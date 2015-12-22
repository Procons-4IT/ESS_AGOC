Imports System
Imports System.Globalization
Imports EN
Imports DataAccess
Imports BusinessLogic
Public Class TravelRequest
    Inherits System.Web.UI.Page
    Dim objEN As TravelRequestEN = New TravelRequestEN()
    Dim objBL As TravelRequestBL = New TravelRequestBL()
    Dim dbcon As DBConnectionDA = New DBConnectionDA()
    Dim strNewStatus, intTempID As String
    Dim dtFrom, dtTo As Date
    Dim Blflag As Boolean
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            If Session("UserCode") Is Nothing Then
                Response.Redirect("Login.aspx?sessionExpired=true", True)
            ElseIf Session("SAPCompany") Is Nothing Then
                If Session("EmpUserName").ToString() = "" Or Session("UserPwd").ToString() = "" Then
                    strError = dbcon.Connection()
                Else
                    strError = dbcon.Connection(Session("EmpUserName").ToString(), Session("UserPwd").ToString())
                End If
                If strError <> "Success" Then
                    Page.ClientScript.RegisterStartupScript(Me.GetType(), "js", "<script>alert('" & strError & "')</script>")
                Else
                    Session("SAPCompany") = dbcon.objMainCompany
                End If
            End If
            ExpintTempID = dbcon.CheckApprovalExists("TraReq", Session("UserCode").ToString())
            If ExpintTempID = 0 Then
                panelhome.Visible = False
                panelview.Visible = False
                panelnew.Visible = False
                lblNewTrip.Text = "Approval template is not defined . You can't create request. please Contact the Administrator..."
                dbcon.strmsg = "Approval template is not defined . You can't create request. please Contact the Administrator..."
                Page.ClientScript.RegisterStartupScript(Me.GetType(), "js", "<script>alert('" & dbcon.strmsg & "')</script>")
            Else
                lblNewTrip.Text = ""
                panelview.Visible = True
                panelnew.Visible = False
                btnnew.Visible = True
                objEN.EmpId = Session("UserCode").ToString()
                ViewState("EmpId") = objEN.EmpId
                PageLoadBind(objEN)
            End If
        End If
    End Sub
    Private Sub PageLoadBind(ByVal objen As TravelRequestEN)
        dbcon.ds = objBL.PageLoadBind(objen)
        If dbcon.ds.Tables(0).Rows.Count > 0 Then
            ddltrip.DataSource = dbcon.ds.Tables(0)
            ddltrip.DataTextField = "U_Z_TraCode"
            ddltrip.DataValueField = "Code"
            ddltrip.DataBind()
            ddltrip.Items.Insert(0, "")
        Else
            ddltrip.DataBind()
            ddltrip.Items.Insert(0, "")
        End If
        If dbcon.ds.Tables(1).Rows.Count > 0 Then
            grdTravelRequest.DataSource = dbcon.ds.Tables(1)
            grdTravelRequest.DataBind()
        Else
            grdTravelRequest.DataBind()
        End If
        If dbcon.ds.Tables(2).Rows.Count > 0 Then
            txtdept.Text = dbcon.ds.Tables(2).Rows(0)("dept").ToString()
            txtempid.Text = dbcon.ds.Tables(2).Rows(0)("empID").ToString()
            txtempname.Text = dbcon.ds.Tables(2).Rows(0)("firstName").ToString() & " " & dbcon.ds.Tables(2).Rows(0)("middleName").ToString() & " " & dbcon.ds.Tables(2).Rows(0)("lastName").ToString()
            txtposid.Text = dbcon.ds.Tables(2).Rows(0)("U_Z_GrdCode").ToString()
            txtposname.Text = dbcon.ds.Tables(2).Rows(0)("U_Z_GrdName").ToString()
            objen.DeptCode = txtdept.Text.Trim()
            If txtdept.Text.Trim() <> "" Then
                txtdeptName.Text = objBL.Department(objen)
            End If
        End If
    End Sub
    Protected Sub btnnew_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnnew.Click
        System.Threading.Thread.Sleep(2000)
        If Session("UserCode") Is Nothing Or Session("SAPCompany") Is Nothing Then
            Response.Redirect("Login.aspx?sessionExpired=true", True)
        Else
            btnWithdraw.Visible = False
            panelnew.Visible = True
            panelview.Visible = False
            btnUpdate.Visible = False
            btnsubmit.Visible = True
            objEN.EmpId = Session("UserCode").ToString()
            txtReqno.Text = dbcon.Getmaxcode("""@Z_HR_OTRAREQ""", """DocEntry""")
            txtreqdate.Text = Now.Date
            ' PageLoadBind(objEN)
            ddlstatus.SelectedValue = "P"
            chkNew.Checked = True
            txttripName.Enabled = True
            dbcon.dss5 = dbcon.AlternateRequest(Session("UserCode").ToString(), "TraReq")
            If dbcon.dss5.Tables(0).Rows.Count > 1 Then
                grdAltEmployee.DataSource = dbcon.dss5.Tables(0)
                grdAltEmployee.DataBind()
                btnfindEmp.Visible = True
            Else
                grdAltEmployee.DataBind()
                btnfindEmp.Visible = False
            End If
        End If
        Clear()
    End Sub
    Private Sub Clear()
        ddlstatus.Enabled = False
        ddltrip.Enabled = True
        txtstartdate.Text = ""
        txtenddate.Text = ""
        txtfromloc.Text = ""
        txttoloc.Text = ""
        txtRemarks.Text = ""
        txtreqappdt.Text = ""
        txtreqdt.Text = ""
        txtreqcldt.Text = ""
        txtappcldt.Text = ""
        txttripName.Text = ""
        btnsubmit.Visible = True
        ddltrip.Enabled = True
        txtstartdate.ReadOnly = False
        txtenddate.ReadOnly = False
        txtfromloc.ReadOnly = False
        txttoloc.ReadOnly = False
        txtRemarks.ReadOnly = False
    End Sub
    Protected Sub ddltrip_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddltrip.SelectedIndexChanged
        objEN.TripCode = ddltrip.SelectedItem.Text
        If objEN.TripCode <> "" Then
            txttripName.Text = objBL.BindTravelName(objEN)
            objEN.TripName = ddltrip.SelectedItem.Value
            ExpensesBind(objEN)
        End If
    End Sub
    Private Sub ExpensesBind(ByVal objen As TravelRequestEN)
        dbcon.ds2 = objBL.ExpensesBind(objen)
        If dbcon.ds2.Tables(0).Rows.Count > 0 Then
            grdExpenses.DataSource = dbcon.ds2.Tables(0)
            grdExpenses.DataBind()
        End If
    End Sub
    Protected Sub btnclose_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnclose.Click
        System.Threading.Thread.Sleep(2000)
        If Session("UserCode") Is Nothing Or Session("SAPCompany") Is Nothing Then
            Response.Redirect("Login.aspx?sessionExpired=true", True)
        Else
            panelview.Visible = True
            panelnew.Visible = False
            If Session("EmpName") Is Nothing Then
                btnnew.Visible = True
            Else
                btnnew.Visible = False
            End If
        End If
    End Sub
    Protected Sub lbtndocnum_Click(ByVal sender As Object, ByVal e As EventArgs)
        System.Threading.Thread.Sleep(2000)
        If Session("UserCode") Is Nothing Or Session("SAPCompany") Is Nothing Then
            Response.Redirect("Login.aspx?sessionExpired=true", True)
        Else
            Dim link As LinkButton = CType(sender, LinkButton)
            Dim gv As GridViewRow = CType((link.Parent.Parent), GridViewRow)
            Dim DocNo As LinkButton = CType(gv.FindControl("lbtndocnum"), LinkButton)
            objEN.DocEntry = DocNo.Text.Trim()
            objEN.EmpId = Session("UserCode").ToString()
            panelview.Visible = False
            panelnew.Visible = True
            btnnew.Visible = True
            PopulateRequest(objEN)
            btnsubmit.Visible = False
            ddlstatus.Enabled = False
            btnfindEmp.Visible = False
        End If
    End Sub
    Public Sub expenses(ByVal objen As TravelRequestEN)
        dbcon.dss4 = objBL.Expenses(objen)
        If dbcon.dss4.Tables(0).Rows.Count > 0 Then
            grdExpenses.DataSource = dbcon.dss4
            grdExpenses.DataBind()
        Else
            grdExpenses.DataBind()
        End If
    End Sub
    Private Sub PopulateRequest(ByVal objen As TravelRequestEN)
        expenses(objen)
        If objen.EmpId <> "" Then
            dbcon.ds2 = objBL.PopulateRequest(objen)
            If dbcon.ds2.Tables(0).Rows.Count <> 0 Then
                txtReqno.Text = dbcon.ds2.Tables(0).Rows(0)("DocEntry").ToString()
                txtreqdate.Text = dbcon.ds2.Tables(0).Rows(0)("U_Z_DocDate").ToString()
                txtdept.Text = dbcon.ds2.Tables(0).Rows(0)("U_Z_DeptId").ToString()
                txtdeptName.Text = dbcon.ds2.Tables(0).Rows(0)("U_Z_DeptName").ToString()
                txtposid.Text = dbcon.ds2.Tables(0).Rows(0)("U_Z_PosCode").ToString()
                txtposname.Text = dbcon.ds2.Tables(0).Rows(0)("U_Z_PosName").ToString()
                txtempid.Text = dbcon.ds2.Tables(0).Rows(0)("U_Z_EmpId").ToString()
                txtempname.Text = dbcon.ds2.Tables(0).Rows(0)("U_Z_EmpName").ToString()
                ddlstatus.SelectedValue = dbcon.ds2.Tables(0).Rows(0)("U_Z_AppStatus").ToString()
                If dbcon.ds2.Tables(0).Rows(0)("U_Z_TraCode").ToString() <> "" Then
                    ' ddltrip.SelectedIndex = ddltrip.Items.IndexOf(ddltrip.Items.FindByText( dbcon.ds2.Tables(0).Rows(0)("U_Z_TraCode").ToString()))
                    objen.TripCode = dbcon.ds2.Tables(0).Rows(0)("U_Z_TraCode").ToString()
                    ddltrip.SelectedItem.Text = objen.TripCode
                End If
                txttripName.Text = dbcon.ds2.Tables(0).Rows(0)("U_Z_TraName").ToString()
                txtstartdate.Text = dbcon.ds2.Tables(0).Rows(0)("U_Z_TraStDate").ToString()
                txtenddate.Text = dbcon.ds2.Tables(0).Rows(0)("U_Z_TraEndDate").ToString()
                txtfromloc.Text = dbcon.ds2.Tables(0).Rows(0)("U_Z_TraStLoc").ToString()
                txttoloc.Text = dbcon.ds2.Tables(0).Rows(0)("U_Z_TraEdLoc").ToString()
                txtreqdt.Text = dbcon.ds2.Tables(0).Rows(0)("U_Z_DocDate").ToString()
                txtreqappdt.Text = dbcon.ds2.Tables(0).Rows(0)("U_Z_ReqAppDate").ToString()
                txtreqcldt.Text = dbcon.ds2.Tables(0).Rows(0)("U_Z_ReqClaimDate").ToString()
                txtappcldt.Text = dbcon.ds2.Tables(0).Rows(0)("U_Z_AppClaimDate").ToString()
                txtRemarks.Text = dbcon.ds2.Tables(0).Rows(0)("U_Z_EmpComme").ToString()
                If dbcon.ds2.Tables(0).Rows(0)("U_Z_NewReq").ToString() = "Y" Then
                    chkNew.Checked = True
                    ddltrip.Enabled = False
                    txttripName.Enabled = True
                Else
                    chkNew.Checked = False
                    ddltrip.Enabled = True
                    txttripName.Enabled = False
                End If
                Dim blnValue As Boolean = dbcon.WithDrawStatus("TraReq", txtReqno.Text.Trim())
                If blnValue = True Or dbcon.ds2.Tables(0).Rows(0)("U_Z_AppStatus").ToString() <> "P" Then
                    btnWithdraw.Visible = False
                    btnUpdate.Visible = False
                Else
                    btnWithdraw.Visible = True
                    btnUpdate.Visible = True
                End If

                EnableDisable(dbcon.ds2.Tables(0).Rows(0)("U_Z_AppStatus").ToString())
            End If
        End If
    End Sub
    Private Sub EnableDisable(ByVal strStatus As String)
        If strStatus = "P" Then
            ddlstatus.Enabled = True
            txtstartdate.ReadOnly = False
            txtenddate.ReadOnly = False
            txtfromloc.ReadOnly = False
            txttoloc.ReadOnly = False
            txtRemarks.ReadOnly = False
            btnsubmit.Visible = False
        Else
            ddlstatus.Enabled = False
            txtstartdate.ReadOnly = True
            txtenddate.ReadOnly = True
            txtfromloc.ReadOnly = True
            txttoloc.ReadOnly = True
            txtRemarks.ReadOnly = True
            btnsubmit.Visible = False
        End If
    End Sub
    Private Sub mess(ByVal str As String)
        ScriptManager.RegisterStartupScript(Update, Update.[GetType](), "strmsg", dbcon.strmsg, True)
    End Sub
    Private Function Validation() As Boolean
        Dim oRec As SAPbobsCOM.Recordset
        Try
            If chkNew.Checked = True And ddltrip.SelectedValue <> "" Then
                dbcon.strmsg = "alert('Select either Trip Code or New Trip Request ...')"
                mess(dbcon.strmsg)
                Return False
            End If
            If chkNew.Checked = False Then
                '    If txttripName.Text = "" Then
                '        dbcon.strmsg = "alert('TripName is missing...')"
                '        mess(dbcon.strmsg)
                '        Return False
                '    End If
                'Else
                If ddltrip.SelectedIndex = 0 Then
                    dbcon.strmsg = "alert('TripCode is missing...')"
                    mess(dbcon.strmsg)
                    Return False
                End If
            End If


            If txtfromloc.Text = "" Then
                dbcon.strmsg = "alert('Origin is missing...')"
                mess(dbcon.strmsg)
                Return False
            End If
            If txtRemarks.Text = "" Then
                dbcon.strmsg = "alert('Purpose Of Trip is missing...')"
                mess(dbcon.strmsg)
                Return False
            End If
            If txttoloc.Text = "" Then
                dbcon.strmsg = "alert('Destination(s) is missing...')"
                mess(dbcon.strmsg)
                Return False
            End If
            If txtstartdate.Text = "" Then
                dbcon.strmsg = "alert('Business Start Date (Excluding Travel Days) is missing...')"
                mess(dbcon.strmsg)
                Return False
            Else
                dtFrom = Date.ParseExact(txtstartdate.Text.Trim().Replace("-", "/"), "dd/MM/yyyy", CultureInfo.InvariantCulture)
            End If

            If txtenddate.Text = "" Then
                dbcon.strmsg = "alert('Business End Date (Excluding Travel Days) is missing...')"
                mess(dbcon.strmsg)
                Return False
            Else
                dtTo = Date.ParseExact(txtenddate.Text.Trim().Replace("-", "/"), "dd/MM/yyyy", CultureInfo.InvariantCulture)
            End If
            If dtFrom > dtTo Then
                dbcon.strmsg = "alert('Business End Date (Excluding Travel Days) must be greater than or equal to Business Start Date (Excluding Travel Days)...')"
                mess(dbcon.strmsg)
                Return False
            End If
            If ddlstatus.SelectedValue = "P" Then
            Else
                dbcon.strmsg = "alert('You are not authorized to perform this action of Request Status...')"
                mess(dbcon.strmsg)
                Return False
            End If
            objEN.SapCompany = Session("SAPCompany")
            oRec = objEN.SapCompany.GetBusinessObject(SAPbobsCOM.BoObjectTypes.BoRecordset)
            dbcon.strQuery = "select * from [@Z_HR_OTRAREQ] where U_Z_EmpId='" & txtempid.Text.Trim() & "' and '" & dtFrom.ToString("yyyy-MM-dd") & "' between U_Z_TraStDate and U_Z_TraEndDate"
            oRec.DoQuery(dbcon.strQuery)
            If oRec.RecordCount > 0 Then
                dbcon.strmsg = "alert('A travel request is already approved for the selected date, do you want to continue?')"
                mess(dbcon.strmsg)
            End If
            Return True
        Catch ex As Exception
            mess(ex.Message)
            Return False
        End Try
    End Function
    Protected Sub btnsubmit_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnsubmit.Click
        System.Threading.Thread.Sleep(2000)
        If Session("UserCode") Is Nothing Or Session("SAPCompany") Is Nothing Then
            Response.Redirect("Login.aspx?sessionExpired=true", True)
        Else
            objEN.SapCompany = Session("SAPCompany")
            If Validation() = True Then
                If AddUDO(objEN.SapCompany) = "Success" Then
                    dbcon.strmsg = "alert('Travel Request added successfully...')"
                    mess(dbcon.strmsg)
                    panelview.Visible = True
                    panelnew.Visible = False
                    objEN.EmpId = ViewState("EmpId").ToString()
                    PageLoadBind(objEN)
                    intTempID = dbcon.GetTemplateID("TraReq", txtempid.Text.Trim())
                    If intTempID <> "0" Then
                        objEN.DocEntry = txtReqno.Text.Trim()
                        dbcon.UpdateApprovalRequired("@Z_HR_OTRAREQ", "DocEntry", objEN.DocEntry, "Y", intTempID)
                        dbcon.InitialMessage("Travel Request", objEN.DocEntry, dbcon.DocApproval("TraReq", txtempid.Text.Trim()), intTempID, txtempname.Text.Trim(), "TraReq", objEN.SapCompany)
                    Else
                        objEN.DocEntry = txtReqno.Text.Trim()
                        dbcon.UpdateApprovalRequired("@Z_HR_OTRAREQ", "DocEntry", objEN.DocEntry, "N", intTempID)
                    End If

                Else
                    dbcon.strmsg = "alert('" & dbcon.strmsg & "')"
                    mess(dbcon.strmsg)
                End If
            End If
        End If
    End Sub
    Private Function AddUDO(ByVal SapCompany As SAPbobsCOM.Company) As String
        Try
            dtFrom = Date.ParseExact(txtstartdate.Text.Trim().Replace("-", "/"), "dd/MM/yyyy", CultureInfo.InvariantCulture)
            dtTo = Date.ParseExact(txtenddate.Text.Trim().Replace("-", "/"), "dd/MM/yyyy", CultureInfo.InvariantCulture)
            dbcon.objMainCompany = SapCompany
            Dim oGeneralService As SAPbobsCOM.GeneralService
            Dim oGeneralData As SAPbobsCOM.GeneralData
            Dim oChild As SAPbobsCOM.GeneralData
            Dim oChildren As SAPbobsCOM.GeneralDataCollection
            Dim oCompanyService As SAPbobsCOM.CompanyService
            oCompanyService = dbcon.objMainCompany.GetCompanyService
            oGeneralService = oCompanyService.GetGeneralService("Z_HR_OTRAREQ")
            oGeneralData = oGeneralService.GetDataInterface(SAPbobsCOM.GeneralServiceDataInterfaces.gsGeneralData)
            'oGeneralData.SetProperty("DocEntry", txtReqno.Text.Trim())
            oGeneralData.SetProperty("U_Z_DocDate", Now.Date)
            If chkNew.Checked = True Then
                strNewStatus = "Y"
                oGeneralData.SetProperty("U_Z_TraCode", "")
            Else
                strNewStatus = "N"
                oGeneralData.SetProperty("U_Z_TraCode", ddltrip.SelectedItem.Text.Trim())
            End If
            'oGeneralData.SetProperty("U_Z_TraName", txttripName.Text.Trim())
            Dim TrpName As String = txtfromloc.Text.Trim() & " - " & txttoloc.Text.Trim()
            oGeneralData.SetProperty("U_Z_TraName", TrpName.Trim())
            oGeneralData.SetProperty("U_Z_EmpId", txtempid.Text.Trim())
            oGeneralData.SetProperty("U_Z_EmpName", txtempname.Text.Trim())
            oGeneralData.SetProperty("U_Z_DeptId", txtdept.Text.Trim())
            oGeneralData.SetProperty("U_Z_DeptName", txtdeptName.Text.Trim())
            oGeneralData.SetProperty("U_Z_PosCode", txtposid.Text.Trim())
            oGeneralData.SetProperty("U_Z_PosName", txtposname.Text.Trim())
            oGeneralData.SetProperty("U_Z_TraStLoc", txtfromloc.Text.Trim())
            oGeneralData.SetProperty("U_Z_TraEdLoc", txttoloc.Text.Trim())
            oGeneralData.SetProperty("U_Z_TraStDate", dtFrom)
            oGeneralData.SetProperty("U_Z_TraEndDate", dtTo)
            oGeneralData.SetProperty("U_Z_EmpComme", txtRemarks.Text.Trim())
            oGeneralData.SetProperty("U_Z_NewReq", strNewStatus)
            oGeneralData.SetProperty("U_Z_AppStatus", dbcon.DocApproval("TraReq", txtempid.Text.Trim()))
            oGeneralData.SetProperty("U_Z_CrEmpID", Session("UserCode").ToString())
            oGeneralData.SetProperty("U_Z_CrEmpName", Session("UserName").ToString())
            oChildren = oGeneralData.Child("Z_HR_TRAREQ1")
            Dim strname, strcode, strutlamt, strbalamt As String
            Dim row1 As GridViewRow
            For Each row1 In grdExpenses.Rows
                strcode = CType(row1.FindControl("lblexpname"), Label).Text
                strname = CType(row1.FindControl("lblbtamt"), Label).Text
                strutlamt = CType(row1.FindControl("lblutlamt"), Label).Text
                strbalamt = CType(row1.FindControl("lblbalamt"), Label).Text
                oChild = oChildren.Add()
                oChild.SetProperty("U_Z_ExpName", strcode)
                oChild.SetProperty("U_Z_Amount", strname)
                oChild.SetProperty("U_Z_UtilAmt", strutlamt)
                oChild.SetProperty("U_Z_BalAmount", strbalamt)
            Next row1
            oGeneralService.Add(oGeneralData)
            'End If
        Catch ex As Exception
            dbcon.strmsg = ex.Message
            Return dbcon.strmsg
        End Try
        Return "Success"
    End Function
    Private Function AddUDOUpdate(ByVal SapCompany As SAPbobsCOM.Company) As String
        Try
            dtFrom = Date.ParseExact(txtstartdate.Text.Trim().Replace("-", "/"), "dd/MM/yyyy", CultureInfo.InvariantCulture)
            dtTo = Date.ParseExact(txtenddate.Text.Trim().Replace("-", "/"), "dd/MM/yyyy", CultureInfo.InvariantCulture)
            dbcon.objMainCompany = SapCompany
            Dim oGeneralService As SAPbobsCOM.GeneralService
            Dim oGeneralData As SAPbobsCOM.GeneralData
            Dim oGeneralParams As SAPbobsCOM.GeneralDataParams
            Dim oChild As SAPbobsCOM.GeneralData
            Dim oChildren As SAPbobsCOM.GeneralDataCollection
            Dim oCompanyService As SAPbobsCOM.CompanyService
            oCompanyService = dbcon.objMainCompany.GetCompanyService
            oGeneralService = oCompanyService.GetGeneralService("Z_HR_OTRAREQ")
            oGeneralData = oGeneralService.GetDataInterface(SAPbobsCOM.GeneralServiceDataInterfaces.gsGeneralData)
            oGeneralParams = oGeneralService.GetDataInterface(SAPbobsCOM.GeneralServiceDataInterfaces.gsGeneralDataParams)
            oGeneralParams.SetProperty("DocEntry", txtReqno.Text)
            oGeneralData = oGeneralService.GetByParams(oGeneralParams)
            If chkNew.Checked = True Then
                strNewStatus = "Y"
                oGeneralData.SetProperty("U_Z_TraCode", "")
            Else
                strNewStatus = "N"
                oGeneralData.SetProperty("U_Z_TraCode", ddltrip.SelectedItem.Text.Trim())
            End If
            Dim TrpName As String = txtfromloc.Text.Trim() & " - " & txttoloc.Text.Trim()
            oGeneralData.SetProperty("U_Z_TraName", TrpName.Trim())
            oGeneralData.SetProperty("U_Z_TraStLoc", txtfromloc.Text.Trim())
            oGeneralData.SetProperty("U_Z_TraEdLoc", txttoloc.Text.Trim())
            oGeneralData.SetProperty("U_Z_TraStDate", dtFrom)
            oGeneralData.SetProperty("U_Z_TraEndDate", dtTo)
            oGeneralData.SetProperty("U_Z_EmpComme", txtRemarks.Text.Trim())
            oGeneralData.SetProperty("U_Z_NewReq", strNewStatus)
            oGeneralData.SetProperty("U_Z_AppStatus", dbcon.DocApproval("TraReq", txtempid.Text.Trim()))
            oChildren = oGeneralData.Child("Z_HR_TRAREQ1")

            Dim strname, strcode, strutlamt, strbalamt As String
            Dim row1 As GridViewRow
            For Each row1 In grdExpenses.Rows
                strcode = CType(row1.FindControl("lblexpname"), Label).Text
                strname = CType(row1.FindControl("lblbtamt"), Label).Text
                strutlamt = CType(row1.FindControl("lblutlamt"), Label).Text
                strbalamt = CType(row1.FindControl("lblbalamt"), Label).Text
                oChild = oChildren.Add()
                oChild.SetProperty("U_Z_ExpName", strcode)
                oChild.SetProperty("U_Z_Amount", strname)
                oChild.SetProperty("U_Z_UtilAmt", strutlamt)
                oChild.SetProperty("U_Z_BalAmount", strbalamt)
            Next row1
            oGeneralService.Update(oGeneralData)
        Catch ex As Exception
            dbcon.strmsg = ex.Message
            Return dbcon.strmsg
        End Try
        Return "Success"
    End Function

    Protected Sub grdTravelRequest_PageIndexChanging(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewPageEventArgs) Handles grdTravelRequest.PageIndexChanging
        grdTravelRequest.PageIndex = e.NewPageIndex
        objEN.EmpId = ViewState("EmpId").ToString()
        PageLoadBind(objEN)
    End Sub
    Protected Sub btnUpdate_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnUpdate.Click
        System.Threading.Thread.Sleep(2000)
        If Session("UserCode") Is Nothing Or Session("SAPCompany") Is Nothing Then
            Response.Redirect("Login.aspx?sessionExpired=true", True)
        Else
            objEN.SapCompany = Session("SAPCompany")
            If Validation() = True Then
                objEN.DocEntry = txtReqno.Text.Trim()
                If objBL.UpdateTravelRequest(objEN) = True Then
                    If AddUDOUpdate(objEN.SapCompany) = "Success" Then
                        dbcon.strmsg = "alert('Travel Request Updated successfully...')"
                        mess(dbcon.strmsg)
                        objEN.EmpId = ViewState("EmpId").ToString()
                        PageLoadBind(objEN)
                        intTempID = dbcon.GetTemplateID("TraReq", objEN.EmpId)
                        If intTempID <> "0" Then
                            objEN.DocEntry = txtReqno.Text.Trim()
                            dbcon.UpdateApprovalRequired("@Z_HR_OTRAREQ", "DocEntry", objEN.DocEntry, "Y", intTempID)
                            dbcon.InitialMessage("Travel Request", objEN.DocEntry, dbcon.DocApproval("TraReq", txtempid.Text.Trim()), intTempID, txtempname.Text.Trim(), "TraReq", objEN.SapCompany)
                        Else
                            objEN.DocEntry = txtReqno.Text.Trim()
                            dbcon.UpdateApprovalRequired("@Z_HR_OTRAREQ", "DocEntry", objEN.DocEntry, "N", intTempID)
                        End If
                        panelview.Visible = True
                        panelnew.Visible = False
                    Else
                        dbcon.strmsg = "alert('" & dbcon.strmsg & "')"
                        mess(dbcon.strmsg)
                    End If
                End If
            End If
        End If
    End Sub

    Private Sub chkNew_CheckedChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles chkNew.CheckedChanged
        Try
            If chkNew.Checked = True Then
                ddltrip.SelectedIndex = 0
                ddltrip.Enabled = False
                txttripName.Enabled = True
                txttripName.Text = ""
            Else
                ddltrip.SelectedIndex = 0
                ddltrip.Enabled = True
                txttripName.Enabled = False
            End If
        Catch ex As Exception
            dbcon.strmsg = "alert('" & ex.Message & "')"
            mess(dbcon.strmsg)
        End Try
    End Sub
    Protected Sub lbtAppHistory_Click(ByVal sender As Object, ByVal e As EventArgs)
        Try
            If Session("UserCode") Is Nothing Or Session("SAPCompany") Is Nothing Then
                dbCon.strmsg = "alert('Your session is Expired...')"
                mess(dbCon.strmsg)
                Response.Redirect("Login.aspx?sessionExpired=true", True)
            Else
                Dim link As LinkButton = CType(sender, LinkButton)
                Dim gv As GridViewRow = CType((link.Parent.Parent), GridViewRow)
                Dim DocNo As LinkButton = CType(gv.FindControl("lbtndocnum"), LinkButton)
                LoadActivity(DocNo.Text.Trim(), "TraReq")
                ModalPopupExtender7.Show()
            End If
        Catch ex As Exception
            Throw ex
        End Try
    End Sub
    Private Sub LoadActivity(ByVal RefCode As String, ByVal DocType As String)
        Try
            dbCon.ds4 = dbCon.ViewHistory(RefCode, DocType)
            If dbCon.ds4.Tables(0).Rows.Count > 0 Then
                grdRequesttohr.DataSource = dbCon.ds4.Tables(0)
                grdRequesttohr.DataBind()
                Label1.Text = ""
            Else
                grdRequesttohr.DataBind()
                Label1.Text = "Approval History not found.."
            End If
        Catch ex As Exception
            Throw ex
        End Try
    End Sub
    Private Sub grdTravelRequest_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles grdTravelRequest.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim LiDocNo As LinkButton = CType(e.Row.FindControl("lbtndocnum"), LinkButton)
            Dim Liview As LinkButton = CType(e.Row.FindControl("lbtAppHistory"), LinkButton)
            Blflag = dbcon.WithDrawStatus("TraReq", LiDocNo.Text.Trim())
            If Blflag = True Then
                Liview.Visible = True
            Else
                Liview.Visible = False
            End If
        End If
    End Sub

    Private Sub btnWithdraw_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnWithdraw.Click
        Dim blValue As Boolean
        objEN.EmpId = Session("UserCode").ToString()
        objEN.DocEntry = txtReqno.Text.Trim()
        blValue = objBL.WithdrawRequest(objEN)
        If blValue = True Then
            dbcon.strmsg = "alert('Withdraw Travel Request Successfully...')"
            mess(dbcon.strmsg)
        Else
            dbcon.strmsg = "alert('Withdraw Travel Request failed...')"
            mess(dbcon.strmsg)
        End If
        PageLoadBind(objEN)
        panelview.Visible = True
        panelnew.Visible = False
    End Sub
    Private Sub grdAltEmployee_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles grdAltEmployee.RowDataBound
        txtpoptno.Text = ""
        txtpopunique.Text = ""
        txthidoption.Text = ""
        If e.Row.RowType = DataControlRowType.DataRow Then
            e.Row.Attributes.Add("onclick", "popupdisplay('AltEmp','" + (DataBinder.Eval(e.Row.DataItem, "U_Z_EMPID")).ToString().Trim() + "','" + (DataBinder.Eval(e.Row.DataItem, "U_Z_EMPNAME")).ToString().Trim() + "');")
        End If
    End Sub

    Protected Sub Btncallpop_ServerClick(ByVal sender As Object, ByVal e As System.EventArgs) Handles Btncallpop.ServerClick
        Dim str1, str2, str3 As String
        Try
            str1 = txtpopunique.Text.Trim()
            str2 = txtpoptno.Text.Trim()
            str3 = txttname.Text.Trim()
            If txthidoption.Text = "AltEmp" Then
                If txtpoptno.Text.Trim() <> "" Then
                    txtempid.Text = txtpopunique.Text.Trim()
                    txtempname.Text = txtpoptno.Text.Trim()
                    objEN.EmpId = txtempid.Text.Trim()
                    dbcon.dss4 = objBL.BindAltRequest(objEN)
                    If dbcon.dss4.Tables(0).Rows.Count > 0 Then
                        txtdept.Text = dbcon.dss4.Tables(0).Rows(0)("dept").ToString()
                        txtempid.Text = dbcon.dss4.Tables(0).Rows(0)("empID").ToString()
                        txtempname.Text = dbcon.dss4.Tables(0).Rows(0)("firstName").ToString() & " " & dbcon.dss4.Tables(0).Rows(0)("middleName").ToString() & " " & dbcon.dss4.Tables(0).Rows(0)("lastName").ToString()
                        txtposid.Text = dbcon.dss4.Tables(0).Rows(0)("U_Z_GrdCode").ToString()
                        txtposname.Text = dbcon.dss4.Tables(0).Rows(0)("U_Z_GrdName").ToString()
                        objEN.DeptCode = txtdept.Text.Trim()
                        If txtdept.Text.Trim() <> "" Then
                            txtdeptName.Text = objBL.Department(objEN)
                        End If
                    End If
                End If
            End If
        Catch ex As Exception
            DBConnectionDA.WriteError(ex.Message)
            dbcon.strmsg = "alert('" & ex.Message & "')"
            mess(dbcon.strmsg)
        End Try
    End Sub
End Class