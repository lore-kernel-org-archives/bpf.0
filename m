Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794400880;
	b=liqO2LTN1pIDZrbACjdUiPtgCywqpDXX726+LA8iOzLxIwZPw51cy/BMv05dZJjHpiAs
	 eNUn0U+Kw/djp0vVmG8pMklLEgq1mXLkP4SGAYAg4Ws0K3wivYw6O1ICYpcP3Wj7lc2nS
	 LoDiVStNGTJN0njvSqDzmVuttzOMfhWDceeZYNffTZFdVLsfqCbz4EjCfjIrUNZ5Sgqiz
	 J4YEFkaAU27O36NQ5rXtDZ7EkyL43ynbgvwgagUfZg6sRuTjCF9aA0Kr3HvKpi9WdsVBM
	 OBYGvvdge/a3EKTLc2L/s2rbT8xUm/8f6TA/nYsvByuVTk7k/6TFeGtJWF4wJC40uhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794400880;
	h=Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=DdCwoGnDpUCUHpjoYOM2hQuvckRg7VfPcnlPRNoDJQE=;
	b=0Rm3LSoDY8GwVb6bpjyNMHobb/7rD0cALpNCfr37hIKl0SmagfCWxM0K8TcgnGpLcu0C
	 vqhGc9Th3dG5/+uJiKlxFymuSEfmZjYQBYRGTJEnNapkLtdaQsogkPt7x5JP61fhZQeeT
	 TxFjsNdpzPMzw5DV6ftwJH9JmbQn1k2WP2FTSc+SE8dQRBNKNodq9r5uZxGYF6xk08EMP
	 knK/u8pzDocVgiA4kou+oXu/OXsGLG55U2z0hNuAsIBEK3k45qYKZo3Lt99hDOz7BBgv7
	 b+XcKR6BMTZHqpTHQoMO6kBNH3ohclNkLsjNhlMJxJI/RfvDZWyE7+2MRf+tfv6EUaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dUxJLn4h;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE6F606A324;
	Wed, 11 Nov 2026 12:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dUxJLn4h
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD49F1F00A05;
	Wed, 11 Nov 2026 12:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794400879;
	bh=DdCwoGnDpUCUHpjoYOM2hQuvckRg7VfPcnlPRNoDJQE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=dUxJLn4hT0n/aAEX3bLnfyDoE9cAdBvwCjGWFMxBCw2f2gTk4sHHUV6qGy+iKZ3is
	 4MneIL0buqAjwJhZ20ITiGVl7Nz+gSiFhl++gQ+jYUBcOq5wySW35BTKfmU7Gw8LT5
	 yKOaHptGg8gvR5F5hTAx5hlGUagtWlZ+eb36/0oGwvF4aSIarE1OEyo20aVYWUjhLH
	 sgE99F/PGwV+/DB26U8PM8xWEZaQioQWoIaTF/kis+mtJRERgX39pj1rVXWjD9sLsa
	 5B3HVSgnDSAsfkwI9SjlJFlg38fnOwknoEGhb/PJnvFJQ1P1qOYJsFtAFLTv84aTnL
	 q+VFDIU+WeVZw==
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
 Mina Almasry <almasrymina@google.com>, "Mike Marciniszyn (Meta)"
 <mike.marciniszyn@gmail.com>, Weiming Shi <bestswngs@gmail.com>, Nikolay
 Aleksandrov <razor@blackwall.org>, David Wei <dw@davidwei.uk>, Alexander
 Lobakin <aleksander.lobakin@intel.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Stuart Clark <stuclar@meta.com>
Subject: Re: [PATCH net-next v1 02/11] net: Add memory provider capabilities
In-Reply-To: <avOYe27x-AlxmyK9@devvm16445.scu0.facebook.com>
References: <20261110102039.1002605-1-bjorn@kernel.org>
 <20261110102039.1002605-3-bjorn@kernel.org>
 <avOYe27x-AlxmyK9@devvm16445.scu0.facebook.com>
Date: Wed, 11 Nov 2026 04:41:15 -0800
Message-ID: <87mrrfa6c4.fsf@all.your.base.are.belong.to.us>
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

Stanislav Fomichev <sdf.kernel@gmail.com> writes:

> On 11/10, Bj=C3=B6rn T=C3=B6pel wrote:
>> The core treats every memory provider as unreadable: installing one
>> needs header split and no XDP program, and any page pool that allows
>> unreadable netmem takes it. An AF_XDP UMEM provider is readable, needs
>> XDP, and hands out whole buffers.
>>=20
>> Describe providers by MP_CAP_READABLE and MP_CAP_FRAG; devmem and
>> io_uring keep their behavior with MP_CAP_FRAG. A page pool takes a
>> readable provider only with the new PP_FLAG_MEM_PROVIDER:
>> PP_FLAG_ALLOW_UNREADABLE_NETMEM says that a driver handles unreadable
>> netmem, not that it handles any provider.
>>=20
>> Signed-off-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>
>> ---
>>  Documentation/networking/netmem.rst     |  5 ++++
>>  drivers/net/netkit.c                    |  3 +-
>>  include/net/page_pool/helpers.h         | 14 +++++++++-
>>  include/net/page_pool/memory_provider.h | 14 ++++++++++
>>  include/net/page_pool/types.h           | 15 ++++++++--
>>  io_uring/zcrx.c                         |  1 +
>>  net/core/dev.c                          | 10 ++++---
>>  net/core/devmem.c                       |  1 +
>>  net/core/netdev_rx_queue.c              | 37 ++++++++++++++++++++-----
>>  net/core/page_pool.c                    | 34 +++++++++++++++++++++--
>>  net/ethtool/rings.c                     |  7 +++--
>>  net/xdp/xsk_buff_pool.c                 |  3 +-
>>  12 files changed, 122 insertions(+), 22 deletions(-)
>>=20
>> diff --git a/Documentation/networking/netmem.rst b/Documentation/network=
ing/netmem.rst
>> index 6871dcdd700c..39cb75339704 100644
>> --- a/Documentation/networking/netmem.rst
>> +++ b/Documentation/networking/netmem.rst
>> @@ -103,6 +103,11 @@ Driver RX Requirements
>>       which knows when dma-syncing is (or is not) appropriate.
>>     - PP_FLAG_ALLOW_UNREADABLE_NETMEM. The driver must specify this flag=
 iff
>>       tcp-data-split is enabled.
>> +   - PP_FLAG_MEM_PROVIDER. The page pool takes memory from the memory
>> +     provider of its RX queue, readable or not. Page pool creation fail=
s if
>> +     the provider is unreadable and PP_FLAG_ALLOW_UNREADABLE_NETMEM is =
not
>> +     set, so do not set it on header page pools of such a queue. Withou=
t it,
>> +     PP_FLAG_ALLOW_UNREADABLE_NETMEM selects unreadable providers only.
>>=20=20
>>  5. The driver must not assume the netmem is readable and/or backed by p=
ages.
>>     The netmem returned by the page_pool may be unreadable, in which case
>> diff --git a/drivers/net/netkit.c b/drivers/net/netkit.c
>> index 82e608e733d9..df672ed5ffcc 100644
>> --- a/drivers/net/netkit.c
>> +++ b/drivers/net/netkit.c
>> @@ -12,6 +12,7 @@
>>  #include <net/netdev_lock.h>
>>  #include <net/netdev_queues.h>
>>  #include <net/netdev_rx_queue.h>
>> +#include <net/page_pool/memory_provider.h>
>>  #include <net/xdp_sock_drv.h>
>>  #include <net/netkit.h>
>>  #include <net/dst.h>
>> @@ -289,7 +290,7 @@ static int netkit_xsk(struct net_device *dev, struct=
 netdev_bpf *xdp)
>>  		ret =3D -EOPNOTSUPP;
>>  		goto out;
>>  	}
>> -	if (!create || !dev_get_min_mp_channel_count(phys))
>> +	if (!create || netif_all_mps_have_cap(phys, MP_CAP_READABLE))
>>  		ret =3D phys->netdev_ops->ndo_bpf(phys, &xdp_lower);
>>  out:
>>  	netdev_unlock(phys);
>> diff --git a/include/net/page_pool/helpers.h b/include/net/page_pool/hel=
pers.h
>> index 28635ce9454e..96e6b62cdebb 100644
>> --- a/include/net/page_pool/helpers.h
>> +++ b/include/net/page_pool/helpers.h
>> @@ -62,6 +62,7 @@
>>=20=20
>>  #include <linux/dma-mapping.h>
>>=20=20
>> +#include <net/page_pool/memory_provider.h>
>>  #include <net/page_pool/types.h>
>>  #include <net/net_debug.h>
>>  #include <net/netmem.h>
>> @@ -519,7 +520,18 @@ static inline void page_pool_nid_changed(struct pag=
e_pool *pool, int new_nid)
>>   */
>>  static inline bool page_pool_is_unreadable(struct page_pool *pool)
>>  {
>> -	return !!pool->mp_ops;
>> +	return pool->mp_ops && !(pool->mp_ops->caps & MP_CAP_READABLE);
>> +}
>> +
>> +/**
>> + * page_pool_supports_frag() - may page pool buffers be split
>> + * @pool: queried page pool
>> + *
>> + * Return: false if the memory provider of @pool hands out whole buffer=
s only
>> + */
>> +static inline bool page_pool_supports_frag(const struct page_pool *pool)
>> +{
>> +	return !pool->mp_ops || pool->mp_ops->caps & MP_CAP_FRAG;
>>  }
>>=20=20
>>  #endif /* _NET_PAGE_POOL_HELPERS_H */
>> diff --git a/include/net/page_pool/memory_provider.h b/include/net/page_=
pool/memory_provider.h
>> index bceb5f7740e2..4417e54a0f81 100644
>> --- a/include/net/page_pool/memory_provider.h
>> +++ b/include/net/page_pool/memory_provider.h
>> @@ -19,6 +19,18 @@ struct sk_buff;
>>   * Per-provider custom logic must be delegated to memory_provider_ops r=
ather
>>   * than handled directly in page_pool core code.
>>   */
>> +
>> +/**
>> + * enum mp_caps - memory provider capabilities
>> + * @MP_CAP_READABLE: The CPU can access provider memory. It may back he=
ader
>> + *	page pools, and XDP programs may run on it.
>> + * @MP_CAP_FRAG: Page pool fragments may split provider buffers.
>> + */
>> +enum mp_caps {
>> +	MP_CAP_READABLE		=3D BIT(0),
>> +	MP_CAP_FRAG		=3D BIT(1),
>> +};
>> +
>>  struct memory_provider_ops {
>>  	netmem_ref (*alloc_netmems)(struct page_pool *pool, gfp_t gfp);
>>  	bool (*release_netmem)(struct page_pool *pool, netmem_ref netmem);
>> @@ -27,6 +39,7 @@ struct memory_provider_ops {
>>  	int (*nl_fill)(void *mp_priv, struct sk_buff *rsp,
>>  		       struct netdev_rx_queue *rxq);
>>  	void (*uninstall)(void *mp_priv, struct netdev_rx_queue *rxq);
>> +	u32 caps;
>>  };
>>=20=20
>>  bool net_mp_niov_set_dma_addr(struct net_iov *niov, dma_addr_t addr);
>> @@ -38,6 +51,7 @@ int netif_mp_open_rxq(struct net_device *dev, unsigned=
 int rxq_idx,
>>  		      struct netlink_ext_ack *extack);
>>  int netif_mp_close_rxq(struct net_device *dev, unsigned int rxq_idx,
>>  		       const struct pp_memory_provider_params *old_p);
>> +bool netif_all_mps_have_cap(struct net_device *dev, u32 cap);
>>=20=20
>>  /**
>>    * net_mp_netmem_place_in_cache() - give a netmem to a page pool
>> diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types=
.h
>> index 6d543076a0c0..0d48c05f1462 100644
>> --- a/include/net/page_pool/types.h
>> +++ b/include/net/page_pool/types.h
>> @@ -31,8 +31,19 @@
>>   */
>>  #define PP_FLAG_ALLOW_UNREADABLE_NETMEM BIT(3)
>>=20=20
>> +/* Take memory from the memory provider of the RX queue, if one is inst=
alled.
>> + * Set page_pool_params.slow.netdev and queue_idx, and create the pool =
under
>> + * the instance lock of the netdev.
>> + * An unreadable provider also needs PP_FLAG_ALLOW_UNREADABLE_NETMEM, o=
r page
>> + * pool creation fails. Without this flag, PP_FLAG_ALLOW_UNREADABLE_NET=
MEM
>> + * selects unreadable providers only.
>> + */
>> +#define PP_FLAG_MEM_PROVIDER	BIT(4)
>> +
>>  #define PP_FLAG_ALL		(PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV | \
>> -				 PP_FLAG_SYSTEM_POOL | PP_FLAG_ALLOW_UNREADABLE_NETMEM)
>> +				 PP_FLAG_SYSTEM_POOL | \
>> +				 PP_FLAG_ALLOW_UNREADABLE_NETMEM | \
>> +				 PP_FLAG_MEM_PROVIDER)
>>=20=20
>>  /* Index limit to stay within PP_DMA_INDEX_BITS for DMA indices */
>>  #define PP_DMA_INDEX_LIMIT XA_LIMIT(1, BIT(PP_DMA_INDEX_BITS) - 1)
>> @@ -82,7 +93,7 @@ struct pp_alloc_cache {
>>   * @netdev:	netdev this pool will serve (leave as NULL if none or multi=
ple)
>>   * @queue_idx:	queue idx this page_pool is being created for.
>>   * @flags:	PP_FLAG_DMA_MAP, PP_FLAG_DMA_SYNC_DEV, PP_FLAG_SYSTEM_POOL,
>> - *		PP_FLAG_ALLOW_UNREADABLE_NETMEM.
>> + *		PP_FLAG_ALLOW_UNREADABLE_NETMEM, PP_FLAG_MEM_PROVIDER.
>>   */
>>  struct page_pool_params {
>>  	struct_group_tagged(page_pool_params_fast, fast,
>> diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
>> index 555f27e6c1ba..3b5bf97aa203 100644
>> --- a/io_uring/zcrx.c
>> +++ b/io_uring/zcrx.c
>> @@ -1478,6 +1478,7 @@ static const struct memory_provider_ops io_uring_p=
p_zc_ops =3D {
>>  	.destroy		=3D io_pp_zc_destroy,
>>  	.nl_fill		=3D io_pp_nl_fill,
>>  	.uninstall		=3D io_pp_uninstall,
>> +	.caps			=3D MP_CAP_FRAG,
>>  };
>>=20=20
>>  static unsigned zcrx_parse_rq(netmem_ref *netmem_array, unsigned nr,
>> diff --git a/net/core/dev.c b/net/core/dev.c
>> index 3b60b15e2175..663fe3e32ea0 100644
>> --- a/net/core/dev.c
>> +++ b/net/core/dev.c
>> @@ -10546,8 +10546,9 @@ int netif_xdp_propagate(struct net_device *dev, =
struct netdev_bpf *bpf)
>>  		return -EBUSY;
>>  	}
>>=20=20
>> -	if (dev_get_min_mp_channel_count(dev)) {
>> -		NL_SET_ERR_MSG(bpf->extack, "unable to propagate XDP to device using =
memory provider");
>> +	if (!netif_all_mps_have_cap(dev, MP_CAP_READABLE)) {
>> +		NL_SET_ERR_MSG(bpf->extack,
>> +			       "unable to propagate XDP to device using unreadable memory pr=
ovider");
>>  		return -EBUSY;
>>  	}
>>=20=20
>> @@ -10622,8 +10623,9 @@ static int dev_xdp_install(struct net_device *de=
v, enum bpf_xdp_mode mode,
>>  		return -EBUSY;
>>  	}
>>=20=20
>> -	if (dev_get_min_mp_channel_count(dev)) {
>> -		NL_SET_ERR_MSG(extack, "unable to install XDP to device using memory =
provider");
>> +	if (!netif_all_mps_have_cap(dev, MP_CAP_READABLE)) {
>> +		NL_SET_ERR_MSG(extack,
>> +			       "unable to install XDP to device using unreadable memory prov=
ider");
>>  		return -EBUSY;
>>  	}
>>=20=20
>> diff --git a/net/core/devmem.c b/net/core/devmem.c
>> index b9146b1f294a..8f190b574beb 100644
>> --- a/net/core/devmem.c
>> +++ b/net/core/devmem.c
>> @@ -698,4 +698,5 @@ static const struct memory_provider_ops dmabuf_devme=
m_ops =3D {
>>  	.release_netmem		=3D mp_dmabuf_devmem_release_page,
>>  	.nl_fill		=3D mp_dmabuf_devmem_nl_fill,
>>  	.uninstall		=3D mp_dmabuf_devmem_uninstall,
>> +	.caps			=3D MP_CAP_FRAG,
>>  };
>> diff --git a/net/core/netdev_rx_queue.c b/net/core/netdev_rx_queue.c
>> index a7261fedd5e7..9e14a747f9b5 100644
>> --- a/net/core/netdev_rx_queue.c
>> +++ b/net/core/netdev_rx_queue.c
>> @@ -82,9 +82,13 @@ __netif_get_rx_queue_lease(struct net_device **dev, u=
nsigned int *rxq_idx,
>>  /* See also page_pool_is_unreadable() */
>>  bool netif_rxq_has_unreadable_mp(struct net_device *dev, unsigned int r=
xq_idx)
>>  {
>> -	if (rxq_idx < dev->real_num_rx_queues)
>> -		return __netif_get_rx_queue(dev, rxq_idx)->mp_params.mp_ops;
>> -	return false;
>> +	const struct memory_provider_ops *ops;
>> +
>> +	if (rxq_idx >=3D dev->real_num_rx_queues)
>> +		return false;
>> +
>> +	ops =3D __netif_get_rx_queue(dev, rxq_idx)->mp_params.mp_ops;
>> +	return ops && !(ops->caps & MP_CAP_READABLE);
>>  }
>>  EXPORT_SYMBOL(netif_rxq_has_unreadable_mp);
>>=20=20
>> @@ -95,6 +99,22 @@ bool netif_rxq_has_mp(struct net_device *dev, unsigne=
d int rxq_idx)
>>  	return false;
>>  }
>>=20=20
>> +bool netif_all_mps_have_cap(struct net_device *dev, u32 cap)
>> +{
>> +	const struct memory_provider_ops *ops;
>> +	unsigned int i;
>> +
>> +	netdev_assert_locked_ops_compat(dev);
>> +
>> +	for (i =3D 0; i < dev->real_num_rx_queues; i++) {
>> +		ops =3D dev->_rx[i].mp_params.mp_ops;
>> +		if (ops && (ops->caps & cap) !=3D cap)
>> +			return false;
>> +	}
>> +
>> +	return true;
>> +}
>> +
>>  static int netdev_rx_queue_reconfig(struct net_device *dev,
>>  				    unsigned int rxq_idx,
>>  				    struct netdev_queue_config *qcfg_old,
>> @@ -189,6 +209,7 @@ static int __netif_mp_open_rxq(struct net_device *de=
v, unsigned int rxq_idx,
>>  			       struct netlink_ext_ack *extack)
>>  {
>>  	const struct netdev_queue_mgmt_ops *qops =3D dev->queue_mgmt_ops;
>> +	bool unreadable =3D !(p->mp_ops->caps & MP_CAP_READABLE);
>>  	struct netdev_queue_config qcfg[2];
>>  	struct netdev_rx_queue *rxq;
>>  	int ret;
>> @@ -196,16 +217,18 @@ static int __netif_mp_open_rxq(struct net_device *=
dev, unsigned int rxq_idx,
>>  	if (!qops)
>>  		return -EOPNOTSUPP;
>>=20=20
>> -	if (dev->cfg->hds_config !=3D ETHTOOL_TCP_DATA_SPLIT_ENABLED) {
>> +	if (unreadable &&
>> +	    dev->cfg->hds_config !=3D ETHTOOL_TCP_DATA_SPLIT_ENABLED) {
>>  		NL_SET_ERR_MSG(extack, "tcp-data-split is disabled");
>>  		return -EINVAL;
>>  	}
>> -	if (dev->cfg->hds_thresh) {
>> +	if (unreadable && dev->cfg->hds_thresh) {
>>  		NL_SET_ERR_MSG(extack, "hds-thresh is not zero");
>>  		return -EINVAL;
>>  	}
>> -	if (dev_xdp_prog_count(dev)) {
>> -		NL_SET_ERR_MSG(extack, "unable to custom memory provider to device wi=
th XDP program attached");
>> +	if (unreadable && dev_xdp_prog_count(dev)) {
>> +		NL_SET_ERR_MSG(extack,
>> +			       "unable to use unreadable memory provider with XDP program at=
tached");
>>  		return -EEXIST;
>>  	}
>>  	if (p->rx_page_size && !(qops->supported_params & QCFG_RX_PAGE_SIZE)) {
>> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
>> index d7c88c0b67e5..d88a3ea528d4 100644
>> --- a/net/core/page_pool.c
>> +++ b/net/core/page_pool.c
>> @@ -188,6 +188,29 @@ static void page_pool_struct_check(void)
>>  				    PAGE_POOL_FRAG_GROUP_ALIGN);
>>  }
>>=20=20
>> +static int page_pool_select_mp(struct page_pool *pool,
>> +			       const struct pp_memory_provider_params *mpp)
>> +{
>> +	const struct memory_provider_ops *ops =3D mpp->mp_ops;
>> +	unsigned int flags =3D pool->slow.flags;
>> +	bool readable;
>> +
>> +	if (!ops)
>> +		return 0;
>> +
>> +	readable =3D ops->caps & MP_CAP_READABLE;
>> +	if (flags & PP_FLAG_MEM_PROVIDER) {
>> +		if (!readable && !(flags & PP_FLAG_ALLOW_UNREADABLE_NETMEM))
>> +			return -EOPNOTSUPP;
>> +	} else if (readable) {
>> +		return 0;
>> +	}
>> +
>> +	pool->mp_priv =3D mpp->mp_priv;
>> +	pool->mp_ops =3D ops;
>> +	return 0;
>> +}
>> +
>>  static int page_pool_init(struct page_pool *pool,
>>  			  const struct page_pool_params *params,
>>  			  int cpuid)
>> @@ -272,12 +295,14 @@ static int page_pool_init(struct page_pool *pool,
>>=20=20
>>  	xa_init_flags(&pool->dma_mapped, XA_FLAGS_ALLOC1);
>>=20=20
>> -	if (pool->slow.flags & PP_FLAG_ALLOW_UNREADABLE_NETMEM) {
>> +	if (pool->slow.flags & (PP_FLAG_MEM_PROVIDER |
>> +				PP_FLAG_ALLOW_UNREADABLE_NETMEM)) {
>>  		netdev_assert_locked(pool->slow.netdev);
>>  		rxq =3D __netif_get_rx_queue(pool->slow.netdev,
>>  					   pool->slow.queue_idx);
>> -		pool->mp_priv =3D rxq->mp_params.mp_priv;
>> -		pool->mp_ops =3D rxq->mp_params.mp_ops;
>> +		err =3D page_pool_select_mp(pool, &rxq->mp_params);
>> +		if (err)
>> +			goto free_ptr_ring;
>>  	}
>>=20=20
>>  	if (pool->mp_ops) {
>> @@ -1070,6 +1095,9 @@ netmem_ref page_pool_alloc_frag_netmem(struct page=
_pool *pool,
>>  	unsigned int max_size =3D PAGE_SIZE << pool->p.order;
>>  	netmem_ref netmem =3D pool->frag_page;
>>=20=20
>
> [..]
>
>> +	if (static_branch_unlikely(&page_pool_mem_providers) &&
>> +	    WARN_ON_ONCE(!page_pool_supports_frag(pool)))
>> +		return 0;
>>  	if (WARN_ON(size > max_size))
>>  		return 0;
>>=20=20
>
> What's the deal with that? How do we get here?

Hey! Thanks for taking a look at the series!

An explicit frag call on a whole-buffer provider is a driver bug: UMEM
chunks can be smaller than a page, and RX gives the whole chunk to
userspace.

But page_pool_alloc_netmem() also picks frags for small requests, so a
valid call can warn.

I think it would be better to make it return a whole buffer and its
actual size. The WARN stays in the frag API, before taking a new buffer?
Wdyt?


Bj=C3=B6rn
