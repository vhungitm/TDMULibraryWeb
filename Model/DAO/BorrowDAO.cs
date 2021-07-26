using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient;
using Model.EF;

namespace Model.DAO
{
    public class BorrowDAO
    {
        DBContext db;

        public BorrowDAO()
        {
            db = new DBContext();
        }

        public int Count(long id, string student, string staff, string book, string borrowDate, string returnDate, int status)
        {
            SqlParameter[] sqlParameters = new SqlParameter[]
            {
                new SqlParameter("Id", id),
                new SqlParameter("Student", student),
                new SqlParameter("Staff", staff),
                new SqlParameter("Book", book),
                new SqlParameter("BorrowDate", borrowDate),
                new SqlParameter("ReturnDate", returnDate),
                new SqlParameter("Status", status)
            };

            return db.Database.SqlQuery<int>("uspCountBorrow @Id, @Student, @Staff, @Book, @BorrowDate, @ReturnDate, @Status", sqlParameters).SingleOrDefault();
        }

        public List<Borrow> Gets(long id, string student, string staff, string book, string borrowDate, string returnDate, int status, int page, int pageSize)
        {
            SqlParameter[] sqlParameters = new SqlParameter[]
            {
                new SqlParameter("Id", id),
                 new SqlParameter("Student", student),
                new SqlParameter("Staff", staff),
                new SqlParameter("Book", book),
                new SqlParameter("BorrowDate", borrowDate),
                new SqlParameter("ReturnDate", returnDate),
                new SqlParameter("Status", status),
                new SqlParameter("Page", page),
                new SqlParameter("PageSize", pageSize)
            };

            return db.Database.SqlQuery<Borrow>("uspGetBorrows @Id, @Student, @Staff, @Book, @BorrowDate, @ReturnDate, @Status, @Page, @PageSize", sqlParameters).ToList();
        }

        public Borrow Get(long id)
        {
            SqlParameter sqlParameter = new SqlParameter("Id", id);

            return db.Database.SqlQuery<Borrow>("uspGetBorrow @Id", sqlParameter).SingleOrDefault();
        }

        public int[] GetQuantity(string startDate, string endDate, int type)
        {
            SqlParameter[] sqlParameters = new SqlParameter[]
            {
                new SqlParameter("StartDate", startDate == "" ? (DateTime.Now.Year + "-" + DateTime.Now.Month + "-" + DateTime.Now.Day) : startDate),
                new SqlParameter("EndDate", endDate == "" ? (DateTime.Now.Year + "-" + DateTime.Now.Month + "-" + DateTime.Now.Day) : endDate),
                new SqlParameter("Type", type)
            };

            return db.Database.SqlQuery<int>("uspGetBorrowQuantity @StartDate, @EndDate, @Type", sqlParameters).ToArray();
        }

        public List<TopBook> GetTopBook (int top, string startDate, string endDate, int type)
        {
            SqlParameter[] sqlParameters = new SqlParameter[]
            {
                new SqlParameter("Top", top),
                new SqlParameter("StartDate", startDate == "" ? (DateTime.Now.Year + "-" + DateTime.Now.Month + "-" + DateTime.Now.Day) : startDate),
                new SqlParameter("EndDate", endDate == "" ? (DateTime.Now.Year + "-" + DateTime.Now.Month + "-" + DateTime.Now.Day) : endDate),
                new SqlParameter("Type", type)
            };

            return db.Database.SqlQuery<TopBook>("uspGetTopBook @Top, @StartDate, @EndDate, @Type", sqlParameters).ToList();
        }

        public List<TopStudent> GetTopStudent(int top, string startDate, string endDate, int type)
        {
            SqlParameter[] sqlParameters = new SqlParameter[]
            {
                new SqlParameter("Top", top),
                new SqlParameter("StartDate", startDate == "" ? (DateTime.Now.Year + "-" + DateTime.Now.Month + "-" + DateTime.Now.Day) : startDate),
                new SqlParameter("EndDate", endDate == "" ? (DateTime.Now.Year + "-" + DateTime.Now.Month + "-" + DateTime.Now.Day) : endDate),
                new SqlParameter("Type", type)
            };

            return db.Database.SqlQuery<TopStudent>("uspGetTopStudent @Top, @StartDate, @EndDate, @Type", sqlParameters).ToList();
        }

        public int Insert(Borrow model)
        {
            SqlParameter[] sqlParameters = new SqlParameter[]
            {
                new SqlParameter("StudentId", model.StudentId),
                new SqlParameter("StaffId", model.StaffId),
                new SqlParameter("BookId", model.BookId),
                new SqlParameter("ReturnDate", model.ReturnDate == null ? "" : model.ReturnDate),
                new SqlParameter("Status", model.Status),
            };

            return db.Database.SqlQuery<int>("uspInsertBorrow @StudentId, @StaffId, @BookId, @ReturnDate, @Status", sqlParameters).SingleOrDefault();
        }

        public int Update(Borrow model)
        {
            SqlParameter[] sqlParameters = new SqlParameter[]
            {
                new SqlParameter("Id", model.Id),
                new SqlParameter("StudentId", model.StudentId),
                new SqlParameter("StaffId", model.StaffId),
                new SqlParameter("BookId", model.BookId),
                new SqlParameter("BorrowDate", model.BorrowDate),
                new SqlParameter("ReturnDate", model.ReturnDate == null ? "" : model.ReturnDate),
                new SqlParameter("Status", model.Status)
            };

            return db.Database.SqlQuery<int>("uspUpdateBorrow @Id,  @StudentId, @StaffId, @BookId, @BorrowDate, @ReturnDate, @Status", sqlParameters).SingleOrDefault();
        }

        public int UpdateStatus(Borrow model)
        {
            SqlParameter[] sqlParameters = new SqlParameter[]
            {
                new SqlParameter("Id", model.Id),
                new SqlParameter("Status", model.Status)
            };

            return db.Database.SqlQuery<int>("uspUpdateBorrowStatus @Id, @Status", sqlParameters).SingleOrDefault();
        }

        public int Delete(long id)
        {
            SqlParameter sqlParameter = new SqlParameter("Id", id);

            return db.Database.SqlQuery<int>("uspDeleteBorrow @Id", sqlParameter).SingleOrDefault();
        }
    }
}
