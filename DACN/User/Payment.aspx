<%@ Page Title="Thanh toán" Language="C#" MasterPageFile="~/User/User.Master" AutoEventWireup="true" CodeBehind="Payment.aspx.cs" Inherits="DACN.User.Payment" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .rounded {
            border-radius: 1rem;
        }

        .nav-pills .nav-links {
            color: #555;
        }

            .nav-pills .nav-links.active {
                color: white;
            }

        .bold {
            font-weight: bold;
        }

        .card {
            padding: 40px 50px;
            border-radius: 20px;
            border: none;
            box-shadow: 1px 5px 10px 1px rgba(0, 0, 0, 0.2);
        }
    </style>

    <script>
        window.onload = function () {
            var giay = 5;
            setTimeout(function () {
                document.getElementById("<%=lblMessage.ClientID%>").style.display = "none";
            }, giay * 1000);
        };

        $(function () {
            $('[data-toggle="tooltip"]').tooltip()
        })
    </script>

    <script type="text/javascript">
        function DisableBackButton() {
            window.history.forward();
        }
        DisableBackButton();
        window.onload = DisableBackButton;
        window.onpageshow = function (evt) { if (evt.persisted) DisableBackButton() }
        window.onunload = function () { void (0) }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <section class="book_section" style="background-image: url('../Image/Payment-bg.png'); 
                                    width: 100%; height: 100%; background-repeat: no-repeat; 
                                    background-size: auto; background-attachment: fixed; 
                                    background-position: left;">
        <div class="container py-5">
            <div class="align-self-end">
                <asp:Label ID="lblMessage" runat="server" Visible="false"></asp:Label>
            </div>

            <div class="row mb-4">
                <div class="col-lg-8 mx-auto text-center">
                    <h1 class="display-6">Thanh Toán</h1>
                </div>
            </div>

            <div class="row pb-5">
                <div class="col-lg-6 mx-auto">
                    <div class="card">
                        <div class="card-header">
                            <div class="bg-white shadow-sm pt-4 pl-2 pr-2 pb-2">

                                <ul role="tablist" class="nav bg-light nav-pills rounded nav-fill mb-3">
                                    <li class="nav-item">
                                        <a data-toggle="pill" href="#credit-card" class="nav-link active">
                                            <i class="fa fa-mobile"></i>
                                        </a>
                                    </li>
                                    <li class="nav-item">
                                        <a data-toggle="pill" href="#paypal" class="nav-link">
                                            <i class="fa fa-money mr-2"></i>
                                        </a>
                                    </li>
                                </ul>
                            </div>

                            <div class="tab-content">
                                <div id="credit-card" class="tab-pane fade show active pt-3">
                                    <div role="form">
                                        <div class="form-group">
                                            <label for="txtName">
                                                <h6>Tên chủ thẻ</h6>
                                            </label>
                                            <asp:RequiredFieldValidator ID="rfvName" runat="server" ErrorMessage="Vui lòng nhập vào tên!"
                                                ControlToValidate="txtName" ForeColor="Red" Display="Dynamic" SetFocusOnError="true" ValidationGroup="card">*</asp:RequiredFieldValidator>
                                            <asp:RegularExpressionValidator ID="revName" runat="server" ErrorMessage="Tên không đúng định dạng!"
                                                ControlToValidate="txtName" ForeColor="Red" Display="Dynamic" SetFocusOnError="true" ValidationGroup="card"
                                                ValidationExpression="^[a-zA-Z\s]+$">*</asp:RegularExpressionValidator>
                                            <asp:TextBox ID="txtName" runat="server" CssClass="form-control" placeholder="Tên chủ thẻ"></asp:TextBox>
                                        </div>

                                        <div class="form-group">
                                            <label for="txtCardNo">
                                                <h6>Số thẻ</h6>
                                            </label>
                                            <asp:RequiredFieldValidator ID="refCardNo" runat="server" ErrorMessage="Vui lòng nhập vào số thẻ!"
                                                ControlToValidate="txtCardNo" ForeColor="Red" Display="Dynamic" SetFocusOnError="true" ValidationGroup="card">*</asp:RequiredFieldValidator>
                                            <asp:RegularExpressionValidator ID="revCardNo" runat="server" ErrorMessage="Số thẻ phải có 16 ký tự"
                                                ControlToValidate="txtCardNo" ForeColor="Red" Display="Dynamic" SetFocusOnError="true" ValidationGroup="card"
                                                ValidationExpression="[0-9]{16}">*</asp:RegularExpressionValidator>
                                            <div class="input-group">
                                                <asp:TextBox ID="txtCardNo" runat="server" CssClass="form-control" placeholder="Số thẻ" TextMode="Number"></asp:TextBox>
                                                <div class="input-group-append">
                                                    <span class="input-group-text text-muted">
                                                        <i class="fa fa-cc-visa mx-1"></i>
                                                        <i class="fa fa-cc-mastercard mx-1"></i>
                                                        <i class="fa fa-cc-amex mx-1"></i>
                                                    </span>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-sm-8">
                                                <div class="form-group">
                                                    <label>
                                                        <span class="hidden-xs">
                                                            <h6>Ngày hết hạn</h6>
                                                        </span>
                                                    </label>
                                                    <asp:RequiredFieldValidator ID="refExpMonth" runat="server" ErrorMessage="Vui lòng nhập vào tháng hết hạn!"
                                                        ControlToValidate="txtExpMonth" ForeColor="Red" Display="Dynamic" SetFocusOnError="true" ValidationGroup="card">*</asp:RequiredFieldValidator>
                                                    <asp:RegularExpressionValidator ID="revExpMonth" runat="server" ErrorMessage="Tháng phải có 2 chữ số!"
                                                        ControlToValidate="txtExpMonth" ForeColor="Red" Display="Dynamic" SetFocusOnError="true" ValidationGroup="card"
                                                        ValidationExpression="[0-9]{2}">*</asp:RegularExpressionValidator>
                                                    <asp:RequiredFieldValidator ID="refExpYear" runat="server" ErrorMessage="Vui lòng nhập vào năm hết hạn!"
                                                        ControlToValidate="txtExpYear" ForeColor="Red" Display="Dynamic" SetFocusOnError="true" ValidationGroup="card">*</asp:RequiredFieldValidator>
                                                    <asp:RegularExpressionValidator ID="revExpYear" runat="server" ErrorMessage="Năm phải có 4 chữ số!"
                                                        ControlToValidate="txtExpYear" ForeColor="Red" Display="Dynamic" SetFocusOnError="true" ValidationGroup="card"
                                                        ValidationExpression="[0-9]{4}">*</asp:RegularExpressionValidator>
                                                    <div class="input-group">
                                                        <asp:TextBox ID="txtExpMonth" runat="server" CssClass="form-control" placeholder="01" TextMode="Number"></asp:TextBox>
                                                        <asp:TextBox ID="txtExpYear" runat="server" CssClass="form-control" placeholder="2024" TextMode="Number"></asp:TextBox>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="col-sm-4">
                                                <div class="form-group mb-4">
                                                    <label data-toggle="tooltip" title="3 số phía sau thẻ của bạn">
                                                        <h6>CVV<i class="fa fa-question-circle d-inline"></i></h6>
                                                    </label>
                                                    <asp:RequiredFieldValidator ID="rfvCVV" runat="server" ErrorMessage="Vui lòng nhập vào số CVV!"
                                                        ControlToValidate="txtCVV" ForeColor="Red" Display="Dynamic" SetFocusOnError="true" ValidationGroup="card">*</asp:RequiredFieldValidator>
                                                    <asp:RegularExpressionValidator ID="revCVV" runat="server" ErrorMessage="CVV phải có 3 chữ số"
                                                        ControlToValidate="txtCVV" ForeColor="Red" Display="Dynamic" SetFocusOnError="true" ValidationGroup="card"
                                                        ValidationExpression="[0-9]{3}"></asp:RegularExpressionValidator>
                                                    <asp:TextBox ID="txtCVV" runat="server" CssClass="form-control" placeholder="Số CVV" TextMode="Number"></asp:TextBox>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <label for="txtAddress">
                                                <h6>Địa chỉ nhận hàng</h6>
                                            </label>
                                            <asp:RequiredFieldValidator ID="rfvAddress" runat="server" ErrorMessage="Vui lòng nhập vào địa chỉ nhận hàng!"
                                                ControlToValidate="txtAddress" ForeColor="Red" Display="Dynamic" SetFocusOnError="true" ValidationGroup="card">*</asp:RequiredFieldValidator>
                                            <asp:TextBox ID="txtAddress" runat="server" CssClass="form-control" placeholder="Địa chỉ nhận hàng"
                                                TextMode="MultiLine" ValidationGroup="card"></asp:TextBox>

                                        </div>
                                        <div class="card-footer">
                                            <asp:LinkButton ID="lbCardSubmit" runat="server" CssClass="subscribe btn btn-info btn-block shadow"
                                                ValidationGroup="card" OnClick="lbCardSubmit_Click" >Xác nhận thanh toán</asp:LinkButton>
                                        </div>
                                    </div>


                                </div>
                                <div id="paypal" class="tab-pane fade pt-3">
                                    <div class="form-group">
                                        <label for="txtCODAddress">
                                            <h6>Địa chỉ nhận hàng</h6>
                                        </label>
                                        <asp:TextBox ID="txtCODAddress" runat="server" CssClass="form-control" placeholder="Địa chỉ nhận hàng" TextMode="MultiLine"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvCODAddress" runat="server" ErrorMessage="Vui lòng nhập vào địa chỉ nhận hàng!"
                                            ControlToValidate="txtCODAddress" ForeColor="Red" Display="Dynamic" SetFocusOnError="true" ValidationGroup="cod" Font-Names="Segoe Script">*</asp:RequiredFieldValidator>
                                    </div>
                                    <p>
                                        <asp:LinkButton ID="lbCODSubmit" runat="server" CssClass="btn btn-info" ValidationGroup="cod"
                                            OnClick="lbCODSubmit_Click" ><i class="fa fa-cart-arrow-down mr-2"></i> Xác nhận đặt hàng</asp:LinkButton>
                                    </p>
                                    <p class="text-muted">
                                        Lưu ý: Khi nhận hàng quý khách phải thanh toán đầy đủ. Sau khi hoàn tất thanh toán, bạn có thể kiểm tra
                                        trạng thái đơn hàng của mình.
                                    </p>
                                </div>
                            </div>
                        </div>
                        <div class="card-footer">
                            <b class="badge badge-success badge-pill shadow-sm">Tổng tiền: <%Response.Write(Session["grandTotalPrice"]); %> VNĐ</b>
                            <div class="pt-1">
                                <asp:ValidationSummary ID="ValidationSummary1" runat="server" ForeColor="Red" ValidationGroup="card"
                                    HeaderText="Lưu ý:" Font-Names="Segoe Script" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</asp:Content>
