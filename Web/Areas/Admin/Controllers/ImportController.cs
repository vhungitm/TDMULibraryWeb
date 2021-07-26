using System.Web.Mvc;
using Model.DAO;
using Web.Global;

namespace Web.Areas.Admin.Controllers
{
    public class ImportController : BaseController
    {
        public ActionResult Index(long id = 0, string staff = "", string createdDate = "", int page = 1, long importId = 0, string book = "", int pageDetail = 1)
        {
            ViewBag.id = id;

            var user = (User)Session[Constants.ADMIN];
            ViewBag.username = user.Username;

            ViewBag.staffId = staff;
            ViewBag.staffName = staff != "" ? new StaffDAO().Get(staff).FullName : "Tất cả nhân viên";

            ViewBag.createdDate = createdDate;
            ViewBag.page = page;

            // Detail
            ViewBag.importId = importId;
            
            ViewBag.bookId = book;
            ViewBag.bookTitle = book != "" ? new BookDAO().Get(book).Title : "Tất cả sách";

            ViewBag.pageDetail = pageDetail;

            return View();
        }
    }
}