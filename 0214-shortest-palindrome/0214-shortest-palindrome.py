class Solution:
    def shortestPalindrome(self, s: str) -> str:
        if not s:
            return s
        
        # Step 1: Create the c ombined string
        # s + separator + reverse(s)
        rev_s = s[::-1]
        new_str = s + "#" + rev_s
        
        # Step 2: Build the LPS (Longest Prefix Suffix) table
        n = len(new_str)
        lps = [0] * n
        
        for i in range(1, n):
            j = lps[i - 1]
            while j > 0 and new_str[i] != new_str[j]:
                j = lps[j - 1]
            if new_str[i] == new_str[j]:
                j += 1
            lps[i] = j
        
        # Step 3: The length of the longest palindromic prefix
        palindrome_len = lps[-1]
        
        # Step 4: Add the reversed remaining suffix to the front
        suffix_to_add = rev_s[:len(s) - palindrome_len]
        return suffix_to_add + s