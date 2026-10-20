Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792466940;
	b=tLJvMnLE7Cx3f60B+UlsNMW4W/M2pKks+rvgLLAR08n6QboI6GzuiEsFBOzo1esmqs6l
	 duN+wukaITME7dQ4VXzInX8v+o8QRunAxkc8urOvcSTR3xWHB/1AHtQ1YsuUHNCOQ33eK
	 LwyFlEUnbWMKvI5FpNHcmf+5ldU9LI+t8TVEwN2g2n2rJqppT/1VsPNMWMpK91AHR0POI
	 3aG6/IuNA73gbRvzjhixpDZRoBOd17TuftUXUiYud8MeET6EpOC7ih/NFJSlGeIMZUBfU
	 esGNNwiweubJHOahUZSYC46i0EK6ibry4Ze4EMZcEpTTWTET9DRTlKwFl9uO0RV9GJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792466940;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=eYhpFhCV1vkP+5Z5Z8wHRbiIDOGVJbobZIYMKB9tLZY=;
	b=jwx59sWzWugIA+tmIj1lQLiPQkISYOPS9HARt4ZKr8d8eIrOkIKfIhvNPVDER1nXkL8I
	 9KBFMlxUNY+bdE3p0IZh2t9bydsIRPxiph9fylc5FpeKLQHBKvkwIar8TEDsInt7gD3pz
	 zKJazLc0O3AOkOv8Yh4SqPMhBr8vdU+dxnZ9+j+ga3OABdq8ugGb2rXzLW57ye2Jska6A
	 3VKKL4SObOC0kYCojR74qNrXpmSSQrovOfJAblMmTFUUDM2Dp5UfN8T/SzHHebHosPVo5
	 LOcIUjNnh579u/vGdGdDEm6i+dfO2sLbb8MxF6t0dxzz0ThEd9k0PwupoHkfcDEu0iA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XSKQrgUG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4770606A319;
	Tue, 20 Oct 2026 03:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XSKQrgUG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 877581F000C5;
	Tue, 20 Oct 2026 03:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792466939;
	bh=eYhpFhCV1vkP+5Z5Z8wHRbiIDOGVJbobZIYMKB9tLZY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XSKQrgUGH/vud0NN4jnQ5CZIK6KTjKqy0BRlpbRhVKNnj4v0bVWBb+Avzcb2qEBUW
	 m45bzOoiGv+wH2OjTiwNBlCPLIjGVEMJNSpEXeF5RKgG6cOC3PXF3S3d3LdlXlhjXJ
	 Wlnro1p4sJH927Cl1e3sLhEJLgj4cnxBui5nQlVE9LCrUX3Ikc1fmPYcY/gHtDCP4x
	 X9Tu5NDX+qQmkegmfLtEwJmUY/iOlhQXa7aXruy0J/Fn1VNKdREfGXCLELl+dr4uoC
	 xmwItsj5+5HNstG6De1zlVCD26TutAkE5EW/8+xqPkS8s9HqXJamhjmxL5HpyQxKT0
	 IVb8uS6oufAxg==
Date: Tue, 20 Oct 2026 11:08:54 +0800
From: Jisheng Zhang <jszhang@kernel.org>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Ong Boon Leong <boon.leong.ong@intel.com>, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] net: stmmac: disable TX checksum offload
 for jumbo frames on bugged cores
Message-ID: <atbbRqSJIJ_glwuf@xhacker>
References: <20261012-stmmac-xdp-tx-pre-fixes-v1-0-05fd0c90f7e1@oss.qualcomm.com>
 <20261012-stmmac-xdp-tx-pre-fixes-v1-2-05fd0c90f7e1@oss.qualcomm.com>
 <6d1d99b5-1c3c-4e59-a0b2-e4d671e594ce@bootlin.com>
 <ata8k2EVDCDTmeE6@xhacker>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ata8k2EVDCDTmeE6@xhacker>

On Tue, Oct 20, 2026 at 08:57:55AM +0800, Jisheng Zhang wrote:
> On Fri, Oct 16, 2026 at 04:18:06PM +0200, Maxime Chevallier wrote:
> > Hi Lorenzo,
> > 
> > On 10/12/26 17:24, Lorenzo Bianconi wrote:
> > > stmmac_xdp_xmit_xdpf() decides TX checksum insertion from the queue COE
> > > capability only:
> > > 
> > > 	csum = !priv->plat->tx_queues_cfg[queue].coe_unsupported;
> > > 
> > > and lets the enhanced descriptor set TX_CIC_FULL accordingly. On the
> > > bugged_jumbo cores (snps,dwmac-3.40a, snps,dwmac-3.610 and
> > > snps,dwmac-3.710) hardware checksum insertion is broken for jumbo
> > > frames; the skb path works around it by clearing NETIF_F_CSUM_MASK in
> > > stmmac_fix_features() when the MTU exceeds ETH_DATA_LEN, so skbs are
> > > never marked CHECKSUM_PARTIAL and no checksum is inserted. The XDP TX
> > > path bypasses that workaround, so once XDP is allowed at MTU >
> > > ETH_DATA_LEN, jumbo frames sent via XDP_TX or redirected into the
> > > device would leave the interface with a full checksum insertion enabled
> > > on those cores - exactly what the workaround is meant to avoid.
> > > 
> > > Disable checksum insertion for oversized frames on bugged_jumbo cores in
> > > the XDP TX path too.
> 
> Here I want to query a generic rule from netdev maintainers:
> can XDP frame enable HW checksum on dwmac IP? Per my understanding, the
> dwmac can only do HW checksum for normal particular packets layouts, such as
> TCP, UDP. What about if XDP transmits a non-IP frame?

or a generic XDP guide from netdev maintainers:
Since XDP can tranmist arbitrary Eth frames, so how does the eth driver cope
with HW checksum if the HW checksum is intended for supported IP packet
layouts rather than arbitrary layer2 frames?

choices:
c1. Simply disabled HW checksum by default. Then XDP prog must provide
checksums themselves, lost the HW offload cap for IP packets.

c2. detect the frame in eth driver's xdp code path, then enable/disable
HW checksum accordingly. Then how? Any example in exisiting eth drivers
is appreciated.

Thanks in advance

> 
> Correct me if I misunderstood something.
> 
> Thanks
> > > 
> > > Fixes: be8b38a722e6 ("net: stmmac: Add support for XDP_TX action")
> > > Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
> > 
> > Looks cleaner to me than the alternative patch from Jisheng :
> > 
> > https://lore.kernel.org/netdev/20260929121025.20821-1-jszhang@kernel.org/
> > 
> > It sure seems there're a lot of people interested in getting XDP/XSK
> > working properly on stmmac :)
> > 
> > Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> > 
> > Maxime
> > 
> > > ---
> > >  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 8 ++++++++
> > >  1 file changed, 8 insertions(+)
> > > 
> > > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > > index ca61ab449e32..0e29c5d04714 100644
> > > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > > @@ -5276,6 +5276,14 @@ static int stmmac_xdp_xmit_xdpf(struct stmmac_priv *priv, int queue,
> > >  		return STMMAC_XDP_CONSUMED;
> > >  	}
> > >  
> > > +	/* Disable TX checksum offload for jumbo frames on cores where
> > > +	 * checksum insertion is broken for oversized frames, matching the
> > > +	 * stmmac_fix_features() workaround used by the skb path.
> > > +	 */
> > > +	if (priv->plat->bugged_jumbo &&
> > > +	    xdp_get_frame_len(xdpf) > ETH_FRAME_LEN)
> > > +		csum = false;
> > > +
> > >  	while (true) {
> > >  		skb_frag_t *frag = i ? &sinfo->frags[i - 1] : NULL;
> > >  		int len = frag ? skb_frag_size(frag) : xdpf->len;
> > > 
> > 
