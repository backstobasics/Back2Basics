public class contactHandler {
   public static void contactonCount(list<Contact> contacts,Map<Id,Contact> oldConMap){
     set<Id> accId = new Set<Id>();
    //  create Account list
    List<Account> accList = new List<Account>();
     for(Contact con:contacts){
         if(con.AccountId != null || con.AccountId != '') accId.add(con.AccountId);
         //  if we reference contact to another Account, old referenced account count needs to be decreased
         if(Trigger.isUpdate && Trigger.isAfter){
             if(con.AccountId != oldConMap.get(con.id).AccountId) accId.add(oldConMap.get(con.id).AccountId);
          }
     }
    // use aggregate result query which calculates count and returns result
    for(AggregateResult ar:[select AccountId,count(id) contactcount from Contact where AccountId=:accId GROUP BY AccountId]){
      Account acc=new Account(id=(Id)ar.get('AccountId'));
      acc.contact_count__c = (Integer)ar.get('contactcount');
      accList.add(acc);
    }
    // use safe navigator operator because in case query returns null, null.size() is not correct. 
    // use safe navigator operator or list.isEmpty()
    // ?. is safe navigator operator which checks for null to avoid NullPointerException
    if(accList?.size() > 0){
      update accList;
    }
   }
}