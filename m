Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6C9481A9F;
	Wed,  6 May 2026 15:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778081247; cv=none; b=W+yGOMBOLxCgh6QHBdV9fbqzYrFuSJ6du8TtT6uL9PmSDnzDn5Lz2gnbKIPighMzGoegHK3GT6uq44At49FcYjxF47lCOjGQ3u7mcfCuSYZDilA2s10zB+9c8J4fzumEolOghBp+999HrnpRoXJoV3+ANuhUjEZLLBY5aLeWbHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778081247; c=relaxed/simple;
	bh=y4fJIpNE69a6WP3hobGlQWf/R5uxF8sLwnnXsWVWTCI=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=LLwXsyYs7umrqWjXghRazc9hNad930FK6NBzW/d9IcGCQQcfPT/S14gS+lFj3vU467703FK7RGOoWK3Age0Sw3+9j7YlEE2IDJp+AvWgUaQkSkJWUIRaIfULcCCDptC9B0vjacgHce02eEYTLYgzNRgHV83AdEEC1e/lDq9WfXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tHSptGAW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tHSptGAW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC21CC2BCF4;
	Wed,  6 May 2026 15:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778081247;
	bh=y4fJIpNE69a6WP3hobGlQWf/R5uxF8sLwnnXsWVWTCI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=tHSptGAWD6mtKl8Thav6wvRjGGCgvgrlmo+7PEo9BkXeMrf7NLuSGaOQh7Fx/fXZP
	 qbFoOjDeeu4NKsV+zxaqOdGP4sm8q3MW3fBMJ8TBIsmFeurIPpGqrVPAg7CDGaKT6F
	 nrNZ1zYdGB1QcM+60D6ZJ0/czgMOG97V9er4EvfvIyLgieWj3jv/7p14uvwHsON/v0
	 7sr1ZDgsMgxOJ7DOoC74SVMhSOmz9GzSYjgzdwFfCsUYD3R45o5lLIHVK4HNfrbNd6
	 hQLhNOe2WPeLYyAkK6NR8khcDiKS4fIgigyZiEIdk3bukYUPDvLJ/CPfDpxLuA/sFt
	 O10WsIocbL74w==
Content-Type: multipart/mixed; boundary="===============4575011560216715104=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <c50e87ba73094da8cf153aa71d110868fe0e0e27bea866e294af7647712c9a6a@mail.kernel.org>
In-Reply-To: <20260506142709.2298255-4-ameryhung@gmail.com>
References: <20260506142709.2298255-4-ameryhung@gmail.com>
Subject: Re: [PATCH bpf-next v4 03/12] bpf: Assign reg->id when getting referenced kptr from ctx
From: bot+bpf-ci@kernel.org
To: ameryhung@gmail.com,bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,alexei.starovoitov@gmail.com,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,memxor@gmail.com,martin.lau@kernel.org,mykyta.yatsenko5@gmail.com,ameryhung@gmail.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed,  6 May 2026 15:27:26 +0000 (UTC)

--===============4575011560216715104==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -6057,8 +6057,6 @@ struct bpf_insn_access_aux info = {
>  			} else {
>  				mark_reg_known_zero(env, regs,
>  						    value_regno);
> -				if (type_may_be_null(info.reg_type))
> -					regs[value_regno].id = ++env->id_gen;
>  				/* A load of ctx field could have different
>  				 * actual load size with the one encoded in the
>  				 * insn. When the dst is PTR, it is for sure not
> @@ -6068,8 +6066,11 @@ struct bpf_insn_access_aux info = {
>  				if (base_type(info.reg_type) == PTR_TO_BTF_ID) {
>  					regs[value_regno].btf = info.btf;
>  					regs[value_regno].btf_id = info.btf_id;
> +					regs[value_regno].id = info.ref_obj_id;
                                        ^^^^

Does this introduce a bug when reading the same nullable context field
multiple times?

The new code sets reg->id = info.ref_obj_id, where ref_obj_id comes from
ctx_arg_info->ref_obj_id. The ctx_arg_info structure is initialized once
during program type setup in check_attach_btf_id(), making ref_obj_id a
static value per context field, not per read.

When a BPF program reads the same nullable context field into different
registers, they would share the same ID:

    r1 = ctx->nullable_kptr;  // r1->id = ref_obj_id = 5
    r2 = ctx->nullable_kptr;  // r2->id = ref_obj_id = 5 (SAME!)
    if (r1 != NULL) {
        // mark_ptr_or_null_regs(id=5) marks ALL registers with id==5
        // Both r1 AND r2 are now considered safe
        use(r2);  // BUG: r2 was never checked but verifier allows use
    }

The mark_ptr_or_null_reg() function uses reg->id to identify which
registers should be updated together after a NULL check. With shared IDs,
independent reads are incorrectly treated as aliases.

The old code generated a unique ID via ++env->id_gen for each nullable
read, ensuring proper NULL-check tracking.

>  					regs[value_regno].ref_obj_id = info.ref_obj_id;
>  				}
> +				if (type_may_be_null(info.reg_type) && !regs[value_regno].id)
> +					regs[value_regno].id = ++env->id_gen;

Would this fallback path prevent fresh ID generation when id was already
set to ref_obj_id? The condition '!regs[value_regno].id' is now false for
nullable PTR_TO_BTF_ID pointers, so each read gets the same static ID
instead of a unique one.

Eduard Zingerman's review comment from v3 suggested that the commit message
should mention that this patch is mandatory for proper invalidation
propagation in later patches. He noted that without the line
'regs[value_regno].id = info.ref_obj_id;', the test
'bpf_qdisc_fail__invalid_dynptr_cross_frame.c:invalid_dynptr_cross_frame'
fails because the .id link is needed to propagate invalidation triggered by
'free_skb(skb);' to 'hdr'. The current commit message mentions consistency
and parent_id tracking but does not explicitly mention the invalidation
propagation aspect.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/25442456702
--===============4575011560216715104==--
