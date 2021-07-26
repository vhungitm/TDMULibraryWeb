using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model.EF
{
    public class Banner
    {
        public long Id { set; get; }
        public string Image { set; get; }
        public int Order { set; get; }
        public int Status { set; get; }
    }
}
