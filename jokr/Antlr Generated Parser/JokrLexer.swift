// Generated from Jokr.g4 by ANTLR 4.7
import Antlr4

open class JokrLexer: Lexer {
	internal static var _decisionToDFA: [DFA] = {
          var decisionToDFA = [DFA]()
          let length = JokrLexer._ATN.getNumberOfDecisions()
          for i in 0..<length {
          	    decisionToDFA.append(DFA(JokrLexer._ATN.getDecisionState(i)!, i))
          }
           return decisionToDFA
     }()

	internal static let _sharedContextCache:PredictionContextCache = PredictionContextCache()
	public static let CLASS=1, BLOCK_COMMENT=2, LINE_COMMENT=3, OPERATOR=4, 
                   OPERATOR_CHAR=5, LPAREN=6, RPAREN=7, LBRACE=8, RBRACE=9, 
                   COMMA=10, PERIOD=11, RETURN=12, INT=13, TYPE=14, ID=15, 
                   SNAKE_CASE=16, ASSIGN=17, NEW_LINE=18, WS=19
	public static let channelNames: [String] = [
		"DEFAULT_TOKEN_CHANNEL", "HIDDEN"
	]

	public static let modeNames: [String] = [
		"DEFAULT_MODE"
	]

	public static let ruleNames: [String] = [
		"CLASS", "BLOCK_COMMENT", "LINE_COMMENT", "OPERATOR", "OPERATOR_CHAR", 
		"LPAREN", "RPAREN", "LBRACE", "RBRACE", "COMMA", "PERIOD", "RETURN", "INT", 
		"TYPE", "ID", "SNAKE_CASE", "ASSIGN", "NEW_LINE", "WS"
	]

	private static let _LITERAL_NAMES: [String?] = [
		nil, "'class'", nil, nil, nil, nil, "'('", "')'", "'{'", "'}'", "','", 
		"'.'", "'return'", nil, nil, nil, nil, "'='"
	]
	private static let _SYMBOLIC_NAMES: [String?] = [
		nil, "CLASS", "BLOCK_COMMENT", "LINE_COMMENT", "OPERATOR", "OPERATOR_CHAR", 
		"LPAREN", "RPAREN", "LBRACE", "RBRACE", "COMMA", "PERIOD", "RETURN", "INT", 
		"TYPE", "ID", "SNAKE_CASE", "ASSIGN", "NEW_LINE", "WS"
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

    open override func getVocabulary() -> Vocabulary {
        return JokrLexer.VOCABULARY
    }

	public override init(_ input: CharStream) {
	    RuntimeMetaData.checkVersion("4.7", RuntimeMetaData.VERSION)
		super.init(input)
		_interp = LexerATNSimulator(self, JokrLexer._ATN, JokrLexer._decisionToDFA, JokrLexer._sharedContextCache)
	}

	override
	open func getGrammarFileName() -> String { return "Jokr.g4" }

    override
	open func getRuleNames() -> [String] { return JokrLexer.ruleNames }

	override
	open func getSerializedATN() -> String { return JokrLexer._serializedATN }

	override
	open func getChannelNames() -> [String] { return JokrLexer.channelNames }

	override
	open func getModeNames() -> [String] { return JokrLexer.modeNames }

	override
	open func getATN() -> ATN { return JokrLexer._ATN }

    public static let _serializedATN: String = JokrLexerATN().jsonString
	public static let _ATN: ATN = ATNDeserializer().deserializeFromJson(_serializedATN)
}