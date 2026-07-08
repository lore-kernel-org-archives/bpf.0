Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8151047DD47
	for <bpf@vger.kernel.org>; Wed,  8 Jul 2026 14:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783520432; cv=none; b=SQchycBznhM8IqmDV2YDB8jLX5eCjEJL+txGu3Sjs2/zrYiqkr+V0djZSWlUuZpFAPNtuig3o9kazk6eScmtnwbTRJb6dj1slKwbOpCN5oYlmgYPmfMF4RGR+AfHn2lvzChUi80qrOGh2vNqOF3C546tqICvGX8cdio68C7Lzw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783520432; c=relaxed/simple;
	bh=jboNYxP/I7plW30fVByjPCcy3M964l2gryzw6AnbNgs=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Subject:Cc:From:
	 References:In-Reply-To; b=RLi+UGqXz//38g/3P+sC1JPVnvAEhhnJnmLKN7M1dqstDPEOv6Nezi3HSSAtXj5TZ4LGbLUnWokkNOmdCqH0iEzRwkcCibkEslWNgXZJKddSUjJXehB942HuKhRTFTALcI+MyeKadbGnjLLMciHKLA9HysN6lWR7xBMp3cic1i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=qvTH96ob; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="qvTH96ob"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id D0F70C8F452
	for <bpf@vger.kernel.org>; Wed,  8 Jul 2026 14:20:42 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C88B360339;
	Wed,  8 Jul 2026 14:20:28 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EAA2811BC16A2;
	Wed,  8 Jul 2026 16:20:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783520428; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=cJozUiQzey/ZKXuISknh1/zGD2CG9O0eT/2wb2q0UcI=;
	b=qvTH96obgk8oeEfbKgGOZGffkX7p78Sf5/r56pYF1UCwfO8VdJb1AkCfTPRwXgEdhHrpVx
	u5FGC2Xi93aSbikyZ/l+0Gxdz2SWrsloyPpNOMjVLGbVea8NY7GK3xwEtlcMfhJPzO9S2K
	yT/3TNr3z/UCDPUeo+QcEetTAFFX4xcfHo51RWmhbiZHIA58QT/9WnK1EhbvkPZ8taaCrh
	q+Di2/4sva8OHYfWOV2RkixjLjCb1dnLY9kCE6A4HKprIXIMS7QnWlst7n7Z4wQlYUl/C2
	dnooN1kxgacXi/9zBPCq6b2uX7WNRWZURt92PoYdAvPzfiP80tDKZnwZtFxgEQ==
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 08 Jul 2026 16:20:27 +0200
Message-Id: <DJT985A6ZGZ3.2496O5EXL4MDR@bootlin.com>
To: <sashiko-reviews@lists.linux.dev>,
 =?utf-8?b?QWxleGlzIExvdGhvcsOpIChlQlBGIEZvdW5kYXRpb24p?=
 <alexis.lothore@bootlin.com>
Subject: Re: [PATCH bpf-next v4 04/10] bpf, x86: add helper to emit kasan
 checks in x86 JITed programs
Cc: <bpf@vger.kernel.org>
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260708-kasan-v4-0-d5c177ab8227@bootlin.com>
 <20260708-kasan-v4-4-d5c177ab8227@bootlin.com>
 <20260708081612.7006D1F000E9@smtp.kernel.org>
In-Reply-To: <20260708081612.7006D1F000E9@smtp.kernel.org>
X-Last-TLS-Session-Version: TLSv1.3

On Wed Jul 8, 2026 at 10:16 AM CEST, sashiko-bot wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
> - [High] emit_kasan_check() fails to save caller-saved registers r10 (BPF=
_REG_AX) and r11 (AUX_REG), causing them to be clobbered by C KASAN helpers=
.
> - [Low] The static function emit_kasan_check() is defined but never calle=
d, leading to a -Wunused-function compiler warning and build failure.

[...]

>> +static int emit_kasan_check(struct bpf_verifier_env *env, u8 **pprog,
>> +			    u32 addr_reg, struct bpf_insn *insn, u8 *ip,
>> +			    bool is_write, bool accesses_stack_only)
>> +{
>
> [Severity: Low]
> Does this introduce a -Wunused-function compiler warning? The static func=
tion
> emit_kasan_check() is added here but does not appear to be called anywher=
e in
> this patch. This could cause build failures on setups with -Werror, break=
ing
> git bisectability.

True, that standalone definition was intended to ease the review. I'll
keep it as is, unless anyone requires this to be squashed in the commit
actually calling the new helper.

[...]

>> +	/* Save rax */
>> +	EMIT1(0x50);
>> +	/* Save rcx */
>> +	EMIT1(0x51);
>> +	/* Save rdx */
>> +	EMIT1(0x52);
>> +	/* Save rsi */
>> +	EMIT1(0x56);
>> +	/* Save rdi */
>> +	EMIT1(0x57);
>> +	/* Save r8 */
>> +	EMIT2(0x41, 0x50);
>> +	/* Save r9 */
>> +	EMIT2(0x41, 0x51);
>
> [Severity: High]
> Could omitting r10 and r11 here lead to data corruption?=20
>
> The commit message mentions skipping them to reduce overhead, but the cal=
led
> C functions (__asan_loadX, __asan_storeX) follow the System V AMD64 ABI a=
nd
> might clobber caller-saved registers like r10 and r11.=20
>
> In the x86 BPF JIT, r10 is mapped to BPF_REG_AX, which is used across
> instructions to hold state (such as during constant blinding rewrites whe=
re
> BPF_ST_MEM is transformed into BPF_STX_MEM using BPF_REG_AX as its source=
).
>
> Would this result in storing garbage data when the C helper clobbers
> BPF_REG_AX?

Already discussed multiple time in the previous revisions.

Alexis
>
>> +
>> +	/* mov rdi, addr_reg */
>> +	EMIT_mov(BPF_REG_1, addr_reg);
> [ ... ]




--=20
Alexis Lothor=C3=A9, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

