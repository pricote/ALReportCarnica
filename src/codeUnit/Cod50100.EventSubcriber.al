codeunit 50100 "Event Subcriber"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::ReportManagement, 'OnAfterSubstituteReport', '', false, false)]
    local procedure ReportManagement_OnAfterSubstituteReport(ReportId: Integer; RunMode: Option; RequestPageXml: Text; RecordRef: RecordRef; var NewReportId: Integer)
    begin
        if ReportId = Report::"Sales - Shipment" then
            NewReportId := Report::"ACTIVEBCCompleteShipment";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::ReportManagement, 'OnAfterSubstituteReport', '', false, false)]
    local procedure OnAfterSubstituteReport(ReportId: Integer; RunMode: Option; RequestPageXml: Text; RecordRef: RecordRef; var NewReportId: Integer);
    begin
        if ReportId = Report::"Standard Sales - Invoice" then
            NewReportId := Report::ACTIVEFHReplaceSalesInvoice;
    end;
}

