Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794513832;
	b=iqn3qs2yNwFjIXP8ocezaozZY63Db8QoGkoZxSyw3o4FYi2aEipI/Y9Auisn3f9L2pDF
	 L+Ygd80gMVKzf2yCTHLw2n5fwuHczhln0nvuGG3E2rr1Ki2Htkef/CmQSomSvlNtXYrNA
	 nOS/Vk2jnv3C1Lielvpv45mJVY9SmhYy1ZWLlq3bDqpqNysp10VjeIFzC0yVVLKXg5t5N
	 HCldfVA2bbgWnBFhTy6Qw4NZ3zzbzLrdIMZT3JuTpBs3Xe2gxcjHg3c0pVi9tx9Dy0KqQ
	 bwlgsNSM32rEXEzz8BtDJ7PRb+HonK5a16+hQbxPXXXLnoIP1hjFgpqhGPwDsqB0K3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794513832;
	h=Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=5gV/6C2AHmV+xeANCfCNQ0nPfep5V3gLCUrkMNmMk7o=;
	b=tI4FYjdjQwCkUwUbvpcKLYNXgapMZgdEK8WGGmgb3LDt3jO9nZFB01u9yPBQJyt4rwU8
	 W/MJFm72q0LaO2rI3B2bfPx1sTnFwbXvIJiuTMMWwhqe6qtvLSwIWt5g0KqvHob7VLooW
	 jDfE1i9IRlscI5tDGWYJX0mE+tFLUU/aZdGfte9FeABjOqoEzrUnI5tlSnNyR4gfuwTPV
	 x7+fcqdactIWv9c6IZPiAmITO53qk1B4f9KAwL93d7WhAnYiKM7AijHTIedupYmKsi1DJ
	 gfKyIrTqE6JEMpT0/HSFAZM6o4A2p1SDFWM7TxWZzR2xivLMbmP4aegYhwEaL34CpUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AOPa7Utz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F10606A31C;
	Thu, 12 Nov 2026 20:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AOPa7Utz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBEC91F000C4;
	Thu, 12 Nov 2026 20:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794513831;
	bh=5gV/6C2AHmV+xeANCfCNQ0nPfep5V3gLCUrkMNmMk7o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=AOPa7Utzo8hGrUb1g8FR1eUscVISdpgMMukqb5E77PFz1A8oOG1n10ayV5uUs444j
	 eJnxzADNKmBB3Vwh9EJ1Pe/3gv4rcKrb1JU+OhK2yEWVVomgQ6wUaxFZb047h7NHpL
	 DIZgkt4JT09zQIeICTMmwEOyyFAn1dvBornsClCTI6h6Mpw/2H32Uc5lgJb3btjgKm
	 ypPwalQ1RyZ1Vpw84/9q5qMgENrEb7R/NTCyXeBtfqiMVyzwcDyuhDhnfgdhZge+Tx
	 9Q7K+DwerqtOhtHOleBO8z1GdZZTP9rcqgxaO7ycg70Jj0exD6Is3Kt76yEs/5/C2C
	 2o8PEYlS22reg==
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
In-Reply-To: <avWk5as19fvZoEJA@boxer>
References: <20261110102039.1002605-1-bjorn@kernel.org>
 <20261110102039.1002605-12-bjorn@kernel.org> <avWk5as19fvZoEJA@boxer>
Date: Thu, 12 Nov 2026 21:03:48 +0100
Message-ID: <87wlqhq0kb.fsf@all.your.base.are.belong.to.us>
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

> On Tue, Nov 10, 2026 at 11:20:32AM +0100, Bj=C3=B6rn T=C3=B6pel wrote:

>> @@ -538,6 +547,13 @@ static int fbnic_bpf(struct net_device *netdev, str=
uct netdev_bpf *bpf)
>>  {
>>  	struct bpf_prog *prog =3D bpf->prog, *prev_prog;
>>  	struct fbnic_net *fbn =3D netdev_priv(netdev);
>> +	const struct xsk_rx_check *check;
>> +
>> +	if (bpf->command =3D=3D XDP_VALIDATE_XSK_POOL) {
>
> do you really need a separate command here? why not rely on existing
> XDP_SETUP_XSK_POOL ?
>
> here it doesn't look like things being validated are something unique that
> you could not check during XDP_SETUP_XSK_POOL and XDP_SETUP_PROG.

I'd like to keep it. XDP_SETUP_XSK_POOL means "set up driver ZC for this
pool": the driver maps the UMEM and restarts its queue, and the core
WARNs if it didn't map. A provider driver does neither; it only says yes
or no, before the core maps and installs anything. The same question
comes up on MTU and program changes of a bound device, with the new MTU
or program, which XDP_SETUP_XSK_POOL can't carry. One command keeps that
in one place, and v2 runs it from the core MTU path too, so a driver
can't forget that case. This is only a burden for the core.

> Overall, +400 lines for zc pp-based support...not sure what I was
> expecting and I know we need Tx side implementation.

fbnic had no AF_XDP at all. Of patch 11, about 120 lines are TX and 58
are docs; the rest is RX setup, refill and the checks. 08-10 add XDP
redirect, netmem heads and whole buffers to fbnic, which aren't
ZC-specific.

> However, I am wondering if better example for this change set would be the
> driver that already supports pp *and* carries the separate ZC data path
> (ekhm, see ice?). Then you could show case at least in diffstat how much
> less work is needed for AF_XDP support.

ice RX is on page pool through libeth, but ice has no queue API, and
libeth can't select a provider yet; that's also why ice can't do devmem
or io_uring zcrx. The provider has no unaligned mode either, which ice
supports. mlx5 or gve already have page pool RX, the queue API and their
own ZC path, so one of those would show the deletion with less
groundwork. I can do that as a follow-up.


Bj=C3=B6rn
