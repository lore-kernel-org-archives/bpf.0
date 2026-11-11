Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794425184;
	b=yuEisPirZwx6aqwnaLSUSbKxjeouxZJmriM5aA8F4tq+1quahsU2kSttVzFY9iSudBVM
	 BKS9sKcpYx+63mv23mxeDtUgvVQUKPC6M2LyGUovitbYgRiRwRcrnaSvvQN9IzwYr5Z8K
	 UGjiV/ngKTKX6WD1vAhLZX3VppWfZs8Nm0UvM3btDG5gXagluwi1Hy1fLuwHhcEXQRJTw
	 q42XakktpJ0KzJVM6P42FpvlYZpDJuDGdUOn7/y4bh1PL7HKgu4FSVHpEiay1IJfYGYNc
	 W0J7XkQKZrXAdWyehFw5NszadTF4Bhdk7CAaj6vwWo4xIsn69qQZBP4H/weKmxAHOHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794425184;
	h=Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=pr1i3ecZGDWDAvpLi3ABH9Nl7KtZoQS7X+cpI1BrO3Y=;
	b=20ELUi5yYhQ/Xnf2hnzF4eU9y1tkyq1SY/htlHWSvo0tOjfVYEocZeyvx7quYMTZsRj/
	 Rnej6Wd9Wdv2MpcnZKLYU8gUMZe9yEIYp+mcBytvq8RBzM4dKldIcgbLrtrGJEyxeDV0M
	 1GgNV7R5a/3BafUY79cYQr7Uz3Ewp+8cdfkB7fwslcdxhIvyl7mUIoFdf70C69j2sV8M+
	 aS8DtxXHAH3oAdqavuy6EECpOoaId1QLnYwJ5bJOT5Pb7d7EJJpADlQE46B+cU7xfiS0R
	 B2cL8QGCq9iRzDUgWp7P64/aHOH1Ql+bM4ubRgjaS8pnwGsCAbNFT5aa4MlNXImDr6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="D/UGcqUc";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14012606A31C;
	Wed, 11 Nov 2026 19:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D/UGcqUc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFAFA1F00A05;
	Wed, 11 Nov 2026 19:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794425183;
	bh=pr1i3ecZGDWDAvpLi3ABH9Nl7KtZoQS7X+cpI1BrO3Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=D/UGcqUcwQkz6nfm3G07JgMB+/3Hq+c9+B1470SiKYg3q+WBzTVCED/nm/Kv10/wU
	 +RwPtlaZtlkenY3lzewO9GA2kxFdtdQAKu7BCuAu6PUZ6wRcLhiqfH/rSaXK7XQYx1
	 j+aN3H8HcoKrD6Z+VDE5ZNKF0O7rXbuMxoRA27SsuwbbUPUCMQrKVjXardHMzvdey6
	 Hyi7PAxO/WNn5rystEcCA5omgunZQdYlHOHZHkiSmY1VfXCSTovGPLACAb6eGDC+np
	 SYFY40RFug9owSGq9o2IGrnq4oM+oQT8poQDrGqgFFIMXkhbpJOAQw2g2+RDvvfb8a
	 CefaaMChBXAig==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Magnus Karlsson <magnus.karlsson@gmail.com>
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
Subject: Re: [PATCH net-next v1 05/11] xsk: Install UMEM page pool providers
 in the core
In-Reply-To: <CAJ8uoz2JMEKkzO-V7jtreS9q1Btmo0URosXzBGW7f=jhFnUzxg@mail.gmail.com>
References: <20261110102039.1002605-1-bjorn@kernel.org>
 <20261110102039.1002605-6-bjorn@kernel.org>
 <CAJ8uoz2JMEKkzO-V7jtreS9q1Btmo0URosXzBGW7f=jhFnUzxg@mail.gmail.com>
Date: Wed, 11 Nov 2026 11:26:19 -0800
Message-ID: <875wy3890k.fsf@all.your.base.are.belong.to.us>
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

Magnus Karlsson <magnus.karlsson@gmail.com> writes:

> On Tue, 10 Nov 2026 at 11:36, Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org> wr=
ote:

>> diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
>> index 18966bbdb5b7..c620a0c32c17 100644
>> --- a/net/xdp/xsk_buff_pool.c
>> +++ b/net/xdp/xsk_buff_pool.c
>> @@ -104,10 +101,30 @@ struct xsk_buff_pool *xp_create_and_assign_umem(st=
ruct xdp_sock *xs,
>>         pool->fq =3D xs->fq_tmp;
>>         pool->cq =3D xs->cq_tmp;
>>
>> -       for (i =3D 0; i < pool->free_heads_cnt; i++) {
>> +       return pool;
>> +
>> +out:
>> +       xp_destroy(pool);
>> +       return NULL;
>> +}
>> +
>> +/* Only copy mode and driver zero copy use heads */
>> +int xp_alloc_heads(struct xsk_buff_pool *pool)
>> +{
>> +       struct xdp_buff_xsk *xskb;
>> +       u32 i;
>> +
>> +       if (pool->heads)
>> +               return 0;
>> +
>> +       pool->heads =3D kvzalloc_objs(*pool->heads, pool->heads_cnt);
>> +       if (!pool->heads)
>> +               return -ENOMEM;
>> +
>> +       for (i =3D 0; i < pool->heads_cnt; i++) {
>
> Now I get why you are not reusing the existing xdp_buff_xsk infra, you
> are removing them here for the PP case. Please mention this in the
> cover letter of the previous patch. There might be a good argument for
> it at least in aligned mode. It is wasting memory versus performance.
> Today when memory is expensive and also for umems that are shared
> between many sockets, the current scheme in the xsk_buffer pool for
> aligned mode might not be worth it.

Will do!

> I have two questions for you. What would the performance be if you
> moved the aligned mode over to use the same free_list as unaligned
> mode and then use that in PP? Would reuse more code, but would it be
> fast enough?
>
> If that is not performant, what if you instead decreased the cost of
> the current pre-allocated xskbs in aligned mode by just creating a
> single copy per umem and using those in PP? Might be a good thing for
> regular xsk drivers too these days, but do not know if it will work
> for you.
>
> I do not know if any of these suggestions would work, but I think you
> should examine them as less code paths is generally a good thing. You
> might also improve the non-PP case too by optimizing it for your case!

Neither would help the provider. The page pool hands out net_iovs, so it
needs one per chunk anyway, and the driver brings its own xdp_buff.
net_iov, reuse and state are 69 bytes per chunk, against 128 for an
xdp_buff_xsk; free_list would add those 128 on top. Nor is reuse on the
hot path: the page pool recycles in its own cache and ring, and gives
chunks back only when it is destroyed or its ring is full. The hot path
is the FILL claim and the RX ring flush.

I don't like the reuse[] fixes size tho...

One copy per UMEM doesn't work either: an xdp_buff_xsk holds pool, rxq,
DMA addresses and cb, so it can only be shared by pools of the same
device and queue, and those already share the pool.

For driver ZC I agree, heads add up with a shared UMEM: 32 MB per pool
for 1 GB of 4K chunks. Unaligned mode allocates a head per chunk too,
though, so moving aligned mode to free_heads saves nothing by itself;
heads would have to be sized by the rings. Worth a look, with numbers,
but in a separate series.

>>                 xskb =3D &pool->heads[i];
>>                 xskb->pool =3D pool;
>> -               xskb->xdp.frame_sz =3D umem->chunk_size - umem->headroom;
>> +               xskb->xdp.frame_sz =3D pool->chunk_size - pool->headroom;
>>                 INIT_LIST_HEAD(&xskb->list_node);
>>                 if (pool->unaligned)
>>                         pool->free_heads[i] =3D xskb;
>> @@ -115,11 +132,7 @@ struct xsk_buff_pool *xp_create_and_assign_umem(str=
uct xdp_sock *xs,
>>                         xp_init_xskb_addr(xskb, pool, (u64)i * pool->chu=
nk_size);
>>         }
>>
>> -       return pool;
>> -
>> -out:
>> -       xp_destroy(pool);
>> -       return NULL;
>> +       return 0;
>
> Agree with Stan that these changes should be in a separate commit.
> Think also about if it would make sense to put your page_pool changes
> in yet another commit.

ACK!

>>  }
>>
>>  void xp_set_rxq_info(struct xsk_buff_pool *pool, struct xdp_rxq_info *r=
xq)
>> @@ -212,9 +225,24 @@ int xp_assign_dev(struct xsk_buff_pool *pool,
>>          */
>>         hlist_add_head(&pool->dev_node, &netdev->xsk_pools);
>>
>> -       if (force_copy)
>> +       if (force_copy) {
>>                 /* For copy-mode, we are done. */
>> +               err =3D xp_alloc_heads(pool);
>> +               goto out;
>> +       }
>> +
>> +       if (xsk_pp_supported(netdev)) {
>> +               err =3D xsk_pp_bind(pool, netdev, queue_id);
>> +               if (err)
>> +                       goto err_unreg_pool;
>> +
>> +               pool->umem->zc =3D true;
>>                 return 0;
>> +       }
>> +
>> +       err =3D xp_alloc_heads(pool);
>> +       if (err)
>> +               goto out;
>>
>>         if ((netdev->xdp_features & NETDEV_XDP_ACT_XSK) !=3D NETDEV_XDP_=
ACT_XSK) {
>>                 err =3D -EOPNOTSUPP;
>> @@ -267,8 +295,10 @@ int xp_assign_dev(struct xsk_buff_pool *pool,
>>  err_unreg_xsk:
>>         xp_disable_drv_zc(pool);
>>  err_unreg_pool:
>> -       if (!force_zc)
>> -               err =3D 0; /* fallback to copy mode */
>> +       /* An old page pool may still own chunks of a failed provider. */
>> +       if (!force_zc && !pool->pp)
>> +               err =3D xp_alloc_heads(pool); /* fallback to copy mode */
>> +out:
>>         if (err) {
>>                 pool->umem->flags =3D umem_flags;
>>                 xsk_clear_pool_at_qid(netdev, queue_id);
>> @@ -301,7 +331,10 @@ static void __xp_clear_dev(struct xsk_buff_pool *po=
ol)
>>         struct net_device *netdev =3D pool->netdev;
>>
>>         netdev_assert_locked_ops_compat(netdev);
>> -       xp_disable_drv_zc(pool);
>> +       if (pool->pp)
>> +               xsk_pp_unbind(pool);
>> +       else
>> +               xp_disable_drv_zc(pool);
>>         xsk_clear_pool_at_qid(netdev, pool->queue_id);
>>         hlist_del(&pool->dev_node);
>>         pool->netdev =3D NULL;
>> @@ -474,7 +507,7 @@ static void xp_check_dma_contiguity(struct xsk_dma_m=
ap *dma_map)
>>
>>  static int xp_init_dma_info(struct xsk_buff_pool *pool, struct xsk_dma_=
map *dma_map)
>>  {
>> -       if (!pool->unaligned) {
>> +       if (!pool->unaligned && pool->heads) {
>>                 u32 i;
>>
>>                 for (i =3D 0; i < pool->heads_cnt; i++) {
>> diff --git a/net/xdp/xsk_pp.c b/net/xdp/xsk_pp.c
>> index fdd55265a6cd..c2214e718cdb 100644
>> --- a/net/xdp/xsk_pp.c
>> +++ b/net/xdp/xsk_pp.c
>> @@ -8,6 +8,9 @@
>>   *       +-----RX ring-------+
>>   */
>>
>> +#include <net/netdev_lock.h>
>> +#include <net/netdev_queues.h>
>> +#include <net/netdev_rx_queue.h>
>>  #include <net/page_pool/helpers.h>
>>  #include <net/page_pool/memory_provider.h>
>>  #include <net/xdp_sock_drv.h>
>> @@ -15,6 +18,8 @@
>>  #include "xsk.h"
>>  #include "xsk_queue.h"
>>
>> +#define XSK_PP_DMA_ATTR        (DMA_ATTR_WEAK_ORDERING | DMA_ATTR_SKIP_=
CPU_SYNC)
>> +
>>  enum xsk_pp_chunk {
>>         XSK_PP_USER,    /* owned by userspace */
>>         XSK_PP_POOL,    /* owned by a page pool */
>> @@ -30,6 +35,8 @@ struct xsk_pp {
>>         refcount_t refs;
>>         u32 nr_pools;
>>         bool dma_need_sync;
>> +       /* RX queue of the provider, NULL once it is removed */
>> +       struct netdev_rx_queue *rxq;
>>         u8 *state;
>>         u32 reuse_cnt;
>>         u32 reuse[];
>> @@ -236,11 +243,225 @@ static int xsk_pp_nl_fill(void *mp_priv, struct s=
k_buff *rsp,
>>         return 0;
>>  }
>>
>> +/* The queue no longer uses the provider, and its DMA stopped */
>> +static void xsk_pp_detach(struct xsk_pp *pp)
>> +{
>> +       pp->rxq =3D NULL;
>> +       spin_lock_bh(&pp->lock);
>
> Just curious, but why this protection of the fq here?

After a normal unbind the queue is already stopped, so nothing reads
FILL anyway. It matters when the restart fails and the old queue keeps
running; I have a net fix that keeps the provider on such a queue until
a retry succeeds... but maybe it's better to introduce the lock then.
Let me noodle on it for the next rev.


Bj=C3=B6rn
