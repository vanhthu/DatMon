<%@ Page Title="Đăng nhập" Language="C#" MasterPageFile="~/User/User.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="DACN.User.Login" %>
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
                <h2>Đăng nhập</h2>
            </div>
            <div class="row">
                <div class="col-md-6">
                    <div class="form_container">
                        <img id="userLogin" src="../Images/Login.jpg" alt="" class="img-thumbnail" style="border:none"/>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="form_container" style="margin-top:80px">
                        <div>
                            <asp:RequiredFieldValidator ID="rfvUserName" runat="server" ErrorMessage="Vui lòng nhập vào tên tài khoản!" ControlToValidate="txtUserName"
                                ForeColor="Red" Display="Dynamic" SetFocusOnError="true" Font-Size="Small"></asp:RequiredFieldValidator>
                            <asp:TextBox ID="txtUserName" runat="server" CssClass="form-control" placeholder="Nhập vào tên tài khoản" ToolTip="Tên tài khoản"></asp:TextBox>
                        </div>

                        <div>
                            <asp:RequiredFieldValidator ID="rfvPassword" runat="server" ErrorMessage="Vui lòng nhập vào mật khẩu!" ControlToValidate="txtPassword"
                                ForeColor="Red" Display="Dynamic" SetFocusOnError="true" Font-Size="Small" ></asp:RequiredFieldValidator>
                            <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" placeholder="Nhập vào mật khẩu" ToolTip="Mật khẩu" TextMode="Password"></asp:TextBox>
                        </div>


                        <div class="btn_box">
                            <asp:Button ID="btnLogin" runat="server" Text="Đăng nhập" CssClass="btn btn-success rounded-pill pl-4 pr-4 text-white"
                                 OnClick="btnLogin_Click" />
                            <span class="pl-3 text-info">Bạn chưa có tài khoản? <a href='Registeration.aspx' class='badge badge-info'>Đăng ký ngay!</a></span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</asp:Content>
