package pojo;

public class ticket {

    String []columnName;
    String [][] tableRecord =null;
    public ticket(){
        tableRecord = new String[1][1];
        columnName = new String[1];
    }

    public void setColumnName(String[] s) {
        this.columnName = s;
    }

    public String[][] getTableRecord(){
        return tableRecord;
    }

    public void setTableRecord(String[][] t) {
        this.tableRecord = t;
    }

    public String[] getColumnName(){
        return columnName;
    }
}
