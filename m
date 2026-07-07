Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0843137F011
	for <bpf@vger.kernel.org>; Tue,  7 Jul 2026 12:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783426067; cv=none; b=lvqeDfgktgE1hZdqbytXGB2OUQGIWYK6xq0qduPmQGIPy+nIj3eY96jq00SPSckn2WZi89VI2jAzMJgc3/TLitI1kZCcYzrXCrqcptaBzndK1S7InpNB8bBfMS+7RRgHL7TiBikw+59P7NdYLpgWCfb1TXuV6nFQsYEhcoRdE3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783426067; c=relaxed/simple;
	bh=MgMwoRGobMzZna+biS4T5/1ah5HZaqV8KM78a2A6F1A=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=N+SXK8tb2qpgJdvDR9OXe9a2ZV3tYLqCs8CieRXPPU4/SGAF24iHt0Hb/IREO4CN638Te69HDJ6z5uvVsbwcD+HXaRq5hwIwTAepw9xsB0byxGTM4g/vPqYbpA7Z95rDASLfKLAVTxMRgjoyTEeCRP1YfsvhbefWWElo08GsFZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=sJgpysSH; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="sJgpysSH"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 547F01A0EB7
	for <bpf@vger.kernel.org>; Tue,  7 Jul 2026 12:07:41 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 1621B601A3;
	Tue,  7 Jul 2026 12:07:41 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 504DA11BC21CF;
	Tue,  7 Jul 2026 14:07:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783426060; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=7XDi/cFy3vm3OzxXUB0o9J7TB8GaimLJvUhzpuJIqqs=;
	b=sJgpysSHN9jEnkQ8zXXSqDkLUGP3ycRja4ntwRMqxB/htxrFxVdrFlxlHhVdBAy3KWHLGv
	X4xH4UQO4GahfYoZEh3PxPzcZlV/LngHxbs2Mb6Yx482wrC8YvExceKSChuJxnKeCHIYHg
	QQFQHsmr9Trz0pAhZlbaK7XKBLTGehSBPpiDCyyEJXQOjXXE909HKlYLhfDCFYkyQlE+m7
	zSokrQITeEkIZ8ms+5LLoXRJKFoGMNWu9ox2AFZkda6pIPr24H2Pe30Zl22y50ZLCoY+3C
	U8H2aRNKJlZT2kscSVooB/+A4YLlseEgnaUxHsFL3en4qtvg1V/tonAcqq/21Q==
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 07 Jul 2026 14:07:39 +0200
Message-Id: <DJSBRX3VVLCU.13U4DZX2R4FRJ@bootlin.com>
Subject: Re: [PATCH bpf-next v3 03/10] bpf: add BPF_JIT_KASAN for KASAN
 instrumentation of JITed programs
Cc: <bpf@vger.kernel.org>
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
To: <sashiko-reviews@lists.linux.dev>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260701-kasan-v3-0-bd09bb942d86@bootlin.com>
 <20260701-kasan-v3-3-bd09bb942d86@bootlin.com>
 <20260701101211.AAD851F00A3D@smtp.kernel.org>
In-Reply-To: <20260701101211.AAD851F00A3D@smtp.kernel.org>
X-Last-TLS-Session-Version: TLSv1.3

On Wed Jul 1, 2026 at 12:12 PM CEST, sashiko-bot wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] BPF_JIT_KASAN needlessly restricts its availability by uncondi=
tionally requiring VMAP_STACK.
> --
>
> commit 23714982e1ca6e827ba19b9f4c74b703b4ad2090
> Author: Alexis Lothor=C3=A9 (eBPF Foundation) <alexis.lothore@bootlin.com=
>
>
> bpf: add BPF_JIT_KASAN for KASAN instrumentation of JITed programs
>
> This commit introduces CONFIG_BPF_JIT_KASAN to enable generic KASAN memor=
y
> access checks for JIT-compiled BPF programs. The JIT compiler emits shado=
w
> memory checks before memory accesses to detect bugs like use-after-free o=
r
> out-of-bounds at runtime. The feature is gated behind HAVE_EBPF_JIT_KASAN=
.
>
>> As KASAN instrumentation for eBPF program will depend on the info that
>> can be accessed during each instruction verification, there may be
>> instructions that will be instrumented even if they don't really need to
>> (eg: global subprograms that access caller stack memory passed as
>> argument). To make sure that those additional checks do not trigger any
>> crash, make sure that VMAP_STACK is enabled so that programs stack has
>> shadow memory allocated.
>
> [Severity: Medium]
> Does generic KASAN already map shadow memory for the entire linear mappin=
g?
> If VMAP_STACK is disabled, the kernel stack resides in the linear mapping=
,
> which should already have shadow memory allocated. Could this justificati=
on
> be slightly misunderstanding the default generic KASAN shadow memory cove=
rage?
>
>> diff --git a/kernel/bpf/Kconfig b/kernel/bpf/Kconfig
>> --- a/kernel/bpf/Kconfig
>> +++ b/kernel/bpf/Kconfig
>
> [ ... ]
>
>> @@ -101,4 +105,9 @@ config BPF_LSM
>> =20
>>  	  If you are unsure how to answer this question, answer N.
>> =20
>> +config BPF_JIT_KASAN
>> +	bool
>> +	depends on HAVE_EBPF_JIT_KASAN
>> +	default y if BPF_JIT && KASAN_GENERIC && KASAN_VMALLOC && VMAP_STACK
>
> [Severity: Medium]
> Is it necessary to unconditionally require VMAP_STACK for BPF_JIT_KASAN?
>
> Following up on the commit message note, since generic KASAN covers the
> linear mapping where non-VMAP stacks reside, this condition might needles=
sly
> disable a useful security and debugging feature on kernel configurations
> where VMAP_STACK happens to be turned off.

This indeed looks over-constraining. To clarify my original intent (and
make sure that I am not overthinking it):

- the current series does its best to skip instrumentation for memory
  accesses that target the BPF program stack
- there are some cases where it is hard or not even possible to guess if
  the memory access is on stack or not (eg: the verifier fixups that
  generate memory-accessing instructions).
- there are two strategies for those "unknown" accesses: either skip
  KASAN for those, with the risk of missing illegitimate accesses
  because instrumentation has been skipped, or systematically inserting
  KASAN checks, at the risk of slightly over-instrumenting accesses
  (some of those will access stack). The latter is chosen by the current
  implementation
- if CONFIG_VMAP_STACK is selected (and !private_stack) but
  CONFIG_KASAN_VMALLOC is not, those few over-instrumented sites may
  trigger crashes because there's no shadow memory for those

I am now realizing that this situation can't happen for BPF JIT, as
VMAP_STACK depends on :

  !KASAN || KASAN_HW_TAGS || KASAN_VMALLOC
=20
So I'll just drop the dependency on VMAP_STACK

Alexis

--=20
Alexis Lothor=C3=A9, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

