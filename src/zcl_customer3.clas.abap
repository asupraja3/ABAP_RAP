
CLASS zcl_customer3 DEFINITION
 PUBLIC
 FINAL
 CREATE PUBLIC .
  PUBLIC SECTION.
    DATA mt_customer TYPE TABLE OF zcustomer20 .
    DATA mt_custaddr TYPE TABLE OF zcustaddr20 .

    DATA ms_customer TYPE zcustomer20 .
    CLASS-DATA mo_instance TYPE REF TO zcl_customer3 .
    METHODS cust_create
      IMPORTING
        !i_customer         TYPE zcustomer20
      RETURNING
        VALUE(r_customerno) TYPE kunnr .
    METHODS custaddr_create
      IMPORTING
        !is_custaddr       TYPE zcustaddr20
        !iv_customerno     TYPE kunnr
      RETURNING
        VALUE(r_addressid) TYPE ad_addrnum .
    METHODS save .
    CLASS-METHODS get_instance
      RETURNING
        VALUE(r_instance) TYPE REF TO zcl_customer3 .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.
CLASS zcl_customer3 IMPLEMENTATION.
  METHOD cust_create.
    DATA: ls_customer TYPE zcustomer20.
    MOVE-CORRESPONDING i_customer TO ls_customer.
    ls_customer-createdbyuser = sy-uname.
    GET TIME STAMP FIELD ls_customer-creationat.
    ls_customer-lastchangedbyuser = sy-uname.
    GET TIME STAMP FIELD ls_customer-lastchangedat.
    GET TIME STAMP FIELD ls_customer-locallastchangedat.
    SELECT SINGLE FROM zcustomer20
    FIELDS MAX( customerno ) AS Customerno
    INTO @DATA(max_custno).
    ls_customer-customerno = max_custno + 1.
    APPEND ls_customer TO mt_customer.
    r_customerno = ls_customer-customerno.
  ENDMETHOD.
  METHOD save.
    IF mt_customer IS NOT INITIAL.
      INSERT zcustomer20 FROM TABLE @mt_customer.
    ENDIF.

    IF mt_custaddr IS NOT INITIAL.
      INSERT zcustaddr20 FROM TABLE @mt_custaddr.
    ENDIF.
  ENDMETHOD.
  METHOD get_instance.
    IF mo_instance IS INITIAL.
      CREATE OBJECT mo_instance.
    ENDIF.
    r_instance = mo_instance.
  ENDMETHOD.
  METHOD custaddr_create.
    DATA: ls_custaddr TYPE zcustaddr20.
    MOVE-CORRESPONDING is_custaddr TO ls_custaddr.
    SELECT SINGLE FROM zcustaddr20
    FIELDS MAX( addressid ) AS AddressID
    WHERE customerno = @iv_customerno
    INTO @DATA(max_addrid).
    IF sy-subrc = 0 AND max_addrid IS NOT INITIAL.
      ls_custaddr-addressid = max_addrid + 1.
    ELSE.
      ls_custaddr-addressid = '9000000001'.
    ENDIF.
    ls_custaddr-createdbyuser = sy-uname.
    GET TIME STAMP FIELD ls_custaddr-creationat.
    ls_custaddr-lastchangedbyuser = sy-uname.
    GET TIME STAMP FIELD ls_custaddr-locallastchangedat.
    ls_custaddr-customerno = iv_customerno.
    APPEND ls_custaddr TO mt_custaddr.
    r_addressid = ls_custaddr-addressid.
  ENDMETHOD.

ENDCLASS.

