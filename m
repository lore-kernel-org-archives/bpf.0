Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794769347;
	b=SOAf901PQFhgFvru0jciwpwX6vGrO/rlx9phkTLvL3ETBoVVVY11Ty0edw4QC6mBCsj+
	 aaUGbqWUJ9GphsuPABxueriGMit+hFs11bJCU8ltPyEOTG28OZTwGLt12HDTyflGp38mK
	 Cvj7lZcT4k5SQzgJHLiZr/OVGIkvnj8TwRY1EJFULA6RFoznPsf6dPpXcvvm399jWggD6
	 Y1hGmhJaSgW/JCehrPUU2UFqolTPyQfV22XEp9iI6NncMOdgfnnC+9raHQhLvmGdSos/L
	 JMkBJC556pvSSujaRBvp9ArgqbxeGPaImqVj28ZnBXkiIv8XnhhN8rZR/io/gqKyIxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794769347;
	h=Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Q/hyJs7suUsQWM9rDMdP2P/X/6Nyzlv7hmi1/xYG81U=;
	b=0EzuiauqZgNhVYSgUwAmNaBAdTsS/4RpLDUiv9JbAsvBvrzvoOYUU20r4mNu9YHziv3c
	 Bk+9Z3j5HmITazqtXj43kvieeBrL8Bps2deSNpXOtuyxXVjdHcKE3omiKYzG1YSGB9NZA
	 IcPCmm8C8tgMwrVJn7fZHsgHRt9Iq2JxS76q7eUrIq8sB2Lqrp1g4DfMM9+/IXjXbjj8C
	 QlsDiSqmPI8B80k9dMCRGor6cVgFIcXY2kpEpDmqiCeUfh+LuVdav4aFJOj3j0MPkYdFI
	 aP8HC7ii4jm1T/BFrUiOMQb29EK/81AigMRZrO1jU0UrUbax5kBR9jbiy5q0ufnu0Xw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jCitSQMY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7187C606A323;
	Sun, 15 Nov 2026 19:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jCitSQMY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7757C1F000C4;
	Sun, 15 Nov 2026 19:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794769347;
	bh=Q/hyJs7suUsQWM9rDMdP2P/X/6Nyzlv7hmi1/xYG81U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=jCitSQMY9Tb/nXzJc/Rl5/ebOalpmPIig30aTEvEKnFOfNmqb45l+Mp0RQmNW9EKV
	 UzwdX+vPG8NlYqsLZQLjYm1Z9yKMJzUMxdiEwqb0ZL34wD72xTu7XNnpUMfc+zgZ4Y
	 3uP5YWR4Zx9PrNG96nCKjOCYVHXYgCIBiwLBodX3o+LRQ9P/F6JvoiNQYYJCf75Rn2
	 y/XPI2f7UB1/9HbGShF0QJhwwojOJ7nnflYYQeDikv8MlOvMFe+O+M59HDLeSEB79W
	 X48CkpEKcHQa0qIva1yk9RnPpl7BBoS/y7RSVHceJP4/xOam+VJME5HnvQtoAQ/BYh
	 wlf+4ym7G1U/A==
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
Subject: Re: [PATCH net-next v1 03/11] xdp: Copy buffers with restricted
 lifetime
In-Reply-To: <179443688445.2199510.2127044982916637399@kernel.org>
References: <20261110102039.1002605-4-bjorn@kernel.org>
 <179443688445.2199510.2127044982916637399@kernel.org>
Date: Sun, 15 Nov 2026 20:02:24 +0100
Message-ID: <87cxs5j4u7.fsf@all.your.base.are.belong.to.us>
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

> With XDP_FLAGS_EXT the head chunk no longer holds the shared info at
> all. Does anything still keep data_end below xdp_data_hard_end() for
> these buffers? If not, len alone can run past skb->end, since
> __skb_put() does not check.

Yes. fbnic's MAX_HDR leaves the same tailroom, and bpf_xdp_adjust_tail()
stops at xdp_data_hard_end().

> Should the destination size be derived from the copy instead of
> xdp->frame_sz? For example: headroom + LARGEST_ALIGN(len) +
> SKB_DATA_ALIGN(sizeof(struct skb_shared_info)). Or should this path
> copy exactly len bytes?

Yes, but that's pre-existing. XSK buffers without XDP_USE_SG have no
tailroom at all, so it's worse there. It's the head sizing from
Clement's thread [1]. A fix that sizes the head by its contents and
copies exact lengths goes to net, and v2 sits on top of it.

[...]

> Could xdp_build_skb_from_zc() compute the metadata size the way
> xdp_copy_buff_to_frame() does? That means treating unsupported
> metadata as zero length and copying from xdp->data.

Yes. Nothing hits it today, as fbnic marks the metadata valid, but this
patch makes it a generic path. Will fix.

pw-bot: cr


Bj=C3=B6rn

[1] https://lore.kernel.org/bpf/20260629072300.1664622-1-clecigne@google.co=
m/

