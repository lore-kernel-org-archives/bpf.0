Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE64396572
	for <bpf@vger.kernel.org>; Fri,  4 Sep 2026 06:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788502192; cv=none; b=mA8rpqi294N15Yjj2/9I6NXjPBKs/pmi5yFxqMa4cZErIVUsaSYH0uetCsK58Q42tQJf7wDY+BYIX1M3arJ4Sv2c5juViGWk9Q378/2GL0DVz5wRfTS1ZSP6cyTfdEeT+OWp9q5ppyMsVpTvIdzbqO1r5GYMcGMQvaCWYPEtUqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788502192; c=relaxed/simple;
	bh=ca933xTIhQbIsdjBwDiqxa/nK5n57cwwFcyqrYsonC0=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=gcjMiaOk5xObxcSn6pPgkgKZClTOsQ3veTNaxFWVd4jpDgcurc1ZV63LjVkEGhLdzGW/77giTSDJMLswtgJLG6iUqOSl3rIqTm2zXA3EwTi8VKt4/FLkZMXdw5TT1EmZdZ8T+chvawsqWO15lQptXJGEMwUpbhP59XLhFFCvnF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SJveRd0Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SJveRd0Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CDD11F00A3D;
	Fri,  4 Sep 2026 06:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788502190;
	bh=fxwv55WQ1qA1JesPT9/RnXReZE3XdGvSrY/dp1n6cHE=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=SJveRd0Y4HXjHOaWCovjOuV5/J7FpyLG0oz567LUzcdnkezAN9zUwz7ntZlgan7id
	 nALQlICQ9+Je5fuiN+OYlqBfkoiMNTlFybQ7LvXYREcvPChIRxld1r+lhAadDUww+S
	 qyaqA5D6A4tspEby9yBfHuj+Yrs8J2aO2nyGcm46vJH/GywvEhyo+AZ0220N7v3XJh
	 w2oxStpTCKnBUbRUQ5BzfiXKsznRmhsSsq/VsATz+Y+vYA8U+b8jpgskmQxAbBnSCi
	 oFjezZEvm+Bnw1qD/JMVFaRMGmMYKYToSotrtB4ZwhubinLaMZHfx3RQXpTpRjfeeC
	 7lo2+Ad4dxHHQ==
Content-Type: multipart/mixed; boundary="===============4071189368778720999=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <4a489b60078c712d9d0b449170f77d5fd0e94dcacff05950684940066dc1b13e@mail.kernel.org>
In-Reply-To: <20260904051043.3981550-1-yonghong.song@linux.dev>
References: <20260904051043.3981550-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next 09/12] bpf, arm64: Place kfunc arguments per AAPCS64
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,kernel-team@fb.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri,  4 Sep 2026 06:09:50 +0000 (UTC)

--===============4071189368778720999==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
> index 3aa3ea0bc30b..f6c783d176ed 100644
> --- a/arch/arm64/net/bpf_jit_comp.c
> +++ b/arch/arm64/net/bpf_jit_comp.c

[ ... ]

> @@ -1256,6 +1256,93 @@ static void emit_stack_arg_store_imm(s32 imm, s16 bpf_off, const u8 tmp, struct
>  	}
>  }
>
> +/* The kernel ABI hands the first eight eightbytes of arguments to registers. */
> +static const u8 a64_arg_reg[8] = {
> +	A64_R(0), A64_R(1), A64_R(2), A64_R(3),
> +	A64_R(4), A64_R(5), A64_R(6), A64_R(7),
> +};
> +
> +static int kfunc_arg_layout(const struct btf_func_model *fm, u8 *pos, int max)
> +{
> +	int i, k, ngrn = 0, nsaa = 0, slot = 0;
> +
> +	for (i = 0; i < fm->nr_args; i++) {
> +		bool align16 = fm->arg_flags[i] & BTF_FMODEL_ALIGN16_ARG;
> +		int n = (fm->arg_size[i] + 7) / 8;
> +
> +		if (slot + n > max)
> +			return -EINVAL;
> +		if (align16)
> +			ngrn = round_up(ngrn, 2);
> +		if (ngrn + n <= 8) {
> +			for (k = 0; k < n; k++)
> +				pos[slot++] = ngrn++;
> +			continue;
> +		}
> +		/* Nothing that follows gets a register either. */
> +		ngrn = 8;
> +		if (align16)
> +			nsaa = round_up(nsaa, 2);
> +		for (k = 0; k < n; k++)
> +			pos[slot++] = 8 + nsaa++;
> +	}
> +	return slot;
> +}
> +
> +static u16 kfunc_arg_stack_bytes(const struct bpf_prog *prog)
> +{
> +	u16 slots = bpf_jit_kfunc_stack_slots(prog, 8, kfunc_arg_layout);
> +
> +	return round_up(slots * sizeof(u64), 16);
> +}
> +
> +static void emit_arg_pos_load(u8 reg, u8 pos, struct jit_ctx *ctx)
> +{
> +	if (pos < 8)
> +		emit(A64_MOV(1, reg, a64_arg_reg[pos]), ctx);
> +	else
> +		emit(A64_LDR64I(reg, A64_SP, (pos - 8) * sizeof(u64)), ctx);
> +}
> +
> +static void emit_arg_pos_store(u8 pos, u8 reg, struct jit_ctx *ctx)
> +{
> +	if (pos < 8)
> +		emit(A64_MOV(1, a64_arg_reg[pos], reg), ctx);
> +	else
> +		emit(A64_STR64I(reg, A64_SP, (pos - 8) * sizeof(u64)), ctx);
> +}

This isn't a bug, but is the pos < 8 branch in emit_arg_pos_store()
kept deliberately for symmetry with emit_arg_pos_load() and with the
x86 helper, or could it be dropped?

Looking at emit_kfunc_args() below, emit_arg_pos_store() is only ever
called from the pos[i] >= 8 branch:

> +static int emit_kfunc_args(const struct bpf_insn *insn, struct jit_ctx *ctx)
> +{
> +	const u8 tmp = bpf2a64[TMP_REG_1];
> +	const struct btf_func_model *fm;
> +	u8 pos[MAX_BPF_FUNC_ARGS];
> +	int i, n;
> +
> +	fm = bpf_jit_find_kfunc_model(ctx->prog, insn);
> +	if (!fm)
> +		return -EINVAL;
> +
> +	n = kfunc_arg_layout(fm, pos, ARRAY_SIZE(pos));
> +	if (n < 0)
> +		return 0;
> +
> +	for (i = n - 1; i >= 0; i--) {
> +		if (pos[i] == i)
> +			continue;
> +		if (WARN_ON_ONCE(pos[i] < i))
> +			return -EFAULT;
> +		if (pos[i] < 8) {
> +			/* into a register, read straight from the slot */
> +			emit_arg_pos_load(a64_arg_reg[pos[i]], i, ctx);
> +		} else {
> +			emit_arg_pos_load(tmp, i, ctx);
> +			emit_arg_pos_store(pos[i], tmp, ctx);
> +		}
> +	}
> +	return 0;
> +}

so pos is always at least 8 and the register store is never emitted.

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33840714551
--===============4071189368778720999==--
