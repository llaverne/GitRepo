<#
Create a powershell function or cmdlet that takes an arbitrarily long string parameter $foo (e.g. 'abcdedcba') and returns the first recurring character in that Input string.
In 'abcdedcba', 'd' would be the first recurring character, so the cmdlet/function should return 'd' for that sample input.

Be mindful of the runtime of your solution.
#>

# 1. Iterate through digits in input string,
# 2. Begin filling the first element of an array with each digit
# 3. If the digit is already in the array then it's the first recurrent char, so return it.

Function Get-FirstRepeatingChar{
Param( [string] $strInput )
# Takes an arbitrarily long string parameter $foo (e.g. 'abcdedcba')
# and returns the first recurring character

# We'll need an empty char array to store the digits we test:
#[char[]]$chrChars = [System.Collections.ArrayList]@() # Nope, doesn't work... still fixed size.
#[char[]]$chrChars = {}.Invoke() # Nope, doesn't work...same
[char[]]$chrChars = @() # OK, it's UGLY, but it will work for now. I'd use a List object for anything that needs to be efficient.


# We'll need a counter/accessor for the array elements:
[int]$i = 0

# Setup error catching:
try {

    # Iterate through each charactor in the input string...
    foreach( $chrCharInString in [char[]]$strInput ){
    
    # ... and fill the array, UNLESS we find a match:
    if ( $chrChars -Contains $chrCharInString ){
        
        # Requirement: returns the first recurring character
        # We found our first match, so return it:
        return $chrCharInString

    }else{
    
        # No match found yet, so add this char to the array:
        #$chrChars.Add($chrCharInString) # Doesn't work, fixed array size, so we'll:
        $chrChars += $chrCharInString # Inefficient, but OK for smaller tasks. I'd use a List object for anything of size.
    }

    # Iterate counter:
    $i++;
    }
    
    # We're out of chars to check, and no match found, so return Null:
    return $null

    }
catch
    {
    
    # Output error message:
    Write-Error -Message $Error[0].Exception.Message

    }
    
}

# Execute the function:
Get-FirstRepeatingChar "abccb"

<#

Interesting task, it was fun.
If I were to do it again, I'd probably use a Hash table or List object for the temporary array to make it faster and allow for the use of .Add()
-Lawrence LaVerne

#>
