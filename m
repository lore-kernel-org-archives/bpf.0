Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21863ACA6F;
	Wed, 30 Sep 2026 04:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790743902; cv=none; b=FyLC9R5eibJo6QfDmcWKZxEGAi1IxDqvc45XTnjQi3uYG/AujBVtvAy0ZgpsEBjUcN02MmeAmGlZGPZJHDsYNAye90HpNY1ZLmW8GxOZeLUiAZjF1uASno8xYsuSSLcsM7uTbC29+9usN4DVGiazgfOjbfrHAlCnFRNTKj80ZjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790743902; c=relaxed/simple;
	bh=T6ibDnTpiHutHQITLg9cC60kmHUzLfnB+10cYsIpJUg=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=F9hqdxlSvL4soMU0l74S+V60AbUT0KK34tkSzf7Ha9iShamZcrN+aGsWLx/zohUH7mrZ5yC4X/wVOYbiSOETI/ytfwjkGhKXPd91yW+xUV/GaDC7HtgAf8HFaPsvKkXZ0VZjb7w5X1ibXOxCTXag5LMXbjjhQhjgYstgndjFdms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JePAsTDI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JePAsTDI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F5FF1F00893;
	Wed, 30 Sep 2026 04:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790743900;
	bh=v3Q5dcFAVU+NwhXPhRNKj0pC2C86kvAfDkG75WWLLeQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=JePAsTDIb2oiMyZhAxCHPa6UIm8l6Cb2bRv3ZHPg86Nj5QKvRz1u9R1pM8sZFl9P6
	 GsPO1x7EHXrPKD0/7wY53l6dmXU4aXMN617ka4hmWuIDlHbh2lA0kWEScFP+fAEkEO
	 It8BJFxuadfqSd2tBzeDzj9CUPl+FpbBNWjJvyMehP8nPGpeBgzHi40zlrDigczwPC
	 VqRzZLDABTLwcfBJbM8iuTjlrR9rArxWfl6k7Bhr0gXikpGyXmr0/XqZ0JW9nB7Oup
	 3UE5+wBU3M1l0y5zLqUjjS594YkZOBcEuvYUncRtvRFxMajBGNNGYskP2gGKgPnmcw
	 6o6bZ/gwxy3AQ==
Subject: Re: [PATCH net v4 05/15] net: stmmac: serialize and retain PHC
 configuration across reset
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
Date: Wed, 30 Sep 2026 04:51:36 +0000
Message-ID: <179074389696.434549.7137155395365644997@kernel.org>
In-Reply-To:
 <20260926-submit-stmmac-reset-fixes-v1-v4-5-ec1c0250b3c9@gmail.com>
References:
 <20260926-submit-stmmac-reset-fixes-v1-v4-5-ec1c0250b3c9@gmail.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 7 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 4 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] While ptp_blocked is set, stmmac_common_interrupt() skips
  stmmac_timestamp_interrupt() completely.
- [Medium] System resume re-initializes the PTP block but never replays
  or clears the new retained PHC state.
- [Medium] The commit says it serializes timestamp writers and devlink
  timestamp-mode updates with ptp_mutex.
- [Medium] While ptp_blocked is set, stmmac_get_time() now returns -EBUSY
  and writes a zero timespec.
- [Medium] stmmac_dl_ts_coarse_set() now runs under ptp_mutex/ptp_lock,
  but it still calls stmmac_update_subsecond_increment().
- [Low] __stmmac_enable() caches the PEROUT start and period exactly as
  userspace supplied them in priv->pps[] whenever flex_pps_config…
- [Low] When an EXTTS request's ATSFC FIFO-clear poll times out,
  __stmmac_enable() and dwmac1000_ptp_enable() have already written the…

--

net: stmmac: serialize and retain PHC configuration across reset

This commit caches the PHC frequency correction, PEROUT requests and EXTTS
selection in stmmac_priv, so that a new stmmac_ptp_restore() helper can
replay them after a MAC reset. It adds ptp_mutex and a ptp_blocked gate to
serialize PHC writers with resets, and stmmac_get_time() now returns
-EBUSY while the gate is set.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 4f3d452c35036..8b0bc7c46df93 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -941,6 +941,11 @@ static void stmmac_setup_ptp(struct stmmac_priv *priv)
>  {
>  	int ret;
>  
> +	priv->ptp_scaled_ppm = 0;
> +	priv->ptp_perout = 0;
> +	priv->ptp_extts = 0;
> +	priv->ptp_blocked = false;
> +

[Severity: Medium]
Does the retained state stay consistent across system resume?

These caches are only cleared in stmmac_setup_ptp(). At the end of the
series, stmmac_resume() calls stmmac_hw_setup(ndev, false, false), which
resets the MAC, and then does:

stmmac_resume() {
    ...
	mutex_lock(&priv->ptp_mutex);
	stmmac_init_timestamping(priv);
	ret = stmmac_tc_restore_est(priv);
	if (!ret)
		stmmac_block_ptp(priv, false);
    ...
}

That programs the default addend and loses PEROUT/EXTTS in hardware.
Resume does not call stmmac_ptp_restore(), and it does not clear
ptp_scaled_ppm, ptp_perout, ptp_extts or pps[].

So after resume the hardware has no frequency correction and no periodic
outputs, but the cache still says they are active. A later jumbo MTU
change or XDP reset fallback then goes through stmmac_ptp_restore(). That
re-applies the old frequency correction and restarts PEROUT/EXTTS without
any request from userspace.

Should resume either replay the cache or reset it?

[ ... ]

> @@ -6285,7 +6290,8 @@ static void stmmac_common_interrupt(struct stmmac_priv *priv)
>  		for (queue = 0; queue < queues_count; queue++)
>  			stmmac_host_mtl_irq_status(priv, priv->hw, queue);
>  
> -		stmmac_timestamp_interrupt(priv, priv);
> +		if (!READ_ONCE(priv->ptp_blocked))
> +			stmmac_timestamp_interrupt(priv, priv);

[Severity: High]
Can this cause an interrupt storm while ptp_blocked is set?

timestamp_interrupt() in stmmac_hwtstamp.c is the only place that reads
the timestamp status register, and that read is what clears TSIS:

	ts_status = readl(priv->ioaddr + GMAC_TIMESTAMP_STATUS);

dwmac4_irq_status() does not touch that register, and GMAC_INT_TSIE is
part of GMAC_INT_DEFAULT_ENABLE.

At the end of the series, stmmac_reconfigure_mtu() sets ptp_blocked while
the MAC IRQ is still registered and enabled. Only the DMA channel sources
are masked. stmmac_ptp_restore() also re-arms EXTTS while the gate is
still closed.

Suppose an aux snapshot event (for example a 1 Hz external PPS on an
EXTTS input) or a PPS target time event arrives in that window. TSIS
then stays asserted. With a level-triggered MAC interrupt,
stmmac_interrupt() keeps returning IRQ_HANDLED, so the spurious IRQ
detector never steps in.

If that IRQ fires on the CPU running the MTU transaction, can the reset
thread ever get to stmmac_block_ptp(priv, false)?

Would it help to read and discard the status, or to mask TSIE, while
blocked?

[ ... ]

> @@ -7696,6 +7702,14 @@ static int stmmac_dl_ts_coarse_set(struct devlink *dl, u32 id,
>  {
>  	struct stmmac_devlink_priv *dl_priv = devlink_priv(dl);
>  	struct stmmac_priv *priv = dl_priv->stmmac_priv;
> +	unsigned long flags;
> +
> +	mutex_lock(&priv->ptp_mutex);
> +	if (priv->ptp_blocked) {
> +		mutex_unlock(&priv->ptp_mutex);
> +		return -EBUSY;
> +	}
> +	write_lock_irqsave(&priv->ptp_lock, flags);
>  
>  	priv->tsfupdt_coarse = ctx->val.vbool;

[Severity: Medium]
The commit message says:

    Serialize timestamp writers and devlink timestamp-mode updates with a
    mutex

Are all of the timestamp writers covered? Two paths write the same state
without taking ptp_mutex or ptp_lock:

  stmmac_hwtstamp_set()
  stmmac_setup_ptp()->stmmac_init_timestamping()->stmmac_init_tstamp_counter()

The shared state is systime_flags, sub_second_inc, default_addend and
the PTP_TCR/SSIR/addend registers.

stmmac_dl_ts_coarse_set() runs under the devlink instance lock, not RTNL.
stmmac_hwtstamp_set() runs under RTNL and does:

	priv->systime_flags = STMMAC_HWTS_ACTIVE;
	if (!priv->tsfupdt_coarse)
		priv->systime_flags |= PTP_TCR_TSCFUPDT;
	...
	stmmac_config_hw_tstamping(priv, priv->ptpaddr, priv->systime_flags);

Suppose hwtstamp_set writes TCR with the old TSCFUPDT after devlink has
already computed SSINC and the addend for the new mode. Wouldn't the PHC
then run in one update mode with an increment computed for the other?

The same interleaving looks possible with stmmac_open(), because the
devlink param is registered at probe. This is still the case at the end
of the series.

> @@ -7708,6 +7722,8 @@ static int stmmac_dl_ts_coarse_set(struct devlink *dl, u32 id,
>  	 * reconfigure the systime, subsecond increment and addend.
>  	 */
>  	stmmac_update_subsecond_increment(priv);
> +	write_unlock_irqrestore(&priv->ptp_lock, flags);
> +	mutex_unlock(&priv->ptp_mutex);

[Severity: Medium]
Should the retained state be re-applied here?
stmmac_update_subsecond_increment() rewrites SSINC and programs the
uncorrected addend:

	priv->default_addend = div_u64(temp, priv->plat->clk_ptp_rate);
	stmmac_config_addend(priv, priv->ptpaddr, priv->default_addend);

After this the hardware has lost the frequency correction, but
priv->ptp_scaled_ppm still records it.

Running flex PPS outputs keep INTERVAL/WIDTH values that were computed in
units of the old sub_second_inc. Their real period and width therefore
change, while pps[] and ptp_perout still describe the requested period.

The next reset replays the cache, which abruptly changes frequency and PPS
timing again. This path already holds ptp_mutex. Could the replay done in
stmmac_ptp_restore() also be applied here? This is unchanged at the end of
the series.

[ ... ]

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
> index 3bfcc9760dce7..bc6fe0c87e01a 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c

[ ... ]

> @@ -128,14 +150,18 @@ static int stmmac_get_time(struct ptp_clock_info *ptp, struct timespec64 *ts)
>  	    container_of(ptp, struct stmmac_priv, ptp_clock_ops);
>  	unsigned long flags;
>  	u64 ns = 0;
> +	int ret = 0;
>  
>  	read_lock_irqsave(&priv->ptp_lock, flags);
> -	stmmac_get_systime(priv, priv->ptpaddr, &ns);
> +	if (priv->ptp_blocked)
> +		ret = -EBUSY;
> +	else
> +		stmmac_get_systime(priv, priv->ptpaddr, &ns);
>  	read_unlock_irqrestore(&priv->ptp_lock, flags);
>  
>  	*ts = ns_to_timespec64(ns);
>  
> -	return 0;
> +	return ret;
>  }

[Severity: Medium]
What happens to in-kernel callers that ignore the gettime64 return value?
While blocked, this returns -EBUSY and also writes a zero timespec.

At this commit, tc_taprio_configure() ignores the result:

	priv->ptp_clock_ops.gettime64(&priv->ptp_clock_ops, &current_time);

It would then compute the EST base time from 0. A later commit in the
series, "net: stmmac: restore TC offloads before restarting DMA", fixes
that caller: it checks the return value and runs under ptp_mutex.

The virtual clock path still looks affected at the end of the series.
stmmac has no getcycles64, so the core falls back to
ptp_getcycles64()->gettime64, and ptp_vclock_read() drops the error:

	ptp->info->getcycles64(ptp->info, &ts);

	return timespec64_to_ns(&ts);

The vclock uses a CYCLECOUNTER_MASK(32) cyclecounter. A refresh or read
that lands in a blocked window records a delta of
(0 - cycle_last) & 0xffffffff, and the next real read adds another one.
Can the vclock then jump by about 2^32 ns (4.29 s)?

The window also covers a case where the PHC is never reset:
stmmac_reconfigure_mtu() jumps to its restart label when
stmmac_prepare_rx_buffers() fails. Before this series the PHC was
unregistered across an MTU reopen, so vclocks could not see this state.

[ ... ]

> +static int stmmac_enable(struct ptp_clock_info *ptp,
> +			 struct ptp_clock_request *rq, int on)
> +{
> +	struct stmmac_priv *priv =
> +		container_of(ptp, struct stmmac_priv, ptp_clock_ops);
> +	int ret;
> +
> +	ret = stmmac_ptp_begin(priv);
> +	if (ret)
> +		return ret;
> +	ret = __stmmac_enable(ptp, rq, on);
> +	if (!ret) {
> +		if (rq->type == PTP_CLK_REQ_PEROUT) {
> +			if (on)
> +				priv->ptp_perout |= BIT(rq->perout.index);
> +			else
> +				priv->ptp_perout &= ~BIT(rq->perout.index);
> +		} else if (rq->type == PTP_CLK_REQ_EXTTS) {
> +			priv->ptp_extts = on ? BIT(rq->extts.index) : 0;
> +		}
> +	}

[Severity: Low]
Can ptp_extts get out of sync with the hardware when the ATSFC poll
times out? In __stmmac_enable(), the new ATSEN state and
STMMAC_FLAG_EXT_SNAPSHOT_EN are written before the poll that can fail:

		writel(acr_value, ptpaddr + PTP_ACR);
		mutex_unlock(&priv->aux_ts_lock);
		/* wait for auxts fifo clear to finish */
		ret = readl_poll_timeout(ptpaddr + PTP_ACR, acr_value,

dwmac1000_ptp_enable() works the same way. It also calls
dwmac1000_timestamp_interrupt_cfg(priv, on) whatever the poll result.
Nothing is rolled back, but ptp_extts is only updated when ret == 0.

If a disable fails, the hardware is off while ptp_extts still holds
BIT(index). The next stmmac_ptp_restore() then re-enables an EXTTS
channel that the user asked to turn off. If an enable fails, the opposite
happens: the hardware keeps capturing, but replay won't re-arm the
channel.

> +	mutex_unlock(&priv->ptp_mutex);
> +	return ret;
> +}
> +
> +/* Called with ptp_mutex held and PHC access blocked across the MAC reset. */
> +int stmmac_ptp_restore(struct stmmac_priv *priv)
> +{

[ ... ]

> +	for (i = 0; !ret && i < STMMAC_PPS_MAX; i++) {
> +		struct stmmac_pps_cfg cfg = priv->pps[i];
> +
> +		if (!(priv->ptp_perout & BIT(i)))
> +			continue;
> +		stmmac_get_systime(priv, priv->ptpaddr, &ns);
> +		period = timespec64_to_ns(&cfg.period);
> +		/* Retain phase, but move an expired target into the future. */
> +		cfg.start = stmmac_calc_tas_basetime(timespec64_to_ktime(cfg.start),
> +						     ns + PTP_SAFE_TIME_OFFSET_NS, period);

[Severity: Low]
Are the cached PEROUT values checked before they are replayed here?
Whenever flex_pps_config accepts a request, __stmmac_enable() stores start
and period in priv->pps[] exactly as userspace supplied them.

A negative period such as sec=-1, nsec=999999999 wraps to a huge u64 in
the dwmac5/xgmac flex_pps_config, which accepts it. A negative start.sec
skips the fixup for start times in the past, because target_ns wraps.

On replay, timespec64_to_ns(&cfg.period) is negative and becomes
cycle_time for stmmac_calc_tas_basetime(). That function calls
div64_s64() with a negative divisor and does signed multiplications that
can overflow, so the resulting start time is meaningless. With
period == -1 and current - start == S64_MIN, the division would trap on
x86.

Would it make sense to reject non-positive or non-normalized periods and
negative starts before caching them?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260926-submit-stmmac-reset-fixes-v1-v4-0-ec1c0250b3c9%40gmail.com
