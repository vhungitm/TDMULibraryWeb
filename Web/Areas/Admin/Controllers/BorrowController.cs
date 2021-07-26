using System.Web.Mvc;
using Model.DAO;

namespace Web.Areas.Admin.Controllers
{
    public class BorrowController : BaseController
    {
        public ActionResult Index(long id = 0, string student = "", string staff = "", string book = "", string borrowDate = "", string returnDate = "", int status = 2, int page = 1)
        {
            ViewBag.id = id;
            
            ViewBag.studentId = student;
            ViewBag.studentName = student != "" ? new StudentDAO().Get(student).FullName : "Tất cả sinh viên";
            
            ViewBag.staffId = staff;
            ViewBag.staffName = staff != "" ? new StaffDAO().Get(staff).FullName : "Tất cả nhân viên";

            ViewBag.bookId = book;
            ViewBag.bookTitle = book != "" ? new BookDAO().Get(book).Title : "Tất cả sách";

            ViewBag.borrowDate = borrowDate;
            ViewBag.returnDate = returnDate;
            ViewBag.status = status;
            ViewBag.page = page;

            return View();
        }
    }
}