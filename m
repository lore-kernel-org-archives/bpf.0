Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA2C443319
	for <bpf@vger.kernel.org>; Fri,  2 Oct 2026 23:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790983436; cv=pass; b=OfNYonWmhypY5g3TJsvbAPNmXPIAWJp2wMGjQcfIGeJugMmjEPHjOsXh/IkXI974omqhzuuL33U3qjx3QOC+6Gqy0CG+8O6fvnqQ4HRQtWwd4rHeEMK/lv5PlGK8+fXeLVq2kF/lQqzLYhM/vl60XhGJDOVTuX4BLhMjeXXPb2M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790983436; c=relaxed/simple;
	bh=RRu9tqdBY3AuiE+QNEPO/+zvxhldBrdnI2YOZOTmnGg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ik7lFk8joDmBmCWuvfzZI7nTeep7STY7H8JgJfEzWcMroa/WlHr51MNdB+dJynhIzBumVzK4OPIJJJG3yH4Wz4MJvgAgeDX1EIHHFrzeFHQd0gajJHebBSdo1j9AFhLNF5A9eKsMCd6Ub+0dpJkrQDgC0hmpMYdmVEHKIyR2gmE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vmbQC762; arc=pass smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vmbQC762"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2e2e4ef20beso22125ad.0
        for <bpf@vger.kernel.org>; Fri, 02 Oct 2026 16:23:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790983434; cv=none;
        d=google.com; s=arc-20260327;
        b=AbelD8KIAhftXjndO3Mz1+gyFh7dMFuX53ROVHrDfg6pTzqnHU4qNz/q5mXB2/vsYU
         xTgvvKsQoaDdm+Om8ggRpC6wpUJxvTfvU/QWmb0QWu22j/vyFwB8bJytmqQtqX7bSPIk
         b/tpUZoivnZOFq5j6IAG55Fb1KmT+Fnyx4hIzLgD0UzuGI97ylUSJDpTLAV1TFmA5bWG
         AB5L6/btKIt2kV6+Rkm10nuTsL+EHV+EtoIUecGtt7RaKoF3ZyeqSSI/6SiP0FwCeuMo
         bLEgNP6OT7AghZ6nDpvwR9Z+Iey7qUibHC6GrPdNlA1OKz6SdijA28tFEoXkll8gpc9G
         AfSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yRPB82VFJ90lfQ7njnr7XC8e8HLChtcDRi7BTmzq/ag=;
        fh=/UGRS6eKH60YZC7jUcUbp2bcYaLbT0NeiqG2i0+UFro=;
        b=Nw8GLq8Ys4u6CS1DO/mrOml4FCccB5GQFZ6v9G7He+SrWFSdVdcJckQ93dc3LO2KvJ
         r47svefRasC01EP0y5PcVfE/FkwJETMLDRXrIXQS96k9dqKk081XeLtpIQtGmXh5bUcB
         uMfv3RGqNt+lnVkz6KVZkltufU+0X8q/+N6uk5Mwl0uligsBdOU+TzhgZqHAxnGbP2Of
         HQn2QM80Q0y8dmcUcT6v2c2523U2QkdPEZLWQ6Z1+QqWGSwKd6BBsm3hR+29x8vMiiUB
         Mpj/+T7cFttGKz3G6ZHAPcLmXtAkZbiVVq5+tPnTq7pZubADsTEl/2b1dqMIXNP7mLwb
         p43g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790983434; x=1791588234; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yRPB82VFJ90lfQ7njnr7XC8e8HLChtcDRi7BTmzq/ag=;
        b=vmbQC762YIx+c+b9Jcnd2ztRovdm6zNGjHZ6GeiASMwD7pmAJ3ugMenjclUjOA3dLb
         rJ2IdzxHW+vqGiiN30lJyeK3aZ/OmBpQJuqJRei45nG6YI2iQe4O8m8zln4qQiY1PCaZ
         X/KboT6nAaJ90wI442SPH86gBBG9WrhYcUuD2dtXmINFla2bQP+mcQsXgwX5GkYQZghF
         nBjbDfMZBYywTv/ogVf9WAy99T2cSG7LfWQRkzCwSfgVAGYTLDGRpwNN9YAZ3YL6NKPe
         w+srLCT9yHBfyP9dGe2aRGF27nmApJAUCigXBZDjq6EuBvxttRjC3krG41YGyn5E6WE5
         8GjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790983434; x=1791588234;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yRPB82VFJ90lfQ7njnr7XC8e8HLChtcDRi7BTmzq/ag=;
        b=Fgnyl8CQ6SeNIiOtJgvTR/7J4qYH8j5q1abFeTWsuZKe/Eo/SQ/9KwQdNJob7M7H5n
         qqHtVzgPgICplUEHQo9BLZvhX/cjZ7KFlCyUKrJDTxMiSJSHPW3DMuAiWmlbd85AU65i
         YFbkG2UIjW0ji4cxJHOkhr4c1gzfm5lkUfPZENS7Pj5RtvdQRGZlNhYXixZkCw/YrODH
         MsFfliVwYcFLTuy+ILxLqn2M3/0U72ay14gxyjw9Srp05cXPzqurYKbQyUYPLchF8+Qk
         LCxqDNbhF9ErZDUBjy6K9HATTUm6fZP2sl7pwZm+nfUvDhgxk+gZrvnP2wegNvEEI1Ao
         46iw==
X-Forwarded-Encrypted: i=1; AKwUvBw0C+2QmYtHWYFtjtWeGlusGfBoUCFSxOxxLKKoAxaMBXy6Gw1i21m+WcErqRJKJwx/byI=@vger.kernel.org
X-Gm-Message-State: AFq9FYJlP5H0ngIyGMtE/lGu5uYBtp0hZzy/jSCGG+cC0K8M3S427LTn
	+F6/rOrBCJawOaldyiLvvrNq1oIc0zBUvzD+1IVbhE4xs3T8ToTSB2nMPKJvuSe9WPn+bYJBuc/
	5x7UpCR3dfsLv/y2IWEDBHbCJZy+XIo86czrEBWWB
X-Gm-Gg: AYBFou1Z/k2oTpniyc5i+H+YqyatLZmr6ljqlUl1xYISuGMjUvHL5tbsoteFPeSXavy
	R7Xj0by0nO6kPNTwCMS70LNIt1TSrCDgaxmCLZ6NNm4KphYV1BMady7g6ZJBMaj2tUytwTjGxpS
	m77XJ8nmw4Ig6kqt+fhj2b6ofylBf5HZweBxX8MGMdEthJtJa+D8f0jkoIWCdqQqW9saAF1gulU
	foKBkrgCG0cr8pddf+7SYQKj+5lT2XDZm8iPKDo7JwCUGAxnKNm+CgtCbQgOu/MH8ONCKCZjY5o
	+v1GlcpCv0JqJZ0I0wRaF2BBZZnosK4E7a5FBPl+UQ3Z8jVVUZWytAOjcJ7wk/9iNDHA+xxF1IJ
	+84Km9X2S9OQuxMYcSagv2nDth7ndcU/MjZL9AKmQynRc+J083Ho9DQ==
X-Received: by 2002:a17:903:3c2b:b0:2c9:d89f:fd98 with SMTP id
 d9443c01a7336-2e530c1b194mr2089565ad.1.1790983433055; Fri, 02 Oct 2026
 16:23:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260930190428.1130007-6-hramamurthy@google.com> <179093559163.434549.8853251921845038273@kernel.org>
In-Reply-To: <179093559163.434549.8853251921845038273@kernel.org>
From: Harshitha Ramamurthy <hramamurthy@google.com>
Date: Fri, 2 Oct 2026 16:23:41 -0700
X-Gm-Features: AclHuK97xos_v4EowLQemIo8YleA2mrgDLsr55DFbDKD09wvx5nu-a-y-m1obAo
Message-ID: <CAEAWyHdJiwb_SEgmUw0TMn-kh6SNzrg3Xwr9wac=E8DpXr-hCA@mail.gmail.com>
Subject: Re: [PATCH net-next v9 05/12] gve: refactor gve_init_priv for reset path
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

On Fri, Oct 2, 2026 at 3:06=E2=80=AFAM <netdev-bot+sashiko@kernel.org> wrot=
e:
>
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 1 (1) =C2=B7 Low: 0
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [Medium] The commit message says "These changes are only code movement,
>   no functional change".
>
> Pre-existing issues:
> - [Medium] This problem wasn't introduced by this patch, but a hard reset
>   leaks the AdminQ dma_pool and its buffer.
>
> --
>
> gve: refactor gve_init_priv for reset path
>
> This patch splits gve_init_priv() so that gve_probe() now does the AdminQ
> setup (the new gve_adminq_init()) and the device property negotiation
> (gve_adminq_get_device_properties()). Device setup moves into a new
> gve_setup_device() helper. gve_reset_recovery() now calls
> gve_adminq_init(), gve_adminq_verify_driver_compatibility() and
> gve_setup_device() directly, instead of gve_init_priv(priv, true).
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
>
> [Severity: Medium]
> This isn't a bug introduced by this patch, but does a hard reset leak the
> AdminQ dma_pool and its buffer here?
>
> A hard reset is gve_reset(priv, false), or gve_reset() after gve_close()
> fails. Either way it goes through:
>
> gve_reset_and_teardown()
>   gve_trigger_reset()
>     gve_adminq_release()
>       gve_clear_admin_queue_ok(priv);
>   gve_teardown_priv_resources()
>     gve_adminq_free()
>
> gve_adminq_free() then returns early, because ADMIN_QUEUE_OK is already
> clear:
>
> void gve_adminq_free(struct gve_priv *priv)
> {
>         if (!gve_get_admin_queue_ok(priv))
>                 return;
>         gve_adminq_release(priv);
>         dma_pool_free(priv->adminq_pool, priv->adminq, priv->adminq_bus_a=
ddr);
>         dma_pool_destroy(priv->adminq_pool);
>         ...
> }
>
> So dma_pool_free() and dma_pool_destroy() never run. Then
> gve_adminq_init() here calls gve_adminq_alloc(), which puts new
> allocations in priv->adminq_pool and priv->adminq. The old pool and
> buffer are lost.
>
> The same thing seems to happen when gve_teardown_device_resources() calls
> gve_trigger_reset() after a failed AdminQ command.
>
> The baseline gve_init_priv(priv, true) path leaked in the same way. The
> later "gve: simplify reset logic" patch in this series appears to fix it.

Like the AI notes, this issue is pre-exisiting and most of the reset
related issues are fixed in the following patch =E2=80=9C"gve: simplify res=
et
logic"  in the same series.

> That patch makes gve_adminq_release() static and calls it only from
> gve_adminq_free(). It also stops gve_adminq_release() from clearing
> ADMIN_QUEUE_OK and removes gve_trigger_reset().
>
> > +     if (err) {
> > +             dev_err(&priv->pdev->dev,
> > +                     "Failed to alloc admin queue: err=3D%d\n", err);
> >               goto err;
> > +     }
> > +
>
> [ ... ]
>
> >       if (was_up) {
> >               err =3D gve_open(priv->dev);
> >               if (err)
> > -                     goto err;
> > +                     return err;
>
> [Severity: Medium]
> The commit message says:
>
>   These changes are only code movement, no functional change.
>
> Is that accurate? The patch seems to change behaviour in a few places.
>
> First, gve_adminq_init() writes the version string before it allocates
> the AdminQ:
>
>         gve_adminq_write_version(&reg_bar->driver_version);
>         return gve_adminq_alloc(priv);
>
> gve_reset_recovery() now calls this helper. That means the driver version
> string is written to the BAR0 driver_version register on every reset,
> resume and recovery. Before this patch, gve_write_version() ran only once=
,
> from gve_probe(). gve_recover() still does this at the end of the series.
>
> Second, the order of device accesses in gve_probe() changes. The version
> write now comes after the max_tx_queues/max_rx_queues ioread32be() reads
> and after alloc_etherdev_mqs(). AdminQ registration,
> VERIFY_DRIVER_COMPATIBILITY and DESCRIBE_DEVICE now run before ctrl_ops i=
s
> set, before map_db_bar() and before alloc_ordered_workqueue().

Both these two changes listed here prepare the driver for the addition
of the new control plane - the version write is now done as part of
Adminq init specifically since this won=E2=80=99t be needed in the mailbox
mode.

And in mailbox mode,  the control plane has to be setup and the device
properties negotiation has to happen before we try to allocate the
net_device. Since the max TX/RX queues that the device supports comes
from this negotiation.
>
> Third, when gve_open() fails here, the old goto err path logged "Reset
> failed! !!! DISABLING ALL QUEUES !!!" and called gve_turndown(). Now the
> function just returns. Neither gve_reset() nor gve_resume() logs the
> error, so a failed re-open after reset or resume leaves nothing in the lo=
g.

Hmm, actually the only visible effect here is the dropping of the log
line which will be back in the next patch. gve_turndown() does nothing
at this point, because NAPI is already disabled and carrier is already
off. The following patch rewrites this path anyway.

>
> The only place this is mentioned is the v3 changelog below the ---
> line, and that text is dropped when the patch is applied. The changelog
> says "don't free device resources if gve_open() fails in the reset path".
> The baseline err label did not free device resources either, though.
>
> The later "gve: simplify reset logic" patch adds a "Failed to start
> queues ... DISABLING ALL QUEUES" message in gve_recover(). At this commit=
,
> though, the message is missing.
>
> Could the commit message describe these changes, instead of calling the
> patch only code movement?

I can call out these changes in the commit message and bring the log
line back if there is a need for another respin. These issues on their
own don=E2=80=99t merit a respin IMO.

>
> >       }
> >       return 0;
>
> [ ... ]
>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20260930190428.1130007-1-hramamurthy%40google.com
