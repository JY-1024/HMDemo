import CommonConstants from './CommonConstants'
import DataModel from './DataModel'
import ItemData from './ItemData'

@Component
export default struct HomePage {
  // 轮播图控制器
  private swiperController: SwiperController = new SwiperController()

  build() {
    Scroll() {
      Column({ space: CommonConstants.COMMON_SPACE }) {
        //第一部分标题
        Text($r('app.string.mainPage_tabTitles_home'))
          .fontWeight(FontWeight.Medium)
          .fontSize($r('app.float.page_title_text_size'))
          .margin({ top: $r('app.float.mainPage_tabTitles_margin') })
          .padding({ left: $r('app.float.mainPage_tabTitles_padding') })

        //轮播图
        Swiper(this.swiperController) {
          ForEach(
            DataModel.getSwiperImages(),
            (item: Resource, index) => {
              Image(item)
                .borderRadius($r('app.float.home_swiper_borderRadius'))
            }
          )
        }
        .autoPlay(true)
        .margin({ top: $r('app.float.home_swiper_margin') })

        //第三部分：菜单列表
        //网格布局
        Grid(){
          ForEach(
            DataModel.getFirstGridData(),
            (item:ItemData,index)=>{
              GridItem(){
                Column(){
                  Image(item.img)
                    .width($r('app.float.home_homeCell_size'))
                    .height($r('app.float.home_homeCell_size'))
                  Text(item.title)
                    .fontSize($r('app.float.little_text_size'))
                    .margin({top:$r('app.float.home_homeCell_margin')})
                }
              }
            })
        }
        .columnsTemplate('1fr 1fr 1fr 1fr') // 设置网格的列模板，每列平分空间
        .rowsTemplate('1fr 1fr') // 设置网格的行模板，每行平分空间
        .columnsGap($r('app.float.home_grid_columnsGap')) // 设置列之间的间隔
        .rowsGap($r('app.float.home_grid_rowGap')) // 设置行之间的间隔
        .padding({ top: $r('app.float.home_grid_padding'), bottom: $r('app.float.home_grid_padding') }) // 设置网格内边距
        .height($r('app.float.home_grid_height')) // 设置网格高度
        .backgroundColor(Color.White) // 设置网格背景色为白色
        .borderRadius($r('app.float.home_grid_borderRadius')) // 设置网格边角半径

        // 第四部分： 频道列表
        Text($r('app.string.home_list')) // 显示"列表"的文本
          .fontSize($r('app.float.normal_text_size')) // 设置文本字号
          .fontWeight(FontWeight.Medium) // 设置文本字重
          .width(CommonConstants.FULL_PARENT) // 设置文本宽度为父容器的100%
          .margin({ top: $r('app.float.home_text_margin') }) // 设置文本上边距

        Grid() {
          ForEach(DataModel.getSecondGridData(), (item: ItemData) => {
            GridItem() {
              Column(){
                Text(item.title)
                  .fontSize($r('app.float.normal_text_size')) // 设置文本字号
                  .fontWeight(FontWeight.Medium) // 设置文本字重
                Text(item.others)
                  .margin({ top: $r('app.float.home_list_margin') }) // 设置文本上边距
                  .fontSize($r('app.float.little_text_size')) // 设置文本字号
                  .fontColor($r('app.color.home_grid_fontColor')) // 设置文本颜色
              }
              .alignItems(HorizontalAlign.Start)  // 两个文本框，在水平方向居左对齐
            }
            .padding({ top: $r('app.float.home_list_padding'), left: $r('app.float.home_list_padding') }) // 设置网格项内边距
            .borderRadius($r('app.float.home_backgroundImage_borderRadius')) // 设置网格项边角半径
            .align(Alignment.TopStart) // 设置网格项对齐方式为顶部开始
            .backgroundImage(item.img) // 设置网格项背景图像
            .backgroundImageSize(ImageSize.Cover) // 设置背景图像尺寸模式为覆盖
            .width(CommonConstants.FULL_PARENT) // 设置网格项宽度为父容器的100%
            .height(CommonConstants.FULL_PARENT) // 设置网格项高度为父容器的100%
          })
        }
        .width(CommonConstants.FULL_PARENT) // 设置网格宽度为父容器的100%
        .height($r('app.float.home_secondGrid_height')) // 设置网格高度
        .columnsTemplate('1fr 1fr') // 设置网格的列模板，每列平分空间
        .rowsTemplate('1fr 1fr') // 设置网格的行模板，每行平分空间
        .columnsGap($r('app.float.home_grid_columnsGap')) // 设置列之间的间隔
        .rowsGap($r('app.float.home_grid_rowGap')) // 设置行之间的间隔
        .margin({ bottom: $r('app.float.setting_button_bottom') }) // 设置网格底部外边距

      }
    }
    .height(CommonConstants.FULL_PARENT)
  }
}