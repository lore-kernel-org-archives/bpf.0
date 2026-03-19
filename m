Received: from mail-pg1-f225.google.com (mail-pg1-f225.google.com [209.85.215.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B48C36492B
	for <bpf@vger.kernel.org>; Thu, 19 Mar 2026 21:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773955131; cv=none; b=dtGRXbRh6SppzQJ7k66w/cyNwboMN2Mp3sNOCm5qXP2VM0oDN3UYKyb4C2TpF4CNQl7HMXZFn+v+BepogoDRmyB2Qdr+ee1blxBLreSlBBT+x+ONWrgOuVBgRhsdxys1dy42QZRgUnC50tzhmUuqAvulZxDhJptE5mqpY64Y4cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773955131; c=relaxed/simple;
	bh=JMzLFbl/OhviIhCtefUkTX8+jfOgmHMWoaLX2EUjHmY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X+12TraFlhd5X1epgwCEJtT49oafSj99ZQ+b2re2IFkX4hCq5nRTm1L/fEiATHzKZdwANPCTZdQmOGj9OobB9Scsz95rfPlm7buljKYUwWZ87ElyWdTHw3iwDn6h7bV/YJIrDVxFD49vfi0HoCuvlsBNB0LP427eKoSnRTfPlbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=OCyZFqkm; arc=none smtp.client-ip=209.85.215.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="OCyZFqkm"
Received: by mail-pg1-f225.google.com with SMTP id 41be03b00d2f7-c70f91776fcso613936a12.0
        for <bpf@vger.kernel.org>; Thu, 19 Mar 2026 14:18:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773955130; x=1774559930;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wh4ELn+KVUmnhuFnvz3rcSxyHtgDapB59qby14b5LnI=;
        b=OYUc6Sz+adyzGA9rzCKICJiO1/S+TIi4Rqkh9aPMwxLPs/Uk/30FsEd16IMDolJhGF
         krM3A6FB594D/z9Mmy7MqJkcExPiC3Xgaigmfp9bfL47E7xAPynxZrf2W6HhzkIMJ74Y
         OP6756MZhW5KzzZaEmAZlmSgZ3rRyrZenAGNeQTujn7m89wI5SNkhhrYmF4OS7kH49Ti
         JcGrVF2Jm/wljJhQO2FC2f24IqQoDa7GukiwlNnryx8los/Sjxost0aqT4HMzdA8qwyU
         oac8J9licakEaNY5/Jthc55hdZHbqO9BbOXv3XZcqGG5aPx2+oyf3Y6lAijwUvSIPkOj
         V1og==
X-Forwarded-Encrypted: i=1; AJvYcCWTAyr6khAXHCdH3dyKYDRXkGE1LOI+ij8UTpeUOwpmq84XuhjW1yKJYseIad3cQBjxl2k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwY1FB/mmmROax3aoNeD5AMULkeonHs0IDOryTU9fngdCKXefur
	Y/usdcBKSMNML/vzXSjPWdg/6+Psg1am0HEBhIqb61h0D68JRe/2dLj3eBQFaxEfkOfZ5uhF3OX
	mqJiG0MPMAa5ccDzi8q3C2pl/6SizCznVnKhl7RerVW2Vf1X5u0u7CRbFHxGJ7qejjwABWKdCqU
	LqHTpf2r/OeO28Q7f7SFIOXPuK83qWA8qT8lPZAxvilx/I6GjAjA1u7yKoSMjSw03epaKVRbRPk
	NMXPg==
X-Gm-Gg: ATEYQzzBbkQibbmyBBpSHpKaLTBTWSfCM4LeGA1DKWAU3Q6dvu5KQUFQ3FnjvnOxUfP
	a0MUrJeGVUcPcHfjN9LaDO8gR49li/rLFyqxi/cJ1v758QUkIT+JloFHS6JbJYh7O5SBIrE72Uz
	L8Ywhr/5cZU6FW9YuLgEZofNVOtZT7cYfBT5X0QOVy+QYNqkGJOXY4gZz2uZ5ftbVwBvr3jBw6N
	j2df+QiFtOWWiiQVvKggsEa9lkWrDcQ6gBdNrUcwt6SdBfRoxttJefDrJ93rceb6ERI5ZY5ISW6
	DlNmLgmfASUT1xYqKlWGwroqTh1QVPsc6D1+qzIYjGwgLotkzZoEf6qmhKQxNNKFdDRAuOmpSm9
	gIjFSrI8npfEBCNMSZG3YFwhXecADKipEUsH7u5j/9gmwQJvLQl2S0AW6XpJzM9UHPy8BCi4E4B
	eti7/o5NBuFGVngIjYuXpKODpDxF9IS1wextK4VYALw9YrHUeSBsdKzJy1sQ==
X-Received: by 2002:a17:903:44c9:b0:2b0:59c4:e9e2 with SMTP id d9443c01a7336-2b0826c3842mr3609575ad.2.1773955129562;
        Thu, 19 Mar 2026 14:18:49 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2b083617795sm284815ad.48.2026.03.19.14.18.49
        for <bpf@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Mar 2026 14:18:49 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-2ba8013a9e3so1225795eec.0
        for <bpf@vger.kernel.org>; Thu, 19 Mar 2026 14:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1773955128; x=1774559928; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wh4ELn+KVUmnhuFnvz3rcSxyHtgDapB59qby14b5LnI=;
        b=OCyZFqkmoHoWuLKiWhRC1et6cYf0UdgcJKjabEOek1+WvYdA/1K1lgKQMPM5UzcMKy
         pILUjgzuStiTmAcnpA2JQNzDXDrqxdsCgr9cj2z7DsEK+LL5fUkFTWFtPS8jBQTbdtFO
         4+TxVUAb38zUnZ+YIzd32d8ITwEoTL7cfBnCo=
X-Forwarded-Encrypted: i=1; AJvYcCVWCLApYaruygDBPdtoUizpgnxTHRBmwXZmmbvjjljmwivNinDV8TY81C4weR1KXWDTz4g=@vger.kernel.org
X-Received: by 2002:a05:7300:50e:b0:2c0:ffe7:318d with SMTP id 5a478bee46e88-2c1097d7856mr381823eec.30.1773955128011;
        Thu, 19 Mar 2026 14:18:48 -0700 (PDT)
X-Received: by 2002:a05:7300:50e:b0:2c0:ffe7:318d with SMTP id 5a478bee46e88-2c1097d7856mr381809eec.30.1773955127301;
        Thu, 19 Mar 2026 14:18:47 -0700 (PDT)
Received: from [10.14.5.69] ([192.19.161.248])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c10b1a88e5sm537846eec.13.2026.03.19.14.18.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Mar 2026 14:18:46 -0700 (PDT)
Message-ID: <2ccfaa48-7aad-49e8-bdfa-82ca9b6ebcc6@broadcom.com>
Date: Thu, 19 Mar 2026 14:18:45 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 2/6] net: bcmgenet: register xdp_rxq_info for
 each RX ring
To: Nicolai Buchwitz <nb@tipi-net.de>, netdev@vger.kernel.org
Cc: Doug Berger <opendmb@gmail.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
References: <20260319115402.353509-1-nb@tipi-net.de>
 <20260319115402.353509-3-nb@tipi-net.de>
Content-Language: en-US
From: Justin Chen <justin.chen@broadcom.com>
In-Reply-To: <20260319115402.353509-3-nb@tipi-net.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e



On 3/19/26 4:53 AM, Nicolai Buchwitz wrote:
> Register an xdp_rxq_info per RX ring and associate it with the ring's
> page_pool via MEM_TYPE_PAGE_POOL. This is required infrastructure for
> XDP program execution: the XDP framework needs to know the memory model
> backing each RX queue for correct page lifecycle management.
> 
> No functional change - XDP programs are not yet attached or executed.
> 
> Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
> ---
>   .../net/ethernet/broadcom/genet/bcmgenet.c    | 22 +++++++++++++++++--
>   .../net/ethernet/broadcom/genet/bcmgenet.h    |  2 ++
>   2 files changed, 22 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> index 7410034d9bdc..6e610e73e12f 100644
> --- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> +++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> @@ -2771,16 +2771,32 @@ static int bcmgenet_rx_ring_create_pool(struct bcmgenet_priv *priv,
>   		.offset = GENET_XDP_HEADROOM,
>   		.max_len = RX_BUF_LENGTH,
>   	};
> +	int err;
>   
>   	ring->page_pool = page_pool_create(&pp_params);
>   	if (IS_ERR(ring->page_pool)) {
> -		int err = PTR_ERR(ring->page_pool);
> -
> +		err = PTR_ERR(ring->page_pool);

This should go in the patch before this.

>   		ring->page_pool = NULL;
>   		return err;
>   	}
>   
> +	err = xdp_rxq_info_reg(&ring->xdp_rxq, priv->dev, ring->index, 0);
> +	if (err)
> +		goto err_free_pp;
> +
> +	err = xdp_rxq_info_reg_mem_model(&ring->xdp_rxq, MEM_TYPE_PAGE_POOL,
> +					 ring->page_pool);
> +	if (err)
> +		goto err_unreg_rxq;
> +
>   	return 0;
> +
> +err_unreg_rxq:
> +	xdp_rxq_info_unreg(&ring->xdp_rxq);
> +err_free_pp:
> +	page_pool_destroy(ring->page_pool);
> +	ring->page_pool = NULL;
> +	return err;
>   }
>   
>   /* Initialize a RDMA ring */
> @@ -2807,6 +2823,7 @@ static int bcmgenet_init_rx_ring(struct bcmgenet_priv *priv,
>   
>   	ret = bcmgenet_alloc_rx_buffers(priv, ring);
>   	if (ret) {
> +		xdp_rxq_info_unreg(&ring->xdp_rxq);
>   		page_pool_destroy(ring->page_pool);
>   		ring->page_pool = NULL;
>   		return ret;
> @@ -3012,6 +3029,7 @@ static void bcmgenet_destroy_rx_page_pools(struct bcmgenet_priv *priv)
>   	for (i = 0; i <= priv->hw_params->rx_queues; ++i) {
>   		ring = &priv->rx_rings[i];
>   		if (ring->page_pool) {
> +			xdp_rxq_info_unreg(&ring->xdp_rxq);
>   			page_pool_destroy(ring->page_pool);
>   			ring->page_pool = NULL;
>   		}
> diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.h b/drivers/net/ethernet/broadcom/genet/bcmgenet.h
> index 11a0ec563a89..82a6d29f481d 100644
> --- a/drivers/net/ethernet/broadcom/genet/bcmgenet.h
> +++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.h
> @@ -16,6 +16,7 @@
>   #include <linux/dim.h>
>   #include <linux/ethtool.h>
>   #include <net/page_pool/helpers.h>
> +#include <net/xdp.h>
>   
>   #include "../unimac.h"
>   
> @@ -579,6 +580,7 @@ struct bcmgenet_rx_ring {
>   	u32		rx_max_coalesced_frames;
>   	u32		rx_coalesce_usecs;
>   	struct page_pool *page_pool;
> +	struct xdp_rxq_info xdp_rxq;
>   	struct bcmgenet_priv *priv;
>   };
>   

