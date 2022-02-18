Speed Testing
=============

This repo is a work in progress. Contains code I use to speed test
functions on different computers.

------------------------------------------------------------------------

<br><br><br>

### Test on 2020 MBP M1, 16 GB RAM

<table>
<thead>
<tr class="header">
<th style="text-align: left;">Test</th>
<th style="text-align: center;">Min</th>
<th style="text-align: center;">Mean</th>
<th style="text-align: center;">Median</th>
<th style="text-align: center;">Max</th>
<th style="text-align: center;">N</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td style="text-align: left;">bootstrap 1 core</td>
<td style="text-align: center;">4.02</td>
<td style="text-align: center;">4.14</td>
<td style="text-align: center;">4.09</td>
<td style="text-align: center;">4.37</td>
<td style="text-align: center;">25</td>
</tr>
<tr class="even">
<td style="text-align: left;">bootstrap parallel cores</td>
<td style="text-align: center;">1.19</td>
<td style="text-align: center;">3.78</td>
<td style="text-align: center;">3.61</td>
<td style="text-align: center;">7.09</td>
<td style="text-align: center;">25</td>
</tr>
<tr class="odd">
<td style="text-align: left;">column medians</td>
<td style="text-align: center;">4.19</td>
<td style="text-align: center;">4.39</td>
<td style="text-align: center;">4.37</td>
<td style="text-align: center;">4.86</td>
<td style="text-align: center;">25</td>
</tr>
</tbody>
</table>
