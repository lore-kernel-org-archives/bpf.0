Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794935647;
	b=heMBlxDOUa+Xv6b5dIR8ZXUL34Hq5hZvzRZEzcugHzyB1zWSs0RT+Nk3k62/1hb6NhNq
	 Seu0S+3mf1U2yXG9/3P0tTDUC6z6j+Lzl13+SIUTLX7OQlU1/90UpZ3PttduiycrFtkuJ
	 VRxlI1ptXE0EuvEUz6ev0GUqmZCAbM8RKhuxOsVneRhutBEAUdE2gmp1LzqKKjTjlNsfM
	 fIHAVQHfORd7JJosWrXr5UC+iMNmSjqKgY3eMP5S9y3gy9/QNsouqHwtKjgwbX7bDuwtn
	 Lba0W8q9NYZ/98P9JUUk9ezS1WuYu64i4MwIeqaLgBRLKofutS2MSJ6AkESPt/FowMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794935647;
	h=Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=NRyU0VXlTkdP1/qvlbXfSzmeB6PM6cbuXEo4V1pctGY=;
	b=4o0M1A629nW4WQ2646DyW7W/Q7mgkWZRFblBxRmcjlw6D7wvhQLOVKSsHCPln8jmcrj7
	 Pwzo2K8Cn6IBulPYvG6rXTexlFCZPZzdMgEB6I8KxT6mbtSAqJ+RIp6I9ECVmaRhdP5Eh
	 j7Iy9+1Wso4zXkPVLPKZmKH0ARlT4sV3k/8zi1ng1ucN1PerYYS11SgKQ6nNUXuIbvw8N
	 WSDj1FxA0gew55UThnK6chOb2d3ODj8WgH69PTb2VD7/HERN9DNEVh14XN2LviYnQIxed
	 5TqXaMgPG5vI70zyyEzenzi0EBtnwUKUi/lIurSb12KQ+GI4lQEhnxLDX+E4AXKgmvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="TNwd9t9/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85ECB606A31C;
	Tue, 17 Nov 2026 17:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TNwd9t9/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4F061F000C5;
	Tue, 17 Nov 2026 17:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794935647;
	bh=NRyU0VXlTkdP1/qvlbXfSzmeB6PM6cbuXEo4V1pctGY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=TNwd9t9/XGKlncwoxJPsyje6+O4dpP5ku58Mpp7QpykW21hRU24e7OyhFQOFLciD3
	 29wDKM5s9fQuNCM01MGCMTwcBZHTKwQdsNtqa7KbaUKomgmrOjw4ONVzwknMHgSKWG
	 1/ngYLQ7fkk6zwnEFmvEkhsBFU0rrWBDVK01KIhZAY8wwmSD8BfUnHzr3O6ECtL3IE
	 u1gWEaoZknei2o6RPefiK6Y9Pv118lQd9Tbgj+OxIU/l4ZeNMJUeOk7Seiwb4Z23fa
	 avUcbgeGAljAO6nP3GxtzkHh3NhCflawy+bc6tSkh2Am7hoM2GVwuD99dWB//R/78k
	 9Tnxc6+M677Ag==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>, Magnus Karlsson
 <magnus.karlsson@intel.com>, Maciej Fijalkowski
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
 Mina Almasry <almasrymina@google.com>
Cc: "Mike Marciniszyn (Meta)" <mike.marciniszyn@gmail.com>, Weiming Shi
 <bestswngs@gmail.com>, Nikolay Aleksandrov <razor@blackwall.org>, David
 Wei <dw@davidwei.uk>, Alexander Lobakin <aleksander.lobakin@intel.com>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Stuart Clark
 <stuclar@meta.com>
Subject: Re: [PATCH net-next v1 11/11] eth: fbnic: Support AF_XDP page pool
 zero copy
In-Reply-To: <6303b161-0f35-47ee-ab70-ebd4e802ae09@gmail.com>
References: <20261110102039.1002605-1-bjorn@kernel.org>
 <20261110102039.1002605-12-bjorn@kernel.org>
 <6303b161-0f35-47ee-ab70-ebd4e802ae09@gmail.com>
Date: Tue, 17 Nov 2026 18:14:04 +0100
Message-ID: <87se0z1iub.fsf@all.your.base.are.belong.to.us>
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

Dimitri Daskalakis <dimitri.daskalakis1@gmail.com> writes:

> On 11/10/26 2:20 AM, Bj=C3=B6rn T=C3=B6pel wrote:
>> Header and payload rings share one provider page pool, so refills even
>> them out, and a short pool does not starve one of them. Payload
>> buffers start at chunk offset 0, and the UMEM headroom rules require
>> headroom only in the first buffer. A chunk is one 4 KiB device page,
>> also with larger kernel pages, so rings fed by the provider post one
>> descriptor per chunk.
>>=20
> [...]
>>  	qt->sub0.page_pool =3D pp;
>> +	fbnic_bdq_set_page_size(&qt->sub0, xsk ? rx_page_size : PAGE_SIZE);
>>  	qt->hdr_max =3D 0;
>>  	if (!page_pool_supports_frag(pp))
>> -		qt->hdr_max =3D fbnic_whole_hdr_max(FBNIC_RX_HROOM);
>> +		qt->hdr_max =3D fbnic_whole_hdr_max(qt->rx_hroom);
>>  	if (netif_rxq_has_unreadable_mp(fbn->netdev, rxq_idx)) {
>>  		pp_params.order =3D get_order(rx_page_size);
>>  		pp_params.max_len =3D rx_page_size;
>>  		pp_params.flags |=3D PP_FLAG_ALLOW_UNREADABLE_NETMEM;
>>  		pp_params.dma_dir =3D DMA_FROM_DEVICE;
>>=20=20
>> +		pp =3D page_pool_create(&pp_params);
>> +		if (IS_ERR(pp))
>> +			goto err_destroy_sub0;
>> +	} else if (xsk && !xsk_pool_uses_sg(xsk)) {
>> +		pp_params.flags &=3D ~PP_FLAG_MEM_PROVIDER;
>> +		pp_params.rx_roles =3D 0;
>> +		pp_params.max_len =3D PAGE_SIZE;
>> +		rx_page_size =3D PAGE_SIZE;
>> +
>>  		pp =3D page_pool_create(&pp_params);
>>  		if (IS_ERR(pp))
>>  			goto err_destroy_sub0;
>
> Maybe I'm misunderstanding, but why is it necessary to create a new page =
pool for
> sub1 if !sg? All frames should be sent to sub0, and the buffers in sub1 s=
hould sit idle.

(BTW, the reply to your other mail didn't show up on lore for some
reason, but I hope you got it! If not, holler!)

You're right, it is not needed. I'll fix this in the next version. Every
frame fits in one chunk on the header ring, and the device drops bigger
frames. With SG, both rings share one pool.

I first tried sharing the pool for non-SG too. But then up to 255 chunks
sit unused in the payload ring :P


Bj=C3=B6rn
