class SoultGrid {
  String? string;
  int? index;
  bool isSelect = false; //是否选中

  SoultGrid({required this.string, required this.index});

  SoultGrid.fromJson(Map<String, dynamic> json) {
    if (json["string"] is String) this.string = json["string"];
    if (json["index"] is int) this.index = json["index"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["string"] = this.string;
    data["index"] = this.index;
    return data;
  }
}
