namespace Model.EF
{
    using System.Data.Entity;

    public partial class DBContext : DbContext
    {
        public DBContext() : base("name=DBContext") { }

    }
}
