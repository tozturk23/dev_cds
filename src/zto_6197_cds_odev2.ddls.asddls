@AbapCatalog.sqlViewName: 'ZTO_CDS_ODEV'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Odev2'
define view zto_6197_cds_odev2 as select from vbrp
    inner join      vbrk on vbrp.vbeln = vbrk.vbeln
    inner join      mara on mara.matnr = vbrp.matnr
    left outer join makt on  makt.matnr = mara.matnr
                         and makt.spras = $session.system_language
    left outer join vbak on vbak.vbeln = vbrp.aubel
    left outer join kna1 on kna1.kunnr = vbak.kunnr

{
  key vbrp.vbeln                                  ,           
  key vbrp.posnr                                  ,           
      vbrp.aubel                                  ,           
      vbrp.aupos                                  ,           
      vbak.kunnr                                  ,          
      concat_with_space(kna1.name1, kna1.name2, 1) as kunnrAd,           

      @Semantics.currencyCode: true
        vbrp.waerk,
        vbrp.netwr,
      currency_conversion( amount => vbrp.netwr,
                           source_currency => vbrp.waerk,
                           target_currency => cast('EUR' as abap.cuky(5)),
                           exchange_rate_date=>vbrk.fkdat,
                           error_handling => 'SET_TO_NULL' ) as Conversion_Netwr,

      left(vbak.kunnr, 3)                                    as Left_Kunnr,
      length( mara.matnr )                                   as Matnr_Length,

      case  when vbrk.fkart = 'FAS' then 'Peşinat Talebi İptali'
            when vbrk.fkart = 'FAZ' then 'Peşinat Talebi'
            else 'Fatura' end                                as Faturalama_Turu,

      vbrk.fkdat,
      vbrk.inco2

}
