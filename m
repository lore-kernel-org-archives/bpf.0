Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C037D1F3B85
	for <bpf@vger.kernel.org>; Wed, 29 Apr 2026 21:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777499986; cv=none; b=qG7e5qVe2rCtGCGJ1ALY7U3mLiCRlHnwrSKHjxU26GOOjD8iWEdM5dTlhx+tyC4nWsCdLncNHHZjKS7ltVK7IWSw4FQPjEfv7sa+yjKploLvjJfnbOADkPaqFe6LfdTBYskbJ+iMQogdF8/IO6tMFF3AFWI1YW4MjM5aIKXLw/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777499986; c=relaxed/simple;
	bh=BORUCfMcLwQFjc0MMtWSijymVIr2LiRqqs8Jf4GbivM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=ejzsE0ixPULFVlyiudb4whj4k8D9u1tdUhfaoyd3IB/YTkCMBnnBt3PTNDyBufvYcPMzYN3ay7Q767SwZpP9hQm2qmPOJf+6Y5fbPwQbdVUgLJ9ok7C/YS4jceyMg5WSWgNck2O3jRyNETO7WBF+/Rmps1Sn1uqoM7oH5QJDvrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=zYM1R7x9; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="zYM1R7x9"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 345A21A3463
	for <bpf@vger.kernel.org>; Wed, 29 Apr 2026 21:59:42 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 065E95FD43;
	Wed, 29 Apr 2026 21:59:42 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 39CA01072B29B;
	Wed, 29 Apr 2026 23:59:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1777499981; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=17Ieqez20ddO86cLwBFV5a8flr66siV3U2xPZKWlp+o=;
	b=zYM1R7x9u4BLYQE5+g+7evwKDjVzryGFfpudLNzIwU/4FBVrv4HBp0wUmykVMa4OWC6ARm
	D24/8TIEms88f7xDjNyamTHAVDKoXBV7QKomJNwRPGx6sxxbU9SeaP0w5ESn2mBwSnoCZC
	S+Qg6hxGaeHqVV8RCXRaB53Ii/I+ceW4QqThCNuu0bZDIy1YHhDropUcPM+xtXPvSdTnha
	YQtpW2v1xLCZRLDMd8POwiFxjh5nuBCkt/kM1ZHrSmczcD2lK1yGPV4XARTjQU39zHESqB
	DLfIlcqoTWVDrdVpGIsZd3F0SWw7VPjKvlUVMUpdRuhj79xT11n2yDV6x1oaBg==
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 29 Apr 2026 23:59:40 +0200
Message-Id: <DI5Z5M5V99JY.3JRWFJY5MLVZS@bootlin.com>
Subject: Re: [PATCH RFC bpf-next 5/8] bpf, x86: emit KASAN checks into x86
 JITed programs
Cc: <bpf@vger.kernel.org>
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
To: <sashiko@lists.linux.dev>,
 =?utf-8?b?QWxleGlzIExvdGhvcsOpIChlQlBGIEZvdW5kYXRpb24p?=
 <alexis.lothore@bootlin.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260413-kasan-v1-5-1a5831230821@bootlin.com>
 <20260425060828.1DAF8C2BCB0@smtp.kernel.org>
In-Reply-To: <20260425060828.1DAF8C2BCB0@smtp.kernel.org>
X-Last-TLS-Session-Version: TLSv1.3

On Sat Apr 25, 2026 at 8:08 AM CEST, sashiko-bot wrote:
> Sashiko AI review found 3 potential issue(s):
> - [High] Missing KASAN instrumentation for immediate-based memory stores =
(BPF_ST | BPF_MEM) and incorrect write detection.
> - [High] Missing KASAN instrumentation for standard atomic memory operati=
ons (BPF_STX | BPF_ATOMIC).
> - [High] Incorrect IP calculation in emit_kasan_check() leads to wrong ju=
mp offsets and kernel crashes when IBT is enabled.
> --
>
> commit bdea14177f5d099598de93e92ea9aecf3714ba64
> Author: Alexis Lothor=C3=A9 (eBPF Foundation) <alexis.lothore@bootlin.com=
>
>
> bpf, x86: emit KASAN checks into x86 JITed programs
>
> This commit inserts KASAN shadow memory checks before load and store
> operations in JIT-compiled BPF programs. It aims to detect memory safety =
bugs
> while explicitly skipping stack accesses and faulting PROBE instructions.
>
>> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
>> index b90103bd00809..111fe1d551219 100644
>> --- a/arch/x86/net/bpf_jit_comp.c
>> +++ b/arch/x86/net/bpf_jit_comp.c
> [ ... ]
>> @@ -2242,6 +2244,11 @@ st:			if (is_imm8(insn->off))
>>  		case BPF_STX | BPF_MEM | BPF_H:
>>  		case BPF_STX | BPF_MEM | BPF_W:
>>  		case BPF_STX | BPF_MEM | BPF_DW:
>> +			err =3D emit_kasan_check(&prog, dst_reg, insn,
>> +					       image + addrs[i - 1],
>> +					       accesses_stack);
>> +			if (err)
>> +				return err;
>>  			emit_stx(&prog, BPF_SIZE(insn->code), dst_reg, src_reg, insn->off);
>>  			break;
>
> Is the correct instruction pointer being passed to emit_kasan_check() her=
e?
>
> Earlier in do_jit(), the local ip variable is updated to account for
> conditionally emitted prefixes:
>
>     if (bpf_insn_is_indirect_target(env, bpf_prog, i - 1))
>         EMIT_ENDBR();
>
>     ip =3D image + addrs[i - 1] + (prog - temp);
>
> Passing image + addrs[i - 1] directly ignores the size of the ENDBR prefi=
x.
> Could this cause the relative jump offset in emit_call() to be off by 4
> bytes, leading to a kernel crash when branching to the KASAN function?

I have CONFIG_X86_KERNEL_IBT=3Dy in my testing kernel, so if that's indeed
a valid scenario, I may have been lucky (or rather, unlucky) to not see the
corresponding crash while running the full selftests set. I'll dig into
that.

> Additionally, looking at the code surrounding this hunk:
>
>         /* ST: *(u8*)(dst_reg + off) =3D imm */
>     case BPF_ST | BPF_MEM | BPF_B:
>         if (is_ereg(dst_reg))
>             EMIT2(0x41, 0xC6);
>         else
>             EMIT1(0xC6);
>         goto st;
> [ ... ]
>     case BPF_ST | BPF_MEM | BPF_DW:
>         EMIT2(add_1mod(0x48, dst_reg), 0xC7);
>
> st:     if (is_imm8(insn->off))
>             EMIT2(add_1reg(0x40, dst_reg), insn->off);
>         else
>             EMIT1_off32(add_1reg(0x80, dst_reg), insn->off);
>
>         EMIT(imm32, bpf_size_to_x86_bytes(BPF_SIZE(insn->code)));
>         break;
>
> Are immediate-based memory stores (BPF_ST | BPF_MEM) meant to be skipped?

As mentioned in the previous comments, BPF_ST/BPF_LD are indeed meant to
be skipped.

> Unlike BPF_STX, there is no emit_kasan_check() added here, which seems to
> allow uninstrumented writes to kernel memory.
>
> If instrumentation is added here, there might be a second issue. Looking =
at
> the helper:
>
> static int emit_kasan_check(..., struct bpf_insn *insn, ...)
> {
>     bool is_write =3D BPF_CLASS(insn->code) =3D=3D BPF_STX;
>     ...
> }
>
> Since BPF_ST has a different class, would this evaluate to false and
> incorrectly emit a read check instead of a write check?
>
> [ ... ]
>> @@ -2390,6 +2397,12 @@ st:			if (is_imm8(insn->off))
>>  				/* populate jmp_offset for JAE above to jump to start_of_ldx */
>>  				start_of_ldx =3D prog;
>>  				end_of_jmp[-1] =3D start_of_ldx - end_of_jmp;
>> +			} else {
>> +				err =3D emit_kasan_check(&prog, src_reg, insn,
>> +						       image + addrs[i - 1],
>> +						       accesses_stack);
>> +				if (err)
>> +					return err;
>>  			}
>>  			if (BPF_MODE(insn->code) =3D=3D BPF_PROBE_MEMSX ||
>>  			    BPF_MODE(insn->code) =3D=3D BPF_MEMSX)
>
> Further down in the function, atomic operations are handled:
>
>     case BPF_STX | BPF_ATOMIC | BPF_W:
>     case BPF_STX | BPF_ATOMIC | BPF_DW:
>         if (insn->imm =3D=3D (BPF_AND | BPF_FETCH) ||
>             insn->imm =3D=3D (BPF_OR | BPF_FETCH) ||
>             insn->imm =3D=3D (BPF_XOR | BPF_FETCH)) {
>             bool is64 =3D BPF_SIZE(insn->code) =3D=3D BPF_DW;
>
> Should standard atomic memory operations be instrumented as well?
>
> While the commit message notes that BPF_PROBE_ATOMIC instructions are ski=
pped
> because they handle faults, standard BPF_STX | BPF_ATOMIC operations perf=
orm
> memory modifications without fault-handling semantics.
>
> Since emit_kasan_check() is omitted here, could an invalid base pointer u=
sed
> in an atomic operation bypass KASAN and corrupt memory?

Atomics were skipped for the RFC, but that's a point I want to tackle
in the next revision.

--=20
Alexis Lothor=C3=A9, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

