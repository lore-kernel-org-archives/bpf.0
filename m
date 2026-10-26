Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793009592;
	b=TVBNCG7/GKoIGmhBO07/z5Q1STi0oeGvDIKPOw4F2bJFmJ3ZjOGyWRhOc/iP/T4q8sE5
	 /qt6C9eRFyMCd8i+UaKun6YnJR+e/AWXouIyYBPfElwvXzTu458E7xavSMOpp9rOcW7KA
	 At2Nsmw4e3KwzAJBqJ/YMCVh0ytZT0+nhMOMMZ5oM6WfxTpwjKfiXme78a9yl1zc5M7jC
	 jbvPirC3MJM23/qt9Ww6kl8mA4ziW7OS8MBqxu5QAbFTwSA1Lt1FchLQf9G0iyw45lzts
	 wjgqxhnT/SLNZAjcLF/lG7AXHeLfAFX/L0F5Kjt5gRxkt+x8fFxcZRQVahS+BHPTTJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793009592;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=W4JDUkT65UJKUap/Q3QCQO+wt9GFW6OJmeRPM0Y//64=;
	b=3uqA5elsoSpeaHV0zldTvhnVY+vqBUXVFvoYI6fc0glgihKgy2ElJZJgI6P2ZT2KmOZk
	 u1+6MluYXRvM4EJNs5ebS5Z1SBP1+JnZ1pfKspdm4LsapXU+8QMXYp2sMVSZ+VGO22naE
	 eWjYzIuV2JKox72Nu52K3DrT00eUVGtyVcfMp7Mv9llILqtfASM23Qzmma7KVxwhwjc+Y
	 1zRubmhNJxwMQed42Tla/Mo0P62DjF12Qf+sJBUFxXJydpE4VxG3tht4oYZLJfUbefGWB
	 0swjVWWM9mI66o/ySTN6Bbjdj2qKCbLMHqlDg8vrVz9BKe0xcs3iHctQY6uqfd8giSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=RkbyZFMY;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=PEbwae9S;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9971606A326;
	Mon, 26 Oct 2026 10:13:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D9971606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=RkbyZFMY;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=PEbwae9S
Date: Mon, 26 Oct 2026 11:13:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1793009590;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W4JDUkT65UJKUap/Q3QCQO+wt9GFW6OJmeRPM0Y//64=;
	b=RkbyZFMYs0L7R5zuL0JWZHga3ct9XtrUDTrWCMaMRGYIq91pY/d1SQuVEGMtzPYQCzfyOS
	vcyZOBvAk9c/CHwlROUnxw954sKtPMGSZQar7+581RlNofCmaeTr4yHBim4sqz+fhCf4+/
	iwMmLzjYdSKG1DD6AqttRb1Q52l7SOp1GnFMz6BElwB/c2hlN2EXbdHxv2g3XkbIKaJ1sb
	xfzyM1ZY6PBOB5LIiJJW2AUV6GpdQjUkWW7abNmFEhdquFLWnFu6+CYd5HUOjMi4QK4OFI
	LJhkteHZgnRoKkGg3636s4fVssuTg/7U/Tt6ClnXqPRZmqkCuv2Q1FPjUdIeWw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1793009590;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W4JDUkT65UJKUap/Q3QCQO+wt9GFW6OJmeRPM0Y//64=;
	b=PEbwae9SGq63+8A+pJEll85BEiUCOOXC2cD2cFdcb2Kv2zumeDW0KxCdtxjtUc2UI7XpRa
	CvMm07pet+3HKLCw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Daniel Zahka <daniel.zahka@gmail.com>,
	Alexander Duyck <alexanderduyck@fb.com>, kernel-team@meta.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Eric Dumazet <edumazet@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/4] eth: mpnic: count packets, bytes, and
 drops per ring
Message-ID: <20261026101308.P7PJXd9E@linutronix.de>
References: <20261012-mpnic-counters3-v2-0-8afba81c2d5a@gmail.com>
 <20261012-mpnic-counters3-v2-1-8afba81c2d5a@gmail.com>
 <20261016220930.i32JEcqe@linutronix.de>
 <DM8U47F4MNK3.2V54CCQ9YTNBY@gmail.com>
 <20261019215405.OCzrrKYw@linutronix.de>
 <20261019190543.419e70bc@kernel.org>
 <20261020212155.47v0ot4g@linutronix.de>
 <68046007-3737-4f85-bcd1-559daa5835d4@redhat.com>
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
In-Reply-To: <68046007-3737-4f85-bcd1-559daa5835d4@redhat.com>

On 2026-10-21 10:26:12 [+0200], Paolo Abeni wrote:
> > Right. If you think is all makes sense and is needed then why not. It
> > just looks odd.
> Sebastian, my understanding is that your doubts are mostly because you
> are unfamiliar with the current reference NIC stats scheme. That has
> evolved significantly in recent time.
> 
> I think the approach here is actually quite nice, I don't see blockers.

That might be it. As I just wrote in my recent reply, if you have a
driver recommendation what is currently recommended I would take a look.

> /P

Sebastian
