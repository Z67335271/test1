package pojo;

public class client {
    String userid;
    String userpwd;
    String identity;
    String username;
    String message;
    String [][] record = null;
    public client(){
        record = new String[1][1];
    }

    public void setRecord(String[][] record) {
        this.record = record;
    }

    public String[][] getRecord() {
        return record;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public String getMessage() {
        return message;
    }

    public String getuserid(){
        return userid;
    }
    public String getuserpwd(){
        return userpwd;
    }
    public String getidentity(){
        return identity;
    }
    public String getusername(){
        return username;
    }
    public void setusername(String newName){
        username = newName;
    }
    public void setidentity(String newIdentity){
        identity = newIdentity;
    }
    public void setuserpwd(String newPwd){ userpwd = newPwd;}
    public void setuserid(String newID){
        userid = newID;
    }



}
