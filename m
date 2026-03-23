Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7704392C4E;
	Mon, 23 Mar 2026 11:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774266088; cv=none; b=gU6Hk8+CcVUtRa310aw5OTFFtZAkUpsylvFspBK1/Kebzc4xXgyy5VTvz3MSPza156lZOD/KECjxNGSUCWL4K568H5DGq5DbzbMQt1tZ5WYBJABm4QLLUeL+zg45L5VAR1QM6PS1mT8dfGEsZ4xSCfIqA0UNTpNCcQLt41kvxCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774266088; c=relaxed/simple;
	bh=+fJzSJ/QClrVADTrc2CI6QfqYbfCbMX8tCh8Qzv65DU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rRYySjY5LU0YFfo4PRHOB+USDisiiY9ubB6H3sVH7lmWEnBvAfsNKVsGiIOaZgF+4uIgHs2kgWbaDSXRl6LJkcRPR2HFBLHDGTAsqF1tV2wPloDimdjAcPVptnhGfxiaI7xI5TSTmOWMYxF2WO7K3d5rCj0o831olOUThE9oeIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=g8qLJ7Bh; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="g8qLJ7Bh"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=0htsbpYkA/TpYf1sU//dIWgM9KmQIdQ5N7HcxkP6zHI=; b=g8qLJ7Bh447j+DQ14lPsx+965D
	mprtnp9kmFq6/S5/BZU/rhnh7yv2pQNr0Hz97esIJg8sAWaSeJhSJtDFnOm2cGBp74hGMmrEUoslS
	AcRLaW9cJHo3Z7keI5zgc9NsrTqI82fAuUVnAQWvNmnsSxhBNrplkt+Os4jMEQ8rqNZwI/Bt3NSsH
	fYOhv1w/tzU607l/+tS+AYr4N0vaS7x8YG+EnPamZ1q7xgXbKK60I+CsenTr3ViC3xPn6Z8OO/Zmt
	zcMpsd0bL5hM+6TTI7phdrSNsXGj87a8rkzOqBnS8Ix0qbmFSDYeR3MydHDXdaELY5AbVuXZR7Hur
	yPmo166Q==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1w4def-007VMU-8t; Mon, 23 Mar 2026 11:41:08 +0000
Date: Mon, 23 Mar 2026 04:41:02 -0700
From: Breno Leitao <leitao@debian.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, kernel-team@meta.com, 
	Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH] coredump: add tracepoint for coredump events
Message-ID: <acEmBRXmUqFc8fcz@gmail.com>
References: <20260320-coredump_tracepoint-v1-1-34864746cbb3@debian.org>
 <20260320-erlitt-ergibt-255e86a66414@brauner>
 <20260320144834.079ba241@gandalf.local.home>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260320144834.079ba241@gandalf.local.home>
X-Debian-User: leitao

On Fri, Mar 20, 2026 at 02:48:34PM -0400, Steven Rostedt wrote:
> On Fri, 20 Mar 2026 14:21:23 +0100
> Christian Brauner <brauner@kernel.org> wrote:
>
> > > +TRACE_EVENT(coredump,
> > > +
> > > +	TP_PROTO(int sig),
> > > +
> > > +	TP_ARGS(sig),
> > > +
> > > +	TP_STRUCT__entry(
> > > +		__field(int, sig)
> > > +		__array(char, comm, TASK_COMM_LEN)
> > > +		__field(pid_t, pid)
> > > +	),
> > > +
> > > +	TP_fast_assign(
> > > +		__entry->sig = sig;
> > > +		memcpy(__entry->comm, current->comm, TASK_COMM_LEN);
> > > +		__entry->pid = current->pid;
> >
> > That's the TID as seen in the global pid namespace.
> > I assume this is what you want but worth noting.
>
> Not to mention the pid is saved in all trace events and is available for
> perf and bpf too. Even the change log showed it:
>
>              sleep-634     [036] .....   145.222206: coredump: sig=11 comm=sleep pid=634
>
>                    ^^^                                                               ^^^
>
> So it should not be included. It's duplicate and only wastes space. Now if
> you wanted to save the name space pid, that may be useful.

In my use case, I don't need the namespace pid since I'm primarily
focused on system-wide monitoring, and the global pid is sufficient
for my purposes. Thanks for the heads-up.

I'll update the patch to remove the pid field.

Thanks,
--breno
