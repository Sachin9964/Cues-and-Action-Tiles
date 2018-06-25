table 50101 SalesInvoiceCueTable
{
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1;PrimaryKey; Code[250])
        {
            
            DataClassification = ToBeClassified;
        }
        field(2; SalesInvoicesOpen ; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Sales Header" where("Document Type"=Filter(Invoice), Status=FILTER(Open)));

        }
    }
    
    keys
    {
        key(PK; PrimaryKey)
        {
            Clustered = true;
        }
    }
}

// SalesInvoiceCueTable Page 

page 50102 SalesInvoiceCuePage
{
    PageType = CardPart;
    SourceTable = SalesInvoiceCueTable;
    
    layout
    {
        area(content)
        {
            /*
            cuegroup(salesCueContainer)
            {
                Caption = 'Sales Invoice';

                field(SalesCue; SalesInvoicesOpen)
                {
                    Caption = 'Open';
                    DrillDownPageId = "Sales Invoice List";
                }
            }
            */
            cuegroup(SalesActionontainer)
            {
                Caption='New Sales Invoice';
                
                actions
                {

                    action(ActionName)
                    {
                        RunObject=page "Sales Invoice";
                        Image=TileNew;

                        trigger OnAction()
                        begin
                                    
                        end;
                    }
                }
            }
        }
    }
    trigger OnOpenPage();
    begin
        RESET;
        if not get then
        begin
            INIT;
            INSERT;
        end;
    end;

}