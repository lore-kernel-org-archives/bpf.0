Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A32F2309AA
	for <bpf@vger.kernel.org>; Thu,  9 Apr 2026 02:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775701582; cv=none; b=PXEd7WKIYH6FzLd7D7ZhrfrYzP1xCR6FoA5lnUqd/h/E/P5RRPF8ULrUInVo2wUS6TLDWt0u7f6/GlL9vt0JDWLckfiRlbBrHdCH/FlHzzXsn8sNrE+wb6/ToWh2rclMp/00ooXxi5h6wB4/yt+OIjzWRR3JDM7PxmEI1Y1NT70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775701582; c=relaxed/simple;
	bh=0FAesaBKBIM3IW2VAjdEcUGVDZnIllMAx3czWTBdoCg=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=eK1Q5X0dJlZzy12kHnqNyijXQnu9PPIdGNlL5Z1kkaQi9/j4EhEjmLodWm+oCvkUf2d/s6mrXxAIMmBizUcXtbcc2azt+BW4Dg83FmcapDZLXYjI68Ic4d4ti75NGEqJwVpGOzbZ9Fe55uULo9oB1r86AHsjLlwVZLqBakwrzvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cov4Ivgf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cov4Ivgf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5511C19421;
	Thu,  9 Apr 2026 02:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775701581;
	bh=0FAesaBKBIM3IW2VAjdEcUGVDZnIllMAx3czWTBdoCg=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=Cov4IvgfGqZFOXML/WrCpBtv14tEcF8dYOKkccG4ux2JqI4G+a+0RplmYOzTkW/1M
	 JYjGQNpunSowNged640pFYyzUtB/DZjed75d82cSNQlVcMLXMD6oYvZ3vMckn5yaJG
	 e6+E+DSRs+FWeBX8T/oEG4H1BoOaaQkQRn9BCo6f0Y3NXwOJtq155ZWSFYrbx0vNHw
	 4vMdYvn+zWuf8Ny3iCODZ/PLCAYuiVW1U9xW7GNhqjWsHq1126Q0bePdZX/Zm1QYHD
	 0+Fh5RrRacacurXikKOhtKjkblt5Qa4iIc4/+Qzo4FWxn9nUhs7MPwO62g9chu12Od
	 SalhToSCYqcjw==
Content-Type: multipart/mixed; boundary="===============0640741652904002027=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <ea799805de3dc55c195861b2b18aab9ea57cb42e17549f4ac68c2111a9885158@mail.kernel.org>
In-Reply-To: <20260408-patch-set-v1-9-1a666e860d42@gmail.com>
References: <20260408-patch-set-v1-9-1a666e860d42@gmail.com>
Subject: Re: [PATCH bpf-next 09/14] bpf: simplify liveness to use (callsite, depth) keyed func_instances
From: bot+bpf-ci@kernel.org
To: eddyz87@gmail.com,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org
Cc: daniel@iogearbox.net,martin.lau@linux.dev,kernel-team@fb.com,yonghong.song@linux.dev,eddyz87@gmail.com,alexei.starovoitov@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu,  9 Apr 2026 02:26:21 +0000 (UTC)

--===============0640741652904002027==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
> index 4457cd80d072..c3098369bee8 100644
> --- a/kernel/bpf/liveness.c
> +++ b/kernel/bpf/liveness.c

[ ... ]

> -static int commit_stack_write_marks(struct bpf_verifier_env *env,
> -				    struct func_instance *instance,
> -				    u32 insn_idx)
> -{
> -	struct bpf_liveness *liveness = env->liveness;
> -	u32 idx, frame, curframe;
>  	struct per_frame_masks *masks;
> -	spis_t mask, old_must_write, dropped;
>
> -	if (!instance)
> -		return 0;
> -
> -	curframe = instance->callchain.curframe;
> -	idx = relative_idx(instance, insn_idx);
> -	for (frame = 0; frame <= curframe; frame++) {
> -		mask = liveness->write_masks_acc[frame];
> -		/* avoid allocating frames for zero masks */
> -		if (spis_is_zero(mask) && !instance->must_write_set[idx])
> -			continue;
> -		masks = alloc_frame_masks(instance, frame, insn_idx);
> -		if (IS_ERR(masks))
> -			return PTR_ERR(masks);

[ ... ]

> +static int mark_stack_write(struct func_instance *instance, u32 frame, u32 insn_idx, spis_t mask)
> +{
> +	struct per_frame_masks *masks;
> +
> +	masks = alloc_frame_masks(instance, frame, insn_idx);
> +	if (IS_ERR(masks))
> +		return PTR_ERR(masks);
> +	if (instance->must_write_initialized)
> +		masks->must_write = spis_and(masks->must_write, mask);
> +	else
> +		masks->must_write = mask;
> +	return 0;
> +}

mark_stack_write() now returns int and can fail with -ENOMEM via
alloc_frame_masks(), but its sole caller record_stack_access_off()
is a void function that ignores the return value:

kernel/bpf/liveness.c:record_stack_access_off() {
    ...
    mark_stack_write(instance, frame, insn_idx, mask);
    ...
}

The old code path through commit_stack_write_marks() did propagate
alloc_frame_masks() errors back through compute_subprog_args().
Should the return value be checked here, or is the silent failure
(conservative liveness, more slots appear live) intentional?

[ ... ]

> -/* Fixed-point computation of @live_before and @must_write_acc marks */
> -static int update_instance(struct bpf_verifier_env *env, struct func_instance *instance)
> +/* Fixed-point computation of @live_before marks */
> +static void update_instance(struct bpf_verifier_env *env, struct func_instance *instance)
>  {

[ ... ]

> -	instance->updated = false;
> -	instance->must_write_dropped = false;
> -	return 0;
> +	return 0;
>  }

update_instance() was changed from returning int to void, but
"return 0;" was left behind. This is resolved by the later commit
cc55f39c101d ("bpf: change logging scheme for live stack analysis")
which removes it.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24168298083
--===============0640741652904002027==--
