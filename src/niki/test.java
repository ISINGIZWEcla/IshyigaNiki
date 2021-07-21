package niki;

public class test {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		
		TrashInput trash = new TrashInput();
		
		trash.setCodebar("1234");
		trash.setCompany("test");
		trash.setExternal_info_1("test");
		trash.setFilename("test");
		trash.setFromExcelId("test");
		
		try{
			trash.insertTrashInput();
		}catch(Exception e){
			e.printStackTrace();
			System.out.println(e.getMessage());
			
		}
		
		
		
	}

}
