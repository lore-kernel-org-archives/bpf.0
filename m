Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699FE1C5F27
	for <bpf@vger.kernel.org>; Fri, 24 Apr 2026 23:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777072849; cv=none; b=g1ZrbWnw1rXjc/Iih4H37fbAMtCqjhhES/yy+YQ6a2IwLGE6eGW1zcw31J9Uq0iOvdULvm+qka6WXL89Btk8JIQ9TV3TsQwPL0OBLf/PFPY/K8wOUgM6JnurcDhA4MhwsDR3wQ37KHIt5LsqnVj+B5Flc0sdxsSujGHsRZaN8wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777072849; c=relaxed/simple;
	bh=dgFCF5P7v1dzu10VkbpiYjCRlLibMMbntJJJrYltWZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GGrMPuisORZPv+i4PQ9+BONX8rh0vnDbL6o+HQU8SPkMH4nW2l5KlQDFTyGkoeVXIBWwoENzvw3B8a3ObJRmLAkz+A5XgNs7V8thret7Krd64o9KwX3HnHdysBLMcSrDij6uHJ49jpC8QjKiMwty5VQEeUosvaEooZtJfXgUaRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N3K5pFfW; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N3K5pFfW"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-7a43424f861so78598607b3.1
        for <bpf@vger.kernel.org>; Fri, 24 Apr 2026 16:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777072847; x=1777677647; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iCIji13baonMmgPO0ajNnq9HOSixeTXLQT62scUgHDU=;
        b=N3K5pFfWKR/MyaZWLoFDLqanQy618byQkHr90UYeL8nwCjyrWm2r4QGttwwEfUP89U
         4/Qi95+f0Ye2QOp8+zDVDDCBMXd+KLp4zJ1JyAKYHprdiyeYQ3/4Og5JFl2urMxi8H4l
         lfzoMEouKi24fTe5IUNV32QbDJPW+CBbZO+S7Sy8Srh+T3PHcRHNiSNSDcsgAt6WJDGR
         XIuWUrwyabQ+5oYFq60xWpysTSayMixOWyl+9JH6LIOZ4iT2N/7xl3lrZ5JqltiJ9KOc
         e3CmhaB12WNRYBuX8zfQa+XZTZstVTcXcprEqwSPx7l0VMtgVNdZTv3yn9VnL/0PtugA
         FXLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777072847; x=1777677647;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iCIji13baonMmgPO0ajNnq9HOSixeTXLQT62scUgHDU=;
        b=M+YDtYnaBnFYg5CVu9mkoXA7UySSYSIHNm7uLFsf0mnt+HMQVI9TyrRXS7+qawAuXI
         xtbHrBgvZGJa7YZ3H0jXEQ4WRmETe0S5+3VhmJaBjsr50JJ4kHChjjazhjCP6yAF/aBz
         0SPwItQUsbMgy2yAju6x81bIrKkCs5rxBRwoTvalvIN9DlDBKaGX5OGGYXgxbW6PSL6U
         slpW4MslsN3KuCjp7BedALhVu190E/ugyk8ZjTZhmRazxYl/I6dtFwLEhE8QB6BoBQWS
         /N0ywjTr+/GjCi1vstIzZBakCNYd9/um6ogRCFRMzPx0hyVhz20CMkKGRJ27j/Y2Vy6k
         qoaw==
X-Forwarded-Encrypted: i=1; AFNElJ/yaL61iDYoO5YhcyW/M29Dy0b+weS6yv7EDhRC+UYOlxzOroXcIAvRSAfes7yWNHJvKWo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn5Wz/Pu4AuXyyuORl+cMmdUljBEB76sv9HnTDTTVtgeQByXuH
	Xcl1tXl9W7IfjAsKslhUnwj5qLSsiLuqSKdYoPzeIN/sPlL+LhsJ3NgRcC9sRA==
X-Gm-Gg: AeBDievg26ImzzjmSubhbgu8VaXr7AFYFjj7CXaD7Sa8T4ZKCR/rHtTiipMepGK4d0f
	tnIsvjva+CaUNnjKI/lxwPQBYmj1p4yN6+e5Imvbacu86WTu6BKqxkc8tn0NDOwSEeN6xgx/K21
	wCi6iEcZbkKOfbY0LtCQVHIge+AJobNYSP5Pof1Lfh0k3DP8KCjGiaRjyvaUqm4RJ11pcsNGe0c
	TCn7gU0oRjRlSn0C6RGzBned0YdcWnbfEl/ykdqJe245gHRV/6tYo2pLSS3/d3XjAj2Lk20GxH4
	fnEQrAnCglNBySc7HcstAyig3Texgw0Q7BEi8cDFaxv/kOr6/Q4JWcaIMRmRlUIrAlLGG5JvdX4
	ZmwvuWwuI2hhd8z4G1RVJkmj7wHNv/J/z36JdwwtIZMaiS/wQ5eemBxSY7NwcxPLemIdN/5jWxD
	C95OQeJjzq/LM84ZeXZEun/iG3IJqC4txmE5wBgWcpiRvKk2KWzwEGa8wIaMspu+kFbFG4d2H3X
	TBI6w==
X-Received: by 2002:a05:690e:128a:b0:650:1cf8:f608 with SMTP id 956f58d0204a3-65310a62a92mr32055488d50.45.1777072847319;
        Fri, 24 Apr 2026 16:20:47 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:cc96:e003:f6cc:4ed])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65314b5faf0sm11182555d50.5.2026.04.24.16.20.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 16:20:46 -0700 (PDT)
Date: Fri, 24 Apr 2026 19:20:45 -0400
From: Justin Suess <utilityemal77@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: sashiko@lists.linux.dev, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next v3 1/2] bpf: Implement dtor for struct file BTF
 ID
Message-ID: <aev6zU2vj6wmaRMG@zenbox>
References: <20260424192252.695240-2-utilityemal77@gmail.com>
 <20260424195958.AED4EC19425@smtp.kernel.org>
 <aevOssMWH_Vm9CPG@zenbox>
 <CAADnVQKFtuX48V9Yy88GHGVbQyY30M3b3YBvZ2PmYt_-jbohpQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQKFtuX48V9Yy88GHGVbQyY30M3b3YBvZ2PmYt_-jbohpQ@mail.gmail.com>

On Fri, Apr 24, 2026 at 03:05:47PM -0700, Alexei Starovoitov wrote:
> On Fri, Apr 24, 2026 at 1:12 PM Justin Suess <utilityemal77@gmail.com> wrote:
> >
> > On Fri, Apr 24, 2026 at 07:59:57PM +0000, sashiko-bot@kernel.org wrote:
> > > Sashiko AI review found 1 potential issue(s):
> > > - [High] Calling `fput()` directly from `bpf_file_release_dtor` can lead to a hard deadlock when invoked from NMI context.
> > > --
> > >
> > > commit 6368f91be1fd91bc9cb38d3498f35d279bad04c9
> > > Author: Justin Suess <utilityemal77@gmail.com>
> > >
> > > bpf: Implement dtor for struct file BTF ID
> > >
> > > This commit implements a destructor for struct file, allowing it to be
> > > stored in a map as a referenced kptr. The destructor calls fput to
> > > release the reference.
> > >
> > > > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > > > index 2bb60200c2665e..ee5ceb82e4f812 100644
> > > > --- a/kernel/bpf/helpers.c
> > > > +++ b/kernel/bpf/helpers.c
> > > [ ... ]
> > > > @@ -2752,6 +2753,13 @@ __bpf_kfunc void bpf_task_release_dtor(void *p)
> > > >  }
> > > >  CFI_NOSEAL(bpf_task_release_dtor);
> > > >
> > > > +__bpf_kfunc void bpf_file_release_dtor(void *file)
> > > > +{
> > > > +   fput((struct file *)file);
> > > > +}
> > >
> > > Can this cause a deadlock if the destructor is invoked from NMI context?
> > >
> > > If an NMI-context BPF program (such as a perf event tracing program)
> > > updates or deletes a map element containing a struct file kptr, the BPF
> > > framework will synchronously invoke this destructor to clean up the old
> > > kptr.
> > >
> > > When fput() drops the reference count to zero, it calls
> > > __fput_deferred(). Since in_interrupt() evaluates to true in NMI
> > > context, __fput_deferred() bypasses task_work_add() and instead calls
> > > schedule_delayed_work().
> > >
> > > This leads to the following call chain:
> > >
> > > bpf_file_release_dtor()
> > >    fput()
> > >       __fput_deferred()
> > >          schedule_delayed_work()
> > >             add_timer()
> > >
> > > The add_timer() function attempts to acquire the timer_base->lock raw
> > > spinlock. If the NMI interrupted a thread that was already holding this
> > > lock, the NMI handler will spin indefinitely waiting for it, resulting
> > > in a hard deadlock.
> > >
> > > Would it be safer to defer the fput() operation using an explicitly
> > > NMI-safe mechanism like irq_work_queue() to handle arbitrary BPF
> > > contexts?
> > >
> > For (human) reviewer context: The NMI stuff needs to be addressed separately. [1]
> >
> > I guess the AI isn't gonna understand but just doing irq_work wouldn't
> > be right either as it would break operation ordering for maps and
> > fixing it here wouldn't fix the other dtors broken in NMI.
> > (cgroup/task_struct)
> 
> Will break operation ordering?
> What do you mean?
>
Basically if we just did irq_work_queue for one map op and then we do it
again for the same irq_work it will just fail because the queue has to
be drained before we can schedule more work.

So ordering can't be:

1. irq_work_queue
2. irq_work_queue (again on same queue)
3. hard interrupt ends

It has to be

1. irq_work_queue (everything)
2. hard interrupt ends.

In the first ordering above, step 2 fails because the queue has a
pending item.
> I feel we should fix things first before being subject
> to more of these bugs.
> Why cannot we defer to irq_work the whole map element if in_nmi
> and call all dtors there?
irq_work won't work if there's pending work already. It will just return
false and not allow you to queue anything until the task is over with.

So it would work for one element, but we'd be stuck and need another
free irq_work to free the next element.

So we'd need an irq work, one for every element that we free.

So either: 

1. allocating memory for a new irq_work on the fly, which is an
operation that can fail. So if we're under memory pressure the
element never gets freed.

2. preallocate an irq work for every element ahead of time.

...

I think the solution for this might be to just reject any kfunc or dtor
that isn't explicitly marked NMI safe from any programs that may 
run in NMI.

With a kfunc flag that marks it as being nmi-safe. KF_NMI or
similar. And extending the concept of kfunc flags to dtors to handle
them in the verifier as well.

My reasoning is:

1. it's very easy to inadvertently introduce new kfuncs/dtors that would
break under NMI. (there's two examples in upstream, task_struct and
cgroup dtors).

2. There's very few NMI contexts reachable from BPF. I only found three
cases, tracepoints for irq_handler_entry irq_handler_exit and
nmi_handler.

3. If the user really needs to no nmi unsafe stuff, why can't we just have them
call bpf_task_work_schedule_resume_impl which is designated for this
purpose?

Justin
> should be a simple fix.
