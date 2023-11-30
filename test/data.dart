// import 'package:shopcaycanh/models/product.dart';
// ////database: https://1989.com.vn/cay-canh-trong-trong-nha.html
// final List<Product> _items = [
//   ///1
//   Product(
//     id: 'p1',
//     title: 'Bàng Singapore',
//     description:
//         'Bàng Singapore có đặc điểm lá lớn, tán lá rộng, tròn và đầy đặn, màu xanh tươi tốt quanh năm tượng trưng cho tiền tài giàu sang và mang đến nhiều may mắn.Bàng Sing thuộc nhóm cây dễ trồng nên cây có thể thích nghi với nhiều điều kiện ánh sáng, phát triển tốt trong nhà kính có ánh sáng, không thích hợp trồng trực tiếp nơi có ánh sáng quá gắt, lá sẽ sẽ phai màu.',
//     price: 135.000,
//     imageUrl:
//         'https://wikicaycanh.com/wp-content/uploads/2022/11/bang-singapore.png',
//     origin: 'Singapore',
//     owner: 'thanhtratran',
//     status: 'cây xanh, phát triển tốt',
//     isFavorite: true,
//   ),
//   /////2
//   Product(
//     id: 'p1',
//     title: 'Trầu bà đài loan',
//     description:
//         'Cây trầu bà cột thuộc loại thân leo, lá hình trái tim, to tròn, nhiều thân bám vào trụ tạo ra tán lá tròn đều, xanh mướt. Cây cực kỳ ít tốn công chăm sóc nhưng lại sống rất bền. Cây Trầu Bà Cột cũng như những loài trầu bà khác, đều có khả năng hút chất độc và loại bỏ những tạp chất ra khỏi không khí, cây trầu bà cột là sự lựa chọn tuyệt vời dành cho tất cả mọi người, đặc biệt là dân công sở – văn phòng, thường xuyên tiếp xúc với máy lạnh, máy in và máy vi tính.',
//     price: 400.000,
//     imageUrl:
//         'https://media.loveitopcdn.com/23464/02-trau-ba-dai-loan-trau-ba-leo-cot-min.jpg',
//     origin: 'Đài loan',
//     owner: 'thanhtra',
//     status: 'ok',
//     isFavorite: true,
//   ),
//   ////3
//   Product(
//     id: 'p1',
//     title: 'Kim ngân',
//     description:
//         'Cây Kim ngân có dáng rất đẹp, cây có dáng thẳng, thường được tết sam với 3 thân hoặc 5 thân lại với nhau, có loại cây 1 thân thẳng tắp (người ta hay gọi là nhất trụ). Đỉnh thân là những nhánh cây mọc thành cụm, mỗi nhánh cây mọc ra lá xẻ thùy thành 5 nhánh như bàn tay vậy.',
//     price: 90.000,
//     imageUrl: 'https://media.loveitopcdn.com/23464/032-cay-kim-ngan-min.jpg',
//     origin: 'Việt Nam',
//     owner: 'thanhtra',
//     status: 'ok',
//     isFavorite: true,
//   ),
//   ////4
//   Product(
//     id: 'p1',
//     title: 'Kim ngân xanh',
//     description: 'Với dáng vóc đẹp mắt, Kim ngân sanh thường xuyên xuất hiện trong những văn phòng, công ty. Nếu văn phòng có một chậu Kim ngân sanh sẽ giúp bạn giữ được tiền tài, mau chóng thành công trong sự nghiệp kinh doanh, công việc ngày càng thăng tiến.',
//     price: 150.000,
//     imageUrl:
//         'https://media.loveitopcdn.com/23464/041-kim-ngan-sanh-min.jpg',
//     origin: 'Việt Nam',
//     owner: 'thanhtra',
//     status: 'ok',
//     isFavorite: true,
//   ),
//   ////5
//   Product(
//     id: 'p1',
//     title: 'Trầu bà nam mĩ',
//     description: 'Trầu Bà Nam Mỹ hay còn gọi là Trầu Bà Lá Xẻ thuộc nhóm cây cảnh văn phòng cao cấp. Trầu bà nam mỹ có khả năng thanh lọc không khí vì hút được một số khí độc như ether, formaldehyde...tác dụng tốt cho những không gian kín.',
//     price: 100.000,
//     imageUrl:
//         'https://media.loveitopcdn.com/23464/05-trau-ba-nam-my-min.jpg',
//     origin: 'Thành phố hồ chí minh',
//     owner: 'thanhtra',
//     status: 'ok',
//     isFavorite: true,
//   ),

//   ///6
//   Product(
//     id: 'p1',
//     title: 'Trầu bà thanh xuân',
//     description: 'Cây trầu bà Thanh Xuân với lá to, xanh mướt, cấu tạo lá xẻ thùy chân vịt đặc biệt nên cây thường được ưa chộng trong không gian nội thất hiện đại.',
//     price: 222.000,
//     imageUrl:
//         'https://media.loveitopcdn.com/23464/061-trau-ba-thanh-xuan-min.jpg',
//     origin: 'Việt Nam',
//     owner: 'thanhtra',
//     status: 'ok',
//     isFavorite: true,
//   ),
//   ////7
//   Product(
//     id: 'p1',
//     title: 'Red Shirt',
//     description: 'A red shirt - it is pretty red!',
//     price: 29.99,
//     imageUrl:
//         'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
//     origin: 'vietnam',
//     owner: 'thanhtra',
//     status: 'ok',
//     isFavorite: true,
//   ),

//   ///8
//   Product(
//     id: 'p1',
//     title: 'Red Shirt',
//     description: 'A red shirt - it is pretty red!',
//     price: 29.99,
//     imageUrl:
//         'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
//     origin: 'vietnam',
//     owner: 'thanhtra',
//     status: 'ok',
//     isFavorite: true,
//   ),
//   ////9
//   Product(
//     id: 'p1',
//     title: 'Red Shirt',
//     description: 'A red shirt - it is pretty red!',
//     price: 29.99,
//     imageUrl:
//         'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
//     origin: 'vietnam',
//     owner: 'thanhtra',
//     status: 'ok',
//     isFavorite: true,
//   ),
//   ////10
//   Product(
//     id: 'p1',
//     title: 'Red Shirt',
//     description: 'A red shirt - it is pretty red!',
//     price: 29.99,
//     imageUrl:
//         'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
//     origin: 'vietnam',
//     owner: 'thanhtra',
//     status: 'ok',
//     isFavorite: true,
//   ),
//   ////11
//   Product(
//     id: 'p1',
//     title: 'Red Shirt',
//     description: 'A red shirt - it is pretty red!',
//     price: 29.99,
//     imageUrl:
//         'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
//     origin: 'vietnam',
//     owner: 'thanhtra',
//     status: 'ok',
//     isFavorite: true,
//   ),
//   ////12
//   Product(
//     id: 'p1',
//     title: 'Red Shirt',
//     description: 'A red shirt - it is pretty red!',
//     price: 29.99,
//     imageUrl:
//         'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
//     origin: 'vietnam',
//     owner: 'thanhtra',
//     status: 'ok',
//     isFavorite: true,
//   ),

//   ///13
//   Product(
//     id: 'p1',
//     title: 'Red Shirt',
//     description: 'A red shirt - it is pretty red!',
//     price: 29.99,
//     imageUrl:
//         'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
//     origin: 'vietnam',
//     owner: 'thanhtra',
//     status: 'ok',
//     isFavorite: true,
//   ),

//   ///14
//   Product(
//     id: 'p1',
//     title: 'Red Shirt',
//     description: 'A red shirt - it is pretty red!',
//     price: 29.99,
//     imageUrl:
//         'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
//     origin: 'vietnam',
//     owner: 'thanhtra',
//     status: 'ok',
//     isFavorite: true,
//   ),
//   ///15
//     Product(
//     id: 'p1',
//     title: 'Red Shirt',
//     description: 'A red shirt - it is pretty red!',
//     price: 29.99,
//     imageUrl:
//         'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
//     origin: 'vietnam',
//     owner: 'thanhtra',
//     status: 'ok',
//     isFavorite: true,
//   ),
//   ///16
//       Product(
//     id: 'p1',
//     title: 'Red Shirt',
//     description: 'A red shirt - it is pretty red!',
//     price: 29.99,
//     imageUrl:
//         'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
//     origin: 'vietnam',
//     owner: 'thanhtra',
//     status: 'ok',
//     isFavorite: true,
//   ),
//   ///17
//       Product(
//     id: 'p1',
//     title: 'Red Shirt',
//     description: 'A red shirt - it is pretty red!',
//     price: 29.99,
//     imageUrl:
//         'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
//     origin: 'vietnam',
//     owner: 'thanhtra',
//     status: 'ok',
//     isFavorite: true,
//   ),
//   //18
//       Product(
//     id: 'p1',
//     title: 'Red Shirt',
//     description: 'A red shirt - it is pretty red!',
//     price: 29.99,
//     imageUrl:
//         'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
//     origin: 'vietnam',
//     owner: 'thanhtra',
//     status: 'ok',
//     isFavorite: true,
//   ),
//   //19
//       Product(
//     id: 'p1',
//     title: 'Red Shirt',
//     description: 'A red shirt - it is pretty red!',
//     price: 29.99,
//     imageUrl:
//         'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
//     origin: 'vietnam',
//     owner: 'thanhtra',
//     status: 'ok',
//     isFavorite: true,
//   ),
//   //20
//       Product(
//     id: 'p1',
//     title: 'Red Shirt',
//     description: 'A red shirt - it is pretty red!',
//     price: 29.99,
//     imageUrl:
//         'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
//     origin: 'vietnam',
//     owner: 'thanhtra',
//     status: 'ok',
//     isFavorite: true,
//   ),
// ];
