Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C943363C75
	for <bpf@vger.kernel.org>; Sat, 28 Mar 2026 06:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774680690; cv=none; b=B5kbHW5IF3LUWG/k/FRihG2aeEZtuCdpgCEr6kggrrVKAhaNBgLCBq7mL4MSuAu/LqVc9yHCq2wYAG0yiMN4FSg8SI6+fHkQ9lvSmZFFPHq0Bum8yrrGXFgTsX2k2iP70L0KH7mcNWl9qAygeg+S7MzbB9xO/0r+Djo/EJKa5cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774680690; c=relaxed/simple;
	bh=An4vic6MBd35CZlHJpJvGDwg9ViMF4bVOHaPAyHIEio=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VfmbDFWvsHPbBXIFQ2H6sQsZKX+8HVGz/bidDKMFGME/zKBaiik2TPiReR4EJ7XmfsZA+q/hMWKHzVwge/UPdXoEx6KccWA9JwN81x4kZMnLAo/tpmguZHt3n24i1VIGH/4sSiYIDmcpdmhmBr/3CJWa9tqgW5ekGOe3FDYKPUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=JW8Nka5o; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="JW8Nka5o"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-48538c5956bso27435555e9.0
        for <bpf@vger.kernel.org>; Fri, 27 Mar 2026 23:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1774680685; x=1775285485; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gBJ6xSeU7qVX6wdlPN+g9gXgCJbSsPlI9/YF9B2IXT8=;
        b=JW8Nka5oZs+j15WY8XY4FRNsUDpzFr2sjdBlAwy0HdDznAlF3QDiuva0QEapXgPCVS
         RThvGLdRkvhAmEz75zyIezi25qXVkKWT9JN7xabnE2xpeBxX3rPirEQpCyM8IkGwjFfO
         ErghQ6no3X3uWS9N357GPNLEGTD98NlaDtaTOuAShM4qINA1ab9STbI/Dqt97inQqXX6
         eBFM5zVgccmc4D9HEv1Bu8vIixiTH8cXo6DCBHV8WZbyEXX+O8lMRAecMxMMcKITGg+2
         l1du7eanhWKodDrzXeMvDdcIM5GfKzDJehN+sD3WJ1oV2vHocV3cdlvEP0Wevy24ZnAT
         C6uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774680685; x=1775285485;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gBJ6xSeU7qVX6wdlPN+g9gXgCJbSsPlI9/YF9B2IXT8=;
        b=bAV9j1JWixs4LQ/AUd3iN0aEWLntaERR9B39a9g2T2VyOA5pPrqhNTV92MyrjwqXmT
         1QCko34bejG9agMeNPi+GbOqEc5uVZUw50N/Bst6pS8ywg0MXBYLvRgQKXfcjU25nqzM
         kfbp6LiZ+zrCCf4y3T62iL5dewIHfVaH1vwalRCw5mW2tBGalneslHm1G+6VF/ifUzAW
         +3dkp/yAuuMR9jVy+5oftgAp8uZZR2SWWg8/qC1uEt9kWvuoeWbzy06MVXJQdoTfDe1V
         FMjJNtIn483byfZgLG+NIpzLZw79YNjT/ZWeecFixfLSbbbKu3cZAT1sTwszQD6K3U6u
         dMNA==
X-Gm-Message-State: AOJu0YwPbt0XOujjlGlj305LmdUt+n3EPjwbuVY2mKm2DanymEgT30OL
	v54OnFr1MpaO9nDjC7xOiuDo2lJ7a3V9Lmwtzk3uMuLj1Yc9TL8/erkM90gqNH36QWU=
X-Gm-Gg: ATEYQzzitA+1oVjs52vRVYullsuKQoPUcH1NCjj/1JXMwK5JHYeiyJSHS2R+C7lgc9L
	+EWr/eKTjMNmdrMGuk2vXnfeD1Qpy6jhmjPWeqLoKH8iV3t9Dzx1Y53Fc8Or7a8zMr2NS23YS6E
	kRa4ZPdtElXOUIGzqPSrSrQfuIsrcMwspCv+euwrJbynHmj76bO8ZgYN7yPA3WEFmelfONCE/+g
	O/aRk5fYkfEWBikaZObwSlVgrFZxPWi/G1Sbnm7JHw9XbkBMiouWlV+xvDha5ZcNHEMluiBjrVC
	EkesTKpDLfVbEEmflJTY5d4j05WbWhqO6//yBG8qG9joB3k40QJk0C+6IkRAR55fRNL6oCE7eLE
	rfqRSG5zlX9X6lCBlaz70k2CSPQ9RCMxapP/9rrqDxA46zTQhJbdTdyDQztB97cUGu2/A/48Fhw
	vP2Qk21jrkvq7agZllRi3lpcMui2u2PZgNyUF2x8qjH2oZo5q7nSVorg==
X-Received: by 2002:a05:600c:a418:b0:485:50ac:b8cf with SMTP id 5b1f17b1804b1-48729016ca5mr56244635e9.0.1774680685602;
        Fri, 27 Mar 2026 23:51:25 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48722c957b9sm205194715e9.8.2026.03.27.23.51.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Mar 2026 23:51:25 -0700 (PDT)
Message-ID: <64535bf7-7416-4f5c-9b37-edca8ed57656@blackwall.org>
Date: Sat, 28 Mar 2026 08:51:23 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v10 07/14] net: Proxy netdev_queue_get_dma_dev
 for leased queues
To: Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, kuba@kernel.org, davem@davemloft.net,
 pabeni@redhat.com, willemb@google.com, sdf@fomichev.me,
 john.fastabend@gmail.com, martin.lau@kernel.org, jordan@jrife.io,
 maciej.fijalkowski@intel.com, magnus.karlsson@intel.com, dw@davidwei.uk,
 toke@redhat.com, yangzhenze@bytedance.com, wangdongdong.6@bytedance.com
References: <20260327121049.334562-1-daniel@iogearbox.net>
 <20260327121049.334562-8-daniel@iogearbox.net>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260327121049.334562-8-daniel@iogearbox.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27/03/2026 14:10, Daniel Borkmann wrote:
> From: David Wei <dw@davidwei.uk>
> 
> Extend netdev_queue_get_dma_dev to return the physical device of the
> real rxq for DMA in case the queue was leased. This allows memory
> providers like io_uring zero-copy or devmem to bind to the physically
> leased rxq via virtual devices such as netkit.
> 
> Signed-off-by: David Wei <dw@davidwei.uk>
> Co-developed-by: Daniel Borkmann <daniel@iogearbox.net>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> ---
>   include/net/netdev_queues.h |  3 ++-
>   net/core/netdev_queues.c    | 36 ++++++++++++++++++++++++++++--------
>   2 files changed, 30 insertions(+), 9 deletions(-)
> 

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>

