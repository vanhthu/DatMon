<%@ Page Title="Hóa đơn" Language="C#" MasterPageFile="~/User/User.Master" AutoEventWireup="true" CodeBehind="Invoice.aspx.cs" Inherits="DACN.User.Invoice" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script>
        window.onload = function () {
            var giay = 5;
            setTimeout(function () {
                document.getElementById("<%=lblMessage.ClientID%>").style.display = "none";
            }, giay * 1000);
        };
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <section class="book_section layout_padding">
        <div class="container">
            <div class="heading_container">
                <div class="align-self-end">
                    <asp:Label ID="lblMessage" runat="server" Visible="false"></asp:Label>
                </div>                
            </div>
        </div>
        <div class="container">
            <asp:Repeater ID="repeatThanhToan" runat="server">
                <HeaderTemplate>
                    <table class="table table-responsive-sm table-bordered table-hover" id="tableHoaDon">
                        <thead class =" bg-dark text-white">
                            <tr>
                                <th>STT</th>
                                <th>Mã đơn hàng</th>
                                <th>Tên món ăn</th>
                                <th>Giá</th>
                                <th>Số lượng</th>
                                <th>Tổng tiền</th>
                            </tr>
                        </thead>
                        <tbody>

                        
                </HeaderTemplate>
                <ItemTemplate>
                    <tr>
                        <%-- số seri để định danh hóa đơn --%>
                        <td><%# Eval("stt") %></td>
                        <td><%# Eval("orderNo") %></td>
                        <td><%# Eval("name") %></td> 
                        <td><%# string.IsNullOrEmpty(Eval("price").ToString()) ? "" :"đ"+Eval("price") %></td>
                        <td><%# Eval("quantity") %></td>
                        <td>đ<%# Eval("tongtien") %></td>
                    </tr>
                </ItemTemplate>
                <FooterTemplate>
                    </tbody>
                    </table>
                </FooterTemplate>
            </asp:Repeater>

            <div class="text-center">
                <asp:LinkButton ID="lbTaiXuongHoaDon" runat="server" CssClass="btn btn-info" 
                    OnClick="lbTaiXuongHoaDon_Click" >
                    <i class="fa fa-file-pdf-o mr-2"></i> Tải xuống
                </asp:LinkButton>
            </div>
            
        </div>
        </section>
</asp:Content>
