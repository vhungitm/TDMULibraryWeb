using System;
using System.Collections.Generic;
using System.Linq;
using Model.EF;
using System.Data.SqlClient;

namespace Model.DAO
{
    public class FeedbackDAO
    {
        DBContext db;
        public FeedbackDAO()
        {
            db = new DBContext();
        }

        public int Count(int status)
        {
            SqlParameter sqlParameter = new SqlParameter("Status", status);

            return db.Database.SqlQuery<int>("uspCountFeedback @Status", sqlParameter).SingleOrDefault();
        }

        public List<Feedback> Gets(int status, int page, int pageSize)
        {
            SqlParameter[] sqlParameters = new SqlParameter[]
            {
                new SqlParameter("Status", status),
                new SqlParameter("Page", page),
                new SqlParameter("PageSize", pageSize)
            };

            return db.Database.SqlQuery<Feedback>("uspGetFeedbacks @Status, @Page, @PageSize", sqlParameters).ToList();
        }

        public Feedback Get(long id)
        {
            SqlParameter sqlParameter = new SqlParameter("Id", id);

            return db.Database.SqlQuery<Feedback>("uspGetFeedback @Id", sqlParameter).SingleOrDefault();
        }

        public int Insert(Feedback entity)
        {
            SqlParameter[] sqlParameters = new SqlParameter[]
            {
                new SqlParameter("Name", entity.Name),
                new SqlParameter("Phone", entity.Phone),
                new SqlParameter("Email", entity.Email),
                new SqlParameter("Content", entity.Content)
            };

            return db.Database.SqlQuery<int>("uspInsertFeedback @Name, @Phone, @Email, @Content", sqlParameters).SingleOrDefault();
        }

        public int UpdateStatus(long id)
        {
            SqlParameter sqlParameter = new SqlParameter("Id", id);

            return db.Database.SqlQuery<int>("uspUpdateFeedbackStatus @Id", sqlParameter).SingleOrDefault();
        }

        public int Delete(long id)
        {
            SqlParameter sqlParameter = new SqlParameter("Id", id);

            return db.Database.SqlQuery<int>("uspDeleteFeedback @Id", sqlParameter).SingleOrDefault();
        }
    }
}
