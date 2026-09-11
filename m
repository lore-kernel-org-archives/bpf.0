Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0621A5B9E
	for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 00:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789088313; cv=pass; b=u5pD28PtcUavFCnQF7IHW+a/tpHcE01HqDPzEMLofwIQK0TqStrOcb67Yt6107XN2n8oolgKDlZhFioMgUGVbi4VD73nEE7KdHVRgR2PVAuFZh/Iwu9NZ++DDSZJoe6Uh/gvjVoPy7rzya1De1H61+6I5I4UKHbFrOLe93EYzDs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789088313; c=relaxed/simple;
	bh=4drBGv6YyhxyX+VShit8G9MBohafzwBZaOD9UZFnRQg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kj7BV9JDLQoW3U5wHndTMInjuA9Cohr7LWOY6M7EQJoBK46HsO/jAO20lo16/ttpVZsgKOriZa4NPQFnwYzn1kc+wj8i11yVT4l156ZdiNstXrsMHoMO9btsLuTGYIyOrkrGwQLvm6rP4Kya/baO0feEFqPUK0vRTCnp5+dYOwA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Kw0wluWR; arc=pass smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Kw0wluWR"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d6ff390a6cso17465ad.1
        for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 17:58:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789088310; cv=none;
        d=google.com; s=arc-20260327;
        b=nyf6QyAz3NMrTOF7ixqJRTmh8Qns1BriGdGXjBF16x8OfxtNVnXRya7d/txNMjKQhX
         GSb/0BNeQLPoRoe2UWMHaO7CkAMdu7b2cMt5OFBuhI5ngZi2PirSEaBTLdqyMrp9b2Jw
         Pkd9NciKo++2cuw6ZzPWItG27NrM3Xcc7At2ycSN+BkI1ElpdfSLQIqt6n4p+d1Yh8iz
         0h+kS9OqQCpLfyA4N24BjWJISlROiXgZOqbERAR+m5QgjKRfjzLOdxyl8Ir5du37IWQQ
         R2Bb2ij8rk7rKecQjJhHRnP9MwGkgcOA/4+Xsz0Y0w9wNC8pGo2fDjZmI6PO+tAlCTIu
         5vyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nMOObWcWSTTmBPNIJxB9A2ZkbRi5NCB7Xm1BYtKAyac=;
        fh=QinFNgPSLj906GUu+FJMKLbp9Zw2LGsUW9LLJ6e8F5s=;
        b=O2Kb4ly3n6SOZyu52i9KwFUYpBLn/+fKvUZBN/KvvTiebeLqI4qi0vxSA/gIJxVKJh
         18C/nv5dw1+x4y21JcE5toGkaefyRqxVXE1l0F7GHdEkiE4eVUsvAdgkdPRr7nc8WccZ
         16HWLdVH1oLaZLlgdoJeE8pD+trXiWV5/zKjt01+NjUSAzNJgRyqN3NMPVGFsRu3ysqd
         /KOG/HyE3s/sjgm3NZ9YEjQ0X2/PxWV1ioxjBsX2vuQRIooSebAo/EJ0fknssmJMstsS
         ujJdHU3CNMc/9ENjs3kS+OKZaMLz66eGln3Oerwpr2kzC9giyXKZOYHs2oi7WbiXar7n
         5lQg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789088310; x=1789693110; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nMOObWcWSTTmBPNIJxB9A2ZkbRi5NCB7Xm1BYtKAyac=;
        b=Kw0wluWRedRrcMdEgZz1C7knjgl71xNhzL+jxjanDdyM3D7bOb+S26t01D7taZgTPU
         MQ2YH3d70/sl2e70XaiN6xocyXFTC/VsIioObNmqpSaaxSIW+E69a/DJuCR77GsilF+L
         XqRdSRtt3Ey5Nv+W0OBTSndKKZ4/cseeK/HULMHhPFYAXyEBiKGudu50KA0nvUgc3BTj
         0QNtoZVoFccm1VVOtosWf2+lPAzVzLtHzSF4aoRSmEvgNweAXgrNkO2K/OwPgip03OEk
         kHcC+qZe3q5E3h4s+AINILraJaQwkX+wbFr5wPAnwAKXGWOvSqTW3uYebqsKKpyQRTcA
         emkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789088310; x=1789693110;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nMOObWcWSTTmBPNIJxB9A2ZkbRi5NCB7Xm1BYtKAyac=;
        b=Pi5ldazEM8OIstLpr+AzJ7WhFMRMwu2DKERL+AAEAwzkxUkKglBz6Ozdl34W1B4RqI
         a10D6UDtp5Z7gIhx+dhh5wXG01E7r7HjcurxuHYZX9Bk3NSulgda/voLPdAl0wPwNBET
         G/7CUmYj35OnDCt1sXza9lxKfpWJbFg4kO2G6yLqQ7Vw57j5mKfuqAikSAwqMJavMwIm
         ppgtXV12b+tTOCMw+WFKJrriiJ6Duuwkmt+3Wqvm+Z1r5zvX0XSFD5p1UKGBALzfQlyc
         N1oIkDH1zPfYarEZriy8AhNyFDOUcrcWvI9Shw+/GduB3jFypcHCwE8PURuwx99EzCzB
         Ehkg==
X-Forwarded-Encrypted: i=1; AKwUvBxvh8uh464iLheDDsFS1Q6zAeNCI55aH0qSFCR7WEc1XxW0bcYHxzJ3gFbsPQbEKifNkkM=@vger.kernel.org
X-Gm-Message-State: AFuF++nGKifmWIPsVZCTKeVzmIQK1OVrQPBRDXLKDJFesx89k4YuKcpo
	TrZYFWyFbau4k6/g0zOhausLGKB29Tg+SMrXAj2SKjbcUtqaPxhMYZivpcT1Po+gtdqfENtRZUA
	SjvA1h5b+HCtA1PcQnx1Wv9E9WhbL2p6FHpFhTGMnR2+u/YzU3/NEWA9qzSZNSg==
X-Gm-Gg: AYBFou0timhBsqKbXq5OYoWScB4gx6F+YmLZP7+cBW/+tLAh2hJk8beABUVziu4ppQC
	iSKaoeQPqz9ubYZFpcNia0rBAm8+seVGScd5Ur8mjh3P3O7X8K7G+cY1hMfI2pGd6FiBCoHTjmm
	d6GXPiDqd8024O6DeG6LcIDh9sBh3X1TSAvFeo4LVgSEOa1BJCsXmy2IgnwyDBR1ctfxK5W7uvP
	pElqChRiHw/fe2PlezAT+wKhlCs06WD0yR8Ejy24l372Jrh4q9qpCZFMtn59hK9AeRwNdCuFK6n
	gjLzX9yGXVHh8AdPX253ZOKaFrhZjw0VacvpERymIuFzVuaVLlJQTBD62OV/3h2byaXdBIK/DQd
	PcVrJmY/l7wstryNq0dCV+CPI0lxmffRTpQ==
X-Received: by 2002:a17:902:f686:b0:2db:a1c:be59 with SMTP id
 d9443c01a7336-2dd2f53925emr1750545ad.7.1789088309766; Thu, 10 Sep 2026
 17:58:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260909191136.3811892-5-hramamurthy@google.com> <178907843138.219967.17268659724650641980@kernel.org>
In-Reply-To: <178907843138.219967.17268659724650641980@kernel.org>
From: Harshitha Ramamurthy <hramamurthy@google.com>
Date: Thu, 10 Sep 2026 17:58:18 -0700
X-Gm-Features: AcwNN1VDb-6nUoUNVsNwOs9BNQUF7tG5NDKWvlmE8TeyMwOHffTvadhBRirJUzo
Message-ID: <CAEAWyHf63MgBXY2UvdyUx4M=Kb_73rBmwD2rUBGfAk1XOFMPmQ@mail.gmail.com>
Subject: Re: [PATCH net-next v6 04/12] gve: introduce gve_adminq_get_device_properties()
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
> - [Low] gve_adminq_get_device_properties()
>   (drivers/net/ethernet/google/gve/gve_adminq.c:1148) bundles=E2=80=A6
>
> Pre-existing issues:
> - [Medium] gve_adminq_verify_driver_compatibility()
>   (drivers/net/ethernet/google/gve/gve_adminq.c:1264, moved verbatim=E2=
=80=A6
>
> --
>
> gve: introduce gve_adminq_get_device_properties()
>
> This adds gve_adminq_get_device_properties(), a helper that runs the
> VERIFY_DRIVER_COMPATIBILITY and DESCRIBE_DEVICE admin queue commands in
> sequence, and moves the driver-info allocation and fill-in from
> gve_main.c into gve_adminq_verify_driver_compatibility().  The commit
> message describes it as pure code movement with no functional change.
>
> No Link: tags present in the commit header.
>
> > diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net=
/ethernet/google/gve/gve_adminq.c
> > index 046155ae7d669..f420a8e1dd3df 100644
> > --- a/drivers/net/ethernet/google/gve/gve_adminq.c
> > +++ b/drivers/net/ethernet/google/gve/gve_adminq.c
>
> [ ... ]
>
> > @@ -1143,6 +1145,27 @@ int gve_adminq_describe_device(struct gve_priv *=
priv)
> >       return err;
> >  }
> >
> > +int gve_adminq_get_device_properties(struct gve_priv *priv)
> > +{
> > +     int err;
> > +
> > +     err =3D gve_adminq_verify_driver_compatibility(priv);
> > +     if (err) {
> > +             dev_err(&priv->pdev->dev,
> > +                     "Could not verify driver compatibility: err=3D%d\=
n", err);
> > +             return err;
> > +     }
> > +
> > +     /* Get the initial information we need from the device */
> > +     err =3D gve_adminq_describe_device(priv);
> > +     if (err) {
> > +             dev_err(&priv->pdev->dev,
> > +                     "Could not get device information: err=3D%d\n", e=
rr);
> > +             return err;
> > +     }
> > +     return 0;
> > +}
>
> [Severity: Low]
> Should this helper also carry the state handling that gve_init_priv()
> currently performs around the same two commands?
>
> gve_init_priv() in gve_main.c does this before calling
> gve_adminq_describe_device():
>
>         priv->num_registered_pages =3D 0;
>
>         if (skip_describe_device)
>                 goto setup_device;
>
>         device_info->queue_format =3D GVE_QUEUE_FORMAT_UNSPECIFIED;
>         /* Get the initial information we need from the device */
>         err =3D gve_adminq_describe_device(priv);
>
> The queue_format reset matters because gve_adminq_describe_device()
> consumes the incoming value:
>
>         } else if (device_info->queue_format =3D=3D GVE_GQI_RDA_FORMAT) {
>                 dev_info(&priv->pdev->dev,
>                          "Driver is running with GQI RDA queue format.\n"=
);
>
> A caller that invokes gve_adminq_get_device_properties() with a stale
> non-zero device_info.queue_format would keep the previous format and end
> up with supported_features_mask left at 0, silently disabling jumbo
> frames, buffer sizes, modify-ring, flow steering, RSS and timestamps.
>
> For the record, this does not appear to be reachable anywhere: at this
> commit gve_adminq_get_device_properties() has no callers, only the
> prototype in gve_adminq.h and the definition, and gve_init_priv() still
> calls gve_adminq_describe_device() directly with the reset in place.  By
> the end of the series the concern is resolved rather than left latent:
> the single call site in gve_probe() does
>
>         priv->device_info.queue_format =3D GVE_QUEUE_FORMAT_UNSPECIFIED;
>         err =3D gve_adminq_get_device_properties(priv);

Like the AI notes, when gve_adminq_get_device_properties() is actually
used later in the series, things are setup to run properly.
>
> skip_describe_device no longer exists in the driver, and
> priv->num_registered_pages =3D 0 has moved into gve_setup_device().  Woul=
d
> it be worth a note in the commit message that the surrounding state
> handling stays with the caller?
>
> > @@ -1205,20 +1228,53 @@ int gve_adminq_report_stats(struct gve_priv *pr=
iv, u64 stats_report_len,
> >       return gve_adminq_execute_cmd(priv, &cmd);
> >  }
> >
> > -int gve_adminq_verify_driver_compatibility(struct gve_priv *priv,
> > -                                        u64 driver_info_len,
> > -                                        dma_addr_t driver_info_addr)
> > +int gve_adminq_verify_driver_compatibility(struct gve_priv *priv)
> >  {
> > +     struct gve_driver_info *driver_info;
> >       union gve_adminq_command cmd;
> > +     dma_addr_t driver_info_bus;
> > +     int err;
> > +
> > +     driver_info =3D dma_alloc_coherent(&priv->pdev->dev,
> > +                                      sizeof(struct gve_driver_info),
> > +                                      &driver_info_bus, GFP_KERNEL);
> > +     if (!driver_info)
> > +             return -ENOMEM;
>
> [ ... ]
>
> > -     return gve_adminq_execute_cmd(priv, &cmd);
> > +     err =3D gve_adminq_execute_cmd(priv, &cmd);
> > +
> > +     /* It's ok if the device doesn't support this */
> > +     if (err =3D=3D -EOPNOTSUPP)
> > +             err =3D 0;
> > +
> > +     dma_free_coherent(&priv->pdev->dev,
> > +                       sizeof(struct gve_driver_info),
> > +                       driver_info, driver_info_bus);
> > +     return err;
> >  }
>
> [Severity: Medium]
> This isn't a bug introduced by this patch, but is it safe to hand
> driver_info back to the DMA allocator when the admin queue timed out?
>
> The identical sequence lived in gve_verify_driver_compatibility() in
> gve_main.c before the move, so this is only being relocated here.
>
> On the timeout path gve_adminq_kick_and_wait() has already rung the
> doorbell and gives up without quiescing the queue:
>
>         gve_adminq_kick_cmd(priv, head);
>         if (!gve_adminq_wait_for_cmd(priv, head)) {
>                 dev_err(&priv->pdev->dev, "AQ commands timed out, need to=
 reset AQ\n");
>                 priv->adminq_timeouts++;
>                 return -ENOTRECOVERABLE;
>         }
>
> The VERIFY_DRIVER_COMPATIBILITY descriptor still carries
> driver_info_bus, so after gve_adminq_execute_cmd() returns
> -ENOTRECOVERABLE the buffer is released while the device may still
> fetch it.  Can the NIC read driver_info after dma_free_coherent() has
> returned it to the allocator?

This is a non-issue. If there is a timeout and the device is not
responding, the driver resets the device and frees the AdminQ.
>
> The same unconditional-free-after-execute pattern is used by
> gve_adminq_register_page_list(), gve_adminq_execute_extended_cmd() and
> gve_adminq_describe_device(), so if this is worth addressing it looks
> like a separate change rather than something for this code movement.
>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20260909191136.3811892-1-hramamurthy%40google.com
