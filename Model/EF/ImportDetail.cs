using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model.EF
{
    public class ImportDetail
    {
        public long ImportId { set; get; }

        public long BookId { set; get; }

        public string BookTitle { set; get; }

        public string BookMetaTitle { set; get; }

        public int Quantity { set; get; }

        public decimal Price { set; get; }

        public decimal TotalPrice { set; get; }
    }
}
