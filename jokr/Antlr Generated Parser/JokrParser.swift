// Generated from Jokr.g4 by ANTLR 4.7
import Antlr4

open class JokrParser: Parser {

	internal static var _decisionToDFA: [DFA] = {
          var decisionToDFA = [DFA]()
          let length = JokrParser._ATN.getNumberOfDecisions()
          for i in 0..<length {
            decisionToDFA.append(DFA(JokrParser._ATN.getDecisionState(i)!, i))
           }
           return decisionToDFA
     }()
	internal static let _sharedContextCache: PredictionContextCache = PredictionContextCache()
	public enum Tokens: Int {
		case EOF = -1, CLASS = 1, BLOCK_COMMENT = 2, LINE_COMMENT = 3, OPERATOR = 4, 
                 OPERATOR_CHAR = 5, LPAREN = 6, RPAREN = 7, LBRACE = 8, 
                 RBRACE = 9, COMMA = 10, PERIOD = 11, RETURN = 12, INT = 13, 
                 DECIMAL = 14, TYPE = 15, ID = 16, SNAKE_CASE = 17, ASSIGN = 18, 
                 NEW_LINE = 19, WS = 20
	}
	public static let RULE_program = 0, RULE_statementList = 1, RULE_statement = 2, 
                   RULE_classDeclarationList = 3, RULE_block = 4, RULE_lvalue = 5, 
                   RULE_expression = 6, RULE_parameterList = 7, RULE_parameter = 8, 
                   RULE_assignment = 9, RULE_variableDeclaration = 10, RULE_returnStatement = 11, 
                   RULE_constructorCall = 12, RULE_functionCall = 13, RULE_methodCall = 14, 
                   RULE_classDeclaration = 15, RULE_classMemberList = 16, 
                   RULE_classMember = 17, RULE_functionDeclaration = 18, 
                   RULE_functionDeclarationHeader = 19, RULE_functionDeclarationParameters = 20, 
                   RULE_parameterDeclarationList = 21, RULE_parameterDeclaration = 22
	public static let ruleNames: [String] = [
		"program", "statementList", "statement", "classDeclarationList", "block", 
		"lvalue", "expression", "parameterList", "parameter", "assignment", "variableDeclaration", 
		"returnStatement", "constructorCall", "functionCall", "methodCall", "classDeclaration", 
		"classMemberList", "classMember", "functionDeclaration", "functionDeclarationHeader", 
		"functionDeclarationParameters", "parameterDeclarationList", "parameterDeclaration"
	]

	private static let _LITERAL_NAMES: [String?] = [
		nil, "'class'", nil, nil, nil, nil, "'('", "')'", "'{'", "'}'", "','", 
		"'.'", "'return'", nil, nil, nil, nil, nil, "'='"
	]
	private static let _SYMBOLIC_NAMES: [String?] = [
		nil, "CLASS", "BLOCK_COMMENT", "LINE_COMMENT", "OPERATOR", "OPERATOR_CHAR", 
		"LPAREN", "RPAREN", "LBRACE", "RBRACE", "COMMA", "PERIOD", "RETURN", "INT", 
		"DECIMAL", "TYPE", "ID", "SNAKE_CASE", "ASSIGN", "NEW_LINE", "WS"
	]
	public static let VOCABULARY: Vocabulary = Vocabulary(_LITERAL_NAMES, _SYMBOLIC_NAMES)

	/**
	 * @deprecated Use {@link #VOCABULARY} instead.
	 */
	//@Deprecated
	public let tokenNames: [String?]? = {
	    let length = _SYMBOLIC_NAMES.count
	    var tokenNames = [String?](repeating: nil, count: length)
		for i in 0..<length {
			var name = VOCABULARY.getLiteralName(i)
			if name == nil {
				name = VOCABULARY.getSymbolicName(i)
			}
			if name == nil {
				name = "<INVALID>"
			}
			tokenNames[i] = name
		}
		return tokenNames
	}()

	override
	open func getTokenNames() -> [String?]? {
		return tokenNames
	}

	override
	open func getGrammarFileName() -> String { return "Jokr.g4" }

	override
	open func getRuleNames() -> [String] { return JokrParser.ruleNames }

	override
	open func getSerializedATN() -> String { return JokrParser._serializedATN }

	override
	open func getATN() -> ATN { return JokrParser._ATN }

	open override func getVocabulary() -> Vocabulary {
	    return JokrParser.VOCABULARY
	}

	public override init(_ input:TokenStream)throws {
	    RuntimeMetaData.checkVersion("4.7", RuntimeMetaData.VERSION)
		try super.init(input)
		_interp = ParserATNSimulator(self,JokrParser._ATN,JokrParser._decisionToDFA, JokrParser._sharedContextCache)
	}
	open class ProgramContext:ParserRuleContext {
		open func statementList() -> StatementListContext? {
			return getRuleContext(StatementListContext.self,0)
		}
		open func NEW_LINE() -> TerminalNode? { return getToken(JokrParser.Tokens.NEW_LINE.rawValue, 0) }
		open func classDeclarationList() -> ClassDeclarationListContext? {
			return getRuleContext(ClassDeclarationListContext.self,0)
		}
		open override func getRuleIndex() -> Int { return JokrParser.RULE_program }
		override
		open func enterRule(_ listener: ParseTreeListener) {
			if listener is JokrListener {
			 	(listener as! JokrListener).enterProgram(self)
			}
		}
		override
		open func exitRule(_ listener: ParseTreeListener) {
			if listener is JokrListener {
			 	(listener as! JokrListener).exitProgram(self)
			}
		}
	}
	@discardableResult
	open func program() throws -> ProgramContext {
		var _localctx: ProgramContext = ProgramContext(_ctx, getState())
		try enterRule(_localctx, 0, JokrParser.RULE_program)
		defer {
	    		try! exitRule()
	    }
		do {
		 	setState(55)
		 	try _errHandler.sync(self)
		 	switch(try getInterpreter().adaptivePredict(_input,0, _ctx)) {
		 	case 1:
		 		try enterOuterAlt(_localctx, 1)

		 		break
		 	case 2:
		 		try enterOuterAlt(_localctx, 2)
		 		setState(47)
		 		try statementList(0)

		 		break
		 	case 3:
		 		try enterOuterAlt(_localctx, 3)
		 		setState(48)
		 		try statementList(0)
		 		setState(49)
		 		try match(JokrParser.Tokens.NEW_LINE.rawValue)

		 		break
		 	case 4:
		 		try enterOuterAlt(_localctx, 4)
		 		setState(51)
		 		try classDeclarationList(0)

		 		break
		 	case 5:
		 		try enterOuterAlt(_localctx, 5)
		 		setState(52)
		 		try classDeclarationList(0)
		 		setState(53)
		 		try match(JokrParser.Tokens.NEW_LINE.rawValue)

		 		break
		 	default: break
		 	}
		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}

	open class StatementListContext:ParserRuleContext {
		open func statement() -> StatementContext? {
			return getRuleContext(StatementContext.self,0)
		}
		open func statementList() -> StatementListContext? {
			return getRuleContext(StatementListContext.self,0)
		}
		open func NEW_LINE() -> TerminalNode? { return getToken(JokrParser.Tokens.NEW_LINE.rawValue, 0) }
		open override func getRuleIndex() -> Int { return JokrParser.RULE_statementList }
		override
		open func enterRule(_ listener: ParseTreeListener) {
			if listener is JokrListener {
			 	(listener as! JokrListener).enterStatementList(self)
			}
		}
		override
		open func exitRule(_ listener: ParseTreeListener) {
			if listener is JokrListener {
			 	(listener as! JokrListener).exitStatementList(self)
			}
		}
	}

	public final  func statementList( ) throws -> StatementListContext   {
		return try statementList(0)
	}
	@discardableResult
	private func statementList(_ _p: Int) throws -> StatementListContext   {
		let _parentctx: ParserRuleContext? = _ctx
		var _parentState: Int = getState()
		var _localctx: StatementListContext = StatementListContext(_ctx, _parentState)
		var  _prevctx: StatementListContext = _localctx
		var _startState: Int = 2
		try enterRecursionRule(_localctx, 2, JokrParser.RULE_statementList, _p)
		defer {
	    		try! unrollRecursionContexts(_parentctx)
	    }
		do {
			var _alt: Int
			try enterOuterAlt(_localctx, 1)
			setState(58)
			try statement()

			_ctx!.stop = try _input.LT(-1)
			setState(65)
			try _errHandler.sync(self)
			_alt = try getInterpreter().adaptivePredict(_input,1,_ctx)
			while (_alt != 2 && _alt != ATN.INVALID_ALT_NUMBER) {
				if ( _alt==1 ) {
					if _parseListeners != nil {
					   try triggerExitRuleEvent()
					}
					_prevctx = _localctx
					_localctx = StatementListContext(_parentctx, _parentState);
					try pushNewRecursionContext(_localctx, _startState, JokrParser.RULE_statementList)
					setState(60)
					if (!(precpred(_ctx, 1))) {
					    throw try ANTLRException.recognition(e:FailedPredicateException(self, "precpred(_ctx, 1)"))
					}
					setState(61)
					try match(JokrParser.Tokens.NEW_LINE.rawValue)
					setState(62)
					try statement()

			 
				}
				setState(67)
				try _errHandler.sync(self)
				_alt = try getInterpreter().adaptivePredict(_input,1,_ctx)
			}

		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx;
	}
	open class StatementContext:ParserRuleContext {
		open func assignment() -> AssignmentContext? {
			return getRuleContext(AssignmentContext.self,0)
		}
		open func returnStatement() -> ReturnStatementContext? {
			return getRuleContext(ReturnStatementContext.self,0)
		}
		open func functionCall() -> FunctionCallContext? {
			return getRuleContext(FunctionCallContext.self,0)
		}
		open func methodCall() -> MethodCallContext? {
			return getRuleContext(MethodCallContext.self,0)
		}
		open override func getRuleIndex() -> Int { return JokrParser.RULE_statement }
		override
		open func enterRule(_ listener: ParseTreeListener) {
			if listener is JokrListener {
			 	(listener as! JokrListener).enterStatement(self)
			}
		}
		override
		open func exitRule(_ listener: ParseTreeListener) {
			if listener is JokrListener {
			 	(listener as! JokrListener).exitStatement(self)
			}
		}
	}
	@discardableResult
	open func statement() throws -> StatementContext {
		var _localctx: StatementContext = StatementContext(_ctx, getState())
		try enterRule(_localctx, 4, JokrParser.RULE_statement)
		defer {
	    		try! exitRule()
	    }
		do {
		 	setState(72)
		 	try _errHandler.sync(self)
		 	switch(try getInterpreter().adaptivePredict(_input,2, _ctx)) {
		 	case 1:
		 		try enterOuterAlt(_localctx, 1)
		 		setState(68)
		 		try assignment()

		 		break
		 	case 2:
		 		try enterOuterAlt(_localctx, 2)
		 		setState(69)
		 		try returnStatement()

		 		break
		 	case 3:
		 		try enterOuterAlt(_localctx, 3)
		 		setState(70)
		 		try functionCall()

		 		break
		 	case 4:
		 		try enterOuterAlt(_localctx, 4)
		 		setState(71)
		 		try methodCall()

		 		break
		 	default: break
		 	}
		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}

	open class ClassDeclarationListContext:ParserRuleContext {
		open func classDeclaration() -> ClassDeclarationContext? {
			return getRuleContext(ClassDeclarationContext.self,0)
		}
		open func classDeclarationList() -> ClassDeclarationListContext? {
			return getRuleContext(ClassDeclarationListContext.self,0)
		}
		open func NEW_LINE() -> TerminalNode? { return getToken(JokrParser.Tokens.NEW_LINE.rawValue, 0) }
		open override func getRuleIndex() -> Int { return JokrParser.RULE_classDeclarationList }
		override
		open func enterRule(_ listener: ParseTreeListener) {
			if listener is JokrListener {
			 	(listener as! JokrListener).enterClassDeclarationList(self)
			}
		}
		override
		open func exitRule(_ listener: ParseTreeListener) {
			if listener is JokrListener {
			 	(listener as! JokrListener).exitClassDeclarationList(self)
			}
		}
	}

	public final  func classDeclarationList( ) throws -> ClassDeclarationListContext   {
		return try classDeclarationList(0)
	}
	@discardableResult
	private func classDeclarationList(_ _p: Int) throws -> ClassDeclarationListContext   {
		let _parentctx: ParserRuleContext? = _ctx
		var _parentState: Int = getState()
		var _localctx: ClassDeclarationListContext = ClassDeclarationListContext(_ctx, _parentState)
		var  _prevctx: ClassDeclarationListContext = _localctx
		var _startState: Int = 6
		try enterRecursionRule(_localctx, 6, JokrParser.RULE_classDeclarationList, _p)
		defer {
	    		try! unrollRecursionContexts(_parentctx)
	    }
		do {
			var _alt: Int
			try enterOuterAlt(_localctx, 1)
			setState(75)
			try classDeclaration()

			_ctx!.stop = try _input.LT(-1)
			setState(82)
			try _errHandler.sync(self)
			_alt = try getInterpreter().adaptivePredict(_input,3,_ctx)
			while (_alt != 2 && _alt != ATN.INVALID_ALT_NUMBER) {
				if ( _alt==1 ) {
					if _parseListeners != nil {
					   try triggerExitRuleEvent()
					}
					_prevctx = _localctx
					_localctx = ClassDeclarationListContext(_parentctx, _parentState);
					try pushNewRecursionContext(_localctx, _startState, JokrParser.RULE_classDeclarationList)
					setState(77)
					if (!(precpred(_ctx, 1))) {
					    throw try ANTLRException.recognition(e:FailedPredicateException(self, "precpred(_ctx, 1)"))
					}
					setState(78)
					try match(JokrParser.Tokens.NEW_LINE.rawValue)
					setState(79)
					try classDeclaration()

			 
				}
				setState(84)
				try _errHandler.sync(self)
				_alt = try getInterpreter().adaptivePredict(_input,3,_ctx)
			}

		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx;
	}
	open class BlockContext:ParserRuleContext {
		open func LBRACE() -> TerminalNode? { return getToken(JokrParser.Tokens.LBRACE.rawValue, 0) }
		open func NEW_LINE() -> Array<TerminalNode> { return getTokens(JokrParser.Tokens.NEW_LINE.rawValue) }
		open func NEW_LINE(_ i:Int) -> TerminalNode?{
			return getToken(JokrParser.Tokens.NEW_LINE.rawValue, i)
		}
		open func RBRACE() -> TerminalNode? { return getToken(JokrParser.Tokens.RBRACE.rawValue, 0) }
		open func statementList() -> StatementListContext? {
			return getRuleContext(StatementListContext.self,0)
		}
		open override func getRuleIndex() -> Int { return JokrParser.RULE_block }
		override
		open func enterRule(_ listener: ParseTreeListener) {
			if listener is JokrListener {
			 	(listener as! JokrListener).enterBlock(self)
			}
		}
		override
		open func exitRule(_ listener: ParseTreeListener) {
			if listener is JokrListener {
			 	(listener as! JokrListener).exitBlock(self)
			}
		}
	}
	@discardableResult
	open func block() throws -> BlockContext {
		var _localctx: BlockContext = BlockContext(_ctx, getState())
		try enterRule(_localctx, 8, JokrParser.RULE_block)
		defer {
	    		try! exitRule()
	    }
		do {
		 	setState(94)
		 	try _errHandler.sync(self)
		 	switch(try getInterpreter().adaptivePredict(_input,4, _ctx)) {
		 	case 1:
		 		try enterOuterAlt(_localctx, 1)
		 		setState(85)
		 		try match(JokrParser.Tokens.LBRACE.rawValue)
		 		setState(86)
		 		try match(JokrParser.Tokens.NEW_LINE.rawValue)
		 		setState(87)
		 		try match(JokrParser.Tokens.RBRACE.rawValue)

		 		break
		 	case 2:
		 		try enterOuterAlt(_localctx, 2)
		 		setState(88)
		 		try match(JokrParser.Tokens.LBRACE.rawValue)
		 		setState(89)
		 		try match(JokrParser.Tokens.NEW_LINE.rawValue)
		 		setState(90)
		 		try statementList(0)
		 		setState(91)
		 		try match(JokrParser.Tokens.NEW_LINE.rawValue)
		 		setState(92)
		 		try match(JokrParser.Tokens.RBRACE.rawValue)

		 		break
		 	default: break
		 	}
		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}
	open class LvalueContext:ParserRuleContext {
		open func ID() -> TerminalNode? { return getToken(JokrParser.Tokens.ID.rawValue, 0) }
		open override func getRuleIndex() -> Int { return JokrParser.RULE_lvalue }
		override
		open func enterRule(_ listener: ParseTreeListener) {
			if listener is JokrListener {
			 	(listener as! JokrListener).enterLvalue(self)
			}
		}
		override
		open func exitRule(_ listener: ParseTreeListener) {
			if listener is JokrListener {
			 	(listener as! JokrListener).exitLvalue(self)
			}
		}
	}
	@discardableResult
	open func lvalue() throws -> LvalueContext {
		var _localctx: LvalueContext = LvalueContext(_ctx, getState())
		try enterRule(_localctx, 10, JokrParser.RULE_lvalue)
		defer {
	    		try! exitRule()
	    }
		do {
		 	try enterOuterAlt(_localctx, 1)
		 	setState(96)
		 	try match(JokrParser.Tokens.ID.rawValue)

		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}

	open class ExpressionContext:ParserRuleContext {
		open func INT() -> TerminalNode? { return getToken(JokrParser.Tokens.INT.rawValue, 0) }
		open func DECIMAL() -> TerminalNode? { return getToken(JokrParser.Tokens.DECIMAL.rawValue, 0) }
		open func LPAREN() -> TerminalNode? { return getToken(JokrParser.Tokens.LPAREN.rawValue, 0) }
		open func expression() -> Array<ExpressionContext> {
			return getRuleContexts(ExpressionContext.self)
		}
		open func expression(_ i: Int) -> ExpressionContext? {
			return getRuleContext(ExpressionContext.self,i)
		}
		open func RPAREN() -> TerminalNode? { return getToken(JokrParser.Tokens.RPAREN.rawValue, 0) }
		open func lvalue() -> LvalueContext? {
			return getRuleContext(LvalueContext.self,0)
		}
		open func constructorCall() -> ConstructorCallContext? {
			return getRuleContext(ConstructorCallContext.self,0)
		}
		open func functionCall() -> FunctionCallContext? {
			return getRuleContext(FunctionCallContext.self,0)
		}
		open func methodCall() -> MethodCallContext? {
			return getRuleContext(MethodCallContext.self,0)
		}
		open func OPERATOR() -> TerminalNode? { return getToken(JokrParser.Tokens.OPERATOR.rawValue, 0) }
		open override func getRuleIndex() -> Int { return JokrParser.RULE_expression }
		override
		open func enterRule(_ listener: ParseTreeListener) {
			if listener is JokrListener {
			 	(listener as! JokrListener).enterExpression(self)
			}
		}
		override
		open func exitRule(_ listener: ParseTreeListener) {
			if listener is JokrListener {
			 	(listener as! JokrListener).exitExpression(self)
			}
		}
	}

	public final  func expression( ) throws -> ExpressionContext   {
		return try expression(0)
	}
	@discardableResult
	private func expression(_ _p: Int) throws -> ExpressionContext   {
		let _parentctx: ParserRuleContext? = _ctx
		var _parentState: Int = getState()
		var _localctx: ExpressionContext = ExpressionContext(_ctx, _parentState)
		var  _prevctx: ExpressionContext = _localctx
		var _startState: Int = 12
		try enterRecursionRule(_localctx, 12, JokrParser.RULE_expression, _p)
		defer {
	    		try! unrollRecursionContexts(_parentctx)
	    }
		do {
			var _alt: Int
			try enterOuterAlt(_localctx, 1)
			setState(109)
			try _errHandler.sync(self)
			switch(try getInterpreter().adaptivePredict(_input,5, _ctx)) {
			case 1:
				setState(99)
				try match(JokrParser.Tokens.INT.rawValue)

				break
			case 2:
				setState(100)
				try match(JokrParser.Tokens.DECIMAL.rawValue)

				break
			case 3:
				setState(101)
				try match(JokrParser.Tokens.LPAREN.rawValue)
				setState(102)
				try expression(0)
				setState(103)
				try match(JokrParser.Tokens.RPAREN.rawValue)

				break
			case 4:
				setState(105)
				try lvalue()

				break
			case 5:
				setState(106)
				try constructorCall()

				break
			case 6:
				setState(107)
				try functionCall()

				break
			case 7:
				setState(108)
				try methodCall()

				break
			default: break
			}
			_ctx!.stop = try _input.LT(-1)
			setState(116)
			try _errHandler.sync(self)
			_alt = try getInterpreter().adaptivePredict(_input,6,_ctx)
			while (_alt != 2 && _alt != ATN.INVALID_ALT_NUMBER) {
				if ( _alt==1 ) {
					if _parseListeners != nil {
					   try triggerExitRuleEvent()
					}
					_prevctx = _localctx
					_localctx = ExpressionContext(_parentctx, _parentState);
					try pushNewRecursionContext(_localctx, _startState, JokrParser.RULE_expression)
					setState(111)
					if (!(precpred(_ctx, 5))) {
					    throw try ANTLRException.recognition(e:FailedPredicateException(self, "precpred(_ctx, 5)"))
					}
					setState(112)
					try match(JokrParser.Tokens.OPERATOR.rawValue)
					setState(113)
					try expression(6)

			 
				}
				setState(118)
				try _errHandler.sync(self)
				_alt = try getInterpreter().adaptivePredict(_input,6,_ctx)
			}

		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx;
	}

	open class ParameterListContext:ParserRuleContext {
		open func parameter() -> ParameterContext? {
			return getRuleContext(ParameterContext.self,0)
		}
		open func parameterList() -> ParameterListContext? {
			return getRuleContext(ParameterListContext.self,0)
		}
		open func COMMA() -> TerminalNode? { return getToken(JokrParser.Tokens.COMMA.rawValue, 0) }
		open override func getRuleIndex() -> Int { return JokrParser.RULE_parameterList }
		override
		open func enterRule(_ listener: ParseTreeListener) {
			if listener is JokrListener {
			 	(listener as! JokrListener).enterParameterList(self)
			}
		}
		override
		open func exitRule(_ listener: ParseTreeListener) {
			if listener is JokrListener {
			 	(listener as! JokrListener).exitParameterList(self)
			}
		}
	}

	public final  func parameterList( ) throws -> ParameterListContext   {
		return try parameterList(0)
	}
	@discardableResult
	private func parameterList(_ _p: Int) throws -> ParameterListContext   {
		let _parentctx: ParserRuleContext? = _ctx
		var _parentState: Int = getState()
		var _localctx: ParameterListContext = ParameterListContext(_ctx, _parentState)
		var  _prevctx: ParameterListContext = _localctx
		var _startState: Int = 14
		try enterRecursionRule(_localctx, 14, JokrParser.RULE_parameterList, _p)
		defer {
	    		try! unrollRecursionContexts(_parentctx)
	    }
		do {
			var _alt: Int
			try enterOuterAlt(_localctx, 1)
			setState(121)
			try _errHandler.sync(self)
			switch(try getInterpreter().adaptivePredict(_input,7, _ctx)) {
			case 1:
				break
			case 2:
				setState(120)
				try parameter()

				break
			default: break
			}
			_ctx!.stop = try _input.LT(-1)
			setState(128)
			try _errHandler.sync(self)
			_alt = try getInterpreter().adaptivePredict(_input,8,_ctx)
			while (_alt != 2 && _alt != ATN.INVALID_ALT_NUMBER) {
				if ( _alt==1 ) {
					if _parseListeners != nil {
					   try triggerExitRuleEvent()
					}
					_prevctx = _localctx
					_localctx = ParameterListContext(_parentctx, _parentState);
					try pushNewRecursionContext(_localctx, _startState, JokrParser.RULE_parameterList)
					setState(123)
					if (!(precpred(_ctx, 1))) {
					    throw try ANTLRException.recognition(e:FailedPredicateException(self, "precpred(_ctx, 1)"))
					}
					setState(124)
					try match(JokrParser.Tokens.COMMA.rawValue)
					setState(125)
					try parameter()

			 
				}
				setState(130)
				try _errHandler.sync(self)
				_alt = try getInterpreter().adaptivePredict(_input,8,_ctx)
			}

		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx;
	}
	open class ParameterContext:ParserRuleContext {
		open func expression() -> ExpressionContext? {
			return getRuleContext(ExpressionContext.self,0)
		}
		open override func getRuleIndex() -> Int { return JokrParser.RULE_parameter }
		override
		open func enterRule(_ listener: ParseTreeListener) {
			if listener is JokrListener {
			 	(listener as! JokrListener).enterParameter(self)
			}
		}
		override
		open func exitRule(_ listener: ParseTreeListener) {
			if listener is JokrListener {
			 	(listener as! JokrListener).exitParameter(self)
			}
		}
	}
	@discardableResult
	open func parameter() throws -> ParameterContext {
		var _localctx: ParameterContext = ParameterContext(_ctx, getState())
		try enterRule(_localctx, 16, JokrParser.RULE_parameter)
		defer {
	    		try! exitRule()
	    }
		do {
		 	try enterOuterAlt(_localctx, 1)
		 	setState(131)
		 	try expression(0)

		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}
	open class AssignmentContext:ParserRuleContext {
		open func variableDeclaration() -> VariableDeclarationContext? {
			return getRuleContext(VariableDeclarationContext.self,0)
		}
		open func ASSIGN() -> TerminalNode? { return getToken(JokrParser.Tokens.ASSIGN.rawValue, 0) }
		open func expression() -> ExpressionContext? {
			return getRuleContext(ExpressionContext.self,0)
		}
		open func lvalue() -> LvalueContext? {
			return getRuleContext(LvalueContext.self,0)
		}
		open override func getRuleIndex() -> Int { return JokrParser.RULE_assignment }
		override
		open func enterRule(_ listener: ParseTreeListener) {
			if listener is JokrListener {
			 	(listener as! JokrListener).enterAssignment(self)
			}
		}
		override
		open func exitRule(_ listener: ParseTreeListener) {
			if listener is JokrListener {
			 	(listener as! JokrListener).exitAssignment(self)
			}
		}
	}
	@discardableResult
	open func assignment() throws -> AssignmentContext {
		var _localctx: AssignmentContext = AssignmentContext(_ctx, getState())
		try enterRule(_localctx, 18, JokrParser.RULE_assignment)
		defer {
	    		try! exitRule()
	    }
		do {
		 	setState(141)
		 	try _errHandler.sync(self)
		 	switch (JokrParser.Tokens(rawValue: try _input.LA(1))!) {
		 	case .TYPE:
		 		try enterOuterAlt(_localctx, 1)
		 		setState(133)
		 		try variableDeclaration()
		 		setState(134)
		 		try match(JokrParser.Tokens.ASSIGN.rawValue)
		 		setState(135)
		 		try expression(0)

		 		break

		 	case .ID:
		 		try enterOuterAlt(_localctx, 2)
		 		setState(137)
		 		try lvalue()
		 		setState(138)
		 		try match(JokrParser.Tokens.ASSIGN.rawValue)
		 		setState(139)
		 		try expression(0)

		 		break
		 	default:
		 		throw try ANTLRException.recognition(e: NoViableAltException(self))
		 	}
		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}
	open class VariableDeclarationContext:ParserRuleContext {
		open func TYPE() -> TerminalNode? { return getToken(JokrParser.Tokens.TYPE.rawValue, 0) }
		open func ID() -> TerminalNode? { return getToken(JokrParser.Tokens.ID.rawValue, 0) }
		open override func getRuleIndex() -> Int { return JokrParser.RULE_variableDeclaration }
		override
		open func enterRule(_ listener: ParseTreeListener) {
			if listener is JokrListener {
			 	(listener as! JokrListener).enterVariableDeclaration(self)
			}
		}
		override
		open func exitRule(_ listener: ParseTreeListener) {
			if listener is JokrListener {
			 	(listener as! JokrListener).exitVariableDeclaration(self)
			}
		}
	}
	@discardableResult
	open func variableDeclaration() throws -> VariableDeclarationContext {
		var _localctx: VariableDeclarationContext = VariableDeclarationContext(_ctx, getState())
		try enterRule(_localctx, 20, JokrParser.RULE_variableDeclaration)
		defer {
	    		try! exitRule()
	    }
		do {
		 	try enterOuterAlt(_localctx, 1)
		 	setState(143)
		 	try match(JokrParser.Tokens.TYPE.rawValue)
		 	setState(144)
		 	try match(JokrParser.Tokens.ID.rawValue)

		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}
	open class ReturnStatementContext:ParserRuleContext {
		open func RETURN() -> TerminalNode? { return getToken(JokrParser.Tokens.RETURN.rawValue, 0) }
		open func expression() -> ExpressionContext? {
			return getRuleContext(ExpressionContext.self,0)
		}
		open override func getRuleIndex() -> Int { return JokrParser.RULE_returnStatement }
		override
		open func enterRule(_ listener: ParseTreeListener) {
			if listener is JokrListener {
			 	(listener as! JokrListener).enterReturnStatement(self)
			}
		}
		override
		open func exitRule(_ listener: ParseTreeListener) {
			if listener is JokrListener {
			 	(listener as! JokrListener).exitReturnStatement(self)
			}
		}
	}
	@discardableResult
	open func returnStatement() throws -> ReturnStatementContext {
		var _localctx: ReturnStatementContext = ReturnStatementContext(_ctx, getState())
		try enterRule(_localctx, 22, JokrParser.RULE_returnStatement)
		defer {
	    		try! exitRule()
	    }
		do {
		 	try enterOuterAlt(_localctx, 1)
		 	setState(146)
		 	try match(JokrParser.Tokens.RETURN.rawValue)
		 	setState(147)
		 	try expression(0)

		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}
	open class ConstructorCallContext:ParserRuleContext {
		open func TYPE() -> TerminalNode? { return getToken(JokrParser.Tokens.TYPE.rawValue, 0) }
		open func LPAREN() -> TerminalNode? { return getToken(JokrParser.Tokens.LPAREN.rawValue, 0) }
		open func parameterList() -> ParameterListContext? {
			return getRuleContext(ParameterListContext.self,0)
		}
		open func RPAREN() -> TerminalNode? { return getToken(JokrParser.Tokens.RPAREN.rawValue, 0) }
		open override func getRuleIndex() -> Int { return JokrParser.RULE_constructorCall }
		override
		open func enterRule(_ listener: ParseTreeListener) {
			if listener is JokrListener {
			 	(listener as! JokrListener).enterConstructorCall(self)
			}
		}
		override
		open func exitRule(_ listener: ParseTreeListener) {
			if listener is JokrListener {
			 	(listener as! JokrListener).exitConstructorCall(self)
			}
		}
	}
	@discardableResult
	open func constructorCall() throws -> ConstructorCallContext {
		var _localctx: ConstructorCallContext = ConstructorCallContext(_ctx, getState())
		try enterRule(_localctx, 24, JokrParser.RULE_constructorCall)
		defer {
	    		try! exitRule()
	    }
		do {
		 	try enterOuterAlt(_localctx, 1)
		 	setState(149)
		 	try match(JokrParser.Tokens.TYPE.rawValue)
		 	setState(150)
		 	try match(JokrParser.Tokens.LPAREN.rawValue)
		 	setState(151)
		 	try parameterList(0)
		 	setState(152)
		 	try match(JokrParser.Tokens.RPAREN.rawValue)

		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}
	open class FunctionCallContext:ParserRuleContext {
		open func ID() -> TerminalNode? { return getToken(JokrParser.Tokens.ID.rawValue, 0) }
		open func LPAREN() -> TerminalNode? { return getToken(JokrParser.Tokens.LPAREN.rawValue, 0) }
		open func parameterList() -> ParameterListContext? {
			return getRuleContext(ParameterListContext.self,0)
		}
		open func RPAREN() -> TerminalNode? { return getToken(JokrParser.Tokens.RPAREN.rawValue, 0) }
		open override func getRuleIndex() -> Int { return JokrParser.RULE_functionCall }
		override
		open func enterRule(_ listener: ParseTreeListener) {
			if listener is JokrListener {
			 	(listener as! JokrListener).enterFunctionCall(self)
			}
		}
		override
		open func exitRule(_ listener: ParseTreeListener) {
			if listener is JokrListener {
			 	(listener as! JokrListener).exitFunctionCall(self)
			}
		}
	}
	@discardableResult
	open func functionCall() throws -> FunctionCallContext {
		var _localctx: FunctionCallContext = FunctionCallContext(_ctx, getState())
		try enterRule(_localctx, 26, JokrParser.RULE_functionCall)
		defer {
	    		try! exitRule()
	    }
		do {
		 	try enterOuterAlt(_localctx, 1)
		 	setState(154)
		 	try match(JokrParser.Tokens.ID.rawValue)
		 	setState(155)
		 	try match(JokrParser.Tokens.LPAREN.rawValue)
		 	setState(156)
		 	try parameterList(0)
		 	setState(157)
		 	try match(JokrParser.Tokens.RPAREN.rawValue)

		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}
	open class MethodCallContext:ParserRuleContext {
		open func ID() -> TerminalNode? { return getToken(JokrParser.Tokens.ID.rawValue, 0) }
		open func PERIOD() -> TerminalNode? { return getToken(JokrParser.Tokens.PERIOD.rawValue, 0) }
		open func functionCall() -> FunctionCallContext? {
			return getRuleContext(FunctionCallContext.self,0)
		}
		open func NEW_LINE() -> Array<TerminalNode> { return getTokens(JokrParser.Tokens.NEW_LINE.rawValue) }
		open func NEW_LINE(_ i:Int) -> TerminalNode?{
			return getToken(JokrParser.Tokens.NEW_LINE.rawValue, i)
		}
		open override func getRuleIndex() -> Int { return JokrParser.RULE_methodCall }
		override
		open func enterRule(_ listener: ParseTreeListener) {
			if listener is JokrListener {
			 	(listener as! JokrListener).enterMethodCall(self)
			}
		}
		override
		open func exitRule(_ listener: ParseTreeListener) {
			if listener is JokrListener {
			 	(listener as! JokrListener).exitMethodCall(self)
			}
		}
	}
	@discardableResult
	open func methodCall() throws -> MethodCallContext {
		var _localctx: MethodCallContext = MethodCallContext(_ctx, getState())
		try enterRule(_localctx, 28, JokrParser.RULE_methodCall)
		var _la: Int = 0
		defer {
	    		try! exitRule()
	    }
		do {
		 	try enterOuterAlt(_localctx, 1)
		 	setState(159)
		 	try match(JokrParser.Tokens.ID.rawValue)
		 	setState(161)
		 	try _errHandler.sync(self)
		 	_la = try _input.LA(1)
		 	if (//closure
		 	 { () -> Bool in
		 	      let testSet: Bool = _la == JokrParser.Tokens.NEW_LINE.rawValue
		 	      return testSet
		 	 }()) {
		 		setState(160)
		 		try match(JokrParser.Tokens.NEW_LINE.rawValue)

		 	}

		 	setState(163)
		 	try match(JokrParser.Tokens.PERIOD.rawValue)
		 	setState(165)
		 	try _errHandler.sync(self)
		 	_la = try _input.LA(1)
		 	if (//closure
		 	 { () -> Bool in
		 	      let testSet: Bool = _la == JokrParser.Tokens.NEW_LINE.rawValue
		 	      return testSet
		 	 }()) {
		 		setState(164)
		 		try match(JokrParser.Tokens.NEW_LINE.rawValue)

		 	}

		 	setState(167)
		 	try functionCall()

		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}
	open class ClassDeclarationContext:ParserRuleContext {
		open func CLASS() -> TerminalNode? { return getToken(JokrParser.Tokens.CLASS.rawValue, 0) }
		open func TYPE() -> TerminalNode? { return getToken(JokrParser.Tokens.TYPE.rawValue, 0) }
		open func LBRACE() -> TerminalNode? { return getToken(JokrParser.Tokens.LBRACE.rawValue, 0) }
		open func NEW_LINE() -> Array<TerminalNode> { return getTokens(JokrParser.Tokens.NEW_LINE.rawValue) }
		open func NEW_LINE(_ i:Int) -> TerminalNode?{
			return getToken(JokrParser.Tokens.NEW_LINE.rawValue, i)
		}
		open func RBRACE() -> TerminalNode? { return getToken(JokrParser.Tokens.RBRACE.rawValue, 0) }
		open func classMemberList() -> ClassMemberListContext? {
			return getRuleContext(ClassMemberListContext.self,0)
		}
		open override func getRuleIndex() -> Int { return JokrParser.RULE_classDeclaration }
		override
		open func enterRule(_ listener: ParseTreeListener) {
			if listener is JokrListener {
			 	(listener as! JokrListener).enterClassDeclaration(self)
			}
		}
		override
		open func exitRule(_ listener: ParseTreeListener) {
			if listener is JokrListener {
			 	(listener as! JokrListener).exitClassDeclaration(self)
			}
		}
	}
	@discardableResult
	open func classDeclaration() throws -> ClassDeclarationContext {
		var _localctx: ClassDeclarationContext = ClassDeclarationContext(_ctx, getState())
		try enterRule(_localctx, 30, JokrParser.RULE_classDeclaration)
		defer {
	    		try! exitRule()
	    }
		do {
		 	setState(182)
		 	try _errHandler.sync(self)
		 	switch(try getInterpreter().adaptivePredict(_input,12, _ctx)) {
		 	case 1:
		 		try enterOuterAlt(_localctx, 1)
		 		setState(169)
		 		try match(JokrParser.Tokens.CLASS.rawValue)
		 		setState(170)
		 		try match(JokrParser.Tokens.TYPE.rawValue)
		 		setState(171)
		 		try match(JokrParser.Tokens.LBRACE.rawValue)
		 		setState(172)
		 		try match(JokrParser.Tokens.NEW_LINE.rawValue)
		 		setState(173)
		 		try match(JokrParser.Tokens.RBRACE.rawValue)

		 		break
		 	case 2:
		 		try enterOuterAlt(_localctx, 2)
		 		setState(174)
		 		try match(JokrParser.Tokens.CLASS.rawValue)
		 		setState(175)
		 		try match(JokrParser.Tokens.TYPE.rawValue)
		 		setState(176)
		 		try match(JokrParser.Tokens.LBRACE.rawValue)
		 		setState(177)
		 		try match(JokrParser.Tokens.NEW_LINE.rawValue)
		 		setState(178)
		 		try classMemberList(0)
		 		setState(179)
		 		try match(JokrParser.Tokens.NEW_LINE.rawValue)
		 		setState(180)
		 		try match(JokrParser.Tokens.RBRACE.rawValue)

		 		break
		 	default: break
		 	}
		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}

	open class ClassMemberListContext:ParserRuleContext {
		open func classMember() -> ClassMemberContext? {
			return getRuleContext(ClassMemberContext.self,0)
		}
		open func classMemberList() -> ClassMemberListContext? {
			return getRuleContext(ClassMemberListContext.self,0)
		}
		open func NEW_LINE() -> TerminalNode? { return getToken(JokrParser.Tokens.NEW_LINE.rawValue, 0) }
		open override func getRuleIndex() -> Int { return JokrParser.RULE_classMemberList }
		override
		open func enterRule(_ listener: ParseTreeListener) {
			if listener is JokrListener {
			 	(listener as! JokrListener).enterClassMemberList(self)
			}
		}
		override
		open func exitRule(_ listener: ParseTreeListener) {
			if listener is JokrListener {
			 	(listener as! JokrListener).exitClassMemberList(self)
			}
		}
	}

	public final  func classMemberList( ) throws -> ClassMemberListContext   {
		return try classMemberList(0)
	}
	@discardableResult
	private func classMemberList(_ _p: Int) throws -> ClassMemberListContext   {
		let _parentctx: ParserRuleContext? = _ctx
		var _parentState: Int = getState()
		var _localctx: ClassMemberListContext = ClassMemberListContext(_ctx, _parentState)
		var  _prevctx: ClassMemberListContext = _localctx
		var _startState: Int = 32
		try enterRecursionRule(_localctx, 32, JokrParser.RULE_classMemberList, _p)
		defer {
	    		try! unrollRecursionContexts(_parentctx)
	    }
		do {
			var _alt: Int
			try enterOuterAlt(_localctx, 1)
			setState(186)
			try _errHandler.sync(self)
			switch(try getInterpreter().adaptivePredict(_input,13, _ctx)) {
			case 1:
				break
			case 2:
				setState(185)
				try classMember()

				break
			default: break
			}
			_ctx!.stop = try _input.LT(-1)
			setState(193)
			try _errHandler.sync(self)
			_alt = try getInterpreter().adaptivePredict(_input,14,_ctx)
			while (_alt != 2 && _alt != ATN.INVALID_ALT_NUMBER) {
				if ( _alt==1 ) {
					if _parseListeners != nil {
					   try triggerExitRuleEvent()
					}
					_prevctx = _localctx
					_localctx = ClassMemberListContext(_parentctx, _parentState);
					try pushNewRecursionContext(_localctx, _startState, JokrParser.RULE_classMemberList)
					setState(188)
					if (!(precpred(_ctx, 1))) {
					    throw try ANTLRException.recognition(e:FailedPredicateException(self, "precpred(_ctx, 1)"))
					}
					setState(189)
					try match(JokrParser.Tokens.NEW_LINE.rawValue)
					setState(190)
					try classMember()

			 
				}
				setState(195)
				try _errHandler.sync(self)
				_alt = try getInterpreter().adaptivePredict(_input,14,_ctx)
			}

		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx;
	}
	open class ClassMemberContext:ParserRuleContext {
		open func functionDeclaration() -> FunctionDeclarationContext? {
			return getRuleContext(FunctionDeclarationContext.self,0)
		}
		open override func getRuleIndex() -> Int { return JokrParser.RULE_classMember }
		override
		open func enterRule(_ listener: ParseTreeListener) {
			if listener is JokrListener {
			 	(listener as! JokrListener).enterClassMember(self)
			}
		}
		override
		open func exitRule(_ listener: ParseTreeListener) {
			if listener is JokrListener {
			 	(listener as! JokrListener).exitClassMember(self)
			}
		}
	}
	@discardableResult
	open func classMember() throws -> ClassMemberContext {
		var _localctx: ClassMemberContext = ClassMemberContext(_ctx, getState())
		try enterRule(_localctx, 34, JokrParser.RULE_classMember)
		defer {
	    		try! exitRule()
	    }
		do {
		 	try enterOuterAlt(_localctx, 1)
		 	setState(196)
		 	try functionDeclaration()

		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}
	open class FunctionDeclarationContext:ParserRuleContext {
		open func functionDeclarationHeader() -> FunctionDeclarationHeaderContext? {
			return getRuleContext(FunctionDeclarationHeaderContext.self,0)
		}
		open func functionDeclarationParameters() -> FunctionDeclarationParametersContext? {
			return getRuleContext(FunctionDeclarationParametersContext.self,0)
		}
		open func block() -> BlockContext? {
			return getRuleContext(BlockContext.self,0)
		}
		open override func getRuleIndex() -> Int { return JokrParser.RULE_functionDeclaration }
		override
		open func enterRule(_ listener: ParseTreeListener) {
			if listener is JokrListener {
			 	(listener as! JokrListener).enterFunctionDeclaration(self)
			}
		}
		override
		open func exitRule(_ listener: ParseTreeListener) {
			if listener is JokrListener {
			 	(listener as! JokrListener).exitFunctionDeclaration(self)
			}
		}
	}
	@discardableResult
	open func functionDeclaration() throws -> FunctionDeclarationContext {
		var _localctx: FunctionDeclarationContext = FunctionDeclarationContext(_ctx, getState())
		try enterRule(_localctx, 36, JokrParser.RULE_functionDeclaration)
		defer {
	    		try! exitRule()
	    }
		do {
		 	try enterOuterAlt(_localctx, 1)
		 	setState(198)
		 	try functionDeclarationHeader()
		 	setState(199)
		 	try functionDeclarationParameters()
		 	setState(200)
		 	try block()

		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}
	open class FunctionDeclarationHeaderContext:ParserRuleContext {
		open func TYPE() -> TerminalNode? { return getToken(JokrParser.Tokens.TYPE.rawValue, 0) }
		open func ID() -> TerminalNode? { return getToken(JokrParser.Tokens.ID.rawValue, 0) }
		open override func getRuleIndex() -> Int { return JokrParser.RULE_functionDeclarationHeader }
		override
		open func enterRule(_ listener: ParseTreeListener) {
			if listener is JokrListener {
			 	(listener as! JokrListener).enterFunctionDeclarationHeader(self)
			}
		}
		override
		open func exitRule(_ listener: ParseTreeListener) {
			if listener is JokrListener {
			 	(listener as! JokrListener).exitFunctionDeclarationHeader(self)
			}
		}
	}
	@discardableResult
	open func functionDeclarationHeader() throws -> FunctionDeclarationHeaderContext {
		var _localctx: FunctionDeclarationHeaderContext = FunctionDeclarationHeaderContext(_ctx, getState())
		try enterRule(_localctx, 38, JokrParser.RULE_functionDeclarationHeader)
		defer {
	    		try! exitRule()
	    }
		do {
		 	try enterOuterAlt(_localctx, 1)
		 	setState(202)
		 	try match(JokrParser.Tokens.TYPE.rawValue)
		 	setState(203)
		 	try match(JokrParser.Tokens.ID.rawValue)

		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}
	open class FunctionDeclarationParametersContext:ParserRuleContext {
		open func LPAREN() -> TerminalNode? { return getToken(JokrParser.Tokens.LPAREN.rawValue, 0) }
		open func parameterDeclarationList() -> ParameterDeclarationListContext? {
			return getRuleContext(ParameterDeclarationListContext.self,0)
		}
		open func RPAREN() -> TerminalNode? { return getToken(JokrParser.Tokens.RPAREN.rawValue, 0) }
		open override func getRuleIndex() -> Int { return JokrParser.RULE_functionDeclarationParameters }
		override
		open func enterRule(_ listener: ParseTreeListener) {
			if listener is JokrListener {
			 	(listener as! JokrListener).enterFunctionDeclarationParameters(self)
			}
		}
		override
		open func exitRule(_ listener: ParseTreeListener) {
			if listener is JokrListener {
			 	(listener as! JokrListener).exitFunctionDeclarationParameters(self)
			}
		}
	}
	@discardableResult
	open func functionDeclarationParameters() throws -> FunctionDeclarationParametersContext {
		var _localctx: FunctionDeclarationParametersContext = FunctionDeclarationParametersContext(_ctx, getState())
		try enterRule(_localctx, 40, JokrParser.RULE_functionDeclarationParameters)
		defer {
	    		try! exitRule()
	    }
		do {
		 	try enterOuterAlt(_localctx, 1)
		 	setState(205)
		 	try match(JokrParser.Tokens.LPAREN.rawValue)
		 	setState(206)
		 	try parameterDeclarationList(0)
		 	setState(207)
		 	try match(JokrParser.Tokens.RPAREN.rawValue)

		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}

	open class ParameterDeclarationListContext:ParserRuleContext {
		open func parameterDeclaration() -> ParameterDeclarationContext? {
			return getRuleContext(ParameterDeclarationContext.self,0)
		}
		open func parameterDeclarationList() -> ParameterDeclarationListContext? {
			return getRuleContext(ParameterDeclarationListContext.self,0)
		}
		open func COMMA() -> TerminalNode? { return getToken(JokrParser.Tokens.COMMA.rawValue, 0) }
		open override func getRuleIndex() -> Int { return JokrParser.RULE_parameterDeclarationList }
		override
		open func enterRule(_ listener: ParseTreeListener) {
			if listener is JokrListener {
			 	(listener as! JokrListener).enterParameterDeclarationList(self)
			}
		}
		override
		open func exitRule(_ listener: ParseTreeListener) {
			if listener is JokrListener {
			 	(listener as! JokrListener).exitParameterDeclarationList(self)
			}
		}
	}

	public final  func parameterDeclarationList( ) throws -> ParameterDeclarationListContext   {
		return try parameterDeclarationList(0)
	}
	@discardableResult
	private func parameterDeclarationList(_ _p: Int) throws -> ParameterDeclarationListContext   {
		let _parentctx: ParserRuleContext? = _ctx
		var _parentState: Int = getState()
		var _localctx: ParameterDeclarationListContext = ParameterDeclarationListContext(_ctx, _parentState)
		var  _prevctx: ParameterDeclarationListContext = _localctx
		var _startState: Int = 42
		try enterRecursionRule(_localctx, 42, JokrParser.RULE_parameterDeclarationList, _p)
		defer {
	    		try! unrollRecursionContexts(_parentctx)
	    }
		do {
			var _alt: Int
			try enterOuterAlt(_localctx, 1)
			setState(211)
			try _errHandler.sync(self)
			switch(try getInterpreter().adaptivePredict(_input,15, _ctx)) {
			case 1:
				break
			case 2:
				setState(210)
				try parameterDeclaration()

				break
			default: break
			}
			_ctx!.stop = try _input.LT(-1)
			setState(218)
			try _errHandler.sync(self)
			_alt = try getInterpreter().adaptivePredict(_input,16,_ctx)
			while (_alt != 2 && _alt != ATN.INVALID_ALT_NUMBER) {
				if ( _alt==1 ) {
					if _parseListeners != nil {
					   try triggerExitRuleEvent()
					}
					_prevctx = _localctx
					_localctx = ParameterDeclarationListContext(_parentctx, _parentState);
					try pushNewRecursionContext(_localctx, _startState, JokrParser.RULE_parameterDeclarationList)
					setState(213)
					if (!(precpred(_ctx, 1))) {
					    throw try ANTLRException.recognition(e:FailedPredicateException(self, "precpred(_ctx, 1)"))
					}
					setState(214)
					try match(JokrParser.Tokens.COMMA.rawValue)
					setState(215)
					try parameterDeclaration()

			 
				}
				setState(220)
				try _errHandler.sync(self)
				_alt = try getInterpreter().adaptivePredict(_input,16,_ctx)
			}

		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx;
	}
	open class ParameterDeclarationContext:ParserRuleContext {
		open func TYPE() -> TerminalNode? { return getToken(JokrParser.Tokens.TYPE.rawValue, 0) }
		open func ID() -> TerminalNode? { return getToken(JokrParser.Tokens.ID.rawValue, 0) }
		open override func getRuleIndex() -> Int { return JokrParser.RULE_parameterDeclaration }
		override
		open func enterRule(_ listener: ParseTreeListener) {
			if listener is JokrListener {
			 	(listener as! JokrListener).enterParameterDeclaration(self)
			}
		}
		override
		open func exitRule(_ listener: ParseTreeListener) {
			if listener is JokrListener {
			 	(listener as! JokrListener).exitParameterDeclaration(self)
			}
		}
	}
	@discardableResult
	open func parameterDeclaration() throws -> ParameterDeclarationContext {
		var _localctx: ParameterDeclarationContext = ParameterDeclarationContext(_ctx, getState())
		try enterRule(_localctx, 44, JokrParser.RULE_parameterDeclaration)
		defer {
	    		try! exitRule()
	    }
		do {
		 	try enterOuterAlt(_localctx, 1)
		 	setState(221)
		 	try match(JokrParser.Tokens.TYPE.rawValue)
		 	setState(222)
		 	try match(JokrParser.Tokens.ID.rawValue)

		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}

    override
	open func sempred(_ _localctx: RuleContext?, _ ruleIndex: Int,  _ predIndex: Int)throws -> Bool {
		switch (ruleIndex) {
		case  1:
			return try statementList_sempred(_localctx?.castdown(StatementListContext.self), predIndex)
		case  3:
			return try classDeclarationList_sempred(_localctx?.castdown(ClassDeclarationListContext.self), predIndex)
		case  6:
			return try expression_sempred(_localctx?.castdown(ExpressionContext.self), predIndex)
		case  7:
			return try parameterList_sempred(_localctx?.castdown(ParameterListContext.self), predIndex)
		case  16:
			return try classMemberList_sempred(_localctx?.castdown(ClassMemberListContext.self), predIndex)
		case  21:
			return try parameterDeclarationList_sempred(_localctx?.castdown(ParameterDeclarationListContext.self), predIndex)
	    default: return true
		}
	}
	private func statementList_sempred(_ _localctx: StatementListContext!,  _ predIndex: Int) throws -> Bool {
		switch (predIndex) {
		    case 0:return precpred(_ctx, 1)
		    default: return true
		}
	}
	private func classDeclarationList_sempred(_ _localctx: ClassDeclarationListContext!,  _ predIndex: Int) throws -> Bool {
		switch (predIndex) {
		    case 1:return precpred(_ctx, 1)
		    default: return true
		}
	}
	private func expression_sempred(_ _localctx: ExpressionContext!,  _ predIndex: Int) throws -> Bool {
		switch (predIndex) {
		    case 2:return precpred(_ctx, 5)
		    default: return true
		}
	}
	private func parameterList_sempred(_ _localctx: ParameterListContext!,  _ predIndex: Int) throws -> Bool {
		switch (predIndex) {
		    case 3:return precpred(_ctx, 1)
		    default: return true
		}
	}
	private func classMemberList_sempred(_ _localctx: ClassMemberListContext!,  _ predIndex: Int) throws -> Bool {
		switch (predIndex) {
		    case 4:return precpred(_ctx, 1)
		    default: return true
		}
	}
	private func parameterDeclarationList_sempred(_ _localctx: ParameterDeclarationListContext!,  _ predIndex: Int) throws -> Bool {
		switch (predIndex) {
		    case 5:return precpred(_ctx, 1)
		    default: return true
		}
	}

   public static let _serializedATN : String = JokrParserATN().jsonString
   public static let _ATN: ATN = ATNDeserializer().deserializeFromJson(_serializedATN)
}