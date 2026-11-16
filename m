Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794845170;
	b=pa985RwnrI2IHhBt74E5DxIjRknYbrgcjXXV8J8DWczzrR1e2zrbMcI5T4BVeUAjEmMo
	 BDQ71S+4Ko26xcxxCsSdgsk3gbIJYbbDKGTG2kvco4r9zIwvF/i15oztY1kqdUF8loMC1
	 Tic2MhNp33u/p3xFXxoB+9jxn2dcmD4lrkYihKKDb1RODm36sFWqgpFzfCvaOnWUwrsWU
	 3LLIKrxNYXOFgNpganEGjTwg4K0cA9X6RY0cfgV2mWeWaAYdybc4uAZuYg+6tLYpYRx41
	 xNV1DiZ2Zt6StezBA31WQbO6rQ9/waDt6aL6z9bDECsUasrUnr6ScBYqHDutWo/sTxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794845170;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=9itPIg7aJEfo+/aaxRkBMiuTQZCc7PZsW/M/SCKETAY=;
	b=JvCA98NaABKHLIMaF+Dd1fqwqvO/3QQMR5zqcdFVgeP9fM8bjufgZg8O0BE9nMlxCe/J
	 /9npdObV9xlnQGLGDsKyiUN8AJg6Czi+TGJiExVSFN5iZsYRL8486uuxLjBfxYhYRmWG+
	 GLuzty8FRZUS29Ln8azcWTbrxax1RUv28ul4Fyuc5H81S8w9CL0zkNE/TdNEC082onlUS
	 XFRyKWRnNkky13L915m7V/HbPp13i/tP+HgRgbcGOm73xqUQFVCczC7xo6x5YwGr5ORkV
	 Hj1rv9g7I513e4kd04OMzpM1ITPHWit93ZlBqFb6X34+32qa09rDOYdyCI6FQKcXflw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Yvy9v6Cy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8910E606A31C
	for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 16:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Yvy9v6Cy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B59B1F000C4;
	Mon, 16 Nov 2026 16:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794845170;
	bh=9itPIg7aJEfo+/aaxRkBMiuTQZCc7PZsW/M/SCKETAY=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Yvy9v6CyWi+quGbkRWwb3Q4WjdquKIwdjv+itCs+WApdwwCA5BkKHFNkWwGw7ZkNH
	 dNhCgIVHhuYHy9IRDOZgZ9reX63DK3rnI7BJMC9r8XLq6BVisiJqduqt35ZNMDqPZ5
	 AsIU2oweyeT87fyB+51YQRNzDl81KB22XTnNC7E8z0gw88dUOVdU7EmJs/34R47Xtk
	 jpRokAjfeUxuKnWKKvifrX4vkG5uLDVa7duE+W4sBlSOFCgQDrK01MlrgrD+kLSTbX
	 +JmZSVMUV6lId7vgIt6tXFa9jwoaVJ9PHGjjdmsmcbTTF4zOxjC/z6HZtgfUkwCGYY
	 CCZcAe8Z+yN5A==
Content-Type: multipart/mixed; boundary="===============1789226211521666341=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <cea1af8c2203f4961d936b0e8050c8fcf6a154ba6419c75b314f0a9eaf727461@mail.kernel.org>
In-Reply-To: <20261116152626.4032587-12-alexei.starovoitov@gmail.com>
References: <20261116152626.4032587-12-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next v2 11/21] libbpf: Size the tables of the loader program from the object
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon, 16 Nov 2026 16:06:09 +0000 (UTC)

--===============1789226211521666341==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> libbpf: Size the tables of the loader program from the object

TL;DR: Larger per-program code in the generated loader may push branch offsets
past 16 bits, so gotol is emitted; kernels older than v6.4 reject it, so
previously loadable light skeletons may now fail to load there.

> gen_loader mirrors limits of the kernel: 64 maps, 32 programs and 256
> kfuncs. The numbers are known before the loader is made.
>
>   fd_array:  [ maps | copies of maps | unused | BTFs of kfuncs ]
>   prog_fds:  [ programs ]              was on the stack of the loader
>
> Use gotol and a register for ctx when an offset needs more than 16 bits.
> That was an error, so loaders that could be made do not get gotol.

Is that last sentence accurate for loaders close to the old 16-bit limit?

The prog fd slots moved from the stack into the blob, which makes the
cleanup block and the per-program fd store longer.  Every backward branch
to cleanup_label from emit_check_err() has to cross that code.

> diff --git a/tools/lib/bpf/gen_loader.c b/tools/lib/bpf/gen_loader.c
> --- a/tools/lib/bpf/gen_loader.c
> +++ b/tools/lib/bpf/gen_loader.c

[ ... ]

> @@ -139,27 +141,24 @@ void bpf_gen__init(struct bpf_gen *gen, int log_level, int nr_progs, int nr_maps
> [ ... ]
>  	for (i = 0; i < stack_sz; i += 4) {
>  		emit(gen, BPF_LDX_MEM(BPF_W, BPF_REG_1, BPF_REG_10, -stack_sz + i));
>  		emit(gen, BPF_JMP_IMM(BPF_JSLE, BPF_REG_1, 0, 1));
>  		emit(gen, BPF_EMIT_CALL(BPF_FUNC_sys_close));
>  	}
> +	for (i = 0; i < nr_progs; i++)
> +		emit_sys_close_blob(gen, blob_prog_fd_off(gen, i));
>  	for (i = 0; i < nr_maps; i++)
>  		emit_sys_close_blob(gen, blob_fd_array_off(gen, i));

Previously this was 3 insns per stack prog_fd slot.  Now each program costs
6 insns here (12 with log_level).

[ ... ]

> @@ -294,7 +283,8 @@ static void emit_check_err(struct bpf_gen *gen)
>  	if (is_simm16(off)) {
>  		emit(gen, BPF_JMP_IMM(BPF_JSLT, BPF_REG_7, 0, off));
>  	} else {
> -		gen->error = -ERANGE;
> +		emit(gen, BPF_JMP_IMM(BPF_JSGE, BPF_REG_7, 0, 1));
> +		emit(gen, BPF_JMP32_A(off - 1));
>  	}

[ ... ]

> @@ -1136,14 +1116,10 @@ void bpf_gen__prog_load(struct bpf_gen *gen,
> [ ... ]
> +	/* remember prog_fd in the blob, if successful */
> +	emit2(gen, BPF_LD_IMM64_RAW_FULL(BPF_REG_1, BPF_PSEUDO_MAP_IDX_VALUE,
> +					 0, 0, 0, blob_prog_fd_off(gen, gen->nr_progs)));
> +	emit(gen, BPF_STX_MEM(BPF_W, BPF_REG_1, BPF_REG_7, 0));
>  	gen->nr_progs++;

The store of each prog fd grew from 1 insn (BPF_STX_MEM to the stack) to 3
insns here.  emit_relo_ksym_typeless() also adds one insn per typeless ksym.

Take an object with N entry programs and no subprograms, where N <= 32 was
allowed before.  The backward distance from the last emit_check_err() grows
by roughly N * (3 + 2) insns, or N * (9 + 2) with log_level.  For N = 32
that is about 160 to 350 insns.

A loader whose last check was within that margin below 32768 insns used to
be generated with plain 16-bit BPF_JSLT branches.  Now is_simm16(off) fails
and emit_check_err() emits BPF_JMP32_A (gotol) instead, which kernels older
than v6.4 reject in do_check() ("BPF_JA uses reserved fields").

So a light skeleton that a previous libbpf could build for those kernels
could now fail to load there.  Should the commit message be reworded, or
should the per-program growth be kept out of the backward-branch distance?

---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/43899902250
--===============1789226211521666341==--
