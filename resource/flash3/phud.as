package  {
	import flash.display.MovieClip;

	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.geom.Point;
	import flash.text.TextLineMetrics;
	import ValveLib.Globals;
	
	public class phud extends MovieClip {
		
		public var gameAPI:Object;
		public var globals:Object;
		public var elementName:String;
		
		public function setup(api:Object,glob:Object): * {
          this.gameAPI = api;
		  this.globals = glob;
     
          //这是我们的事件的监听器
          this.gameAPI.SubscribeToGameEvent("p_update", this.updateui2);
		  trace("phud ui init complete")
        }
		
		public function phud() {
			// constructor code
		}
		
		 public function updateui2(args:Object) : * {
			 
              trace("jajaja");
              var pID:int = globals.Players.GetLocalPlayer();
			  trace(pID);
			  trace(args.pp1);
			  switch(pID) {
                
			     case 0:
				   this.gold.text=args.pp1g;
				   this.energy.text=args.pp1e;
				   this.food.text=args.pp1r;
				   this.tech.text=args.pp1k;
				   break;
				 case 1:
				   this.gold.text=args.pp2g;
				   this.energy.text=args.pp2e;
				   this.food.text=args.pp2r;
				   this.tech.text=args.pp2k;
				   break;
				 case 2:
				   this.gold.text=args.pp3g;
				   this.energy.text=args.pp3e;
				   this.food.text=args.pp3r;
				   this.tech.text=args.pp3k;
				   break;
				 case 3:
				   this.gold.text=args.pp4g;
				   this.energy.text=args.pp4e;
				   this.food.text=args.pp4r;
				   this.tech.text=args.pp4k;
				   break;
				 case 5:
				   this.gold.text=args.pp5g;
				   this.energy.text=args.pp5e;
				   this.food.text=args.pp5r;
				   this.tech.text=args.pp5k;
				   break;
				 case 6:
				   this.gold.text=args.pp6g;
				   this.energy.text=args.pp6e;
				   this.food.text=args.pp6r;
				   this.tech.text=args.pp6k;
				   break;
				 case 7:
				   this.gold.text=args.pp7g;
				   this.energy.text=args.pp7e;
				   this.food.text=args.pp7r;
				   this.tech.text=args.pp7k;
				   break;
			     case 8:
				   this.gold.text=args.pp8g;
				   this.energy.text=args.pp8e;
				   this.food.text=args.pp8r;
				   this.tech.text=args.pp8k;
				   break;
			  }

            }
		
		
	}
	
}
