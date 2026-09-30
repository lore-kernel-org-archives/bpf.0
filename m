Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F52B3A9611;
	Wed, 30 Sep 2026 04:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790743900; cv=none; b=RsmgvVM9a+X3gOVXzHhexF52g8JZQzCcMrXhIv1g1ALau9RdiQ1JWAl4RY1oJ1IVJ669v0ad/ISCKFTTsMoW3BE19qRV5ZSu7YtbsA6wRTZM1EokF2oH8v5bODysAR1wfippSt9MYVvvtilYXk41G+7ctiTNdzkrJT64i7yotZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790743900; c=relaxed/simple;
	bh=xc3KfkSrztxu9JU91gu7aNc25rnz08mhpsrzfYVKAOY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OWqbtFiJbBfne7ApfwAUOguUijCjvLPjWNQkVXWxx5Tdt4NaFciYMRsIDDz7ITq75RwmKNiJuk2Ynk7yM+3clRmwb/ucghrMFYgfNDG9g+YDx/XUE94M4xigBXC6oWl01IBYXA9S0SRTtt6D0rZE2zb8iH4H4FC+7keM+/LaBig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OMWqCemL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OMWqCemL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 304BA1F000FF;
	Wed, 30 Sep 2026 04:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790743896;
	bh=Pdp6WD7T30aI+MBeJKjzKi4AVf5J+aE5ONgJHfabMYE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=OMWqCemLztXGnK/f+UQ727wVx/zkX29wcOkV6odMrCZZq0QgrsniQbNl4PofTa73z
	 jxJbe44sVF7hPrdqavQmLDElJWE3xjU8DTUcsXSRpmZx90IuiScfaEisQ4P9BwTsvj
	 kUu8T6hG8oBURCtyie0LFMPoGuN90SNs0dzWProseKMxsu6L5K0yybtdxJeGnN0CHK
	 cgsJfIJdZr9hAWI6i9VYqQck1gMK8u1zjvQTn/E3z1T1ltzrznJV2HJx6m+1v/c6kC
	 obovDfKOPrREYb8oLIZtNhq97K2R7zHNiJkFkFxyHstcLM7lpKGbTq2+pcIiKJE6j5
	 zNVpXuuQM0b5w==
Subject: Re: [PATCH net v4 04/15] xsk: freeze deferred pool teardown during
 system sleep
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
Date: Wed, 30 Sep 2026 04:51:33 +0000
Message-ID: <179074389376.434549.7889207718883714396@kernel.org>
In-Reply-To:
 <20260926-submit-stmmac-reset-fixes-v1-v4-4-ec1c0250b3c9@gmail.com>
References:
 <20260926-submit-stmmac-reset-fixes-v1-v4-4-ec1c0250b3c9@gmail.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] Resume can hang forever when a netdev is unregistered from a
  device PM callback while an xsk pool release is waiting on the frozen…

--

xsk: freeze deferred pool teardown during system sleep

This patch moves the deferred xsk buffer pool release from system_wq to
system_freezable_wq. The goal is to stop ndo_bpf() from being called
while the device is suspended.

> diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
> index 9d2d94f1fb759..c58f56f24a9c7 100644
> --- a/net/xdp/xsk_buff_pool.c
> +++ b/net/xdp/xsk_buff_pool.c
> @@ -337,7 +337,10 @@ bool xp_put_pool(struct xsk_buff_pool *pool)
>  
>  	if (refcount_dec_and_test(&pool->users)) {
>  		INIT_WORK(&pool->work, xp_release_deferred);
> -		schedule_work(&pool->work);
> +		/* Teardown calls ndo_bpf(), which may need powered hardware.
> +		 * RTNL alone does not exclude the device's system PM callbacks.
> +		 */
> +		queue_work(system_freezable_wq, &pool->work);

[Severity: High]
Can this hang system resume if the same netdev is unregistered from a PM
callback while this work is still queued on the frozen workqueue?

This work is now the only path to the dev_put() that balances the
dev_hold() in xp_assign_dev():

xp_release_deferred()
  xp_clear_dev()
    dev_put(netdev);

The final put can arrive after the workqueues are frozen:

- xsk_release() has already taken the socket off net->xdp.list with
  sk_del_node_init_rcu().

- xsk_destruct() -> xp_put_pool() runs from the SOCK_RCU_FREE callback
  once sk_wmem_alloc drains. That drain can happen when pending copy-mode
  TX skbs are freed via xsk_destruct_skb() -> sock_wfree(). Two ways this
  can happen are a driver freeing TX skbs in its suspend callback and a
  qdisc reset during unregister.

If this final put happens after freeze_workqueues_begin(), the work does
not run until thaw_workqueues(). For suspend-to-RAM that is
suspend_finish() -> suspend_thaw_processes(), which runs after
dpm_resume_end().

Now suppose a resume callback unregisters that same netdev:

usb_resume()
  unbind_marked_interfaces()
    usb_forced_unbind_intf()
      usbnet_disconnect()
        unregister_netdev()
          netdev_run_todo()
            netdev_wait_allrefs_any()

This path is taken when usb_resume_interface() sets needs_binding on a
reset-resume and the driver has no .reset_resume. Several usbnet drivers
lack one, for example dm9601, rndis_host, cdc_eem, cdc_subset and aqc111.

netdev_wait_allrefs_any() loops with no timeout:

- Its NETDEV_UNREGISTER rebroadcasts reach xsk_notifier(), but that only
  walks net->xdp.list, so it cannot find the released socket's pool.

- Its rcu_barrier() does not run frozen work.

The resume thread never reaches thaw_workqueues(), so the netdev
reference is never dropped. With system_wq the work would have run and
called dev_put().

Copy-mode pools also take the freezable path, even though
xp_disable_drv_zc() only calls ndo_bpf() when pool->umem->zc is set.

Would it work to defer only the driver ndo_bpf() teardown to the
freezable queue, and never the dev_put()? Another option might be to let
xsk_notifier() handle NETDEV_UNREGISTER for pools whose release is still
pending, for example by tracking them per netdev.

Separately, the commit message says:

    newly queued destruction waits until device resume

Is this accurate? As far as I can tell, the work waits until process
thaw, which comes after every device resume and complete callback has
finished.

>  		return true;
>  	}
>

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260926-submit-stmmac-reset-fixes-v1-v4-0-ec1c0250b3c9%40gmail.com
