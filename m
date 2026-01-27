Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E0E347C6
	for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 17:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769535952; cv=pass; b=YLKR7CQSQVYpqsQaCILyUALks35Dc/P3oCtZqMl5csiW0Mrth548Cqof+79XGDHzOe4y4LFsjvNhnqPbkscp6q99f7RGFiRl7msrtOsAvtyaStsMm74AQvwdfeHxkIA/bwe2uotvFuh1MniWJitf1EH0j24eKhgXMUhwh6NLKdo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769535952; c=relaxed/simple;
	bh=btzeLvjyBbMUtnsVSmRUhSv3uD8P7KgYjwqqfhmKp88=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F/RN6YnX69b9yd0bCfMosW42CxOkdLw0VS3JNwnW6L3BsgSubolmuWQtXl97H1rRFssbjLNdNqQlvjpQTPxlnQYpQw4fZWzOzYKuGTJfKa87/3guHDPaJ2unt6I9HZIuWYONsaWbNXzgIgUVTVPcWXn+bta7sxppa1WhPfs32mM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CCT0Vd7v; arc=pass smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CCT0Vd7v"
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-47ee76e8656so87223755e9.0
        for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 09:45:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769535950; cv=none;
        d=google.com; s=arc-20240605;
        b=eFRgRzTA0JhwXM25v/TorcJoo91Ci9/qQO9V7nPCxnWYWoEQBFkaEHpWk6l/guAuZg
         ssZ/5f3jlLLoYyJh5+r/TJ7tiYnSDKU/RwHiXFD/sEKRItHWS7Fa/0/ZcBpdXOJNtnaZ
         Am7bHgIyUMCrWl9u7POqcHMTj85qdrQLMK1RuyL6Ta8HydgtTo4pXShxP5KTTThjQPH5
         j0BplvqzpLp8zU7hLqMk7+MTM0J8ytK0t2doNZYUX4JSICcIzgyYtQMdJrFPc1WUacK8
         8Tfszgle62my5dqoHkeWtJOQrFEHIBeXCQGtcNkNj6dxjlEVhyDdQHPd/UMjeoW3J0YZ
         DSOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=e6v5C0TFk2V1M9wQ1fOB+cW3Akr/zrCp8PC3IOlrDI4=;
        fh=mV8Uwy03aTQpEc71kkKqimIDFbwq2oIhKiU5zAUO9K0=;
        b=lEjiHNkgRzMl4KeqnnitrmO/SUp84+SyPC8XS1vJt34OlFa5SJjkl3W0L4cq5kbf5B
         t6V0FAhlfyKHDrF3Bcb267J87UhT1oD+xokGUwwgw7oRRZwhzx7IJkDXc8ZHP/RZDlhx
         6ZEHlKHnRhZVFzjbPmwEaM/fAHnQIte7VY1fPbGU4ytJ4tH/BdxB24XdR+SHMG5jxFmf
         Ao20ElN3XPzbeOXURdlqwJ80RFUPEa3H3/0IS5Pf2NlY8l5aCVnzzuyeUWcuzi5fCOAQ
         9QZ5bVDjfNjGaghuMsoNWnzJK5cikobEVUbkqOfr99PvLML+TecMCTzgGh4swPI10dx6
         0chQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769535950; x=1770140750; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=e6v5C0TFk2V1M9wQ1fOB+cW3Akr/zrCp8PC3IOlrDI4=;
        b=CCT0Vd7vmED4F+T8gGySBFq1WGsyabCROwaKWPeqmQYYLkHcvXDN6R/5EwSlQc/AYj
         JE7qovRkflHfVFBe3bCBRS5wL3eawODPTwjgVez3DpqPtgwVDqSDjLjaIPXyHsIicC/u
         mD1Ag+/Be+Fnvpsi2fJ7YL6LlisNemgxyBGuNBNHu0YLzydTfhR++IIfVuyifVeeuOyg
         Hl5/sfCfGV11EBOI8/x4YKWGMZEyoprRsd/FSZVLuYVPrcn7W/uMG8FMQNUusXOjQNN2
         PikUlV3hOYJkvKOD+/i1PgQAG2A4YNUFjNvSTHi/5G8+r86j6ttgNLtOpPRcY7S80DUs
         f3+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769535950; x=1770140750;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e6v5C0TFk2V1M9wQ1fOB+cW3Akr/zrCp8PC3IOlrDI4=;
        b=UPhLJGDQbebd55ZNh9BnKJooJE5vkTb7s9M8GjTYdZlYnaFQD82zrXBskqpwZ2Z63/
         BWV1tgLqTSW9Mffq0WZKnRWHMtNTSWtzcbVd4HT4vk6jGWaMsf/b7mG7/tQ/6wB9Yw94
         qe8nLCuCAMAF0pYKx9rMhP2PV76VHrZZ2tfq9g5LnW2K+fulUs7gF5ueHFoeiL++akCj
         GochlYuU8NOhXSYBB1Vav++KecT/sHE8Uwk5rAd83fETCqUuPIWCNb+xPJ3wXOoceuC+
         pE3lxgdL1LC5oneJF+fV/gNgL0dVBOwhqYfcKVBYt4qsVgrUBnA5ygOthNm/Du1A0lNU
         dNhQ==
X-Gm-Message-State: AOJu0YzGnX9RpY4blQylWz8dub/tS0KBgnO6DJdt10WC+xUt+D0NZK8I
	bor8j3uXk+sCLzrlzFvPayl+3Fr6p+BbFFSGynrqbXxsc1Zjwl2opq9EGa210chugVlzZ6sPg0N
	NHts8nmiDyUefWihBdLsS6HiI4YkE3uE=
X-Gm-Gg: AZuq6aIgxIeCpnx9Y1BIqz7Uw1+24PacCLOIfVl+grdjX096QN2C9P3Hv6IXeLEXYa9
	LzlwCulmmctAxD5lqd7iwx+gigdAFJCsHvuv7Mtt+T+QCxv5Tb2J6WBkkeAeC67tbHLVzY4MNu6
	V7iXLHBfB712vu7DDM7c6e+1xKd3+2C2uAKtQR5vTo7LpvfZmaEQGbu+WHgZf654Ziw3oIOypVQ
	JQOgkGgKfFBSMEn7XzwMic8C48hIswiM2oR80v8bMFy4QeimKOoLlL7UVwIjURVaIT37fivRdFA
	QqOb/YJ933rSt8jZAzcaQ0Q153eoFn3T7xFHkjjNd3Iw8TiT3EZj4BqQv2mk
X-Received: by 2002:a05:600c:3b08:b0:480:19ed:7efa with SMTP id
 5b1f17b1804b1-48069c86e98mr32311785e9.36.1769535949570; Tue, 27 Jan 2026
 09:45:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260122-timer_nolock-v7-0-04a45c55c2e2@meta.com> <20260122-timer_nolock-v7-1-04a45c55c2e2@meta.com>
In-Reply-To: <20260122-timer_nolock-v7-1-04a45c55c2e2@meta.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 27 Jan 2026 18:45:13 +0100
X-Gm-Features: AZwV_QjVpHSOUZKrXG0yeQJF6_pmI6Uhk4w7wMWZuYPLMQNbLmjxILi6PWyY2DU
Message-ID: <CAP01T74WHyfVvtb8E+f7=B-yTHjJ+4qxDpO_RDdOZj6LW275pQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v7 1/8] bpf: Enable bpf timer and workqueue use
 in NMI
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, eddyz87@gmail.com, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"

Resending because I screwed up formatting.

On Thu, 22 Jan 2026 at 19:03, Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> Refactor bpf timer and workqueue helpers to allow calling them from NMI
> context by making all operations lock-free and deferring NMI-unsafe
> work to irq_work.
>
> Previously, bpf_timer_start(), and bpf_wq_start()
> could not be called from NMI context because they acquired
> bpf_spin_lock and called hrtimer/schedule_work APIs directly. This
> patch removes these limitations.
>
> Key changes:
>  * Remove bpf_spin_lock from struct bpf_async_kern.
>  * Initialize/Destroy via setting/unsetting bpf_async_cb pointer
>    atomically.
>  * Add per-bpf_async_cb irq_work to defer NMI-unsafe
>    operations (hrtimer_start, hrtimer_try_to_cancel, schedule_work) from
>    NMI to softirq context.
>  * Use the lock-free seqcount_latch_t to pass operation
>    commands (start/cancel/free) and parameters
>    from NMI-safe callers to the irq_work handler.
>  * Add reference counting to bpf_async_cb to ensure the object stays
>    alive until all scheduled irq_work completes.
>  * Move bpf_prog_put() to RCU callback to handle races between
>    set_callback() and cancel_and_free().
>  * Modify cancel_and_free() path:
>    * Detach bpf_async_cb.
>    * Signal destruction to irq_work side via setting last_seq to
>      BPF_ASYNC_DESTROY.
>    * On receiving BPF_ASYNC_DESTROY, cancel timer/wq.
>  * Free bpf_async_cb on refcnt reaching 0, wait for both rcu and rcu
>    task trace grace periods before freeing the bpf_async_cb. Removed
>    unnecessary rcu locks, as kfunc/helper allways assumes rcu or rcu
>    task trace lock.
>
> This enables BPF programs attached to NMI-context hooks (perf
> events) to use timers and workqueues for deferred processing.
>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

>  [...]

> +
> +static int bpf_async_read_op(struct bpf_async_cb *cb, enum bpf_async_op *op,
> +                            u64 *nsec, u32 *flags)
> +{
> +       u32 seq, idx;
> +       s64 last_seq;
> +
> +       while (true) {
> +               last_seq = atomic64_read_acquire(&cb->last_seq);
> +               if (unlikely(last_seq > U32_MAX)) { /* Check if terminal seq num has been set */
> +                       s64 expected = BPF_ASYNC_DESTROY;
> +
> +                       if (last_seq != BPF_ASYNC_DESTROY)
> +                               return -EBUSY;
> +
> +                       if (!atomic64_try_cmpxchg_release(&cb->last_seq,
> +                                                         &expected,
> +                                                         BPF_ASYNC_DESTROYED))
> +                               return -EBUSY; /* Someone else set it to DESTROYED, bail */
> +
> +                       *op = BPF_ASYNC_CANCEL;
> +                       return 0;
> +               }
> +
> +               seq = raw_read_seqcount_latch(&cb->latch);
> +
> +               /* Return -EBUSY if current seq is consumed by another reader */
> +               if (seq == last_seq)
> +                       return -EBUSY;
> +
> +               idx = seq & 1;
> +               *nsec = cb->cmd[idx].nsec;
> +               *flags = cb->cmd[idx].mode;
> +               *op = cb->cmd[idx].op;
> +
> +               if (raw_read_seqcount_latch_retry(&cb->latch, seq))
> +                       continue;
> +
> +               /* Commit read sequence number, own snapshot exclusively */
> +               if (atomic64_try_cmpxchg_release(&cb->last_seq, &last_seq, seq))
> +                       break;

I guess you could fold in the change we discussed offline here:

return atomic64_try_cmpxchg_release(&cb->last_seq, &last_seq, seq) ? 0 : -EBUSY;

> [...]
>
