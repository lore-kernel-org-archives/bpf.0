Received: from mail-ej2-f24.google.com (mail-ej2-f24.google.com [74.125.228.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4151F16B
	for <bpf@vger.kernel.org>; Sat, 19 Sep 2026 01:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.152
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789781679; cv=pass; b=AFAmlbAoe6obbJqzMZT57R2k8ET5HEIDJB92i3IfSu3hYTz3WcORD3tb14ll5j2oM2p/s1meBUIZlkeVYxkOpTdEaczUXAjL+4OARMIjxY8nwuaG1rv9tmRkmuQxrEIxJrBIQtT8DDTXz1CwDKROraGfAxo89uplBOsA5OD5kxU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789781679; c=relaxed/simple;
	bh=Kw3yDKIHcBNFvBwNRKYpzHOzLixVl79t2sfddCrbZDE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EAnS9C4T/MniK2eBADi/qSxGGjNy+kOMwP58UnFAXgywksb9BDf4pFqNb64eXpgLy1PceV0dvwRs3e79cTqRHDFgZjwVLAOkWD7LoOlBBAIQmwsthbPhPIm8JYg+/hKxNvA1jsiT1S7qR1KiWrLddz3IR3H2suiijggTvMkStSQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=af+4dh6N; arc=pass smtp.client-ip=74.125.228.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="af+4dh6N"
Received: by mail-ej2-f24.google.com with SMTP id a640c23a62f3a-c29d33431c8so192227666b.2
        for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 18:34:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789781675; cv=none;
        d=google.com; s=arc-20260327;
        b=YHLq/x+9NdAUsGfylGYnflw4tXNaEZqJ9e74yRmc4EhX65jq5M2Bd2fj9v5ypcP9pN
         4fzn/094iHzmUdSjuvMXgxte/VxQDdhsI+Q+Y+CJwGyX+Q6bEcnd6rC3n+L8uzlIKVl/
         9bu8Kzawn2M0xmYCuLeyxpLjcZK338Uh6vvTW318THv/kBqill6gOlIRcY7yNectFcHr
         qD7OkNqgrhWSQRcyXYxfwSmP8ezcmgrn/l6XBN3viKyyBk4GsjLfrvwtxUwY3gWy0X9F
         daZQCFIMpdMiMa8X69G3CceAqOWUoSYwrKfBTA7tod3IE+UKYXs1fdOczx/s/bK3pnmP
         qrcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=M8oFBZzFyz4P4xWy+QdYhioYa+kpKn6oOTM01KMzXsQ=;
        fh=WlcLHr1zmTTkiRYpMWOdfNTUOoVPt9ytgRjW4ix0kGo=;
        b=gGIXve1wJNRJG8+23JQLg5cHXvDb0aG/OTX7Xho6Yxiw1KFjCpr8Xfmh6pSZ5uuax+
         2050ZzUsLrkaSMIYX+Ih4Fngb2D0OPWxWbUPJDry+jAHNOm/abY85/QIltOpP1Z2Adq/
         3e6dqmlM3Aa9h9iygcLjgIl2qj9RztU062N9JRGd02a9RkAfx51JoIAH7F0JSpiDRabf
         2JASOKZKrKaOTxVeRS/pC/xSq5+4HqyfdAUOdZANiJEdNIijFVTkZSgYILPRSe7eqKH+
         K3NjZAxh92TMfqGUs6RNvo2e129bgncT4WY36aTbuOnm1N31B2YLRF7wM+70IJUOLFBL
         kX6A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789781675; x=1790386475; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=M8oFBZzFyz4P4xWy+QdYhioYa+kpKn6oOTM01KMzXsQ=;
        b=af+4dh6NnVFu+EsLh67wXDuu00R3s3HAWLnEUDlyMjsrBmJ63rp7RmkRtBILldFcBi
         Na3BxFW9KBLMJITMCvDiwZJdYu3ylc/XhpLl3lv/5JikaCJzheYsgVdBQ76VBzTfn4B9
         2u3h/NV4Po8HCCxiyZOPK7XKjh4H2AFm+9Y+ctEdbY+yIFg8u7UnE0Gbi05eNMgVEU3y
         7VbfKIxqDXy3HZklFtg8Pthxsiiy9bxmm97Yj4G29dS5gdvOmlk6C4N8LNm3hzlo9BBa
         1Cg29Zv2MFhrimGd6ivzWCCxK5jFsxmeLUVi1fVtpLqxmbHBOsLmwBw7q7YfaN20g6GP
         RhOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789781675; x=1790386475;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M8oFBZzFyz4P4xWy+QdYhioYa+kpKn6oOTM01KMzXsQ=;
        b=sfTAtUJcodaHoV9WHF3jG7KaWN9NjBdSkYhujnvp8ovbQ4t3bh08uDccBAvMbiZ2lK
         BjlpJ4A4NCP8XPqcz8m9Ouvgi57b9iqdt4io+dx2Q7a2LnGbTaRSkn1pufrG9Alv+HiB
         QSYYnImmFF/y/qKww7mpnrb82oL+PCa5aUmkjHd9BxhLOHHveoqPkHmS50Y6Mn+IdSP1
         fz5yX/Wtvg6JPqsX98etIwxy/4Xssr+sNytH8zZdV+jj+jKUWpfrdTgxiykCf9cN0ocI
         XJA1vklSB7Q4z2hzsEVgbsA0dI8VA91RWRxBayTK11Romb6BMVeTXwhMwbIU18kN5cnN
         XItw==
X-Forwarded-Encrypted: i=1; AKwUvBzNJdOPn/pcw4RqBs8b0EO/+ff9O8yISzI5tWS/RuqkxA+c5DeGnS7Wzjcqlssbv3TImD0=@vger.kernel.org
X-Gm-Message-State: AFuF++nYZIUP8Hk8bZeVIgjTcW6ww/1j81aDTDjjmIC8V8+irl2UJhwF
	27xlMhvC1d6ewY5taTvQ3n+iVowYXpBGlE3XkE08Q0MqkCwCVXs21rwlDEQKT253rnd/YE2DAHf
	rM3fve4JMCAM+L47mpPUd6fHlj0kr7B55sWjjLLj5UqWoQM6zhUP5NMwkqz0=
X-Gm-Gg: AYBFou1PHJwBxsZyKgoAGxGIyf/Ijo9GuGn170k7IVou0bSK/pSTVDzJOZj9kLmhYqz
	wkYJGuovIv5orkAIZOz3MarvY0Z8E2OfrcMlzh7TXsNjurG7ptxNJ/UTjLn9xQU08J1Kg/oeNuR
	Xyrj46Gg6f4aiBZGrUsBhIS9OAmvVod7f0qHEvD+HglLsoIJgQrhqW66zBKvUT864CXUyv7RctZ
	R1IhjeL6xfdrvWb2thYKCEjPuNEYrK38aFlYNqQF+vikiKxWSohoqANt4VcwVV3/OrcZWQ/PZi8
	EZxRi8J/h22FUjghCXTgkbxunb4NXzI7Pe0yWS7L55rUy2QOueglyLcl
X-Received: by 2002:a17:907:97cd:b0:c26:19e3:e98d with SMTP id
 a640c23a62f3a-c2a15829046mr383999566b.45.1789781328145; Fri, 18 Sep 2026
 18:28:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260916165533.2187434-7-hramamurthy@google.com> <178971826647.22033.15667934166032456970@kernel.org>
In-Reply-To: <178971826647.22033.15667934166032456970@kernel.org>
From: Joshua Washington <joshwash@google.com>
Date: Fri, 18 Sep 2026 18:28:35 -0700
X-Gm-Features: AcwNN1U5mBd-tfQpz5zMywaZdp4PlIdV9DV3YU1kzHcXc8IjZIXDNbZ8URz6txc
Message-ID: <CALuQH+U8+KxX0kRwo8pw-tLD6tFzEn5jVbO9AGfY_SiiwsgkHA@mail.gmail.com>
Subject: Re: [PATCH net-next v7 06/12] gve: simplify reset logic
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

On Fri, Sep 18, 2026 at 12:57=E2=80=AFAM <netdev-bot+sashiko@kernel.org> wr=
ote:
>
> Thank you for your contribution! Sashiko AI review found 7 potential
> issue(s) to consider:
>
> Critical: 0 =C2=B7 High: 1 =C2=B7 Medium: 4 (2) =C2=B7 Low: 2
>
> - [High] gve_recover()'s new failure path calls gve_teardown_device()
>   (e.g. when gve_open() fails on queue-memory allocation), freeing all=E2=
=80=A6
> - [Medium] The -ETIME (admin-queue timeout) reset trigger was removed
>   from the shared helper gve_adminq_configure_flow_rule() and re-added=E2=
=80=A6
> - [Medium] gve_mgmnt_intr() now silently discards the management
>   interrupt whenever DEVICE_RESOURCES_OK is clear.
> - [Medium] gve_queues_start()'s `reset:` path returns gve_reset()'s
>   status instead of the original error, so a successful reset converts a=
=E2=80=A6
> - [Medium] Queue-creation failure during reset recovery frees device-
>   owned ring memory before the hardware reset.
> - [Low] The patch removes a synchronous gve_reset() on admin-queue
>   timeout from the shared flow-rule helper, which fixes a genuine=E2=80=
=A6
> - [Low] The commit message uses a `deconfigure_device_resources` failure
>   as its example of a path that 'preempts its reset with another reset=E2=
=80=A6
>
> Pre-existing issues:
> - [Medium] Failed queue setup during reset recovery omits
>   gve_unreg_xdp_info(), leaking the XDP memory-model reference on DQO=E2=
=80=A6
> - [Medium] A service task that already observed GVE_PRIV_FLAGS_DO_RESET
>   can block on RTNL while a concurrent direct gve_reset() (ethtool/flow-=
=E2=80=A6
>
> --
>
> gve: simplify reset logic
>
> This reworks the gve reset path: recursive resets and resets during
> teardown are removed, allocation is split from device setup, and the
> hardware reset is now performed before shared resources are freed.
>
> > gve: simplify reset logic
> >
> > [ ... ]
> >
> > 2) Removing resets during teardown. This is partly covered by removing
> >    recursive resets, but the primary goal in this case is to ensure tha=
t
> >    the driver is capable of actually executing a hardware reset if
> >    something goes wrong with a control plane operation. As it stands, i=
f
> >    `deconfigure_device_resources` fails, for example, GVE will preempt
> >    its reset with another reset without actually invoking a hardware
> >    reset, which could actually help with recovery.
>
> [Severity: Low]
> Is the deconfigure_device_resources example accurate?  In the baseline th=
at
> branch calls gve_trigger_reset(), which is just a wrapper for
> gve_adminq_release():
>
> gve_teardown_device_resources()
>         err =3D gve_adminq_deconfigure_device_resources(priv);
>         if (err) {
>                 dev_err(...);
>                 gve_trigger_reset(priv);
>         }
>
> and gve_adminq_release() does perform the hardware reset and waits for th=
e
> device to acknowledge it:
>
>         iowrite32be(GVE_DRIVER_STATUS_RESET_MASK, &priv->reg_bar0->driver=
_status);
>         while (!(ioread32be(&priv->reg_bar0->device_status)
>                         & GVE_DEVICE_STATUS_DEVICE_IS_RESET))
>
> The path that really recursed is the flow-rule -ETIME case, where
> gve_adminq_configure_flow_rule() called gve_reset() from inside teardown.
> Could the changelog name that case instead?

Yes, this was a bad example on my part. A better example would be:

gve_close() (from gve_shutdown, for example)
  gve_queues_stop() -> device_rings_ok() =3D=3D true
    gve_destroy_rings() -> fails, reset_in_progress =3D=3D false
      gve_reset_and_teardown() -> was_up =3D=3D true
      gve_close() ...

However, even in this case, it is not accurate to say that the HW reset doe=
s not
happen. I will update the commit description to correct this.

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
> [Severity: Medium]
> This helper has three callers, but the -ETIME handling is re-added below =
only
> for the add and delete cases.  Does the third caller lose reset on timeou=
t?
>
> gve_set_features()          /* ethtool -K <dev> ntuple off */
>   gve_flow_rules_reset()
>     ops->reset_flow_rules() =3D=3D gve_adminq_reset_flow_rules()
>       gve_adminq_configure_flow_rule()
>
> gve_adminq_reset_flow_rules() just forwards the return value:
>
>         return gve_adminq_configure_flow_rule(priv, &flow_rule_cmd);
>
> and gve_set_features() does:
>
>         err =3D gve_flow_rules_reset(priv);
>         if (err)
>                 goto revert_features;
>
> so an admin-queue timeout there no longer starts recovery, while before t=
his
> patch it called gve_reset(priv, true).  The v3 changelog says "only reset=
 when
> failing to program flow rules as ethtool op", and gve_set_features() is s=
uch
> an ethtool op, so was this call site simply missed?

gve_set_features() was missed. Will attempt a reset there as well.

>
> [Severity: Low]
> Removing this gve_reset() also fixes a real recursion: teardown calls
> gve_flow_rules_reset(), so an adminq timeout during gve_reset(),
> gve_remove() or gve_suspend() re-entered gve_reset() from inside teardown=
.
> Should the patch carry a Fixes: tag for 6f3bc487565d ("gve: Add flow stee=
ring
> ethtool support")?  The trailers currently only have Reviewed-by and
> Signed-off-by lines.
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
> >
> >  out:
> >       kvfree(rule);
> > @@ -290,9 +295,17 @@ int gve_add_flow_rule(struct gve_priv *priv, struc=
t ethtool_rxnfc *cmd)
> >  int gve_del_flow_rule(struct gve_priv *priv, struct ethtool_rxnfc *cmd=
)
> >  {
> >       struct ethtool_rx_flow_spec *fsp =3D (struct ethtool_rx_flow_spec=
 *)&cmd->fs;
> > +     int err;
> >
> >       if (!priv->max_flow_rules)
> >               return -EOPNOTSUPP;
> >
> > -     return gve_adminq_del_flow_rule(priv, fsp->location);
> > +     err =3D gve_adminq_del_flow_rule(priv, fsp->location);
> > +     if (err =3D=3D -ETIME) {
> > +             dev_err(&priv->pdev->dev,
> > +                     "Timeout to delete flow rule, trigger reset.");
> > +             gve_reset(priv, false);
> > +     }
> > +
> > +     return err;
> >  }
> > diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/e=
thernet/google/gve/gve_main.c
> > index 2fe280cf7e680..82bf2c5fed3f2 100644
> > --- a/drivers/net/ethernet/google/gve/gve_main.c
> > +++ b/drivers/net/ethernet/google/gve/gve_main.c
>
> [ ... ]
>
> > @@ -270,6 +271,10 @@ static irqreturn_t gve_mgmnt_intr(int irq, void *a=
rg)
> >  {
> >       struct gve_priv *priv =3D arg;
> >
> > +     /* Device resources are not okay; consider the interrupt spurious=
. */
> > +     if (!gve_get_device_resources_ok(priv))
> > +             return IRQ_HANDLED;
> > +
> >       queue_work(priv->gve_wq, &priv->service_task);
> >       return IRQ_HANDLED;
> >  }
>
> [Severity: Medium]
> Can this drop a device-requested reset?
>
> The mgmt vector is requested in gve_alloc_notify_blocks() during the
> allocation phase, while gve_set_device_resources_ok() only runs at the ve=
ry
> end of gve_setup_control_plane_resources(), after several blocking adminq
> round trips.  Any event arriving in that window, including
> GVE_DEVICE_STATUS_RESET_MASK, is acked as handled and thrown away.
>
> The only consumer of that bit is gve_service_task():
>
>         u32 status =3D ioread32be(&priv->reg_bar0->device_status);
>
>         gve_handle_status(priv, status);
>
> and it only runs when the service task is queued.  On the paths that call
> gve_recover() with setup_queues =3D=3D false (gve_reset(priv, true) from
> gve_close(), and gve_resume() when up_before_suspend is false) there is n=
o
> queue_work() from gve_queues_start(), so nothing re-samples device_status
> after the flag is set again.
>
> Since disable_work()/enable_work() already stop the service task across
> reset, and gve_reset() returns early on reset_in_progress, would simply
> queueing the work (a no-op while disabled) or re-reading device_status af=
ter
> gve_set_device_resources_ok() avoid the lost-event window?

This was originally done in an attempt to prevent an interrupt from
coming in while the device is suspended. However, this is solved by
the symmetric paired disable_work/enable_work in gve_suspend and
gve_resume, and in gve_reset. So this can be removed.

>
> [ ... ]
>
> > @@ -1416,10 +1465,11 @@ static int gve_queues_start(struct gve_priv *pr=
iv,
> >  reset:
> >       if (gve_get_reset_in_progress(priv))
> >               goto stop_and_free_rings;
> > -     gve_reset_and_teardown(priv, true);
> > -     /* if this fails there is nothing we can do so just ignore the re=
turn */
> > -     gve_reset_recovery(priv, false);
> > -     /* return the original error */
> > +
> > +     /* Attempt to reset. If reset is successful, gve_queues_start was
> > +      * successful.
> > +      */
> > +     err =3D gve_reset(priv, false);
> >       return err;
> >  stop_and_free_rings:
> >       gve_tx_stop_rings(priv, gve_num_tx_queues(priv));
>
> [Severity: Medium]
> Returning gve_reset()'s status here reports success for a queue start tha=
t
> failed.  Can that silently discard a requested configuration?
>
> In gve_queues_start() these two assignments happen only after
> gve_register_qpls() succeeds:
>
>         priv->header_split_enabled =3D rx_alloc_cfg->enable_header_split;
>         priv->rx_cfg.packet_buffer_size =3D rx_alloc_cfg->packet_buffer_s=
ize;
>
> The earlier priv->rx_cfg =3D *rx_alloc_cfg->qcfg_rx does not carry them,
> because gve_rx_get_curr_alloc_cfg() sets cfg->qcfg_rx =3D &priv->rx_cfg, =
so an
> ethtool rx-buf-len or tcp-data-split change lives only in the temporary
> alloc cfg.
>
> If gve_init_rss_config() or gve_register_qpls() fails, we jump to reset, =
and
> gve_reset() -> gve_recover() -> gve_open() -> gve_get_curr_alloc_cfgs()
> rebuilds the rings from the stale priv values, while gve_open(),
> gve_adjust_config() and gve_set_ringparam() all see 0.  Would committing =
the
> requested configuration before entering reset recovery, or propagating th=
e
> original error, be preferable?

In this case, it makes sense to propagate the original error. There is
no guarantee that the configuration itself is not the cause of the
error warranting a reset. Will revert this to propagating the original
error.

>
> [Severity: Medium]
> The commit message says "shared resources between the device and driver a=
re
> not freed until after the hardware reset has completed".  Does the
> stop_and_free_rings path below meet that guarantee during reset recovery?
>
> gve_create_rings() returns on partial success without cleaning up, for
> example TX queues created and RX creation failing:
>
>         err =3D gve_adminq_create_rx_queues(priv, priv->rx_cfg.num_queues=
);
>         if (err) {
>                 /* This failure will trigger a reset - no need to clean
>                  * up
>                  */
>                 return err;
>         }
>
> With reset_in_progress set by the enclosing gve_reset(), we then take
> stop_and_free_rings and call gve_queues_mem_remove(), which dma_free_cohe=
rent()s
> the ring memory and releases the QPL pages while those queues are still
> registered with the device.  The hardware reset only happens afterwards i=
n
> gve_recover() -> gve_teardown_device() -> gve_reset_device(), whose teard=
own
> adminq commands can block before the reset register write.  Could the dev=
ice
> still write into that freed memory?

Yes, this will have to be moved. Since gve_queues_mem_remove is
idempotent, the simplest solution might be to call
gve_queues_mem_remove as part of gve_teardown_device(), freeing the
queues at the same time as control plane resources are freed.

>
> [Severity: Medium]
> This isn't a bug introduced by this patch, but the same stop_and_free_rin=
gs
> path never calls gve_unreg_xdp_info(), so the XDP memory-model reference =
on
> DQO page pools looks leaked.
>
> gve_reg_xdp_info() registers the pool:
>
>         xdp_rxq_info_reg_mem_model(&rx->xdp_rxq, MEM_TYPE_PAGE_POOL,
>                                    rx->dqo.page_pool);
>
> and __xdp_reg_mem_model() takes an extra reference:
>
>         if (type =3D=3D MEM_TYPE_PAGE_POOL)
>                 page_pool_use_xdp_mem(allocator, mem_allocator_disconnect=
, mem);
>
> while gve_rx_free_ring_dqo() only does one page_pool_destroy().  Since
> xdp_rxq_info_unreg() is reached only from gve_unreg_xdp_info(), does the =
pool
> and mem-model id stay around after a failed queue start with XDP enabled =
on
> DQO?
>
> [ ... ]
>
> > @@ -2514,30 +2554,7 @@ static int gve_init_priv(struct gve_priv *priv)
> >       return 0;
> >  }
> >
> > -static void gve_teardown_priv_resources(struct gve_priv *priv)
> > -{
> > -     gve_teardown_device_resources(priv);
> > -     gve_adminq_free(priv);
> > -     bitmap_free(priv->xsk_pools);
> > -     priv->xsk_pools =3D NULL;
> > -}
> > -
> > -static void gve_trigger_reset(struct gve_priv *priv)
> > -{
> > -     /* Reset the device by releasing the AQ */
> > -     gve_adminq_release(priv);
> > -}
> > -
> > -static void gve_reset_and_teardown(struct gve_priv *priv, bool was_up)
> > -{
> > -     gve_trigger_reset(priv);
> > -     /* With the reset having already happened, close cannot fail */
> > -     if (was_up)
> > -             gve_close(priv->dev);
> > -     gve_teardown_priv_resources(priv);
> > -}
> > -
> > -static int gve_reset_recovery(struct gve_priv *priv, bool was_up)
> > +static int gve_recover(struct gve_priv *priv, bool setup_queues)
> >  {
> >       int err;
> >
> > @@ -2545,62 +2562,67 @@ static int gve_reset_recovery(struct gve_priv *=
priv, bool was_up)
> >       if (err) {
> >               dev_err(&priv->pdev->dev,
> >                       "Failed to alloc admin queue: err=3D%d\n", err);
> > -             goto err;
> > +             goto teardown_device;
> >       }
> >
> >       err =3D gve_adminq_verify_driver_compatibility(priv);
> >       if (err) {
> >               dev_err(&priv->pdev->dev,
> >                       "Could not verify driver compatibility: err=3D%d\=
n", err);
> > -             goto err_free_adminq;
> > +             goto teardown_device;
> >       }
> >
> >       err =3D gve_setup_device(priv);
> >       if (err)
> > -             goto err_free_adminq;
> > -     if (was_up) {
> > +             goto teardown_device;
> > +
> > +     if (setup_queues) {
> >               err =3D gve_open(priv->dev);
> >               if (err)
> > -                     return err;
> > +                     goto teardown_device;
> >       }
> > +
> >       return 0;
> >
> > -err_free_adminq:
> > -     gve_adminq_free(priv);
> > -err:
> > -     dev_err(&priv->pdev->dev, "Reset failed! !!! DISABLING ALL QUEUES=
 !!!\n");
> > -     gve_turndown(priv);
> > +teardown_device:
> > +     dev_err(&priv->pdev->dev, "Recover failed! !!! DISABLING ALL QUEU=
ES !!!\n");
> > +     gve_teardown_device(priv);
> >       return err;
> >  }
>
> [Severity: High]
> Routing a gve_open() failure into gve_teardown_device() frees the whole
> control plane while the netdev stays registered and administratively
> running.  Can that be dereferenced afterwards?
>
> gve_teardown_device() -> gve_free_control_plane_resources() calls
> gve_free_rss_config_cache():
>
>         kfree(rss_config->hash_key);
>         kfree(rss_config->hash_lut);
>
>         memset(rss_config, 0, sizeof(*rss_config));
>
> and gve_free_notify_blocks(), which leaves priv->ntfy_blocks NULL, while
> priv->cache_rss_config, priv->rss_key_size and priv->rss_lut_size (set in
> gve_init_priv()) are untouched and nothing closes the interface.
>
> Only gve_open() got the new resources_ok gate, so ETHTOOL_GRSSH still
> reaches gve_get_rxfh() -> gve_get_rss_config_cache():
>
>         memcpy(rxfh->key, rss_config->hash_key, priv->rss_key_size);
>
> with hash_key =3D=3D NULL, and ETHTOOL_GRSSH is one of the commands that =
skips
> the ns_capable(net->user_ns, CAP_NET_ADMIN) check in net/ethtool/ioctl.c.
>
> An ethtool channel change is a second route: gve_adjust_queues() still se=
es
> netif_running(priv->dev) true, so gve_adjust_config() -> gve_queues_start=
()
> -> gve_tx_start_rings() -> gve_tx_add_to_block() runs:
>
>         struct gve_notify_block *block =3D &priv->ntfy_blocks[ntfy_idx];
>         struct gve_tx_ring *tx =3D &priv->tx[queue_idx];
>
>         block->tx =3D tx;
>
> on a NULL array.  Should these entry points also be rejected (or the netd=
ev
> detached) while control-plane resources are gone?

If gve_open fails as part of gve_recover, that is meant to be an
unrecoverable state. Even if the gve_open was changed to only turndown
the device as was the case before this patch, there is still the
problem that a failure can happen before gve_open() is called. Given
that this issue predates this patch, I think it makes sense to come up
with a solution for this issue in a future patch.

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
>
> [Severity: Medium]
> This is a pre-existing issue, but the new early return only covers
> overlapping resets, not a stale pending request.  gve_handle_reset() samp=
les
> the bit before taking the locks and never rechecks it:
>
>         if (gve_get_do_reset(priv)) {
>                 rtnl_lock();
>                 netdev_lock(priv->dev);
>                 gve_reset(priv, false);
>
> If a direct gve_reset() from the ethtool or flow-rule path completes whil=
e
> the worker is blocked on RTNL, it clears both do_reset and
> reset_in_progress (and disable_work() does not wait for an already runnin=
g
> worker), so the worker performs a second full reset once it gets the lock=
s.
> Would rechecking do_reset after acquiring the locks be reasonable?

This is a good point. Will defend against TOCTOU in gve_handle_reset().

>
> >
> > -     /* If we aren't attempting to teardown normally, just go turndown=
 and
> > -      * reset right away.
> > -      */
> > -     if (!attempt_teardown) {
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
> >
> > -     /* Set it all back up */
> > -     err =3D gve_reset_recovery(priv, was_up);
> > +     disable_work(&priv->service_task);
> > +     gve_reset_device(priv);
> > +     gve_queues_stop(priv);
> > +     gve_queues_mem_remove(priv);
> > +     gve_free_control_plane_resources(priv);
> > +
> > +     enable_work(&priv->service_task);
> > +     err =3D gve_recover(priv, was_up && !skip_queue_setup);
> > +     if (err)
> > +             dev_info(&priv->pdev->dev,
> > +                      "Failed to recover in reset: %d\n", err);
> > +
> >       gve_clear_reset_in_progress(priv);
> >       priv->reset_cnt++;
> >       priv->interface_up_cnt =3D 0;
>
> [ ... ]
>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20260916165533.2187434-1-hramamurthy%40google.com

-- Josh
