Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=68.232.154.123
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793711857;
	b=jAQlyRXdmBMjxDilL4dSUkBUzQxmCQYCVGGGM1/fekisbiHfIxueAXGvh668jU+Sxwvc
	 lYDK2vhvgjKFFTIGEjGJCwgX1J0e7Vm4UAYisymeVzKJZAnM1aUSQgqzqbtGI1rtPPrZt
	 w1V2l80ygG1LeG4/AM9m5QDZO1mWNzmhIEuGmFckXE3OJSulGXAg4F5Uedr1x8+kk5a61
	 7qToOO7GgY9kJZfEcOqP32/CBBi1oYF6a9ClHRrWop/VjxQAbzA1+eO/Ed1NSkve5ZyK/
	 lBVXW1qJqq5B6bsCwiPtppjyF8BlRiLpg05I2F8qVofN+2pRKTZK/c9yP0i12PvOz0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793711857;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-Amp-Result:Received:Received:Received:Date:From:To:CC:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=8jNxLKZJ0+Ujjqcgm7O6G2p5yvTyzeq9NAf4nQDsOak=;
	b=d/w9DUM065ZoattX13MCOB6Yp1imK2EGKJc5/K45M77aLaRUc2YCy5u7Ls8Wv8skOQK2
	 yxaPw3SC15XRWIHbiP8jCrBDTEfGsn3MnJl07yBPPV4QNsPqkaWpqyaYFBv7OU1DFSgBG
	 ovm0RsHPOpHhIMPs339u9bEOt4P32VqQLGEmPniDLgtMjsRcIiHeVRYC13kZ3IkKKOEDM
	 Zh6kLCeu5PvT1iKbHqtbvtM2Dn+OA4UhVaczqrTJ+/GaFgpLjVcjjfAq0240FZd0VZjLl
	 ErCCq22GKdrloFvD/6ZC8PxFVE8sQrvt25Dr5415u3UxkAvbB4BIdPL/fOZI5BjVvqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=microchip.com;
	spf=pass smtp.mailfrom=microchip.com;
	dkim=pass header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=TxhUMdX4;
	arc=none smtp.remote-ip=68.232.154.123
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3016F606A328;
	Tue,  3 Nov 2026 13:17:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3016F606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=TxhUMdX4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1793711857; x=1825247857;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qg8Xxxvy/Qj+8i2OmfTlCLXN559/BTN2nQA+TRADqKE=;
  b=TxhUMdX4RFuEJqC2GixwtZy7dKchb8pXjrJLLdG2+vzWG2Gv47dOt+N1
   c2XQUD11CZOAdkC8+xvZKpNj6BdNV7a/pGvMISVA5kdWqkqKonOSuzpq6
   Wh5bx7mAkXXfAb7qT7sUT/gRToxsndx0lm0soMSLVijSCo02myM8UoeRA
   7oAxxQ/EW5t3HV899aAUy+Wk9mrn513XlGG0uD5ZEC+BWeRnLf7R81azK
   CjmmvnBbYskI0D3pQOBrukIimYqI2LxUeyvD7LUbMFki20Xo9gm4n4gBp
   pCOLT+jkAoWpZxfo2t1T0+kETG7O4sghctn5+FcrmkVwadr7sRgOeNSVF
   A==;
X-CSE-ConnectionGUID: ivVIAx7WQoekeZRNTi+1ZQ==
X-CSE-MsgGUID: d/ZbvNGEQBmNQIcSRRskqw==
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="64982494"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 06:17:36 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex2.mchp-main.com (10.10.87.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.56; Tue, 3 Nov 2026 06:17:35 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 3 Nov 2026 06:17:32 -0700
Date: Tue, 3 Nov 2026 14:17:32 +0100
From: Daniel Machon <daniel.machon@microchip.com>
To: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
CC: Maxime Chevallier <maxime.chevallier@bootlin.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre
 Torgue <alexandre.torgue@foss.st.com>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer
	<hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, Stanislav
 Fomichev <sdf@fomichev.me>, Song Yoong Siang <yoong.siang.song@intel.com>,
	<netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<bpf@vger.kernel.org>
Subject: Re: [PATCH net] net: stmmac: set XDP metadata length on the
 page_pool RX path
Message-ID: <20261103131732.5wdtyhk7o6fa6iol@DEN-DL-M70577.microsemi.net>
References: <20261102-stmmac_meatada_pp_path-v1-1-d93cc4f9a864@oss.qualcomm.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261102-stmmac_meatada_pp_path-v1-1-d93cc4f9a864@oss.qualcomm.com>

> stmmac_rx() initializes the XDP buffer with the metadata area valid, so
> an XDP program can reserve metadata with bpf_xdp_adjust_meta() and write
> it in [xdp->data_meta, xdp->data), for example to export the RX hardware
> timestamp obtained from the metadata kfunc. When such a frame is passed
> to the stack, the skb is built in place around the same page with
> napi_build_skb(), but skb_metadata_set() is never called.
> 
> napi_build_skb() clears skb_shared_info up to dataref, which includes
> meta_len, so skb_metadata_len() stays zero. The stack and TC BPF then see
> an empty metadata range even though the bytes are present in the skb
> headroom. The AF_XDP zero-copy path already records the length in
> stmmac_construct_skb_zc().
> 
> Record the metadata length after reserving the headroom and adding the
> frame data. No copy is needed because the skb is built over the buffer the
> XDP program wrote to. With the length recorded, the software VLAN
> stripping path can move the metadata together with the MAC header, as it
> already does for zero-copy frames.
> 
> Fixes: e3f9c3e34840 ("net: stmmac: add Rx HWTS metadata to XDP receive pkt")
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

Reviewed-by: Daniel Machon <daniel.machon@microchip.com>
