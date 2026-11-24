Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795520651;
	b=pEK3tth10nVvH1nztFI9tr9lioV8VUvS4P3a7Fxe2OSCs0KTzY7EE24pMLomv7UNtxgV
	 LxUeS8c0snRGASB8ldpD/6Vvy4VujgyWfSGYVZ0BT2NadigrWpArwmWSC1oeWmwHICbqz
	 i+6WKefRH07UeVsUd6gt8jCeju7qYVrWpvCmpe4RidIIeZiLi39vEyKIPb1ELzJEvn1ls
	 Cq2qoxPr/hC2EQ5dLfm/Qjj1O5l7av+6SdmuglMv2frMmLV5rZIBMMrgUPD/22EXrYl6t
	 jA5b0A9uerNvdDqalDCy2cNXB6xi0nNFj0t6QB8rRowdQZdE9qW+EuFRYBq7B8pNsgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795520651;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=N8ZwPvRdVQ5w2lgcEQVZGVC5oZ+OtkHzlUcaoTKvjTw=;
	b=5ZQQumm6PsC1lXzbbIIs3RDVdReeQSvc5Vm+T/tGKZds8yeOh+3JUdvc+X1PZRmi2t1n
	 wuN5cbvcOaSRf+verSMcv6AkCI7qIsRY0MqAnALc3YwaG4bRKmOJvK5P8/w+ElMef3XNS
	 imHYXensBECzBmsPZKwCgVN5dTbVhjC63h1NY+VtjIcvQZHxCphMW0y6dhRJVHHCakTr1
	 2y0ufJy0zoD9APKw+ylfentikySojhBqGnspdq/woJ8NFfVKe/y42IKiAQPDgMuHPGTQ3
	 glCNYz77ZVqmYlBN2XGICbHNL1quUhxS9XoOlGZen7PI2wPcgikETt6hrmuA4Pm0E+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=roblab.la;
	spf=pass smtp.mailfrom=roblab.la;
	dkim=pass header.d=roblab.la header.i=@roblab.la header.a=rsa-sha256 header.s=fm2 header.b=zDYFYC3w;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=uhXj6dU2;
	arc=none smtp.remote-ip=103.168.172.151
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B06606A326
	for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 11:44:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 99B06606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=roblab.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=roblab.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=roblab.la header.i=@roblab.la header.a=rsa-sha256 header.s=fm2 header.b=zDYFYC3w;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=uhXj6dU2
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfout.phl.internal (Postfix) with ESMTP id 7AA5BEC0CF0
	for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 06:44:09 -0500 (EST)
Received: from ams-imap-01 ([10.64.2.21])
  by ams-compute-02.internal (MEProxy); Tue, 24 Nov 2026 06:44:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=roblab.la; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1795520646;
	 x=1795607046; bh=N8ZwPvRdVQ5w2lgcEQVZGVC5oZ+OtkHzlUcaoTKvjTw=; b=
	zDYFYC3wexfaIgx8zNffpg9ogZuJCVHAUEMlO1YAALQu/uHNMHYmysXehwFaIhk2
	jf8g1/u/EIZt19wPWRWjL/r5FqDdL2O0M7QHh3eILktcqrsiZHHbHz6qlD5SIR2j
	NXpT8W6mosEgGglIku4J6hN0NycewfAKVoL0BB/EuIeelPselkwnR2ZqC7ON9Jxe
	XmslgP6I3ilwoaYcsuqGcPiXsr22JOkXTzkdrPfh9Szu8iFtPKD+6qCHrOyQQjrK
	pE8fVC4r4Z/0MpPH4JC7CHOWl9YbU2ZZ080u9byBOWfWqD8D5emK2D1w5Q2nJbcX
	VUUg75+pPjyBTND/0sH/BA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795520646; x=
	1795607046; bh=N8ZwPvRdVQ5w2lgcEQVZGVC5oZ+OtkHzlUcaoTKvjTw=; b=u
	hXj6dU2NGsl5yxC6Ru2m4kQ3+TiBA6m8WdWFlpm/d3+SLSF79ds/pGE74jRTdQ6z
	7fHMSpLlkviKhdlipGtw3Dy7HutCaGVtq30JGeEWPnqQy9yKy/sC5zI8gLGjWbeP
	/bhxTWsMs7kQmtx0Jb9jLgQ72RISnkiM4aSF9pHneE2iTumLQEtZSmIcNiS2AHjR
	6Cy1+dFOTiKvPyIyVY7THOg+4aOpnc3z+3u6XgO6hwRsRF59YUN8VINoI6yMWPFL
	vJPLe6ViF54KkUFS72pXxseoAW17X8CcGZsgrXmKaHSri9G+1bQqAmAkSesxv/ys
	HRfyqc47rjb5EY0VnRlXQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=roblab.la a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795520646; d=roblab.la;
	mf=PGxpbnV4QHJvYmxhYi5sYT4=; rt=PGJwZkB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:b1cmfR0e6UvezP+qxEWLpydn6ehMCualfOcuqEVFchCfWul
	LNNNPe7Yqu/QVs852UQ274aEYQ8Zv1FIXIv/q4qlEM6EFDf4KfqfDPSpr+CXEf9m
	a8TxAnaLtTsFK78FNU4SLOFqkM+4hZUqiDMM0FPFDYPQtiDe/aUyMUPDN7SDa+5z
	O0qywN6yI21VijEAyNeT4NIb5YRBrcHccHQ05RRgWON6sJjI/RxyJAQlQ+jstQVH
	OEF9XBdyrWgU7juWaC3TvexAb8NHb4Ey3BB3WC7/J9gXfv6tB2bHlIyatVls9Uon
	uOW30a4l5sKXOTQUl53oTyjKfDjFxdJ+aVHYTgA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:Dd8hp7MIhTLV2jC/7YXbyY2mKFfMZQ04/wOAlib3Rss=:N8ZwPvRdVQ5w2lgcEQVZGVC5oZ+OtkHzlUcaoTKvjTw=;
X-ME-Sender: <xms:gXgFa6GG2StYcMpBXf_HbgR4FCnxHnN2Qv-VKOei6ZQhOaRn3Dw_Bw>
    <xme:gXgFa2LMjbBsIIFKzDdTEzVsx50wK0horskny35SEyBU6IA0PkuzLjMoL2rZU9-QC
    695IOx4cF-faVXi5wjI_hNH1TbPAFGVhk2mHDAYm4n-ZFZi4nbtdf0>
X-ME-Proxy-Cause: dmFkZTGybzWXWqi2KfGEkkNVWKjEvPW7MWzRp/je3r72i5X5OVhLIMGFKlkE/o4YYFL/XL
    EhTJCQvrT0we6f5gxwoZHshPN8e8IrJojlT9BiLsxDkwUT5d7kSsjSJ0wCncBKmA4edGnf
    g8mYMO2Qj9QR+Yz5PTQmJEeSs4qsYX4ebd19Xkxnd58eE9nIn7V6DiwwYlIUpn8YDypv+F
    OUy8A/xnvS36+4L3ijBtClHiSUp++G51hZ3HqErC/f5F5jrr6C+06yV35Zf9p5+TsDC8K7
    Yg1LjG73zqGuQIGFczUdmiV269uUoG2DkoKIRITA/hJmJ0/M9WkQivlfVzh+IdslSHdhrq
    H0b2ulxivTTWq36moJSL8GYCIKMLEyRDLVVd1Bt4YvH15qX7uhyJ0pV2GuEEvTPv2sjn0N
    +4MmLo/OMu999wUmV2HGwi2Y7j6oreXiXD6R9zZV977mikbPYxbL8ES4Xc0mIfEAsDI38g
    o7YT84mSWoj6n+TayN1RK18uR8+blPHo9Ml1uTwIyeA377cuvDYiRdar0+edyS8Wc27XRW
    kXVeSBthOlxdZqENbqqvhhTCn2Ng+SvD0WNd3RFTMWLsm5qKaL9qIaxvGg1Se2FkYqubSe
    DML+ZVCR7n1hHJSuF3eH0XseTVgxIib1recs5Yg+lKNtiisHVSb+0+veEbmg
X-ME-Proxy: <xmx:g3gFa1mztdhIl612jbwONHEnMFs4Djrca8Ng7pBxemMeNCzShp0U-g>
    <xmx:g3gFaz5UADkFtw7rZdjdC-TnhuKtJvW7ZNg8Nnr_VERO2JuhFVBVWg>
    <xmx:g3gFa2RqGVpYXZLMj2EYtdsR5VxyYOqkOu3Ox_X2WqGtyRgFWaSq8g>
    <xmx:g3gFaxycmteoiHwreKBe2slpCRPuUhFIdY1KT0YkwlfIuyjrehf-Aw>
    <xmx:hngFa7QwAvFFa2l7pGE8LkpDUYes36fcqNVPwQl7zHx05UxNEI9KAPRk>
Feedback-ID: iddd147b3:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 42652FA009D; Tue, 24 Nov 2026 06:44:01 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-ThreadId: AgAAt5wBJ-mw
Date: Tue, 24 Nov 2026 12:42:17 +0100
From: roblabla <linux@roblab.la>
To: "Ihor Solodrai" <ihor.solodrai@linux.dev>,
 "Andrii Nakryiko" <andrii.nakryiko@gmail.com>,
 "Paul Moore" <paul@paul-moore.com>, "Daan De Meyer" <daan@amutable.com>
Cc: bpf@vger.kernel.org, linux-security-module@vger.kernel.org,
 "Paul Mabileau" <paul.mabileau@harfanglab.fr>, linux-kernel@vger.kernel.org,
 "Andrii Nakryiko" <andrii@kernel.org>
Message-Id: <05507d51-651e-4ff8-aa6e-4bbb1e788f64@app.fastmail.com>
In-Reply-To: <9695ec3d-7b81-488d-989f-0bd411d673f2@linux.dev>
References: <d85ece6e-27f9-4d9f-83af-4101bc76fef6@app.fastmail.com>
 <356db94e-f5d6-4fb2-839a-b97aef72256b@app.fastmail.com>
 <CAHC9VhR9sjunJRnM9gy-BkBZkapQTrr8a8FtmaK7JkAmUqTrLA@mail.gmail.com>
 <CAEf4BzZKmn6g0SK8OddjKFj_vAmZFvpZv32Hs_S+GHgT7VNfrg@mail.gmail.com>
 <9d6bdc31-e57c-4187-be78-29d82471f710@app.fastmail.com>
 <9695ec3d-7b81-488d-989f-0bd411d673f2@linux.dev>
Subject: Re: [BUG] bpf, lsm: new first argument in 7.4 inode hooks silently breaks BPF
 LSMs
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

For what it's worth, I don't particularly care about the argument order in this particular case. Like yes, it'd be nice to avoid the split, but I've already made the necessary changes to deal with it, so I just need to tell people stuck on an old version of my software to be careful when updating the kernel past 7.4. I can live with that.

I'm much more interested in a way to avoid a repeat of this when an argument is inevitably added/removed/changed in the LSM hooks - ergo a way to fail to load on prototype mismatch in eBPF LSM. To that end, I implemented Ihor's suggestion (using `bpf_core_type_matches` to verify the signature matches `security_list_options`) in my eBPFs, which resolves the immediate issue. While doing so, I found two problems in libbpf's implementation of `bpf_core_type_matches()`:

1. https://github.com/libbpf/libbpf/issues/995 : GCC and clang spell some integer types differently - for instance an `unsigned short` will be encoded as `short unsigned int` by gcc, while clang keeps the original name. `libbpf` claims to only compare the length/signedness of integer, but the code also checks the type name. In practice, this means an eBPF built with clang cannot use `bpf_core_type_matches` for this use-case.

2. https://github.com/libbpf/libbpf/issues/996 : `char` has an annoying story: In old versions of the kernel, its signedness followed platform ABI (ergo signed on x86_64), but because of a bug in pahole (fixed in 1.24), it was categorized as "unsigned" in the BTF. Then, in recent versions of the kernel, the `-funsigned-char` flag was added. This makes matching a prototype containing a char with `bpf_core_type_matches` essentially a coin toss whether it will work or not.

Now, in my case, I use a fork of aya to load my eBPFs, so I can afford to workaround both of these issues - see this PR adding the necessary machinery https://github.com/aya-rs/aya/pull/1889 - it has a commit to fix each of these. For the former I simply removed the typename check when looking at an integer type, and for the later, I relaxed the signedness check when looking at a `char`.

With these two fixes in place, the check does work properly across all the kernel versions and distros in my test matrix, and in fact it caught a (thankfully benign) mismatch in RedHat kernels caused by a backported commit that slipped through my monitoring.

So thanks a lot for the suggestion Ihor! I also looked at your branch with `BPF_PROG_ARGS` - that'd be great to have as well, making other kind of probes like tracepoints more robust against arguments being shuffled would be a welcome addition as well. While I'm a lot less worried about them (they don't run the risk of rendering a machine inoperable if they produce garbage output), being more robust is always nice. If this ends up in libbpf, I'll switch to it in a heartbeat (well, as soon as I add the equivalent code in aya anyways ^^').
