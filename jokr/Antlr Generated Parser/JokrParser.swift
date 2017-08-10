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
		case EOF = -1, BLOCK_COMMENT = 1, LINE_COMMENT = 2, OPERATOR = 3, OPERATOR_CHAR = 4, 
                 LPAREN = 5, RPAREN = 6, LBRACE = 7, RBRACE = 8, COMMA = 9, 
                 RETURN = 10, INT = 11, TYPE = 12, ID = 13, SNAKE_CASE = 14, 
                 ASSIGN = 15, NEW_LINE = 16, WS = 17
	}
	public static let RULE_program = 0, RULE_statementList = 1, RULE_statement = 2, 
                   RULE_declarationList = 3, RULE_declaration = 4, RULE_assignment = 5, 
                   RULE_functionDeclaration = 6, RULE_functionDeclarationHeader = 7, 
                   RULE_functionDeclarationParameters = 8, RULE_parameterDeclarationList = 9, 
                   RULE_parameterDeclaration = 10, RULE_block = 11, RULE_expression = 12, 
                   RULE_returnStatement = 13, RULE_variableDeclaration = 14, 
                   RULE_lvalue = 15
	public static let ruleNames: [String] = [
		"program", "statementList", "statement", "declarationList", "declaration", 
		"assignment", "functionDeclaration", "functionDeclarationHeader", "functionDeclarationParameters", 
		"parameterDeclarationList", "parameterDeclaration", "block", "expression", 
		"returnStatement", "variableDeclaration", "lvalue"
	]

	private static let _LITERAL_NAMES: [String?] = [
		nil, nil, nil, nil, nil, "'('", "')'", "'{'", "'}'", "','", "'return'", 
		nil, nil, nil, nil, "'='"
	]
	private static let _SYMBOLIC_NAMES: [String?] = [
		nil, "BLOCK_COMMENT", "LINE_COMMENT", "OPERATOR", "OPERATOR_CHAR", "LPAREN", 
		"RPAREN", "LBRACE", "RBRACE", "COMMA", "RETURN", "INT", "TYPE", "ID", 
		"SNAKE_CASE", "ASSIGN", "NEW_LINE", "WS"
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
		open func declarationList() -> DeclarationListContext? {
			return getRuleContext(DeclarationListContext.self,0)
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
		 	setState(41)
		 	try _errHandler.sync(self)
		 	switch(try getInterpreter().adaptivePredict(_input,0, _ctx)) {
		 	case 1:
		 		try enterOuterAlt(_localctx, 1)

		 		break
		 	case 2:
		 		try enterOuterAlt(_localctx, 2)
		 		setState(33)
		 		try statementList(0)

		 		break
		 	case 3:
		 		try enterOuterAlt(_localctx, 3)
		 		setState(34)
		 		try statementList(0)
		 		setState(35)
		 		try match(JokrParser.Tokens.NEW_LINE.rawValue)

		 		break
		 	case 4:
		 		try enterOuterAlt(_localctx, 4)
		 		setState(37)
		 		try declarationList(0)

		 		break
		 	case 5:
		 		try enterOuterAlt(_localctx, 5)
		 		setState(38)
		 		try declarationList(0)
		 		setState(39)
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
			setState(44)
			try statement()

			_ctx!.stop = try _input.LT(-1)
			setState(51)
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
					setState(46)
					if (!(precpred(_ctx, 1))) {
					    throw try ANTLRException.recognition(e:FailedPredicateException(self, "precpred(_ctx, 1)"))
					}
					setState(47)
					try match(JokrParser.Tokens.NEW_LINE.rawValue)
					setState(48)
					try statement()

			 
				}
				setState(53)
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
		 	setState(56)
		 	try _errHandler.sync(self)
		 	switch (JokrParser.Tokens(rawValue: try _input.LA(1))!) {
		 	case .TYPE:fallthrough
		 	case .ID:
		 		try enterOuterAlt(_localctx, 1)
		 		setState(54)
		 		try assignment()

		 		break

		 	case .RETURN:
		 		try enterOuterAlt(_localctx, 2)
		 		setState(55)
		 		try returnStatement()

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

	open class DeclarationListContext:ParserRuleContext {
		open func declaration() -> DeclarationContext? {
			return getRuleContext(DeclarationContext.self,0)
		}
		open func declarationList() -> DeclarationListContext? {
			return getRuleContext(DeclarationListContext.self,0)
		}
		open func NEW_LINE() -> TerminalNode? { return getToken(JokrParser.Tokens.NEW_LINE.rawValue, 0) }
		open override func getRuleIndex() -> Int { return JokrParser.RULE_declarationList }
		override
		open func enterRule(_ listener: ParseTreeListener) {
			if listener is JokrListener {
			 	(listener as! JokrListener).enterDeclarationList(self)
			}
		}
		override
		open func exitRule(_ listener: ParseTreeListener) {
			if listener is JokrListener {
			 	(listener as! JokrListener).exitDeclarationList(self)
			}
		}
	}

	public final  func declarationList( ) throws -> DeclarationListContext   {
		return try declarationList(0)
	}
	@discardableResult
	private func declarationList(_ _p: Int) throws -> DeclarationListContext   {
		let _parentctx: ParserRuleContext? = _ctx
		var _parentState: Int = getState()
		var _localctx: DeclarationListContext = DeclarationListContext(_ctx, _parentState)
		var  _prevctx: DeclarationListContext = _localctx
		var _startState: Int = 6
		try enterRecursionRule(_localctx, 6, JokrParser.RULE_declarationList, _p)
		defer {
	    		try! unrollRecursionContexts(_parentctx)
	    }
		do {
			var _alt: Int
			try enterOuterAlt(_localctx, 1)
			setState(59)
			try declaration()

			_ctx!.stop = try _input.LT(-1)
			setState(66)
			try _errHandler.sync(self)
			_alt = try getInterpreter().adaptivePredict(_input,3,_ctx)
			while (_alt != 2 && _alt != ATN.INVALID_ALT_NUMBER) {
				if ( _alt==1 ) {
					if _parseListeners != nil {
					   try triggerExitRuleEvent()
					}
					_prevctx = _localctx
					_localctx = DeclarationListContext(_parentctx, _parentState);
					try pushNewRecursionContext(_localctx, _startState, JokrParser.RULE_declarationList)
					setState(61)
					if (!(precpred(_ctx, 1))) {
					    throw try ANTLRException.recognition(e:FailedPredicateException(self, "precpred(_ctx, 1)"))
					}
					setState(62)
					try match(JokrParser.Tokens.NEW_LINE.rawValue)
					setState(63)
					try declaration()

			 
				}
				setState(68)
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
	open class DeclarationContext:ParserRuleContext {
		open func functionDeclaration() -> FunctionDeclarationContext? {
			return getRuleContext(FunctionDeclarationContext.self,0)
		}
		open override func getRuleIndex() -> Int { return JokrParser.RULE_declaration }
		override
		open func enterRule(_ listener: ParseTreeListener) {
			if listener is JokrListener {
			 	(listener as! JokrListener).enterDeclaration(self)
			}
		}
		override
		open func exitRule(_ listener: ParseTreeListener) {
			if listener is JokrListener {
			 	(listener as! JokrListener).exitDeclaration(self)
			}
		}
	}
	@discardableResult
	open func declaration() throws -> DeclarationContext {
		var _localctx: DeclarationContext = DeclarationContext(_ctx, getState())
		try enterRule(_localctx, 8, JokrParser.RULE_declaration)
		defer {
	    		try! exitRule()
	    }
		do {
		 	try enterOuterAlt(_localctx, 1)
		 	setState(69)
		 	try functionDeclaration()

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
		try enterRule(_localctx, 10, JokrParser.RULE_assignment)
		defer {
	    		try! exitRule()
	    }
		do {
		 	setState(79)
		 	try _errHandler.sync(self)
		 	switch (JokrParser.Tokens(rawValue: try _input.LA(1))!) {
		 	case .TYPE:
		 		try enterOuterAlt(_localctx, 1)
		 		setState(71)
		 		try variableDeclaration()
		 		setState(72)
		 		try match(JokrParser.Tokens.ASSIGN.rawValue)
		 		setState(73)
		 		try expression(0)

		 		break

		 	case .ID:
		 		try enterOuterAlt(_localctx, 2)
		 		setState(75)
		 		try lvalue()
		 		setState(76)
		 		try match(JokrParser.Tokens.ASSIGN.rawValue)
		 		setState(77)
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
		try enterRule(_localctx, 12, JokrParser.RULE_functionDeclaration)
		defer {
	    		try! exitRule()
	    }
		do {
		 	try enterOuterAlt(_localctx, 1)
		 	setState(81)
		 	try functionDeclarationHeader()
		 	setState(82)
		 	try functionDeclarationParameters()
		 	setState(83)
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
		try enterRule(_localctx, 14, JokrParser.RULE_functionDeclarationHeader)
		defer {
	    		try! exitRule()
	    }
		do {
		 	try enterOuterAlt(_localctx, 1)
		 	setState(85)
		 	try match(JokrParser.Tokens.TYPE.rawValue)
		 	setState(86)
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
		try enterRule(_localctx, 16, JokrParser.RULE_functionDeclarationParameters)
		defer {
	    		try! exitRule()
	    }
		do {
		 	try enterOuterAlt(_localctx, 1)
		 	setState(88)
		 	try match(JokrParser.Tokens.LPAREN.rawValue)
		 	setState(89)
		 	try parameterDeclarationList(0)
		 	setState(90)
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
		var _startState: Int = 18
		try enterRecursionRule(_localctx, 18, JokrParser.RULE_parameterDeclarationList, _p)
		defer {
	    		try! unrollRecursionContexts(_parentctx)
	    }
		do {
			var _alt: Int
			try enterOuterAlt(_localctx, 1)
			setState(94)
			try _errHandler.sync(self)
			switch(try getInterpreter().adaptivePredict(_input,5, _ctx)) {
			case 1:
				break
			case 2:
				setState(93)
				try parameterDeclaration()

				break
			default: break
			}
			_ctx!.stop = try _input.LT(-1)
			setState(101)
			try _errHandler.sync(self)
			_alt = try getInterpreter().adaptivePredict(_input,6,_ctx)
			while (_alt != 2 && _alt != ATN.INVALID_ALT_NUMBER) {
				if ( _alt==1 ) {
					if _parseListeners != nil {
					   try triggerExitRuleEvent()
					}
					_prevctx = _localctx
					_localctx = ParameterDeclarationListContext(_parentctx, _parentState);
					try pushNewRecursionContext(_localctx, _startState, JokrParser.RULE_parameterDeclarationList)
					setState(96)
					if (!(precpred(_ctx, 1))) {
					    throw try ANTLRException.recognition(e:FailedPredicateException(self, "precpred(_ctx, 1)"))
					}
					setState(97)
					try match(JokrParser.Tokens.COMMA.rawValue)
					setState(98)
					try parameterDeclaration()

			 
				}
				setState(103)
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
		try enterRule(_localctx, 20, JokrParser.RULE_parameterDeclaration)
		defer {
	    		try! exitRule()
	    }
		do {
		 	try enterOuterAlt(_localctx, 1)
		 	setState(104)
		 	try match(JokrParser.Tokens.TYPE.rawValue)
		 	setState(105)
		 	try match(JokrParser.Tokens.ID.rawValue)

		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}
	open class BlockContext:ParserRuleContext {
		open func LBRACE() -> TerminalNode? { return getToken(JokrParser.Tokens.LBRACE.rawValue, 0) }
		open func NEW_LINE() -> Array<TerminalNode> { return getTokens(JokrParser.Tokens.NEW_LINE.rawValue) }
		open func NEW_LINE(_ i:Int) -> TerminalNode?{
			return getToken(JokrParser.Tokens.NEW_LINE.rawValue, i)
		}
		open func statementList() -> StatementListContext? {
			return getRuleContext(StatementListContext.self,0)
		}
		open func RBRACE() -> TerminalNode? { return getToken(JokrParser.Tokens.RBRACE.rawValue, 0) }
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
		try enterRule(_localctx, 22, JokrParser.RULE_block)
		defer {
	    		try! exitRule()
	    }
		do {
		 	try enterOuterAlt(_localctx, 1)
		 	setState(107)
		 	try match(JokrParser.Tokens.LBRACE.rawValue)
		 	setState(108)
		 	try match(JokrParser.Tokens.NEW_LINE.rawValue)
		 	setState(109)
		 	try statementList(0)
		 	setState(110)
		 	try match(JokrParser.Tokens.NEW_LINE.rawValue)
		 	setState(111)
		 	try match(JokrParser.Tokens.RBRACE.rawValue)

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
		var _startState: Int = 24
		try enterRecursionRule(_localctx, 24, JokrParser.RULE_expression, _p)
		defer {
	    		try! unrollRecursionContexts(_parentctx)
	    }
		do {
			var _alt: Int
			try enterOuterAlt(_localctx, 1)
			setState(120)
			try _errHandler.sync(self)
			switch (JokrParser.Tokens(rawValue: try _input.LA(1))!) {
			case .INT:
				setState(114)
				try match(JokrParser.Tokens.INT.rawValue)

				break

			case .LPAREN:
				setState(115)
				try match(JokrParser.Tokens.LPAREN.rawValue)
				setState(116)
				try expression(0)
				setState(117)
				try match(JokrParser.Tokens.RPAREN.rawValue)

				break

			case .ID:
				setState(119)
				try lvalue()

				break
			default:
				throw try ANTLRException.recognition(e: NoViableAltException(self))
			}
			_ctx!.stop = try _input.LT(-1)
			setState(127)
			try _errHandler.sync(self)
			_alt = try getInterpreter().adaptivePredict(_input,8,_ctx)
			while (_alt != 2 && _alt != ATN.INVALID_ALT_NUMBER) {
				if ( _alt==1 ) {
					if _parseListeners != nil {
					   try triggerExitRuleEvent()
					}
					_prevctx = _localctx
					_localctx = ExpressionContext(_parentctx, _parentState);
					try pushNewRecursionContext(_localctx, _startState, JokrParser.RULE_expression)
					setState(122)
					if (!(precpred(_ctx, 2))) {
					    throw try ANTLRException.recognition(e:FailedPredicateException(self, "precpred(_ctx, 2)"))
					}
					setState(123)
					try match(JokrParser.Tokens.OPERATOR.rawValue)
					setState(124)
					try expression(3)

			 
				}
				setState(129)
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
		try enterRule(_localctx, 26, JokrParser.RULE_returnStatement)
		defer {
	    		try! exitRule()
	    }
		do {
		 	try enterOuterAlt(_localctx, 1)
		 	setState(130)
		 	try match(JokrParser.Tokens.RETURN.rawValue)
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
		try enterRule(_localctx, 28, JokrParser.RULE_variableDeclaration)
		defer {
	    		try! exitRule()
	    }
		do {
		 	try enterOuterAlt(_localctx, 1)
		 	setState(133)
		 	try match(JokrParser.Tokens.TYPE.rawValue)
		 	setState(134)
		 	try match(JokrParser.Tokens.ID.rawValue)

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
		try enterRule(_localctx, 30, JokrParser.RULE_lvalue)
		defer {
	    		try! exitRule()
	    }
		do {
		 	try enterOuterAlt(_localctx, 1)
		 	setState(136)
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
			return try declarationList_sempred(_localctx?.castdown(DeclarationListContext.self), predIndex)
		case  9:
			return try parameterDeclarationList_sempred(_localctx?.castdown(ParameterDeclarationListContext.self), predIndex)
		case  12:
			return try expression_sempred(_localctx?.castdown(ExpressionContext.self), predIndex)
	    default: return true
		}
	}
	private func statementList_sempred(_ _localctx: StatementListContext!,  _ predIndex: Int) throws -> Bool {
		switch (predIndex) {
		    case 0:return precpred(_ctx, 1)
		    default: return true
		}
	}
	private func declarationList_sempred(_ _localctx: DeclarationListContext!,  _ predIndex: Int) throws -> Bool {
		switch (predIndex) {
		    case 1:return precpred(_ctx, 1)
		    default: return true
		}
	}
	private func parameterDeclarationList_sempred(_ _localctx: ParameterDeclarationListContext!,  _ predIndex: Int) throws -> Bool {
		switch (predIndex) {
		    case 2:return precpred(_ctx, 1)
		    default: return true
		}
	}
	private func expression_sempred(_ _localctx: ExpressionContext!,  _ predIndex: Int) throws -> Bool {
		switch (predIndex) {
		    case 3:return precpred(_ctx, 2)
		    default: return true
		}
	}

   public static let _serializedATN : String = JokrParserATN().jsonString
   public static let _ATN: ATN = ATNDeserializer().deserializeFromJson(_serializedATN)
}