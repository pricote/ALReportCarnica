report 50105 ACTIVEFHRepresentativeSummary
{
    ApplicationArea = All;
    Caption = 'Resumen Representante';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'Layouts/ResumenRepresentante.rdl';
    dataset
    {
        dataitem(SalesInvoiceHeader; "Sales Invoice Header")
        {
            column(NoFactura; "No.")
            {
            }
            column(FechaFactura; "Document Date")
            {
            }
            column(SelltoCustomerNo; "Sell-to Customer No.")
            {
            }
            column(Amount; Amount)
            {
            }
            column(AmountIncludingVAT; "Amount Including VAT")
            {
            }
            column(Abonado; abonado)
            {
            }
            column(Cerrado; Closed)
            {
            }
            column(VendorName; salesPersonName)
            {
            }
            column(Comision; SalesPersonComision)
            {
            }
            column(VAT; VAT)
            {
            }
            column(FechIni; StartDate)
            {
            }
            column(FechFin; FinalDate)
            {
            }
            trigger OnAfterGetRecord()
            begin
                SalesPersonComision := (Amount * salesPersonPurchaserTemp."Commission %") / 100;
                VAT := ("Amount Including VAT" - Amount);
                if SalesInvoiceHeader.Closed then begin
                    abonado := 'SI';
                end else begin
                    abonado := 'NO';
                end;
            end;

            /*dataitem("Vendedor"; "Salesperson/Purchaser")
            {
                DataItemLink = Code = FIELD("Salesperson Code");
                column(Comision; "Commission %")
                {
                }
            }*/
            trigger OnPreDataItem()
            begin
                SalesInvoiceHeader.SetRange("Salesperson Code", salesPersonTemp);
                //SalesInvoiceHeader.FindSet();
                salesPersonPurchaserTemp.SetRange(Code, salesPersonTemp);
                salesPersonPurchaserTemp.FindSet();
                salesPersonName := salesPersonPurchaserTemp.Name;
                //if triggerError() then begin
                if ((Format(StartDate) <> '') and (Format(FinalDate) <> '')) then begin
                    SalesInvoiceHeader.SetRange("Document Date", StartDate, FinalDate);
                end;
                if ((Format(StartDate) = '') and (Format(FinalDate) = '')) then begin
                    SalesInvoiceHeader.SetRange("Document Date", Today - 30, Today);
                    StartDate := (Today - 30);
                    FinalDate := Today;
                end;
                if ((Format(StartDate) <> '') and (Format(FinalDate) = '')) then begin
                    FinalDate := Today;
                    SalesInvoiceHeader.SetRange("Document Date", StartDate, Today);
                end;
                if ((Format(StartDate) = '') and (Format(FinalDate) <> '')) then begin
                    //TODO: Cambiar las fechas
                    SalesInvoiceHeader.SetRange("Document Date", DMY2Date(01, 01, 2024), FinalDate);
                    StartDate := DMY2Date(01, 01, 2024);
                end;
                //end
                /*else
                    Message('Campos de la fecha invalidos');*/
                if pagado then begin
                    SalesInvoiceHeader.SetRange(Closed, true);
                end;
                SalesInvoiceHeader.FindSet();
            end;

        }

    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(Filtros)
                {
                    field(Pagado; pagado)
                    {
                        ApplicationArea = All;
                        Caption = 'Mostrar solamente los ya abonados';
                        /*ShowMandatory = false;
                        NotBlank = false;*/
                        //LookupPageId = "Salespersons/Purchasers";
                    }
                }
                group(Comerciales)
                {
                    field(Comercial; salesPersonTemp)
                    {
                        ApplicationArea = All;
                        /*ShowMandatory = false;
                        NotBlank = false;*/
                        Lookup = true;
                        TableRelation = "Salesperson/Purchaser"."Code";
                        //LookupPageId = "Salespersons/Purchasers";
                    }
                }
                group(Fechas)
                {
                    field(StartDate; StartDate)
                    {
                        ApplicationArea = All;
                        ShowMandatory = false;
                        NotBlank = false;
                    }
                    field(FinalDate; FinalDate)
                    {
                        ApplicationArea = All;
                        ShowMandatory = false;
                        NotBlank = false;
                    }
                }
            }
        }
    }
    trigger OnPreReport()
    begin

        CompanyInfo.Get();//cogemos todo lo que haya en companyinfo 
        CompanyInfo.CalcFields(Picture);//y sacamos el logo que es lo que queremos usar
    end;

    var
        CompanyInfo: Record "Company Information";
        salesPersonTemp: Code[20];
        salesPersonPurchaserTemp: Record "Salesperson/Purchaser";
        EncodeText: Text;
        cantidad: Decimal;
        fechaPedido: Date;
        salesPersonName: Text;
        salesPersonComision: Decimal;
        VAT: Decimal;
        StartDate: Date;
        FinalDate: Date;
        pagado: Boolean;
        abonado: Text;

    [TryFunction]
    local procedure triggerError()
    begin
        Error('Campos de la fecha invalidos');
    end;
}
