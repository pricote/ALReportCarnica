/// <summary>
/// Report ACTIVEBCListOpenOrders (ID 50103).
/// </summary>
report 50103 "ACTIVEBCListOpenOrders"
{
    ApplicationArea = All;
    Caption = 'ACTIVEBCListOpenOrders';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;//le decimos coo lo queremos y donde queremos que lo guarde
    RDLCLayout = 'Layouts/ListOpenOrders.rdl';
    //ProcessingOnly = True;
    dataset
    {
        dataitem(DataItemName; "Sales Header")
        {
            //RequestFilterFields = "Document Date";
            //DataItemTableView = WHERE("Completely Shipped" = CONST(false));
            column(DocumentDate; "Document Date")
            {
            }

            column(SelltoCustomerName; "Sell-to Customer Name")
            {
            }
            column(SelltoCustomerNo; "Sell-to Customer No.")
            {
            }
            column(DocumentNo; "No.")
            {
            }
            column(CompanyPic; CompanyInfo.Picture)
            {
            }
            column(Completely_Shipped; "Completely Shipped")
            {
            }

            dataitem(DataItemName2; "Sales Line")
            {
                DataItemLink = "Document No." = field("No.");
                //DataItemTableView = WHERE("Completely Shipped" = CONST(false));
                column(CantidadFaltante; "Outstanding Quantity")
                {
                }
                column(Articulo; "No.")
                {
                }
                column(BarCode; EncodeText)
                {
                }
                column(Descripcion; Description)
                {
                }
                column(CatidadKilos; "ACTIVE FH Cantidad Kilos")
                {
                }
                column(CatidadUnidades; "ACTIVE FH Cantidad Unidades")
                {
                }
                trigger OnAfterGetRecord();
                var
                    BarcodeString: Text;
                    BarcodeSymbology: Enum "Barcode Symbology";
                    BarcodeFontProvider: Interface "Barcode Font Provider";
                begin
                    BarcodeFontProvider := Enum::"Barcode Font Provider"::IDAutomation1D;
                    BarcodeSymbology := Enum::"Barcode Symbology"::Code39;
                    BarcodeString := "Document No.";
                    BarcodeFontProvider.ValidateInput(BarcodeString, BarcodeSymbology);
                    EncodeText := BarcodeFontProvider.EncodeFont(Format(BarcodeString), BarcodeSymbology);
                end;


            }
            trigger OnPreDataItem()
            begin
                if triggerError() then begin
                    if ((Format(StartDate) <> '') and (Format(FinalDate) <> '')) then begin
                        DataItemName.SetRange("Document Date", StartDate, FinalDate);
                    end;
                    if ((Format(StartDate) = '') and (Format(FinalDate) = '')) then begin
                        DataItemName.SetRange("Document Date", Today);
                    end;
                    if ((Format(StartDate) <> '') and (Format(FinalDate) = '')) then begin
                        FinalDate := Today;
                        DataItemName.SetRange("Document Date", StartDate, Today);
                    end;
                    if ((Format(StartDate) = '') and (Format(FinalDate) <> '')) then begin
                        //TODO: Cambiar las fechas
                        DataItemName.SetRange("Document Date", DMY2Date(15, 11, 2023), FinalDate);
                    end;
                end
                else
                    Message('Campos de la fecha invalidos');
            end;

        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
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
        actions
        {
            area(processing)
            {
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
        EncodeText: Text;
        StartDate: Date;
        FinalDate: Date;
    /*var
        Fecha: Date;
        NumComprador: Text;
        NombreComprador: Text;
        NumPedido: Text;
        listo: Boolean;

    /*local procedure ComprobarBucleRecord(NumPedido: Text; doc: Text): Boolean
    var
        listoLocal: Boolean;
    begin
        listoLocal := false;
        if NumPedido = doc then begin
            listoLocal := true;
            EXIT(listoLocal);
        end;
        EXIT(listoLocal);
    end;*/
    [TryFunction]
    local procedure triggerError()
    begin
        Error('Campos de la fecha invalidos');
    end;

}
