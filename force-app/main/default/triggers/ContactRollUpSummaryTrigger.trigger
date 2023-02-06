trigger ContactRollUpSummaryTrigger on Contact (after insert,after update,after delete,after undelete) {
   if(Trigger.isAfter){
      list<contact> contacts = trigger.isDelete ? trigger.old :trigger.new; 
      contactHandler.contactsOnAccount(contacts,trigger.oldMap);
   }
}