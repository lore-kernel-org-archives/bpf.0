Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A993AE190;
	Wed,  2 Sep 2026 22:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788387425; cv=none; b=oaHGRJli+pA08Zms8blWjNDjNk1aC3sndsAXl3AXjnTLSwYF32pvtfOITBamWvt9itsZPwbM0gkMpK4c8W85GaYkKwannA4701oM4j0Oyc/DDBu4x/ls7/F2Obb8KcVGNQoRZwEti5Lf+SYaJy89Apx8SJ2YAGHwao+SGzEXKVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788387425; c=relaxed/simple;
	bh=QI1C5+il/qc+zBCcHHanqytB1vaPfJTpw6aU0V2vA/8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N/YSDBzDyMNyh8O3ToCSLIz4Rax/afZnVq3tH933yTy8LPFQHPYYHFDuSxLVdIfoWZTmQZVhfjvF9g9AmyBU0BL4gMvvAfNhXnx5+P9OgSdOMOpfjW9Ac/QFEKmXl5TMFhp9jsUo8J7GYtazjFwxTbzOd2lIjOmGiAROXgZKHkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=fTRFOtF9; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="fTRFOtF9"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 7E1D71A1968;
	Wed,  2 Sep 2026 22:16:57 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 313B95FF79;
	Wed,  2 Sep 2026 22:16:57 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7C0AC11C79331;
	Thu,  3 Sep 2026 00:16:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788387411; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=G8GIJmRVcQRu3gXC8ANh/f6tIzU9fEZM1Etf82O4wT4=;
	b=fTRFOtF9+Ij664TLlH2OaK1q9NFCBpYw+pqZ2Q1o6ziiWIhfqb/GeUYIJEI1KVP8W6xr6i
	nu/dQff/nCwUbXXyMi4KNdHHhWWU550J6fd18roIahAyl4awZFOCVjS1920bibBmdlLJAo
	lSVXYVkrwIpjdjasjpZiCOex1E3fOerBqn3PSfjfThCZPJfWXhiEisstIOfvjALpkvfpjE
	nlAcV5FJAD30OtBJguSyZaqSwNM6Frt4Vy7rFo0ib066VvfVo9V8RC+DUwb7IJKSmkHPTV
	+mJKFU8pZs/UjSJgN6W1nOE0opx+1moGPqdAM8PCyRFktSEP/QsVD18Pil/L6Q==
Message-ID: <ebe7d40e-4f2c-4c39-8d9d-ef588074154b@bootlin.com>
Date: Thu, 3 Sep 2026 00:16:40 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 1/4] net: stmmac: propagate PTP init failures in
 stmmac_setup_ptp()
To: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Jose Abreu <Jose.Abreu@synopsys.com>,
 Rayagond Kokatanur <rayagond@vayavyalabs.com>,
 Thierry Reding <treding@nvidia.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
References: <20260902-stmmac-est-reapply-after-open-v3-0-e72a6df5a7ef@oss.qualcomm.com>
 <20260902-stmmac-est-reapply-after-open-v3-1-e72a6df5a7ef@oss.qualcomm.com>
 <1010cb80-d9c9-4891-a719-8d7ca31c732a@bootlin.com>
 <apiT0ZrlBMF2k8qz@lore-desk>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <apiT0ZrlBMF2k8qz@lore-desk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

>>> -static void stmmac_setup_ptp(struct stmmac_priv *priv)
>>> +static int stmmac_setup_ptp(struct stmmac_priv *priv)
>>>  {
>>>  	int ret;
>>>  
>>>  	ret = clk_prepare_enable(priv->plat->clk_ptp_ref);
>>> -	if (ret < 0)
>>> +	if (ret < 0) {
>>>  		netdev_warn(priv->dev,
>>>  			    "failed to enable PTP reference clock: %pe\n",
>>>  			    ERR_PTR(ret));
>>> +		return ret;
>>> +	}
>>> +
>>> +	ret = stmmac_init_timestamping(priv);
>>> +	if (ret) {
>>> +		clk_disable_unprepare(priv->plat->clk_ptp_ref);
>>> +		return ret;
>>> +	}
>>
>> This can legitimately fail with -EOPNOTSUPP, we musn't failt the whole open
>> sequence in this case.
> 
> ops, right. I guess we should just skip -EOPNOTSUPP in this case, or do you
> prefer to always not report the error from stmmac_init_timestamping()?

The clean solution IMO is to gracefully handle -EOPNOTSUPP, here I think you
pass it on to the caller exactly like you do (I don't think it makes sense to
still enable clk_ptp_ref if you don't have timestamping available), and in the
__stmmac_open() path you don't fail on -EOPNOTSUPP.

Thanks :)

Maxime

