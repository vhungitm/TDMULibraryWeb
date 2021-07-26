using System;
using System.Collections.Generic;
using System.Linq;
using Model.EF;
using System.Data.SqlClient;
using Model;

namespace Model.DAO
{
    public class CategoryDAO
    {
        DBContext db;
        public CategoryDAO()
        {
            db = new DBContext();
        }

        public int Count(string key)
        {
            SqlParameter sqlParameter = new SqlParameter("Key", key);

            return db.Database.SqlQuery<int>("uspCountCategory @Key", sqlParameter).SingleOrDefault();
        }

        public List<Category> Gets(string key, int page, int pageSize)
        {
            SqlParameter[] sqlParameters = new SqlParameter[]
            {
                new SqlParameter("Key", key),
                new SqlParameter("Page", page),
                new SqlParameter("PageSize", pageSize)
            };

            return db.Database.SqlQuery<Category>("uspGetCategories @Key, @Page, @PageSize", sqlParameters).ToList();
        }

        public Category Get(string key)
        {
            SqlParameter sqlParameter = new SqlParameter("Key", key);

            return db.Database.SqlQuery<Category>("uspGetCategory @Key", sqlParameter).SingleOrDefault();
        }

        public int Insert(Category entity)
        {
            SqlParameter[] sqlParameters = new SqlParameter[]
            {
                new SqlParameter("Name", entity.Name),
                new SqlParameter("MetaTitle", FormatValue.ConvertToLink(entity.Name)),
                new SqlParameter("Image", entity.Image)
            };

            return db.Database.SqlQuery<int>("uspInsertCategory @Name, @MetaTitle, @Image", sqlParameters).SingleOrDefault();
        }

        public int Update(Category entity)
        {
            SqlParameter[] sqlParameters = new SqlParameter[]
            {
                new SqlParameter("Id", entity.Id),
                new SqlParameter("Name", entity.Name),
                new SqlParameter("MetaTitle", FormatValue.ConvertToLink(entity.Name)),
                new SqlParameter("Image", entity.Image)
            };

            return db.Database.SqlQuery<int>("uspUpdateCategory @Id, @Name, @MetaTitle, @Image", sqlParameters).SingleOrDefault();
        }

        public int Delete(long id)
        {
            SqlParameter sqlParameter = new SqlParameter("Id", id);

            return db.Database.SqlQuery<int>("uspDeleteCategory @Id", sqlParameter).SingleOrDefault();
        }
    }
}
