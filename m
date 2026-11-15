Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794770722;
	b=QM5h3DPDn9T1nJeYYCm5WDgNCIUGk28EFvWLXvCaG6Dm9aUjc5fQeTQWNF5mCyra+cnc
	 kuHvQj5q6eKBVJtA6UUQ0WFxszrVcxxFfo8+BJ4SkNtsP4+OSnWQUhxywLMi6p09HKXH8
	 yXxOCiIN161R2IRUOGegyBiWHd16VkNZln+/T5lvzXIDpmSB9DPe7IoBxiTk5to64GXXW
	 /FbGtg9tSkMxposeTGu3qFJ1Lr9nyB44X82QWl2ktLMreMbat8bmhhiAaT7t1ACByw4FH
	 XL5XZHDuz76XFHHjHRjpMe08Chrj+u9IvWnE+vhlKaUQZIPpBmn4lVtvFY8zCeGWcrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794770722;
	h=Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=IpXm5/i3llW/ahehebtunlrixeYN2RFPtOc0pKumyvA=;
	b=4acKZtMfNk6WKK+GYIz22Ud08Rdwt7E4NKF0G8xrbutnJ/V9mtGWIaldLtXIAQHK4+Ug
	 aVzf8XNbifEwDmATtmdVCI77E4lZiErdEyDx6I3J+2abpiLLMdcaKeJg78wftn2ZKsDkP
	 axZBiSPv4gq3tDaun4zuzTvSx2Qr1iU7TAaZAYrawgXpm0ENML81z8gWkEYRw8q1Sf3ko
	 Id4edH5yFsB94AAeQ9Pv8/ioWW20vOiLKUlrQYJtUFvGzM6AAuWVbB6u4M3cKfNnpYfZS
	 Toi24v7b/c1JwUqNC8vvhL6//B/39JA3zlh7eiCfbE0RtUb83xE/9lNXy+JrpD2ji3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Sme0VUGW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7DA606A323;
	Sun, 15 Nov 2026 19:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Sme0VUGW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90AB81F000C4;
	Sun, 15 Nov 2026 19:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794770722;
	bh=IpXm5/i3llW/ahehebtunlrixeYN2RFPtOc0pKumyvA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=Sme0VUGWqpVacf3Prr1Xor31wdDfhTrgMgPHk3oBLq+bwlcO41XPGQ2YOWcBMF5XE
	 9WBupiekLYxYFtxZ1PBDXd2WoRpp2VsSYBeIH/0CYa11j7sS0Dj0DmNj5xfR7/QF2q
	 CdL7ufmeJkmsAV1LfCN3c2HBeQcew5LOJ7KPCFCjcJBvM9ErQxp5a2bI5AK2XA6e6j
	 1UlUITaQisTV/557tGf7GiKV00G/cW8BiqD+ru0+TclKUa6boku5XxiXWjV69L+T1+
	 1jDbKCujHNpDicsQntuJqwoPtApqRj66kzgFNSvYkPDlms43lWwOgX0yOtXSjr1BM1
	 H53dXuRIEbWZw==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: netdev-bot+sashiko@kernel.org
Cc: magnus.karlsson@intel.com, maciej.fijalkowski@intel.com,
 sdf@fomichev.me, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
 skhan@linuxfoundation.org, rdunlap@infradead.org, alexanderduyck@fb.com,
 kernel-team@meta.com, andrew+netdev@lunn.ch, hawk@kernel.org,
 ilias.apalodimas@linaro.org, ast@kernel.org, daniel@iogearbox.net,
 john.fastabend@gmail.com, asml.silence@gmail.com, axboe@kernel.dk,
 andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, emil@etsalapatis.com, ihor.solodrai@linux.dev,
 netdev@vger.kernel.org, bpf@vger.kernel.org, io-uring@vger.kernel.org,
 almasrymina@google.com, mike.marciniszyn@gmail.com, bestswngs@gmail.com,
 razor@blackwall.org, dw@davidwei.uk, aleksander.lobakin@intel.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, stuclar@meta.com
Subject: Re: [PATCH net-next v1 11/11] eth: fbnic: Support AF_XDP page pool
 zero copy
In-Reply-To: <179443690174.2199510.10806656670743256191@kernel.org>
References: <20261110102039.1002605-12-bjorn@kernel.org>
 <179443690174.2199510.10806656670743256191@kernel.org>
Date: Sun, 15 Nov 2026 20:25:19 +0100
Message-ID: <878q2thp7k.fsf@all.your.base.are.belong.to.us>
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
Content-Transfer-Encoding: quoted-printable

netdev-bot+sashiko@kernel.org writes:

[...]

> Won't an idle xsk queue then report a fast-growing alloc_fail count that
> has nothing to do with memory pressure? With need_wakeup, each wakeup
> that finds the FILL ring empty would also be counted.

mlx5 counts it the same way, ice doesn't. It's already in
fill_ring_empty_descs, so v2 doesn't count it on rings the provider
feeds.

[...]

> The xsk_rxq_pool() comment says "The pool stays valid while the queue
> that the caller allocates runs", but that does not seem to hold on this
> failure path. Part of the cause is the core error handling. Still, the
> fbnic TX code added here is what keeps using the raw pointer.

Same root cause as the failed removal in 05, and the same fix. The
provider then keeps the pool, its rings and the UMEM until the queue DMA
has stopped, so the comment holds. The socket is off the pool's TX list
by then, so TX finds nothing, and completions go to a live ring.


Bj=C3=B6rn
