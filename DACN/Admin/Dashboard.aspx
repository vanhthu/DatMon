<%@ Page Title="Admin - Giao diện chính" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="DACN.Admin.Dashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="pcoded-inner-content">
        <div class="main-body">
            <div class="page-wrapper">
                <div class="page-body">
                    <div class="row">
                        <div class="col-md-6 col-xl-3">
                            <div class="card widget-card-1">
                                <div class="card-block-small">
                                    <i class="icofont icofont-muffin bg-c-green card1-icon"></i>
                                    <span class="text-c-blue f-w-600">Danh mục</span>
                                    <h4><%Response.Write(Session["category"]); %></h4>
                                    <div>
                                        <span class="f-left m-t-10 text-muted">
                                            <a href="Categories.aspx">
                                                <i class="text-c-blue f-16 icofont icofont-eye-alt m-r-10"></i>Xem chi tiết
                                            </a>
                                        </span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6 col-xl-3">
                            <div class="card widget-card-1">
                                <div class="card-block-small">
                                    <i class="icofont icofont-fast-food bg-warning card1-icon"></i>
                                    <span class="text-c-blue f-w-600">Món ăn</span>
                                    <h4><%Response.Write(Session["product"]); %></h4>
                                    <div>
                                        <span class="f-left m-t-10 text-muted">
                                            <a href="Products.aspx">
                                                <i class="text-c-blue f-16 icofont icofont-eye-alt m-r-10"></i>Xem chi tiết
                                            </a>
                                        </span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6 col-xl-3">
                            <div class="card widget-card-1">
                                <div class="card-block-small">
                                    <i class="icofont icofont-spoon-and-fork bg-c-blue card1-icon"></i>
                                    <span class="text-c-blue f-w-600">Đơn hàng</span>
                                    <h4><%Response.Write(Session["order"]); %></h4>
                                    <div>
                                        <span class="f-left m-t-10 text-muted">
                                            <a href="OrderStatus.aspx">
                                                <i class="text-c-blue f-16 icofont icofont-eye-alt m-r-10"></i>Xem chi tiết
                                            </a>
                                        </span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6 col-xl-3">
                            <div class="card widget-card-1">
                                <div class="card-block-small">
                                    <i class="icofont icofont-fast-delivery bg-c-pink card1-icon"></i>
                                    <span class="text-c-blue f-w-600">Đơn đã giao</span>
                                    <h4><%Response.Write(Session["delivery"]); %></h4>
                                    <div>
                                        <span class="f-left m-t-10 text-muted">
                                            <a href="OrderStatus.aspx">
                                                <i class="text-c-blue f-16 icofont icofont-eye-alt m-r-10"></i>Xem chi tiết
                                            </a>
                                        </span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6 col-xl-3">
                            <div class="card widget-card-1">
                                <div class="card-block-small">
                                    <i class="icofont icofont-delivery-time bg-c-blue card1-icon"></i>
                                    <span class="text-c-blue f-w-600">Đơn đang giao</span>
                                    <h4><%Response.Write(Session["pending"]); %></h4>
                                    <div>
                                        <span class="f-left m-t-10 text-muted">
                                            <a href="OrderStatus.aspx">
                                                <i class="text-c-blue f-16 icofont icofont-eye-alt m-r-10"></i>Xem chi tiết
                                            </a>
                                        </span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6 col-xl-3">
                            <div class="card widget-card-1">
                                <div class="card-block-small">
                                    <i class="icofont icofont-users-social bg-c-pink card1-icon"></i>
                                    <span class="text-c-blue f-w-600">Người dùng</span>
                                    <h4><%Response.Write(Session["user"]); %></h4>
                                    <div>
                                        <span class="f-left m-t-10 text-muted">
                                            <a href="Users.aspx">
                                                <i class="text-c-blue f-16 icofont icofont-eye-alt m-r-10"></i>Xem chi tiết
                                            </a>
                                        </span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6 col-xl-3">
                            <div class="card widget-card-1">
                                <div class="card-block-small">
                                    <i class="icofont icofont-money-bag bg-c-green card1-icon"></i>
                                    <span class="text-c-blue f-w-600">Doanh thu</span>
                                    <h4><%Response.Write(Session["soldamount"]); %>đ</h4>
                                    <div>
                                        <span class="f-left m-t-10 text-muted">
                                            <a href="Report.aspx">
                                                <i class="text-c-blue f-16 icofont icofont-eye-alt m-r-10"></i>Xem chi tiết
                                            </a>
                                        </span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6 col-xl-3">
                            <div class="card widget-card-1">
                                <div class="card-block-small">
                                    <i class="icofont icofont-support-faq bg-secondary card1-icon"></i>
                                    <span class="text-c-blue f-w-600">Phản hồi</span>
                                    <h4><%Response.Write(Session["contact"]); %></h4>
                                    <div>
                                        <span class="f-left m-t-10 text-muted">
                                            <a href="Contact.aspx">
                                                <i class="text-c-blue f-16 icofont icofont-eye-alt m-r-10"></i>Xem chi tiết
                                            </a>
                                        </span>
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
