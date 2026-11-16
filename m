Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794839491;
	b=gQpL6SdeIhD/k+xs/r1L4FKmnluUmoDUSTTYwgp4vG2m7+iPDL7RgRPwYt+TdNiAiXDX
	 hS3otz4bMqH/DYrg0gYEizPi1CTURGyS0kS6AHFeTvgO+xWaoPdxEu0oBQ7UMmrfrcB1A
	 /aiibfAqBBGJfun/Wc5YwmNo/O4Q5J0x/PArDnYnpUfWFzO4aPnDI4losQ8skgWoxJMEH
	 h+BWSNDFl27rw1wvjPhUJTF1HeY8iQMRLdFapvMe2NGUQ1MPzjxxggIE+nTLtegkjJjTv
	 zYNh3RglGBnXmivCi/0q3udNWsTdeZwABDadFxeZWy3/3DYBtXv++pR9AEoQrfv6Qdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794839491;
	h=Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=cwUM8snIbc4i6t6DwNBE5IxQmUu92baJJlXJSsLd7ds=;
	b=NPUKMbY7KofykhEAw5am+1+WuulxFZ4xqiSS+rAx8GsFXs1+EXlDcIM1F5Vc6kJAUAk5
	 OOF0jn0muC2ES1sB86MoE+JYySLb9MVYHCdJfm3UmK32OWtx7snjuNibtt9YWyHuE0dvD
	 GLagjaSOnDRBXbY/GuK6GlsUtkeIIN+I+jaCnP38D/AGQOYUftVDgK8Y7DVpOOH+/jMK8
	 MBL57K6Z1+ybIVdN+EUeQHw9pDvPOqomHQCYadYsBG2IW0tYWr/306uwmv3tb6pd9ruqQ
	 Tky2GDKxKRG/+szcx2KG3ngQwk79OLpffUvIAp9UA03hcJOej7bGwfAJanJBwuk+nVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZFbUoDJm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C879606A32C;
	Mon, 16 Nov 2026 14:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZFbUoDJm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 684ED1F000C4;
	Mon, 16 Nov 2026 14:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794839491;
	bh=cwUM8snIbc4i6t6DwNBE5IxQmUu92baJJlXJSsLd7ds=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=ZFbUoDJmVlKZ00rc5ZREhr+AOpmTQmGE2pcAgFWQIPgILTRIEPTUh34AtXNC4JCVr
	 oVpooj11+t3b0nyFgqthEaCfn5zbBE3ltl+R10tO4KWSOpwdZ1Jy2o9cGfFlFd1xXo
	 whmTeIRppL/op8Ovo0kSiI1Zgv+1HEl5DTSvF5osugJLLMS7T1TSvFkzk2rD6QEFwQ
	 CCf/D06xce9KLqD+GJIHJ3F4qu68WTQNZLJNcae3P+UWDT1To/IwRPZp7bLBQNY+ha
	 8i9xauMLmAhxz4uffiomh4S4oH+lc5eq1S1hVKey1PPFggSXHQKDKYa9Yu8rP2eo8a
	 m2Nq4MKu/4YRw==
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
Subject: Re: [PATCH net-next v1 01/11] net: Get skb fragment addresses
 through netmem
In-Reply-To: <20261115131314.2d3ab96f@kernel.org>
References: <20261110102039.1002605-1-bjorn@kernel.org>
 <20261110102039.1002605-2-bjorn@kernel.org>
 <20261115131314.2d3ab96f@kernel.org>
Date: Mon, 16 Nov 2026 15:31:27 +0100
Message-ID: <87wlqcg85c.fsf@all.your.base.are.belong.to.us>
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

> On Tue, 10 Nov 2026 11:20:22 +0100 Bj=C3=B6rn T=C3=B6pel wrote:
>> skb_frag_address() goes through struct page, so a net_iov never has an
>> address. Only unreadable memory should lack one: XDP and BPF read
>> fragments through this helper, and AF_XDP UMEM will back readable
>> net_iovs. netmem_address() also returns NULL, not a bogus pointer, for
>> an unmapped highmem page.
>>=20
>> Generic code needs the size of a net_iov to find its address, so keep
>> it in struct net_iov_area instead of the devmem binding.
>
> IIRC netmem is supposed to be used for frags and memory CPU never needs
> to access.

netmem covers pages too, and netmem.rst already allows readable net_iovs
("Decouple net_iov from unreadability"); the in-tree ones just happen to
be unreadable.

> This patch looks odd. I haven't read the rest of the series yet but at
> the very least commit message should explain why this aberration is
> needed / correct.

I'll expand the wording in the commit message.
