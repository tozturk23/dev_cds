@AbapCatalog.sqlViewName: 'ZBT_CDS_EGT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS Eğitim DDL'
    define view ZBT_DDL_EGT
    as select from ekko as t1
    inner join ekpo as t2 on t2.ebeln = t1.ebeln
    inner join mara as t3 on t3.matnr = t2.matnr
    inner join makt as t4 on t4.matnr = t3.matnr
                             and t4.spras = $session.system_language
    inner join lfa1 as t5 on t5.lifnr = t1.lifnr
{
   t2.ebeln,
   t2.ebelp,
   t2.matnr,
   t4.maktx,
   t2.werks,
   t2.lgort,
   t2.meins,
   t5.lifnr,
   t5.land1,
   concat_with_space(t5.stras,t5.mcod3,3) as Satici_Adresi
 }
