Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.92.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794478275;
	b=yNwYGB6S2Eb38WHmsLrlSGTnhhcgExdUXiDPiWVicmOnLRnSwVLjuY53oSpp1SRuaevL
	 7Nq/lI4nai6H8nSTxtgz+w+IQ+856+Mvo1x/9BmF5A+Z1V/UYpnODzmqMGMk+Jer8ZAZk
	 lWnPbVJVVrbeJ82CM7bH6NkjWtFFk7MnIjnf3eCzdBJaDXVSuQliefZ/bXapaxxPMGpAP
	 Img62o93G8nkg1tXQSaIItwFPjkdtPZvrqZKbJiAIlGjYEOl5eincP0A1HuGp10OOqtqF
	 0dRaFRJperSH5xk5Jm9TvHyiTyw36NN3dRHWIZNISFTRjLB7Y65Vo/hkshcSsyotb6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794478275;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=7Q0PBfVVJl39z4M/NZGwQrOiJIvhiLbfabOfTbTalbs=;
	b=HhtLyD0EDwGcurLhsDIz+2XA7wO/TBuFuRFyhvEbCHqmrxpY3FPdpVNnHXmRVV7scpUK
	 NIzeRhnepvbZs9xUSWm4mx5Eo8N/EAb0WRsC9I5vmPu66UqCPVR587dKpwwHURU/2Td7H
	 bcD5mrGDF2pIq2SxoxiJo6M0cVRXU2BXzlOHBCh/IUbT5GNMGt/PF+gmNtop4o/YiSmQY
	 3BSSnpCIjB40SvWZysr2VKNbs80JCDoW6Je1mCAvQf0i/AyApRDG32zczxSnk2WIeFsBP
	 sVhaLkOlaQiuLo318zv8XJV8sPmn68I8nMIRaosP44sfQVy0zdb2x6ooI8h/7vX/Nfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=LqMs+jU7;
	arc=none smtp.remote-ip=90.155.92.199
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0418606A327;
	Thu, 12 Nov 2026 10:11:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D0418606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=LqMs+jU7
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=7Q0PBfVVJl39z4M/NZGwQrOiJIvhiLbfabOfTbTalbs=; b=LqMs+jU7fv6JRVCZaBJAjZvZVW
	mxpqLYwG9rQez3RkdF+5Ue2RvIjCYhd17DMzbFTCLuVRGgqKJRQcnzxSCp8n7xY5Pw9MNDYuQ0R0i
	PpyKWu4aUqkNstOi9kJdqxxGehZUtZR0EUJ8/pfrYytIUsO4UchNeu9+LZgQfA9Il4Jgs8yGFbeJl
	YfBk8LLuY7VncB1UQ4xLX6RRQghGD/uawN8m8xxJ3wvd8crFNRm/U5iIZbRExYLN5+E5rLw6F7XEB
	gSv89dd/eQBvCO6xuUaNBXr7bJBy0RRWhqZQQ0ggInoCHIkLSaIBH2Khc1BAnt9y2l3lUSveO2IIr
	r9m2XCcQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRRlt-0000000AB67-2HST;
	Thu, 12 Nov 2026 10:11:09 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 5C70530066A; Thu, 12 Nov 2026 11:11:08 +0100 (CET)
Date: Thu, 12 Nov 2026 11:11:08 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Naveen N Rao <naveen@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Jason Baron <jbaron@akamai.com>, Alice Ryhl <aliceryhl@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ard Biesheuvel <ardb@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Alan Maguire <almagui@kernel.org>,
	x86@kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH 01/13] static_call: Index code text reservation lookups
Message-ID: <20261112101108.GE2669272@noisy.programming.kicks-ass.net>
References: <20261109194916.1089703-1-jolsa@kernel.org>
 <20261109194916.1089703-2-jolsa@kernel.org>
 <20261112090734.GH2668804@noisy.programming.kicks-ass.net>
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
In-Reply-To: <20261112090734.GH2668804@noisy.programming.kicks-ass.net>

On Thu, Nov 12, 2026 at 10:07:34AM +0100, Peter Zijlstra wrote:
> Looking at this in a little more detail; I'm confused. 
> 
> You're literally adding an index, so that you can find the
> static_call_size, while all you really need is static_call_addr().

/size/site/ obviously :-)

> That is, you could have just created an array of relocated site->addr
> and sorted that, that would safe you a ton of indirection all around.
> 
> That is:
> 
> 	index->entries[i] = (long)static_call_addr(start + i) - (long)&index->entries[i];

Should be:

 	index->entries[i] = (long)static_call_addr(start + i) - (long)index->entries;

They have to all be relative to one location in order for sorting to
make sense.

> That will make your lookup take at least half the amount of loads.
> 
> 
> Also, you really should support modules, there is no point being fast
> until you load a module.
