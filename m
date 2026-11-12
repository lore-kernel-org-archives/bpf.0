Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794492102;
	b=MwwaQB0v/7wFtPiwP3JygMjcvD8v65VbUbNx+royAoHSEl0Zjn9bUgse+I90LW9M0G5H
	 JEJHgnlQgMv0ulgYVb0i3GvXMAkwRc/IiXQp1H0qUf++cbjVJTtf5S4U4gmjX2lpOu3BY
	 4tCXTNK1ua3GZa7iHBqGDV/sMx8CrVh3Fs10D2uVq8teoO656L1rboRQeK02zt8+u/yOc
	 OqupVtyTAEUT25pflduE/evuBvFII7DDAvccyGSRspOoSr1Ae9+Q+BBaYuvlbBee98v9j
	 yVXrQrhGlncDzfvTp0rjNOIq76apKX2PtIVDE2muMqI5pRo2NQnNDvfewb1HTHkbGSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794492102;
	h=Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=aBARur1dT4MWX+I/z1/h+o1yJLTVBc8hlb0hdIzvarw=;
	b=WderqUk3eM3++J21ZoIeHZvjxItWtwrZhtojv5qW2NdagrxZY72e1x5qYm+VXwWkTBVF
	 uFO5Bd5SpNH7FV/5JziXWspJmt9dU9yw672oy2k2Y2skIN4LER5AyT5zOUT3G0d/LXcTG
	 w0D9f9sMadPAoZSIQf0Hx5/nNRHMBOG4u2O5bfQHIUD0mCNSbpF9AJouHnFShsEpGwrYk
	 3dj71fn8KnOQde70WoOBYH12T54UTIxt4kXU8f+j58BBaVNNTbsw/VRW8+tegnZhywSQu
	 zuYvkVNRZ8qcUZZIgqyfhoiKq3FCkyq6KWA9Cr6wLYbXAV2iLRsbCPo9EeA1/UFBGpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bkJrwgFK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FECE606AEAF;
	Thu, 12 Nov 2026 14:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bkJrwgFK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 458351F00A05;
	Thu, 12 Nov 2026 14:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794492102;
	bh=aBARur1dT4MWX+I/z1/h+o1yJLTVBc8hlb0hdIzvarw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=bkJrwgFKZLz2eyZ08zR1vVS1gNY4lcsTVuOkKO5Zsi6J/MZG3VLrS6/SqAclPw5i/
	 J9lPRoFaIuh+N72gjr/E9SBEKwkvmSKGhz4ux6exFmYwWinmRza2yHg0ThFnYJLujg
	 21LXohipWNNThNQvznItQRLJldvnZFt85uHMd2TwqssMp19zdxjl/0ab65GF4n49w9
	 gMmaFhDtk4gNQqhHcU5C4vhhDqpsVNVxhfel+TEX0vK1b9aFW8pXpgxBeT13jFVfbs
	 NiKd0e1sAOAnlaqg+VAO0qh26QyBudCrQyLSo9rC9I+Pyg5mFyGfO10c5d61nOZAvy
	 XXFGc1HLfcAyw==
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
In-Reply-To: <avTy21_cSnyMdbb5@devvm16445.scu0.facebook.com>
References: <20261110102039.1002605-1-bjorn@kernel.org>
 <20261110102039.1002605-3-bjorn@kernel.org>
 <avOYe27x-AlxmyK9@devvm16445.scu0.facebook.com>
 <87mrrfa6c4.fsf@all.your.base.are.belong.to.us>
 <avTy21_cSnyMdbb5@devvm16445.scu0.facebook.com>
Date: Thu, 12 Nov 2026 15:01:38 +0100
Message-ID: <87cxsarvwd.fsf@all.your.base.are.belong.to.us>
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

> On 11/11, Bj=C3=B6rn T=C3=B6pel wrote:
>> Stanislav Fomichev <sdf.kernel@gmail.com> writes:
>> > On 11/10, Bj=C3=B6rn T=C3=B6pel wrote:

>> >> +	if (static_branch_unlikely(&page_pool_mem_providers) &&
>> >> +	    WARN_ON_ONCE(!page_pool_supports_frag(pool)))
>> >> +		return 0;
>> >>  	if (WARN_ON(size > max_size))
>> >>  		return 0;
>> >>=20=20
>> >
>> > What's the deal with that? How do we get here?
>>=20
>> Hey! Thanks for taking a look at the series!
>>=20
>> An explicit frag call on a whole-buffer provider is a driver bug: UMEM
>> chunks can be smaller than a page, and RX gives the whole chunk to
>> userspace.
>>=20
>> But page_pool_alloc_netmem() also picks frags for small requests, so a
>> valid call can warn.
>>=20
>> I think it would be better to make it return a whole buffer and its
>> actual size. The WARN stays in the frag API, before taking a new buffer?
>> Wdyt?
>
> I see.. Idk, I'd still return 0 here, but without a warn. Not sure
> we want a warn for any api misuse? Returning no netmem is gonna be enough
> to debug things? As for the calls from page_pool_alloc_netmem, I'd also
> handle it explicitly? if (size > max_size || !page_pool_supports_frag) ?
> But no strong preference, up to you, was mostly trying to understand
> what we are warning against here :-)

Yes, page_pool_alloc_netmem() gets the explicit check. Thanks!

For the frag API I'd keep a WARN_ON_ONCE, like the size check right
below it. A silent 0 looks like an empty provider: the queue just
stalls, and nothing points at the driver. With the helper fixed, only an
explicit frag call on such a pool gets there... Wdyt? I'll probably take
that route for v2.


Bj=C3=B6rn
