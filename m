Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794935709;
	b=GMh2gPGL4GY5UgojUKaKOquRO/BTc3N4KxIeJH64lLS4vkqfGqzUhvvZb5A1FwVyvyAA
	 25wkqeHtjJOk8ZgHxjPWwhndEjvGuveJA3i3P8uw7mqofVCpKJ+qibyDcTOyh/H2rH4u0
	 wjJsio42u8CHUiIcu7iFoezcvsY4t4igNCOt2ahmhAmpswMgynEQ+nVr2y5aJ/eA0AHEV
	 LJQHFDfTeeKoFT4wvCDQKv5q3f4j3oiovktJBs7HkdqcVM7KI3FwkqvgzVSJjAuk7jBvB
	 S4B1C5imJo1XUErTbItqqRph8jagMyBHXOwGUEy8YLs/s0HLrgvB7Q8LHQpdoJaRuZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794935709;
	h=Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=K+VTICfGPfWmno915+gEOYcZG0bzY28xKQVSO7l1ZyM=;
	b=AWNKVVMFEghspF4w8etZVKSS1Iu1NyGdv/4717k+shtEcycYy4w2/sCWq7pQXOMXLPMA
	 CQC703q0w30HRvY67TB+kgMa7VIMTOTLq1C6Gh9862kwXqNd2zp0f4re6gESjVcPPLiwK
	 JGXo+r2zN5oRGSH9nv+09VSzYLA5wCrhd2QUNLNO3YU5V713k0reMb62rxJw6qHGThXLV
	 C34YKaKePaYsuNiEIXzBP3Df3xJTciOTIJStJdYZrjNVlghu1wOaNGBsF17+gsyl0pRYx
	 8yqp8iS9H5ZWaZP4ycXpDuyigIVkiGPG8YpDOegsbS6kTpH9iSr8iGi9kUsmkTgPbog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hSBiVHnb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D62606A32F;
	Tue, 17 Nov 2026 17:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hSBiVHnb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E8CD1F000C5;
	Tue, 17 Nov 2026 17:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794935709;
	bh=K+VTICfGPfWmno915+gEOYcZG0bzY28xKQVSO7l1ZyM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=hSBiVHnbkID07Y7JhjxruFvVfkmcj+WfMKTIBi7VnehjQb89y9O+MhoUzHRiw5UxF
	 KuFPUXuh3uSNLAm0FYYgr8Gh8fI72EtGz8Mr5JYs4+bM5b4mUwLtqHbou2vUDITNUJ
	 GJG94VnwOUcS4fjd2StOdMThiff3SkLQRU0xFo4YuIpD0/j/cfJLMrtG2u7tw8FTvs
	 sGIFp9lY6TgCOh3SoCds9sJf+yLLCQuka3iRACu7rpD2gTS58XeQB52bHbWyfR9niJ
	 qlxPaiIyjwProxljp1x5Zba/Evs5yHMEyGUEBos3j4g1EQupBBAWAC1LEXItH2IQ5m
	 2MVMUr/7D4FkA==
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
Subject: Re: [PATCH net-next v1 04/11] xsk: Allocate UMEM chunks through
 page_pool
In-Reply-To: <CAHS8izMxaRKkSKqp3x4dLgTrzuzz5=8WMbEvq5W-oiqoL5vckg@mail.gmail.com>
References: <20261110102039.1002605-1-bjorn@kernel.org>
 <20261110102039.1002605-5-bjorn@kernel.org>
 <CAHS8izNC9APadHg9yPtROkii1H7TPMAB7Xhxo+y9Cx-XCw9C1Q@mail.gmail.com>
 <87v75xj550.fsf@all.your.base.are.belong.to.us>
 <CAHS8izMxaRKkSKqp3x4dLgTrzuzz5=8WMbEvq5W-oiqoL5vckg@mail.gmail.com>
Date: Tue, 17 Nov 2026 18:15:06 +0100
Message-ID: <87o6bn1isl.fsf@all.your.base.are.belong.to.us>
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

> On Sun, Nov 15, 2026 at 10:55=E2=80=AFAM Bj=C3=B6rn T=C3=B6pel <bjorn@ker=
nel.org> wrote:
>>
>> Mina Almasry <almasrymina@google.com> writes:
>>
>> > On Tue, Nov 10, 2026 at 2:21=E2=80=AFAM Bj=C3=B6rn T=C3=B6pel <bjorn@k=
ernel.org> wrote:
>>
>> >> diff --git a/include/net/xdp.h b/include/net/xdp.h
>> >> index 1105bb9e3292..5ab7802ac4e1 100644
>> >> --- a/include/net/xdp.h
>> >> +++ b/include/net/xdp.h
>> >> @@ -368,7 +368,7 @@ static inline bool xdp_buff_add_frag(struct xdp_b=
uff *xdp, netmem_ref netmem,
>> >>
>> >>         if (unlikely(netmem_is_pfmemalloc(netmem)))
>> >>                 xdp_buff_set_frag_pfmemalloc(xdp);
>> >> -       if (unlikely(netmem_is_net_iov(netmem)))
>> >> +       if (unlikely(netmem_is_net_iov(netmem) && !netmem_address(net=
mem)))
>> >>                 xdp_buff_set_frag_unreadable(xdp);
>> >>
>> >
>> >
>> > netmem_is_net_iov() check became redundant.
>>
>> Hmm, not quite... netmem_address() is also NULL for a highmem page
>> without a mapping, and the stack reads those through kmap, so they
>> aren't unreadable. The net_iov test keeps them out. I'll add a comment.
>>
>
>
> Oh. I missed that. There are a bunch of docs actually that explicitly
> wrongly say to use netmem_address to tell if the memory si readable.
>
> Can you, in a separate patch, add a netmem_readable() helper and
> update the docs (and if possible code places) that checked net-iov
> when they were really checks for readability? Now that you're adding
> readable net-iovs, all that assumption break right?

Uhm, yes. I'll cook a separate patch that adds netmem_readable().

>> >> diff --git a/net/xdp/xsk_pp.c b/net/xdp/xsk_pp.c
>> >> new file mode 100644
>> >> index 000000000000..fdd55265a6cd
>> >> --- /dev/null
>> >> +++ b/net/xdp/xsk_pp.c
>> >> @@ -0,0 +1,246 @@
>> >> +// SPDX-License-Identifier: GPL-2.0
>> >> +/* AF_XDP UMEM as a page pool memory provider
>> >> + *
>> >> + * Each aligned UMEM chunk is a readable net_iov with one owner at a=
 time:
>> >> + *
>> >> + *   userspace --FILL--> page pool --release--> reuse --alloc--> pag=
e pool
>> >> + *       ^                   |
>> >> + *       +-----RX ring-------+
>> >> + */
>> >> +
>> >> +#include <net/page_pool/helpers.h>
>> >> +#include <net/page_pool/memory_provider.h>
>> >> +#include <net/xdp_sock_drv.h>
>> >> +
>> >> +#include "xsk.h"
>> >> +#include "xsk_queue.h"
>> >> +
>> >> +enum xsk_pp_chunk {
>> >> +       XSK_PP_USER,    /* owned by userspace */
>> >> +       XSK_PP_POOL,    /* owned by a page pool */
>> >> +       XSK_PP_REUSE,   /* on the reuse stack */
>> >> +};
>> >
>> > maybe should be xsk_mp_chunk.
>> >
>> > But also, why is this 3? Usually the mp's track allocated and free. I
>> > assume PP_REUSE is actually free, but I'm curious why it matters to
>> > your mp whether the pool or the userspace holds the memory (or whether
>> > the net stack holds it. Can't it hold it?)
>>
>> REUSE is free, yes. USER and POOL are both allocated, but userspace
>> gives chunks back by writing addresses to FILL, and it can write any
>> address, also one of a chunk the kernel still owns. Taking that entry
>> would hand the device the same chunk twice. So the provider only takes
>> FILL entries for chunks in USER, and drops the rest. io_uring zcrx
>> checks the same with user_refs, and devmem with the socket's token
>> xarray.
>>
>
> Sounds like devmem choose to do extra-pp-refs on netmems given to
> userspace, io-uring choose to give extra user_refs for netmems given
> to userspace, and you have choosen to do something new? I need to read
> the patches more thoroughly to understand.

It is close to io_uring's scheme, but simpler. io_uring counts user refs
per buffer, because one buffer can reach userspace in several pieces,
each returned on its own, and it keeps a page pool ref while userspace
holds it. A UMEM chunk is never split, so userspace holds it at most
once, and one state per chunk replaces the counter: USER means userspace
has it, REUSE is the free list. The chunk also leaves its page pool
before userspace gets it, so no page pool ref is held meanwhile. When
userspace returns a chunk on the FILL ring, we take it only if it is in
USER state, so userspace cannot return a chunk the kernel still uses.


Bj=C3=B6rn
