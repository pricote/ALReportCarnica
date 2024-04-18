report 50101 ACTIVEBCCompleteShipment
{
    ApplicationArea = All;
    Caption = 'ACTIVEBCCompleteAlb';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;//le decimos coo lo queremos y donde queremos que lo guarde
    RDLCLayout = 'Layouts/CompleteShipment.rdl';
    //ProcessingOnly = True;
    dataset
    {

        dataitem(SSH; "Sales Shipment Header")
        {

            RequestFilterFields = "No.";
            column(DocumentDate; "Document Date")
            {
            }
            column(No; "No.")
            {
            }
            column(CustNum; "Sell-to Customer No.")
            {
            }
            column(ShipDate; "Shipment Date")
            {
            }
            column(FechaPublicacion; "Posting Date")
            {
            }
            column(SalesPerson; "Salesperson Code")
            {
            }
            dataitem(Customer; Customer)
            {
                DataItemLink = "No." = field("Sell-to Customer No.");
                column(numCli; "No.")
                {
                }
                column(DirCli; "Address")
                {
                }
                column(nameCli; Name)
                {
                }
                column(CityCli; "City")
                {
                }
                column(Pais; "Country/Region Code")
                {
                }
                column(Contacto; Contact)
                {
                }

            }
            dataitem(SSL; "Sales Shipment Line")
            {
                DataItemLink = "Document No." = field("No.");
                column(ItemNo_Line; "No.")
                {
                }
                column(DocNum; "Document No.")
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
                column(Quantity; Quantity)
                {
                }
                column(VATPorCiento; IVAPC)
                {
                }
                column(LineAmount; LineAmount)
                {
                }
                column(UnidadesTotal; "ACTIVE FH Cantidad Unidades")
                {
                }
                column(Decuento; Descuento)
                {
                }
                dataitem(ILE; "Item Ledger Entry")
                {
                    DataItemLink = "Document No." = field("Document No.");
                    //RequestFilterFields = "Item No.";
                    column(Document_No_Lote; "Document No.")
                    {

                    }
                    column(No_Lote; "Lot No.")
                    {

                    }
                    column(CantidaLote; "Quantity")
                    {

                    }
                    column(CantidaLoteUnidades; "ACTIVE FH Cantidad Unidades")
                    {

                    }

                }

                /*trigger OnAfterGetRecord();
                var
                    conIVA: Boolean;
                begin
                    Fecha1 := CopyStr(Format("Shipment Date"), 1, 10);
                    Cantidad := Format("Quantity") + ' Kg';
                    PrecioUnidad := Format("Unit Price");
                    Descuento := Format("Line Discount %");
                    IVAPC := Format("VAT %");
                    if "VAT %" = 0 then
                        TotalVATAmount := '0';
                end;*/
            }

        }
        /*dataitem(Customer; Customer)
        {

            column(numCli; "No.")
            {
            }
            column(DirCli; "Address")
            {

            }

        }*/
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
}
