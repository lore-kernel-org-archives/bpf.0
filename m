Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794935215;
	b=cNy6dqcKPXcRwJ24yByTtVv9qRcrTlX1/XdG2Z/ZmeJoo6kX+ycbUrFYQJOB/2QhNaVe
	 CrYr1ERYoGEYbHQzC/z0upv2OzdmwaLjqFZWaDb9e9CBpJXtjAQuDYoOnK+TlkSYxodWC
	 jVjURMLJJFE+R53iMcqQbV/OecfdoULv45cu0LOHezgOq/0yZk0ppqoelp98I8ro+cP6u
	 4Va/eoRKRS/8Z0NyLFYeJ11HfLUtqv+ceDl2Z3jvPI4mXZ0bGOWoJSN8oa8/zD0w2ewge
	 xSlxds3fiBlFkvkIpcJaDPmYtkzdZFzPc0HzkFGjE5XUEVCw32OdI44toHk4Me2mKGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794935215;
	h=Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=3x+0jlSrgAaHaiAOabPc8qLStc9/QqPozrpSv+XIEh0=;
	b=XwK5V1e/sJXQUP5Mj6pxTxr5EuBlikX90BHtBL+1n31ioUwXuamwQGMSJJQrIia2rBuY
	 szdohztqufBPDaVfR0vId1pQ7Q6aVBLrEJtF3ljI4RM8NyFU2W1884FE8963RhPsy2jm7
	 SDKORORQ1EUzNeqPuribsa5nbbYzNAg7wLbCK8ImWBh22K1wHETDbr+joUkkjwUr62Kx4
	 S5Bp+ofxBAzD1G7UhkzTcISIz9wAA/Z0yl5sYf5YGfAUv1dafiK3eE7H4MP4FsOpRUqKS
	 XTR9pWRgqz3GAoVzbzW3eGgdmVTM0oSFk9cCNNBLSum1FNTbYt9UeSEn71QprO0dv6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P1CFB4aJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC16606A880;
	Tue, 17 Nov 2026 17:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P1CFB4aJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1EC61F000C5;
	Tue, 17 Nov 2026 17:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794935215;
	bh=3x+0jlSrgAaHaiAOabPc8qLStc9/QqPozrpSv+XIEh0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=P1CFB4aJGuX0QRQ3pAADWjoP02+tKboFVQQ03fUP+1g3874UOV1Dpkehu7J0kv3oZ
	 QESyyaeevXRFo87s6sdstC4TY8S1xeMtU0fa3VEfzwsqQ43p9h5dIVADe6sONUAV+D
	 Odc7FepYb4Jam0Ha00wlGoNW/2eFNfFc+CW2RXzqFOYWD8rYbjeKAlcUREHZLjA9P3
	 de01no0XzXMKJk2hhYrjl0X0QGgOjofLHCB2NFjoWIUV9VtD9ZU1gI35uwSG+SowfV
	 fg+GSWh5zVKjOXRZ1TnttX8oiib8kdCqMZBDLmKEXaP366RKvOcSjN+SZEEKD/xkGo
	 ++lP1oIISjMnQ==
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
Subject: Re: [PATCH net-next v1 02/11] net: Add memory provider capabilities
In-Reply-To: <CAHS8izNVDU8+JzeuwDBmF24C-XqkO+ox01qnTvK665Y8pyWNLA@mail.gmail.com>
References: <20261110102039.1002605-1-bjorn@kernel.org>
 <20261110102039.1002605-3-bjorn@kernel.org>
 <CAHS8izMaAv6gX1NeJR+QCf43CL+DC4DgePRNNxSLoE31jxHU0g@mail.gmail.com>
 <87fqx2j5jx.fsf@all.your.base.are.belong.to.us>
 <CAHS8izNVDU8+JzeuwDBmF24C-XqkO+ox01qnTvK665Y8pyWNLA@mail.gmail.com>
Date: Tue, 17 Nov 2026 18:06:52 +0100
Message-ID: <87zev71j6b.fsf@all.your.base.are.belong.to.us>
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

> On Sun, Nov 15, 2026 at 10:47=E2=80=AFAM Bj=C3=B6rn T=C3=B6pel <bjorn@ker=
nel.org> wrote:
>>
>> Mina Almasry <almasrymina@google.com> writes:
>>
>> > On Tue, Nov 10, 2026 at 2:21=E2=80=AFAM Bj=C3=B6rn T=C3=B6pel <bjorn@k=
ernel.org> wrote:
>> >>
>> >> The core treats every memory provider as unreadable: installing one
>> >> needs header split and no XDP program, and any page pool that allows
>> >> unreadable netmem takes it. An AF_XDP UMEM provider is readable, needs
>> >> XDP, and hands out whole buffers.
>> >>
>> >> Describe providers by MP_CAP_READABLE and MP_CAP_FRAG; devmem and
>> >> io_uring keep their behavior with MP_CAP_FRAG. A page pool takes a
>> >> readable provider only with the new PP_FLAG_MEM_PROVIDER:
>> >
>> > Why do we need this? I thought whatever creates the pool actually
>> > shouldn't get to pick whether the pool picks up the memory provider. I
>> > thought if core has configured the rxq for a memory provider then the
>> > pool is forced to take it.
>>
>> Thanks for looking at series, Mina. ...this needed some thinking.
>>
>> It isn't forced today either: only pools with
>> PP_FLAG_ALLOW_UNREADABLE_NETMEM take the queue's provider. Drivers set
>> it on the pool that holds payloads, and keep headers in host memory: in
>> a separate pool (fbnic, bnxt), or outside the page pool (gve, mlx5).
>> That works because every provider so far backs payloads only.
>>
>> UMEM doesn't. The socket gets whole packets, so UMEM has to back the
>> header buffers, and with multi-buffer the payloads too. The flag was my
>> way to get it there, but you're right that it's the wrong knob: it lets
>> the driver opt in, where it should only say what each pool holds.
>>
>> How about this instead. Both sides use the rx_roles bits from patch 5,
>> HEAD and PAYLOAD:
>>
>>  - The provider says which buffers it backs, next to rx_page_size in
>>    pp_memory_provider_params: devmem and io_uring zcrx PAYLOAD, AF_XDP
>>    HEAD, or HEAD|PAYLOAD with multi-buffer.
>>  - The driver says what each pool holds, in rx_roles. A pool without
>>    roles but with PP_FLAG_ALLOW_UNREADABLE_NETMEM holds PAYLOAD, so
>>    existing drivers don't change.
>>  - page_pool_create() gives the provider to a pool whose roles are all
>>    backed; the others get host pages. No opt-in.
>>  - After ndo_queue_mem_alloc(), the core checks that the new pools that
>>    took the provider cover everything it backs, or fails the restart.
>>
>> With fbnic's header and payload pools:
>>
>>   devmem:                header pool host, payload pool devmem
>>   AF_XDP single-buffer:  header pool UMEM, payload pool host
>>   AF_XDP multi-buffer:   one shared pool, UMEM
>>
>> A shared pool on a devmem queue doesn't take devmem, since devmem
>> doesn't back HEAD, so the check fails and the driver has to split.
>> That's the "headers in host memory" rule, without the driver asking
>> which provider it is.
>>
>> Wdyt?
>>
>
> Hmm, I think maybe the exsiting knobs PP_FLAG_ALLOW_UNREADABLE +
> CAP_READABLE covers your needs.
>
> The pp says whether the memory it provides is readable or not via
> CAP_READABLE (or !CAP_UNREADABLE).
>
> The driver says whether it will allow unreadable memory for this pool.
> For header pools, it doesn't specfiy PP_FLAG_ALLOW_UNREADABLE and for
> paylaod pools it specifies ALLOW_UNREADABLE.
>
> The change I think you need to make is: today we disallow any
> providers if the caller did not specify ALLOW_UNREADABLE (because we
> assume mp's are unreadable). After your series we only need to
> disallow memory providers if the mp is unreadable and the caller said
> it's not fine with unreadable.

I'm all in on making v1 simpler -- I'll try this path! So, an unreadable
provider still goes only to pools that set ALLOW_UNREADABLE. A readable
provider goes to all RX pools of the queue. The roles and
PP_FLAG_MEM_PROVIDER are gone.

One addition: a driver must opt in with a readable_mp flag in its
queue ops. Without it, its pools don't look for a provider. The reason
is that today only ALLOW_UNREADABLE pools must set queue_idx and be
created under the instance lock. Other pools may not, so they could
pick up the wrong queue's provider. Maybe there's a better way?

Thanks!


Bj=C3=B6rn
