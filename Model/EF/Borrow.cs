using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model.EF
{
    public class Borrow
    {
        public long Id { set; get; }

        public string StudentId { set; get; }

        public string StudentName { set; get; }

        public string StaffId { set; get; }

        public string StaffName { set; get; }

        public long BookId { set; get; }

        public string BookTitle { set; get; }

        public string BookMetaTitle { set; get; }

        public string BookImage { set; get; }

        public string BookCategoryMetaTitle { set; get; }

        public string BorrowDate { set; get; }

        public string ReturnDeadline { set; get; }

        public string ReturnDate { set; get; }

        public int Status { set; get; }
    }
}
