Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795376773;
	b=jC+YLocWyHpLafNKaTFco3XQ8IJHCdzXaC4bdRFw0FEDKVv4Xi0JNJZfzA8i0aKSTjoh
	 WjGX8Nr5PFyUjr3aon9qGFzI4LcVvje0S70V/W8mCV6Wl/QbPz1sL4b8ALhofYDrc/Hvd
	 92x5nM9TTWOxOT5jSzoPwiINaXHDscsQ4u+cY8lPdJUVWA39kD0ikKvATFoAA5SBO07xN
	 lMv0jLudRlrgK/xQcJGxOtDlFw2VIcwC/X9+JrBfBbMP6mCfytuGzEHoHEn5CEXnSjpN9
	 dSuxMa6rzZIJ84LQ3wvX8TcvkLBYNiApsYx4hU9frUR+SZyvpU/IbSezprWJ8j4/C6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795376773;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Last-TLS-Session-Version;
	bh=dbGXM1I9Jh83hjJSiKGDRAEmUJNnFhvU9Kb1A5Z3ub8=;
	b=I/UgkBQACyRIRNkC5+EBn0ayKsDYyIAwD73EWuIWAAnzoX3EKghen/TZ4uifYZWLPKT5
	 0srccBE56h3qecdDv+WueFqVB2cqhThV/eoEY1gbgHXzA4x0ud8q00rl6ApSggYk/zz53
	 TVhn/csrXcHZEHf95FJBtSsZAT0hIWJDIzvaiT5g1WUEKuURrCFJN7rSveCqo/Vb2zvs2
	 sOsi5TrGPU9Rv4dBlgVfDnUInGjv0Zch6btqKT3NQxFtgkgIjrW3+RN5ew++R1oJcD6AZ
	 M7QTJKCNhUeSNKMRyl1ZePljwCvxrgj4Oe/Akkjhe5VkOP8Y8yhUYnMsBIkNaoOWyHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=W0QWdRuz;
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AFCA606A31D;
	Sun, 22 Nov 2026 19:46:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1AFCA606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=W0QWdRuz
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id B0E63C69140;
	Sun, 22 Nov 2026 19:46:14 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C804660512;
	Sun, 22 Nov 2026 19:46:07 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8D16411E6033E;
	Sun, 22 Nov 2026 20:45:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795376765; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=dbGXM1I9Jh83hjJSiKGDRAEmUJNnFhvU9Kb1A5Z3ub8=;
	b=W0QWdRuzMqLYXnJk4odzdLYtZXZMIYtQYMT8IB7ANLCF8YMMTiCNE0IPROF+gKZ70cEG4k
	LroyuHKdGOnJfOQsjOnHbeOH8d4V1ynY9uiW0G5q1sSQCz5un+v8sXg+3OaviQuacPA34d
	PrT7yCOYJ/uYoSxmBVvu3UUbV0vNlVtZbyekIUzxcJrRsPN//WHz3OKjK3ZKsuqFCWPzzG
	3kN5bcJZi1xEdWUvTD9Gf4zzyDNq8wXU2qsHXOCwyCPvgTBbcFIUsc9xoQmEUjX4va3MeU
	qS4ialWhY1rtVmFR9sdwvGf4abv2UckG+1S4KdJnDLuszg9EvrF1W9oC6iiaLw==
Message-ID: <9997f4e9-9453-4511-af3e-4be664a09281@bootlin.com>
Date: Sun, 22 Nov 2026 20:45:47 +0100
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v12 1/4] net: xdp: add
 __xdp_build_skb_from_buff() helper
To: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Jose Abreu <Jose.Abreu@synopsys.com>,
 Ong Boon Leong <boon.leong.ong@intel.com>, Simon Horman <horms@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>, peilinhe2020@163.com,
 Peilin He <he.peilin@zte.com.cn>
Cc: netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 bpf@vger.kernel.org
References: <20261121-stmmac-rx-mb-v12-0-3ae2f3bce174@oss.qualcomm.com>
 <20261121-stmmac-rx-mb-v12-1-3ae2f3bce174@oss.qualcomm.com>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20261121-stmmac-rx-mb-v12-1-3ae2f3bce174@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Lorenzo,

On 11/21/26 18:28, Lorenzo Bianconi wrote:
> xdp_build_skb_from_buff() always calls eth_type_trans() on the skb it
> builds, which pulls the Ethernet header and advances skb->data. Drivers
> that still need to process the L2 header before protocol parsing
> therefore cannot use the helper.
> 
> stmmac is such a driver: its software VLAN path (stmmac_rx_vlan()) reads
> the VLAN tag at skb->data and shifts the MAC addresses over it, so it has
> to run before eth_type_trans().
> 
> Split the implementation into __xdp_build_skb_from_buff(), which builds
> the skb (including the recycle mark, the Rx queue index and the frags
> info) but leaves skb->dev, skb->protocol, skb->pkt_type and the mac
> header unset, so the caller must initialize them, usually by calling
> eth_type_trans(). Make xdp_build_skb_from_buff() a static inline wrapper
> that still calls eth_type_trans() as before, preserving the behavior of
> existing in-tree users. A follow-up patch will let stmmac use it.

I've been questionning why we even do that in stmmac in the first place
actually. This pretends to offload, but it's just to deal with the tag
in the driver instead of later down the road.

The original idea was for GRO back when it didn't handle vlan tags, but
this isn't necessary anymore.

There was a series in-flight to remove stmmac_rx_vlan altogether, but it
seems to have stalled [1]:

[1]: https://lore.kernel.org/all/20260914150612.9798-3-peilinhe2020@163.com/

Peilin He, do you have any plans to continue this ? If not, it may be good
to pick this up instead of working around this.

Maxime

