Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792533040;
	b=oOGm2tgZpEOj8FZE1xFJIGi1zKW5ZMinW/tuQXDUP7Qwx0vJ+9JtGUxm/tsiRiJYnylS
	 LKzH2q3NBlSGqxm4TlTEOEZ36C8JKx3dZj1pS3Jmbwo1D0/DvZxDgrkhj+YsI9WfkkDau
	 o68Q/lFFa0PCeoUKeada/bHL/tdRkT9LFeklin/DBYOWEDyqL7jTdB3JSClF6/sEZB5Oi
	 2FZ2auqNb2RVgSQIIq5YahphpPZhXmBhhSMeirx9WuMgGHosgyKezPQXAoLnNVQia+Q59
	 U3rBLWzCX5m4mjD59WN4K7u4czLw6fT+xedVyZd+HMUzpEjVBa68J9e/XFkRSfLICMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792533040;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=wh0AGYPF6mCurL31eIvMZgQeZnelcGsoRPRPBnoOqTQ=;
	b=IrjVr9OoTRqnNxM3JapRZkriWEWYebMn+0hOm4XE24uGNGFp+5sto0jeY9QbII84wV8Y
	 RHGf10mcN8Wd6DgZwn7e+Zq+gh7amB09zRPhikPft6e9VvEEOStU8fxT384/TI+kFHQzb
	 O6190yD4Pk/M0Df216RJj7/QDzFQ7w05fm6hdFvelUVxeBuC2dYmQFoq51ghjDkB20qXM
	 EwY4PGpWWiBLF2q/lr8gD/lnjiolTk9/HgM/4ek/7wZ03UC0nHbxD1IXbIJYgDX3Uiem3
	 0UhfH7/nu1b3WDP2uWlCHRMvUSMbt720U+cZ7lXbkav4u1r1IXGo8wUVTK4pqGdUxBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i+Paarq3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B71606A319;
	Tue, 20 Oct 2026 21:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i+Paarq3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 845821F000C9;
	Tue, 20 Oct 2026 21:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792533040;
	bh=wh0AGYPF6mCurL31eIvMZgQeZnelcGsoRPRPBnoOqTQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=i+Paarq3UVuSI3LH6bh9wFDgAOlMbD1z3j5tUg8jygIOlmLHlG7lsBudUxIO0HN6j
	 sid+0HKW9INRsXYVLs1lK2U91MTfTkli3Xcd337UdJZ1JMaU1Sh1oQ0gCC+ofsu/hY
	 RzsyLqDyomh0tto99ufDTzd/Pr9UOiS6a8bw0l0/UbY4Vcvk4kkz3PfGMewW7TUdD4
	 mN8C84+XDwE28sEMO/GRgnFgAvaHHSKu++4vVwSIJE/g2/k1KdHC7q3aoqIIRgI06V
	 Fk9VpqQHIwqQde4TkIgffbRim73dh3V/bBBg0dDqSMOOQxfBNAHQErhIGt7U7Rks3u
	 VbD+DQaH7m39Q==
Date: Tue, 20 Oct 2026 14:50:38 -0700
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
Message-ID: <20261020145038.4f7eb295@kernel.org>
In-Reply-To: <20261020212155.47v0ot4g@linutronix.de>
References: <20261012-mpnic-counters3-v2-0-8afba81c2d5a@gmail.com>
	<20261012-mpnic-counters3-v2-1-8afba81c2d5a@gmail.com>
	<20261016220930.i32JEcqe@linutronix.de>
	<DM8U47F4MNK3.2V54CCQ9YTNBY@gmail.com>
	<20261019215405.OCzrrKYw@linutronix.de>
	<20261019190543.419e70bc@kernel.org>
	<20261020212155.47v0ot4g@linutronix.de>
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

On Tue, 20 Oct 2026 23:21:55 +0200 Sebastian Andrzej Siewior wrote:
> > > Is there any other driver doing this?
> > > There is ::get_sset_count() and so on for the per-queue stats.  
> > 
> > You may be mixing up queue stats (netlink) with the old ethtool -S
> > kitchen sink / garbage dump.  
> 
> The statistics is folded on device-down into a global counter. So on
> device-up the statistics is still available. At least that is my
> understanding. This means the per-queue stats are lost and global stats
> don't match the per queue stats anymore.

Yes, that's intentional and recommended by the docs for queue stats.

> > > If the interface goes down and frees all its queues, then the stats are
> > > gone, true. But preserving them at the price of two (down+up) forced RCU
> > > grace period, I don't know. It looks like a bit too much.  
> > 
> > This is a modern driver, the down / up path is not taken when interface
> > is reconfigured. It's only taken when the interface is actually taken
> > down or bought up. Which virtually never happens for a datacenter NIC.  
> 
> So if this never happens, it might not be needed to preserve this. That
> force-RCU might not be needed. This does happen on down and I would
> assume that the device is no longer processing packets.

The (old) ndo for stats reading runs under RCU, only.
AI will immediately point that out if we remove the sync.

May I ask why you care? Is there another driver you're trying 
to implement stats in? I'm not sure where you're coming from
and therefore what to explain to you.
