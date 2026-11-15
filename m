Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794768958;
	b=RZF0E5v9qm8ounCxvA81egqNhBJGE1Ti+9g8THK7NMsn8lx228rjHeJfPTKmO7S7sJhl
	 gpwsRY2b6mXwtXCCtcfO5xipKA0Dhe+UjjRytpTrhnbjGsqQ84YckuWyPI2/UAWmgGzVE
	 lAWrRbE6DxMR50SthjMXN1/jiY8SnL4IwEm+Ui12LKkjHIv7p0rupjSQYBeyk0DPDOXN9
	 Bey/16ho+oYmiXn1tdQcMJGZ7HpIWvZ22H5meBc+Yg1XYY94rEWbSSo3BW4fHB8L3HhEb
	 90ojNhEvPYvKN1c6yJzXCvLNv3/xjLArreMtk8SFykSohPeNluf4JxXx7PQlJHzrGcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794768958;
	h=Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=zyXslw9VshoP0Dt+hSCQbWwSxcGhI3BWVVf2b5NPS+g=;
	b=rZIx8Pu9Q/WhfPRyoVyEYOhdAqD3qjPWL9++ZH0kvqNX3YcVFcO44Yk9gDmhgKVGc58Q
	 qWkVAgbTNU3Nmlkz9LdqMepRNOMD1iaLk1oXlX9QZH6V+k+ocVF7GswY5rEcaHRlNzKce
	 WLjyvA3dxLOieqq7Qu5fz7iG2/scKiPG//2I/gLb5De1k+uAevaVPN/7w6uAiUqLS5W/l
	 WEbjiSjfg/7ycqRm1tTSH7kxzuXjoOze30agluEpiF1Xh+MyGuOZYQP2bNBNOwO5FXc4/
	 tbhvQBjkasKE0nn7FLci4ll6o0Rv0oikux9W0SN2j7LdqHx5jDJf6E1SGrYvV5SWQ/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fJ+vqeSl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6CB606A31A;
	Sun, 15 Nov 2026 18:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fJ+vqeSl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 708D61F000C4;
	Sun, 15 Nov 2026 18:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794768958;
	bh=zyXslw9VshoP0Dt+hSCQbWwSxcGhI3BWVVf2b5NPS+g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=fJ+vqeSlkhrBkQxZvX/Lxn09eGioyBRenoJ34ugy0G+/njudzKIqL/wqu8vvvN9Av
	 Jthdkut6dozLF5eLQTi2o2XbpLRc3OxrGEmBjqULmZMZk9e6GmM8UKPLHSMLEUEZQT
	 18HtuzmhqbbbQrmhlKYbMhJfsTq3uhIx5ksae9Pq8bV1XrdIYQ/SZLPWm7Xt9qpJZ0
	 I4CneqOuGhjFbRvGp2R8sdnWt/M3tDLeZxVodVojrTQGH+kuBLdV45r0FrhKUsurHH
	 lK7XnIRt9FalYffxGd54cxd2GVXt6aGE4iofQnOOsTxD/s4lJEftWdxkVb1dYXMUS/
	 GgAm86xzyWIiA==
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
In-Reply-To: <CAHS8izNC9APadHg9yPtROkii1H7TPMAB7Xhxo+y9Cx-XCw9C1Q@mail.gmail.com>
References: <20261110102039.1002605-1-bjorn@kernel.org>
 <20261110102039.1002605-5-bjorn@kernel.org>
 <CAHS8izNC9APadHg9yPtROkii1H7TPMAB7Xhxo+y9Cx-XCw9C1Q@mail.gmail.com>
Date: Sun, 15 Nov 2026 19:55:55 +0100
Message-ID: <87v75xj550.fsf@all.your.base.are.belong.to.us>
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

>> diff --git a/include/net/xdp.h b/include/net/xdp.h
>> index 1105bb9e3292..5ab7802ac4e1 100644
>> --- a/include/net/xdp.h
>> +++ b/include/net/xdp.h
>> @@ -368,7 +368,7 @@ static inline bool xdp_buff_add_frag(struct xdp_buff=
 *xdp, netmem_ref netmem,
>>
>>         if (unlikely(netmem_is_pfmemalloc(netmem)))
>>                 xdp_buff_set_frag_pfmemalloc(xdp);
>> -       if (unlikely(netmem_is_net_iov(netmem)))
>> +       if (unlikely(netmem_is_net_iov(netmem) && !netmem_address(netmem=
)))
>>                 xdp_buff_set_frag_unreadable(xdp);
>>
>
>
> netmem_is_net_iov() check became redundant.

Hmm, not quite... netmem_address() is also NULL for a highmem page
without a mapping, and the stack reads those through kmap, so they
aren't unreadable. The net_iov test keeps them out. I'll add a comment.

>> diff --git a/net/xdp/xsk_pp.c b/net/xdp/xsk_pp.c
>> new file mode 100644
>> index 000000000000..fdd55265a6cd
>> --- /dev/null
>> +++ b/net/xdp/xsk_pp.c
>> @@ -0,0 +1,246 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/* AF_XDP UMEM as a page pool memory provider
>> + *
>> + * Each aligned UMEM chunk is a readable net_iov with one owner at a ti=
me:
>> + *
>> + *   userspace --FILL--> page pool --release--> reuse --alloc--> page p=
ool
>> + *       ^                   |
>> + *       +-----RX ring-------+
>> + */
>> +
>> +#include <net/page_pool/helpers.h>
>> +#include <net/page_pool/memory_provider.h>
>> +#include <net/xdp_sock_drv.h>
>> +
>> +#include "xsk.h"
>> +#include "xsk_queue.h"
>> +
>> +enum xsk_pp_chunk {
>> +       XSK_PP_USER,    /* owned by userspace */
>> +       XSK_PP_POOL,    /* owned by a page pool */
>> +       XSK_PP_REUSE,   /* on the reuse stack */
>> +};
>
> maybe should be xsk_mp_chunk.
>
> But also, why is this 3? Usually the mp's track allocated and free. I
> assume PP_REUSE is actually free, but I'm curious why it matters to
> your mp whether the pool or the userspace holds the memory (or whether
> the net stack holds it. Can't it hold it?)

REUSE is free, yes. USER and POOL are both allocated, but userspace
gives chunks back by writing addresses to FILL, and it can write any
address, also one of a chunk the kernel still owns. Taking that entry
would hand the device the same chunk twice. So the provider only takes
FILL entries for chunks in USER, and drops the rest. io_uring zcrx
checks the same with user_refs, and devmem with the socket's token
xarray.

The stack can't hold a chunk, see my reply on patch 3.

>> +
>> +struct xsk_pp {
>
> maybe xsk_mp? this is a memory provider right?

Yes, I'll rename it to xsk_mp, the enum too.

Bj=C3=B6rn
