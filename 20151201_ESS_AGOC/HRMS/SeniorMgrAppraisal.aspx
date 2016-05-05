<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/HRMS.Master"
    CodeBehind="SeniorMgrAppraisal.aspx.vb" Inherits="HRMS.SeniorMgrAppraisal" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        function Confirmation() {
            if (confirm("Do you want to confirm the changes?") == true) {
                return true;
            }
            else {
                return false;
            }
        }

        function Confirmation1() {
            if (confirm("Sure Want to Approve Document?") == true) {
                return true;
            }
            else {
                return false;
            }
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:UpdateProgress ID="UpdateProgress" runat="server">
        <ProgressTemplate>
            <asp:Image ID="Image1" ImageUrl="Images/waiting.gif" AlternateText="Processing" runat="server" />
        </ProgressTemplate>
    </asp:UpdateProgress>
    <ajx:ModalPopupExtender ID="modalPopup" runat="server" TargetControlID="UpdateProgress"
        PopupControlID="UpdateProgress" BackgroundCssClass="modalPopup" />
    <asp:UpdatePanel ID="Update" runat="server">
        <ContentTemplate>
            <table width="100%" border="0" cellspacing="0" cellpadding="4" class="main_content">
                <tr>
                    <td>
                    </td>
                </tr>
                <tr>
                    <td height="30" align="left" colspan="2" valign="bottom" background="images/h_bg.png"
                        style="border-bottom: 1px dotted; border-color: #f45501; background-repeat: repeat-x">
                        <div>
                            &nbsp;
                            <asp:Label ID="Label3" runat="server" Text="Second Level Approval" CssClass="subheader"
                                Style="float: left;"></asp:Label>
                            <span>
                                <asp:Label ID="lblNewTrip" runat="server" Text="" Visible="false"></asp:Label></span>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td align="center">
                        <table width="99%" border="0" cellspacing="0" cellpadding="4" class="main_content">
                            <tr>
                                <td>
                                    <asp:Panel ID="panelhome" runat="server" Width="100%">
                                        <asp:ImageButton ID="btnhome" runat="server" ImageUrl="~/images/Homeicon.jpg" PostBackUrl="~/Home.aspx"
                                            ToolTip="Home" />
                                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                        <asp:ImageButton ID="btnnew" runat="server" ImageUrl="~/images/Add.jpg" ToolTip="Add new record"
                                            Visible="false" />
                                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                    </asp:Panel>
                                    <asp:Label ID="Label2" runat="server" Text="" Style="color: Red;"></asp:Label>
                                    <asp:Panel ID="panelview" runat="server" Width="100%" BorderColor="LightSteelBlue"
                                        BorderWidth="2">
                                        <table width="99%" border="0" cellspacing="0" cellpadding="4" class="main_content">
                                            <tr>
                                                <td valign="top">
                                                    <ajx:TabContainer ID="TabContainer2" runat="server" ActiveTabIndex="0" CssClass="ajax__tab_yuitabview-theme"
                                                        Width="100%">
                                                        <ajx:TabPanel ID="TabPanel3" runat="server" HeaderText="Appraisal Details">
                                                            <ContentTemplate>
                                                                <table width="100%" border="0" cellspacing="0" cellpadding="3" class="main_content">
                                                                    <tr>
                                                                        <td width="3%">
                                                                            <a style="font-size: 10pt; font-weight: bold;">Search :</a>
                                                                        </td>
                                                                        <td width="3%">
                                                                            Appraisal No.
                                                                        </td>
                                                                        <td width="5%">
                                                                            <asp:TextBox ID="txtAppFrom" Width="100px" runat="server" CssClass="txtbox"></asp:TextBox>
                                                                            <ajx:TextBoxWatermarkExtender ID="TBWE1" runat="server" TargetControlID="txtAppFrom"
                                                                                WatermarkText="Appraisal Number" WatermarkCssClass="watermark" Enabled="True" />
                                                                        </td>
                                                                        <td width="3%">
                                                                            Employee Id
                                                                        </td>
                                                                        <td width="5%">
                                                                            <asp:TextBox ID="txtEmpfrom" Width="100px" runat="server" CssClass="txtbox"></asp:TextBox>
                                                                            <ajx:TextBoxWatermarkExtender ID="TBWE3" runat="server" TargetControlID="txtEmpfrom"
                                                                                WatermarkText="Employee ID" WatermarkCssClass="watermark" Enabled="True" />
                                                                        </td>
                                                                        <td width="2%">
                                                                            Period
                                                                        </td>
                                                                        <td width="5%">
                                                                            <asp:DropDownList ID="ddlsrPeriod" CssClass="txtbox1" Width="120px" runat="server">
                                                                            </asp:DropDownList>
                                                                        </td>
                                                                        <td width="2%">
                                                                            Status
                                                                        </td>
                                                                        <td width="5%">
                                                                            <asp:DropDownList ID="ddlsrStatus" CssClass="txtbox1" Width="140px" runat="server">
                                                                                <asp:ListItem Value="">---Select---</asp:ListItem>
                                                                                <asp:ListItem Value="SE">SelfApproved</asp:ListItem>
                                                                                <asp:ListItem Value="LM">LineManager Approved</asp:ListItem>
                                                                                <asp:ListItem Value="SM">Sr.Manager Approved</asp:ListItem>
                                                                                <asp:ListItem Value="HR">HR Approved</asp:ListItem>
                                                                                <asp:ListItem Value="DR">Draft</asp:ListItem>
                                                                                <asp:ListItem Value="C">HR Canceled</asp:ListItem>
                                                                            </asp:DropDownList>
                                                                        </td>
                                                                        <td width="5%">
                                                                            <asp:Button ID="btnSearch" CssClass="btn" runat="server" Text="Search" />
                                                                        </td>
                                                                        <td width="5%">
                                                                            <asp:LinkButton runat="server" ID="LnkViewall">View All</asp:LinkButton>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                                <table width="100%" border="0" cellspacing="0" cellpadding="3" class="main_content">
                                                                    <tr>
                                                                        <td>
                                                                            <asp:GridView ID="grdRequestApp" runat="server" CellPadding="4" AllowPaging="True"
                                                                                CssClass="mGrid" HeaderStyle-CssClass="GridBG" PagerStyle-CssClass="pgr" AlternatingRowStyle-CssClass="alt"
                                                                                AutoGenerateColumns="False" Width="100%" PageSize="10" ShowHeaderWhenEmpty="true"
                                                                                EmptyDataText="No records Found">
                                                                                <Columns>
                                                                                    <asp:TemplateField HeaderText="Appraisal No.">
                                                                                        <ItemTemplate>
                                                                                            <div align="center">
                                                                                                <asp:LinkButton ID="lbtndocnum" runat="server" Text='<%#Bind("DocEntry") %>' OnClick="lbtndocnum_Click"></asp:LinkButton></div>
                                                                                        </ItemTemplate>
                                                                                    </asp:TemplateField>
                                                                                    <asp:TemplateField HeaderText="Request Date">
                                                                                        <ItemTemplate>
                                                                                            <div align="left">
                                                                                                &nbsp;<asp:Label ID="lblcust" runat="server" Text='<%#Bind("U_Z_Date") %>'></asp:Label></div>
                                                                                        </ItemTemplate>
                                                                                    </asp:TemplateField>
                                                                                    <asp:TemplateField HeaderText="EmployeeId">
                                                                                        <ItemTemplate>
                                                                                            <div align="left">
                                                                                                &nbsp;<asp:Label ID="lblcustName" runat="server" Text='<%#Bind("U_Z_EmpId") %>'></asp:Label></div>
                                                                                        </ItemTemplate>
                                                                                    </asp:TemplateField>
                                                                                    <asp:TemplateField HeaderText="Employee Name">
                                                                                        <ItemTemplate>
                                                                                            <div align="left">
                                                                                                &nbsp;<asp:Label ID="lblitem" runat="server" Text='<%#Bind("U_Z_EmpName") %>'></asp:Label></div>
                                                                                        </ItemTemplate>
                                                                                    </asp:TemplateField>
                                                                                    <asp:TemplateField HeaderText="Period" Visible="false">
                                                                                        <ItemTemplate>
                                                                                            <div align="left">
                                                                                                &nbsp;<asp:Label ID="lblPeriod" runat="server" Text='<%#Bind("U_Z_Period") %>'></asp:Label>
                                                                                            </div>
                                                                                        </ItemTemplate>
                                                                                    </asp:TemplateField>
                                                                                    <asp:TemplateField HeaderText="Period Desc" Visible="false">
                                                                                        <ItemTemplate>
                                                                                            <div align="left">
                                                                                                &nbsp;<asp:Label ID="lblPerioddesc" runat="server" Text='<%#Bind("U_Z_PerDesc") %>'></asp:Label>
                                                                                            </div>
                                                                                        </ItemTemplate>
                                                                                    </asp:TemplateField>
                                                                                    <asp:TemplateField HeaderText="Period From">
                                                                                        <ItemTemplate>
                                                                                            <div align="left">
                                                                                                &nbsp;<asp:Label ID="lblPeriodFr" runat="server" Text='<%#Bind("U_Z_PerFrom") %>'></asp:Label>
                                                                                            </div>
                                                                                        </ItemTemplate>
                                                                                    </asp:TemplateField>
                                                                                    <asp:TemplateField HeaderText="Period To">
                                                                                        <ItemTemplate>
                                                                                            <div align="left">
                                                                                                &nbsp;<asp:Label ID="lblPeriodto" runat="server" Text='<%#Bind("U_Z_PerTo") %>'></asp:Label>
                                                                                            </div>
                                                                                        </ItemTemplate>
                                                                                    </asp:TemplateField>
                                                                                    <asp:TemplateField HeaderText="Active" Visible="false">
                                                                                        <ItemTemplate>
                                                                                            <div align="center">
                                                                                                &nbsp;<asp:Label ID="lblserial" runat="server" Text='<%#Bind("U_Z_Status") %>'></asp:Label></div>
                                                                                        </ItemTemplate>
                                                                                    </asp:TemplateField>
                                                                                    <asp:TemplateField HeaderText="Status">
                                                                                        <ItemTemplate>
                                                                                            <div align="center">
                                                                                                &nbsp;<asp:Label ID="lblstatus" runat="server" Text='<%#Bind("U_Z_WStatus") %>'></asp:Label></div>
                                                                                        </ItemTemplate>
                                                                                    </asp:TemplateField>
                                                                                </Columns>
                                                                                <HeaderStyle HorizontalAlign="Center" Height="25px" BackColor="#CCCCCC" />
                                                                            </asp:GridView>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </ContentTemplate>
                                                        </ajx:TabPanel>
                                                    </ajx:TabContainer>
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                                    <asp:Panel ID="panelnew" runat="server" Width="100%">
                                        <div class="DivCorner" style="border: solid 2px LightSteelBlue; width: 100%;">
                                            <table width="100%" border="0" cellspacing="0" cellpadding="4" class="main_content">
                                                <tr>
                                                    <td width="20%">
                                                        Appraisal Number
                                                    </td>
                                                    <td width="15%">
                                                        <asp:TextBox ID="txtAppno" CssClass="txtbox" Width="150px" ReadOnly="true" runat="server"></asp:TextBox>
                                                    </td>
                                                    <td width="10%">
                                                    </td>
                                                    <td width="20%">
                                                        Request Date
                                                    </td>
                                                    <td width="15%">
                                                        <asp:TextBox ID="txtreqdate" CssClass="txtbox" Width="150px" ReadOnly="true" runat="server"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td width="10%">
                                                        Employee Id
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtempid" CssClass="txtbox" Width="150px" ReadOnly="true" runat="server"></asp:TextBox>
                                                    </td>
                                                    <td width="15%">
                                                    </td>
                                                    <td width="10%">
                                                        Employee Name
                                                    </td>
                                                    <td width="30%">
                                                        <asp:TextBox ID="txtempname" CssClass="txtbox" Width="150px" ReadOnly="true" runat="server"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td width="10%">
                                                        Period From
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="lblPeriodfrom" CssClass="txtbox" Width="150px" runat="server"></asp:Label>
                                                    </td>
                                                    <td width="15%">
                                                    </td>
                                                    <td width="10%">
                                                        Period To
                                                    </td>
                                                    <td width="30%">
                                                        <asp:Label ID="lblperioTo" CssClass="txtbox" Width="150px" runat="server"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td width="10%">
                                                    </td>
                                                    <td>
                                                        <asp:DropDownList ID="ddlperiod" CssClass="txtbox1" Width="120px" runat="server"
                                                            Visible="false">
                                                        </asp:DropDownList>
                                                    </td>
                                                    <td width="15%">
                                                    </td>
                                                    <td width="10%">
                                                        Status
                                                    </td>
                                                    <td width="30%">
                                                        <asp:DropDownList ID="ddlstatus" CssClass="txtbox1" Width="150px" runat="server"
                                                            Enabled="false">
                                                            <asp:ListItem Value="SE">SelfApproved</asp:ListItem>
                                                            <asp:ListItem Value="LM">LineManager Approved</asp:ListItem>
                                                            <asp:ListItem Value="SM">Sr.Manager Approved</asp:ListItem>
                                                            <asp:ListItem Value="HR">HR Approved</asp:ListItem>
                                                            <asp:ListItem Value="DR">Draft</asp:ListItem>
                                                            <asp:ListItem Value="C">HR Canceled</asp:ListItem>
                                                        </asp:DropDownList>
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                        <asp:Panel ID="paltab" runat="server" Width="100%" BorderColor="LightSteelBlue" BorderWidth="2">
                                            <table width="99%" border="0" cellspacing="0" cellpadding="4" class="main_content">
                                                <tr>
                                                    <td valign="top">
                                                        <ajx:TabContainer ID="TabContainer1" runat="server" ActiveTabIndex="0" CssClass="ajax__tab_yuitabview-theme"
                                                            Width="100%">
                                                            <ajx:TabPanel ID="TabPanel1" runat="server" HeaderText="Business Objectives">
                                                                <ContentTemplate>
                                                                    <table width="100%" border="0" cellspacing="0" cellpadding="3" class="main_content">
                                                                        <tr>
                                                                            <td colspan="4">
                                                                                <div style="overflow-x: auto; width: 1100px;">
                                                                                    <asp:GridView ID="grdBusinessView" runat="server" CellPadding="4" AllowPaging="True"
                                                                                        CssClass="mGrid" HeaderStyle-CssClass="GridBG" ShowHeaderWhenEmpty="true" EmptyDataText="No records Found"
                                                                                        PagerStyle-CssClass="pgr" AlternatingRowStyle-CssClass="alt" ShowFooter="True"
                                                                                        AutoGenerateColumns="False" Width="100%" PageSize="10">
                                                                                        <Columns>
                                                                                            <asp:TemplateField HeaderText="Code" Visible="false">
                                                                                                <ItemTemplate>
                                                                                                    <div align="center">
                                                                                                        <asp:Label ID="lbbudocnum1" runat="server" Text='<%#Bind("U_Z_BussCode") %>'></asp:Label></div>
                                                                                                </ItemTemplate>
                                                                                            </asp:TemplateField>
                                                                                            <asp:TemplateField HeaderText="Business Objectives">
                                                                                                <ItemTemplate>
                                                                                                    <div align="left">
                                                                                                        &nbsp;<asp:Label ID="lblbussname1" runat="server" Text='<%#Bind("U_Z_BussDesc") %>'></asp:Label></div>
                                                                                                </ItemTemplate>
                                                                                                <FooterTemplate>
                                                                                                    <div align="right">
                                                                                                        <asp:Label ID="lblpay4" runat="server" Text="Total(%)"></asp:Label>&nbsp;&nbsp;</div>
                                                                                                </FooterTemplate>
                                                                                            </asp:TemplateField>
                                                                                            <asp:TemplateField HeaderText="Weight(%)">
                                                                                                <ItemTemplate>
                                                                                                    <div align="Right">
                                                                                                        &nbsp;<asp:Label ID="lblweight1" runat="server" Text='<%#Bind("U_Z_BussWeight") %>'></asp:Label></div>
                                                                                                </ItemTemplate>
                                                                                                <FooterTemplate>
                                                                                                    <div align="right">
                                                                                                        <asp:Label ID="lblBselfweight" runat="server"></asp:Label>&nbsp;</div>
                                                                                                </FooterTemplate>
                                                                                            </asp:TemplateField>
                                                                                            <asp:TemplateField HeaderText="Self Rating">
                                                                                                <ItemTemplate>
                                                                                                    <div align="left">
                                                                                                        &nbsp;<asp:DropDownList ID="ddlbusselfrate" runat="server" Enabled="false">
                                                                                                        </asp:DropDownList>
                                                                                                    </div>
                                                                                                </ItemTemplate>
                                                                                                <FooterTemplate>
                                                                                                    <div align="right">
                                                                                                        <asp:Label ID="lblBselfgrd" runat="server" Text="Self Grade :"></asp:Label>&nbsp;</div>
                                                                                                </FooterTemplate>
                                                                                            </asp:TemplateField>
                                                                                            <asp:TemplateField HeaderText="Self Remarks">
                                                                                                <ItemTemplate>
                                                                                                    <div align="left">
                                                                                                        &nbsp;
                                                                                                        <asp:LinkButton ID="lblBSelfRemark" runat="server" Text="View Remarks" ToolTip='<%#Bind("U_Z_SelfRemark") %>'
                                                                                                            CssClass="txtbox"></asp:LinkButton>
                                                                                                    </div>
                                                                                                </ItemTemplate>
                                                                                                <FooterTemplate>
                                                                                                    <div align="left">
                                                                                                        <asp:Label ID="lblBselfgrade" runat="server"></asp:Label>&nbsp;</div>
                                                                                                </FooterTemplate>
                                                                                            </asp:TemplateField>
                                                                                            <asp:TemplateField HeaderText="Self Grade" Visible="false">
                                                                                                <ItemTemplate>
                                                                                                    <div align="left">
                                                                                                        &nbsp;
                                                                                                        <asp:Label ID="lblBselGrd" runat="server" Text='<%#Bind("U_Z_BussSelfGrade") %>'
                                                                                                            CssClass="txtbox"></asp:Label>
                                                                                                    </div>
                                                                                                </ItemTemplate>
                                                                                            </asp:TemplateField>
                                                                                            <asp:TemplateField HeaderText="Self Rating" Visible="false">
                                                                                                <ItemTemplate>
                                                                                                    <div align="left">
                                                                                                        &nbsp;<asp:Label ID="lblbusselfrate" runat="server" Text='<%#Bind("U_Z_SelfRaCode") %>'
                                                                                                            Visible="false"></asp:Label></div>
                                                                                                    <div align="Right">
                                                                                                        &nbsp;<asp:Label ID="lblbusself1" runat="server" Text='<%#Bind("U_Z_BussSelfRate") %>'></asp:Label></div>
                                                                                                </ItemTemplate>
                                                                                                <FooterTemplate>
                                                                                                    <div align="right">
                                                                                                        <asp:Label ID="lblBselfrate" runat="server"></asp:Label>&nbsp;</div>
                                                                                                </FooterTemplate>
                                                                                            </asp:TemplateField>
                                                                                            <asp:TemplateField HeaderText="First Level Manager Rating">
                                                                                                <ItemTemplate>
                                                                                                    <div align="left">
                                                                                                        &nbsp;<asp:DropDownList ID="ddlbusmgrfrate" runat="server" Enabled="false">
                                                                                                        </asp:DropDownList>
                                                                                                    </div>
                                                                                                </ItemTemplate>
                                                                                                <FooterTemplate>
                                                                                                    <div align="right">
                                                                                                        <asp:Label ID="lblBmgrgrd" runat="server" Text="First Level Manager Grade :"></asp:Label>&nbsp;</div>
                                                                                                </FooterTemplate>
                                                                                            </asp:TemplateField>
                                                                                            <asp:TemplateField HeaderText="First Level Manager Remarks">
                                                                                                <ItemTemplate>
                                                                                                    <div align="left">
                                                                                                        &nbsp;
                                                                                                        <asp:LinkButton ID="lblBstmgremark" runat="server" Text="View Remarks" ToolTip='<%#Bind("U_Z_MgrRemark") %>'
                                                                                                            CssClass="txtbox" Width="100"></asp:LinkButton>
                                                                                                    </div>
                                                                                                </ItemTemplate>
                                                                                                <FooterTemplate>
                                                                                                    <div align="left">
                                                                                                        <asp:Label ID="lblBMgrgrade" runat="server"></asp:Label>&nbsp;</div>
                                                                                                </FooterTemplate>
                                                                                            </asp:TemplateField>
                                                                                            <asp:TemplateField HeaderText="First Level Manager Grade" Visible="false">
                                                                                                <ItemTemplate>
                                                                                                    <div align="left">
                                                                                                        &nbsp;
                                                                                                        <asp:Label ID="lblBmgrGrd" runat="server" Text='<%#Bind("U_Z_BussMgrGrade") %>' CssClass="txtbox"></asp:Label>
                                                                                                    </div>
                                                                                                </ItemTemplate>
                                                                                            </asp:TemplateField>
                                                                                            <asp:TemplateField HeaderText="Line Manager Rating" Visible="false">
                                                                                                <ItemTemplate>
                                                                                                    <div align="left">
                                                                                                        &nbsp;<asp:Label ID="lblbusmgrfrate" runat="server" Text='<%#Bind("U_Z_MgrRaCode") %>'
                                                                                                            Visible="false"></asp:Label></div>
                                                                                                    <div align="Right">
                                                                                                        &nbsp;<asp:Label ID="lblmgrrate1" runat="server" Text='<%#Bind("U_Z_BussMgrRate") %>'></asp:Label></div>
                                                                                                </ItemTemplate>
                                                                                                <FooterTemplate>
                                                                                                    <div align="right">
                                                                                                        <asp:Label ID="lblBLinerate" runat="server"></asp:Label>&nbsp;</div>
                                                                                                </FooterTemplate>
                                                                                            </asp:TemplateField>
                                                                                            <asp:TemplateField HeaderText="Second Level Manager Rating">
                                                                                                <ItemTemplate>
                                                                                                    <div align="left">
                                                                                                        &nbsp;<asp:DropDownList ID="ddlsmgrfrate" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlsmgrfrate_SelectedIndexChanged"
                                                                                                            EnableViewState="true">
                                                                                                        </asp:DropDownList>
                                                                                                    </div>
                                                                                                </ItemTemplate>
                                                                                                <FooterTemplate>
                                                                                                    <div align="right">
                                                                                                        <asp:Label ID="lblBsmgrgrd" runat="server" Text="Second Level Manager Grade :"></asp:Label>&nbsp;</div>
                                                                                                </FooterTemplate>
                                                                                            </asp:TemplateField>
                                                                                            <asp:TemplateField HeaderText="Second Level Manager Remarks">
                                                                                                <ItemTemplate>
                                                                                                    <div align="left">
                                                                                                        &nbsp;
                                                                                                        <asp:TextBox ID="txtBfstmgrRemarks" runat="server" Text='<%#Bind("U_Z_SrRemark") %>'
                                                                                                            TextMode="MultiLine" CssClass="txtbox" Width="100"></asp:TextBox>
                                                                                                    </div>
                                                                                                </ItemTemplate>
                                                                                                <FooterTemplate>
                                                                                                    <div align="left">
                                                                                                        <asp:Label ID="lblBSMgrgrade" runat="server"></asp:Label>&nbsp;</div>
                                                                                                </FooterTemplate>
                                                                                            </asp:TemplateField>
                                                                                            <asp:TemplateField HeaderText="Second Level Manager Grade" Visible="false">
                                                                                                <ItemTemplate>
                                                                                                    <div align="left">
                                                                                                        &nbsp;
                                                                                                        <asp:Label ID="lblBsmgrGrd" runat="server" Text='<%#Bind("U_Z_BussSMGrade") %>' CssClass="txtbox"></asp:Label>
                                                                                                    </div>
                                                                                                </ItemTemplate>
                                                                                            </asp:TemplateField>
                                                                                            <asp:TemplateField HeaderText="Senior Manager Rating" Visible="false">
                                                                                                <ItemTemplate>
                                                                                                    <div align="left">
                                                                                                        &nbsp;<asp:Label ID="lblsmgrfrate" runat="server" Text='<%#Bind("U_Z_SMRaCode") %>'
                                                                                                            Visible="false"></asp:Label></div>
                                                                                                    <div align="Right">
                                                                                                        &nbsp;<asp:Label ID="lblsrmgrrate1" runat="server" Text='<%#Bind("U_Z_BussSMRate") %>'></asp:Label></div>
                                                                                                </ItemTemplate>
                                                                                                <FooterTemplate>
                                                                                                    <div align="right">
                                                                                                        <asp:Label ID="lblBsrrate" runat="server"></asp:Label>&nbsp;</div>
                                                                                                </FooterTemplate>
                                                                                            </asp:TemplateField>
                                                                                            <asp:TemplateField HeaderText="Code" Visible="false">
                                                                                                <ItemTemplate>
                                                                                                    <div align="center">
                                                                                                        &nbsp;<asp:Label ID="lblbusCode1" runat="server" Text='<%#Bind("LineId") %>'></asp:Label></div>
                                                                                                </ItemTemplate>
                                                                                            </asp:TemplateField>
                                                                                        </Columns>
                                                                                        <HeaderStyle HorizontalAlign="Center" Height="25px" BackColor="#CCCCCC" />
                                                                                          <FooterStyle Font-Bold="true"  />
                                                                                    </asp:GridView>
                                                                                </div>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                                Self Remarks
                                                                            </td>
                                                                            <td>
                                                                                <asp:TextBox ID="txtsBremarks" CssClass="txtbox" Width="200px" TextMode="MultiLine"
                                                                                    Height="40px" runat="server" Enabled="false"></asp:TextBox>
                                                                            </td>
                                                                            <td>
                                                                                Sr.Manager Remarks
                                                                            </td>
                                                                            <td>
                                                                                <asp:TextBox ID="txtBSrremarks" CssClass="txtbox" Width="200px" TextMode="MultiLine"
                                                                                    Height="40px" runat="server"></asp:TextBox>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                                Line Manager Remarks
                                                                            </td>
                                                                            <td>
                                                                                <asp:TextBox ID="txtBLmremarks" CssClass="txtbox" Width="200px" TextMode="MultiLine"
                                                                                    Height="40px" runat="server" Enabled="false"></asp:TextBox>
                                                                            </td>
                                                                            <td>
                                                                                HR Remarks
                                                                            </td>
                                                                            <td>
                                                                                <asp:TextBox ID="txtBCHrremarks" CssClass="txtbox" Width="200px" TextMode="MultiLine"
                                                                                    Height="40px" runat="server" Enabled="false"></asp:TextBox>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </ContentTemplate>
                                                            </ajx:TabPanel>
                                                            <ajx:TabPanel ID="TabPanel2" runat="server" HeaderText="Personal Objectives">
                                                                <ContentTemplate>
                                                                    <table width="100%" border="0" cellspacing="0" cellpadding="4" class="main_content">
                                                                        <tr>
                                                                            <td colspan="4">
                                                                                <div style="overflow-x: auto; width: 1100px;">
                                                                                    <asp:GridView ID="grdPeopleview" runat="server" CellPadding="4" AllowPaging="True"
                                                                                        CssClass="mGrid" HeaderStyle-CssClass="GridBG" ShowHeaderWhenEmpty="true" EmptyDataText="No records Found"
                                                                                        PagerStyle-CssClass="pgr" AlternatingRowStyle-CssClass="alt" ShowFooter="True"
                                                                                        Visible="false" AutoGenerateColumns="False" Width="100%" PageSize="10">
                                                                                        <Columns>
                                                                                            <asp:TemplateField HeaderText="Code" Visible="false">
                                                                                                <ItemTemplate>
                                                                                                    <div align="center">
                                                                                                        <asp:Label ID="lbtpedocnum1" runat="server" Text='<%#Bind("U_Z_PeopleCode") %>'></asp:Label></div>
                                                                                                </ItemTemplate>
                                                                                            </asp:TemplateField>
                                                                                            <asp:TemplateField HeaderText="Personal Objectives">
                                                                                                <ItemTemplate>
                                                                                                    <div align="left">
                                                                                                        &nbsp;<asp:Label ID="lblpeoname1" runat="server" Text='<%#Bind("U_Z_PeopleDesc") %>'></asp:Label></div>
                                                                                                </ItemTemplate>
                                                                                            </asp:TemplateField>
                                                                                            <asp:TemplateField HeaderText="Category">
                                                                                                <ItemTemplate>
                                                                                                    <div align="left">
                                                                                                        &nbsp;<asp:Label ID="lblcate1" runat="server" Text='<%#Bind("U_Z_PeopleCat") %>'
                                                                                                            Visible="false"></asp:Label></div>
                                                                                                    <div align="left">
                                                                                                        &nbsp;<asp:Label ID="Label1" runat="server" Text='<%#Bind("U_Z_CatName") %>'></asp:Label></div>
                                                                                                </ItemTemplate>
                                                                                                <FooterTemplate>
                                                                                                    <div align="right">
                                                                                                        <asp:Label ID="lblPPay" runat="server" Text="Total(%)"></asp:Label>&nbsp;&nbsp;</div>
                                                                                                </FooterTemplate>
                                                                                            </asp:TemplateField>
                                                                                            <asp:TemplateField HeaderText="Weight(%)">
                                                                                                <ItemTemplate>
                                                                                                    <div align="Right">
                                                                                                        &nbsp;<asp:Label ID="lblpeweight1" runat="server" Text='<%#Bind("U_Z_PeoWeight") %>'></asp:Label></div>
                                                                                                </ItemTemplate>
                                                                                                <FooterTemplate>
                                                                                                    <div align="right">
                                                                                                        <asp:Label ID="lblPselfweight" runat="server"></asp:Label>&nbsp;</div>
                                                                                                </FooterTemplate>
                                                                                            </asp:TemplateField>
                                                                                            <asp:TemplateField HeaderText="Self Rating">
                                                                                                <ItemTemplate>
                                                                                                    <div align="left">
                                                                                                        &nbsp;<asp:DropDownList ID="ddlpeselfrate" runat="server" Enabled="false">
                                                                                                        </asp:DropDownList>
                                                                                                    </div>
                                                                                                </ItemTemplate>
                                                                                                <FooterTemplate>
                                                                                                    <div align="right">
                                                                                                        <asp:Label ID="lblPselfgr" runat="server" Text="Self Grade :"></asp:Label>&nbsp;</div>
                                                                                                </FooterTemplate>
                                                                                            </asp:TemplateField>
                                                                                            <asp:TemplateField HeaderText="Self Remarks">
                                                                                                <ItemTemplate>
                                                                                                    <div align="left">
                                                                                                        &nbsp;
                                                                                                        <asp:LinkButton ID="lblPSelfRemark" runat="server" Text="View Remarks" ToolTip='<%#Bind("U_Z_SelfRemark") %>'
                                                                                                            CssClass="txtbox"></asp:LinkButton>
                                                                                                    </div>
                                                                                                </ItemTemplate>
                                                                                                <FooterTemplate>
                                                                                                    <div align="left">
                                                                                                        <asp:Label ID="lblPselfgrade" runat="server"></asp:Label>&nbsp;</div>
                                                                                                </FooterTemplate>
                                                                                            </asp:TemplateField>
                                                                                            <asp:TemplateField HeaderText="Self Grade" Visible="false">
                                                                                                <ItemTemplate>
                                                                                                    <div align="left">
                                                                                                        &nbsp;
                                                                                                        <asp:Label ID="lblPselGrd" runat="server" Text='<%#Bind("U_Z_PeoSelfGrade") %>' CssClass="txtbox"></asp:Label>
                                                                                                    </div>
                                                                                                </ItemTemplate>
                                                                                            </asp:TemplateField>
                                                                                            <asp:TemplateField HeaderText="Self Rating" Visible="false">
                                                                                                <ItemTemplate>
                                                                                                    <div align="left">
                                                                                                        &nbsp;<asp:Label ID="lblpeselfrate" runat="server" Text='<%#Bind("U_Z_SelfRaCode") %>'
                                                                                                            Visible="false"></asp:Label></div>
                                                                                                    <div align="right">
                                                                                                        &nbsp;<asp:Label ID="lblpeselfrate1" runat="server" Text='<%#Bind("U_Z_PeoSelfRate") %>'></asp:Label></div>
                                                                                                </ItemTemplate>
                                                                                                <FooterTemplate>
                                                                                                    <div align="right">
                                                                                                        <asp:Label ID="lblPselfrate" runat="server"></asp:Label>&nbsp;</div>
                                                                                                </FooterTemplate>
                                                                                            </asp:TemplateField>
                                                                                            <asp:TemplateField HeaderText="First Level Manager Rating">
                                                                                                <ItemTemplate>
                                                                                                    <div align="left">
                                                                                                        &nbsp;<asp:DropDownList ID="ddlpesmgrfrate" runat="server" Enabled="false">
                                                                                                        </asp:DropDownList>
                                                                                                    </div>
                                                                                                </ItemTemplate>
                                                                                                <FooterTemplate>
                                                                                                    <div align="right">
                                                                                                        <asp:Label ID="lblPMgrgr" runat="server" Text="First Level Manager Grade :"></asp:Label>&nbsp;</div>
                                                                                                </FooterTemplate>
                                                                                            </asp:TemplateField>
                                                                                            <asp:TemplateField HeaderText="First Level Manager Remarks">
                                                                                                <ItemTemplate>
                                                                                                    <div align="left">
                                                                                                        &nbsp;
                                                                                                        <asp:LinkButton ID="lblPSecoMgrRemark" runat="server" Text="View Remarks" ToolTip='<%#Bind("U_Z_MgrRemark") %>'
                                                                                                            CssClass="txtbox"></asp:LinkButton>
                                                                                                    </div>
                                                                                                </ItemTemplate>
                                                                                                <FooterTemplate>
                                                                                                    <div align="left">
                                                                                                        <asp:Label ID="lblPMgrgrade" runat="server"></asp:Label>&nbsp;</div>
                                                                                                </FooterTemplate>
                                                                                            </asp:TemplateField>
                                                                                            <asp:TemplateField HeaderText="First Level Manager Grade" Visible="false">
                                                                                                <ItemTemplate>
                                                                                                    <div align="left">
                                                                                                        &nbsp;
                                                                                                        <asp:Label ID="lblPMgrGrd" runat="server" Text='<%#Bind("U_Z_PeoMgrGrade") %>' CssClass="txtbox"></asp:Label>
                                                                                                    </div>
                                                                                                </ItemTemplate>
                                                                                            </asp:TemplateField>
                                                                                            <asp:TemplateField HeaderText="Line Manager Rating" Visible="false">
                                                                                                <ItemTemplate>
                                                                                                    <div align="left">
                                                                                                        &nbsp;<asp:Label ID="lblpesmgrfrate" runat="server" Text='<%#Bind("U_Z_MgrRaCode") %>'
                                                                                                            Visible="false"></asp:Label></div>
                                                                                                    <div align="right">
                                                                                                        &nbsp;<asp:Label ID="lblpemgrrate1" runat="server" Text='<%#Bind("U_Z_PeoMgrRate") %>'></asp:Label></div>
                                                                                                </ItemTemplate>
                                                                                                <FooterTemplate>
                                                                                                    <div align="right">
                                                                                                        <asp:Label ID="lblPLinerate" runat="server"></asp:Label>&nbsp;</div>
                                                                                                </FooterTemplate>
                                                                                            </asp:TemplateField>
                                                                                            <asp:TemplateField HeaderText="Second Level Manager Rating">
                                                                                                <ItemTemplate>
                                                                                                    <div align="left">
                                                                                                        &nbsp;<asp:DropDownList ID="ddlsmgrrate" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlpesmgrfrate_SelectedIndexChanged"
                                                                                                            EnableViewState="true">
                                                                                                        </asp:DropDownList>
                                                                                                    </div>
                                                                                                </ItemTemplate>
                                                                                                <FooterTemplate>
                                                                                                    <div align="right">
                                                                                                        <asp:Label ID="lblPSMMgrgr" runat="server" Text="Second Level Manager Grade :"></asp:Label>&nbsp;</div>
                                                                                                </FooterTemplate>
                                                                                            </asp:TemplateField>
                                                                                            <asp:TemplateField HeaderText="Second Level Manager Remarks">
                                                                                                <ItemTemplate>
                                                                                                    <div align="left">
                                                                                                        &nbsp;
                                                                                                        <asp:TextBox ID="txtPfstmgrRemarks" runat="server" Text='<%#Bind("U_Z_SrRemark") %>'
                                                                                                            CssClass="txtbox" Width="100"></asp:TextBox>
                                                                                                    </div>
                                                                                                </ItemTemplate>
                                                                                                <FooterTemplate>
                                                                                                    <div align="left">
                                                                                                        <asp:Label ID="lblPSMMgrgrade" runat="server"></asp:Label>&nbsp;</div>
                                                                                                </FooterTemplate>
                                                                                            </asp:TemplateField>
                                                                                            <asp:TemplateField HeaderText="Second Level Manager Grade" Visible="false">
                                                                                                <ItemTemplate>
                                                                                                    <div align="left">
                                                                                                        &nbsp;
                                                                                                        <asp:Label ID="lblPsmgrGrd" runat="server" Text='<%#Bind("U_Z_PeoSMGrade") %>' CssClass="txtbox"></asp:Label>
                                                                                                    </div>
                                                                                                </ItemTemplate>
                                                                                            </asp:TemplateField>
                                                                                            <asp:TemplateField HeaderText="Senior Manager Rating" Visible="false">
                                                                                                <ItemTemplate>
                                                                                                    <div align="left">
                                                                                                        &nbsp;<asp:Label ID="lblsmgrrate" runat="server" Text='<%#Bind("U_Z_SMRaCode") %>'
                                                                                                            Visible="false"></asp:Label></div>
                                                                                                    <div align="right">
                                                                                                        &nbsp;<asp:Label ID="lblsrmgrrate" runat="server" Text='<%#Bind("U_Z_PeoSMRate") %>'></asp:Label></div>
                                                                                                </ItemTemplate>
                                                                                                <FooterTemplate>
                                                                                                    <div align="right">
                                                                                                        <asp:Label ID="lblPsrrate" runat="server"></asp:Label>&nbsp;</div>
                                                                                                </FooterTemplate>
                                                                                            </asp:TemplateField>
                                                                                            <asp:TemplateField HeaderText="Code" Visible="false">
                                                                                                <ItemTemplate>
                                                                                                    <div align="center">
                                                                                                        &nbsp;<asp:Label ID="lblpecode1" runat="server" Text='<%#Bind("LineId") %>'></asp:Label></div>
                                                                                                </ItemTemplate>
                                                                                            </asp:TemplateField>
                                                                                        </Columns>
                                                                                        <HeaderStyle HorizontalAlign="Center" Height="25px" BackColor="#CCCCCC" />
                                                                                          <FooterStyle Font-Bold="true"  />
                                                                                    </asp:GridView>
                                                                                </div>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                                Self Remarks
                                                                            </td>
                                                                            <td>
                                                                                <asp:TextBox ID="txtsPremarks" CssClass="txtbox" Width="200px" TextMode="MultiLine"
                                                                                    Height="40px" runat="server" Enabled="false"></asp:TextBox>
                                                                            </td>
                                                                            <td width="20%">
                                                                                Sr.Manager Remarks
                                                                            </td>
                                                                            <td>
                                                                                <asp:TextBox ID="txtPSrremarks" CssClass="txtbox" Width="200px" TextMode="MultiLine"
                                                                                    Height="40px" runat="server"></asp:TextBox>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td width="20%">
                                                                                Line Manager Remarks
                                                                            </td>
                                                                            <td>
                                                                                <asp:TextBox ID="txtPLmremarks" CssClass="txtbox" Width="200px" TextMode="MultiLine"
                                                                                    Height="40px" runat="server" Enabled="false"></asp:TextBox>
                                                                            </td>
                                                                            <td>
                                                                                HR Remarks
                                                                            </td>
                                                                            <td>
                                                                                <asp:TextBox ID="txtPHrremarks" CssClass="txtbox" Width="200px" TextMode="MultiLine"
                                                                                    Height="40px" runat="server" Enabled="false"></asp:TextBox>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </ContentTemplate>
                                                            </ajx:TabPanel>
                                                            <ajx:TabPanel ID="TabPanel4" runat="server" HeaderText="Competences">
                                                                <ContentTemplate>
                                                                    <table width="100%" border="0" cellspacing="0" cellpadding="4" class="main_content">
                                                                        <tr>
                                                                            <td colspan="4">
                                                                                <div style="overflow-x: auto; width: 1100px;">
                                                                                    <asp:GridView ID="grdCompetenceview" runat="server" CellPadding="4" AllowPaging="True"
                                                                                        CssClass="mGrid" HeaderStyle-CssClass="GridBG" PagerStyle-CssClass="pgr" AlternatingRowStyle-CssClass="alt"
                                                                                        ShowFooter="True" AutoGenerateColumns="False" Width="100%" PageSize="10" Visible="false"
                                                                                        ShowHeaderWhenEmpty="true" EmptyDataText="No records Found">
                                                                                        <Columns>
                                                                                            <asp:TemplateField HeaderText="Code" Visible="false">
                                                                                                <ItemTemplate>
                                                                                                    <div align="center">
                                                                                                        <asp:Label ID="lbcomdocnum1" runat="server" Text='<%#Bind("U_Z_CompCode") %>'></asp:Label></div>
                                                                                                </ItemTemplate>
                                                                                            </asp:TemplateField>
                                                                                            <asp:TemplateField HeaderText="Competences Description">
                                                                                                <ItemTemplate>
                                                                                                    <div align="left">
                                                                                                        &nbsp;<asp:Label ID="lblCompname1" runat="server" Text='<%#Bind("U_Z_CompDesc") %>'></asp:Label></div>
                                                                                                </ItemTemplate>
                                                                                            </asp:TemplateField>
                                                                                            <asp:TemplateField HeaderText="Levels">
                                                                                                <ItemTemplate>
                                                                                                    <div align="left">
                                                                                                        &nbsp;<asp:Label ID="lblCompLevel" runat="server" Text='<%#Bind("U_Z_CompLevel") %>'></asp:Label></div>
                                                                                                </ItemTemplate>
                                                                                            </asp:TemplateField>
                                                                                            <asp:TemplateField HeaderText="Current Level">
                                                                                                <ItemTemplate>
                                                                                                    <div align="left">
                                                                                                        &nbsp;<asp:Label ID="lblCurrLevel" runat="server" Text='<%#Bind("CurrentLevel") %>'></asp:Label></div>
                                                                                                </ItemTemplate>
                                                                                                <FooterTemplate>
                                                                                                    <div align="right">
                                                                                                        <asp:Label ID="lblCPay" runat="server" Text="Total(%)"></asp:Label>&nbsp;&nbsp;</div>
                                                                                                </FooterTemplate>
                                                                                            </asp:TemplateField>
                                                                                            <asp:TemplateField HeaderText="Weight(%)">
                                                                                                <ItemTemplate>
                                                                                                    <div align="right">
                                                                                                        &nbsp;<asp:Label ID="lblCompWeight1" runat="server" Text='<%#Bind("U_Z_CompWeight") %>'></asp:Label></div>
                                                                                                </ItemTemplate>
                                                                                                <FooterTemplate>
                                                                                                    <div align="right">
                                                                                                        <asp:Label ID="lblCselfweight" runat="server"></asp:Label>&nbsp;</div>
                                                                                                </FooterTemplate>
                                                                                            </asp:TemplateField>
                                                                                            <asp:TemplateField HeaderText="Self Rating">
                                                                                                <ItemTemplate>
                                                                                                    <div align="left">
                                                                                                        &nbsp;<asp:DropDownList ID="ddlcompselfrate" runat="server" Enabled="false">
                                                                                                        </asp:DropDownList>
                                                                                                    </div>
                                                                                                </ItemTemplate>
                                                                                                <FooterTemplate>
                                                                                                    <div align="right">
                                                                                                        <asp:Label ID="lblCselfgrd" runat="server" Text="Self Grade :"></asp:Label>&nbsp;</div>
                                                                                                </FooterTemplate>
                                                                                            </asp:TemplateField>
                                                                                            <asp:TemplateField HeaderText="Self Remarks">
                                                                                                <ItemTemplate>
                                                                                                    <div align="left">
                                                                                                        &nbsp;
                                                                                                        <asp:LinkButton ID="lblCSelfRemark" runat="server" ToolTip='<%#Bind("U_Z_SelfRemark") %>'
                                                                                                            Text="View Remarks" CssClass="txtbox"></asp:LinkButton>
                                                                                                    </div>
                                                                                                </ItemTemplate>
                                                                                                <FooterTemplate>
                                                                                                    <div align="left">
                                                                                                        <asp:Label ID="lblCselfgrade" runat="server"></asp:Label>&nbsp;</div>
                                                                                                </FooterTemplate>
                                                                                            </asp:TemplateField>
                                                                                            <asp:TemplateField HeaderText="Self Grade" Visible="false">
                                                                                                <ItemTemplate>
                                                                                                    <div align="left">
                                                                                                        &nbsp;
                                                                                                        <asp:Label ID="lblCSelfGrd" runat="server" Text='<%#Bind("U_Z_CompSelfGrade") %>'
                                                                                                            CssClass="txtbox"></asp:Label>
                                                                                                    </div>
                                                                                                </ItemTemplate>
                                                                                            </asp:TemplateField>
                                                                                            <asp:TemplateField HeaderText="Self Rating" Visible="false">
                                                                                                <ItemTemplate>
                                                                                                    <div align="left">
                                                                                                        &nbsp;<asp:Label ID="lblcompselfrate" runat="server" Text='<%#Bind("U_Z_SelfRaCode") %>'
                                                                                                            Visible="false"></asp:Label></div>
                                                                                                    <div align="right" style="text-align: right;">
                                                                                                        &nbsp;<asp:Label ID="lblcompself1" runat="server" Text='<%#Bind("U_Z_CompSelfRate") %>'></asp:Label></div>
                                                                                                </ItemTemplate>
                                                                                                <FooterTemplate>
                                                                                                    <div align="right">
                                                                                                        <asp:Label ID="lblCselfrate" runat="server"></asp:Label>&nbsp;</div>
                                                                                                </FooterTemplate>
                                                                                            </asp:TemplateField>
                                                                                            <asp:TemplateField HeaderText="First Level Manager Rating">
                                                                                                <ItemTemplate>
                                                                                                    <div align="left">
                                                                                                        &nbsp;<asp:DropDownList ID="ddlCompsmgrfrate" runat="server" Enabled="false">
                                                                                                        </asp:DropDownList>
                                                                                                    </div>
                                                                                                </ItemTemplate>
                                                                                                <FooterTemplate>
                                                                                                    <div align="right">
                                                                                                        <asp:Label ID="lblCmgrgrd" runat="server" Text="First Level Manager Grade :"></asp:Label>&nbsp;</div>
                                                                                                </FooterTemplate>
                                                                                            </asp:TemplateField>
                                                                                            <asp:TemplateField HeaderText="First Level Manager Remarks">
                                                                                                <ItemTemplate>
                                                                                                    <div align="left">
                                                                                                        &nbsp;
                                                                                                        <asp:LinkButton ID="lblCSecoMgrRemark" runat="server" ToolTip='<%#Bind("U_Z_MgrRemark") %>'
                                                                                                            Text="View Remarks" CssClass="txtbox"></asp:LinkButton>
                                                                                                    </div>
                                                                                                </ItemTemplate>
                                                                                                <FooterTemplate>
                                                                                                    <div align="left">
                                                                                                        <asp:Label ID="lblCMgrgrade" runat="server"></asp:Label>&nbsp;</div>
                                                                                                </FooterTemplate>
                                                                                            </asp:TemplateField>
                                                                                            <asp:TemplateField HeaderText="First Level Manager Grade" Visible="false">
                                                                                                <ItemTemplate>
                                                                                                    <div align="left">
                                                                                                        &nbsp;
                                                                                                        <asp:Label ID="lblCmgrGrd" runat="server" Text='<%#Bind("U_Z_CompMgrGrade") %>' CssClass="txtbox"></asp:Label>
                                                                                                    </div>
                                                                                                </ItemTemplate>
                                                                                            </asp:TemplateField>
                                                                                            <asp:TemplateField HeaderText="Line Manager Rating" Visible="false">
                                                                                                <ItemTemplate>
                                                                                                    <div align="left">
                                                                                                        &nbsp;<asp:Label ID="lblCompsmgrfrate" runat="server" Text='<%#Bind("U_Z_MgrRaCode") %>'
                                                                                                            Visible="false"></asp:Label></div>
                                                                                                    <div align="right">
                                                                                                        &nbsp;<asp:Label ID="lblcompmgrRate1" runat="server" Text='<%#Bind("U_Z_CompMgrRate") %>'></asp:Label></div>
                                                                                                </ItemTemplate>
                                                                                                <FooterTemplate>
                                                                                                    <div align="right">
                                                                                                        <asp:Label ID="lblCLinerate" runat="server"></asp:Label>&nbsp;</div>
                                                                                                </FooterTemplate>
                                                                                            </asp:TemplateField>
                                                                                            <asp:TemplateField HeaderText="Second Level Manager Rating">
                                                                                                <ItemTemplate>
                                                                                                    <div align="left">
                                                                                                        &nbsp;<asp:DropDownList ID="ddlcompsmgrrate" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlCompsmgrfrate_SelectedIndexChanged"
                                                                                                            EnableViewState="true">
                                                                                                        </asp:DropDownList>
                                                                                                    </div>
                                                                                                </ItemTemplate>
                                                                                                <FooterTemplate>
                                                                                                    <div align="right">
                                                                                                        <asp:Label ID="lblCsmgrgrd" runat="server" Text="Second Level Manager Grade :"></asp:Label>&nbsp;</div>
                                                                                                </FooterTemplate>
                                                                                            </asp:TemplateField>
                                                                                            <asp:TemplateField HeaderText="Second Level Manager Remarks">
                                                                                                <ItemTemplate>
                                                                                                    <div align="left">
                                                                                                        &nbsp;
                                                                                                        <asp:TextBox ID="txtCfstmgrRemarks" runat="server" Text='<%#Bind("U_Z_SrRemark") %>'
                                                                                                            TextMode="MultiLine" CssClass="txtbox" Width="100"></asp:TextBox>
                                                                                                    </div>
                                                                                                </ItemTemplate>
                                                                                                <FooterTemplate>
                                                                                                    <div align="left">
                                                                                                        <asp:Label ID="lblCSMgrgrade" runat="server"></asp:Label>&nbsp;</div>
                                                                                                </FooterTemplate>
                                                                                            </asp:TemplateField>
                                                                                            <asp:TemplateField HeaderText="Second Level Manager Grade" Visible="false">
                                                                                                <ItemTemplate>
                                                                                                    <div align="left">
                                                                                                        &nbsp;
                                                                                                        <asp:Label ID="lblCsmgrGrd" runat="server" Text='<%#Bind("U_Z_CompSMGrade") %>' CssClass="txtbox"></asp:Label>
                                                                                                    </div>
                                                                                                </ItemTemplate>
                                                                                            </asp:TemplateField>
                                                                                            <asp:TemplateField HeaderText="Senior Manager Rating" Visible="false">
                                                                                                <ItemTemplate>
                                                                                                    <div align="right">
                                                                                                        &nbsp;<asp:Label ID="lblsrmgrRate1" runat="server" Text='<%#Bind("U_Z_CompSMRate") %>'></asp:Label></div>
                                                                                                    <div align="left">
                                                                                                        &nbsp;<asp:Label ID="lblcompsmgrrate" runat="server" Text='<%#Bind("U_Z_SMRaCode") %>'
                                                                                                            Visible="false"></asp:Label></div>
                                                                                                </ItemTemplate>
                                                                                                <FooterTemplate>
                                                                                                    <div align="right">
                                                                                                        <asp:Label ID="lblCsrrate" runat="server"></asp:Label>&nbsp;</div>
                                                                                                </FooterTemplate>
                                                                                            </asp:TemplateField>
                                                                                            <asp:TemplateField HeaderText="Code" Visible="false">
                                                                                                <ItemTemplate>
                                                                                                    <div align="center">
                                                                                                        &nbsp;<asp:Label ID="lblcompCode1" runat="server" Text='<%#Bind("LineId") %>'></asp:Label></div>
                                                                                                </ItemTemplate>
                                                                                            </asp:TemplateField>
                                                                                        </Columns>
                                                                                        <HeaderStyle HorizontalAlign="Center" Height="25px" BackColor="#CCCCCC" />
                                                                                          <FooterStyle Font-Bold="true"  />
                                                                                    </asp:GridView>
                                                                                </div>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                                Self Remarks
                                                                            </td>
                                                                            <td>
                                                                                <asp:TextBox ID="txtsCremarks" CssClass="txtbox" Width="200px" TextMode="MultiLine"
                                                                                    Height="40px" runat="server" Enabled="false"></asp:TextBox>
                                                                            </td>
                                                                            <td width="20%">
                                                                                Sr.Manager Remarks
                                                                            </td>
                                                                            <td>
                                                                                <asp:TextBox ID="txtCSrremarks" CssClass="txtbox" Width="200px" TextMode="MultiLine"
                                                                                    Height="40px" runat="server"></asp:TextBox>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td width="20%">
                                                                                Line Manager Remarks
                                                                            </td>
                                                                            <td>
                                                                                <asp:TextBox ID="txtCLmremarks" CssClass="txtbox" Width="200px" TextMode="MultiLine"
                                                                                    Height="40px" runat="server" Enabled="false"></asp:TextBox>
                                                                            </td>
                                                                            <td>
                                                                                HR Remarks
                                                                            </td>
                                                                            <td>
                                                                                <asp:TextBox ID="txtCHrremarks" CssClass="txtbox" Width="200px" TextMode="MultiLine"
                                                                                    Height="40px" runat="server" Enabled="false"></asp:TextBox>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </ContentTemplate>
                                                            </ajx:TabPanel>
                                                        </ajx:TabContainer>
                                                    </td>
                                                </tr>
                                            </table>
                                        </asp:Panel>
                                        <table>
                                            <tr>
                                                <td colspan="5" align="center">
                                                    <br />
                                                    <asp:Button ID="btnsubmit" CssClass="btn" Width="85px" runat="server" Text="Add"
                                                        OnClientClick="return Confirmation();" />
                                                    <asp:Button ID="btnUpdate" CssClass="btn" Width="85px" runat="server" Text="Save"
                                                        Visible="false" OnClientClick="return Confirmation();" />
                                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                    <asp:Button ID="btnsavesubmit" CssClass="btn" Width="140px" runat="server" Text="Save&Submit"
                                                        OnClientClick="return Confirmation1();" />
                                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                    <asp:Button ID="btnclose" CssClass="btn" Width="85px" runat="server" Text="Cancel" />
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
