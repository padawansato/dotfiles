$(function () {
    var $flower01 = $('#flower01');
    var $flower02 = $('#flower02');
    var $flower03 = $('#flower03');
    var $flower = $('.flower');
	var $flowerImg = $('.flower').children('img');
    var $recipes = $('.recipes');
    var $recipeImg = $recipes.children('img')
    var $txtMv = $('#txtMv');
    var $fukidashi = $('#fukidashi');
    var $mochileft = $('#mochiWrapperLeft');
    var $main = $('#main');
	var $txt1 = $('#mvTxt01');
	var $txt2 = $('#mvTxt02');
	var $txt3 = $('#mvTxt03');

    $flower01.children('img').css('opacity', 0);
    $flower02.children('img').css('opacity', 0);
    $flower03.children('img').css('opacity', 0);
    $recipes.children('img').css('opacity', 0);
    $('#mvTxt01').css('opacity', 0);
    $('#mvTxt02').css('opacity', 0);
    $('#mvTxt03').css('opacity', 0);
    $('#mvTxt04').css('opacity', 0);
    $('#mvTxt05').css('opacity', 0);
    $('#mvTxt06').css('opacity', 0);
    $('#mvTxt07').css('opacity', 0);
    $('#mvMochi').css('opacity', 0);
    $main.css('opacity', 0);
    $fukidashi.css({'opacity': 0,'transform-origin':'bottom left'});
    $mochileft.css('opacity', 0);
	$flower.addClass('on');
	$recipes.addClass('on');

	/**==========================
	**触る場所はここから
	============================*/

	//▼▼代理店からの要望「もちもち」した感じ▼▼
	//要望にそった動きをつくってみよう

	//イージング確認サイト
	//https://greensock.com/ease-visualizer

	//よくつかう操作方法
	//透明度 opacity: 0~1(0.1や0.5などと記述)
	//横移動 x: -10000~10000
	//縦移動 y: -10000~10000
	//回転(通常) rotation: -360deg ~ 360deg
	//X軸を基準二回転 rotationX: rotationと同様
	//Y軸を基準二回転 rotationY: rotationと同様
	//拡大(通常) scale: 1が等倍、1/10なら0.1、10倍なら10
	//横方向に拡大 scaleX : scaleと同様
	//縦方向に拡大 scaleY : scaleと同様

	var animationStart = function(){
		var tl = new TimelineLite();

		//モデルの表示
		tl.set($main, {
			//はじめの状態を設定
			opacity:0
		});
		tl.to($main, 1, {
			opacity: 1
		}, '+=0');


		//背景の花模様の表示
		tl.set($flowerImg, {
			//はじめの状態を設定
			opacity:0
		});
		tl.to($flowerImg, 1, {
			//変化後の状態を設定
			opacity: 1
		}, '+=0');


		//「きょうも、」の表示
		tl.set($txt1,{
			//はじめの状態を設定
			opacity:0
		});
		tl.to($txt1, 1, {
			//変化後の状態を設定
			opacity: 1
		}, '+=0');


		//「もち」の表示
		tl.set($txt2,{
			//はじめの状態を設定
			opacity:0,
      scale:0
		});
		tl.to($txt2, 1, {
			//変化後の状態を設定
			opacity: 1,
      scale:1,
      ease: Baunce.easeOut
		}, '+=0');


		//「もち」の表示
		tl.set($txt3,{
			//はじめの状態を設定
			opacity:0
		});
		tl.to($txt3, 1, {
			//変化後の状態を設定
			opacity: 1
		}, '+=0');


		//レシピの表示
		tl.set($recipeImg,{
			//はじめの状態を設定
			opacity:0
		});
		tl.to($recipeImg, 1, {
			//変化後の状態を設定
			opacity: 1
		}, '+=0');


		//右側の吹き出し表示
		tl.set($fukidashi,{
			//はじめの状態を設定
			opacity:0
		});
		tl.to($fukidashi, 1, {
			//変化後の状態を設定
			opacity: 1,
		}, '+=0');


		//左側の吹き出し表示
		tl.set($mochileft,{
			//はじめの状態を設定
			opacity:0
		});
		tl.to($mochileft, 1, {
			//変化後の状態を設定
			opacity: 1
		}, '+=0');

	}
	/**==========================
	**触る場所はここまで
	============================*/

     $('#mv').imagesLoaded(function () {
         setTimeout(animationStart, 1000)
     });
});
