Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792531320;
	b=yAuI5R/ovsDBzR019y3z48IbDKjwvzHnhguZ1DsncwhvE678F5KEhi2UD0lO3xD5OzT3
	 ZkdBFjD93kdKTIzpQ3wmBte2Qdh3XFEoIMP9TMf/h3TywlMbS9KnZZPVt34dG6LDif7zF
	 PjB2lkxKLHfD7IvCjY/PeliY38vp+KbUcjOQiv+GW2BcgoLSoAEYyPkA/qy8AoFnUqNxm
	 usAMoN1H1rLsdygPBMDJFRt2G1aTbmSLiOyt3+gR1Vz7YhigRaR2eP3NhAy8uagbUWc9J
	 3fdr/WsM1aLTOno0mZTpFOCWpS2dVjYM4ZJQfb2RZDzLR87Jlk57E799huEY287qwKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792531320;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=L4lW4QRgtgru/oJ0WAOdQrIQ+BhNIuEeNA/PzS3zOCU=;
	b=QOlWEbU71aI200lJeOPqFhlY0yH7kjEr4BxSkEUb0lkeZWoJOUOoYGmKjbb+Lej/s9t5
	 GDTjSi4uNgzx6qVHqDJdnFV7bmNek/1qMTxq9gvP7GsztKtwl59atM26HNv/A/7/gEk7U
	 UNM4gDr/P5Pw4lS3Wp3ujb6edLpkpML5WKNGkXa27zO1/0y8bu5hMQscL1kHp/lmpansC
	 bXaP1A+3OzR5VDRFeiS0sEdZoysPhfP9CIMOjQzWhfeyO/TRoHTKigyUYSZVMrbA/YnZO
	 1Nr2b7M7V7X5b3nz0yjxzs11aUOCSyKHUUpZ3vBALPnY2UoEx8uflcsTG3clXdhuY9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=wshPDE74;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=WUNt9Kam;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86818606A31A;
	Tue, 20 Oct 2026 21:21:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 86818606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=wshPDE74;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=WUNt9Kam
Date: Tue, 20 Oct 2026 23:21:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1792531317;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L4lW4QRgtgru/oJ0WAOdQrIQ+BhNIuEeNA/PzS3zOCU=;
	b=wshPDE74zOyIJblawM0ld+RVwBdmNL+hTu4IkXviGe8mBvFDgUQnY0ypd7Ox/aKJX5xV41
	vjjahZR1uYWTTkrRst4uSI6Xc1mCi3LwKp9kEzqv3t4tgDwJPAxiZpRO4GxU8WE0ORmH4b
	h0TR1bqKzkEffTFnJxV6qOn4bKKxbQYz0Ib15TZ7/qnGTsGvp3PojpUbzAqUMjlP+RTLeu
	Wm/foE4AAXB7Ht1sG2dPRUYX5UuF8bQxLB4aTvexAOnk4x6e3QRHLTY+VBLrT1iFlFi35G
	ctewgWr/VcXTFf4YgJdEK7oGfdOVtDU2XBcmtNWiv5asayyx95R3qwDxArfpMA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1792531317;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L4lW4QRgtgru/oJ0WAOdQrIQ+BhNIuEeNA/PzS3zOCU=;
	b=WUNt9KamSn2SD6IiwERG2R4ZVIcxL9GDX/e8f7Axht6534Bijne2Msy8+pClpbxb9VXoPQ
	Wb3xzWg93+LAwdAQ==
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
Message-ID: <20261020212155.47v0ot4g@linutronix.de>
References: <20261012-mpnic-counters3-v2-0-8afba81c2d5a@gmail.com>
 <20261012-mpnic-counters3-v2-1-8afba81c2d5a@gmail.com>
 <20261016220930.i32JEcqe@linutronix.de>
 <DM8U47F4MNK3.2V54CCQ9YTNBY@gmail.com>
 <20261019215405.OCzrrKYw@linutronix.de>
 <20261019190543.419e70bc@kernel.org>
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
In-Reply-To: <20261019190543.419e70bc@kernel.org>

On 2026-10-19 19:05:43 [-0700], Jakub Kicinski wrote:
> On Mon, 19 Oct 2026 23:54:05 +0200 Sebastian Andrzej Siewior wrote:
> > On 2026-10-19 09:04:38 [-0400], Daniel Zahka wrote:
> > > > Why do you have the two mpnic_base_stats and fold the stats into into
> > > > it? My guess would be that on stop the counters are reset and you want
> > > > to preserve the stats.
> > > >  
> > > 
> > > Not sure I understand. I think you are asking about two things:
> > > 
> > > 1. Why have two mpnic_base_stats?
> > > 
> > > To avoid a separate heap allocation that can fail. Handling an
> > > allocation failure in the ndo_stop path when doing the aggregation into
> > > the base stats is tricky.  
> > 
> > Right. But looking at hinic3_get_stats64() for instance (I just grabbed
> > a random one) it simply does query the stats for each queue, add up,
> > return. It probably does not drop the queues on down, just reallocates
> > them while changing the number of queues (and maybe MTU).
> 
> I don't think pre-allocating stats for chips which supports thousands
> of queues is reasonable.

I don't mean to pre-allocate stats. If device-down removes queues then
the stats gone, so what. The queues could remain.

> > > 2. Why split stats into base stats and per queue stats, and why reset
> > > the per queue counts when the device transitions down?
> > > 
> > > This is the way the stats in netdev.yaml are exposed depending on the
> > > 'scope' request attribute. My reading of the relevant kernel docs is
> > > that the per queue counters are counting events for the current live
> > > queue, so it makes sense to reset them and fold those counts into the
> > > base stats when the interface is transitioned down.  
> > 
> > Is there any other driver doing this?
> > There is ::get_sset_count() and so on for the per-queue stats.
> 
> You may be mixing up queue stats (netlink) with the old ethtool -S
> kitchen sink / garbage dump.

The statistics is folded on device-down into a global counter. So on
device-up the statistics is still available. At least that is my
understanding. This means the per-queue stats are lost and global stats
don't match the per queue stats anymore.

> > If the interface goes down and frees all its queues, then the stats are
> > gone, true. But preserving them at the price of two (down+up) forced RCU
> > grace period, I don't know. It looks like a bit too much.
> 
> This is a modern driver, the down / up path is not taken when interface
> is reconfigured. It's only taken when the interface is actually taken
> down or bought up. Which virtually never happens for a datacenter NIC.

So if this never happens, it might not be needed to preserve this. That
force-RCU might not be needed. This does happen on down and I would
assume that the device is no longer processing packets.

> I don't mean to dismiss your concerns, we agonized over this off-list
> for a week, and don't love the resulting flow, either. But I strongly
> prefer the RCU grace period that never really runs, but is easy to
> reason about, to more advanced fixes which use memory barriers etc.

Right. If you think is all makes sense and is needed then why not. It
just looks odd.

> Anyway, I'll punt to Paolo for the final call but I think this is fine.
> 
> Acked-by: Jakub Kicinski <kuba@kernel.org>

Sebastian
