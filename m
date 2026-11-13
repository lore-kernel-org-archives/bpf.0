Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794539116;
	b=1aypsy+Bh58JMBLsJSO7h4jmJQ8MUUQkCEyacRprFiuXbVy/XQb/HQDdpPZ4jhG9+VYb
	 Zw32NoY8eeZ6x8sks3zrwtEx6nbGM9lZ4IfNOvMDrOTxswhA2wln1fYFEkEYMJ3ZBUm8s
	 ISRfa3VZmkXDQSRBHwgbmmTQawy6dEzmY5jRq4pPjKCz5/U5RCafv7TqEvT5HrzXnEGbP
	 1JZXuEsY88ExaoCRqIhvz/BjYw8N9kIWo1iOvatLJE+pBkKUSQ6IkSoJjElpZbHjq5Ogv
	 m/B6KfsH6jrLU1bKy/LWY5l9271odA03qRhmCR6TkMooV6in4+XE1kdps8ZQFEUP1Mg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794539116;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=jNB7W//7JP+AU0kGw/bmy15q+GCRPvpGya5e+wAjm4o=;
	b=B2crlxpkvKJoV/s4u4n56qbJhfRejwm+JltekWZh/PUKJO4hPNTB6RbQ9FB8WriHtVVE
	 t0NHUf636IurQnf+X+pQ44Noq10jyEX0VwncLOYFHapBCglu4hQe+gb14efzm9Ar/5adU
	 SlYl7t8lf3CIiGzhxLsCOnrx8hlFbe1gI8MMdinjevs4w16f8ThPt1IRHoSkZUW6ABur2
	 003TuJexiL8ry3h8lMZipu4prPbFgZfaLp+svcrbR9PH000d5T5dZlV0j8QC9AQOUdPsa
	 VAN8/rrJifjoEEQLvkhNPQA12H8uQLh0vVPAqoz2YuHyeFLA/2o+9skMbTlsuUh9j+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="g6/t3vEU";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2DB7606A31C;
	Fri, 13 Nov 2026 03:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g6/t3vEU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAF981F000C4;
	Fri, 13 Nov 2026 03:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794539116;
	bh=jNB7W//7JP+AU0kGw/bmy15q+GCRPvpGya5e+wAjm4o=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=g6/t3vEUsbXDMVqiM26ZOsj0RK7ASV9gw7gJjSf8FzKK1rpjq4GTq2C8+pjmRtYNf
	 fap+svi60qaDDZBXnCOspek3hDYg7F9i3MTgXl4EVQPSn+Fn9Ytvph8hGY9VhIVm9M
	 UyBp5eElPN/lZ3JS7V5de5LCrHRdfITY8B0TNqjbOJ1nfVG0dcA+9oV8bAHMYNPz+R
	 1XEWbMQEtANJ85LkeKIzLTDMzFKaznrnH3GfqKm7Zys2/31r0LFhqI7xLpcN8RKm/x
	 jclze15Yxm2fXKSyIHiJQkLSI3+aIvG1YTOABxjlc+I8FVcryOXJLby6PfM+srh8b5
	 d91+oPZzoxmPw==
Content-Type: multipart/mixed; boundary="===============5277389857893964114=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <89f7ed00d7373ea7389e563810fbcd7ae775858e7fb592ad6e12cc1d1aee2565@mail.kernel.org>
In-Reply-To: <20261112144935.583937-3-cui.tao@linux.dev>
References: <20261112144935.583937-3-cui.tao@linux.dev>
Subject: Re: [PATCH 2/2] sched_ext: Block a retained donor before PI deboost routes it back to sched_ext
From: bot+bpf-ci@kernel.org
To: cui.tao@linux.dev,tj@kernel.org
Cc: void@manifault.com,arighi@nvidia.com,changwoo@igalia.com,mingo@redhat.com,peterz@infradead.org,sched-ext@lists.linux.dev,linux-kernel@vger.kernel.org,bpf@vger.kernel.org,cui.tao@linux.dev,cuitao@kylinos.cn,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri, 13 Nov 2026 03:05:14 +0000 (UTC)

--===============5277389857893964114==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> sched_ext: Block a retained donor before PI deboost routes it back to sched_ext

TL;DR:
- Possible WARN_ON_ONCE from a double rq clock update on every rt/dl to ext PI
  deboost when WARN_DOUBLE_CLOCK is enabled
- Changelog's "only entry path" claim may be wrong: sched_setscheduler() can
  also skip blocking donors
- Peter Zijlstra rejected this hook; is it still intended?

>     sched_ext: Block a retained donor before PI deboost routes it back to sched_ext
>
>     rt_mutex_setprio() is the only entry path into sched_ext that does not
>     block a retained donor: an ext task PI-boosted by an rt waiter can
>     block on a second kernel mutex while boosted, and on deboost is routed
>     back to sched_ext carrying the queued+blocked state that
>     scx_prepare_setscheduler() promises never happens; every PI cycle
>     hands the BPF scheduler a queued+blocked donor it never admitted.
>
>     Call scx_prepare_task_sched_change() before the sched_change guard when
>     the class change routes the task back to sched_ext, which performs the
>     missing sched_proxy_block_task() (plus an update_rq_clock() that is
>     harmless here: the clock was already advanced, so the second advance
>     only applies a small delta). The boost direction (ext -> rt) needs no
>     handling.
>
>     Fixes: be8be8acb268 ("sched_ext: Block proxy donors before taking control")
>     Signed-off-by: Tao Cui <cuitao@kylinos.cn>

The changelog says rt_mutex_setprio() is the only entry path into sched_ext
that does not block a retained donor.  Is that accurate?

In __sched_setscheduler(), scx_prepare_setscheduler() only blocks the donor
when policy == SCHED_EXT.  With a BPF scheduler loaded without
SCX_OPS_SWITCH_PARTIAL, task_should_scx() returns true for every policy, so
__setscheduler_class(SCHED_NORMAL, ...) returns &ext_sched_class.

That means sched_setscheduler(pid, SCHED_NORMAL) on a SCHED_FIFO or
SCHED_DEADLINE task that is being retained as a mutex-blocked donor routes it
into sched_ext without scx_block_proxy_donor() being called.  The same
applies to normalize_rt_tasks() via sysrq-n.

The new comment in rt_mutex_setprio() also says "the same way the other entry
points into sched_ext do".

Should scx_prepare_setscheduler() be keyed on the resulting class like the new
check, or should the changelog be reworded?

> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index f7a452123ef5..dcb16b006740 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c

[ ... ]

> @@ -7816,6 +7816,18 @@ void rt_mutex_setprio(struct task_struct *p, struct task_struct *pi_task)
>  	if (prev_class != next_class)
>  		queue_flag |= DEQUEUE_CLASS;
>
> +	/*
> +	 * PI boost can route @p out of sched_ext: policy stays SCHED_EXT but
> +	 * __setscheduler_class() follows the effective rt prio, and rt/fair
> +	 * may have retained @p on the rq as a blocked donor. Block it before
> +	 * sched_change_begin() records the queued state, the same way the
> +	 * other entry points into sched_ext do.
> +	 */
> +#ifdef CONFIG_SCHED_CLASS_EXT
> +	if ((queue_flag & DEQUEUE_CLASS) && next_class == &ext_sched_class)
> +		scx_prepare_task_sched_change(p);
> +#endif

rt_mutex_setprio() has already called update_rq_clock() after taking the rq
lock, and the rq is not unpinned in between, so RQCF_UPDATED is still set.
scx_prepare_task_sched_change() then calls update_rq_clock(task_rq(p))
unconditionally, before checking whether @p is a retained donor.

update_rq_clock() does:

    if (sched_feat(WARN_DOUBLE_CLOCK))
        WARN_ON_ONCE(rq->clock_update_flags & RQCF_UPDATED);

Can this warn on every rt/dl -> ext deboost when WARN_DOUBLE_CLOCK is
enabled?  For example, an ext task holding a PI futex that was boosted by a
SCHED_FIFO waiter and then unlocks:

mark_wakeup_next_waiter()
  rt_mutex_adjust_prio()
    rt_mutex_setprio()
      update_rq_clock()
      scx_prepare_task_sched_change()
        update_rq_clock()   <- WARN_ON_ONCE(RQCF_UPDATED)

This does not need CONFIG_SCHED_PROXY_EXEC, since without it
sched_proxy_block_task() is an empty stub and the clock update is all the
call does.

The comment on scx_prepare_task_sched_change() says the caller must pass
DEQUEUE_NOCLOCK so the rq clock is updated only once, and the commit message
calls the second update "harmless".  scx_prepare_setscheduler(), whose caller
has already updated the rq clock, calls scx_block_proxy_donor() directly.
Would a variant without the clock update, or exposing scx_block_proxy_donor()
to core.c, avoid this?

Peter Zijlstra also replied to this patch on the list: "I can't understand
this. And I take a very dim view of sprinking magic hooks like this. So no."

He proposed instead having sched_class->switching_to() return a bool saying
whether the class accepts blocked tasks, with sched_change_end() blocking the
task.  Andrea Righi agreed to take that approach over, noting that the block
must not dequeue a second time, donor and ctx->running must be reset, and
DEQUEUE_NOCLOCK must be dropped.

This patch still adds the explicit sched_ext specific call in
rt_mutex_setprio().  Is this approach still intended given that discussion?

---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/43353689014
--===============5277389857893964114==--
