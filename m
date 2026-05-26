Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B09A2030A
	for <bpf@vger.kernel.org>; Tue, 26 May 2026 19:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779825010; cv=none; b=L3m/zNr48YbjJPFYBucK76HdUee6ztjzYbYFk70/a0atH+3jSVrFwE72GQIxwkCz4krCI++CxSxwjfdZTz2w51K7vG6zVX/I6b47UJtue0WaRDZHdMd1dtGwz0vsYEybvRdpdegT2fvQp/bW0Wi2qHjyt/e2vmbH4YswyQ9jErc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779825010; c=relaxed/simple;
	bh=mmumirwXfPa92CKEBHQ/CkVbab2Pb9bhy5A1vIGGReE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=a3lFFvuZRX+KV3Bvb331V0MzjPXMqUJDEAZfZ9pxRMhCUex0x48yHDwn7yuPfGXUtav7ywQpoETrh5VBm9jbYdpZ/xYBT8xBP5IIJjHsOVIJqZbC+1fcB6HKyrROqEdYtxelL0U59iix2VTV8ivvUcZm9aoysUvtsh3ai8I5DcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OtPDHnao; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OtPDHnao"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 897721F000E9;
	Tue, 26 May 2026 19:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779825008;
	bh=YCLAN1e/Z0Cth1ihJ/aZrXH12/le8O5IvOjZdzavz/M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OtPDHnaoyi+Vo8FI4cmIRxeF+FocA/j59gVkg5PhI6zPZyGe2w0UL9pFH9mCRcvqu
	 3wBY2mhwf7KW/R6+JWrAZrKmtT8OpddQPKX1P1YG3/oQOp+OMtut4AB7PKpW5giNHM
	 5t5x7xUEMfw0BsihAzFjp5sp7wmrlIFIDdd4ykUlzFr62MeibrB2dbeyyYxiYDTc5p
	 hQYkT9Wh3Ahr3Qd8SFwMcMX4VJaY+cctHceqC8yxl2PLvHngu2B2FVB8WH7sAtOoQT
	 cWXCw/sT6pb3+3J5BaesDDyv6oQNiVjb57ZNGVVMxNutcvYAVvXB99iI2QSGvHJU6n
	 8b3EiBhLAOkWQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.12] x86/fgraph: Fix return_to_handler regs.rsp value
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gyokhan Kochmarla" <gyokhan@amazon.de>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260526192324.79459-1-gyokhan@amazon.de>
References: <20260526192324.79459-1-gyokhan@amazon.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 26 May 2026 19:50:07 +0000
Message-Id: <20260526195008.897721F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The `return_to_handler` assembly routine creates a `pt_regs` (or `=
ftrace_regs`) structure on the kernel stack but only initializes four regis=
ters (`rax`, `rdx`, `rbp`, `rsp`), leaving the rest of the structure uninit=
ialized. This partially initialized structure is passed to BPF kretprobe pr=
ograms, leading to an information leak of kernel stack memory.
--

commit ff6f1024b92860971d84c833c6dac53501145715
Author: Jiri Olsa <jolsa@kernel.org>

x86/fgraph: Fix return_to_handler regs.rsp value

This commit fixes the unwinding rsp register value in return_to_handler. It=
=20
saves the original rsp before the FRAME_SIZE adjustment, replacing the=20
previous incorrect value. This ensures fprobe and direct unwinders see the=
=20
right stack pointer.

Link: https://lore.kernel.org/bpf/20260126211837.472802-2-jolsa@kernel.org

> diff --git a/arch/x86/kernel/ftrace_64.S b/arch/x86/kernel/ftrace_64.S
> --- a/arch/x86/kernel/ftrace_64.S
> +++ b/arch/x86/kernel/ftrace_64.S
> @@ -364,6 +364,9 @@ SYM_CODE_START(return_to_handler)
>  	UNWIND_HINT_UNDEFINED
>  	ANNOTATE_NOENDBR
> =20
> +	/* Store original rsp for pt_regs.sp value. */
> +	movq %rsp, %rdi
> +
>  	/* Restore return_to_handler value that got eaten by previous ret instr=
uction. */
>  	subq $8, %rsp
>  	UNWIND_HINT_FUNC
> @@ -374,7 +377,7 @@ SYM_CODE_START(return_to_handler)
>  	movq %rax, RAX(%rsp)
>  	movq %rdx, RDX(%rsp)
>  	movq %rbp, RBP(%rsp)
> -	movq %rsp, RSP(%rsp)
> +	movq %rdi, RSP(%rsp)

[Severity: High]
This is a pre-existing issue, but could this code leak kernel stack memory
to BPF programs?

This assembly creates a pt_regs structure on the stack by allocating
FRAME_SIZE bytes, but only explicitly saves rax, rdx, rbp, and rsp. Later in
ftrace_return_to_handler and arch_ftrace_partial_regs, only a few additional
fields are populated.

The remaining fields (like rdi, rsi, rbx, and r12-r15) remain uninitialized.

Because this partially initialized pt_regs structure is passed to BPF
kprobe_multi return programs via kprobe_multi_link_exit_handler(), and the
BPF verifier allows reading any field of the pt_regs context, does this
allow BPF programs to extract residual kernel stack data?

>  	movq %rsp, %rdi
> =20
>  	call ftrace_return_to_handler

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260526192324.7945=
9-1-gyokhan@amazon.de?part=3D1
