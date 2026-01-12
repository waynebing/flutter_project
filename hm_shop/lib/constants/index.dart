// 全局的常量
class GlobalConstants {
  static const String BASE_URL = "https://meikou-api.itheima.net"; // 基础地址
  static const int TIME_OUT = 10; // 超时时间
  static const String SUCCESS_CODE = "1"; // 成功状态
  static const String TOKEN_KEY = "hm_shop_token"; // token对应持久化的key
}

// 存放请求地址接口的常量

class HttpConstants {
  static const String BANNER_LIST = "/home/banner";
  static const String CATEGORY_LIST = "/home/category/head";
  static const String PRODUCT_LIST = "/hot/preference"; // 特惠推荐地址
}
