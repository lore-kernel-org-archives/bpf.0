Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C803A0E99
	for <bpf@vger.kernel.org>; Wed, 29 Apr 2026 21:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777496672; cv=none; b=Vn9qJSLYaZw2ouAupbST2TMiPIwOjz01h7u8MURBABAvcurXEuzZTB5T99yvGcnWEiviXlILzdlDIF9bnn+as6JrvBXwd5saXkrjJMzhihnRgXC5yRPivAT3rHmOUoSOt/GKp1qzW+YCfZin+qwm9IT5m8mfUcNt1/0JvF6czNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777496672; c=relaxed/simple;
	bh=PUv/wtdAaCDxWTSqwMEnMtq40S4x3X73v2jPSv0r6w4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=rfWET6q96BOXN5Sfbkfb+Syp7P1nFuXmguXtW1pLpxSyS1edWyRtd2Q5BpSyHJavfber6VP4Cuk/SXws47GMptnjr14NSbpNNCoSniR2O1rqrRgZDtSq8udP3+A8wdkl3dEn7Ipuh26/KpB0Iq9JZ070Sflh5UtiSNXDnEk4klM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=r9GKvN5f; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="r9GKvN5f"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 24A50C5EF31;
	Wed, 29 Apr 2026 21:05:11 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C9ABC5FD43;
	Wed, 29 Apr 2026 21:04:26 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E461E1072B31D;
	Wed, 29 Apr 2026 23:04:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1777496666; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=vZB3xOONBlzwTld0/b/9vkSKWE1hI2mPZDQMBd4wIO0=;
	b=r9GKvN5f/LCZsgVMuxe4ogTRntwEaB81/uuSDp6sckQm4YzHfqhQfZC1shdX6/JxDZGNfy
	AgkzDeMhl7Xfg0shl/vQO5SO5OvysfEwo2Qrb6SgaWj3RyPWw9jUf0UF0gmFErPW3jwy+l
	+1DcHSJpPRoxqDeFkX3cLLMsU2WivuTZATX8+vMpS7ow5vSaDxrN1XU3QHsZ93IuzEl/AG
	H62OS547wYcYrYZSa79e1KNqN/ILxEkMfK3Qg30Xtcc/g+wk/24+a5VLT0GESly19Q0WrC
	DIyeoB34o+Z6bKCF3I6seRMlLZzglj7gdIfssoPYG14X9xW85exm889oev04eg==
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 29 Apr 2026 23:04:24 +0200
Message-Id: <DI5XZAYSH081.1FI819ZYQZW8L@bootlin.com>
Subject: Re: [PATCH RFC bpf-next 3/8] bpf: add BPF_JIT_KASAN for KASAN
 instrumentation of JITed programs
Cc: <bpf@vger.kernel.org>
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
To: <sashiko@lists.linux.dev>,
 =?utf-8?b?QWxleGlzIExvdGhvcsOpIChlQlBGIEZvdW5kYXRpb24p?=
 <alexis.lothore@bootlin.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260413-kasan-v1-3-1a5831230821@bootlin.com>
 <20260425051840.1E7C1C2BCB2@smtp.kernel.org>
In-Reply-To: <20260425051840.1E7C1C2BCB2@smtp.kernel.org>
X-Last-TLS-Session-Version: TLSv1.3

On Sat Apr 25, 2026 at 7:18 AM CEST, sashiko-bot wrote:
> Sashiko AI review found 2 potential issue(s):
> - [Medium] BPF_JIT_KASAN is defined as a hidden config, preventing users =
from disabling it.
> - [Medium] Mismatch between commit message claims and Kconfig implementat=
ion regarding KASAN modes.
> --

[...]

>> @@ -101,4 +105,9 @@ config BPF_LSM
>> =20
>>  	  If you are unsure how to answer this question, answer N.
>> =20
>> +config BPF_JIT_KASAN
>> +	bool
>> +	depends on HAVE_EBPF_JIT_KASAN
>> +	default y if BPF_JIT && KASAN_GENERIC
>> +
>>  endmenu # "BPF subsystem"
>
> Since this config is defined as a bool without a prompt string, it acts a=
s a
> hidden symbol that is forcefully enabled whenever its dependencies are me=
t.
>
> Because KASAN instrumentation emits shadow memory checks, it can signific=
antly
> inflate the size of generated JIT code.
>
> Could this code expansion cause large BPF programs to exceed the strict B=
PF
> JIT memory limits (bpf_jit_limit) and break BPF functionality?

It likely can, indeed, but...

> If so, would it make sense to provide a prompt text so users and automate=
d
> testing systems have a mechanism to manually disable CONFIG_BPF_JIT_KASAN
> to work around JIT limits or isolate bugs without having to entirely disa=
ble
> KASAN_GENERIC?

... the discussions around this RFC rather tend make the series go in
the opposite direction ([1]) and keep it systematically enabled if KASAN
is enabled (I'll even drop this patch in the next revision and just make
the KASAN code in JIT directly depend on KASAN_GENERIC).

[1] https://lore.kernel.org/bpf/CAADnVQLj=3DUosnsC-4V2+mN92Fe0-kW++U+m-O9c9=
3kk6BwiXgw@mail.gmail.com/

--=20
Alexis Lothor=C3=A9, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

