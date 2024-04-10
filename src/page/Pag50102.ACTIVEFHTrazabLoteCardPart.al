page 50102 "ACTIVE FH Trazab.Lote CardPart"
{
    ApplicationArea = All;
    Caption = 'ACTIVE FH Trazab.Lote CardPart';
    PageType = CardPart;
    SourceTable = "ACTIVE FH Trazab.Lote";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No. Lote"; Rec."No. Lote")
                {
                    ToolTip = 'Specifies the value of the Nº Lote field.';
                    ApplicationArea = all;
                }
                field("Certificado No."; Rec."Certificado No.")
                {
                    ToolTip = 'Specifies the value of the Nº Trazab field.';
                }
                field("Raza"; Rec."Raza")
                {
                    ToolTip = 'Specifies the value of the Race field.';
                }
                field("Alimentacion"; Rec."Alimentacion")
                {
                    ToolTip = 'Specifies the value of the Alimentation field.';
                }
                field("Fecha Sacrificio"; Rec."Fecha Sacrificio")
                {
                    ToolTip = 'Specifies the value of the Date of Sacrifice field.';
                }
                field("Lote Sacrificio"; Rec."Lote Sacrificio")
                {
                    ToolTip = 'Specifies the value of the Lote of Sacrifice field.';
                }
                field("Fecha Elaboracion"; Rec."Fecha Elaboracion")
                {
                    ToolTip = 'Specifies the value of the Date of Elaboration field.';
                }
                field("Mapa"; Rec.Mapa)
                {
                    ToolTip = 'Specifies the value of the Map field.';
                }
                field("Item No."; Rec."Item No.")
                {
                    ToolTip = 'Specifies the value of the Nº Product field.';
                }
                field("Descripcion"; Rec.Descripcion)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
            }
        }
    }
}
