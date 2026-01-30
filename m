Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44643559DA;
	Fri, 30 Jan 2026 17:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769793462; cv=none; b=mOMtrJJFI8xwHK10YqhXV+l3GFRy+a7b2Tf9HGKl62p6Eky9+UFIn8SZ0juzPqBkaXJklCmTFJqCcqkVlocG/T0gDlyWzxbqdIoQexMmrepZLoAjSbJpyaxiEVffFWrRIF527R8gGnHOxTWokyQJUCgm/LOwhDX97KN6ex4BL+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769793462; c=relaxed/simple;
	bh=6WH2JiWpUwtSy2YEgZz/amy0gqy++66/ns2O7K3oeIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Glvh358DOIUZ7Iq/ytJsdlM2yu1612LWW6qrHxe5KT3qMu6FI++zkC4Z5R8hi9NT8A7dyapuziJfAF7JMa4h7aXWMyT6Is88FiR0+r37KK/A6pOMGDpu7rFfjXr3IEVUPQhRkMvq/xTZUUY6IVH5y1xU5F0AoGwyAl7ByNP1jws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QkIJqHpe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QkIJqHpe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42130C4CEF7;
	Fri, 30 Jan 2026 17:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769793462;
	bh=6WH2JiWpUwtSy2YEgZz/amy0gqy++66/ns2O7K3oeIc=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=QkIJqHpeUFF4wfqIJFJjzru2w5TUXqDVd9/PcwuTbqT5fIqZZ6BiirNoeRkeKs31w
	 6CHNG30GSAAFnxA0igkXJpV/DuModCYd+t3EANh+4PVezua/8gCMKs8G1LinG5GFLr
	 BzfBZN8oVQXJ8y/pbhBQwNt2zzNuAJ0xrw9pqlkboc+Ld+fZoE6WzsUoFteNw79eqL
	 C/3u9Z9DpC6cExSr5eF4bIPyPSbB3poEjGxrwR/w4kT6xSvYCCSp5gxynlqO/LvUpL
	 RVc0uS81QefGQVClecsCTnHJqC1o0aM8SfwPxptSauJsi05LTTcaUcnEAIPGwsS74/
	 9IcUDthPAlL3A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id C640ACE289D; Fri, 30 Jan 2026 09:17:41 -0800 (PST)
Date: Fri, 30 Jan 2026 09:17:41 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Boqun Feng <boqun@kernel.org>
Cc: Steven Rostedt <rostedt@kernel.org>, linux-kernel@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, bpf@vger.kernel.org
Subject: Re: [for-next][PATCH 3/4] srcu: Fix warning to permit SRCU-fast
 readers in NMI handlers
Message-ID: <7ed7a968-4a37-4166-b9cb-09bccc18fd4d@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260130154607.755725833@kernel.org>
 <20260130154639.883617005@kernel.org>
 <aXzTdOTyxuH-51_t@tardis.local>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXzTdOTyxuH-51_t@tardis.local>

On Fri, Jan 30, 2026 at 07:51:16AM -0800, Boqun Feng wrote:
> On Fri, Jan 30, 2026 at 10:46:10AM -0500, Steven Rostedt wrote:
> > From: "Paul E. McKenney" <paulmck@kernel.org>
> > 
> > SRCU-fast is designed to be used in NMI handlers, even going so far
> > as to use atomic operations for architectures supporting NMIs but not
> > providing NMI-safe per-CPU atomic operations.  However, the WARN_ON_ONCE()
> > in __srcu_check_read_flavor() complains if SRCU-fast is used in an NMI
> > handler.  This commit therefore modifies that WARN_ON_ONCE() to avoid
> > such complaints.
> > 
> > Reported-by: Steven Rostedt <rostedt@goodmis.org>
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > Tested-by: Steven Rostedt <rostedt@goodmis.org>
> > Cc: Andrii Nakryiko <andrii@kernel.org>
> > Cc: Boqun Feng <boqun@kernel.org>
> > Cc: Alexei Starovoitov <ast@kernel.org>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: bpf@vger.kernel.org
> > Link: https://patch.msgid.link/8232efe8-a7a3-446c-af0b-19f9b523b4f7@paulmck-laptop
> > Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> 
> Thank you, Steven! I will drop this in the RCU PR since you already plan
> to carry it via tracing.

Thank you both!

							Thanx, Paul

> Regards,
> Boqun
> 
> > ---
> >  kernel/rcu/srcutree.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> > index ea3f128de06f..c4a0a93e8da4 100644
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
> > -- 
> > 2.51.0
> > 
> > 
