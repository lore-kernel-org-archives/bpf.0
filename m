Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8FF92D73BD
	for <bpf@vger.kernel.org>; Sat, 30 May 2026 02:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780106674; cv=none; b=cx8HWyPh60il2y3/vS99KZlxSHv8qABBDsECqMJ/3OkaPBjGoPbEDOFczZrYMMbZdMNXK9E4K5Dqir+ycaz2U4FeGwCJhFRTj5GSxxTQ0SWk9Grb9aM8xYgPNW3+fp+dYs/QXM+yMueH0WGiQWfCSI2L9en4t26oSkW//ydbxCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780106674; c=relaxed/simple;
	bh=SrMy5Jdz+2D2EVz8tBqVvgfAjkAtcA4FZ0wgfcsMF5Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lzRp7mfS3lj/UVSgrmFAzc4Z0IHZoXvR2Y0wfmLZgScV0n7JpN+p3mr/N7aWizxtgWsJ1J2UuO3EEUo/SL67oli+UfoisYhHZa5ZYzB8i6jwTMdHGqeX7PftVrUUTD/QxdfOZLeI7VcXw2IKQQZAoH8YrgPrNlRMvP1CWVE7NKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=L3SCkRBo; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="L3SCkRBo"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-8c92737a8d3so95149626d6.1
        for <bpf@vger.kernel.org>; Fri, 29 May 2026 19:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1780106672; x=1780711472; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gVrcDEF09KsKVjTTMwgiJBdEIB/nZKDbtMXriX4I1jY=;
        b=L3SCkRBoYURvZlvI4DY9GqY8gi6DROcnJE755+DvGiLw2LEXK12L9GE4KjzYxUukmd
         jfA/3tensshmMEls/oJQflxygRQPwxliL6v1gcHDzA8yae3OFRin4RHUfI7X3jgPrI1H
         At8lZSB1dYWc8/HNhJxMJ4Hchp2ROUxKVRIqFE0ODw+ScVsV0QcYqbtqHxm8XUi8qCox
         Sy+3rZG0J5ArnGqqw/9ZwmpGRcME6K/9gCFuWpDYX89Qe24YwN/g/gRTHsqDmAsiHkn6
         sXGNHZQn8VilzGOxZ92sCopUct59edQb0vzijjqOL1rFaeLXGTUpPavZz96fJVFtlnXB
         6vAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780106672; x=1780711472;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gVrcDEF09KsKVjTTMwgiJBdEIB/nZKDbtMXriX4I1jY=;
        b=MGc/w13MeJS3feF8sH0lfN3mpRzLZV7ld9027WQ5Cdr0dOVgbNBuCEcelTpeFuH1Zy
         Gg1QL8Cuo/JtWZNPw2007dZal21SnBQbWegTwQyUJiCBgnfmBnhX6ODFuGxHasFGI6bd
         QDqJArMpd0EtvDg70ZiXhJoe+YguJ6Iq9YFB/fjeRk5LfZDirDpBBOoTt6FdEY0w3hKO
         +L/C86xEbHzIGXcCPGVE7Vdp2Ldngoo+w5AJdcCDxuKHKkJWzAJZERhM1SZxOY4wAHNs
         vPegaBGeUkevjw3aWqG+0AtDpGvaIfn/3aG90DIGh4y8hzMLxl1TCMpRXicgtII1rAim
         7Ipw==
X-Gm-Message-State: AOJu0Yx9wU/vH/dmiwTYDmXV7BBPf4bDsVm0hp8jKz8SscWKxvjhuvOv
	CbJKDaDvb+TxY5hKuvX7tGfPpBy8oyYG+hrF7ZsgaEq/Nx1lr5OLt3rDrYmeI14cg0I=
X-Gm-Gg: Acq92OGrx0Sij8hAuQ2/bgcqk3qa5rHDZD6YwJDRr28ZN5P3+MsIacCFpaHXNWgegMM
	z/QpFcFpe63bFSvv5OxrTh/zni6W/D/KpnNxPiw56TVi2dIAwnj2AkwHVEQFg9LQyHrSFYCSOpT
	qtA3zucbO5/XoZPvjuOs7YA7wgp4OzQ0fW0f2Lsc5zRi4Q8f05e1LC0NEVipaV4IE2uecbQUyLe
	3KzXjo9RIWprxCIO5LXTwsk+oaBnbCul2ZDB81ilhBIwEhYPkCtdSiDPACDgiFSZoNLiml8KQPl
	zlaCBkdiuqXeXKuXkGXBLVtshVj7YlEMjdruFm+cm5Edj/VRl1hr5S6kKiWg5tbseqlYtvKPGxS
	7Qxaz2ag23LGm/TelxdhcgTXlyGiHwVyFAOtjRblAN+O+i6KYToQCvp0ywNzovK0ykSw0/iKwxt
	O3FG4MWGXkKjyvWEmrKpqZr69Q1FYJvFR1/A==
X-Received: by 2002:a05:6214:27c4:b0:8cc:de2:3b79 with SMTP id 6a1803df08f44-8ccefd7622cmr39316916d6.20.1780106671726;
        Fri, 29 May 2026 19:04:31 -0700 (PDT)
Received: from [172.22.22.28] ([73.62.185.64])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ccea06d4casm32658206d6.16.2026.05.29.19.04.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2026 19:04:31 -0700 (PDT)
Message-ID: <eb69b202-17db-43cd-8fc1-51583f089e64@riscstar.com>
Date: Fri, 29 May 2026 21:04:30 -0500
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 04/12] net: stmmac: dma: create a separate
 dma_device pointer
To: sashiko@lists.linux.dev
Cc: bpf@vger.kernel.org, Daniel Thompson <daniel@riscstar.com>
References: <20260501155421.3329862-5-elder@riscstar.com>
 <20260502155616.82EA3C19425@smtp.kernel.org>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <20260502155616.82EA3C19425@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/2/26 10:56 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] DMA mappings are permanently leaked if an error occurs mid-packet in `stmmac_xmit`, `stmmac_tso_xmit`, or `jumbo_frm`.
> - [High] In `jumbo_frm()` (`chain_mode.c` and `ring_mode.c`), assigning a `dma_addr_t` to an `unsigned int` breaks `dma_mapping_error()` detection.
> --
> 
> commit 152df859f4e94baeb0ca419c5b87bcb9e5f13d3d
> Author: Alex Elder <elder@riscstar.com>
> 
> net: stmmac: dma: create a separate dma_device pointer
> 
> This commit adds a second dma_device pointer to the stmmac_priv structure.
> The new pointer handles all DMA operations independently from the normal
> device pointer, allowing better management of common internal IPs for
> specialized Ethernet bridge chips.
> 
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/chain_mode.c b/drivers/net/ethernet/stmicro/stmmac/chain_mode.c
>> index fc04a23342cf..331e6523ee01 100644
>> --- a/drivers/net/ethernet/stmicro/stmmac/chain_mode.c
>> +++ b/drivers/net/ethernet/stmicro/stmmac/chain_mode.c
>> @@ -34,10 +34,10 @@ static int jumbo_frm(struct stmmac_tx_queue *tx_q, struct sk_buff *skb,
>>   	buf_len = min_t(unsigned int, nopaged_len, bmax);
>>   	len = nopaged_len - buf_len;
>>   
>> -	des2 = dma_map_single(priv->device, skb->data,
>> +	des2 = dma_map_single(priv->dma_device, skb->data,
>>   			      buf_len, DMA_TO_DEVICE);
>>   	desc->des2 = cpu_to_le32(des2);
>> -	if (dma_mapping_error(priv->device, des2))
>> +	if (dma_mapping_error(priv->dma_device, des2))
> 
> This isn't a bug introduced by this patch, but since the patch modifies these
> DMA mapping calls, it brings up a potential issue.
> 
> Does the use of an unsigned int for des2 break error detection?
> 
> On 64-bit architectures, dma_map_single() returns a 64-bit dma_addr_t.
> Assigning this to the unsigned int des2 truncates the upper 32 bits.

I think this is a legitimate report.  I will follow up with a
separate patch that will change the type of the variable holding
the value returned by dma_map_single() to be dma_addr_t so it
doesn't affect the validity of dma_mapping_error().

> If the mapping fails, it returns an error code that becomes 0xFFFFFFFF after
> truncation. When this truncated value is passed to dma_mapping_error(), it
> is cast back to a 64-bit value, which no longer matches the expected error
> code representation.
> 
> Will this bypass the error check and record an invalid physical address in
> tx_q->tx_skbuff_dma[entry].buf? This same pattern also appears in the
> jumbo_frm() function in ring_mode.c.
> 
> [ ... ]
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>> index ca68248dbc78..1104cf750295 100644
>> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> [ ... ]
>> @@ -4876,9 +4876,9 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
>>   
>>   		desc = stmmac_get_tx_desc(priv, tx_q, entry);
>>   
>> -		dma_addr = skb_frag_dma_map(priv->device, frag, 0, frag_size,
>> -					    DMA_TO_DEVICE);
>> -		if (dma_mapping_error(priv->device, dma_addr))
>> +		dma_addr = skb_frag_dma_map(priv->dma_device, frag, 0,
>> +					    frag_size, DMA_TO_DEVICE);
>> +		if (dma_mapping_error(priv->dma_device, dma_addr))
>>   			goto dma_map_err; /* should reuse desc w/o issues */
> 
> Similarly, can this leak DMA mappings if an error occurs mid-packet?

It looks to me like it could.  I don't know this code especially
well, but if the loop iterates more than once, and skb_frag_dma_map()
returns an error, it seems the mappings should be "unwound" at
the dma_map_err label.  I'll look at this as something to address
in a separate patch too, but it's a little trickier than the first
suggestion.

					-Alex
> If skb_frag_dma_map() fails for a multi-fragment packet, the code jumps
> to the dma_map_err label. However, tx_q->cur_tx is only updated at the very
> end of the function upon complete success.
> 
> Because cur_tx is not advanced on the error path, stmmac_tx_clean() won't
> unmap these partially filled descriptor entries. On the next transmission,
> the driver will start at the unmodified cur_tx index and blindly overwrite
> the tx_skbuff_dma entries.
> 
> Could this result in permanently leaking the previously successful DMA
> mappings? The same concern appears to apply to stmmac_tso_xmit() and
> jumbo_frm() where multiple fragments are mapped sequentially.
> 
> [ ... ]
> 

