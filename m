Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBAD5257855;
	Sat,  6 Jun 2026 03:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780716341; cv=none; b=jR7g638G/iWpi3+yvaCbhX1hFF4fflU0m0nNvfyLDHcxfpsvm+X91vFZQgVl6IARXwMPyoto79bv3PfJFKvMO5OeIE9yfW5xVb65mlvCdyASmsANsXEpcGs12hyFxAIQaZF/CHTmAc47E9VhBphrlRwzyP4R99gJ8mpTMXgT5Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780716341; c=relaxed/simple;
	bh=wN9kfK45KNdCDMem+zCnz7FuiOpYVg9dW8CAgdWAPEA=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=H3gbz2vFmjhpMiouNmIfB+zONGQ7SR+Jv4g8AmtvEWkuyfULdtyw3Uk0b8CU1fWGzpTOdVI1UXBsGX9BhuxJOo3alXPAW+NyA2p5cFYHZoQJtZA4rTR7luLT3U0NbrlzTv7U03SCQrQBBNWdwuRD9/BiUjBAS3SPxHhkZLcBbXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HnceFllu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HnceFllu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBBCF1F00893;
	Sat,  6 Jun 2026 03:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780716340;
	bh=9nikvrfVtz/H3id9+tbpQ3vywanYHZIfIgE+DYWm8LA=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=HnceFlluby4iKlW//ObS0RAz3HASqUtvNW9QDPLdJhwmHgbVtAszELgKuXYAP4qOO
	 lhFRcePASbGCPgnkbB3pZtTfQfsid+D0JXYZ73cnTNkNQX6wo+K1+wKLKtnM+HlCtQ
	 IxDgxPpTOymYm5Vyn+XfVEFvWqoDRLPl4UiuKSpOkWwJ/ns9a7I6utXot9wTM3XqMv
	 2OFs6fsPY2M6ynmOSUpEkvGzZDFPNkMYR/dI8NCI5illt/TKSjLx8GzeH2mIXkU1ob
	 hVKV5hNCgArGw/K3QuMUtnf6Pb6Dmb5vZW9ZfM1UOa+vIAbqpG9hf+sfDI8QqiM9og
	 RcWut1NsoNcBw==
Content-Type: multipart/mixed; boundary="===============7713235649426645380=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <86b976f32a179141dbeb3eed5fa106f18f2e46b5c6849ca2c800484847d1deb7@mail.kernel.org>
In-Reply-To: <20260606024540.47362-1-ethantidmore06@gmail.com>
References: <20260606024540.47362-1-ethantidmore06@gmail.com>
Subject: Re: [PATCH] bpf: Fix signedness bug
From: bot+bpf-ci@kernel.org
To: ethantidmore06@gmail.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ameryhung@gmail.com,bpf@vger.kernel.org,linux-kernel@vger.kernel.org
Cc: john.fastabend@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,ethantidmore06@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sat,  6 Jun 2026 03:25:39 +0000 (UTC)

--===============7713235649426645380==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> commit cc27f12c12ff54b8eace339c3e130317bf205277
> Author:     Ethan Tidmore <ethantidmore06@gmail.com>
>
>     bpf: Fix signedness bug
>
>     The function acquire_reference() returns negative error codes and 'id'
>     is an unsigned integer, so the check (id < 0) is always impossible.

Is this commit message accurate? Looking at check_kfunc_call() in
kernel/bpf/verifier.c, the variable 'id' is declared as a signed int:

    const struct btf_param *args;
    u32 i, nargs, ptr_type_id;
    struct btf *desc_btf;
    int id;

Since acquire_reference() can return negative error codes like -ENOMEM,
wouldn't the original check (id < 0) work correctly?

The three other call sites of acquire_reference() in the verifier all use
the same signed-int pattern without issue:

    verifier.c:mark_stack_slots_dynptr():
        id = acquire_reference(env, insn_idx, dynptr_id);
        if (id < 0)
            return id;

    verifier.c:mark_stack_slots_iter():
        id = acquire_reference(env, insn_idx, ITER_TYPE_TO_ID(iter_type));
        if (id < 0)
            return id;

    verifier.c:check_helper_call():
        id = acquire_reference(env, insn_idx, fn->arg_type[arg_num]);
        if (id < 0)
            return id;

It looks like the Smatch warning might be a false positive, and the original
code was already handling the error properly.

>
>     Detected by Smatch:
>     kernel/bpf/verifier.c:13115 check_kfunc_call()
>     warn: unsigned 'id' is never less than zero.
>
>     Fixes: 308c7a0ae8859 ("bpf: Refactor object relationship tracking and fix dynptr UAF bug")
>     Signed-off-by: Ethan Tidmore <ethantidmore06@gmail.com>
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 935595138aa0..be528a0be13c 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -13167,9 +13167,11 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>  		}
>  		mark_btf_func_reg_size(env, BPF_REG_0, sizeof(void *));
>  		if (is_kfunc_acquire(&meta)) {
> -			id = acquire_reference(env, insn_idx, 0);
> -			if (id < 0)
> -				return id;
> +			err = acquire_reference(env, insn_idx, 0);
> +			if (err < 0)
> +				return err;
> +			id = err;
> +
>  			regs[BPF_REG_0].id = id;
>  		} else if (is_rbtree_node_type(ptr_type) || is_list_node_type(ptr_type)) {
>  			ref_set_non_owning(env, &regs[BPF_REG_0]);

The code change itself is behavior-equivalent since 'err' is also a signed
int, so the patch doesn't introduce a runtime regression. But if the premise
that 'id' is unsigned is wrong, should the commit message be corrected?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/27050796130
--===============7713235649426645380==--
