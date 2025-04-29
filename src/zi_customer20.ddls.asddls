//@AbapCatalog.sqlViewName: ''
//@AbapCatalog.compiler.compareFilter: true
//@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Customer data'
//@Metadata.ignorePropagatedAnnotations: true
define root view entity zI_customer20 as select from zcustomer20
composition [0..*] of ZI_Custaddr20 as _CustAddr
{
    key customerno as Customerno,
    firstname as Firstname,
    lastname as Lastname,
    phone as Phone,
    @Semantics.user.createdBy: true
    createdbyuser as Createdbyuser,
    @Semantics.systemDateTime.createdAt: true
    creationat as Creationat,
     @Semantics.user.lastChangedBy: true
    lastchangedbyuser as Lastchangedbyuser,
     @Semantics.systemDateTime.lastChangedAt: true
    lastchangedat as Lastchangedat,
    _CustAddr
}
