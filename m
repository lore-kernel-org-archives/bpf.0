Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1066222585
	for <bpf@vger.kernel.org>; Wed,  4 Mar 2026 21:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772660126; cv=none; b=q7szqHQayxB0cGeA2I0FRdYLWQFYBpc0mc4oXKOkWRgHvWn7D4dc1lVAxSGY81q2IZkRg1Cbg6+RcSZCh6pyAIz7JMQRHSUf8TF7W/YiHX0LIkZI2g4Sip/VuaheJeVqJe3/M12R0SX4k/PnlOUtsNBJPdFml3H6A9rvlCD/r+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772660126; c=relaxed/simple;
	bh=g1jJ7+PvEzLNzCmg0/V/jfiEQVRG1P1r/WLSuAicBDE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D4W4KbxBpKqmqIdYn1Vpm2mlMqSUv+1tu/1FbLcZIPjCZzxrVMVqq7MgMJT58H/CZdEiWW/MV0Uvc0P+xnMi0BwbceksWkV94lMgLau8Cju4mssU2G4ftQFyJPOtJafK8B/O2TOU15tSFK3LGrcD8OyQFsPo78Q7UfugT1VfVGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cSGBhxDw; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cSGBhxDw"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-483bd7354efso97646755e9.2
        for <bpf@vger.kernel.org>; Wed, 04 Mar 2026 13:35:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772660122; x=1773264922; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oHwh5kWRHiqXFYFXI/fqBKZ24JxWXaGYGlZJiOK+k2g=;
        b=cSGBhxDwW7q/N/ouGNWX0lERHC53uRTfFbS0vO8HmCGAN20cl17w2aIrcGJTgDx+uH
         KoCSk1RQLyvHC4HwS6onw4uIGMSv/dWQEEcdsXMI01mLw5JPsYQc+qkTZqQf7MH8Zywe
         GimnUn/mAvg3sTzAEE0LRsmy6kgVEkpTTG/TAM/l0tRD0ljEg0v8sYfYIqvDTbRXzNpY
         hs9+Cf/ErNH0nwa6AfHhHJZVF5l0Vl0QeCOZQ9Vpp5E3Lhu+56JB6xt5sLPb+0k5qoXg
         X1XM8DBj8EpEliml6VW1kfFz5U4oaRkIGYXuOyD6BR12AAPTSuI9XhJArS3GoN+cYP7a
         KJ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772660122; x=1773264922;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oHwh5kWRHiqXFYFXI/fqBKZ24JxWXaGYGlZJiOK+k2g=;
        b=miPnlnGa+R4zfMll6W/in+5ntVCvwU5pbqI+4GB658xeZ7sO+Sknomm2wx8ZnDmKKH
         Ljg36Og/ai9pASK5ZYq9YjZH/szRxTEqVg+rk6J/iCKgYyLIdvMnwri+H8b/FPZ66pOo
         5GU8QG8Tu6SuncqdkqwlnaAflMzDghpfXVWax+ZsAkcHk2qt3IWO/IAyKnejZUwQ15GB
         yGia7KgWV+cIe2KG4gq2Lika5UWLa/SAI64g79Ye2pizPVqD/cB03QYlrBP/lRbOoqzY
         txe/yud/5Q3OTbzyzCqVknLDdDPJCv6imq2N+9NCn5yUJoLoXY7oOg9gg4yqdm2nXKCQ
         3ecA==
X-Forwarded-Encrypted: i=1; AJvYcCVt959ijJZeNOE3tGyxBVOYD76+2TgLVThQILyxDzwGCRm5QsT5badz4E9veJFwt2W4DFQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqzSqZSi6eZNnFuAn7I9r3ZgPK1PEfq5QZrB3pH6fYBcik8D6f
	ZEqnHsEdb9HZiEaBJYgp6ntVUE8EHuKqTdDYIIIQMgwsYn7ynnErS3VE
X-Gm-Gg: ATEYQzxYodR4m8/ChNMvyZJ7NVWvjpbQbIkSxCoBO3E3yFOWex/290SzdrFE8SHfZTr
	o5AIgOeCoTWAFAihjT8k5VdutaRsYAxdQH2on2uo8iXOJp5RLStp3tlTFq8Iqm0GoVilXQ9Vv8B
	52OqbemHJDksyTBsO8lzpnvT1c3ANxS+216I5EP62OKaHbeNy4t0vH/ODrtJI/Kr4gmjWSPa4L+
	+ON+lTmGOHvkdic2DycwtRKRb+7CNZ9EKTk/w846/AzTbk1BBG+4w1JC1poPd74JTHYK+j6BE04
	CooaWNli82gsJHDQzKPZCIRCrBfwgpXUYu7X929Ns7whhn4I/gS5Kc3WpdIiU1BTtAOwt6dMMPv
	kgTKOuZm4d02dbyWBJDqd4sG09ngecNuMYB/poBqijoyqcYrPefOSKanwGEFE8JnsgT/O8M+xFs
	GBlKyfjzQFMf1edQINIOU3XQA7zmaiIcpjOb+l1PGGtxQbW71YvZvBuD5+R437X02yzrIkMbBIo
	kA=
X-Received: by 2002:a05:600c:828d:b0:483:ad56:8d16 with SMTP id 5b1f17b1804b1-4851983a7fcmr55969805e9.6.1772660122112;
        Wed, 04 Mar 2026 13:35:22 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4851883a007sm80403085e9.2.2026.03.04.13.35.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 13:35:21 -0800 (PST)
Date: Wed, 4 Mar 2026 21:35:20 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Larysa Zaremba <larysa.zaremba@intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 intel-wired-lan@lists.osuosl.org, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexander
 Lobakin <aleksander.lobakin@intel.com>, Simon Horman <horms@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, John
 Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, Natalia Wochtman
 <natalia.wochtman@intel.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH iwl-next v3 04/10] ixgbevf: branch prediction and
 cleanup
Message-ID: <20260304213520.17e16331@pumpkin>
In-Reply-To: <20260304160345.1340940-5-larysa.zaremba@intel.com>
References: <20260304160345.1340940-1-larysa.zaremba@intel.com>
	<20260304160345.1340940-5-larysa.zaremba@intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  4 Mar 2026 17:03:36 +0100
Larysa Zaremba <larysa.zaremba@intel.com> wrote:

> Add likely/unlikely markers for better branch prediction. While touching
> some functions, cleanup the code a little bit.
> 
> This patch is not supposed to make any logic changes aside from making
> total_rx_bytes and total_rx_packets more correlated.
> 
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> ---
>  .../net/ethernet/intel/ixgbevf/ixgbevf_main.c | 29 +++++++++----------
>  1 file changed, 14 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
> index 5a270dd2c7aa..4619f2bea1ab 100644
> --- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
> +++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
> @@ -570,7 +570,7 @@ static void ixgbevf_alloc_rx_buffers(struct ixgbevf_ring *rx_ring,
>  	u16 ntu = rx_ring->next_to_use;
>  
>  	/* nothing to do or no valid netdev defined */
> -	if (!cleaned_count || !rx_ring->netdev)
> +	if (unlikely(!cleaned_count || !rx_ring->netdev))
>  		return;
>  
>  	rx_desc = IXGBEVF_RX_DESC(rx_ring, ntu);
> @@ -586,7 +586,7 @@ static void ixgbevf_alloc_rx_buffers(struct ixgbevf_ring *rx_ring,
>  
>  		rx_desc++;
>  		ntu++;
> -		if (unlikely(ntu == rx_ring->count)) {
> +		if (unlikely(ntu == fq.count)) {
>  			rx_desc = IXGBEVF_RX_DESC(rx_ring, 0);
>  			ntu = 0;
>  		}
> @@ -823,7 +823,7 @@ static int ixgbevf_clean_rx_irq(struct ixgbevf_q_vector *q_vector,
>  
>  		rx_desc = IXGBEVF_RX_DESC(rx_ring, rx_ring->next_to_clean);
>  		size = le16_to_cpu(rx_desc->wb.upper.length);
> -		if (!size)
> +		if (unlikely(!size))
>  			break;
>  
>  		/* This memory barrier is needed to keep us from reading
> @@ -855,7 +855,7 @@ static int ixgbevf_clean_rx_irq(struct ixgbevf_q_vector *q_vector,
>  		}
>  
>  		/* exit if we failed to retrieve a buffer */
> -		if (!xdp_res && !skb) {
> +		if (unlikely(!xdp_res && !skb)) {

I'd check that generates something sensible.
Using unlikely on multi-term conditionals doesn't always do
something sensible.

	David

>  			rx_ring->rx_stats.alloc_rx_buff_failed++;
>  			break;
>  		}
> @@ -867,21 +867,19 @@ static int ixgbevf_clean_rx_irq(struct ixgbevf_q_vector *q_vector,
>  			continue;
>  
>  		/* verify the packet layout is correct */
> -		if (xdp_res || ixgbevf_cleanup_headers(rx_ring, rx_desc, skb)) {
> +		if (xdp_res ||
> +		    unlikely(ixgbevf_cleanup_headers(rx_ring, rx_desc, skb))) {
>  			skb = NULL;
>  			continue;
>  		}
>  
> -		/* probably a little skewed due to removing CRC */
> -		total_rx_bytes += skb->len;
> -
>  		/* Workaround hardware that can't do proper VEPA multicast
>  		 * source pruning.
>  		 */
> -		if ((skb->pkt_type == PACKET_BROADCAST ||
> -		     skb->pkt_type == PACKET_MULTICAST) &&
> -		    ether_addr_equal(rx_ring->netdev->dev_addr,
> -				     eth_hdr(skb)->h_source)) {
> +		if (unlikely((skb->pkt_type == PACKET_BROADCAST ||
> +			      skb->pkt_type == PACKET_MULTICAST) &&
> +			     ether_addr_equal(rx_ring->netdev->dev_addr,
> +					      eth_hdr(skb)->h_source))) {
>  			dev_kfree_skb_irq(skb);
>  			continue;
>  		}
> @@ -889,13 +887,14 @@ static int ixgbevf_clean_rx_irq(struct ixgbevf_q_vector *q_vector,
>  		/* populate checksum, VLAN, and protocol */
>  		ixgbevf_process_skb_fields(rx_ring, rx_desc, skb);
>  
> +		/* probably a little skewed due to removing CRC */
> +		total_rx_bytes += skb->len;
> +		total_rx_packets++;
> +
>  		ixgbevf_rx_skb(q_vector, skb);
>  
>  		/* reset skb pointer */
>  		skb = NULL;
> -
> -		/* update budget accounting */
> -		total_rx_packets++;
>  	}
>  
>  	/* place incomplete frames back on ring for completion */

