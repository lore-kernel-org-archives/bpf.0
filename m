Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5CBF296BD2
	for <bpf@vger.kernel.org>; Fri, 17 Apr 2026 04:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776401030; cv=none; b=rKohqAyeunpIWfI1o+hGsbVlUfbKF3HjDgvQR51T0GARwKS4NqDbGOHX7SUrFGhx1NyNaSpasvfmay3bd7ineZIxUDsEXvLcFwQM0SPOf8dn8NB2b2ta+mwQ9gir9m+6/CztBOZXro00N4tTaCFYLv4jSg4cZUuXxnPiGtUy9og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776401030; c=relaxed/simple;
	bh=5ndV6RpSBcY/IYZg2cHIOzesx0GKuDN2IoXW+zuGso4=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=iZ88NBynMZw6WbombNC+J7GCujo6U/lVt0fLwszgYufdaNfjtgo9CuY4rhs2r6GsxHXj5aHpkYztMRyed6NZIGCbVqd9OrtVZ92+VVc4xZXjrXl+AvxNfFavG/K/rOCejTojSQ/N4sjAmQcU7FYvBnZLQ7GCHWqmqfZb+Vv1el4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rC9jZd3/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rC9jZd3/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37140C2BCB0;
	Fri, 17 Apr 2026 04:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776401030;
	bh=5ndV6RpSBcY/IYZg2cHIOzesx0GKuDN2IoXW+zuGso4=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=rC9jZd3/9M2aaS7Ic1f/C9m/6wzbu6LYR9pmLlnG/8rvL4KMelggfgbVM1aTBFSll
	 E2TeARSjnYckBwU2lJD2TVSrTwEfrO/Hg+X5yDYBSEUWWdeFRy8SBjL4RM02Cg+Ylx
	 9Jwd54KAGPXbbQZsUEgHXuBb5i9cApy7J8pLlDWHs+WMmGnhJkL8yOL3rWvmotNbUB
	 ofkhp40YzqGcfe+VrIpSmf/GzxrAUd+3vmgqxM8na+CY5SjeqdTesPunk2VNzekCby
	 cKTRSfNXM+l7mVkv1liME3XspNMkH9BKco01XulaEOnKW9rMpJZj0a2iW1ZfMbYtMZ
	 4c2EeKjUQkLiA==
Content-Type: multipart/mixed; boundary="===============2073127983673618487=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <e5a6e801c10994cc2e03b0cd57e76152eb234493a6b7395a9859feade4a6575b@mail.kernel.org>
In-Reply-To: <20260417034754.2630932-1-yonghong.song@linux.dev>
References: <20260417034754.2630932-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v5 11/16] bpf: Support stack arguments for kfunc calls
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,jose.marchesi@oracle.com,kernel-team@fb.com,martin.lau@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 17 Apr 2026 04:43:50 +0000 (UTC)

--===============2073127983673618487==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -20145,6 +20209,16 @@ int bpf_fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>  	if (!bpf_jit_supports_far_kfunc_call())
>  		insn->imm = BPF_CALL_IMM(desc->addr);
>
> +	/*
> +	 * After resolving the kfunc address, insn->off is no longer needed
> +	 * for BTF fd index. Repurpose it to store the number of stack args
> +	 * so the JIT can marshal them.
> +	 */
> +	if (desc->func_model.nr_args > MAX_BPF_FUNC_REG_ARGS)
> +		insn->off = desc->func_model.nr_args - MAX_BPF_FUNC_REG_ARGS;
> +	else
> +		insn->off = 0;
> +

Is insn->off really "no longer needed for BTF fd index" after this
point? Looking at bpf_jit_find_kfunc_model() in kernel/bpf/fixups.c,
the function is called during JIT compilation from every BPF JIT backend
that supports kfunc calls (x86_32, s390, riscv64, ppc64, loongarch).

It performs a bsearch on the kfunc_tab keyed by (insn->imm, insn->off)
using kfunc_desc_cmp_by_imm_off:

kernel/bpf/fixups.c:kfunc_desc_cmp_by_imm_off() {
    ...
    if (a->imm != b->imm)
        return a->imm < b->imm ? -1 : 1;
    if (a->offset != b->offset)
        return a->offset < b->offset ? -1 : 1;
    return 0;
}

The desc->offset was populated from the original insn->off during
bpf_add_kfunc_call(), where for module kfuncs it is a non-zero BTF fd
index.

The call order is:

bpf_check()
  -> bpf_do_misc_fixups()
     -> bpf_fixup_kfunc_call()  (overwrites insn->off to 0 or stack_arg_count)
  -> bpf_prog_select_runtime()
     -> bpf_int_jit_compile()
        -> arch JIT
           -> bpf_jit_find_kfunc_model()  (reads insn->off for bsearch key)

After this patch, for a kfunc with 5 or fewer args that lives in a
module (non-zero btf_fd_idx), insn->off is zeroed, and the bsearch will
fail to find the entry that was stored with offset=btf_fd_idx.

For kfuncs with more than 5 args, the new value of insn->off (stack arg
count) also will not match desc->offset (btf_fd_idx or 0), so module
kfuncs with stack args are also broken, and vmlinux kfuncs with more
than 5 args get a nonzero insn->off that no longer matches
desc->offset=0.

Can the stack arg count be communicated to the JIT without clobbering
the btf_fd_idx that bsearch still keys on?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24546989054
--===============2073127983673618487==--
