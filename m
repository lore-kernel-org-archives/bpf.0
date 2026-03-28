Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6381D17C220
	for <bpf@vger.kernel.org>; Sat, 28 Mar 2026 06:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774680484; cv=none; b=bNQ5TTyO+ToyA+mejjGoV5Zmc+dk9jIAkP6rMmBcSq8CWieSSKVM6FAVvPld/sIoEdhRMLPphF/19sOGr44+W8aL46nd9oit88kdtHsXdPtGo4SMWBBVEfRejoL2D7YounU5fyRVEuW+T4gF1g3k25CPm5k/vm2iQeOBOD6QKAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774680484; c=relaxed/simple;
	bh=bbvI9iWBsuwbYbUiB414sq68ZB3+ZOIlpKW96dHSPc8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JVzGUwQ73B47MQKpNTCEbyRZRdWQnUNsRtKOJ/MXtfv2IkKk9c0DeKggjAwqGy/wpZhCJZG0evGxhkqXpqgS8CZFqt1wy9V8ERB36dQOiPR9QhMJGDy/V+KjzUBK+XyTh4Yer9GVKI+q03h5vGymliUAdjI4tbKNDJYEtvGapYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=hsIbeHoA; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="hsIbeHoA"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-439b9b1900bso1652291f8f.1
        for <bpf@vger.kernel.org>; Fri, 27 Mar 2026 23:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1774680482; x=1775285282; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5O0qXq17JKmnmutbL4tWXncwKTIiaImob3OC0al/I2k=;
        b=hsIbeHoAmW/EINsyoWIylHj5UMMHH0XGlaEQDeVxrcRFSqw+Wfe26eSyH7d1NVvrGg
         CurrKU/TKSy2ILfAPCrWAdmh34N187h9gzbXW7C17sFP0qNvt/3uFn26eESfF5ATw7jD
         XKXeYsIvGfO9H51Gboc3SOalKPz+e+FYjBuqbu0H9dEOwNqym8lYZdMiShMbBVb0+zav
         bP7tHbJ9W6hDilm35X2DgPdtCPro8Eq8BJpzcq2R7IU2HCbFFQsT1l824jJlOw6vIpPX
         qRVQVk6/IT2Xq4HhmKrhIjqfuppJ5+9+7qZnKbCFrkyeIneCkKl07wlcBsHFdtZrVarX
         122Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774680482; x=1775285282;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5O0qXq17JKmnmutbL4tWXncwKTIiaImob3OC0al/I2k=;
        b=DYSwt0FE4Q0vqn5ioKBoAOYc/XfXNK9Dgqq81oe5zaKmUX49HjuBUR2vdBxDh5j2NR
         vJLf9dQDqw0EoMdxNMyK3Upe4OkHEXNPW/LeluIH5iaFlnZveIsEkF4PjSCFvWvGtRkN
         xTVFww17o6ZQc23+KixVuv/zLmUAj6T0h5/8MkMhYNSYYjh+NoJrij0LFEMroYcwQWRx
         5r36dCcLH/0V3cD2e4Lg9iqhVMgrq8neYElYgca5SkcxYFFRz6MTXKK6AoPy5q9zAiBp
         PJqsX6yffR3hGTFfcaQX6mswM+tQ9xtBs6HSpW4PT5MJwsTWNuYezccSpfZIeQ91HQ3+
         cmqg==
X-Gm-Message-State: AOJu0YwZnPoCBQh3IqwvGLT3ymLXtV4EzkFBrGg/UF6otbRwzbEEof7k
	PJ6Jy/8hBYsHnCTcrzY14w0/iXS+zAj3IRF4nQ5D59qXe41dAU+ibU9bLorFCkQ6+lY=
X-Gm-Gg: ATEYQzzYRITsZHfvU4o8hR2p+HAEhyYG3BSMVqNM+p604P5TYwygenudyeCqb+WoKpl
	aTGQtEe1tlabgKYLN6dFn95ZBszviphRq4kQ2Ly5PJy/hzPUK0OqdFUzrPKOPGXdLCKfCFeJjbM
	62z2dVM4gnrPH8PdVgs6ldD96+XeNalSXRzBce8h+Jz6gSdNJe2vHB732f2KpvqkzGc1CmQA0T8
	+DgOu/jGlDP7TyJCq8vlmH0RI/fMBskitCaTnBhKJNpIk+/Oi0+01IqNpMVO4nuRztdOHMITSC/
	IV604DVt93ZphBCO9qB09VR3LpexRjeoM9+VOjsacqz8S0oxOLon/S45iCTyKLUIExGm0oSjAI8
	bn4yfRSECmco/3JlrNrbPhdU8gQxC8v3evApUmr7xTD3tvQQHFpqOEubvb1R9LsgrBJBXHgdyex
	uaNZMhRJudxCfZgoyV2YMlewuJOaO14HH1Dpk6sCdDBbD9eOkyoDylqA==
X-Received: by 2002:a5d:4385:0:b0:43c:dc99:771b with SMTP id ffacd0b85a97d-43cdc9977a6mr2793035f8f.43.1774680481761;
        Fri, 27 Mar 2026 23:48:01 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43cf2580168sm3508425f8f.36.2026.03.27.23.48.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Mar 2026 23:48:01 -0700 (PDT)
Message-ID: <dfa17232-bc02-415f-8798-6617196d3160@blackwall.org>
Date: Sat, 28 Mar 2026 08:47:59 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v10 05/14] net: Slightly simplify
 net_mp_{open,close}_rxq
To: Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, kuba@kernel.org, davem@davemloft.net,
 pabeni@redhat.com, willemb@google.com, sdf@fomichev.me,
 john.fastabend@gmail.com, martin.lau@kernel.org, jordan@jrife.io,
 maciej.fijalkowski@intel.com, magnus.karlsson@intel.com, dw@davidwei.uk,
 toke@redhat.com, yangzhenze@bytedance.com, wangdongdong.6@bytedance.com
References: <20260327121049.334562-1-daniel@iogearbox.net>
 <20260327121049.334562-6-daniel@iogearbox.net>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260327121049.334562-6-daniel@iogearbox.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27/03/2026 14:10, Daniel Borkmann wrote:
> net_mp_open_rxq is currently not used in the tree as all callers are
> using __net_mp_open_rxq directly, and net_mp_close_rxq is only used
> once while all other locations use __net_mp_close_rxq.
> 
> Consolidate into a single API, netif_mp_{open,close}_rxq, using the
> netif_ prefix to indicate that the caller is responsible for locking.
> 
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Co-developed-by: David Wei <dw@davidwei.uk>
> Signed-off-by: David Wei <dw@davidwei.uk>
> ---
>   include/net/page_pool/memory_provider.h |  8 ++------
>   io_uring/zcrx.c                         |  9 ++++++---
>   net/core/devmem.c                       |  6 +++---
>   net/core/netdev_rx_queue.c              | 23 ++---------------------
>   4 files changed, 13 insertions(+), 33 deletions(-)
> 

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>

