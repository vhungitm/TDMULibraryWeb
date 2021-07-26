using System;
using System.Collections.Generic;
using System.Linq;
using Model.EF;
using System.Data.SqlClient;

namespace Model.DAO
{
    public class BannerDAO
    {
        DBContext db;
        public BannerDAO()
        {
            db = new DBContext();
        }

        public int Count(int status)
        {
            SqlParameter sqlParameter = new SqlParameter("Status", status);

            return db.Database.SqlQuery<int>("uspCountBanner @Status", sqlParameter).SingleOrDefault();
        }

        public List<Banner> Gets(int status, int page, int pageSize)
        {
            SqlParameter[] sqlParameters = new SqlParameter[]
            {
                new SqlParameter("Status", status),
                new SqlParameter("Page", page),
                new SqlParameter("PageSize", pageSize)
            };

            return db.Database.SqlQuery<Banner>("uspGetBanners @Status, @Page, @PageSize", sqlParameters).ToList();
        }

        public Banner Get(long id)
        {
            SqlParameter sqlParameter = new SqlParameter("Id", id);

            return db.Database.SqlQuery<Banner>("uspGetBanner @Id", sqlParameter).SingleOrDefault();
        }

        public int Insert(Banner entity)
        {
            SqlParameter[] sqlParameters = new SqlParameter[]
            {
                new SqlParameter("Image", entity.Image),
                new SqlParameter("Order", entity.Order),
                new SqlParameter("Status", entity.Status)
            };

            return db.Database.SqlQuery<int>("uspInsertBanner @Image, @Order, @Status", sqlParameters).SingleOrDefault();
        }

        public int Update(Banner entity)
        {
            SqlParameter[] sqlParameters = new SqlParameter[]
            {
                new SqlParameter("Id", entity.Id),
                new SqlParameter("Image", entity.Image),
                new SqlParameter("Order", entity.Order),
                new SqlParameter("Status", entity.Status)
            };

            return db.Database.SqlQuery<int>("uspUpdateBanner @Id, @Image, @Order, @Status", sqlParameters).SingleOrDefault();
        }

        public int UpdateStatus(long id)
        {
            SqlParameter sqlParameter = new SqlParameter("Id", id);

            return db.Database.SqlQuery<int>("uspUpdateBannerStatus @Id", sqlParameter).SingleOrDefault();
        }

        public int Delete(long id)
        {
            SqlParameter sqlParameter = new SqlParameter("Id", id);

            return db.Database.SqlQuery<int>("uspDeleteBanner @Id", sqlParameter).SingleOrDefault();
        }
    }
}
