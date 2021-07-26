using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Model.DAO;
using Web.Global;

namespace Web.Controllers
{
    public class BookController : Controller
    {
        BookDAO dao = new BookDAO();

        public ActionResult Search(string key = "", string category = "", string publisher = "", int publishYear = 0, int status = 2, int page = 1)
        {
            if (key.Trim() != "")
            {
                ViewBag.key = key;
                
                ViewBag.categoryId = category;
                ViewBag.categoryName = new CategoryDAO().Get(category) != null ? new CategoryDAO().Get(category).Name : "Tất cả thể loại";
                
                ViewBag.publisherId = publisher;
                ViewBag.publisherName = new PublisherDAO().Get(publisher) != null ? new PublisherDAO().Get(publisher).Name : "Tất cả nhà xuất bản";

                ViewBag.publishYear = publishYear;
                ViewBag.status = status;
                ViewBag.page = page;

                return View();
            }

            return Redirect("/404");
        }

        public ActionResult Detail(string metaTitle)
        {
            var book = dao.Get(metaTitle);
            book.Quantity = dao.GetQuantityInStock(book.Id);
            ViewBag.RelatedBook = dao.Gets("" , "", book.CategoryId.ToString(), "", 0, 1, 1, 5).Where(x => x.MetaTitle != metaTitle).Take(4);

            return View(book);
        }

        public ActionResult Category(string metaTitle, int page = 1)
        {
            var category = new CategoryDAO().Get(metaTitle);
            ViewBag.page = page;

            return View(category);
        }

        public ActionResult Publisher(string metaTitle, int page = 1)
        {
            var publisher = new PublisherDAO().Get(metaTitle);
            ViewBag.page = page;

            return View(publisher);
        }

        public ActionResult BorrowHistory(long id = 0, string staff = "", string book = "", string borrowDate = "", string returnDate = "", int status = 2, int page = 1)
        {
            var user = (User)Session[Constants.USER];

            if (user != null)
            {

                ViewBag.id = id;
                ViewBag.username = user.Username;
                
                ViewBag.staffId = staff;
                ViewBag.staffName = new StaffDAO().Get(staff) != null ? new StaffDAO().Get(staff).FullName : "Tất cả nhân viên";
                
                ViewBag.bookId = book;
                ViewBag.bookTitle = new BookDAO().Get(book) != null ? new BookDAO().Get(book).Title : "Tất cả sách";

                ViewBag.borrowDate = borrowDate;
                ViewBag.returnDate = returnDate;
                ViewBag.status = status;
                ViewBag.page = page;

                return View();
            }
            else
            {
                return RedirectToAction("Login", "Home");
            }
        }
    }
}