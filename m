Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77801446BF8;
	Mon, 12 Oct 2026 11:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791806078; cv=none; b=qz8PFTVc09ljJxm3YYqUmn+ERDbgHoIxWt3EIaa4NTunftUyMsOb+L295pH8TM9uSVX4guFTmdc3ukqBbZ6kn04uTcZzmxSCHjnKWrESro6il7DLjq1F7ChIuOT4sHkkEdhBVarDGUS4Gqds6z2iqwDBdp6uguG82pydnzWyVKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791806078; c=relaxed/simple;
	bh=DkAq1DQFR/tlPeGtKw7uvWOqlsvCVtZWd047RazSY9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hSho6n8uuw3N6h9IcIpDpTM3MWJKO+KAe9w1Wtlvyis5pir/dnLYKRSRfE+fb0quUVRa3ArPF40yERr3Bp+ChUDXV9WS9KuPV2Z7OeBER1s+lHqre2k+HW2ryKk/FStF5IYERer3xwDWC0RJm7OZ2+XkDrd93oSTkEwdEPKLpvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=GHwbY3mV; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GHwbY3mV"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=tX7Kon+sEtkNnm6BjlNO1s3cXPA4vmv+FnhZk7PJB3M=; b=GHwbY3mVKHVcZ1b0mVwD9OjtG5
	q/j1wLjyUjU0nzziiI40ohPCX3D/k+VOq02YoA5PgAiVxcwKmI0Q405eoe+F3l6LYAhhBBf9ZUN7n
	lRuUQsjLvS1efEnAIDWLUoCfZmM9d7pgE7qUC5VQA3WTq6v8H+UKsHUUnPL2kUZ2OzQM6fVQiJmwF
	z2fOeQFKS80BrQ94p2gw+ahXAofBtYvXuoU3ELN30t+XRbwG82ruMh6BEtwJvmGQGVV6XwNg/XtiY
	z64/Vn7BORWN5ktJFdM67PAjWB3OcubRtaxZGI9qMD8yXK4Ph1AeXRBiNa2w+bXVrAPcUNxXrhG7V
	R+ZzfRtw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGEbv-00000004hXa-0hAL;
	Mon, 12 Oct 2026 11:54:31 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id B8EA930063F; Mon, 12 Oct 2026 13:54:30 +0200 (CEST)
Date: Mon, 12 Oct 2026 13:54:30 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Gabriele Monaco <gmonaco@redhat.com>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Nam Cao <namcao@linutronix.de>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Wen Yang <wen.yang@linux.dev>,
	Tobias Schaffner <tobias.schaffner@siemens.com>,
	Viktor Malik <vmalik@redhat.com>
Subject: Re: [PATCH v2 01/15] sched: Add task enqueue/dequeue trace points
Message-ID: <20261012115430.GD2823843@noisy.programming.kicks-ass.net>
References: <20261001152042.124445-1-gmonaco@redhat.com>
 <20261001152042.124445-2-gmonaco@redhat.com>
 <20261001154934.GT88198@noisy.programming.kicks-ass.net>
 <d75888885e2c94c1bc717faa864f609c43db874f.camel@redhat.com>
 <20261002102939.GB2823843@noisy.programming.kicks-ass.net>
 <56972260b9221128d7aaf5bb60f90611ec9d7235.camel@redhat.com>
 <20261002191842.GA1259248@noisy.programming.kicks-ass.net>
 <20261004035714.18140850@fedora>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261004035714.18140850@fedora>

On Sun, Oct 04, 2026 at 03:57:14AM -0400, Steven Rostedt wrote:
> On Fri, 2 Oct 2026 21:18:42 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > So personally I have 0 interest or use for html. Mail is text, code is
> > text, we use a text editor (neovim is my current poison of choice).
> > Nowhere is there html. So then having to look at rst is just crap. rst
> > gets in the way of actually reading the thing. All down-sides, no
> > up-sides.
> 
> This is specifically your opinion. I really liked text files, but I have
> fallen to the dark side and found reading the Documentation directory
> from docs.kernel.org so much nicer than reading the text files directly.

For me it means having to use a mouse. It means having to deal with dumb
shit like non monospace fonts and endless annoying stuff like that.

I know I'm a minority, but the web *SUCKS*. There are no wins for me.
