Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00462F5487;
	Tue,  3 Feb 2026 17:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770140688; cv=none; b=osgsqs1asPw+9r++r+bxcyJMJop7zAqLrIRv5tkl3iao+9pZH5MrOgB9cxO6SIBPqabQymV7f1NTGSLBhII1PxsMkGqUZuRrzjk5cVKOBPytflmmtt8B0onvTBpmRzF/219WUM+kIddiF8dVUVnkt/zJOeIgnuJbTRF/d5kXlSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770140688; c=relaxed/simple;
	bh=AljXhBkvbuE0xOZ8XKFpmH9TODssO3BSBPIRwdLj414=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=D/XpNYB+5Gt84ABCYGsegsiuLXZTFwlk1id722hTkn40a+Dv7MeQ/oPxK7bX26zhddDeAjx1ZKTg65CAg9Bs60TE7p1UxXNBOzOozWf/EuoMIqyR8zK1xxwSgPLLxVdPyxx1ux9/sNbEGE6E7mTUzscWF7gEC4bqXdXG6GWCgwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=ZuHPbZXQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=i0RDooR2; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="ZuHPbZXQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="i0RDooR2"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id BD70AEC056D;
	Tue,  3 Feb 2026 12:44:45 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Tue, 03 Feb 2026 12:44:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1770140685;
	 x=1770227085; bh=bfw2kcvtfnc3Q83pa3ExnQIAU1qUQL+7PiDki1t3CJo=; b=
	ZuHPbZXQWb1F3tui0CGdWthZ4Vj/Si2rzJMX/oXZ/0hTmft655k4xFCjTh4v0IkX
	XRO5QcPHVhNPiESciRjcpCap/h9ok9E8K7eJ2jrSAloBy4EV+Ex8O5Szz1PBGQiH
	XGRAMWarZYhrxiXnKaIH4df5l7QMuDoNYwCSl0+gs/HwvLEsJgyo2vIQevN2BePz
	fDVTfVkNPHxuDE2Moo5aTp7wrWqXOs7Axs26fHSrLl5ak4SxgrvnrKVTnxc/iBqe
	p9lrUWkCRPD7KEeUESv9US0DFfO5CVrI1j/8EvAqV/Ax8/zLdv17mMuPsqeZje9s
	5vhABWIhUwl7kkKeSaNcYQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770140685; x=
	1770227085; bh=bfw2kcvtfnc3Q83pa3ExnQIAU1qUQL+7PiDki1t3CJo=; b=i
	0RDooR2KIxsgYpWdm25FPlyQH7UQ6vCSZsOxsoA3nBVQ+eUDcEKn771UAqdRnIl6
	iKtacJsPQMsDcLe3uvckKYBy4YDtIEykKTRch/iROxAqbFbrNTVVubTfgX/irEU6
	TcrNt73Eq8V0APjfK/0Tr73AAXlCPhGxf4Wx61mOz7olk0lRG0zOxPphEQEaIYJ9
	ckQAEb3Wyf2Q1stVD2aQhrey4T6cmGcvAPtu8ib8XoTf/6Yo5n/Vg67NulEdaFHL
	SgCus+Dz6eGgkw2mb3CbDj5/T+xjFfkMJaqWg1f9S4Jhli92LFfglxe7hlM06Dhi
	FwmJhklzS/QUe5vEjkJDw==
X-ME-Sender: <xms:DTSCaTlYEeJMsB1NhQrvTU_3P33EEsKWaZwXnTZwX3eaN_hn3ZU72A>
    <xme:DTSCaRqawHQj0c92-VS_r4QYfEHmAT1XYEJTwMj4r9oR_LBe4kpy3fTtF-NqiMBd_
    cmwJfafgIKopU4TOPB7hf6nbQmxnFIy6CroWNPvLRWAgOT4NVmvqus>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukedtieejucetufdoteggodetrf
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
X-ME-Proxy: <xmx:DTSCaTCvOqAeF3Otgcqlk5NDil5cw1XdSq8-LHRQXxF4Yv9NllgYMw>
    <xmx:DTSCaVFes9jOD1Bp1ZdCWzGQHtheiLJFAesbdjcPHBbS2-QBX36N1g>
    <xmx:DTSCaemKwmnpX_uKcWL0bU2IIV1BkIROf3gk_6LrmjOZ9xZgsIVcgg>
    <xmx:DTSCaatuv-_UN2LoHnKnsEIaYoL7pggtDHrqsr9Mb0hoAJtp_e3gPA>
    <xmx:DTSCaa1DADiCL3N6FGKgohIY_Wps5jVVEZmldUYIp5IcS6PfhbM-NiT1>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 36BDB700065; Tue,  3 Feb 2026 12:44:45 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ATnu9ZDQUFrg
Date: Tue, 03 Feb 2026 18:44:04 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
Cc: "Arnd Bergmann" <arnd@kernel.org>, "Alexei Starovoitov" <ast@kernel.org>,
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
Message-Id: <ab709a00-3a7f-423f-9d8b-b2cd17fef76f@app.fastmail.com>
In-Reply-To: 
 <CAADnVQKn4xP9s_koBuP7D_eqUX0dSPwUr-dOj3mTZNTh_VxqKQ@mail.gmail.com>
References: <20260203162746.2337002-1-arnd@kernel.org>
 <CAADnVQ+14yum8okMmjuqF5m5DafWo1fY1EuPj-QU_ykYbQ01uw@mail.gmail.com>
 <5f9c89fe-df1d-4eb4-b724-08f8d90fcc59@app.fastmail.com>
 <CAADnVQKn4xP9s_koBuP7D_eqUX0dSPwUr-dOj3mTZNTh_VxqKQ@mail.gmail.com>
Subject: Re: [PATCH] bpf: add missing __printf attributes
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 3, 2026, at 18:24, Alexei Starovoitov wrote:
> On Tue, Feb 3, 2026 at 8:58=E2=80=AFAM Arnd Bergmann <arnd@arndb.de> w=
rote:
>> On Tue, Feb 3, 2026, at 17:34, Alexei Starovoitov wrote:
>> > On Tue, Feb 3, 2026 at 8:27=E2=80=AFAM Arnd Bergmann <arnd@kernel.o=
rg> wrote:
>> >>
>> >> From: Arnd Bergmann <arnd@arndb.de>
>> >>
>> >> Some internal functions in bpf produce a warning when -Wsuggest-at=
tribute=3Dformat
>> >> is passed to the compiler, e.g. in 'make W=3D1':
>> >>
>> >> kernel/trace/bpf_trace.c: In function '____bpf_trace_printk':
>> >> kernel/trace/bpf_trace.c:377:9: error: function '____bpf_trace_pri=
ntk' might be a candidate for 'gnu_printf' format attribute [-Werror=3Ds=
uggest-attribute=3Dformat]
>> >>   377 |         ret =3D bstr_printf(data.buf, MAX_BPRINTF_BUF, fmt=
, data.bin_args);
>> >>       |         ^~~
>> >>
>> >> The attribute here is useless since there are no callers from C co=
de,
>> >> but it helps to shut up the output anyway so we can eventually turn
>> >> the warning option on by default.
>> >>
>> >> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> >
>> > This was discussed and it's incorrect.
>>
>> Do you have a reference to why it's incorrect?  It seems harmless
>> and gives me a clean kernel build in combination with a handful
>> of other fixes after enabling the option by default, but I assume
>> I'm missing something,
>
> because it's not a printf format. There are no varags here.
> gnu_printf attribute takes two arguments:
> format (archetype, string-index, first-to-check)
> Also
> "GCC requires a function with the 'format' attribute to be variadic"

My impression was that at least vbin_printf() falls into the
same category as vprintf(), which is explictly mentioned in the
gcc documentation:

  For functions where the arguments are not available to be checked
  (such as 'vprintf'), specify the third parameter as zero.

I also see the comment about bstr_printf() mention that it
uses a vsnprintf() compatible format, which would indicate that
marking the format argument isn't wrong, though I agree it is
not actually useful if there are no callers that pass a string
literal.

>> > Commit 7bf819aa992f ("vsnprintf: Mark binary printing functions with
>> > __printf() attribute") should be reverted instead.
>>
>> Reverting that one would appear to introduce warnings elsewhere,
>> so that would not be a complete fix either.
>
> Somebody needs to root cause it and fix it properly.
> Adding more incorrect annotation is not a solution.

I've tried reverting it here now, will see what I can come up
with. We can probably use the same trick that I used "[PATCH]
[v2] tracing: move __printf() attribute on __ftrace_vbprintk()",
annotate only the definition but not the declaration so the
format string warning doesn't propagate to the callers.

      Arnd
