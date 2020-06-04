class SearchFunction {
  List<Map> filterSearchResults(
      String query, List<Map> litems, List<Map> litemsDuplicate) {
    List<Map> dummySearchList = List<Map>();
    dummySearchList.addAll(litemsDuplicate);
    if (query.isNotEmpty) {
      List<Map> dummyListData = List<Map>();
      dummySearchList.forEach((item) {
        if (item['textFieldValue']
            .toString()
            .toLowerCase()
            .contains(query.toLowerCase())) {
          dummyListData.add(item);
        }
      });
      litems.clear();
      litems.addAll(dummyListData);
    } else {
      litems.clear();
      litems.addAll(litemsDuplicate);
    }
    return litems;
  }
}
