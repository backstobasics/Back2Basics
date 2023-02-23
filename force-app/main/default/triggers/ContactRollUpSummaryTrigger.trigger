// get contact count on Account object field called contact_count__c
trigger ContactRollUpSummaryTrigger on Contact (after insert,after update,after delete,after undelete) {
   // use of ternary operator, if true then trigger.old else trigger.new
    list<contact> contacts = trigger.isDelete ? trigger.old : trigger.new;
   //  calling apex handler class
   contactHandler.contactonCount(contacts,trigger.oldMap);
}