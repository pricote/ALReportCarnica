tableextension 50100 "ACTIVE FH Config Carnicas Ext" extends "ACTIVE FH Config Carnicas"
{
    fields
    {
        field(50100; "Control DIB"; Boolean)
        {
            Caption = 'Control DIB';
            DataClassification = ToBeClassified;
        }
        field(50101; "Control Trazabilidad Lote"; Boolean)
        {
            Caption = 'Control Trazabilidad Lote';
            DataClassification = ToBeClassified;
        }
    }
}
