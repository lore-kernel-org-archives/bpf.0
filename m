Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794770243;
	b=JPQ3p0F4pfHRJXHyge2ZhsjM+2fJNNXvohqq5saBeoGvU9iRpKbXtFgbWLhHlA3SxZH7
	 Hi5ygeuaBBbFb5JFw3tdiaD4q3WnZ7pgV/SAPJVJMOHxMc8ypWSgavo11kdzr7Drj8XVL
	 pPjYq3wnrOpDbn3yNykNmno+pRUJ9phYkzClZs5E3zWmNwEcV5Lc59y9ysnjKcyWvSQMY
	 JQkKeewKH8s4uQZSmjHDN8q/I306/VC/GX4aqKVegfjMCv5zlX0zuI9l6WejuND7ZzxDI
	 J9rK+59nrRWsIKXvib/a1oXdnDofTSqtjLDRrCSbAI5I27NwwSXxL7O5TpNC+8QLHNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794770243;
	h=Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=syiaQMJ04df2CAPDd9TxgmwagOaCksS43FztMaZSoj4=;
	b=YI9DW0o84/btgXhcFZC57hmxJfpLJ3uUOz0d10lR3SoNfKVikJylVoTxgADjGgBFwtat
	 v5jr5alAwc9YhCs25HAwJUWQdQQJ6ud+Uh6p8LaiEXjRONHo+WKOySObDUp9Om7akayAS
	 q7jZksPe3KAJaUNSqu3Kl38PiFFVJrMYojpaPduqXh++/c/AJTwFphhSgw07Bafsls9tF
	 xNOJxnogng7KVh5pMIfTxJLbgPcqpXKphda0RYPkqHQB1oekLTvvoltIO2i7/c36qPi0P
	 +JBhi19AhhX5YbKS5AGsmM+YPUsG7v+if3ArWRZJ1NjQbBcC0U1LNxmi7RyI9c7nh3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NQ2RTQiU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203CB606A323;
	Sun, 15 Nov 2026 19:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NQ2RTQiU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBBF11F000C4;
	Sun, 15 Nov 2026 19:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794770242;
	bh=syiaQMJ04df2CAPDd9TxgmwagOaCksS43FztMaZSoj4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=NQ2RTQiUkooIEv2aFmxn0mSejwHAVan7OoLwkXp7+EqL2JE0uyg24oNE/w8/BPWGU
	 hOkEUqIcDLeoy6OECB08uAAAqUGy6jJbvGmrZQE1k0fPw5aiUyeVkPyTKP6ZLr8hhJ
	 znImMXQFXrHoaun4DzvCTiTsjpny2ultaPf0sLdeCuE6xqS0qb+FGZLDa7+wyuAKiv
	 NuTb3IfidJO8ZktYh+I8f6+utWgwo5Mv+YUTMcv9JSMRBm9cDgointBeyQ2h166T9t
	 a1q+nUh0ZUqUIJQX914bGraPwGIETtkpad3nVgRfq6u6rtlguO+PxFoX7biiqEnA0U
	 BPqgK4+7YLhXA==
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
Subject: Re: [PATCH net-next v1 06/11] page_pool: Coordinate refill with
 memory providers
In-Reply-To: <179443689325.2199510.6016244708978672874@kernel.org>
References: <20261110102039.1002605-7-bjorn@kernel.org>
 <179443689325.2199510.6016244708978672874@kernel.org>
Date: Sun, 15 Nov 2026 20:17:19 +0100
Message-ID: <87ld6thpkw.fsf@all.your.base.are.belong.to.us>
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

> Should netif_mp_napi_del() also clear rxq->napi when it matches, or
> should netif_mp_update_napi() only publish a NAPI that is still
> listed? If drivers are expected to clear the association themselves,
> could netmem.rst item 8 say so?

The first. v2 drops mp_napi, so wakeups use rxq->napi itself, under RCU,
and the core clears it when the NAPI is deleted.

[...]

> Should the documented contract require that, or should the core handle
> the disabled-NAPI case itself?

The contract. fbnic polls the vector right after napi_enable()
(FBNIC_INTR_SET), so the queue refills once, from the reuse stack or
FILL, and refill_done marks it starved again if both are empty. A wakeup
lost on a stopped queue doesn't matter then. v2 documents that a driver
polls the queue once after enabling its NAPI.

> Could uses_need_wakeup be cached in struct xsk_pp when it is created, or
> read only after pp->fq is confirmed under pp->lock?

Same root cause as the failed removal in 05, and the same fix. The pool
then stays until the queue DMA has stopped, and no refill runs after
that.

> Should the error path arm from the configuration that is running
> again, or should __netif_mp_open_rxq() and __netif_mp_close_rxq() call
> netif_mp_update_napi() once they have settled rxq->mp_params?

Neither is needed -- with mp_napi and mp_armed gone in v2, there is no
wakeup target to arm from the wrong configuration.


Bj=C3=B6rn
