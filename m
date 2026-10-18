Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62F2388895;
	Sun, 18 Oct 2026 19:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792351230; cv=none; b=ftvKvp2zJoaEDqdLeEE/RYa4OREzA34ufHMfl8EhTRqh4Xw1Jh1bVoecaFwtSfrzMdrkT1Cfze80dZaHLU8Rvq/JveyQ18rQB0E8CM0lvDNVtKaRBR0OMtkiHdfyLebjxm/T+MorPALN8hG7MwNOewCM9bJpPNPazOllROB+A9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792351230; c=relaxed/simple;
	bh=7wpD6rrtVCuVPSDOYFWT3aDtybXWFIN02kCudrQI1ls=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=h/Wt6HUj8He/iAiT8rpIJU0D9VQLCV/6GWtvH4FyVV1xM8gIIx43hib1+bKrpBS0GYjmJol00go5X0W7nLWLSYelXF9MPenh0JLDI8uFQZmcjsqqaVwQQ9Cq2yWOTjha6TRBqIn7PO7ig10xDK6N26kFYbX1+K/8PI/BxoorshY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kMLqpt2J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kMLqpt2J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 096DB1F000C4;
	Sun, 18 Oct 2026 19:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792351229;
	bh=7wpD6rrtVCuVPSDOYFWT3aDtybXWFIN02kCudrQI1ls=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=kMLqpt2JoswwT0eqfe1u6vzdu0dGB+DvKVxAapgg3bonlAWk0ezBwaY+5bBGzTljP
	 51qzrwBFhcE1CmPvIG4ynCR61azMq4yxvd5PJ92n6YKozl8iy05/s6HCoRlYvPrFRi
	 IWseUDIgImi4eXRDYK5Z4/77qjvBX2u6H/1kgcYKk/86o50aFAcTbVvSmP61J0sY42
	 pP7UrWZBQjfIloVRY0isWhzz7K/gB/s/AXSMBpOPpIKgfgkQeG3S9YjGYmHJTQms89
	 WXxxJ0HYPDcFCdC1yjCbOfLEgxdoisN9sGc6USmw+lhWWJvVNmAgzy/q8hxb2EUPZC
	 J6nIq+InnnVjQ==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, magnus.karlsson@intel.com, stfomichev@gmail.com,
 kuba@kernel.org, pabeni@redhat.com, tushar.vyavahare@intel.com,
 kerneljasonxing@gmail.com, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>
Subject: Re: [PATCH v4 net-next 00/15] selftests: net: migrate AF_XDP test
 suite over to net
In-Reply-To: <20261016174338.787135-1-maciej.fijalkowski@intel.com>
References: <20261016174338.787135-1-maciej.fijalkowski@intel.com>
Date: Sun, 18 Oct 2026 21:20:26 +0200
Message-ID: <87pkx63jet.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Maciej Fijalkowski <maciej.fijalkowski@intel.com> writes:

> v3: https://lore.kernel.org/netdev/20261014184539.774708-1-maciej.fijalko=
wski@intel.com/
> v3 -> v4:
> - add tags from Mr Bj=C3=B6rn
> - Drop --hw in xskxceiver, align packet layout between hw/veth runners (B=
j=C3=B6rn)
> - drop parse_u32() in xskxceiver (Bj=C3=B6rn)
> - move ethtool -G and ring sizing logic from C to python
> - configurable --timeout (Bj=C3=B6rn)
> - keep the HW_SW_MAX_RING_SIZE batch below the XSK TX ring size (Sashiko)
> - restore hugepage count in veth runner on exception paths (Sashiko)
> - use ExitStack in hw runner to cover setup unrolls (Bj=C3=B6rn, Sashiko)
> - support IPv6 next to IPv4 (Bj=C3=B6rn)
> - send to the next-hop MAC, the peer need not be on-link (Bj=C3=B6rn)
> - make --listen work on its own rather than follow the TX role (Bj=C3=B6r=
n)
> - run XDP_SHARED_UMEM on HW, the socket is picked by UDP source port
> - fail a case when one endpoint fails and the other skips (Bj=C3=B6rn)
> - keep the TX half of the unaligned check in the xsk_caps conversion
> - detach in cleanup_iface() with the flags of mode_to_xdp_flags()
> - reserve 2 MiB huge pages, tolerate hosts without hugetlb or root (Sashi=
ko)
> - lower the veth case timeout to 20s, within the net timeout (Sashiko)
> - guard pkts_in_flight against forged PROGRESS reports (Sashiko)
> - log short fragments, fix the IPv4 fragment comment (Sashiko)
> - keep the MIN_PKT_SIZE and PKT_HDR_SIZE names to cut churn
> - read what a gone peer left at READY, drain after a SKIP (Sashiko)
> - cap --max-frags, which sizes a packet array (Sashiko)
> - skip the hw run when RSS or ntuple setup is refused (Sashiko)
> - bound the gateway ping, fail clearly without its MAC (Sashiko)
> - note in the README that RFS has to stay off on the DUT (Sashiko)

I think this serves well as a baseline for the XSK HW driver tests. I
think we'll surface a lot of bugs here! ;-)

For the series:
Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>
