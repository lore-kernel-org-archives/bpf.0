Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793367436;
	b=Pn22/D0gU4/OX1RWK2G/+AA1GB0RUlC2VKAZasH0ShnL5Fv0dbBa+JmBvGglDxaZ3K3E
	 hVsY3YR6m4/nLyB3UA4zwrWfmRM4Xblbks2waguQvTaandIJrZiAx1eggRAC8KsiWdlfV
	 qfdmSVva++Z38YXSXG2VJHwoEX1ica5h3qgUS9iUDIvNlfrHp5vS600tWyqUNbJ/8GGYU
	 nFw7udRe2dDfflG1jNEhcp2Xx+ihcEXuupZwFZ3yKG26smT8nPwtrofJk0P7RsVWAxJWO
	 451e/jfQZMDDHvULXckCNp64WT/p6/MtWLNYYsNtzGlA8tRg/+qlI2YrToo9b+IM+eg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793367436;
	h=Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=8tJ3mHvsCbcK0uC2z5FiKSUzFDveTQLdd2jjhlDidfw=;
	b=A+E5JpqGeAgrWxQ4DmqdOdmUqIFuOPr7+drp3yeOWweuxNDgzTpEfjNrISakdWHZWp7l
	 WXDI19Z47WthgziNXLrszdmFotoReWP4IdKg8gsycPsa4hCVkqlBhnHYeDPr5Ux0ZC5BK
	 bOl/h28kDq7gyTkFxJQhWBvhAGLE1N5SfRYz8ljuIzD74UrV6r5SW1GRFouKTc0sKuGxA
	 7UOEvb4PvNdAmywxI3rMBInv/Smtl150Ci5h+hdXAHqrqHMDuYZDotPP8APZOdhNjzdiv
	 TdrBDv/EwmvkSMsRc+O7mvfnfNRG4Yx3G/DK5wAuosIwdEX7yXuTv571BRDl2i5JIpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gNgiXmC1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A2F606A31A;
	Fri, 30 Oct 2026 13:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gNgiXmC1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EED6A1F00A02;
	Fri, 30 Oct 2026 13:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793367435;
	bh=8tJ3mHvsCbcK0uC2z5FiKSUzFDveTQLdd2jjhlDidfw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=gNgiXmC1hJbmntbn8phJg0ee50nGdaXjCJiFZtfcwCb84nlmG2+I+G+swfz1cbYwA
	 mY70cuTfDvF9VNaKUyVrakM6NBJiqWEIGKYaMwvHjmZ8tmc8Ysz/j4uBRznu8hRT/I
	 yN+BnVieh5JO7BlbF2r/8BXu/3H84N0fyGavQlBlcQ0RGHLqG0nWL03rxTQ/AU2rZU
	 QQDVFy4ogb/lpeX7tmDxNJCLMsHGEdkqw1oYI/6W66inTlQnbxY1OE5C9U9OPbyk8I
	 TCxIi/nnjTP0BRsxVDY274yuz+Jp43YGCHVJkJ1h4+j+kXRmcE+IB2cjxwVFvPnSVV
	 3UlzcFxZ75wPA==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Marcin Knap via B4 Relay <devnull+marcin.knap.vecima.com@kernel.org>,
 Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Magnus Karlsson <magnus.karlsson@intel.com>, Maciej
 Fijalkowski <maciej.fijalkowski@intel.com>, Stanislav Fomichev
 <sdf@fomichev.me>, Simon Horman <horms@kernel.org>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard
 Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 jtollet@cisco.com
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, Marcin Knap
 <marcin.knap@vecima.com>, Joshua Washington <joshwash@google.com>,
 Harshitha Ramamurthy <hramamurthy@google.com>, Sunil Goutham
 <sgoutham@marvell.com>, Geetha sowjanya <gakula@marvell.com>, Ratheesh
 Kannoth <rkannoth@marvell.com>, Subbaraya Sundeep <sbhatta@marvell.com>,
 Bharat Bhushan <bbhushan2@marvell.com>
Subject: Re: [PATCH bpf v2] xsk: Do not free ZC Rx buffer when the Rx ring
 is full
In-Reply-To: <20261030-xsk-zc-rx-double-free-v2-1-cf01d4a9f3f7@vecima.com>
References: <20261030-xsk-zc-rx-double-free-v2-1-cf01d4a9f3f7@vecima.com>
Date: Fri, 30 Oct 2026 14:37:11 +0100
Message-ID: <87jymz48e0.fsf@all.your.base.are.belong.to.us>
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

Marcin Knap via B4 Relay <devnull+marcin.knap.vecima.com@kernel.org>
writes:

> From: Marcin Knap <marcin.knap@vecima.com>
>
> When an XDP program redirects a zero-copy buffer to an XSK and the
> socket's Rx ring is full, xsk_rcv_zc() frees the buffer and returns
> -ENOBUFS to xdp_do_redirect().
>
> A failed xdp_do_redirect() leaves the buffer owned by the caller, and
> most drivers rely on that: mlx5e treats the failure as XDP_DROP and
> releases the buffer when the Rx WQE is refilled, while i40e, ice,
> ixgbe, igb, igc, stmmac, idpf and others free it themselves. The
> buffer is therefore freed twice. It gets reused for another Rx
> descriptor, the second free puts an in-use buffer back on the pool
> free list, and the same UMEM frame is later handed to user space
> twice. ixgbe and igb keep the buffer in the ring on their need_wakeup
> -ENOBUFS (XDP_EXIT) path and run it through XDP again on the next poll,
> after the core has freed it.
>
> Leave the buffer with the caller on both the single-buffer and the
> multi-buffer -ENOBUFS paths, as xsk_rcv() and xsk_rcv_check() already
> do. A few drivers relied on the core freeing the buffer, so make them
> free it:
>
> - i40e and ice consume the descriptor on XDP_EXIT without freeing it.
> - gve DQO counts the redirect error without freeing the buffer.
> - octeontx2 returns false on a failed redirect, so the caller goes on
>   to build an skb from the already freed buffer. Free the buffer and
>   report it as consumed instead.
>
> Seen on Mellanox ConnectX-6 DX MT2892 (FW 22.47.1026) with AF_XDP
> zero-copy on 7.3.0-rc6 when the user-space consumer could not keep up
> with the Rx ring. With this change no duplicate frames were seen with
> striding RQ on or off.
>
> Fixes: 269009893146 ("xsk: recycle buffer in case Rx queue was full")
> Signed-off-by: Marcin Knap <marcin.knap@vecima.com>
> ---
> Tested on mlx5 (ConnectX-6 DX) in zero-copy single-buffer mode.
> The i40e and ice changes and the multi-buffer path are build-tested
> only, as I don't have that hardware available.
> ---
> Changes in v2:
> - Also free the buffer on zero-copy redirect failure in gve DQO and
>   octeontx2, which relied on the core freeing it (AI review).
> - Audited the remaining zero-copy drivers against Bj=C3=B6rn's table.
>   ixgbe and igb no longer run XDP on a freed buffer after
>   XDP_EXIT; making them drop and consume the descriptor (R2) is
>   left for a follow-up unless you prefer it in this patch.
> - Rebased on current bpf.
> - Link to v1: https://patch.msgid.link/20261019-xsk-zc-rx-double-free-v1-=
1-2aa19f6628fb@vecima.com

Thank you for catching, and cleaning up the drivers.

I can follow-up with the documentation [1], or if you respin, feel free
to add it yourself.

Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>


[1] https://gist.github.com/fb-bjorn/d6835c49650bc3433b427a9c9708fbe2

