// Copyright (c) 2015, Haran Kumar. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of DartFeed;

class Item {
  String title;
  Uri link;
  String description;
  String creator;
  String author;
  List<Category> categories;
  Uri comments;
  Enclosure enclosure;
  Guid guid;
  DateTime pubDate;
  Source source;
  XmlElement xml;

  Item.fromXml(XmlElement element) {
    xml = element;
    title = _getValue("title", element);
    description = _getValue("description", element);
    if ((title == null || title == "") &&
        (description == null || description == "")) {
      throw new Exception(
          "Received a feed item with no valid title or description.");
      title = "No Title";
      description = "No Description";
    }
    link = Uri.parse(_escape(_getValue("link", element)));
    author = _getValue("author", element);
    categories = new List<Category>();
    for (var category in element.findAllElements("category")) categories
        .add(new Category.fromXml(category));
    comments = Uri.parse(_escape(_getValue("comments", element)));
    enclosure = new Enclosure.fromXml(_get("enclosure", element));
    guid = new Guid.fromXml(_get("guid", element));
    pubDate = _parseDate(_getValue("pubDate", element));
    source = new Source.fromXml(_get("source", element));
    creator = _getValue("creator", element);
  }

  String toString() {
    return title;
  }
}
