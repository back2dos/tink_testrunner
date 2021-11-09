package tink.testrunner;

import haxe.PosInfos;
import tink.testrunner.Suite;

@:forward
abstract Case(CaseObject) from CaseObject to CaseObject {
	public function shouldRun(includeMode:Bool):Bool {
		return !this.exclude && (!includeMode || this.include);
	}
}

interface CaseObject {
	final info:CaseInfo;
	final timeout:Int;
	final include:Bool;
	final exclude:Bool;
	final pos:PosInfos;
	function execute():Assertions;
}

typedef CaseInfo = {
	final name:String;
	final description:String;
	final pos:PosInfos;
}

class BasicCase implements CaseObject {
	public final info:CaseInfo;
	public final timeout:Int = 5000;
	public final include:Bool = false;
	public final exclude:Bool = false;
	public final pos:PosInfos = null;

	public function new(?options:{ ?include:Bool, ?exclude:Bool, ?timeout:Int }, ?pos:PosInfos) {
		if (options != null) {
			include = !!options.include;
			exclude = !!options.exclude;
			if (options.timeout != null)
				timeout = options.timeout;
		}
		info = {
			name: Type.getClassName(Type.getClass(this)),
			description: null,
			pos: pos,
		}
	}

	public function execute():Assertions {
		return [].iterator();
	}
}