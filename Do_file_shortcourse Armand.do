
import excel "C:\Users\arman\Downloads\Base_EnfantZD.xlsx", sheet("Base_EnfantZD") firstrow allstring

describe

*TRANSFORMATION VARIABLES

*transformer variables distance_ha "string" en "numeric"
encode distance_ha, generate(distance_ha_num)

*transformer variables age_m "string" en "numeric"
encode age_m, generate(age_m_num)

*TEST KHI2

* Test du Khi² entre reco_visit et distance_1km
tabulate reco_visit distance_1km, chi2

* Test du Khi² entre zd_enfant et urbain_rural
tabulate zd_enfant urbain_rural, chi2

* Test du Khi² entre etude_m et zd_enfant
tabulate etude_m zd_enfant, chi2

* Test du Khi² entre migrant_status et zd_enfant
tabulate migrant_status zd_enfant, chi2

*DIFFERENCE DES PROPORTIONS

*Différence de proportions entre CPN et Nutrition de l’enfant
prtest nutrition_enfant, by(cpn)

*Différence de proportions entre Reco_visit et Distance_1km
prtest distance_1km, by(reco_visit)

*Différence de proportions entre Migrant_status et Zd_enfant
prtest zd_enfant, by(migrant_status)

*Différence de proportions entre Zd_enfant et ZS (Zone de Santé)
prtest zd_enfant if ZS == "KIKWIT Nord" | ZS == "KIKWIT Sud", by(ZS)


*REGRESSION LOGISTIQUE

tabulate zd_enfant  // Check current coding


* Convert string variables into factor variables
encode ZS, generate(ZS_num)
encode urbain_rural, generate(urbain_rural_num)
encode migrant_status, generate(migrant_status_num)
encode reco_visit, generate(reco_visit_num)
encode etude_m, generate(etude_m_num)
encode etude_m2, generate(etude_m2_num)
encode cpn, generate(cpn_num)
encode tetanos_2, generate(tetanos_2_num)
encode kce_mev, generate(kce_mev_num)
encode sexe_enfant, generate(sexe_enfant_num)
encode nutrition_enfant, generate(nutrition_enfant_num)
encode Measles_unvacc, generate(rougeole_unvacc_num)
encode zd_enfant, generate(zd_enfant_num)
encode card_vacc, generate(card_vacc_num)
encode cpn, generate(cpn_num)

list ZS ZS_num if _n <= 10  // Check the first 10 observations
tabulate ZS_num  // See the numeric categories


* Régression logistique binaire avec zd_enfant comme variable dépendante
logistic zd_enfant i.urbain_rural_num i.migrant_status_num i.reco_visit_num age_m distance_ha_num i.card_vacc_num i.cpn_num

* Pour visualiser les odds ratios
logit, or
