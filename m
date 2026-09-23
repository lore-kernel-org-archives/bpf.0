Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A9056E056;
	Wed, 23 Sep 2026 20:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790194337; cv=none; b=KKcjMbnZRUgHXV9LkurY8DpYcfH29NVgPb+lU0Gp9v0t3Bq9yfR6PSpoSku2qrpyedPBAWNucZUdraRvOjDsPJB9xHzYMyHVLcwKInJ84f2eaYGGrgKstpA9h4UfjzvuvfqvZhbGSC88+LehVUNsFgZL8giIhqeB8sBFXxpKlus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790194337; c=relaxed/simple;
	bh=xjbIiGtnPGGNdB7Cp4RtxhvrfWalzWVLJYOsERWZ//k=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I0wsOsGhJUBQoEaNf5I14R0dO4NBG5JcOuMWBFn12B+HwFhtVLgejf8y+uvvriTFg/mlPdtI936KWU4ZfG84JmbJUk0WwcwMnyk1arJTeDgLlXKzPBjNaEAXLd27/n6+Tc0lzOiJzFTQpVINqAP+rQI+64DNwa1uyuPdBXcCYBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=zHPROmlt; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="zHPROmlt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1790194328; x=1821730328;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xjbIiGtnPGGNdB7Cp4RtxhvrfWalzWVLJYOsERWZ//k=;
  b=zHPROmlth7VU9Nr6k7HsJh+qjv0GWsvqCoULJ4+Ejve2660zNxKIVZkG
   6yXYH6qN4YpakL6Dbi+PhCFoTeNOapSEy1+298WbJzlbtgC0sSdo5DhxY
   3edWpsfULpGpQC2NPHTxYBAQy3AFKox2eDmnLmaEzFS1FhH5lRBmEkJtm
   zYERSiUsGjFMyNIEWtzB24a8T2SAMwOWjIwJxtLnIZdN+b3wJbsvTqDht
   bM68i981ETKO81bUiqGdE1kHoW+MY+i2mFCVlW98NxXCBm939RroGhEAo
   Daze0q9xiARJQOf2n0R9f8p7M12sLXprjhAamN6QRO1YRqnWc/euYO+HS
   w==;
X-CSE-ConnectionGUID: c8w4xk0VQIK9kL7RzabfGg==
X-CSE-MsgGUID: PlFzdfUORdq11vQkFWPh5g==
X-IronPort-AV: E=Sophos;i="6.27,119,1787036400"; 
   d="scan'208";a="74202281"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 13:12:00 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex1.mchp-main.com (10.10.87.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.49; Wed, 23 Sep 2026 13:11:59 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Wed, 23 Sep 2026 13:11:55 -0700
Date: Wed, 23 Sep 2026 22:11:55 +0200
From: Daniel Machon <daniel.machon@microchip.com>
To: Simon Horman <horms@kernel.org>
CC: <netdev-bot+sashiko@kernel.org>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horatiu.vultur@microchip.com>,
	<steen.hegelund@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<ast@kernel.org>, <daniel@iogearbox.net>, <hawk@kernel.org>,
	<john.fastabend@gmail.com>, <sdf@fomichev.me>, <herve.codina@bootlin.com>,
	<arnd@arndb.de>, <gregkh@linuxfoundation.org>, <mohsin.bashr@gmail.com>,
	<richardcochran@gmail.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH net-next v7 10/14] net: lan966x: add PCIe FDMA support
Message-ID: <20260923201155.lbbbtx22adz2ilhg@DEN-DL-M70577.microsemi.net>
References: <20260918-lan966x-pci-fdma-v7-10-0ecc179c8a2c@microchip.com>
 <179008205148.2160803.12818321368571406375@kernel.org>
 <20260923084538.wgkw2nt5ergoxcot@DEN-DL-M70577>
 <20260923180730.GV13925@horms.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260923180730.GV13925@horms.kernel.org>

> On Wed, Sep 23, 2026 at 10:45:38AM +0200, Daniel Machon wrote:
> 
> ...
> 
> > > [Severity: Medium]
> > > Is this path expected to work on a big-endian host?
> > >
> > > Until now the descriptor producer and the FDMA engine were both on the
> > > little-endian SoC, so the native-endian descriptor layout in
> > > drivers/net/ethernet/microchip/fdma/fdma_api.h was fine:
> > >
> > >   struct fdma_db {
> > >         u64 dataptr;
> > >         u64 status;
> > >   };
> > >
> > >   struct fdma_dcb {
> > >         u64 nextptr;
> > >         u64 info;
> > >         struct fdma_db db[FDMA_DB_MAX];
> > >   };
> > >
> > > With PCIe FDMA the descriptors live in host memory and are fetched by the
> > > endpoint, so the host and the engine can disagree on byte order. The
> > > translated addresses written here, and the status/info words written by
> > > __fdma_db_add()/__fdma_dcb_add(), all go out in host byte order, and the
> > > HW-written DONE/BLOCKL fields are read back the same way in
> > > lan966x_fdma_pci_get_next_dcb() and lan966x_fdma_pci_rx_check_frame().
> > >
> > > CONFIG_MCHP_LAN966X_PCI in drivers/misc/Kconfig only has
> > >
> > >   depends on PCI
> > >   depends on OF_OVERLAY
> > >
> > > so a big-endian host (e.g. powerpc) can select it. On such a host, would
> > > the engine see byte-swapped nextptr/dataptr and length fields, i.e. would
> > > RX/TX not work at all? Should the descriptor fields become explicit
> > > little-endian types with accessors at the hardware boundary, or should the
> > > Kconfig entry gain a little-endian dependency?
> >
> > Hmm. Never tested on PowerPC, not this driver nor the DT overlay mechanism it
> > relies on for PCI deployment, which has only been exercised on ARM and x86 so
> > far (AFAICT) [1].
> >
> > [1] https://lore.kernel.org/all/20240430183301.46568e35@bootlin.com/
> 
> I don't think that the baseline expectation is that drivers are tested
> on big-endian systems, but rather that reasonable effort is made to ensure
> that byte-order usage is correct.
> 
> In this case I suggest that will involve using __le64 instead of u64,
> coupled with calling le64_to_cpu() and cpu_to_le64() as appropriate.
> 
> Sparse can aid with getting this right.

Ack.

I am a little reluctant, when I cant really test it properly. Sashiko gives
another solution - adding a LE dependency to the Kconfig of the misc PCI driver,
maybe that'll do?

> 
> ...
> 
> > > [Severity: Medium]
> > > Is rx_bytes meant to count the frame as it arrived on the wire?
> > >
> > > By the time this runs, skb->len has already been reduced twice: the
> > > skb_trim() above drops ETH_FCS_LEN, and eth_type_trans() pulls the
> > > MAC header out of the linear region, so skb->len is short by at least
> > > ETH_HLEN. If lan966x_hw_offload() ends up untagging a VLAN header,
> > > that is another four bytes gone. So every packet delivered through
> > > lan966x_fdma_pci_rx_get_frame() undercounts rx_bytes by 14 bytes or
> > > more, which is visible to userspace via ip -s link.
> > >
> > > The frame length is available before any of that surgery happens --
> > > data_len from FDMA_DCB_STATUS_BLOCKL(db->status), or skb->len right
> > > after the skb_pull(skb, IFH_LEN_BYTES) -- so accounting could be done
> > > there instead.
> > >
> > > I realise this mirrors what the existing register/page path in
> > > lan966x_fdma.c does, so if the intent is to keep the two backends
> > > byte-for-byte consistent, please say so; otherwise it would be good
> > > not to copy the miscount into the new file.
> >
> > Not only lan966x, but sparx5 and lan969x does the exact same thing, increasing
> > rx_bytes after headers are pulled.  The undercount is real, but not visible to
> > userspace. Both implementations (platform and PCI) read hardware counters directly
> 
> I'm a little unsure, but if it's consistent then I guess that is ok.
> It's an old interface anyway.
