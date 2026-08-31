Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44F13DB625;
	Mon, 31 Aug 2026 09:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788168752; cv=none; b=aOyda9zfCPvs9j7xqTnkMEvdyoJoTxYR8zqtXnc0WNcaB3/tTQG20YQqGoIeIgier6oPl4CmbLhh0gUY5n528O7zTCoh/fpCtO/xnwIe7WugwrC204Hf2PTAJQQmAaq2f+C+U/5x5Re8gtbenYLn5mmNU5gVXhFnznRLxlx+OOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788168752; c=relaxed/simple;
	bh=i1NHXdvS4HQ//YSnYHlLct4qHuR+QlqbEd9w858VRCs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fMSsaTi/mgR2cVVO/Lp1GBbGxo0MYqUnleYETYMWtyUl9Tn5a5CwpgLd9mleX/Touv7ANT/1qq1U9Xuiwk44NB7XKdKEg52NrAFCmM7ugfpOsF8nOBEttWQvFvdNR1vo0j8gPrPewTIXMjYfB/i8Hkf40m0pBdDK5MkDYJioBq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K3Moitbr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K3Moitbr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F9FE1F00ACA;
	Mon, 31 Aug 2026 09:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788168751;
	bh=uVq8q2/iYOwTfVRqeig5X+ukQdl7MUjSsMFzxaZLvwg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=K3MoitbrX6NZWHPadf2IfHtryksMFB1QaKGy4cdNOZhws1TVEN7OLrloycwlROB8+
	 1Ty2T4vu4k5xIeLDLK3lp9RDLu8hvv1y505sgmvCUdXnWPaJlaZiofukv2yR/3nwzC
	 bq57WxLuo5bvWmJvZeiQEHL6MuGyKOBlP2IZwMbBojesWxkIndCQP8XRXiOy+vIsRh
	 7SKe6N2LfG7VG/aGUf/rSEWxhfjc3qfX4QNz7JUCF26FzpxAUXmHDAeMKtaCWeacQo
	 rqjp87UkIl9OgLxNn0LERTRW4iV4kbY5KWnefHPanfHQ6UBe08kr9CUMb2/krk1kLR
	 XDwLwlj+Kaf5Q==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 01/20] sched: Add task enqueue/dequeue trace points
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gabriele Monaco" <gmonaco@redhat.com>
Cc: bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260831090524.106845-2-gmonaco@redhat.com>
References: <20260831090524.106845-1-gmonaco@redhat.com>
 <20260831090524.106845-2-gmonaco@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 09:32:30 +0000
Message-Id: <20260831093231.1F9FE1F00ACA@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The `sched_enqueue_tp` tracepoint is invoked before the schedule=
r class has actually enqueued the task, resulting in trace consumers observ=
ing stale task state.
--

commit cd98b289fdbaccae680f140f19c0e9bd5dd972b6
Author: Nam Cao <namcao@linutronix.de>

sched: Add task enqueue/dequeue trace points

This commit adds tracepoints into the scheduler's enqueue and dequeue paths
to allow tracing task scheduling events.

> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index f78275192036b..8561ca324943a 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
[ ... ]
> @@ -2181,6 +2183,9 @@ unsigned long get_wchan(struct task_struct *p)
> =20
>  void enqueue_task(struct rq *rq, struct task_struct *p, int flags)
>  {
> +	if (trace_sched_enqueue_tp_enabled() && !(flags & ENQUEUE_DELAYED))
> +		trace_sched_enqueue_tp(p, cpu_of(rq));
> +
[Severity: Medium]
Because this tracepoint is placed at the beginning of the function, prior to
p->sched_class->enqueue_task(), will trace consumers observe stale task
state?

For example, it seems that when the tracepoint triggers here, metrics like
se.vruntime have not yet been denormalized for the new runqueue, the EEVDF
se.deadline has not been recomputed, and on_rq is still 0.

Does it make sense to move this after the class-specific enqueue operation
completes, mirroring how dequeue_task() handles this by emitting
trace_sched_dequeue_tp() after calling p->sched_class->dequeue_task()?

>  	if (!(flags & ENQUEUE_NOCLOCK))
>  		update_rq_clock(rq);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831090524.1068=
45-1-gmonaco@redhat.com?part=3D1
