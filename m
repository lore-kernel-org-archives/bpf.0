Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63BF23D9DB9;
	Tue,  9 Jun 2026 07:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780988781; cv=none; b=S8c4itwTB1uMICleiEfP4SRSFORb1m8AkI0w39f6cwLpNYF1A74/95E/VsrMoftVu2ix8U0k8qxJNhQWXY/zM4ddGUsV0sMVCo9Kg997NfSNJmb4j9h8J1GfgfcZRNTnMDg9vzlaE+ZRtvVW6ezZ3IXWRNBnlSD0azKak1YymD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780988781; c=relaxed/simple;
	bh=/1p9O9WrK8BRBzAZ2Ybv1OoY/AKYevpga6mRKbC4PJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VYlsc1MKP29FTdyICFTJWBJdgpcYPqF+FXDWXxVhsp4loDzndqR/W6r2oxzMqVKU1Z2AiBtR1onr5V9P4l2sLf6Tj3/61qBFEj1V/AGH6+AWj7KjaYk5q/Mv9gyMimfKAfFadyYeIa8DMaWFJGwYZCYC0bAXsdHB3V+RjLnO+Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=pg5y11nF; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pg5y11nF"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ob9OfVRU9ZHHyh2Prr29GebKBWTRqDdF/FoIinPntFI=; b=pg5y11nF09BUheVQ59jR8Rzyyj
	ZSZoFw3llG+GCcgFj7Nb8IxPuzjgK1Dds/rfEAgU5DKixXXOQpx233gn+ebBnw/a/bEWhJCDo5qxR
	XfabMhCOZQLuBsc89kFaof/aXhF1bHUww2go1pBXQdQ8RbFgyKHupX/qmEOHqcySfrSBDn4umJ3dQ
	Q1E52F7YWXJCs98B9S98RiGB0xEDwIYLG00kTz6NiFIlemvzpz2dNPJwZKNNoCfbfwNcZuFmGe3+J
	gsC7K4ivMSUA9Df8VeNTvy8k/f5BLtOfJV0e5hBsbB6Xa4aYy1m3rwz2Fm9vArrKmHdN3JahbxnQT
	1wT50E9A==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wWqWo-000000024tO-1NDV;
	Tue, 09 Jun 2026 07:05:40 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id AC310300642; Tue, 09 Jun 2026 09:05:36 +0200 (CEST)
Date: Tue, 9 Jun 2026 09:05:36 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: bpf@vger.kernel.org, Tengda Wu <wutengda@huaweicloud.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Alexei Starovoitov <ast@kernel.org>,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Josh Poimboeuf <jpoimboe@redhat.com>, jikos@kernel.org,
	mbenes@suse.cz, pmladek@suse.com
Subject: Re: [PATCH] rethook: Use tsk->on_cpu to check task execution state
Message-ID: <20260609070536.GF3102624@noisy.programming.kicks-ass.net>
References: <94179dab-ffb7-4fab-af45-b20bfb686ab3@huaweicloud.com>
 <20260601084001.9566b443746447ec2bb1a9fb@kernel.org>
 <20260604093445.GF3126523@noisy.programming.kicks-ass.net>
 <20260605224341.c926299d613b6102912c9a3f@kernel.org>
 <679a1c8f-1e4d-4ae5-83e1-d0068e6de1a6@huaweicloud.com>
 <20260608093449.GH4149641@noisy.programming.kicks-ass.net>
 <20260608102326.GB3161497@noisy.programming.kicks-ass.net>
 <20260608220811.d4a0b58961cfb9eeb6bbbccb@kernel.org>
 <20260608140654.GE3102624@noisy.programming.kicks-ass.net>
 <20260609134153.d06aef367a366e5d976cba62@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260609134153.d06aef367a366e5d976cba62@kernel.org>

On Tue, Jun 09, 2026 at 01:41:53PM +0900, Masami Hiramatsu wrote:

> > This, you cannot take locks in unwinding. The only thing you can do is
> > try to do the best you can without crashing.
> > 
> > Typically unwind only happens on self -- this is natural, a task crashes
> > and unwinds itself, or a task does something (takes a lock, hits a
> > tracepoint, etc) and takes a snapshot of its own stack, and this is
> > safe.
> > 
> > Things like live-patch use task_call_func(), which ensures the callback
> > function is done while holding sufficient locks for the task to not
> > change state.
> 
> Hmm, is there any way to ensure the function is called from task_call_func()?

Nope. And you shouldn't want to.

> (Maybe checking p->pi_lock, but this is not sure the lock owner is this
> context?) If not, I need to make this available only for current task
> (anyway it just return kretprobe trampoline address, no critical issue)
> or, introduce a spinlock.
> 
> Or, eventually it may be better to replace kretprobe/rethook with
> fprobe return handler.

I'm not sure where you're wanting to go. AFAICT the current rethook
stuff won't crash when called on an active task, it might just not give
the right results -- but that is true for the entire unwind, so who
cares?

Those who call unwind on active tasks get to keep the pieces, not our
problem etc.
