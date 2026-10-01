Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D251647DFB6;
	Thu,  1 Oct 2026 11:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790854315; cv=none; b=D15TMVN2PKVAeehWQVCebRS+WNqM/39+T3c510Jv/Bj0f9/fbzWnpqdtBzuWRlzCh4X9H+I6/OP1emegJHvWhK9zESlTGyy6cJvl2om4707XuyQaLnZPYJ2GbcqeLUp/2jr5nvD5Sx7rQNNuHrNau31ClSmZ/HdXiB6grj/nR+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790854315; c=relaxed/simple;
	bh=4O9v7unYLnpmGTZ1mJ8ed8Sdiuqp5qGO0FAiHc2QvHQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=kiFSbgouejWRpafPBUYpd8Tl6FsLj6DgZ/qU5B2BAGQcrZ1E2ojRrM8Riah/EiQTWilgyaGPX7bV4A1zrxh3FH0eVz9JtnPutcqITgnMqqMxOJMdxaBkpLpAqgq1kJRqxNlPbswhW10sc6CV8Fn1dWCQHingvOFutb1sxmraGb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f9KfEJIb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f9KfEJIb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBCDD1F000FF;
	Thu,  1 Oct 2026 11:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790854309;
	bh=d0rNJYwfFcyZ5A8yaNfJkusDj8/3Qger099IK4ddb9A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=f9KfEJIbojKWDQu5kTjVdVW+O6EOiF2q85uGRW8hWIQTrdwVIgVUqo19bDgbNYTzC
	 wstaSzHOxXVkagCai3t9sJ/KyRA9oDxGc46USMRCrrWqgblOybfxyu2eiEnfr5uJWb
	 8aBjAWpg6w7SkwTqQ7stwKKTb+Xv1B5luZ5EcrzsUP94sTxVnqQ7dK/DRHdYRxz+LJ
	 4xrXXDfgwih+4FSHEuAUkX6WrBcNT+Ns7+c+LLA8kW4esEnxjM9uPKHd1jOnK639mt
	 gMwKp3dRRhIwyr46FhD8YgKD6N8558mCyNVK8rr3Ilg4rpZs9t/OYu6SSg3U75jKfg
	 e24M6LKJ1AJhw==
Date: Thu, 1 Oct 2026 20:31:45 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: sashiko-bot@kernel.org, "Vineet Gupta" <vineet.gupta@linux.dev>,
 linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v3 1/1] tracing: fgraph: allocate shadow stacks inline
 with GFP_NOWAIT
Message-Id: <20261001203145.abaab4f85291cdec5e423184@kernel.org>
In-Reply-To: <20261001103752.653961F000FF@smtp.kernel.org>
References: <20261001102909.1152572-1-vineet.gupta@linux.dev>
	<20261001102909.1152572-2-vineet.gupta@linux.dev>
	<20261001103752.653961F000FF@smtp.kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, 01 Oct 2026 10:37:51 +0000
sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] tracing: mixing goto and scoped_guard in alloc_retstack_tasklist()
> --
> 
> commit eacae2b1226bb2d8684604b5c37e3ec9f073cb80
> Author: Vineet Gupta <vineet.gupta@linux.dev>
> 
> tracing: fgraph: allocate shadow stacks inline with GFP_NOWAIT
> 
> This commit updates alloc_retstack_tasklist() to allocate return stacks
> inline using GFP_NOWAIT within an RCU read-side critical section,
> replacing the fixed-batch preallocation loop. It also replaces the
> open-coded rcu_read_lock() and rcu_read_unlock() with scoped_guard(rcu)
> to handle RCU protection implicitly.
> 
> > diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
> > index 40d373d65f9b9..efb5d260334e0 100644
> > --- a/kernel/trace/fgraph.c
> > +++ b/kernel/trace/fgraph.c
> 
> [ ... ]
> 
> > @@ -1057,26 +1060,37 @@ static int alloc_retstack_tasklist(unsigned long **ret_stack_list)
> >  		}
> >  	}
> >  
> > -	rcu_read_lock();
> > -	for_each_process_thread(g, t) {
> > -		if (start == end) {
> > -			ret = -EAGAIN;
> > -			goto unlock;
> > -		}
> > +	scoped_guard (rcu) {
> 
> [Severity: Low]
> Does this code mix goto-based error handling and scope-based cleanup in the
> same function?
> 
> The alloc_retstack_tasklist() function still contains a goto free error
> handling path earlier in its body, and a free: cleanup label at the end.
> Adding scoped_guard() here violates the kernel cleanup subsystem guidelines,
> which state that for a given routine, usage of goto and cleanup helpers
> should never be mixed.
> 
> Since returning directly from within the scoped_guard() skips the free: loop
> at the end of the function, it forces manual reasoning about whether that is
> safe. This is noted in the new comment about keeping the start == end check
> in step with the exhaustion logic.
> 
> Is it possible to convert the initial return stack array allocation to use
> scope-based cleanup as well, or revert to open-coded RCU read locks, to
> avoid mixing the two patterns?

If this sends to stable kernel, I think it is better to keep using
goto in this patch, and send another cleanup later. It is allow us
to backport the patch easier.

Thank you,

> 
> > +		for_each_process_thread(g, t) {
> > +			unsigned long *rs;
> > +
> > +			if (t->ret_stack)
> > +				continue;
> > +
> > +			rs = kmem_cache_alloc(fgraph_stack_cachep, GFP_NOWAIT);
> > +			if (!rs) {
> > +				/*
> > +				 * Returning from inside scoped_guard() drops
> > +				 * the RCU read lock, but skips the free loop
> > +				 * below. That is only safe because start ==
> > +				 * end here, which leaves that loop nothing to
> > +				 * free. Keep the two in step if this
> > +				 * exhaustion check ever changes.
> > +				 */
> > +				if (start == end)
> > +					return -EAGAIN;
> > +				rs = ret_stack_list[start++];
> > +			}
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261001102909.1152572-2-vineet.gupta@linux.dev?part=1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
