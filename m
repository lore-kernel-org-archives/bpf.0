Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C2C3DDDCF
	for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 14:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776348197; cv=none; b=K21D/9RV7G5YziaBJZtMcFHR00YvR5ZFtietvv3JfS8FABqVp/nT9483JARcRoGrpFPS7socxnJ8NCT5Km8vyamMEeGdLuTfj2mjC1Ks7wqofCHs55/UgxPF52ShgnTWJaG1Mpk7U/GNIx08rjoROcK46LAkXX8mIP5wMzv59E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776348197; c=relaxed/simple;
	bh=yblk6kBeMoDHykndGjOsNZ8xSZBhWuP4RQlwnkM2efo=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=qERiCHARbimvBrEuTk+sc075xD4ZAevA7XWgsrVcc5XFghvb7PguRK6UArNPM6/s4VHL1nyqLaKVdjyHnUg0GgJfiMr8q9r1ZQ9GhcZR6HbLooV/XR/+V1zPl4TnYNB9QjjDK4ImjjIpGQ4ZGskmVCxDxMvo4J//59HB3HdpMp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uUwfoblw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uUwfoblw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F132C2BCAF;
	Thu, 16 Apr 2026 14:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776348196;
	bh=yblk6kBeMoDHykndGjOsNZ8xSZBhWuP4RQlwnkM2efo=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=uUwfoblwTslVR6Twj+k1Ao4F0INym5V4EvPUa5cA2tdq6qRGs5kqPHOHEh3Pa3Vql
	 exrqJknJqHz69EDAwcnFSf683hBmRzR8swyRPmUpzXPoM6Y3yZ+LK9QCC0E6d34lMF
	 M+L66z80CqgTHHavGwDJEkBYjuayzF17k3VXorjmCz6p70+o1sSZ5ciXGEuuAYzL8S
	 W8fbwrOoxoLgQDjTQv6gXjo52aaR1nyviHf1GVveNo0tOSxjBpYk+YSH4wGPRyniY4
	 qnNHF+IoCk7z8KxUglm5hTPJ8bFkrfI4kZ+RBHxV09FLsX/AjQF60u9IQUdmw8HmC6
	 X3JYL4LLLKV1Q==
Content-Type: multipart/mixed; boundary="===============2059603081105847354=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <8c0577ba9cc4f4cd4707091109f5b9172ec63ee53aa7db9413cce4578d9e8b31@mail.kernel.org>
In-Reply-To: <681fc6e748330e6a765a89f7193c17b33d4ea26f.1776344897.git.paul.chaignon@gmail.com>
References: <681fc6e748330e6a765a89f7193c17b33d4ea26f.1776344897.git.paul.chaignon@gmail.com>
Subject: Re: [PATCH RFC bpf-next 1/7] bpf/verifier: Use intersection checks when simulating to detect dead branches
From: bot+bpf-ci@kernel.org
To: paul.chaignon@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,harishankar.vishwanathan@gmail.com,eddyz87@gmail.com,koike@igalia.com,yonghong.song@linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 16 Apr 2026 14:03:16 +0000 (UTC)

--===============2059603081105847354==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 9e4980128151..1d5d2b7e5140 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -2345,12 +2345,15 @@ static void __reg_bound_offset(struct bpf_reg_state *reg)
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

Should this multi-line comment have the opening /* on its own line, per
the BPF comment style?

    /*
     * If the input reg_state has no intersection between abstract
     * values, it is invalid. We can exit early, ensuring that
     * subsequent operations don't inadvertently fix the reg_state.
     */

[ ... ]

> @@ -15493,7 +15696,7 @@ static int simulate_both_branches_taken(struct bpf_verifier_env *env, u8 opcode,
>  	/*
>  	 * If there is a range bounds violation in *any* of the abstract values in either
>  	 * reg_states in the FALSE branch (i.e. reg1, reg2), the FALSE branch must be dead. Only
>  	 * TRUE branch will be taken.
>  	 */
> -	if (range_bounds_violation(&env->false_reg1) || range_bounds_violation(&env->false_reg2))
> +	if (!reg_bounds_intersect(&env->false_reg1) || !reg_bounds_intersect(&env->false_reg2))
>  		return 1;

The comment still says "range bounds violation" but the code now calls
reg_bounds_intersect(), which checks for more than range violations --
it checks pairwise intersection across all domain pairs including tnum.
Should the comment be updated to match the broader check?

[ ... ]

>  	/*
>  	 * If there is a range bounds violation in *any* of the abstract values in either
>  	 * reg_states in the TRUE branch (i.e. true_reg1, true_reg2), the TRUE branch must be dead.
>  	 * Only FALSE branch will be taken.
>  	 */
> -	if (range_bounds_violation(&env->true_reg1) || range_bounds_violation(&env->true_reg2))
> +	if (!reg_bounds_intersect(&env->true_reg1) || !reg_bounds_intersect(&env->true_reg2))
>  		return 0;

Same stale comment here for the true branch.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24513066291
--===============2059603081105847354==--
