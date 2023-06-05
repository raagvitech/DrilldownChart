public with sharing class DrillDownGraphController {
    @AuraEnabled(cacheable=true)
    public static List<AggregateResult> getSalesByQuater() {
      return [
        SELECT Product_Category__c, CALENDAR_QUARTER(Sold_Date__c) Quarter__c, SUM(Product_Price__c) Total_Sales__c
        FROM Sales_products__c
        GROUP BY Product_Category__c, CALENDAR_QUARTER(Sold_Date__c) 
       ];
    }
    @AuraEnabled
    public static List<AggregateResult> getSalesByMonth( Integer quarter) {
        List<AggregateResult> results = [
            SELECT Product_Category__c, CALENDAR_MONTH(Sold_Date__c) month, SUM(Product_Price__c) Total_Sales
            FROM Sales_products__c
            WHERE CALENDAR_QUARTER(Sold_Date__c) = :quarter
            GROUP BY Product_Category__c, CALENDAR_MONTH(Sold_Date__c)
        ];

        return results;
      }

  }