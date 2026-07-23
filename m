Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F2C361948
	for <bpf@vger.kernel.org>; Thu, 23 Jul 2026 18:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784830480; cv=none; b=jPzhjLChduGKp6CkrXxhZHwULPLh/+BGqOZNn38hJYAsurtLuMOkicY3mPR7AHkRaROyAvdM7CTat/TBYJLRupwZnboFA3X9MKMTerrnWEdw8hW7XSboWMLNkXlFimxrNgqZ3t7ynce4zzEm9u4yW32CgOleFYe4txGFs3TQ3Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784830480; c=relaxed/simple;
	bh=xqa/iEeG53HBI+Q/pfOW9H63MRCZykZXKT4SwjwiDH4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=qfDBfHgZM4pEGte7oo1c5c3Y+rxzyFPl/ZI0GMQcjN7F+H+T7PimnwXqx4mK8EjDbMwqRNJIfYc5efptHUDZN3vl784J0AbIO6JSKRJ3y6Gkh3VneahOcSO4q41MUsX0oXMnTx07bdZrcvoanNbEuQhjqavtgZymX51qrOTA92o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Rncqyx9/; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Rncqyx9/"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 027FD1A1197;
	Thu, 23 Jul 2026 18:14:35 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id BBCFC6038D;
	Thu, 23 Jul 2026 18:14:34 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 81CB811C113CD;
	Thu, 23 Jul 2026 20:14:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1784830474; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=S98asg3MVpyBGpZbRMAducyfSiLz8bdjfuDcl35YefA=;
	b=Rncqyx9/PH6PHCct4TQCljnoQCZL4h+UQ4ibwm8jpHBFsykYp2Go/bufmEoeUrZmGDmjKh
	3RIBoXTQ0yd/6QywxPpz4RoXLSXLk5f5gi+rwOfSXIrXV7swA2Kty2IkwyCknGYDasOv6t
	rHUAlvMJZ4+rxzjecAPu2jp0+rvKBHVOBJJ3KYxzZxEG+zGGD3dW3RhSmredFQGm2GGG1n
	xGIWG+QJNhf/dwVmZwvTRIaEePiShtBfQLqbFrRFkNdKDhhwBliKxc+5VsvuOiuR2XJhzG
	qTH6+4j2qCCMaQF4PY2rX65VpJoBdYtm0pw6o4WadYCR2qBrorktbucllD3pHQ==
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 23 Jul 2026 20:14:32 +0200
Message-Id: <DK65LJMNL4VC.3EHPKD4YSYWG@bootlin.com>
Subject: Re: [PATCH bpf-next v5 05/10] bpf, x86: refactor BPF_ST management
 in do_jit
Cc: <bpf@vger.kernel.org>
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
To: "Ihor Solodrai" <ihor.solodrai@linux.dev>,
 <sashiko-reviews@lists.linux.dev>,
 =?utf-8?b?QWxleGlzIExvdGhvcsOpIChlQlBGIEZvdW5kYXRpb24p?=
 <alexis.lothore@bootlin.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260709-kasan-v5-0-1c64af8e4e1e@bootlin.com>
 <20260709-kasan-v5-5-1c64af8e4e1e@bootlin.com>
 <20260709110819.6BED51F000E9@smtp.kernel.org>
 <9ddec85b-2a70-4bf6-af09-701f485d0cae@linux.dev>
In-Reply-To: <9ddec85b-2a70-4bf6-af09-701f485d0cae@linux.dev>
X-Last-TLS-Session-Version: TLSv1.3

On Thu Jul 16, 2026 at 12:27 AM CEST, Ihor Solodrai wrote:
> On 7/9/26 4:08 AM, sashiko-bot@kernel.org wrote:

[...]

>>> +	insn_off =3D insn->off;
>>> +	if (dst_reg =3D=3D BPF_REG_PARAMS) {
>>> +		/*
>>> +		 * Args 7+: reverse BPF negative offsets to
>>> +		 * x86 positive rsp offsets.
>>> +		 * BPF off=3D-16 =E2=86=92 [rsp+0], off=3D-24 =E2=86=92 [rsp+8], ...
>>> +		 */
>>> +		insn_off =3D outgoing_arg_base - outgoing_rsp -
>>> +			insn_off - 16;
>>> +		dst_reg =3D BPF_REG_FP;
>>> +	}
>>=20
>> [Severity: High]
>> Does hiding the BPF_REG_PARAMS translation inside emit_st() conflict wit=
h the
>> stated goal of adding KASAN instrumentation before the call?
>>=20
>> If KASAN checks are inserted in do_jit() before emit_st() is called, wou=
ldn't
>> they attempt to instrument Arg 6 (which uses register r9, not memory)?
>>=20
>> Additionally, wouldn't any KASAN checks added before this helper use the=
 raw
>> BPF_REG_PARAMS pseudo-register before it is translated to BPF_REG_FP, ca=
using
>> instrumentation against an unmapped register (which evaluates to rax)?
>
> I think sashiko is wrong, because BPF_REG_PARAMS stores should always hav=
e
> non_stack_access =3D false, but please double check

So I've checked this empirically by monitoring any call to
emit_kasan_check with addr_reg >=3D MAX_BPF_REG and running the whole
selftests set. I confirm that BPF_REG_PARAMS is never passed to
emit_kasan_check.

While doing so however, I have spotted an unrelated example of undesired
instrumentation on some stack access (seeing emit_kasan_check receiving
15 -> X86_REG_R9)
- pyperf600_bpf_loop.bpf.o uses a bpf_loop() and is of type "raw
  tracepoint"
- the verifier inlines the bpf_loop() call, and so generates those
  insns:
  [...]
  185: (7b) *(u64 *)(r10 -352) =3D r6
  186: (7b) *(u64 *)(r10 -344) =3D r7
  187: (7b) *(u64 *)(r10 -336) =3D r8
  [...]
- those instructions, not bearing any former marking (because they are
  new/generated by the fixups) , are systematically marked with
  non_stack_access=3Dtrue, despite only accessing stack.
- when the JIT comp encounters those insn, it turns r10 into X86 r9,
  and are systematically instrumented, hence the value received by
  emit_kasan_check.

I _think_ it's ok (to be confirmed) and if so, this looks like a slight
overhead that we may agree to afford, based on the discussions on the
other commits. Or, I can make the verifier fixups (adjust_insn_aux_data)
slightly smarter, and systematically set non_stack_access=3Dtrue for mem
accessing insn:
1. that aren't the original insn
2. and for which _neither dst_reg nor src_reg is r10_

Alexis

NB: I am OoO until 03/08, I'll resume this investigation when I get
back.

--=20
Alexis Lothor=C3=A9, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

