Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793108891;
	b=bVMriWXW1VXwVmKUEnFwKy4QQm54vIp0yM1WSR0F/F/CWxsg1EZhsKkgMPoa2R2YBWj+
	 pYWtanGNduiHKV2yxkpgp2Q59k5D6rsdSZydPdlTPJ1XDG/0Ezy4wGq+y4kSNW/TwkRAV
	 5OlVHFPEZf/OUkMLG5E9w8WZpfCVsKFQZ+iaokFKdgHz18i/NWBZTHoy+RdKF3lKB/ffj
	 yQUPWJI/ZuuxErW2dm8fC8oG8HQR/sXjCZPlB8uyAqVIUbqvBVs6RoA4kQ2sdC0HO5MGA
	 ShApfTrHN9Ebpm9ZHykhprYJLwppVARs3xJWdvxm8ClWPGSPcNNj4+AN3bMUVkkhMZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793108891;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=XTLXmRbDqDj4P5lRAy22aEow8R81ACtgFAanKE8SXfE=;
	b=BLCKBXb12moOr3M4wRLsXlhUHbqiUKPwtcg/WwiZqai/UrU//Q3AxUBfsTANK4sd9+gB
	 GlJKq7VCobTG0B0buo3laLFAnvnzV1scEUFE+3JnrXydRcQOZ0fOWKj5cBNAmIwzs5T+S
	 jDyMLk6T+64vERdr74U2LvFLN16U39PXIa5iD6sE8UhlzwfKZJ4X4p3QY7EcAhjF4s5Ku
	 2yb86FHjkkdFnRSWpNq2YDq0N1mL7t9haIPZA7lgWfQM0nddFi8dvH/3yEQCQCMF+FrZT
	 EzKRu0Zuw8Ud7PYs7ItIENpjpSJ83aL/b1Hl40iH0poWzrL0eXhBHBNd2tQ0UM7AxaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Mw68UCOt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD18606A320;
	Tue, 27 Oct 2026 13:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Mw68UCOt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 578261F01825;
	Tue, 27 Oct 2026 13:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793108890;
	bh=XTLXmRbDqDj4P5lRAy22aEow8R81ACtgFAanKE8SXfE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Mw68UCOt9ZIp52ZJxdD9GhCKIyvJ9KXUoiQ+oLoqyjnZloKfQ8AQ8lsb0zJIgFYIZ
	 NnbAhRF7mTQkWVDJvQ8YQMpIWL2gc8vlDFWRKCnspHttQqp+zjGE98CZwgYDPQ6G6f
	 BPxpJb5YsADy3jcmPXrz+i9LrghQoirr4cUw4aY0yE9WUQQusyK2v0zJ8lHWlUKfUs
	 NzAuH7bLfgijNJQWyASzqOl16c0rHvYM77rhxLvydeUUe1SgTu6QwyzWNrAXh8+eHr
	 94mf2hCfiOg/6zaB/oWu0wJuwTQsi54aWVHRQYtWmTVPSvRdIC0BciMK/37YzWWKqZ
	 9A+Db19tLgd5g==
Subject:
 Re: [PATCH net] net: lan966x: don't disable hardirqs in fdma tx clear path
From: netdev-bot+sashiko@kernel.org
To: daniel.machon@microchip.com
Cc: horatiu.vultur@microchip.com, UNGLinuxDriver@microchip.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Date: Tue, 27 Oct 2026 13:48:08 +0000
Message-ID: <179310888885.3134.1983716616405342216@kernel.org>
In-Reply-To:
 <20261026-lan966x-fdma-tx-clear-hardirq-v1-1-5f70f026a2e4@microchip.com>
References:
 <20261026-lan966x-fdma-tx-clear-hardirq-v1-1-5f70f026a2e4@microchip.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The patch only fixes the normal NAPI case.

--

net: lan966x: don't disable hardirqs in fdma tx clear path

This patch changes lan966x_fdma_tx_clear_buf() to take tx_lock with a
plain spin_lock() instead of spin_lock_irqsave(). The aim is to stop
freeing page_pool backed buffers with hardirqs disabled. That currently
triggers the lockdep_assert_no_hardirq() warning in
__page_pool_put_page().

> diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
> index a7940eca5df31..a92bd0590b460 100644
> --- a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
> +++ b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
> @@ -336,14 +336,13 @@ static void lan966x_fdma_tx_clear_buf(struct lan966x *lan966x, int weight)

[ ... ]

>  	xdp_frame_bulk_init(&bq);
>  
> -	spin_lock_irqsave(&lan966x->tx_lock, flags);
> +	spin_lock(&lan966x->tx_lock);

[Severity: High]
Does this cover the netpoll case? The commit message says:

  tx_clear_buf() runs from the NAPI poll, so disabling hardirqs there is
  not needed.

However, netpoll can call the NAPI poll with budget 0 after the caller
has already disabled hardirqs:

netpoll_send_skb()
  local_irq_save(flags)
  __netpoll_send_skb()
    netpoll_poll_dev()
      poll_napi()
        poll_one_napi()
          napi->poll(napi, 0)
            lan966x_fdma_napi_poll(weight == 0)
              lan966x_fdma_tx_clear_buf(lan966x, 0)

lan966x_fdma_napi_poll() calls lan966x_fdma_tx_clear_buf() whatever the
weight is. tx_clear_buf() then does the XDP and page pool frees without
checking weight:

			if (dcb_buf->xdp_ndo)
				xdp_return_frame_bulk(dcb_buf->data.xdpf, &bq);
			else
				page_pool_recycle_direct(rx->page_pool,
							 dcb_buf->data.page);
	...
	xdp_flush_frame_bulk(&bq);

Consider netconsole on the port that owns the FDMA NAPI (fdma_ndev, which
does not set IFF_DISABLE_NETPOLL), with completed XDP_TX or ndo_xdp_xmit
frames in the TX ring. In that case, won't page_pool_recycle_direct() and
xdp_flush_frame_bulk() still hit lockdep_assert_no_hardirq() in
__page_pool_put_page()?

The bulk path always goes through page_pool_recycle_ring_bulk(). The
direct path does too once the alloc cache is full. That function takes
the producer lock with spin_lock_bh(), and netpoll from process context
is not in softirq.

Can spin_unlock_bh() then run __local_bh_enable_ip() with IRQs disabled?
That could run pending softirqs or turn IRQs back on inside netpoll's
local_irq_save() section.

Documentation/networking/napi.rst says:

  skb Tx processing should happen regardless of the budget, but if
  the argument is 0 driver cannot call any XDP (or page pool) APIs.

The skb branch looks fine, because napi_consume_skb(skb, 0) falls back to
dev_consume_skb_any(). Could the XDP and page pool part of TX completion
be skipped when weight is 0, as other page_pool drivers do?

The missing budget check is older than this patch. Even so, it means the
warning this patch is meant to fix can still be triggered from
lan966x_fdma_tx_clear_buf().

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261026-lan966x-fdma-tx-clear-hardirq-v1-1-5f70f026a2e4%40microchip.com
