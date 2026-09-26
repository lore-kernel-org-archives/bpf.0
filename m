Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B154C2931F1;
	Sat, 26 Sep 2026 00:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790383614; cv=none; b=TRUMVuyxKde3Ibr5nsUDuct5bmdiL9E2/6OcxjVyiKeWZSLmi4KBFFRdk766kDaZ27jSVV0yqAdqYMHqfbPZspeeK+RXp9tMbB7FFs4DZ1NFmQSJmvJzChTnC+E89hudUmI9CW60SFFI+Ou59lL/1nifk4qqr1vkIjl5nuDoAoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790383614; c=relaxed/simple;
	bh=DKdq3voB47uzGIch1glrSHGpfqUBBs9eBQrk1bu6Gqk=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=GFTQ/O8kqAecCkckjBbmrlr5rM4jXZanuKX2XtAI6dMyCJHXzXcQhTWF+D+MwNWhW7M6XfNrc8jaRry2rbuNBV9tTRWbqAexWPkUubz4WQ+EyXQfBFtPSq7uNqzcQI3ggZNKltncjfZ7nYkPaE+Vez3yhcYHHDR1dkvrzyv7uaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hgUQgDA8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hgUQgDA8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44CE61F000FF;
	Sat, 26 Sep 2026 00:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790383613;
	bh=hJCxWty+NRCNWggDVWTk+vRAamuJiEacabDIAt3udy8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=hgUQgDA8giVxde4VVjbJwhWi8tJ5KxklKgZ7mT3kz4Rpb7mzqxGryvD48SXl/NBB0
	 kl1x1Q5H9aurhS8tfPSMZ6p/wQTQRNbF7t2UObEOik33qd/1hWjU5D2JfL3Exji/yU
	 QRZUTMHTyDY5FWz3Sf6XzMByHYnu8DJw0eINPHwYaGw9RylpZSEdRWrBzerOZy2F+P
	 v7GZRWcyrI7338WrDYn/aGExoKtZ+mcD7SsGWZRT0LEIaiTVenS1IkJECDv7Rhi39t
	 N07xAC02FpuNfHIyai6iQYsJj7KQJUYmRA1sImU9VakwD271AozshmwVt4COPoWU4W
	 otnF8MP8bd4yw==
Content-Type: multipart/mixed; boundary="===============4005590161933855054=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <b03043f923291b82f8491c1f713a7017bb807171e1f577f6f431116813c3ce70@mail.kernel.org>
In-Reply-To: <20260924130503.853919-1-usama.arif@linux.dev>
References: <20260924130503.853919-1-usama.arif@linux.dev>
Subject: Re: [PATCH v2] sched_ext: Update scx_dispatch_dequeue() comments
From: bot+bpf-ci@kernel.org
To: usama.arif@linux.dev,arighi@nvidia.com,bpf@vger.kernel.org,bsegall@google.com,changwoo@igalia.com,dietmar.eggemann@arm.com,etsal@meta.com,juri.lelli@redhat.com,kprateek.nayak@amd.com,linux-kernel@vger.kernel.org,mgorman@suse.de,mingo@redhat.com,peterz@infradead.org,rostedt@goodmis.org,sched-ext@lists.linux.dev,tj@kernel.org,vincent.guittot@linaro.org,void@manifault.com,vschneid@redhat.com,yphbchou0911@gmail.com
Cc: usama.arif@linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sat, 26 Sep 2026 00:46:52 +0000 (UTC)

--===============4005590161933855054==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> index 3219f0da0fe4..ed5b3d954a45 100644
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c
> @@ -1766,10 +1766,10 @@ void scx_dispatch_dequeue(struct rq *rq, struct task_struct *p)
>  			list_del_init(&p->scx.dsq_list.node);
>
>  		/*
> -		 * When dispatching directly from the BPF scheduler to a local
> -		 * DSQ, the task isn't associated with any DSQ but
> -		 * @p->scx.holding_cpu may be set under the protection of
> -		 * %SCX_OPSS_DISPATCHING.
> +		 * When dispatch_to_local_dsq() or remote consumption moves a
> +		 * task to a local DSQ, the task isn't associated with any DSQ
> +		 * but @p->scx.holding_cpu may be set. Clearing holding_cpu
> +		 * tells dispatch_to_local_dsq() that it lost to a dequeue.
>  		 */
>  		if (p->scx.holding_cpu >= 0)
>  			p->scx.holding_cpu = -1;

Can remote consumption actually reach this !dsq branch with holding_cpu
set?  The commit message and the new comment both say it does, but looking
at the code path:

Remote consumption goes through scx_consume_dispatch_q() ->
consume_remote_task() -> unlink_dsq_and_switch_rq_lock().  That function
sets holding_cpu but never clears p->scx.dsq:

    WARN_ON_ONCE(p->scx.holding_cpu >= 0);
    scx_task_unlink_from_dsq(p, dsq);
    p->scx.holding_cpu = cpu;

scx_task_unlink_from_dsq() also leaves p->scx.dsq alone. This is on
purpose: the kernel-doc of unlink_dsq_and_switch_rq_lock() says the goal
is to "maintain the invariant that @p->scx.dsq can only change while
@src_rq is locked, which e.g. scx_dump_task() depends on."

Only two places set p->scx.dsq = NULL: scx_dispatch_dequeue() itself at
the end of this function, and dispatch_dequeue_locked().

So while a remote-consumed task has holding_cpu >= 0, p->scx.dsq still
points to the source DSQ. Every scx_dispatch_dequeue() call for such a
task takes the dsq-present branch below, not the !dsq branch:

- Racing dequeue on src_rq (dequeue_task_scx/set_next_task_scx): dsq !=
  NULL, so it locks dsq->lock, sees holding_cpu >= 0, and clears
  holding_cpu and p->scx.dsq together.

- The consumer's own successful move: move_remote_task_to_local_dsq() ->
  deactivate_task(src_rq, p, 0) -> dequeue_task_scx() ->
  scx_dispatch_dequeue(). dsq is still the source DSQ, so the dsq-present
  else branch runs and resets holding_cpu. There is no race in this case.

holding_cpu >= 0 together with dsq == NULL can only come from
dispatch_to_local_dsq(). That path sets holding_cpu while the task is in
BPF custody, where p->scx.dsq is NULL. Callers are finish_dispatch() and
process_ddsp_deferred_locals().

Should the comment and commit message drop the "or remote consumption"
part?  The dsq-present branch comment below might also benefit from noting
that consume_remote_task()'s own deactivate_task() also ends up there,
not just the racing case.

> @@ -1789,10 +1789,10 @@ void scx_dispatch_dequeue(struct rq *rq, struct task_struct *p)
>  		scx_task_unlink_from_dsq(p, dsq);
>  	} else {
>  		/*
> -		 * We're racing against dispatch_to_local_dsq() which already
> -		 * removed @p from @dsq and set @p->scx.holding_cpu. Clear the
> -		 * holding_cpu which tells dispatch_to_local_dsq() that it lost
> -		 * the race.
> +		 * We're racing against unlink_dsq_and_switch_rq_lock(),
> +		 * which already removed @p from @dsq and set
> +		 * @p->scx.holding_cpu. Clear holding_cpu to tell
> +		 * unlink_dsq_and_switch_rq_lock() that it lost the race.
>  		 */
>  		WARN_ON_ONCE(!list_empty(&p->scx.dsq_list.node));
>  		p->scx.holding_cpu = -1;


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/36204647163
--===============4005590161933855054==--
