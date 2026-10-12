Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9676536A009;
	Mon, 12 Oct 2026 08:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791795492; cv=none; b=NFvZ5tQVRVfXFjlUGOmrrjDg92QJK1usQ7lUn9eqQD2kPRpgqas/uIczxlbV/uoeo70nC8cz/z+6UTRE47wv1oTyr6sKmS5hoBL7ip6rBkIS13SvJhd7izk0i1NI1CaXSLUiN7JePxthW2enucrNqBOhULLdeEbj/AnGaDcMV9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791795492; c=relaxed/simple;
	bh=30VFGCRA0qJB0Bq1PBBcD4DWnr/FP3m5761PkCZqa38=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=W2I/Rty27c//S8hBfMZxNKTE9bVnU8B2BNGgWBJwQLVpOdgOi1ayESLLi+QnCnK8Gu89UPXzGwrkImYC9gAEuQpDphgljl2UA8blMJVMj6PRR+tAP7x8+US/m8oDkG43b6Wl5K8I6NIzAfIham64fzBOBJvxzKeRxg+3c7CxoTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZwaqRO+A; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BIj6kN4l; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZwaqRO+A";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BIj6kN4l"
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1791795488;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lEhppZbolJBBfUeHZTohEYrvVBHJFyiflHzlpvjk9QY=;
	b=ZwaqRO+AkpSt8dmvPcJKjxaAhjQqh1xmhmr2sVDa3CSZo7pgZbtlQ5JSC2lA1aSpULfjB+
	KKDUaazdj9Ax24BADaroUKqsZW7XBKQcMwInH2sIe/4rujkF+l7mLIhX/cM0MBjDyR/yGF
	9Rpz/mQtyeQ94swd4bDOqWukW/0+mVh/GvPUdqf+SSUz3X/OpjonTU7AvnzrKdgCNjV+9K
	UKxj+h3bKPze02npvbVBZqp0CA6p9H0hX1FUFx9roJpmUZrCwZZ/AWG2hjSEGKv1DMHgqf
	8AeextzcuGB+Oco2Q2j2nDlfvYx3ScvtWIv8yx7SF0nU5vKw+SJuMNvmPkJfog==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1791795488;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lEhppZbolJBBfUeHZTohEYrvVBHJFyiflHzlpvjk9QY=;
	b=BIj6kN4lEHbjxXiTrT+37wQM8K+6Afcl/eks2A4k2ZATpXO7IU6m7ME5XDz5/kMWncAJB0
	b0Vn6A3T6/h9UFCw==
To: netdev-bot+sashiko@kernel.org
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@kernel.org, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, ast@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me,
 yoong.siang.song@intel.com, noor.azura.ahmad.tarmizi@intel.com,
 faizal.abdul.rahim@intel.com, boon.leong.ong@intel.com,
 bigeasy@linutronix.de, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
Subject: Re: [PATCH net v2 1/2] net: stmmac: Disable NAPI before stopping Tx
 queues in stmmac_xdp_release()
In-Reply-To: <179148659257.434549.8899547962974012240@kernel.org>
References: <20261005-stmmac_xsk_crashes-v2-1-46c60cba6421@linutronix.de>
 <179148659257.434549.8899547962974012240@kernel.org>
Date: Mon, 12 Oct 2026 10:58:06 +0200
Message-ID: <878q43gush.fsf@jax.kurt.home>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu Oct 08 2026, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 2 (1) =C2=B7 Medium: 0 (1) =C2=B7 Low: 0
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
>
> - [High] Baseline decision: false.
> - [High] This patch reorders stmmac_xdp_release() so that
>   hrtimer_cancel() on every tx_q->txtimer now runs before=E2=80=A6
>
> Pre-existing issues:
> - [High] This problem was not introduced by this patch, but it is a use-
>   after-free in the same teardown sequence, and moving=E2=80=A6
> - [Medium] Baseline decision: false.
>
> --
>
> net: stmmac: Disable NAPI before stopping Tx queues in stmmac_xdp_release=
()
>
> This commit reorders stmmac_xdp_release() so that NAPI is disabled and the
> Tx coalescing timers are cancelled before netif_tx_disable() is called.
> The goal is to stop an in-flight Tx NAPI poll from waking the Tx queue
> again while free_dma_desc_resources() releases the descriptor rings.
>
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers=
/net/ethernet/stmicro/stmmac/stmmac_main.c
>> index 9741f97fa37a2..796817caf7af0 100644
>> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>> @@ -7178,15 +7178,15 @@ void stmmac_xdp_release(struct net_device *dev)
>>  	struct stmmac_priv *priv =3D netdev_priv(dev);
>>  	u8 chan;
>>=20=20
>> -	/* Ensure tx function is not running */
>> -	netif_tx_disable(dev);
>> -
>>  	/* Disable NAPI process */
>>  	stmmac_disable_all_queues(priv);
>>=20=20
>>  	for (chan =3D 0; chan < priv->plat->tx_queues_to_use; chan++)
>>  		hrtimer_cancel(&priv->dma_conf.tx_queue[chan].txtimer);
>>=20=20
>> +	/* Ensure tx function is not running */
>> +	netif_tx_disable(dev);
>
> [Severity: High]
> Now that netif_tx_disable() runs after the hrtimer_cancel() loop, can
> stmmac_xmit() re-arm tx_q->txtimer after it has been cancelled?
>
> Before this change, netif_tx_disable() took every txq lock first. Any
> running stmmac_xmit() had finished and the queues were stopped before the
> timers were cancelled.
>
> Now stmmac_xmit() can run at the same time as stmmac_disable_all_queues()
> and the cancel loop. It always ends by calling stmmac_tx_timer_arm():
>
> stmmac_tx_timer_arm() {
>     ...
> 	if (unlikely(!napi_is_scheduled(napi))) {
> 		if (unlikely(!(hrtimer_active(&tx_q->txtimer))))
> 			hrtimer_start(&tx_q->txtimer,
> 				      STMMAC_COAL_TIMER(tx_coal_timer),
> 				      HRTIMER_MODE_REL);
>     ...
> }
>
> One possible interleaving:
>
> CPU1 (stmmac_xmit)                  CPU0 (stmmac_xdp_release)
> stmmac_tx_timer_arm()
>   napi_is_scheduled() =3D=3D false
>                                     stmmac_disable_all_queues()
>                                       napi_disable() sets SCHED
>                                     hrtimer_cancel(&tx_q->txtimer)
>                                       timer not armed, returns 0
>   hrtimer_start(&tx_q->txtimer)
>                                     netif_tx_disable(dev)
>
> The timer then stays queued while the rings are freed. The timeout is 5ms
> by default and up to 100ms through ethtool -C tx-usecs.
>
> stmmac_xdp_set_prog() then calls stmmac_xdp_open(), which does:
>
> 	hrtimer_setup(&tx_q->txtimer, stmmac_tx_timer, CLOCK_MONOTONIC, HRTIMER_=
MODE_REL);
>
> __hrtimer_setup() memsets the timer while it is still linked in the
> hrtimer base timerqueue.
>
> Could that corrupt the timerqueue rbtree when the timer expires or is
> started again?
>
> Would this order avoid the problem: disable NAPI, then netif_tx_disable(),
> then hrtimer_cancel()?
>
> __stmmac_release() is cited in the commit message as the reference order,
> but it also cancels the timers before netif_tx_disable(). It may have the
> same window.

Looks like a possible issue even though I did not observe this. The
common cleanup code between stmmac_xdp_release() and __stmmac_release()
can be moved into a helper function in a later patch. This issue can be
addressed then.

>
> [Severity: High]
> The reproducer in the commit message opens an AF_XDP/ZC socket. When an
> XDP program is already attached, that goes through stmmac_xdp_setup_pool()
> -> stmmac_xdp_enable_pool() in stmmac_xdp.c, not stmmac_xdp_release():
>
> stmmac_xdp_enable_pool() {
>     ...
> 	if (need_update) {
> 		napi_disable(&ch->rx_napi);
> 		napi_disable(&ch->tx_napi);
> 		stmmac_disable_rx_queue(priv, queue);
> 		stmmac_disable_tx_queue(priv, queue);
> 	}
>     ...
> }
>
> stmmac_disable_tx_queue() frees the ring with stmmac_stop_tx_dma() and
> __free_dma_tx_desc_resources(). Nothing stops the netdev Tx queue.
> stmmac_xdp_disable_pool() follows the same pattern with ch->rxtx_napi.
>
> At this commit, can stmmac_xmit() keep writing into tx_q->dma_tx while the
> ring is freed and reallocated on these paths?
>
> The next patch in the series, "net: stmmac: Stop Tx queue when
> (en|dis)abling XSK pools", appears to address this. It adds
> stmmac_xdp_stop_tx_queue() after napi_disable() and netif_tx_wake_queue()
> after the queues are re-enabled, which closes the gap by the end of the
> series.

Yes, that's fixed in the second patch.

>
>> +
>>  	/* Free the IRQ lines */
>>  	stmmac_free_irq(dev, REQ_IRQ_ERR_ALL, 0);
>
> [Severity: Medium]
> This isn't a bug introduced by this patch, but the TX/DMA IRQ handlers
> stay registered after netif_tx_disable() until stmmac_free_irq() runs.
> STMMAC_DOWN is not set on this path.
>
> If a TX hard error arrives in that window, stmmac_msi_intr_tx() or
> stmmac_dma_interrupt() calls stmmac_tx_err(), which ends with:
>
> stmmac_tx_err() {
>     ...
> 	priv->xstats.tx_errors++;
> 	netif_tx_wake_queue(netdev_get_tx_queue(priv->dev, chan));
> }
>
> Can that reopen the queue so that stmmac_xmit() runs on rings that
> free_dma_desc_resources() is about to release?
>
> The window existed before this patch and was larger then. Hitting it needs
> a hardware DMA TX fatal error during XDP attach or detach.

Yes, i did not observe this while testing.

>
> [Severity: High]
> This is a pre-existing issue, not introduced by this patch. Moving
> netif_tx_disable() does not change it.

Yes, that's a separate issue.

Thanks,
Kurt

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCgAxFiEEvLm/ssjDfdPf21mSwZPR8qpGc4IFAmrMoR4THGt1cnRAbGlu
dXRyb25peC5kZQAKCRDBk9HyqkZzgunDEACZXvbN5Glrx8oYf8plbzAhuyxCpZ6i
uZE2E5kBC57t+Qeh+jteAaXPiDTwKI3eGNwXMsBLivfPWm5qSx02x9ZNUv8j+xtW
VXk0VHkVL+tUGvG824AeqWe9GzO5MjUEy/6MW3tpHx9p7ijclj2VI/XxO3Q2JLgE
TKXOBUz2Q/kIQOp9Z7HUGhZ0X8xTsHV8O6OIDVBG1+J8trPeTJADF6MSLZmZ+62z
5SXCoa/LyGXAYIvBRW8QiB0deg55L65RPaccsP9eo9nsd3prz9bWmS/NdMAn5nli
LRZYG4iMYYR7yyR1rDr83wLSMAJ5qTehD3thoOxdwyCRFIGC3gYE/Xcee+gXN7f/
O9Q9BEDTVnh9k9Tz+Rc/I3Y83md0GUoVmOkteVOm6OZTyJO7JWo2sADIWnslqsgk
D/F+W1VnXxyfouHD2W4c9j43gHR0en4/MrzSbLblRTqL2cANIgjtTwmE44cPxZhs
pRk++Mio78jhHpyxwhR7VdHEtmvq3DiDAsasFEk4reLDUJlL0TXMcJ/exjpQ4PW7
rkHDdu5wnnVg5c0GNuuSpVkxtYL8/Z+vFqOeMWodqBSlAocYquyyYUE2Z9lVfaEO
udv0ubebBpzuXOXmB4ZXOifEVM+7vG2e5b/9XOjXQY6bgpTzUPTlZDsR61+31cFz
HBTuhf3aoV/WcA==
=PmlX
-----END PGP SIGNATURE-----
--=-=-=--
