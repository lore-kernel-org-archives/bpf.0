Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9389175A6E
	for <bpf@vger.kernel.org>; Sat, 25 Apr 2026 05:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777095966; cv=none; b=tzoLfhP4s6/qIuceZk00EOZ6m9AMqaFOdghFr6pGH5uL9Hsk6U0I6vg2hPi68c1F01K5vS4pAZ2I/Kzci6QpJGG0xqmUjfSgWHHrWOvptM9BYTLS8I/CZ6zZZ47O3oF6r82hZuoHIQDYJgwhMe89/7XDUbnXUDSllvIG5g7dnqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777095966; c=relaxed/simple;
	bh=0BPz1YIioCTa5mlcm8TVHaMc/3dQpSU2xqjsd9glJIY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Na6/aWqFTQfXvT/gr0tz88eoDbSgGNcm8x2ZGvbIl8fl75KGTrXuJH0IeeW3DZZnk5rdsqfrLw7gYibYnrN2fdvyoO+sP7hv8jOlZcOoyPlQO6jmqy/2jw5kFGmtMHSsNJN9pJAdsf5v1ufEVyErGSy07F4C+ZVG7pXiS586f3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dhyX0wRV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dhyX0wRV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 612E9C2BCB0;
	Sat, 25 Apr 2026 05:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777095966;
	bh=0BPz1YIioCTa5mlcm8TVHaMc/3dQpSU2xqjsd9glJIY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=dhyX0wRVEpaRPEWfOh9QdQ4NT79xrXOad+4feUXxkKimI4OUU2KWlX3z3eIsUSQ4L
	 34Oy/kApUXNAnRRIRpNbAgQkuWnOpp/fFa6UGJb+TIY59al70+tYysMpfAcoG+ApmN
	 WKJVmuTBl660PDxNHPYmLcv2eMNAsAc9h4AXdkx5mV1Tt0vrPLGm4XgCvc3S315RkD
	 2zCEXN7BRuAR+pMGPxmjjj78B/i6stH6R9XtJbDSiAWCb+D1eZYWkdk5NbsieFUY8D
	 yoHizCFNetcqtXwazsSkqcSn9YbiFwfRu1SpZvb8eWQZ8WrS7ExQ6vBBoGVE6neGM4
	 JYc2ZJL9W1ttQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC bpf-next 4/8] bpf, x86: add helper to emit kasan
 checks in x86 JITed programs
Reply-To: sashiko@lists.linux.dev
To: =?utf-8?b?QWxleGlzIExvdGhvcsOpIChlQlBGIEZvdW5kYXRpb24p?= <alexis.lothore@bootlin.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260413-kasan-v1-4-1a5831230821@bootlin.com>
References: <20260413-kasan-v1-4-1a5831230821@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Apr 2026 05:46:05 +0000
Message-Id: <20260425054606.612E9C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 3 potential issue(s):
- [High] Missing call depth accounting for Retbleed mitigations leads to ca=
ll depth counter underflow.
- [Medium] BPF_ST instructions are incorrectly classified as memory reads i=
nstead of writes.
- [Low] Flawed stack realignment logic wastes stack space.
--

commit d2f06b6218cd74384e59faf159117526fab479e6
Author: Alexis Lothor=C3=A9 (eBPF Foundation) <alexis.lothore@bootlin.com>

bpf, x86: add helper to emit kasan checks in x86 JITed programs

This commit adds emit_kasan_check() to emit KASAN shadow memory checks
before memory accesses in x86 JIT-compiled BPF programs. It saves registers,
computes the accessed address, calls the relevant KASAN load/store function,
and restores the registers.

> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index ea9e707e8abff..b90103bd00809 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c

[ ... ]

> @@ -1301,6 +1305,95 @@ static void emit_store_stack_imm64(u8 **pprog, int=
 reg, int stack_off, u64 imm64
>  	emit_stx(pprog, BPF_DW, BPF_REG_FP, reg, stack_off);
>  }
> =20
> +static int emit_kasan_check(u8 **pprog, u32 addr_reg, struct bpf_insn *i=
nsn,
> +			    u8 *ip, bool accesses_stack)
> +{
> +#ifdef CONFIG_BPF_JIT_KASAN
> +	bool is_write =3D BPF_CLASS(insn->code) =3D=3D BPF_STX;

Does this code incorrectly classify BPF_ST instructions as memory reads?

The BPF instruction set includes the BPF_ST class for storing immediate
values into memory. Because BPF_CLASS(insn->code) for BPF_ST evaluates to
0x02, the is_write condition evaluates to false. This causes the helper to
inject KASAN load checks instead of store checks, leading to inaccurate
error reporting.

> +	u32 bpf_size =3D BPF_SIZE(insn->code);
> +	s32 off =3D insn->off;
> +	u8 *prog =3D *pprog;
> +	void *kasan_func;
> +
> +	if (accesses_stack)
> +		return 0;
> +
> +	/* Derive KASAN check function from access type and size */
> +	switch (bpf_size) {

[ ... ]

> +	/* Save r10 */
> +	EMIT2(0x41, 0x52);
> +	/* Save r11 */
> +	EMIT2(0x41, 0x53);
> +	/* We have pushed 72 bytes, realign stack to 16 bytes: sub rsp, 8 */
> +	EMIT4(0x48, 0x83, 0xEC, 8);

Is this stack realignment logic correct?

The x86 BPF JIT prologue pushes a variable number of callee-saved registers
and subtracts an 8-byte aligned stack_depth, meaning the stack pointer can
be 8-byte misaligned prior to the check. If the stack is initially 8-byte
misaligned, pushing 72 bytes and subtracting 8 preserves the 8-byte
misalignment. Because the Linux kernel is compiled with 8-byte stack
alignment, the sub rsp, 8 instruction seems unnecessary and wastes 8 bytes
of stack space.

> +
> +	/* mov rdi, addr_reg */
> +	EMIT_mov(BPF_REG_1, addr_reg);
> +
> +	/* add rdi, off (if offset is non-zero) */
> +	if (off) {

[ ... ]

> +	/* Adjust ip to account for the instrumentation generated so far */
> +	ip +=3D (prog - *pprog);
> +	/* call kasan_func */
> +	if (emit_call(&prog, kasan_func, ip))
> +		return -ERANGE;

Does this call need call depth accounting for Retbleed mitigations?

When CONFIG_CALL_DEPTH_TRACKING is enabled, every call instruction executed
in the kernel must be properly accounted for to increment the call depth
counter. Other dynamically emitted calls in the BPF JIT explicitly emit
this tracking via x86_call_depth_emit_accounting() prior to emitting the
actual call.

By omitting this accounting, the call to the KASAN function will not
increment the call depth counter. When the KASAN function returns, its
return thunk will decrement the counter, causing it to underflow. This
causes the return thunks to assume the Return Stack Buffer is empty and
trigger expensive RSB stuffing on subsequent returns.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260413-kasan-v1-0=
-1a5831230821@bootlin.com?part=3D4
