@AbapCatalog.sqlViewName: 'ZTO_EGT_CDS'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Eğitim cds'
define view zto_egt_ddl as select from zto_6197_cds_odev2
{vbeln,
sum(Conversion_Netwr) as toplam_net_deger,
kunnrAd,
count(*) as toplam_fatura_adedi,
division(cast(sum(Conversion_Netwr) as abap.curr( 10, 2 )), cast(count(*) as abap.int4), 2) as ortalama_miktar,
substring(fkdat, 1, 4) as faturalama_yili,
substring(fkdat, 5, 2) as faturalama_ayi,
substring(fkdat, 7, 2) as faturalama_gunu,
substring(inco2, 1, 3) as incoterm_yeri
}group by vbeln,kunnrAd,Conversion_Netwr,fkdat,inco2

