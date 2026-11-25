Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.92.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795622658;
	b=Wcb/78agj7s1TdrpiGCFNxwUyK5bYgsxlYw/vvKbbcUlq4RoDt5XsXCgiez3KJ6tvzBS
	 QcgxcTQGOvzZguQ+mAU+Hov28iqmOtf3mmglFUzFjB9dWlWgpW18lIaPX7WumeBPsp2IV
	 JExQaluRzF4DTy++AHpcRffRotQ7jDia62/gymdMPt1FqchtXcHmK/dLPN8SLqhjSwfDE
	 UJivSQxsqjuA/yGwdrLmBUkAwhe31O8SqQY9b5TNsAKqIZ5u0p83aiZIXhgd8i6HREu9Q
	 EJK+OMDpGVMsyOGg8ppVsI2U+5Snq6LvEEwCMxEYh7wnnz+Db7PlLpEEewsVbnN4SuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795622658;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=LozVc94GvRrMpc05Z6BHALOclMWxHaFig1ixRTKkdyU=;
	b=O2d/JIyws3xwmXSPpujJZta3kW0xW5lsueKEiSsPOxJm/dFXbMKt+b0JocqXSlnzhRCA
	 SGy6qMmQDr2sW5nrlga0zNU3d3kDRXfQ2QZhqWVucaz9eZTHrSbgYrkGtUVNopmjWkV8H
	 KEMQMnQr1hhbAXzi5V6ju/yYC6h2QA60C+xdAaiVNRHYQGVyTgOk64uyUell0YqyJkURc
	 q4vbY6n/DfnpDXHmXeMO2Sirtj+0tqksta1AZlDUL9QFfCbiLv7xbPnA5bMfrldof01kU
	 1YGdaR3xYJAU5Z7e9/zsCpXIXJ1IguDJZxYzhJ+BWQFXQKEv8+jphdt25zVbyZ1Nt0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=Th9WkmJA;
	arc=none smtp.remote-ip=90.155.92.199
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0070D606A32D;
	Wed, 25 Nov 2026 16:04:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0070D606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=Th9WkmJA
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=LozVc94GvRrMpc05Z6BHALOclMWxHaFig1ixRTKkdyU=; b=Th9WkmJAm20Jktbi/zYzyZaOgX
	BjVyyFdGD3TGMyljTvD+yJTzFUq9AEoZyUNauy2qrAauT95N4P/TL9iNr3hSkSm/kF7ArBq5415/S
	CoaywChZFxQy/1UnTQCVJkeW9nohTRLMNH37hcZeUvMZyFEm5aZ3S/JuPoFl69s+9dDqfNYW9nFW4
	Pb70nVw3U2LuiNZbmCrWu4ivq60e9kkzN52b1HfBUSU4QFwvUfLZLff/Zugc+yvZZfDCBd0P+vEFS
	2DWgv/zrsUEkgGngu8xYoRY6INTtaI8oa1ikYVUfb5vQ6TLpMJsaQWv2qBfVXalT9hUc2/GwzdwAb
	3l6H4OxQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWFTf-00000005Vfy-0GiP;
	Wed, 25 Nov 2026 16:04:11 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 18D053008BF; Wed, 25 Nov 2026 17:04:09 +0100 (CET)
Date: Wed, 25 Nov 2026 17:04:09 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Harry Yoo <harry@kernel.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>, bpf@vger.kernel.org,
	andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com,
	daniel@iogearbox.net,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-devel@lists.linux.dev, Vlastimil Babka <vbabka@kernel.org>,
	Hao Li <hao.li@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <brendan.jackman@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
	linux-mm@kvack.org, David Hildenbrand <david@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Boqun Feng <boqun@kernel.org>, Waiman Long <longman@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v1 1/4] bpf: Add call for selecting kmalloc or
 kmalloc_nolock at call time
Message-ID: <20261125160409.GF2668804@noisy.programming.kicks-ass.net>
References: <20261124060357.11700-1-emil@etsalapatis.com>
 <20261124060357.11700-2-emil@etsalapatis.com>
 <DN38HGVL8JHQ.2ZVZQCKFXVA9T@gmail.com>
 <awWRZ9xCzWLnj_R6@thinkstation>
 <20261125140902.GE2668804@noisy.programming.kicks-ass.net>
 <awbvek-HS3OJYJGF@thinkstation>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <awbvek-HS3OJYJGF@thinkstation>

On Wed, Nov 25, 2026 at 02:30:52PM +0000, Harry Yoo wrote:

> > This is absolute atrocious shite. You cannot attempt a spin_trylock from
> > NMI context. That thing might be a mutex.
> 
> Uh, right. We went through this when kmalloc_nolock() was introduced.
> 
> > This should not work; if it does, that is an accident we need to fix.
> 
> Current implementation handles this by can_spin_trylock() in
> mm/internal.h.
> 
> One remaining accident we're aware is that we cannot attempt a
> spin_trylock or local_trylock under pi_lock (even on !RT).
> 
> Currently I don't have a good idea to fix this :/

Yeah, me neither, other than creating specific classes of
tracepoints/whatnot where things are explicitly allowed.


