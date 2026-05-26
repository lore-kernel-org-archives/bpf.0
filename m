Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0503537ED;
	Tue, 26 May 2026 09:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779787189; cv=none; b=PtchPMYc/3zKS6tWV4VJTO1dZHotRh8sqw0vmC9pzNoLD3RuOPm/5BbY1rQIEuYUf9XkW+461Unxn+yF+GxXZ8qy7KnO9REbLe7JJ9AtJ2DY7QbeeLkH4tgPr/Lpl+YqhY/i4Gyxx53QJLgQKArb1N+Ys5u/ZXpFiKm+lW6xPt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779787189; c=relaxed/simple;
	bh=Ow8gwZ4Lkp4cctgvyU9+aUk0/1z2UR5fi5awZDsKQgE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tYaXLD0ZYVQq3x0EyzDFfYjUlj0L02VmAtx8hiLO7lIO2YRoEUntmk/w/q20dgyp1BSg4yrY5RJLklJoFaaa/LD2sS4hb45WSslpWuKyx9hnfIBb68JCRlMeeZvLNo2C/Ry7YKwlt7X00rnbvoj5Vgp2LvwOfr9FMzDpOI4AIfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=P+iwEl1z; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="P+iwEl1z"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=ZsA+GRwAoN+DQ7RbB5DBHupTBdRhZ9vasf36fYJp86c=; b=P+iwEl1zKEy5v0U1vQMuz30JMn
	LUa3PKrUEhHYlCyefE5A6nagVuGWV3A9Kt90gy7pBiV4lbnPt103EFUgHU2JRAT2w2kc7Bp1EmhZX
	TfYbcGMHC3EUDG5cgWsVr0T+oosjrgXPo+bKyg11qxqvfhw1lHaFqkkIT2yx+BXgzha8F0huU0bPs
	lCgyv6IDBHfos8kaJsaGVz4kNkn7/JLpIw6cDQsH6eFQCPRcrJpl6gjcTuLF0imdRzIm41MdBv8hK
	1Wr/fKsoCYcemFIVvIlRla/Tzit2b/KD5wZZ7X6A4Zj2GDwYJZ71+MF2chmFmg+UahQ2kCer7gQVH
	rsO01Itw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRnwu-0000000ApeO-2uzK;
	Tue, 26 May 2026 09:19:45 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 7F26B3007C4; Tue, 26 May 2026 11:19:44 +0200 (CEST)
Date: Tue, 26 May 2026 11:19:44 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCHv3 04/12] uprobes/x86: Move optimized uprobe from nop5 to
 nop10
Message-ID: <20260526091944.GB4149641@noisy.programming.kicks-ass.net>
References: <20260521124411.31133-1-jolsa@kernel.org>
 <20260521124411.31133-5-jolsa@kernel.org>
 <CAEf4BzZ+MToBKJS9Vdu=YZrX+2kRpUcmWejVhuoqhtu-ijqDAQ@mail.gmail.com>
 <ahDIVTM5WfVqiYE6@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ahDIVTM5WfVqiYE6@krava>

On Fri, May 22, 2026 at 11:19:17PM +0200, Jiri Olsa wrote:
> On Fri, May 22, 2026 at 11:50:44AM -0700, Andrii Nakryiko wrote:
> > On Thu, May 21, 2026 at 5:44 AM Jiri Olsa <jolsa@kernel.org> wrote:
> > >
> > > Andrii reported an issue with optimized uprobes [1] that can clobber
> > > redzone area with call instruction storing return address on stack
> > > where user code may keep temporary data without adjusting rsp.
> > >
> > > Fixing this by moving the optimized uprobes on top of 10-bytes nop
> > > instruction, so we can squeeze another instruction to escape the
> > > redzone area before doing the call, like:
> > >
> > >   lea -0x80(%rsp), %rsp
> > >   call tramp
> > >
> > > Note the lea instruction is used to adjust the rsp register without
> > > changing the flags.
> > >
> > > We use nop10 and following transofrmation to optimized instructions
> > > above and back as suggested by Peterz [2].
> > >
> > > Optimize path (int3_update_optimize):
> > >
> > >   1) Initial state after set_swbp() installed the uprobe:
> > >       cc 2e 0f 1f 84 00 00 00 00 00
> > >
> > >      From offset 0 this is INT3 followed by the tail of the original
> > >      10-byte NOP.
> > >
> > >   2) Trap the call slot before rewriting the NOP tail:
> > >       cc 2e 0f 1f 84 [cc] 00 00 00 00
> > >
> > >      From offset 0 this traps on the uprobe INT3.  A thread reaching
> > >      offset 5 traps on the temporary INT3 instead of seeing a partially
> > >      patched call.
> > >
> > >   3) Rewrite the LEA tail and call displacement, keeping both INT3 bytes:
> > >       cc [8d 64 24 80] cc [d0 d1 d2 d3]
> > >
> > >      From offset 0 and offset 5 this still traps.  The bytes between
> > >      them are not executable entry points while both traps are in place.
> > >
> > >   4) Restore the call opcode at offset 5:
> > >       cc 8d 64 24 80 [e8] d0 d1 d2 d3
> > >
> > >      From offset 0 this still traps.  From offset 5 the instruction is
> > >      the final CALL to the uprobe trampoline.
> > >
> > 
> > I'm sorry if I'm slow, but I don't understand why we need that second
> > cc at offset 5? Isn't original nop10 processed by CPU as single
> > instruction? So it will either be at ip of nop10, or at ip+10, no? If
> > we trap at ip and in int3 handler +10 from there while we are
> > installing lea+call, why do we need cc on byte 5?
> > 
> > I.e., I don't understand how CPU can end up being at ip+5 until we
> > finalize lea+call sequence? Can it?
> 
> hum, so I though it's for the case when you do unoptimize+optimize,
> then you can have cpu executing the previous lea and hitting the int3
> on +5 offset.. but as pointed by Peter (and you) the call instruction
> never changes, so now I'm not sure why we need it

So I missed you did the second INT3 in my initial reading.

That second INT3 is absolutely required *IF* the CALL can ever change.
However Andrii pointed out that once the CALL is written, it will always
be the same CALL -- there is but the one trampoline, it doesn't move.

Therefore, the second INT3 is not strictly required.

Does this clarify?
