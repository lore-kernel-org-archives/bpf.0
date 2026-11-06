Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=66.163.188.146
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793934193;
	b=f17QPjFw1S0XVhQWnalHfan7QJEBDaLOhgwscQEwfXxutY+FWKF5Z7F5yqhmj8e6r3Db
	 MWDO2VNCOnmI/WWk6DItmj5tCLLUh8BMD1hWNShfGKzpxi17U4PdMMS2HXT3PhGnGy3LS
	 BNLQ1wd9BtCZ7jXtYGLYe3z4NZQkDEbpia2FJDgmN0zj+d3Z9qhhV0vsbKegRivCyXagn
	 xO4hTQ9sJnanscKxmw4Yr3iF3usp/aE3ZZ+3MyeBQAIIPZmZTeXNQFDYMdCQJPvSjqBn6
	 p17ijGDt3JaqucD40uCZmQp40qp0bU365j3a59oV9n/F3vxzaHQVwJOhoVxBhhdikRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793934193;
	h=DMARC-Filter:DKIM-Signature:X-SONIC-DKIM-SIGN:X-YMail-OSG:X-Sonic-MF:
	 X-Sonic-ID:Received:Received:Date:From:To:Message-ID:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:References:
	 X-Mailer;
	bh=oHsZXe/yfgbexHiS6caj6VsRY0IwWyQXToKvJrJMA1w=;
	b=gg5Id6/RLuih/eRQw1FxSrjGBnVrsAxcvjKdhR6mX60EbAso/zmnRNzQdj4efHqmKa2e
	 6HeGnLiROt0O3DYrmKlAL/leOguo8D3IrvS1OrkuAoLG7hwy8ro/c4VrEUTF7QjyvbOui
	 u5HVc/tKyYsdjsOc9KwAL23HTZPcbQQuyoguPdxZTemxRoKM6pxlissruyxf5TCxM93j0
	 kwdUH6ENBeGjHgvCO5WaHVuLmYcfPYUR7D/kl3BlvoB7YHB+jIoi763wCAl32K5JSu6qE
	 X9vA+toU3DTuVeoRyJOtuavQvAREzmNdTAHDg/00Ip/r3ESnUcJRre1NfsB94ccHegw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=aol.com;
	spf=pass smtp.mailfrom=aol.com;
	dkim=pass header.d=aol.com header.i=@aol.com header.a=rsa-sha256 header.s=a2048 header.b=EubPfStO;
	arc=none smtp.remote-ip=66.163.188.146
Received: from sonic303-20.consmr.mail.ne1.yahoo.com (sonic303-20.consmr.mail.ne1.yahoo.com [66.163.188.146])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D01606A326
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 03:03:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 74D01606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aol.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256 header.s=a2048 header.b=EubPfStO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1793934191; bh=oHsZXe/yfgbexHiS6caj6VsRY0IwWyQXToKvJrJMA1w=; h=Date:From:To:Subject:References:From:Subject:Reply-To; b=EubPfStOdnsRc2ASwf+ATODJNQ9mR8zOykC9N4jjyWWz1tm4n8QpawEDA9aPylAQLFb1rIwfJt4cxSLyRbq/OiwkzJv6KQ47crjJtzkaoNG7IHWJK0/86HHc0qQrfCBtFwute0Ml0eumQ+vwZov+q+cqNS27YQfhgTMPq697oi6H3X1458jqWL2GzfrQnuzvBUQwrTDdR2aQxt4Zh7W1g8c7QOCghAKxQmnuGykJ6kJydMqUykkrkBikdHj1buViLvZsoiK30EK7HQ6jZPMkY6538y1XBIuyHNPZZb/8mm/MRSD/hYYzzggBMuDuZdMLwHcL9iZZGkt4t1aqRoZxUQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1793934191; bh=qjd3VhvwCh+FUG685dQmsAHIMCAlaN2a33rICbBInKq=; h=X-Sonic-MF:Date:From:To:Subject:From:Subject; b=sdp7tNhTM69f+yoY4kFPtPPhKcNfyYHvBh5DvLVRV5l0EKiLtC2+Ul/C8CSMf9MJDBot+snbWlJX3XGSd6UeKVPY1K3P8TpuoQ3kQuEZHzbja6EQbEAn96FXYFGIkDaTqkCLw7+kNXmn61/Gua05WaJRYfLOjZ5qb9uG0cn7dJiWENHnzd7tS+MKFE+3KwTWZ+vszooZjwrt3vUGj83D5y2OKJjN5z4ttZ+t7HnK48B2JV5awCt7NW6jC6rbfvdaxzx8GBfglCaSSr/TkAEntmic3vK7Q1nkd9zjpwbqnle2vb8wD9sT+M4A08JGnEO8ROqtS+kxjoIuy7SMm2Bapw==
X-YMail-OSG: p68zPocVM1laxgTYJvdtijMk5ZXY4lEfs7zTft_Poa1g7RPwmpVRATLVZ4nSkUQ
 ZDpCoz.5lmLaeSg1JjJcT5N2dNEgDd27TB28zGtcS8tlZ.x8QrCV22m6ESZH5.RT3ugmPsgELhUP
 5Qb0rrl.6K3eJ4Bt_jseZyCmAlC9Tt0OKUzJLyg41bsNdAWuYJjjk2CCoK1dvQ4uogsLFZ2rgL2r
 q.hTsN32p6P1WI.00c.vM7mnBjX.6ctwHXSvN59uOce4RJ0m3r_Hk7i47Eb3.ZQFgQSDaqX1fvVU
 BKevZa6tiKCxT0WWzraZ7owOvN3UZA4jJ5AGZ4NFdWS8nm8UMVBLjStKNYPLX29ZD..UZ9HkwPPJ
 17QucdDDFs.akgI8X4CI0ueEzVvj48otV1R8BOCYd3_dOMqRO3nykh5YVgaaeG2dIATO5HcDs61E
 3tQbBqimOQ4e7dVNpAZoLmpybqq1SUiebwXf8YKPTVYxK3a672Qpf8EHYlc5FTNGJMcI3wDmSLzA
 mSPlBz0dNfMaPqu60GlK_VA_Y8dOcv90i9ACr79gumTV0_47E1jbdP0zd_.oIM8i3b0hs0JwnhGs
 xwKl2qS_lu8OjZ8kbbtpXqglHZ1KvAHfHpN9JZqbjtxBXXPA1MuvixQAdBmI5XURHU5FD_fX9cxQ
 HmCCL3doXhLLW.pm2gFvmDBC7hTdYRwZp..n7ZHTy1itnw9mAAe0GXMeFCGaM1IQVfKP6Vzf4gSJ
 pYdPyRhLj4Up2JiRYrQxbBjS6oKJigmXA2KABtPUCDVm1mDpX3RR38iRSJa2nnX_.3QqL3tthhr9
 ToLXOiE3sjNj7tBzQoy.9ut6PsP2UL1KVNF246fMT8_1uzANXdi5pYBLbqfRbA4YTt5shz.uqCPd
 7hUoQVRU2tYTsE8NlryMYYbDh80jeobeakm_xe.O6DH7y.fGHGuvE5Y0cpzR1Tn3LE8nYtSZ4A.9
 AaVGAEA_C1UxIm9tH3ZH1P1gzPgTvNeMXQhXbTePcEhDyW9y3756HBknwpKYdCZPY_h92CWqFTkJ
 l644d21wzFoVc88c5sjV1zmj2_hssoNfyxb2TStx18mKjccJHmHy2lNDkXQVI7PwizxsSBdS93O.
 QPdBWW0r4tRHB0RedaX.Edw7SJHaWP.sMpFhHiXM_.cxQtERzoeNZP2TQ2RApco9sl9bQrkBRGAG
 xH0biuhf87yBqm9LtGnWpziO5PfKeVo76S_xLVTb0xpehVcfjXg.jzvTQ0sTBiu8JcvEU8mj6Ifx
 KwjGxd6Bj8gNN8taYRxGs25KjvVefucS0foCikLTQK3WVDcH7Js0aI5CPCiAmAXX0MNMMf6d9a7J
 jk6SzRNqfjmYS5Ixffs_xq_RpiG66Kt8GAIXWhMUgpnh8sOrRJfs.440cvNS1wIFP5cnYR8Mw04x
 yIwklpAAnE.Ak.bMD32tQonCIeKkikbqnyzx6F0RY1q8Ieo.c2q3oc.2DegxgL29uKd_h6HCUTsS
 EcyS07UMiQel_WlM1hGi5iytbk1tsTpsqjhvd0GezjsjrQ1Yb8NWvDlr0ZcInsrKWvzWmOFQwuzc
 EqPzRzX7cW_mbGkrO0uM62NFmieNgq9.NnbFAHedMuPHhpS20a87AV8cLQJodGoc.U.BG1oG6g3M
 0d2Do0dX_V4uinfhWouobahCGwRwwMIn49Yb4njDyWdEdIxYMhVffBbvdSyaryUFE5Tt03dh8Ezk
 n.fDYUff61qj.Tp0CljSTRQRakYXaL5.Hz5RS35vrS5xvjWUtALP2YZbYpKHekiCqG_8yS_4XKOM
 tj2KXMzTbOnLhZJMDx.kAx3mVguv7YR0q.ZqoRK776eStv.Yk9DZLJB69BOMCRs0ZZQO4DHd26mo
 RCVWmoVrcQP1P3ukD_CsTZmgTyTtgC4amV3dDVyrL8dpixant.yobG4LhTRrfhg87xNG_yrNlmKd
 Ae2QfZiI7_I_ohEvEXmbbuRPRhX1U2rXDpJmJn8V0v2Kv337vy9izoROxZLmrffRGmT9aLaZzBJF
 13RdR.4V48_DhUQ4olmc.A1pbFImeYHP4vNuChJSF26KKNG.YPrLGujwvIjnAV6AdsDGGnwi80EA
 8.fs7Y78B0ISoAOwejHynHjgOPgKPPn5AxWQuGImd58QmvbU0HFd36B2RKHAQcwkeS1W6uGKv.vx
 2iS.QM80y4Wu_WflsXUM.qwIhAxRdC_o-
X-Sonic-MF: <camachonick456799@aol.com>
X-Sonic-ID: 3459e50a-cbdf-41bf-af9e-963894960cae
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.ne1.yahoo.com with HTTP; Fri, 6 Nov 2026 03:03:11 +0000
Received: by hermes--production-gq1-fd7994565-5w4l7 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID a61c4681ce761a348c8fbd51b3521f5d;
          Fri, 06 Nov 2026 03:03:07 +0000 (UTC)
Date: Fri, 6 Nov 2026 11:03:04 +0800 (CST)
From: camachonick456799@aol.com
To: bpf@vger.kernel.org
Message-ID: <2144123926.34.1793934184164@24dcc8b25a7d>
Subject: Provide a lightweight solution for libbpf document access to
 multi-language support
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <2144123926.34.1793934184164.ref@24dcc8b25a7d>
X-Mailer: WebService/1.1.26943 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.aol

libbpf is an important open source library in the eBPF field and widely serves the global Linux kernel and system engineer community. I noticed that your documentation and technical content are in high demand for access by international users, which got me thinking translate.js  Might be a lightweight supplement.

 I am Guan Leiming, the founder of Weifang Leiming Cloud Network Technology Co., Ltd., and I am also the founder of Weifang Leiming Cloud Network Technology Co., Ltd. translate.js  author. This open source project enables fully automatic multi-language translation of HTML content without affecting SEO. It can be connected to GitHub README or documentation sites without changing the existing project structure.

 If you are interested in learning how to quickly access translate.js  To support multi-language display, I can send you an access guide and demonstration link http://translate.zvo.cn .
