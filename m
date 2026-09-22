Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA592857CC
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 02:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790042500; cv=none; b=LYsKOkuMEMhi0AeUoRtRFtbTtOEkhWq26dfuOVsMZyKpOUrT57tO7R5DJl3qcYHrTrhdxBITTdnpHMXDk+3v6v6nxQ7TthdyjgF2OWmNbNPi/gRqU9GL8isTWlPUsM8WOtbQmtw0r9DKktk+ty7eD+wH7ZbNCfkswvwt3QszCng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790042500; c=relaxed/simple;
	bh=Hhs/MI9v7inttzChdGdw2zZTyXlPAfNywlfKSfpXSNg=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=AYzYJB55Dn28iPz2Vpc+TWT9pFoa4dbMSz2iMWJuVJjrdx/eQKdCpuL6pP9LSqbLM4UoNsru9NcuUqn4IyJlSHWlbcwiFHNi6Uhx3ndlqIDfBmuHflChGT3gf2Wq8xdPSR8ShZQ0oLcTQ30n7aBGqQzmPsxw97e9gsX3rDwnOKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O+dQnTY/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O+dQnTY/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AC281F000FF;
	Tue, 22 Sep 2026 02:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790042498;
	bh=dee8hgU4xXnSSWK2lyUyCiFUV3qmDVW30FOLoNqxEXA=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=O+dQnTY/As+NqN8Tra2Q48fN38GXy67yBayVMwuJUcZDzFaTyivnUL/SGD9R5OydL
	 IH/00P62Mh3Y6JrrhOdb5eM04lXcuOtUZktk7EvOCyWc040DyA0Bv1q1bEgcLcZ2d7
	 JurW1m/XAU3i1EWv4sWITb7QTAZM1FKphWSXS/cMsGhv692VuirU/ddl2q40fdhco6
	 8kTkR4oEewk+r91IapFDIOpWTLGQIkFasYYF6MvJnWdn+2MalMIuTiAnu0qhDtAgDC
	 yR3VaZB+f3K51JLO/0EZMl47SsbnX/YmH7H6+KzGOyJiT3HONVze2qD7wuJMsMYCkO
	 JhVy+qkkvcG5g==
Content-Type: multipart/mixed; boundary="===============5489016991197551841=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <58bd021020f98b1ae36acbf611049344613d50ea0c768de4430c6923d3544e2f@mail.kernel.org>
In-Reply-To: <20260922011323.1298619-2-alexei.starovoitov@gmail.com>
References: <20260922011323.1298619-2-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next 01/17] bpf: Fix infinite loop in check_max_stack_depth()
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,a.s.protopopov@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue, 22 Sep 2026 02:01:37 +0000 (UTC)

--===============5489016991197551841==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> commit c85fc3663258fcad6e896f09408e2d78dc70eb8b
> Author: Alexei Starovoitov <ast@kernel.org>
> Date:   Tue Sep 22 01:13:07 2026 +0000
>
>     bpf: Fix infinite loop in check_max_stack_depth()
>
>     sort_subprogs_topo() rejects recursion via direct calls, but allows cycles
>     that go through ld_imm64 BPF_PSEUDO_FUNC, since the address could be taken
>     for an async callback. The main verifier pass limits the number of frames,
>     but it doesn't follow calls into global functions.
>     So the following program passes both:
>
>       static int cb(u32 i, void *ctx) { return foo(i); }
>       static int foo(int x)           { return bar(x); }
>       int bar(int x)                  { bpf_loop(1, cb, NULL, 0); return 0; }
>
>       SEC("socket") int prog(void *ctx) { return cb(0, NULL); }
>
>     cb -> foo -> bar -> bpf_loop -> cb is unbounded recursion.
>     check_max_stack_depth_subprog() walks this cycle too. None of
>     the functions use stack and the frame counter is reset by every global
>     function, so neither stack size nor frame limit is hit and bpf_prog_load()
>     spins forever.
>
>     Reject a call into a subprog that is already in the chain of callers.
>     Async callbacks are skipped earlier and are not affected.
>
>     Signed-off-by: Alexei Starovoitov <ast@kernel.org>

This looks like a bug fix for async callback support. Should this include:

  Fixes: 7ddc80a476c2 ("bpf: Teach stack depth check about async callbacks.")

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index d62c0f74cff5..72ea662baea5 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -5505,6 +5505,22 @@ static int check_max_stack_depth_subprog(struct bpf_verifier_env *env, int idx,
>  			}
>  		}
>
> +		/*
> +		 * sort_subprogs_topo() tolerates cycles in the call graph that
> +		 * go through the address of a function being taken, since it
> +		 * doesn't know what it is taken for. Such cycle is a recursion
> +		 * unless it's an async callback, which are skipped above.
> +		 * The main verification pass limits the depth of the recursion,
> +		 * but it doesn't follow calls of global functions.
> +		 */
> +		for (tmp = idx; tmp >= 0; tmp = dinfo[tmp].caller) {
> +			if (tmp != sidx)
> +				continue;
> +			verbose(env, "recursive call from %s() to %s()\n",
> +				bpf_subprog_name(env, idx), bpf_subprog_name(env, sidx));
> +			return -EINVAL;
> +		}
> +

This isn't a bug, but would it be worth attaching a bpf_diag_program_structure()
hint here so both recursion rejections look the same to users?

sort_subprogs_topo() emits the same "recursive call from %s() to %s()" message
paired with a bpf_diag_program_structure() call that gives users a title, a
hint like "Rewrite the recursion as an explicit bounded loop...", and an
explanation. This new site emits only the bare verbose() line. bpf_diag is
still usable at this point in bpf_check() - check_max_stack_depth() runs
before the "instruction rewrites happen after this point" boundary.

>  		/* store caller info for after we return from callee */
>  		dinfo[idx].frame = frame;
>  		dinfo[idx].ret_insn = i + 1;


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35675730306
--===============5489016991197551841==--
