trigger ContactRollUpSummaryTrigger on Contact (after insert,after update,after delete,after undelete) {
    if(Trigger.isAfter){
           //---> on delete we use Trigger.Old, all else, Trigger.new
        list<Contact> contacts = Trigger.isDelete ? Trigger.old :Trigger.new;
        contactHandler.contactsOnAccount(contacts);
    }
}