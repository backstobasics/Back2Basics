public class contactHandler {
    public static void contactsOnAccount(list<contact> contacts,Map<Id,Contact> oldContact){
      set<Id> accId = new Set<Id>();
      for(Contact con:contacts){
        if(con.AccountId != null) accId.add(con.AccountId);
        // after referencing some different Account,Old Account count also needs to be increased
        if(Trigger.isAfter && Trigger.isUpdate){
          if(con.AccountId != oldContact.get(con.id).AccountId){
            accId.add(oldContact.get(con.id).AccountId);
          }
        }
      }
      list<Account> rollupSummaryAccount = new List<Account>();
      // AggregateResult Query
      for(AggregateResult ar:[select AccountId,count(id)contactcount from Contact where AccountId=:accId group by AccountId]){
        Account acc = new Account (id = (Id)ar.get('AccountId'));
        acc.contact_count__c = (Integer)ar.get('contactcount');
        rollupSummaryAccount.add(acc);
      }
      if(!rollupSummaryAccount.isEmpty()){
        update rollupSummaryAccount;
      }
    }
}