@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Customer Projection'
@Search.searchable: true
@Metadata.allowExtensions: true
define root view entity zC_customer20 as projection on zI_customer20 as Customer
//composition [0..*] of ZI_Custaddr20 as _CustAddr
{
    key Customerno ,
    @Search.defaultSearchElement: true
    Firstname ,
    @Search.defaultSearchElement: true
    Lastname ,
    Phone ,
     @Semantics.user.createdBy: true
    Createdbyuser ,
    @Semantics.systemDateTime.createdAt: true
    Creationat,
    @Semantics.user.lastChangedBy: true
    Lastchangedbyuser ,
     @Semantics.systemDateTime.lastChangedAt: true
    Lastchangedat ,
    _CustAddr: redirected to composition child zC_custaddr20
}
