CLASS lhc_zI_customer20 DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS create FOR MODIFY
      IMPORTING entities FOR CREATE Customer.

    METHODS update FOR MODIFY
      IMPORTING entities FOR UPDATE Customer.

    METHODS delete FOR MODIFY
      IMPORTING keys FOR DELETE Customer.

    METHODS read FOR READ
      IMPORTING keys FOR READ Customer RESULT result.

    METHODS lock FOR LOCK
      IMPORTING keys FOR LOCK Customer.

    METHODS rba_Custaddr FOR READ
      IMPORTING keys_rba FOR READ Customer\_Custaddr FULL result_requested RESULT result LINK association_links.

    METHODS cba_Custaddr FOR MODIFY
      IMPORTING entities_cba FOR CREATE Customer\_Custaddr.

ENDCLASS.

CLASS lhc_zI_customer20 IMPLEMENTATION.

  METHOD create.
    DATA: l_cust TYPE zcustomer20.
    LOOP AT entities ASSIGNING FIELD-SYMBOL(<entity>).
      MOVE-CORRESPONDING <entity> TO l_cust.
      DATA(customerno) = zcl_customer3=>get_instance( )->cust_create( EXPORTING i_customer = l_cust ).
      APPEND VALUE #( %cid = <entity>-%cid customerno =  customerno ) TO mapped-customer.
    ENDLOOP.
ENDMETHOD.

METHOD update.
ENDMETHOD.

METHOD delete.
ENDMETHOD.

METHOD read.
ENDMETHOD.

METHOD lock.
ENDMETHOD.

METHOD rba_Custaddr.
ENDMETHOD.

METHOD cba_Custaddr.
    DATA: l_custaddr TYPE zcustaddr20.
    LOOP AT entities_cba ASSIGNING FIELD-SYMBOL(<entity>).
      LOOP AT <entity>-%target ASSIGNING FIELD-SYMBOL(<target>).
        MOVE-CORRESPONDING <target> TO l_custaddr.
        data(lv_addressid) = zcl_customer3=>get_instance( )->custaddr_create( EXPORTING is_custaddr = l_custaddr
                                                            iv_customerno = <entity>-customerno ).
        INSERT VALUE #( %cid = <target>-%cid customerno = <entity>-customerno addressid = lv_addressid )
        INTO TABLE mapped-custaddr.
      ENDLOOP.
    ENDLOOP.
ENDMETHOD.

ENDCLASS.

CLASS lhc_ZI_Custaddr20 DEFINITION INHERITING FROM cl_abap_behavior_handler.
PRIVATE SECTION.

  METHODS update FOR MODIFY
    IMPORTING entities FOR UPDATE CustAddr.

  METHODS delete FOR MODIFY
    IMPORTING keys FOR DELETE CustAddr.

  METHODS read FOR READ
    IMPORTING keys FOR READ CustAddr RESULT result.

  METHODS rba_Customer FOR READ
    IMPORTING keys_rba FOR READ CustAddr\_Customer FULL result_requested RESULT result LINK association_links.

ENDCLASS.

CLASS lhc_ZI_Custaddr20 IMPLEMENTATION.

METHOD update.
ENDMETHOD.

METHOD delete.
ENDMETHOD.

METHOD read.
ENDMETHOD.

METHOD rba_Customer.
ENDMETHOD.

ENDCLASS.

CLASS lsc_ZI_CUSTOMER20 DEFINITION INHERITING FROM cl_abap_behavior_saver.
PROTECTED SECTION.

  METHODS finalize REDEFINITION.

  METHODS check_before_save REDEFINITION.

  METHODS save REDEFINITION.

  METHODS cleanup REDEFINITION.

  METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_ZI_CUSTOMER20 IMPLEMENTATION.

METHOD finalize.
ENDMETHOD.

METHOD check_before_save.
ENDMETHOD.

METHOD save.
    zcl_customer3=>get_instance( )->save( ).

ENDMETHOD.

METHOD cleanup.
ENDMETHOD.

METHOD cleanup_finalize.
ENDMETHOD.

ENDCLASS.
