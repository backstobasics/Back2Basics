public class contactHandler {
    public static void contactsOnAccount(list<Contact> contacts){
      set<Id> accId = new Set<Id>();
        for(Contact con:contacts){
            if(con.AccountId != null ) accId.add(con.AccountId);
      }
      list<Account> accountToRollup = new List<Account>();
      for(AggregateResult ar:[select AccountId,count(id)contactcount from Contact where AccountId =:accId group by AccountId]){
        Account acc = new Account(id = (Id)ar.get('AccountId'));
        acc.contact_count__c = (Integer)ar.get('contactcount');
        accountToRollup.add(acc);
      }
      if(accountToRollup.size() > 0){
        update accountToRollup;
      }
    }
}