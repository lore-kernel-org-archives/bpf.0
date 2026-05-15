Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813DC3DF01F
	for <bpf@vger.kernel.org>; Fri, 15 May 2026 08:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778833201; cv=none; b=X0q/KYl7Mz1nwGtKqTOk55ZrjlcFvO1rukQNq+yFsTjwV5b/culIDYxQsmjRcWWKpzA5kuljdPmGb/fYbWltRxgs+3IDNf+DiPCTGyVQfRMWxJF/Gy9IDR6vmnQnXqDv9L1xMt/VSiKeASMNf3EhW7mVZdZEm+sPDqDjA68pzWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778833201; c=relaxed/simple;
	bh=ugGcMYtB0fPhdBu4UszOvZNNj6rWmerTKhti3SxAvT4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=noevF/iioT0UdJRGHAqiNS8kFI0BveJplTrYx0szIPsc9Wt3gHTqvXALN7sfZZS8CsyY91mVTsw7mV8TIPK5AbGCbveAikBfCCZsDzZDVsQg319I4dSQejvDS4aLvwg0zioRkeTQTCIATvhTuefRNmi3MbJ0nIX9GNfAulFvMpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eRjp2E0N; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eRjp2E0N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBCE2C2BCB0;
	Fri, 15 May 2026 08:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778833201;
	bh=ugGcMYtB0fPhdBu4UszOvZNNj6rWmerTKhti3SxAvT4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=eRjp2E0NkKTMLtlfQsBPGGDq7JQ/OP3TjsqMh/5c8BfNo2sszVmblcb3hu9Gu35m2
	 BhIeIEj5KSTROEpyXA+VsXSpeVyEpyzcgsvkTY1shYK2BDjbcLXGtc4KbLcyXwUGMT
	 8Nvq0P4wdQqBqG9Oc7fHNXLWPabvXXVh5Q8gHLPOeRvc/Fztj+4EbmySf7mT++HpRc
	 3aSa0hCbHRw4KLBT85/ILyftC1zViZVv1Ido00uES1VaWzeQxSKHndrPXrOi6DuVGl
	 zlu2M6BE2046nZGAph5aQv6KJ3zQyVsmo0GbjV9esrQwJ0j9fZrruuKLWfE38pCFnq
	 uBw8Y78PdZ5Dw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v4 24/25] bpf, arm64: Add JIT support for stack
 arguments
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yonghong Song" <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260513045158.2402494-1-yonghong.song@linux.dev>
References: <20260513045158.2402494-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 15 May 2026 08:20:00 +0000
Message-Id: <20260515082000.DBCE2C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] Incoming stack arguments 6-8 are mapped to caller-saved regist=
ers `x5-x7` without being spilled to the stack, allowing them to be corrupt=
ed by function calls. This bypasses verifier bounds checks and enables arbi=
trary kernel memory read/write.
--

commit 20fea8a10865fdb2efc7f0e237022c9e2e575fd7
Author: Puranjay Mohan <puranjay@kernel.org>

bpf, arm64: Add JIT support for stack arguments

Implement stack argument passing for BPF-to-BPF and kfunc calls with
more than 5 parameters on arm64, following the AAPCS64 calling
convention.

> BPF convention uses fixed offsets from BPF_REG_PARAMS (r11): off=3D-8 is
> always arg 6, off=3D-16 arg 7, etc. The verifier invalidates all outgoing
> stack arg slots after each call, so the compiler must re-store before
> every call. This means x5-x7 don't need to be saved on stack.

While it is true that the verifier invalidates outgoing stack arg slots aft=
er
each call, does this logic safely apply to incoming stack arguments?

Incoming arguments are modeled as memory accesses relative to BPF_REG_PARAMS
and the verifier assumes these memory slots are preserved across helper and
subprog calls.

Since x5-x7 are caller-saved registers per AAPCS64, what happens if a BPF
program makes a call (which clobbers x5-x7) and subsequently reads its
incoming stack arguments 6-8?

> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
> index 085e650662e3d..e3bbeaa94590c 100644
> --- a/arch/arm64/net/bpf_jit_comp.c
> +++ b/arch/arm64/net/bpf_jit_comp.c

[ ... ]

> @@ -1191,6 +1207,41 @@ static int add_exception_handler(const struct bpf_=
insn *insn,
>  	return 0;
>  }
> =20
> +static const u8 stack_arg_reg[] =3D { A64_R(5), A64_R(6), A64_R(7) };
> +
> +#define NR_STACK_ARG_REGS	ARRAY_SIZE(stack_arg_reg)
> +
> +static void emit_stack_arg_load(u8 dst, s16 bpf_off, struct jit_ctx *ctx)
> +{
> +	int idx =3D bpf_off / sizeof(u64) - 1;
> +
> +	if (idx < NR_STACK_ARG_REGS)
> +		emit(A64_MOV(1, dst, stack_arg_reg[idx]), ctx);

Could emit_stack_arg_load() read corrupted values if the BPF program reads
an incoming argument after making a helper or subprog call that clobbered
the x5-x7 registers?

If LLVM treats the incoming arguments as preserved memory and doesn't spill
them locally, a mismatch could occur where the verifier applies its bounds
tracking to the original argument but the program actually reads a clobbered
value, potentially leading to arbitrary memory reads or writes.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260513044949.2382=
019-1-yonghong.song@linux.dev?part=3D24
