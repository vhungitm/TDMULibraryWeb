using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Model.EF;
using System.Data.SqlClient;
using Model;

namespace Model.DAO
{
    public class PublisherDAO
    {
        DBContext db;
        public PublisherDAO()
        {
            db = new DBContext();
        }

        public int Count(string key)
        {
            SqlParameter sqlParameter = new SqlParameter("Key", key);

            return db.Database.SqlQuery<int>("uspCountPublisher @Key", sqlParameter).SingleOrDefault();
        }

        public List<Publisher> Gets(string key, int page, int pageSize)
        {
            SqlParameter[] sqlParameters = new SqlParameter[]
            {
                new SqlParameter("Key", key),
                new SqlParameter("Page", page),
                new SqlParameter("PageSize", pageSize)
            };

            return db.Database.SqlQuery<Publisher>("uspGetPublishers @Key, @Page, @PageSize", sqlParameters).ToList();
        }

        public Publisher Get(string key)
        {
            SqlParameter sqlParameter = new SqlParameter("Key", key);

            return db.Database.SqlQuery<Publisher>("uspGetPublisher @Key", sqlParameter).SingleOrDefault();
        }

        public int Insert(Publisher entity)
        {
            SqlParameter[] sqlParameters = new SqlParameter[]
            {
                new SqlParameter("Name", entity.Name),
                new SqlParameter("MetaTitle", FormatValue.ConvertToLink(entity.Name)),
                new SqlParameter("Address", entity.Address != null ? entity.Address : DBNull.Value.ToString()),
                new SqlParameter("Phone", entity.Phone != null ? entity.Phone : DBNull.Value.ToString()),
                new SqlParameter("Email", entity.Email != null ? entity.Email : DBNull.Value.ToString())
            };

            return db.Database.ExecuteSqlCommand("uspInsertPublisher @Name, @MetaTitle, @Address, @Phone, @Email", sqlParameters);
        }

        public int Update(Publisher entity)
        {
            SqlParameter[] sqlParameters = new SqlParameter[]
            {
                new SqlParameter("Id", entity.Id),
                new SqlParameter("Name", entity.Name),
                new SqlParameter("MetaTitle", FormatValue.ConvertToLink(entity.Name)),
                new SqlParameter("Address", entity.Address != null ? entity.Address : DBNull.Value.ToString()),
                new SqlParameter("Phone", entity.Phone != null ? entity.Phone : DBNull.Value.ToString()),
                new SqlParameter("Email", entity.Email != null ? entity.Email : DBNull.Value.ToString())
            };

            return db.Database.ExecuteSqlCommand("uspUpdatePublisher @Id, @Name, @MetaTitle, @Address, @Phone, @Email", sqlParameters);
        }

        public int Delete(long id)
        {
            SqlParameter sqlParameter = new SqlParameter("Id", id);

            return db.Database.SqlQuery<int>("uspDeletePublisher @Id", sqlParameter).SingleOrDefault();
        }
    }
}
