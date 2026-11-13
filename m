Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794570013;
	b=rnV2vjEVgxL185Xoieh8E6aSefHOWohSNT/vCInbCWparP+4hOObUsJvmegHQRlFvg5K
	 44w6MnZchdqlyPEGnikhoK41yHr7yxUEjUsVybMD29ktTkB4WVwfPPnPega/VlAvcRznA
	 /cHToY4gQChaP6Zef64+1WnfyWikkdmnBj1g7uGnhv700OYskPaCSnKr1d+qPKIPqZORt
	 7+LrzUfH5l5v9GlJPDlcpa4B+EP8v+eyEJQ8ibMqhftGCHt0550th9A6jxhK7WtC52hvj
	 olqhgFVG6cd0/uopctJGt4zBGdBOu7AX9AImK5aeHNAjr7D9qeTWaXJYBq4Iz7iBfsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794570013;
	h=Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Sx4I5TQr/tJnq6LolN0jCNFUVlDYTPLN9V39idqWiWI=;
	b=WX/MFLWlUyS+uTaNjAsfrX8EjIGNiy9kjvuspTY2YsgZ0Kudwh9/h8hJx0dc8K5t8I2S
	 NCHcVNIZeM/XUwpgHX93mq6kjOBcwoOILsO1lw+1qL1qyU570NUCFuqG/VW+LjGVqtc0F
	 yJnEnol8+vjXYHoGyVVBkwGacZSiIAv+ND5TR+aMjPUJIVon+D1IS7GuM09hj9hybM7iD
	 uqgD4ZoFw26ULRbH1CV+zEQHokWaFJ/JSjhKKgCVdODcrPbdUyuMugrDyrxhx73g53xMv
	 Mu29U3+mC1KXrhHVYNthsIe2x1DNpn1PveHrWm7oA5FNvt9nJvUTa0dAIvNmDO5Xgeg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kni5FwAo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19F0606A31C;
	Fri, 13 Nov 2026 11:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kni5FwAo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D7031F000C4;
	Fri, 13 Nov 2026 11:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794570013;
	bh=Sx4I5TQr/tJnq6LolN0jCNFUVlDYTPLN9V39idqWiWI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=kni5FwAouxMtDA8R93e8iSlDAJTDtGYbK21KGRib3SZb7xNDHAIlrTvOjQiLjB8re
	 Bdjgg9FwAwSnAjo7uKXMBMbGIDlt8naewDQWpT29oKYLv/bKX2tedXO0+oEpEHjOXz
	 4lEqG5kyTCVZXX8hC/HoqW6sF7e6gsamUhceqMNwPlJp6SGxvLnmS1I9cupMdAHCMd
	 ymUC5jPHh+XJSEXKtvm+DyABf8fX5S4WK49awYlV6S0979oDIBQGQ3YKMcxGIywy96
	 aGvXenv3zP7estPpkfzpogmvvux9Nt+iQk+zyF8vn/RDWyi2hW4NvoslCL7FUWl1Xy
	 b5PM0oyvsnyDg==
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
In-Reply-To: <87wlqhq0kb.fsf@all.your.base.are.belong.to.us>
References: <20261110102039.1002605-1-bjorn@kernel.org>
 <20261110102039.1002605-12-bjorn@kernel.org> <avWk5as19fvZoEJA@boxer>
 <87wlqhq0kb.fsf@all.your.base.are.belong.to.us>
Date: Fri, 13 Nov 2026 12:40:09 +0100
Message-ID: <87jymhot7q.fsf@all.your.base.are.belong.to.us>
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

> Maciej Fijalkowski <maciej.fijalkowski@intel.com> writes:
>
>> On Tue, Nov 10, 2026 at 11:20:32AM +0100, Bj=C3=B6rn T=C3=B6pel wrote:
>
>>> @@ -538,6 +547,13 @@ static int fbnic_bpf(struct net_device *netdev, st=
ruct netdev_bpf *bpf)
>>>  {
>>>  	struct bpf_prog *prog =3D bpf->prog, *prev_prog;
>>>  	struct fbnic_net *fbn =3D netdev_priv(netdev);
>>> +	const struct xsk_rx_check *check;
>>> +
>>> +	if (bpf->command =3D=3D XDP_VALIDATE_XSK_POOL) {
>>
>> do you really need a separate command here? why not rely on existing
>> XDP_SETUP_XSK_POOL ?
>>
>> here it doesn't look like things being validated are something unique th=
at
>> you could not check during XDP_SETUP_XSK_POOL and XDP_SETUP_PROG.
>
> I'd like to keep it. XDP_SETUP_XSK_POOL means "set up driver ZC for this
> pool": the driver maps the UMEM and restarts its queue, and the core
> WARNs if it didn't map. A provider driver does neither; it only says yes
> or no, before the core maps and installs anything. The same question
> comes up on MTU and program changes of a bound device, with the new MTU
> or program, which XDP_SETUP_XSK_POOL can't carry. One command keeps that
> in one place, and v2 runs it from the core MTU path too, so a driver
> can't forget that case. This is only a burden for the core.

Thinking more about it, maybe I can drop the callback altogether, by
doing what devmem, io_uring zcrx and tcp-data-split already do: the core
refuses a setup that can't work, instead of asking the driver.

The driver only judges the chunk size and headroom, in
ndo_validate_qcfg, which the queue API already calls when it installs
the provider, with a new bit saying the buffers can't be split. A frame
of up to the chunk size (minus headroom), then lands in one buffer, so
the core checks the MTU itself, at bind and on MTU changes. And like
tcp-data-split, a socket bound with XDP_USE_SG needs a frags XDP
program: attaching a single-buffer program fails while one is bound, and
the bind fails while one is attached.

That drops XDP_VALIDATE_XSK_POOL and struct xsk_rx_check, and fbnic's
MTU and program hooks with them. Not fully cooked in my head, but maybe?
Wdyt?


Bj=C3=B6rn
