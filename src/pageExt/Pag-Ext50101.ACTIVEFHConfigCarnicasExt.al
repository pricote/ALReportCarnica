pageextension 50101 "ACTIVE FH Config Carnicas Ext" extends "ACTIVE FH Config Carnicas"
{
    layout
    {
        addbefore("Permitir registro recepciones desde terminal")
        {
            field("Control DIB"; Rec."Control DIB")
            {
                ToolTip = 'Specifies the value of the Nº DIB field.';
                ApplicationArea = all;
            }
            field("Control Trazabilidad Lote"; Rec."Control Trazabilidad Lote")
            {
                ToolTip = 'Specifies the value of the Nº DIB field.';
                ApplicationArea = all;
            }
        }
    }
}
