* Encoding: UTF-8.

DATASET ACTIVATE DataSet1.
SORT CASES  BY nOnderwijs.
SPLIT FILE SEPARATE BY nOnderwijs.



CORRELATIONS
  /VARIABLES=DL.jan.2017.feb.2017 DL.juni.2017 DLE.AVI.jan.feb.2017 DMT.ruwe.score.jan.2017 
    DMT.vaardigheidsscore.jan.2017 EMT.ruwe.score.juni.2017 EMT.standaardscore.juni.2017 
    DLE.EMT.juni.2017 Klepel.ruwe.score.juni.2017 Klepel.standaardscore.juni.2017 with rt.GEM rt.SD rt.MED 
    rt.MAD
  /PRINT=TWOTAIL NOSIG
  /MISSING=PAIRWISE.
NONPAR CORR
  /VARIABLES=DL.jan.2017.feb.2017 DL.juni.2017 DLE.AVI.jan.feb.2017 DMT.ruwe.score.jan.2017 
    DMT.vaardigheidsscore.jan.2017 EMT.ruwe.score.juni.2017 EMT.standaardscore.juni.2017 
    DLE.EMT.juni.2017 Klepel.ruwe.score.juni.2017 Klepel.standaardscore.juni.2017 with rt.GEM rt.SD rt.MED 
    rt.MAD
  /PRINT=SPEARMAN TWOTAIL NOSIG
  /MISSING=PAIRWISE.




SPLIT FILE OFF.

CORRELATIONS
  /VARIABLES=DL.jan.2017.feb.2017 DL.juni.2017 DLE.AVI.jan.feb.2017 DMT.ruwe.score.jan.2017 
    DMT.vaardigheidsscore.jan.2017 EMT.ruwe.score.juni.2017 EMT.standaardscore.juni.2017 
    DLE.EMT.juni.2017 Klepel.ruwe.score.juni.2017 Klepel.standaardscore.juni.2017 with rt.GEM rt.SD rt.MED 
    rt.MAD
  /PRINT=TWOTAIL NOSIG
  /MISSING=PAIRWISE.
NONPAR CORR
  /VARIABLES=DL.jan.2017.feb.2017 DL.juni.2017 DLE.AVI.jan.feb.2017 DMT.ruwe.score.jan.2017 
    DMT.vaardigheidsscore.jan.2017 EMT.ruwe.score.juni.2017 EMT.standaardscore.juni.2017 
    DLE.EMT.juni.2017 Klepel.ruwe.score.juni.2017 Klepel.standaardscore.juni.2017 with rt.GEM rt.SD rt.MED 
    rt.MAD
  /PRINT=SPEARMAN TWOTAIL NOSIG
  /MISSING=PAIRWISE.

SORT CASES BY nOnderwijs nblockcode .
CASESTOVARS
  /ID=nOnderwijs nblockcode
  /GROUPBY=VARIABLE
  /VIND ROOT=ind.
