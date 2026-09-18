Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1346E46C4D3
	for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 05:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789710268; cv=none; b=LTFSrb25ntv1tRzzaEMoSsYyv9TK3n0szqSl4SNCKoIR53d4rLnvXETjy269OIOex0iw2fKbZ4QrMb/KjfFEGwrE2pNsEnfp75JU5gqdSl1AUcKfosIIGDwbExCZGo0a0X7Gg4fVBfYAzGRr6W9JnbNGSNarjC9tfv0LLZGjJaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789710268; c=relaxed/simple;
	bh=cJ/gGPUTQkTDIHbtPTRZ68bt/Sgt4CnPBA5a8xOEcpI=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=elBVzRKTID3VOgcEMJWnUSaBH1/C42YMP00AUofEi1oueI8TYEaFN4g7ejPpoFIN+ja4Cn2KW/IkaenHU5ozUAziTTaZ05gsIffnjTkGTE8OJzN9zIZL2OwoxtAGwlxeDBD8Zw4VRa9Ma+KkZJTBrQ/XT3eIcWxo6ttVtWd8fY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lNTJvch+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lNTJvch+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33D161F00893;
	Fri, 18 Sep 2026 05:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789710266;
	bh=B9TJNDzMa7JLUoyJb8ijDxguw+NUNf44GTvcDh3JcqY=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=lNTJvch+nQ4vDoU8PkaHkFZmJ2GrRrt8vm92wKoiHZmrI6Bncm8Prp0vEjdd0bPnT
	 IoAkoRRK7j8Dc5UfuvxFzkRF4cDY6hDf3Dyxvdtoe+qYKwG/zfsE+IGY5MizFsHydK
	 zfoH5vWwbpbjuhthMmqKi4296AK2uZqr46yZlCNowij8VBLOAkaXEDfPb2mTi00Ylo
	 OAnB8uhZZsuUQrnM8IEGy+lEU5qtVvjMxujnzttMGkphIyS9Wr6fXibvSc6c5g/zFM
	 6KAi2gGPGbpQBV0OuvXams/b6KPgcpH0qadzyy8AmUqBpfGSGVy4dIOfNZIndssQOW
	 3Qp/sRPvCfSIQ==
Content-Type: multipart/mixed; boundary="===============8741015644366736951=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <5dacf8db0cf086b921c09c3b65da5bff0d1957eb96a3a11906781a6a80c02c2d@mail.kernel.org>
In-Reply-To: <20260918044211.3286855-1-yonghong.song@linux.dev>
References: <20260918044211.3286855-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v2 03/20] bpf: Add lookups for exception cleanup resumes and landing pads
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,kernel-team@fb.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri, 18 Sep 2026 05:44:26 +0000 (UTC)

--===============8741015644366736951==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index c08505b9ba821..f9bccd3e0f4db 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -681,6 +681,11 @@ struct bpf_insn_aux_data {
>  	bool needs_zext; /* alu op needs to clear upper bits */
>  	bool non_sleepable; /* helper/kfunc may be called from non-sleepable context */
>  	bool is_iter_next; /* bpf_iter_<type>_next() kfunc call */
> +	/*
> +	 * 1 + the instruction index of the exception cleanup landing pad this
> +	 * call site unwinds to, or 0 for none.
> +	 */
> +	u32 cleanup_pad;
>  	bool call_with_percpu_alloc_ptr; /* {this,per}_cpu_ptr() with prog percpu alloc */
>  	u8 alu_state; /* used in combination with alu_limit */

[ ... ]

> diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
> index 2add8001c3ec3..82b00fac6bd6a 100644
> --- a/kernel/bpf/fixups.c
> +++ b/kernel/bpf/fixups.c
> @@ -261,6 +261,11 @@ static void adjust_insn_aux_data(struct bpf_verifier_env *env,
>  		}
>  	}
>
> +	if (env->cleanup_info_cnt)
> +		for (i = 0; i < prog_len; i++)
> +			if (data[i].cleanup_pad > off + 1)
> +				data[i].cleanup_pad += cnt - 1;
> +

[ ... ]

> @@ -549,6 +554,7 @@ static int verifier_remove_insns(struct bpf_verifier_env *env, u32 off, u32 cnt)
>  	struct bpf_insn_aux_data *aux_data = env->insn_aux_data;
>  	unsigned int orig_prog_len = env->prog->len;
>  	int err;
> +	u32 i;
>
>  	if (bpf_prog_is_offloaded(env->prog->aux))
>  		bpf_prog_offload_remove_insns(env, off, cnt);
> @@ -573,6 +579,17 @@ static int verifier_remove_insns(struct bpf_verifier_env *env, u32 off, u32 cnt)
>  		sizeof(*aux_data) * (orig_prog_len - off - cnt));
>  	env->insn_aux_data_len -= cnt;
>
> +	if (env->cleanup_info_cnt) {
> +		for (i = 0; i < env->insn_aux_data_len; i++) {
> +			u32 pad = aux_data[i].cleanup_pad;
> +
> +			if (pad > off + cnt)
> +				aux_data[i].cleanup_pad = pad - cnt;
> +			else if (pad > off)
> +				aux_data[i].cleanup_pad = 0;
> +		}
> +	}
> +
>  	return 0;
>  }

Can this logic handle NOP removal correctly? When bpf_opt_remove_nops()
calls verifier_remove_insns(env, i, 1) to remove a single fall-through
goto +0, if a cleanup record names that instruction as its landing pad,
then pad == off + 1, so pad > off is true and cleanup_pad becomes 0.

But removing the NOP leaves the pad's next instruction at the same
index, so the correct landing pad index stays unchanged rather than
being zeroed. For example:

    off:     some_call with cleanup_pad = off+1
    off+1:   goto +0  (NOP landing pad)
    off+2:   actual cleanup code

After removing the NOP at off+1:

    off:     some_call (cleanup_pad should still be off+1)
    off+1:   actual cleanup code (was at off+2)

The `else if (pad > off)` arm erases the record instead of preserving
it. Nothing rejects NOP landing pads during validation - a goto +0 has
code 0x05, not 0x00, so check_cleanup_info() accepts it.

The ordering makes the loss escape validation: bpf_check_cleanup_exceptions()
runs before bpf_opt_remove_nops(), so the verifier proves the cleanup
path releases acquired references, but then the NOP removal zeroes
cleanup_pad, and later cleanup_info_for_subprog() sees `if (!pad)
continue;` and omits the record from the runtime table. The program is
accepted but bpf_throw() finds no pad for that call site and skips the
cleanup, leaking whatever the pad was supposed to release.

Does the `else if (pad > off)` arm need to distinguish removals that
consume the landing pad instruction itself versus removals that happen
before it?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35308528711
--===============8741015644366736951==--
