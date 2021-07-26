using System;
using System.Collections.Generic;
using System.Web.Mvc;

namespace Model.EF
{
    public class Book
    {
        public long Id { set; get; }

        public string Title { set; get; }

        public string MetaTitle { set; get; }

        public string Image { set; get; }

        public string Authors { set; get; }

        public long CategoryId { set; get; }

        public string CategoryName { set; get; }

        public string CategoryMetaTitle { set; get; }

        public long PublisherId { set; get; }

        public string PublisherName { set; get; }

        public string PublisherMetaTitle { set; get; }

        public int Quantity { set; get; }

        public int PageNumber { set; get; }

        public string Size { set; get; }

        public string Weight { set; get; }

        public int PublishYear { set; get; }

        [AllowHtml]
        public string Description { set; get; }

        public int Status { set; get; }
    }
}
