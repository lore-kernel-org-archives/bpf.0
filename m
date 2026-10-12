Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D4F3FCB37;
	Mon, 12 Oct 2026 14:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791814482; cv=none; b=tJXttjoOihqm1gU/bfWexunr5h0zqI+oy60CTXV9w55gMP4KTfIrXsv13oFDDzQMFiMn3x9MBCASUG1Yib0qYQlA+7QNUgfSL2Bkq2LFN9BLb3YdEWF68nubaWII3CMCD9k1Qf0VPIVE7Vcde0oQdNdCBDzxcC9WhIsbARYrJzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791814482; c=relaxed/simple;
	bh=ceC3DkinQnzgssYWjBSY7LZAGR+ChCV47GSthL2BjG4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=c3KisFWV8aap/7wg0mjVrhhpM9zgdo0hIKyn5F3GnNt8nzXNtJJte4SNkvaq8O+04axQ8Ad3Pt/RkWEyLFM8WqMgt/Txnp6RjfNRHUXEpLbh44aQb6l0O7aHEDhLVHGGyWSRnuQRSi5IvNeXfy7o6wD8EysrmiQ2xDKucxD8hAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZQdujEd3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZQdujEd3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FC581F0089B;
	Mon, 12 Oct 2026 14:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791814481;
	bh=FZMSNEWN8c3eC1CstWJpWeqj8Hq9WO/jQ/IPK7z+a6w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=ZQdujEd3nm1ANerj4OM7BrYF5ruevPlY3cvROcQpaFWKqZSSbmDWIvzkKBgiiSjKM
	 xukpSQ+VALmHPW0Ut0jCTjDxuuWiIChU75JOYBFbQtm34yQowbkZaigYiiF+6vTDGQ
	 +3+7DBmNJkzJyngfDUxfqoMDW5aXF5y6KghBOnZILPbNDL89aRxTGAoq5NtxE6eCwg
	 BJ19SOKDFmEoRal8sQwR20K0UED/WX/sk8di2bWh8J/qGo3+7ZYZxzW3ae5dTuYB0+
	 N67e35NAaDIndJZh9SCO+swDJAkcvZC3nKDnv1u0LQ0qN9jMmnfBs6zL+fK6hM+F8J
	 Rx5HVQwSkrt7w==
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
Subject: Re: [RFC net-next 09/15] xsk: Add a page-pool memory provider for UMEM
In-Reply-To: <asPfprbzjNAgKabP@devvm7509.cco0.facebook.com>
References: <20261002190018.696925-1-bjorn@kernel.org>
 <20261002190018.696925-10-bjorn@kernel.org>
 <asPfprbzjNAgKabP@devvm7509.cco0.facebook.com>
Date: Mon, 12 Oct 2026 16:14:38 +0200
Message-ID: <87y0c3atv5.fsf@all.your.base.are.belong.to.us>
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
>> AF_XDP zero-copy drivers get RX buffers from an xsk_buff_pool. A
>> driver built on page_pool would need a second RX allocator for that.
>> Instead, let an XSK buffer pool act as a page-pool memory provider.
>> It hands out UMEM chunks as NET_IOV_XSK net_iovs, and the driver
>> uses the normal page_pool API.
>>=20
>> A driver calls xsk_pool_setup_page_pool() for XDP_SETUP_XSK_POOL.
>> For now only 4 KiB pages and aligned UMEM with 4 KiB chunks work;
>> other setups get -EOPNOTSUPP. A bind without XDP_ZEROCOPY then falls
>> back to copy mode, as before. The exception is a failed setup that
>> leaves an old page pool being destroyed. That page pool still uses
>> the DMA mapping, so the bind fails.
>>=20
>> The provider reads the FILL ring in batches of the page-pool cache
>> refill size, and it handles RX need-wakeup. Each allocation reads at
>> most one batch, which limits the work spent on bad descriptors in
>> NAPI. Addresses outside the UMEM, and addresses that are already in
>> use, count as invalid descriptors and are dropped. refill_done keeps
>> NAPI scheduled while the FILL ring has entries. When the ring is
>> empty, it sets NEED_WAKEUP and then checks the ring once more.
>>=20
>> The provider asks for page-sized buffers with the UMEM headroom plus
>> XDP_PACKET_HEADROOM. It refuses a page pool whose DMA sync range
>> goes past the chunk.
>>=20
>> During a queue restart, two page pools can use one provider at the
>> same time. A provider lock protects the FILL ring, the reuse stack
>> and need-wakeup. Allocation takes it once per page-pool cache refill
>> of up to 64 buffers. A packet that is copied into a socket with a
>> provider takes it once per packet, because the copy also reads the
>> FILL ring.
>>=20
>> A buffer has one owner at a time, as a normal page-pool page does.
>> Allocation claims a buffer by setting its page pool under the
>> provider lock. Release clears the link, so destroying the provider
>> does not need to scan the UMEM.
>>=20
>> Generic XDP and synthetic RX queues, such as CPUMAP, would write to
>> the socket RX ring outside the queue's NAPI. While the provider is
>> installed, generic XDP drops such packets and counts them in
>> rx_dropped, and synthetic queues get -EINVAL. Classic zero-copy
>> sockets do not change.
>>=20
>> A failed queue restart can leave the old page pool draining. Keep
>> the UMEM, the DMA mapping and the netdev until the provider's last
>> page pool is destroyed. Charge the provider arrays, whose size grows
>> with the UMEM, to the memory cgroup of the socket owner.
>> XDP_SOCKETS now selects PAGE_POOL.
>>=20
>> Signed-off-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>
>> ---
>>  include/net/xdp_sock_drv.h  |  12 +
>>  include/net/xsk_buff_pool.h |   6 +-
>>  net/core/page_pool.c        |   4 +-
>>  net/xdp/Kconfig             |   1 +
>>  net/xdp/xsk.c               |  50 ++-
>>  net/xdp/xsk.h               |  58 ++++
>>  net/xdp/xsk_buff_pool.c     | 654 +++++++++++++++++++++++++++++++++++-
>>  7 files changed, 756 insertions(+), 29 deletions(-)
>>=20
>> diff --git a/include/net/xdp_sock_drv.h b/include/net/xdp_sock_drv.h
>> index d94aeb506379..b9288f5dd48b 100644
>> --- a/include/net/xdp_sock_drv.h
>> +++ b/include/net/xdp_sock_drv.h
>> @@ -9,6 +9,8 @@
>>  #include <net/xdp_sock.h>
>>  #include <net/xsk_buff_pool.h>
>>=20=20
>> +struct netlink_ext_ack;
>> +
>>  #define XDP_UMEM_MIN_CHUNK_SHIFT 11
>>  #define XDP_UMEM_MIN_CHUNK_SIZE (1 << XDP_UMEM_MIN_CHUNK_SHIFT)
>>=20=20
>> @@ -28,6 +30,8 @@ void xsk_tx_completed(struct xsk_buff_pool *pool, u32 =
nb_entries);
>>  bool xsk_tx_peek_desc(struct xsk_buff_pool *pool, struct xdp_desc *desc=
);
>>  u32 xsk_tx_peek_release_desc_batch(struct xsk_buff_pool *pool, u32 max);
>>  void xsk_tx_release(struct xsk_buff_pool *pool);
>> +int xsk_pool_setup_page_pool(struct net_device *dev, struct xsk_buff_po=
ol *pool,
>> +			     u16 queue_id, struct netlink_ext_ack *extack);
>>  struct xsk_buff_pool *xsk_get_pool_from_qid(struct net_device *dev,
>>  					    u16 queue_id);
>>  void xsk_set_rx_need_wakeup(struct xsk_buff_pool *pool);
>> @@ -370,6 +374,14 @@ static inline void xsk_tx_release(struct xsk_buff_p=
ool *pool)
>>  {
>>  }
>>=20=20
>> +static inline int xsk_pool_setup_page_pool(struct net_device *dev,
>> +					   struct xsk_buff_pool *pool,
>> +					   u16 queue_id,
>> +					   struct netlink_ext_ack *extack)
>> +{
>> +	return -EOPNOTSUPP;
>> +}
>> +
>>  static inline struct xsk_buff_pool *
>>  xsk_get_pool_from_qid(struct net_device *dev, u16 queue_id)
>>  {
>> diff --git a/include/net/xsk_buff_pool.h b/include/net/xsk_buff_pool.h
>> index 77264c4902c0..9eed8796a356 100644
>> --- a/include/net/xsk_buff_pool.h
>> +++ b/include/net/xsk_buff_pool.h
>> @@ -11,6 +11,7 @@
>>  #include <net/xdp.h>
>>=20=20
>>  struct xsk_buff_pool;
>> +struct xsk_pp;
>>  struct xdp_rxq_info;
>>  struct xsk_cb_desc;
>>  struct xsk_queue;
>> @@ -52,7 +53,8 @@ struct xsk_buff_pool {
>>  	spinlock_t xsk_tx_list_lock;
>>  	refcount_t users;
>>  	struct xdp_umem *umem;
>> -	struct work_struct work;
>> +	struct xsk_pp *pp;
>> +	struct delayed_work work;
>>  	/* Protects generic receive in shared and non-shared umem mode. */
>>  	spinlock_t rx_lock;
>>  	struct list_head free_list;
>> @@ -117,10 +119,8 @@ int xp_alloc_tx_descs(struct xsk_buff_pool *pool, s=
truct xdp_sock *xs,
>>  void xp_destroy(struct xsk_buff_pool *pool);
>>  void xp_get_pool(struct xsk_buff_pool *pool);
>>  bool xp_put_pool(struct xsk_buff_pool *pool);
>> -void xp_clear_dev(struct xsk_buff_pool *pool);
>>  void xp_add_xsk(struct xsk_buff_pool *pool, struct xdp_sock *xs);
>>  void xp_del_xsk(struct xsk_buff_pool *pool, struct xdp_sock *xs);
>> -
>>  /* AF_XDP, and XDP core. */
>>  void xp_free(struct xdp_buff_xsk *xskb);
>>=20=20
>> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
>> index e36ae6123adf..1f446e9a10d7 100644
>> --- a/net/core/page_pool.c
>> +++ b/net/core/page_pool.c
>> @@ -1397,8 +1397,8 @@ void net_mp_release_page_pool_bulk(struct page_poo=
l *pool,
>>  		atomic_add(count, release_cnt);
>>  }
>>=20=20
>> -/* Disassociate a niov from a page pool. Should only be used in the
>> - * ->release_netmem() path.
>> +/* Disassociate a niov from a page pool. Memory providers may do this e=
ither
>> + * from ->release_netmem() or from ->destroy() after all objects were r=
eleased.
>>   */
>>  void net_mp_niov_clear_page_pool(struct net_iov *niov)
>>  {
>> diff --git a/net/xdp/Kconfig b/net/xdp/Kconfig
>> index 71af2febe72a..c9c68d3b3712 100644
>> --- a/net/xdp/Kconfig
>> +++ b/net/xdp/Kconfig
>> @@ -2,6 +2,7 @@
>>  config XDP_SOCKETS
>>  	bool "XDP sockets"
>>  	depends on BPF_SYSCALL
>> +	select PAGE_POOL
>>  	default n
>>  	help
>>  	  XDP sockets allows a channel between XDP programs and
>> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
>> index b68dda9c37d1..90c98b42a18a 100644
>> --- a/net/xdp/xsk.c
>> +++ b/net/xdp/xsk.c
>> @@ -464,7 +464,9 @@ static int xsk_rcv_check(struct xdp_sock *xs, struct=
 xdp_buff *xdp, u32 len)
>>  static void xsk_flush(struct xdp_sock *xs)
>>  {
>>  	xskq_prod_submit(xs->rx);
>> -	__xskq_cons_release(xs->pool->fq);
>> +	/* Provider pools publish FILL consumption under the provider lock. */
>> +	if (!READ_ONCE(xs->pool->pp))
>> +		__xskq_cons_release(xs->pool->fq);
>>  	sock_def_readable(&xs->sk);
>>  }
>>=20=20
>> @@ -474,16 +476,40 @@ int xsk_generic_rcv(struct xdp_sock *xs, struct xd=
p_buff *xdp)
>>  	int err;
>>=20=20
>>  	err =3D xsk_rcv_check(xs, xdp, len);
>> -	if (!err) {
>> -		spin_lock_bh(&xs->pool->rx_lock);
>> -		err =3D __xsk_rcv(xs, xdp, len);
>> -		xsk_flush(xs);
>> +	if (err)
>> +		return err;
>> +	spin_lock_bh(&xs->pool->rx_lock);
>> +	if (unlikely(READ_ONCE(xs->pool->pp))) {
>> +		xs->rx_dropped++;
>>  		spin_unlock_bh(&xs->pool->rx_lock);
>> +		return -EOPNOTSUPP;
>>  	}
>> +	err =3D __xsk_rcv(xs, xdp, len);
>> +	xsk_flush(xs);
>> +	spin_unlock_bh(&xs->pool->rx_lock);
>>=20=20
>>  	return err;
>>  }
>>=20=20
>> +/* Copy into the socket's UMEM. A provider-backed pool shares its FILL =
ring
>> + * with provider allocation, which can run for another page pool of the=
 queue
>> + * while the queue is replaced.
>> + */
>> +static int xsk_rcv_copy(struct xdp_sock *xs, struct xdp_buff *xdp, u32 =
len)
>> +{
>> +	struct xsk_pp *provider =3D READ_ONCE(xs->pool->pp);
>> +	int err;
>> +
>> +	if (likely(!provider))
>> +		return __xsk_rcv(xs, xdp, len);
>> +
>> +	spin_lock_bh(&provider->lock);
>> +	err =3D __xsk_rcv(xs, xdp, len);
>> +	__xskq_cons_release(xs->pool->fq);
>> +	spin_unlock_bh(&provider->lock);
>> +	return err;
>> +}
>> +
>>  static int xsk_rcv(struct xdp_sock *xs, struct xdp_buff *xdp)
>>  {
>>  	u32 len =3D xdp_get_buff_len(xdp);
>> @@ -498,7 +524,15 @@ static int xsk_rcv(struct xdp_sock *xs, struct xdp_=
buff *xdp)
>>  		return xsk_rcv_zc(xs, xdp, len);
>>  	}
>>=20=20
>> -	err =3D __xsk_rcv(xs, xdp, len);
>> +	/* The socket RX ring has a single producer, the queue's poll context.
>> +	 * Reject synthetic RX queues before their remote context produces
>> +	 * into a provider-backed socket.
>> +	 */
>> +	if (unlikely(READ_ONCE(xs->pool->pp) &&
>> +		     !xdp_rxq_info_is_reg(xdp->rxq)))
>> +		return -EINVAL;
>> +
>> +	err =3D xsk_rcv_copy(xs, xdp, len);
>>  	if (!err)
>>  		xdp_return_buff(xdp);
>>  	return err;
>> @@ -2149,8 +2183,8 @@ static int xsk_notifier(struct notifier_block *thi=
s,
>>=20=20
>>  				xsk_unbind_dev(xs);
>>=20=20
>> -				/* Clear device references. */
>> -				xp_clear_dev(xs->pool);
>> +				/* Unregister cannot hold a device reference. */
>> +				xp_clear_dev(xs->pool, XSK_POOL_CLEAR_FORCE);
>>  			}
>>  			mutex_unlock(&xs->mutex);
>>  		}
>> diff --git a/net/xdp/xsk.h b/net/xdp/xsk.h
>> index 7c811b5cce76..8770778cd322 100644
>> --- a/net/xdp/xsk.h
>> +++ b/net/xdp/xsk.h
>> @@ -4,6 +4,64 @@
>>  #ifndef XSK_H_
>>  #define XSK_H_
>>=20=20
>> +#include <net/netmem.h>
>> +
>> +struct xsk_buff_pool;
>> +
>> +enum xsk_pool_clear_mode {
>> +	XSK_POOL_CLEAR_NORMAL,
>> +	XSK_POOL_CLEAR_FORCE,
>> +};
>> +
>> +struct xsk_pp_info {
>> +	struct net_iov_area area;
>> +	struct xsk_buff_pool *pool;
>> +	u32 chunk_shift;
>> +};
>> +
>> +/* Keep page_pool descriptors independent from direct-driver XSK buffer=
s.
>> + * Queue replacement creates the new page_pool before it stops the old =
queue
>> + * and destroys the old page_pool after the new queue started, so two
>> + * page_pools can use one provider. @lock serializes the state they sha=
re.
>> + * Generic XDP cannot deliver to a provider-backed socket.
>> + */
>> +struct xsk_pp {
>> +	struct xsk_pp_info info;
>> +	struct xsk_queue __rcu *fq;
>> +	/* FILL consumers, @reuse and RX need_wakeup state */
>> +	spinlock_t lock;
>> +	u32 reuse_cnt;
>> +	u32 nr_pools;
>> +	u64 chunk_mask;
>> +	u64 addrs_cnt;
>> +	u8 release_retries;
>> +	bool dma_need_sync;
>> +	bool detached;
>> +	u32 reuse[];
>> +};
>> +
>> +void xp_clear_dev(struct xsk_buff_pool *pool, enum xsk_pool_clear_mode =
mode);
>> +
>> +static inline bool xp_netmem_is_xsk(netmem_ref netmem)
>> +{
>> +	return netmem_is_net_iov(netmem) &&
>> +	       netmem_to_net_iov(netmem)->type =3D=3D NET_IOV_XSK;
>> +}
>> +
>> +static inline struct xsk_pp_info *xp_netmem_to_pp(netmem_ref netmem)
>> +{
>> +	struct net_iov *niov =3D netmem_to_net_iov(netmem);
>> +
>> +	return container_of(net_iov_owner(niov), struct xsk_pp_info, area);
>> +}
>> +
>> +static inline bool xp_netmem_is_from_pool(netmem_ref netmem,
>> +					  const struct xsk_buff_pool *pool)
>> +{
>> +	return xp_netmem_is_xsk(netmem) &&
>> +	       xp_netmem_to_pp(netmem)->pool =3D=3D pool;
>> +}
>> +
>>  struct xdp_ring_offset_v1 {
>>  	__u64 producer;
>>  	__u64 consumer;
>> diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
>> index 244776a72961..e25347f8c208 100644
>> --- a/net/xdp/xsk_buff_pool.c
>> +++ b/net/xdp/xsk_buff_pool.c
>> @@ -1,7 +1,11 @@
>>  // SPDX-License-Identifier: GPL-2.0
>>=20=20
>>  #include <linux/netdevice.h>
>> +#include <linux/sizes.h>
>>  #include <net/netdev_lock.h>
>> +#include <net/netdev_queues.h>
>> +#include <net/netdev_rx_queue.h>
>> +#include <net/page_pool/helpers.h>
>>  #include <net/page_pool/memory_provider.h>
>>  #include <net/xsk_buff_pool.h>
>>  #include <net/xdp_sock.h>
>> @@ -12,6 +16,20 @@
>>  #include "xsk.h"
>>=20=20
>>  #define ETH_PAD_LEN (ETH_HLEN + 2 * VLAN_HLEN  + ETH_FCS_LEN)
>> +#define XSK_PAGE_POOL_DMA_ATTR	(DMA_ATTR_WEAK_ORDERING | \
>> +				 DMA_ATTR_SKIP_CPU_SYNC)
>> +#define XSK_POOL_RELEASE_RETRY_MAX	(60 * HZ)
>> +
>> +static bool xp_pp_teardown(struct xsk_buff_pool *pool);
>> +static void xp_pp_retry_release(struct xsk_buff_pool *pool);
>> +static void xp_destroy_unbound_deferred(struct work_struct *work);
>> +
>> +static void __xp_destroy(struct xsk_buff_pool *pool)
>> +{
>> +	kvfree(pool->tx_descs);
>> +	kvfree(pool->heads);
>> +	kvfree(pool);
>> +}
>>=20=20
>>  void xp_add_xsk(struct xsk_buff_pool *pool, struct xdp_sock *xs)
>>  {
>> @@ -38,9 +56,22 @@ void xp_destroy(struct xsk_buff_pool *pool)
>>  	if (!pool)
>>  		return;
>>=20=20
>> -	kvfree(pool->tx_descs);
>> -	kvfree(pool->heads);
>> -	kvfree(pool);
>> +	/* A failed queue replacement can leave a page_pool waiting for an
>> +	 * in-flight buffer.  Keep the UMEM and pool alive until its provider
>> +	 * destroy callback has run.
>> +	 */
>
> [..]
>
>> +	if (pool->pp) {
>
>
> Would be nice to do a cleanup in xsk_buff_pool: separate it into
> common/generic parts and pp vs non-pp parts. And maybe pp vs non-pp can
> be a union? With the addition of pp, it's gonna be hard to understand
> what is new/shiny vs old/deprecated. I'm assuming, at some point, when
> every driver is backed by pp umem, we can drop the non-umem path?

Yep. I'll try to split the shared and allocator-specific state. Need to
check fallback and teardown before using a union.

Both paths use UMEM, so the direct allocator can go only after (if ever)
its users migrate.
