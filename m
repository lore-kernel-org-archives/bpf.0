Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39448494A09
	for <bpf@vger.kernel.org>; Thu,  4 Jun 2026 17:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780593268; cv=none; b=nE4+Ic4mxjaRAXPBlCN3xmQgGxTutLh/CCpjP8CavO8EvlGUSjLLkaGIuqdtTqrj5qqPwwm3WrSZ+6Zc85iIYDvg26opig7vStNrCEAK0SvEufVZ3jU5BffM1HlsT4YkKMKjVP8qyqvlKJ8T/f5blPPhBc98URW3FNC/RDEjAhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780593268; c=relaxed/simple;
	bh=d3HSJAJL/CZpifWzF5pa1FkTwCP37MA00KVKkWjQ7OY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=HhNFa3KP8N7S9ypH6WYL8uPPnhRa/HO6iS6ZgedFh9t3Og1Wq97cmcMLJyDQ91Wh2jO6/zzLLBOtbeJJZBiuBI/uwytY+kwnc7QANIlAJGDKmIh0KLAV/X4fmDvrCmNTKdju3auXZMg+Sqfy/zLpuzDsXsyyqS9g3wAANMIfZi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=RJkoiN9e; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="RJkoiN9e"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 98D921A04FB;
	Thu,  4 Jun 2026 17:14:23 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 5BA305FED1;
	Thu,  4 Jun 2026 17:14:23 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E0736106A1C7F;
	Thu,  4 Jun 2026 19:14:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1780593262; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=SxKA39oCQnUS+MVqoThwKrOX8s0n4tDOtpNJzSuHeaQ=;
	b=RJkoiN9eFdrsx/DPKFWicuRKWhEJnxa2605r2gEL+HWURxq+P+GDAnherNfaUh3hiQ6wuS
	5xMRG4iPkNQPBzx8WFoke2zBEc9iz6aEEYmGG8CEA4KX99v4XEebqVuj1Vep1f9mh+Tqzh
	It1gFxEDm9ZDmsG8QQGOYssif60LXZq1bj3PM2L7cNKHCPSQgJ6dhBYrXevQ2sLqalQrYa
	cfRk4a58VGmWS6RqzOKhhNWM5kxWsbD3hlb+qATuiy3YkbFehN9oRYeMlT2oJ9sVdxzGVk
	1bY3rO9Wl5C4xoK1KtUg62lT/cfnMUYjBNG2k4A2Ps4cU2S40MAUQ8W6DNObxQ==
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 04 Jun 2026 19:14:21 +0200
Message-Id: <DJ0FMRLUKG6Z.3QLENZVQRK0VL@bootlin.com>
Subject: Re: [PATCH RFC bpf-next 2/8] bpf: mark instructions accessing
 program stack
Cc: <sashiko@lists.linux.dev>, "bpf" <bpf@vger.kernel.org>
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>,
 =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260413-kasan-v1-2-1a5831230821@bootlin.com>
 <20260425050557.827F3C2BCB2@smtp.kernel.org>
 <DJ094TM6SLCC.2FU5ZV435P1UK@bootlin.com>
 <CAADnVQ+u=pCMcB1=K_WQ3Ae5ML92of+DA1Z-sKRhHq2KoUJbnw@mail.gmail.com>
In-Reply-To: <CAADnVQ+u=pCMcB1=K_WQ3Ae5ML92of+DA1Z-sKRhHq2KoUJbnw@mail.gmail.com>
X-Last-TLS-Session-Version: TLSv1.3

On Thu Jun 4, 2026 at 6:24 PM CEST, Alexei Starovoitov wrote:
> On Thu, Jun 4, 2026 at 5:23=E2=80=AFAM Alexis Lothor=C3=A9
> <alexis.lothore@bootlin.com> wrote:
>>
>> On Sat Apr 25, 2026 at 7:05 AM CEST, sashiko-bot wrote:
>>
>> [...]
>>
>> >>  #define LR_FRAMENO_BITS     3
>> >>  #define LR_SPI_BITS 6
>> > [ ... ]
>> >> @@ -6493,6 +6498,8 @@ static int check_mem_access(struct bpf_verifier=
_env *env, int insn_idx, u32 regn
>> >>              else
>> >>                      err =3D check_stack_write(env, regno, off, size,
>> >>                                              value_regno, insn_idx);
>> >> +
>> >> +            mark_insn_accesses_stack(env, insn_idx);
>> >
>> > Global subprograms are verified independently of their call sites, and=
 pointer
>> > arguments are tracked as PTR_TO_MEM rather than PTR_TO_STACK. Inside t=
he
>> > subprogram, check_mem_access() evaluates loads and stores under the
>> > PTR_TO_MEM branch, which does not invoke mark_insn_accesses_stack().
>> >
>> > If a BPF caller dynamically passes a pointer to its stack as an argume=
nt to
>> > the global subprogram, will the JIT-compiled global subprogram execute=
 with
>> > KASAN checks enabled for those accesses?
>> >
>> > Does this erroneously monitor the BPF stack, bypassing the intended
>> > suppression mechanism?
>>
>> After having thought about this one for quite some time, I see no
>> simple way to correctly distinguish stack accesses hidden behing a
>> PTR_TO_MEM passed to a global subprog, as those are verified separately.
>>
>> I can either:
>> 1. skip PTR_TO_MEM memory instrumentation when we are in global
>> subprograms, at the risk of missing instrumentation on passed memory
>> accesses that _need_ to be instrumented
>> 2. systematically instrument passed PTR_TO_MEM memory accesses in global
>> subprog, at the risk of inserting unneeded instrumentation when the
>> passed memory comes in fact from caller memory.
>>
>> I then propose to be conservative and apply 2:  the only downside I can
>> think of is that a few alwasy-passing kasan checks will be inserted, but
>> we are at least sure not to miss any instrumentation.
>
> Isn't it the other way around? Replacing LDX with asan_load() will
> check stack access, but it doesn't have shadow memory behind it?
> Or you mean to assume kasan_vmalloc and vmalloced_stack kconfig?

Ah yes, my bad, I did not state it explicitely, but my point above
indeed assumes that we are with CONFIG_KASAN_VMALLOC and
CONFIG_VMAP_STACK




--=20
Alexis Lothor=C3=A9, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

