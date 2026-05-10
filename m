Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189D4355F54
	for <bpf@vger.kernel.org>; Sun, 10 May 2026 15:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778426020; cv=none; b=ezVL0abZGYfuJGwQ3wcdDAZofHrAz0eXH6wWNalIr6N2XzKS2d/ooGAXkRBshoUnV83Wy4Tjn4K3DXv3SB9jw7xpQbEewSkIjqIExEQP7f7wj1p7OX9ZFaCfEsBWnTHKUH8WokTZxDZFYrZ6mCIz5yAN/Fa6MJLssZkUNAuMs8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778426020; c=relaxed/simple;
	bh=r/WOnTGUEtMH6yCZoAP+YqqwKeh7rprH5FfTfFGcFdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XOjijuPVGWg89bOgtR6KVsSeePkrjhBaD3yghXPdIfitBGX62XWSgy8eNdzrH0STz5kA9eXqSo35kF/8Ez1ZM3ccXPs/VnUCuYuv1xqW2P0izaNosk9sLgrQesqL6UcuslvwkvC/t9KtxKdDyLfrjNuBxo1p/LrkMM7oFeIXFSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hHFhudWl; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hHFhudWl"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-7bd8c55c885so34111257b3.2
        for <bpf@vger.kernel.org>; Sun, 10 May 2026 08:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778426018; x=1779030818; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=N6YM/AAXzn9J0aZ953Dqra2iVWJmXRfyE6DQF3nGAEs=;
        b=hHFhudWlAhv3AiSlp0PqgEOZrHKiJxfJo5MSqI0vw+TR6sCcEBG3J1vr43jIIfhQBL
         aGBw6kDk+BzIBWh04FvIuadCKXLBg1+npWuyZRapgdcuyhVUNzPUHCIpqqxd+XPehNaV
         jlR0Bfkm5kMv83F/48gzjZenNXAln3rYipeVhaN9TlRDS5KyuGnCPGN9+DtRFGUYO3uK
         NVguAv3ssHQMAevn9dVa+LjoXGH+Puh7fR2LaqB27BAq/3yS8i2RoMAfBycWTJCSNPiY
         +kfNHdERZ3VwhOyJJfIaWRncfYgI/Ez+RQmXmcbkM6Boyllu6wx9O3wrU79DAnomFTOw
         0usw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778426018; x=1779030818;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N6YM/AAXzn9J0aZ953Dqra2iVWJmXRfyE6DQF3nGAEs=;
        b=TeoDaBCdUa9ffAC6dXF8I38HgF34DGs9+9j86UfwegWiT4GIGNoP4V+2SQ/JBjd1vr
         haU3qYliZbFuNVOSY+NmZdes8ToubhcOOoEc37dIHwUvf/xKUmD0RprMTdqUD29Sqytf
         vXHsZSDvJA2jbWl3bIt6lIb0S1uV56YIplMTEfRH+EL8dWhBDcvTg9WNNlwZ9d+ZZZXl
         F9TmW0vVn2YiymU6HuhfZZWP6jVWxqJZGjUQJMQI2cvISdJ+mbtiZq3SujKSH9x4wpe+
         d3gImUBsGy9WAI4OgGzc2vCyL/KjcPNj6BtLkbpuJWmCgL0XXHkTUjfyx8A2PXOQI5QM
         rJnA==
X-Gm-Message-State: AOJu0YwS/mgx3NoEVg6Gi37PZV82bnTKS+MrHIH/LpsgF6u/wYbkdEWB
	fYIHVgCjEM4xDJrw0xi/DlPbhVAMF/JqgWy8sXuwjZk01E310wGxzdKEWF8e2sya
X-Gm-Gg: Acq92OHdGM14jz0QCGVqoAujGag9fZkd8XKwpVTri56Xf52XyoNoDg0avARjoQgd76k
	mSy2A+NBoviLJsoULOjHvm1hA6X2iatjygENnJwAaIbBYT73iwBjclncO+VdhWnqa4BlYvNBCfh
	17CZlCYgqTwMan2qM6fi86RJAyR9RGd37ehtuKUu0LaqAAxtFhGOfEuAhzUyfVM8L6pJlrfaPlU
	q02WsbU57FxNWZh2Geczeg2AqGF0ymBazJH4EnSpEeyZM9+rMl1BjUfEUWqrzHquQug6DogBDLZ
	cI5oFxkrEi7hllqueSCvOlE0ytrPG8IiWqp2yrlR0gjDEp5WkqYMy/3fHWghef7gYe8a6/MfuFA
	Ut15qu8flMSx7hmi7XEHj1dxvFNv2ZtovoeCcRCLbc97y9vtckDxk54GiQIDzD3wUhY9HCOZzq1
	bw5dwM+rvNAb/UThkYH7fLTX2yl7msUJneMT6JyUBnOKAJfgHcBsXvAL9t7g==
X-Received: by 2002:a05:690c:4b0c:b0:799:2b4c:1d49 with SMTP id 00721157ae682-7bdf5eef7e4mr218836357b3.36.1778426018026;
        Sun, 10 May 2026 08:13:38 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:4060:ee75:92ff:98db])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd6685d37fsm135045457b3.36.2026.05.10.08.13.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2026 08:13:37 -0700 (PDT)
Date: Sun, 10 May 2026 11:13:36 -0400
From: Justin Suess <utilityemal77@gmail.com>
To: sashiko@lists.linux.dev
Cc: bpf@vger.kernel.org
Subject: Re: [bpf-next v3 1/2] bpf: Offload kptr destructors that run from NMI
Message-ID: <agCXEJKJh-JGMhjG@zenbox>
References: <20260507175453.1140400-2-utilityemal77@gmail.com>
 <20260507234520.646C4C2BCB2@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260507234520.646C4C2BCB2@smtp.kernel.org>

On Thu, May 07, 2026 at 11:45:19PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] TOCTOU race in `bpf_dtor_kptr_release_one()` can lead to NMI deadlocks.
> - [Low] Memory leak on initialization failure in `bpf_dtor_kptr_init()`.
> --
> 
> commit 488cdc390b90427a591d47211600c09addc95fcd
> Author: Justin Suess <utilityemal77@gmail.com>
> Date:   Thu May 7 17:54:52 2026 +0000
> 
>     bpf: Offload kptr destructors that run from NMI
> 
> This commit queues destructor-backed kptr teardowns to irq_work when
> running from NMI context. It maintains an idle-slot surplus counter to
> ensure offload slots are preallocated to prevent deadlocks.
> 
> Closes: https://lore.kernel.org/bpf/20260421201035.1729473-1-utilityemal77@gmail.com/
> 
> > diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> > index 3b1f0ba02f613..d34fdb99eb8a9 100644
> > --- a/kernel/bpf/syscall.c
> > +++ b/kernel/bpf/syscall.c
> [ ... ]
> > @@ -65,6 +69,111 @@ static DEFINE_SPINLOCK(map_idr_lock);
> > +static void bpf_dtor_kptr_release_one(void)
> > +{
> > +	struct bpf_dtor_kptr_work *job;
> > +	long surplus;
> > +
> > +	for (;;) {
> > +		surplus = atomic_long_read(&bpf_dtor_kptr_surplus);
> > +		if (surplus <= 0)
> > +			return;
> > +
> > +		job = bpf_dtor_kptr_pop_idle();
> 
> Could this sequence lead to a race condition that drains the idle pool
> too early?
> 
> If multiple threads read a positive surplus value here, they might all call
> bpf_dtor_kptr_pop_idle() before the cmpxchg executes. This could temporarily
> drain the idle pool below the required number of reserved slots.
> 
> If an NMI fires during this window and attempts to tear down a kptr, would
> bpf_dtor_kptr_offload() find the idle pool empty? If so, it looks like it
> would trigger the fallback warning and run the destructor inline from the
> NMI context, which might reintroduce the deadlocks this patch aims to
> prevent.
>
Yes this is real.

But there's a bigger problem: the push side of pcpu_freelist is not
interruptible.

If we jump to NMI during this stage then the pcpu_freelist will be
locked up because we were pushing to it, thus preventing us from
popping. Thus we just deadlock again.

I think we technically have exclusivity here on our percpu head
(we can't be in NMI and process context stimultaniously on the cpu).

So maybe it is safe to forcibly acquire that specific lock? I'm not 100%
sure.

llist won't work since we can't have multiple llist_del_first consumers,
and llist_del_all would render the list null and unusable if we jump to
it from NMI while we're borrowing it. 

Making percpu llists won't work either, since the cpu we allocate the
job one might not be the one the dtor runs on, so we need percpu
stealing, which then runs into the same multiple consumers problem if
threads steal from same cpu head.

So this code is not ready either way.

I think 128 bit cmpxchg could technically solve this problem, but don't
think we can rely on it for all architectures BPF supports.

If anyone has any guidance on this it would be much appreciated. Been
stuck on this for several weeks...

Construct I need is a data structure with atomic push, pop, and move
between sets. No specific ordering needed, but updates from producers 
must be immediately visible to all consumers. I've looked into Treiber
stacks.

Any help or guidance on this would be appreciated!
> > +		if (!job)
> > +			return;
> > +
> > +		if (!atomic_long_try_cmpxchg(&bpf_dtor_kptr_surplus, &surplus,
> > +						     surplus - 1)) {
> > +			pcpu_freelist_push(&bpf_dtor_kptr_idle, &job->fnode);
> > +			continue;
> > +		}
> > +
> > +		bpf_mem_free(&bpf_global_ma, job);
> > +		return;
> > +	}
> > +}
> [ ... ]
> > +static int __init bpf_dtor_kptr_init(void)
> > +{
> > +	int err;
> > +
> > +	err = pcpu_freelist_init(&bpf_dtor_kptr_idle);
> > +	if (err)
> > +		return err;
> > +
> > +	err = pcpu_freelist_init(&bpf_dtor_kptr_jobs);
> > +	if (err)
> > +		return err;
> 
> Does this error path leak the per-cpu memory allocated for the idle list?
> 
> If the second pcpu_freelist_init() fails, the function returns immediately.
> Should there be a cleanup path here to free the already initialized
> bpf_dtor_kptr_idle list?
> 
> > +
> > +	return 0;
> > +}
> > +late_initcall(bpf_dtor_kptr_init);
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260507175453.1140400-1-utilityemal77@gmail.com?part=1
