Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793009481;
	b=SAQny3+xnYjvCAK7kQi6TeG75ZDO7RIukweDN246OkxTHxWD6f4jXKrfQ/9JDkesKIK9
	 M2hNVZi5t5RSJ54+rnCmqen/K/aCUtNFJgo+EXtWHg0T+Twt2k6lo4n1ej2/uMT0nBLlI
	 KGZmfgLmnmSgCEDg7tXRuYjIzPt9hOxTzm2i76xVd3p4iebpNVjZaNIS5LwVWOuRDFXRE
	 gRW0RXKx1VtN8ScHQaJfMRL3wP51/ECxM1BJhtrV0K8wHyXEhfOhD+Vx6+E21Vo0kyegc
	 CeKHkTVz46zBjRqpqbwiB8BbNnbiHOfP/WGh4Q0z08AGIkZBKfg4Ii2taQ4Qb7xr6gg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793009481;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=nHzLAUsQ2YNWwS+va9j2/lpxa/j+AoQFACmUeHcREIM=;
	b=TjQPxEXqoxe8JtB0xcfdHpKOOG5191HdQ5nnQW1nSpVTiOM9+X4Vc2qw1Wcw6p8cEl6F
	 A8UD+fssT2sQyAJ1CrXkcGPrgjgRvxXQDPx7urPTC5qYfiaoPutmXfOmM6UL1LsgC8hlW
	 OU2dEo2fvog0HofRcaFeuOGeOipH8NyFgVTaARmOor4z4CVXdHmuEhr80vB2fM5eeYU67
	 ZcGmf3G9aI41fXD7hrw742X1U35tVHUNXUhb2pDwb+8D31SA06aham71lX27mTE31QpfC
	 hlw489zuTcugXxH30Rn0iUGeBtU4xKCtgLscOPtaEYlKn/qQSceofHI1ZKf9xyWL5yg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=1YVZacPP;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=0xswxDpu;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3A5606A31A;
	Mon, 26 Oct 2026 10:11:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5C3A5606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=1YVZacPP;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=0xswxDpu
Date: Mon, 26 Oct 2026 11:11:17 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1793009479;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nHzLAUsQ2YNWwS+va9j2/lpxa/j+AoQFACmUeHcREIM=;
	b=1YVZacPP5NPyL4rpBaTY4TTSK6ebdm3IKzjOW4/fl1/gf8jNI0CFONv1ZAQ6MRL9U2ZWYU
	UXwpv0GtvVqUSi6bo+PTnyrsw3rBxdzlIeUN56TcHSzAcI8/JACyMoOFZKlR21qr9CWbBw
	DLNfInirpQkuQWrp2HxxBSe348BaqfKeAmrAR7lsfOa7GuI4O5PEoRKyGUaFg7oZSAaojY
	Yimuf9zNWA9671E5WcR63gf9B67Omsm6FxBVaE+cUNxqPf5xG+m6RbTmnc/Ul2nbGTkINk
	ZmBkk9pPsdUKrxhdLg0t2xJoFs+dAOn+oSfz7OJ8SSGVBkXLspnvhvGpseTXJA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1793009479;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nHzLAUsQ2YNWwS+va9j2/lpxa/j+AoQFACmUeHcREIM=;
	b=0xswxDpu5/IOM5iVsYwwwQMy22SacGvOOFA0XSPsWHkfgLHtx3JPsHUNmU8yP6meOoqWKy
	rI9FTW0uOhmGSvDg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Daniel Zahka <daniel.zahka@gmail.com>,
	Alexander Duyck <alexanderduyck@fb.com>, kernel-team@meta.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Eric Dumazet <edumazet@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/4] eth: mpnic: count packets, bytes, and
 drops per ring
Message-ID: <20261026101117.YTmp0eu2@linutronix.de>
References: <20261012-mpnic-counters3-v2-0-8afba81c2d5a@gmail.com>
 <20261012-mpnic-counters3-v2-1-8afba81c2d5a@gmail.com>
 <20261016220930.i32JEcqe@linutronix.de>
 <DM8U47F4MNK3.2V54CCQ9YTNBY@gmail.com>
 <20261019215405.OCzrrKYw@linutronix.de>
 <20261019190543.419e70bc@kernel.org>
 <20261020212155.47v0ot4g@linutronix.de>
 <20261020145038.4f7eb295@kernel.org>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261020145038.4f7eb295@kernel.org>

On 2026-10-20 14:50:38 [-0700], Jakub Kicinski wrote:
> On Tue, 20 Oct 2026 23:21:55 +0200 Sebastian Andrzej Siewior wrote:
> > > > Is there any other driver doing this?
> > > > There is ::get_sset_count() and so on for the per-queue stats.  
> > > 
> > > You may be mixing up queue stats (netlink) with the old ethtool -S
> > > kitchen sink / garbage dump.  
> > 
> > The statistics is folded on device-down into a global counter. So on
> > device-up the statistics is still available. At least that is my
> > understanding. This means the per-queue stats are lost and global stats
> > don't match the per queue stats anymore.
> 
> Yes, that's intentional and recommended by the docs for queue stats.

I guess this is Documentation/networking/statistics.rst that I need to
study.

> > So if this never happens, it might not be needed to preserve this. That
> > force-RCU might not be needed. This does happen on down and I would
> > assume that the device is no longer processing packets.
> 
> The (old) ndo for stats reading runs under RCU, only.
> AI will immediately point that out if we remove the sync.
> 
> May I ask why you care? Is there another driver you're trying 
> to implement stats in? I'm not sure where you're coming from
> and therefore what to explain to you.

I tried to be useful and do so some reviews and this stats part is what
I did not expect to be "expected". I would expect per-queue stats which
are folded into device stats on query time. Anyway. Let me study what is
recommended before making noise here again.
One last thing: If you replace RCU with SRCU then the logic should
remain the same. On the plus side you would have some domain separation
and the "synchronize" part will not force/ wait for the global grace
period but be limited to the local one.

Sebastian
