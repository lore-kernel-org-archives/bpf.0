Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430E13EDAB7
	for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 21:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768943849; cv=none; b=FR0OAQbUVFjAi0TpqZfG6UrRi1oDutxaHrwxSlBvi1/0I81zS534IU0kq+OfiVUhT9AvYfxX5PHbgH2W+dGDxo1FIbmt6heb+3Qg2jYTkU6nphtFAo9oNzUXEWKqLO+9OOaWhVkGT/xHvUFy4yiSYe5GUYnQ5HzF3w6ckgop0E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768943849; c=relaxed/simple;
	bh=WnunuGwC7zHGaS+Ldd9zVUkoEmxLNVRADah0unJHRgE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IgfWnceGkGgmpzH5OZw90LxGiyXxNH7I6B+CX1W+AHVUFdGzKQq3yiJYcVescnWoi+otzohJsKHnPunbPGgKhRZFd4q9TMtCBBVm2ZWi0BfMgMgzv0yxlRgtzR1COKXBDHLySE/m8c+7hAcq/KkMN1vZRvCruHmy4Q1sKzB0RaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XcyncFdl; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XcyncFdl"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-47ee07570deso41159125e9.1
        for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 13:17:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768943845; x=1769548645; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RBNABxiQXCXzGyXchHtszx/v21czbZDOX8uZG2Wzvek=;
        b=XcyncFdla/rbzmGQppHZs2O9qf71LPWAmGWbOItAHnMlo1X/HpcfS3xGLcyyT+Vbjl
         as1xiw/Ps2T9fCHRI34At+K3cLEW/Pk/GGsyP70z9Zy2pOMpX2BDUHUT0qrwpwQNEfCg
         xwGWQuhOwwkXoalogzeu5zL8NvttIvsF45I1RVcsuACnmFSxcuYx4mdVKRL3L4/0pODm
         1S3KKNDihTQZ26xg2AghW/i01DNT+1/En8nIePishiI9YTkraEbjWJXytdJlCuKuRHrM
         415YskmhEyLzqIWP72oH1j4kdVqnoyPArfUpCEf2ecR+xCEnf1VPD5K+ett7c5YXC4Ig
         /fvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768943845; x=1769548645;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RBNABxiQXCXzGyXchHtszx/v21czbZDOX8uZG2Wzvek=;
        b=UCKsvbo/JpnTdV68ZewzLdEpUkPkE0sXq95GYJNy0LEQzId9/N+wKpSrByT+v8+KuZ
         ig7dwiqzRNvkCdh7jqBT/rbsm0eKnJR6MvE2EQSwEUR7Qzyo/pICWvrB+FhpOy8JX9cy
         cDaaHml0XN2SrAa38a0Vp8m4QiLJJ2+qkl0wFtw9XdZMWvIl/QjQKzrKsIvtRdLzoeXh
         4hy1F176WRKPaxhrKdXuvJVl9TYz68uUsSF0Db8sEMfezinUloDn/vM3fuJfycx7I+rf
         j/tu83NshtOqTvFzd3wMp5JpjbI4yiuhx6pBow1UU/+sdyLhGssurzsa50ixhDbvU3sM
         f6Pg==
X-Gm-Message-State: AOJu0Yw11a7iRRLTv5i2vZkGzfXwWX2XDzoiIHnhXrQ/11fQXci92xmJ
	rbV1QzOrD0/eMoURgbV6lqIabstz7B/6cQJEmoO2OCj+xDxlFjPjaXry
X-Gm-Gg: AY/fxX6SfbXh0WGonwOPiqxy4z0VaMFRRv9HZMZ76EVIhdAcrjJLm7Isb3U0eHkmkGg
	mbt9AyHjcgR5sendX6BxTcjsY23SorbdTYpmiaiYPjIu/+uUOo3iH3Q+y3zS7iLMxvoxDa2vGSA
	wNs5eG80nOZiX186NbBPfnGTu8dgGApAne4Vsejs52/MBSIdGFbA+ultPp66WWqQDeshfRFjasB
	7FQTQE7K8Tl8rGUdEND6bfMqtcK8n/puAwUxgOzNx6zk+d60DkpBb9WLc+eWKmemcjKZCi8yGZ0
	reQvNbaHR6sCGjRwtf9VNkrvoorm6F/LU63B5eLz7dI8cRjJI9qQN0otY13uDFtFvJrPTUMwWhb
	wGSZ7GvpDMz7DLSJExLlAW8lLmsJsQavUa88wusSy+tlF7tlgufREjB8t3bxP+0NWRoFzXqXYLJ
	9Vb65A5K2+lHtQI1Aw7C76cjKUMcFTCx8tnO4Rb7S4zFu1csX8xPlObK450H29kk1l1TzLzSk1Y
	U4=
X-Received: by 2002:a05:600c:46cd:b0:47e:e9bf:dd8a with SMTP id 5b1f17b1804b1-4801eb182e1mr163825105e9.37.1768943845092;
        Tue, 20 Jan 2026 13:17:25 -0800 (PST)
Received: from ?IPV6:2a01:4b00:bd1f:f500:e85d:a828:282d:d5c7? ([2a01:4b00:bd1f:f500:e85d:a828:282d:d5c7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4801e879542sm275835355e9.4.2026.01.20.13.17.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jan 2026 13:17:24 -0800 (PST)
Message-ID: <2ef459bf-6a7a-4249-b400-aab75f03f44a@gmail.com>
Date: Tue, 20 Jan 2026 21:17:23 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v6 05/10] bpf: Enable bpf timer and workqueue use
 in NMI
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com,
 memxor@gmail.com, eddyz87@gmail.com, Mykyta Yatsenko <yatsenko@meta.com>
References: <20260120-timer_nolock-v6-0-670ffdd787b4@meta.com>
 <20260120-timer_nolock-v6-5-670ffdd787b4@meta.com>
 <CAEf4Bza1r4db3srwPYymSDC=ynhbZ-vsVJKshy8wGfnRhKkCmQ@mail.gmail.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <CAEf4Bza1r4db3srwPYymSDC=ynhbZ-vsVJKshy8wGfnRhKkCmQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/20/26 18:31, Andrii Nakryiko wrote:
> On Tue, Jan 20, 2026 at 7:59 AM Mykyta Yatsenko
> <mykyta.yatsenko5@gmail.com> wrote:
>> From: Mykyta Yatsenko <yatsenko@meta.com>
>>
>> Refactor bpf timer and workqueue helpers to allow calling them from NMI
>> context by making all operations lock-free and deferring NMI-unsafe
>> work to irq_work.
>>
>> Previously, bpf_timer_start(), and bpf_wq_start()
>> could not be called from NMI context because they acquired
>> bpf_spin_lock and called hrtimer/schedule_work APIs directly. This
>> patch removes these limitations.
>>
>> Key changes:
>>   * Remove bpf_spin_lock from struct bpf_async_kern.
>>   * Initialize/Destroy via setting/unsetting bpf_async_cb pointer
>>     atomically.
>>   * Add per-bpf_async_cb irq_work to defer NMI-unsafe
>>     operations (hrtimer_start, hrtimer_try_to_cancel, schedule_work) from
>>     NMI to softirq context.
>>   * Use the lock-free seqcount_latch_t to pass operation
>>     commands (start/cancel/free) and parameters
>>     from NMI-safe callers to the irq_work handler.
>>   * Add reference counting to bpf_async_cb to ensure the object stays
>>     alive until all scheduled irq_work completes.
>>   * Move bpf_prog_put() to RCU callback to handle races between
>>     set_callback() and cancel_and_free().
>>   * Modify cancel_and_free() path:
>>     * Detach bpf_async_cb.
>>     * Signal destruction to irq_work side via setting last_seq to
>>       BPF_ASYNC_DESTROY.
>>     * On receiving BPF_ASYNC_DESTROY, cancel timer/wq.
>>   * Free bpf_async_cb on refcnt reaching 0, wait for both rcu and rcu
>>     task trace grace periods before freeing the bpf_async_cb. Removed
>>     unnecessary rcu locks, as kfunc/helper allways assumes rcu or rcu
>>     task trace lock.
>>
>> This enables BPF programs attached to NMI-context hooks (perf
>> events) to use timers and workqueues for deferred processing.
>>
>> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
>> ---
>>   kernel/bpf/helpers.c | 423 +++++++++++++++++++++++++++++----------------------
>>   1 file changed, 240 insertions(+), 183 deletions(-)
> I think we'll need another revision, but all the things I pointed out
> below do not change the logic in any big way, so it would be great for
> people that were following along but waited for the overall
> implementation to stabilize to actually check the implementation now.
> I think it's basically ready, hopefully the next revision will land,
> so let's do another round of thorough reviews.
>
>
> [...]
>
>> +static int bpf_async_schedule_op(struct bpf_async_cb *cb, enum bpf_async_op op,
>> +                                u64 nsec, u32 timer_mode)
>> +{
>> +       /* Acquire active writer */
>> +       if (atomic_cmpxchg_acquire(&cb->writer, 0, 1))
>> +               return -EBUSY;
>> +
>> +       write_seqcount_latch_begin(&cb->latch);
>> +       cb->cmd[0].nsec = nsec;
>> +       cb->cmd[0].mode = timer_mode;
>> +       cb->cmd[0].op = op;
>> +       write_seqcount_latch(&cb->latch);
>> +       cb->cmd[1].nsec = nsec;
>> +       cb->cmd[1].mode = timer_mode;
>> +       cb->cmd[1].op = op;
>> +       write_seqcount_latch_end(&cb->latch);
>> +
>> +       atomic_set_release(&cb->writer, 0);
>> +
>> +       if (!refcount_inc_not_zero(&cb->refcnt))
>> +               return -EBUSY;
> let's not do refcount bump unless we are going to schedule irq_work,
> so move this after !in_nmi() check, and instead of
> bpf_async_irq_worker() call only part of it that does the work, but
> doesn't put the refcount. This will speed up common non-NMI case.
Thanks for reminding about this one.
>
> [...]
>
>> +static int bpf_async_read_op(struct bpf_async_cb *cb, enum bpf_async_op *op,
>> +                            u64 *nsec, u32 *flags)
>> +{
>> +       u32 seq, idx;
>> +       s64 last_seq;
>> +
>> +       while (true) {
>> +               last_seq = atomic64_read_acquire(&cb->last_seq);
>> +               if (last_seq > U32_MAX) /* Check if terminal seq num has been set */
> unlikely() seems to be warranted here to optimize (a little bit) a common case
>
>> +                       return bpf_async_handle_terminal_seq(cb, last_seq, op);
> why this helper function, it's called once. It's actually a
> distraction, IMO, that this logic is split out. Can you please inline
> it here?
It looked ugly inlined, I saw value in attaching word "terminal" to the 
functionality.
I'll send inlined in the next version.
>
>> +
>> +               seq = raw_read_seqcount_latch(&cb->latch);
>> +
>> +               /* Return -EBUSY if current seq is consumed by another reader */
>> +               if (seq == last_seq)
>> +                       return -EBUSY;
> I'd drop this check, below atomic64_try_cmpxchg() should handle this
> unlikely situation anyways, no?
I don't think cmpxchg handles this, if seq == last_seq, cmpxchg still 
succeeds,
it only fails if cb->last_seq != last_seq.
>
>> +
>> +               idx = seq & 1;
>> +               *nsec = cb->cmd[idx].nsec;
> [...]
>
>> -       ret = bpf_async_update_prog_callback(cb, callback_fn, prog);
>> -out:
>> -       __bpf_spin_unlock_irqrestore(&async->lock);
>> -       return ret;
>> +       cb = READ_ONCE(async->cb);
>> +       if (!cb)
>> +               return -EINVAL;
>> +
>> +       return bpf_async_update_prog_callback(cb, callback_fn, prog);
> nit: if you end up with another revision, consider swapping callback
> and prog arguments order, it doesn't make sense for callback (that
> belongs to that prog) to be specified before the prog. Super minor,
> but reads very backwards.
>
>>   }
>>
>>   BPF_CALL_3(bpf_timer_set_callback, struct bpf_async_kern *, timer, void *, callback_fn,
> [...]
>
>> @@ -1536,79 +1617,75 @@ static const struct bpf_func_proto bpf_timer_cancel_proto = {
>>          .arg1_type      = ARG_PTR_TO_TIMER,
>>   };
>>
>> -static struct bpf_async_cb *__bpf_async_cancel_and_free(struct bpf_async_kern *async)
>> +static void __bpf_async_cancel_and_free(struct bpf_async_kern *async)
>>   {
>>          struct bpf_async_cb *cb;
>>
>> -       /* Performance optimization: read async->cb without lock first. */
>> -       if (!READ_ONCE(async->cb))
>> -               return NULL;
>> -
> I don't feel strongly about this, but I guess we could leave this
> performance optimization in place without changing anything else, so
> why not?
>
>> -       __bpf_spin_lock_irqsave(&async->lock);
>> -       /* re-read it under lock */
>> -       cb = async->cb;
>> +       cb = xchg(&async->cb, NULL);
>>          if (!cb)
>> -               goto out;
>> -       bpf_async_update_prog_callback(cb, NULL, NULL);
>> -       /* The subsequent bpf_timer_start/cancel() helpers won't be able to use
>> -        * this timer, since it won't be initialized.
>> -        */
>> -       WRITE_ONCE(async->cb, NULL);
>> -out:
>> -       __bpf_spin_unlock_irqrestore(&async->lock);
>> -       return cb;
>> +               return;
>> +
>> +       atomic64_set(&cb->last_seq, BPF_ASYNC_DESTROY);
>> +       /* Pass map's reference to irq_work callback */
> I'd expand here, because it's subtle but important. Just to make it
> very clear: we *attempt* to pass our initial map's reference to
> irq_work callback, but if we fail to schedule it (meaning it is
> already scheduled by someone else having their own ref), we have to
> put that ref here.
>
> It's important to have a noticeable comment here because refcounting
> here looks asymmetrical (and thus broken at first sight), but it's
> actually not.
>
> But also, can't we do the same !in_nmi() optimization here as with
> schedule_op above?
>
>> +       if (!irq_work_queue(&cb->worker))
>> +               bpf_async_refcount_put(cb);
>>   }
>>
> [...]
>
>> -       if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
>> -               /* If the timer is running on other CPU, also use a kworker to
>> -                * wait for the completion of the timer instead of trying to
>> -                * acquire a sleepable lock in hrtimer_cancel() to wait for its
>> -                * completion.
>> -                */
>> -               if (hrtimer_try_to_cancel(&t->timer) >= 0)
>> -                       call_rcu(&t->cb.rcu, bpf_async_cb_rcu_free);
>> -               else
>> -                       queue_work(system_dfl_wq, &t->cb.delete_work);
>> -       } else {
>> -               bpf_timer_delete_work(&t->cb.delete_work);
>> +               switch (op) {
>> +               case BPF_ASYNC_START:
>> +                       hrtimer_start(&t->timer, ns_to_ktime(timer_nsec), timer_mode);
>> +                       break;
>> +               case BPF_ASYNC_CANCEL:
>> +                       hrtimer_try_to_cancel(&t->timer);
> I think it's important to point out (in patch description) that we now
> have asynchronous timer cancellation on cancel_and_free, and thus we
> don't need all that hrtimer_running logic that you removed above (and
> a huge comment accompanying it).
>
>> +                       break;
>> +               default:
> Drop BPF_ASYNC_CANCEL_AND_FREE which we don't use anymore, and then
> you won't need default (and compiler will complain if we add new
> operation that isn't handled explicitly).
>
> If that doesn't work for some reason, at least WARN_ON_ONCE() here.
> This shouldn't ever happen, but if it does during development, we
> better know about that.
>
>> +                       break;
>> +               }
>> +               break;
>> +       }
>> +       case BPF_ASYNC_TYPE_WQ: {
>> +               struct bpf_work *w = container_of(cb, struct bpf_work, cb);
>> +
>> +               switch (op) {
>> +               case BPF_ASYNC_START:
>> +                       schedule_work(&w->work);
>> +                       break;
>> +               case BPF_ASYNC_CANCEL:
>> +                       /* Use non-blocking cancel, safe in irq_work context.
>> +                        * RCU grace period ensures callback completes before free.
>> +                        */
>> +                       cancel_work(&w->work);
>> +                       break;
>> +               default:
> same as above
>
>> +                       break;
>> +               }
>> +               break;
>>          }
>> +       }
>> +}
>> +
>> +static void bpf_async_irq_worker(struct irq_work *work)
>> +{
>> +       struct bpf_async_cb *cb = container_of(work, struct bpf_async_cb, worker);
>> +       u32 op, timer_mode;
>> +       u64 nsec;
>> +       int err;
>> +
>> +       err = bpf_async_read_op(cb, &op, &nsec, &timer_mode);
>> +       if (err)
>> +               goto out;
>> +
>> +       bpf_async_process_op(cb, op, nsec, timer_mode);
> if you split read_op+process_op combo into a separate function, then
> you won't need refcount manipulations outside of in_nmi context. Let's
> do it.
Thanks!
>> +
>> +out:
>> +       bpf_async_refcount_put(cb);
>>   }
>>
>>   /*
> [...]

