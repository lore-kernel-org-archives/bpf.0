Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792459085;
	b=BW+eEU1vUUjGrXCwQgoBTHYYCX56IOruybU1R2vmivMzjbDMeyklYxEQWSEM+Cv4ucgs
	 3LApvvLbNHhFU3Zk0jHGfDUvcj87JcIISxdjolvYxq3/j3xASDqIWm4OOH/2QAWivITMv
	 ZnrjQSNGLc0PTz1JLdt+NOXEk5noKR+ZN+bK5Mt/Yvwfqqzri8MnhiWJMAvSsflS993qg
	 dN4vk7dBG7HtmLUMkFjDovbNo+7298DJhfK5dH1CkhxRP4XXcLf06zgOVrKGhJ3lP3FCY
	 gcrbZkFsa9OILeUE95Mx1YgmgiWErLd5d8hjj1nWINtsydomxukyeJiJ1GCTBf0ONRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792459085;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=gVKlbXZWCw8qO2LC4n2LKk2ZzmgfYZxvObuGjMQnSGY=;
	b=IhMbNTpvtdzVh8QafO/hnRYVy2fqNkwDBiaHlKD9bQb0/2WbhW1KInoVM3ovdxAmoTDs
	 ir9ff5Ui/6dx2jRi7qU/KVtf0xhAQvMgHPK6mCbgKyU9VCJlAClTIkfKY/CwS0/7abRkz
	 R5PmtEtbWfOG9/sz+tqPgbY/vH7gila1Lm5Z3djPsPVim1hanwhZ/lFLa6cdhnjWHt05q
	 17Saiip9UUtjzo1BDNLWpCQMxzOWB4WbB9SCOF8zslrjoj3Cmbbw9K8ijEoxolhJS+VL0
	 4/IK3/8pkpWJVv5xMVIorlaIUeRmSmg7Vaq16Qi4OTay1aL/E91RGtUKYWthJfHuV+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iye2npiI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C64606A319;
	Tue, 20 Oct 2026 01:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iye2npiI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1324D1F000C4;
	Tue, 20 Oct 2026 01:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792459085;
	bh=gVKlbXZWCw8qO2LC4n2LKk2ZzmgfYZxvObuGjMQnSGY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iye2npiIIcGb2r8dG0dJ0aD7shMe74LoGxfkV2IRkJq+SXuU+RCGS1FFnCGYrT98E
	 6CNw3LBP4EPJnzNgA266EaBkoBDAG2o00Iaok+4JuE/iU7TGTTeFzSUPVFPy8Wt2KB
	 Xjdi5Qimm6qpCx8SHpW7lwe2l0w6LEsHWzW9OR+F/zZ/+cldGyWbADWKGEX5URsoYA
	 PCkjzEO4HAv7fai8qjQXM4MMDhexVEMykVEfdk78VV0gv0RvJwf5HrxbBeoq0i7BVU
	 yZ2Hx/+PIC2MfBg3SvkbH8UNg3odB+yP4QgVwT8I+9XzSQqfe8lMptVB8OAnlKo+UF
	 EAcM3GmYGF97Q==
Date: Tue, 20 Oct 2026 08:57:55 +0800
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
Message-ID: <ata8k2EVDCDTmeE6@xhacker>
References: <20261012-stmmac-xdp-tx-pre-fixes-v1-0-05fd0c90f7e1@oss.qualcomm.com>
 <20261012-stmmac-xdp-tx-pre-fixes-v1-2-05fd0c90f7e1@oss.qualcomm.com>
 <6d1d99b5-1c3c-4e59-a0b2-e4d671e594ce@bootlin.com>
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
In-Reply-To: <6d1d99b5-1c3c-4e59-a0b2-e4d671e594ce@bootlin.com>

On Fri, Oct 16, 2026 at 04:18:06PM +0200, Maxime Chevallier wrote:
> Hi Lorenzo,
> 
> On 10/12/26 17:24, Lorenzo Bianconi wrote:
> > stmmac_xdp_xmit_xdpf() decides TX checksum insertion from the queue COE
> > capability only:
> > 
> > 	csum = !priv->plat->tx_queues_cfg[queue].coe_unsupported;
> > 
> > and lets the enhanced descriptor set TX_CIC_FULL accordingly. On the
> > bugged_jumbo cores (snps,dwmac-3.40a, snps,dwmac-3.610 and
> > snps,dwmac-3.710) hardware checksum insertion is broken for jumbo
> > frames; the skb path works around it by clearing NETIF_F_CSUM_MASK in
> > stmmac_fix_features() when the MTU exceeds ETH_DATA_LEN, so skbs are
> > never marked CHECKSUM_PARTIAL and no checksum is inserted. The XDP TX
> > path bypasses that workaround, so once XDP is allowed at MTU >
> > ETH_DATA_LEN, jumbo frames sent via XDP_TX or redirected into the
> > device would leave the interface with a full checksum insertion enabled
> > on those cores - exactly what the workaround is meant to avoid.
> > 
> > Disable checksum insertion for oversized frames on bugged_jumbo cores in
> > the XDP TX path too.

Here I want to query a generic rule from netdev maintainers:
can XDP frame enable HW checksum on dwmac IP? Per my understanding, the
dwmac can only do HW checksum for normal particular packets layouts, such as
TCP, UDP. What about if XDP transmits a non-IP frame?

Correct me if I misunderstood something.

Thanks
> > 
> > Fixes: be8b38a722e6 ("net: stmmac: Add support for XDP_TX action")
> > Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
> 
> Looks cleaner to me than the alternative patch from Jisheng :
> 
> https://lore.kernel.org/netdev/20260929121025.20821-1-jszhang@kernel.org/
> 
> It sure seems there're a lot of people interested in getting XDP/XSK
> working properly on stmmac :)
> 
> Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> 
> Maxime
> 
> > ---
> >  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > index ca61ab449e32..0e29c5d04714 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > @@ -5276,6 +5276,14 @@ static int stmmac_xdp_xmit_xdpf(struct stmmac_priv *priv, int queue,
> >  		return STMMAC_XDP_CONSUMED;
> >  	}
> >  
> > +	/* Disable TX checksum offload for jumbo frames on cores where
> > +	 * checksum insertion is broken for oversized frames, matching the
> > +	 * stmmac_fix_features() workaround used by the skb path.
> > +	 */
> > +	if (priv->plat->bugged_jumbo &&
> > +	    xdp_get_frame_len(xdpf) > ETH_FRAME_LEN)
> > +		csum = false;
> > +
> >  	while (true) {
> >  		skb_frag_t *frag = i ? &sinfo->frags[i - 1] : NULL;
> >  		int len = frag ? skb_frag_size(frag) : xdpf->len;
> > 
> 
