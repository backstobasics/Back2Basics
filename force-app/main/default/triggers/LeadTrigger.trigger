// donot create lead when contact exists
trigger LeadTrigger on Lead (before insert,before update) {
   //if contact email exists, lead created with mail then it should through error "Lead Already exists" 
   if(trigger.isBefore && (Trigger.isInsert || Trigger.isUpdate)){
    LeadTriggerHandler.leadMailCheck(trigger.new);
   }
}