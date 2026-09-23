Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA1F427A10;
	Wed, 23 Sep 2026 18:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790186858; cv=none; b=Qc+vnjjPgemXkCcC9jhpz+h4KBzilP2/U/5q0tVrgr23Bp+xGnDKVbvhe/MU8wiQ9GQ0PQ8gJOFwAdECZ/CuWpw+ZJ/5QGZzYSib7R3gg6CjO4jKZq9VVDDTHHoS1Wb9L90a0dzxd7M7MAm5BqSC6q5Sl0W9o+BfTj522hGeWAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790186858; c=relaxed/simple;
	bh=U5+nhunaLiSVoMI+VdQBIfVkc9YsZ6zc1C4hVwZKmCM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UQODosILX4M9chOGqxsrclKa2ZjPLoqrrLSc/VF3WMgRfIGRas5g1fCqR+O0k8K1cHAa/c3hCMKg1dbayM2N8cCDqVRIVM1YgByd7FHmKYCuZ0ZCTm5P+jNHuFP86PUiZOgthQPRHQJgkLDgmQOf7hG6g64BGKpGkWSkluz+jVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kZJpmvu7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kZJpmvu7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0BA91F000FF;
	Wed, 23 Sep 2026 18:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790186857;
	bh=+vDPcquJM7GahtjddOoqJJfhDpqWnXxKLvU+vehlwfQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kZJpmvu7LipMdS7s6+mj9xDLvZhIbIEu5iavgnSnpKXpDsyvWxAwjkhQfEWK5EvB3
	 puajcWtvMf/x7BQSh8XixkLDEZbx1IP0iI8dXlEFD83TJlneF5YQjtadOY6PFulIF6
	 L0G2y+7enOt+6AmbfvtSPxtYFRJzsw6kPgFlIF6GL0488YwRZ2KqW28I0ftI63c6Jn
	 Jh8OoFaA4UUyN8HygG5Q4MSkdgZkPKCj3SN2TP2BpTdxH/M1bgouZwMEDeqCyM3OFC
	 swXiKbV5JxoXCdQRQsVCdO5HqcoPaSEEausVGKdlcYl+OQ9i14JSTEpnH+23iJUVkG
	 82Dr4cmCduoCA==
Date: Wed, 23 Sep 2026 19:07:30 +0100
From: Simon Horman <horms@kernel.org>
To: Daniel Machon <daniel.machon@microchip.com>
Cc: netdev-bot+sashiko@kernel.org, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horatiu.vultur@microchip.com,
	steen.hegelund@microchip.com, UNGLinuxDriver@microchip.com,
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
	john.fastabend@gmail.com, sdf@fomichev.me, herve.codina@bootlin.com,
	arnd@arndb.de, gregkh@linuxfoundation.org, mohsin.bashr@gmail.com,
	richardcochran@gmail.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next v7 10/14] net: lan966x: add PCIe FDMA support
Message-ID: <20260923180730.GV13925@horms.kernel.org>
References: <20260918-lan966x-pci-fdma-v7-10-0ecc179c8a2c@microchip.com>
 <179008205148.2160803.12818321368571406375@kernel.org>
 <20260923084538.wgkw2nt5ergoxcot@DEN-DL-M70577>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260923084538.wgkw2nt5ergoxcot@DEN-DL-M70577>

On Wed, Sep 23, 2026 at 10:45:38AM +0200, Daniel Machon wrote:

...

> > [Severity: Medium]
> > Is this path expected to work on a big-endian host?
> > 
> > Until now the descriptor producer and the FDMA engine were both on the
> > little-endian SoC, so the native-endian descriptor layout in
> > drivers/net/ethernet/microchip/fdma/fdma_api.h was fine:
> > 
> >   struct fdma_db {
> >         u64 dataptr;
> >         u64 status;
> >   };
> > 
> >   struct fdma_dcb {
> >         u64 nextptr;
> >         u64 info;
> >         struct fdma_db db[FDMA_DB_MAX];
> >   };
> > 
> > With PCIe FDMA the descriptors live in host memory and are fetched by the
> > endpoint, so the host and the engine can disagree on byte order. The
> > translated addresses written here, and the status/info words written by
> > __fdma_db_add()/__fdma_dcb_add(), all go out in host byte order, and the
> > HW-written DONE/BLOCKL fields are read back the same way in
> > lan966x_fdma_pci_get_next_dcb() and lan966x_fdma_pci_rx_check_frame().
> > 
> > CONFIG_MCHP_LAN966X_PCI in drivers/misc/Kconfig only has
> > 
> >   depends on PCI
> >   depends on OF_OVERLAY
> > 
> > so a big-endian host (e.g. powerpc) can select it. On such a host, would
> > the engine see byte-swapped nextptr/dataptr and length fields, i.e. would
> > RX/TX not work at all? Should the descriptor fields become explicit
> > little-endian types with accessors at the hardware boundary, or should the
> > Kconfig entry gain a little-endian dependency?
> 
> Hmm. Never tested on PowerPC, not this driver nor the DT overlay mechanism it
> relies on for PCI deployment, which has only been exercised on ARM and x86 so
> far (AFAICT) [1].
> 
> [1] https://lore.kernel.org/all/20240430183301.46568e35@bootlin.com/

I don't think that the baseline expectation is that drivers are tested
on big-endian systems, but rather that reasonable effort is made to ensure
that byte-order usage is correct.

In this case I suggest that will involve using __le64 instead of u64,
coupled with calling le64_to_cpu() and cpu_to_le64() as appropriate.

Sparse can aid with getting this right.

...

> > [Severity: Medium]
> > Is rx_bytes meant to count the frame as it arrived on the wire?
> > 
> > By the time this runs, skb->len has already been reduced twice: the
> > skb_trim() above drops ETH_FCS_LEN, and eth_type_trans() pulls the
> > MAC header out of the linear region, so skb->len is short by at least
> > ETH_HLEN. If lan966x_hw_offload() ends up untagging a VLAN header,
> > that is another four bytes gone. So every packet delivered through
> > lan966x_fdma_pci_rx_get_frame() undercounts rx_bytes by 14 bytes or
> > more, which is visible to userspace via ip -s link.
> > 
> > The frame length is available before any of that surgery happens --
> > data_len from FDMA_DCB_STATUS_BLOCKL(db->status), or skb->len right
> > after the skb_pull(skb, IFH_LEN_BYTES) -- so accounting could be done
> > there instead.
> > 
> > I realise this mirrors what the existing register/page path in
> > lan966x_fdma.c does, so if the intent is to keep the two backends
> > byte-for-byte consistent, please say so; otherwise it would be good
> > not to copy the miscount into the new file.
> 
> Not only lan966x, but sparx5 and lan969x does the exact same thing, increasing
> rx_bytes after headers are pulled.  The undercount is real, but not visible to
> userspace. Both implementations (platform and PCI) read hardware counters directly

I'm a little unsure, but if it's consistent then I guess that is ok.
It's an old interface anyway.
