Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4A23A0E85;
	Tue, 29 Sep 2026 08:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790669038; cv=none; b=nyXljlhn3iUaH3+nMnQQx5m5GoBdViFcNcxNemozYThK6aARNDG/BLYqKODMjhB/6vOVAPx6aHVc9XHVCW2KuB/Rkn6yIbfuAkrCMVW1VWIZQvTYxQGhGNjeQf7Rd8jpnsoEZRV7/c3u1Ly12H4mPR+S8GardOMsWbXlk/9IxPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790669038; c=relaxed/simple;
	bh=GotuyaK1bvWLOXD8dQRDPmlm+Jby8QWTJuG1VIpksBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G5jq+zik/M3oCTVmkJSO2m+h/UOS2YHuh6Jkrjd1YEq25HrsyVoH7hcKwEfESPcqwWQ5LQooF2xnQfsKKu8XkHBrlyYcfSikkbwfEoPmL8fLHAoa9qQ3VYQBXDtiyx2hwNK0MOB2HLFI9JGaaT5NLzXCW06kpqNRo/2HsBe/saQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=adkiet3j; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="adkiet3j"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=65p2mc0TKga7tV1e3c08D2MWEBKF2gxIG69YfJyQynU=; b=adkiet3jQtCnsZvN3RjM/yBP1v
	KOruza7UwVcd3DnOmWXKEnvZXGUq+qgi9AwE+nsh6rq7611dH4HKy0Fy2ZVwbezrsbTGWFld0YKcj
	GdSSYTDbwZEW0d9cstNzO7+sQoXdCtgHBgeRt+feSGN9LpJzy3lDm9lX+bXkppcKgO+jLGNf/p0fJ
	Cf7DZfq+PtniTPwUnRoqh3eb3SYiGFHDljRNED7bHUFB0xunkP1+dIGW0CQdxvWuzPp2qAJe2MX4k
	5U/vlgQFL4wC8gRGuqE5ubTnS0P0OsZ92UkNhM2hRgxWQPukhVW5CKWQvcyCFDp7hxqFdnbWBVkwB
	Wzu7hc8A==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1xBSoV-00000002KMR-2EeD;
	Tue, 29 Sep 2026 08:03:48 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id C6F6D300446; Tue, 29 Sep 2026 10:03:46 +0200 (CEST)
Date: Tue, 29 Sep 2026 10:03:46 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Vineet Gupta <vineet.gupta@linux.dev>, sashiko-reviews@lists.linux.dev,
	rostedt@goodmis.org, Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>, kernel-team@meta.com
Subject: Re: [PATCH v2 1/1] tracing: fgraph: allocate shadow stacks inline
 with GFP_NOWAIT
Message-ID: <20260929080346.GR4120091@noisy.programming.kicks-ass.net>
References: <20260929005411.4105448-1-vineet.gupta@linux.dev>
 <20260929005411.4105448-2-vineet.gupta@linux.dev>
 <20260929010327.024281F000FF@smtp.kernel.org>
 <0499fb85-d323-4141-b76e-bc9812b1d142@linux.dev>
 <CAEf4BzZJL3jkyXo7XwTYwH2St-eiQB_FNCM6ZP=_TzC_McW2zQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzZJL3jkyXo7XwTYwH2St-eiQB_FNCM6ZP=_TzC_McW2zQ@mail.gmail.com>

On Mon, Sep 28, 2026 at 07:25:00PM -0700, Andrii Nakryiko wrote:
> On Mon, Sep 28, 2026 at 6:22 PM Vineet Gupta <vineet.gupta@linux.dev> wrote:
> >
> > On 9/28/26 6:03 PM, sashiko-bot@kernel.org wrote:
> > > Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> > > - [Low] cleanup: mixing goto-based error handling and scope-based cleanup
> > > --
> > >
> > > commit a6de528fef00ef67da15965a7a8b3944fa92b053
> > > Author: Vineet Gupta <vineet.gupta@linux.dev>
> > > Subject: tracing: fgraph: allocate shadow stacks inline with GFP_NOWAIT
> > >
> > > This commit aims to resolve performance regressions with ftrace graph tracing
> > > when there are a large number of tasks. It replaces the pre-allocated batch
> > > approach with inline allocation using GFP_NOWAIT, avoiding repeated sweeps of
> > > the task list. Additionally, it transitions the RCU read-side section to use
> > > scoped_guard(rcu) instead of manual rcu_read_lock and rcu_read_unlock calls.
> > >
> > >> diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
> > >> index 40d373d65f9b9..1c5ccc3f80d53 100644
> > >> --- a/kernel/trace/fgraph.c
> > >> +++ b/kernel/trace/fgraph.c
> > > [ ... ]
> > >> @@ -1057,26 +1056,37 @@ static int alloc_retstack_tasklist(unsigned long **ret_stack_list)
> > >>              }
> > >>      }
> > >>
> > >> -    rcu_read_lock();
> > >> -    for_each_process_thread(g, t) {
> > >> -            if (start == end) {
> > >> -                    ret = -EAGAIN;
> > >> -                    goto unlock;
> > >> -            }
> > >> +    scoped_guard (rcu) {
> > > [Severity: Low]
> > > Does this mix goto-based error handling and scope-based cleanup within the same
> > > function?
> > >
> > > Looking at alloc_retstack_tasklist(), the function retains the legacy goto free
> > > path in the initial pre-allocation loop (just before this block), while
> > > introducing scoped_guard(rcu) here.
> > >
> > > The cleanup subsystem guidelines recommend that for a given routine, we should
> > > convert all resources that need a goto cleanup to scope-based cleanup, or
> > > convert none of them. Mixing these paradigms creates confusing ownership
> > > semantics and is highly prone to double-free or resource leak regressions upon
> > > future modifications.
> > >
> > > Could we either convert the ret_stack_list array cleanup to use scope-based
> > > helpers, or stick to the manual rcu_read_lock() and rcu_read_unlock() here to
> > > keep the error handling style consistent?
> >
> > And a third option is to drop the fallback allocation completely and
> > return -EAGAIN and come back. Granted I don't have much experience of
> > typical handling of GFP_NOWAIT fails and retrying immediately: would
> > that recover at all or does that take us back to where we started ? Peter
> >
> 
> Not Peter, but I don't see a problem with scoped rcu and goto-based
> free/cleanup. Unless Peter objects, let's keep it as is?

Yeah, the silly robot is being silly. Code is fine as is.

The guideline is just that, a guide. Its not a hard requirement. It is
possible to create a terrible mess of things when doing a partial
conversion of a large multi-stage goto unwind fest. But in general, goto
over the scope (as here) is fine. Also goto out of a scope is also fine.

