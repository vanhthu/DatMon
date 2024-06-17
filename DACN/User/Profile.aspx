<%@ Page Title="Thông tin của bạn" Language="C#" MasterPageFile="~/User/User.Master" AutoEventWireup="true" CodeBehind="Profile.aspx.cs" Inherits="DACN.User.Profile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <%
        string imageURL = Session["imageURL"].ToString();
    %>
    <section class="book_section layout_padding">
        <div class="container">
            <div class="heading_container">
                <h2>Thông tin người dùng</h2>
            </div>

            <div class="row">
                <div class="col-12">
                    <div class="card">
                        <div class="card-body">
                            <div class="card-title mb-4">
                                <div class="d-flex justify-content-start">
                                    <div class="image-container">
                                        <img src="<%= DACN.Utils.GetImageURL(imageURL) %>" id="imgUser" style="width: 150px; height: 150px;" class="img-thumbnail" />
                                        <div class="middle pt-2">
                                            <a href="Registeration.aspx?id=<%Response.Write(Session["userID"]); %>" class="btn btn-warning">
                                                <i class="fa fa-pencil"></i>&nbsp;Chỉnh sửa
                                            </a>
                                        </div>
                                    </div>

                                    <div class="userData ml-3">
                                        <h2 class="d-block" style="font-size: 1.5rem; font-weight: bold">
                                            <a href="javascript:void(0);"><%Response.Write(Session["name"]); %></a>
                                        </h2>

                                        <h6 class="d-block">
                                            <a href="javascript:void(0);">
                                                <asp:Label ID="lblUserName" runat="server" ToolTip="Tên người dùng"> 
                                                            @<%Response.Write(Session["username"]); %>
                                                </asp:Label>
                                            </a>
                                        </h6>

                                        <h6 class="d-block">
                                            <a href="javascript:void(0);">
                                                <asp:Label ID="lblEmail" runat="server" ToolTip="Email"> 
                                                            @<%Response.Write(Session["email"]); %>
                                                </asp:Label>
                                            </a>
                                        </h6>

                                        <h6 class="d-block">
                                            <a href="javascript:void(0);">
                                                <asp:Label ID="lblCreatedDate" runat="server" ToolTip="Ngày tạo tài khoản"> 
                                                            @<%Response.Write(Session["createdDate"]); %>
                                                </asp:Label>
                                            </a>
                                        </h6>
                                    </div>
                                </div>
                            </div>

                            <%-- 2 cái tab --%>
                            <div class="row">
                                <div class="col-12">
                                    <ul class="nav nav-tabs mb-4" id="myTab" role="tablist">
                                        <li class="nav-item">
                                            <a class="nav-link active text-info" id="basicInfo-tab" data-toggle="tab" href="#basicInfo" role="tab"
                                                aria-controls="basicInfo" aria-selected="true"><i class="fa fa-id-badge mr-2"></i>
                                                Thông tin người dùng
                                            </a>
                                        </li>
                                        <li class="nav-item">
                                            <a class="nav-link text-info" id="connectedServices-tab" data-toggle="tab" href="#connectedServices" role="tab"
                                                aria-controls="connectedServices" aria-selected="false"><i class="fa fa-clock-o mr-2"></i>Lịch sử mua hàng</a>
                                        </li>
                                    </ul>


                                    <div class="tab-content ml-1" id="myTabContent">
                                        <%-- tab thông tin người dùng start --%>
                                        <div class="tab-pane fade show active" id="basicInfo" role="tabpanel" aria-labelledby="basicInfo-tab">
                                            <asp:Repeater ID="repeatProfile" runat="server">
                                                <ItemTemplate>
                                                    <div class="row">
                                                        <div class="col-sm-3 col-md-2 col-5">
                                                            <label style="font-weight: bold">Tên đầy đủ</label>
                                                        </div>
                                                        <div class="col-md-8 col-6">
                                                            <%# Eval("name") %>
                                                        </div>
                                                    </div>
                                                    <hr />

                                                    <div class="row">
                                                        <div class="col-sm-3 col-md-2 col-5">
                                                            <label style="font-weight: bold">Tên tài khoản</label>
                                                        </div>
                                                        <div class="col-md-8 col-6">
                                                            <%# Eval("username") %>
                                                        </div>
                                                    </div>
                                                    <hr />

                                                    <div class="row">
                                                        <div class="col-sm-3 col-md-2 col-5">
                                                            <label style="font-weight: bold">Số điện thoại</label>
                                                        </div>
                                                        <div class="col-md-8 col-6">
                                                            <%# Eval("mobile") %>
                                                        </div>
                                                    </div>
                                                    <hr />

                                                    <div class="row">
                                                        <div class="col-sm-3 col-md-2 col-5">
                                                            <label style="font-weight: bold">Email</label>
                                                        </div>
                                                        <div class="col-md-8 col-6">
                                                            <%# Eval("email") %>
                                                        </div>
                                                    </div>
                                                    <hr />

                                                    <div class="row">
                                                        <div class="col-sm-3 col-md-2 col-5">
                                                            <label style="font-weight: bold">Mật khẩu</label>
                                                        </div>
                                                        <div class="col-md-8 col-6">
                                                            <%# Eval("password") %>
                                                        </div>
                                                    </div>
                                                    <hr />

                                                    <div class="row">
                                                        <div class="col-sm-3 col-md-2 col-5">
                                                            <label style="font-weight: bold">Địa chỉ</label>
                                                        </div>
                                                        <div class="col-md-8 col-6">
                                                            <%# Eval("address") %>
                                                        </div>
                                                    </div>
                                                    <hr />
                                                </ItemTemplate>
                                            </asp:Repeater>
                                        </div>
                                        <%-- tab thông tin người dùng end --%>

                                        <%-- lịch sử mua hàng start --%>
                                        <div class="tab-pane fade" id="connectedServices" role="tabpanel" aria-labelledby="connectedServices-tab">
                                            <asp:Repeater ID="repeatPurchaseHistoty" runat="server" OnItemDataBound="repeatPurchaseHistoty_ItemDataBound" >
                                                <ItemTemplate>
                                                    <div class="container">
                                                        <div class="row pt-1 pb-1" style="background-color: lightgray">
                                                            <div class="col-4">
                                                                <span class="badge badge-pill badge-dark text-white">
                                                                    <%# Eval("stt") %>
                                                                </span>
                                                                Thanh toán bằng: <%# Eval("paymentMode").ToString() == "cod" ? "COD" : Eval("paymentMode").ToString().ToUpper()%>
                                                            </div>
                                                            <div class="col-6">
                                                                <%# string.IsNullOrEmpty(Eval("cardNo").ToString()) ? "" : "Số thẻ: " + Eval("cardNo").ToString() %>
                                                            </div>
                                                            <div class="col-2">
                                                                <a href="Invoice.aspx?id=<%# Eval("paymentID") %>" class="btn btn-info btn-sm"><i class="fa fa-download mr-2"></i>Tải xuống hóa đơn</a>
                                                            </div>
                                                        </div>
                                                        <asp:HiddenField ID="hdnPaymentID" runat="server" Value='<%# Eval("paymentID") %>' />
                                                        <asp:Repeater ID="repeatOrder" runat="server">
                                                            <HeaderTemplate>
                                                                <table class="table data-table-export table-responsive-sm table-bordered table-hover">
                                                                    <thead class="bg-dark text-white">
                                                                        <tr>
                                                                            <th>Tên món ăn</th>
                                                                            <th>Giá</th>
                                                                            <th>Số lượng</th>
                                                                            <th>Tổng tiền</th>
                                                                            <th>Mã đơn hàng</th>
                                                                            <th>Trạng thái</th>
                                                                        </tr>
                                                                    </thead>
                                                                    <tbody>
                                                            </HeaderTemplate>
                                                            <ItemTemplate>
                                                                <tr>
                                                                    <td>
                                                                        <asp:Label ID="lblName" runat="server" Text='<%# Eval("name") %>'></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                         <asp:Label ID="lblPrice" runat="server" Text='<%# string.IsNullOrEmpty(Eval("price").ToString()) ? "" : "đ" + Eval("price").ToString() %>'></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                         <asp:Label ID="lblQuantity" runat="server" Text='<%# Eval("quantity") %>'></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                         đ<asp:Label ID="lblTotalPrice" runat="server" Text='<%# Eval("tongtien") %>'></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                         <asp:Label ID="lblOrderNo" runat="server" Text='<%# Eval("orderNo") %>'></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                         <asp:Label ID="lblStatus" runat="server" Text='<%# Eval("status") %>'
                                                                              CssClass='<%# Eval("status").ToString() == "Đã giao" ? "badge badge-success" :"badge badge-warning" %>' ></asp:Label>
                                                                    </td>

                                                                </tr>
                                                            </ItemTemplate>
                                                            <FooterTemplate>
                                                                </tbody>
                                                                </table>
                                                            </FooterTemplate>
                                                        </asp:Repeater>
                                                    </div>
                                                </ItemTemplate>
                                            </asp:Repeater>
                                        </div>
                                        <%-- lịch sử mua hàng end --%>
                                    </div>

                                </div>
                            </div>

                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</asp:Content>
