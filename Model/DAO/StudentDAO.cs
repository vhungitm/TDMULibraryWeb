using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient;
using Model.EF;

namespace Model.DAO
{
    public class StudentDAO
    {
        DBContext db;

        public StudentDAO()
        {
            db = new DBContext();
        }

        public int Count(string key, int status)
        {
            SqlParameter[] sqlParameters = new SqlParameter[]
            {
                new SqlParameter("Key", key),
                new SqlParameter("Status", status)
            };

            return db.Database.SqlQuery<int>("uspCountStudent @Key, @Status", sqlParameters).SingleOrDefault();
        }

        public List<Student> Gets(string key, int status, int page, int pageSize)
        {
            SqlParameter[] sqlParameters = new SqlParameter[]
            {
                new SqlParameter("Key", key),
                new SqlParameter("Status", status),
                new SqlParameter("Page", page),
                new SqlParameter("PageSize", pageSize)
            };

            return db.Database.SqlQuery<Student>("uspGetStudents @Key, @Status, @Page, @PageSize", sqlParameters).ToList();
        }

        public Student Get(string id)
        {
            SqlParameter sqlParameter = new SqlParameter("Id", id);

            return db.Database.SqlQuery<Student>("uspGetStudent @Id", sqlParameter).SingleOrDefault();
        }

        public int Insert(Student model)
        {
            SqlParameter[] sqlParameters = new SqlParameter[]
            {
                new SqlParameter("Id", model.Id),
                new SqlParameter("Password", model.Password),
                new SqlParameter("Avatar", model.Avatar),
                new SqlParameter("FullName", model.FullName),
                new SqlParameter("Gender", model.Gender),
                new SqlParameter("Birthday", model.Birthday),
                new SqlParameter("Address", model.Address),
                new SqlParameter("Phone", model.Phone),
                new SqlParameter("Email", model.Email),
                new SqlParameter("Class", model.Class),
                new SqlParameter("Status", model.Status)
            };

            return db.Database.SqlQuery<int>("uspInsertStudent @Id, @Password, @Avatar, @FullName, @Gender, @Birthday, @Address, @Phone, @Email, @Class, @Status", sqlParameters).SingleOrDefault();
        }

        public int Update(Student model)
        {
            SqlParameter[] sqlParameters = new SqlParameter[]
            {
                new SqlParameter("Id", model.Id),
                new SqlParameter("Password", model.Password),
                new SqlParameter("Avatar", model.Avatar),
                new SqlParameter("FullName", model.FullName),
                new SqlParameter("Gender", model.Gender),
                new SqlParameter("Birthday", model.Birthday),
                new SqlParameter("Address", model.Address),
                new SqlParameter("Phone", model.Phone),
                new SqlParameter("Email", model.Email),
                new SqlParameter("Class", model.Class),
                new SqlParameter("Status", model.Status)
            };

            return db.Database.SqlQuery<int>("uspUpdateStudent @Id, @Password, @Avatar, @FullName, @Gender, @Birthday, @Address, @Phone, @Email, @Class, @Status", sqlParameters).SingleOrDefault();
        }

        public int UpdateStatus(string id)
        {
            SqlParameter sqlParameter = new SqlParameter("Id", id);

            return db.Database.SqlQuery<int>("uspUpdateStudentStatus @Id", sqlParameter).SingleOrDefault();
        }

        public int Delete(string id)
        {
            SqlParameter sqlParameter = new SqlParameter("Id", id);

            return db.Database.SqlQuery<int>("uspDeleteStudent @Id", sqlParameter).SingleOrDefault();
        }

        public int Login(string username, string password)
        {
            int type = 0;

            SqlParameter[] sqlParameters = new SqlParameter[]
            {
                new SqlParameter("Username", username),
                new SqlParameter("Password", password),
                new SqlParameter("Type", type)
            };

            return db.Database.SqlQuery<int>("uspLogin @Username, @Password, @Type", sqlParameters).SingleOrDefault();
        }
    }
}
