table 50100 "ACTIVE FH Trazab.Lote"
{
    Caption = 'ACTIVE FH Trazab.Lote';
    DataClassification = ToBeClassified;

    fields
    {

        field(1; "No. Lote"; Code[20])
        {
            Caption = 'No. Lote';
            TableRelation = "Lot No. Information"."Lot No.";
        }
        field(2; "Certificado No."; Text[20])
        {
            Caption = 'Certificado No.';
        }
        field(3; "Raza"; Enum "Active FH RazaLote")
        {
            Caption = 'Raza';
        }
        field(4; "Alimentacion"; Enum "Active FH AlimentacionLote")
        {
            Caption = 'Alimentacion';
        }
        field(5; "Fecha Sacrificio"; Date)
        {
            Caption = 'Fecha Sacrificio';
        }
        field(6; "Lote Sacrificio"; Text[20])
        {
            Caption = 'Lote Sacrificio';
        }
        field(7; "Fecha Elaboracion"; Date)
        {
            Caption = 'Fecha Elaboracion';
        }
        field(8; "Mapa"; Text[50])
        {
            Caption = 'Mapa';
        }
        field(9; "Item No."; code[20])
        {
            Caption = 'Item No.';
            TableRelation = Item."No.";
            trigger OnValidate()
            var
                ItemRec: Record Item;
            begin
                ItemRec.SetLoadFields("No.", Description);

                if (ItemRec.Get(rec."Item No.")) then begin
                    //rec.Descripcion := ItemRec.Description;    //ya lo hacemos en el Validate de abajo
                    rec.Validate(Descripcion, ItemRec.Description);
                end;
            end;
        }
        field(10; "Descripcion"; Text[150])
        {
            Caption = 'Descripcion';
            //TableRelation = Item.Description WHERE("Description" = field("Descripcion"));
        }
        /*field(3; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            TableRelation = "Sales Header"."No." WHERE("Document Type" = FIELD("Document Type"));
        }*/
    }
    keys
    {
        key(PK; "No. Lote", "Item No.")
        {
            Clustered = true;
        }
    }

}
