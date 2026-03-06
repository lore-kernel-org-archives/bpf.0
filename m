Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D4C327BFC
	for <bpf@vger.kernel.org>; Fri,  6 Mar 2026 04:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772772809; cv=pass; b=k8CeUmFQjIyjBZP1KR45yKVx4mj41pEj/HqsVWkZLC2pJUuz/OoIqg6SKCCBNxo3MlgG+OpXpV2QRnCXmKo0/60oBlDBauk0vaa9BrddQ3JsfUrpDBAdpEct7X4XSlw44kT1qeKwJxyHyQnoTHuPhtSQhrhTL+/tjDVvN2wM7Gs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772772809; c=relaxed/simple;
	bh=v0K+RVkAZYunYTIdLhiSZa1jP7R2VX9am17TfvBSPmE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=re26SfmlU4ha1obO9Df/wmhovTnByfIwns1kd1KpuJiCsRpYR49M3Otfd8qVD5MlefP+qm0lkFzKZfEYUpvo8xy++YrW4wqwvyks0GfROuYSRELHUHE/a8MEfr0IzATkRSuIViLhOfsGu7oA178G9SRAAtSY3RR2eSXcVPzbs0s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aHhgtPpT; arc=pass smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aHhgtPpT"
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-439b9b190easo3425762f8f.2
        for <bpf@vger.kernel.org>; Thu, 05 Mar 2026 20:53:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772772806; cv=none;
        d=google.com; s=arc-20240605;
        b=bQP5oAQodwu47LRcPbPC8cigikNFJdYadZkK/maW9UINd5DX6neXAqy8QOYxyJewXr
         7PeE6eBh0u85SfeDzhPnq3EiE78SYnMBUnajWjZ1v+qdcKryFpWzgt1OiPR/3inti+7P
         TcxzxhHLKb1Q+hFh3RAULDwhJ2R1iuomn2gePOUrZSFCM3V7jJAyZum7YwdzL76Jmhkw
         qT42KyV2MxfmDGpUxkNzGeCj5Z9376oAxpQn9KY+aZ1lKmWI5blWOQqm+4FNNNYHGTDs
         2ZYy1lxymSroGqG5pGIDNh7xrIuM3nXd9J0KcDxM6YuBLHWX8K5cUf2ms0RwCa3NjM8K
         06cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=agO6xhGPUkPThlBYcgNw6b+dBxFu14/17IF8SN16sWc=;
        fh=cI9uooar5Ltd3e+Qt/db85L/ZzbTwlMx+rc2r9DqGqk=;
        b=SMRixYj7OM0pBIgwUlEwYqRdUj1lbo401g+SLhI/eSaWtlJtmPywSvznB2ggBi1gM2
         yXv3LA4ATXzHVyWi6kZy3eYkJoMPJcLnqIfJkX/gO+azlRQNVm3jo3mGofK22cAnEKha
         UBg9oNzjUatrtw2QCq7gHDoM7yuddkFUx7u8eoc/lDY6pzGqYNBRYwfnX1V//EP64fNX
         G79CGB+GgR9+O1RECTd90uw+0yjKu54XlZziQPt1tcSXb0y/VhW/iCfafUGO+W9fkbrX
         FKRb3JKBbtPRblUBmkSZosTB9jrm8/GnORVEC9aaS00wh0cesttlOtFc+cVRjGjWnxMM
         PrAw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772772806; x=1773377606; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=agO6xhGPUkPThlBYcgNw6b+dBxFu14/17IF8SN16sWc=;
        b=aHhgtPpTzUjBX9yanPkKOIl9gyJz73gk65ZkBowPA/zuLH37qz6SWfPrgYCBHPTMBd
         ogzIWx1/lSqXrvWj7SwN3SDP9kEvAJz6TDW3fFv0l5Wzw8MmZF6Bndy94+Vz3z245Qmb
         /U/UHefhm8JMoLUqqvyevDvdL+FcPaIJxxV6o5od3vyCCRelTm+fEQiP08GZ4LjZYKwJ
         uDNtGPJ3KGBaSEHB5ua9Sl2ZMNFCymMGJ89snKUKZi1kFGWuCJaOqPzDGVgQdITMXGoV
         fB23w6l25vsuJxBKEkvQgFb3WDpEsEiueAThAsi04QHkRz7ZygagO39cRgBRnwDlaPd0
         k+MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772772806; x=1773377606;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=agO6xhGPUkPThlBYcgNw6b+dBxFu14/17IF8SN16sWc=;
        b=FJDnPfRVPTLqriLSHaY4SE17ynkKuLYSQIPX4JrI2xwCS6392RZqbog2JyBUATKx+X
         aigjtlG+NaBAgOBFeTYc8VFlhgMp67ryzi/bzcihRg2d/KsjJtsKXFuv6cYAqH52jpSa
         dTrsMy39QyMLhz51enXr1QyEs3PJhICzTk0xzBI7Ld91RJO49r44mf+rRwj3iG5KU9Px
         Ypl1Yr2tI+eiWDmy7xsjnzpzMvl0g0qNS3cdQ9yd5zlJHmhPzyyj5S4F2zIzxUkf7ujH
         F9T+rRDVOmBCMg2WXdBj4l7LJMgN7CXMyErm7BDi6gBP+Mf9/IFSK1hYXvbbl5sZeSKy
         LvyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhZEdpu4Px4ArkDidHt3GNcbEMQReDZrMCQSBXeJBTWY9qIApOjqmz8k97pGV9gju8XwA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnAxeEoOmywlPUmAyLIUknBEYZSlcF/8AKXjUvi/m16q2roYVd
	q3FfoSZZt6GWP/OjYuwy2SrKPIqKAPkJKbPoodocLhxF9kw1lb1nmWATIbjxQk4HMIs3CZCFS1+
	5vCE+PKPF8GJHR2Kvw7VpZmqIq5cA/9c=
X-Gm-Gg: ATEYQzz97vPkEZYSvB92Jt46DFL8gMU1Xtz+fn4n9JVtbYsvsokmIqZj4a0xez8eP7l
	kAnSV5brSQpO0vWD8XRzgZcdebi7AEtgsIJwzsB0i8JUZHbCybY9PJ4RLB7F4tQ9ixOHJEMIvUT
	kOClD+mgQrTFeKb6kKqwC9pbDJEhyVu6xtEOhoOcMhvnt7jZFcZN2lpOYzHwjOt/OxCzOc4qJg/
	Op3R3Tqis2txebEQnKq8PIULcdu5fsU7P5mFPXdwgyT37uHruVqmFQ75gWQhDAw7FvNQoQaqcb6
	CST9EIB6jVKFQyNr9limLPfQMZ20H2Fft5FgigCoLexM7+aad4WM2WIa+xc=
X-Received: by 2002:a5d:5f82:0:b0:439:bc2b:cb57 with SMTP id
 ffacd0b85a97d-439da3483bcmr1127381f8f.6.1772772805912; Thu, 05 Mar 2026
 20:53:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260225-sleepable_tracepoints-v2-2-0330dafd650f@meta.com>
 <9a841572b63b4a741b20e14452a230a34203a2fb325275ad57fc5c0568a30c58@mail.kernel.org>
 <CAP01T77_J8tua8HziBWZRunY9=LQ-Ut1mxJnKAk3cMCc00+7Kw@mail.gmail.com>
In-Reply-To: <CAP01T77_J8tua8HziBWZRunY9=LQ-Ut1mxJnKAk3cMCc00+7Kw@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Fri, 6 Mar 2026 05:52:49 +0100
X-Gm-Features: AaiRm50tnSpf_mijRgtKCC3UsMY6irae8m5W2h64Sehkdqva-25yZmKX-WYwpO4
Message-ID: <CAP01T74FbF5FH70B2-6iB0BJEh8cLcM7Ok=vhUPJZe-SXeOYJg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/6] bpf: Add sleepable execution path for raw
 tracepoint programs
To: bot+bpf-ci@kernel.org
Cc: mykyta.yatsenko5@gmail.com, bpf@vger.kernel.org, ast@kernel.org, 
	andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
	eddyz87@gmail.com, yatsenko@meta.com, martin.lau@kernel.org, 
	yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"

On Fri, 6 Mar 2026 at 05:23, Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
>
> On Wed, 25 Feb 2026 at 18:14, <bot+bpf-ci@kernel.org> wrote:
> >
> > > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > > index 9bc0dfd235af..2dd345e0fdb0 100644
> > > --- a/kernel/trace/bpf_trace.c
> > > +++ b/kernel/trace/bpf_trace.c
> >
> > [ ... ]
> >
> > > @@ -2085,12 +2085,26 @@ void __bpf_trace_run(struct bpf_raw_tp_link *link, u64 *args)
> > >       run_ctx.bpf_cookie = link->cookie;
> > >       old_run_ctx = bpf_set_run_ctx(&run_ctx.run_ctx);
> > >
> > > -     (void) bpf_prog_run(prog, args);
> > > +     if (prog->sleepable) {
> > > +             might_fault();
> > > +             (void)bpf_prog_run(prog, args);
> >
> > At this commit, __BPF_DECLARE_TRACE_SYSCALL in include/trace/bpf_probe.h
> > still wraps the BPF callback in preempt_disable_notrace() /
> > preempt_enable_notrace():
> >
> > include/trace/bpf_probe.h:__BPF_DECLARE_TRACE_SYSCALL() {
> >     might_fault();
> >     preempt_disable_notrace();
> >     bpf_trace_run##x(__data, ...);
> >     preempt_enable_notrace();
> > }
> >
> > Since __bpf_trace_run() is inlined into bpf_trace_run##x(), which is
> > called between the preempt_disable_notrace() and
> > preempt_enable_notrace(), the might_fault() here will execute with
> > preempt_count > 0, producing a warning on CONFIG_DEBUG_ATOMIC_SLEEP
> > kernels.
> >
> > More importantly, if the sleepable program calls a helper like
> > bpf_copy_from_user(), the page fault handler will see in_atomic()
> > and return -EFAULT for any non-resident page instead of faulting it
> > in, defeating the purpose of sleepable programs.
> >
> > The v1 RFC series included a separate patch to remove
> > preempt_disable_notrace() from __BPF_DECLARE_TRACE_SYSCALL.  Should
> > that change be folded into this commit so the sleepable path works
> > at each bisect point?
>
> But sleepable programs are not yet permitted, so I think this is not
> needed for bisection-friendliness.
>
> >
> > > +     } else {
> > > +             /*
> > > +              * Non-sleepable programs may run in the faultable context,
> > > +              * do cant_sleep() only if program is non-sleepable and context
> > > +              * is non-faultable.
> > > +              */
> > > +             if (!link->link.sleepable)
> > > +                     cant_sleep();
> > > +             rcu_read_lock();
> > > +             (void)bpf_prog_run(prog, args);
> > > +             rcu_read_unlock();
> > > +     }
> >
> > [ ... ]
> >
> > The commit message states:
> >
> > > For non-sleepable programs, behavior is unchanged: cant_sleep() check,
> > > rcu_read_lock() protection.
> >
> > The parent commit does not have a cant_sleep() call in
> > __bpf_trace_run() -- it uses rcu_read_lock_dont_migrate().  The
> > conditional cant_sleep() is new in this commit.  Could this sentence
> > be updated to reflect the actual change?
>
> This seems worth adjusting.

Actually, with the extra cant_sleep() check, we get this splat when
running normal raw_tp tests.
E.g.

...
[  295.211949] BUG: assuming atomic context at kernel/trace/bpf_trace.c:2098
[  295.212166] in_atomic(): 0, irqs_disabled(): 0, pid: 587, name: test_progs
[  295.212316] 3 locks held by test_progs/587:
...
[  295.213044] Call Trace:
[  295.213046]  <TASK>
[  295.213048]  dump_stack_lvl+0x54/0x70
[  295.213055]  __cant_sleep+0xb7/0xd0
[  295.213060]  bpf_trace_run1+0xce/0x340
[  295.213072]  bpf_testmod_test_read+0x433/0x5e0 [bpf_testmod]
[  295.213080]  ? srso_return_thunk+0x5/0x5f
[  295.213093]  kernfs_fop_read_iter+0x166/0x220
...

It means if the tracepoint is not marked faultable but is invoked in a
non-atomic context, we will get a warning.
It might be better to just drop this, since I don't think this adds much value.


>
> >
> >
>
> Other than that LGTM.
>
> Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
>
> > [...]
