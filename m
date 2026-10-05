Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6CBF1CAA6D;
	Mon,  5 Oct 2026 04:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791175103; cv=none; b=FzsERdNGVCYM+QuhEhFulau44/NWHWQNjHFotceKv+aY1t+oDSNCaxm6TVo09YIixACq8hoTLMlonqZiH7GN0zbz7rnzNbc5OMVNmwHncm7JHGAzzs2CrGvfcd2PCQ83bwPCksFgxaArbQb5nRBFbUkS6gFPUUfI7tYyiJrf9W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791175103; c=relaxed/simple;
	bh=eNz3U7uwKRZGVS8C+R5CwsQPbKmkeZzbi1XqHYKzgak=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CuQ3f4kQ2IQYDm4hh7a1P1atbL0ucI3hXUBT9T0N8VweQLBXoUmX9bGDu43jk3CP/KJCk6vhBXzc0Rk7OAzT2Uh4Mja/2pd4vkoMGBb4CKRGz+U99mQDk4rHPZuusrBWrQVu+j36ULBgJVnqibhTe1nKpsGqkDH2xhQgSTlmoF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PLGX8rzv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PLGX8rzv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 284101F000FF;
	Mon,  5 Oct 2026 04:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791175101;
	bh=Hp0eT36ZoGYYwqx1P4uri5STuyS5zLwYbpHm41ewMko=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=PLGX8rzvtHB8iHSGX6CYjCbg/IqTHwTaZHMAgGffuVSQ0IYFDk24i6rOw/shYyNvs
	 /+mbSxo657QB7a2CIa57LgZRqrm2ND1fXCqx52c7gaeAqSkuxV6D1PghDb2SmqZolV
	 fhYrXtAiBIIeEZNXax1UEFSPnjsVIuTnxbg2jjqvNjewChNTyWDF/zG0YRHM/hxVu6
	 Tlu/WFx3vMfWGVC2Npech6xgqcXRzCV391BbWjYvV7TnDVFFOuvL9IteuDdNA7ESbS
	 +ebUEZnlOEGJYbsoJSlO1ZuH9m3gCV8JznW+P6OTVNsDxR2gpkWXWE3e7nO0BMYmN+
	 UR0EgevShLUyw==
Subject: Re: [PATCH net-next v4 3/4] net: stmmac: preserve the installed EST
 schedule on errors
From: netdev-bot+sashiko@kernel.org
To: james.hilliard1@gmail.com
Cc: netdev@vger.kernel.org, pabeni@redhat.com, kuba@kernel.org,
 lorenzo.bianconi@oss.qualcomm.com, andrew+netdev@lunn.ch, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 sdf@fomichev.me, Jose.Abreu@synopsys.com, linux@armlinux.org.uk,
 edumazet@google.com, davem@davemloft.net, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, fancer.lancer@gmail.com, horms@kernel.org,
 maxime.chevallier@bootlin.com, richardcochran@gmail.com,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
Date: Mon, 05 Oct 2026 04:38:19 +0000
Message-ID: <179117509969.434549.14027278696780761740@kernel.org>
In-Reply-To:
 <20260930-stmmac-est-reapply-after-open-v4-3-9d4366587b73@gmail.com>
References:
 <20260930-stmmac-est-reapply-after-open-v4-3-9d4366587b73@gmail.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 8 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 (3) · Low: 6

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] tc_taprio_configure() (stmmac_tc.c:1022-1023) now rejects
  TAPRIO_CMD_REPLACE with -EOPNOTSUPP whenever priv->ptp_enabled is…
- [Medium] The new rollback in tc_taprio_configure() rewrites the EST
  registers right after the replacement schedule has been armed.
- [Low] This concern said that stmmac_setup_est() in stmmac_est.h has no
  callers and that the tc_taprio_configure() comment refers to a 'reset…
- [Low] The `!priv->ptp_clock_ops.gettime64` test in
  tc_taprio_configure() (stmmac_tc.c:1022) is now dead and misleading.
- [Low] The comment on __stmmac_setup_est() (stmmac_est.c:83) says it
  programs 'either the installed schedule or an unpublished…
- [Low] stmmac_est.h has no include guard.
- [Low] The new scratch buffer `est = kzalloc_obj(*est)`
  (stmmac_tc.c:1036) holds a struct stmmac_est.
- [Low] stmmac_setup_ptp() registers the PHC (stmmac_main.c:975) before
  it sets priv->ptp_enabled = true (line 976).

Pre-existing issues:
- [Medium] stmmac_set_time() (the settime64 op, stmmac_ptp.c:133-145)
  steps the PHC under ptp_lock only.
- [Medium] The TX hot paths (stmmac_xmit, stmmac_xdp_xmit_zc,
  stmmac_xdp_xmit_xdpf) read priv->est.enable and priv->est.max_sdu[]…
- [Medium] This concern said that after stmmac_hw_setup() ->
  stmmac_init_dma_engine() -> stmmac_reset() clears the EST block,…

--

net: stmmac: preserve the installed EST schedule on errors

This patch builds a TAPRIO replacement schedule in a separately allocated
struct stmmac_est. It copies that schedule to priv->est only after the
hardware accepts it, and restores the installed schedule on failure. A
shared __stmmac_setup_est() helper is used for new schedules, rollback
and stmmac_adjust_time(), which now holds est_lock across the whole clock
step.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_est.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_est.c
> index f15d4d046aa74..15c2d1794e229 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_est.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_est.c
> @@ -80,6 +80,47 @@ static int est_configure(struct stmmac_priv *priv, struct stmmac_est *cfg,
>  	return 0;
>  }
>  
> +/* Program either the installed schedule or an unpublished replacement. */
> +int __stmmac_setup_est(struct stmmac_priv *priv, struct stmmac_est *est)
> +{

[ ... ]

> +	lockdep_assert_held(&priv->est_lock);
> +
> +	if (!priv->ptp_enabled)
> +		return -EOPNOTSUPP;

[Severity: Low]
stmmac_setup_ptp() registers the PHC before it sets ptp_enabled:

drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:stmmac_setup_ptp() {
    ...
	stmmac_ptp_register(priv);
	priv->ptp_enabled = true;
    ...
}

Suppose an adjtime lands in that window while priv->est.enable is set.
stmmac_adjust_time() then disables EST and steps the clock, and this
check returns -EOPNOTSUPP, which leaves EST off in hardware.

At this commit, stmmac_hw_setup() has already reset EST before
stmmac_setup_ptp() runs. The later patch "net: stmmac: restore EST before
starting DMA on open and resume" re-arms EST via stmmac_setup_est() right
after stmmac_setup_ptp(). What remains is that adjtime returns
-EOPNOTSUPP for a clock step that was actually applied.

Is that return value intended?

> +
> +	read_lock_irqsave(&priv->ptp_lock, flags);
> +	err = stmmac_get_systime(priv, priv->ptpaddr, &now);
> +	read_unlock_irqrestore(&priv->ptp_lock, flags);

[Severity: Medium]
This is a pre-existing issue, but stmmac_set_time() (the settime64 op)
steps the PHC while holding only ptp_lock:

drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c:stmmac_set_time() {
    ...
	write_lock_irqsave(&priv->ptp_lock, flags);
	stmmac_init_systime(priv, priv->ptpaddr, ts->tv_sec, ts->tv_nsec);
	write_unlock_irqrestore(&priv->ptp_lock, flags);
    ...
}

It does not take est_lock, does not disable EST and does not replay the
schedule. Can a settime land between this PHC read and the EST register
writes below? Can a settime after a schedule is installed leave the
hardware BTR stale?

The commit message's "Hold est_lock throughout a clock step" covers only
the adjtime path. The old tc_taprio_configure() and stmmac_adjust_time()
were not serialized against settime64 either.

[ ... ]

> +	err = stmmac_est_configure(priv, priv, est,
> +				   priv->plat->clk_ptp_rate, true);
> +	if (err)
> +		netdev_err(priv->dev, "failed to re-configure EST\n");

[Severity: Low]
This isn't a bug, but this helper now also does the first install of a
new schedule from tc_taprio_configure(). The message removed there was
"failed to configure EST".

A failed initial install is now logged as a re-configure failure. On the
rollback path, "failed to restore EST" follows this message. Would
"failed to configure EST" be more accurate here?

> +
> +	return err;
> +}
> +
>  static void est_irq_status(struct stmmac_priv *priv, struct net_device *dev,
>  			   struct stmmac_extra_stats *x, u32 txqcnt)
>  {
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_est.h b/drivers/net/ethernet/stmicro/stmmac/stmmac_est.h
> index f70221c9c84af..5665e7a539948 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_est.h
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_est.h
> @@ -65,3 +65,16 @@
>  #define EST_GCL_DATA			0x00000034
>  
>  extern const struct stmmac_est_ops dwmac510_est_ops;
> +
> +int __stmmac_setup_est(struct stmmac_priv *priv, struct stmmac_est *est);
> +static inline int stmmac_setup_est(struct stmmac_priv *priv)
> +{
> +	int ret = 0;
> +
> +	mutex_lock(&priv->est_lock);
> +	if (priv->est.enable)
> +		ret = __stmmac_setup_est(priv, &priv->est);
> +	mutex_unlock(&priv->est_lock);
> +
> +	return ret;
> +}

[Severity: Low]
stmmac_setup_est() has no callers at this commit. The new comment in
tc_taprio_configure() also refers to a "reset replay" consumer that does
not exist yet.

The last patch in the series, "net: stmmac: restore EST before starting
DMA on open and resume", adds callers in __stmmac_open() and
stmmac_resume(). At the end of the series the helper and the comment are
both accurate.

Would it make sense to add this helper in that patch instead?

[Severity: Low]
stmmac_est.h has no include guard. Until now it held only macros and an
extern declaration, which are safe to include more than once.

This adds a static inline body that dereferences priv->est_lock and
priv->est and calls mutex_lock(). Would a second inclusion cause a
redefinition error? Does the header now silently depend on stmmac.h being
included first?

All current includers include stmmac.h first and include this header
once, so the build works today.

[Severity: Medium]
This is a pre-existing issue, but stmmac_hw_setup() clears the EST block:

stmmac_hw_setup()->stmmac_init_dma_engine()->stmmac_reset()

At this commit, nothing re-programs EST afterwards while priv->est.enable
stays set.

The last patch in the series, "net: stmmac: restore EST before starting
DMA on open and resume", fixes this. It calls stmmac_setup_est() in
__stmmac_open() after stmmac_setup_ptp(), and in stmmac_resume() before
stmmac_start_all_dma(). Those cover both callers of stmmac_hw_setup().

[ ... ]

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
> index 67c6fc32d0ea6..58dda3282973e 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c

[ ... ]

> @@ -979,6 +980,9 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
>  	if (!priv->dma_cap.estsel)
>  		return -EOPNOTSUPP;
>  
> +	if (ctr > (u64)U32_MAX * NSEC_PER_SEC)
> +		return -ERANGE;
> +
>  	switch (wid) {
>  	case 0x1:
>  		wid = 16;
> @@ -1015,6 +1019,8 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
>  
>  	if (qopt->cmd == TAPRIO_CMD_DESTROY)
>  		goto disable;
> +	if (!priv->ptp_enabled || !priv->ptp_clock_ops.gettime64)
> +		return -EOPNOTSUPP;

[Severity: Medium]
Does this reject TAPRIO_CMD_REPLACE whenever the interface is down?

priv->ptp_enabled is set only in stmmac_setup_ptp(), called from
__stmmac_open(), and stmmac_release_ptp() clears it on close. Neither
stmmac_setup_tc() nor tc_setup_taprio() checks netif_running().

Before this patch, a full-offload taprio replace on a down interface read
the PHC through gettime64, programmed EST and succeeded. Now it fails
with -EOPNOTSUPP on a MAC that has estsel set:

  ip link set dev X down
  tc qdisc replace dev X root taprio ... flags 0x2
    -> tc_taprio_configure()
       -> return -EOPNOTSUPP

An installed schedule already survives a down/up cycle, and the later
"restore EST ... on open" patch replays it on open. Could a replace while
down be cached in the same way instead of being rejected?

The commit message mentions neither this gate nor the new -ERANGE check
for cycle_time > U32_MAX * NSEC_PER_SEC above.

[Severity: Low]
This isn't a bug, but is the gettime64 test still needed?

__stmmac_setup_est() no longer reads the PHC through gettime64. It checks
priv->ptp_enabled itself and uses stmmac_get_systime().

Also, priv->ptp_clock_ops is copied at hwif init from
stmmac_ptp_clock_ops or dwmac1000_ptp_clock_ops. Both set .gettime64, so
this condition can never be true. stmmac_adjust_time() calls the same
helper without this check.

>  
>  	if (qopt->num_entries > dep)
>  		return -EINVAL;
> @@ -1023,25 +1029,27 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
>  	if (qopt->cycle_time_extension >= BIT(wid + 7))
>  		return -ERANGE;
>  
> -	mutex_lock(&priv->est_lock);
> -	memset(&priv->est, 0, sizeof(priv->est));
> -	mutex_unlock(&priv->est_lock);
> +	/* Build the replacement without changing the installed schedule. An
> +	 * entry rejected below must not leave an enabled, zero-cycle cache for
> +	 * PHC adjustment or reset replay to consume.
> +	 */
> +	est = kzalloc_obj(*est);
> +	if (!est)
> +		return -ENOMEM;

[Severity: Low]
This isn't a bug, but struct stmmac_est is about 8268 bytes because
gcl_unaligned[] and gcl[] each hold EST_GCL (1024) u32 entries.

That is larger than the biggest kmalloc cache on 4K page systems, so every
taprio replace makes a physically contiguous order-2 allocation. The
buffer is short-lived and allocated in sleepable context. Would
kvzalloc_obj() with kvfree() be a better fit?

[ ... ]

> +	mutex_lock(&priv->est_lock);
> +	ret = __stmmac_setup_est(priv, est);
> +	if (ret)
> +		goto restore;
>  
>  	ret = stmmac_fpe_map_preemption_class(priv, priv->dev, extack,
> -					      qopt->mqprio.preemptible_tcs);
> +					     qopt->mqprio.preemptible_tcs);
>  	if (ret)
> -		goto disable;
> +		goto restore;
>  
> -	return 0;
> +	priv->est = *est;

[Severity: Medium]
This is a pre-existing issue, but stmmac_xmit(), stmmac_xdp_xmit_zc() and
stmmac_xdp_xmit_xdpf() read priv->est.enable and priv->est.max_sdu[] with
no est_lock and no READ_ONCE().

Can a packet sent during this struct copy be checked against a mix of old
and new max_sdu values?

The old memset() followed by field-by-field updates had the same race,
with intermediate states at least as bad, so the struct copy does not
make it worse.

> +	mutex_unlock(&priv->est_lock);
> +free_est:
> +	kfree(est);
> +	return ret;
> +
> +restore:
> +	/* A failed hardware update must not publish the rejected schedule. */
> +	if (priv->est.enable)
> +		err = __stmmac_setup_est(priv, &priv->est);
> +	else
> +		err = stmmac_est_configure(priv, priv, &priv->est,
> +					   priv->plat->clk_ptp_rate, false);

[Severity: Medium]
When stmmac_fpe_map_preemption_class() fails, __stmmac_setup_est(priv,
est) has already armed the replacement through est_configure(..., true):

	if (enable)
		ctrl |= EST_EEST | EST_SSWL | EST_DFBS;

SSWL asks the hardware to switch lists at the programmed BTR, and it stays
set until the switch happens. When base_time is in the past, that is
usually about one cycle later.

This restore rewrites the GCL and the other EST registers microseconds
later. It does not clear EEST or wait for SSWL first.

An admin can trigger the FPE failure. dwmac5_fpe_map_preemption_class()
returns -EINVAL with SP scheduling when a preemptible TC spans several
queues, or when queue weights differ.

If the hardware aborts indirect GCL writes while SSWL is pending (the
Synopsys EST programming model describes this), est_write() would not
notice, because it only polls SRWO:

	return readl_poll_timeout(est_addr + EST_GCL_CONTROL, ctrl,
				  !(ctrl & EST_SRWO), 100, 5000);

Could the restore then return 0 while the hardware later switches to the
rejected schedule, and priv->est still describes the old one?

Would checking the FPE mapping before arming the replacement, or waiting
for SSWL to clear, avoid this?

> +	if (err)
> +		netdev_err(priv->dev, "failed to restore EST\n");
> +	mutex_unlock(&priv->est_lock);
> +	goto free_est;

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260930-stmmac-est-reapply-after-open-v4-0-9d4366587b73%40gmail.com
