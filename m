Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794708835;
	b=2NX+Oz5y1UuFiNcR2JDlWmj9WiKfdL1elu0WK0JNW2Lwwgel+3RRVsVqJX42cnOndslH
	 eH3X1nnYOJAyXxt/FVwMMQL1yLauMGMXrNmRjMn96cM4nzS2ZXZYSi8Lp74R6+Jk8CRBb
	 Y3D61CXfWMv9+i9yGyfegvBK0BWCbKrtRWq44eFw3J2KHvAXTLKOzfna+m7F2hCtKm4Eq
	 38dNfdzXk3nOJ1A/EylXU5m+OuDMf/GEevx71Z32zgDtcj+dGkPSX4F8kEM09gCXZWBS+
	 kErIf3Bhw0+ICABtD9Asfiyee6etIlM0X11dlYbfUkQdTevVCbMgJelabda6RcsQjVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794708835;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=qLd1t2SOPSrsBdIc+eu+GEo/ZR66HR89GcURxW95eic=;
	b=X5UiqdG4fIL7ro9sOO1DqAVclhIaShqIgTJCEcXyND779hfW0hVcXKgU6s3VNB1pd2XT
	 r4zTB4rB2O56glmnbIdA5ULyLIGX65631hIfKL4l4uolMThr5X0ORIp0kB/4CHiub3OLs
	 w9yWELuUC94Du1kFgh99FSeS3jJhSkkHBUGrZyYOdIyGwB/vAIdm5YbzCxD3P0+Lq12QP
	 K8ia6pR+7/xDHNC+UuAVIy3zEok85pCx3EWscBxrmhWAfsCE6RuLHfTpiCv26dWFOub0F
	 w0qrzQLseI8aGZICD+bnwHgzpjnHSq21powAPtMeL+bJTbSUICBwvlupb2B+BVk6OHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="AXA7/8mC";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B3B606A333;
	Sun, 15 Nov 2026 02:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AXA7/8mC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93DDA1F000C5;
	Sun, 15 Nov 2026 02:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794708835;
	bh=qLd1t2SOPSrsBdIc+eu+GEo/ZR66HR89GcURxW95eic=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=AXA7/8mCjPW2MkXeT5B8ez40/dmEKtV7Cuihb3Hn8nhZCs80bnCDHrRK4h+OE2YFz
	 75f+u5paslGhtxqqKOKjabSlOy+ZlsKh50xJWSOOp3l4VlQYK6gAB5afKkh7EylCfv
	 1El+7x/8dvxUKlYw8tBPGeLDueUDC2dIApiSzBeVXcb9b5VYkEW/AiGvS0UlQGBE19
	 HKaS7t6UWmsCdvAD7kUh9dmHNKfL5TuXUHeTu1HzV/zmx85svUCgY2vysrCGVrSKBy
	 78fNMZTmO1DlhVwTONOoBY70G/gVZ9yLayeDRrKBiSVd0NP4ZM0WVjeespGlg67sfa
	 RSXt54So2sFfA==
Subject:
 Re: [PATCH net-next v2 2/3] veth: link RX queues to their NAPI instances
From: netdev-bot+sashiko@kernel.org
To: tianyi@cloudflare.com
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, toke@redhat.com,
 lorenzo@kernel.org, horms@kernel.org, bpf@vger.kernel.org, shuah@kernel.org,
 hawk@kernel.org, kernel-team@cloudflare.com, ast@kernel.org,
 daniel@iogearbox.net, john.fastabend@gmail.com, sdf@fomichev.me,
 linux-kselftest@vger.kernel.org
Date: Sun, 15 Nov 2026 02:13:54 +0000
Message-ID: <179470883411.2199510.13825316417997386083@kernel.org>
In-Reply-To: <20261111015922.67745-3-tianyi@cloudflare.com>
References: <20261111015922.67745-3-tianyi@cloudflare.com>
X-sashiko-severity: Medium
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

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] In drivers/net/veth.c, veth_napi_enable_range() still creates
  the per-queue NAPI with plain netif_napi_add(dev, &rq->xdp_napi,…

--

veth: link RX queues to their NAPI instances

This patch links each veth RX queue to its NAPI instance with
netif_queue_set_napi(). The link is set after napi_enable() and cleared
before napi_disable(). With it, queue-get reports a napi-id, and AF_XDP
copy-mode sockets bound to a veth queue get a NAPI ID for busy polling.

> diff --git a/drivers/net/veth.c b/drivers/net/veth.c
> index f5097696df15e..c042771864051 100644
> --- a/drivers/net/veth.c
> +++ b/drivers/net/veth.c
> @@ -1062,6 +1062,8 @@ static int veth_napi_enable_range(struct net_device *dev, int start, int end)
>  		netif_napi_add(dev, &rq->xdp_napi, veth_poll);
>  		rcu_assign_pointer(rq->xdp_prog, priv->_xdp_prog);
>  		napi_enable(&rq->xdp_napi);
> +		netif_queue_set_napi(dev, i, NETDEV_QUEUE_TYPE_RX,
> +				     &rq->xdp_napi);

[Severity: Medium]
Should this be netif_napi_add_config(dev, &rq->xdp_napi, veth_poll, i)
rather than netif_napi_add()?

As written, the queue-to-NAPI link only holds until the next
reconfiguration. veth_napi_del_range() deletes the NAPI completely, via
napi_disable() and then __netif_napi_del(). On the next enable,
napi_enable_locked() finds no n->config and allocates a new ID:

net/core/dev.c:napi_enable_locked() {
    ...
	if (n->config)
		napi_restore_config(n);
	else
		napi_hash_add(n);
    ...
}

So the same queue gets a new napi-id after each of these:

  - ip link set down/up (veth_close()/veth_open())
  - XDP detach and re-attach (veth_xdp_set())
  - a GRO toggle without XDP (veth_set_features())
  - ethtool -L (veth_disable_range_safe()/veth_enable_range_safe())

Any per-NAPI settings applied with napi-set are dropped silently on each
of these paths. That covers defer-hard-irqs, gro-flush-timeout,
irq-suspend-timeout and threaded.

An AF_XDP copy-mode socket is affected the same way. xsk_bind() records
the ID only once:

net/xdp/xsk.c:xsk_bind() {
    ...
		if (rxq->napi)
			__sk_mark_napi_id_once(sk, rxq->napi->napi_id);
    ...
}

The xsk notifier only unbinds on NETDEV_UNREGISTER, so the socket stays
bound across a down/up and keeps the old ID. Would sk_busy_loop() then
call napi_busy_loop() with an ID that no longer resolves, so busy polling
stops without any error?

The commit message gives napi-set and AF_XDP busy polling as the
motivation. Documentation/networking/napi.rst ("Persistent NAPI config")
says "Drivers should try to use netif_napi_add_config() whenever
possible." The queue index i is already available here, and
dev->napi_config has max(num_tx_queues, num_rx_queues) entries.

The selftest added later in this series ("selftests: net: veth: test RX
queue NAPI links") checks that the IDs match napi-get after each step.
It does not check that they stay the same across these reconfigurations.

>  		rcu_assign_pointer(priv->rq[i].napi, &priv->rq[i].xdp_napi);
>  	}
>  

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261111015922.67745-1-tianyi%40cloudflare.com
