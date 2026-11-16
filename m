Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794838863;
	b=IbCNaqdJOU07zbAZb8Opk3vFkA5dVe5zC8MFLIaGQFMmyJO3XVO4Q8NvB+jKKZNUiaVr
	 ET2GUnnbfgaAFGHcCmLZXjO/JKXcJRCigWpYmZIWtMEFBC2Q/ki/J3hLvGz9uDtObGLB0
	 GIWnhLOCAaFyDxhiGxwwz/ZQIVRtCxmIaVObG1AAM+5eI58snhy0xeaVpZ+uCToBJPPa8
	 a9tQjUl93kQSHsNyxsx7+vGtAp0s6Oku6p4z8D2Nu+khQjVYz6O/eBhg/uzrB04BambFl
	 TlBuY4UEkit4lvK8rtMMrk6GWTb/1tLa/DSY3p9+02mvgV/0+KRsaBXOebwEDXKFNrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794838863;
	h=Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=p0MCEiScXA3/AegZMZrPbSW4djcYCJen36hSgSOSxr8=;
	b=X7+eyVHJ7Qzo7PbJm3hhjsd5LcQf6N7iF1wN27Am2zkPoU+mXJMgaS8GXnxVOoZPVu1j
	 NpGtI2idzwwFX0X4zqkfq3RyUiy4Zi+obksfaofHS49EVkoKj1g90aic73QYnar2CFqXm
	 pFgQ/YmqW7xiF2wgME6Ves3JRd0oMPB5GNUOq/pEax6hXVa9nJLP8/NjbwLPGisKvXcIN
	 97bYhK12AeKGWqHcyirSNbQ+th3B+njMCSYvfzPwXea0tWSXdwtzqN5rJ5dTIHp0d2zFO
	 w9SQ4/WbkdBH5AtpbGMckTLG1/nMX8GaqEIKeAHK/ziGfKDGfXRZGV4AuWmKyEWMPBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lrMNwZMp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CBDE606A329;
	Mon, 16 Nov 2026 14:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lrMNwZMp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64E1A1F000C4;
	Mon, 16 Nov 2026 14:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794838863;
	bh=p0MCEiScXA3/AegZMZrPbSW4djcYCJen36hSgSOSxr8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=lrMNwZMpVLaC2BtfAP4b7LZ6QFc4IZAk8smXnST30fiArFsHMpDO8pHkIB6Cr8ys+
	 ee+JRnmqA68sVX265zPLaNHnOzcJcKLeRl4boeqkIBPd85eN10aGzC0MJ8/2iRTaPX
	 C4js2OW0HI4bnxI5yEVoRrrSVD0MczuQ7+8+Ai3AUOVruZhi0h6yiLoBUlpAnHrgPX
	 XjK/UDNqOIoRJDvbfzRZ9VG2IFMtNBWl0HmfcnKl7yIiBlpo873jNkEGXJhENBI0CR
	 gS+aiwQEoBnOez7Qp2dCZTZnUqIJu9WGirp6rXpJ171+S+xd5+BuR5lK65ivivJEec
	 IBwEluMMFSqZA==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Magnus Karlsson <magnus.karlsson@intel.com>, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>, Stanislav Fomichev <sdf@fomichev.me>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>,
 Alexander Duyck <alexanderduyck@fb.com>, kernel-team@meta.com, Andrew Lunn
 <andrew+netdev@lunn.ch>, Jesper Dangaard Brouer <hawk@kernel.org>, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, John Fastabend
 <john.fastabend@gmail.com>, Pavel Begunkov <asml.silence@gmail.com>, Jens
 Axboe <axboe@kernel.dk>, Andrii Nakryiko <andrii@kernel.org>, Eduard
 Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil
 Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>,
 netdev@vger.kernel.org, bpf@vger.kernel.org, io-uring@vger.kernel.org,
 Mina
 Almasry <almasrymina@google.com>, "Mike Marciniszyn (Meta)"
 <mike.marciniszyn@gmail.com>, Weiming Shi <bestswngs@gmail.com>, Nikolay
 Aleksandrov <razor@blackwall.org>, David Wei <dw@davidwei.uk>, Alexander
 Lobakin <aleksander.lobakin@intel.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Stuart Clark <stuclar@meta.com>
Subject: Re: [PATCH net-next v1 02/11] net: Add memory provider capabilities
In-Reply-To: <20261115131840.55b03578@kernel.org>
References: <20261110102039.1002605-1-bjorn@kernel.org>
 <20261110102039.1002605-3-bjorn@kernel.org>
 <20261115131840.55b03578@kernel.org>
Date: Mon, 16 Nov 2026 15:20:59 +0100
Message-ID: <871p8khn78.fsf@all.your.base.are.belong.to.us>
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

Jakub Kicinski <kuba@kernel.org> writes:

> On Tue, 10 Nov 2026 11:20:23 +0100 Bj=C3=B6rn T=C3=B6pel wrote:
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
>
> Being readable is the normal state for memory.
> We should be marking mps as unreadable, not as readable?

Fair, I'll flip it. devmem and io_uring zcrx mark themselves unreadable.
The same goes for the other two caps; page memory can be split and kept,
so AF_XDP marks that its buffers can't be.

>> @@ -1070,6 +1095,9 @@ netmem_ref page_pool_alloc_frag_netmem(struct page=
_pool *pool,
>>  	unsigned int max_size =3D PAGE_SIZE << pool->p.order;
>>  	netmem_ref netmem =3D pool->frag_page;
>>=20=20
>> +	if (static_branch_unlikely(&page_pool_mem_providers) &&
>> +	    WARN_ON_ONCE(!page_pool_supports_frag(pool)))
>> +		return 0;
>
> Shouldn't we return a full page if we can't frag?
> Fragmentation breaks up a page into smaller units,
> it should be legal to simply return a full page if
> fragmentation is not supported for the provider.

Yeah, make sense. I'll return the whole buffer at offset 0, instead of
the WARN Stan and I settled on, and page_pool_alloc_netmem() reports the
chunk size for callers that need it for truesize.


Bj=C3=B6rn
