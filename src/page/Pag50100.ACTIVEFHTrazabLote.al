page 50100 "Active FH Trazab.Lote"
{
    ApplicationArea = All;
    Caption = 'Active FH Trazab.Lote';
    CardPageID = "Active FH Trazab.Lote Card";
    SourceTable = "ACTIVE FH Trazab.Lote";
    PageType = List;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No. Lote"; Rec."No. Lote")
                {
                    ToolTip = 'Specifies the value of the Nº DIB field.';
                }
                field("Certificado No."; Rec."Certificado No.")
                {
                    ToolTip = 'Specifies the value of the Nº DIB field.';
                }
                field("Raza"; Rec.Raza)
                {
                    ToolTip = 'Specifies the value of the Nº DIB field.';
                }
                field("Alimentacion"; Rec."Alimentacion")
                {
                    ToolTip = 'Specifies the value of the Nº DIB field.';
                }
                field("Fecha Sacrificio"; Rec."Fecha Sacrificio")
                {
                    ToolTip = 'Specifies the value of the Nº DIB field.';
                }
                field("Lote Sacrificio"; Rec."Lote Sacrificio")
                {
                    ToolTip = 'Specifies the value of the Nº DIB field.';
                }
                field("Fecha Elaboracion"; Rec."Fecha Elaboracion")
                {
                    ToolTip = 'Specifies the value of the Nº DIB field.';
                }
                field("Mapa"; Rec.Mapa)
                {
                    ToolTip = 'Specifies the value of the Nº DIB field.';
                }
                field("Item No."; Rec."Item No.")
                {
                    ToolTip = 'Specifies the value of the Nº DIB field.';
                }
                field("Descripcion"; Rec.Descripcion)
                {
                    ToolTip = 'Specifies the value of the Nº DIB field.';
                }
            }
        }
    }
}
