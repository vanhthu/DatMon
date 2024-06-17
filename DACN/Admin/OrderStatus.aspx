<%@ Page Title="Admin - Trạng thái đơn hàng" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="OrderStatus.aspx.cs" Inherits="DACN.Admin.OrderStatus" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script>
        window.onload = function () {
            var giay = 5;
            setTimeout(function () {
                document.getElementById("<%=lbMessage.ClientID%>").style.display = "none";
            }, giay * 1000);
        };
    </script>
    <style>
    .badge-status-1 {
        background-color: #DC3545; 
    }
    .badge-status-2 {
        background-color: #17A2B8; 
    }
    .badge-status-3 {
        background-color: #28A745; 
    }
    /* Thêm các lớp CSS khác nếu cần thiết */
</style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="pcoded-inner-content pt-0">
        <div class="align-align-self-end">
            <asp:Label ID="lbMessage" runat="server" Visible="false"></asp:Label>
        </div>

        <div class="main-body">
            <div class="page-wrapper">
                <div class="page-body">
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="card">
                                <div class="card-header">
                                </div>
                                <div class="card-block">
                                    <div class="row">
                                        <div class="col-sm-6 col-md-8 col-lg-8">
                                            <h4 class="sub-title">Danh sách đơn hàng</h4>
                                            <div class="card-block table-border-style">
                                                <div class="table-responsive">
                                                    <asp:Repeater ID="repeatOrderStatus" runat="server" OnItemCommand="repeatOrderStatus_ItemCommand">
                                                        <HeaderTemplate>
                                                            <table class="table data-table-export table-hover nowrap">
                                                                <thead>
                                                                    <tr>
                                                                        <th class="table-plus">Mã đơn hàng</th>
                                                                        <th>Ngày đặt</th>
                                                                        <th>Trạng thái</th>
                                                                        <th>Tên món</th>
                                                                        <th>Tổng tiền</th>
                                                                        <th>Thanh toán bằng</th>
                                                                        <th class="datatable-nosort">Chỉnh sửa</th>
                                                                    </tr>
                                                                </thead>
                                                                <tbody>
                                                        </HeaderTemplate>

                                                        <ItemTemplate>
                                                            <%-- lấy từ database --%>
                                                            <tr>
                                                                <td class="table-plus"><%# Eval("orderNo") %></td>
                                                                <td><%# Eval("orderNo") %></td>
                                                                <td>
                                                                    <asp:Label ID="lblStatus" runat="server" Text='<%# Eval("status") %>'
                                                                        CssClass='<%# Eval("status").ToString() == "Đã giao" ? "badge badge-success":"badge badge-warning" %>'></asp:Label>
                                                                </td>
                                                                
                                                                <td><%# Eval("name") %> </td>
                                                                <td>đ<%# Eval("tongtien") %> </td>
                                                                <td><%# Eval("paymentMode") %> </td>
                                                                <td>
                                                                    <asp:LinkButton ID="LinkButtonEdit" runat="server" CssClass="badge badge-primary"
                                                                        CommandArgument='<%# Eval("orderDetailsID") %>' CommandName="edit" Text="Sửa"> 
                                                                        <i class="ti-pencil"></i> 
                                                                    </asp:LinkButton>
                                                                </td>
                                                            </tr>
                                                        </ItemTemplate>
                                                        <FooterTemplate>
                                                            </tbody>
                                                            </table>
                                                        </FooterTemplate>
                                                    </asp:Repeater>
                                                </div>
                                            </div>

                                        </div>

                                        <%-- Load dữ liệu lên --%>
                                        <div class="col-sm-6 col-md-4 col-lg-4 mobile-inputs">
                                            <asp:Panel ID="panelUpdateStatus" runat="server">
                                                <h4 class="sub-title">Cập nhật trạng thái</h4>
                                                <div>
                                                    <div class="form-group">
                                                        <label>Trạng thái đơn hàng</label>
                                                        <div>
                                                            <asp:DropDownList ID="ddlOrderStatus" runat="server" CssClass="form-control">
                                                                <asp:ListItem Value="0">Lựa chọn trạng thái</asp:ListItem>
                                                                <asp:ListItem>Đang giao</asp:ListItem>
                                                                <asp:ListItem>Đã gửi</asp:ListItem>
                                                                <asp:ListItem>Đã giao</asp:ListItem>
                                                            </asp:DropDownList>
                                                            <asp:RequiredFieldValidator ID="rfvOrderStatus" runat="server"
                                                                ControlToValidate="ddlOrderStatus" ErrorMessage="Vui lòng chọn trạng thái!"
                                                                ForeColor="Red" Display="Dynamic" InitialValue="0">
                                                            </asp:RequiredFieldValidator>
                                                            <asp:HiddenField ID="hdnID" runat="server" Value="0" />
                                                        </div>
                                                    </div>

                                                    <div class="pb-5">
                                                        <asp:Button ID="btnUpdate" runat="server" Text="Cập nhật" CssClass="btn btn-primary"
                                                            OnClick="btnUpdate_Click" />
                                                        &nbsp;
                                                    <asp:Button ID="btnCancel" runat="server" Text="Hủy" CssClass="btn btn-primary"
                                                        CausesValidation="false" OnClick="btnCancel_Click" />
                                                    </div>
                                                </div>
                                            </asp:Panel>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
