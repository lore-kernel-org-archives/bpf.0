Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794403675;
	b=MHUpu2dPnJTpe3pFhfaexDAF/xZgpBk77PH1fNmIepvvkKYhYk4W1dAjDY/mbZly5ov1
	 TsTtDOfgDvMFQSxjM6+oRQtAlG3o7OVQ/pcCYiISoQK+mfQ1JvpUVCb3ooeyPriqbbE9q
	 iTrcpHEiAv7c6LGKkrOTzqbwTzxWCBoxSExVV8S8gRggA7KaTLjR1CwhNFNG+cJ5FUyyP
	 L0FHsF6s6AnhZWRxC7s3e3sIVuGGX7eL44QU91WHQGos/zhPBA3IDmAevoSGf6X0ORuQZ
	 mPIhjyiEJ45fvzn8TrFX03Bwj557y02FnSZe/eLtN2zfjKci+zaarGqMzhZDr4D7/CA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794403675;
	h=Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=5TobANsfNbQPE7bHGqRUO1+IBRipYYGScGTtUnijg5Y=;
	b=t1rdQ2P5X5f+rf1hlU4xu+mWkN4QUQXQH8jftQrpkzpgyLyEZC9BF34PuAyjyRGViA2s
	 OFqhcO+IZ/NjKq0LuUpC57dwyGoaFwMXceSp0dTxJ4tpuajomjvac12mpUHD0wrmeTM4b
	 7HI2cPPPpxsVYBoEB55+rbl/rV1YFCPVf0N0PVpM50wORljxhEJ48DYg50ttdURIXKhyD
	 WSkjWrQgDnis2nnFRR8oNt0prqdS0iTAHzP3K6gOie1wt4njZ+m+wJPzm3JXD4WQaa9ee
	 wEo5Zu6VLwVPBaB3IprQDS4mBHx+w8lv9y6ePFcw0/qVFWacT/LzJcbt2EE6Z7PxuBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NEdkPhkE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8E2606A31C;
	Wed, 11 Nov 2026 13:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NEdkPhkE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6368F1F00A05;
	Wed, 11 Nov 2026 13:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794403675;
	bh=5TobANsfNbQPE7bHGqRUO1+IBRipYYGScGTtUnijg5Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=NEdkPhkEYUeNthxyHswKlC+LjnE3+C8o+r69jP/kWWwPJmNjwUjX+n+MMVxp86fU3
	 nRjyHg29mW4zKgB9zMfQeSzMvvHdf2fKf94JxaWhgLL2UNMd7ycqXvlqYBgcx4uhXr
	 YNd/LCvK63k37DwGXK6b0TQDBrIGUpyAfYnNWJlIJlGu+t2gyajY4rYAs18sR8WJ/x
	 nMUEA4I988zdXET2E/tBIaZpQ2YcNX39oUAB+DEYSftb5YPfi2iJpdFO8M5uQWpbyh
	 GauZxaMl/9tkIxRUqgCf6TE/U4Jrnhpnix3hcgOcAIFMfnQHTfRsfI3a89cyrPU9+6
	 LZg4ZR/DaB6zA==
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
Subject: Re: [PATCH net-next v1 03/11] xdp: Copy buffers with restricted
 lifetime
In-Reply-To: <avOZa6jLnmvYkk2H@devvm16445.scu0.facebook.com>
References: <20261110102039.1002605-1-bjorn@kernel.org>
 <20261110102039.1002605-4-bjorn@kernel.org>
 <avOZa6jLnmvYkk2H@devvm16445.scu0.facebook.com>
Date: Wed, 11 Nov 2026 05:27:51 -0800
Message-ID: <87eccra46g.fsf@all.your.base.are.belong.to.us>
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

>> diff --git a/include/net/xdp.h b/include/net/xdp.h
>> index 07231adfb5f8..1105bb9e3292 100644
>> --- a/include/net/xdp.h
>> +++ b/include/net/xdp.h
>> @@ -81,6 +81,16 @@ enum xdp_buff_flags {
>>  	 * XDP program is not attached.
>>  	 */
>>  	XDP_FLAGS_FRAGS_UNREADABLE	=3D BIT(2),
>> +	/* Internal: the head netmem and the shared info are in &xdp_buff.ext.
>> +	 * Not copied to xdp_frames or skbs.
>> +	 */
>> +	XDP_FLAGS_EXT			=3D BIT(3),
>> +};
>> +
>> +/* For a head buffer that cannot hold kernel data, see xdp_init_buff_ne=
tmem() */
>> +struct xdp_buff_ext {
>> +	netmem_ref netmem;
>
> nit: netmem -> head ? and the same for xdp_init_buff_netmem netmem arg?

Yup, will fix.

>> @@ -138,7 +153,7 @@ static __always_inline void xdp_buff_set_frag_unread=
able(struct xdp_buff *xdp)
>>=20=20
>>  static __always_inline u32 xdp_buff_get_skb_flags(const struct xdp_buff=
 *xdp)
>>  {
>> -	return xdp->flags;
>> +	return xdp->flags & ~XDP_FLAGS_EXT;
>
> The only consumer is xdp_update_skb_frags_info, so probably not worth
> filtering out XDP_FLAGS_EXT here? Or is it for
> xdp_update_frame_from_buff? Can we explicitly clear it at the caller?=20

It was for xdp_update_frame_from_buff(), but looking closer EXT never
gets there...

I'll drop the mask. Thanks!

>> diff --git a/net/core/devmem.c b/net/core/devmem.c
>> index 8f190b574beb..dea4a4a17e86 100644
>> --- a/net/core/devmem.c
>> +++ b/net/core/devmem.c
>> @@ -698,5 +698,5 @@ static const struct memory_provider_ops dmabuf_devme=
m_ops =3D {
>>  	.release_netmem		=3D mp_dmabuf_devmem_release_page,
>>  	.nl_fill		=3D mp_dmabuf_devmem_nl_fill,
>>  	.uninstall		=3D mp_dmabuf_devmem_uninstall,
>> -	.caps			=3D MP_CAP_FRAG,
>> +	.caps			=3D MP_CAP_FRAG | MP_CAP_RETAIN,
>
> Not sure I understand this part, can you explain?
> These are MP_CAP_RETAIN because they are unreadable?

No, RETAIN is about lifetime: the stack may hold page pool references
after the RX poll, e.g. skbs on a TCP receive queue. That's how devmem
and zcrx work; without it the stack would try to copy them, and they'd
trip the DEBUG_NET check in skb_add_rx_frag_netmem().

A provider without RETAIN gets copied, so it must be readable. I'll try
to make that more clear in the kdoc, and probably refuse a provider that
is neither.

>> diff --git a/net/core/xdp.c b/net/core/xdp.c
>> index 1d679e8fd649..0cf46d492d91 100644
>> --- a/net/core/xdp.c
>> +++ b/net/core/xdp.c
>> @@ -23,6 +23,8 @@
>>  #include <trace/events/xdp.h>
>>  #include <net/xdp_sock_drv.h>
>>=20=20
>> +#include "dev.h"
>> +
>>  #define REG_STATE_NEW		0x0
>>  #define REG_STATE_REGISTERED	0x1
>>  #define REG_STATE_UNREGISTERED	0x2
>> @@ -559,10 +561,41 @@ void xdp_return_buff(struct xdp_buff *xdp)
>>  			     xdp->rxq->mem.type, true, xdp);
>>=20=20
>>  out:
>> -	__xdp_return(virt_to_netmem(xdp->data), xdp->rxq->mem.type, true, xdp);
>> +	__xdp_return(xdp_buff_head_netmem(xdp), xdp->rxq->mem.type, true, xdp);
>>  }
>>  EXPORT_SYMBOL_GPL(xdp_return_buff);
>>=20=20
>> +bool __xdp_buff_needs_copy(const struct xdp_buff *xdp)
>> +{
>> +	const struct skb_shared_info *sinfo;
>> +	u32 i;
>> +
>> +	/* Provider buffers come only from page pool queues */
>> +	if (xdp->rxq->mem.type !=3D MEM_TYPE_PAGE_POOL)
>> +		return false;
>> +	if (!netmem_can_retain(xdp_buff_head_netmem(xdp)))
>> +		return true;
>> +	if (likely(!xdp_buff_has_frags(xdp)))
>> +		return false;
>> +
>> +	sinfo =3D xdp_get_shared_info_from_buff(xdp);
>> +	for (i =3D 0; i < sinfo->nr_frags; i++) {
>> +		if (!netmem_can_retain(skb_frag_netmem(&sinfo->frags[i])))
>> +			return true;
>
> Do we want/need to go that deep? Can we have a skb-like assumptions that
> mixing retain and non-retain in the same shinfo is not allowed?

Yep, let's make that the rule. I'll remove the deep checks.


Bj=C3=B6rn
