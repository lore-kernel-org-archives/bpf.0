Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14995199949
	for <bpf@vger.kernel.org>; Wed,  1 Jul 2026 14:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782914792; cv=none; b=Koxc1Zsh6Wg2dL0XuxEho0nxFjmRVEOdN+iQNW1DPHUOucfL+qu9Z3PfYYPShie9RKcKthZEmJsFB6AQx9lFUB5EijjV1RBsaT+XtR4pbHJNTFx6hrbOF7CTI734Y3Q2s532mqCGHmRd1GnzFwIwNv7QCUPBTi8yKaHIrWMhZe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782914792; c=relaxed/simple;
	bh=cCjmr0zh9gWd5EB9wwdchpGkcKJ1kN2B2zGo7vAP8GY=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mWaHoDEdSHD5o7wOjP8wQAoZm/UgPKbSLmaDwC+WFPyozDrG0kejTddbX10n+qv0NjFPMeedWvtyeTrJQ80xJJgNV2rbY5qWnSGmD7wB19Ch1zftt3IgN2FBm5bYFsnjzB18XIAeC50L3AOhraQqta898piSlSpuVIoujNNgnRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mdmYsEv9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mdmYsEv9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BA6E1F000E9
	for <bpf@vger.kernel.org>; Wed,  1 Jul 2026 14:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782914790;
	bh=0tBO+3q71JwkhdL+A6vTLwyiAPllW37A9k7LIcraVUY=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=mdmYsEv9qilPR7tO24PqxevQZ5wLtRcQzg1mSinISkBxhAiP6kfY9CzeqhQMfVasK
	 IdhgCe9EA0vsLZM7MEVQTHqu/I2RVeDH9jMkacdcOH/+Y1rhYa2ZsJlQfjStvNVy9I
	 baxJpO3JAuNVd+QpF5Gsg8/I9cU/3fiyYnJxTfG6oZxEo6/Szfxo04bIb8V/3sKn/F
	 6keSNBXij5q73bgytdFj7sLRFy3zcLIUc/KODdcUaVfHLBrNkk6DWLd5E+lGP8wY3M
	 WJOPLDqmEBmPb0Axcek4LSL9pxRuPJT1LiQowiFmX/K7gtXmov3OxBhunMzyjGO/GV
	 DDzgbvjhdU0KA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 2/4] tracing/probes: Compile all fetchargs into a
 single BPF program per event
Reply-To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
In-Reply-To: <178291354144.1566898.14374948740441958770.stgit@devnote2>
References: <178291352217.1566898.14481561093843379745.stgit@devnote2>
 <178291354144.1566898.14374948740441958770.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 14:06:30 +0000
Message-Id: <20260701140630.8BA6E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [Critical] Early termination of the BPF fetch program upon a single memor=
y fault skips the processing of all subsequent probe arguments, exposing un=
initialized ring-buffer memory to userspace.
- [Critical] The generated BPF program bypasses the verifier and leaves `st=
ack_depth` as 0, causing JIT to omit stack allocation and leading to stack =
corruption during memory fetches.
- [Critical] Direct invocation of `copy_from_kernel_nofault` using `BPF_EMI=
T_CALL` violates kCFI and architecture calling conventions.
- [High] Failures from `bpf_prog_select_runtime` are silently ignored becau=
se the code checks `IS_ERR(prog)` instead of the `err` out-parameter.
- [High] Missing `refcnt` initialization of the manually allocated BPF prog=
ram leads to a permanent memory leak.
--

commit fb399d3b83423ab453a35bd3c084a85256eaf7df
Author: Masami Hiramatsu (Google) <mhiramat@kernel.org>

tracing/probes: Compile all fetchargs into a single BPF program per event

This commit compiles trace probe arguments into a single BPF program to
reduce prologue and dispatching overhead. It supports basic BPF-compatible
arguments and falls back to the interpreter loop if non-BPF operations
are required.

> diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
> index 18c2121223440..0deb53c22ae39 100644
> --- a/kernel/trace/trace_probe.c
> +++ b/kernel/trace/trace_probe.c
[ ... ]
> +static void trace_probe_compile_bpf(struct trace_probe *tp)
> +{
[ ... ]
> +			case FETCH_OP_DEREF:
> +				/* Add offset: R3 =3D R0 + code->offset (src) */
> +				insns[i++] =3D BPF_MOV64_REG(BPF_REG_2, BPF_REG_0);
> +				if (code->offset)
> +					insns[i++] =3D BPF_ALU64_IMM(BPF_ADD, BPF_REG_2,
> +								   code->offset);
> +				/* R1 =3D dst (R10 - 8 on stack) */
> +				insns[i++] =3D BPF_MOV64_REG(BPF_REG_1, BPF_REG_10);
> +				insns[i++] =3D BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -8);

[Severity: Critical]
Does this stack access corrupt the caller's stack frame?

Since this manually constructed BPF program bypasses the verifier,
prog->aux->stack_depth remains 0. Because the stack depth is 0, the JIT
compiler will not allocate a stack frame for the program. When the program
writes to R10 - 8, it might overwrite the caller's stack frame or
callee-saved registers, potentially leading to kernel panics.

> +				/* R3 =3D size */
> +				insns[i++] =3D BPF_MOV64_IMM(BPF_REG_3, sizeof(unsigned long));
> +				/* Call copy_from_kernel_nofault(dst, src, size) */
> +				insns[i++] =3D BPF_EMIT_CALL(copy_from_kernel_nofault);

[Severity: Critical]
Can this direct call to copy_from_kernel_nofault trigger a kCFI panic?

copy_from_kernel_nofault is a standard C function with a 3-argument
signature, but BPF_EMIT_CALL executes a BPF helper call which expects
to pass 5 arguments in 64-bit BPF registers. Under Control Flow Integrity,
invoking this through the interpreter's 5-argument function pointer might
cause a signature mismatch and panic the kernel. It could also break the
standard calling convention on 32-bit architectures.

> +				/* if (R0 < 0) return R0; */
> +				insns[i++] =3D BPF_JMP_IMM(BPF_JSGE, BPF_REG_0, 0, 1);
> +				insns[i++] =3D BPF_EXIT_INSN();

[Severity: Critical]
If a memory fault occurs here and the program exits early, does it leave the
remaining trace event ring buffer fields uninitialized?

Since trace_event_buffer_reserve() leaves the ring buffer uninitialized,
terminating the BPF program immediately on a single fault without zeroing
the current field or processing subsequent arguments might expose stale
kernel memory from the stack or heap to userspace when the buffer is
subsequently committed.

> +				/* R0 =3D *(unsigned long *)(R10 - 8) */
> +				insns[i++] =3D BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_10, -8);
> +				break;
[ ... ]
> +	/* Epilogue: return R9 (0) */
> +	insns[i++] =3D BPF_MOV64_REG(BPF_REG_0, BPF_REG_9);
> +	insns[i++] =3D BPF_EXIT_INSN();
> +
> +	prog =3D bpf_prog_alloc(bpf_prog_size(i), 0);
> +	if (!prog)
> +		goto out;

[Severity: High]
Is a prog->aux->refcnt initialization needed here?

bpf_prog_alloc() zero-initializes the bpf_prog_aux structure, leaving
refcnt as 0. When bpf_prog_put() is later called during cleanup,
atomic64_dec_and_test(0) will evaluate to false, which causes the
program memory to never be freed.

> +
> +	prog->len =3D i;
> +	memcpy(prog->insnsi, insns, prog->len * sizeof(struct bpf_insn));
> +	prog->type =3D BPF_PROG_TYPE_KPROBE;
> +
> +	prog =3D bpf_prog_select_runtime(prog, &err);
> +	if (IS_ERR(prog))
> +		goto out;
> +	tp->prog =3D prog;

[Severity: High]
Does this error check properly handle failures from bpf_prog_select_runtime?

bpf_prog_select_runtime() does not return ERR_PTR on failure; instead, it
returns the program pointer and sets the out-parameter err to a negative
error code. Checking IS_ERR(prog) evaluates to false, which might cause
the error to be ignored. If JIT compilation fails and the interpreter is
unavailable, this leaves prog->bpf_func as NULL, leading to a NULL pointer
dereference later.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/178291352217.156689=
8.14481561093843379745.stgit@devnote2?part=3D2
