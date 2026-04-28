Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1AC43DA51
	for <bpf@vger.kernel.org>; Tue, 28 Apr 2026 13:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777382009; cv=none; b=ZnebkuzH2uEWk4ZDQcIx/YSpGzXZm6hj/V8F3EA21xL9KYnaF73bOEGKYPF9ExQrsp/9Z0l9KvnE/Xn0Ab+aymQYUIAbG3tR50FXuN5+oa+W9iSen/f3j/OqiDudUI/0dKzGbMh24pdVQkDljSPwcyaVdsVQv8rwYtF6aXl0h5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777382009; c=relaxed/simple;
	bh=WLTyOgn6Yo2LBw9Q51BSSkcRxJInShuvEO903qRo0V0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DH16C/j+RMDSi+3EUf6cDAUbNbmnE00uImL1byDdKZacbSEAkdurbsSEFP2iSBZJsFe2RDszpGtkez0UpTH9MiafRhsgh68XTuvDMY4GcjNqrZmZl9H0MWNJp8UP/NIVHMRstYi+qHblb3K3b/SxByGQVHIeZwR0vi9THIB45D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bjp4qEOM; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=toxJn5ke; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bjp4qEOM";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="toxJn5ke"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777382006;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r6UCJWpe6oz0LWXsTSAYtgVExWdfBVYtrUT8ubfZ6Y8=;
	b=bjp4qEOMsnvNZFMxNAdm2dO8yFmCmE11MvSgfl60bPts+Gb+1qjyDz0EGK7F69Y2QY+cPS
	Lz30HD2QR1cOp5Hal2jXnPfy72ra3l+Dh9Ls0yEif9V6/MDjgXmGNqpJbj58d8sUfd65Ru
	DxGQOmActkiD91L1njgsZkBa97E6uAY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-79-j75w6xmUNviDkVWe-_EQew-1; Tue, 28 Apr 2026 09:13:21 -0400
X-MC-Unique: j75w6xmUNviDkVWe-_EQew-1
X-Mimecast-MFC-AGG-ID: j75w6xmUNviDkVWe-_EQew_1777382000
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-488f973ddfeso84476295e9.3
        for <bpf@vger.kernel.org>; Tue, 28 Apr 2026 06:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777382000; x=1777986800; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r6UCJWpe6oz0LWXsTSAYtgVExWdfBVYtrUT8ubfZ6Y8=;
        b=toxJn5kewFPB/TPe+9eojtCYLkx/tJJ2WhHnqIaa5mCLpMOBdr8do4gHkU/nbw6YU9
         PXYK5J0AElbv87arcI+cWv0xj81xNBeAgDJ90cYT7J3ft9K/pmpgsaaYEFO3VEfGbON5
         pR+NWCj9tTenfoZI08bfmRHWCWNNXL7FOezsGxOTtPAEVMOko8SpWiBbmyfLwabnNBzp
         dW/aoVtPZkF4ISepaAgqk6sxDJCF27xpqZhtuxk/GKgV7VQxqR9OGpx1SA1AsgoUVto3
         bVVoACNJKTBDPd96qO/dyDd0ZheZgzAaMRSM7xx7BxFrlyUyKpvAPGteBNNzLKN0Vx6V
         FxGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777382000; x=1777986800;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r6UCJWpe6oz0LWXsTSAYtgVExWdfBVYtrUT8ubfZ6Y8=;
        b=bPMhy2+WWeCTMekRX4SeZZ0pNITUVIIxrSev5UnBdtWpLuiBRIu5glpDZwn2t28F7c
         H/kMlGzg6o7ghuVnDf8gtfBtMKPAQ4KTsO9La/GGH6UqcrFTnzlJremOzvxdyQbuSzSF
         UkE3OfWmGMU89J6/d5GD8gtsmk3Qhj+dY5VhYr9nGpaoCUeqkeUr0rH8bh0cVkADI3YQ
         zWzI4d22yHcR4w43zPb/rAeNZvvWnRf3kIQ1Vypsxib3Sq5KEUb0hk2yZ6p1eK4xk//a
         S2VSsylUknbpfuBciKBhomEVa/RV0pkTz8QsgrB4tXegJbOeh7y4z4ilQ/2l+P/IdYp2
         jkfA==
X-Gm-Message-State: AOJu0YxuFEKWPRkp81Aaa3VPYZGGGBTF/m0e9QL+BQ1rjXiDOc0Mj1gm
	pL8jZAORJq6f/SXi01tkApBOXnRs3RZNvxzAD4/9C3a0tNyH6PSPX9KuoLQI//CAopBFvTwySu0
	jNyY8dhg5FQnEV131Hw8R/RiGnrpl4hoJ+xAe253Gct9iEPwvq1wbRg==
X-Gm-Gg: AeBDievFFdIq22te/PYifr55lp9plou7z7b6dRrO3lcpsA6YCtMnlh5O+PD7EVGA95r
	440Ka0P+YlaoBoTGfmaYw1Nt7qEp4AfVrwtX8t+A9rDyDRaHUGzaFlY5KO82A3inRLZldWP8rzh
	hm+FS70tfjl2CC5ffnvI1BEfCoFtyv+li+7nGk6+1vyOdeJLtXJAFNvXo8A6k9zyDxthGsTCMT2
	p4tuvP1hv5dkmwFazW+ljTI0qNLSr3QM50uzAl5Z0R31rqV391inuMJkE4c2cGrXzwbh6hAI7mD
	lMihrvxvLggTk8amoe1HS3nkL16PlHzrxtBiNMTHxmxAoyFOeQ+uLZxhzzU097yVbaAR/JseeFx
	jMZgBaxnAM7FgB49qXvDvwqcQX4f7IG7D7lm4BOftFDdIXRpVxDMHZXo91f3Du95oZg==
X-Received: by 2002:a05:600c:82c3:b0:48a:7772:c26b with SMTP id 5b1f17b1804b1-48a77b2608emr50277315e9.26.1777382000165;
        Tue, 28 Apr 2026 06:13:20 -0700 (PDT)
X-Received: by 2002:a05:600c:82c3:b0:48a:7772:c26b with SMTP id 5b1f17b1804b1-48a77b2608emr50276565e9.26.1777381999597;
        Tue, 28 Apr 2026 06:13:19 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.9.114])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a775eb983sm18943475e9.19.2026.04.28.06.13.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Apr 2026 06:13:19 -0700 (PDT)
Message-ID: <99816901-6026-49ec-9c20-b548ed362d11@redhat.com>
Date: Tue, 28 Apr 2026 15:13:18 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v4 1/8] xsk: reject sw-csum UMEM binding to
 IFF_TX_SKB_NO_LINEAR devices
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: bpf@vger.kernel.org, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 sashiko@lists.linux.dev
References: <20260424053816.27965-2-kerneljasonxing@gmail.com>
 <20260425054032.28A27C2BCB2@smtp.kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260425054032.28A27C2BCB2@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/25/26 7:40 AM, sashiko-bot@kernel.org wrote:
> Sashiko AI review found 1 potential issue(s):
> - [High] The patch incompletely fixes the WARN_ON_ONCE in skb_checksum_help() triggered by pure-fragment SKBs. It successfully prevents the explicit fallback in xsk_skb_metadata() (which wedged the TX ring), but leaves the implicit generic network stack fallback vulnerable. If a user sets XDP_TXMD_FLAGS_CHECKSUM on an IFF_TX_SKB_NO_LINEAR device and the hardware checksum offload is disabled at runtime (e.g., via `ethtool -K eth0 tx off`), the core stack's validate_xmit_skb() takes over. Because NETIF_F_SG is allowed to remain active even without checksum features, skb_needs_linearize() evaluates to false, leaving the SKB unlinearized. The SKB is then passed to skb_csum_hwoffload_help() -> skb_checksum_help(), which hits the exact same WARN_ON_ONCE(offset >= skb_headlen(skb)) because skb_headlen is 0.
> --
> 
> commit 86ab0a4900aa60bee0c3df7393a2846b5ff74ccb
> Author: Jason Xing <kerneljasonxing@gmail.com>
> 
> xsk: reject sw-csum UMEM binding to IFF_TX_SKB_NO_LINEAR devices
> 
> This commit attempts to fix a warning triggered in skb_checksum_help()
> by AF_XDP pure-fragment SKBs. It rejects sw-csum UMEM binding for
> drivers advertising IFF_TX_SKB_NO_LINEAR at setup time.
> 
> Closes: https://lore.kernel.org/all/20260419045822.843BFC2BCAF@smtp.kernel.org/#t
> Fixes: 30c3055f9c0d ("xsk: wrap generic metadata handling onto separate function")
> Acked-by: Stanislav Fomichev <sdf@fomichev.me>
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> 
>> diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
>> index cd7bc50872f6b5..d981cfdd853578 100644
>> --- a/net/xdp/xsk_buff_pool.c
>> +++ b/net/xdp/xsk_buff_pool.c
>> @@ -175,6 +175,9 @@ int xp_assign_dev(struct xsk_buff_pool *pool,
>>  	if (force_zc && force_copy)
>>  		return -EINVAL;
>>  
>> +	if (pool->tx_sw_csum && (netdev->priv_flags & IFF_TX_SKB_NO_LINEAR))
>> +		return -EOPNOTSUPP;
>> +
> 
> Does this still leave a path for the warning in skb_checksum_help() to
> trigger if hardware checksum offloading is disabled at runtime?
> 
> If a user sets XDP_TXMD_FLAGS_CHECKSUM on an IFF_TX_SKB_NO_LINEAR device,
> and hardware checksum offload is later disabled (e.g., via ethtool -K
> eth0 tx off), the core stack's validate_xmit_skb() will take over.
> 
> Because NETIF_F_SG can remain active even without checksum features,
> skb_needs_linearize() evaluates to false, leaving the SKB unlinearized.
> 
> The SKB is then passed to skb_csum_hwoffload_help() which falls back to
> skb_checksum_help(). Since the pure-fragment SKB still has a headlen of 0,
> won't this hit the exact same WARN_ON_ONCE(offset >= skb_headlen(skb))
> warning?

My take here is the issue describe above should be handled separately.
(And on top of my head I don't see an easy way to address it short of an
additional check in the tx path, which I think we want to avoid).

/P

