<%@ Page Title="Liên hệ với chúng tôi" Language="C#" MasterPageFile="~/User/User.Master" AutoEventWireup="true" CodeBehind="Contact.aspx.cs" Inherits="DACN.User.Contact" %>

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
    <!-- book section -->
    <section class="book_section layout_padding">
        <div class="container">
            <div class="heading_container">
                <div class="align-self-end">
                    <asp:Label ID="lblMessage" runat="server" Visible="false"></asp:Label>
                </div>
                <h2>Gửi phản hồi của bạn
                </h2>
            </div>
            <div class="row">
                <div class="col-md-6">
                    <div class="form_container">

                        <div>
                            
                            <asp:RequiredFieldValidator ID="rfvName" runat="server"
                                ErrorMessage="Vui lòng nhập vào tên!" ControlToValidate="txtName"
                                ForeColor="Red" Display="Dynamic" SetFocusOnError="true">                                    
                            </asp:RequiredFieldValidator>
                            <asp:TextBox ID="txtName" runat="server" CssClass="form-control"
                                placeholder="Nhập vào tên của bạn"></asp:TextBox>
                        </div>
                        <div>
                            
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
                                ErrorMessage="Vui lòng nhập vào email!" ControlToValidate="txtEmail"
                                ForeColor="Red" Display="Dynamic" SetFocusOnError="true">  
                            </asp:RequiredFieldValidator>
                            <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control"
                                placeholder="Nhập vào email của bạn" TextMode="Email"></asp:TextBox>
                        </div>
                        <div>
                            
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server"
                                ErrorMessage="Vui lòng nhập vào tiêu đề phản hồi!" ControlToValidate="txtSubject"
                                ForeColor="Red" Display="Dynamic" SetFocusOnError="true">                                    
                            </asp:RequiredFieldValidator>
                            <asp:TextBox ID="txtSubject" runat="server" CssClass="form-control"
                                placeholder="Nhập vào tiêu đề phản hồi"></asp:TextBox>
                        </div>
                        <div>
                           
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server"
                                ErrorMessage="Vui lòng nhập vào nội dung phản hồi!" ControlToValidate="txtMessage"
                                ForeColor="Red" Display="Dynamic" SetFocusOnError="true">                                    
                            </asp:RequiredFieldValidator>
                             <asp:TextBox ID="txtMessage" runat="server" CssClass="form-control"
                                placeholder="Nhập vào nội dung phản hồi" TextMode="MultiLine"></asp:TextBox>
                        </div>

                        <div class="btn_box">
                            <asp:Button ID="btnSubmit" runat="server" Text="Gửi" CssClass="btn btn-primary rounded-pill pl-4 pr-4 text-white"
                                OnClick="btnSubmit_Click" />
                        </div>

                    </div>
                </div>
                <div class="col-md-6">
                    <div class="map_container ">
                        <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3824.683792359879!2d106.33274019720317!3d10.423136775197898!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x310abb77abfeb299%3A0x3047216743107681!2zVHLGsOG7nW5nIMSQ4bqhaSBo4buNYyBUaeG7gW4gR2lhbmcgY8ahIHPhu58gMg!5e1!3m2!1svi!2s!4v1714796108521!5m2!1svi!2s"
                            width="600" height="450" style="border: 0;" allowfullscreen="" loading="lazy"
                            referrerpolicy="no-referrer-when-downgrade">
                        </iframe>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- end book section -->
</asp:Content>
