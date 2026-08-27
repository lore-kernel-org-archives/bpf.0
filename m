Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16E843CE6F;
	Thu, 27 Aug 2026 10:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787827814; cv=none; b=DlL8/SBCGStbyguaCD5N2dAZhEcR8klidaOPuFB7h+oXcaq0UEsqE2qCFm8yWnmODyZldx6D3UaYZblik+0uq2vxpl6nCmx4VWyUENmO34KEkHnUR9fKFN1QtJGsOVHQf8mMjLd2EEEX9GlPc2lOA1kwLsU8JVqv1ALQ8p/CsKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787827814; c=relaxed/simple;
	bh=WKikv7UDh0swUxIskP5m5gbLAwHhjW6fwJWJtfX2mOM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=emlZdCu0XayxkUTixlZFsAKvLlSsOrWq8TYCkIJvS/0iRS64OrYzr0mJVrhhdJ39Z1Tlk4BGUoWn2Bo7C2mLeiYgJfeOKEbkGDNlpJpyJpmTovcjz2XQpk5vSaIZNbJGt6dIz8qCejFX5u9xK24GP96oroyIKAZ9sYl+9iCQ90E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=AsHVFGSQ; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="AsHVFGSQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1787827816; x=1819363816;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WKikv7UDh0swUxIskP5m5gbLAwHhjW6fwJWJtfX2mOM=;
  b=AsHVFGSQjxdIhNPh73Z/ArgCYdJEkYW0CGc4IQlayZtxxgwDoltAEqZ7
   1nhy2RdMSVTSmrZ/Du2hFYn+kHiSHzcQpLL0uS8D1dXAMuvj07PalYo39
   nGHKDu0jPpp0Mw1PINom6jOCzkh2+WMUHa8QT29AbtLReRs/+qcdwmT1d
   hOMwROVWY2QjahYY/lg5sDVfGKlvoJEXUAlpb9p0Y5azwqBJSB7xinxQw
   LwUCxVB2WHXvwqbtTX2xmXyscOJ4pyH7cedRg5MeVNRVtEWDPgAIkyz10
   YE4R8dD1b1BbyqwIfkHj6ilk2gjWMxBeGeDs6FAiPhoExCPHDOQgAm7+6
   Q==;
X-CSE-ConnectionGUID: On+VD9zvSDyogEdmr1ElXg==
X-CSE-MsgGUID: oJikmRcNRw6C4o8l2jsrCA==
X-IronPort-AV: E=Sophos;i="6.25,246,1779174000"; 
   d="scan'208";a="61843423"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2026 03:50:15 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.87.151) by
 chn-vm-ex4.mchp-main.com (10.10.87.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.45; Thu, 27 Aug 2026 03:50:11 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Thu, 27 Aug 2026 03:50:07 -0700
Date: Thu, 27 Aug 2026 12:50:07 +0200
From: Daniel Machon <daniel.machon@microchip.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
	<pabeni@redhat.com>, Horatiu Vultur <horatiu.vultur@microchip.com>, "Steen
 Hegelund" <steen.hegelund@microchip.com>, <UNGLinuxDriver@microchip.com>,
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, "Herve
 Codina" <herve.codina@bootlin.com>, Arnd Bergmann <arnd@arndb.de>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, Mohsin Bashir
	<mohsin.bashr@gmail.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH net-next v5 11/13] net: lan966x: add PCIe FDMA XDP support
Message-ID: <20260827105007.ghfhbfhko3dkr37n@DEN-DL-M70577.microsemi.net>
References: <20260520-lan966x-pci-fdma-v5-0-ca56197ae05b@microchip.com>
 <20260520-lan966x-pci-fdma-v5-11-ca56197ae05b@microchip.com>
 <20260522190126.0f2d6587@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260522190126.0f2d6587@kernel.org>

> On Wed, 20 May 2026 10:12:23 +0200 Daniel Machon wrote:
> >  #if IS_ENABLED(CONFIG_MCHP_LAN966X_PCI)
> >  extern const struct lan966x_fdma_ops lan966x_fdma_pci_ops;
> > +
> > +static inline bool lan966x_is_pci(struct lan966x *lan966x)
> > +{
> > +     return lan966x->ops == &lan966x_fdma_pci_ops;
> 
>         return IS_ENABLED(CONFIG_MCHP_LAN966X_PCI) &&
>                 lan966x->ops == &lan966x_fdma_pci_ops;
> 
> compiler will eliminate the reference to the ops as dead code
> and linker will not complain that its object is missing.

Ack. Will change in v6.

> 
> > +}
> > +#else
> > +static inline bool lan966x_is_pci(struct lan966x *lan966x)
> > +{
> > +     return false;
> > +}
> >  #endif
> >
> >  int lan966x_lag_port_join(struct lan966x_port *port,
> > diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_xdp.c b/drivers/net/ethernet/microchip/lan966x/lan966x_xdp.c
> > index 9ee61db8690b..b470f731e25c 100644
> > --- a/drivers/net/ethernet/microchip/lan966x/lan966x_xdp.c
> > +++ b/drivers/net/ethernet/microchip/lan966x/lan966x_xdp.c
> > @@ -24,6 +24,16 @@ static int lan966x_xdp_setup(struct net_device *dev, struct netdev_bpf *xdp)
> >       old_prog = xchg(&port->xdp_prog, xdp->prog);
> >       new_xdp = lan966x_xdp_present(lan966x);
> >
> > +     /* PCIe FDMA uses contiguous buffers, so no page_pool reload
> > +      * is needed. Drain NAPI before freeing the old program so
> > +      * no in-flight poll holds a stale pointer.
> > +      */
> 
> Not sure what this does. BPF programs are under RCU, they are not
> immediately freed (if that's that you mean..)
> 

It was added to stop NAPI from reading a NULL xdp_prog during a concurrent
program swap, however that issue was closed using READ_ONCE in an earlier
version. napi_synchronize() and the comment will be dropped in v6.

> > +     if (lan966x_is_pci(lan966x)) {
> > +             if (old_prog)
> > +                     napi_synchronize(&lan966x->napi);
> > +             goto out;
> > +     }

/Daniel
