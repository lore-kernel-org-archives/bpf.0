Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BAD3418353;
	Mon, 12 Oct 2026 14:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791814378; cv=none; b=jMXPnpBZ83XQ3PbVAPm1z42vwuUGsTnG2JZit+RYNuoTut4dPW31S3LsqShC71/QslmQhi/tXytlvEVBHpgulAfBAhUn+4HyHmz7HhCqX2DbjwuacwPUprVGn2IQmAt6e9tfPxN+XGIpoOQ1wKP098gggW863hRHe1xFLT9eSBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791814378; c=relaxed/simple;
	bh=2RJ4HPmBZNcpkWoZbXPtJ7mrUpVAX499W0ndI01jdT8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GIaMKedaoSWGR+VWLpZMaAnW/jPpwf2NBh0/iZJcKi02WFNLvHxmAxxn7sAzIZr/XDEOiTG17fnutaHvw+GjKcN8WBKgx7U5uFfbqNqN6D7dIEkrcNjk8pwTsrmhLlNOqK+BROUp1cIA5m96Xz0LoaifH4ZBf4dwt2jwd6GP+kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Raj/wj1d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Raj/wj1d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF93E1F0089F;
	Mon, 12 Oct 2026 14:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791814376;
	bh=QH4R+MXlZktJnQ9gXtfrNIn8C2oUJYsTrp0hNj3REYQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=Raj/wj1dyfGFTt33LIR1X3CPI64HfWpaHxFyDhHgvoQoGrHVRVaXOUUG1AfnFhyth
	 VGD57dZkUumcCgZXB1mmDyHk2vzxkB01XDCC7vGqOSp5kvqYPPbmTpYh0wztpdFDm6
	 IoH95i0PaLqyN2lx7c++hq94g1+dcI5IVT7+LLZT6kINPuXBqReUfgJA9EHVzn4dx2
	 QW0+KyyMnn5o+bMOWpvZ8X1xH12SbPjPDYPDYBJreMETATwU2tiwD4qWdR6spnZzlm
	 ndYwfQCTz3M9K/NOF0ABv5empEWCPdgcj76+opmy+yojOWJVro+ltkN8RjvxLacxs+
	 8F7AbWDE+yUTw==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: Magnus Karlsson <magnus.karlsson@intel.com>, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>, Stanislav Fomichev <sdf@fomichev.me>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
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
 Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, Emil Tsalapatis
 <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>,
 netdev@vger.kernel.org, bpf@vger.kernel.org, io-uring@vger.kernel.org,
 "Mike Marciniszyn (Meta)" <mike.marciniszyn@gmail.com>, Weiming Shi
 <bestswngs@gmail.com>, Nikolay Aleksandrov <razor@blackwall.org>, David
 Wei <dw@davidwei.uk>, Alexander Lobakin <aleksander.lobakin@intel.com>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Mina Almasry
 <almasrymina@google.com>
Subject: Re: [RFC net-next 06/15] xdp: Track non-page netmem in receive buffers
In-Reply-To: <asPXa7k-_drxXiI0@devvm7509.cco0.facebook.com>
References: <20261002190018.696925-1-bjorn@kernel.org>
 <20261002190018.696925-7-bjorn@kernel.org>
 <asPXa7k-_drxXiI0@devvm7509.cco0.facebook.com>
Date: Mon, 12 Oct 2026 16:12:53 +0200
Message-ID: <8733ubc8ii.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Stanislav Fomichev <sdf.kernel@gmail.com> writes:

> On 10/02, Bj=C3=B6rn T=C3=B6pel wrote:
>> A page-pool memory provider can give net_iov buffers, and
>> virt_to_page() does not work for them. An xdp_buff holds only the
>> data pointer, so code that returns or converts a buffer cannot find
>> its net_iov.
>>=20
>> Add NET_IOV_XSK, the net_iov type for AF_XDP. Add the internal flag
>> XDP_FLAGS_HAS_NETMEM. When it is set, the xdp_buff holds a netmem
>> reference in the union with the devmap TX queue, which only devmap
>> egress uses. The flag is cleared when flags are copied to an skb or
>> an xdp_frame. xdp_convert_buff_to_frame() sends such a buffer to the
>> zero-copy copy path.
>>=20
>> A fragment from a readable net_iov area no longer marks the buffer's
>> fragments as unreadable. The skb layer still treats every net_iov as
>> unreadable, so such a buffer must be copied before it becomes an
>> skb. Later patches in this series do that.
>>=20
>> skb_shared_info holds kernel pointers, so it cannot be in UMEM,
>> which userspace can write. A netmem xdp_buff points to a
>> skb_shared_info that the RX queue keeps in kernel memory instead.
>> xdp_init_buff_from_netmem() sets this up. Page-backed buffers still
>> use their tailroom.
>>=20
>> On 64-bit, struct xdp_buff grows from 56 to 64 bytes. struct
>> xdp_buff_xsk stays at 128 bytes on x86-64. Where the largest
>> alignment is 8 bytes, as on s390, it grows from 120 to 128 bytes, so
>> a pool needs 8 more bytes per UMEM chunk. Only helpers that need the
>> netmem or the fragment info test the new flag. Page-backed receive
>> and return paths do not.
>>=20
>> Signed-off-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>
>> ---
>>  include/net/netmem.h |  1 +
>>  include/net/xdp.h    | 56 ++++++++++++++++++++++++++++++++++++++++----
>>  2 files changed, 52 insertions(+), 5 deletions(-)
>>=20
>> diff --git a/include/net/netmem.h b/include/net/netmem.h
>> index e6dff0b01581..76e4fe878863 100644
>> --- a/include/net/netmem.h
>> +++ b/include/net/netmem.h
>> @@ -68,6 +68,7 @@ DECLARE_STATIC_KEY_FALSE(page_pool_mem_providers);
>>  enum net_iov_type {
>>  	NET_IOV_DMABUF,
>>  	NET_IOV_IOURING,
>> +	NET_IOV_XSK,
>>  };
>>=20=20
>>  /* A memory descriptor representing abstract networking I/O vectors,
>> diff --git a/include/net/xdp.h b/include/net/xdp.h
>> index 07231adfb5f8..80931490ca3a 100644
>> --- a/include/net/xdp.h
>> +++ b/include/net/xdp.h
>> @@ -11,6 +11,7 @@
>>  #include <linux/netdevice.h>
>>  #include <linux/skbuff.h> /* skb_shared_info */
>>=20=20
>> +#include <net/netmem.h>
>>  #include <net/page_pool/types.h>
>>=20=20
>>  /**
>> @@ -81,6 +82,8 @@ enum xdp_buff_flags {
>>  	 * XDP program is not attached.
>>  	 */
>>  	XDP_FLAGS_FRAGS_UNREADABLE	=3D BIT(2),
>> +	/* The txq/netmem union contains a receive netmem reference. */
>> +	XDP_FLAGS_HAS_NETMEM		=3D BIT(3),
>>  };
>>=20=20
>>  struct xdp_buff {
>> @@ -89,7 +92,12 @@ struct xdp_buff {
>>  	void *data_meta;
>>  	void *data_hard_start;
>>  	struct xdp_rxq_info *rxq;
>> -	struct xdp_txq_info *txq;
>> +	union {
>> +		/* Valid for DEVMAP egress programs. */
>> +		struct xdp_txq_info *txq;
>> +		/* Valid for receive buffers backed by non-page netmem. */
>> +		netmem_ref netmem;
>> +	};
>>=20=20
>>  	union {
>>  		struct {
>> @@ -104,6 +112,8 @@ struct xdp_buff {
>>  		u64 frame_sz_flags_init;
>>  #endif
>>  	};
>> +	/* Kernel-owned fragment metadata for non-page netmem. */
>> +	struct skb_shared_info *sinfo;
>>  };
>>=20=20
>>  static __always_inline void xdp_reinit_buff(struct xdp_buff *xdp)
>> @@ -138,7 +148,7 @@ static __always_inline void xdp_buff_set_frag_unread=
able(struct xdp_buff *xdp)
>>=20=20
>>  static __always_inline u32 xdp_buff_get_skb_flags(const struct xdp_buff=
 *xdp)
>>  {
>> -	return xdp->flags;
>> +	return xdp->flags & ~XDP_FLAGS_HAS_NETMEM;
>>  }
>>=20=20
>>  static __always_inline void xdp_buff_clear_frag_pfmemalloc(struct xdp_b=
uff *xdp)
>> @@ -150,6 +160,10 @@ static __always_inline void
>>  xdp_init_buff(struct xdp_buff *xdp, u32 frame_sz, struct xdp_rxq_info *=
rxq)
>>  {
>>  	xdp->rxq =3D rxq;
>> +	/* Do not initialize the txq/netmem union here. DEVMAP generic XDP
>> +	 * sets txq before this helper is called; receive drivers set netmem
>> +	 * explicitly.
>> +	 */
>>=20=20
>>  #ifdef __LITTLE_ENDIAN
>>  	/*
>> @@ -176,6 +190,33 @@ xdp_prepare_buff(struct xdp_buff *xdp, unsigned cha=
r *hard_start,
>>  	xdp->data_meta =3D meta_valid ? data : data + 1;
>>  }
>>=20=20
>> +static __always_inline bool xdp_buff_has_netmem(const struct xdp_buff *=
xdp)
>> +{
>> +	return !!(xdp->flags & XDP_FLAGS_HAS_NETMEM);
>> +}
>> +
>
> [..]
>
>> +static __always_inline netmem_ref
>> +xdp_buff_get_netmem(const struct xdp_buff *xdp)
>> +{
>> +	if (xdp_buff_has_netmem(xdp))
>> +		return xdp->netmem;
>> +
>> +	return virt_to_netmem(xdp->data);
>> +}
>
> You keep adding methods that are not used in the patch where they are add=
ed.
> I keep getting confused :-p
>
> For virt_to_netmem, maybe a meta question: does xsk pool need a treatment
> similar to the socket path? Where we did s/page/netmem_ref/ ? Then might
> be less reasons to special case?

Fair point! I'll move the helpers with their users and see what
netmem_ref can unify. UMEM still needs the saved descriptor for
returning buffers and kernel-owned fragment info...
