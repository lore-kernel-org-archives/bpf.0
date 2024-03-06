Received: from wfout5-smtp.messagingengine.com (wfout5-smtp.messagingengine.com [64.147.123.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD47C5CDD8
	for <bpf@vger.kernel.org>; Wed,  6 Mar 2024 07:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709711864; cv=none; b=LEDDo3ApUhlUgT9mzOdOWY8zuK+tdPcLUNB9o0mPE4nD1SErnH3KmAfB6SqBlX27vsnflk9rzSYVU1y4vR5rjuiBydAem2LhlRf1x0mU8FrLtcpmUoKw1UCLtWNfz07SWMNNwhFNc45S9ncU1YCTdkJIltlkduZuVdL/gCZdEZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709711864; c=relaxed/simple;
	bh=6mEzWRPAPZpFHIGgZvLiqo/nfEnV9sE0CRc9KSAlcXc=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=stl/u9iTp7RWm1LgR0z70epCrL73QqeMQXLz5lUjziAbbszdndLnWiy57mBI5CNTTiMoELGHJLyCco5yDAhViF7pSWXGtZtYKIf92U8GxeaPxgIuXB42XscSz7GTsKUYjcfXYnLvmBBjfC4E5IJ+RVQZsmSPtZkTXAnSnTjIS7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isaackhor.com; spf=pass smtp.mailfrom=isaackhor.com; dkim=pass (2048-bit key) header.d=isaackhor.com header.i=@isaackhor.com header.b=cQlIpg5S; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GeQbSa1Y; arc=none smtp.client-ip=64.147.123.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isaackhor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isaackhor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isaackhor.com header.i=@isaackhor.com header.b="cQlIpg5S";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GeQbSa1Y"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.west.internal (Postfix) with ESMTP id 9868B1C000A9;
	Wed,  6 Mar 2024 02:57:41 -0500 (EST)
Received: from imap45 ([10.202.2.95])
  by compute6.internal (MEProxy); Wed, 06 Mar 2024 02:57:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=isaackhor.com;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1709711861; x=
	1709798261; bh=3cZ8wVDgtLMJtJp1u+3LLyQkoR0tmTOysQzSb4YxXUg=; b=c
	QlIpg5SzIqNLszQpTvedZFv8wVtALFBIqTCR0CCNGw5Wg/s9sDclTfpcvaG5JdUM
	oze2pz1m4OG7pbAUuOgE1icuo4ciEscKw8YIt09f3DD7lerG1df8Oc/VTqdKOdZf
	fFIZYzbUgyaPX+ezqAfXN9oRpAXkqUDDd5FLn5LFi4NVr9bYY9kNWwVsFVg00P5d
	kdLEBR3olNMpE2wX4GreKToEUlflsTj5BSVo+KDWIj7mioN2rKQOIS/ZtaMHr3IR
	PZ+EpRLm2f/O3Dj7ehws8EuiDfmUkOGIpIEUBrXG6p+hvzV111hbuYVbQMjOKR/w
	ScEgkNXcKMBNV8Q9gUhvA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709711861; x=1709798261; bh=3cZ8wVDgtLMJtJp1u+3LLyQkoR0t
	mTOysQzSb4YxXUg=; b=GeQbSa1YNmtD6DF/xAE30/vgv9UOhLjsEP4z+Gjk5JQD
	OBeYh/0r6v0Hcfh8J5yBdFYazIlXX6Y8QVWOdh9v4YKcuz2SDSQEr+Bph9/hJ5gw
	fjtPSl3OdXnCOoGB/IDTaeXfAtcH8nyBSVD7IErkVg/sJejbSuWoP8x1riVm6htW
	T/kD6jRZnEjx3MoHAPBY0PS1bBijDgY2SigJVr6fklQGKB8+C5qMWM4x/TNJDne8
	WgWIlmPlblfEGcEW77rjW+OdZJlMSqvdeN9StBFMqA7equPcMNLfiAd1NS+6w4D5
	cluyfKv2Fy84zM2WfoNn/WZh7By9DrZfyvFv8VIs5Q==
X-ME-Sender: <xms:9CHoZSKnshyrA9tgKmZaYfN0mFGJKhi6v2PD3ZQOTPqqE4BsikHznQ>
    <xme:9CHoZaLRh5HvXjATQiOhc8XFphyurx5hFvlPV9KPEE6EzeSb-q16kbFTXVNTZlZr-
    a9gBSgbMkfkQwIr0Zg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledriedtgdduuddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedfkfhs
    rggrtgcumfhhohhrfdcuoegtohhnthgrtghtsehishgrrggtkhhhohhrrdgtohhmqeenuc
    ggtffrrghtthgvrhhnpefhfeeuhfegffehgeduhffgvdejvdfgffeffefhtefhtefgieeg
    vdehtdetudeitdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpegtohhnthgrtghtsehishgrrggtkhhhohhrrdgtohhm
X-ME-Proxy: <xmx:9SHoZSsm5LGLvrKNeU6rxRSObRPJiJLIeUeO-ZIUeOiknN2pSq0WvQ>
    <xmx:9SHoZXZO9naZFUoWkoxha2ORuGj6sV7JnXxBIdSCO95bhaSbqv150Q>
    <xmx:9SHoZZYwadbxe9vkU0IPPQSm5H5mD_WafqNv4wnLSExPde953fsDJQ>
    <xmx:9SHoZYxy4AwjWhsiZDFZWivhoc7c-knrNR9cT4-NcXsS-udtUxEAVAVvkIw>
Feedback-ID: ia46944cc:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id DE571272007C; Wed,  6 Mar 2024 02:57:40 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-208-g3f1d79aedb-fm-20240301.002-g3f1d79ae
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <d55baee2-29bc-4057-b0b8-c789df8dcebc@app.fastmail.com>
In-Reply-To: 
 <CAADnVQKY0d2ww4hwbuu3TA3DFyrSeBnRqSp0qdEY2Scgf4kP5g@mail.gmail.com>
References: <8F75EC74-53D6-4841-8D41-4CF56BE69730@isaackhor.com>
 <CAADnVQKY0d2ww4hwbuu3TA3DFyrSeBnRqSp0qdEY2Scgf4kP5g@mail.gmail.com>
Date: Wed, 06 Mar 2024 02:57:20 -0500
From: "Isaac Khor" <contact@isaackhor.com>
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>
Subject: Re: struct_ops usage - verifier interactions
Content-Type: text/plain

> Was it compiled with -O0 ?
> clang didn't even inline what was marked as __always_inline which is strange.
> Make sure to use the latest clang with -O2 -target bpf -g -mcpu=v3

You're right, the optimisations got disabled somewhere along the road when
I was debugging the problem. Re-tested with the compiler args you listed:

libbpf: prog 'bpf_iden_max_ra': BPF program load failed: Permission denied
libbpf: prog 'bpf_iden_max_ra': -- BEGIN PROG LOAD LOG --
0: R1=ctx() R10=fp0
; int BPF_PROG(bpf_iden_max_ra, struct bpf_fs_readahead_state *s) @ readahead_noop.c:7
0: (79) r1 = *(u64 *)(r1 +0)          ; R1_w=scalar()
; return s->ra_pages; @ readahead_noop.c:9
1: (61) r0 = *(u32 *)(r1 +12)
R1 invalid mem access 'scalar'
processed 2 insns (limit 1000000) max_states_per_insn 0 total_states 0 peak_states 0 mark_read 0
-- END PROG LOAD LOG --
libbpf: prog 'bpf_iden_max_ra': failed to load: -13
libbpf: failed to load object '/root/readahead_noop.o'

Stepping through the verifier in a debugger still shows the same problem,
somehow the verifier thinks that the register is a `SCALAR_VALUE` instead of 
valid pointer.

> You should see something like:
>
> llvm-objdump -S -r bpf_cubic.bpf.o|head -50
>
> bpf_cubic.bpf.o:    file format elf64-bpf
>
> Disassembly of section struct_ops/bpf_cubic_init:
>
> <... snip ...>

Yep, the output matches. I'm building with `vmlinux.h` instead of linux/bpf.h
but otherwise nothing has changed.

Thanks,
Isaac Khor
