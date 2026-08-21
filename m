Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BDDD30FF31
	for <bpf@vger.kernel.org>; Fri, 21 Aug 2026 23:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787355213; cv=none; b=bCt4HfhJg06RiiyvW2SO8a7BUpjegv8VbdLA8ibPoAqpI2jameNC5CG3c09FKtUz1kv0lPjrnIaM73fNydS7He9NtXNi+tYwqCpVJcfBd39jQH2ic99KVJtF9QVafOH/4t2o8liR8sy5ZvKzhgSOqDIQVd1/sOZS78zKbIZw3do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787355213; c=relaxed/simple;
	bh=c1umsg0dp1r1if4rMK7h9tOiO2oOokvu9tqrPGY+qtQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Zku9O/Vwufx49IAgyD5rKteAI2I98fSTWAOXzXOtcqBWvVIJQsuoUG4s9u/cBYLdHpmdbnsbItEmm40SoPPUChKVIFAckt49eEM2b6k5yYIR4/MWe2WBDMQi2oTFAXDwGWegDbqL7MfThQUlGT0S3zhO9kKB4kLx7kJ/evA0SnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GMP8o0pz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GMP8o0pz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D2201F00A3A;
	Fri, 21 Aug 2026 23:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787355212;
	bh=lKbH9ZBz5rPT/V6sSHXU4BwXbrQdGnxs4CQe24xK914=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GMP8o0pz9qqVmZdQ+MZ79eHCkz0mztgSQerZJg8q/3WJqV9SHCK/GoTTLxeAe8XEH
	 A5SGxwhGEIOVZvhtjv/Grk7r0mo2MCT7hUUGxyXXCx6Daw2XU5oK4HeXy2Iatfyw9g
	 9Ev3EzKKye5roJTwnY9IC+l5sQmFzihyZu/owgBPZMp2I+gC6OC163+P5XKF69q2Be
	 pB7wGifckihYYaqdQCd4xpastrjpGF0w97NTEd1tfuP9J9lvN1I2xT6xKW4LdB1O36
	 Lbsi8mwWvyu9o0/2A87RuR+dF7AsOAIcjJAJFgBYQRNPW51QsyPGlse6ztKnJaWVjk
	 AUEHC0UeEKYsQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v7 4/9] bpf, x86: emit KASAN checks in x86
 JITed programs
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QWxleGlzIExvdGhvcsOpIChlQlBGIEZvdW5kYXRpb24p?= <alexis.lothore@bootlin.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260822-kasan-v7-4-99afee6ef7fd@bootlin.com>
References: <20260822-kasan-v7-0-99afee6ef7fd@bootlin.com>
 <20260822-kasan-v7-4-99afee6ef7fd@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 23:33:31 +0000
Message-Id: <20260821233332.1D2201F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] `emit_kasan_check` fails to save the caller-saved register %r10 (B=
PF_REG_AX), which corrupts BPF_REG_0 and memory pointers during atomic fetc=
h operations.
--

--- Patch [4]: [PATCH bpf-next v7 4/9] bpf, x86: emit KASAN checks in x86 J=
ITed programs ---
commit 6bca50db6e9af9416363fe2e60f4e42f924950c9
Author: Alexis Lothor=C3=A9 (eBPF Foundation) <alexis.lothore@bootlin.com>

bpf, x86: emit KASAN checks in x86 JITed programs

Insert KASAN shadow memory checks before memory load and store
operations in JIT-compiled BPF programs. This helps detect memory safety
bugs such as use-after-free and out-of-bounds accesses at runtime.

> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index 13ba3232993ac..8134d028a2f2c 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c

[ ... ]

> @@ -1110,6 +1121,92 @@ static void maybe_emit_1mod(u8 **pprog, u32 reg, b=
ool is64)
>  	*pprog =3D prog;
>  }
> =20
> +static int emit_kasan_check(struct bpf_verifier_env *env, u8 **pprog,
> +			    u32 addr_reg, struct bpf_insn *insn, u8 *ip,
> +			    bool is_write)
> +{
> +#ifdef CONFIG_BPF_JIT_KASAN
> +	u32 bpf_size =3D BPF_SIZE(insn->code);
> +	s32 off =3D insn->off;
> +	u8 *prog =3D *pprog;
> +	void *kasan_func;
> +
> +	if (!env)
> +		return 0;
> +
> +	/* Derive KASAN check function from access type and size */
> +	switch (bpf_size) {
> +	case BPF_B:
> +		kasan_func =3D is_write ? __asan_store1 : __asan_load1;
> +		break;
> +	case BPF_H:
> +		kasan_func =3D is_write ? __asan_store2 : __asan_load2;
> +		break;
> +	case BPF_W:
> +		kasan_func =3D is_write ? __asan_store4 : __asan_load4;
> +		break;
> +	case BPF_DW:
> +		kasan_func =3D is_write ? __asan_store8 : __asan_load8;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	/* Save rax */
> +	EMIT1(0x50);
> +	/* Save rcx */
> +	EMIT1(0x51);
> +	/* Save rdx */
> +	EMIT1(0x52);
> +	/* Save rsi */
> +	EMIT1(0x56);
> +	/* Save rdi */
> +	EMIT1(0x57);
> +	/* Save r8 */
> +	EMIT2(0x41, 0x50);
> +	/* Save r9 */
> +	EMIT2(0x41, 0x51);
> +	/*
> +	 * SystemV ABI states that we should also save r10/r11, but in
> +	 * practice those registers are _not_ used by the limited set of
> +	 * kasan helpers we are calling here, so that's fine not to save those.
> +	 */
> +
> +	/* mov rdi, addr_reg */

[Severity: High]
Is it safe to skip saving %r10 and %r11 here?

In the x86 BPF JIT, %r10 is mapped to BPF_REG_AX. During atomic fetch
operations, BPF_REG_0 is stashed into BPF_REG_AX before calling
emit_kasan_check():

arch/x86/net/bpf_jit_comp.c:do_jit() {
    ...
    /* Will need RAX as a CMPXCHG operand so save R0 */
    emit_mov_reg(&prog, true, BPF_REG_AX, BPF_REG_0);
    if (src_reg =3D=3D BPF_REG_0)
        real_src_reg =3D BPF_REG_AX;
    if (dst_reg =3D=3D BPF_REG_0)
        real_dst_reg =3D BPF_REG_AX;

    if (!bpf_atomic_is_load_store(insn)) {
        if (!accesses_stack_only) {
            err =3D emit_kasan_check(env, &prog, real_dst_reg, insn, ip, tr=
ue);
    ...
}

Since the KASAN helpers are standard C functions, they are permitted by the
System V AMD64 ABI to clobber caller-saved registers like %r10 (especially =
if
kasan_report is called).

If %r10 is clobbered, could this corrupt the stashed BPF_REG_0 and potentia=
lly
cause a crash when real_dst_reg is used as a memory pointer in the subseque=
nt
emit_ldx() call?

arch/x86/net/bpf_jit_comp.c:do_jit() {
    ...
    /* Load old value */
    emit_ldx(&prog, BPF_SIZE(insn->code), BPF_REG_0, real_dst_reg, insn->of=
f);
    ...
    /* Restore R0 after clobbering RAX */
    emit_mov_reg(&prog, true, BPF_REG_0, BPF_REG_AX);
    ...
}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260822-kasan-v7-0=
-99afee6ef7fd@bootlin.com?part=3D4
