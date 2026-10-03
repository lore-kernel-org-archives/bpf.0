Received: from mail-ej2-f43.google.com (mail-ej2-f43.google.com [74.125.228.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070C137A496
	for <bpf@vger.kernel.org>; Sat,  3 Oct 2026 01:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790991255; cv=pass; b=a/clPk92FuRl31mh+lVI1ekurkarIqgORNX+BYVbMdbGfHJG5iDdSyQ25MaK20Z/GSDwFRP1mOyZm6hTusdzJB5XPo/eu2GLqkhstdyrhiCFVQJoj1s/chdUfWLjvj24ciy+nMoG4D5KjVUWcbhjAnFnhKCYW2t57cZVeo/Sex0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790991255; c=relaxed/simple;
	bh=ptPWV0OH3q7QGoA21bHgyc6hO14/F29odnY8cqO6j4Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oIHdoTYTDHOpztaCmpUfgtIwD4Y79IfzSuNzRry0toPyMW2hTXH5h24XyjvEoJ25SGw0IcPaf5TJizSjoQraa7XpBB1DA6ZymL1kAJu2VDpv+XNSffy1AqgA5LqAl4nO/cORfqkzng3rS6rUqYYANaYDBnlmESBRgeRCThqMWGU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=swGARxck; arc=pass smtp.client-ip=74.125.228.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="swGARxck"
Received: by mail-ej2-f43.google.com with SMTP id a640c23a62f3a-c264788fd58so68203966b.1
        for <bpf@vger.kernel.org>; Fri, 02 Oct 2026 18:34:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790991248; cv=none;
        d=google.com; s=arc-20260327;
        b=rBaGbIPs4WUz1cDA7atsp1F/TB3HaBqECVyn9/Nb7U06ZuGKh3KUyeP0Y1IiBJFXbJ
         qJ1fMnRT0VepYa73pZ8NWW64Z1sQQ6R2L3xd32kNqIbJ8dQei+y4GLklMprsWgz914sJ
         ZaOWr41NFL2SxR0tcsc3/2QTOjQuTNt2ne0VpjfDRCDwsBLW2SfZh70FmElALTGSZNaS
         pcS55Rwh87yrKbHO5AzUUZVzurU0BIWZhJAjDS6yWnENfsWtZ6xeq+bpBKpnN/Vv+jC6
         Cl/6Ugaw9oze4Go2BS8/ersT7q34P/0+2XPLlIWmU6VgIan2SVinqCr+V6Wu/kRsrCOd
         n2ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zq6yQo/n7YZWJM2rNuPgBEyLg7Q2HpE3/x3GEKnGA74=;
        fh=mF5YJTWoLLfYn6s08y7d8Vcuqovz5PPn+tYYHCCdK7M=;
        b=Uf+YuUG1i9SGjc4Ff2lAptzLgOt51SLAab8wGSyn3pHUr069E2rtIg/+va61ExmZpr
         HKeiW9NxMjZAg7O19Jy3T3PiBG1oZdtnmbT4/OPGX3R5AK40CQ78lXh+7Qmd+n7hHPD+
         NL34L11123OmYr1r71EnEZopzRB2Pi35Bk/qtXp5UyQDNJ/AR6pA1T8BcWtUpy25k5/H
         IMGmWxF/iIdhkQVHRL6YdLm1UuU9j4ROsPCjSTlCPz1FO4yyswp5+BE6UDnFClLhJKn3
         EWvTbneJitbX7lJnPDdwJ1GkXSP3J8KVFxoqO0pB+V8vthHOtJu84TC5QxiHJf5bs4vn
         QD8g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790991248; x=1791596048; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zq6yQo/n7YZWJM2rNuPgBEyLg7Q2HpE3/x3GEKnGA74=;
        b=swGARxcknj8wi/nU5cqLlEvbsNNdL+am+609tnKkOdpDXD8jyCaeusJffXzJLIHlOt
         J4suKzC2qq1HvyNTmAQQDl2LajpAogzUasi3+GdimO4EHQwyJLqNTH+kGoGpp0UuaGBi
         r4ABvN0l4zCNueuAX7JoAXyA1b7/B0WsTIaMH0VJdUW8e/UznIeAOBP4fCJDa+bnPBIa
         3+UVo8xVVVCvUvs26lF41yWH38itvutxPj0+PW1+v2H42oY7tJmojSZCZ0qRMJuLpech
         e5RTSjBtXb4SjEOmaL3KMuF4nwDzqFBwiqCMAaXqzy+XoGZZhwqrabf6mKnSjjoGvwaX
         XmOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790991248; x=1791596048;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zq6yQo/n7YZWJM2rNuPgBEyLg7Q2HpE3/x3GEKnGA74=;
        b=KUcCQlEFmUTVhWw3jdrEZkeAoyYf+SqqWoJTzF1dWi/lS7YHpU48FyJ7AnztO+QPmG
         KmQHAC7VRHqD4Uy3gqBQFSGUK7mLx9cEnaTZjp5mWXqtYaFzk6RaY/LOcpeR1BlaYm0D
         J8RNi8qFqwCz7g1w4k+/mJZ6cdUSFnuBRMY6KBYvNOYC5eCzRya0DAveQIITBVDy6jdN
         6TEYr646DHxNwEMY9Zj15FYN1IPJzYOuRwBPMNhtH2sU5njmw2gsnHOOY7cdji7GIyc1
         Ixg/YRwBMBTaRGqN6N5JnL6GeMG3CWk87WDcsdbIhgOZWGaiUfTxfS+zsdCup/26bDD6
         yLCw==
X-Forwarded-Encrypted: i=1; AKwUvBxKAsSNbWcDNQw9Zu2LB6q8M4oysYmYL7lzkUwlMpzooT4/cdyorwbznnMXteRB3JHau2I=@vger.kernel.org
X-Gm-Message-State: AFq9FYI/WDuKdbt4zB+oC+oQX+Y3jl8GDhbHimrUBU9V6foIP3fmLPuP
	jV8rOQ0LbvnMMpRmdePdEAuZm/PFi/lr6dj6E1muj+JRDqUoPJMxkhxi4z8WJsbhNI8f6eNPWoH
	9pX50sX1BLy0HwEYmmrxQZ98eM9Ao4j5k0zQJxNQo
X-Gm-Gg: AYBFou14TMcaA8UJ/hWe2wSlWa+dFaLMbejSGPhNU8S0ga/9pvfMkoDCz4SbfYnWI72
	YiyB1BaI7FXZS1TqEL3+vItXYvvjnTM2fPahYq/vgiu9L6vUGKQnGphq5kSTchjL8nLmZX4LBL7
	li5t7GoP5Osd/ewKsjzAG6IiF/3IzdSniz0Nl1ahzH6qW7uMPMkK3DZgRpgejZp/gQ+85uyT8hp
	lfihlq3+IJyBqdLg0/4uuwNsxZU29c0k5G+Wla4JvT0UMW8rteRY7qbeE/7cNESfV3m5RT8w19h
	AdcJ+WHyumx0dVBXfIP6LSNZ4AGBclbHcTyocmzpslgGSJo/+BpDkMS1MpPtMSd4x1wG9j0YdwR
	RwDumcGHDrw==
X-Received: by 2002:a17:907:3e8f:b0:c29:555e:bf9 with SMTP id
 a640c23a62f3a-c2e4acecb16mr322944966b.18.1790991247335; Fri, 02 Oct 2026
 18:34:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260930190428.1130007-7-hramamurthy@google.com> <179093559372.434549.9856875950011939081@kernel.org>
In-Reply-To: <179093559372.434549.9856875950011939081@kernel.org>
From: Joshua Washington <joshwash@google.com>
Date: Fri, 2 Oct 2026 18:33:55 -0700
X-Gm-Features: AclHuK-na4KIVh_xyvtlcdSV2vFhMZhQfkxQuSVXTekT7AMrm044hPQdhZkA9BQ
Message-ID: <CALuQH+VQVRvGUmgrFDE4XW6K1AWJbSW6=ed4Z7WRMW7BxV22bw@mail.gmail.com>
Subject: Re: [PATCH net-next v9 06/12] gve: simplify reset logic
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

On Fri, Oct 2, 2026 at 3:06=E2=80=AFAM <netdev-bot+sashiko@kernel.org> wrot=
e:
>
> Thank you for your contribution! Sashiko AI review found 8 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 1 (3) =C2=B7 Medium: 2 (3) =C2=B7 Low: 5
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [High] If gve_open() fails inside gve_recover(priv, true), queue memory
>   that the device may still reference is freed and the device is never=E2=
=80=A6
> - [Medium] In gve_recover(), when setup_queues is true and gve_open()
>   fails, the function returns early and skips netif_device_attach(),=E2=
=80=A6
> - [Medium] On a running DQO RDA interface with XDP loaded,
>   gve_xsk_pool_enable() sets the xsk_pools bit, registers the pool and=E2=
=80=A6
> - [Low] gve_reset() now has a single graceful path.
> - [Low] When gve_recover() fails (gve_adminq_init,
>   verify_driver_compatibility or gve_setup_device), it now calls=E2=80=A6
> - [Low] The patch fixes a real unbounded recursion in the baseline:
>   gve_adminq_configure_flow_rule() called gve_reset(priv, true) on=E2=80=
=A6
> - [Low] Item 2 of the commit message says that, before this patch,
>   gve_close() during gve_shutdown could trigger a hardware reset and=E2=
=80=A6
> - [Low] The comment above gve_queues_start() still says 'No memory is
>   allocated.

In this patch, many of the issues >=3D medium severity are pre-existing
in some form or another, and are being called out as non-pre-existing
either because they are failing on a different edge case, or they keep
the same behavior as before the patch, but are acknowledged as an
issue by the patch description but not fixed.

With this in mind I think overall, the patch is a marked improvement
over the previous code. Since no significant new regressions are being
introduced at this point, I am wondering if the remaining issues can
be addressed in future patches. I have provided responses for the
medium/high issues on this patch in case another revision is
requested.

>
> Pre-existing issues:
> - [High] gve_adjust_config() allocates the new rings
>   (gve_queues_mem_alloc) before calling gve_close().
> - [High] After a failed gve_recover() (teardown_device path),
>   priv->xsk_pools, priv->ntfy_blocks and priv->stats_report are NULL,=E2=
=80=A6
> - [High] gve_get_stats() (ndo_get_stats64) checks 'if (priv->rx)' and 'if
>   (priv->tx)' and then walks the ring arrays with no lock or RCU=E2=80=A6
> - [Medium] gve_reset() uses the non-sync
>   disable_work(&priv->service_task), which does not wait for a service=E2=
=80=A6
> - [Medium] gve_shutdown() and gve_suspend() sample was_up =3D
>   netif_running() before disable_work_sync() and before taking RTNL and=
=E2=80=A6
> - [Medium] gve_add_flow_rule(), gve_del_flow_rule() and the new NTUPLE-
>   disable branch in gve_set_features() start a reset only when the error=
=E2=80=A6
>
> --
>
> gve: simplify reset logic
>
> This commit reworks the gve reset path to remove recursive resets and
> resets triggered during teardown. It splits control plane allocation from
> device setup, and gve_reset() now tears down queues and the control plane
> directly before calling gve_recover(). Shared memory is meant to be freed
> only after the hardware reset done in gve_adminq_free().
>
> > 2) Removing resets during the teardown portion of reset. This is partly
> >    covered by removing recursive resets, but the primary goal in this
> >    case is to allow the driver to complete teardown in a more direct
> >    manner. Before this patch, gve_close() when called as part of
> >    gve_shutdown, could end up triggering a hardware reset, then attempt
> >    to close again. In such a case, destroying hardware queues would
> >    inevitably fail, causing a loop. gve_close() is no longer called
> >    directly in gve_reset() breaking any possibility of this loop.
>
> [Severity: Low]
> Is this description of the old behaviour accurate? In the baseline,
> gve_reset_and_teardown() calls gve_trigger_reset() first, and
> gve_adminq_release() ends with:
>
>         gve_clear_device_rings_ok(priv);
>         gve_clear_device_resources_ok(priv);
>         gve_clear_admin_queue_ok(priv);
>
> The second gve_close() -> gve_queues_stop() destroys rings only under
> gve_get_device_rings_ok(). So it skips gve_destroy_rings() and
> gve_unregister_qpls() entirely.
>
> The loop that did exist was the recursive gve_reset() from
> gve_adminq_configure_flow_rule() on -ETIME during teardown, via
> gve_teardown_device_resources() -> gve_flow_rules_reset().
>
> Could the commit message describe that mechanism instead?
>
> > diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net=
/ethernet/google/gve/gve_adminq.c
> > index a62cb7a921d07..901673d2e2648 100644
> > --- a/drivers/net/ethernet/google/gve/gve_adminq.c
> > +++ b/drivers/net/ethernet/google/gve/gve_adminq.c
>
> [ ... ]
>
> > @@ -1377,12 +1376,8 @@ gve_adminq_configure_flow_rule(struct gve_priv *=
priv,
> >                       sizeof(struct gve_adminq_configure_flow_rule),
> >                       flow_rule_cmd);
> >
> > -     if (err =3D=3D -ETIME) {
> > -             dev_err(&priv->pdev->dev, "Timeout to configure the flow =
rule, trigger reset");
> > -             gve_reset(priv, true);
> > -     } else if (!err) {
> > +     if (!err)
> >               priv->flow_rules_cache.rules_cache_synced =3D false;
> > -     }
> >
> >       return err;
> >  }
>
> [Severity: Low]
> Removing this call fixes a real unbounded recursion. In the baseline,
> gve_reset(priv, true) was called on -ETIME, and teardown then called
> gve_flow_rules_reset() again with no reset-in-progress guard:
>
> gve_reset()
>   gve_teardown_device_resources()
>     gve_flow_rules_reset()
>       gve_adminq_configure_flow_rule()   <- -ETIME
>         gve_reset()
>           ...
>
> The patch also carries other fixes that the commit message doesn't
> mention:
>
>   - cancel_work_sync(&priv->stats_report_task) in gve_free_stats_report()
>   - cancelling the PTP worker
>   - the NULL priv->rx check in gve_drain_page_cache()
>
> Should these be split out, or at least get a Fixes: tag, rather than
> going in under "simplify reset logic"?
>
> > diff --git a/drivers/net/ethernet/google/gve/gve_flow_rule.c b/drivers/=
net/ethernet/google/gve/gve_flow_rule.c
> > index 2c80cda28ef30..fae552f4ad6fb 100644
> > --- a/drivers/net/ethernet/google/gve/gve_flow_rule.c
> > +++ b/drivers/net/ethernet/google/gve/gve_flow_rule.c
> > @@ -278,6 +278,11 @@ int gve_add_flow_rule(struct gve_priv *priv, struc=
t ethtool_rxnfc *cmd)
> >               goto out;
> >
> >       err =3D gve_adminq_add_flow_rule(priv, rule, fsp->location);
> > +     if (err =3D=3D -ETIME) {
> > +             dev_err(&priv->pdev->dev,
> > +                     "Timeout to add flow rule, trigger reset.");
> > +             gve_reset(priv, false);
> > +     }
>
> [Severity: Medium]
> This is a pre-existing issue, which the patch moves and copies. Should th=
is
> also handle -ENOTRECOVERABLE?
>
> gve_adminq_parse_err() returns -ETIME when the device completes a command
> with a DEADLINE_EXCEEDED status. A real driver-side timeout in
> gve_adminq_kick_and_wait() returns -ENOTRECOVERABLE instead, and that
> triggers no reset.
>
> Later gve_adminq_execute_cmd() calls then fail with -EINVAL through the
> tail !=3D head check. The admin queue stays unusable until something else
> resets the device.
>
> The same -ETIME-only check is used in gve_del_flow_rule() and in the new
> NTUPLE disable branch in gve_set_features().
>
> [ ... ]
>
> > diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/e=
thernet/google/gve/gve_main.c
> > index 2fe280cf7e680..3ca0f8dba683a 100644
> > --- a/drivers/net/ethernet/google/gve/gve_main.c
> > +++ b/drivers/net/ethernet/google/gve/gve_main.c
>
> [ ... ]
>
> > @@ -590,7 +591,80 @@ static void gve_free_notify_blocks(struct gve_priv=
 *priv)
>
> [ ... ]
>
> > +static void gve_queues_mem_remove(struct gve_priv *priv)
> > +{
> > +     struct gve_tx_alloc_rings_cfg tx_alloc_cfg =3D {0};
> > +     struct gve_rx_alloc_rings_cfg rx_alloc_cfg =3D {0};
> > +
> > +     gve_get_curr_alloc_cfgs(priv, &tx_alloc_cfg, &rx_alloc_cfg);
> > +     gve_queues_mem_free(priv, &tx_alloc_cfg, &rx_alloc_cfg);
> > +     priv->tx =3D NULL;
> > +     priv->rx =3D NULL;
> > +}
>
> [Severity: High]
> This is a pre-existing issue. gve_get_stats() checks priv->rx and priv->t=
x
> and then walks the ring arrays with no lock or RCU protection:
>
> gve_get_stats() {
>         if (priv->rx) {
>                 for (ring =3D 0; ring < priv->rx_cfg.num_queues; ring++) =
{
>                         do {
>                                 start =3D u64_stats_fetch_begin(&priv->rx=
[ring].statss);
>         ...
> }
>
> dev_get_stats() callers such as /proc/net/dev hold neither rtnl nor the
> netdev lock. Here gve_queues_mem_free() kvfree()s the arrays before
> priv->tx and priv->rx are cleared, with no grace period.
>
> Can a concurrent /proc/net/dev read dereference freed ring memory when
> this runs from gve_reset(), gve_close() or gve_teardown_device()?
>
> [ ... ]
>
> > @@ -1335,15 +1393,16 @@ static void gve_rx_stop_rings(struct gve_priv *=
priv, int num_rings)
>
> [ ... ]
>
> >  /* The passed-in queue memory is stored into priv and the queues are m=
ade live.
>
> [Severity: Low]
> This isn't a bug, but the rest of this comment still reads:
>
>  * No memory is allocated. Passed-in memory is freed on errors.
>
> After this patch, the stop_rings path only calls gve_queues_stop().
> gve_open() and gve_adjust_config() now call gve_queues_mem_remove()
> themselves.
>
> On the reset path, gve_reset() frees the passed-in rings and
> gve_recover() -> gve_open() allocates new ones.
>
> Should the comment be updated to match?
>
> [ ... ]
>
> > @@ -1415,16 +1473,14 @@ static int gve_queues_start(struct gve_priv *pr=
iv,
> >
> >  reset:
> >       if (gve_get_reset_in_progress(priv))
> > -             goto stop_and_free_rings;
> > -     gve_reset_and_teardown(priv, true);
> > -     /* if this fails there is nothing we can do so just ignore the re=
turn */
> > -     gve_reset_recovery(priv, false);
> > -     /* return the original error */
> > -     return err;
> > -stop_and_free_rings:
> > -     gve_tx_stop_rings(priv, gve_num_tx_queues(priv));
> > -     gve_rx_stop_rings(priv, priv->rx_cfg.num_queues);
> > -     gve_queues_mem_remove(priv);
> > +             goto stop_rings;
> > +
> > +     /* Attempt to reset. If reset is successful, gve_queues_start was
> > +      * successful with the new config.
> > +      */
> > +     return gve_reset(priv, false);
>
> [Severity: Medium]
> Before this patch, this path returned the original error. Now it returns
> the result of gve_reset(), so a successful recovery is reported to the
> caller as success. Can this break an AF_XDP zero-copy bind?
>
> On a running DQO RDA interface with XDP loaded:
>
> gve_xsk_pool_enable()
>   set_bit(qid, priv->xsk_pools)
>   gve_configure_rings_xdp()
>     gve_adjust_config()
>       gve_queues_start()
>         gve_create_rings() fails
>         return gve_reset(priv, false)
>           gve_free_control_plane_resources()    <- frees xsk_pools
>           gve_recover()
>             gve_alloc_control_plane_resources() <- new, empty bitmap
>             gve_open() -> gve_reg_xdp_info()    <- no XSK pool found
>
> gve_xsk_pool_enable() then sees 0, and xp_assign_dev() marks the socket
> zero-copy, even though the queue now uses an ordinary page pool.
>
> Wouldn't the socket then silently receive no traffic?

This is a possibility, but the same issue could occur if any
configuration required a reset before this patch while XSK pools were
enabled. Suppose that a ring size adjustment resulted while XSK pools
were enabled. In both cases, the datapath would come back up without
XSK pools being attached. The fix for this would probably to only
allocate XSK pools in probe, and release them in remove/shutdown.
However, that change can be made entirely independently of this patch
and introduced as a fix, since the change would be relatively small,
non-invasive, and tangential to this reset path change.

>
> > +stop_rings:
> > +     gve_queues_stop(priv);
> >       return err;
> >  }
> >
> > @@ -1435,70 +1491,55 @@ static int gve_open(struct net_device *dev)
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
> This is a pre-existing issue, and this check fences only gve_open().
>
> After a failed gve_recover() takes the teardown_device path,
> priv->xsk_pools, priv->ntfy_blocks and priv->stats_report are NULL, and
> the admin queue dma_pool is destroyed. netif_running() usually stays true=
,
> because gve_reset() was called from the service task or ethtool with the
> interface up.
>
> netif_device_detach() blocks ethtool and dev_open, but ndo_bpf and
> ndo_set_features are still reachable. Could these then oops or use freed
> memory?
>
> AF_XDP zero-copy bind:
>   gve_xsk_pool_enable()
>     set_bit(qid, priv->xsk_pools)   <- NULL bitmap
>
> gve_xsk_pool_disable() does clear_bit() on the same NULL bitmap.
>
> ethtool -K (GRO_HW) or XDP attach:
>   gve_set_features() / gve_set_xdp()
>     gve_adjust_config()
>       gve_close()                    <- succeeds, rings_ok is false
>       gve_queues_start()
>         gve_tx_start_rings()         <- indexes NULL priv->ntfy_blocks
>         gve_register_qpls()
>           gve_adminq_execute_cmd()   <- freed admin queue
>
> Would a gve_get_device_resources_ok() check in gve_adjust_config() and in
> the XSK pool paths help here?
>
> >       gve_get_curr_alloc_cfgs(priv, &tx_alloc_cfg, &rx_alloc_cfg);
> >
> >       err =3D gve_queues_mem_alloc(priv, &tx_alloc_cfg, &rx_alloc_cfg);
> >       if (err)
> >               return err;
> >
> > -     /* No need to free on error: ownership of resources is lost after
> > -      * calling gve_queues_start.
> > -      */
> >       err =3D gve_queues_start(priv, &tx_alloc_cfg, &rx_alloc_cfg);
> > -     if (err)
> > +     if (err) {
> > +             gve_queues_mem_remove(priv);
> >               return err;
> > +     }
>
> [Severity: High]
> Can this free memory that the device still references, without the
> device ever being reset?
>
> When gve_open() is called from gve_recover(priv, true), reset_in_progress
> is set. A failure in gve_register_qpls() or gve_create_rings() inside
> gve_queues_start() therefore goes from the reset label straight to
> stop_rings:
>
> reset:
>         if (gve_get_reset_in_progress(priv))
>                 goto stop_rings;
>
> Neither function rolls back on failure. gve_register_qpls() leaves the
> earlier QPLs registered. gve_create_rings() may already have created all
> TX queues, whose q_resources the device writes to ("This failure will
> trigger a reset - no need to clean up").
>
> gve_queues_mem_remove() here then unmaps and frees the QPL pages,
> descriptor rings and q_resources.
>
> gve_recover() then returns err and deliberately keeps the admin queue, so
> gve_adminq_free() never resets the device. DEVICE_RINGS_OK was never set,
> so a later gve_close() won't destroy those queues either.
>
> That seems to conflict with the guarantee, in both the commit message and
> the gve_reset_device() kdoc, that shared memory is freed only after the
> device has been reset.

This is a pre-existing issue, but it is marked as non-pre-existing
because the commit message calls out this behavior.

This edge case is tricky to deal with because the alternative that was
introduced in V8 is to tear down the device. For that solution, while
netif_device_detach() means that we no longer have to worry about a
case where the device has access to bus addressses for unallocated
memory, that solution also inadvertently removes any recovery
mechanisms through device-requested resets via the managment interrupt
or user-requested resets via ethtool.

An alternative solution might be to attempt to teardown QPLs, and
schedule a reset/teardown device if that doesn't work, but that has
its own risks, as it could open up a new edge case to resolve.

>
> [ ... ]
>
> > -static int gve_queues_stop(struct gve_priv *priv)
> > +static int gve_close(struct net_device *dev)
> >  {
> > +     struct gve_priv *priv =3D netdev_priv(dev);
> >       int err;
> >
> > -     netif_carrier_off(priv->dev);
> > +     gve_turndown(priv);
> > +
> > +     /* Surrender to reset if the queue destroying adminq cmds fail. R=
eset
> > +      * will not re-enable the interface.
> > +      */
> >       if (gve_get_device_rings_ok(priv)) {
> > -             gve_turndown(priv);
> > -             gve_drain_page_cache(priv);
> > +             gve_clear_device_rings_ok(priv);
> >               err =3D gve_destroy_rings(priv);
> >               if (err)
> > -                     goto err;
> > +                     goto reset;
>
> [ ... ]
>
> > +reset:
> > +     err =3D gve_reset(priv, true);
> > +     return err;
> >  }
>
> [Severity: High]
> This is a pre-existing issue, and the rewritten reset label keeps it.
>
> gve_adjust_config() allocates the new rings with gve_queues_mem_alloc()
> before calling gve_close(). On DQO RDA, gve_rx_create_page_pool() stores
> a pointer into the notify block array in each new page pool:
>
>     .napi =3D &priv->ntfy_blocks[ntfy_id].napi,
>
> Suppose gve_destroy_rings() or gve_unregister_qpls() fails here. Then
> gve_reset(priv, true) runs gve_free_control_plane_resources() ->
> gve_free_notify_blocks(), which kvfree()s priv->ntfy_blocks.
> gve_recover() then allocates a new array.
>
> If gve_reset() returns 0, gve_adjust_config() carries on with:
>
>     err =3D gve_queues_start(priv, tx_alloc_cfg, rx_alloc_cfg);
>
> The pre-allocated rings passed in still have page pools pointing at the
> freed ntfy_blocks. Can page_pool_napi_local(), or
> page_pool_disable_direct_recycling() via gve_rx_stop_ring_dqo(), then
> dereference freed memory?
>
> If recovery fails instead, gve_adjust_config() calls
> gve_queues_mem_free() on the same rings, and page_pool_destroy() sees the
> same stale napi pointer.
>
> This is reachable from gve_set_features(), gve_adjust_queues() or
> gve_set_xdp() when an admin queue destroy command fails.
>
> [ ... ]
>
> > @@ -2545,62 +2557,79 @@ static int gve_reset_recovery(struct gve_priv *=
priv, bool was_up)
>
> [ ... ]
>
> > +     if (setup_queues) {
> > +             /* On failure, hold on to the control plane to give a
> > +              * chance for the queues to be brought up later.
> > +              */
> >               err =3D gve_open(priv->dev);
> > -             if (err)
> > +             if (err) {
> > +                     dev_err(&priv->pdev->dev,
> > +                             "Failed to start queues: err=3D%d, !!! DI=
SABLING ALL QUEUES !!!\n",
> > +                             err);
> >                       return err;
> > +             }
> >       }
> > +
> > +     /* undo any detach from an earlier failure */
> > +     netif_device_attach(priv->dev);
> > +
> >       return 0;
>
> [Severity: Medium]
> If setup_queues is true and gve_open() fails, this returns before
> netif_device_attach(). The comment says the control plane is kept so the
> queues can be brought up later. But if an earlier gve_recover() failure
> had detached the netdev, won't it stay detached?
>
> For example:
>
> gve_reset() -> gve_recover() fails -> netif_device_detach()
> gve_suspend()
> gve_resume()
>   gve_recover(priv, up_before_suspend =3D true)
>     gve_setup_device() succeeds
>     gve_open() fails
>     return err            <- netif_device_attach() skipped
>
> device_resources_ok is set at that point. But __dev_open() and the
> ethtool ops return -ENODEV, so the queues can't be brought up without
> rebinding the driver.

This is an edge case that was not caught when introducing
netif_device_present() semantics. This can be fixed by setting
netif_device_present() after gve_device_setup() completes instead of
after gve_open(). However, I think it is important to mention that if
gve_recover() fails both as part of a driver reset and part of a
future resume, something has likely gone quite wrong, and triggering a
reset via ethtool isn't likely to help. Since the management interrupt
is still set up in this case, the device can still trigger a reset.

>
> >
> > -err_free_adminq:
> > -     gve_adminq_free(priv);
> > -err:
> > -     dev_err(&priv->pdev->dev, "Reset failed! !!! DISABLING ALL QUEUES=
 !!!\n");
> > -     gve_turndown(priv);
> > +teardown_device:
> > +     dev_err(&priv->pdev->dev, "Recover failed: err=3D%d, detaching de=
vice\n",
> > +             err);
> > +     netif_device_detach(priv->dev);
> > +     gve_teardown_device(priv);
> >       return err;
> >  }
>
> [Severity: Low]
> When gve_recover() fails here, the netdev is detached and
> gve_teardown_device() frees MSI-X, the management IRQ and the admin queue=
.
>
> With the device not present, the ethtool ioctl and netlink paths return
> -ENODEV, so gve_user_reset() can't be reached. __dev_open() refuses the
> device as well. With the management IRQ gone, nothing can queue
> service_task for a device-requested reset either.
>
> Before this patch, a failed gve_reset_recovery() only freed the admin
> queue and turned the queues down, so a later ethtool --reset could retry.
>
> Is it intended that one transient failure in gve_adminq_init(),
> gve_adminq_verify_driver_compatibility() or gve_setup_device() now leaves
> the NIC unusable until the driver is rebound or a suspend/resume cycle
> runs? The v9 changelog mentions this, but the commit message doesn't.
>
> >
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
> >       }
>
> [Severity: Low]
> gve_reset() now always takes the graceful path. With the interface up, it
> sends the destroy-queue and unregister-QPL commands first. It then sends
> the flow-rule reset, stats detach and deconfigure commands in
> gve_teardown_control_plane_resources(). All of this happens before
> gve_adminq_free() actually resets the device.
>
> That now also covers resets requested through the service task: device
> status RESET_MASK, TX timeout and RX errors. Before this patch,
> gve_handle_reset() called gve_reset(priv, false), which released the
> admin queue first and skipped every admin queue command.
>
> On a device that has stopped processing the admin queue, won't the first
> batch command stall for about two seconds while rtnl_lock and the netdev
> lock are held?
>
> gve_handle_reset()
>   gve_reset(priv, false)
>     gve_destroy_rings()
>       gve_adminq_destroy_tx_queues()
>         gve_adminq_kick_and_wait()   <- times out
>
> Later commands fail fast through the tail !=3D head check in
> gve_adminq_execute_cmd(), so the stall is limited to about one timeout.
>
> Was dropping the reset-hardware-first ordering for device-requested
> resets intended? The commit message doesn't mention it.
>
> >
> > -     /* Set it all back up */
> > -     err =3D gve_reset_recovery(priv, was_up);
> > +     disable_work(&priv->service_task);
>
> [Severity: Medium]
> This is a pre-existing issue. disable_work() doesn't wait for a service
> task that is already running.
>
> gve_service_task() -> gve_handle_link_status() checks
> gve_get_napi_enabled() and netif_carrier_ok() without rtnl or the netdev
> lock, and may call netif_carrier_on().
>
> If that runs at the same time as gve_turndown() in a gve_reset() triggere=
d
> by ethtool or a flow rule, can the carrier be turned back on while the
> queues are disabled mid-reset? If the reset takes longer than
> watchdog_timeo, this could also cause a spurious tx_timeout.
>
> > +     gve_reset_device(priv);
> > +     gve_queues_stop(priv);
> > +     gve_queues_mem_remove(priv);
> > +     gve_free_control_plane_resources(priv);
>
> [ ... ]
>
> > @@ -2991,17 +3022,16 @@ static void gve_shutdown(struct pci_dev *pdev)
> >       struct gve_priv *priv =3D netdev_priv(netdev);
> >       bool was_up =3D netif_running(priv->dev);
> >
> > -     netif_device_detach(netdev);
> > +     disable_work_sync(&priv->service_task);
> >
> >       rtnl_lock();
> >       netdev_lock(netdev);
> > -     if (was_up && gve_close(priv->dev)) {
> > -             /* If the dev was up, attempt to close, if close fails, r=
eset */
> > -             gve_reset_and_teardown(priv, was_up);
> > -     } else {
> > -             /* If the dev wasn't up or close worked, finish tearing d=
own */
> > -             gve_teardown_priv_resources(priv);
> > -     }
> > +     if (was_up)
> > +             gve_close(priv->dev);
> > +
> > +     /* detach here because gve_close() might attach in recovery */
> > +     netif_device_detach(netdev);
> > +     gve_teardown_device(priv);
>
> [Severity: Medium]
> This is a pre-existing issue. was_up is sampled before
> disable_work_sync(), rtnl_lock() and netdev_lock().
>
> If the interface is opened in that window, gve_close() is skipped. Then
> gve_teardown_device() frees ntfy_blocks and the rings while NAPI is still
> enabled. Could that lead to a use-after-free from NAPI?
>
> The added disable_work_sync() makes this window slightly wider.
> gve_suspend() follows the same pattern.
>
> [ ... ]
>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20260930190428.1130007-1-hramamurthy%40google.com


-- Josh
