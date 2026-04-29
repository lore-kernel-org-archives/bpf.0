Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2EC0359A6C
	for <bpf@vger.kernel.org>; Wed, 29 Apr 2026 22:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777502136; cv=none; b=loP849JPl8tVf5uCCkjP+iqxFAuy74V9TnO1HkWsPacD+4Rkz04aTxvdmZZRYitxMECRh7xqhcJWBWyx8qD3g4X79i3I0fMPuQ2fStPU2LG+PFrgMhsJGUji2w5+WQjB3LRWw3x33YTHaqQWzzyMecPIqtBFpxiG4NgVfwveRsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777502136; c=relaxed/simple;
	bh=h06udCUDn+9Q5G420B9KW0bzGQn5oXrfqfXqUQ5y1k0=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=my1RAyEoGs01gNqXLvU0fmt1jKUpknWVRc+6sKx31a/tmqCFrq6v3oWu6I0OWZfUnEYEMFe8d8Bv9UhzGoDWstPG+f2ctGX/nkrzjrqlK4OWOBpP05SgLx+7GDHTU+//TluXsjA5RC0SlMZIP5iRmYbZWVIoP9JoWvjz2KSkDfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=iwWk70g/; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="iwWk70g/"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 30972A5394;
	Thu, 30 Apr 2026 00:35:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1777502132; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=lw8pE8HXZGjbhwX5wkdKsxcNjQDChDyqyQazSon870c=;
	b=iwWk70g/vRLnu4dCwVpAO+b6Gmd9Sdveb6F1nR1x3/HFNJdECjDCnNIuO7nOnvT/kfvl0M
	giZhPzacuPCZ38Lg59Rz4Pt23KX1hBURuoQ6Lbe4VThdWre3KGeKcorkSVifT3P3M/Uh7e
	svpv5VAnYEDsBVGgQCk6exQ5dPO51F4XvEI5na6HAPTg7esZZ2x+DCzxj/vGAQVKnsBIhd
	c6o/Pc97OkVFRFTekSKjyP3Aiw33zPc+twvq7ujwBSb3Clnxy801Hcu9zmxRMMPlHtogv7
	2g+cZ7/yWnO/NnHqVyXk/9KlIsOTF5W92CzIzGH88/ftZuj1KzjQxtLtjO4arQ==
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 30 Apr 2026 00:35:32 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: sashiko@lists.linux.dev
Cc: bpf@vger.kernel.org, Florian Fainelli <florian.fainelli@broadcom.com>,
 Mohsin Bashir <mohsin.bashr@gmail.com>
Subject: Re: [PATCH net-next v8 7/7] net: bcmgenet: reject MTU changes
 incompatible with XDP
In-Reply-To: <20260429211705.4CF4CC19425@smtp.kernel.org>
References: <20260428205846.2625550-8-nb@tipi-net.de>
 <20260429211705.4CF4CC19425@smtp.kernel.org>
Message-ID: <3a01466edcd2b49e2d513951f78605ba@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 29.4.2026 23:17, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential 
> issue(s) to consider:
> - [Medium] The XDP MTU validation logic contains a mathematical error 
> (ignoring L2 headers) and is structurally unreachable (dead code) 
> because the device's maximum MTU is fixed at 1500.
> --
> 
> commit b8018c0a123b4927db5ca8c39c8395c751532069
> Author: Nicolai Buchwitz <nb@tipi-net.de>
> 
> net: bcmgenet: reject MTU changes incompatible with XDP
> 
> This commit introduces a minimal ndo_change_mtu function to the 
> bcmgenet
> driver. It checks if an XDP program is attached and rejects MTU values 
> that
> would exceed the capacity of a single-page XDP buffer.
> 
>> diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c 
>> b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
>> index 02ad2f410d6c..4d1ec68ec0c5 100644
>> --- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
>> +++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
>> @@ -4085,6 +4085,20 @@ static int bcmgenet_xdp_xmit(struct net_device 
>> *dev, int num_frames,
> [ ... ]
>> +static int bcmgenet_change_mtu(struct net_device *dev, int new_mtu)
>> +{
>> +	struct bcmgenet_priv *priv = netdev_priv(dev);
>> +
>> +	if (priv->xdp_prog && new_mtu > PAGE_SIZE - GENET_RX_HEADROOM -
>> +	    SKB_DATA_ALIGN(sizeof(struct skb_shared_info))) {
> 
> Is this condition actually reachable, and does it correctly account for 
> L2
> headers?
> 
> The bcmgenet driver does not appear to override dev->max_mtu, which
> defaults to ETH_DATA_LEN (1500). Because dev_validate_mtu() in the core
> networking stack checks that new_mtu <= dev->max_mtu before calling
> ndo_change_mtu, new_mtu will never exceed 1500.
> 
> Given that PAGE_SIZE (typically 4096) minus GENET_RX_HEADROOM and the
> skb_shared_info alignment is roughly 3454 bytes, the check new_mtu > 
> 3454
> will always evaluate to false.
> 
> Also, new_mtu represents the L3 payload size. Shouldn't the check add 
> the
> L2 header overhead when comparing against the L2 buffer capacity?
> 
> Furthermore, is it possible for an MTU change to corrupt the XDP buffer
> layout as the commit message claims?

Correct, the check is currently unreachable since dev->max_mtu defaults
to 1500. It is a safety guard for the planned follow-up series adding
full ndo_change_mtu support. L2 overhead handling will be part of that
follow-up.

The commit message wording is slightly misleading; today no MTU change
can corrupt the layout, but once jumbo MTU support is added, this guard
prevents misconfiguration while an XDP program is attached.

The original discussion with Mohsin and Florian on the rationale for
adding this in the XDP series rather than deferring to the MTU
follow-up is here:
https://lore.kernel.org/netdev/1d551008-3c42-4b7b-9507-03072740a54a@gmail.com/
https://lore.kernel.org/netdev/99062602-05a3-418f-9182-f60a83fdbe3b@broadcom.com/

> 
> The hardware DMA appears to be statically configured to write a maximum 
> of
> RX_BUF_LENGTH (2048) bytes per buffer, and bcmgenet_desc_rx() 
> explicitly
> drops any packet larger than 2048 bytes. It seems structurally 
> impossible
> to overflow the 4096-byte page and corrupt skb_shared_info.
> 
>> +		netdev_warn(dev, "MTU too large for single-page XDP buffer\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	WRITE_ONCE(dev->mtu, new_mtu);
>> +	return 0;
>> +}


Thanks
Nicolai
