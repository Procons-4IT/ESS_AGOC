Imports System
Imports DataAccess
Imports EN
Public Class LoaneeExpenseBL
    Dim objen As ClaimRequestEN = New ClaimRequestEN()
    Dim objDA As LoaneeExpenseDA = New LoaneeExpenseDA()
    Public Function PageLoadBind(ByVal objen As ClaimRequestEN) As DataSet
        Try
            Return objDA.PageLoadBind(objen)
        Catch ex As Exception
            Throw ex
        End Try
    End Function
    Public Function BindTravelbyEmp(ByVal objen As ClaimRequestEN) As DataSet
        Try
            Return objDA.BindTravelbyEmp(objen)
        Catch ex As Exception
            Throw ex
        End Try
    End Function
    Public Function DropDownBind() As DataSet
        Try
            Return objDA.DropDownBind()
        Catch ex As Exception
            Throw ex
        End Try
    End Function
    Public Function GetCardCode(ByVal EmpId As String) As String
        Try
            Return objDA.GetCardCode(EmpId)
        Catch ex As Exception
            Throw ex
        End Try
    End Function
    Public Function AllowanceCode(ByVal objen As ClaimRequestEN) As DataSet
        Try
            Return objDA.AllowanceCode(objen)
        Catch ex As Exception
            Throw ex
        End Try
    End Function
    Public Function LocalCurrency(ByVal objen As ClaimRequestEN) As String
        Try
            Return objDA.LocalCurrency(objen)
        Catch ex As Exception
            Throw ex
        End Try
    End Function
    Public Function TargetPath() As String
        Try
            Return objDA.TargetPath()
        Catch ex As Exception
            Throw ex
        End Try
    End Function
    Public Function PopulateRequest(ByVal objen As ClaimRequestEN) As DataSet
        Try
            Return objDA.PopulateRequest(objen)
        Catch ex As Exception
            Throw ex
        End Try
    End Function
    Public Function DeleteRequest(ByVal objen As ClaimRequestEN) As String
        Try
            Return objDA.DeleteRequest(objen)
        Catch ex As Exception
            Throw ex
        End Try
    End Function
    Public Function PopulateTANo(ByVal EmpId As String) As String
        Try
            Return objDA.PopulateTANo(EmpId)
        Catch ex As Exception
            Throw ex
        End Try
    End Function
    Public Function NewRequestBind(ByVal objen As ClaimRequestEN) As DataSet
        Try
            Return objDA.NewRequestBind(objen)
        Catch ex As Exception
            Throw ex
        End Try
    End Function
    Public Function DeleteTempTable(ByVal objen As ClaimRequestEN) As String
        Try
            Return objDA.DeleteTempTable(objen)
        Catch ex As Exception
            Throw ex
        End Try
    End Function
    Public Function PopulateExistingDocument(ByVal objen As ClaimRequestEN) As String
        Try
            Return objDA.PopulateExistingDocument(objen)
        Catch ex As Exception
            Throw ex
        End Try
    End Function
    Public Function PopulateHeader(ByVal objen As ClaimRequestEN) As DataSet
        Try
            Return objDA.PopulateHeader(objen)
        Catch ex As Exception
            Throw ex
        End Try
    End Function
    Public Function DeleteExpenses(ByVal objen As ClaimRequestEN) As String
        Try
            Return objDA.DeleteExpenses(objen)
        Catch ex As Exception
            Throw ex
        End Try
    End Function
    Public Function BindDistriRule() As DataSet
        Try
            Return objDA.BindDistriRule()
        Catch ex As Exception
            Throw ex
        End Try
    End Function
    Public Function BindDistriRule1(ByVal EmpId As String) As String
        Try
            Return objDA.BindDistriRule1(EmpId)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function GetExcRate(ByVal TransCur As String, ByVal TrsDate As Date) As Double
        Try
            Return objDA.GetExcRate(TransCur, TrsDate)
        Catch ex As Exception
            Throw ex
        End Try
    End Function
    Public Function GetHolidayCode(ByVal EmpId As String) As String
        Try
            Return objDA.GetHolidayCode(EmpId)
        Catch ex As Exception
            Throw ex
        End Try
    End Function
    Public Function GetWeekdays(ByVal Holidays As String, dtDate As Date, SAPCompany As SAPbobsCOM.Company) As String
        Try
            Return objDA.GetWeekdays(Holidays, dtDate, SAPCompany)
        Catch ex As Exception
            Throw ex
        End Try
    End Function
    Public Function ValidateExpenses(ByVal Expenses As String, dtDate As Date, ByVal Empid As String, SAPCompany As SAPbobsCOM.Company) As Boolean
        Try
            Return objDA.ValidateExpenses(Expenses, dtDate, Empid, SAPCompany)
        Catch ex As Exception
            Throw ex
        End Try
    End Function
End Class
