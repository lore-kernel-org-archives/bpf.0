Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4013238F95B;
	Thu,  2 Jul 2026 07:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782976821; cv=none; b=m3uRw+/s8l6aRiZyY0LXDyCtZ2fiNSKf2gctdlcEbCNzxybrWTzERy+T0B5PxHHf9xwN6br6ak9Pz0JoVLv3V/n5Be6AiOKpLK4XD1/6cWrOOQVNmFy7tUvrjPUjU5UEDKlsXdFXzeWihsFWlSswxvFSb6sh+0VetTY0MfzT8JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782976821; c=relaxed/simple;
	bh=dx2VXafrO//xdt38szlB83WfwfzKrsb2hSYoKVkcfLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hb+K8aW8vkqUnaF8V6177CHH4qYW7LvXaFQudJXLBU+7dIixWYBF3J8Pp2E9mOZoqNyrMNtQusNiaYbGBAw9ezFhBgSJCdVt4iN+Xsj+l+ighLkfHAyC7RITpdagGLJjpVeFDJusvy4hYYjt1tN19jdlnr8Z3wNZ/khzCCn8rFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=pHbKErVk; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pHbKErVk"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=s4GrMuQi2v79BhoyZqc3BN/543xsjIK9xGProY+jboI=; b=pHbKErVkucrnsb7fbxysDVlVSG
	/M+WqSaJOq2Sr0DzscX/VDopGLY9lSnnpWak+WOOX5ykxTIFrmSAQjMt6Lhmi2DK0IyPQrbGKEQJB
	jwf6IljbK0q1/aoIylXIjYL75ETSyv2XJnw27CzeFUB9oCPjeGuNdfyGo8aYyOzzGnIJnZ76t+yzF
	P9AHY5qgiliC1XvY39fcd7vm/CrN6V9pmDEZBdMjaFPO7hq2DuniNiTB44q87MpRmIpNI6ucI/i+a
	1emO8O9U3TvI4PtFLYdWeZpPJfzb4304l0jp4y21hEWRD02VVIO7o+4hO7vc5D39cn8lLujs0eis9
	FUvK9MPg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wfBiQ-000000086O7-1mO4;
	Thu, 02 Jul 2026 07:20:06 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id DC7AF30035C; Thu, 02 Jul 2026 09:20:04 +0200 (CEST)
Date: Thu, 2 Jul 2026 09:20:04 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Ingo Molnar <mingo@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCHv4 00/13] uprobes/x86: Fix red zone issue for optimized
 uprobes
Message-ID: <20260702072004.GA49951@noisy.programming.kicks-ass.net>
References: <20260526205840.173790-1-jolsa@kernel.org>
 <aiEiP54zktDqAZpG@krava>
 <CAEf4Bzbrd8xs5sSwEPR336=7z2FGcdXVtV-aVZ4W1zSjHkwwcg@mail.gmail.com>
 <CAEf4BzYmgj55UnBX2fRoKwtc-97vc7Sf1opWcAXzSKKLr_Ei6A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzYmgj55UnBX2fRoKwtc-97vc7Sf1opWcAXzSKKLr_Ei6A@mail.gmail.com>

On Thu, Jun 25, 2026 at 10:44:18PM -0700, Andrii Nakryiko wrote:
> On Mon, Jun 8, 2026 at 1:48 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Wed, Jun 3, 2026 at 11:59 PM Jiri Olsa <olsajiri@gmail.com> wrote:
> > >
> > > On Tue, May 26, 2026 at 10:58:27PM +0200, Jiri Olsa wrote:
> > > > hi,
> > > > Andrii reported an issue with optimized uprobes [1] that can clobber
> > > > redzone area with call instruction storing return address on stack
> > > > where user code may keep temporary data without adjusting rsp.
> > > >
> > > > Fixing this by moving the optimized uprobes on top of 10-bytes nop
> > > > instruction, so we can squeeze another instruction to escape the
> > > > redzone area before doing the call.
> > > >
> > > > Note we need upstream update first for patch 3 (github.com/libbpf/usdt),
> > > > if we decide to take this change.
> > > >
> > > > thanks,
> > > > jirka
> > > >
> > > >
> > > > v1: https://lore.kernel.org/bpf/20260514135342.22130-1-jolsa@kernel.org/
> > > > v2: https://lore.kernel.org/bpf/20260518105957.123445-1-jolsa@kernel.org/
> > > > v3: https://lore.kernel.org/bpf/20260521124411.31133-1-jolsa@kernel.org/
> > > >
> > > > v4 changes:
> > > > - do not use 2nd int3 (ont +5 offset) because the call instruction
> > > >   is allways the same for the given nop10 address [Andrii/Peter]
> > > > - unmap unused trampoline vma after unsuccesfull optimization [sashiko]
> > > > - small change to patch#2 moved user_64bit_mode earlier in the path
> > > >   and pass/use mm_struct pointer directly from arch_uprobe_optimize
> > > >   instead of gettting current->mm
> > > >   Andrii, keeping your ack, please shout otherwise
> > >
> > > hi,
> > > I think bots did not find anything substantial, I have just small
> > > selftests changes queued for v5
> > >
> > > any other feedback/review would be great
> > >
> >
> > one small nit on only, otherwise LGTM.
> >
> > Peter, Masami, Ingo, should this go through tip tree or should we
> > route this through bpf-next tree? I think we are fine either way, but
> > might be more convenient to route through bpf-next given libbpf and
> > BPF selftest changes.
> >
> 
> I'll assume that no one has any objections to route this through
> bpf-next. We got reviews from Oleg, so that's great. Jiri, seems like
> you will do small adjustments and send v5, please do, and then unless
> meanwhile no one raises any issues, this will go through bpf-next.
> Thanks!

Is it already applied? If not, I can stick it in tip/perf/core (and the
first in /urgent).
