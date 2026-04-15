Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41533E5EC7
	for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 17:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776272662; cv=none; b=bI9JG6idVul759VbvltPgWdYsx96MSzISWrHHs6Ob5iPXrbbAMigBBmSA7EnSpQEqVKrUxHDEnKRvMAScUOtzOfTLG0ZBQ0js7yXf/HMsC35TomgsgnxFLirnmVe5/1WCiK5Sn57wpApZja7sx3Yz3TjuLVt1Xr6MfGRhd+NlWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776272662; c=relaxed/simple;
	bh=wSPsiifr9w5a3o/ugl5xTzDuANB3klcpwKuemhS/xoU=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=FseQ/Xb4kmlgE3zAi4uJ9OSqxZ2jlOvb0WPdYqpu3Z2ICYmzmFb2+70iLLPTYv643rBikZJWz8BS8Yippmg+1Czav0wQaS44FUwggQiYpjSxeq3Ug8DPkAS3R5XkkBNACg76DyQMKBHlNA3+xJKxkC7DjaNYHoIU5CcHhzA34qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JIHxtt4B; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JIHxtt4B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACADAC19424;
	Wed, 15 Apr 2026 17:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776272661;
	bh=wSPsiifr9w5a3o/ugl5xTzDuANB3klcpwKuemhS/xoU=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=JIHxtt4BGGlYmvpQ0B6Rso8C6cJH/HWm/G/yfEcoM6xrxsQrU1IpWxB1ptiNSVaKk
	 gHUnB2VYg9jWkUSXGALtMVODQnrd6XF28ItktMLBWz5ee7TlEBJjmVhnkDVdhrBCmA
	 c/dwzAdSVzgGzI9dbfKXA+3U1G6SvzjdmWBwCiL0Z2M8MnG+U23R0rGlUTDSTPCUhI
	 9n/CkVzU3loaU5Bgqwiqw1N+bsWloaG3KWfRA83AQW31vjs5DRU+jwpOLFvnVfFeFe
	 FxqcCebk1lSWo4sT4hiYV9OZ7ceAhw2+yZyNG/59MIsJxAFzCSsSZTprC8p4dZyTnP
	 deg8jSvAhVtcQ==
Content-Type: multipart/mixed; boundary="===============1492788402526279702=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <61ce4c9bb196a2baa2133e0bf778369d78e7c72cd17ee6cfce44c5c262a65457@mail.kernel.org>
In-Reply-To: <20260415160728.657270-2-harishankar.vishwanathan@gmail.com>
References: <20260415160728.657270-2-harishankar.vishwanathan@gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf/verifier: Use intersection checks when simulating to detect dead branches
From: bot+bpf-ci@kernel.org
To: harishankar.vishwanathan@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,paul.chaignon@gmail.com,shung-hsi.yu@suse.com,harishankar.vishwanathan@gmail.com,srinivas.narayana@rutgers.edu,santosh.nagarakatte@rutgers.edu,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 15 Apr 2026 17:04:21 +0000 (UTC)

--===============1492788402526279702==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -2345,12 +2345,15 @@ static void __reg_bound_offset(struct bpf_reg_state *reg)
>  	reg->var_off = tnum_or(tnum_clear_subreg(var64_off), var32_off);
>  }
>
> -static bool range_bounds_violation(struct bpf_reg_state *reg);
> +static bool reg_bounds_intersect(struct bpf_reg_state *reg);
>
>  static void reg_bounds_sync(struct bpf_reg_state *reg)
>  {
> -	/* If the input reg_state is invalid, we can exit early */
> -	if (range_bounds_violation(reg))
> +	/* If the input reg_state has no intersection between abstract values, it is
> +	 * invalid. We can exit early, ensuring that subsequent operations don't
> +	 * inadvertently fix the reg_state.
> +	 */
> +	if (!reg_bounds_intersect(reg))
>  		return;

This multi-line comment has text on the same line as the opening /*.
The BPF subsystem convention is to place the opening /* on its own
line for multi-line comments:

    /*
     * If the input reg_state has no intersection between abstract
     * values, it is invalid. ...
     */

[ ... ]

> @@ -15493,7 +15707,7 @@ static int simulate_both_branches_taken(struct bpf_verifier_env *env, u8 opcode,
>  	 * If there is a range bounds violation in *any* of the abstract values in either
>  	 * reg_states in the FALSE branch (i.e. reg1, reg2), the FALSE branch must be dead. Only
>  	 * TRUE branch will be taken.
>  	 */
> -	if (range_bounds_violation(&env->false_reg1) || range_bounds_violation(&env->false_reg2))
> +	if (!reg_bounds_intersect(&env->false_reg1) || !reg_bounds_intersect(&env->false_reg2))
>  		return 1;

The comment above still says "range bounds violation" but the check
is now reg_bounds_intersect(), which tests all 10 pairwise domain
intersections -- a strictly broader check than range bounds violation
alone. Should this comment be updated to reflect the new semantics,
e.g., "If there is no intersection between abstract values..."?

> @@ -15505,7 +15719,7 @@ static int simulate_both_branches_taken(struct bpf_verifier_env *env, u8 opcode,
>  	 * If there is a range bounds violation in *any* of the abstract values in either
>  	 * reg_states in the TRUE branch (i.e. true_reg1, true_reg2), the TRUE branch must be dead.
>  	 * Only FALSE branch will be taken.
>  	 */
> -	if (range_bounds_violation(&env->true_reg1) || range_bounds_violation(&env->true_reg2))
> +	if (!reg_bounds_intersect(&env->true_reg1) || !reg_bounds_intersect(&env->true_reg2))
>  		return 0;

Same stale "range bounds violation" wording here in the TRUE branch
comment.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24465659578
--===============1492788402526279702==--
