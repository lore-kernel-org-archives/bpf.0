Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795366982;
	b=wM0429ee5FtAyoxWjwkXQdHgvLXQSxoB1o7pHud5w0MiHWG4qZGzS9NXvdJ2z7Ty+SfC
	 gNZHpxGwu0m5LUw01cW41g3/bSQ01AMuhFq7aEhAM/osKHWVur3bq2S/MSqJIOagLQZsc
	 8j0nmDqXnXVConljgJwqGv+fsegE24rxJn2PIrG37eSqAyY8lYWTg66GTSG4r2XwBHZ30
	 moSzA1FybOTKksZ2xEZrVJsFSNMl+NgVOKjoRFkzXjDA+Pgmp7cFiT75vewdusLrwxxhr
	 LIPz/gyQos678X5H8p6GGp6InLjcNR7wTeojVwtEFf8+WGudBt6H4igvJ19WmNi5oFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795366982;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=CMdZJjStYTeG+QXi153Hruf7L5SKL3ufYUXm+pIPYx0=;
	b=GqKJe7/41slZ6+yBEYqpW7RQXFPCz6FIrGuHOazG6EVfcdKkhFwph5hTdtioAqDUMf/8
	 GN+ip8uA3jugsrg6fMkFGdoMLBb5efvdf0PHX17DUnxKfOr7+eS+avTyZ/RPTpjWnjOYA
	 LMJQrHOxMKjdVX3sJmuTLrbxL/Im48q8paC3saf7J3VIVbmApvwaVcrx5al5htg0I4irb
	 wWwU+h1vwaYUvcokOyPbXpx7lIRQa7VxRuvz9Nko/DVe9TmE+Q5bMNsVAfRQfpzgoVkQJ
	 bDXjM4VdgayncaXco9mQqiVTAs9cNigKAaxSl1I/IJ7TLNVEyyZfWg3tLTXr7IuaeTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DUYnN5nW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C20606A320;
	Sun, 22 Nov 2026 17:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DUYnN5nW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90EE81F000C0;
	Sun, 22 Nov 2026 17:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795366981;
	bh=CMdZJjStYTeG+QXi153Hruf7L5SKL3ufYUXm+pIPYx0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=DUYnN5nWUmcHxjrh3lvtRQG0PQhiUBSX1UBxYH2Do081//XlX+UaOgceQAFhdyGcH
	 Ntv7i6Y8vgvBR69AkdbzVXOTydSrJb/uKFY1/mGJ10X7D8UhYPuCzDuoiuUUXw4sQJ
	 z0Wzob5vXhTNwYnlM/885zVC+PFqCsjA+Xcjhcb3ZY/Tgxxn5tyjsW6JdFle+oUk6L
	 rwo/BnbexT1ezyg/hKQDvVugdlDGSyNG7loVElSwktJSVOOlvHRcvicioQ/k/ryyfP
	 OY5WB934po+MhNKf3zIJZ28+C4BPj6fwct+E5Hla2cVLaqCumIIAQVbYHH+p7egOg4
	 zYD9KP8klQbZg==
Subject: Re: [PATCH net-next 1/8] net: stop making HW-GRO depend on SW GRO
From: netdev-bot+sashiko@kernel.org
To: kuba@kernel.org
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 michael.chan@broadcom.com, manishc@marvell.com, joshwash@google.com,
 hramamurthy@google.com, tariqt@nvidia.com, saeedm@nvidia.com,
 daniel@iogearbox.net, hawk@kernel.org, sdf@fomichev.me, willemb@google.com,
 przemyslaw.kitszel@intel.com, bpf@vger.kernel.org
Date: Sun, 22 Nov 2026 17:03:00 +0000
Message-ID: <179536698013.3135.16546623491395924004@kernel.org>
In-Reply-To: <20261118232315.3593731-2-kuba@kernel.org>
References: <20261118232315.3593731-2-kuba@kernel.org>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] On bnxt, `ethtool -K $dev gro off lro on` used to give
  hardware LRO.

--

net: stop making HW-GRO depend on SW GRO

This patch removes the code in bnxt, qede and bnx2x that cleared
NETIF_F_GRO_HW whenever NETIF_F_GRO was off. The commit message gives
one user visible change: "ethtool -K $dev gro off" no longer implies
"rx-gro-hw off" on these drivers.

[ ... ]

> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> index 6846a27bfef4c..27c53db2c9e45 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -14092,9 +14092,6 @@ static netdev_features_t bnxt_fix_features(struct net_device *dev,
>  	if ((bp->flags & BNXT_FLAG_NO_AGG_RINGS) || bp->xdp_prog)
>  		features &= ~(NETIF_F_LRO | NETIF_F_GRO_HW);
>  
> -	if (!(features & NETIF_F_GRO))
> -		features &= ~NETIF_F_GRO_HW;
> -
>  	if (features & NETIF_F_GRO_HW)
>  		features &= ~NETIF_F_LRO;
>  

[Severity: Medium]
Does this change what "ethtool -K $dev gro off lro on" does on bnxt?

Before this patch, turning SW GRO off cleared NETIF_F_GRO_HW first. The
LRO request then got past the GRO_HW-over-LRO check below it, and
bnxt_set_features() picked LRO:

bnxt_set_features() {
    ...
	if (features & NETIF_F_GRO_HW)
		flags |= BNXT_FLAG_GRO;
	else if (features & NETIF_F_LRO)
		flags |= BNXT_FLAG_LRO;
    ...
}

With the check removed, NETIF_F_GRO_HW stays in wanted_features, since
bnxt_init_one() turns it on by default. bnxt_fix_features() then
clears NETIF_F_LRO, and netdev_fix_features() drops it again:

net/core/dev.c:netdev_fix_features() {
    ...
	if ((features & NETIF_F_GRO_HW) && (features & NETIF_F_LRO)) {
		netdev_dbg(dev, "Dropping LRO feature since HW-GRO is requested.\n");
		features &= ~NETIF_F_LRO;
	}
    ...
}

So the device ends up in BNXT_FLAG_GRO mode instead of BNXT_FLAG_LRO,
and ethtool shows large-receive-offload as "off [requested on]". To get
LRO now, the user also has to set "rx-gro-hw off".

This mapping looks intentional. Before commit 1054aee82321 ("bnxt_en:
Use NETIF_F_GRO_HW."), bnxt_set_features() chose hardware GRO based on
NETIF_F_GRO and fell back to LRO when GRO was off. The GRO -> GRO_HW
dependency kept that behaviour working.

bnx2x_fix_features() checks GRO_HW and LRO in the same order:

	if (!bnx2x_mtu_allows_gro(dev->mtu))
		features &= ~NETIF_F_GRO_HW;
	if (features & NETIF_F_GRO_HW)
		features &= ~NETIF_F_LRO;

Fewer users hit this by default, because bnx2x_init_dev() clears
GRO_HW when LRO is on. But if a user has enabled rx-gro-hw and later
runs "gro off lro on", they would also get HW-GRO instead of LRO.

Later patches in the series only remove the bp->xdp_prog clause from
bnxt_fix_features(). The GRO_HW-over-LRO ordering is still there at the
end of the series.

Should the commit message say that LRO requests with gro off are now
refused while rx-gro-hw is on? Or should an explicit LRO request take
precedence here?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261118232315.3593731-1-kuba%40kernel.org
