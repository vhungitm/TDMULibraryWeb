using System;
using System.Collections.Generic;
using System.Linq;
using Model.EF;
using System.Data.SqlClient;

namespace Model.DAO
{
    public class AuthorDAO
    {
        DBContext db;
        public AuthorDAO()
        {
            db = new DBContext();
        }

        public int Count(string key)
        {
            SqlParameter[] sqlParameters = new SqlParameter[]{
                new SqlParameter("Key", key)
            };

            return db.Database.SqlQuery<int>("uspCountAuthor @Key", sqlParameters).SingleOrDefault();
        }

        public List<Author> Gets(string key, int page, int pageSize)
        {
            SqlParameter[] sqlParameters = new SqlParameter[]
            {
                new SqlParameter("Key", key),
                new SqlParameter("Page", page),
                new SqlParameter("PageSize", pageSize)
            };

            return db.Database.SqlQuery<Author>("uspGetAuthors @Key, @Page, @PageSize", sqlParameters).ToList();
        }

        public Author Get(long id)
        {
            SqlParameter sqlParameter = new SqlParameter("Id", id);

            return db.Database.SqlQuery<Author>("uspGetAuthor @Id", sqlParameter).SingleOrDefault();
        }

        public int Insert(Author entity)
        {
            SqlParameter sqlParameter = new SqlParameter("Name", entity.Name);

            return db.Database.ExecuteSqlCommand("uspInsertAuthor @Name", sqlParameter);
        }

        public int Update(Author entity)
        {
            SqlParameter[] sqlParameters = new SqlParameter[]
            {
                new SqlParameter("Id", entity.Id),
                new SqlParameter("Name", entity.Name)
            };

            return db.Database.ExecuteSqlCommand("uspUpdateAuthor @Id, @Name", sqlParameters);
        }

        public int Delete(long id)
        {
            SqlParameter sqlParameter = new SqlParameter("Id", id);

            return db.Database.ExecuteSqlCommand("uspDeleteAuthor @Id", sqlParameter);
        }
    }
}
