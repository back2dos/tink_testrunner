package tink.testrunner;

import haxe.PosInfos;
import tink.testrunner.Suite;
using tink.CoreApi;

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
	function execute(report:Assertion->Void):Promise<Noise>;
}

typedef CaseInfo = {
	final name:String;
	final description:String;
	final pos:PosInfos;
}