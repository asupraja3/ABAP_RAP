@AbapCatalog.viewEnhancementCategory: [ #NONE ]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Customer Address Data'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
serviceQuality: #X,
sizeCategory: #S,
dataClass: #MIXED }
define view entity ZI_Custaddr20
  as select from zcustaddr20
  association to parent zI_customer20 as _Customer on
  $projection.Customerno = _Customer.Customerno
  
{
  key customerno         as Customerno,
  key addressid          as Addressid,
      city               as City,
      district           as District,
      postalcode         as Postalcode,
      country            as Country,
      street             as Street,
      @Semantics.user.createdBy: true
      createdbyuser      as Createdbyuser,
      @Semantics.systemDateTime.createdAt: true
      creationat         as Creationat,
      @Semantics.user.lastChangedBy: true
      lastchangedbyuser  as Lastchangedbyuser,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      locallastchangedat as Locallastchangedat,
      _Customer
}
