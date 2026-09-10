Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381AC493651
	for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 13:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789045312; cv=none; b=imPk42fbL64DiOMTTiSC9qDEd9pMqbpT5mYmCaSEEcwHZmw3usKdkyZIfLpk+1HALiMeNgwIIszyHaaj4xU77ZH1zarUqprtpflz/skG89o2B2CRSFbEs2GId2U9Ch+9WieqFJYZcUgmb6uickNJVKR1muKcFY/nTd3kjCjupvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789045312; c=relaxed/simple;
	bh=/XrzPycryurSYfvOyyCsuYWwJn0KyrKySE096JHgqpQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=orVw5fROgKsM23YXLmdkxa5N3YoW7y+Hry1HPT6u3nIvV5BRX5KHQTX3/FbcHZD5UvLu3dWJUaOhzuAY1On3X0n2dGyJYrJOsYPRv/zK0mb2w2V7PoXga2YQ1LiL3WgLwo+ADWGmVN3cCxTqrWgd984EDY4O6OfzjzLPjXr3zzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ET5GgFlj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ET5GgFlj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5BC11F00893;
	Thu, 10 Sep 2026 13:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789045309;
	bh=8tE1oid0jwCODtgY6mehMCPqncIoqwHlsfrQYFkQ6FY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ET5GgFlj7Lr3Ms4JoEZSLd4Ia3HMu/P25FjWHjXZVs4Tcj3XZ5n2b1Sfbx1Ttb4LM
	 i8rkfzc3fNPDmV3xihBClbWQN+WZLQrhea+g8YGqBUTaZ5PJJTOlQiTwKTQLkhdjh1
	 l4x58iw1woGWtNvhFntHplcc6dI0xag0MP2g6ksZ8MoXMc1wQgwyBVS43TLF2sbbSx
	 EWRxUGbY5DuRyMAWmulD9GZ6aErsQWUvsy8F9GZgZdCmEkGVPAYpHE1SycCGij0cbV
	 I2nij70hb6AW8z34oawssdVeOUpd1virmfOk2DsYM1iX3/PWcPexKCe5LejnzV0+z9
	 PZl9XxlW0PQtg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v6 04/14] net: lan966x: add FDMA LLP register
 write helper
Reply-To: sashiko-reviews@lists.linux.dev
To: "Daniel Machon" <daniel.machon@microchip.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260909-lan966x-pci-fdma-v6-4-6f48dab9d671@microchip.com>
References: <20260909-lan966x-pci-fdma-v6-0-6f48dab9d671@microchip.com>
 <20260909-lan966x-pci-fdma-v6-4-6f48dab9d671@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 13:01:49 +0000
Message-Id: <20260910130149.B5BC11F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unchecked return value of `fdma_dcbs_init` in `lan966x_fdma_rx_all=
oc` leads to missing pages, causing a guaranteed NULL pointer dereference d=
uring teardown or reload.
- [High] Hardware and software RX ring pointers become permanently desynchr=
onized on the `lan966x_fdma_reload` failure path, breaking RX completely.
--

commit 3d957750cc640b40763313c06874bd2261200dd3
Author: Daniel Machon <daniel.machon@microchip.com>

net: lan966x: add FDMA LLP register write helper

Move the FDMA Link List Pointer (LLP) register writes into a new shared
helper and call it from the allocation functions instead of the activate
and start functions. This avoids overwriting ATU-translated addresses
with DMA addresses in the upcoming PCIe FDMA path.

> diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c b/driv=
ers/net/ethernet/microchip/lan966x/lan966x_fdma.c
> index 41d4ec7f2f571..b8344fd5e5ad2 100644
> --- a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
> +++ b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
[ ... ]
> @@ -128,6 +135,8 @@ static int lan966x_fdma_rx_alloc(struct lan966x_rx *r=
x)
>  	fdma_dcbs_init(fdma, FDMA_DCB_INFO_DATAL(fdma->db_size),
>  		       FDMA_DCB_STATUS_INTR);
> =20
> +	lan966x_fdma_llp_configure(lan966x, fdma->dma, fdma->channel_id);
> +
>  	return 0;
>  }

[Severity: High]
This is a pre-existing issue, but I noticed the return value of
fdma_dcbs_init() is ignored here in lan966x_fdma_rx_alloc().

If page allocation fails under memory pressure inside
lan966x_fdma_rx_dataptr_cb(), fdma_dcbs_init() aborts early and
returns -ENOMEM. The remaining rx->page[i][j] entries are left as NULL,
but since the error is ignored, initialization succeeds with an
incomplete ring.

Does this lead to a NULL pointer dereference in
lan966x_fdma_rx_free_pages() when the interface is brought down or an
MTU reload fails? That function blindly loops over all fdma->n_dcbs and
passes each page to page_pool_put_full_page() which will crash when trying
to access the page's reference count.

[ ... ]
> @@ -876,6 +871,9 @@ static int lan966x_fdma_reload(struct lan966x *lan966=
x, int new_mtu)
>  					   MEM_TYPE_PAGE_POOL, page_pool);
>  	}
> =20
> +	lan966x_fdma_llp_configure(lan966x, lan966x->rx.fdma.dma,
> +				   lan966x->rx.fdma.channel_id);
> +
>  	lan966x_fdma_rx_start(&lan966x->rx);
> =20
>  	lan966x_fdma_wakeup_netdev(lan966x);

[Severity: High]
This isn't a bug introduced by this patch, but does calling
lan966x_fdma_llp_configure() here in the restore: path of
lan966x_fdma_reload() cause the hardware and software ring pointers to
become permanently desynchronized?

The restore: path successfully restores the old rx->fdma state to memory
(via memcpy), reverting software's dcb_index to wherever it was before
the reload attempt. However, configuring the LLP register here forces the
hardware back to the start of the ring (index 0).

When lan966x_fdma_rx_start() starts the engine, hardware will write newly
received frames sequentially from index 0, but the software NAPI poll
(lan966x_fdma_napi_poll) will still poll the restored dcb_index. Can this
cause all newly received packets to be missed and stall the ring entirely
once the hardware wraps around and encounters the already 'done'
descriptors from its first pass?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909-lan966x-pc=
i-fdma-v6-0-6f48dab9d671@microchip.com?part=3D4
