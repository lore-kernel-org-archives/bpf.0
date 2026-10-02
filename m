Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F37C3C2BB4;
	Fri,  2 Oct 2026 19:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790968741; cv=none; b=IwY96YBhaBDiTXVcZU675r0TRSlNyzrcOacpCVr+v+Mg0YPp0kDc0T45UsYDMvIPbD5ooL9jWIXvqytgtRccOP5aV23FPiIP0kJ2gI6BMZF024do8bA+AK3P/LhPpsfmaLwdOeHo1gMtk6UbOv+xYsdseRPUyv08oq+U2IaCu4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790968741; c=relaxed/simple;
	bh=jnAOeGmpazpaa6F0liOQgWuqc+WpTuXHDmlbHHSzhJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BIJeoFxQmazMbBpY9SlOrRakavdlfticXkan6E8LfdL385fkQTunukxBJMFPyriPOaJpYenMQ3LT5gASogzB9W5ej3F1DMY1umt22626+0F8wvWNzxUILRBBTAE7SuotiGi4wkX21gQQo0ozh1z25n+Ecg2l9NxQgzW7/OMm5nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=oQgd97MU; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oQgd97MU"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=y8MzMOtbyh0mzvxY+tu6OnDzIzuOy1UtRCB8aMJlZbw=; b=oQgd97MUFQeDpxNSe6MLHsukHW
	7KNw+ycnsj4ujG4FqEpVU7uboQfHgPEK2rzpqvpNgPfnmb2m/N+XHuP+/KNeXnT0O4BtvjRE/uXW6
	m9Q2FEnqqgxQd9oXI0k2f4/hKT8jElXUYkH8zijGpygKhmADckEuAuAXhBB1pSsl272MdFN8nFXha
	CxYvifLBOWmiuUe0dTsNypBD3syY/iMFPJxpmVNlj4lRCJ2F7ZUK4+XWrAyLLUCTdkRAnq2SzTfvu
	N4QjtwC79yz1abBGdBRmNVVyBdkoSS3u01RH3vODFfO6YNrYayMC9TfEhtRrjiwCnFqWvgJ+vg/H3
	3/h+7JvQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xCimK-00000002CL4-0aJs;
	Fri, 02 Oct 2026 19:18:44 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 0E1093008DB; Fri, 02 Oct 2026 21:18:43 +0200 (CEST)
Date: Fri, 2 Oct 2026 21:18:42 +0200
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
Message-ID: <20261002191842.GA1259248@noisy.programming.kicks-ass.net>
References: <20261001152042.124445-1-gmonaco@redhat.com>
 <20261001152042.124445-2-gmonaco@redhat.com>
 <20261001154934.GT88198@noisy.programming.kicks-ass.net>
 <d75888885e2c94c1bc717faa864f609c43db874f.camel@redhat.com>
 <20261002102939.GB2823843@noisy.programming.kicks-ass.net>
 <56972260b9221128d7aaf5bb60f90611ec9d7235.camel@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56972260b9221128d7aaf5bb60f90611ec9d7235.camel@redhat.com>

On Fri, Oct 02, 2026 at 01:55:48PM +0200, Gabriele Monaco wrote:
> On Fri, 2026-10-02 at 12:29 +0200, Peter Zijlstra wrote:
> > So mostly I flat out out ignore partial series. It means I have to go
> > dig around to figure out the whole picture, and anything that requires
> > extra effort goes on the 'later' pile, and you know where that lives.
> 
> Alright, I guess I'm going to have to fix my to_cmd script.
> 
> > Now, as to 3,4; I'm confused. If I search 'enqueue' I see there is a
> > tracepoint attach thingy in the .c file, but I don't see the
> > corresponding bits in the .dot file. And per my understanding the .c
> > thing is an artifact of the .dot file.
> 
> Yes but only partially. There isn't always a 1-1 mapping with model events and
> tracepoints.

So the .c files are no longer an artifact? That seems unfortunate. I
thought the .dot file was fully descriptive and the .c file was fully
generated by dot2c.

If we cannot fully express the automaton in .dot, we should look at
extending the 'format' and teach dot2c new tricks.

> Throttle uses handle_sched_enqueue() for one case of dl_defer_arm, representing
> a fair task running not boosted, in the enqueue case, because it was running
> with another scheduler.
> Boost uses handle_sched_dequeue() in a similar fashion to describe fair tasks
> that stop running on the fair runqueue (but may continue on another runqueue).
> 
> In both cases I'm reusing an event that can be triggered from other tracepoints
> too, ideally to keep the model simpler.
> 
> Then it uses handle_sched_enqueue() for dl_server_resume[_throttled]. They are
> both plain enqueues, in fact, so I could rename them to show what they are.

I'm not sure I'm following. Will you be in Prague next week?

> > Also, IMO it would be *much* preferred if the .rst file would not exist.
> > Just have the graph-easy and the description as a comment in the .dot
> > file. Then you have the whole thing in one *readable* place.
> 
> Well, you make a fair point, I like to have it appear in the html docs, but
> obviously no one is going to build the docs to review a patch.
> I may look into ways to get both birds with a stone.

So personally I have 0 interest or use for html. Mail is text, code is
text, we use a text editor (neovim is my current poison of choice).
Nowhere is there html. So then having to look at rst is just crap. rst
gets in the way of actually reading the thing. All down-sides, no
up-sides.

