package niki;



import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;

public class ReadExcel {
	private static String filename;//="C:/Users/vakaniwabo/Documents/CMU documents/Internship-Algorithm/Data/The mirror/Kitchen list.xlsx";
	//String a = "C:\Users\vakaniwabo\Documents\CMU documents\Internship-Algorithm\Data\The mirror";

	public ReadExcel() {
		// TODO Auto-generated constructor stub
	}
	
	/*
	 * getters and setters
	 */
	public String getFilename() {
		return filename;
	}

	public void setFilename(String filename) {
		ReadExcel.filename = filename;
	}
	
	
	/*
	 * main function
	 */

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		readFile("C:/Users/vakaniwabo/Documents/CMU documents/Internship-Algorithm/Data/The mirror/Kitchen list.xlsx");
		//System.out.println(readFile(filename));
	}	
	
	public void testFunct(){
		System.out.println("this is the test function!!; and the file path is: "+  filename);
	}
		

	/*
	 * readFile function takes an excel file name as parameter
	 * returns a map of the values of the excel file data row by row
	 */
	public static Map readFile(String filename){
		Map<String, ArrayList<String>> mydata = new HashMap<String,ArrayList<String>>();

		
		try {
			
			//FileInputStream file = new FileInputStream(new File("C:/Users/vakaniwabo/Documents/hello.xls"));
			FileInputStream file = new FileInputStream(new File(filename));

			//Get the workbook instance for XLS file 
			XSSFWorkbook workbook = new XSSFWorkbook(file);

			//Get first sheet from the workbook
			XSSFSheet sheet = workbook.getSheetAt(0);
			
			//Iterate through each rows from first sheet
			Iterator<Row> rowIterator = sheet.iterator();
			
			
			int i=0;
			
			while(rowIterator.hasNext()) {
				
				ArrayList<String> rowData = new ArrayList<String>();

				
				Row row = rowIterator.next();
				int j=0;
				//For each row, iterate through each columns
				Iterator<Cell> cellIterator = row.cellIterator();
				while(cellIterator.hasNext() && j<3) {//I make sure I take only 3 columns
					
					Cell cell = cellIterator.next();
					
					switch(cell.getCellType()) {
						case Cell.CELL_TYPE_BOOLEAN:
							System.out.print(cell.getBooleanCellValue() + "\t\t");
							//adding the cell data to the arraylist
							rowData.add(cell.getBooleanCellValue()+"");

							break;
						case Cell.CELL_TYPE_NUMERIC:
							System.out.print(cell.getNumericCellValue() + "\t\t");
							//adding the cell data to the arraylist
							rowData.add(cell.getNumericCellValue()+"");

							break;
						case Cell.CELL_TYPE_STRING:
							System.out.print(cell.getStringCellValue() + "\t\t");
							//adding the cell data to the arraylist
							rowData.add(cell.getStringCellValue()+"");

							break;
					}
					j++;
				}
				System.out.println("");
				i++;
				
				mydata.put(i+"", rowData);

			}
			
			System.out.println("these are the data in the hashmap:");
			System.out.println(mydata.values());
			System.out.println("hashmap data at key 1");
			System.out.println(mydata.get("1"));

			
			file.close();
			/*FileOutputStream out = 
				new FileOutputStream(new File("C:/Users/vakaniwabo/Documents/hello.xls"));
			workbook.write(out);
			out.close();
*/			
			return mydata;
		} catch (FileNotFoundException e) {
			e.printStackTrace();
			return mydata;
		} catch (IOException e) {
			e.printStackTrace();
			return mydata;
		}

	}

}

