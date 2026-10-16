Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A553D812D;
	Fri, 16 Oct 2026 11:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792149579; cv=none; b=V6isaUECN2eawckCSQFwl0olVajrF7ITQ/VOp+/AQjWcidfdaZggQEvOp2o9qOM+OqTuv9bItLZV8YrENMvUtawnK12OZSBJjv1EwX3+txSTc1BwdOOxb1Wt1uE1WrX9jyGyC9h4fwfRQVETkKfB5FeiC5ZhONs8awGhoXuubY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792149579; c=relaxed/simple;
	bh=bISYE32Keboph/NFLD7Q56AYqXzzo4A+4qsxWw0jSfc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EvcDhhNaJx81OPGUrAbUQ/5qZiWzvM6ConcaoIDrlhQ4gZlBPOOYSUYaW/thhSkDkzaD+OpKf4JmSrGJdBCNdYHiED4+SfWzOUoddNVvxbrWTz5X6pOXMNjac8tiTmsBDO9BBIDIV5G4YNoTT42QrZk/DWeM9tGv3nEwMiU4mD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GSZ/aODB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GSZ/aODB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF8141F000C4;
	Fri, 16 Oct 2026 11:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792149578;
	bh=miFPUobfnaeUFZw7U7GalciH9GRDPp4unu/aa9PhnKE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=GSZ/aODBboUbiYkksQCGe0Lc331lPG6ylfhUjH9mf4IrJL7JL60l+wppkr1u2qCJF
	 qkhd098NKAKFf7sIkiDnxofGPrRlVW8xwRJqE55NBaJlj+etNWiXeKoJNCdEORp9RA
	 Vwo/m2xF6ZtjOLg7tseNh3oiIzJXkMh4KPWKGphgLFUhQs40E6VkjMpJ41SZE09xks
	 sPwREe2sr+iJlnIP1V3f0j8fhCDnDMWR8riDM4+zYazw0VcEY51o33XgB9DB89Il8A
	 b0nkcOwoAmYOgl9cDgGDDwiQbvoPvIu2euUH5RDVdTrjS4BLiuPCiS4sWzsuIrOlUo
	 XzpAu+uQXplEw==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Clement Lecigne <clecigne@google.com>, aleksander.lobakin@intel.com,
 edumazet@google.com, netdev@vger.kernel.org, maciej.fijalkowski@intel.com
Cc: clecigne@google.com, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 kuba@kernel.org, sdf@fomichev.me, horms@kernel.org,
 john.fastabend@gmail.com, ast@kernel.org, daniel@iogearbox.net
Subject: Re: [PATCH v3] xsk: fix memory corruptions in net/core/xdp.c
In-Reply-To: <20260629072300.1664622-1-clecigne@google.com>
References: <20260629072300.1664622-1-clecigne@google.com>
Date: Fri, 16 Oct 2026 13:19:35 +0200
Message-ID: <87qzhp51vc.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Waking a dead thread: RISE FROM YOUR GRAVE!

Clement Lecigne <clecigne@google.com> writes:

> From: Cl=C3=A9ment Lecigne <clecigne@google.com>
>
> Commit 560d958c6c68 ("xsk: add generic XSk &xdp_buff -> skb conversion")
> introduced a vulnerability in the handling of XDP_PASS for AF_XDP zero-co=
py
> frames.

Hmm, I acually hit this in my WIP for UMEM page pool provider hack.

> Note: Currently, this specific AF_XDP zero-copy conversion path is only
> reachable from the drivers/net/ethernet/intel/ice and
> drivers/net/ethernet/intel/idpf drivers.
>
> When building an skb, xdp_build_skb_from_zc() uses the chunk size
> (xdp->frame_sz) for the allocation. However, napi_build_skb() automatical=
ly
> reserves space at the end of the allocation for the skb_shared_info
> structure.=20
>
> Most high performance UMEM applications use 4K chunks, where the
> corruption cannot happen.

I think this can also happen with 4K UMEM chunks.

For example, on ice, use MTU 3800, 4K chunks, and no extra UMEM
headroom. Attach an xdp.frags program that returns XDP_PASS, and bind
the socket without XDP_USE_SG.

A 3814-byte Ethernet frame fits in the UMEM chunk:

  256 headroom + 3814 packet =3D 4070 bytes

But the copied skb also needs space for skb_shared_info. Using
the 320-byte size from your example:

  256 headroom + 3814 packet + 320 shared info =3D 4390 bytes

The old code allocates only 4096 bytes, so the packet copy
overwrites skb_shared_info.

Am I missing something?


Bj=C3=B6rn
