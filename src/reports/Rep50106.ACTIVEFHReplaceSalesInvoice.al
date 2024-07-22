report 50106 ACTIVEFHReplaceSalesInvoice
{
    ApplicationArea = All;
    Caption = 'Factura de venta';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;//le decimos coo lo queremos y donde queremos que lo guarde
    RDLCLayout = 'Layouts/ReplaceSalesInvoice.rdl';
    //ProcessingOnly = True;
    dataset
    {

        dataitem(DataItem2; "Sales Invoice Header")
        {

            RequestFilterFields = "No.";
            column(DocumentDate; "Document Date")
            {
            }
            column(No; "No.")
            {
            }
            column(FechaPublicacion; "Posting Date")
            {
            }
            column(CustomerNum; "Sell-to Customer No.")
            {
            }
            column(CustomerContact; "Sell-to Contact")
            {
            }
            column(CustomerName; "Sell-to Customer Name")
            {
            }
            column(CustomerAddress; "Sell-to Address")
            {
            }
            column(CustomerCity; "Sell-to City")
            {
            }
            column(CustomerPostCode; "Sell-to Post Code")
            {
            }
            column(CustomerBankAcc; "Cust. Bank Acc. Code")
            {
            }
            column(SalesPersonCode; "Salesperson Code")
            {
            }
            column(TipoPago; Format("Payment Method Code"))
            {
            }
            column(BackAcc; "VAT Registration No.")
            {
            }
            dataitem(DataItem3; "Sales Invoice Line")
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
                    column(GrupoLotes; GrupoLotes)
                    {
                    }
                }
                trigger OnAfterGetRecord();
                var
                    conIVA: Boolean;
                    itemLedgerEntryTemp: Record "Item Ledger Entry";
                begin
                    Fecha1 := CopyStr(Format("Shipment Date"), 1, 10);
                    Cantidad := Format("Quantity") + ' Unids.';
                    PrecioUnidad := Format("Unit Price");
                    Descuento := Format("Line Discount %");
                    LineAmount := Format(Amount);
                    IVAPC := Format("VAT %");
                    //Bruto:=Amount - TotalVATAmount;
                    AmountInclVAT := Format("Amount Including VAT");
                    CalcSums(Amount, "Amount Including VAT", "Inv. Discount Amount");
                    TotalVATAmount := Format("Amount Including VAT" - Amount);
                    if "VAT %" = 0 then
                        TotalVATAmount := '0';
                    /*itemLedgerEntryTemp.SetCurrentKey("Document No.", "Document Line No.");
                    itemLedgerEntryTemp.SetRange("Document No.", DataItem2."No.");
                    itemLedgerEntryTemp.SetRange("Document Line No.", DataItem3."Line No.");
                    if itemLedgerEntryTemp.FindSet() then begin
                        repeat
                            GrupoLotes := GrupoLotes + Format(itemLedgerEntryTemp."Lot No.");
                        until itemLedgerEntryTemp.Next() = 0;
                    end;
                    GrupoLotes := '';*/
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
        GrupoLotes: Text;
}
