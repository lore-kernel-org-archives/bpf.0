Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECCDC48094A;
	Wed, 22 Jul 2026 08:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784709722; cv=none; b=gc8zroDtQXjE4NK393sq68lJ7M/5s8ZwL2JWFY59n7MxvMhP5J80oIYAyGj5XRKYNYfRwc65mbwMja+rLXPJC/ALwq7/O2D72pFrYbqZ71+hysI1RhaFtMGY3IKO0tYOyOvtGNWjIadKj0py47MRcPCQp4J23zk9iqSXhLBIbTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784709722; c=relaxed/simple;
	bh=1AmBG2S3F2ZWIEEt5VcFVNo0fsz8Zid9QZvITX+DA7c=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Subject:Cc:From:
	 References:In-Reply-To; b=W9bOSgTjK4wyUC2Tf2xAZu8iZvm8c5xt3/DDoQB6Idhlr9owL+5qJ55ZVCycgrA2SowqqafS17e1wRNDKL5E90Af/C4S4AL2M9vclsQQW0Q9svbUR5fK1QN6ChgfEenAj5WBTOJJWArIUbzsOEnnsOrwq8APB2wVVSTM4UFs6OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=2MXFqphn; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="2MXFqphn"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id E2CF84E40EC2;
	Wed, 22 Jul 2026 08:41:57 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A6E6D60388;
	Wed, 22 Jul 2026 08:41:57 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6149711BD0424;
	Wed, 22 Jul 2026 10:41:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1784709716; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=R4FRHWL0tY4VMpWfWqCBQs1ITN/uP11uQ8hOe/SFpZQ=;
	b=2MXFqphnqEUwqn6dPWHrXwcmD8ZDNPA8exPJLNroFz1qbLhbS5t2NTEbM8r/mcblUIth0o
	UzUglKqKGjr3/zfqJRA8VT0IbudnwhArMExijPgvfP4GiZDZMUNKy1L6bQ+DfzzbESNY0e
	ZeHHes8704qKjYf0aMxIVzOrORcFFNAbv0hRBuC03eArC5epqYt08YSjfEtiXjxRkfJxnH
	yIGAehbm+pZI3Zxo8MXRjhQutEsqnXBEcqir1MW5MFxpIMyzs+Fo35tRfwmgzR3Mheh608
	VnTj9xPzvIO8LosSHqHEYnAz6q2HCqH82ncK35wIItQgyULoPWvoZMSrsfB5Mw==
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 22 Jul 2026 10:41:49 +0200
Message-Id: <DK4YSI0RWB7L.3N89245Y5AO6E@bootlin.com>
To: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>, "Ihor
 Solodrai" <ihor.solodrai@linux.dev>, "Alexei Starovoitov" <ast@kernel.org>,
 "Daniel Borkmann" <daniel@iogearbox.net>, "John Fastabend"
 <john.fastabend@gmail.com>, "Andrii Nakryiko" <andrii@kernel.org>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, "Eduard Zingerman" <eddyz87@gmail.com>,
 "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Song Liu" <song@kernel.org>,
 "Yonghong Song" <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>,
 "Thomas Gleixner" <tglx@kernel.org>, "Borislav Petkov" <bp@alien8.de>,
 "Dave Hansen" <dave.hansen@linux.intel.com>, <x86@kernel.org>, "H. Peter
 Anvin" <hpa@zytor.com>, "Shuah Khan" <shuah@kernel.org>, "Ingo Molnar"
 <mingo@redhat.com>, "Andrey Konovalov" <andreyknvl@gmail.com>
Subject: Re: [PATCH bpf-next v5 01/10] bpf: propagate original instruction
 offset when patching program
Cc: <ebpf@linuxfoundation.org>, "Bastien Curutchet"
 <bastien.curutchet@bootlin.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, <bpf@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260709-kasan-v5-0-1c64af8e4e1e@bootlin.com>
 <20260709-kasan-v5-1-1c64af8e4e1e@bootlin.com>
 <bbbcbae7-a819-4f86-b116-6d5e31973a0e@linux.dev>
 <DJZRZ1WQ82BG.3UJGK4IH5703@bootlin.com>
In-Reply-To: <DJZRZ1WQ82BG.3UJGK4IH5703@bootlin.com>
X-Last-TLS-Session-Version: TLSv1.3

On Thu Jul 16, 2026 at 8:17 AM CEST, Alexis Lothor=C3=A9 wrote:

[...]

>>> In order to introduce KASAN support for eBPF JIT, we need to mark any
>>> load/store instruction that accesses non-stack memory, but updating thi=
s
>>> new marking after a patch is not as straightforward as for indirect
>>> calls: the original BPF_ST/BPF_STX/BPF_LDX can be at the beginning, at
>>> the end or somewhere in the middle of the new patch: we then need some
>>> additional info to properly update this marking.
>>
>> I don't think we need to track the exact offset here.
>>
>> It looks like .non_stack_access is set to is_mem_insn(insn + off) in
>> every single case *except* for when a stack access happens to be in
>> the middle of a patch.
>>
>> Given that the cost of getting the flag "wrong" is an unnecessary
>> kasan check only for that case, I think it'll be cleaner to just
>> unconditionally do:
>>
>>     data[off].non_stack_access =3D is_mem_insn(insn + off);
>>
>> in adjust_insn_aux_data()
>>
>> And then the code change can be folded in patch #2
>>
>> The only problem with this I can think of is that in reality *most*
>> stack accesses go trough that special case, which would defeat the
>> purpose of the .non_stack_access flag. This can be checked empirically
>> however.
>
>> Anything else I'm missing here?
>
> Sounds good to me. I'll try to get a rough idea about how often the
> flag, in this scenario, correctly triggers or not.

So this new logic indeed let some "unwanted" cases being instrumented,
like the ldx_patched_on_stack (testing the rnd_hi32 case, so involving
bpf_opt_subreg_zext_lo32_rnd_hi32):

0000000000000710 <ldx_patched_on_stack>:
     226:       bf a6 00 00 00 00 00 00 r6 =3D r10
     227:       07 06 00 00 f0 ff ff ff r6 +=3D -0x10
     228:       bf 61 00 00 00 00 00 00 r1 =3D r6
     229:       b4 02 00 00 10 00 00 00 w2 =3D 0x10
     230:       85 10 00 00 ff ff ff ff call -0x1
     231:       61 a1 f4 ff 00 00 00 00 w1 =3D *(u32 *)(r10 - 0xc)
                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
                Is instrumented, shouldn't
     232:       63 1a f4 ff 00 00 00 00 *(u32 *)(r10 - 0xc) =3D w1
     233:       bf 61 00 00 00 00 00 00 r1 =3D r6
     234:       b4 02 00 00 10 00 00 00 w2 =3D 0x10
     235:       85 10 00 00 ff ff ff ff call -0x1
     236:       b4 00 00 00 00 00 00 00 w0 =3D 0x0
     237:       95 00 00 00 00 00 00 00 exit

While taking a further look at it, I thought about an intermediate
solution that would prevent the unwanted instrumentation, without
spreading the insn_off_in_patch value I initially proposed. What if:
- in bpf_patch_insn_data, we copy the original instruction being patched
  (the one at "off") in a temp var
- we pass this saved insn to adjust_insn_aux_data
- in the loop going over the patched zone, if the current insn matches
  the saved insn, we apply back the original non_stack_access flag,
  otherwise we systematically mark the insn as "non stack accessing" if
  this is a mem insn

Assuming that memcp'ing a struct bpf_insn is enough/correct to check
whether we are processing the original insn or a new one. Some initial
tests in my env correctly reduce the amount of instrumentation for those
stack accesses, without having to edit all bpf_patch_insn_data sites.

Alexis

--=20
Alexis Lothor=C3=A9, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

