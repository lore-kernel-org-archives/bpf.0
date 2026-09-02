Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7733EB7FE;
	Wed,  2 Sep 2026 20:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788382774; cv=none; b=XCRNO1am55U68MouMEtsukem9j8Bv6xPRZ4C4f9lEztb6bFPGf8IA7iGF4fK83DB3JA2Vd5s5R5ygIDC1aafLIdOIqRmh6IJsqyA2lxotPdapd076fbB2r9+zOosSPa70KOvtMHZoTTPP3jcdua4s7C3dbVTpA4B4tP5v3fOIMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788382774; c=relaxed/simple;
	bh=o0vhalKJxHMGi6ytMHMRK4/IopGQxUQJYHruFCaZQ7Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y5Te7YiRi0ZbO74LCMDNwAG5/nlXAS1rH3/2WdsVt2P7yXrJ6RndUuMXIkw71kaa597rxItL/cjwvtodz4uN4191J2W/3Tnj3NWQvlAicfTz5e99ZJnzIFE+fYe4hEukiy8Jd9Dv2+lUIH0y36Wluz68U6ZAR9ogA2Qio4IkJrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=GUZn9Q2E; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="GUZn9Q2E"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 2C7D54E414D4;
	Wed,  2 Sep 2026 20:59:16 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id EAD7B6053C;
	Wed,  2 Sep 2026 20:59:15 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1794411C79331;
	Wed,  2 Sep 2026 22:59:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788382750; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=zZ+s2XEBuZodW5KuiEYx8rkHpmMdoiYAvq8N8LYvLc4=;
	b=GUZn9Q2E/CFdQn3IIRW01htGWPqiIf5a1pfqU/uTykLAPwY4be7vjNZjyAAwvPOnWvagGe
	4k+SHJ1uobhodformV+POrG1zcNCQoo49bh48QStlKJqv8ixoa/IdZQBx7ogQ82YjgY90T
	K4hg9wMOSeX+Rf4mvmxTPP2vSmAaO8YYOvXKvxsfVMtE1I2LWWhfidpuf35ioYGAJhsif8
	UW0EyDqjXfLA8Rsbkbfw1vNuKufW/im+omwOR5X2jIN76nUa/DFBTX3dkBB9SlQ8nEao1k
	yCyoyCp8C69XLYHPnoycuiVjo43echBMyZf5CQ3NCI2WNPbze3VmX9Cjq7St9Q==
Message-ID: <1010cb80-d9c9-4891-a719-8d7ca31c732a@bootlin.com>
Date: Wed, 2 Sep 2026 22:59:00 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 1/4] net: stmmac: propagate PTP init failures in
 stmmac_setup_ptp()
To: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
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
 Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
References: <20260902-stmmac-est-reapply-after-open-v3-0-e72a6df5a7ef@oss.qualcomm.com>
 <20260902-stmmac-est-reapply-after-open-v3-1-e72a6df5a7ef@oss.qualcomm.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260902-stmmac-est-reapply-after-open-v3-1-e72a6df5a7ef@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 9/2/26 22:15, Lorenzo Bianconi wrote:
> stmmac_setup_ptp() returns void and swallows both PTP setup errors:
> the PTP reference clock enable and stmmac_init_timestamping()
> failures are logged but never propagated. When they fail, the MAC
> system time counter is left in its post-reset, non-running state,
> while the driver keeps operating as if timestamping were up.
> This matters for the upcoming taprio offload re-apply, which derives
> the EST base time from the hardware timestamp counter: arming the
> gate list against a non-advancing time base would leave the schedule
> permanently stuck. Make stmmac_setup_ptp() return an error code.
> 
> Fixes: 92ba6888510c ("stmmac: add the support for PTP hw clock driver")
> Fixes: 0ad2be79f254 ("net: stmmac: Balance PTP reference clock enable/disable")
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

nice fix, this isn't the first time we have issues because ptp init silently
failed :(

> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 46 ++++++++++++++++-------
>  1 file changed, 33 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index d576059c04df..47295845371a 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -937,18 +937,27 @@ static int stmmac_init_timestamping(struct stmmac_priv *priv)
>  	return 0;
>  }
>  
> -static void stmmac_setup_ptp(struct stmmac_priv *priv)
> +static int stmmac_setup_ptp(struct stmmac_priv *priv)
>  {
>  	int ret;
>  
>  	ret = clk_prepare_enable(priv->plat->clk_ptp_ref);
> -	if (ret < 0)
> +	if (ret < 0) {
>  		netdev_warn(priv->dev,
>  			    "failed to enable PTP reference clock: %pe\n",
>  			    ERR_PTR(ret));
> +		return ret;
> +	}
> +
> +	ret = stmmac_init_timestamping(priv);
> +	if (ret) {
> +		clk_disable_unprepare(priv->plat->clk_ptp_ref);
> +		return ret;
> +	}

This can legitimately fail with -EOPNOTSUPP, we musn't failt the whole open
sequence in this case.

Maxime

