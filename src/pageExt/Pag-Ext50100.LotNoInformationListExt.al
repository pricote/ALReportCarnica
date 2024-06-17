pageextension 50100 "Lot No. Information Card Ext" extends "Lot No. Information Card"
{
    layout
    {
        modify(SubformDIB)
        {
            Visible = visibilidadDIB;
        }
        addlast(content)
        {
            part(TrazabPart; "Active FH Trazab.Lote CardPart")
            {
                Caption = 'Trazabilidad Lote';
                Editable = false;
                ShowFilter = false;
                SubPageLink = "Certificado No." = FIELD("Lot No.");
                ApplicationArea = All;
                Visible = visibilidadLote;
            }
        }
    }
    trigger OnOpenPage()
    var
        ACTIVEFHInfoNoDIB: Record "ACTIVE FH Info. No. DIB";


    begin
        visibilidadDIB := CanBeShowedDIB();
        visibilidadLote := CanBeShowedLote();
        /*LotRec.SetLoadFields("Control Trazabilidad Lote");
        //LotRec.Get(LotRec."Control Trazabilidad Lote")
        if (LotRec.Get(LotRec."Control Trazabilidad Lote") = True) then begin
            visibilidad := True;
        end
        else begin
            visibilidad := false;
        end;*/
    end;

    trigger OnAfterGetCurrRecord()
    begin

    end;

    local procedure CanBeShowedLote(): Boolean
    var
        ACTIVEFHConfigCarnicas: Record "ACTIVE FH Config Carnicas";
    begin
        if not ACTIVEFHConfigCarnicas.Get() then
            Error('no existe empresa');
        if ACTIVEFHConfigCarnicas."Control Trazabilidad Lote" then
            exit(true);

    end;

    local procedure CanBeShowedDIB(): Boolean
    var
        ACTIVEFHConfigCarnicas: Record "ACTIVE FH Config Carnicas";
    begin
        if not ACTIVEFHConfigCarnicas.Get() then
            Error('no existe empresa');
        if ACTIVEFHConfigCarnicas."Control Trazabilidad Lote" then
            exit(true);

    end;


    var
        visibilidadLote: Boolean;
        visibilidadDIB: Boolean;
    /* if not LotRec.Get() then
        Error no existe empresa
trigger OnOpenPage()
    begin
        CurrPage.
    
    end;

    trigger OnAfterGetCurrRecord()
    begin
       
    end;

    

    var
        visibilidadDIB: Boolean;

    if LotRec."Control Trazabilidad Lote" and LotRec."Control DIB" then
    exit true*/
}

