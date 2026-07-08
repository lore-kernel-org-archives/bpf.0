Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A6C262D0B
	for <bpf@vger.kernel.org>; Wed,  8 Jul 2026 14:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783521207; cv=none; b=ppqLKHXHth+QJ0P6Nsa+GkO6HdyeEwzmynBKOWmoGNwSXjTnSiBiFYp8W7jegNnfyUvdkRtPdBJbVxb9q5/lb1E4uBP9RT08bfkYO6d+KmJFxSssUlAFMdm5N82Ayv1hXYq/dSGLJNwYHnNUKN1Kaz5/hU2KFH9ne2PHq+cvF28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783521207; c=relaxed/simple;
	bh=En+DTw41wTTzeOFEvpjzUW7VImKXVzVSY1KV2yjCIAI=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Subject:Cc:From:
	 References:In-Reply-To; b=h0CtbOei1wkwHnIBGYt3jPyWJZegZh/ZkV2uOhCI94dkSI5rK/Mu6RudRKi2PYx/YHgblKmc2aw63ZxBc+pWkVTYBkCIOwVSMUYCtlm46gZchBv3wDV5VHkGXwQakowZY7qDhXP4ocE00P0gXF5ffTA1GhPN/EOpq11FPbfG3gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=RhQtti0p; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="RhQtti0p"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id BBF671A0EAA
	for <bpf@vger.kernel.org>; Wed,  8 Jul 2026 14:33:24 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 8496360339;
	Wed,  8 Jul 2026 14:33:24 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C189A11BC16CC;
	Wed,  8 Jul 2026 16:33:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783521204; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=eZs9CZ9c3kbiVyLs1ZcaaVEpmmTWJ9qTkPDu+cCL3ls=;
	b=RhQtti0pm/yOI9NOM5HsCE9RQyY29qPN6fBxKcDKsvd4dy74zQYxpyAZI7J7aFmTdgjXSZ
	ZVXX9vBdQSwaJKVO0sFnSr0yxrKuMDjTd1oyOrnbgSjzvbCCe1MgzTRKaPocfHbWFTIkgD
	9dnOlAxIaz7BLKgrJ6aos5ANzYtIvKkaO7IM9ToZQiHkTSzCD2Y6jB7v0iiyKm4tJpk2LH
	G0rJ9p9+4GrQnJArE5OjcC/pwk3K7jRw/qyBM9oKxw5LBTYWXw3Dz7vGDs+eI24vE2vWxI
	4zroTEPHwZ76oZTnTyGDhKBMMo+0prpUaYf3Ma+Q/q7Gbae1Zm519mGByj2C7A==
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 08 Jul 2026 16:33:23 +0200
Message-Id: <DJT9I1RTRU5T.18LAJGPWA4UK2@bootlin.com>
To: <sashiko-reviews@lists.linux.dev>,
 =?utf-8?b?QWxleGlzIExvdGhvcsOpIChlQlBGIEZvdW5kYXRpb24p?=
 <alexis.lothore@bootlin.com>
Subject: Re: [PATCH bpf-next v4 07/10] bpf, x86: enable KASAN for JITed
 programs on x86
Cc: <bpf@vger.kernel.org>
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260708-kasan-v4-0-d5c177ab8227@bootlin.com>
 <20260708-kasan-v4-7-d5c177ab8227@bootlin.com>
 <20260708081920.629921F000E9@smtp.kernel.org>
In-Reply-To: <20260708081920.629921F000E9@smtp.kernel.org>
X-Last-TLS-Session-Version: TLSv1.3

On Wed Jul 8, 2026 at 10:19 AM CEST, sashiko-bot wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:

[...]

>> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>> index bdad90f210e4b..705a9ab85f3a9 100644
>> --- a/arch/x86/Kconfig
>> +++ b/arch/x86/Kconfig
>> @@ -233,6 +233,7 @@ config X86
>>  	select HAVE_SAMPLE_FTRACE_DIRECT	if X86_64 >>  	select HAVE_SAMPLE_FTR=
ACE_DIRECT_MULTI	if X86_64 >>  	select HAVE_EBPF_JIT
>> +	select HAVE_EBPF_JIT_KASAN		if X86_64
> [Severity: Critical]
> Does enabling this feature introduce memory corruption by exposing a bug =
in
> emit_kasan_check()?
>
> Looking at arch/x86/net/bpf_jit_comp.c:emit_kasan_check(), caller-saved
> registers (rax through r9) are pushed, but r10 (BPF_REG_AX) and r11 (AUX_=
REG)
> are explicitly missing. This exposes them to clobbering by the KASAN C
> function call:
>
> arch/x86/net/bpf_jit_comp.c:emit_kasan_check() {
>     ...
> 	/* Save r8 */
> 	EMIT2(0x41, 0x50);
> 	/* Save r9 */
> 	EMIT2(0x41, 0x51);
>
> 	/* mov rdi, addr_reg */
>     ...
> }
>
> For BPF_STX, if constant blinding is used, src_reg is BPF_REG_AX (r10).
> The value in src_reg is corrupted by emit_kasan_check() before it is stor=
ed
> by emit_stx():
>
> arch/x86/net/bpf_jit_comp.c:do_jit() {
>     ...
> 			err =3D emit_kasan_check(env, &prog, dst_reg, insn, ip,
> 					       true, accesses_stack_only);
> 			if (err)
> 				return err;
> 			emit_stx(&prog, BPF_SIZE(insn->code), dst_reg, src_reg, insn_off);
>     ...
> }
>
> Additionally, in atomic fetch operations, BPF_REG_0 is moved into BPF_REG=
_AX.
> The pointer (real_dst_reg) might become BPF_REG_AX, which is passed to
> emit_kasan_check() and then used afterwards, resulting in using a corrupt=
ed
> pointer:
>
> arch/x86/net/bpf_jit_comp.c:do_jit() {
>     ...
> 				/* Will need RAX as a CMPXCHG operand so save R0 */
> 				emit_mov_reg(&prog, true, BPF_REG_AX, BPF_REG_0);
> 				if (src_reg =3D=3D BPF_REG_0)
> 					real_src_reg =3D BPF_REG_AX;
> 				if (dst_reg =3D=3D BPF_REG_0)
> 					real_dst_reg =3D BPF_REG_AX;
>
> 				ip +=3D 3;
> 			}
> 			if (!bpf_atomic_is_load_store(insn)) {
> 				err =3D emit_kasan_check(env, &prog, real_dst_reg,
> 						       insn, ip, false,
> 						       accesses_stack_only);
>     ...
> }
>
> Unprivileged users loading BPF programs with constant blinding might trig=
ger
> arbitrary memory reads or writes due to this clobbering.

Already discussed multiple times in previous revisions.

--=20
Alexis Lothor=C3=A9, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

