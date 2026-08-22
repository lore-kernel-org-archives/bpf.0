Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6DA14A60F
	for <bpf@vger.kernel.org>; Sat, 22 Aug 2026 00:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787359597; cv=none; b=ccHR4jdp8IaBgZXxtrpsimxsNC8jC9qMB4YKF4biUcddd4Vr4koOQMKoQvEYJlGkVH5tRgIGoityGvWqrLr/LpPMFDLD/3LkxlPgTmEJU8o/zaMBASE/eOA3H7x2R1GKeFeQA8fo77k0fD66zH2F12mv+cPv8VQk0E2l4JtOUP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787359597; c=relaxed/simple;
	bh=sfIvDmdk84kfs12EmVN4sDFBcN6jtePFZ91BVA4nlbM=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Meg3kFUkVWVkkn3w69gupaS/l4tPHA9kA/4D95BcejOXSqWbb4IOvD4hzX7hlOgVSbxzA5QGQ+gFb/mkxSaRfXxyJoi03zaQBiiIarBRZCm42uYkZmrfzlEt1Mg5P+LOXnH0R+4qFu1+OTpjXZFIHLRyQBVuaAWpe5QJFBZ6Hbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UJCVn6LK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UJCVn6LK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 547981F000E9;
	Sat, 22 Aug 2026 00:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787359595;
	bh=THfjU6RtBrk6urDJhufH5vm0zPl20700f4TKRgu6FW4=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=UJCVn6LKq9E5eLk6f/EcwWsm9LDIuE30anufR2D4eb3putcrFAaDbNtZb38QQWimM
	 2eksMVtv47KE2XwnSJ5PGMwRaDmnhyc2M9t54X6hHgJSJTVyXygeRZvZy4S7Eehge/
	 Qb4VIOfNL0cUnGMhlbFZRPp8KEZmxOMtQDAzD2dqf4QQvoWC4wjHbYA+7+SSBqXEkm
	 1wZfm35duNblsSV9njANMNbrCNyZhDAaUoy4LZBSynxDVvPFWG5V8Emeqm1WaAWKAZ
	 t3q75126iPMOMXE3YTF7tN++pI6P/OiaeoV5lb8u3dma2Jx55bqkw4/o6KhQZZLhHw
	 d9eh+ovrxZPVw==
Content-Type: multipart/mixed; boundary="===============9076427298579758486=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <8e3ed45213301bb0ba2c041097dcf5b845f187bf35965b932abf8dd54f5c2615@mail.kernel.org>
In-Reply-To: <20260821233516.3426127-7-memxor@gmail.com>
References: <20260821233516.3426127-7-memxor@gmail.com>
Subject: Re: [PATCH bpf-next v1 06/14] bpf, s390: Convert struct_ops arena arguments
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: iii@linux.ibm.com,hca@linux.ibm.com,gor@linux.ibm.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,ihor.solodrai@linux.dev,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sat, 22 Aug 2026 00:46:35 +0000 (UTC)

--===============9076427298579758486==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
> index 20b6e53999b3f..964f1ad82637b 100644
> --- a/arch/s390/net/bpf_jit_comp.c
> +++ b/arch/s390/net/bpf_jit_comp.c
> @@ -2607,6 +2607,34 @@ static void load_imm64(struct bpf_jit *jit, int dst_reg, u64 val)
>  	EMIT6_IMM(0xc00d0000, dst_reg, val);
>  }
>
> +/*
> + * Convert an arena kernel address into the arena pointer form on its way
> + * into the BPF ctx, dst = (u32)(src - kern_vm_start). A nullable arg
> + * preserves NULL, tested on the full 64-bit kernel pointer. The 32-bit
> + * subtraction followed by zero-extension keeps the upper half clear.
> + */
> +static void emit_arena_arg_conv(struct bpf_jit *jit, int dst, int src,
> +				bool nullable, u32 base_lo)
> +{

[ ... ]

> +	/* llilf %w1,base_lo */
> +	EMIT6_IMM(0xc00f0000, REG_W1, base_lo);
> +	/* sr %dst,%w1 */
> +	EMIT2(0x1b00, dst, REG_W1);

This isn't a bug, but could slfi %dst,base_lo replace the llilf %w1 +
sr %dst,%w1 pair here, dropping the per-argument reload of the base and
the %r1 clobber?

> +	/* llgfr %dst,%dst */
> +	EMIT4(0xb9160000, dst, dst);
> +	/* 1: */
> +}

[ ... ]

> @@ -2829,14 +2868,33 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
>  		bpf_arg_off = tjit->bpf_args_off + j * sizeof(u64);
>  		if (m->arg_size[i] <= 8) {
> -			if (i < MAX_NR_REG_ARGS)
> +			bool arena_arg = arena_base &&
> +					 (m->arg_flags[i] & BTF_FMODEL_ARENA_ARG);
> +			bool nullable = m->arg_flags[i] & BTF_FMODEL_NULLABLE_ARG;
> +
> +			if (arena_arg) {
> +				if (i < MAX_NR_REG_ARGS) {
> +					emit_arena_arg_conv(jit, REG_W0, arg, nullable,
> +							    (u32)arena_base);
> +				} else {
> +					/* lg %w0,arg(%r15) */
> +					EMIT6_DISP_LH(0xe3000000, 0x0004, REG_W0,
> +						      REG_0, REG_15, arg);
> +					emit_arena_arg_conv(jit, REG_W0, REG_W0,
> +							    nullable, (u32)arena_base);
> +				}
> +				/* stg %w0,bpf_arg_off(%r15) */
> +				EMIT6_DISP_LH(0xe3000000, 0x0024, REG_W0,
> +						      REG_0, REG_15, bpf_arg_off);
> +			} else if (i < MAX_NR_REG_ARGS) {
>  				/* stg %arg,bpf_arg_off(%r15) */
>  				EMIT6_DISP_LH(0xe3000000, 0x0024, arg,
> -					      REG_0, REG_15, bpf_arg_off);
> -			else
> +						      REG_0, REG_15, bpf_arg_off);

This isn't a bug, but was the extra tab on the REG_0, REG_15, bpf_arg_off
continuation lines intended? Realigning them to the open parenthesis (as
the nearby lg %w0,arg(%r15) already is) would keep the diff to the
functional change.

> +			} else {
>  				/* mvc bpf_arg_off(8,%r15),arg(%r15) */
>  				_EMIT6(0xd207f000 | bpf_arg_off,
>  				       0xf000 | arg);
> +			}

[ ... ]

>     Keep the native argument index separate from the BPF ctx slot index. The
>     former selects r2-r6 or one caller stack slot per s390 ABI argument, while
>     the latter still expands 16-byte arguments to two slots. This also converts
>     arena pointers passed after the fifth argument without shifting later
>     values.

This isn't a bug, but since i and j were already separate before this
change, could this paragraph be trimmed to just the new part - that arena
pointers beyond the fifth argument are loaded, converted and stored in
place?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/32538351576
--===============9076427298579758486==--
