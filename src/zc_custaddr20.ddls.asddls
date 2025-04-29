@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Customer Projection'
@Metadata.allowExtensions: true
define view entity zC_custaddr20
  as projection on ZI_Custaddr20 as CustAddr
  //composition [0..*] of ZI_Custaddr20 as _CustAddr
{
  key Customerno,
  key Addressid,
      City,
      District,
      Postalcode,
      Country,
      Street,
       @Semantics.user.createdBy: true
      Createdbyuser,
      @Semantics.systemDateTime.createdAt: true
      Creationat,
       @Semantics.user.lastChangedBy: true
      Lastchangedbyuser,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      Locallastchangedat,
      _Customer: redirected to parent zC_customer20
}
