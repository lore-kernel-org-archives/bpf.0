Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F4C3E5595
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 03:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790222183; cv=none; b=mc4Ub5P3VbG04sQz1wWl4Gj33UvdKO8smg2IVQvDkPCucd+BVmZBt3urJlkqS6mh4WtdaY3vna1K9H5KSDHY/h0OI4CVcwOvuATnGs+oQpGDICqNiWgJLiqbq6LK+WpobtlRjlorQ+5WIOwGDVYk5I/w1ueMa3EBPbM/YWo/QfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790222183; c=relaxed/simple;
	bh=SZmJa5RVXbD0Dp3WV0I6Tg0R/wSz5eyBJtvBLKRMABk=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=RaOBGrgqUSloccxqnlduIXXrYK9aFblb023anzs5YMDNALS8N1wZ3VQwXZQgiYKsXwsoficX4sGHsVXg1SA4K22Tv50kC5uJKfO01PUGqcx2jpIqJINfpHNi9l79j0aXf28XQt9qkFgqnUnXi8XXBj8e50vexbXY5UKaHifU2T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JOb9mNdu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JOb9mNdu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EEEF1F000FF;
	Thu, 24 Sep 2026 03:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790222182;
	bh=tTgVr8SCsp/z4xKz1heNaqgb3vdcv/FszeemmbyRwbs=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=JOb9mNduazAzki3PAoUQ70GDqdYnXLX5XnJ4lHWp1TO3QwKNzqSajc1u9ehjklhkg
	 rrB5lXQJmh+KM8xngZKfp+uR6PScaXrUj56VOotXsvsL7NSYjLbcM8moYSiN7sBhrX
	 Q22g8lIlTOAPoWh0DdqQ9Vm4E5PoXbEbjLxBGvN37EvuMY/PWRkWlfH1qk+ijyD1jb
	 pKGiUda+eOmxc1Z7xbczcIq93SqwBBvpyS9r/wEXCzz7MQyxP0PnldqVUaVBWjoI2+
	 hf+xwXD1zUePCit3H5vPgleGUeOrQm7yH2mdpMx4ZaWMBQiBh25eivDx/n1zfzBULF
	 kazEO5dYGu6Fg==
Content-Type: multipart/mixed; boundary="===============7746873327517886572=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <d7fd0e8fae2022bcd7310050dcee7b43a7d5dad6249ad20167b9a73b0d1deb5f@mail.kernel.org>
In-Reply-To: <20260924031042.1690890-5-alexei.starovoitov@gmail.com>
References: <20260924031042.1690890-5-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next v2 04/17] bpf: Prepare static analysis passes for callx instruction
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu, 24 Sep 2026 03:56:20 +0000 (UTC)

--===============7746873327517886572==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h

[ ... ]

> diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
> index 44ecdc5b4ec2..a204b492acc8 100644
> --- a/kernel/bpf/liveness.c
> +++ b/kernel/bpf/liveness.c
> @@ -356,12 +356,29 @@ int bpf_live_stack_query_init(struct bpf_verifier_env *env, struct bpf_verifier_
>  	return 0;
>  }
>
> +/*
> + * Stack slots of outer frames that the callee may read are accounted as read
> + * by the @callsite insn itself, i.e. they are live before @callsite and may be
> + * dead after it, when:
> + * - @callsite calls a callback, which may be called several times;
> + * - @callsite is callx. Its callee is not known when stack liveness is
> + *   computed, so there is no func instance for it at @callsite. While
> + *   the verifier is in the callee lookup_instance() finds its standalone
> + *   instance that knows nothing about outer frames. What the callee may read
> + *   there is recorded by record_call_access().
> + */
> +static bool callee_stack_access_at_callsite(struct bpf_verifier_env *env, u32 callsite)
> +{
> +	return bpf_calls_callback(env, callsite) ||
> +	       bpf_is_callx(&env->prog->insnsi[callsite]);
> +}

The comment and the commit message line "The callee is analyzed as
standalone instance" say that a callx callee always has a standalone
depth-0 func instance that lookup_instance() finds. Is that accurate for
all cases?

Looking at bpf_compute_subprog_arg_access(), the standalone instance is
only created for subprogs not already analyzed through a direct call:

kernel/bpf/liveness.c:bpf_compute_subprog_arg_access() {
    ...
    if (info[sub].at_in && !bpf_subprog_is_global(env, sub))
        continue;
    instance = call_instance(env, NULL, 0, sub);
    ...
}

Subprogs are walked callers-first. If a static subprog S is both a callx
target and reached by a BPF_PSEUDO_CALL that passes an fp-derived
argument, analyze_subprog() has already set info[S].at_in, so no depth-0
instance is created.

With the verifier state in frame S entered through callx,
lookup_instance() tries key == callx insn idx at depths frameno..1 (no
match, call_instance() is only called for pseudo calls and callbacks),
then tries key == S start at depth 0 (does not exist), so it returns NULL.

bpf_live_stack_query_init() stores NULL in q->instances[frame], and
bpf_stack_slot_alive() returns true for every slot:

kernel/bpf/liveness.c:bpf_stack_slot_alive() {
    ...
    if (!curframe_instance)
        return true;
    ...
    if (!instance)
        return true;
    ...
}

The result is safe (slots are only treated as more alive), but the
comment appears to misdescribe the mechanism. Stack-slot cleaning in
__clean_func_state() is also silently lost for the whole callx chain in
that case, which reduces state pruning.

At this commit callx is still rejected, so this only matters later when
callx is enabled. Could the comment and changelog be reworded to cover
the case where lookup_instance() returns NULL, or should the standalone
instance be created for address-taken static subprogs as well?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35951148075
--===============7746873327517886572==--
