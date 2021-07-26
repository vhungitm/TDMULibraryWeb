using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient;
using Model.EF;
using Model;

namespace Model.DAO
{
    public class BookDAO
    {
        DBContext db;

        public BookDAO()
        {
            db = new DBContext();
        }

        public int Count(string key, string category, string publisher, int publishYear, int status)
        {
            SqlParameter[] sqlParameters = new SqlParameter[]
            {
                new SqlParameter("Key", key),
                new SqlParameter("Category", category),
                new SqlParameter("Publisher", publisher),
                new SqlParameter("PublishYear", publishYear),
                new SqlParameter("Status", status)
            };

            return db.Database.SqlQuery<int>("uspCountBook @Key, @Category, @Publisher, @PublishYear, @Status", sqlParameters).SingleOrDefault();
        }

        public List<Book> Gets(string key, string authorId, string category, string publisher, int publishYear, int status, int page, int pageSize)
        {
            SqlParameter[] sqlParameters = new SqlParameter[]
            {
                new SqlParameter("Key", key),
                new SqlParameter("Category", category),
                new SqlParameter("Publisher", publisher),
                new SqlParameter("PublishYear", publishYear),
                new SqlParameter("Status", status),
                new SqlParameter("Page", page),
                new SqlParameter("PageSize", pageSize)
            };

            return db.Database.SqlQuery<Book>("uspGetBooks @Key, @Category, @Publisher, @PublishYear, @Status, @Page, @PageSize", sqlParameters).ToList();
        }

        public Book Get(string key)
        {
            SqlParameter sqlParameter = new SqlParameter("Key", key);

            return db.Database.SqlQuery<Book>("uspGetBook @Key", sqlParameter).SingleOrDefault();
        }

        public int GetQuantityInStock(long id)
        {
            SqlParameter sqlParameter = new SqlParameter("Id", id);

            return db.Database.SqlQuery<int>("uspGetBookQuantityInStock @Id", sqlParameter).SingleOrDefault();
        }

        public int Insert(Book model)
        {
            SqlParameter[] sqlParameters = new SqlParameter[]
            {
                new SqlParameter("Title", model.Title),
                new SqlParameter("MetaTitle", FormatValue.ConvertToLink(model.Title)),
                new SqlParameter("Image", model.Image),
                new SqlParameter("Authors", model.Authors),
                new SqlParameter("CategoryId", model.CategoryId),
                new SqlParameter("PublisherId", model.PublisherId),
                new SqlParameter("Quantity", model.Quantity),
                new SqlParameter("PageNumber", model.PageNumber),
                new SqlParameter("Size", model.Size),
                new SqlParameter("Weight", model.Weight),
                new SqlParameter("PublishYear", model.PublishYear),
                new SqlParameter("Description", model.Description == null ? DBNull.Value.ToString() : model.Description),
                new SqlParameter("Status", model.Status),
            };

            return db.Database.SqlQuery<int>("uspInsertBook @Title, @MetaTitle, @Image, @Authors, @CategoryId, @PublisherId, @Quantity, @PageNumber, @Size, @Weight, @PublishYear, @Description, @Status", sqlParameters).SingleOrDefault();
        }

        public int Update(Book model)
        {
            SqlParameter[] sqlParameters = new SqlParameter[]
            {
                new SqlParameter("Id", model.Id),
                new SqlParameter("Title", model.Title),
                new SqlParameter("MetaTitle", FormatValue.ConvertToLink(model.Title)),
                new SqlParameter("Image", model.Image),
                new SqlParameter("Authors", model.Authors),
                new SqlParameter("CategoryId", model.CategoryId),
                new SqlParameter("PublisherId", model.PublisherId),
                new SqlParameter("Quantity", model.Quantity),
                new SqlParameter("PageNumber", model.PageNumber),
                new SqlParameter("Size", model.Size),
                new SqlParameter("Weight", model.Weight),
                new SqlParameter("PublishYear", model.PublishYear),
                new SqlParameter("Description", model.Description == null ? DBNull.Value.ToString() : model.Description),
                new SqlParameter("Status", model.Status),
            };

            return db.Database.ExecuteSqlCommand("uspUpdateBook @Id, @Title, @MetaTitle, @Image, @Authors, @CategoryId, @PublisherId, @Quantity, @PageNumber, @Size, @Weight, @PublishYear, @Description, @Status", sqlParameters);
        }

        public int UpdateStatus(long id)
        {
            SqlParameter sqlParameter = new SqlParameter("Id", id);

            return db.Database.SqlQuery<int>("uspUpdateBookStatus @Id", sqlParameter).SingleOrDefault();
        }

        public int Delete(long id)
        {
            SqlParameter sqlParameter = new SqlParameter("Id", id);

            return db.Database.SqlQuery<int>("uspDeleteBook @Id", sqlParameter).SingleOrDefault();
        }
    }
}
