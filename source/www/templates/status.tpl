<HTML>
			<HEAD>
						<meta http-equiv="cache-control" content="no-cache">
						<META HTTP-EQUIV="Refresh" CONTENT="30; URL=%%LINK_STATUS%%">
						<TITLE>Status</TITLE>
			</HEAD>
			<BODY bgcolor="#030C5A" text=E0E0E0 link="blue" vlink="blue" alink="blue" topmargin="0" leftmargin="2" onLoad="parent.unten.obenloaded=0;">
						&nbsp;letzter Status: %%LAST_STATUS%%
<table width=100% border="0" >
<tr>
<td>
		Ihre IP-Adresse: %%USER_IP%%<br>
		Datum/Uhrzeit: %%NOW%%	
</td>
<td align="center"><font size=+2 color=green> %%STATUS%% &nbsp; %%ONLINETIME%%</font><br></td>
</tr>
</table>
%%IF_NEW_MESSAGE_BEGIN%%
<b><a href="%%LINK_MESSAGES%%" target="unten">Sie haben ungelesene Nachrichten</a></b>
%%IF_NEW_MESSAGE_END%%
</BODY>
</HTML>
