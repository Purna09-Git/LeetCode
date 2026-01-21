class Solution:
    def isValid(self, s: str) -> bool:
        # Map closing brackets to  their corresponding opening brackets
        bracket_map = {")": "(", "}": "{", "]": "["}
        stack = []

        for char in s:
            # If the character is a closing bracket
            if char in bracket_map:
                # Pop the top element if stack isn't empty, else use a dummy value
                top_element = stack.pop() if stack else '#'
                
                # Check if the popped element matches the map value
                if bracket_map[char] != top_element:
                    return False
            else:
                # It's an opening bracket, push to stack
                stack.append(char)

        # If stack is empty, all brackets were matched correctly
        return not stack