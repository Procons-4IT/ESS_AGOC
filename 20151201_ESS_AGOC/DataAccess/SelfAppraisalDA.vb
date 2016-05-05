Imports System
Imports System.Web.UI.WebControls
Imports System.Data
Imports System.Data.SqlClient
Imports EN
Public Class SelfAppraisalDA
    Dim objen As SelfAppraisalEN = New SelfAppraisalEN()
    Dim objDA As DBConnectionDA = New DBConnectionDA()
    Public Sub New()
        objDA.con = New SqlConnection(objDA.GetConnection)
    End Sub
    Public Function BindPeriod() As DataSet
        Try
            objen.StrQry = "SELECT U_Z_PerCode AS 'Code',U_Z_PerDesc AS 'Name' FROM [@Z_HR_PERAPP] order by Code Desc;"
            objDA.sqlda = New SqlDataAdapter(objen.StrQry, objDA.con)
            objDA.sqlda.Fill(objDA.ds1)
        Catch ex As Exception
            DBConnectionDA.WriteError(ex.Message)
        End Try
        Return objDA.ds1
    End Function
    Public Function mainGvbind(ByVal objen As SelfAppraisalEN) As DataSet
        Try
            objen.StrQry = "select DocEntry,U_Z_EmpId,U_Z_EmpName,convert(varchar(11),U_Z_Date,103) as U_Z_Date,U_Z_Period,case U_Z_Status when 'D' then 'Draft' when 'F' then 'Approved'"
            objen.StrQry += " when 'S'then '2nd Level Approval' when 'L' then 'Closed' else 'HR Canceled' end as U_Z_Status,case U_Z_WStatus when 'DR' then 'Draft' when 'HR' then 'HR Approved'"
            objen.StrQry += " when 'SM'then 'Second Level Approved' when 'LM' then 'First Level Approved' when 'SE' then 'SelfApproved' else 'HR Canceled'  end as 'U_Z_WStatus',U_Z_GStatus,U_Z_GRemarks,"
            objen.StrQry += " convert(varchar(11),U_Z_GDate,101) as U_Z_GDate,U_Z_GNo  from [@Z_HR_OSEAPP] where U_Z_EmpId=" & objen.EmpId & " Order by DocEntry Desc"
            objDA.sqlda = New SqlDataAdapter(objen.StrQry, objDA.con)
            objDA.sqlda.Fill(objDA.ds)
        Catch ex As Exception
            DBConnectionDA.WriteError(ex.Message)
        End Try
        Return objDA.ds
    End Function
    Public Function PopulateAppraisal(ByVal objen As SelfAppraisalEN) As DataSet
        Try
            If objen.HomeEmpId <> "" Then
                objen.StrQry = "select DocEntry, U_Z_EmpId,U_Z_EmpName,convert(varchar(11),U_Z_Date,103) as U_Z_Date,U_Z_Period,U_Z_BSelfRemark,U_Z_PSelfRemark,U_Z_CSelfRemark,"
                objen.StrQry += "U_Z_CMgrRemark,U_Z_PMgrRemark,U_Z_BMgrRemark,U_Z_CSMrRemark,U_Z_PSMrRemark,U_Z_BSMrRemark, case U_Z_Status when 'D' then 'Draft' when 'F' then 'Approved' when 'S' then '2nd Level Approval'"
                objen.StrQry += " when 'L' then 'Closed' else 'HR Canceled' end as U_Z_Status,U_Z_BHrRemark,U_Z_PHrRemark,U_Z_CHrRemark,case U_Z_WStatus when 'DR' then 'Draft' when 'HR' then 'HR Approved' when 'SM'then 'Sr.Manager Approved' when 'LM' then 'LineManager Approved' when 'SE' then 'SelfApproved' else 'HR Canceled'  end as 'U_Z_WStatus',U_Z_GStatus,U_Z_GRemarks,convert(varchar(11),U_Z_GDate,101) as U_Z_GDate,U_Z_GNo   from [@Z_HR_OSEAPP] where U_Z_EmpId='" & objen.HomeEmpId & "' and DocEntry='" & objen.AppraisalNumber & "'"
            Else
                objen.StrQry = "select DocEntry, U_Z_EmpId,U_Z_EmpName,convert(varchar(11),U_Z_Date,103) as U_Z_Date,U_Z_Period,U_Z_BSelfRemark,U_Z_PSelfRemark,U_Z_CSelfRemark,"
                objen.StrQry += "U_Z_CMgrRemark,U_Z_PMgrRemark,U_Z_BMgrRemark,U_Z_CSMrRemark,U_Z_PSMrRemark,U_Z_BSMrRemark, case U_Z_Status when 'D' then 'Draft' when 'F' then 'Approved' when 'S' then '2nd Level Approval'"
                objen.StrQry += " when 'L' then 'Closed' else 'HR Canceled' end as U_Z_Status,U_Z_BHrRemark,U_Z_PHrRemark,U_Z_CHrRemark,case U_Z_WStatus when 'DR' then 'Draft' when 'HR' then 'HR Approved' when 'SM'then 'Sr.Manager Approved' when 'LM' then 'LineManager Approved' when 'SE' then 'SelfApproved' else 'HR Canceled'  end as 'U_Z_WStatus',U_Z_GStatus,U_Z_GRemarks,convert(varchar(11),U_Z_GDate,101) as U_Z_GDate,U_Z_GNo   from [@Z_HR_OSEAPP] where U_Z_EmpId='" & objen.EmpId & "' and DocEntry='" & objen.AppraisalNumber & "'"
            End If
            objDA.sqlda = New SqlDataAdapter(objen.StrQry, objDA.con)
            objDA.sqlda.Fill(objDA.dss)
        Catch ex As Exception
            DBConnectionDA.WriteError(ex.Message)
        End Try
        Return objDA.dss
    End Function
    Public Function BusinessObjectve(ByVal objen As SelfAppraisalEN) As DataSet
        Try
            objen.StrQry = "  select U_Z_BussCode ,U_Z_BussDesc,U_Z_BussMgrRate ,U_Z_BussSelfRate,U_Z_BussWeight,LineId,U_Z_BussSMRate,U_Z_SelfRaCode,U_Z_SMRaCode,U_Z_MgrRaCode,""U_Z_SelfRemark"",""U_Z_MgrRemark"",""U_Z_SrRemark"",U_Z_BussSelfGrade,U_Z_BussMgrGrade,U_Z_BussSMGrade  from [@Z_HR_SEAPP1] where DocEntry='" & objen.AppraisalNumber & "'"
            objDA.sqlda = New SqlDataAdapter(objen.StrQry, objDA.con)
            objDA.sqlda.Fill(objDA.dss1)
        Catch ex As Exception
            DBConnectionDA.WriteError(ex.Message)
        End Try
        Return objDA.dss1
    End Function
    Public Function PeopleObjective(ByVal objen As SelfAppraisalEN) As DataSet
        Try
            objen.StrQry = "select U_Z_PeopleCode,U_Z_PeopleDesc,U_Z_PeopleCat,U_Z_PeoWeight,U_Z_PeoSelfRate,U_Z_PeoMgrRate,LineId,U_Z_PeoSMRate,U_Z_SelfRaCode,U_Z_SMRaCode,U_Z_MgrRaCode,""U_Z_SelfRemark"",""U_Z_MgrRemark"",""U_Z_SrRemark"",U_Z_PeoSelfGrade,U_Z_PeoMgrGrade,U_Z_PeoSMGrade,T1.U_Z_CatName from [@Z_HR_SEAPP2] T0 left join [@Z_HR_PECAT] T1 ON  T0.U_Z_PeopleCat=T1.U_Z_CatCode where T0.DocEntry='" & objen.AppraisalNumber & "'"
            objDA.sqlda = New SqlDataAdapter(objen.StrQry, objDA.con)
            objDA.sqlda.Fill(objDA.dss2)
        Catch ex As Exception
            DBConnectionDA.WriteError(ex.Message)
        End Try
        Return objDA.dss2
    End Function
    Public Function CompetenceObjective(ByVal objen As SelfAppraisalEN) As DataSet
        Try
            objen.StrQry = "select T0.U_Z_CompCode,T0.U_Z_CompDesc,T0.U_Z_CompMgrRate,T0.U_Z_CompSelfRate,T0.U_Z_CompWeight,isnull(T0.U_Z_CompLevel,0) as U_Z_CompLevel,T2.U_Z_CompLevel As 'CurrentLevel',T0.U_Z_CompSMRate,T0.LineId,T0.U_Z_SelfRaCode,T0.U_Z_SMRaCode,T0.U_Z_MgrRaCode,""U_Z_SelfRemark"",""U_Z_MgrRemark"",""U_Z_SrRemark"",U_Z_CompSelfGrade,U_Z_CompMgrGrade,U_Z_CompSMGrade  from [@Z_HR_SEAPP3] T0 Join [@Z_HR_OSEAPP] T1 ON T1.DocEntry = T0.DocEntry Left Outer Join [@Z_HR_ECOLVL] T2 On T1.U_Z_EmpId = T2.U_Z_HREmpID and T2.U_Z_CompCode =T0.U_Z_CompCode  Where T1.DocEntry='" & objen.AppraisalNumber & "'"
            objDA.sqlda = New SqlDataAdapter(objen.StrQry, objDA.con)
            objDA.sqlda.Fill(objDA.dss3)
        Catch ex As Exception
            DBConnectionDA.WriteError(ex.Message)
        End Try
        Return objDA.dss3
    End Function
    Public Function HRFinalRating(ByVal objen As SelfAppraisalEN) As DataSet
        Try
            objen.StrQry = "Select  DocEntry,LineId, U_Z_CompType,(Select Case When SUM(U_Z_BussSMRate) > 0 Then (SUM(U_Z_BussMgrRate) +  SUM(U_Z_BussSMRate))/2 Else SUM(U_Z_BussMgrRate) End "
            objen.StrQry += " From [@Z_HR_SEAPP1] Where DocEntry = '" & objen.AppraisalNumber & "') As U_Z_AvgComp ,U_Z_HRComp From [@Z_HR_SEAPP4] Where DocEntry = '" & objen.AppraisalNumber & "' And LineId = 1"
            objen.StrQry += " Union All "
            objen.StrQry += "Select  DocEntry,LineId, U_Z_CompType,(Select Case When SUM(U_Z_PeoSMRate) > 0 Then (SUM(U_Z_PeoMgrRate) +  SUM(U_Z_PeoSMRate))/2 Else SUM(U_Z_PeoMgrRate) End "
            objen.StrQry += " From [@Z_HR_SEAPP2] Where DocEntry = '" & objen.AppraisalNumber & "' ) As U_Z_AvgComp ,U_Z_HRComp From [@Z_HR_SEAPP4] Where DocEntry = '" & objen.AppraisalNumber & "' And LineId = 2"
            objen.StrQry += " Union All "
            objen.StrQry += "Select  DocEntry,LineId, U_Z_CompType,(Select Case When SUM(U_Z_CompSMRate) > 0 Then (SUM(U_Z_CompMgrRate) +  SUM(U_Z_CompSMRate))/2 Else SUM(U_Z_CompMgrRate) End "
            objen.StrQry += " From [@Z_HR_SEAPP3] Where DocEntry = '" & objen.AppraisalNumber & "' ) As U_Z_AvgComp ,U_Z_HRComp From [@Z_HR_SEAPP4] Where DocEntry = '" & objen.AppraisalNumber & "' And LineId = 3 "
            objDA.sqlda = New SqlDataAdapter(objen.StrQry, objDA.con)
            objDA.sqlda.Fill(objDA.dss4)
        Catch ex As Exception
            DBConnectionDA.WriteError(ex.Message)
        End Try
        Return objDA.dss4
    End Function
    Public Function PopulateEmployee(ByVal objen As SelfAppraisalEN) As DataSet
        Try
            objen.StrQry = "Select * from OHEM where empID=" & objen.EmpId & ""
            objDA.sqlda = New SqlDataAdapter(objen.StrQry, objDA.con)
            objDA.sqlda.Fill(objDA.ds)
        Catch ex As Exception
            DBConnectionDA.WriteError(ex.Message)
        End Try
        Return objDA.ds
    End Function

    Public Sub UpdateSelfAppHeader(ByVal objen As SelfAppraisalEN)
        Try
            objen.StrQry = "Update [@Z_HR_OSEAPP] set U_Z_SCkApp='" & objen.CheckStatus & "', U_Z_WStatus='" & objen.Status & "',U_Z_BSelfRemark='" & objen.BusinessRemarks & "' ,  U_Z_PSelfRemark='" & objen.PeopleRemarks & "' ,  U_Z_CSelfRemark='" & objen.CompRemarks & "' where DocEntry='" & objen.AppraisalNumber & "'"
            objDA.cmd = New SqlCommand(objen.StrQry, objDA.con)
            objDA.con.Open()
            objDA.cmd.ExecuteNonQuery()
            objDA.con.Close()
        Catch ex As Exception
            DBConnectionDA.WriteError(ex.Message)
        End Try
    End Sub
    Public Sub UpdateSelfAppBusiness(ByVal objen As SelfAppraisalEN)
        Try
            objen.StrQry = "Update [@Z_HR_SEAPP1] set U_Z_SelfRaCode='" & objen.SelfRating & "', U_Z_BussSelfRate=" & objen.Amount & ",U_Z_SelfRemark='" & objen.BusinessRemarks & "',U_Z_BussSelfGrade='" & objen.BussSelfGrade & "' where DocEntry='" & objen.AppraisalNumber & "' and LineId=" & objen.LineNo & ""
            objDA.cmd = New SqlCommand(objen.StrQry, objDA.con)
            objDA.con.Open()
            objDA.cmd.ExecuteNonQuery()
            objDA.con.Close()
        Catch ex As Exception
            DBConnectionDA.WriteError(ex.Message)
        End Try
    End Sub
    Public Sub UpdateSelfAppPeople(ByVal objen As SelfAppraisalEN)
        Try
            objen.StrQry = "Update [@Z_HR_SEAPP2] set U_Z_SelfRaCode='" & objen.SelfRating & "',U_Z_PeoSelfRate=" & objen.Amount & ",U_Z_SelfRemark='" & objen.PeopleRemarks & "',U_Z_PeoSelfGrade='" & objen.PeoSelfGrade & "' where DocEntry='" & objen.AppraisalNumber & "' and LineId=" & objen.LineNo & ""
            objDA.cmd = New SqlCommand(objen.StrQry, objDA.con)
            objDA.con.Open()
            objDA.cmd.ExecuteNonQuery()
            objDA.con.Close()
        Catch ex As Exception
            DBConnectionDA.WriteError(ex.Message)
        End Try
    End Sub
    Public Sub UpdateSelfAppCompetence(ByVal objen As SelfAppraisalEN)
        Try
            objen.StrQry = "Update [@Z_HR_SEAPP3] set U_Z_SelfRaCode='" & objen.SelfRating & "',U_Z_CompSelfRate=" & objen.Amount & ",U_Z_SelfRemark='" & objen.CompRemarks & "',U_Z_CompSelfGrade='" & objen.CompSelfGrade & "' where DocEntry='" & objen.AppraisalNumber & "' and LineId=" & objen.LineNo & ""
            objDA.cmd = New SqlCommand(objen.StrQry, objDA.con)
            objDA.con.Open()
            objDA.cmd.ExecuteNonQuery()
            objDA.con.Close()
        Catch ex As Exception
            DBConnectionDA.WriteError(ex.Message)
        End Try
    End Sub
    Public Sub UpdateLineMgrAppGrade(ByVal objen As SelfAppraisalEN)
        Dim status, strgrade As String
        Try
            objDA.con.Open()
            objDA.cmd = New SqlCommand("Select COALESCE(SUM (U_Z_BussSelfRate), 0) from [@Z_HR_SEAPP1] where DocEntry=" & objen.AppraisalNumber & "", objDA.con)
            objDA.cmd.CommandType = CommandType.Text
            status = objDA.cmd.ExecuteScalar()
            objDA.con.Close()
            If CDbl(status) > 0 And status <> "" Then
                strgrade = objDA.GetAppraisalGrade(status)
                objen.StrQry = "Update ""@Z_HR_SEAPP1"" set ""U_Z_BusSelfTotGrade""='" & strgrade & "' where ""DocEntry""='" & objen.AppraisalNumber & "'"
                objDA.cmd = New SqlCommand(objen.StrQry, objDA.con)
                objDA.con.Open()
                objDA.cmd.ExecuteNonQuery()
                objDA.con.Close()
            End If

            objDA.con.Open()
            objDA.cmd = New SqlCommand("Select COALESCE(SUM (U_Z_PeoSelfRate), 0)  from [@Z_HR_SEAPP2] where DocEntry=" & objen.AppraisalNumber & "", objDA.con)
            objDA.cmd.CommandType = CommandType.Text
            status = objDA.cmd.ExecuteScalar()
            objDA.con.Close()

            If CDbl(status) > 0 And status <> "" Then
                strgrade = objDA.GetAppraisalGrade(status)
                objen.StrQry = "Update ""@Z_HR_SEAPP2"" set ""U_Z_PeoSelfTotGrade""='" & strgrade & "' where ""DocEntry""='" & objen.AppraisalNumber & "'"
                objDA.cmd = New SqlCommand(objen.StrQry, objDA.con)
                objDA.con.Open()
                objDA.cmd.ExecuteNonQuery()
                objDA.con.Close()
            End If
            objDA.con.Open()
            objDA.cmd = New SqlCommand("Select COALESCE(SUM (U_Z_CompSelfRate), 0) from [@Z_HR_SEAPP3] where DocEntry=" & objen.AppraisalNumber & "", objDA.con)
            objDA.cmd.CommandType = CommandType.Text
            status = objDA.cmd.ExecuteScalar()
            objDA.con.Close()
            If CDbl(status) > 0 And status <> "" Then
                strgrade = objDA.GetAppraisalGrade(status)
                objen.StrQry = "Update ""@Z_HR_SEAPP3"" set ""U_Z_CoSelfTotGrade""='" & strgrade & "' where ""DocEntry""='" & objen.AppraisalNumber & "'"
                objDA.cmd = New SqlCommand(objen.StrQry, objDA.con)
                objDA.con.Open()
                objDA.cmd.ExecuteNonQuery()
                objDA.con.Close()
            End If

         
        Catch ex As Exception
            DBConnectionDA.WriteError(ex.Message)
            Throw ex
        End Try
    End Sub
    Public Function BindAppraisalRating() As DataSet
        Try
            objen.StrQry = "Select U_Z_RateCode As Code,U_Z_RateName As Name From [@Z_HR_ORATE]"
            objDA.sqlda = New SqlDataAdapter(objen.StrQry, objDA.con)
            objDA.sqlda.Fill(objDA.ds2)
        Catch ex As Exception
            DBConnectionDA.WriteError(ex.Message)
        End Try
        Return objDA.ds2
    End Function
    Public Sub UpdateGrievence(ByVal objen As SelfAppraisalEN)
        Try
            objen.StrQry = "Update [@Z_HR_OSEAPP] set U_Z_GStatus='" & objen.strGrvStaus & "',U_Z_GDate=getdate(),U_Z_GNo='" & objen.GrvNo & "',U_Z_GRemarks='" & objen.GrvRemarks & "' where DocEntry='" & objen.AppraisalNumber & "'"
            objDA.cmd = New SqlCommand(objen.StrQry, objDA.con)
            objDA.con.Open()
            objDA.cmd.ExecuteNonQuery()
            objDA.con.Close()
        Catch ex As Exception
            DBConnectionDA.WriteError(ex.Message)
        End Try
     
    End Sub
    Public Sub UpdateGrievenceAccepted(ByVal objen As SelfAppraisalEN)
        Try
            objen.StrQry = "Update [@Z_HR_OSEAPP] set U_Z_GStatus='" & objen.strGrvStaus & "' where DocEntry='" & objen.AppraisalNumber & "'"
            objDA.cmd = New SqlCommand(objen.StrQry, objDA.con)
            objDA.con.Open()
            objDA.cmd.ExecuteNonQuery()
            objDA.con.Close()
        Catch ex As Exception
            DBConnectionDA.WriteError(ex.Message)
        End Try
    End Sub
    Public Function ddlChangedRating(ByVal objen As SelfAppraisalEN) As DataSet
        Try
            objDA.ds.Clear()
            objen.StrQry = "Select * from [@Z_HR_ORATE] where U_Z_RateCode='" & objen.Ratings & "'"
            objDA.sqlda = New SqlDataAdapter(objen.StrQry, objDA.con)
            objDA.sqlda.Fill(objDA.ds)
            Return objDA.ds
        Catch ex As Exception
            DBConnectionDA.WriteError(ex.Message)
        End Try
    End Function
    Public Function ddlPeopleChangedRating(ByVal objen As SelfAppraisalEN) As DataSet
        Try
            objDA.ds.Clear()
            objen.StrQry = "Select * from [@Z_HR_ORATE] where U_Z_RateCode='" & objen.Ratings & "'"
            objDA.sqlda = New SqlDataAdapter(objen.StrQry, objDA.con)
            objDA.sqlda.Fill(objDA.ds)
            Return objDA.ds
        Catch ex As Exception
            DBConnectionDA.WriteError(ex.Message)
        End Try
    End Function
    Public Function GetHREmail(ByVal Empid As String) As String
        Dim status As String
        Try
            objDA.con.Open()
            objDA.cmd = New SqlCommand("SELECT ISNULL(""dept"",'') FROM OHEM  WHERE ""empID"" =" & Empid & "", objDA.con)
            objDA.cmd.CommandType = CommandType.Text
            status = objDA.cmd.ExecuteScalar()
            objDA.con.Close()
            If status <> "" Then
                objDA.con.Open()
                objDA.cmd = New SqlCommand("SELECT ISNULL(""U_Z_ReqHR"",'') FROM OUDP  WHERE ""Code"" =" & status & "", objDA.con)
                objDA.cmd.CommandType = CommandType.Text
                status = objDA.cmd.ExecuteScalar()
                objDA.con.Close()
            End If
            Return status
        Catch ex As Exception
            DBConnectionDA.WriteError(ex.Message)
            Throw ex
        End Try
    End Function
End Class
