Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6042D59C982
	for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 20:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789158712; cv=pass; b=tp2bjXU9QIv2ZJkYRsP0OouGDIitReJhxHWHi9fscJVYw2OFclIwa9mNcPdjXIb+vDsVq/DptZAPoPN6o+K+xlxowWfzBSNR0OR44wQUfnMOoEYiREj2NAH2UBc6xqKEnwtxdsDVSwNZ7sDRiYA9AGufJOZfT9mPsXZ1W4Mqiic=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789158712; c=relaxed/simple;
	bh=WckXGz3Qec+zm1CBv72tUM3tCEAFIcvi0BYp7o6dr3A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LEzM1YxZzUjH365dAFCdTEdBvX35ghxNXWSk1UH5z31Bd/JXx9WmnIiq4rT/WFN9FHHEB9ZUABK6fNcJ0+6e9bmMR/E9uvdaSBzFZO4vQHpiFkKB3ZfM9EoEdQSSgtyqAJ51eCW20WcDPYcgLIP9d3y45XUb17EfnNZ7IeH8qNc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oZl1W2fD; arc=pass smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oZl1W2fD"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254fa663bfso64665766b.1
        for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 13:31:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789158709; cv=none;
        d=google.com; s=arc-20260327;
        b=bVgzU6eDltFYAwGa/7bSLqqx1zRjVR7dqZ+UZyeS2zACazAO1fnoJkeqqucy6/MDee
         bjoCLYc1PpFVe/j5RfxeF2vTmlGdD+nlQ9fTyyJPyuPwdTOons9M0hCYAJrRaUjSiGTj
         xEoHMAhcMn3aauykZbO+6+aWJya5o2MHs79Ih1LMGNiw9qptWdyULZH942GR831HEm11
         tQLU1f8a7noi+toYU9oodWXzh5RvI+oQEdbNYrjI3cBaaJQXb7t9QkmjeSE1EXYjJHLi
         mvMXRyTQF2kOGfsj34Q+e7iQbVebxK1n1Z/zieXEVBAtSMpMXA0b5GwaLQBEBhyeH+mc
         263Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pV2QG1WoCjLuqD0DRqRY8SOqVOiCMZinny9u6qmNbV0=;
        fh=kXuU2gJf3lwKHFJlRthV0gW0IhcfnQI4DSImjVQuqBE=;
        b=W91IVLnky5Wj186ivRc+O+oIYUWs6QM19vhhX00qV3aovk6J6zzwZ0C7FO5a32SNO6
         VWplAx8XwzDyylvm0MPDa9gRRWS43nsRjhMN/2sSn2MOpOCudLHvgqDJwH22nPNJR1nx
         tdxhf8TBBNWdoSWY1fsAdxBRKD9jFBrJTy0JEnJGm6FCyIPDyaxITbpre4BpzZZKfeXD
         7z+hqanhRla9myw6MZfydLx1Z/QUJKPHDOi5UBgqg40hCmseXHfTBrpT8L3JwseXb9Qz
         /L7B7KMAgzUdRUIZsQi3bJ8NZnQnw/+A6Erai77/hhHVuiYE4ID+eznN7eoIz5N1Uplr
         UvIA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789158709; x=1789763509; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pV2QG1WoCjLuqD0DRqRY8SOqVOiCMZinny9u6qmNbV0=;
        b=oZl1W2fDgQMfOYagbQFGs1d1ATEqNYv0ghwfF+HqQtWf5wuXk2J0Lj2dNRCzcxG541
         iBobj8NurNvkZa1gj6VHhDhRhwwTHMO1KL6exyJECTSANSL6EYw0szXb/7Lbi1nPr8u2
         RFJlBBrgRgsAcwkS911ApCPinvkC9GxaX1scfN9axSvTzTxWN7osUr+MUvgYBaYFU5Zt
         Wh4LjMneHdJWRYgP2QED0gpOMRa/Aah6MEd75gf0chLynCCogWsmQG7gQiHpGVdVGNHN
         mYBIW4ItwM+a0E7dOyxNEorpE0hQ3C7ufeZ/4EVfVb3gtGy9X5/EILGIHqbXVWhcGvKY
         UUbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789158709; x=1789763509;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pV2QG1WoCjLuqD0DRqRY8SOqVOiCMZinny9u6qmNbV0=;
        b=V7BwOSqGk3F3Y3Ka7jZqvI5Ob254AeNEr9qU+w3+WxONykeZYdoBxt3qniWmHntwWA
         CsNTIuAFAQDLCHQ4zPfgI6Xm4Phc+O7094rZy8KdVKVcFnGUoaxXEqwCwaoEoz3AJbw1
         Mte8RO8KEwTYg8nNKIKtpMoRgvFWW7ttU5I/UumuvzmDnpnZ8BM1TyBmaEyALKhswVDR
         kErvX9x3+I05Jtrnc0UAA5RB5NwTHLPUz2LbSxhP1gWUgUl8mZWtPgeeNkx7qOcJqXdV
         LG/bFL7CXN91ybCW/UPcAGjH899PxBEMQZkRGNfLV4ZBqmRyTTUi5BA3Fu7lyingPwoq
         dAmw==
X-Forwarded-Encrypted: i=1; AKwUvByT8ezqeNCdTpLXxLPJnBNyN+AmM5dD8uQ6NB+LEVN0IHtykzwLlUeScOtHEB3xKKtIAgY=@vger.kernel.org
X-Gm-Message-State: AFuF++nMoIrdSNgCsLARe5dLxYShMj12DkjgwEcRag29x8SirD3vtDbL
	1mk87TRnZOou52QOKBKFNsm6f6LGv0hbsAZzl6LcE6W/dWpzLpHgYkawyegypbIlnAgfBgnMNvG
	vkE/17D6X3tJ/N9m50pkYh1W2+nFVtTqfQdknE9h+
X-Gm-Gg: AYBFou2e1tuJGGAWwEo29HQo6vyYgLGpgbp5hVOu6KVxPE2Ct6XWfKSnaN3Pflz91Vs
	vVVe8p5WIRpHgrl7p1rFn42itR0Dk/pB3g1kwBxncbuWoFGN5upPtCqm1FPE9z7+ApARtmL87Ld
	cD7KEeuLkJXS6qrdg3zuRqPxOCcfM8Y6dvwnenAb6n6IB5YSvvrI8dXh2kZCj9ECll/49vDolFp
	zej0+tMTAHNisC8LQdJITUTyZwVte09Z5AkQohFeJNSp+XggwHIJ2CGGVjsDVZJLGDR0Z+ZgDXe
	22Ru1GXwe1g6SUUB6EHRQFBePmzpXcHICS07NzfBnGf75kJXZefL9oNIgUQsgcuZSt8WyRKCY7t
	s/wqN4fLRiA==
X-Received: by 2002:a17:907:971a:b0:c29:5215:b2d8 with SMTP id
 a640c23a62f3a-c2966694db6mr503582266b.14.1789158707987; Fri, 11 Sep 2026
 13:31:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260909191136.3811892-7-hramamurthy@google.com> <178907843486.219967.15219569295959777862@kernel.org>
In-Reply-To: <178907843486.219967.15219569295959777862@kernel.org>
From: Joshua Washington <joshwash@google.com>
Date: Fri, 11 Sep 2026 13:31:35 -0700
X-Gm-Features: AcwNN1XMpsz8oY2xtsGwwnJpZtQPEmpAmpBbz4es88ABVunuSKuvd8RKgqh8xPg
Message-ID: <CALuQH+V2=Cy7BGux-5M50Z+tqiUQfO8q5_oF6sxV--n+26y8ng@mail.gmail.com>
Subject: Re: [PATCH net-next v6 06/12] gve: simplify reset logic
To: netdev-bot+sashiko@kernel.org
Cc: hramamurthy@google.com, netdev@vger.kernel.org, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, sdf@fomichev.me, jordanrhee@google.com, 
	willemb@google.com, nktgrg@google.com, maolson@google.com, thostet@google.com, 
	jacob.e.keller@intel.com, debarghyak@google.com, kees@kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	przemyslaw.kitszel@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 10, 2026 at 3:13=E2=80=AFPM <netdev-bot+sashiko@kernel.org> wro=
te:
>
> Thank you for your contribution! Sashiko AI review found 3 potential
> issue(s) to consider:
>
> Critical: 0 =C2=B7 High: 2 (1) =C2=B7 Medium: 1 =C2=B7 Low: 0
>
> - [High] Inconsistent work quiescing across the new gve_teardown_device()
>   call sites leaves priv->stats_report_task able to run after=E2=80=A6
> - [High] The new reset/close flow releases data-plane DMA before the
>   hardware reset that revokes the device's access to it.
> - [Medium] gve_mgmnt_intr() now returns IRQ_NONE without queueing
>   priv->service_task whenever GVE_PRIV_FLAGS_DEVICE_RESOURCES_OK is=E2=80=
=A6
>
> Pre-existing issues:
> - [High] After gve_reset() fails to recover (gve_recover() ->
>   teardown_device), the netdev is left administratively UP (nothing=E2=80=
=A6
>
> --
>
> Here is the report.
>
> gve: simplify reset logic
>
> This reworks the gve reset path: recursive resets and resets during
> teardown are removed, allocation is split from device setup, and a single
> gve_teardown_device() / gve_recover() pair replaces the old
> gve_reset_and_teardown() / gve_reset_recovery() helpers.
>
> A few questions on the new teardown ordering and work-item quiescing
> below.
>
> > diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/e=
thernet/google/gve/gve_main.c
> > index 2fe280cf7e680..87388856ff6c5 100644
> > --- a/drivers/net/ethernet/google/gve/gve_main.c
> > +++ b/drivers/net/ethernet/google/gve/gve_main.c
> > @@ -270,6 +270,10 @@ static irqreturn_t gve_mgmnt_intr(int irq, void *a=
rg)
> >  {
> >       struct gve_priv *priv =3D arg;
> >
> > +     /* Device resources are not okay; consider the interrupt spurious=
. */
> > +     if (!gve_get_device_resources_ok(priv))
> > +             return IRQ_NONE;
> > +
> >       queue_work(priv->gve_wq, &priv->service_task);
> >       return IRQ_HANDLED;
> >  }
>
> [Severity: Medium]
> Can this drop a management notification instead of latching it?
>
> The mgmt vector is live from gve_alloc_notify_blocks()/setup_mgmt_irq()
> until it is released, but device_resources_ok is only set at the end of
> gve_setup_control_plane_resources() and is cleared at the very start of
> gve_teardown_control_plane_resources(). So for the whole teardown window
> inside gve_teardown_device(), and for gve_recover()'s
> adminq_init/verify/setup_device phase, this returns IRQ_NONE without
> queueing the service task.
>
> gve_service_task() is the only reader of reg_bar0->device_status (it feed=
s
> gve_handle_status() for the device-requested-reset bit and the link
> handling), and the only other re-sample point is the
> queue_work(priv->gve_wq, &priv->service_task) at the end of
> gve_queues_start(). When gve_recover() runs with setup_queues =3D=3D fals=
e
> (was_up false, or gve_reset(priv, true) from gve_close()'s reset path),
> gve_open() is never called:
>
>         if (setup_queues) {
>                 err =3D gve_open(priv->dev);
>
> Is a device reset request or link transition asserted in that window
> recovered anywhere, or is it lost until the next unrelated open?
>
> Since gve_reset() already brackets the teardown with
> disable_work()/enable_work(&priv->service_task), would keeping the
> unconditional queue_work() here be equivalent for exclusion purposes
> without discarding the notification? Also, for a dedicated (non-shared)
> MSI-X vector, repeatedly returning IRQ_NONE feeds the core spurious
> interrupt detector.
>
> [ ... ]

The management IRQ should not be enabled until after device resources
are okay. Any interrupt that comes in before the control plane
resources are set up and the management IRQ is enabled should be
considered spurious, and ignored. However, IRQ_NONE is not the correct
return value here, as this is not a situation in which shared
interrupts are returned. Will convert to IRQ_HANDLED.

>
> > -static void gve_trigger_reset(struct gve_priv *priv);
> > -
> > -static void gve_teardown_device_resources(struct gve_priv *priv)
> > +/**
> > + * gve_teardown_control_plane_resources() - Request the device to rele=
ase any
> > + * shared allocated resources.
>
> [ ... ]
>
> > +static void gve_teardown_device(struct gve_priv *priv)
> > +{
> > +     gve_teardown_control_plane_resources(priv);
> > +     gve_adminq_free(priv);
> > +     /*
> > +      * Free any resources shared with the device only after we have a
> > +      * guarantee that the device will not try to access such resource=
s.
> > +      * Device commands in gve_teardown_control_plane_resources can fa=
il, in
> > +      * which case, device resources won't be relinquished until
> > +      * gve_adminq_free is called to trigger a device reset.
> > +      */
> > +     gve_free_control_plane_resources(priv);
> > +}
> > +
>
> [Severity: High]
> Is priv->stats_report_task guaranteed to be quiesced by the time
> gve_free_control_plane_resources() -> gve_free_stats_report() frees the
> coherent buffer?
>
> gve_free_stats_report() only stops the timer and frees:
>
>         if (!priv->stats_report)
>                 return;
>
>         timer_delete_sync(&priv->stats_report_timer);
>         dma_free_coherent(&priv->pdev->dev, priv->stats_report_len,
>                           priv->stats_report, priv->stats_report_bus);
>         priv->stats_report =3D NULL;
>
> The only cancel_work_sync(&priv->stats_report_task) added by this patch i=
s
> in gve_queues_stop(), which the teardown paths only reach when the
> interface was up (gve_reset() calls it under if (was_up); gve_remove(),
> gve_shutdown() and gve_suspend() reach it only via gve_close()).
>
> gve_set_priv_flags() in gve_ethtool.c arms the timer with no
> netif_running() check:
>
>         if (flags & BIT(0)) {
>                 mod_timer(&priv->stats_report_timer,
>                           round_jiffies(jiffies +
>                                         msecs_to_jiffies(priv->stats_repo=
rt_timer_period)));
>         }
>
> so with report-stats enabled on a down interface the chain
> gve_stats_report_timer() -> gve_stats_report_schedule() ->
> queue_work(priv->gve_wq, &priv->stats_report_task) can leave the work
> pending across gve_teardown_device(). gve_handle_report_stats() then does=
:
>
>         struct stats *stats =3D priv->stats_report->stats;
>         ...
>         be64_add_cpu(&priv->stats_report->written_count, 1);
>
> which is either a write into the just-freed DMA coherent buffer or a NULL
> dereference once priv->stats_report has been set to NULL. In gve_remove()
> the pending item is only drained by destroy_workqueue(), i.e. after
> gve_teardown_device() has already freed it.
>
> Would it be simpler to do the cancel_work_sync(&priv->stats_report_task)
> inside gve_free_stats_report() (or in gve_teardown_device()) so every cal=
l
> site is covered regardless of whether the interface was up?

Ack. Will do this in v7.

>
> [ ... ]
>
> > @@ -1435,6 +1472,12 @@ static int gve_open(struct net_device *dev)
> >       struct gve_priv *priv =3D netdev_priv(dev);
> >       int err;
> >
> > +     if (!gve_get_device_resources_ok(priv)) {
> > +             dev_err(&priv->pdev->dev,
> > +                     "Attempting to open netdev without resources. Dev=
ice must be reset.");
> > +             return -ENODEV;
> > +     }
> > +
>
> [Severity: High]
> This isn't a bug introduced by this patch (the baseline
> gve_reset_recovery() error path also left the interface up with
> priv->xsk_pools =3D=3D NULL after gve_teardown_priv_resources()), but sin=
ce
> this patch restructures exactly that path and adds the resources_ok gate
> here, should the other user-reachable entry points get the same gate?
>
> After gve_recover() takes its teardown_device label, the netdev is still
> administratively up (nothing calls dev_close()), while
> gve_teardown_device() has set priv->xsk_pools =3D NULL,
> priv->ptype_lut_dqo =3D NULL, priv->tx/priv->rx =3D NULL, freed the notif=
y
> blocks, and dma_pool_free()d the adminq buffer while priv->adminq keeps
> its stale pointer.
>
> gve_xsk_pool_disable() only bounds-checks the queue id:
>
>         if (qid >=3D priv->rx_cfg.num_queues)
>                 return -EINVAL;
>
>         clear_bit(qid, priv->xsk_pools);
>
> and closing an AF_XDP zero-copy socket reaches ndo_bpf(XDP_SETUP_XSK_POOL=
,
> pool =3D=3D NULL) without any netif_running() test (xp_clear_dev() /
> xp_disable_drv_zc()), so this is a clear_bit() on a NULL bitmap.
> gve_set_priv_flags() likewise memsets priv->stats_report->stats when
> report-stats is turned off, and gve_adjust_queues()/gve_adjust_config()
> issue adminq commands through the freed priv->adminq while netif_running(=
)
> is true.
>
> The failed-recovery precondition is easy to reach now that
> gve_add_flow_rule()/gve_del_flow_rule() call gve_reset(priv, false) on
> -ETIME, and gve_recover() bails out to teardown_device when e.g.
> gve_adminq_verify_driver_compatibility() times out.
>
> > @@ -1451,41 +1494,16 @@ static int gve_open(struct net_device *dev)
> >       return 0;
> >  }
> >
> > -static int gve_queues_stop(struct gve_priv *priv)
> > +static void gve_queues_stop(struct gve_priv *priv)
> >  {
> > -     int err;
> > +     gve_unreg_xdp_info(priv);
> > +     gve_drain_page_cache(priv);
> >
> > -     netif_carrier_off(priv->dev);
> > -     if (gve_get_device_rings_ok(priv)) {
> > -             gve_turndown(priv);
> > -             gve_drain_page_cache(priv);
> > -             err =3D gve_destroy_rings(priv);
> > -             if (err)
> > -                     goto err;
> > -             err =3D gve_unregister_qpls(priv);
> > -             if (err)
> > -                     goto err;
> > -             gve_clear_device_rings_ok(priv);
> > -     }
> >       timer_delete_sync(&priv->stats_report_timer);
> > -
> > -     gve_unreg_xdp_info(priv);
> > +     cancel_work_sync(&priv->stats_report_task);
> >
> >       gve_tx_stop_rings(priv, gve_num_tx_queues(priv));
> >       gve_rx_stop_rings(priv, priv->rx_cfg.num_queues);
> > -
> > -     priv->interface_down_cnt++;
> > -     return 0;
> > -
> > -err:
> > -     /* This must have been called from a reset due to the rtnl lock
> > -      * so just return at this point.
> > -      */
> > -     if (gve_get_reset_in_progress(priv))
> > -             return err;
> > -     /* Otherwise reset before returning */
> > -     gve_reset_and_teardown(priv, true);
> > -     return gve_reset_recovery(priv, false);
> >  }
> >
> >  static int gve_close(struct net_device *dev)
> > @@ -1493,12 +1511,30 @@ static int gve_close(struct net_device *dev)
> >       struct gve_priv *priv =3D netdev_priv(dev);
> >       int err;
> >
> > -     err =3D gve_queues_stop(priv);
> > -     if (err)
> > -             return err;
> > +     gve_turndown(priv);
> > +
> > +     /* Surrender to reset if the queue destroying adminq cmds fail. R=
eset
> > +      * will not re-enable the interface.
> > +      */
> > +     if (gve_get_device_rings_ok(priv)) {
> > +             gve_clear_device_rings_ok(priv);
> > +             err =3D gve_destroy_rings(priv);
> > +             if (err)
> > +                     goto reset;
> > +             err =3D gve_unregister_qpls(priv);
> > +             if (err)
> > +                     goto reset;
> > +     }
> >
> > +     gve_queues_stop(priv);
> >       gve_queues_mem_remove(priv);
> > +     priv->interface_down_cnt++;
> >       return 0;
> > +
> > +reset:
> > +     gve_queues_stop(priv);
> > +     err =3D gve_reset(priv, true);
> > +     return err;
> >  }
>
> [Severity: High]
> On this new reset: label, is it safe to release the ring buffers before
> the hardware reset?
>
> gve_destroy_rings() or gve_unregister_qpls() failing (typically -ETIME
> from gve_adminq_kick_and_wait() -> gve_adminq_wait_for_cmd()) means the
> NIC never acknowledged that it stopped using those queues. gve_queues_sto=
p()
> then does:
>
>         gve_tx_stop_rings(priv, gve_num_tx_queues(priv));
>         gve_rx_stop_rings(priv, priv->rx_cfg.num_queues);
>
> which for DQO returns RX buffer pages via gve_free_to_page_pool()/
> gve_free_qpl_page_dqo(), dma_unmaps pending TX buffers
> (gve_tx_clean_pending_packets() -> gve_unmap_packet()) and memsets the
> descriptor/completion rings and q_resources.
>
> The point at which the device is guaranteed to have stopped touching that
> memory only comes later, in gve_reset() -> gve_teardown_device() ->
> gve_adminq_free() -> gve_adminq_release():
>
>         iowrite32be(GVE_DRIVER_STATUS_RESET_MASK, &priv->reg_bar0->driver=
_status);
>         while (!(ioread32be(&priv->reg_bar0->device_status)
>                         & GVE_DEVICE_STATUS_DEVICE_IS_RESET)) { ... }
>
> The pre-patch code returned from gve_queues_stop() before stopping the
> rings on a destroy failure, and gve_reset_and_teardown() called
> gve_trigger_reset() (which blocks until DEVICE_IS_RESET) first. Should th=
e
> hardware reset happen before gve_queues_stop() here?
>
> The commit message applies exactly this reasoning to the control plane:
>
>     With the new reset functionality, shared resources between the device
>     and driver are not freed until after the hardware reset has completed
>
> Does the same invariant hold for the data-plane rings and buffers on this
> path?
>

This is a good catch. Will remove the gve_queues_stop() from
gve_queues_start(). Because netif_running() is guaranteed to be true
when calling gve_queues_start(), was_up will be true in gve_reset().
Rely on this, reorder the teardown operations to do

```
gve_teardown_device()
if (was_up) { gve_queues_stop() }
gve_queues_mem_remove()
```

To ensure that the device is not holding onto reseources when
gve_queues_stop() is performed.

> [ ... ]
>
> > -int gve_reset(struct gve_priv *priv, bool attempt_teardown)
> > +int gve_reset(struct gve_priv *priv, bool skip_queue_setup)
> >  {
> >       bool was_up =3D netif_running(priv->dev);
> >       int err;
> >
> > +     if (gve_get_reset_in_progress(priv))
> > +             return 0;
> > +
> >       dev_info(&priv->pdev->dev, "Performing reset\n");
> >       gve_clear_do_reset(priv);
> >       gve_set_reset_in_progress(priv);
> > -     /* If we aren't attempting to teardown normally, just go turndown=
 and
> > -      * reset right away.
> > -      */
> > -     if (!attempt_teardown) {
> > +
> > +     if (was_up) {
> >               gve_turndown(priv);
> > -             gve_reset_and_teardown(priv, was_up);
> > -     } else {
> > -             /* Otherwise attempt to close normally */
> > -             if (was_up) {
> > -                     err =3D gve_close(priv->dev);
> > -                     /* If that fails reset as we did above */
> > -                     if (err)
> > -                             gve_reset_and_teardown(priv, was_up);
> > +             if (gve_get_device_rings_ok(priv)) {
> > +                     gve_clear_device_rings_ok(priv);
> > +                     gve_destroy_rings(priv);
> > +                     gve_unregister_qpls(priv);
> >               }
> > -             /* Clean up any remaining resources */
> > -             gve_teardown_priv_resources(priv);
> > +             gve_queues_stop(priv);
> >       }
>
> [Severity: High]
> Same ordering question here, with the added detail that the return values
> of gve_destroy_rings() and gve_unregister_qpls() are not inspected at all=
,
> so gve_queues_stop() unmaps/recycles the ring memory unconditionally,
> including for a device whose adminq is not responding.
>
> There is a mirror of this on the recovery side: with RESET_IN_PROGRESS
> set, a create-rings failure makes gve_queues_start() take
> stop_and_free_rings:
>
>         stop_and_free_rings:
>                 gve_tx_stop_rings(priv, gve_num_tx_queues(priv));
>                 gve_rx_stop_rings(priv, priv->rx_cfg.num_queues);
>                 gve_queues_mem_remove(priv);
>
> which frees the coherent rings and QPL pages even though some TX queues
> may already have been created in hardware, with the reset handshake only
> happening later when gve_recover() calls gve_teardown_device(). Can the
> NIC still be writing into those pages at that point?

Addressed above.


>
> >
> > -     /* Set it all back up */
> > -     err =3D gve_reset_recovery(priv, was_up);
> > +     disable_work(&priv->service_task);
> > +     gve_teardown_device(priv);
> > +     gve_queues_mem_remove(priv);
> > +
> > +     enable_work(&priv->service_task);
> > +     err =3D gve_recover(priv, was_up && !skip_queue_setup);
> > +     if (err)
> > +             dev_info(&priv->pdev->dev,
> > +                      "Failed to recover in reset: %d\n", err);
> > +
>
> [Severity: High]
> Only priv->service_task is disabled around gve_teardown_device() here.
> When was_up is false, gve_queues_stop() (the sole
> cancel_work_sync(&priv->stats_report_task) call site) is skipped, so a
> stats work item queued by the timer can run concurrently with
> gve_free_stats_report(). Should priv->stats_report_task be quiesced here
> too?

Fixed by canceling the work as part of freeing stats report.

>
> [ ... ]
>
> > @@ -2943,8 +2952,9 @@ static int gve_probe(struct pci_dev *pdev, const =
struct pci_device_id *ent)
> >       queue_work(priv->gve_wq, &priv->service_task);
> >       return 0;
> >
> > -abort_with_gve_init:
> > -     gve_teardown_priv_resources(priv);
> > +abort_teardown_device:
> > +     disable_work(&priv->stats_report_task);
> > +     gve_teardown_device(priv);
>
> [Severity: High]
> Is this disabling the intended work item? During probe, the stats work ha=
s
> no producer yet (its only producer is the timer armed by
> gve_queues_start() or by ethtool on a registered netdev), while
> priv->service_task is queueable at this point because gve_setup_device()
> already set device_resources_ok and the mgmt IRQ is requested. Every othe=
r
> teardown site in this patch uses disable_work_sync(&priv->service_task).
>
> Should this be disable_work_sync(&priv->service_task) instead, or in
> addition?

Yes, this should be the service task being disabled.

>
> > @@ -2976,7 +2986,8 @@ static void gve_remove(struct pci_dev *pdev)
> >       void __iomem *reg_bar =3D priv->reg_bar0;
> >
> >       unregister_netdev(netdev);
> > -     gve_teardown_priv_resources(priv);
> > +     disable_work_sync(&priv->service_task);
> > +     gve_teardown_device(priv);
> >       destroy_workqueue(priv->gve_wq);
>
> [Severity: High]
> For an interface that was already down, unregister_netdev() does not call
> gve_close(), so nothing cancels priv->stats_report_task before
> gve_teardown_device() frees priv->stats_report. destroy_workqueue() then
> drains the pending stats work after the free. Does the ordering here need
> a disable_work_sync(&priv->stats_report_task) as well?
>

As mentioned above, when freeing the stats report, the timer will be
deleted, and the work will be canceled. With those fixes, the stats
report task won't have any queued work.

> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20260909191136.3811892-1-hramamurthy%40google.com


-- Josh
