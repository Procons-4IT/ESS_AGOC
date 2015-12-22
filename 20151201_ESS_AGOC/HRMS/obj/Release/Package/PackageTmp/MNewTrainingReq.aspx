<%@ Page Title="New Training Request" Language="vb" AutoEventWireup="false" MasterPageFile="~/HRMS.Master"
    CodeBehind="MNewTrainingReq.aspx.vb" Inherits="HRMS.MNewTrainingReq" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">

        function Confirmation() {
            if (confirm("Do you want to confirm?") == true) {
                return true;
            }
            else {
                return false;
            }
        }

        function Confirmation1() {
            if (confirm("Sure Want to withdraw the request?") == true) {
                return true;
            }
            else {
                return false;
            }
        }

        function AllowNumbers(el) {
            var ex = /^[0-9.]+$/;
            if (ex.test(el.value) == false) {
                el.value = el.value.substring(0, el.value.length - 1);
            }
        }
        function alphanumerichypen(el) {
            var ex = /^[A-Za-z0-9_-]+$/;
            if (ex.test(el.value) == false) {
                el.value = el.value.substring(0, el.value.length - 1);
            }
        }

        function checkDec(el) {
            //            el.value = el.value.replace(/^[ 0]+/, '');
            var ex = /^\d*\.?\d{0,2}$/;
            if (ex.test(el.value) == false) {
                el.value = el.value.substring(0, el.value.length - 1);
            }
        }
        function checkDec1(el) {
            //            el.value = el.value.replace(/^[ 0]+/, '');
            var ex = /^\d*\.?\d{0,6}$/;
            if (ex.test(el.value) == false) {
                el.value = el.value.substring(0, el.value.length - 1);
            }
        }

        function RemoveZero(el) {
            el.value = el.value.replace(/^[ ]+/, '');
        }

        function FormatCurrency(ctrl) {
            //Check if arrow keys are pressed - we want to allow navigation around textbox using arrow keys
            if (event.keyCode == 37 || event.keyCode == 38 || event.keyCode == 39 || event.keyCode == 40) {
                return;
            }

            var val = ctrl.value;

            val = val.replace(/,/g, "")
            ctrl.value = "";
            val += '';
            x = val.split('.');
            x1 = x[0];
            x2 = x.length > 1 ? '.' + x[1] : '';

            var rgx = /(\d+)(\d{3})/;

            while (rgx.test(x1)) {
                x1 = x1.replace(rgx, '$1' + ',' + '$2');
            }

            ctrl.value = x1 + x2;
        }

        function CheckNumeric() {
            return event.keyCode >= 48 && event.keyCode <= 57 || event.keyCode == 46;
        }

        function popupdisplay(option, uniqueid, tripno) {
            if (uniqueid.length > 0) {
                var uniid = document.getElementById("<%=txtpopunique.ClientID%>").value;
                var tno = document.getElementById("<%=txtpoptno.ClientID%>").value;
                var opt = document.getElementById("<%=txthidoption.ClientID%>").value;
                uniid = ""; tno = ""; opt = "";
                if (uniid != uniqueid && tno != tripno && opt != option) {
                    document.getElementById("<%=txtpopunique.ClientID%>").value = uniqueid;
                    document.getElementById("<%=txtpoptno.ClientID%>").value = tripno;
                    document.getElementById("<%=txthidoption.ClientID%>").value = option;
                    document.getElementById("<%=Btncallpop.ClientID%>").onclick();
                }
            }
        }
      
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:UpdateProgress ID="UpdateProgress" runat="server">
        <ProgressTemplate>
            <asp:Image ID="Image1" ImageUrl="~/Images/waiting.gif" AlternateText="Processing"
                runat="server" />
        </ProgressTemplate>
    </asp:UpdateProgress>
    <ajx:ModalPopupExtender ID="modalPopup" runat="server" TargetControlID="UpdateProgress"
        PopupControlID="UpdateProgress" BackgroundCssClass="modalPopup" />
    <asp:UpdatePanel ID="Update" runat="server">
        <ContentTemplate>
            <table width="99%" border="0" cellspacing="0" cellpadding="4" class="main_content">
                <tr>
                    <td>
                        <asp:TextBox ID="txtHEmpID" runat="server" Width="93px" Style="display: none"></asp:TextBox>
                        <asp:TextBox ID="txtpopunique" runat="server" Style="display: none"></asp:TextBox>
                        <asp:TextBox ID="txtpoptno" runat="server" Style="display: none"></asp:TextBox>
                        <asp:TextBox ID="txthidoption" runat="server" Style="display: none"></asp:TextBox>
                        <asp:TextBox ID="txttname" runat="server" Style="display: none"></asp:TextBox>
                        <input id="Btncallpop" runat="server" onserverclick="Btncallpop_ServerClick" style="display: none"
                            type="button" value="button" />
                    </td>
                </tr>
                <tr>
                    <td height="30" align="left" colspan="2" valign="bottom" background="images/h_bg.png"
                        style="border-bottom: 1px dotted; border-color: #f45501; background-repeat: repeat-x">
                        <div>
                            &nbsp;
                            <asp:Label ID="Label3" runat="server" Text="New Training Request" CssClass="subheader"
                                Style="float: left;"></asp:Label>
                            <span style="margin-left: 100px; color: Red;">
                                <asp:Label ID="lblNewTrip" runat="server"></asp:Label></span>
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
                                        <asp:ImageButton ID="btnnew" runat="server" ImageUrl="~/images/Add.jpg" ToolTip="Add new record" />
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
                                                        <ajx:TabPanel ID="TabPanel3" runat="server" HeaderText="New Training Request">
                                                            <ContentTemplate>
                                                                <table width="100%" border="0" cellspacing="0" cellpadding="3" class="main_content">
                                                                    <tr>
                                                                        <td>
                                                                            <asp:GridView ID="grdTrainingRequest" runat="server" CellPadding="4" AllowPaging="True"
                                                                                ShowHeaderWhenEmpty="true" CssClass="mGrid" HeaderStyle-CssClass="GridBG" PagerStyle-CssClass="pgr"
                                                                                AlternatingRowStyle-CssClass="alt" AutoGenerateColumns="false" Width="100%" PageSize="10">
                                                                                <Columns>
                                                                                    <asp:TemplateField HeaderText="Request Code">
                                                                                        <ItemTemplate>
                                                                                            <div align="center">
                                                                                                <asp:LinkButton ID="lbtndocnum" runat="server" Text='<%#Bind("DocEntry") %>' OnClick="lbtndocnum_Click">
                                                                                                </asp:LinkButton></div>
                                                                                        </ItemTemplate>
                                                                                    </asp:TemplateField>
                                                                                    <asp:TemplateField HeaderText="Request Date">
                                                                                        <ItemTemplate>
                                                                                            <div align="center">
                                                                                                <asp:Label ID="lbllReqdt" runat="server" Text='<%#Bind("U_Z_ReqDate") %>'></asp:Label></div>
                                                                                        </ItemTemplate>
                                                                                    </asp:TemplateField>
                                                                                    <asp:TemplateField HeaderText="Training Title">
                                                                                        <ItemTemplate>
                                                                                            <div align="center">
                                                                                                <asp:Label ID="lblTrtitle" runat="server" Text='<%#Bind("U_Z_CourseName") %>'></asp:Label></div>
                                                                                        </ItemTemplate>
                                                                                    </asp:TemplateField>
                                                                                    <asp:TemplateField HeaderText="Justification">
                                                                                        <ItemTemplate>
                                                                                            <div align="left">
                                                                                                &#160;<asp:Label ID="lbljust" runat="server" Text='<%#Bind("U_Z_CourseDetails") %>'></asp:Label></div>
                                                                                        </ItemTemplate>
                                                                                    </asp:TemplateField>
                                                                                    <asp:TemplateField HeaderText="Training From Date">
                                                                                        <ItemTemplate>
                                                                                            <div align="left">
                                                                                                &#160;<asp:Label ID="lblfrDate" runat="server" Text='<%#Bind("U_Z_TrainFrdt") %>'></asp:Label></div>
                                                                                        </ItemTemplate>
                                                                                    </asp:TemplateField>
                                                                                    <asp:TemplateField HeaderText="Training To Date">
                                                                                        <ItemTemplate>
                                                                                            <div align="left">
                                                                                                &#160;<asp:Label ID="lbltodt" runat="server" Text='<%#Bind("U_Z_TrainTodt") %>'></asp:Label></div>
                                                                                        </ItemTemplate>
                                                                                    </asp:TemplateField>
                                                                                    <asp:TemplateField HeaderText="Training Course Cost">
                                                                                        <ItemTemplate>
                                                                                            <div align="left">
                                                                                                &#160;<asp:Label ID="lbltrcost" runat="server" Text='<%#Bind("U_Z_TrainCost") %>'></asp:Label></div>
                                                                                        </ItemTemplate>
                                                                                    </asp:TemplateField>
                                                                                    <asp:TemplateField HeaderText="Comments">
                                                                                        <ItemTemplate>
                                                                                            <div align="left">
                                                                                                &#160;<asp:Label ID="lblreason" runat="server" Text='<%#Bind("U_Z_Notes") %>'></asp:Label></div>
                                                                                        </ItemTemplate>
                                                                                    </asp:TemplateField>
                                                                                    <asp:TemplateField HeaderText="Approval Status">
                                                                                        <ItemTemplate>
                                                                                            <div align="left">
                                                                                                &#160;<asp:Label ID="lblstatus" runat="server" Text='<%#Bind("U_Z_AppStatus") %>'></asp:Label></div>
                                                                                        </ItemTemplate>
                                                                                    </asp:TemplateField>
                                                                                    <asp:TemplateField HeaderText="Current Approver">
                                                                                        <ItemTemplate>
                                                                                            <div align="left">
                                                                                                &#160;<asp:Label ID="lblcurapp" runat="server" Text='<%#Bind("U_Z_CurApprover") %>'></asp:Label></div>
                                                                                        </ItemTemplate>
                                                                                    </asp:TemplateField>
                                                                                    <asp:TemplateField HeaderText="Next Approver">
                                                                                        <ItemTemplate>
                                                                                            <div align="left">
                                                                                                &#160;<asp:Label ID="lblnxtapp" runat="server" Text='<%#Bind("U_Z_NxtApprover") %>'></asp:Label></div>
                                                                                        </ItemTemplate>
                                                                                    </asp:TemplateField>
                                                                                    <asp:TemplateField HeaderText="Requested by">
                                                                                        <ItemTemplate>
                                                                                            <div align="left">
                                                                                                &#160;<asp:Label ID="lblreqby" runat="server" Text='<%#Bind("U_Z_CrEmpName") %>'></asp:Label></div>
                                                                                        </ItemTemplate>
                                                                                    </asp:TemplateField>
                                                                                    <asp:TemplateField HeaderText="Approval History">
                                                                                        <ItemTemplate>
                                                                                            <div align="left">
                                                                                                &#160;<asp:LinkButton ID="lbtAppHistory" runat="server" Text="View" OnClick="lbtAppHistory_Click"></asp:LinkButton></div>
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
                                    <asp:Panel ID="PanelNewRequest" runat="server" Width="100%" BorderColor="LightSteelBlue"
                                        BorderWidth="2">
                                        <table width="100%" border="0" cellspacing="0" cellpadding="3" class="main_content">
                                            <tr>
                                                <td>
                                                    Request Code
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtreqcode" CssClass="txtbox" runat="server" Enabled="False"></asp:TextBox>
                                                    <asp:TextBox ID="txtcode" CssClass="txtbox" runat="server" Visible="False"></asp:TextBox>
                                                </td>
                                                <td>
                                                    Request Date
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtreqdate" CssClass="txtbox" runat="server" Enabled="False"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    Employee Code
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtempid" CssClass="txtbox" runat="server" Enabled="False"></asp:TextBox>
                                                    <asp:TextBox ID="txtbadge" CssClass="txtbox" runat="server" Visible="False"></asp:TextBox>
                                                    <asp:ImageButton ID="btnfindEmp" runat="server" Text="Find" ImageUrl="~/images/search.jpg"
                                                        ToolTip="Search" />
                                                    <ajx:ModalPopupExtender ID="ModalPopupExtender1" runat="server" DropShadow="True"
                                                        PopupControlID="Panel1" TargetControlID="btnfindEmp" CancelControlID="Button1"
                                                        BackgroundCssClass="modalBackground">
                                                    </ajx:ModalPopupExtender>
                                                </td>
                                                <td>
                                                    Employee Name
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtempname" CssClass="txtbox" runat="server" Enabled="False"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    Department
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtdeptName" CssClass="txtbox" runat="server" Enabled="False"></asp:TextBox>
                                                    <asp:TextBox ID="txtdeptcode" CssClass="txtbox" runat="server" Visible="False"></asp:TextBox>
                                                </td>
                                                <td>
                                                    Position
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtpositionName" CssClass="txtbox" runat="server" Enabled="False"></asp:TextBox>
                                                    <asp:TextBox ID="txtposCode" CssClass="txtbox" runat="server" Visible="False"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    Training Title (*)
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txttrtitle" CssClass="txtbox" runat="server"></asp:TextBox>
                                                </td>
                                                <td>
                                                    Justification
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtjust" CssClass="txtbox" runat="server"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    Training Course Cost
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtcost" CssClass="txtbox" runat="server" onkeypress="return CheckNumeric();"
                                                        onkeyup="FormatCurrency(this);"></asp:TextBox>
                                                </td>
                                                <td>
                                                    Per-Diem and AirFares (SAR)
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtestexp" CssClass="txtbox" runat="server" onkeypress="return CheckNumeric();"
                                                        onkeyup="FormatCurrency(this);"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    Training From Date (*)
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtfrmdate" CssClass="txtbox" runat="server"></asp:TextBox>
                                                    <ajx:CalendarExtender ID="CalendarExtender2" Animated="true" Format="dd/MM/yyyy"
                                                        runat="server" TargetControlID="txtfrmdate" CssClass="cal_Theme1">
                                                    </ajx:CalendarExtender>
                                                </td>
                                                <td>
                                                    Training To Date (*)
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txttodate" CssClass="txtbox" runat="server"></asp:TextBox>
                                                    <ajx:CalendarExtender ID="CalendarExtender1" Animated="true" Format="dd/MM/yyyy"
                                                        runat="server" TargetControlID="txttodate" CssClass="cal_Theme1">
                                                    </ajx:CalendarExtender>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    Training Location
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtTrainloc" CssClass="txtbox" runat="server"></asp:TextBox>
                                                </td>
                                                <td>
                                                </td>
                                                <td>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    Training Duration (Business Days)
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtBussDur" CssClass="txtbox" runat="server" onkeypress="AllowNumbers(this);checkDec(this);RemoveZero(this);"
                                                        onkeyup="AllowNumbers(this);checkDec(this);RemoveZero(this);"></asp:TextBox>
                                                </td>
                                                <td>
                                                    Training Duration (Calendar Days)
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtCalDur" CssClass="txtbox" runat="server" onkeypress="AllowNumbers(this);checkDec(this);RemoveZero(this);"
                                                        onkeyup="AllowNumbers(this);checkDec(this);RemoveZero(this);"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    Away from Office(Business Days)
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtawaybuss" CssClass="txtbox" runat="server" onkeypress="AllowNumbers(this);checkDec(this);RemoveZero(this);"
                                                        onkeyup="AllowNumbers(this);checkDec(this);RemoveZero(this);"></asp:TextBox>
                                                </td>
                                                <td>
                                                    Certification Test Available
                                                </td>
                                                <td>
                                                    <asp:RadioButtonList ID="Rblcert" runat="server" RepeatDirection="Horizontal">
                                                        <asp:ListItem Value="2">Yes</asp:ListItem>
                                                        <asp:ListItem Value="1">No</asp:ListItem>
                                                    </asp:RadioButtonList>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    Trainee Leaves Duty On
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtLveDutyon" CssClass="txtbox" runat="server"></asp:TextBox>
                                                    <ajx:CalendarExtender ID="CalendarExtender3" Animated="true" Format="dd/MM/yyyy"
                                                        runat="server" TargetControlID="txtLveDutyon" CssClass="cal_Theme1">
                                                    </ajx:CalendarExtender>
                                                </td>
                                                <td>
                                                    Certification Test Included
                                                </td>
                                                <td>
                                                    <asp:RadioButtonList ID="RblTestinc" runat="server" RepeatDirection="Horizontal">
                                                        <asp:ListItem Value="2">Yes</asp:ListItem>
                                                        <asp:ListItem Value="1">No</asp:ListItem>
                                                    </asp:RadioButtonList>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    Trainee Travels On
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtTravelon" CssClass="txtbox" runat="server"></asp:TextBox>
                                                    <ajx:CalendarExtender ID="CalendarExtender4" Animated="true" Format="dd/MM/yyyy"
                                                        runat="server" TargetControlID="txtTravelon" CssClass="cal_Theme1">
                                                    </ajx:CalendarExtender>
                                                </td>
                                                <td>
                                                    Trainee Returns On
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtReturnon" CssClass="txtbox" runat="server"></asp:TextBox>
                                                    <ajx:CalendarExtender ID="CalendarExtender5" Animated="true" Format="dd/MM/yyyy"
                                                        runat="server" TargetControlID="txtReturnon" CssClass="cal_Theme1">
                                                    </ajx:CalendarExtender>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    Trainee Resumes Duty On
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtresumes" CssClass="txtbox" runat="server"></asp:TextBox>
                                                    <ajx:CalendarExtender ID="CalendarExtender6" Animated="true" Format="dd/MM/yyyy"
                                                        runat="server" TargetControlID="txtresumes" CssClass="cal_Theme1">
                                                    </ajx:CalendarExtender>
                                                </td>
                                                <td>
                                                </td>
                                                <td>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    Notes/Comments
                                                </td>
                                                <td colspan="2">
                                                    <asp:TextBox ID="txtComments" CssClass="txtbox" TextMode="MultiLine" Width="400px"
                                                        Height="70px" runat="server"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="2" align="center">
                                                    <br />
                                                    <asp:Button ID="btnAdd" CssClass="btn" Width="85px" runat="server" Text="Save" OnClientClick="return Confirmation();" />
                                                    <asp:Button ID="btncancel" CssClass="btn" Width="85px" runat="server" Text="Cancel" />
                                                    <asp:Button ID="btnWithdraw" CssClass="btn" runat="server" Text="WithDraw Request"
                                                        Visible="false" OnClientClick="return Confirmation1();" />
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div style="visibility: hidden">
                            <asp:Button ID="btnSample" runat="server" />
                        </div>
                        <ajx:ModalPopupExtender ID="ModalPopupExtender7" runat="server" DropShadow="True"
                            PopupControlID="Panelpoptechnician" TargetControlID="btnSample" CancelControlID="btnclstech"
                            BackgroundCssClass="modalBackground">
                        </ajx:ModalPopupExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Panel ID="Panelpoptechnician" runat="server" BackColor="White" Style="display: none;
                            padding: 10px; width: 900px;">
                            <div>
                                <span class="sideheading" style="color: Green;">Approval History Details</span>
                                <span style="float: right;">
                                    <asp:Button ID="btnclstech" runat="server" CssClass="btn" Width="30px" Text="X" /></span></div>
                            <br />
                            <br />
                            <asp:Panel ID="Panel4" runat="server" Height="400px">
                                <asp:Label ID="Label1" runat="server" Text="" CssClass="txtbox" ForeColor="Red"></asp:Label>
                                <asp:GridView ID="grdRequesttohr" runat="server" CellPadding="4" ShowHeaderWhenEmpty="true"
                                    CssClass="mGrid" HeaderStyle-CssClass="GridBG" AlternatingRowStyle-CssClass="alt"
                                    AutoGenerateColumns="false" Width="100%">
                                    <Columns>
                                        <asp:TemplateField HeaderText="Employee ID">
                                            <ItemTemplate>
                                                <div align="center">
                                                    <asp:Label ID="lbtndocnum" runat="server" Text='<%#Bind("U_Z_EmpId") %>'></asp:Label></div>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Approved By">
                                            <ItemTemplate>
                                                <div align="center">
                                                    <asp:Label ID="lblactivity" runat="server" Text='<%#Bind("U_Z_EmpName") %>'></asp:Label></div>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Approved By" Visible="false">
                                            <ItemTemplate>
                                                <div align="center">
                                                    <asp:Label ID="lbltype" runat="server" Text='<%#Bind("U_Z_ApproveBy") %>'></asp:Label></div>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Next Approver">
                                            <ItemTemplate>
                                                <div align="center">
                                                    <asp:Label ID="lblhapprover" runat="server" Text='<%#Bind("U_Z_NextApprover") %>'></asp:Label></div>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Action Date">
                                            <ItemTemplate>
                                                <div align="center">
                                                    <asp:Label ID="lblcrDate" runat="server" Text='<%#Bind("CreateDate") %>'></asp:Label></div>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Action Time">
                                            <ItemTemplate>
                                                <div align="center">
                                                    <asp:Label ID="lblcrtime" runat="server" Text='<%#Bind("CreateTime") %>'></asp:Label></div>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Update Date" Visible="false">
                                            <ItemTemplate>
                                                <div align="center">
                                                    <asp:Label ID="lblupdate" runat="server" Text='<%#Bind("UpdateDate") %>'></asp:Label></div>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Update Time" Visible="false">
                                            <ItemTemplate>
                                                <div align="center">
                                                    <asp:Label ID="lblupdatime" runat="server" Text='<%#Bind("UpdateTime") %>'></asp:Label></div>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Approved Status">
                                            <ItemTemplate>
                                                <div align="center">
                                                    <asp:Label ID="lblactsubject" runat="server" Text='<%#Bind("U_Z_AppStatus") %>'></asp:Label></div>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Remarks">
                                            <ItemTemplate>
                                                <div align="center">
                                                    <asp:Label ID="lblAssigned" runat="server" Text='<%#Bind("U_Z_Remarks") %>'></asp:Label></div>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                    <HeaderStyle HorizontalAlign="Center" Height="25px" BackColor="#CCCCCC" />
                                </asp:GridView>
                            </asp:Panel>
                        </asp:Panel>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Panel ID="Panel1" runat="server" BackColor="White" Style="display: none; padding: 10px;
                            width: 500px;">
                            <div>
                                <span class="sideheading" style="color: Green;">Alternate Employee Request</span>
                                <span style="float: right;">
                                    <asp:Button ID="Button1" runat="server" CssClass="btn" Width="30px" Text="X" /></span></div>
                            <br />
                            <asp:Panel ID="Panel2" runat="server" Height="200px" ScrollBars="Vertical">
                                <asp:GridView ID="grdAltEmployee" runat="server" CellPadding="4" ShowHeaderWhenEmpty="true"
                                    CssClass="mGrid" HeaderStyle-CssClass="GridBG" PagerStyle-CssClass="pgr" AlternatingRowStyle-CssClass="alt"
                                    AutoGenerateColumns="false" Width="100%" EmptyDataText="No records Found" RowStyle-CssClass="mousecursor">
                                    <Columns>
                                        <asp:TemplateField HeaderText="Employee ID">
                                            <ItemTemplate>
                                                <asp:Label ID="lblpEmpcode" runat="server" Text='<%#Bind("U_Z_EMPID") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Employee Name">
                                            <ItemTemplate>
                                                <asp:Label ID="lblPEmpname" runat="server" Text='<%#Bind("U_Z_EMPNAME") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                    <HeaderStyle HorizontalAlign="Center" Height="25px" BackColor="Gray" ForeColor="White" />
                                    <RowStyle HorizontalAlign="Center" />
                                    <AlternatingRowStyle HorizontalAlign="Center" />
                                </asp:GridView>
                            </asp:Panel>
                        </asp:Panel>
                    </td>
                </tr>
            </table>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
