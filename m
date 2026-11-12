Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794513090;
	b=o8q9FL1s4h0xv8rEm3XQyglIbyJepFFBKt6MwREZbZSNKZM0dD650mXtRYl8rDu8DhVU
	 EuDv1hAA84BqRAU6/kUJd1PkknC2B7SYLKf66vww/RPhtuIbkLeAX70IORsgoSJlsudB1
	 ciS/0oZcb2NZhZaIFhWy2hl5fn29ICgrpRjQIkXi+2Y9fXMnGFESIIzPsJPOAUw4UFXub
	 nDRr7K4Bw1adg7U5TccPfBeVhyLO4Dbl7K21N55hNAwhkPSPN2sCQALIlAMGnAbN0S7PZ
	 psAxdVWjr5T99fIEyU6X1R/gJISaJI1SQ9Y24rthGcNB10kR2qc/XsiYcrKCeyHUqTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794513090;
	h=Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=J5YHlMWLzixlGZAieAoDB/16KHmKEu6ecY+Dpg3o9Zs=;
	b=vIJ0BzuOSSbqTGz2ArCxx6pF6s8836a06+cq7gvQMVKj4AXwlqq4PRZ38mR1jvtmTA9S
	 IVqW94wRe8muk5rp3uHq6cLyeMPdzSRNaK+sZmRBzvuVVZncjwSyc3KtzQ4k1/j8l2Nob
	 rbBHF7YOz5Zu/8SHNcajNi8QsEmEgzwdXCDJvENNcUDeXQOWOk41Zz6vXPPgfB/68fpvG
	 Q0PDNMrH4NVzb2c0571u65HU4Oxb0SruNOJk2R8tmEOwmyNwi+iqaNQjSlvDv8K/2VTWe
	 TRjzEbpOxHtaE9uEL/Vk1h/+3gOmJsxBdAbnqzA0Jytp3tNY4DD+kdYS1+hFM0EcH5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YDNlhiDz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2CA606A327;
	Thu, 12 Nov 2026 19:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YDNlhiDz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C70A1F000C4;
	Thu, 12 Nov 2026 19:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794513089;
	bh=J5YHlMWLzixlGZAieAoDB/16KHmKEu6ecY+Dpg3o9Zs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=YDNlhiDztLYpch6dqmeK4d/fJdLblsXSh91VJXz40SJ9cUOTncJMi+qJXByJG/+kE
	 +DYitf3rLVS32dgj1tn8IKs47A+pnKprk9/9BrxrwCSvn6rwbUljhsyuikM5ZgbpnS
	 jxQOTmhsK4ZN745Lw4PuHRF6wxmjyiwpJPiGWK3Rp0SFDnnFfT6xOyR+smWuVpYfq4
	 EJfhtaV71jhRmVTGE6yxPBTbuLt6sIuY0fdOesbRHjWE29sVf2l0KN5+0YUwWbI0qj
	 5SsntQDys/KtKLuSKpYr/NDlDse0nrF6EKcwBRqsu7XS3XGtw47uH6XkSyRhgEs+cB
	 cMqbgAb0je2iA==
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
In-Reply-To: <avXeswRldufJ8Nor@boxer>
References: <20261110102039.1002605-1-bjorn@kernel.org>
 <20261110102039.1002605-6-bjorn@kernel.org> <avWo1bY5MSN1XvHL@boxer>
 <874idmrtq8.fsf@all.your.base.are.belong.to.us> <avXeswRldufJ8Nor@boxer>
Date: Thu, 12 Nov 2026 20:51:26 +0100
Message-ID: <87a4ndrfpd.fsf@all.your.base.are.belong.to.us>
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

> On Thu, Nov 12, 2026 at 03:48:31PM +0100, Bj=C3=B6rn T=C3=B6pel wrote:
>> Maciej Fijalkowski <maciej.fijalkowski@intel.com> writes:

>> >> +/* Called with RTNL and the instance lock of @dev. On error, @pool->=
pp stays
>> >> + * set if an old page pool still owns chunks; copy mode must not tak=
e the pool.
>> >> + */
>> >> +int xsk_pp_bind(struct xsk_buff_pool *pool, struct net_device *dev,
>> >> +		u16 queue_id)
>> >> +{
>> >> +	struct pp_memory_provider_params mp =3D { .mp_ops =3D &xsk_pp_ops };
>> >> +	struct device *dma_dev;
>> >> +	struct xsk_pp *pp;
>> >> +	int err;
>> >> +
>> >> +	if (queue_id >=3D dev->real_num_rx_queues || pool->unaligned)
>> >> +		return -EOPNOTSUPP;
>> >> +	if ((dev->xdp_features & NETDEV_XDP_ACT_XSK) !=3D NETDEV_XDP_ACT_XS=
K ||
>> >> +	    (xsk_pool_uses_sg(pool) && dev->xdp_zc_max_segs =3D=3D 1))
>> >> +		return -EOPNOTSUPP;
>> >
>> > that is checked elsewhere, in xp_assign_dev() I assume.
>>=20
>> Ah, yes! I'll do the common checks first in xp_assign_dev(), and branch
>> after.
>>=20
>> > Why there are skb mode checks?
>>=20
>> (Note to self: I need to make some details/designs more obvious in the
>> cover!)
>>=20
>> Because the provider is turned on by the queue API at bind, not by an
>> XDP program. This is a big difference. Once the socket is bound, the
>> queue's page pool hands the device chunks from FILL, whatever program is
>> attached: native, generic or none. A generic redirect would copy into a
>> chunk taken from FILL behind the provider's back, and a provider pool
>> doesn't have the heads that copy path needs. So 07 drops those
>> redirects.
>>=20
>> The checks make that visible (I hope): with a generic program attached,
>> bind falls back to copy mode, where generic XDP works, and attaching one
>> to a provider queue fails instead of dropping everything.
>
> Might be a dumb question but couldn't you forbid generic xdp attach if you
> detect zc socket active on netdev? Or can't you have some deferring
> mechanism like other drivers do? Or is it now not possible as decision at
> that other drivers is done early at napi and here you don't really have a
> way to distinguish it?
>
> Another thought here - if user binds ZC socket and follows with generic
> XDP prog, then i'd say something is wrong.
>
> You generally *need* native xdp prog for resource bringup. I don't see why
> we have to worry that much about generic hook, which probably lacks real
> world use cases (sorry if I offended someone actually using it) ?

Not dumb, and that's what the attach check does: a generic program
fails to attach while a provider socket is bound, and a bind with one
attached falls back to copy mode. With those two, the drop in 07 can't
trigger, so it goes, as I told Stan. I agree generic doesn't
deserve more than that.

And I'd rather not tie the bringup to a native program, as driver ZC
does. That adds state: attach and detach would install and remove the
provider, restart the queues and handle that failing half way, and
whether a bound socket gets zero copy would depend on the program. Here
a socket depends only on its allocator, set up at bind, and the program
just picks the packets that go to it; the two are orthogonal.

That also leaves room for a mode without an XDP program, steering flows
to the queue like devmem and io_uring zcrx do ;-)

>>=20
>> Driver ZC is different: ice and i40e use the pool only while a native
>> program is attached, so with a generic one the queue runs on normal
>> buffers, and the copy is the only FILL user.
>>=20
>> > You sort of introduce totally separate control path and rx data path. =
It
>> > is hard for me to buy onto the management burden of all this new code =
:(
>> >
>> > I believe we should break this up onto smaller chunks and don't try to
>> > solve everything within a single set...or wil that not be possible?
>>=20
>> Separate from driver ZC, yes, but not new: the provider binds the way
>> devmem and io_uring zcrx do, netif_mp_open_rxq() and a queue restart,
>> and the driver keeps its normal page pool RX path, with no ZC RX loop of
>> its own. The cost moves into the AF_XDP core, and xsk_pp.c is real code,
>> I know.
>>=20
>> It can be split:
>>=20
>> 1. preparation, no new behaviour: netmem frag addresses, the page pool
>>    caps, fbnic's redirect and netmem patches, the TX metadata fix;
>> 2. the provider for single-buffer packets, with fbnic, without the copy
>>    fallback or fbnic's shared header/payload pool;
>> 3. multi-buffer.
>>=20
>> Not sure it would help much TBH.
>
> 1 as prep would be good, but I believe we were saying new ZC drivers are
> supposed to include mbuf support from day 0. Otherwise it might be hard to
> enforce this later.

TBH I fail to see how moving 1 to a separate set would make it easier to
review.

>>=20
>> The provider, its bind and the delivery need a driver to land, so 2 is
>> the smallest set that does something. v2 also loses some things (but I'd
>> like to keep the validate ndo_bpf), e.g. nr_pools and the duplicate
>> checks. And I'm happy to look after xsk_pp.c. Would that work for you?
>>=20
>> >> +	if (dev_xdp_prog_id(dev, XDP_MODE_SKB))
>> >> +		return -EOPNOTSUPP;
>> >> +	if (!netif_all_mps_have_cap(dev, MP_CAP_READABLE))
>> >> +		return -EBUSY;
>> >> +
>> >> +	err =3D xsk_pp_validate(dev, pool, dev->mtu, NULL, NULL);
>> >> +	if (err)
>> >> +		return err;
>> >> +
>> >> +	dma_dev =3D netdev_queue_get_dma_dev(dev, queue_id, NETDEV_QUEUE_TY=
PE_RX);
>> >> +	if (!dma_dev)
>> >> +		return -EOPNOTSUPP;
>> >> +
>> >> +	err =3D xp_dma_map(pool, dma_dev, XSK_PP_DMA_ATTR, pool->umem->pgs,
>> >> +			 pool->umem->npgs);
>> >> +	if (err)
>> >> +		return err;
>> >
>> > Couldn't we have this part common across drivers wanting to do ZC?
>>=20
>> It is: this is core code, and no provider driver maps UMEM itself;
>> netdev_queue_get_dma_dev() gives the core the device, as for io_uring
>> zcrx. Driver ZC could map in xp_assign_dev() too, but drivers differ in
>> DMA device and attributes, so that's its own series.
>
> I meant existing drivers do this on their side, idea was to make it common
> before your set so that you could reuse existing code.
>
> I am wondering what is the end goal here. If we would have enough of work
> force (or tokens) and time and willpower, I assume we would have every
> current xsk ZC driver converted to page_pool and finally orphan the
> MEM_TYPE_XSK_BUFF_POOL.
>
> That might not happen, so I feel like I sound like a sentinel, but current
> code can't just be abandonded. Hence all these asks for code reuse, etc.

I'm not saying we're orphaning anything. I am trying to reuse as much as
possible, but some parts does not fit. Like using xsk_buff_head -- the
page_pool return netmems. Type type is PAGE_POOL, and driver typically
use a stack allocated xdp_buff.

The end goal is enable the XSK core, so that a netdev driver does not
need to build a secondary shadow driver for XSK. Instead, driver
supports the page pool + queue restart APIs, and you can then use XSK,
devmem, and iouring zc with less code. Initially Rx, but we need a plan
for Tx as well at some point.

It would be awesome if over time we move from the existing "shadow
driver" world, to page pool and the provider, and MEM_TYPE_XSK_BUFF_POOL
goes once the last one has. Until then driver ZC keeps working as it
does today, and v2 will have numbers for it. FWIW, I'll keep converting
drivers too, not just land the core.

The fact that Linux does not have a driver ABI, which IMO a strength, is
just for work like this. We can clean up drivers, as the world change,
without keeping old stuff around forever.


Bj=C3=B6rn
