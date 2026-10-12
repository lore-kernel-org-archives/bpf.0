Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F10D371043;
	Mon, 12 Oct 2026 13:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791812099; cv=none; b=n3Xll3P0vBqey+eYMU4+KloZMW9vhe6661G28mNbleklGd/brDERlgzNgkwF6lY7PIbK8d6b2udqEIKY+9tfcO+IzVKF25nZjk0eWQrbVyvYQ+7wl9lQB9r9gZij+Q/zDgnXwEKt+hBStICUBqSyBXj+FPJ1Faxpx/6lBchyoYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791812099; c=relaxed/simple;
	bh=OhfL0GL8GJ86jahX5GdCFWMjyPBxJk0gmFh2OTmphns=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aXweN2WKn+L8e6S0MD5dSL5XqafRdwTjdPiNE3/kaSbS07jS8VTdzKHJ3UGRjrUO1AKxnZK5KgjWMQZGzChB811V9Qi7v1X8WVSHyntmNOTiz4Rge1UbcXecb4LxwqB63yfkOAcyvMkBGo0eHXgTWgxyLou2SNs8pplZWjA5Hds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ff8bMTf+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ff8bMTf+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F8B11F0089B;
	Mon, 12 Oct 2026 13:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791812097;
	bh=w/DeowNBJKbFIs3vJCMnI0ObhW5niXOTwHtocWeV7dk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=Ff8bMTf+7myqyUnSdtIx3d2O/3g8e2CsnV0ApHhxc8mJHmLFGYOtFne1SPzVtb20A
	 H5Jfhi8h/9KcszNJNv6VIp+4oz3QP8E346tD2NZq8fChiwlgf7oF/z9nyGV10NNPiA
	 0Tf5e9YM5xqh4tBg3V1vYzGZ3qbF7/1R8ktMci3PKEfwBSPubC7449KPomT9VCWF+2
	 4DObNNzKzEwXQS51+RoivQyzqk8zd9g8QdvhrtboPrTav+4jytLZQAzz77ZiOPZeJw
	 sXycZDc6F2sHuwcvq6tO9+ayJ6P1ZeQDABtWQZkr4oPPk/lsaAXmAkD1vGmUI7oMs6
	 pz3fRo3/FsAtw==
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
Subject: Re: [RFC net-next 03/15] net: Add memory provider capabilities
In-Reply-To: <asPPqXsmAygSdO94@devvm7509.cco0.facebook.com>
References: <20261002190018.696925-1-bjorn@kernel.org>
 <20261002190018.696925-4-bjorn@kernel.org>
 <asPPqXsmAygSdO94@devvm7509.cco0.facebook.com>
Date: Mon, 12 Oct 2026 15:34:54 +0200
Message-ID: <87h5irca9t.fsf@all.your.base.are.belong.to.us>
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
>> The current memory providers, devmem and io_uring zero-copy RX, give
>> memory that the CPU cannot read. The core allows them only on queues
>> with header-data split on, a zero header-split threshold, and no XDP
>> program. AF_XDP needs a provider that the CPU can read and that
>> works with XDP.
>>=20
>> Add a capability field to the provider operations, with
>> MP_CAP_READABLE as the first flag. Apply the header-split and XDP
>> rules only to providers without it. A queue with an AF_XDP buffer
>> pool still rejects other providers, but it accepts the provider made
>> from that same pool.
>>=20
>> Provider memory can become free while a queue is restarted, and no
>> device event reports it. After a restart, and after a failed restart
>> is rolled back, schedule the queue's NAPI if the queue has a
>> provider, so the driver tries to refill.
>>=20
>> Signed-off-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>
>> ---
>>  Documentation/networking/netmem.rst     |  7 ++-
>>  include/net/page_pool/memory_provider.h | 11 +++++
>>  include/net/page_pool/types.h           |  7 +--
>>  net/core/dev.c                          |  4 +-
>>  net/core/netdev_rx_queue.c              | 57 ++++++++++++++++++++-----
>>  net/ethtool/rings.c                     | 18 +++-----
>>  net/xdp/xsk_buff_pool.c                 |  3 +-
>>  7 files changed, 78 insertions(+), 29 deletions(-)
>>=20
>> diff --git a/Documentation/networking/netmem.rst b/Documentation/network=
ing/netmem.rst
>> index 217869d1108d..aacd185843ac 100644
>> --- a/Documentation/networking/netmem.rst
>> +++ b/Documentation/networking/netmem.rst
>> @@ -48,8 +48,11 @@ Driver RX Requirements
>>     - PP_FLAG_DMA_SYNC_DEV: netmem dma addr is not necessarily dma-synca=
ble
>>       by the driver. The driver must delegate the dma syncing to the pag=
e_pool,
>>       which knows when dma-syncing is (or is not) appropriate.
>> -   - PP_FLAG_ALLOW_UNREADABLE_NETMEM. The driver must specify this flag=
 iff
>> -     tcp-data-split is enabled.
>> +   - PP_FLAG_ALLOW_UNREADABLE_NETMEM. This opts the page pool into the =
memory
>> +     provider configured on its RX queue. For a provider without
>> +     MP_CAP_READABLE, the driver must specify it only for a payload pool
>> +     with tcp-data-split enabled. A readable provider may also back a
>> +     regular or header pool.
>>=20=20
>>  5. The driver must not assume the netmem is readable and/or backed by p=
ages.
>>     The netmem returned by the page_pool may be unreadable, in which case
>> diff --git a/include/net/page_pool/memory_provider.h b/include/net/page_=
pool/memory_provider.h
>> index 255ce4cfd975..d18ec079ffe2 100644
>> --- a/include/net/page_pool/memory_provider.h
>> +++ b/include/net/page_pool/memory_provider.h
>> @@ -9,6 +9,15 @@ struct netdev_rx_queue;
>>  struct netlink_ext_ack;
>>  struct sk_buff;
>>=20=20
>> +/**
>> + * enum mp_caps - memory provider capabilities
>> + * @MP_CAP_READABLE: The CPU can access provider buffers. They may back
>> + *	header and regular page pools, and XDP programs may run on them.
>> + */
>> +enum mp_caps {
>> +	MP_CAP_READABLE		=3D BIT(0),
>> +};
>> +
>>  struct memory_provider_ops {
>>  	netmem_ref (*alloc_netmems)(struct page_pool *pool, gfp_t gfp);
>>  	bool (*release_netmem)(struct page_pool *pool, netmem_ref netmem);
>> @@ -17,11 +26,13 @@ struct memory_provider_ops {
>>  	int (*nl_fill)(void *mp_priv, struct sk_buff *rsp,
>>  		       struct netdev_rx_queue *rxq);
>>  	void (*uninstall)(void *mp_priv, struct netdev_rx_queue *rxq);
>> +	u32 caps;
>>  };
>>=20=20
>>  bool net_mp_niov_set_dma_addr(struct net_iov *niov, dma_addr_t addr);
>>  void net_mp_niov_set_page_pool(struct page_pool *pool, struct net_iov *=
niov);
>>  void net_mp_niov_clear_page_pool(struct net_iov *niov);
>> +bool netif_mp_lacks_cap(struct net_device *dev, u32 cap);
>>=20=20
>>  int netif_mp_open_rxq(struct net_device *dev, unsigned int rxq_idx,
>>  		      const struct pp_memory_provider_params *p,
>> diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types=
.h
>> index 03da138722f5..a96376613dda 100644
>> --- a/include/net/page_pool/types.h
>> +++ b/include/net/page_pool/types.h
>> @@ -22,9 +22,10 @@
>>  					*/
>>  #define PP_FLAG_SYSTEM_POOL	BIT(2) /* Global system page_pool */
>>=20=20
>> -/* Allow unreadable (net_iov backed) netmem in this page_pool. Drivers =
setting
>> - * this must be able to support unreadable netmem, where netmem_address=
() would
>> - * return NULL. This flag should not be set for header page_pools.
>> +/* Allow memory-provider (net_iov backed) netmem in this page_pool. Dri=
vers
>> + * setting this must honor the provider's capabilities. Unless the prov=
ider has
>> + * MP_CAP_READABLE, netmem_address() returns NULL, and the flag must no=
t be set
>> + * for a header page_pool.
>>   *
>>   * If the driver sets PP_FLAG_ALLOW_UNREADABLE_NETMEM, it should also s=
et
>>   * page_pool_params.slow.queue_idx.
>> diff --git a/net/core/dev.c b/net/core/dev.c
>> index 5ac08da8b9d7..12b532c09a9c 100644
>> --- a/net/core/dev.c
>> +++ b/net/core/dev.c
>> @@ -10423,7 +10423,7 @@ int netif_xdp_propagate(struct net_device *dev, =
struct netdev_bpf *bpf)
>>  		return -EBUSY;
>>  	}
>>=20=20
>> -	if (dev_get_min_mp_channel_count(dev)) {
>> +	if (netif_mp_lacks_cap(dev, MP_CAP_READABLE)) {
>>  		NL_SET_ERR_MSG(bpf->extack, "unable to propagate XDP to device using =
memory provider");
>>  		return -EBUSY;
>>  	}
>> @@ -10499,7 +10499,7 @@ static int dev_xdp_install(struct net_device *de=
v, enum bpf_xdp_mode mode,
>>  		return -EBUSY;
>>  	}
>>=20=20
>> -	if (dev_get_min_mp_channel_count(dev)) {
>> +	if (netif_mp_lacks_cap(dev, MP_CAP_READABLE)) {
>>  		NL_SET_ERR_MSG(extack, "unable to install XDP to device using memory =
provider");
>>  		return -EBUSY;
>>  	}
>> diff --git a/net/core/netdev_rx_queue.c b/net/core/netdev_rx_queue.c
>> index 00a7011eb4d5..610e31d1a717 100644
>> --- a/net/core/netdev_rx_queue.c
>> +++ b/net/core/netdev_rx_queue.c
>> @@ -82,8 +82,12 @@ __netif_get_rx_queue_lease(struct net_device **dev, u=
nsigned int *rxq_idx,
>>  /* See also page_pool_is_unreadable() */
>>  bool netif_rxq_has_unreadable_mp(struct net_device *dev, unsigned int r=
xq_idx)
>>  {
>> -	if (rxq_idx < dev->real_num_rx_queues)
>> -		return __netif_get_rx_queue(dev, rxq_idx)->mp_params.mp_ops;
>> +	const struct memory_provider_ops *ops;
>> +
>> +	if (rxq_idx < dev->real_num_rx_queues) {
>> +		ops =3D __netif_get_rx_queue(dev, rxq_idx)->mp_params.mp_ops;
>> +		return ops && !(ops->caps & MP_CAP_READABLE);
>> +	}
>>  	return false;
>>  }
>>  EXPORT_SYMBOL(netif_rxq_has_unreadable_mp);
>> @@ -95,6 +99,32 @@ bool netif_rxq_has_mp(struct net_device *dev, unsigne=
d int rxq_idx)
>>  	return false;
>>  }
>>=20=20
>> +/* Return true if an installed memory provider lacks @cap. */
>> +bool netif_mp_lacks_cap(struct net_device *dev, u32 cap)
>> +{
>> +	const struct memory_provider_ops *ops;
>> +	int i;
>> +
>> +	netdev_assert_locked_ops_compat(dev);
>> +
>> +	for (i =3D dev->real_num_rx_queues - 1; i >=3D 0; i--) {
>> +		ops =3D dev->_rx[i].mp_params.mp_ops;
>> +		if (ops && (ops->caps & cap) !=3D cap)
>> +			return true;
>> +	}
>> +
>> +	return false;
>> +}
>> +
>> +/* Provider memory may become available while the queue is replaced,
>> + * without a device event to report it.
>> + */
>> +static void netdev_rx_queue_kick(struct netdev_rx_queue *rxq)
>> +{
>> +	if (rxq->mp_params.mp_ops && rxq->napi)
>> +		napi_schedule(rxq->napi);
>> +}
>> +
>>  static int netdev_rx_queue_reconfig(struct net_device *dev,
>>  				    unsigned int rxq_idx,
>>  				    struct netdev_queue_config *qcfg_old,
>
> [..]
>
>> @@ -142,6 +172,8 @@ static int netdev_rx_queue_reconfig(struct net_devic=
e *dev,
>>  	}
>>=20=20
>>  	qops->ndo_queue_mem_free(dev, old_mem);
>> +	if (netif_running(dev))
>> +		netdev_rx_queue_kick(rxq);
>>=20=20
>>  	kvfree(old_mem);
>>  	kvfree(new_mem);
>> @@ -165,6 +197,11 @@ static int netdev_rx_queue_reconfig(struct net_devi=
ce *dev,
>>=20=20
>>  err_free_new_queue_mem:
>>  	qops->ndo_queue_mem_free(dev, new_mem);
>> +	/* Freeing the replacement can hand provider memory back to the old
>> +	 * queue, which still runs unless the rollback failed.
>> +	 */
>> +	if (err !=3D -ENETDOWN && netif_running(dev))
>> +		netdev_rx_queue_kick(rxq);
>>=20=20
>>  err_free_old_mem:
>>  	kvfree(old_mem);
>
> These are separate fixes?

Thanks for taking a look!

The old pool can hold buffers the new pool needs. We need another refill
after those buffers return. I'll split that from the capabilities patch.


Bj=C3=B6rn
