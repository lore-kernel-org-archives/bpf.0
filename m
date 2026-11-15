Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794769507;
	b=U+KqE+pzx2cGKnf8FfbzQG2Y1CsmeWgGCBbZUeNRl91wDy/kIMKdHReywJ7opOv9lsfR
	 HFrQP3oDo6LAK0Ezc9SQqqlnDIjefelVLLzp7WrmkJieaFc7N0x/lv0uAWIk5aAQ4aObX
	 Z4QVimUVtHJQ2TtJ2Dwv0RoBlbLrfbCgBMEU18rdqcBnri/n27Qrp3ppJAP69m7+ppXug
	 nT2yrbgmU6GKFd9eeu/PRK+N+4OGtczTFBeTfwNlAm2OvC9QG1MSQtAjqrf154W7/GLRq
	 hJKWlqEMwar3Ou0ZlQjiwyMSj/NILPzgIHferFMREtuQf3f95e0K+sPjqKrTrkGGjlw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794769507;
	h=Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=zXGiTJrEwntGV8op4MyBOAbCJ8yVIiAFp8O5PQ3b1D8=;
	b=dkaH9ipexsV9y4AtgvMmqmaSEgOyBjq4ipwMf6ywMHOQmlMU5dx2/RNDsZXLbBIC0pcy
	 X4bnhgn9/vtagO3NKXUW3l2WCbdpuaX71qNVIBA+PbZ9w7n8K1IaxUeRSAMldJultRCFS
	 xBEgCDJnWHGoo4kskEdIdR3x9m16zTubBt0EfZ+oPdQQiir2k7r6Kic6A2sWwQBNtP/V9
	 P+tewcd+xc2Do93JvbPe/4m6FlKk9OurTzSn8iwnqhwnPdzkkxguADqDwNZPnCrWjCr48
	 Xasx0poKdYDXJArnuagRwzHBFLre2yNMgAnL3AzuPFrusX5CWw/zDPbT3k2kZC9CpWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D32Rf1mu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69019606A31E;
	Sun, 15 Nov 2026 19:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D32Rf1mu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 715B81F000C4;
	Sun, 15 Nov 2026 19:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794769506;
	bh=zXGiTJrEwntGV8op4MyBOAbCJ8yVIiAFp8O5PQ3b1D8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=D32Rf1munNBT2NK3EMTmueeDc6pHo5E4eKLEPb0TwrTkEFVIJDbN9uxfIEQcyBKBm
	 1gqfJjeY5xf4KniLWlD8AJPKBDWHhgKyen/269r3W3paujA7r/qkuewnkWUahD+LW0
	 WLWsLk6+RcOaLY2b3YSMwWVfhZJC8DYJRZtiUaW+NdOoczaqwyQex8B5yINbmdbcv7
	 P2KY3hsXjTbKetgXMiXxOhaGktl81Iix98zKS0iWgJtglG69z21LDkVBNwHf96zdGz
	 7QHMeAt0W32rWWHOWCUa19SopATjMfIye9oTIltZHlVjz+IoxJrnrNyjdSdFGpVNYv
	 q+qtQkW0hKG7Q==
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
Subject: Re: [PATCH net-next v1 05/11] xsk: Install UMEM page pool providers
 in the core
In-Reply-To: <179443689029.2199510.2604170089798059237@kernel.org>
References: <20261110102039.1002605-6-bjorn@kernel.org>
 <179443689029.2199510.2604170089798059237@kernel.org>
Date: Sun, 15 Nov 2026 20:05:01 +0100
Message-ID: <875wxxj4pu.fsf@all.your.base.are.belong.to.us>
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

> Should xsk_pp_detach() be skipped, or the DMA unmap and UMEM release be
> deferred until pp->nr_pools drops to zero, when the close fails?

Deferred. A failed restart leaves the old queue running on the provider.
I have a net fix that keeps the provider on such a queue and retries the
removal, which also covers netif_rxq_cleanup_unlease(); I might add a
fix in v2 that unmaps and releases the UMEM only once the queue DMA has
stopped.

[...]

> Should the xsk_pp pin the buffer pool and the UMEM, and do the DMA
> unmap in xsk_pp_free(), so they outlive the last page pool? Or should
> xsk_bind() defer releasing the pool in this case?

This case can't happen. The page pools of a failed open never hold a
chunk. fbnic fills its rings only in ndo_queue_start(), which can't
fail, so a failed open frees empty pools, and they're destroyed at once.
pool->pp protects nothing there, so v2 drops that branch for a WARN.


Bj=C3=B6rn
