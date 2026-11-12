Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794494916;
	b=NwUGcyvHE608WnUdcfXznVK8LW1Y6+RoiLEB0t0lTgr5idD8F8UhTXW3DSBuVFbfMgZE
	 T5mOFxMcOZV9Qs2m6KTdtVLZCAM7KK7ZQLdiDcfS+wPHo8OHRFoDqFeYQoLb5gmdmT+eR
	 mXBnUjtf320K52xiIQYPqMp6w6pE8EjZrXLRGTX31uWsbjydlHVbxBEF9xG+4qgrZ3g11
	 eDF1Y5zYQDyg1QMTEgLYE+qcQzLeC1apsAQfZizGO+YXbWEZha7YGQtJKz6QEYhzhIu9o
	 1Ciftqf89RIoUvCYL/NvhPRwY9tE9jb2hqvAbzxU5j0ktFtuEvl88B3CsQw9+6/vcZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794494916;
	h=Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=wfehWnNFGB+xL9gcLLhpg8yhAIC+VsknyjJOhfaCTyo=;
	b=eTVjyWfo2olZPyuGv9FtlKe+GYgFwY+ezGbMx1eir5wGmNZ5sYeFDMKsCzA+1oa6llLc
	 Q0Xyn1c2s7BC1uGoNROl7AcDxIibusOqLmGjUYl2f07W0QF33oYBADTBeJ6MWaiCzCn/3
	 uGUMhm9th7ouz07L0JdyCZ4dkFcD1dgCiSPwZcJ59hbWj4yoWdUjDawgv+BTgBc4bQxMQ
	 VRKgs68BalwCp6xgZVUWq4Fq1hycp/o1Q4p/g7rUwgNfywpkB38k3waPYyw23JNT7GAD3
	 ceHxbbLMfklrvh/Ar87NHMNEA9KSS7AuCDX04gjypDhl9QkMxL7r2jGlWVQHRPiFfFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fI8Y1u3K;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD6D606A321;
	Thu, 12 Nov 2026 14:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fI8Y1u3K
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D3B91F00A05;
	Thu, 12 Nov 2026 14:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794494916;
	bh=wfehWnNFGB+xL9gcLLhpg8yhAIC+VsknyjJOhfaCTyo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=fI8Y1u3K5yl76FWz8LlCknQGEWMX/os+rKNjrZylCsvcws7V8eCqRlokbKNLNWiJg
	 KPofhVaHkW4HoAKwToms/m0nfPop8WnGC4cZGffBm7/uahlFPY0joGOO+g+MuKVZuB
	 tU8G9ypgnRqYc2Kq/Hiu10RIIOoN4dzvILbBEfm1ys3+8clAhjJ2bMv1cYYjDOj+m/
	 15hwgPCrpoe2kEXq4Zcj5jL+sw7jG7G1SFRq8U4nG0wBhe8Z/udngO3AZUnlgjCfjk
	 09E76P8tnEw0/UrXQbLjDDKauCINe6n6KQrbjfC/S+linGykoNzRgTJWPe3J3KJXV3
	 5Aaooc7zGfcBg==
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
Subject: Re: [PATCH net-next v1 05/11] xsk: Install UMEM page pool providers
 in the core
In-Reply-To: <avWo1bY5MSN1XvHL@boxer>
References: <20261110102039.1002605-1-bjorn@kernel.org>
 <20261110102039.1002605-6-bjorn@kernel.org> <avWo1bY5MSN1XvHL@boxer>
Date: Thu, 12 Nov 2026 15:48:31 +0100
Message-ID: <874idmrtq8.fsf@all.your.base.are.belong.to.us>
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

> On Tue, Nov 10, 2026 at 11:20:26AM +0100, Bj=C3=B6rn T=C3=B6pel wrote:
>> A page_pool driver should not need its own AF_XDP setup. When it sets
>> netdev_queue_mgmt_ops.xsk_page_pool, a zero-copy bind installs the
>> UMEM provider through the queue API, as devmem and io_uring do. The
>> driver only judges the chunk size, headroom and multi-buffer mode
>> against its MTU and XDP program, in XDP_VALIDATE_XSK_POOL; MTU and
>> program changes of a bound device get the same check. The UMEM
>> headroom belongs to the socket, so the queue gets it as rx_headroom,
>> next to rx_page_size.
>>=20
>> After a queue restart, the core checks that the new page pools took
>> the provider. A readable provider must back the header pool, where an
>> unsplit packet lands, so pools declare the buffers they supply in
>> rx_roles. The old queue's pools carry the same provider during the
>> check, so a per-queue generation, mp_gen, tells the new ones apart.
>>=20
>> Generic XDP runs outside the queue NAPI, so it cannot feed the socket.
>>=20
>> The provider needs no xdp_buff_xsk per chunk. The buffer pool
>> allocates them only for copy mode and driver zero copy, which saves
>> 128 bytes per chunk.
>>=20
>> Signed-off-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>
>> ---
>>  include/linux/netdevice.h     |   8 ++
>>  include/net/netdev_queues.h   |  12 ++
>>  include/net/netdev_rx_queue.h |   2 +
>>  include/net/page_pool/types.h |  12 ++
>>  include/net/xdp_sock.h        |   4 +
>>  include/net/xdp_sock_drv.h    |  45 +++++++
>>  include/net/xsk_buff_pool.h   |   3 +
>>  net/core/dev.c                |  16 +++
>>  net/core/netdev_config.c      |   2 +
>>  net/core/netdev_rx_queue.c    |   9 +-
>>  net/core/page_pool.c          |   6 +-
>>  net/core/page_pool_user.c     |  25 ++--
>>  net/xdp/xsk.h                 |   7 +-
>>  net/xdp/xsk_buff_pool.c       |  69 ++++++++---
>>  net/xdp/xsk_pp.c              | 221 ++++++++++++++++++++++++++++++++++
>>  15 files changed, 410 insertions(+), 31 deletions(-)
>>=20
>
> (...)
>
>> +
>> +/**
>> + * xsk_validate_dev - check AF_XDP page pool queues against a new setti=
ng
>> + * @dev: device of the queues
>> + * @mtu: MTU to check
>> + * @prog: XDP program to check, or NULL for the current one
>> + * @mode: XDP mode of @prog
>> + * @extack: netlink extended ack
>> + *
>> + * Context: holds the instance lock of @dev, or RTNL for a device witho=
ut it.
>> + * Return: 0 if the driver accepts all queues of @dev that have an AF_X=
DP
>> + * memory provider, or its error.
>> + */
>> +int xsk_validate_dev(struct net_device *dev, unsigned int mtu,
>> +		     struct bpf_prog *prog, enum bpf_xdp_mode mode,
>> +		     struct netlink_ext_ack *extack)
>> +{
>> +	struct netdev_rx_queue *rxq;
>> +	struct xsk_pp *pp;
>> +	unsigned int i;
>> +	int err;
>> +
>> +	netdev_assert_locked_ops_compat(dev);
>> +
>> +	for (i =3D 0; i < dev->real_num_rx_queues; i++) {
>> +		rxq =3D __netif_get_rx_queue(dev, i);
>> +		if (rxq->mp_params.mp_ops !=3D &xsk_pp_ops)
>> +			continue;
>> +
>> +		/* Generic XDP runs outside the queue NAPI */
>> +		if (mode =3D=3D XDP_MODE_SKB) {
>> +			NL_SET_ERR_MSG(extack,
>> +				       "generic XDP cannot feed an AF_XDP page pool socket");
>> +			return -EBUSY;
>> +		}
>> +
>> +		pp =3D rxq->mp_params.mp_priv;
>> +		err =3D xsk_pp_validate(dev, pp->pool, mtu, prog, extack);
>> +		if (err)
>> +			return err;
>> +	}
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(xsk_validate_dev);
>> +
>> +/**
>> + * xsk_rxq_pool - get the AF_XDP pool that provides memory to an RX que=
ue
>> + * @dev: device of the queue
>> + * @queue_id: RX queue
>> + *
>> + * The pool stays valid while the queue that the caller allocates runs.
>> + *
>> + * Context: holds the instance lock of @dev.
>> + * Return: the buffer pool, or NULL.
>> + */
>> +struct xsk_buff_pool *xsk_rxq_pool(struct net_device *dev, u16 queue_id)
>> +{
>> +	struct netdev_rx_queue *rxq;
>> +	struct xsk_pp *pp;
>> +
>> +	netdev_assert_locked(dev);
>> +
>> +	if (queue_id >=3D dev->real_num_rx_queues)
>> +		return NULL;
>> +
>> +	rxq =3D __netif_get_rx_queue(dev, queue_id);
>> +	if (rxq->mp_params.mp_ops !=3D &xsk_pp_ops)
>> +		return NULL;
>> +
>> +	pp =3D rxq->mp_params.mp_priv;
>> +	return pp->pool;
>> +}
>> +EXPORT_SYMBOL_GPL(xsk_rxq_pool);
>> +
>> +bool xsk_pp_supported(struct net_device *dev)
>> +{
>> +	const struct netdev_queue_mgmt_ops *qops =3D dev->queue_mgmt_ops;
>> +
>> +	return qops && qops->xsk_page_pool;
>> +}
>> +
>> +/* Called with RTNL and the instance lock of @dev. On error, @pool->pp =
stays
>> + * set if an old page pool still owns chunks; copy mode must not take t=
he pool.
>> + */
>> +int xsk_pp_bind(struct xsk_buff_pool *pool, struct net_device *dev,
>> +		u16 queue_id)
>> +{
>> +	struct pp_memory_provider_params mp =3D { .mp_ops =3D &xsk_pp_ops };
>> +	struct device *dma_dev;
>> +	struct xsk_pp *pp;
>> +	int err;
>> +
>> +	if (queue_id >=3D dev->real_num_rx_queues || pool->unaligned)
>> +		return -EOPNOTSUPP;
>> +	if ((dev->xdp_features & NETDEV_XDP_ACT_XSK) !=3D NETDEV_XDP_ACT_XSK ||
>> +	    (xsk_pool_uses_sg(pool) && dev->xdp_zc_max_segs =3D=3D 1))
>> +		return -EOPNOTSUPP;
>
> that is checked elsewhere, in xp_assign_dev() I assume.

Ah, yes! I'll do the common checks first in xp_assign_dev(), and branch
after.

> Why there are skb mode checks?

(Note to self: I need to make some details/designs more obvious in the
cover!)

Because the provider is turned on by the queue API at bind, not by an
XDP program. This is a big difference. Once the socket is bound, the
queue's page pool hands the device chunks from FILL, whatever program is
attached: native, generic or none. A generic redirect would copy into a
chunk taken from FILL behind the provider's back, and a provider pool
doesn't have the heads that copy path needs. So 07 drops those
redirects.

The checks make that visible (I hope): with a generic program attached,
bind falls back to copy mode, where generic XDP works, and attaching one
to a provider queue fails instead of dropping everything.

Driver ZC is different: ice and i40e use the pool only while a native
program is attached, so with a generic one the queue runs on normal
buffers, and the copy is the only FILL user.

> You sort of introduce totally separate control path and rx data path. It
> is hard for me to buy onto the management burden of all this new code :(
>
> I believe we should break this up onto smaller chunks and don't try to
> solve everything within a single set...or wil that not be possible?

Separate from driver ZC, yes, but not new: the provider binds the way
devmem and io_uring zcrx do, netif_mp_open_rxq() and a queue restart,
and the driver keeps its normal page pool RX path, with no ZC RX loop of
its own. The cost moves into the AF_XDP core, and xsk_pp.c is real code,
I know.

It can be split:

1. preparation, no new behaviour: netmem frag addresses, the page pool
   caps, fbnic's redirect and netmem patches, the TX metadata fix;
2. the provider for single-buffer packets, with fbnic, without the copy
   fallback or fbnic's shared header/payload pool;
3. multi-buffer.

Not sure it would help much TBH.

The provider, its bind and the delivery need a driver to land, so 2 is
the smallest set that does something. v2 also loses some things (but I'd
like to keep the validate ndo_bpf), e.g. nr_pools and the duplicate
checks. And I'm happy to look after xsk_pp.c. Would that work for you?

>> +	if (dev_xdp_prog_id(dev, XDP_MODE_SKB))
>> +		return -EOPNOTSUPP;
>> +	if (!netif_all_mps_have_cap(dev, MP_CAP_READABLE))
>> +		return -EBUSY;
>> +
>> +	err =3D xsk_pp_validate(dev, pool, dev->mtu, NULL, NULL);
>> +	if (err)
>> +		return err;
>> +
>> +	dma_dev =3D netdev_queue_get_dma_dev(dev, queue_id, NETDEV_QUEUE_TYPE_=
RX);
>> +	if (!dma_dev)
>> +		return -EOPNOTSUPP;
>> +
>> +	err =3D xp_dma_map(pool, dma_dev, XSK_PP_DMA_ATTR, pool->umem->pgs,
>> +			 pool->umem->npgs);
>> +	if (err)
>> +		return err;
>
> Couldn't we have this part common across drivers wanting to do ZC?

It is: this is core code, and no provider driver maps UMEM itself;
netdev_queue_get_dma_dev() gives the core the device, as for io_uring
zcrx. Driver ZC could map in xp_assign_dev() too, but drivers differ in
DMA device and attributes, so that's its own series.


Bj=C3=B6rn

