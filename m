Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795371173;
	b=MVq3y8PWyHhfmk4uYk4jHtE3rej7W4c5lmFeN3tEukIIncvCeAP65UoUCuwZViWfIPYY
	 6UyIKY34hw6/6P4BJ7zE4itfTAiJqLUqyRVpFxl0oeC7bi1Yh0nXmm26mArbrgUaIXVZG
	 oRZzozzqSttts2wvIz+RJ3ViKUHApEKKvN0WczQzb3/gJGcTvqyVdlrc1hJs26wAYjKYC
	 LF+HgMTHaXHK+MvphspfIoPbxqUycARe+XBjh/tDni7hfjiXg9PqKuuQkay8U8rJlpolp
	 Y4GQqoXJVFP900DMKzbwssPb5aSx9ozPy0+b9vd1b257z7jt59Cg/PNzs6QhHPKC5/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795371173;
	h=Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Mo3kjI8Xpm7/wjLGyOU2Dz1FSRwjRmlKgOXYc5So1Wo=;
	b=kHlJxd9Td+qnz48sxP3+6Sq0KQ0AhKBsYMoIln9uIW3EGXdVsRrr5mJUwntO7fSNXp++
	 z6Vg2ABj0Ue0A3hR8bahx8MV8Bit7CQBU/aFFrUxji2ms6b/TiRHzUzx33mpVA26HIA+D
	 tk1sg8SlEr22AeQyLP5S0mfp0tezXfbwk9b8vHRFP5EuLyFgDUmO3npuxh+mlOKY30Mcb
	 yu+3cCZ1gcGYESGYogetEfsFdVNK87iyh8l/i31W51W5dl4Lm3/u/99Vwbev7vMzfO2cC
	 pRvAZznQDW8kf4pDF+qkPm+WQ7YsPHxDi2DsYByT9NpVQiB8IZbhwq4XwdL/TPDgz4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CRXAsa7W;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9563F606A32C;
	Sun, 22 Nov 2026 18:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CRXAsa7W
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 496DE1F000E0;
	Sun, 22 Nov 2026 18:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795371173;
	bh=Mo3kjI8Xpm7/wjLGyOU2Dz1FSRwjRmlKgOXYc5So1Wo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=CRXAsa7WDcnr2ID5hW3MaNS8IBlTnwVXVJ8jXES1HeAZTZ3owWi7Jn6LnQROmNfCX
	 Hi8rA/SLh+CHxEvOsm02vz7ws7HW6NjN7P+tmWSxuvjwiAp4kC4c/V8sgDRu5afefE
	 FRdxn02SK7LycBgR4LtKd3nmhJX9Ax9nSonYf8Y9R4CQxHxVyMqLkJhvJQU7x78/KY
	 Ab5BQZBvk4eMTPQXua0rXBa5nlfjtQXVNSJivVZef3T3NdY6gfAjmvKuPwd14N6daa
	 g1qQgODYl562WzAX7PIj5fdjZij/aCqtQ4FqCm7Y5Csq8408v0v8sA7ZL5+/3l/OTF
	 Sa59F0+lGszOQ==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Magnus Karlsson <magnus.karlsson@intel.com>, Maciej Fijalkowski
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
Subject: Re: [PATCH net-next v1 00/11] xsk: Zero copy through page-pool
 memory providers
In-Reply-To: <20261110102039.1002605-1-bjorn@kernel.org>
References: <20261110102039.1002605-1-bjorn@kernel.org>
Date: Sun, 22 Nov 2026 19:12:48 +0100
Message-ID: <875wxo3fbz.fsf@all.your.base.are.belong.to.us>
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

Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org> writes:

> Hi!
>
> AF_XDP zero copy needs a second RX allocator in every driver. This
> series makes UMEM a page-pool memory provider instead: a page_pool
> driver opts in, and keeps its refill, recycling and DMA sync code.
> fbnic is the first user. Patches 1-7 are core, 8-11 fbnic.
>
> Since the RFC [RFC], net_iov is a first class netmem, the core owns
> AF_XDP setup, and a refill contract replaces the NAPI kicks. The fixes
> are out.

Hey,

Thanks for all the input!

TL;DR for new readers: Too much churn, especially on the driver side.
net_iov was not intended to be readable from the core side of things.

The net_iov part needs some deeper thinking. UMEM memory is readable
(the kernel can read the memory), but needs a non-page refcounting, and
benefits from the rx_buf_len (larger chunks). iouring TCP ZC frags are
also readable, and the kernel does read from it from time to time, but
it still unreadable. I have some ideas how to fit UMEM to the puzzle.
:-)

I'm working on a v2, but it'll have a different take than this version,
to try to reduce the amount of driver churn. It'll probably be an RFC or
a brand new v1. I'll try to address all input from this design.


Cheers, and thanks all!
Bj=C3=B6rn
