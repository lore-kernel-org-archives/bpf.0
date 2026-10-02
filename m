Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C2A47DD6E;
	Fri,  2 Oct 2026 10:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790936997; cv=none; b=hNmnAklqWXO9+rB32hny45ZchjXuxGKIeDxhe1CGvlYZkYX9MbsqQV0hTt4oA5ojLcStFSbYwEl7cfoBpxbNYB9KWxlT6lKKtO2Bu0afD2AlgCzrHaJI5vSJXHlsO4NMOrlmKiHY0D5hyIe4qOtnJsDaPnaxyAQDAWqWceiTmtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790936997; c=relaxed/simple;
	bh=4Yz9VttyjtIobBYr4zHBO6hC8p4PyUMtgFsW/tKWCxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RItKo/cp7WIS8X0eYZ2aPSLzgVAoeww2J5zqZBEsbdEk8L0Z9mVyH9N2SdTU8fgBLoTuWsb1WOMRmknsaXAYybPaXA/eMsqeHGl/70jkL6t1qtbkMn2ytscCZ5mftxh+CFw98VHM7YEh7EQYTXd9w5Xjr6yf/PjQ5Nzj4y9Gc8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=uiiqz/dG; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uiiqz/dG"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=O9DRmnwiqHKYpTYCpYE+50FxaPR56rtvVjls/+jpVIE=; b=uiiqz/dGVA1i/oX5Bd6lqAAAWb
	rf+a+NGebxFGnYuXlYKtI/e2FA9XMP2iVTZSFl79WRDhgGKM4eVedJ/5S3+uu5BAaZcmx/liU68WR
	/jSeUpxJJ4vRLw9hGpLd/jsQLXnhPQZ1JNVS9/Cbs54FkKZtVJuTZ0nCLbs42fsXI/+rItbhyvdTh
	vIU04khZRf1EYtUPqVvdnPfMZjQbvPLvo4beiscVCmQZRJeDbE5RudK7UYvRU8WfKhStZ1d0KDEGH
	JBsPE2xaEYJ+BAImKhyFS5Ov21rGY5Vxve1/WTEbeGtogO1XUQ4Z75iS7qUH/xhOqNmyIDIvyNeM3
	FKeJ+3Rg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xCaWJ-0000000H6ZJ-3dH9;
	Fri, 02 Oct 2026 10:29:39 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 19287300673; Fri, 02 Oct 2026 12:29:39 +0200 (CEST)
Date: Fri, 2 Oct 2026 12:29:39 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Nam Cao <namcao@linutronix.de>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Wen Yang <wen.yang@linux.dev>,
	Tobias Schaffner <tobias.schaffner@siemens.com>,
	Viktor Malik <vmalik@redhat.com>
Subject: Re: [PATCH v2 01/15] sched: Add task enqueue/dequeue trace points
Message-ID: <20261002102939.GB2823843@noisy.programming.kicks-ass.net>
References: <20261001152042.124445-1-gmonaco@redhat.com>
 <20261001152042.124445-2-gmonaco@redhat.com>
 <20261001154934.GT88198@noisy.programming.kicks-ass.net>
 <d75888885e2c94c1bc717faa864f609c43db874f.camel@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d75888885e2c94c1bc717faa864f609c43db874f.camel@redhat.com>

On Fri, Oct 02, 2026 at 09:09:01AM +0200, Gabriele Monaco wrote:
> On Thu, 2026-10-01 at 17:49 +0200, Peter Zijlstra wrote:
> > On Thu, Oct 01, 2026 at 05:20:28PM +0200, Gabriele Monaco wrote:
> > > From: Nam Cao <namcao@linutronix.de>
> > > 
> > > Add trace points into enqueue_task() and dequeue_task().
> > > 
> > > Signed-off-by: Nam Cao <namcao@linutronix.de>
> > > Suggested-by: Peter Zijlstra <peterz@infradead.org>
> > 
> > Obviously I don't remember anything at all. But also, you 'forgot' to
> > send me the rest of the patches which might hold a clue. As is I'm
> > clueless as to why we want this, since the Changelog also offers none.
> 
> Right..
> 
> This commit is part of [1], but borrowed from [2], which is actually more
> interesting to understand why I need those tracepoints.
> 
> [2] contains 3 other RV deadline monitors, I should have at least CC'd you in
> [3] and [4].. Essentially the enqueue and dequeue tracepoints are used to:
> 
>  * model the event from dl_server idle to ready (a new fair task is available)
>  * understand when a task is moved to and from another scheduler runqueue
> 
> Thanks,
> Gabriele
> 
> [1] - https://lore.kernel.org/lkml/20261001152042.124445-1-gmonaco@redhat.com
> [2] - https://lore.kernel.org/lkml/20260929124908.177676-1-gmonaco@redhat.com
> [3] - https://lore.kernel.org/lkml/20260929124908.177676-8-gmonaco@redhat.com
> [4] - https://lore.kernel.org/lkml/20260929124908.177676-9-gmonaco@redhat.com

So mostly I flat out out ignore partial series. It means I have to go
dig around to figure out the whole picture, and anything that requires
extra effort goes on the 'later' pile, and you know where that lives.

Now, as to 3,4; I'm confused. If I search 'enqueue' I see there is a
tracepoint attach thingy in the .c file, but I don't see the
corresponding bits in the .dot file. And per my understanding the .c
thing is an artifact of the .dot file.

So what gives?

Also, IMO it would be *much* preferred if the .rst file would not exist.
Just have the graph-easy and the description as a comment in the .dot
file. Then you have the whole thing in one *readable* place.

...insert rant on what a piece of shit rst is here...
