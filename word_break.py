class Solution(object):
  def wordBreak(self, string, wordDict):
      """
      :type s: str
      :type wordDict: Set[str]
      :rtype: List[str]
      """
      return self.helper(string, wordDict, {})
      
  def helper(self, string, wordDict, memo):
      if string in memo: return memo[string]
      if not string: return []
      
      res = []
      for word in wordDict:
          if not string.startswith(word):
              continue
          if len(word) == len(string):
              res.append(word)
          else:
              resultOfTheRest = self.helper(string[len(word):], wordDict, memo)
              for item in resultOfTheRest:
                  item = word + ' ' + item
                  res.append(item)
      memo[string] = res
      return res

# basic word break
def word_break(string, words):
  dp_table = [False] * len(string)
  for i in range(len(string)):
    for word in words:
      if word == string[i-len(word)+1:i+1] and (dp_table[i-len(word)] or i-len(word) == -1):
        import pdb; pdb.set_trace()
        dp_table[i] = True
  import pdb; pdb.set_trace()
  return dp_table[-1]

# s = Solution()
# s.wordBreak('ilike', set(['ilik', 'e']))
word_break('ilike', ['ilik', 'e'])