Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0838730FC27
	for <bpf@vger.kernel.org>; Wed, 13 May 2026 05:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778650397; cv=none; b=W8pCXFS9XVmonmEuqid/Zp9W9/SA7ylKEJ1nmmrfSYUWwdlbwumffH9PKHrAi3kTBus9bXXGLYDu4ruylUXY1dDafXw7J7GUdr39SibjDGgTTVK9EK2sbi788glm6ro6IVUPbNAxgRFS6Aq2uogsefZcPDvwROQ5S/vdC/bfLu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778650397; c=relaxed/simple;
	bh=oKADf0LUOFnfgiqYmMeuVBqUQWTkLZ1HwxeigMjl0Ck=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=PJCWsnvcCeXLlrT/uo0aDUiIUZCxrqXsYq+7hpcbwuCwJZzHDurQvRXLk9YfR6wo/bI0qzQVFBLYN0gYCQHouGBp2EFXRws/aA128hiY4e+hCYDD9rrGR1GzCATCSc/ixQsGbJLR6qkevk6NzPbceOjjzw02TCX52a4s1JrELa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MX8vladm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MX8vladm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B010C2BCB7;
	Wed, 13 May 2026 05:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778650396;
	bh=oKADf0LUOFnfgiqYmMeuVBqUQWTkLZ1HwxeigMjl0Ck=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=MX8vladm/3SXeDlvvFT2Jl7yW6xvPvMFDhRXzF1qOGU65MzXWtZmHAIB0PCSW2DxY
	 1GnZRNeeyGFyeuXgU3ns9XrIc38fDruY42wkC+IAbxMM25eLP0nXsLDePh303t7kt3
	 SMryigfTCdyGnhdzwnS5uLXEDwokEZXRyTBaXdx333XNsfFXUzr/0u0x8oH3R0kuDJ
	 ByHYKBNMGNv+Lqm42Y37dqoLNAwA6hS0t2Go+z6P3WKEJO0gtOf+EOFEhtHmTVLzCH
	 z2Mg2Jnc+AFyGOPArupQJQZhJsCyxCSC09+oSWJiuNX5AhoThjYZ25sktBdX79HdgK
	 tgUhd/sfKvCCQ==
Content-Type: multipart/mixed; boundary="===============8218868308912374862=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <160e00e9cc06dacf567cc7a90425054b998c00c0a02a940d5e7805fa01f7c549@mail.kernel.org>
In-Reply-To: <20260513045109.2392108-1-yonghong.song@linux.dev>
References: <20260513045109.2392108-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v4 15/25] bpf: Reject stack arguments if tail call reachable
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,jose.marchesi@oracle.com,kernel-team@fb.com,martin.lau@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 13 May 2026 05:33:16 +0000 (UTC)

--===============8218868308912374862==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> commit 45936037fdce86edc48f07b4ce94daed4efac78e
> Author: Yonghong Song <yonghong.song@linux.dev>
> Date:   Tue May 12 21:51:09 2026 -0700
>
>     bpf: Reject stack arguments if tail call reachable
>
>     Tail calls are deprecated and will be replaced by indirect calls
>     in the future. Reject programs that combine tail calls with stack
>     arguments rather than adding complexity for a deprecated feature.
>
>     Signed-off-by: Yonghong Song <yonghong.song@linux.dev>

Multiple reviewers across v4, v5, v6, v1, v2, and v3 raised concerns
that the commit message inaccurately states 'Tail calls are deprecated'
when the actual technical reason is that tail calls and stack arguments
require incompatible stack frame handling. The author acknowledged this
feedback but chose to keep the commit message as-is, stating that tail
calls are 'in deprecation stage'.

Would it be more precise if the commit message explained the technical
constraint: 'tail calls and stack arguments require incompatible stack
frame handling'?

This looks like a bug fix for stack argument support. Should this include:

  Fixes: cc06010ca1b8 ("bpf: Support stack arguments for bpf functions")

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 1a734ab91a31..a10cc045057d 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -5267,14 +5267,23 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
>  	 * this info will be utilized by JIT so that we will be preserving the
>  	 * tail call counter throughout bpf2bpf calls combined with tailcalls
>  	 */
> -	if (tail_call_reachable)
> +	if (tail_call_reachable) {
>  		for (tmp = idx; tmp >= 0; tmp = dinfo[tmp].caller) {
>  			if (subprog[tmp].is_exception_cb) {
>  				verbose(env, "cannot tail call within exception cb\n");
>  				return -EINVAL;
>  			}
> +			if (subprog[tmp].stack_arg_cnt) {
> +				verbose(env, "tail_calls are not allowed in programs with stack args\n");
> +				return -EINVAL;
> +			}
>  			subprog[tmp].tail_call_reachable = true;
>  		}
> +	} else if (!idx && subprog[0].has_tail_call && subprog[0].stack_arg_cnt) {
> +		verbose(env, "tail_calls are not allowed in programs with stack args\n");
> +		return -EINVAL;
> +	}
> +
>  	if (subprog[0].tail_call_reachable)
>  		env->prog->aux->tail_call_reachable = true;


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/25779371388
--===============8218868308912374862==--
