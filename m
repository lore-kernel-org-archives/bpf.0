Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A373822B1
	for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 18:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789409968; cv=none; b=GmbQ5DwSz8Z363fEw3R1qwrWYMqENebkBhuWveytRo6bafQ6ISnTzLMfUoZhUxeAh9+/reOJpmIslUQfl5e8vgTZZhD9XN+l4hDE5HotufZQWECtuwnH59wTc6BozBLZgND2uWmPbgD1VwbxfTK5T0H29qOOpZrMF8kKGrY95VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789409968; c=relaxed/simple;
	bh=OHemRYf9sd1vbiFTWIeCmoHjma3zPM2r7gtNYnBqhAA=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=ucAf3cO7tGWnpy2kLmK78xNf96JaRXiqzRMOBbgoGQTjFjncTb2cH6TsB2CjEDZgWNsdERvOz0w4WpHEBDraGtSGSpYVMTwT9kgn5qsPZu+vO8BiTrV99Zipa7mesPUiF5vn+VsOTuZDdaciu54FQOgBfP8buObK/21pBlf0/sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hTDoNEwX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hTDoNEwX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E3E01F00893;
	Mon, 14 Sep 2026 18:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789409966;
	bh=zsv3DOK1z6di+4JD9HWbCcsiMGFP7Wdz0N67HNJxtZo=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=hTDoNEwXU138VQsAvrZzfoA8+qKcGyUlz94sSXEZ9dIPMWVr6/nShNGgIRbCdeph8
	 1yOo/sOA0v9HPZAqXY1DzhGbW9gQkvsOw9d1XbeH20kOndVhkHcubF4k7Uzv68H97l
	 hCuKiFjGJjQCZRDEvT9WF3rI4F9MDto4Mrqy1mv4KWVOCoEHwnJZDdFKJ9amFIqbpz
	 3oSSHIr7HjQssJ22lQyiuPV8w5pNhsju1vzAn4yAfKoI3IsuD4qW6A8Fb3kElfA0b3
	 5H15FfMxgcAkFqV8LIzwmmaoz21hXAloFCPmOZsemj2KRd8FbfQsxw3PjDG3i9fGSn
	 ka7pZJNBKoQKQ==
Content-Type: multipart/mixed; boundary="===============4992885252515047981=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <850a6d1cc01f20f2157f097cba13fb46ca8f7c48c8c8dc7f4eba41d7c171e36c@mail.kernel.org>
In-Reply-To: <20260914170326.249953-4-daniel@iogearbox.net>
References: <20260914170326.249953-4-daniel@iogearbox.net>
Subject: Re: [PATCH bpf v2 03/11] bpf: Cache the jump table of a subprogram during CFG discovery
From: bot+bpf-ci@kernel.org
To: daniel@iogearbox.net,ast@kernel.org
Cc: memxor@gmail.com,eddyz87@gmail.com,a.s.protopopov@gmail.com,info@starlabs.sg,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon, 14 Sep 2026 18:19:26 +0000 (UTC)

--===============4992885252515047981==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 04bb8f71cabe3..754e24d41f47f 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -670,7 +670,6 @@ struct bpf_insn_aux_data {
>  		/* remember the offset of node field within type to rewrite */
>  		u64 insert_off;
>  	};
> -	struct bpf_iarray *jt;	/* jump table for gotox or bpf_tailcall call instruction */
>  	struct btf_struct_meta *kptr_struct_meta;
>  	u64 map_key_state; /* constant (32 bit) key tracking for maps */
>  	int ctx_field_size; /* the ctx field size for load insn, maybe 0 */
> @@ -805,6 +804,7 @@ struct bpf_subprog_info {
>  	u32 linfo_idx; /* The idx to the main_prog->aux->linfo */
>  	u32 postorder_start; /* The idx to the env->cfg.insn_postorder */
>  	u32 exit_idx; /* Index of one of the BPF_EXIT instructions in this subprogram */
> +	struct bpf_iarray *jt; /* jump table shared by all gotox of this subprogram */
                                ^^^^
The patch moves jt ownership into bpf_subprog_info but doesn't update the
code that removes instructions. When verifier_remove_insns() deletes a
whole subprogram, adjust_subprog_starts_after_remove() in
kernel/bpf/fixups.c compacts the array with memmove:

    move = env->subprog_cnt + 1 - j;
    memmove(env->subprog_info + i,
            env->subprog_info + j,
            sizeof(*env->subprog_info) * move);
    env->subprog_cnt -= j - i;

If subprogram 3 owns a jump table and subprograms 1 and 2 are removed
(i=1, j=3), slots 3 and 4 are never rewritten, so subprog_info[1].jt and
subprog_info[3].jt both point to the same kvmalloc'd buffer.

Does bpf_free_subprog_jts() then double-free that buffer? Its loop walks
the entire fixed-size array rather than stopping at env->subprog_cnt:

    for (i = 0; i < ARRAY_SIZE(env->subprog_info); i++)
        kvfree(env->subprog_info[i].jt);

so both the moved copy at index 1 and the stale alias at index 3 would be
freed.

Also, when verifier_remove_insns() overwrites subprog_info[i..j), doesn't
that leak the jump table of any subprogram in that range?

Before this patch, verifier_remove_insns() called
bpf_clear_insn_aux_data(env, off, cnt) to free the jt of every removed
instruction and then memmoved the aux array. The new owner needs the same
handling: kvfree the tables of removed subprograms and clear the stale
tail slots left by the memmove, or bound bpf_free_subprog_jts() to
env->subprog_cnt and explicitly zero the tail.

[ ... ]

> diff --git a/kernel/bpf/cfg.c b/kernel/bpf/cfg.c
> index df4513e71c80a..c38d33f0b0ba5 100644
> --- a/kernel/bpf/cfg.c
> +++ b/kernel/bpf/cfg.c

[ ... ]

> +void bpf_free_subprog_jts(struct bpf_verifier_env *env)
> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(env->subprog_info); i++) {
> +		kvfree(env->subprog_info[i].jt);
> +		env->subprog_info[i].jt = NULL;
> +	}
> +	env->cfg.subprog_jts_ready = false;
> +}

This iterates over all BPF_MAX_SUBPROGS + 2 slots (258 entries), but
adjust_subprog_starts_after_remove() only updates env->subprog_cnt when
subprograms are removed. Slots beyond that count can hold stale pointers
duplicated by the memmove. Is there a risk of freeing the same allocation
twice, once from its new index and once from the old stale slot?

[ ... ]

> diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
> index 52d3cec336727..f3cf66b8147a4 100644
> --- a/kernel/bpf/fixups.c
> +++ b/kernel/bpf/fixups.c
> @@ -500,23 +500,6 @@ static int bpf_adj_linfo_after_remove(struct bpf_verifier_env *env, u32 off,
>  	return 0;
>  }
>
> -/*
> - * Clean up dynamically allocated fields of aux data for instructions [start, ...]
> - */
> -void bpf_clear_insn_aux_data(struct bpf_verifier_env *env, int start, int len)
> -{
> -	struct bpf_insn_aux_data *aux_data = env->insn_aux_data;
> -	int end = start + len;
> -	int i;
> -
> -	for (i = start; i < end; i++) {
> -		if (aux_data[i].jt) {
> -			kvfree(aux_data[i].jt);
> -			aux_data[i].jt = NULL;
> -		}
> -	}
> -}
> -
>  static int verifier_remove_insns(struct bpf_verifier_env *env, u32 off, u32 cnt)
>  {
>  	struct bpf_insn_aux_data *aux_data = env->insn_aux_data;
> @@ -526,8 +509,6 @@ static int verifier_remove_insns(struct bpf_verifier_env *env, u32 off, u32 cnt)
>  	if (bpf_prog_is_offloaded(env->prog->aux))
>  		bpf_prog_offload_remove_insns(env, off, cnt);
>
> -	bpf_clear_insn_aux_data(env, off, cnt);
> -
                          ^^^^
Removing bpf_clear_insn_aux_data() makes sense for insn_aux_data, since
it no longer owns the jt allocation. But subprog_info[].jt is still an
owned pointer, and adjust_subprog_starts_after_remove() will memmove
those structs when entire subprograms disappear.

Does verifier_remove_insns() need equivalent cleanup for the new owner?
When j - i removed subprograms are dropped, the memmove copies slots
[j, subprog_cnt] down to [i, ...] and decrements subprog_cnt by j - i,
but it doesn't kvfree the jt pointers being overwritten in [i, j) or
NULL the duplicates left in the tail slots.

>  	err = bpf_remove_insns(env->prog, off, cnt);
>  	if (err)
>  		return err;

[ ... ]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index ddba53eaa3331..32157d145a609 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -21477,8 +21477,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
>  	release_maps(env);
>  	release_btfs(env);
>  err_free_env:
> -	if (env->insn_aux_data)
> -		bpf_clear_insn_aux_data(env, 0, env->insn_aux_data_len);
> +	bpf_free_subprog_jts(env);
>  	vfree(env->insn_aux_data);
>  	kvfree(env->fd_array);
>  	bpf_stack_liveness_free(env);


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/34875126886
--===============4992885252515047981==--
