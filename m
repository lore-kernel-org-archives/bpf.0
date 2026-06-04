Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305A343636D
	for <bpf@vger.kernel.org>; Thu,  4 Jun 2026 12:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780574941; cv=none; b=FrpG6UBiyQG+VdWi9L7XSTQA0+IovQMk/PZKnqyuOGjVvvLrz3Iz8as/f4zkf8KxxO8uaM2cjjujUmmQF7MKWGlWi0fethIV36hVH/3nPx2VHXXDTfMs/WHNSOWwfxFXZC2qnGzipJ3/Mdg5ItPOkMKyzVWTpczxXbmiqIShvR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780574941; c=relaxed/simple;
	bh=jY3Pzqq530Cn72frYkgbtdMUeZZjNDuhAa03g5Uw7yo=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=lPapXpQxnzZT/n8hZj6nv8cmOhtydKAD5QXwXSLKXPHRNE9Qhzfp2IlsPdIanaaYuKpDo+/wN5yH1GfWydgdLIa77Z3NjsaAGyObKrIzxz6vor9m/BX4gaJkRtZQUDwJNVrUkNHbl/Rwcle1STKaNYH0i0KPPFSLu3SthsGCS44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=L4cfS0Ud; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="L4cfS0Ud"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 4164D1A05BC
	for <bpf@vger.kernel.org>; Thu,  4 Jun 2026 12:08:52 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id F0F955FEF7;
	Thu,  4 Jun 2026 12:08:51 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2B0C5106A035A;
	Thu,  4 Jun 2026 14:08:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1780574931; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=8JExlbsCTH+ccnzG/dkGRTjdMWB4w6e4ceeXGKPD6vk=;
	b=L4cfS0UdZ7ltln4Odkyg5QmKC/Sn73ZeQQGf3R8wB4dJI3rxo9YrpH7W26r7wdG0RqUPiv
	u1YW7A7ZUSIQuzL5kJdPWZJM4QzOoAUhePMVJSyZ7lubCql0Be8QQf08Fv4WKkuOHhQ8eQ
	WSGSVp5D7l4c5bW71S9GGNXFo4bNwCdYJ/4cuGR33NE6OGvVdCKWUlpT3EJ8ocm96DJSlx
	f92DAyTs4NYMk7CJuJJ1De1vTsYCahvzb4N07H2IJD/CfROaJFqnNCD/FXRMBqGDawl0CG
	ZI7gRTfB9aXIeXcIZOxfmtphYhpQYli00+JTG7aHkKXoqyCITXaWp5MLos4ffQ==
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 04 Jun 2026 14:08:48 +0200
Message-Id: <DJ094TM6SLCC.2FU5ZV435P1UK@bootlin.com>
Subject: Re: [PATCH RFC bpf-next 2/8] bpf: mark instructions accessing
 program stack
Cc: <bpf@vger.kernel.org>
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
To: <sashiko@lists.linux.dev>,
 =?utf-8?b?QWxleGlzIExvdGhvcsOpIChlQlBGIEZvdW5kYXRpb24p?=
 <alexis.lothore@bootlin.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260413-kasan-v1-2-1a5831230821@bootlin.com>
 <20260425050557.827F3C2BCB2@smtp.kernel.org>
In-Reply-To: <20260425050557.827F3C2BCB2@smtp.kernel.org>
X-Last-TLS-Session-Version: TLSv1.3

On Sat Apr 25, 2026 at 7:05 AM CEST, sashiko-bot wrote:

[...]

>>  #define LR_FRAMENO_BITS	3
>>  #define LR_SPI_BITS	6
> [ ... ]
>> @@ -6493,6 +6498,8 @@ static int check_mem_access(struct bpf_verifier_en=
v *env, int insn_idx, u32 regn
>>  		else
>>  			err =3D check_stack_write(env, regno, off, size,
>>  						value_regno, insn_idx);
>> +
>> +		mark_insn_accesses_stack(env, insn_idx);
>
> Global subprograms are verified independently of their call sites, and po=
inter
> arguments are tracked as PTR_TO_MEM rather than PTR_TO_STACK. Inside the
> subprogram, check_mem_access() evaluates loads and stores under the
> PTR_TO_MEM branch, which does not invoke mark_insn_accesses_stack().
>
> If a BPF caller dynamically passes a pointer to its stack as an argument =
to
> the global subprogram, will the JIT-compiled global subprogram execute wi=
th
> KASAN checks enabled for those accesses?=20
>
> Does this erroneously monitor the BPF stack, bypassing the intended
> suppression mechanism?

After having thought about this one for quite some time, I see no
simple way to correctly distinguish stack accesses hidden behing a
PTR_TO_MEM passed to a global subprog, as those are verified separately.

I can either:
1. skip PTR_TO_MEM memory instrumentation when we are in global
subprograms, at the risk of missing instrumentation on passed memory
accesses that _need_ to be instrumented
2. systematically instrument passed PTR_TO_MEM memory accesses in global
subprog, at the risk of inserting unneeded instrumentation when the
passed memory comes in fact from caller memory.

I then propose to be conservative and apply 2:  the only downside I can
think of is that a few alwasy-passing kasan checks will be inserted, but
we are at least sure not to miss any instrumentation.

--=20
Alexis Lothor=C3=A9, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

