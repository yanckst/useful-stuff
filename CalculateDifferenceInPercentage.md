# Calculate percentage difference between 2 values

## The purpose

The purpose of this algorithm is to determine the percentage difference between 2 numbers.

## Mathematical equation
![](assets/img/CalculateDifferenceInPercentage.png)

### Javascript / Typescript

```javascript
const calculateDifferenceInPercentage = (
    firstValue: number,
    secondValue: number
) => {
    const numerator = Math.abs(firstValue - secondValue)
    const denominator = Math.abs((firstValue + secondValue) / 2)
    if(denominator === 0)
        return 0

    return (numerator / denominator) * 100
}
```