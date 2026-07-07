Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184B42E7F3E
	for <bpf@vger.kernel.org>; Tue,  7 Jul 2026 13:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783431896; cv=none; b=lu2sQ8MUOHhSV+cYxwfYe8dQi8gixF4a6E/PiO1re/hJjcNi8PSN9N4k/tlEWONrcc4lWRFMFjxWzCvaYg+euwIHUeiSq/1kGP/m3at1QUEBZB0A7aLPLf1IcVYSEzgmyDmjgXan99B0Dv2x8s1Q8n2gGS15sjK1r0AVifxz/0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783431896; c=relaxed/simple;
	bh=oTiKwW6pCc4LynyVt+qdpFUE2EDKuult/l7+T/efMbs=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Subject:Cc:From:
	 References:In-Reply-To; b=C8EFZT6Wy0JlkYSmZ7manPFfFdCUS5CbCu+nraLBwYcVtyl0Vvo7d6PHQ6YCaZAjauqsCa06mx0J0sqM9Riz9SuqcgdOm+bxnmbB09wHL55mGw4vTq0adqn5Ueve8B8DiVxIyRJnJ0Z6fTgs/s1mLDU3vrJ1do+RKNqwoJI0OAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=GdHz5GMK; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="GdHz5GMK"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id EE3F6C8F1ED
	for <bpf@vger.kernel.org>; Tue,  7 Jul 2026 13:45:04 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 70CA660333;
	Tue,  7 Jul 2026 13:44:51 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7CF5311BC24C6;
	Tue,  7 Jul 2026 15:44:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783431890; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=VRo3P7DD6QD27F8dM4vTbI4FMsYN5ProobK7FQGLKiQ=;
	b=GdHz5GMKhtEd4hLCi5bnUcKCnqPAPmmcLPkuDhATdB297NRgGm59bWzCK8VokIpM+AKQ/T
	x76+h5Mgc/ehiRjNwuiLqHDuZim3RB94SfaxMc5KPCnbZNb/sDRbe5gon5aiWme5gQgMI5
	m+Y+lMvIfJEw5Aa3Yg7SNpRv3ZNCPy6uBUKecoMIzCMIon0WLkrM3OKgqKmIAyP8BkgrtY
	WBUBb+Rq52mIGG90+Hy+GJaw19GeKEpeQRaUwnbayKIXPcQAVt7ZF7cwPs2eLoZryIinDB
	XX4cLNtRUA4ZgStBMgtCMlKMJwEz1FQNbdvNKYp69TLstT5+Hbx39QnDH3S7FA==
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 07 Jul 2026 15:44:49 +0200
Message-Id: <DJSDUBPVUJJ7.1A26I1W2L6RLH@bootlin.com>
To: <sashiko-reviews@lists.linux.dev>
Subject: Re: [PATCH bpf-next v3 04/10] bpf, x86: add helper to emit kasan
 checks in x86 JITed programs
Cc: <bpf@vger.kernel.org>
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260701-kasan-v3-0-bd09bb942d86@bootlin.com>
 <20260701-kasan-v3-4-bd09bb942d86@bootlin.com>
 <20260701101645.D14D21F000E9@smtp.kernel.org>
In-Reply-To: <20260701101645.D14D21F000E9@smtp.kernel.org>
X-Last-TLS-Session-Version: TLSv1.3

On Wed Jul 1, 2026 at 12:16 PM CEST, sashiko-bot wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Critical] emit_kasan_check() fails to save BPF_REG_AX (R10), leading t=
o memory corruption when combined with constant blinding.
> --
>
> commit 4c7e1a72bec793ca4ed19fd754408dd627715a3c
> Author: Alexis Lothor=C3=A9 (eBPF Foundation) <alexis.lothore@bootlin.com=
>
>
> bpf, x86: add helper to emit kasan checks in x86 JITed programs
>
> This patch adds emit_kasan_check() to emit KASAN shadow memory checks bef=
ore
> memory accesses in x86 JIT-compiled BPF programs. The helper saves tempor=
ary
> registers before calling the KASAN functions, but deliberately omits r10 =
and
> r11 to reduce overhead.
>
>> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
>> index 054e043ffcd22..68c5f9f94e5e2 100644
>> --- a/arch/x86/net/bpf_jit_comp.c
>> +++ b/arch/x86/net/bpf_jit_comp.c
>
> [ ... ]
>
>> @@ -1110,6 +1121,90 @@ static void maybe_emit_1mod(u8 **pprog, u32 reg, =
bool is64)
>>  	*pprog =3D prog;
>>  }
>> =20
>> +static int emit_kasan_check(struct bpf_verifier_env *env, u8 **pprog,
>> +			    u32 addr_reg, struct bpf_insn *insn, u8 *ip,
>> +			    bool is_write, bool accesses_stack_only)
>> +{
>
> [ ... ]
>
>> +	/* Save r8 */
>> +	EMIT2(0x41, 0x50);
>> +	/* Save r9 */
>> +	EMIT2(0x41, 0x51);
>> +
>
> [Severity: Critical]
> Can this lead to data corruption when BPF constant blinding is enabled?
>
> The commit message notes that r10 and r11 are skipped here to reduce
> overhead. However, when constant blinding is enabled, bpf_jit_blind_insn(=
)
> in kernel/bpf/core.c translates BPF_ST_MEM into a sequence that uses
> BPF_REG_AX (which maps to x86's r10) as the source register:
>
> kernel/bpf/core.c:bpf_jit_blind_insn() {
>         ...
>         case BPF_ST | BPF_MEM | BPF_DW:
>                 *to++ =3D BPF_ALU64_IMM(BPF_MOV, BPF_REG_AX, imm_rnd ^ fr=
om->imm);
>                 *to++ =3D BPF_ALU64_IMM(BPF_XOR, BPF_REG_AX, imm_rnd);
>                 *to++ =3D BPF_STX_MEM(from->code, from->dst_reg, BPF_REG_=
AX,
>                                     from->off);
>         ...
> }
>
> When do_jit() processes this BPF_STX_MEM, it first calls emit_kasan_check=
(),
> which invokes the C function __asan_storeX. Since __asan_storeX is a stan=
dard
> C function, it is permitted by the System V AMD64 ABI to clobber caller-s=
aved
> registers like r10.
>
> Upon returning from the KASAN check, r10 might contain garbage. Then do_j=
it()
> calls emit_stx() which will use this clobbered r10 as the data to be writ=
ten,
> potentially writing corrupted data to memory.
>
> Should BPF_REG_AX (r10) be explicitly saved and restored here to prevent =
this?
>
>> +	/* mov rdi, addr_reg */
>> +	EMIT_mov(BPF_REG_1, addr_reg);
>> +

Sashiko keeps on raising concerns on r10/r11 being possibly clobbered by
_asan functions. It has been suggested in the RFC to drop those
registers, and I have already given a few elements here ([1]) and
proposed to keep those skipped anyway. No one raised complaints about
this so far, so unless it changes, I'll keep those registers skipped.

Alexis

[1] https://lore.kernel.org/all/DJ5HDX2K5CTF.YRZ9TDI6QCII@bootlin.com/


>
> [ ... ]




--=20
Alexis Lothor=C3=A9, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

