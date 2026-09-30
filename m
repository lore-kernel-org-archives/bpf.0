Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E433909A2;
	Wed, 30 Sep 2026 04:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790743923; cv=none; b=kVTuu1Ox4Zg3rAoo6SCLxfw1x9wY2DvZ8TfjZQWK1Ryw5WFPq6SlmrSfY6t5AE3P/ww3P/3UJ+l0Hy9tt0+MYq36vsuA2zQ51DYMr5WUsd4xFh/bYBtnZ/WtWW4VwRM/8SKpSPVGcs4L1G7DYZ28ZcEDm3vHMiYP/7SwFi/ZnMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790743923; c=relaxed/simple;
	bh=bSzK4vyx7DcIlXR9DnpD48c2SchuyupmnnSgCckfqV0=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OzWhA70t3OV7BootqwUu+D5+ocyTYJuiDO8MgkSRhdphx/sawxn+kyaUBVv5EA7MRkLRVo3QuUIanTiqKPBoe9p5in7JfC8KoNQusBx1go98GuG45xTmDtYhrJFym94XbqZTqOz8x8O8bkKR0D7u+sEKdpbabIbj8G7c91kpGOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bwyHTm+l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bwyHTm+l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58ECE1F00898;
	Wed, 30 Sep 2026 04:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790743917;
	bh=tUfkIuIu01TE09unIbwfyc+jw+tUIQD5Z08Cnsfr7Cg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=bwyHTm+l2GDzc0P92NdG1ctDhgVg1QhX5jCoXfUrPsSqvrYSHY21jGSLr5PnJ+7yK
	 JpW31PCHmgxEqsl3aNupQ37yi9Xacp7XWlP2rMoz1wc/CQYaWingQe3RSlnRna9zlL
	 hK0LeAmZZ/xGLW1egqoAkxyzZ/3ch/8f1aeeRz4HXiWf/hOQSE0H3zQaqsxmbT1mBW
	 oc0udvv0IT/2/lFn7zaZz+p2aE74og6Qa9pv4FHVl0pVYJwlSPZ+HESggrGAI9kNfM
	 LThaaXPVUfBBAt8IrKuc8Cr026IMYQZVSwrhOz2jOGBAH7XkxhnHwnuzqnpkOR2Xku
	 3rCLfBNTlLqXA==
Subject: Re: [PATCH net v4 11/15] net: stmmac: restore TC offloads before
 restarting DMA
From: netdev-bot+sashiko@kernel.org
To: james.hilliard1@gmail.com
Cc: linux@armlinux.org.uk, andrew@lunn.ch, hkallweit1@gmail.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 qiangqing.zhang@nxp.com, rmk+kernel@armlinux.org.uk,
 maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, ansuelsmth@gmail.com,
 yangtiezhu@loongson.cn, chenhuacai@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 sdf@fomichev.me, fancer.lancer@gmail.com, quic_jsuraj@quicinc.com,
 richardcochran@gmail.com, Joao.Pinto@synopsys.com, vladimir.oltean@nxp.com,
 boon.leong.ong@intel.com, weifeng.voon@intel.com, yoong.siang.song@intel.com,
 linusw@kernel.org, martin.blumenstingl@googlemail.com,
 magnus.karlsson@intel.com, maciej.fijalkowski@intel.com, horms@kernel.org,
 bjorn@kernel.org, thierry.reding@kernel.org, jonathanh@nvidia.com,
 wens@kernel.org, jernej.skrabec@gmail.com, samuel@sholland.org,
 edumazet@kernel.org, richard.genoud@bootlin.com, alastair@d-silva.org,
 mripard@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org,
 zhaojinming@uniontech.com, lorenzo.bianconi@oss.qualcomm.com,
 dinghui1111@163.com, linux-tegra@vger.kernel.org, linux-sunxi@lists.linux.dev
Date: Wed, 30 Sep 2026 04:51:53 +0000
Message-ID: <179074391390.434549.14176681299170404417@kernel.org>
In-Reply-To:
 <20260926-submit-stmmac-reset-fixes-v1-v4-11-ec1c0250b3c9@gmail.com>
References:
 <20260926-submit-stmmac-reset-fixes-v1-v4-11-ec1c0250b3c9@gmail.com>
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

Critical: 0 · High: 2 · Medium: 3 (1) · Low: 1 (2)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The patch saves VLAN-priority steering in
  priv->plat->rx_queues_cfg[tc] and relies on stmmac_mtl_configuration()…
- [High] On XGMAC, the runtime TC-to-queue mapping that this patch
  restores is corrupted again before DMA starts.
- [Medium] The patch fixes a real divide-by-zero crash but does not say
  so and has no Fixes: tag.
- [Medium] When tc_taprio_configure() fails after programming the new
  schedule (stmmac_est_configure() or tc_config_preemption() fails), the…
- [Medium] stmmac_tc_restore_filters() walks
  priv->flow_entries[0..flow_entries_max) and…
- [Low] EST replay and DMA start go ahead even when timestamp setup
  failed.

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but
  tc_config_flow() programs port_src and then port_dst into the same…
- [Low] This problem wasn't introduced by this patch, but a protocol-only
  flower rule (e.g. IPv4/UDP DROP with no address or port keys) is…
- [Low] This problem wasn't introduced by this patch, but
  dwmac4_config_l3_filter()/dwmac4_config_l4_filter() (and the XGMAC…

--

net: stmmac: restore TC offloads before restarting DMA

This patch saves L3/L4 flower rules, VLAN priority steering, EtherType
steering, the FPE preemption mapping and the EST schedule so they can be
replayed after a DMA software reset on open and resume. DMA start is
delayed until those offloads have been restored. TAPRIO replacement now
builds the new schedule separately and publishes it only after hardware
programming succeeds.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 618e01772ab86..edcb9a025385b 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c

[ ... ]

> @@ -4348,6 +4350,14 @@ static int __stmmac_open(struct net_device *dev,
>  	stmmac_init_coalesce(priv);
>  
>  	stmmac_vlan_restore(priv);
> +	mutex_lock(&priv->ptp_mutex);
> +	ret = stmmac_tc_restore_est(priv);
> +	mutex_unlock(&priv->ptp_mutex);
> +	if (ret)
> +		goto irq_error;
> +
> +	/* All reset-sensitive offloads must be installed before DMA runs. */
> +	stmmac_start_all_dma(priv);
>  
>  	ret = stmmac_request_irq(dev);
>  	if (ret)
> @@ -8722,10 +8732,14 @@ int stmmac_resume(struct device *dev)
>  		goto error_stop_dma;
>  	}
>  
> -	stmmac_init_timestamping(priv);
>  	mutex_lock(&priv->ptp_mutex);
> -	stmmac_block_ptp(priv, false);
> +	stmmac_init_timestamping(priv);
> +	ret = stmmac_tc_restore_est(priv);
> +	if (!ret)
> +		stmmac_block_ptp(priv, false);
>  	mutex_unlock(&priv->ptp_mutex);
> +	if (ret)
> +		goto error_stop_dma;

[Severity: Low]
The commit message says "Restore EST after the timestamp counter is
usable". The comment above stmmac_tc_restore_est() also says it is called
after timestamp setup. Does either caller actually enforce that?

In stmmac_resume(), the return value of stmmac_init_timestamping() is
ignored before stmmac_tc_restore_est() runs. Also,
stmmac_init_tstamp_counter() throws away the result of
stmmac_init_systime(), so a TSINIT timeout is reported as success.

In __stmmac_open(), stmmac_setup_ptp() returns void. It returns early if
clk_prepare_enable() fails for clk_ptp_ref, but stmmac_tc_restore_est()
and stmmac_start_all_dma() still run afterwards.

stmmac_get_systime() cannot fail when the callback exists. In these cases,
won't the replay compute a base time from a counter that was never
initialized, arm EST, and report success?

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
> index 9ded65750e89f..de254919f6ab7 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c

[ ... ]

> @@ -577,23 +559,46 @@ static int tc_add_ports_flow(struct stmmac_priv *priv,

[ ... ]

> +static int tc_config_flow(struct stmmac_priv *priv,
> +			  const struct stmmac_flow_entry *entry)
> +{
> +	bool inv = entry->action & STMMAC_FLOW_ACTION_DROP;
> +	bool udp = entry->ip_proto == IPPROTO_UDP;
> +	int ret;
> +
> +	/* Clear the whole slot, including matches removed by a replacement. */
> +	ret = stmmac_config_l3_filter(priv, priv->hw, entry->idx, false,
> +				      false, false, false, 0);

[Severity: Low]
This isn't a bug introduced by this patch, but dwmac4_config_l3_filter()
and dwmac4_config_l4_filter() do an unlocked read-modify-write of
MAC_PACKET_FILTER to set IPFE. The XGMAC equivalents do the same:

    value = readl(ioaddr + GMAC_PACKET_FILTER);
    value |= GMAC_PACKET_FILTER_IPFE;
    writel(value, ioaddr + GMAC_PACKET_FILTER);

tc_add_flow() holds only RTNL. The rx-mode set_filter path writes the same
register under the address lock.

Could a concurrent rx-mode update lose the IPFE bit? This clear-slot call
adds one more read-modify-write per add or replace, but the race itself
is unchanged.

> +	if (ret || !entry->in_use)
> +		return ret;

[ ... ]

> +	if (entry->port_src) {
>  		ret = stmmac_config_l4_filter(priv, priv->hw, entry->idx, true,
> -					      is_udp, false, inv, hw_match);
> +					    udp, true, inv, entry->port_src);
>  		if (ret)
>  			return ret;
>  	}
> -
> -	entry->is_l4 = true;
> +	if (entry->port_dst)
> +		return stmmac_config_l4_filter(priv, priv->hw, entry->idx, true,
> +					      udp, false, inv, entry->port_dst);
>  	return 0;
>  }

[Severity: Medium]
This is a pre-existing issue, but on dwmac4, is the source port match
still there after port_src and then port_dst are programmed into the same
slot?

Every call to dwmac4_config_l4_filter() clears both enables and rewrites
the whole GMAC_L4_ADDR register:

    value &= ~(GMAC_L4SPM0 | GMAC_L4SPIM0);
    value &= ~(GMAC_L4DPM0 | GMAC_L4DPIM0);
    ...
    writel(value, ioaddr + GMAC_L4_ADDR(filter_no));

As a result, a flower rule with both src and dst ports seems to match only
the dst port. That happens at install time and, with this patch, on every
reset replay too. The old tc_add_ports_flow() used the same call sequence.

[ ... ]

> @@ -637,23 +643,33 @@ static int tc_add_flow(struct stmmac_priv *priv,
>  			return -ENOENT;
>  	}
>  
> -	ret = tc_parse_flow_actions(priv, &rule->action, entry,
> +	new.idx = entry->idx;
> +	ret = tc_parse_flow_actions(priv, &rule->action, &new,
>  				    cls->common.extack);
>  	if (ret)
>  		return ret;
>  
>  	for (i = 0; i < ARRAY_SIZE(tc_flow_parsers); i++) {
> -		ret = tc_flow_parsers[i].fn(priv, cls, entry);
> +		ret = tc_flow_parsers[i].fn(priv, cls, &new);
>  		if (!ret)
> -			entry->in_use = true;
> +			new.in_use = true;
>  		else if (ret == -EOPNOTSUPP)
>  			return ret;
>  	}
>  
> -	if (!entry->in_use)
> +	if (!new.in_use)
>  		return -EINVAL;
>  
> -	entry->cookie = cls->cookie;
> +	ret = tc_config_flow(priv, &new);

[Severity: Low]
This isn't a bug introduced by this patch, but what happens with a
protocol-only rule, for example an IPv4/UDP drop with no address or port
keys?

tc_add_basic_flow() records only ip_proto and returns 0, which sets
new.in_use. The IPv4 and ports parsers return -EINVAL, and that is ignored
here.

tc_config_flow() then clears the slot, enables no match and returns 0.
The cookie is published and the rule is reported as offloaded, but it has
no effect in hardware. The baseline had the same false success.

[ ... ]

> @@ -739,6 +755,8 @@ static int tc_add_vlan_flow(struct stmmac_priv *priv,
>  
>  		prio = BIT(match.key->vlan_priority);
>  		stmmac_rx_queue_prio(priv, priv->hw, prio, tc);
> +		priv->plat->rx_queues_cfg[tc].prio = prio;
> +		priv->plat->rx_queues_cfg[tc].use_prio = true;
>  
>  		entry->in_use = true;
>  		entry->cookie = cls->cookie;
> @@ -760,6 +778,8 @@ static int tc_del_vlan_flow(struct stmmac_priv *priv,
>  
>  	if (stmmac_tc_active(priv))
>  		stmmac_rx_queue_prio(priv, priv->hw, 0, entry->tc);
> +	priv->plat->rx_queues_cfg[entry->tc].prio = 0;
> +	priv->plat->rx_queues_cfg[entry->tc].use_prio = true;
>  
>  	entry->in_use = false;
>  	entry->cookie = 0;

[Severity: High]
Can tc go past the end of rx_queues_cfg[] here?

rx_queues_cfg[] has MTL_MAX_RX_QUEUES (8) entries, and tx_queues_cfg[]
follows it in struct plat_stmmacenet_data. tc comes from
tc_classid_to_hwtc(), which only guarantees tc < netdev_get_num_tc().

taprio in txtime-assist mode allows overlapping TXQ ranges and can set up
to TC_MAX_QUEUE (16) traffic classes. A rule with "vlan_prio N hw_tc 8..15
skip_sw" would then write into tx_queues_cfg[] (CBS slopes, weights,
prio). tc_del_vlan_flow() uses entry->tc as the index in the same way.

Before this patch, tc_add_vlan_flow() only called stmmac_rx_queue_prio()
and did not write to the array.

Separately, does the saved copy match what the hardware holds?
dwmac4_rx_queue_priority() and dwxgmac2_rx_queue_prio() OR the new bit
into the target queue's PSRQ field and clear it from the other queues.
The saved value, however, is overwritten:

    priv->plat->rx_queues_cfg[tc].prio = prio;

With two VLAN priority rules on the same tc, both bits are set in
hardware, but only the last one would be replayed after a reset.

In tc_del_vlan_flow(), setting prio = 0 for the whole tc also drops any
other VLAN rule still installed on that tc. It also permanently removes
the board or DT priority for that queue.

A rule can also move priority p from DT queue r to queue q. In that case
rx_queues_cfg[r].prio still contains p. stmmac_mac_config_rx_queues_prio()
replays queues in ascending order. When r > q, wouldn't replaying r take
p back from q?

In addition, stmmac_mtl_configuration() only replays priorities for
queues below rx_queues_to_use, and only when rx_queues_to_use > 1:

    if (rx_queues_count > 1)
        stmmac_mac_config_rx_queues_prio(priv);

stmmac_tc_restore_filters() skips STMMAC_RFS_T_VLAN on the assumption
that stmmac_mtl_configuration() replays it. After open or resume, won't
the RX VLAN priority steering then differ from the installed flower
rules?

> @@ -934,6 +954,45 @@ static int tc_setup_cls(struct stmmac_priv *priv,
>  	return ret;
>  }
>  
> +int stmmac_tc_restore_filters(struct stmmac_priv *priv)
> +{
> +	int i, ret;
> +
> +	for (i = 0; i < priv->flow_entries_max; i++) {
> +		struct stmmac_flow_entry *entry = &priv->flow_entries[i];
> +
> +		if (!entry->in_use)
> +			continue;

[Severity: Medium]
Can priv->flow_entries be NULL here while flow_entries_max is non-zero?

tc_init() sets flow_entries_max from dma_cap->l3l4fnum before calling
devm_kcalloc(). If the allocation fails, it returns -ENOMEM with the
count still set. tc_rfs_init() does the same with rfs_entries_total and
rfs_entries.

__stmmac_dvr_probe() ignores the error:

    ret = stmmac_tc_init(priv, priv);
    if (!ret) {
        ndev->hw_features |= NETIF_F_HW_TC;
    }

Before this patch, these tables were only reached through flower
offload, which needs NETIF_F_HW_TC. Now stmmac_hw_setup() calls
stmmac_tc_restore_filters() on every open and resume. Wouldn't that
dereference NULL on every open and resume?

The RX parser replay nearby is already guarded with if (priv->tc_entries).

> +		ret = tc_config_flow(priv, entry);
> +		if (ret)
> +			return ret;
> +	}

[ ... ]

> +	/* The XGMAC callback also restores the runtime TC-to-queue mapping. */
> +	if (priv->fpe_cfg.mapping_configured)
> +		return tc_config_preemption(priv, NULL,
> +					    priv->fpe_cfg.preemptible_tcs);
> +	return 0;
> +}

[Severity: High]
On XGMAC, is this mapping still intact when DMA starts?

dwxgmac3_fpe_map_preemption_class() writes Q2TCMAP = tc using
u32_replace_bits(). However, stmmac_hw_setup() calls
stmmac_dma_operation_mode() after stmmac_tc_restore_filters(), and
dwxgmac2_dma_tx_mode() ORs in the channel without clearing the field:

    /* Use static TC to Queue mapping */
    value |= FIELD_PREP(XGMAC_Q2TCMAP, channel);

That would leave Q2TCMAP = tc | channel. For example, with mqprio 2@0 2@2,
queue 1 would move from TC 0 to TC 1, and queues 2 and 3 would move from
TC 1 to TC 3, which does not exist.

Should the replay run after stmmac_dma_operation_mode(), or should
dwxgmac2_dma_tx_mode() clear the field first?

[ ... ]

> @@ -1040,34 +1130,27 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
>  	if (qopt->cycle_time_extension >= BIT(wid + 7))
>  		return -ERANGE;
>  
> -	if (!priv->est) {
> -		priv->est = devm_kzalloc(priv->device, sizeof(*priv->est),
> -					 GFP_KERNEL);
> -		if (!priv->est)
> -			return -ENOMEM;
> -
> -		mutex_init(&priv->est_lock);
> -	} else {
> -		mutex_lock(&priv->est_lock);
> -		memset(priv->est, 0, sizeof(*priv->est));
> -		mutex_unlock(&priv->est_lock);
> -	}
> +	/* Build the replacement without changing the installed schedule. An
> +	 * entry rejected below must not leave an enabled, zero-cycle cache for
> +	 * PHC adjustment or reset replay to consume.
> +	 */
> +	est = kzalloc_obj(*est);
> +	if (!est)
> +		return -ENOMEM;
>  
>  	size = qopt->num_entries;
> -
> -	mutex_lock(&priv->est_lock);
> -	priv->est->gcl_size = size;
> -	priv->est->enable = qopt->cmd == TAPRIO_CMD_REPLACE;
> -	mutex_unlock(&priv->est_lock);
> +	est->gcl_size = size;
> +	est->enable = true;

[Severity: Medium]
This change fixes a divide-by-zero in the baseline, but the commit
message only says:

  "A rejected first install must not leave an enabled zero-cycle cache
  for PHC adjustment or reset replay."

In the baseline, every TAPRIO_CMD_REPLACE cleared priv->est with memset()
and set enable before the gate list was validated. An entry with an
out-of-range interval (for example more than 65535 ns with wid=16)
returned -ERANGE and left enable set with ctr[] still zero.
taprio_change() then keeps the previous qdisc and does not send DESTROY.

The next PHC step then reaches this code in stmmac_adjust_time():

    cycle_time = (u64)priv->est->ctr[1] * NSEC_PER_SEC + priv->est->ctr[0];
    time = stmmac_calc_tas_basetime(basetime, current_time_ns, cycle_time);

That ends up calling div64_s64() with a zero divisor. It affects any
rejected replace, not only the first install.

Could this fix be split into its own patch with a Fixes: tag and a commit
message that describes the crash, so it can go to stable without the rest
of the series?

[ ... ]

> +	*priv->est = *est;
> +	mutex_unlock(&priv->est_lock);
> +free_est:
> +	kfree(est);
> +	return ret;
> +
> +restore:
> +	/* A failed hardware update must not publish the rejected schedule. */
> +	if (stmmac_est_configure(priv, priv, priv->est, priv->plat->clk_ptp_rate))
> +		netdev_err(priv->dev, "failed to restore EST\n");
> +	mutex_unlock(&priv->est_lock);
> +	goto free_est;

[Severity: Medium]
Is priv->est->btr[] still safe to write back here?

It was computed when the old schedule was installed, or at the last PHC
adjust or reset replay. It is not rebased against the current PHC time
here. stmmac_tc_restore_est() and stmmac_adjust_time() both recompute it
from btr_reserve[] with stmmac_calc_tas_basetime().

est_configure() writes cfg->btr[] directly to EST_BTR_LOW/HIGH and sets
EEST | SSWL. The EST block only accepts a past BTR for a limited number
of cycles (EST_GMAC5_BTRL allows 15). Beyond that it raises BTRE and does
not switch lists.

User space can reach this path. One example is when
dwmac5_fpe_map_preemption_class() rejects the SP algorithm with
one-to-many TC mapping after EST has already been programmed.

In that case, could the hardware keep running the rejected schedule while
priv->est and the returned error say the old schedule is still active?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260926-submit-stmmac-reset-fixes-v1-v4-0-ec1c0250b3c9%40gmail.com
