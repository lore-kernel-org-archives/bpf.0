Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=68.232.153.233
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793111970;
	b=E0atrRXu8qVOOPgt8Io91b/yUVjyqOBCj6cNTfjt3tttjbfRUKY0vQm6jmTId8/ofLqX
	 45o2bmQ1O8t+u9Npfidg6CFVe9U+6qHPH1c1YHfDSkf3WJNym16BYVvj1Yut46QL8hnNr
	 BFoC53rS8nKT0NdcA0LLsjZ3dTUlkUH1D9GbIxrLgK1QwHjIYwxnprwIkl+wQsPygzA6s
	 oWAcGAjVFsdyQtTTKwC+TpDg3oAtH8yShIdcA9q6tGFuq6MrKTi/Mchd34uK8qptt6sBG
	 zNTfGIWIVolg/X7kY5i3VcOyM3NhNRsNdd8KoUIffaGoQXuQSLcKPYY2ZR3Yu/Ul/2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793111970;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-Amp-Result:Received:Received:Received:Date:From:To:CC:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To;
	bh=SsiL9XLFUNHqZME5gVEL6suEGYBNoOa/XtonB3t1YKA=;
	b=gLSSh6I72V9z5g0DorjdaqDHzUq5Adv4QZ48tdhK9sIpJdMEcktXpnzlVlry3AXZjEml
	 jAAxMOVDm/j3KzUGnSnum/SuyyrQvei1HC5OWrdloLWE238vPe9cRkK/CTE1npY54wAOd
	 fwzhKMA6exBjg9t5wjFF3ZXX6Y7+CV6/iigjgAt9Lkqa7+7nALKK9any3bGTPUCz6DglL
	 /PgD3YPbi5hs8Idg6zVxQpVitaWbJD7L6Qs3DXAN80m/5XSinnjlF87RbwnMRBfkZdSr8
	 f/hSmChrEEz591zXrh4gXrYDyrIpo/ZU7lBjmh4I98mLLQSdqhp6eOxEpVKJoCEAP/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=microchip.com;
	spf=pass smtp.mailfrom=microchip.com;
	dkim=pass header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=dJL3S+I7;
	arc=none smtp.remote-ip=68.232.153.233
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08D4606A323;
	Tue, 27 Oct 2026 14:39:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D08D4606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=dJL3S+I7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1793111970; x=1824647970;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=45CVcKvk/hupgpg0LhGsE87Hx7VpgL7A/4GQdvlKUVk=;
  b=dJL3S+I7eicpAf3uNE4/IUIzoJXs6Y/9GawFTWOp+v9/DzuoO71cZj/d
   o8fIpQ1AEH7YDQx/s4/vJV3JQoYbKOTO5xQeDrtccaeLTrX0KfG21gxfg
   JpRt+9SaQ9P21dUIxviRTa0K9eQFCtMyCEens1XrrC91Y658BXAAAjDvd
   R0i/2eL0etbUnBSZwcy5nDb2I7VFowyUUwPQeNQIXLuHUXEnv4oNkd7I5
   9QBLdw52gXFPzTb9GIw6dD0FlNT1LDw8kos0W94ZbFsnUvKH2w/TjG/1T
   XEuqe0nkIHYGglucN5vUM7Gwq6RM4XX5gaqRcQSvuJIbAvDZ9ZZop0/pD
   g==;
X-CSE-ConnectionGUID: MIk20CbjS9SN3RF5nH3gUw==
X-CSE-MsgGUID: M6K2zDiKRoWUPNn9JG5Jlg==
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="65617921"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 07:39:23 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex3.mchp-main.com (10.10.87.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.56; Tue, 27 Oct 2026 07:39:21 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 27 Oct 2026 07:39:19 -0700
Date: Tue, 27 Oct 2026 15:39:18 +0100
From: Daniel Machon <daniel.machon@microchip.com>
To: <netdev-bot+sashiko@kernel.org>
CC: <horatiu.vultur@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@kernel.org>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <hawk@kernel.org>, <john.fastabend@gmail.com>,
	<sdf@fomichev.me>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>
Subject: Re: [PATCH net] net: lan966x: don't disable hardirqs in fdma tx
 clear path
Message-ID: <20261027143918.zdn3brvcco22ehj7@DEN-DL-M70577.microsemi.net>
References: <20261026-lan966x-fdma-tx-clear-hardirq-v1-1-5f70f026a2e4@microchip.com>
 <179310888885.3134.1983716616405342216@kernel.org>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <179310888885.3134.1983716616405342216@kernel.org>

> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
> 
> Critical: 0 � High: 1 � Medium: 0 � Low: 0
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [High] The patch only fixes the normal NAPI case.
> 
> --
> 
> net: lan966x: don't disable hardirqs in fdma tx clear path
> 
> This patch changes lan966x_fdma_tx_clear_buf() to take tx_lock with a
> plain spin_lock() instead of spin_lock_irqsave(). The aim is to stop
> freeing page_pool backed buffers with hardirqs disabled. That currently
> triggers the lockdep_assert_no_hardirq() warning in
> __page_pool_put_page().
> 
> > diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
> > index a7940eca5df31..a92bd0590b460 100644
> > --- a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
> > +++ b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
> > @@ -336,14 +336,13 @@ static void lan966x_fdma_tx_clear_buf(struct lan966x *lan966x, int weight)
> 
> [ ... ]
> 
> >       xdp_frame_bulk_init(&bq);
> >
> > -     spin_lock_irqsave(&lan966x->tx_lock, flags);
> > +     spin_lock(&lan966x->tx_lock);
> 
> [Severity: High]
> Does this cover the netpoll case? The commit message says:
> 
>   tx_clear_buf() runs from the NAPI poll, so disabling hardirqs there is
>   not needed.
> 
> However, netpoll can call the NAPI poll with budget 0 after the caller
> has already disabled hardirqs:
> 
> netpoll_send_skb()
>   local_irq_save(flags)
>   __netpoll_send_skb()
>     netpoll_poll_dev()
>       poll_napi()
>         poll_one_napi()
>           napi->poll(napi, 0)
>             lan966x_fdma_napi_poll(weight == 0)
>               lan966x_fdma_tx_clear_buf(lan966x, 0)
> 
> lan966x_fdma_napi_poll() calls lan966x_fdma_tx_clear_buf() whatever the
> weight is. tx_clear_buf() then does the XDP and page pool frees without
> checking weight:
> 
>                         if (dcb_buf->xdp_ndo)
>                                 xdp_return_frame_bulk(dcb_buf->data.xdpf, &bq);
>                         else
>                                 page_pool_recycle_direct(rx->page_pool,
>                                                          dcb_buf->data.page);
>         ...
>         xdp_flush_frame_bulk(&bq);
> 
> Consider netconsole on the port that owns the FDMA NAPI (fdma_ndev, which
> does not set IFF_DISABLE_NETPOLL), with completed XDP_TX or ndo_xdp_xmit
> frames in the TX ring. In that case, won't page_pool_recycle_direct() and
> xdp_flush_frame_bulk() still hit lockdep_assert_no_hardirq() in
> __page_pool_put_page()?

This patch fixes the normal NAPI path, where the driver itself disabled
hardirqs around the frees. Fixing the netpoll case would be checking the budget,
which seems to be unrelated to this fix.

> The bulk path always goes through page_pool_recycle_ring_bulk(). The
> direct path does too once the alloc cache is full. That function takes
> the producer lock with spin_lock_bh(), and netpoll from process context
> is not in softirq.
> 
> Can spin_unlock_bh() then run __local_bh_enable_ip() with IRQs disabled?
> That could run pending softirqs or turn IRQs back on inside netpoll's
> local_irq_save() section.
> 
> Documentation/networking/napi.rst says:
> 
>   skb Tx processing should happen regardless of the budget, but if
>   the argument is 0 driver cannot call any XDP (or page pool) APIs.
> 
> The skb branch looks fine, because napi_consume_skb(skb, 0) falls back to
> dev_consume_skb_any(). Could the XDP and page pool part of TX completion
> be skipped when weight is 0, as other page_pool drivers do?
> 
> The missing budget check is older than this patch. Even so, it means the
> warning this patch is meant to fix can still be triggered from
> lan966x_fdma_tx_clear_buf().
> 
> [ ... ]
> 
> --
> Sashiko AI review � https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261026-lan966x-fdma-tx-clear-hardirq-v1-1-5f70f026a2e4%40microchip.com
