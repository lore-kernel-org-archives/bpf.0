Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792461945;
	b=btM39cTX2gVDgfSN6kPNC6+RXFR1CmXQ1v61iTw0tW7eGkkpaoutglA+GYWw1vbWr6eh
	 V8RmD9B5QG0VLT+c7seXnjGMdjodXAY20s/TLuITnkYYxLqV4Nwx3DE/2qCI8G32TEMse
	 UwjCVqR0aWp7zp+DokVsfcS1ZJ6QrElHdNKcArbodMvpcDeIGMgTf2YZ56PG1/L/YgsOc
	 X/vXPa/PmNc/mCNOwz1om2aGwZDJ5hXjUGbC8YjTx+rCGVEj1wti6msLxp6XpC7tv0XSK
	 B7uEqldiNFPN6Ty+e9Zh5T4ayTmM66I8ZoLWJ+S1uNSZC08UbZJawRPxQmJndajMlmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792461945;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=jBHDSbYOOr/pJH/I3PqMtcm89cA/njOWz0J8cUaUEs0=;
	b=g0V61S+fYvQbJiEpMBoRYEWymRP6M/CjDVs4uNsF+Lpwsg2Jr74hMZbR1UoC06qyln6V
	 OmDmXx1NaY8LWdw8SJJyjV2FrJP0zRviU3q1YMPaOAUYqkwyoop2y3djExWldfpRuwajv
	 nbAt/MeDfa/Xs4pRKEX7s46tIYiL9z8ugQ4L3Hjh5Gvb2r7efJqvr3SldyTLaM57FhS0R
	 I03QKtlP4XMjWyTE+g1j28d6r+wYFLqMoJl1uDQAv3HZKaQGCDFvZZN7z6wco2IoWiqqE
	 JbRapvsgGOfq8HgpbUosOgiPjigGPszYFnm2z5fjL45z6HNSmfHvA0frGOfGGgEUZmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="g2wvuYL/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02960606A31A;
	Tue, 20 Oct 2026 02:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g2wvuYL/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23B901F000CB;
	Tue, 20 Oct 2026 02:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792461944;
	bh=jBHDSbYOOr/pJH/I3PqMtcm89cA/njOWz0J8cUaUEs0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=g2wvuYL/xgH/RkAw0lMi5R+WvVYsCYInK6TCW7IuYIwxx2k9LB4wZJhjgYns3wWyh
	 MjrVLgiuq1HFuDpUk3pGtPCDm4iWt+s8LkvMckvenssQERLHc2ti6TchP0isHCrUeN
	 Yg8ZehenCJjO/7GJhfMWX/5SbNOkF7bN4jeMoXtCK77sme/P4E1GWN5YPRkHKbbmqw
	 S49+GmStdLpn3qe7kPvrchh5lWQ92c//trLRwINWJXG8MypCelEFIX4Cf8LZQ1Lg/r
	 tHZyFK5PpAJ00vivIRTg1XizX9eV/FzJh8L5wsqI/MxWKJdokPYfVk1osnWD49DFuS
	 zacu3fZLeXfyA==
Date: Mon, 19 Oct 2026 19:05:43 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Daniel Zahka <daniel.zahka@gmail.com>, Alexander Duyck
 <alexanderduyck@fb.com>, kernel-team@meta.com, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Paolo
 Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev
 <sdf@fomichev.me>, Eric Dumazet <edumazet@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/4] eth: mpnic: count packets, bytes, and
 drops per ring
Message-ID: <20261019190543.419e70bc@kernel.org>
In-Reply-To: <20261019215405.OCzrrKYw@linutronix.de>
References: <20261012-mpnic-counters3-v2-0-8afba81c2d5a@gmail.com>
	<20261012-mpnic-counters3-v2-1-8afba81c2d5a@gmail.com>
	<20261016220930.i32JEcqe@linutronix.de>
	<DM8U47F4MNK3.2V54CCQ9YTNBY@gmail.com>
	<20261019215405.OCzrrKYw@linutronix.de>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 19 Oct 2026 23:54:05 +0200 Sebastian Andrzej Siewior wrote:
> On 2026-10-19 09:04:38 [-0400], Daniel Zahka wrote:
> > > Why do you have the two mpnic_base_stats and fold the stats into into
> > > it? My guess would be that on stop the counters are reset and you want
> > > to preserve the stats.
> > >  
> > 
> > Not sure I understand. I think you are asking about two things:
> > 
> > 1. Why have two mpnic_base_stats?
> > 
> > To avoid a separate heap allocation that can fail. Handling an
> > allocation failure in the ndo_stop path when doing the aggregation into
> > the base stats is tricky.  
> 
> Right. But looking at hinic3_get_stats64() for instance (I just grabbed
> a random one) it simply does query the stats for each queue, add up,
> return. It probably does not drop the queues on down, just reallocates
> them while changing the number of queues (and maybe MTU).

I don't think pre-allocating stats for chips which supports thousands
of queues is reasonable.

> > 2. Why split stats into base stats and per queue stats, and why reset
> > the per queue counts when the device transitions down?
> > 
> > This is the way the stats in netdev.yaml are exposed depending on the
> > 'scope' request attribute. My reading of the relevant kernel docs is
> > that the per queue counters are counting events for the current live
> > queue, so it makes sense to reset them and fold those counts into the
> > base stats when the interface is transitioned down.  
> 
> Is there any other driver doing this?
> There is ::get_sset_count() and so on for the per-queue stats.

You may be mixing up queue stats (netlink) with the old ethtool -S
kitchen sink / garbage dump.

> If the interface goes down and frees all its queues, then the stats are
> gone, true. But preserving them at the price of two (down+up) forced RCU
> grace period, I don't know. It looks like a bit too much.

This is a modern driver, the down / up path is not taken when interface
is reconfigured. It's only taken when the interface is actually taken
down or bought up. Which virtually never happens for a datacenter NIC.

I don't mean to dismiss your concerns, we agonized over this off-list
for a week, and don't love the resulting flow, either. But I strongly
prefer the RCU grace period that never really runs, but is easy to
reason about, to more advanced fixes which use memory barriers etc.

Anyway, I'll punt to Paolo for the final call but I think this is fine.

Acked-by: Jakub Kicinski <kuba@kernel.org>
