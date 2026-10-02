Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D2844161B;
	Fri,  2 Oct 2026 07:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790926423; cv=none; b=K1zwTVkED2v/PWq6ZUFJ0LgtL+RAZr9H5D1J67MegDNLjUGCeqDS0fSUYtvshQWUxVgQw44BcJFrVN6SikGGhiASVdvOMPttrVg/7iM/VaidwH6/kI8QZUA+XiVUFyeFlrTqy4CzT3zP1SrKgLZXENgtgtVRZAl0rIKr1w4GHYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790926423; c=relaxed/simple;
	bh=UjFEFs/9N31CsJqhdfOV1wLA1n7YMdR2wM4Zjikrxoc=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NtiTg6BwpMbmhK+lbK5O86BEFxehHt+1wrFFj9CAMqD16tVc0k8xXucEyOncuJ6IMqIK7v6qntW3lHLQeluyzcKOwgvv03aZR0SYOL5s/UID1R1LkFhDzSTMf2Knf2a2G89KoW1gl0gTsAK+wlKzxlvGNIyeDUp84xrAVKCIzUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NY25e7fU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NY25e7fU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EDC01F00899;
	Fri,  2 Oct 2026 07:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790926421;
	bh=5ySYygxUxT5gl4179kQW8xeEjkqCg4XtfHXz+ZiJhx4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=NY25e7fUag+Q/ardp38Z2tPAgxTmgF1wumG7lxK0Orcvs//bFTwU59qoPZjstDjci
	 JzAHPikPSlz/rRDuk9iy1h4HAhBAojnwZgsmn5+0+0Wr3zs4PLSh3lbNLAFiI7tNR3
	 decoC3Y2y7Qz1jFOy+S6S7V+be5hvttE4czvphwBDWZI0X5RN6A57YfEDKmPqveAMd
	 FjrVFyAnIaVMcN0ZtSlGXEMd6r0DktYLOXAcsm04NAbD/vWXTTWFGI9a7x6xkl5x2L
	 N0/55nAIbMjhIe6+ftKBf2vrhZRLRYW6MTkdk9aj9oFdltqj32R39Me2v8nc79V1vP
	 HzX0kxmTBx1ng==
Subject:
 Re: [PATCH net-next v9 12/15] net: lan966x: add PCIe FDMA MTU change support
From: netdev-bot+sashiko@kernel.org
To: daniel.machon@microchip.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horatiu.vultur@microchip.com,
 steen.hegelund@microchip.com, UNGLinuxDriver@microchip.com, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 sdf@fomichev.me, herve.codina@bootlin.com, arnd@arndb.de,
 gregkh@linuxfoundation.org, mohsin.bashr@gmail.com, horms@kernel.org,
 richardcochran@gmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Date: Fri, 02 Oct 2026 07:33:39 +0000
Message-ID: <179092641967.434549.1766859316698814287@kernel.org>
In-Reply-To: <20260928-lan966x-pci-fdma-v9-12-a17caf60f89a@microchip.com>
References: <20260928-lan966x-pci-fdma-v9-12-a17caf60f89a@microchip.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 1 (1) · Medium: 0 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] lan966x_fdma_pci_resize() uses `lan966x->rx.lan966x` to decide
  whether the rings exist, and that field does not track ring state.
- [Low] lan966x_fdma_pci_reload() frees and ATU-unmaps the old rings and
  reprograms LLP right after lan966x_fdma_rx_disable() and…

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the patch
  explicitly acknowledges the hazard and fixes only the PCIe side.

--

net: lan966x: add PCIe FDMA MTU change support

This adds MTU change support to the lan966x PCIe FDMA path. On an MTU
change, the contiguous ATU-mapped RX and TX rings are reallocated at the
new size, and the old buffers are kept if allocation fails. The PCIe DCB
ring is capped at 256, FDMA_PCI_MAX_MTU is advertised as max_mtu when the
FDMA is in use, and the resize is skipped until lan966x_fdma_pci_init()
has built the rings.

> diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma_pci.c b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma_pci.c
> index f511e70613141..758554c951c52 100644
> --- a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma_pci.c
> +++ b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma_pci.c

[ ... ]

> +static int lan966x_fdma_pci_reload(struct lan966x *lan966x, int new_mtu)
> +{
> +	struct fdma tx_fdma_old = lan966x->tx.fdma;
> +	struct fdma rx_fdma_old = lan966x->rx.fdma;
> +	u32 old_mtu = lan966x->rx.max_mtu;
> +	int err;
> +
> +	napi_disable(&lan966x->napi);
> +	lan966x_fdma_tx_disable_netdev(lan966x);
> +	lan966x_fdma_rx_disable(&lan966x->rx);
> +	lan966x_fdma_tx_disable(&lan966x->tx);

[Severity: Low]
lan966x_fdma_rx_disable() and lan966x_fdma_tx_disable() both throw away
the result of the FDMA_CH_ACTIVE poll:

	readx_poll_timeout_atomic(lan966x_fdma_channel_active, lan966x,
				  val, !(val & BIT(fdma->channel_id)),
				  READL_SLEEP_US, READL_TIMEOUT_US);

__lan966x_fdma_pci_reload() also ignores the result of the CPU queue drain
poll. After that, the old rings are freed and ATU-unmapped straight away.

If a channel is still active when the poll times out, could it follow the
old DCB chain into memory that has already been unmapped and freed?

The timeout is READL_TIMEOUT_US (100 seconds), so this would need wedged
hardware. The platform lan966x_fdma_reload() uses the same sequence. It
might still be worth checking the poll results and bailing out before
freeing the old rings.

> +
> +	lan966x->rx.max_mtu = new_mtu;

[ ... ]

> +	/* Free and unmap old memory. */
> +	fdma_free_coherent_and_unmap(lan966x->dma_dev, &rx_fdma_old);
> +	fdma_free_coherent_and_unmap(lan966x->dma_dev, &tx_fdma_old);

[ ... ]

>  static int lan966x_fdma_pci_resize(struct lan966x *lan966x)
>  {
> -	return -EOPNOTSUPP;
> +	int max_mtu;
> +
> +	/* Nothing to resize until fdma_pci_init() has built the rings; it
> +	 * sizes them from DEV_MAC_MAXLEN_CFG, which the caller already set.
> +	 */
> +	if (!lan966x->rx.lan966x)
> +		return 0;

[Severity: High]
Does rx.lan966x actually show whether the rings have been built?

In lan966x_fdma_pci_init() it is set before either ring is allocated or
ATU-mapped:

	lan966x->rx.lan966x = lan966x;
	lan966x->rx.max_mtu = lan966x_fdma_get_max_frame(lan966x);
	...
	err = lan966x_fdma_pci_rx_alloc(&lan966x->rx);
	if (err)
		return err;

It is not cleared on the init error paths or in
lan966x_fdma_pci_deinit(). Init and deinit both run without RTNL while the
port netdevs are registered, so ndo_change_mtu can reach this check during
those windows.

First, lan966x_remove() tears down the FDMA before the netdevs are
unregistered:

	lan966x->ops->fdma_deinit(lan966x);
	lan966x_cleanup_ports(lan966x);

lan966x_fdma_pci_deinit() calls napi_disable() and frees both rings. An
MTU change in that window passes this check and reaches
lan966x_fdma_pci_reload(), which calls napi_disable() a second time.

Would napi_disable_locked() then spin forever on NAPIF_STATE_SCHED |
NAPIF_STATE_NPSVC with RTNL held? That would leave unregister_netdev() and
every other RTNL user blocked. The probe unwind at cleanup_fdma has the
same ordering.

Second, if lan966x_fdma_pci_tx_alloc() fails in init, the RX ring is freed.
However, rx.fdma.dcbs still points at it and rx.lan966x stays set. The
probe unwind jumps to cleanup_ptp and skips fdma_deinit, so the netdevs
stay registered until lan966x_cleanup_ports(). An MTU change in that
window runs lan966x_fdma_pci_reload(), which calls:

	fdma_free_coherent_and_unmap(lan966x->dma_dev, &rx_fdma_old);

Can this free the stale RX buffer a second time? The newly allocated,
ATU-mapped rings would then leak while the FDMA runs on them.

The same thing looks possible when the ATU map fails inside
lan966x_fdma_pci_rx_alloc(), because fdma_alloc_coherent_and_map() frees
dcbs without clearing the pointer.

Third, lan966x_probe() registers every port netdev in lan966x_probe_port()
before ops->fdma_init() runs. A concurrent MTU change, for example udev
applying MTUBytes, could pass this check while init is still sleeping in
dma_alloc_coherent() inside rx_alloc or tx_alloc.

Reload would then snapshot a half-built struct fdma, clear atu_region, and
rewrite db_size and size while init is still filling them in. Could that
leak or double-map ATU regions, or leave LLP pointing at freed memory?

The commit message says:

  Skip the resize until lan966x_fdma_pci_init() has built the rings;

The check does not seem to do that. The resize, init and deinit paths are
also unchanged at the end of the series.

> +
> +	max_mtu = lan966x_fdma_get_max_frame(lan966x);
> +	if (max_mtu == lan966x->rx.max_mtu)
> +		return 0;
> +
> +	return __lan966x_fdma_pci_reload(lan966x, max_mtu);
>  }

[Severity: High]
This isn't a bug introduced by this patch, but the platform backend has
the same pre-init window, and the guard added here only covers PCIe.

lan966x_fdma_change_mtu() in lan966x_fdma.c has no equivalent check:

	max_mtu = lan966x_fdma_get_max_frame(lan966x);
	if (max_mtu == lan966x->rx.max_mtu)
		return 0;

	return __lan966x_fdma_reload(lan966x, max_mtu);

rx.max_mtu is still 0 before lan966x_fdma_init() runs. So an MTU change
after register_netdev() in lan966x_probe_port() always continues down:

lan966x_port_change_mtu()->lan966x_fdma_change_mtu()->
    __lan966x_fdma_reload()->lan966x_fdma_reload()

>From there, lan966x_fdma_rx_disable() does:

	struct lan966x *lan966x = rx->lan966x;
	...
	lan_rmw(FDMA_CH_DISABLE_CH_DISABLE_SET(BIT(fdma->channel_id)),
		FDMA_CH_DISABLE_CH_DISABLE,
		lan966x, FDMA_CH_DISABLE);

rx->lan966x is still NULL at that point. Can this oops under RTNL?

Would a check in the common caller, or an equivalent guard in
lan966x_fdma_change_mtu(), cover both backends?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260928-lan966x-pci-fdma-v9-0-a17caf60f89a%40microchip.com
