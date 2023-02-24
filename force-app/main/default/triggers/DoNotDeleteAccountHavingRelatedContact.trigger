//  Account that has related contacts should not be deleted
trigger DoNotDeleteAccountHavingRelatedContact on Account (before delete) {
    //nested loop
    for(Account acc:[select id from Account where id in (select AccountId from Contact) and Id in: trigger.oldMap.keySet()]){
        trigger.oldMap.get(acc.id).addError('Account can not be deleted');
    } 
}
 /*
    there are three ways to achieve this solution: 
    1st way:
    =============================================
    // use set to store AccountId
    Set<Id> accId = new Set<Id>();
    // deleting records are stored in trigger.old list
    for(Account oldAcc:Trigger.old){
        accId.add(oldAcc.Id);
    }
    Map<Id,Account> accMap = new Map<Id,Account>([select id,(select id from contacts) from Account where id in:accId]);
    for(Account acc:Trigger.old){
        if(accMap.get(acc.Id).contacts.size() > 0){
            acc.addError('Account can be deleted');
        }
    }

    2nd way:
    ================================================
    // use AggregateResult query
    for(AggregateResult ar:[select AccountId,count(id) contactcount from Contact where AccountId in: Trigger.oldMap.keyset() GROUP BY AccountId]){
        Trigger.oldMap.get((Id)ar.get('AccountId')).addError('Account can not be deleted');
    }

 */
