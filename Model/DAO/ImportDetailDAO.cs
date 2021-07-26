using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient;
using Model.EF;

namespace Model.DAO
{
    public class ImportDetailDAO
    {
        DBContext db;

        public ImportDetailDAO()
        {
            db = new DBContext();
        }

        public int Count(long importId, string book)
        {
            SqlParameter[] sqlParameters = new SqlParameter[]
            {
                new SqlParameter("ImportId", importId),
                new SqlParameter("Book", book)
            };

            return db.Database.SqlQuery<int>("uspCountImportDetail @ImportId, @Book", sqlParameters).SingleOrDefault();
        }

        public List<ImportDetail> Gets(long importId, string book, int page, int pageSize)
        {
            SqlParameter[] sqlParameters = new SqlParameter[]
            {
                new SqlParameter("ImportId", importId),
                new SqlParameter("Book", book),
                new SqlParameter("Page", page),
                new SqlParameter("PageSize", pageSize)
            };

            return db.Database.SqlQuery<ImportDetail>("uspGetImportDetails @ImportId, @Book, @Page, @PageSize", sqlParameters).ToList();
        }

        public ImportDetail Get(long importId, string book)
        {
            SqlParameter[] sqlParameters = new SqlParameter[]
            {
                new SqlParameter("ImportId", importId),
                new SqlParameter("Book", book)
            };

            return db.Database.SqlQuery<ImportDetail>("uspGetImportDetail @ImportId, @Book", sqlParameters).SingleOrDefault();
        }

        public int Insert(ImportDetail model)
        {
            SqlParameter[] sqlParameters = new SqlParameter[]
            {
                new SqlParameter("ImportId", model.ImportId),
                new SqlParameter("BookId", model.BookId),
                new SqlParameter("Quantity", model.Quantity),
                new SqlParameter("Price", model.Price)
            };

            return db.Database.SqlQuery<int>("uspInsertImportDetail @ImportId, @BookId, @Quantity, @Price", sqlParameters).SingleOrDefault();
        }

        public int Update(ImportDetail model)
        {
            SqlParameter[] sqlParameters = new SqlParameter[]
            {
                new SqlParameter("ImportId", model.ImportId),
                new SqlParameter("BookId", model.BookId),
                new SqlParameter("Quantity", model.Quantity),
                new SqlParameter("Price", model.Price)
            };

            return db.Database.SqlQuery<int>("uspUpdateImportDetail @ImportId, @BookId, @Quantity, @Price", sqlParameters).SingleOrDefault();
        }

        public int Delete(long importId, long bookId)
        {
            SqlParameter[] sqlParameters = new SqlParameter[]
            {
                new SqlParameter("ImportId", importId),
                new SqlParameter("BookId", bookId)
            };

            return db.Database.SqlQuery<int>("uspDeleteImportDetail @ImportId, @BookId", sqlParameters).SingleOrDefault();
        }
    }
}
