Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9AF18DF80
	for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 01:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789088787; cv=pass; b=mlNZNpXjFvyaQneYdZGuhMl75nL8FCLYn7/h36LNXmUpXdlsGtxPtwkMs/ZQozStrAeVPhLfQfc/8BztESj9Ze9pxBRJyECRbEQtCEsBkD07d9ErI+Af5FfPjFFfnq5joEA1CfRb6qmxOfwK1VdSYlMXKxaEPGkFhvqHG7GbeRM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789088787; c=relaxed/simple;
	bh=3anrTnb9b6fjm1Z1Gs58eq0Nwh9F0aeBL5GbmkzMyeI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PuLVlQlTM4KtQfrYZZFLZqzWZtQjexqfmub0//F7HBXvj2RjoVuSRtjZx1ijHay0ipC/3YXTgP21D7vy6T+gsqBBzWc3ARK/pfYQD+aByR1dd5a2XNEc6jY44AVbzeO4e6NIZZzHe37n+wnwtXyhJgu2qVd6/0AY1c7VQXu3jpc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uKaoqAfy; arc=pass smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uKaoqAfy"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d6ff3aca06so24145ad.0
        for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 18:06:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789088785; cv=none;
        d=google.com; s=arc-20260327;
        b=Is+ol76DBkUUnqLkY3g+3I+ZNB4ibkdFpaTHFdqlN9hYCSrcCEJO/WzoxMTTx2RDo2
         FoaOjIRD8k2Daz9xBDzZ6ipWmB4pnEQg2VozcKQgv3m34IQBts8TCxUKkluucRpWruYe
         qE5EgoBLCQZhLJtzFzIWCSRhzCTUZ1kQA7/bcEyiesYB2BVvlr1WJq8SfQkflEWJwXYI
         //z3VPz65taA/+cnroteiecpRPZyKxGhYQXzlwXTe1Y88or75XC8BhD8G/LnLo9LFw09
         elV7OiND3ZSU3oPRmwsiyUKWAhzZgtCTHzp9e5EPlNWsPvSUKH90A9+i9aMQZlOP8h7M
         tt5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kU6ol/MFIe6+8xDTyzZWs/daSwbhi6L9UOvBpCwlXMg=;
        fh=calQdykbcp8b+H5EuWR8M/qRCvxXQe7I4WbUT8LHMw8=;
        b=iGBo0dV70224LJZydY61RaXugLF6wPzQ9AsVVLrSe2rm93JdxHZvOZLUoI/qt55TKC
         pImfOB/c6W0EvZoQnL87S4xGmFcnFY9lPcPb5Ss/tSwH62GFlCo7Pw2tfh4dd40AxykU
         Etn0LXkjWU1noAFwtrApxTOL7ERh5E+uQggtAoHUtNGOur78jmuCd0Hs4cuOtkZW/UsQ
         fLz2//ZSqRY2I7smqz0hJAsttv/sjgKSWTLI48gX3qFvyZ9T2fXNiFMWyzYO4e8YtcvS
         kJ9T61AplAFwAeWIdolqSS4X0mSIJk54HmgW9De3sdSP53rLqWJGD+HNT7IpB9JeyCqW
         NuOg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789088785; x=1789693585; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kU6ol/MFIe6+8xDTyzZWs/daSwbhi6L9UOvBpCwlXMg=;
        b=uKaoqAfyAK1US82kJrofqYNSq/aXj8ugYa/215IRJcx/Je7PFnh9F+t8deidOgXV1H
         NbBQdiloRub5AvcYPObRPfDRdQxw6sfgRvXzP6fsYSOFGtFH+WBWqNoxoRa7fdF22qmE
         HbS7L9CCBxZZwAts9m5UajjiMXoV+SJQka7WZGWyLwATxkTgum8OFbzm2mH/HdwA1ahs
         J6nWy9d939Ux9RpM/j81/6zJPXRFsloS6b21W9n2LTyOMCIAnFtXX1BEXDnbp54zDIFx
         QHg+mcoSnJJvQKDAQ5sArlsv+TPnoYDIDb52Iw2xbA784/oWeAKGDSn5jhFplNRZeYbv
         h9eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789088785; x=1789693585;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kU6ol/MFIe6+8xDTyzZWs/daSwbhi6L9UOvBpCwlXMg=;
        b=IljlvLlO6teefPdE1GM/AHm8CzsnvEV/z+uOlfJdeupCHKWN0dCbVHQHk8TTHpl58X
         VHkRyH51J7w13HnR/HWP1jKoFYBeXWD2+SD2nHqRurZIU3d6oGZx+Z98XIMZtdKJZqDq
         2Y+Wcu2ZeY39OIq1VdAOMHLgNYgpQc0VlitbUsvdJhDvsbxb4OJ/79avtEGcUaAMyrDW
         ydvr4bRzqFaySsp+sArwRPUCEn3IthOcy1KoNxc4+8YMjlZ46noZhIJGoBWZ1kFSpTiF
         XPzg4K/GSaAv2zmnbvs5YdAcLqiWzjYIsfKcBjbtYjqN1nQkMjdTaA6NZ/LXxT+7xG4P
         zXAw==
X-Forwarded-Encrypted: i=1; AKwUvBzaO/FVFLIefcVrNghBaMqOEXcv1vZEj5EPq2C2EU/lWMfcmG/7XfxilYcgpGAMSleYpj0=@vger.kernel.org
X-Gm-Message-State: AFuF++nQfIaZLv7j90vq8lXCyLtxZMuj1nhUtvg9BNwXAf3B3a5kGGfb
	GQhMvvU4t2XujJoOY55pcuJRcrc+WuD+ZvFLcHCf4hkU51IaNLkOLvxSboi3hKKMJN38FX8mr+I
	lUN3lENSW4061p4bIZQ1XkpGkqRJO+qgxHoXSLfWU
X-Gm-Gg: AYBFou2FhOtfgDYh0CPXyP+IPt2aFITKm+cZxa44M6+QxNfDhtzvdnStxdhggJt81cn
	T6K8EPyK+Kdj2QbRWQtZ85a3q6wexwJASFjfQhHwiTJ6cBt4PTzirf9us1tkt6u/q+laBm6GU4y
	M4R8XEPPszARQqyxCGpzLTuD+AnvJmpHVBBox8DiZtDxDKbIurLiYYRBDwX0Efbk8bIp2NwalGl
	ukZM+b4SPkqhRk5GrrH729CWl5SGyWozHpEvkecSQ+WHz7+wcGYz+eFYaogVA7Rbwyvw3oMARm/
	aM3EoPodCcelss53bImnknbOPHFX/wFyUBmZKDOGduSVbf4CcdwsdH6BcGoJ6J2A9iKzppvmP/N
	yR7jqgNgnJzXOSnTrdbw/P8A=
X-Received: by 2002:a17:902:ce09:b0:2db:2225:d2fd with SMTP id
 d9443c01a7336-2dd2ce422edmr3459955ad.16.1789088784189; Thu, 10 Sep 2026
 18:06:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260909191136.3811892-6-hramamurthy@google.com> <178907843311.219967.13433516854329401694@kernel.org>
In-Reply-To: <178907843311.219967.13433516854329401694@kernel.org>
From: Harshitha Ramamurthy <hramamurthy@google.com>
Date: Thu, 10 Sep 2026 18:06:13 -0700
X-Gm-Features: AcwNN1Uk7_qMvIJF9mycrrKKlRnRcORMjJ7A-sPV6chshJ4vmGdQiU29r_8muRM
Message-ID: <CAEAWyHdVGwmQzL8uki7081YCydV4v=vL9cXjz_5XY2Kn=ad4rg@mail.gmail.com>
Subject: Re: [PATCH net-next v6 05/12] gve: refactor gve_init_priv for reset path
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, joshwash@google.com, andrew+netdev@lunn.ch, 
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
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider:
>
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 0 (1) =C2=B7 Low: 1
>
> - [Low] In `gve_reset_recovery()`
>   (drivers/net/ethernet/google/gve/gve_main.c:2561-2564) a `gve_open()`=
=E2=80=A6
>
> Pre-existing issues:
> - [Medium] Hardware-state divergence after a failed queue bring-up in
>   reset recovery: when `gve_reset_recovery()` gets an error from=E2=80=A6
>
> --
>
> gve: refactor gve_init_priv for reset path
>
> gve_init_priv() is reduced to only populating priv with device properties
> so it can be called once from gve_probe(), with the new gve_adminq_init()
> and gve_setup_device() helpers taking over adminq allocation and device
> setup. gve_reset_recovery() now calls those helpers directly instead of
> going through gve_init_priv().
>
> > diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/e=
thernet/google/gve/gve_main.c
> > index addfd8dc1a1a2..2fe280cf7e680 100644
> > --- a/drivers/net/ethernet/google/gve/gve_main.c
> > +++ b/drivers/net/ethernet/google/gve/gve_main.c
>
> [ ... ]
>
> > @@ -2566,15 +2541,32 @@ static int gve_reset_recovery(struct gve_priv *=
priv, bool was_up)
> >  {
> >       int err;
> >
> > -     err =3D gve_init_priv(priv, true);
> > -     if (err)
> > +     err =3D gve_adminq_init(priv);
> > +     if (err) {
> > +             dev_err(&priv->pdev->dev,
> > +                     "Failed to alloc admin queue: err=3D%d\n", err);
> >               goto err;
> > +     }
> > +
> > +     err =3D gve_adminq_verify_driver_compatibility(priv);
> > +     if (err) {
> > +             dev_err(&priv->pdev->dev,
> > +                     "Could not verify driver compatibility: err=3D%d\=
n", err);
> > +             goto err_free_adminq;
> > +     }
> > +
> > +     err =3D gve_setup_device(priv);
> > +     if (err)
> > +             goto err_free_adminq;
> >       if (was_up) {
> >               err =3D gve_open(priv->dev);
> >               if (err)
> > -                     goto err;
> > +                     return err;
> >       }
>
> [Severity: Low]
>
> The gve_open() failure in gve_reset_recovery() changes from "goto err" to
> "return err", so it no longer reaches the shared label:
>
> err:
>         dev_err(&priv->pdev->dev, "Reset failed! !!! DISABLING ALL QUEUES=
 !!!\n");
>         gve_turndown(priv);
>         return err;
>
> Is dropping the "Reset failed" message and the gve_turndown(priv) call on
> that path intended?  A failing gve_open() during recovery (for example
> gve_queues_mem_alloc() returning -ENOMEM under memory pressure) now
> returns silently to gve_reset(), which only prints its own message.
>
> The commit message says:
>
>     These changes are only code movement, no functional change.
>
> Would it be worth mentioning this behaviour change above the "---" line s=
o
> it survives in git history?  The v3 changelog note "don't free device
> resources if gve_open() fails in the reset path" is below the cut and doe=
s
> not mention the lost diagnostic or the skipped gve_turndown().
>
> For what it is worth, the later commit "gve: simplify reset logic"
> (84559f54c263) restores both: gve_recover() sends a gve_open() failure to
> its teardown_device label, which logs "Recover failed! !!! DISABLING ALL
> QUEUES !!!" and calls gve_teardown_device().
>
> [Severity: Medium]
>
> This isn't a bug introduced by this patch, but the same "return err" path
> leaves the device without any reset after a partially completed queue
> bring-up, and the refactor is a good opportunity to ask about it.
>
> When gve_open() -> gve_queues_start() fails after gve_register_qpls() or
> after some queues were created, it takes its reset label, and because
> GVE_PRIV_FLAGS_RESET_IN_PROGRESS is set it skips the reset and frees the
> ring and QPL memory instead:
>
> reset:
>         if (gve_get_reset_in_progress(priv))
>                 goto stop_and_free_rings;
>         gve_reset_and_teardown(priv, true);
> ...
> stop_and_free_rings:
>         gve_tx_stop_rings(priv, gve_num_tx_queues(priv));
>         gve_rx_stop_rings(priv, priv->rx_cfg.num_queues);
>         gve_queues_mem_remove(priv);
>         return err;
>
> gve_register_qpls() and gve_create_rings() rely on the assumption that
> "this failure will trigger a reset - no need to clean up", but on this pa=
th
> no gve_adminq_free()/gve_adminq_release() runs, so nothing writes
> GVE_DRIVER_STATUS_RESET_MASK.
>
> Can the NIC then be left with queues created and page lists registered th=
at
> reference DMA memory the driver has just released?  The baseline code had
> the same gap, since its "goto err" only logged and called gve_turndown().
>
> Here too the end of the series appears to close this: gve_recover() route=
s
> the gve_open() failure to gve_teardown_device(), which calls
> gve_adminq_free() and therefore gve_adminq_release().

As the AI notes, both the issues it has flagged are resolved in the
next patch in the series.

>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20260909191136.3811892-1-hramamurthy%40google.com
