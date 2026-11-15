Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794769186;
	b=S8FOPymONIQPnxP7cyE/2vm6TKl+ztTOA3WSXq7vYN/rCflt4ZWaI81xp7nsRSr0OXYI
	 cGp3u6/ru3xQRJhZ1RqaH/QP8/NAc9Bso0KdchbWTJsiUhYIasm0xy84pcOBcUFKoudcZ
	 do+W+FbBs0R36y+gy4yKONKzXhvttuk8mRcxJqYNEadK4vkyEDD7zGppsLBITzU2XreuX
	 WqFxxuWJ6uuiBtNa08Lh4eH2EzWM27nvjxbV2CGCu3jizPTcaYV3yGyyBQjHqKmuMA4R0
	 8gG3fHZO5A1rK3HK7ZE+QXzQQWs2GsJNdEcNXKxfHiHuyV2RYmFWuPcGq4rINJNbgTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794769186;
	h=Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=DuWRw0pm3e+98SOmXelKpHIJTHYXZWbeemqNai35EO8=;
	b=fIIRGXCCf+X4QRnAz6GAwGaBN21/GatY1JRKhaySzmgDj4aldMHX3+MWfcQLR+RLk2NJ
	 4LpcVI79M29cpTgdSdELX2xJdlQpofCVD2KjFNEv96JDzPXJNhACH1rX+eX+1s4JgFovq
	 eyCI6aE8mWNG/tWxYLItSzeK3sX9ZcquzCEfovdAzctY19J8u7seL7f2UbIUR/fzpq2t9
	 jvYuvc7ZsdaQrKOhed2y3S9pR2BNAl2v6YsH3/Cqs6RezwrtlpIS1FU+fv1/UoKzA0X9i
	 Rrn6i427E7SF+37or4w5mS5os+S20gscvQzWzZw0NDjGy/VpEB1Gro2vfbIL/E6N9gg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MsyhObEQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C675606A31D;
	Sun, 15 Nov 2026 18:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MsyhObEQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2123E1F000C5;
	Sun, 15 Nov 2026 18:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794769186;
	bh=DuWRw0pm3e+98SOmXelKpHIJTHYXZWbeemqNai35EO8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=MsyhObEQa4B12hLDfSbk8mlrv4CVjmCz3ZmtdmX2YYT6ni7g7/qGJWhdVdzMp+FWE
	 YJvJ3aj4/JKmM+k9dzfyypDSu91SnK606oF2vl+G1triU3BT6PE65zomazzLMnpkjx
	 amXXAQM2hWbkXav0F+pGFelvi3OUVOXyw/leAL1n1hYG20DF097d7Z1bW0IYItwrX6
	 XGuyBCyDQa9Q/Lmmo91HvfXmWqXh0KKolLCwCk/0wgli66Kxywa6gUTUk+fiVoU/Ck
	 XFJA86TebLDgveonC5DjFQHbibe6wf7xqBqR5/eJ7nGMpEy4LIr4rKsh/IJrTvFdGX
	 80fL3/Reefegw==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: Magnus Karlsson <magnus.karlsson@intel.com>, Stanislav Fomichev
 <sdf@fomichev.me>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
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
 Kartikeya
 Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song
 Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa
 <jolsa@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai
 <ihor.solodrai@linux.dev>, netdev@vger.kernel.org, bpf@vger.kernel.org,
 io-uring@vger.kernel.org, Mina Almasry <almasrymina@google.com>, "Mike
 Marciniszyn (Meta)" <mike.marciniszyn@gmail.com>, Weiming Shi
 <bestswngs@gmail.com>, Nikolay Aleksandrov <razor@blackwall.org>, David
 Wei <dw@davidwei.uk>, Alexander Lobakin <aleksander.lobakin@intel.com>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Stuart Clark
 <stuclar@meta.com>
Subject: Re: [PATCH net-next v1 11/11] eth: fbnic: Support AF_XDP page pool
 zero copy
In-Reply-To: <avc6tIIQ9uDQB4IM@boxer>
References: <20261110102039.1002605-1-bjorn@kernel.org>
 <20261110102039.1002605-12-bjorn@kernel.org> <avWk5as19fvZoEJA@boxer>
 <87wlqhq0kb.fsf@all.your.base.are.belong.to.us>
 <87jymhot7q.fsf@all.your.base.are.belong.to.us> <avc6tIIQ9uDQB4IM@boxer>
Date: Sun, 15 Nov 2026 19:59:43 +0100
Message-ID: <87ik1xj4yo.fsf@all.your.base.are.belong.to.us>
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

Maciej Fijalkowski <maciej.fijalkowski@intel.com> writes:

> On Fri, Nov 13, 2026 at 12:40:09PM +0100, Bj=C3=B6rn T=C3=B6pel wrote:
>> Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org> writes:
>>=20
>> > Maciej Fijalkowski <maciej.fijalkowski@intel.com> writes:
>> >
>> >> On Tue, Nov 10, 2026 at 11:20:32AM +0100, Bj=C3=B6rn T=C3=B6pel wrote:
>> >
>> >>> @@ -538,6 +547,13 @@ static int fbnic_bpf(struct net_device *netdev,=
 struct netdev_bpf *bpf)
>> >>>  {
>> >>>  	struct bpf_prog *prog =3D bpf->prog, *prev_prog;
>> >>>  	struct fbnic_net *fbn =3D netdev_priv(netdev);
>> >>> +	const struct xsk_rx_check *check;
>> >>> +
>> >>> +	if (bpf->command =3D=3D XDP_VALIDATE_XSK_POOL) {
>> >>
>> >> do you really need a separate command here? why not rely on existing
>> >> XDP_SETUP_XSK_POOL ?
>> >>
>> >> here it doesn't look like things being validated are something unique=
 that
>> >> you could not check during XDP_SETUP_XSK_POOL and XDP_SETUP_PROG.
>> >
>> > I'd like to keep it. XDP_SETUP_XSK_POOL means "set up driver ZC for th=
is
>> > pool": the driver maps the UMEM and restarts its queue, and the core
>> > WARNs if it didn't map. A provider driver does neither; it only says y=
es
>> > or no, before the core maps and installs anything. The same question
>> > comes up on MTU and program changes of a bound device, with the new MTU
>> > or program, which XDP_SETUP_XSK_POOL can't carry. One command keeps th=
at
>> > in one place, and v2 runs it from the core MTU path too, so a driver
>> > can't forget that case. This is only a burden for the core.
>>=20
>> Thinking more about it, maybe I can drop the callback altogether, by
>> doing what devmem, io_uring zcrx and tcp-data-split already do: the core
>> refuses a setup that can't work, instead of asking the driver.
>>=20
>> The driver only judges the chunk size and headroom, in
>> ndo_validate_qcfg, which the queue API already calls when it installs
>> the provider, with a new bit saying the buffers can't be split. A frame
>> of up to the chunk size (minus headroom), then lands in one buffer, so
>> the core checks the MTU itself, at bind and on MTU changes. And like
>> tcp-data-split, a socket bound with XDP_USE_SG needs a frags XDP
>> program: attaching a single-buffer program fails while one is bound, and
>> the bind fails while one is attached.
>>=20
>> That drops XDP_VALIDATE_XSK_POOL and struct xsk_rx_check, and fbnic's
>> MTU and program hooks with them. Not fully cooked in my head, but maybe?
>> Wdyt?
>
> Would be nice, what I meant mostly was that a single driver can't do both
> 'legacy' ZC and new-age provider based xsk at the same time, so let us
> have a single vehicle down to drivers, adjusted to both needs?

With the callback gone, a provider driver doesn't get an XSK command at
all. It sees a queue restart with the provider's parameters, the vehicle
devmem and io_uring zcrx already use, and opts in with xsk_page_pool in
its queue ops. Driver ZC keeps XDP_SETUP_XSK_POOL. So each driver has
one vehicle, and the provider's isn't XSK-specific. What's left of XSK
in a provider driver is TX, which finds the pool with xsk_rxq_pool().

Does that cover it? I'll try to get that working in v2.


Bj=C3=B6rn
