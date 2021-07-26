using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient;
using Model.EF;

namespace Model.DAO
{
    public class ImportDAO
    {
        DBContext db;

        public ImportDAO()
        {
            db = new DBContext();
        }

        public int Count(long id, string staffId, string createdDate)
        {
            SqlParameter[] sqlParameters = new SqlParameter[]
            {
                new SqlParameter("Id", id),
                new SqlParameter("StaffId", staffId),
                new SqlParameter("CreatedDate", createdDate)
                
            };

            return db.Database.SqlQuery<int>("uspCountImport @Id, @StaffId, @CreatedDate", sqlParameters).SingleOrDefault();
        }

        public List<Import> Gets(long id, string staffId, string createdDate, int page, int pageSize)
        {
            SqlParameter[] sqlParameters = new SqlParameter[]
            {
                new SqlParameter("Id", id),
                new SqlParameter("StaffId", staffId),
                new SqlParameter("CreatedDate", createdDate),
                new SqlParameter("Page", page),
                new SqlParameter("PageSize", pageSize)
            };

            return db.Database.SqlQuery<Import>("uspGetImports @Id, @StaffId, @CreatedDate, @Page, @PageSize", sqlParameters).ToList();
        }

        public Import Get(long id)
        {
            SqlParameter sqlParameter = new SqlParameter("Id", id);

            return db.Database.SqlQuery<Import>("uspGetImport @Id", sqlParameter).SingleOrDefault();
        }

        public long Insert(Import model)
        {
            SqlParameter sqlParameter = new SqlParameter("StaffId", model.StaffId);

            return db.Database.SqlQuery<long>("uspInsertImport @StaffId", sqlParameter).SingleOrDefault();
        }

        public int Update(Import model)
        {
            SqlParameter[] sqlParameters = new SqlParameter[]
            {
                new SqlParameter("Id", model.Id),
                new SqlParameter("StaffId", model.StaffId)

            };

            return db.Database.SqlQuery<int>("uspUpdateImport @Id, @StaffId", sqlParameters).SingleOrDefault();
        }

        public int Delete(long id)
        {
            SqlParameter sqlParameter = new SqlParameter("Id", id);

            return db.Database.SqlQuery<int>("uspDeleteImport @Id", sqlParameter).SingleOrDefault();
        }
    }
}
