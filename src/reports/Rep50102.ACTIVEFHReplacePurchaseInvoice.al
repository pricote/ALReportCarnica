report 50102 ACTIVEFHReplacePurchaseInvoice
{
    ApplicationArea = All;
    Caption = 'ReplacePurchaseInvoice';
    UsageCategory = Administration;
    DefaultLayout = RDLC;//le decimos coo lo queremos y donde queremos que lo guarde
    RDLCLayout = 'Layouts/ReplacePurchaseInvoice.rdl';
    dataset
    {
        dataitem(PurchInvHeader; "Purch. Inv. Header")
        {
            column(InvoiceAmountWithOutVat; Amount)
            {
            }
            column(AmountIncludingVAT; "Amount Including VAT")
            {
            }
            column(DocumentDate; "Document Date")
            {
            }
            column(No; "No.")
            {
            }
            column(OrderDate; "Order Date")
            {
            }
            column(PaytoAddress; "Pay-to Address")
            {
            }
            column(PaytoName; "Pay-to Name")
            {
            }
            column(PaytoContact; "Pay-to Contact")
            {
            }
            column(PaytoContactNo; "Pay-to Contact No.")
            {
            }
            column(PaytoCountryRegionCode; "Pay-to Country/Region Code")
            {
            }
            column(PaymentDiscount; "Payment Discount %")
            {
            }
            column(PayToPostCode; "Pay-to Post Code")
            {
            }

            dataitem(DataItem3; "Purch. Inv. Line")
            {
                DataItemLink = "Document No." = field("No.");
                column(ItemNo_Line; "No.")
                {
                }
                column(ItemDescription; Description)
                {
                }
                column(Fecha; Fecha1)
                {
                }
                column(UnitPrice; PrecioUnidad)
                {
                }
                column(AmountInclVAT; AmountInclVAT)
                {
                }
                column(Quantity; Cantidad)
                {
                }
                column(VATPorCiento; IVAPC)
                {
                }
                column(TotalLineAmount; Amount)
                {
                }
                column(LineAmount; LineAmount)
                {
                }
                column(TotalAmountInclVAT; "Amount Including VAT")
                {
                }
                column(VAT; TotalVATAmount)
                {
                }
                column(Decuento; Descuento)
                {
                }
                column(Kilos; "ACTIVE FH Cantidad Kilos")
                {
                }
                column(Piezas; "Qty. per Unit of Measure")
                {
                }
                dataitem(DataItemName; "Item Ledger Entry")
                {
                    DataItemLink = "Document No." = field("Document No."), "Document Line No." = field("Line No.");
                    column(Lote; "Lot No.")
                    {
                    }
                    /*column(GrupoLotes; GrupoLotes)
                    {
                    }*/

                }
                trigger OnAfterGetRecord();
                var
                    conIVA: Boolean;
                begin
                    //Fecha1 := CopyStr(Format("Shipment Date"), 1, 10);
                    Cantidad := Format("Quantity") + ' Unids.';
                    //PrecioUnidad := Format("Unit Price");
                    Descuento := Format("Line Discount %");
                    LineAmount := Format(Amount);
                    IVAPC := Format("VAT %");
                    AmountInclVAT := Format("Amount Including VAT");
                    CalcSums(Amount, "Amount Including VAT", "Inv. Discount Amount");
                    TotalVATAmount := Format("Amount Including VAT" - Amount);
                    if "VAT %" = 0 then
                        TotalVATAmount := '0';
                end;
            }
        }
    }
    trigger OnPreReport()
    begin

        //Customerito.SetLoadFields(Balance);
        //Customerito.Get();
        // Customerito.CalcFields(Balance);
        //SalesLines.SetAutoCalcFields(Amount, "Amount Including VAT");
        //CompanyInfo.SetLoadFields(Picture);
        CompanyInfo.Get();//cogemos todo lo que haya en companyinfo 
        CompanyInfo.CalcFields(Picture);//y sacamos el logo que es lo que queremos usar
        //Fecha1 := Date2DMY(NormalDate(SalesHeader."Document Date"), 1);
        //Message(Format(Fecha1));
    end;

    var
        CompanyInfo: Record "Company Information";
        IVA: Text;
        TotalVATAmount: Text;
        AmountInclVAT: Text;
        LineAmount: Text;
        ReplaceInvoice_Title: Label 'Report Replace Invoice';
        CIFText: Label 'CIF/NIF';
        NºTelefonoText: Label 'NºTelefono';
        Fecha1: Text;
        Cantidad: Text;
        PrecioUnidad: Text;
        Descuento: Text;
        IVAPC: Text;
        VencimientoLabel: Label 'Vencimiento';
        VtoLabel: Label 'Vto. A LA VISTA';
        AvisoLabel: Label 'No se permitirán devoluciones trancurriddos 10 días de la recepcón del género por el cliente';
}

