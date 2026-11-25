Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795608720;
	b=oIbXqyAoaWojZdJS/OwLGPtx2n6qVlm7bQ1vX2/K2U/uABAYmr5twF/AOfqs5OxAoCgS
	 V/KYy/6CrFD5uQpjTizMlbwbe3Yux5R1qS9gsz9i8UhjTtVaaTzSvYqxWBSF9Zng6Ky/a
	 aDAwYDhI78jYdkKSKT2vRkj82bM7cg91u1roXlC9VubKRIeuA21qYCMWL05hpzNeSKigk
	 zIiCL+GdY9hwYv5WoIO2tz4osYbpWlTSs9k9DLYnuPj1/tNZ+sgDanKFvBGnVn4QoWyjy
	 TUEf8vZ7ilh0eiSQcKmnxnu/OFbmFzwGRpkYz3/c9pSCt+HdCA+QcNB+ZxKKBEtGhaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795608720;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=zoIAFYAcrw2In7mPsz0I79pd13SW8TJXMyFwyHpwC1k=;
	b=4UBmW+lVZSsM7Zol7m6Ahlotz3ChODw959qPjWytFH8dsvVEfeSvKe2kitCfFHZ3uZiR
	 PIHbt4AD7Z2unRlq5H91N11Ljk3P4xBkQcARCRTJd+48BoarRL0BLMaNyTeAu+k53Ca8b
	 zVA/LMm3s46p2+SlN11XPY2vVx2UydZjtUw7liA4bQ9PvAe9xkw/5FREVB8SubYQstw+m
	 zFWsKHhfQfQ3fAOvTWqaknqkQpL+NJoY/4dSzNrxSQU0YHQeJUCp+73hDvbzM+xElVi/d
	 FblsIzDcqontQh8aSnyyTD1EkD/b25QvQqGFmpuhKBJ9mxP0rWHGgu33XfKvCekBtoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UDXyQVo9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99CE606A31E;
	Wed, 25 Nov 2026 12:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UDXyQVo9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE2691F000CA;
	Wed, 25 Nov 2026 12:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795608720;
	bh=zoIAFYAcrw2In7mPsz0I79pd13SW8TJXMyFwyHpwC1k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UDXyQVo9ECntjvpQbMJ/hC9fIhbVdR2aq4mM07ICQmsBluEJnMw5Ew6ycPsnPcXgN
	 NSnZ4LttzwNCF1DLgS0McSQRLtvQNhEzNGSnNHLG+BgTcnVqxQJOcYZq1ZNhpjwAOr
	 MK2gVwEXQyqOcgotezSvv4KSlBUnBdwn3K3/EtmDeyrXO4xqs+YFWmsjdhambuX9er
	 ikcTTeaXXypizqg0q02qJ9ssWdRN8Pt2dc06DXLDy+5vpiUzHAutcK2pK5wA+5OZ29
	 j9QCRqj4Qyp7IJZCUUd3iVqz7ichk2hcGRiOzEYJl1LikyJGa03l4rYeMuEu4CwvP3
	 l1+KJWq8amdPQ==
Date: Wed, 25 Nov 2026 12:11:53 +0000
From: Simon Horman <horms@kernel.org>
To: netdev-bot+sashiko@kernel.org
Cc: m-malladi@ti.com, marco.crivellari@suse.com, kees+treewide@kernel.org,
	laixiangwu@cmss.chinamobile.com, philippe.schenker@impulsing.ch,
	haokexin@gmail.com, devnexen@gmail.com, jacob.e.keller@intel.com,
	sdf@fomichev.me, john.fastabend@gmail.com, hawk@kernel.org,
	daniel@iogearbox.net, ast@kernel.org, pabeni@redhat.com,
	kuba@kernel.org, edumazet@kernel.org, davem@davemloft.net,
	andrew+netdev@lunn.ch, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, srk@ti.com, vigneshr@ti.com,
	danishanwar@ti.com
Subject: Re: [PATCH net-next 1/2] net: ti: icssg-prueth: Add multi-flow RX
 support with per-flow NAPI
Message-ID: <20261125121153.GU31322@horms.kernel.org>
References: <20261118184729.2302130-2-m-malladi@ti.com>
 <179537406410.3135.5804903978186343042@kernel.org>
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
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <179537406410.3135.5804903978186343042@kernel.org>

On Sun, Nov 22, 2026 at 07:01:04PM +0000, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 19 potential
> issue(s) to consider.
> 
> Critical: 2 · High: 1 · Medium: 12 · Low: 4
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [Critical] SR1 data RX path is out of bounds.
> - [Critical] SR1 management-channel buffers get invalid DMA addresses.
> - [High] On a running interface, a failed XSK enable/disable leaves the
>   flow half torn down, and the next ndo_stop then hangs or the driver…
> - [Medium] Multi-flow RX does not work on AM65x SR2 ('ti,am654-icssg-
>   prueth'), which uses NAVSS UDMA rather than PKTDMA, but the driver…
> - [Medium] SR1 management-channel teardown is incomplete compared with
>   before the patch.
> - [Medium] Misplaced error label in SR1 emac_ndo_open().
> - [Medium] An AF_XDP pool bound while the interface is down silently
>   stops working after ndo_open.
> - [Medium] All flows share one desc_pool, and the XSK runtime refill
>   budget comes from the pool-wide free count, which other CPUs change…
> - [Medium] The SR1 data-flow page pool is never destroyed.
> - [Medium] SR1 now gets an RX coalescing hrtimer but never cancels it.
> - [Medium] prueth_xsk_pool_disable() can return an uninitialised value.
> - [Medium] On a running interface, XSK enable/disable now reconfigures a
>   single flow while the shared UDMA RX channel stays enabled.
> - [Medium] Racy irq_disabled handling in prueth_destroy_rxq() and the
>   prueth_create_rxq() error path.
> - [Medium] RX drop and error counters can lose updates now that RX runs
>   in several NAPIs at once.
> - [Medium] A coalesce setting is not applied to RX flows added later.
> - [Low] The ethtool channel range does not match what SR1 implements.
> - [Low] In the SR1 mgm flow setup in emac_ndo_open(), the IRQ check is
>   wrong for the signed field.
> - [Low] Leftover field and mixed-in cleanups.
> - [Low] net: ti: icssg: missing skb_record_rx_queue() in RX packet paths

This is quite a list of issues. And I would appreciate if you could
respond to them as requested above. For patch 1/2, the four that look most
likely to require a respin are:

  - [Critical] SR1 data RX path is out of bounds.
  - [Critical] SR1 management-channel buffers get invalid DMA addresses.
  - [High] On a running interface, a failed XSK enable/disable leaves the
    flow half torn down, and the next ndo_stop then hangs or the driver...
  - [Medium] Multi-flow RX does not work on AM65x SR2 ('ti,am654-icssg-
    prueth'), which uses NAVSS UDMA rather than PKTDMA, but the driver...

Patch 2/2 likely needs attention as well, but I have not reviewed it.

-- 
pw-bot: changes-requested
