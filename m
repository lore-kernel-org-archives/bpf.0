Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C210628D82F
	for <bpf@vger.kernel.org>; Fri, 27 Mar 2026 02:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774579182; cv=pass; b=Z95/GrN5ppIKMZXLDnuHE9wr6J0hO75TPcG+0MDlmp+SZUXZzXUNEeWyA0Y4B473gUuhi2Y1T1ZIPDnfslIiL71Nkb+HiR07q90VFW93eiDZZawQuaFNssLausTMuxK4IaXop9chVlNaJjNO5R1nKi0s/txfonQKE4ysJSSTSNw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774579182; c=relaxed/simple;
	bh=fFnLdx80Lwgt+BNY1Dx1jqYlDMZ++tOi6mJEx2z902I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ON4D9JyVQf/w2rwW86r2oKXcvdnCVJU+ZpmGEt4FZgJoJx9WgdHclOE1NORwMmfv8bVKEMO8kqSU8iHXP8RpxAUa274k4lFNfje94ZSWp7XILZzKE/k8vnE8W0FBPiPrl97FaIdlAVzlplQUPUe+CLwd11cZDA/Laa5wVFz1IbQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mcRmhyy5; arc=pass smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mcRmhyy5"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-66a922a3a05so2501356a12.0
        for <bpf@vger.kernel.org>; Thu, 26 Mar 2026 19:39:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774579178; cv=none;
        d=google.com; s=arc-20240605;
        b=HKDOMjTRA/eu2OU6Q/6lvR+CLw49dm8FttugF+msq9cbATBgOoCpC0rsFi6G0FPIZp
         eRPBJuGn2kbL074nyG0cF/3TPm91XMPqYFvRJvfRqSHfeFLHCM2R5lrl8lav6fMMFIgO
         tmYF/PVwktcRCnNu342675q4nUfmvbZJq2ZZtwPBAXK2Ct4nmBmoWWsGRm1Isx7h7Fsh
         vqIKEA8aHSwazXrA7AhHaOF/Ulwt4DPyrNra3i1MS47zXVYe0HJC/stuhw68MCh36hne
         p/99al/qTVRmGRQD+co3xBcn/PI5quIJPTVXGO8ODHE8bgEAEg8f4ds3FRy1KoASCtop
         i9Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=UJ2njBuNaj0VaWfPhX2usnjUYhb68jMwXCP3GoFIvQE=;
        fh=jACrC5W6QoJMGrvCQ5q7Zo0OKGzzI4B+OVxbwSNIOW8=;
        b=QoYlOm9Bu7MliHxl9vYyTuE9zwh/iKGzIk943RCdD0jdhKj7b1kdsAGYjW1P5/RFfi
         CQ/yxliSJ69JZj9yriBZ8J/pxCGcKkj0x5lRwAM/9w/ZUocGFJGQuTeyGqPlku1IsEnE
         7OyGhydsxQE/OOBVIRzPxea81GHa5erUBx1Wm6fb41JkMeMDDDLKR039vhb9gufwW4v5
         EVvnbp5+87K+vhYP/SMS/S/3z41eGT76IC9I1icEvUqRjz9Xp8lpO0Or2BifeydFlaj4
         BIRFTLXJRNLaGNcFKeisvlhaegL1SM/NWaFz95fH0t+TKmTrUkvmrHgHoXl6P/8CxdVt
         H7bA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774579178; x=1775183978; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UJ2njBuNaj0VaWfPhX2usnjUYhb68jMwXCP3GoFIvQE=;
        b=mcRmhyy5u5uJ9TUYMqHA5vykFUfV95SCoirQlMSXutXtkrVRQYV3P4eqBHmXvauwFO
         PxhmPjFHqdKK2RKekWE0EN9gasO4gK2a6fAD6Aq/pfSjTHxrUud+Hk4wjamCccbAfxSu
         tf2l/2eXGdq1I8KRm6MHzmK7qsiI7Zz6Ww6Ut8Fs/MGh43+rFREbaIqnhwFJ2ZFPwUyy
         iNMmt6UYPRttIctTxCiw4mBJCq8KqDdNzRV4cl7e9wTQ4oc2HjlBQ15861wQLisnXUHu
         lbaYe0aGFT/7qgmjNKZhoHagZDI3nKEnLsCiUvhkZBNPA8admw+KxYe8GwTQJ0+eYLor
         2GbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774579178; x=1775183978;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UJ2njBuNaj0VaWfPhX2usnjUYhb68jMwXCP3GoFIvQE=;
        b=Vl6hZ8OiHj81rHiP3v0JMiaerPfhUW2oU3jMnvlCmrbcMC0ItHk1pPKXgogNB/ltIZ
         In7wUKNxUB+gPSYa9g6+OLpFOziK24kb5br+JOoTaKrQSDEq/W9bh+8A79lfw5zTsPk2
         GOpB+aFkb7GKZcfsglodEJtrsrelySxv31J3xZll92UHWf2ZW/96jymCAGw8DjkFFrmk
         HKf5d5UTlNw7uaACe8yx0yaDne9BZR1N53TCgqipFEjgQ1QgE0ef3pojKSFtJ3tHPNpd
         hUFShlhAY/ory+GebjlQiGC8ghhv+jwHOWVkbem0gdugX6zJvquoNTusdZ7qoGOtvk6l
         EyrA==
X-Forwarded-Encrypted: i=1; AJvYcCVU/4ivtuWeXZWK5yE7k4l3FAJmK2/JTKO1H1aJZKTOq/nV4mSf576/7coZg/TH6u2JTXU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKaYHD/2vElpxfqOpTWJRpccJgA+7O/1vesqwR3aSo9KJk5bXJ
	dt6xtKyVzT942Ffb+aWg+3ZqWrKCRWDnJvxvc0ahZyiS2BxmCKCz0AkwPlkpQa7/9wISaLCYuuv
	q3pbpPH4KFzRMLzdODdsZ9RE1GK0zIow=
X-Gm-Gg: ATEYQzyJ1UYMMn+t0+8Ly4sUKw5s0TImaWmLUUIfPy8VTG4r5tJiM/sy3RcC/Jtlfdh
	2BO00Gv1qu/G5ZdcAHvJrxdFKmV9e+/Nq1xcxtFQv9gnK+HAAMLYSMevCx4eKF1CVqABE3iCJ6M
	LEa9+4IkkpuLLKA8++PHISNeFDnKy5QB1g+YvNVNKcd0zaoKOIz0eXSd6Z6d0Z3tbZuoBfRmlUF
	8MaaAzlayHluAKX1cy+LnTVmpjRbMLfPaoet2WjIa8jbH8SQQA+QYqG4yeg81yKOmCfLWhHXvjg
	yhdz
X-Received: by 2002:a05:6402:4618:b0:665:e9f:9021 with SMTP id
 4fb4d7f45d1cf-66b2855f8d5mr335186a12.9.1774579178032; Thu, 26 Mar 2026
 19:39:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260323182823.5813-1-teknoraver@meta.com> <20260323182823.5813-3-teknoraver@meta.com>
 <IA3PR11MB8986307A14724905DE2FDFF6E548A@IA3PR11MB8986.namprd11.prod.outlook.com>
In-Reply-To: <IA3PR11MB8986307A14724905DE2FDFF6E548A@IA3PR11MB8986.namprd11.prod.outlook.com>
From: Matteo Croce <technoboy85@gmail.com>
Date: Fri, 27 Mar 2026 03:39:01 +0100
X-Gm-Features: AQROBzBiAPRhsRa45Vggn9i03leNAE9sOWPbFipz0NnppklDg7IYO0SsDmOrUoA
Message-ID: <CAFnufp16d3BtZ_A6Zp-yV80CUruTo32EPE7pqCXKYnmzpnacxQ@mail.gmail.com>
Subject: Re: [Intel-wired-lan] [PATCH net-next v4 2/2] e1000e: add
 XDP_REDIRECT support
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
Cc: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, 
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Mohsin Bashir <mohsin.bashr@gmail.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Il giorno mar 24 mar 2026 alle ore 09:48 Loktionov, Aleksandr
<aleksandr.loktionov@intel.com> ha scritto:
>
>
>
> > -----Original Message-----
> > From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> > Of Matteo Croce
> > Sent: Monday, March 23, 2026 7:28 PM
> > To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
> > Przemyslaw <przemyslaw.kitszel@intel.com>; Andrew Lunn
> > <andrew+netdev@lunn.ch>; David S. Miller <davem@davemloft.net>; Eric
> > Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo
> > Abeni <pabeni@redhat.com>; Alexei Starovoitov <ast@kernel.org>; Daniel
> > Borkmann <daniel@iogearbox.net>; Jesper Dangaard Brouer
> > <hawk@kernel.org>; John Fastabend <john.fastabend@gmail.com>; Mohsin
> > Bashir <mohsin.bashr@gmail.com>
> > Cc: netdev@vger.kernel.org; bpf@vger.kernel.org; intel-wired-
> > lan@lists.osuosl.org; linux-kernel@vger.kernel.org
> > Subject: [Intel-wired-lan] [PATCH net-next v4 2/2] e1000e: add
> > XDP_REDIRECT support
> >
> > Add the ability to redirect packets to other devices via XDP_REDIRECT
> > and to receive redirected frames from other devices via ndo_xdp_xmit.
> >
> > New functionality:
> > - XDP_REDIRECT case in e1000_run_xdp() using xdp_do_redirect()
> > - e1000_xdp_xmit() as the ndo_xdp_xmit callback for receiving
> >   redirected frames from other devices
> > - xdp_do_flush() in e1000_finalize_xdp() for REDIR completions
> > - xdp_features_set/clear_redirect_target() in e1000_xdp_setup()
> > - NETDEV_XDP_ACT_REDIRECT and NETDEV_XDP_ACT_NDO_XMIT advertised
> >
> > Assisted-by: claude-opus-4-6
> > Signed-off-by: Matteo Croce <teknoraver@meta.com>
> > ---
> >  drivers/net/ethernet/intel/e1000e/netdev.c | 85
> > +++++++++++++++++++++-
> >  1 file changed, 81 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c
> > b/drivers/net/ethernet/intel/e1000e/netdev.c
> > index d77f208f00cc..01661e1a74e5 100644
> > --- a/drivers/net/ethernet/intel/e1000e/netdev.c
> > +++ b/drivers/net/ethernet/intel/e1000e/netdev.c
> > @@ -41,6 +41,7 @@ char e1000e_driver_name[] = "e1000e";
> >  #define E1000_XDP_PASS               0
> >  #define E1000_XDP_CONSUMED   BIT(0)
> >  #define E1000_XDP_TX         BIT(1)
>
> ...
>
> >
> > +/**
> > + * e1000_xdp_xmit - transmit XDP frames from another device
> > + * @netdev: network interface device structure
> > + * @n: number of frames to transmit
> > + * @frames: array of XDP frame pointers
> > + * @flags: XDP transmit flags
> > + *
> > + * This is the ndo_xdp_xmit callback, called when other devices
> > +redirect
> > + * frames to this device.
> > + **/
> > +static int e1000_xdp_xmit(struct net_device *netdev, int n,
> > +                       struct xdp_frame **frames, u32 flags) {
> > +     struct e1000_adapter *adapter = netdev_priv(netdev);
> > +     struct e1000_ring *tx_ring = adapter->tx_ring;
> > +     struct netdev_queue *nq = netdev_get_tx_queue(netdev, 0);
> > +     int cpu = smp_processor_id();
> > +     int nxmit = 0;
> > +     int i;
> > +
> > +     if (unlikely(test_bit(__E1000_DOWN, &adapter->state)))
> > +             return -ENETDOWN;
> > +
> > +     if (unlikely(flags & ~XDP_XMIT_FLAGS_MASK))
> > +             return -EINVAL;
> > +
> > +     if (!adapter->xdp_prog)
> > +             return -ENXIO;
> > +
> > +     __netif_tx_lock(nq, cpu);
> > +     txq_trans_cond_update(nq);
> > +
> > +     for (i = 0; i < n; i++) {
> > +             int err;
> > +
> > +             err = e1000_xdp_xmit_ring(adapter, tx_ring, frames[i]);
> > +             if (err != E1000_XDP_TX)
> > +                     break;
> On first failure, we break out of the loop. frames[i] through frames[n-1] are silently abandoned.
> It should be no memleaks I hope, but silent packets drop is nasty!
>

I wanted to be consistent with other similar drivers, this i what igb
does in igb_main.c:

for (i = 0; i < n; i++) {
        struct xdp_frame *xdpf = frames[i];
        int err;

        err = igb_xmit_xdp_ring(adapter, tx_ring, xdpf);
        if (err != IGB_XDP_TX)
                break;
        nxmit++;
}

Regards,
-- 
Matteo Croce

perl -e 'for($t=0;;$t++){print chr($t*($t>>8|$t>>13)&255)}' |aplay
