Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A37E2857CF;
	Tue, 13 Jan 2026 14:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768314225; cv=none; b=GFfhLkqAXBN3u7Uh/WaN4w00cPIab59J/TUNwyKvqSNG+8RAN0M3ysjlJx0WDpzB9jP05kDXk4oRH0AJ2M6aO8aA3AL5xoqvle2cSW2DWQ3mvOBKW/kPDIBRVKcXyxf4HPSMoSHg1rwCTztCJhDxumtzpN8hnd/WQvtl67TCVG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768314225; c=relaxed/simple;
	bh=/6WYYCUttI6FSLWYUO2VMRCmTddMnQOrG+e2YTZUF3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eOwZwjDPl4Qv6KgPf1gmiRPYBVTw+sKfxj3B7L2qQex2tR2reNrVdC7bSBIWlGlc9X7pthEEUduK6SnBVsOevqbBrgvkVmxLB6UUfTxwF+OykDOZ+luCqgyWQ51cP90vlMiZCM7VU7wnfw+/kA+HFh9U5O3nqWwLhnt9KvV0Yvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=COS0mLvR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=h1HOWPrF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="COS0mLvR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="h1HOWPrF"
Date: Tue, 13 Jan 2026 15:23:40 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768314222;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0QUaZ3NBQEN6pfbGUOcR9Y1sexgzwzif0TpUiLHJADA=;
	b=COS0mLvReSbab2ruPsH9pneyJYSTQMCpWCqm+DbYE05w9psnpV0PhnAOGnsLjDDX0j9fgE
	8HBNa55H+H6JmN5yO3yk9YnHtBjub4nfu6PkXseucaJ0Gr9AQEdQ8/59AQMn3wM+gt6EdM
	HerLFoS0O63VBJCQFdI47rAwJVHyndw0Ah+enVHzZRU6X0DdTKHjdIA8S3fsp58W3JGsqb
	iyU+oLqjtnEJ3UrWTLHiaQrAXKbUK8ZX37GjstL+Ec6Ot6kRzOTNKwHBef90RTIfeMl/gh
	IEvwl8l8sTsCl4EkmSZysAhUIazMrMxMuXyCBfzVmKHAgtW0+73RK8vAIKefXw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768314222;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0QUaZ3NBQEN6pfbGUOcR9Y1sexgzwzif0TpUiLHJADA=;
	b=h1HOWPrFgauPAOdnE4NhcNvvOupmKFkJ/JyjcQGv0LPhCVbYBzEVrT2qPpXORqBcnwpjR5
	vncgJEqUu5QABSDA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux trace kernel <linux-trace-kernel@vger.kernel.org>,
	bpf <bpf@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v5] tracing: Guard __DECLARE_TRACE() use of
 __DO_TRACE_CALL() with SRCU-fast
Message-ID: <20260113142340.xEFFVvni@linutronix.de>
References: <CAADnVQKGm-t2SdN_vFVMn0tNiQ5Fs6FutD2Au-jO69aGdhKS7Q@mail.gmail.com>
 <20260109173326.616e873c@fedora>
 <20260109173915.1e8a784e@fedora>
 <CAADnVQKB4dAWtX7T15yh31NYNcBUugoqcnTZ3U9APo8SZkTuwg@mail.gmail.com>
 <20260110111454.7d1a7b66@fedora>
 <CAADnVQJ_L_TvFogq0+-qOH=vxe5bzU9iz3c-6-N7VFYE6cBnjQ@mail.gmail.com>
 <20260111170953.49127c00@fedora>
 <CAADnVQJiEhDrfYVEyV8eGUECE_XFt7PGG=PFJRKU4jRBn-TsvA@mail.gmail.com>
 <20260112085257.26bb7b5b@fedora>
 <CAADnVQKvY026HSFGOsavJppm3-Ajm-VsLzY-OeFUe+BaKMRnDg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAADnVQKvY026HSFGOsavJppm3-Ajm-VsLzY-OeFUe+BaKMRnDg@mail.gmail.com>

On 2026-01-12 09:19:58 [-0800], Alexei Starovoitov wrote:
> > Now if you are saying that BPF will handle migrate_disable() on its own
> > and not require the tracepoint infrastructure to do it for it, then
> > this is perfect. And I can then simplify this code, and just use
> > srcu_fast for both RT and !RT.
> 
> Agree. Just add migrate_disable to __bpf_trace_run,
> or, better yet, use rcu_read_lock_dont_migrate() in there.

Wonderful, thank you.

Is this "must remain on the same CPU and can be re-entrant" because BPF
core code such memory allocator/ data structures use per-CPU data
structures and must use the same through the whole invocation?

I did audit network related BPF code and their per-CPU usage usually had
a local_bh_disable() in the relevant spots.

Sebastian
