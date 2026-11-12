Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794513458;
	b=1anX/uCg2hwk/P/8eMTdM61jHBrAPfemEo697vniGIg4i9436W2+FzYM5+CARlRVjRpL
	 N3fkzXNkZLskJjsSCmx71PwEAwG+IDOTGfxRvc3ycICXcIZJJv63CNOPOHqJfm+GzaWYC
	 U8DrAT4ZgDM4aUhidB8/zrUQ5InK7sIEQCMn9yKSFveMpvEjt1oBaMCTMh61Cirqkm40G
	 6VCJwWmKWNjhTSFAZwtKUM6N5OIvUE7WbT4v8WUaM2db37ecuQBNirV0kHtaJsNnLiYM3
	 H+tthZzGXzTmsUW7oW6lD9eIywuYRq7ZURvzWLgvKOneNzzzOS5ksx2uhK/+SnjiRdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794513458;
	h=Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=7guJMRRaIyBXSu5q1TNtm5fdzWXrkWkE2iKaLV14h3U=;
	b=kvJJnBIpXnEqbemn+vE3lTmWItKPdXdrUOdApZUt/qlOGSO3cRJ6ECavnAfNrmhbjNSA
	 74VGnb/jq3zhXW7f3mRbSiX9pZSoJUFqdB+RywRvkwTt4MZjis1pBCTk3TjM/t3fCVVZ5
	 8MH1ZInPpc2nzSmI9QjmQKmu1jybeROeS+1gxtVeuMWSo6xwdskIIs7IUrxOQj8Q16upu
	 j8upr/x2L8YhAOU1e8DhbTeqncDi6e2RPjP9vmODWLtjmKoylbjDpXcH3oNr7C/322LSl
	 W8lbYEdPNQQqy46n+l77h6hD/R8tevzwIM6/k3WwCXVe0Xr71MDMMxUDW1+FClL+lSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WwR0zLi9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCBFE606A88F;
	Thu, 12 Nov 2026 19:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WwR0zLi9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDE151F000C5;
	Thu, 12 Nov 2026 19:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794513458;
	bh=7guJMRRaIyBXSu5q1TNtm5fdzWXrkWkE2iKaLV14h3U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=WwR0zLi94YNDct3dcB3nW3opR+n+eZhSHuebehNpSFyoYQJYcRB/uTok6f0VIEsn8
	 VhNnmCYLnslIOCeD3XHMyPbA/szoNfexl/h4UkRdQdnkKQS+t4viFQd0RF5sIrS+7w
	 94NnR1EI7kWlcUYSg5DeygJD9WLbjg6lApMtl06hUAl/P2fwWHzg6oLoFiO4b46RcW
	 EtTonZU6mxNjqp2zNmo0stc9wJcpwtqAxzNRKlZulu64/zsMZDedhlHfcdt4xWq8eU
	 vUh5tJKBKk+fh7k+Z924uIN9JJy6j+hnV411pXsULtaOC6Ei5AfRW5f5NXXqASN3YD
	 y+XV789RFCh3g==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: Magnus Karlsson <magnus.karlsson@intel.com>, Stanislav Fomichev
 <sdf@fomichev.me>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap
 <rdunlap@infradead.org>, Alexander Duyck <alexanderduyck@fb.com>,
 kernel-team@meta.com, Andrew Lunn <andrew+netdev@lunn.ch>, Jesper Dangaard
 Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, Pavel
 Begunkov <asml.silence@gmail.com>, Jens Axboe <axboe@kernel.dk>, Andrii
 Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Kumar
 Kartikeya
 Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song
 Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa
 <jolsa@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai
 <ihor.solodrai@linux.dev>, netdev@vger.kernel.org, bpf@vger.kernel.org,
 io-uring@vger.kernel.org, Mina Almasry <almasrymina@google.com>, "Mike
 Marciniszyn (Meta)" <mike.marciniszyn@gmail.com>, Weiming Shi
 <bestswngs@gmail.com>, Nikolay Aleksandrov <razor@blackwall.org>, David
 Wei <dw@davidwei.uk>, Alexander Lobakin <aleksander.lobakin@intel.com>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Stuart Clark
 <stuclar@meta.com>
Subject: Re: [PATCH net-next v1 07/11] xsk: Deliver provider chunks without
 copying
In-Reply-To: <avWua/xvHrUa5wUI@boxer>
References: <20261110102039.1002605-1-bjorn@kernel.org>
 <20261110102039.1002605-8-bjorn@kernel.org> <avWua/xvHrUa5wUI@boxer>
Date: Thu, 12 Nov 2026 20:57:34 +0100
Message-ID: <875wy1rff5.fsf@all.your.base.are.belong.to.us>
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

Maciej Fijalkowski <maciej.fijalkowski@intel.com> writes:

> On Tue, Nov 10, 2026 at 11:20:28AM +0100, Bj=C3=B6rn T=C3=B6pel wrote:
>> A provider socket still receives through the copy path, which takes
>> FILL entries without the provider's ownership checks: a chunk that a
>> page pool holds could be handed out twice. No driver opts in yet.
>>=20
>> Put packets whose buffers all belong to the socket's provider on the
>> RX ring as they are, and copy others into chunks the provider claims.
>> Only the queue NAPI may produce to such a socket, so generic XDP and
>> CPUMAP redirects to it are dropped.
>>=20
>> A device may place payload at chunk offset 0, as fbnic does, so only
>> the first buffer of a packet keeps the UMEM headroom. Such buffers may
>> be sent back as they are, so only descriptors with XDP_TX_METADATA
>> need room for TX metadata in front.
>>=20
>> Signed-off-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>
>> ---
>>  Documentation/networking/af_xdp.rst          |   6 +-
>>  Documentation/networking/xsk-tx-metadata.rst |   3 +-
>>  include/net/page_pool/memory_provider.h      |   2 +
>>  net/core/page_pool.c                         |  34 +++-
>>  net/xdp/xsk.c                                |  82 ++++++++-
>>  net/xdp/xsk.h                                |   5 +
>>  net/xdp/xsk_pp.c                             | 165 +++++++++++++++++++
>>  net/xdp/xsk_queue.h                          |  18 +-
>>  8 files changed, 304 insertions(+), 11 deletions(-)
>>=20
>
> (...)
>
>> +
>>  static int xsk_pp_nl_fill(void *mp_priv, struct sk_buff *rsp,
>>  			  struct netdev_rx_queue *rxq)
>>  {
>> diff --git a/net/xdp/xsk_queue.h b/net/xdp/xsk_queue.h
>> index 1bc42c8902f4..b9464b917a88 100644
>> --- a/net/xdp/xsk_queue.h
>> +++ b/net/xdp/xsk_queue.h
>> @@ -156,17 +156,24 @@ static inline bool xp_unused_options_set(u32 optio=
ns)
>>  	return options & ~(XDP_PKT_CONTD | XDP_TX_METADATA);
>>  }
>>=20=20
>> +static inline u32 xp_desc_meta_len(struct xsk_buff_pool *pool,
>> +				   struct xdp_desc *desc)
>> +{
>> +	return desc->options & XDP_TX_METADATA ? pool->tx_metadata_len : 0;
>
> How is it related to this patch? I know I trimmed, but I didn't see any
> references above to tx_metadata_len, only some documentation bump.

Provider frags start at chunk offset 0, and an application may send them
back as they are. TX validation wants tx_metadata_len in front of every
descriptor once the UMEM has it, so such a descriptor fails, though only
XDP_TX_METADATA descriptors use that room. Driver ZC never puts RX data
below offset 256, so it never came up. It stands on its own; I'll make
it a separate patch.

> Besides, the amount of branches introduced to existing hot path is
> worrying. On next revision, could you provide numbers from xdpsock before
> and after this set run on existing zc driver?

(FWIW, I've left a all my performance patches out, to keep the size of
set down.)

Will do, but the only one I got is mlx5. Would be awesome if you or
Magnus could take it for a spin on Intel NICs.

Single-buffer RX on driver ZC gets no new per-packet branch: xsk_rcv()
leaves through xsk_rcv_zc() first. The rest is one test per flush, one
XDP_TX_METADATA test per TX descriptor, and a flag test in the
multi-buffer and XDP_PASS/redirect helpers. v2 also moves pool->pp next
to fq, which the flush reads anyway, and drops the frag walk in
xdp_buff_needs_copy(), as agreed with Stan.

Anything specific, or just in general?


Bj=C3=B6rn
