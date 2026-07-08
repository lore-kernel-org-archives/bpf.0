Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3524F401493
	for <bpf@vger.kernel.org>; Wed,  8 Jul 2026 08:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783498762; cv=none; b=BcA8UBeOIculuItimlSfgXNhZ+h81c0B/i/FkreweTtCaOLRqstqLvdYOk+wdy1LeXAvPVyN9DLntXpPBAeen/6k2pWo2FUrlynR6FGJyLKROz5S40LG6LxVEx0gNboFTztDbxRrhTg4w5beQ5ve+jp6bgKm3ygu/3aeBF7cim4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783498762; c=relaxed/simple;
	bh=KBkLVO2Da1lZk947kd5GYtx9qxSSu5cql3wQ3sO+1mY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QQpLW1xN3IjIELvN+dnm5cLLGdb2cEp5eTmp9WE53SQdwcjn7T0N2Aw/cyOaeBOaOcHgPJgOg/SL2o/1qPub4wRt9ZVAUdl74BbYKI+SqH16IeLmCpLRN+t+xplCICagIXkcesm4wiTgpXp5mjvSxPXWYGhAidSI5tCbgOO4Y4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UaWfrX24; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UaWfrX24"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 629921F000E9;
	Wed,  8 Jul 2026 08:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783498760;
	bh=38zdpJRefunH40n68pUVvidYjZhB1vgAZwn0eYaYOVs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UaWfrX2489+FLRm2eFovTW1J6puXBV/AZNCBRXIXBQwXa7OqMSdTmRQXgluFlJd1u
	 JHHJmYeP91jn4ddTDN04YifNgolbkEKVQEbH5I+mJREPZJXnTpVqvkOaCCrtHaCvxg
	 uaPh46pLD/JuzK9nX0ImeF6wdhfucKaTGuQIVUZsASslvGzNR8CFi2CbEJtIPMKose
	 eezUdfCuWjd0mOrkcosYQSBUZSiIB4C3GPffnxiYwarPMp8ky5sxgaOU0NzzN0poF8
	 v38hXyOzNR/ZGQySEaydfOxRF0mgXuq+hpQ0vG3meW0X+6/4W9SJz0yN9X2nj+obJM
	 c4SoOj2YJ/8TA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v4 07/10] bpf, x86: enable KASAN for JITed
 programs on x86
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QWxleGlzIExvdGhvcsOpIChlQlBGIEZvdW5kYXRpb24p?= <alexis.lothore@bootlin.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260708-kasan-v4-7-d5c177ab8227@bootlin.com>
References: <20260708-kasan-v4-0-d5c177ab8227@bootlin.com>
 <20260708-kasan-v4-7-d5c177ab8227@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 08:19:20 +0000
Message-Id: <20260708081920.629921F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] The KASAN check emitted by the x86 BPF JIT clobbers the caller=
-saved registers r10 (BPF_REG_AX) and r11 (AUX_REG), leading to memory corr=
uption.
--

--- Patch [7]: [PATCH bpf-next v4 07/10] bpf, x86: enable KASAN for JITed p=
rograms on x86 ---
commit 4ee1a38a02c8227bc35c998032951cf3c95c2d7d
Author: Alexis Lothor=C3=A9 (eBPF Foundation) <alexis.lothore@bootlin.com>

bpf, x86: enable KASAN for JITed programs on x86

Mark x86 as supporting KASAN checks in JITed programs so that the
corresponding JIT compiler inserts checks on the translated
instructions.

> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index bdad90f210e4b..705a9ab85f3a9 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -233,6 +233,7 @@ config X86
>  	select HAVE_SAMPLE_FTRACE_DIRECT	if X86_64
>  	select HAVE_SAMPLE_FTRACE_DIRECT_MULTI	if X86_64
>  	select HAVE_EBPF_JIT
> +	select HAVE_EBPF_JIT_KASAN		if X86_64
[Severity: Critical]
Does enabling this feature introduce memory corruption by exposing a bug in
emit_kasan_check()?

Looking at arch/x86/net/bpf_jit_comp.c:emit_kasan_check(), caller-saved
registers (rax through r9) are pushed, but r10 (BPF_REG_AX) and r11 (AUX_RE=
G)
are explicitly missing. This exposes them to clobbering by the KASAN C
function call:

arch/x86/net/bpf_jit_comp.c:emit_kasan_check() {
    ...
	/* Save r8 */
	EMIT2(0x41, 0x50);
	/* Save r9 */
	EMIT2(0x41, 0x51);

	/* mov rdi, addr_reg */
    ...
}

For BPF_STX, if constant blinding is used, src_reg is BPF_REG_AX (r10).
The value in src_reg is corrupted by emit_kasan_check() before it is stored
by emit_stx():

arch/x86/net/bpf_jit_comp.c:do_jit() {
    ...
			err =3D emit_kasan_check(env, &prog, dst_reg, insn, ip,
					       true, accesses_stack_only);
			if (err)
				return err;
			emit_stx(&prog, BPF_SIZE(insn->code), dst_reg, src_reg, insn_off);
    ...
}

Additionally, in atomic fetch operations, BPF_REG_0 is moved into BPF_REG_A=
X.
The pointer (real_dst_reg) might become BPF_REG_AX, which is passed to
emit_kasan_check() and then used afterwards, resulting in using a corrupted
pointer:

arch/x86/net/bpf_jit_comp.c:do_jit() {
    ...
				/* Will need RAX as a CMPXCHG operand so save R0 */
				emit_mov_reg(&prog, true, BPF_REG_AX, BPF_REG_0);
				if (src_reg =3D=3D BPF_REG_0)
					real_src_reg =3D BPF_REG_AX;
				if (dst_reg =3D=3D BPF_REG_0)
					real_dst_reg =3D BPF_REG_AX;

				ip +=3D 3;
			}
			if (!bpf_atomic_is_load_store(insn)) {
				err =3D emit_kasan_check(env, &prog, real_dst_reg,
						       insn, ip, false,
						       accesses_stack_only);
    ...
}

Unprivileged users loading BPF programs with constant blinding might trigger
arbitrary memory reads or writes due to this clobbering.

>  	select HAVE_EFFICIENT_UNALIGNED_ACCESS
>  	select HAVE_EISA			if X86_32
>  	select HAVE_EXIT_THREAD

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708-kasan-v4-0=
-d5c177ab8227@bootlin.com?part=3D7
