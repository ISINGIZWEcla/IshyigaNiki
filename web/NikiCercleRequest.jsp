

<%@page import="i_m_e.me"%>
<%@page import="niki.Niki_request"%>
<%@page import="niki.ConnectionClass"%>
<%@page import="java.sql.*"%>
<%@page import="niki.Item_Final" %>
<%@page import="javax.servlet.ServletInputStream,javax.servlet.http.HttpServletRequest"%>
<%@page import="java.io.BufferedReader,java.io.InputStreamReader"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.util.Enumeration"%>
<%@page import="java.util.Map"%>



<%

    BufferedReader br = request.getReader();
    String prefix = "payment_intimation";
    PrintWriter writer = new PrintWriter("yourfilenamewithpath", "UTF-8");
    String line = "";

    writer.println("----PARAMETERS-----");

    if (request.getContentType().equals("SDJUNSHDSD")) {%><%=request.getContentType()%> FAIL TO LOG EXITING <%
    } else {
        writer.println("----BODY-----");
        String income = null;
        while ((line = br.readLine()) != null) {
            writer.println(line);
            income = line;

        }
        writer.close();
        if (income != null) {
            String catt = niki.Niki_request.getTagValue("category", income);
            try {

                String sql = "SELECT * FROM niki.niki_items,niki.niki_item_business_category,niki.niki_items_temp where "
                        + "niki.niki_items.niki_code= niki.niki_item_business_category.niki_code "
                        + "and niki.niki_items.niki_code= niki.niki_items_temp.niki_code "
                        + "and niki.niki_item_business_category.busin_category_id='" + catt + "'ORDER BY ITEM_TEMP_ID";

%>
<%     Connection conn = ConnectionClass.getConnection();
    PreparedStatement st = conn.prepareStatement(sql);
    ResultSet rs = st.executeQuery();

    String resultat = "<START>";

    while (rs.next()) {
        String niki_code = rs.getString(1);
        String code_product = rs.getString("item_external_id");
        String item_commercial_name = rs.getString("item_commercial_name");
        String tax_vat = rs.getString("tax_vat");
        String status = rs.getString("status");
        String bar_code = rs.getString("bar_code");
        String hs_code = rs.getString("hs_code");
        String item_fabricant = rs.getString("item_fabricant");
        String item_inn = rs.getString("item_inn");
        double item_packet = rs.getDouble("item_packet");
        String item_form = rs.getString("item_form");
        String item_emballage = rs.getString("item_emballage");
        String category_id = rs.getString("category_id");
        String item_dosage = rs.getString("item_dosage");
        
        item_inn = item_inn.replaceAll("[^a-zA-Z0-9]", " ");
        item_dosage = item_dosage.replaceAll("[^a-zA-Z0-9]", " ");
        category_id = category_id.replaceAll("[^a-zA-Z0-9]", " ");

        resultat += "<LINE>"
                + "<niki_code>" + niki_code + "</niki_code>"
                + "<item_commercial_name>" + item_commercial_name + "</item_commercial_name>"
                + "<tax_vat>" + tax_vat + "</tax_vat>"
                + "<item_inn>" + item_inn + "</item_inn>"
                + "<item_packet>" + item_packet + "</item_packet>"
                + "<item_form>" + item_form + "</item_form>"
                + "<item_emballage>" + item_emballage + "</item_emballage>"
                + "<category_id>" + category_id + "</category_id>"
                + "<item_dosage>" + item_dosage + "</item_dosage>"
                + "<item_bar_code>" + bar_code + "</item_bar_code>"
                + "<item_hs_code>" + hs_code + "</item_hs_code>"
                + "<code_product>" + code_product + "</code_product>"
                + "</LINE>";

    }

    resultat += "</START>";
%>
<%=resultat%> <%

    conn.close();
} catch (Exception e) {
    out.print(e);
%> <%=e%> danger <%
    }
} else {%> <%=line%> nameneste <% }
      }
%>
