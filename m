Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D040740D562;
	Wed, 10 Jun 2026 00:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781051886; cv=none; b=aBu+k3kxe3Mzj7TdVPEeHBgC7Wd0qFtNk/LA+XTWt7sL7dzyof4fzvzEMevMgKrhJwLU82DMfX1jM79hxAbZhu8KFqgQPD3kWiKXxRybssqutBL7rZPhjNHKqmheBpF4QHpwff0j6KQPBpdfFlmp2IWPiWrSAFYddc92HV2wdVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781051886; c=relaxed/simple;
	bh=SxmIZJ+n1HkZTEshek9Vc2EZp4Ecq/SPC0XEfEnplJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HzQIYIk/Q+y0Igt6dmR284lW/AIarYAe+EthnO62wUJrINC5DZOE8N1mPPbiN+gnJCuuWEEugWnd222fMK36wEJvBCNbXpH6aSFBH8/vwaPOIaeWUZlRdr3z/Lq/6I4++bxv0FR7pKKWWREd3acnV9XA8mlWXm8xRl1oQrhOQm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kMOvifmd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kMOvifmd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC47E1F00893;
	Wed, 10 Jun 2026 00:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781051885;
	bh=EevDIl3T2tRBqKOfS6hGhqCsYiv62Le6WH61wInv79E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=kMOvifmdrxuqXxaTsT7spri7/bwWkkDRVMbJ/XqDSXYookm952FeqwRm2HxMp5mYY
	 nWkmXXOuZV8rl2zXMgE2RAKtR9aEN4/Ke5uOTWtj6KPJdDw3YM0Zu/QvxyNfXUtZww
	 bPKoYSVqJ+kD+2HylJDpSzc4/YkXqGgqy4zHnMb80oAtPlGO4h01f4GV8jhXzPPdeJ
	 AJywWCIqPchi3OmLGlnEL1He6wD/klnKE5rFKr/+9/JLMsEBOfLZMIEz2/Lon4GF7W
	 zonQvFtAA5c8IzxsTKNm5cjUQXpJ8xM75DhEPj0au4u6X4huY0LiKA9OgjiKqIJGLd
	 8/fBQSYk0k7Aw==
Date: Tue, 9 Jun 2026 17:38:04 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Carlos Fangmeier <carlos.fangmeier@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, "David S. Miller" <davem@davemloft.net>, Jesper
 Dangaard Brouer <hawk@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, Andrew
 Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, Ong Boon Leong
 <boon.leong.ong@intel.com>, netdev@vger.kernel.org, bpf@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: stmmac: prevent kernel panic during XDP program
 and XSK pool transitions
Message-ID: <20260609173804.77d13413@kernel.org>
In-Reply-To: <20260605-main-v1-1-aed15b1cf1af@gmail.com>
References: <20260605-main-v1-1-aed15b1cf1af@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 05 Jun 2026 00:56:35 -0700 Carlos Fangmeier wrote:
> stmmac_xdp_set_prog() tears down and rebuilds all DMA channels via
> stmmac_xdp_release()/stmmac_xdp_open() without pausing the netdev
> TX path. Similarly, stmmac_xdp_enable_pool() and
> stmmac_xdp_disable_pool() reconfigure individual queue DMA rings
> while TX remains active.

This still looks racy. Please look at other drivers

> If the kernel transmits a frame during these windows =E2=80=94 for exampl=
e an
> MLD report queued by the IPv6 stack =E2=80=94 stmmac_xmit() calls
> dwmac4_set_addr() against an MMIO register whose mapping has been
> torn down, triggering a level-3 translation fault:
>=20
>   Unable to handle kernel paging request at virtual address ffff8000840ec=
000
>   pc : dwmac4_set_addr+0x8/0x18
>   lr : stmmac_xmit+0x64c/0xb60
>   Call trace:
>    dwmac4_set_addr+0x8/0x18
>    dev_hard_start_xmit+0xb0/0x220
>    sch_direct_xmit+0x108/0x3f0
>    __dev_queue_xmit+0x844/0xd00
>    ip6_finish_output2+0x2d8/0x610
>    mld_sendpack+0x180/0x2e0
>    mld_ifc_work+0x1dc/0x480
>=20
> The existing netif_tx_disable() in stmmac_xdp_release() is not
> sufficient because stmmac_xdp_open() re-enables TX via
> netif_tx_start_all_queues() before the caller regains control, leaving
> a window where the freshly rebuilt rings can race with pending TX work.
>=20
> Fix this by wrapping each reconfiguration path with
> netif_tx_disable()/netif_tx_wake_all_queues():
>=20
>  - stmmac_xdp_set_prog(): hold TX disabled across the full
>    stmmac_xdp_release() + stmmac_xdp_open() sequence, only waking
>    TX after stmmac_xdp_open() returns.
>=20
>  - stmmac_xdp_enable_pool(): disable TX before tearing down the
>    queue, re-enable after the queue is rebuilt and NAPI is active.
>=20
>  - stmmac_xdp_disable_pool(): same pattern around the pool teardown
>    and queue rebuild.
>=20
> Tested on Cortex-A55 (stmmac/dwmac4, kernel 6.6.60) with AF_XDP

That's an ancient kernel, you'll have to test an upstream kernel
for us to merge the patch
--=20
pw-bot: cr
