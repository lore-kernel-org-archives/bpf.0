Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.13.80.246
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793619852;
	b=pj3a2VLp5eMAyKYYbNBdL5ZmQZtmPanOQJuZ6OCBQYd+jeZXS+8uYpYNisVwXvB/RMw8
	 wKAkt4Snq878g2gMhcuFt3/yg9qnjVecsNd4t0p+0ml4flNLNuBPV/yZzBzfzipimIdcU
	 elcIw10LPsWDWQIFFBdLayfY+zE6AbN5fzTD7ayjfEZn6m7GYOIe37uhEJl7iFLdo4Nxf
	 AfG8dySilCI7s31F11hm8fF42ZJFMjI6Saoe7iXRBM/9EdcL8WhVop+3aEg0kNbLrnZse
	 mcyeFOr9plXnKsuxxA1pMS9dVQ9jDdURb6zWZcAIUVlgKYLjge0rfkR5HsG/nVUapFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793619852;
	h=DMARC-Filter:Received:DKIM-Signature:MIME-Version:Date:From:To:Cc:
	 Subject:In-Reply-To:References:Message-ID:X-Sender:Content-Type:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=CEbYZciebtL2aKgroSydecBjkvTVNl1Hbb78SlOoaRg=;
	b=xxAM4ZjFCstepIsCSl4gaf3cfL73bXB2PuBoPj/fnUoN4w11jnWnjMFeJe+anDYkxBkq
	 j7MWMilr2V62WSod9Pc8mY2dFiZjamXQMHQgAomnk+C1IDmDD7p66tMeaV2Dvk5ZE20Cs
	 2OweAr6D9Vr1U84ha/5nCsdMwG/6zbylJJqFN3F+HiCeaUaIudQxJ+lIw+LI8Ml7oBAEI
	 das3gMHWEvP16jdVRW0oZdPg4n+5Vcib6DIe33ucz4TrdPN0cHJjoujZ9/qi8VdJdRid7
	 3nE6Kq4IOb4MuaRJ03EaEr8vrL8RUZs/PhsV+slilS7g8RJBw/PFNLw0au8J400fRqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=tipi-net.de;
	spf=pass smtp.mailfrom=tipi-net.de;
	dkim=pass header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=h2z0Hw3P;
	arc=none smtp.remote-ip=194.13.80.246
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30F2606A324;
	Mon,  2 Nov 2026 11:44:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E30F2606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=h2z0Hw3P
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 913ABA12EB;
	Mon, 02 Nov 2026 12:44:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1793619847; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=CEbYZciebtL2aKgroSydecBjkvTVNl1Hbb78SlOoaRg=;
	b=h2z0Hw3PffeZ/4+TKe9RVKbucreoqLTN1ZOL0D9ChB3xIeCc3ev7ePBgeccDdJABxNxMqr
	K/drIP0DOa/HmZjo3jongZTLKsMdmkwXlZgYEz+fqwgLm3HfhuvAy+wN74YV5Ad/EdAQ8x
	46urajdusq1F3txkNgHenrBSYGUw5CJ5150j6J9ExpKemKYz3i2B7k/PUJ74OdX5iibVXc
	2flYJ7PIx0QDTUzbf+5Ewifwmc7GFN4J9CSI3VCsw8SK/k2sO5Vmcp50MbDkxUoLdU1Ipt
	yXbTTrEhAW7vAarAlm0cvvWqHys8tmooKGf4DunV6+JUr3LMxRKDW9cHOXFs7Q==
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Mon, 02 Nov 2026 12:44:03 +0100
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Daniel Machon <daniel.machon@microchip.com>
Cc: Sunil Goutham <sgoutham@marvell.com>, Geetha sowjanya
 <gakula@marvell.com>, Ratheesh Kannoth <rkannoth@marvell.com>, Subbaraya
 Sundeep <sbhatta@marvell.com>, Bharat Bhushan <bbhushan2@marvell.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard
 Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Suman Ghosh <sumang@marvell.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH net] octeontx2-pf: fix XDP frames freed as skbs on
 interface down
In-Reply-To: <20261102113011.h4gv6z6y3ktab2cq@DEN-DL-M70577>
References: <20261030-nb-otx2-xdp-cqe-cleanup-net-v1-1-710635c0f504@tipi-net.de>
 <20261102113011.h4gv6z6y3ktab2cq@DEN-DL-M70577>
Message-ID: <06c7ea9008cf1d143a44750a36798610@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 2.11.2026 12:30, Daniel Machon wrote:

> [...]

>> @@ -1348,6 +1349,10 @@ void otx2_cleanup_tx_cqes(struct otx2_nic 
>> *pfvf, struct otx2_cq_queue *cq)
>> 
>>  		if (!cqe)
>>  			continue;
>> +		if (cq->cq_type == CQ_XDP) {
>> +			otx2_xdp_snd_pkt_handler(pfvf, sq, cqe, &xsk_frames);
> 
> Any reason xsk_frames is never handed to xsk_tx_completed()?

No, just missed that, thanks. I'll send a v2 with this fixed, after 
waiting for
potential feedback from clashiko later today.

> [...]

Regards,
Nicolai
