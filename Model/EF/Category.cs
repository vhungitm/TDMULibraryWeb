using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model.EF
{
    public class Category
    {
        public long Id { set; get; }

        public string Name { set; get; }

        public string MetaTitle { set; get; }

        public string Image { set; get; }
    }
}
