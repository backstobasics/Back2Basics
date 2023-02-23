public class LeadTriggerHandler {
  public static void leadMailCheck(list<Lead> leadlist){
    Map<string,Lead> leadMap = new Map<string,lead>();
    for(Lead ld:leadlist) leadMap.put(ld.Email,ld);
    Map<string,contact> conMap = new Map<String,contact>();
    for(Contact con:[select id,Email from contact where Email=:leadMap.keySet()]){
        if(conMap.containsKey(con.Email)) conMap.get(Con.Email);
        else conMap.put(con.Email,con);
        
    }
    for(Lead ld:leadlist){
        if(conMap.containsKey(ld.Email) || ld.Email != ''){
            ld.addError('Lead Already exists');
        }
    }
  }
}