Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=68.232.154.123
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793711883;
	b=x79uQE9XZTNyBlTYrT4GZvU/ytbZgJYiK93zYn1RXq/Px9If+Ytk6fM1WWgKALQ3dT8P
	 qhiAKxVPQx/MFvJ0WYeT6lfa8VTRcOyBgNHr1dyWDsY4Xe+pAkVzUw6k2DoUFJUvIuiEs
	 R5NKNivJ0cfbGw+wdluEP8o6FkZ9q9eJzN1ToOlHZmmw1eYpvkKVD8ughrBt9hoYHJJ0o
	 aVc4s1u5g5HFKu6dOcO8XlLpmFcHWnFv524FEu7FSVVuO/Cf4ygLU4cJqb3ER3b/Hnig4
	 L/OVUqsyj5PO8ysa+yhSEx4I7RTqXhWNVR8XA325C+iUp/cS8ybTzjaQPMK4jNNgNtw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793711883;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-Amp-Result:Received:Received:Received:Date:From:To:CC:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=ndbDYQ+0aDAKm5IXh5NCg7VxUMjA6WygtYo6a6b0nTc=;
	b=OUyUxlTgsp8E9ZXGd8X+jw5/qYQbLhAwXRbBFmxn8pCOGFAM4qUXrSV6aWeuke9PqZ5L
	 wMIoepBgnz+XlOBazH7cyTzzwo0Wo3LVtl4eddxiK3lhdtpe2AaKKT1EaolD7hRdJQ1Fl
	 mT/c1F+XpPMrQ7LIUsxV0xbCkE8xZXwOjCbFw4U41+u4BXFH9F86Pa96L92ZrieV2ZaTl
	 jzmxkEIsvpcEOUqSsaTEKLN2fgO7zhGA5v3nHjbgE9/CY0X/khp5RnWGSILzRDIDtIlw3
	 WjaMV+lRYarxIkeDE2ft3wh14aVeD2opIjPlI/sSJA201k+pMhqK1PnB35vs06YQijw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=microchip.com;
	spf=pass smtp.mailfrom=microchip.com;
	dkim=pass header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=dEQzcJQB;
	arc=none smtp.remote-ip=68.232.154.123
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE516082BCC;
	Tue,  3 Nov 2026 13:18:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2EE516082BCC
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=dEQzcJQB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1793711883; x=1825247883;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QRLnd+UBXZsm2ULCPmbvMIfcEp/fdiFArcUzETdYZFA=;
  b=dEQzcJQBR9jyQxcYvo7yCCtiBgBvbbGYEm+jCjpV80ohNjOjVptcxlmJ
   nqVu5xY6Vs3MW2A4X3gSXpLMlA6s8lM6PQI90sI9B0WfYUg+cLLm8oIIA
   uVixEJvxqHVGdvd+w6/qFLt6DMOgX1geiwBYNyJwZYsLqymY+TJs9xLLy
   vxjwE2y2Wh8FSfV/hsEybiQKM39muEYvzWsTgE9tDZbvNEvSeOY+ZqIDz
   XDfKgNVwt7oD3udMDNRKOapfkwyhagPjScgioxKm2z57yMA+8smVjJEVi
   o3FwDJdYnHfAdE9SV9s6UBMIN9ATlbAi8iiMhNZzwi1+74dgCetWDa25u
   Q==;
X-CSE-ConnectionGUID: 0mkX0q64QtqqgJ6xhB3D4g==
X-CSE-MsgGUID: Nw0X1Po/QHa1wucV7HivOw==
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="64982512"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Nov 2026 06:18:02 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Tue, 3 Nov 2026 06:18:01 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 3 Nov 2026 06:17:58 -0700
Date: Tue, 3 Nov 2026 14:17:57 +0100
From: Daniel Machon <daniel.machon@microchip.com>
To: Nicolai Buchwitz <nb@tipi-net.de>
CC: Sunil Goutham <sgoutham@marvell.com>, Geetha sowjanya
	<gakula@marvell.com>, Ratheesh Kannoth <rkannoth@marvell.com>, Subbaraya
 Sundeep <sbhatta@marvell.com>, Bharat Bhushan <bbhushan2@marvell.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, John
 Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>,
	Suman Ghosh <sumang@marvell.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>
Subject: Re: [PATCH net v2] octeontx2-pf: fix XDP frames freed as skbs on
 interface down
Message-ID: <20261103131757.tt4j6eyowgp4jx2d@DEN-DL-M70577.microsemi.net>
References: <20261103-nb-otx2-xdp-cqe-cleanup-net-v2-1-5430545c9cbc@tipi-net.de>
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
In-Reply-To: <20261103-nb-otx2-xdp-cqe-cleanup-net-v2-1-5430545c9cbc@tipi-net.de>

> On interface down, the TX completion cleanup also runs on the XDP
> queues, but treats the pending xdp_frames as skbs. Freeing them with
> dev_kfree_skb_any() corrupts page pool memory. AF_XDP TX completions
> in these queues were never reported to the socket either.
> 
> This happens when XDP_TX or redirected packets are still in flight on
> ifdown, or when the XDP program is replaced.
> 
> Fixes: 94c80f748873 ("octeontx2-pf: use xdp_return_frame() to free xdp buffers")
> Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>

Reviewed-by: Daniel Machon <daniel.machon@microchip.com>
