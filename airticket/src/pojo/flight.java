package pojo;

public class flight {
    String [][] Record = null;
    String date=null;
    String start =null;
    String end = null;
    String previous = null;
    String next = null;
    public flight(){
        Record = new String[1][1];
    }
    public void setRecord(String[][] s){
        this.Record = s;
    }

    public String[][] getRecord() {
        return Record;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public String getDate() {
        return date;
    }

    public void setStart(String start) {
        this.start = start;
    }

    public String getStart() {
        return start;
    }

    public void setEnd(String end) {
        this.end = end;
    }

    public String getEnd() {
        return end;
    }

    public void setPrevious(String previous) {
        this.previous = previous;
    }

    public String getPrevious() {
        return previous;
    }

    public void setNext(String next) {
        this.next = next;
    }

    public String getNext() {
        return next;
    }
}
