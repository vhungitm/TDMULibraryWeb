using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model.EF
{
    public class Import
    {
        public long Id { set; get; }

        public string StaffId { set; get; }

        public string StaffName { set; get; }

        public string CreatedDate { set; get; }

        public int Quantity { set; get; }

        public decimal TotalPrice { set; get; }
    }
}
