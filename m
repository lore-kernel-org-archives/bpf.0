Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A7A3AD513;
	Sun, 23 Aug 2026 21:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787520563; cv=none; b=DG+82md8a16GYTMqIhURwgxWb5E7r8FMQbqIAiJtyZiPRB6l/xv8mklmvLlSJG5NdSP+v5VwG0Dbf78JjrGoBZZbWWsz7TqhQNgkoqO6q/NflqhQ/VL7UECmgg9zcnymNXCcIFIabslMLdTvuj9yUJTCqg3WU5Wv8bE3xI8BDzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787520563; c=relaxed/simple;
	bh=K2Ezk3PTBsSgmq5jxU0ghUJSnZRFcuxHFM8pZhVTqDY=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Z2BIEi1P5jpL9Y8iuEA9CfLGxtcbWZmRxK7JmFag2z4C1fuJtgb4Jf369TFd5PnIhilR5DTzoX6Me16kcFxh77y9HwdLcsGReiCbmHYoRDZmCF9+QZkBnqPD8/RFDa3ykmQhUIEadNyGWL1dp4MGnM0imeucoShHP+cAOYJz3sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FddI/lTq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FddI/lTq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D9DB1F000E9;
	Sun, 23 Aug 2026 21:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787520562;
	bh=y307OTUWHRZjctIfcjymbVBtGKCmjsbA+lD3bXtmFvM=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=FddI/lTq1vdNT69NxP8c5xaUaC8unOBWUtEgsWwxM18Af9HbKbGnJjxMZEL5a98s1
	 N7j1XDlBOyF9dz375KZK1R9CRYAT/br7QVPtPRBD7/c9zwWycPq3Fb2t05I9+kHzG2
	 z5wPILwCeCR/ruMoBKfTrErk5GXPn4bmOuNr5ie+HoiGLUM/JRCAmMhm3qg4A8tRb3
	 YgU2F3hHCwEsAuLygbo618jBxJwtZHiouN8wDqdU2hcEy6r/YdsJENM8iXaXPWgjbu
	 VE7IIQK+KtdduURjTODxlppjxkYw6Rcn9xrQgQ5ViXQfHVIjPMuKxSpusnCEkShLn+
	 7SxJkEAYn2A/Q==
Content-Type: multipart/mixed; boundary="===============7098532397741696681=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <82290fa17a3ae684d551ef0843c5022472b2422b3e230313bac3b1d2c65fc63f@mail.kernel.org>
In-Reply-To: <20260823203944.2084994-2-Jeremy.Jean@oss.cyber.gouv.fr>
References: <20260823203944.2084994-2-Jeremy.Jean@oss.cyber.gouv.fr>
Subject: Re: [PATCH] bpf, x86: Sign-extend narrow signed kfunc returns
From: bot+bpf-ci@kernel.org
To: Jeremy.Jean@oss.cyber.gouv.fr,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev
Cc: bpf@vger.kernel.org,linux-kernel@vger.kernel.org,Jeremy.Jean@oss.cyber.gouv.fr,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sun, 23 Aug 2026 21:29:21 +0000 (UTC)

--===============7098532397741696681==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index 48429fae0641..93b9e36df1d2 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -1721,6 +1721,23 @@ static int emit_kfunc_arena_args(struct bpf_prog *bpf_prog,
>  	return prog - start;
>  }
>
> +static int emit_kfunc_return(const struct bpf_prog *bpf_prog,
> +			     const struct bpf_insn *insn, u8 **pprog)
> +{
> +	const struct btf_func_model *fm;
> +
> +	fm = bpf_jit_find_kfunc_model(bpf_prog, insn);
> +	if (!fm)
> +		return -EINVAL;
> +	if (!(fm->ret_flags & BTF_FMODEL_SIGNED_ARG) || fm->ret_size == 8)
> +		return 0;
> +	if (fm->ret_size != 1 && fm->ret_size != 2 && fm->ret_size != 4)
                    ^^^^

Does this reject supported kfunc return sizes?  The early-out skips only
fm->ret_size == 8, so a signed return of size 16 falls through to this
check and triggers -EINVAL.

Size 16 is a valid kfunc return size:

kernel/bpf/btf.c:__get_type_size() returns t->size for any
btf_type_is_int(), and btf_distill_func_proto() only rejects ret > 16, so
fm->ret_size legitimately reaches 16.

kernel/bpf/btf.c:__get_type_fmodel_flags() sets BTF_FMODEL_SIGNED_ARG for
every BTF_KIND_INT carrying BTF_INT_SIGNED. __int128 is encoded exactly
that way (BTF_KIND_INT, size 16, BTF_INT_SIGNED), so both the SIGNED flag
and ret_size 16 are set together.

do_jit() already handles the wide case just below this call site:

	if (fm && fm->ret_size > 8)
		emit_mov_reg(&prog, true, BPF_REG_2, BPF_REG_3);

Concrete in-tree instance at
tools/testing/selftests/bpf/test_kmods/bpf_testmod.c:

#if defined(__x86_64__) || defined(__aarch64__)
__bpf_kfunc __int128 bpf_kfunc_call_test_i128(u64 a, u64 b)

exercised by tools/testing/selftests/bpf/progs/verifier_aggregate_ret.c
(__arch_x86_64 __arch_arm64 __load_if_JITed() __success __retval(0)) and
tools/testing/selftests/bpf/progs/aggregate_ret_kfunc.c.

emit_kfunc_return() returning -EINVAL causes do_jit() to return -EINVAL.
In bpf_int_jit_compile(), this takes the proglen <= 0 branch, which frees
the image and clears prog->jited. On the common CONFIG_BPF_JIT_ALWAYS_ON=y
configuration, program load fails outright instead of falling back to the
interpreter. Any BPF program calling a kfunc with a signed 16-byte return
stops loading on x86-64.

Should the first check use fm->ret_size >= 8 instead of fm->ret_size == 8
to keep the whitelist meaningful while preserving the existing wide-return
behaviour?

> +		return -EINVAL;
> +
> +	emit_movsx_reg(pprog, fm->ret_size * 8, true, BPF_REG_0, BPF_REG_0);
> +	return 0;
> +}
> +
>  static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *addrs, u8 *image,
>  		  u8 *rw_image, int oldproglen, struct jit_context *ctx, bool jmp_padding)
>  {
> @@ -2664,6 +2681,11 @@ st:			insn_off = insn->off;
>  			ip += x86_call_depth_emit_accounting(&prog, func, ip);
>  			if (emit_call(&prog, func, ip))
>  				return -EINVAL;
> +			if (src_reg == BPF_PSEUDO_KFUNC_CALL) {
> +				err = emit_kfunc_return(bpf_prog, insn, &prog);
> +				if (err)
> +					return err;
> +			}
>  			if (priv_frame_ptr)
>  				pop_r9(&prog);
>  			/*


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/32665981826
--===============7098532397741696681==--
