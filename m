Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12BFE3932EE
	for <bpf@vger.kernel.org>; Sun, 27 Sep 2026 20:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790541608; cv=none; b=gOwruskl4H4jLxkas7ehrFfQU/g/qpRD56IuNAcqHTWtYqNcv6/nehqnErtMScnWdZl2jXC+CiWunPNvCTR04D6H9drKv2+44keJb/MpS8S5kNsAZe8ZiV/Wt5m2HgLpzwU2woGgKzgJq5b43rTufDYZnCwWXQ2b+c2kSuTK9HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790541608; c=relaxed/simple;
	bh=h0KVudeLSFOQo+9AY7gVqMZsDjL6KO2kW3NVymhoVU8=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=OcZH7jynzHqunH12aSfcy12TwdKaAxaTXzoZ7m893U3Xq5e7rSzEJrbji/inZGKhSeVvwxKE7bre9H8CPZdERUiuyNvDtpAsAksxRqfS1iHY1Zr9pKuimd5tuaMjtHh72CIO/68lB7DOhzVdrzboXkbfpqy5UYLxA/lY0CYBmow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HeI5GSTB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HeI5GSTB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1829C1F000FF;
	Sun, 27 Sep 2026 20:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790541606;
	bh=k3CnnnfZ6+r2mPJw8S+rCuojzAOYlIpP67S6kfBNxmA=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=HeI5GSTB+0aRXlWdw7cFXO/uG3g6S8jApEoi++GLaz+gONoN1+BuZSFxslgdpPJ6t
	 1mmIwaHvYp3OgSt+sXfC/IqWXUv5yJkORN8FfKUlM1NnfLHD05xAb/0+iP6CR7bNS5
	 xxb3DH8r8s4hIYdXgfJKUj7uc6B8u1P9ERgMvAPUVgPXAPNtnfGWdNrw2dki70qjbd
	 RjpQwsqCZXuUtOZiujKY/ySTz6JoP48r+RXRlGHniZOzTmwadqB/LSIYCTCTXO8ya7
	 51ryd/xiBnpMTUArKZ9YkxIXgsvzJ4uXvVfvsIOHM/76Xs0vknt6e00wSIGJYrxfZY
	 l5kvl6uech03Q==
Content-Type: multipart/mixed; boundary="===============4930451105973295880=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <7a0545480588f4ab39ec80723158e989856b3a70db252c274d1d1fe9d9389d4d@mail.kernel.org>
In-Reply-To: <20260926050037.2216265-1-yonghong.song@linux.dev>
References: <20260926050037.2216265-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v6 06/21] bpf: Make exception landing pads reachable in the CFG
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,kernel-team@fb.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sun, 27 Sep 2026 20:40:06 +0000 (UTC)

--===============4930451105973295880==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/cfg.c b/kernel/bpf/cfg.c
> index b0bd9ba951df..4e2b6985bc96 100644
> --- a/kernel/bpf/cfg.c
> +++ b/kernel/bpf/cfg.c
> @@ -6,6 +6,7 @@
>  #include <linux/sort.h>
>
>  #include "diagnostics.h"
> +#include "exception.h"
>
>  #define verbose(env, fmt, args...) bpf_verifier_log_write(env, fmt, ##args)
>

[ ... ]

> @@ -160,17 +161,64 @@ static int push_insn(int t, int w, int e, struct bpf_verifier_env *env)
>  	return DONE_EXPLORING;
>  }
>
> +static int visit_cleanup_pad_edge(int t, struct bpf_verifier_env *env)
> +{
> +	int *insn_stack = env->cfg.insn_stack;
> +	int *insn_state = env->cfg.insn_state;
> +	int w;
> +
> +	if (!env->cleanup_info_cnt)
> +		return DONE_EXPLORING;
> +	w = bpf_exc_pad_of_call(env, t);
> +	if (w < 0)
> +		return DONE_EXPLORING;
> +
> +	/*
> +	 * @t is a call that may branch here, and @w is the target of that
> +	 * branch, so both are prune points. @w especially: every covered call
> +	 * site in a region unwinds to the same pad, and without a prune point
> +	 * at its head the verifier walks the pad again for each of them.
> +	 */
> +	mark_prune_point(env, t);
> +	mark_prune_point(env, w);
> +	mark_jmp_point(env, w);
> +	mark_jump_target(env, w);
> +
> +	if (insn_state[w])
> +		return DONE_EXPLORING;
> +	if (env->cfg.cur_stack >= env->prog->len)
> +		return -E2BIG;
> +	insn_stack[env->cfg.cur_stack++] = w;
> +	insn_state[w] |= DISCOVERED;
> +	return KEEP_EXPLORING;
> +}
> +
> +static int merge_visit_ret(int a, int b)
> +{
> +	if (a < 0)
> +		return a;
> +	if (b < 0)
> +		return b;
> +	if (a == KEEP_EXPLORING || b == KEEP_EXPLORING)
> +		return KEEP_EXPLORING;
> +	return DONE_EXPLORING;
> +}
> +
>  static int visit_func_call_insn(int t, struct bpf_insn *insns,
>  				struct bpf_verifier_env *env,
>  				bool visit_callee)
>  {
> -	int ret, insn_sz;
> +	int ret, insn_sz, pad_ret;
>  	int w;
>
> +	pad_ret = visit_cleanup_pad_edge(t, env);
> +	if (pad_ret < 0)
> +		return pad_ret;

The error handling here appears to be incorrect. In the v6 discussion
thread, you identified that this should be:

	if (pad_ret != DONE_EXPLORING)
		return pad_ret;

rather than checking for negative values. The current code causes premature
DFS stop by ignoring KEEP_EXPLORING return values from
visit_cleanup_pad_edge(). When the cleanup pad edge returns KEEP_EXPLORING,
the DFS should continue, but the negative-only check misses this case and
treats it as DONE_EXPLORING.

Can this be changed to properly handle both KEEP_EXPLORING and error cases?

>
>  	insn_sz = bpf_is_ldimm64(&insns[t]) ? 2 : 1;
>  	ret = push_insn(t, t + insn_sz, FALLTHROUGH, env);
>  	if (ret)
> -		return ret;
> +		return merge_visit_ret(pad_ret, ret);
>
>  	mark_prune_point(env, t + insn_sz);
>  	/* when we exit from subprog, we need to record non-linear history */
> @@ -182,7 +230,7 @@ static int visit_func_call_insn(int t, struct bpf_insn *insns,
>  		merge_callee_effects(env, t, w);
>  		ret = push_insn(t, w, BRANCH, env);
>  	}
> -	return ret;
> +	return merge_visit_ret(pad_ret, ret);
>  }

[ ... ]

> diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
> index cd9523f69298..4e0273a8ceee 100644
> --- a/kernel/bpf/liveness.c
> +++ b/kernel/bpf/liveness.c
> @@ -8,6 +8,8 @@
>  #include <linux/slab.h>
>  #include <linux/sort.h>
>
> +#include "exception.h"
> +
>  #define verbose(env, fmt, args...) bpf_verifier_log_write(env, fmt, ##args)

[ ... ]

> @@ -384,6 +386,18 @@ bpf_insn_successors(struct bpf_verifier_env *env, u32 idx)
>  			succ->items[succ->cnt++] = exit_idx;
>  	}
>
> +	/*
> +	 * A call a cleanup record covers can leave through its landing pad.
> +	 * Only a call to a subprogram or to bpf_unwind() is marked, neither of
> +	 * which is an edge the block above adds, so succ still holds two.
> +	 */
> +	if (unlikely(env->cleanup_info_cnt)) {
> +		int pad = bpf_exc_pad_of_call(env, idx);
> +
> +		if (pad >= 0)
> +			succ->items[succ->cnt++] = pad;
> +	}
> +
>  	return succ;
>  }

[ ... ]

> @@ -545,6 +559,13 @@ bool bpf_stack_slot_alive(struct bpf_verifier_env *env, u32 frameno, u32 half_sp
>  		alive = callee_stack_access_at_callsite(env, callsite)
>  			? is_live_before(instance, callsite, rel, half_spi)
>  			: is_live_before(instance, callsite + 1, rel, half_spi);
> +
> +		if (!alive && unlikely(env->cleanup_info_cnt)) {
> +			int pad = bpf_exc_pad_of_call(env, callsite);
> +
> +			if (pad >= 0)
> +				alive = is_live_before(instance, pad, rel, half_spi);
> +		}

Eduard Zingerman asked in v5 why this landing pad liveness check is
necessary. He stated: "If bpf_insn_succ correctly traverses call successors
including the landing pad the information should already be accounted for
by the is_live_before(instance, callsite, rel, half_spi)."

This question was not addressed in subsequent versions. Looking at the
patch series design, there's a question about which model is intended.

The commit message justifies this hunk with: "otherwise
clean_verifier_state() poisons the slot while the callee runs and the pad
is rejected for reading it."

However, at this series tip, the verifier never enters a landing pad from a
state where the pad's frame is an outer frame. There are only two entry
paths:

1. push_cleanup_pad_branch() (added in patch 5f426cf2a1ff) pushes a copy of
   the caller's state before check_func_call(), with the pad in the current
   frame.

2. process_bpf_unwind() jumps to a pad only in the current frame; otherwise
   it returns PROCESS_BPF_EXIT and bpf_unwind_resume goes through
   process_bpf_exit_full() to callsite + 1.

Since clean_verifier_state() is called only on cur in is_state_visited(),
poisoning a caller slot in cur while the callee runs cannot affect the
pushed pad copy. That copy was taken at the call site, where the caller is
the current frame, and bpf_insn_successors() already includes the pad
there.

As written, the outer-frame pad check only keeps extra caller slots alive
in callee states, which reduces pruning. It does not prevent any pad
rejection.

Either the rationale is inaccurate and the hunk is unnecessary, or the
intended model is that the pad sees the caller's frame as the callee left
it. The second reading is closer to runtime behaviour: a callee can write
the caller's stack through a PTR_TO_STACK argument before bpf_unwind(). But
that is not what push_cleanup_pad_branch() models.

Which model is intended? If the pre-call copy is the design, could this
hunk and the changelog paragraph be dropped? If the post-callee state is
the design, does the pad verification in the later verifier patch need to
change instead?

>  		if (alive)
>  			return true;
>  	}


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/36346422430
--===============4930451105973295880==--
