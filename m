Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93561E505;
	Fri, 30 Jan 2026 01:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769736744; cv=none; b=rc59JPMyoRzRagSfl2xEeKuq5pMY8JK2b4m2hrLZE1A76PsUJxFKi+9URi8cdi4WxsT2L2QJ7ypddmJfbWFPatE1BZD7es37CU4WEcR+FYbzYCcyQlWydvwOuAvzSTVII0H1hdaVzQhpfzk8h9C8DA9XhFHTwo1p1JMrBdlIssI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769736744; c=relaxed/simple;
	bh=IFCk/ULxMdOygcWiAXu+2x98+7fnX6InI7plUc24b5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P1vIm13mBviHZOLJVovrQRwxGjxB/xEebKs4Ov0m3kCglYrnKMR4BTmRUNLhjq+2XMZc5x64JZPXynIENHdqyM0NgAo1ZX2OU2VE1WVm3/8iqSm0Ie5RTAe89t5a5+wssy6lgPyMRdMLr0xuaeyuyWdNNTFX8ZXpOVwgjvFVSxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lAybW5qy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lAybW5qy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78A6BC4CEF7;
	Fri, 30 Jan 2026 01:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769736744;
	bh=IFCk/ULxMdOygcWiAXu+2x98+7fnX6InI7plUc24b5w=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=lAybW5qyyzOmhjexjKWStG4I6O2xCN0XGzCGPOI6OltyBxKUEGdmHHivqjIV4dpYP
	 uiZGCn/V4MA6UhliDb/SeWos5eYNPZEScAcbJwSV6lgxT8leMrr5QJZvPFTbkcfE2f
	 HsLzBHukHecQLLtZZv6O75Xi1sTC9hVW4EowdKvH+lao8tqmDc/41nek5d7Azjuii4
	 QJCGvI2w7x8a2DW4QsEuSIehzSNLjFj+gFWDZ+Q8GmC6eIk97WqarnUP/Q0WJHsakz
	 OXEX13eE78MT/qPYUef8+3b0IkZAvTCL1aHgqJRYpwYbNIscomKheVW3/LGdBgwj3l
	 37i6tuQ7fadEQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 1710FCE38F0; Thu, 29 Jan 2026 17:32:24 -0800 (PST)
Date: Thu, 29 Jan 2026 17:32:24 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Alexei Starovoitov <ast@kernel.org>
Subject: Re: [PATCH v6 0/3] tracing: Guard __DECLARE_TRACE() use of
 __DO_TRACE_CALL() with SRCU-fast
Message-ID: <1d6300a5-61a8-498a-8d40-b529bacf9a8a@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260126231145.728172709@kernel.org>
 <20260126213922.0a91bfac@robin>
 <581f0711-9115-44e8-a616-06cd13563f8c@paulmck-laptop>
 <20260129193359.08230ac0@gandalf.local.home>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260129193359.08230ac0@gandalf.local.home>

On Thu, Jan 29, 2026 at 07:33:59PM -0500, Steven Rostedt wrote:
> On Tue, 27 Jan 2026 15:18:05 -0800
> "Paul E. McKenney" <paulmck@kernel.org> wrote:
> 
> > Ah, I get it.  I think.  NMIs, right?
> > 
> > In your source tree, line 792 of kernel/rcu/srcutree.c is this line of
> > code, correct?
> > 
> > 	WARN_ON_ONCE((read_flavor != SRCU_READ_FLAVOR_NMI) && in_nmi());
> > 
> > If so, could you please try this test with the patch shown at the end
> > of this email?
> > 
> 
> > 
> > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> > index c469c708fdd6a..66ba6a2f83d3a 100644
> > --- a/kernel/rcu/srcutree.c
> > +++ b/kernel/rcu/srcutree.c
> > @@ -789,7 +789,8 @@ void __srcu_check_read_flavor(struct srcu_struct *ssp, int read_flavor)
> >  	struct srcu_data *sdp;
> >  
> >  	/* NMI-unsafe use in NMI is a bad sign, as is multi-bit read_flavor values. */
> > -	WARN_ON_ONCE((read_flavor != SRCU_READ_FLAVOR_NMI) && in_nmi());
> > +	WARN_ON_ONCE(read_flavor != SRCU_READ_FLAVOR_NMI &&
> > +		     read_flavor != SRCU_READ_FLAVOR_FAST && in_nmi());
> >  	WARN_ON_ONCE(read_flavor & (read_flavor - 1));
> >  
> >  	sdp = raw_cpu_ptr(ssp->sda);
> 
> It appears to fix the issue.
> 
> Tested-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> 
> Care to send a formal patch, and I'll add it before the patch that causes
> issues.

Thank you, done, and apologies for the hassle!  This should show up
here in a bit:

https://lore.kernel.org/all/8232efe8-a7a3-446c-af0b-19f9b523b4f7@paulmck-laptop/

And I have it below, just in case.

							Thanx, Paul

------------------------------------------------------------------------

commit 0bf3a51bef3c33ea528c96720ab6d6211d9009cf
Author: Paul E. McKenney <paulmck@kernel.org>
Date:   Tue Jan 27 15:20:02 2026 -0800

    srcu: Fix warning to permit SRCU-fast readers in NMI handlers
    
    SRCU-fast is designed to be used in NMI handlers, even going so far
    as to use atomic operations for architectures supporting NMIs but not
    providing NMI-safe per-CPU atomic operations.  However, the WARN_ON_ONCE()
    in __srcu_check_read_flavor() complains if SRCU-fast is used in an NMI
    handler.  This commit therefore modifies that WARN_ON_ONCE() to avoid
    such complaints.
    
    Reported-by: Steven Rostedt <rostedt@goodmis.org>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
    Tested-by: Steven Rostedt <rostedt@goodmis.org>
    Cc: Andrii Nakryiko <andrii@kernel.org>
    Cc: Alexei Starovoitov <ast@kernel.org>
    Cc: Peter Zijlstra <peterz@infradead.org>
    Cc: bpf@vger.kernel.org

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index c469c708fdd6a..66ba6a2f83d3a 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -789,7 +789,8 @@ void __srcu_check_read_flavor(struct srcu_struct *ssp, int read_flavor)
 	struct srcu_data *sdp;
 
 	/* NMI-unsafe use in NMI is a bad sign, as is multi-bit read_flavor values. */
-	WARN_ON_ONCE((read_flavor != SRCU_READ_FLAVOR_NMI) && in_nmi());
+	WARN_ON_ONCE(read_flavor != SRCU_READ_FLAVOR_NMI &&
+		     read_flavor != SRCU_READ_FLAVOR_FAST && in_nmi());
 	WARN_ON_ONCE(read_flavor & (read_flavor - 1));
 
 	sdp = raw_cpu_ptr(ssp->sda);
