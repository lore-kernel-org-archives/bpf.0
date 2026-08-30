Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8B634AAE9
	for <bpf@vger.kernel.org>; Sun, 30 Aug 2026 10:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788086879; cv=none; b=l7IzGxdVt3wbn2b7YHdBuhj4bIay24xsN/5ieopRxBqiHgsJuBDNKHMPfOWPJR10HAc27ObbX+tgTF2jSXYQz6eVWAKLRMV8spTPe1qH4CGzhJGNsewWM4LrhA+oYpe6lTEtzp0sMMfdYcA4rlvGnAV98c542WIKU7UwDl9VyNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788086879; c=relaxed/simple;
	bh=hNnia8XhPnLSk/A4GBDY7Zj6mbERNjo+mWH67W2qXs8=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=BFcXHNqTqNmtFtT01nJCZfINeBDg2RI/MdLI8HCQd1xMeFjTtBOVpFlHxDOt7QlrnDV+pz/cJ9TIUSUwpYuYagLb1t4xoKSFFo5t35bsS+J40aUFh7raESZf6FKd77BM0dNK+5jg+nIP7UJU1tohbwgs56cXbr7ecQHAlmpnPCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n4+VIlH/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n4+VIlH/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E9701F000E9;
	Sun, 30 Aug 2026 10:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788086877;
	bh=sCvbdnWMJj0VyD1TY1Nrr1eB7ATeeEyKqBtwvs59pYc=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=n4+VIlH/7/S+8VOjHKPwuCMouV/Fua1EZtyN8Fr9BNAeK9D0VxNrIoGNBQnIYD9Ym
	 uTBozi3iKHGEForSMWip6iu/qMu1iX7YOb1hD7/aHjKNfOFOkscc4zzadKRpVe5mpb
	 qaWbrwShwt5kvBGHCNd8/8hWUUtOViKMGkHus1qRRPcTEQc1m7hNguLn5raXdmvniq
	 4uNcdqQ+jAp9baVq9P8wn8ibn0Vdfv1P3M9qxDskOOnX7a7w/zXDX5K8Op70/7llVF
	 fRdEU1ZYpqz0yPMHmPE1uRPFUUcF/v3I4hamYAh9ADFPMC5VNtsmrEAkJ9eGODss7x
	 ziadsQaGFddRw==
Content-Type: multipart/mixed; boundary="===============0296533559413182563=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <543396a8e803885371e65b85708a98f89365d669e4a3e91e93390dd31998e7f5@mail.kernel.org>
In-Reply-To: <20260830093514.4105972-2-memxor@gmail.com>
References: <20260830093514.4105972-2-memxor@gmail.com>
Subject: Re: [PATCH bpf-next v1 1/6] bpf: Add file descriptor interface for program streams
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,tj@kernel.org,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sun, 30 Aug 2026 10:47:57 +0000 (UTC)

--===============0296533559413182563==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 3a7eb2185c354..1745686331be0 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h

[ ... ]

> diff --git a/kernel/bpf/stream.c b/kernel/bpf/stream.c
> index 2b80a0599865e..d3dbb1aca792f 100644
> --- a/kernel/bpf/stream.c
> +++ b/kernel/bpf/stream.c
> @@ -2,11 +2,14 @@
>  /* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
>
>  #include <linux/bpf.h>
> +#include <linux/anon_inodes.h>
>  #include <linux/filter.h>
>  #include <linux/bpf_mem_alloc.h>
>  #include <linux/gfp.h>
>  #include <linux/memory.h>
>  #include <linux/mutex.h>
> +#include <linux/poll.h>
> +#include <linux/refcount.h>
>
>  static void bpf_stream_elem_init(struct bpf_stream_elem *elem, int len)
>  {
> @@ -83,6 +86,8 @@ static int bpf_stream_push_str(struct bpf_stream *stream, const char *str, int l
>  	ret = __bpf_stream_push_str(&stream->log, str, len);
>  	if (ret)
>  		bpf_stream_release_capacity(stream, len);
> +	else if (len)
> +		wake_up_interruptible_poll(&stream->waitq, EPOLLIN | EPOLLRDNORM);
>
>  	return ret;
>  }

Can this wake_up_interruptible_poll call run from NMI context?
bpf_stream_push_str is reached from bpf_stream_vprintk, which is registered
in common_btf_ids for BPF_PROG_TYPE_UNSPEC (kernel/bpf/helpers.c:4968,
5007), making it callable from NMI-capable perf_event and kprobe programs.

wake_up_interruptible_poll unconditionally does
spin_lock_irqsave(&wq_head->lock) (kernel/sched/wait.c:118-130), which can
deadlock if a reader blocked in wait_event_interruptible holds stream->waitq
lock when an NMI fires on the same CPU and tries to re-acquire it.

On PREEMPT_RT the breakage is unconditional: spinlock_t is a sleeping
rt_mutex, and rt_spin_lock calls might_sleep, which BUGs when called with
IRQs disabled and preempt_count != 0.

The bpf_stream_vprintk kfunc also carries KF_SPINLOCK_SAFE, meaning it is
allowed inside bpf_spin_lock-ed regions after local_irq_save +
preempt_disable + arch_spin_lock, where acquiring a spinlock_t is similarly
illegal.

bpf_ringbuf handles this by calling irq_work_queue instead of waking the
wait queue directly:

kernel/bpf/ringbuf.c:bpf_ringbuf_commit() {
    ...
    irq_work_queue(&rb->work);
}

kernel/bpf/ringbuf.c:bpf_ringbuf_notify() {
    wake_up_all(&rb->waitq);
}

Should the wakeup be deferred to an irq_work callback?

> @@ -215,6 +220,102 @@ int bpf_prog_stream_read(struct bpf_prog *prog, enum bpf_stream_id stream_id, vo
>  	return bpf_stream_read(stream, buf, len);
>  }
>
> +static bool bpf_stream_has_data(struct bpf_stream *stream)
> +{
> +	return atomic_read(&stream->capacity) > 0;
> +}
> +
> +static void bpf_stream_put(struct bpf_stream *stream)
> +{
> +	if (refcount_dec_and_test(&stream->refcnt)) {
> +		struct llist_node *list;
> +
> +		list = llist_del_all(&stream->log);
> +		bpf_stream_free_list(list);
> +		bpf_stream_free_list(stream->backlog_head);
> +		mutex_destroy(&stream->lock);
> +		kfree(stream);
> +	}
> +}
> +
> +static int bpf_stream_release(struct inode *inode, struct file *file)
> +{
> +	bpf_stream_put(file->private_data);
> +	return 0;
> +}
> +
> +static ssize_t bpf_stream_file_read(struct file *file, char __user *buf, size_t len,
> +				    loff_t *ppos)
> +{
> +	struct bpf_stream *stream = file->private_data;
> +	int ret;
> +
> +	if (len > INT_MAX)
> +		return -EINVAL;
> +	if (!len)
> +		return 0;
> +
> +	for (;;) {
> +		ret = bpf_stream_read(stream, buf, len);
> +		if (ret)
> +			return ret;
> +		if (READ_ONCE(stream->dead))
> +			return 0;
> +		if (file->f_flags & O_NONBLOCK)
> +			return -EAGAIN;
> +
> +		ret = wait_event_interruptible(stream->waitq,
> +					       bpf_stream_has_data(stream) ||
> +					       READ_ONCE(stream->dead));
> +		if (ret)
> +			return ret;
> +	}
> +}
> +
> +static __poll_t bpf_stream_poll(struct file *file, struct poll_table_struct *pts)
> +{
> +	struct bpf_stream *stream = file->private_data;
> +	__poll_t events = 0;
> +
> +	/*
> +	 * poll_wait() only registers the wait queue callback. Register before
> +	 * checking persistent state so a concurrent publication or teardown is
> +	 * observed either by the callback or by the checks below.
> +	 */
> +	poll_wait(file, &stream->waitq, pts);
> +	if (bpf_stream_has_data(stream))
> +		events |= EPOLLIN | EPOLLRDNORM;
> +	if (READ_ONCE(stream->dead))
> +		events |= EPOLLHUP;
> +	return events;
> +}

Does bpf_stream_has_data reliably indicate readable data?

The function tests stream->capacity, but capacity is a reservation counter
charged before data is published. Both producers call
bpf_stream_consume_capacity first, then allocate the element and llist_add
it:

kernel/bpf/stream.c:bpf_stream_push_str() {
    ret = bpf_stream_consume_capacity(stream, len);
    if (ret)
        return ret;

    ret = __bpf_stream_push_str(&stream->log, str, len);
    ...
}

kernel/bpf/stream.c:bpf_stream_stage_commit() {
    ret = bpf_stream_consume_capacity(stream, ss->len);
    if (ret)
        return ret;
    ...
    llist_add_batch(head, tail, &stream->log);
}

So capacity > 0 is observable while stream->log is still empty and nothing
is readable. If a producer is preempted or descheduled between the
reservation and the publication, the window widens.

For poll, this means reporting EPOLLIN with no data present. A level-
triggered epoll consumer wakes, calls read, gets -EAGAIN, and re-polls
immediately, spinning at 100% CPU until the data is published or the
reservation is released.

For the blocking read loop above, wait_event_interruptible returns
immediately because its condition is already true. The for loop re-runs
bpf_stream_read (returns 0), checks dead (false), checks O_NONBLOCK (clear),
and calls wait_event_interruptible again with the same result. The loop
spins without reaching schedule, so it is not interruptible by a signal and
only preemptible.

Per locking.md section 6 (Multi-Variable Races), the readiness flag and the
data must be published together. Could the code use a dedicated atomic
counter incremented after llist_add / llist_add_batch and decremented by the
consumer, so the readiness predicate reflects actual readable bytes?

> @@ -366,6 +482,7 @@ int bpf_stream_stage_commit(struct bpf_stream_stage *ss, struct bpf_prog *prog,
>  		list = tail;
>  	}
>  	llist_add_batch(head, tail, &stream->log);
> +	wake_up_interruptible_poll(&stream->waitq, EPOLLIN | EPOLLRDNORM);
>  	return 0;
>  }

This second wake_up_interruptible_poll call has the same NMI-context
concern. bpf_stream_stage_commit is reached from
bpf_prog_report_rqspinlock_violation (kernel/bpf/rqspinlock.c:673), which
runs from bpf_res_spin_lock_irqsave after preempt_disable + local_irq_save
with an rqspinlock held, and from __bpf_prog_report_arena_violation
(kernel/bpf/arena.c:1137) invoked from the JIT exception handlers.

Both paths are hard-atomic contexts where acquiring a spinlock_t is illegal.

Should this wakeup also be deferred to irq_work?

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33304989971
--===============0296533559413182563==--
