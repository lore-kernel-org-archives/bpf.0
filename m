Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B468D22B594;
	Tue,  3 Feb 2026 16:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770137902; cv=none; b=rw16og2QGqtNObAuLjmcJeRlmD28eImNFMPsT9qXtCnbiQHpOKOrFaednKyjdD59+ItFy3mSdE4NP1EzjfYEq2UzGaQ8u9mu93mJDRdoSStyPPfzkD5VDcdxSVt4eHHpu1C9WPQMDZOsuinybi8a2XFMemuMUoVzJo2gDEfAjGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770137902; c=relaxed/simple;
	bh=0289L1PKuryyzydZQqQllWWbPQlbVc0Tfg05QbiN3Vw=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=oU04TesBr+xSX+RaCRdVi3PmqVqjMnsb8Q9XZ7sZcIB7ckHxSnib+5RCkyGXVMUQ7CgZ57Io1vdq/miHlDd2EycjsgSoZ9gtMf/nNVfodd7NM/1UBMtJZr67be5RBoWQXb53GDwwl2yVIHqzVBiboXcCAZE0UTvekZAYFfyGT9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=p1jc44bv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=O3cYmRx+; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="p1jc44bv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="O3cYmRx+"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id E7FC1EC057A;
	Tue,  3 Feb 2026 11:58:18 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Tue, 03 Feb 2026 11:58:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1770137898;
	 x=1770224298; bh=upK8X81jOmhOmWtnSD+fQ2W7IUu9DJYR+8J/jtItzcY=; b=
	p1jc44bvGbvfiVfDrPZJbCHsbtZqdsAoZ+JKSHukCwDaupbg6gqF95MJAbDD5oXy
	gnEzi+4Y2iQjDrr1GbKfMDWggCkitZntk2HMO7tMv52z2rk23YVKqf7VPfljjrIc
	15GEyi8oi/xTeXtYHRxBEfTk/Bpe0tXvBxpj1xGPilKN6/8C0HhiWKkkGhqv3chF
	MfCmutWKgyoOuDZ1GFCzaFxALmo1bgRtyuZIVwBm9m3A87/gKF7ASgMDWl2c1+IM
	pfRgVsB3p1N7j4DjaW9IFF2eP6vB963F91QlwTZQPEyWInpPmIYKx3q2G/29rbj7
	BVouWf+FBBVDNsMhouHPmg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770137898; x=
	1770224298; bh=upK8X81jOmhOmWtnSD+fQ2W7IUu9DJYR+8J/jtItzcY=; b=O
	3cYmRx+goII2x37EtO/k2G27c2smmEHUHLE98+vFoemrme6dfYQ5onhqQNjKW+ZY
	RUsRsD5nhTcfHwrWAB/SOlC2lMzJlBPZHElEyr5Wlfo/GJmSZgRLF8eOEeMWcmwE
	KRXEhPcB3/eD++cGb7cFwSg6tZTWm8L1ZoMUudDdoiqtWRfurAjBl0jApHWcHgtc
	CVxh/l+bT+gDlcX6lZOODSda18sJvjkc16KJ2U9rJwSJuIe3Ef7jGWh8aqViW4s1
	TH+GYo/0bzH2Z3+AsAPyF3hFpuOORDqgOsvisMgwuzxc3YaZbMocsJPWRjES+Nno
	cYBoPiONrENhBu3yJLcZA==
X-ME-Sender: <xms:KimCaQc2rpPJ71dDcwRH0GGWMvDNVdpLECd667QSY6PJQMZYJSQY8w>
    <xme:KimCadAeuiEV-loxHxKvKF896UnQMIJeQVvkbNzR76HR1gohwecZKe7MLEh26EvFJ
    ttCkwT3QHT-w016iceFjc_HjqqyX3nBlkW51XZ6tyBq20zdoyqWkcs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukedtheelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhepvdfhvdekueduveffffetgfdvveefvdelhedvvdegjedvfeehtdeggeevheefleej
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnh
    gusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepvdefpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehmrghthhhivghurdguvghsnhhohigvrhhssegvfhhfihgtihhosh
    drtghomhdprhgtphhtthhopehsughfsehfohhmihgthhgvvhdrmhgvpdhrtghpthhtohep
    rghlvgigvghirdhsthgrrhhovhhoihhtohhvsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epvgguugihiiekjeesghhmrghilhdrtghomhdprhgtphhtthhopehjohhhnhdrfhgrshht
    rggsvghnugesghhmrghilhdrtghomhdprhgtphhtthhopehmvghmgihorhesghhmrghilh
    drtghomhdprhgtphhtthhopehrohhsthgvughtsehgohhoughmihhsrdhorhhgpdhrtghp
    thhtohephhgrohhluhhosehgohhoghhlvgdrtghomhdprhgtphhtthhopehmrghtthgsoh
    gsrhhofihskhhisehgohhoghhlvgdrtghomh
X-ME-Proxy: <xmx:KimCaS5sVgVt91B7P4f3ntTgpGl6UgYZcjGBWk7ggCgHwmYD5NnAWA>
    <xmx:KimCaXcKd09fDD6CymT-D6fz66TJWFyWPkwbAY5219GD31f_LEVypw>
    <xmx:KimCaRf7xG4Q5ZyJHp79Sm46ufBzSLBfjgnkC3wI5p2SaCRYJJvzYg>
    <xmx:KimCaUGG-pCYiHa_WKJozfE0ViSFUPG5aBD9NYPg0J3qHrescFQq7w>
    <xmx:KimCaYs8M-eXjzSUxQOExV68IoVNqYSeUYrHkBhqHCLSRAO1VFYkN51x>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 48370700065; Tue,  3 Feb 2026 11:58:18 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ATnu9ZDQUFrg
Date: Tue, 03 Feb 2026 17:57:58 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>,
 "Arnd Bergmann" <arnd@kernel.org>
Cc: "Alexei Starovoitov" <ast@kernel.org>,
 "Daniel Borkmann" <daniel@iogearbox.net>,
 "Andrii Nakryiko" <andrii@kernel.org>, "Song Liu" <song@kernel.org>,
 "KP Singh" <kpsingh@kernel.org>, "Matt Bobrowski" <mattbobrowski@google.com>,
 "Steven Rostedt" <rostedt@goodmis.org>,
 "Masami Hiramatsu" <mhiramat@kernel.org>,
 "Martin KaFai Lau" <martin.lau@linux.dev>,
 "Eduard Zingerman" <eddyz87@gmail.com>,
 "Yonghong Song" <yonghong.song@linux.dev>,
 "John Fastabend" <john.fastabend@gmail.com>,
 "Stanislav Fomichev" <sdf@fomichev.me>, "Hao Luo" <haoluo@google.com>,
 "Jiri Olsa" <jolsa@kernel.org>,
 "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>,
 "Mykyta Yatsenko" <yatsenko@meta.com>,
 "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, bpf <bpf@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
Message-Id: <5f9c89fe-df1d-4eb4-b724-08f8d90fcc59@app.fastmail.com>
In-Reply-To: 
 <CAADnVQ+14yum8okMmjuqF5m5DafWo1fY1EuPj-QU_ykYbQ01uw@mail.gmail.com>
References: <20260203162746.2337002-1-arnd@kernel.org>
 <CAADnVQ+14yum8okMmjuqF5m5DafWo1fY1EuPj-QU_ykYbQ01uw@mail.gmail.com>
Subject: Re: [PATCH] bpf: add missing __printf attributes
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 3, 2026, at 17:34, Alexei Starovoitov wrote:
> On Tue, Feb 3, 2026 at 8:27=E2=80=AFAM Arnd Bergmann <arnd@kernel.org>=
 wrote:
>>
>> From: Arnd Bergmann <arnd@arndb.de>
>>
>> Some internal functions in bpf produce a warning when -Wsuggest-attri=
bute=3Dformat
>> is passed to the compiler, e.g. in 'make W=3D1':
>>
>> kernel/trace/bpf_trace.c: In function '____bpf_trace_printk':
>> kernel/trace/bpf_trace.c:377:9: error: function '____bpf_trace_printk=
' might be a candidate for 'gnu_printf' format attribute [-Werror=3Dsugg=
est-attribute=3Dformat]
>>   377 |         ret =3D bstr_printf(data.buf, MAX_BPRINTF_BUF, fmt, d=
ata.bin_args);
>>       |         ^~~
>>
>> The attribute here is useless since there are no callers from C code,
>> but it helps to shut up the output anyway so we can eventually turn
>> the warning option on by default.
>>
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> This was discussed and it's incorrect.

Do you have a reference to why it's incorrect?  It seems harmless
and gives me a clean kernel build in combination with a handful
of other fixes after enabling the option by default, but I assume
I'm missing something,

> Commit 7bf819aa992f ("vsnprintf: Mark binary printing functions with
> __printf() attribute") should be reverted instead.

Reverting that one would appear to introduce warnings elsewhere,
so that would not be a complete fix either.

      Arnd
