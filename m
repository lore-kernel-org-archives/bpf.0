Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA433445AFB;
	Fri, 25 Sep 2026 19:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790363540; cv=none; b=pAeZzTTQBB3UFWQZXuX77V5pUr2pAaWuyImd/YIjxQhBkFGUYH0cC0kpV5tWr/vqVpvZEUtZ23y1mob96/jlc7yt9RyOJw0fDll3EnPkaYKoOVKnAuGv4s5cwnEagTqpcxR31UKqMOZRy0tpRMHWwvmZWbYAFnX74hQx/jDvPn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790363540; c=relaxed/simple;
	bh=gJjlr1oA2h0Vu4DZenVd11pp4Vv14x2xu24QYk/9wxo=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PwjfPuAfSf4AawhUOLY1X4I+6LhOQZw72sNp34to4aVZ+VP6lKifxyEUUb9vzmnyU96+rFv3xm9urT2pSnx/0edu17ZB3DqAuEbFtpqUiYyrNOpokqj+kgAvHP5iudrd+YMbddUHT85PM1O6f9jYtkf/qAvezBytXwVQ02IVvck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XiZ1BIy8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XiZ1BIy8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 056A31F0089D;
	Fri, 25 Sep 2026 19:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790363535;
	bh=m2ivcYBAuZaiefngtR+aI2MSnofNwOd/HKB+3cs/zEY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=XiZ1BIy8BqNVkuQesimaRh3DeJfmDLY4fNIOOqLmHopq03aKpRUegn7+V20wcLaXp
	 k9edL97ibdvRzEJmLk3vF3svjAwuLAzZaUnRH9MQCI7lrH6u06IxxZ6fcdzMcqNaS9
	 2po3rZFdtBnRSDEtoyMF545fdbeQmhfjQEwWeedFq4wJqMNuWBZdVmtS6ZdkjXo3Id
	 8JfpkYqHf0KbaXPiohyL/gf09w4jXtfFG0gHN1PsSQW5LmtxZfiGZOgOQ+/aI4HpLe
	 OwvdwG1Bviao9pAhBs0d8G4F5D48MF85JzIJJjnGOlhoZd/ZbqK1M8y8ExDZh7Uu7L
	 eKHlUbc3w6Yyw==
Subject:
 Re: [PATCH net v3 10/10] net: stmmac: retain DMA resources across MTU changes
From: netdev-bot+sashiko@kernel.org
To: james.hilliard1@gmail.com
Cc: linux@armlinux.org.uk, andrew@lunn.ch, hkallweit1@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 qiangqing.zhang@nxp.com, rmk+kernel@armlinux.org.uk,
 maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, ansuelsmth@gmail.com,
 yangtiezhu@loongson.cn, chenhuacai@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 sdf@fomichev.me, fancer.lancer@gmail.com, quic_jsuraj@quicinc.com,
 richardcochran@gmail.com, Joao.Pinto@synopsys.com, vladimir.oltean@nxp.com,
 boon.leong.ong@intel.com, weifeng.voon@intel.com, yoong.siang.song@intel.com,
 richard.genoud@bootlin.com, alastair@d-silva.org, mripard@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org,
 zhaojinming@uniontech.com, lorenzo.bianconi@oss.qualcomm.com,
 dinghui1111@163.com
Date: Fri, 25 Sep 2026 19:12:12 +0000
Message-ID: <179036353260.2160803.17107531453230624571@kernel.org>
In-Reply-To:
 <20260924-submit-stmmac-reset-fixes-v1-v3-10-c031e3f3a282@gmail.com>
References:
 <20260924-submit-stmmac-reset-fixes-v1-v3-10-c031e3f3a282@gmail.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 6 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 3 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] After a rollback, stmmac_reinit_dma_desc() initializes the RX
  descriptors in the wrong order.
- [Medium] stmmac_reconfigure_mtu() leaves out the platform PTP clock-
  frequency hook after the MAC/DMA reset.
- [Medium] The PHC now stays registered across the jumbo MTU reset, but
  the PTP hardware state that users configured through it is silently…
- [Medium] stmmac_set_irq_state(priv, false) calls disable_irq() on
  dev->irq, wol_irq and sfty_irq.
- [Low] Two comments were not updated when STMMAC_DATAPATH_HALTED was
  added: - In stmmac_bpf() (stmmac_main.c:7271-7275), the comment talks…
- [Low] A comment in __stmmac_open() (stmmac_main.c:4314-4315) gives
  'e.g. on MTU change' as the case where the interface is reopened…

--

net: stmmac: retain DMA resources across MTU changes

This patch changes how stmmac handles an MTU change across ETH_DATA_LEN on
a running interface. It no longer does a full close/open. Instead it
prepares a new DMA configuration, quiesces the old queues with their IRQs
disabled, and resets the hardware onto the new rings. On failure it rolls
back to the old rings, reinitializing them after a successful reset. If
that rollback also fails, it leaves the interface in a new HALTED state.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index d17c68f55caf6..1a552455a633d 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c

[ ... ]

> +/* Only after a successful DMA reset, and with all RX buffers prepared. */
> +static void stmmac_reinit_dma_desc(struct stmmac_priv *priv)
> +{
> +	struct stmmac_dma_conf *dma_conf = priv->dma_conf;
> +	u32 queue, i;
> +
> +	stmmac_free_tx_skbufs(priv);
> +	stmmac_reset_queues_param(priv);
> +	init_dma_tx_desc_rings(priv->dev, dma_conf);
> +	stmmac_clear_descriptors(priv, dma_conf);
> +
> +	for (queue = 0; queue < priv->plat->rx_queues_to_use; queue++) {
> +		struct stmmac_rx_queue *rx_q = &dma_conf->rx_queue[queue];
> +
> +		if (rx_q->state_saved)
> +			dev_kfree_skb_any(rx_q->state.skb);
> +		rx_q->state.skb = NULL;
> +		rx_q->state_saved = 0;
> +		rx_q->rx_count_frames = 0;
> +		rx_q->buf_alloc_num = dma_conf->dma_rx_size;
> +
> +		for (i = 0; i < dma_conf->dma_rx_size; i++)
> +			stmmac_init_rx_buffer_desc(priv, dma_conf,
> +						   stmmac_get_rx_desc(priv, rx_q, i),
> +						   &rx_q->buf_pool[i]);

[Severity: High]
Can this order leave the RX descriptors without the OWN bit on dwmac4 and
xgmac cores?

On dwmac4, stmmac_clear_descriptors() reaches dwmac4_rd_init_rx_desc() and
then dwmac4_set_rx_owner(). That ORs RDES3_OWN, RDES3_BUFFER1_VALID_ADDR
and the IOC bit into des3.

The loop above then calls stmmac_init_rx_buffer_desc() for every
descriptor. That function always calls stmmac_set_desc_sec_addr(), which
on dwmac4 is:

drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c:dwmac4_set_sec_addr() {
	p->des2 = cpu_to_le32(lower_32_bits(addr));
	p->des3 = cpu_to_le32(upper_32_bits(addr));
	...
}

dwxgmac2_set_sec_addr() does the same. The plain assignment to des3 clears
OWN, BUF1V and IOC, and nothing sets them again. After that,
stmmac_init_dma_engine() programs the RX tail pointer with
buf_alloc_num = dma_rx_size, and stmmac_hw_setup() starts RX DMA.

The existing init_dma_desc_rings() writes the buffer addresses first and
sets ownership last:

	ret = init_dma_rx_desc_rings(dev, dma_conf, flags);
	...
	ret = init_dma_tx_desc_rings(dev, dma_conf);

	stmmac_clear_descriptors(priv, dma_conf);

Take the case where the first stmmac_hw_setup(dev, false) in
stmmac_reconfigure_mtu() fails and the rollback succeeds. Would the
interface then be reattached with no RX descriptors owned by the hardware
on GMAC4/5 and XGMAC? enh_desc and norm_desc keep OWN in des0, so they do
not seem to be affected.

Should stmmac_clear_descriptors() move after the RX loop, as in
init_dma_desc_rings()?

> +
> +		if (priv->descriptor_mode == STMMAC_CHAIN_MODE)
> +			stmmac_mode_init(priv, stmmac_get_rx_desc(priv, rx_q, 0),
> +					 rx_q->dma_rx_phy, dma_conf->dma_rx_size,
> +					 priv->extend_desc);
> +	}
> +}

[ ... ]

> @@ -4220,7 +4322,7 @@ static int __stmmac_open(struct net_device *dev,
>  
>  	stmmac_reset_queues_param(priv);
>  
> -	ret = stmmac_hw_setup(dev);
> +	ret = stmmac_hw_setup(dev, false);

[Severity: Low]
This isn't a bug, but the comment earlier in __stmmac_open() still gives
an MTU change as its example:

	/* The PHY is suspended when the interface is reopened without
	 * disconnecting the PHY, e.g. on MTU change. IEEE 802.3 allows PHYs

After this patch, stmmac_change_mtu() no longer reaches __stmmac_open(),
and stmmac_reconfigure_mtu() calls phylink_prepare_resume() itself. The
remaining callers are stmmac_open() and stmmac_reopen(). Could the example
be updated?

>  	if (ret < 0) {
>  		netdev_err(priv->dev, "%s: Hw setup failed\n", __func__);
>  		goto init_error;

[ ... ]

> +static int stmmac_reconfigure_mtu(struct net_device *dev, int mtu)
> +{

[ ... ]

> +	/* An IRQ can recover a TX error and restart a queue. Drain handlers
> +	 * before the final TX stop, and keep the registrations for rollback.
> +	 */
> +	stmmac_set_irq_state(priv, false);

[Severity: Medium]
Does disabling these lines also block other devices that share them?

In single-IRQ mode, stmmac_request_irq_single() requests the lines with
IRQF_SHARED:

	ret = request_irq(dev->irq, stmmac_interrupt,
			  IRQF_SHARED, dev->name, dev);

The comment on stmmac_set_irq_state() also says it covers shared lines.
disable_irq() masks the whole line at the interrupt controller, so any
other device on dev->irq, wol_irq or sfty_irq gets no interrupts from here
until the restart label.

That window includes:

  synchronize_net()
  the RX buffer refill in stmmac_prepare_rx_buffers()
  the DMA software reset poll, which can wait a long time without an
  RX clock
  a full stmmac_hw_setup()
  on failure, a second reset for the rollback

Would it work to mask the device's own DMA/MAC interrupt enables and then
call synchronize_irq(), instead of disabling a shared line?

> +	netif_tx_disable(dev);
> +	synchronize_net();

[ ... ]

> +	/* Restore timestamping without registering a new PHC or resetting the
> +	 * user's packet timestamp filters. Timestamping can also be used without
> +	 * a registered PHC (CONFIG_PTP_1588_CLOCK=n).
> +	 */
> +	if ((priv->dma_cap.time_stamp || priv->dma_cap.atime_stamp) &&
> +	    priv->plat->clk_ptp_rate) {
> +		unsigned long flags;
> +
> +		write_lock_irqsave(&priv->ptp_lock, flags);
> +		stmmac_init_tstamp_counter(priv, priv->systime_flags);
> +		if (priv->plat->flags & STMMAC_FLAG_HWTSTAMP_CORRECT_LATENCY)
> +			stmmac_hwtstamp_correct_latency(priv, priv);
> +		write_unlock_irqrestore(&priv->ptp_lock, flags);
> +	}

[Severity: Medium]
Is the platform ptp_clk_freq_config() hook skipped here?

Before this patch, the jumbo MTU path went through
__stmmac_open()->stmmac_setup_ptp()->stmmac_init_timestamping(). That
function calls the hook after the reset done in stmmac_hw_setup():

	if (priv->plat->ptp_clk_freq_config)
		priv->plat->ptp_clk_freq_config(priv);

stmmac_resume() also calls stmmac_init_timestamping() after its reset.

On Intel mGBE, intel_mgbe_ptp_clk_freq_config() selects the PTP reference
clock with the GPO bits in GMAC_GPIO_STATUS, and the software reset clears
them. On PSE, 200 MHz needs GMAC_GPO0 | GMAC_GPO3, while the zero value
(PSE_PTP_CLK_FREQ_256MHZ) selects 256 MHz.

stmmac_init_tstamp_counter() still computes the sub-second increment and
addend from clk_ptp_rate (200 MHz). Would the PHC and packet timestamps
then run at the wrong rate until the next down/up?

[Severity: Medium]
The PHC now stays registered across the reset. What happens to the PTP
state that users configured through it?

The DMA software reset in stmmac_hw_setup() also resets the MAC timestamp
and PPS block, but this code only restores the counter:

  stmmac_init_tstamp_counter()->stmmac_update_subsecond_increment()
  writes priv->default_addend. That drops any adjfine correction that
  stmmac_adjust_freq() had programmed into the addend register.

  Flexible PPS/PEROUT outputs that stmmac_enable() set up with
  stmmac_flex_pps_config() and recorded in priv->pps[] are not
  re-applied.

  EXTTS auxiliary snapshot enables in PTP_ACR are not restored, although
  STMMAC_FLAG_EXT_SNAPSHOT_EN stays set in priv->plat->flags.

Before the patch, the PHC was unregistered, so consumers could see that
this state was gone. Now /dev/ptpN stays valid while PPS output and EXTTS
events stop without notice, and the frequency cached by the PTP core no
longer matches the hardware.

The commit message only says:

    This does not preserve continuous PHC time across the reset.

Should these settings be replayed after the reset, or at least be listed
in the commit message?

> +	stmmac_set_rx_mode(dev);
> +	stmmac_vlan_restore(priv);

[ ... ]

> @@ -7091,7 +7273,8 @@ static int stmmac_bpf(struct net_device *dev, struct netdev_bpf *bpf)
>  	 * suspended rings before their pool or XDP buffer layout can change.
>  	 * Leave the interface detached until it is closed and reopened.
>  	 */
> -	if (priv->datapath == STMMAC_DATAPATH_SUSPENDED)
> +	if (priv->datapath == STMMAC_DATAPATH_SUSPENDED ||
> +	    priv->datapath == STMMAC_DATAPATH_HALTED)
>  		__stmmac_release(dev);

[Severity: Low]
This isn't a bug, but the comment above still mentions only "a failed
resume" and "suspended rings". The condition now also covers the HALTED
state left by a failed MTU rollback.

The same applies in __stmmac_release(), where the comment on skipping the
quiesce mentions only suspend:

	/* Suspend retains the resources, but has already stopped activity. */
	if (priv->datapath == STMMAC_DATAPATH_RUNNING)
		stmmac_quiesce(priv);

HALTED also takes this path, and it additionally skips stmmac_free_irq().
Could both comments be updated to cover HALTED?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260924-submit-stmmac-reset-fixes-v1-v3-0-c031e3f3a282%40gmail.com
