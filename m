Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794768726;
	b=NXVsAl7r3sZX2EjYc/qH2G5tnpg2W3pJql8V05IZBnOm5ZeBCwPd4YvGWNIqBm4ClhRL
	 e3InZbYUwZIgifGQ1CbNUO5h8t9JLrTFwQh9FwOyLvTxlA0X0U4g5QoTNFqNfFuGIcqZ1
	 0oAqwfHrWZe3B9WaYkYBVAf7XSMHoa0vKAPa2s0eU0hLd9VXvvtLcQDiLpqGZIxxLhuFm
	 sittHRpyUsQEG7js9xbzpRfKKUSqQclo1udWOnkaj4IDh2/rJ2dLQYtYTIqhtVL+DjA3t
	 PJ/GE9BXZuT71HOGMfN7dXm7vIipu7FvqxiqZsbQec6gSDTS9vxrtrPFofqQhnm7GzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794768726;
	h=Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=SdudER1+z7QJDiZ1Nnh2ZbZ2E80axq39/K+Tsu5UA/w=;
	b=wLfRl8I7bgWf/d4cB/GdGcHCJdGtgBhH0P3dQVbCAH9LUlfvLO/pZcIosQ7J8yvKRCB8
	 vWJ2o/gW0vpO5RRRjgUnWd5DTmPv0jJ4hlT4uUHnYB0QGmeCL2/wbqgVpo50zXHD5q3+S
	 Rp31DKslsa0WgoLz8twGGSYtxY42i2aWUQnq33urjw+kvfBmrLYBBWGsQZKc4KQ8i19C/
	 CVkcZ3tSRxyceF0NxWlwZVnHwEzNhMbG8rlyAYyNEwvGiVu+0Wgt19v4a4v7Q4/EbRyoU
	 Re+t/1qpxCo0z+csJC1qsB8M1IaOG191OCXb6UGyV2QrhAHqOs8inGhw85Tsjr5OyzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Yi4oaMcO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45979606A31D;
	Sun, 15 Nov 2026 18:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Yi4oaMcO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 940D41F000C4;
	Sun, 15 Nov 2026 18:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794768725;
	bh=SdudER1+z7QJDiZ1Nnh2ZbZ2E80axq39/K+Tsu5UA/w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=Yi4oaMcOGX2qt7K6xqQ1ukn3u3IMrRR9Vyw5Msfzk3hAI8l8HV/yfhWxljmFTkgXe
	 QewrDoa47Q8taP+G8Cw5AWN7uDgarEMA0qA82uQHDKhScIKK1ZpA9Crlfy9f9AjtEx
	 uRXn46e/XmiB/CTeO2qOXT6V+0x9UtPa4PY8kRz5EgO2XXdYO0fs55Tbo7W8EZm9MK
	 7216YnY0EOU37M4AYq7EdEuJSOX6jJHDJeDBZCDQoyFxLtvcnNdLTYNeohvpNzPjwq
	 7EgC17gY/t/VY3BRoZCfyJ2sTgIAmko21KncSHOQ3pB1WvZb2IhxIkg3rBUwW1lTMt
	 D5JoYQJimN3QQ==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Mina Almasry <almasrymina@google.com>
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
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Stuart Clark
 <stuclar@meta.com>
Subject: Re: [PATCH net-next v1 03/11] xdp: Copy buffers with restricted
 lifetime
In-Reply-To: <CAHS8izMhFEMu+v4zAm6VqjU=Lz=vMn58Ft6HKya1L-uNY0hL-A@mail.gmail.com>
References: <20261110102039.1002605-1-bjorn@kernel.org>
 <20261110102039.1002605-4-bjorn@kernel.org>
 <CAHS8izMhFEMu+v4zAm6VqjU=Lz=vMn58Ft6HKya1L-uNY0hL-A@mail.gmail.com>
Date: Sun, 15 Nov 2026 19:52:01 +0100
Message-ID: <874idij5bi.fsf@all.your.base.are.belong.to.us>
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

Mina Almasry <almasrymina@google.com> writes:

> On Tue, Nov 10, 2026 at 2:21=E2=80=AFAM Bj=C3=B6rn T=C3=B6pel <bjorn@kern=
el.org> wrote:
>>
>> UMEM stays mapped writable in userspace, and it has a fixed number of
>> chunks. The stack must not keep its chunks in an skb or an xdp_frame.
>> Mark the providers whose buffers the stack may keep with
>> MP_CAP_RETAIN, and copy packets of the others on XDP_PASS, on
>> conversion to a frame, and on redirects other than XSKMAP.
>>
>
> I'm not understanding why that needs special handling. Devmem stays
> mapped and writeable and did not need MP_CAP_RETAIN. Also, today the
> stack can keep any pp page in the socket's receive queue for arbitrary
> time without _RETAIN. I'm espcially confused you're not adding _RETAIN
> as a cap to existing providers, but their netmems can be retained.

This patch does give devmem and io_uring zcrx MP_CAP_RETAIN, and pages
need nothing... a pool without a provider is retainable. Only UMEM
isn't.

The stack never reads devmem or io_uring zcrx payloads, so it doesn't
matter that userspace can write them. UMEM is readable, and the stack
would parse headers and payload that the application can change under
it. An AF_XDP socket also has a fixed set of chunks, and chunks held in
skbs elsewhere starve it. Driver zero copy copies on XDP_PASS for the
same reasons, in xdp_build_skb_from_zc(); this does the same for
provider buffers.

>> The head chunk is writable by userspace, so it cannot hold
>> skb_shared_info, and virt_to_netmem() cannot find a net_iov head.
>> Drivers pass kernel memory for both to xdp_init_buff_netmem().
>>
>> A static key keeps the check off while no such page pool exists. A
>> frame copy is linear, so a multi-buffer packet of such a provider
>> cannot go to a device or CPU map.
>>
>
> Did this actually improve perf? I recall that when I benchmarked the
> performance improvement, it was questionable.

I have no numbers for it, and it goes in v2. With the frag walk gone, as
agreed with Stan, the only check left under the key is for page heads,
and no provider hands out pages.


Bj=C3=B6rn
