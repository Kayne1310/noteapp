Ngẫm lại note app


dependencies đã add vào project
flutter_bloc
equitable


Sử dung cubit
Cubit có 2 file là state và cubit
State:
Class ListNoteState chứ
-Attribute
+Lưu data note dưới dạng List 
+ 2 data type là int là selectIndex và pageCount để lưu index và số lượng của page khi ở màn hình lớn
-Constructor
1 constructor với như bth
- hàm mới copyWith(cũng giống như con structor vì ở dart chỉ chứa 1 constructor thôi ko được tạo 2 constructor nên dung copyWith )
- Mục đích của copyWith là tạo một bản sao của đối tượng hiện tại, với các giá trị mới được cung cấp để thay thế một số thuộc tính (nếu cần). Nếu không cung cấp giá trị mới, thuộc tính gốc sẽ được giữ nguyên.


ngoài ra còn có 1 method override của equitable là List<Object> get props => [notes,selectIndex,pagecount];
.Nếu ko có cái này thì sẽ ko nhận biết đượng state của class đã thay đổi



Class NoteItem cx tương tự y hệt có các thuộc tính là final  date Time ,title,content, 
1 Constructor và 1 copyWith với default là có thể null
//key word final là để những object sẽ được gán sau là chỉ 1 lần
1 orverride props

---------------------------------------------------------------------------------------------
File cubit

Ở trong này thì  dung emit để thay đổi trạng thái
trong này có 1 constructor chứ data mẫu 



có method addNote 2 tham số là tittle và string ko cần date vì date mình dung datetime.now
đây là code mẫu method add
   var newNote = [
      NoteItem(dateTime: DateTime.now(), title: title, content: content),
      ...state.notes
    ];
    emit(state.copyWith(notes: newNote));

giải thích :Tạo 1 biến ở dạng list gọi Object NoteItem chứa 3 tham số và datetime thì dung DateTime.now,title thì dùngg biến title trên hàm addNote và tương tự content , ...state.note   để Giữ lại các ghi chú cũ và thêm ghi chú mới vào đầu danh sách.


rôid dung emit để lưu state của note

ngoài ra còn có  các method removeNote ,EditNote ,setPageCount ,setSelectIndex thì cũng khá đã giản dung các method có sắn của list như removeAt hay gọi thẳng index của list để edit

----------------------------------------------------------
Ở main.dart

có thuộc tính ở materialApp là 
    debugShowCheckedModeBanner: false,
      scrollBehavior: MaterialScrollBehavior().copyWith(
        dragDevices: {
          PointerDeviceKind.touch,
          PointerDeviceKind.trackpad,
          PointerDeviceKind.mouse
        }

---- Mục đích là chế độ debug hiện ở screen :false ,mấy phần kia thì dung nút chuột như dt

ngoài ra  còn có lứng Nghe khi các cubit thay đổi ở docs của cubit


ở phần APp có 1 onGenerateRoute :thằng này là route của appp ///thằng này là 1 method nhé tham số là settings
mặc định là initialRoute :LoginPage.route

--------------------
ở route.dart
nó sẽ kiểu Route<dynamic>? MainRoute(RouteSettings settings) {

 muốn route được qua các page thì m phải có 1 biến const String routeName = "Home" 

dung stwich case để check với tham số switch(settings.name)
retrun ví dụ   return MaterialPageRoute(builder: (context) => LoginPage());
}


ngoài ra trong phần route.dart này còn có thể tạo BlocProvider.value để dùngg lại cubit chứ ko phải khởi tạo lại cubit mới.
đây là ví dụ

   case DetailNote.route:
      var cubit = (settings.arguments as Map<String, dynamic>)['cubit']
          as ListNoteCubit;
      return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
                value: cubit,
                child: Scaffold(
                  body: DetailNote(),
                ),
              ));

ở đây vì bên DetailNote đã có  1 onpress trong đó có 1 arguments dạng Map có key "cubit":context.read<ListNoteCubit>
lên bên này tạo thằng BlocProvider.vale đã có value là cubit đẵ hứng ở  trên

luu vào cubit kia thì chúng ta thằng settings.arguments ép kiểu thành Map truy cập vào key cubit và tiếp tục ép kiểu của nó về dạng ListNoteCubit



--------------------------------------------------

Ở bên trang DetailNote thì chỉ cần gọi BlocBuilder để hứng cubit

ví dụ 
 Text("${state.notes[state.selectIndex].dateTime.toString()}"),

ở đây dung state.notes để gọi ra listnote ở vị trí selectIndex và lấy ra datetime rồi toString


ở trong này có 1 eleatedButton Edit để route qua trang EditDetail

route bang cách dùng Navigator.of(context).pushName tên cần route và có 1 arguments để lưu cubit tránh bị khởi tạo lại từ đầu




----------------------------------------------
ở phần listnote.dart(file chứa widget screen)

cx có 1 blocProvider để tạo cubit và blocBuilder để hứng 

Ngoài ra còn có 1 biến width:MediaQuery.sizeOf(context).width để lấy ra chiều rộng của screen 

dùng if else if để return 3 widget chứa số lượng page hiển thị

Ở phần ListNoteScreen dùng Card để hiển thị data còn 1 IconButton để thực hiện method xoá ,gọi method xoá bang cách context.read<ListNoteCubit>().removeNote(index)

ngoài ra còn có onTap để bắt sự kiện tap vào card 

còn 1 itemcount để đếm số lượng card có trong list note ví dụ 1 list note có 3 phần tử thì có 3 card hiển thị



ở 2 widget còn loại khi pagecount==2 || pagecount ==3 thì gọi screen của 2 file kia vào chung ví dụ:
class ListNoteDetailEdit extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ListNoteScreen(),
        ),
        Expanded(
          child: DetailNote(),
        ),
        Expanded(
          child: EditNote(),
        ),
      ],
    );
  }
}

dùng  expanded để tránh bị lỗi tràn màn hình







