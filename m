Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3D542CB1A
	for <bpf@vger.kernel.org>; Thu,  6 Aug 2026 09:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786007716; cv=none; b=OCpZiyjvCE/M4o3LPrP0YWD2wO2FfJC4iVeSDJK3/M7Kj+Vfq7/RD7RxzQhZgArP/ztFaucoY+FvZE+Ztfd+QIvFzieCw6QhqtrA3B8j/kpYUEOHDAf77Cp99/qHB3k2xA6fUA2+qmplKCHCNLF1yzdiPwL/rAfYry8eQ/Tg6bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786007716; c=relaxed/simple;
	bh=qzNuBPozfFIkdZOuS/fLxMETJ0Kd83A2UR9sybGyKyo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wq7Exr5M+tOqh2gMPO3RP8N9GMitvi0pVkvOf6Xd5FiSHFGtyh8t9i4038Q7dsaFl3Dj9T3XeEe8TrNKHW5w7avSH94D3EIayPtaNtImLGshKWPvtv7fYFTZB8gpaO/ds58ZUrK//iTuty2H6XRWR9M8pyJy2FiB+Cdi1nxl2Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HIgIczcV; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=POUHX7sE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HIgIczcV";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="POUHX7sE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786007713;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w1p/WqP5zNmyTteiVasVWjR72E6WFiVRU2GjHHBSa5c=;
	b=HIgIczcVznM/PvVO3WSanKAnsj07yqxutA+c0qD6W7KLAX8sbER67wo9jFQsXuofoJp0/B
	HSBivg8cl1+otxci0Ww/V/gbi+/7g4SukEv3JNqh5UMv90cICz6R9+Bvj6/5P+xXsCnIPy
	CE6BpTG9rTiqqWxmwEluDWBUS6gIoZM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-308-563qicg6MVeruNDT8ivqZA-1; Thu, 06 Aug 2026 05:15:12 -0400
X-MC-Unique: 563qicg6MVeruNDT8ivqZA-1
X-Mimecast-MFC-AGG-ID: 563qicg6MVeruNDT8ivqZA_1786007711
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-47f2de3ba47so1097754f8f.1
        for <bpf@vger.kernel.org>; Thu, 06 Aug 2026 02:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786007711; x=1786612511; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=w1p/WqP5zNmyTteiVasVWjR72E6WFiVRU2GjHHBSa5c=;
        b=POUHX7sEuNbTNG8im8YwWh7euPC20Hq7L+HtA5b9iqeez7oWztB9t3fOq8svtzfsyl
         frcIdw3D15BamK1Iy09v4fdRkzcztICglAqIb8kz+h9oH0zGX/tmVHVJtiM5o4teejqW
         wX7xCxWigFQdvvJ+cxZDb8WKifd2fp/Z4u7rfuqNWor/Rx9vFB+PXwkjYMd/WNDzwEc3
         0BLODXpha1A2mtbx++dvWCcd4qx0ine7Ax1js3XyVwFO/N2CXA4gWRbDHz+KrtpTxw37
         sjzlG8uajyJ76YS1QZXyCALvvKBXINbW8jr7qdHrJZNRxhZrF3QCGos5IKtx+Avd+P2s
         Txpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786007711; x=1786612511;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=w1p/WqP5zNmyTteiVasVWjR72E6WFiVRU2GjHHBSa5c=;
        b=gqanVd1DaFd4qbVGk9FjSc2P4JLCEIxr69sPgz4XLDfjc+KS5Vao0sKe7irM7audJn
         HC99Ku+Sy7ojf9FFN3yJGAYg4yxFgcj0npnCW7VWKDykVEeHwmXy+5WSwcYBDZ5SgZHC
         rkOv93HhqCU+Fks4j6JZ6sMy9Xq0LCogIp5lNDSrTZY5VJ1UySAMz+7K/Nv5lDeSzcIJ
         J9FEz1LvSKdpyUzHMRZ3WEnxXC8ldiGF1fAgxLstzIpPSOdBTS/UV6ymqK8Ww3cCQlYC
         OfaFLRQrMMictW0Htun2QyujrQZgRjFGMyIoXwg5Ykfa5DfEoQpDc2wu/5c2Amc9gkgT
         bbWg==
X-Gm-Message-State: AOJu0YwKGDKNze/hnX8XPsSyJvsm+k0kh/NFgaf0UB12yaL4H1hMsRyk
	tlMPqYz8rGeSNi5h/ZKbdYwo5LedNDmbdBoYun2bFMQYk2qpF+vtoa1flqyoBVcdC+Lx0FqmOlh
	olUE6QkyOJeIMNNvZtZLJruGIfaOK50sX0uWd2Tlv4lzPSNwRM5oB9sAXT+HeNg==
X-Gm-Gg: AR+sD10QLiNVKSqHBb0+LNk0f81sHgMAqt+UdT6YhMoGkXbV/yxMBBmaYCR62UVjOPZ
	lzzpIgIAXOFs01rMjjNhJaQeb3gZH2GKw01uzeNHK96Jt/OJKObVFUsv2ovwWStLAml9YD+sMMT
	e9iqY9MpFYUFlkvhL6NMoMHfYWk8X8teGhYCq6kjIg3QDdvN4hXPZRBC0q1jyozb6dh7GmB2f68
	Tqi7FoZyql+h3Jqeepb4oqbx4SU4fnGWJobiCTynvW8xYKEJd7oDyvejGZwWZyKTkC+Z5VSyg3h
	4Tm1eCAXSfQQfsXu8E7UYU5Vkf3kYcKKmUm1jkJ0Eq9fh6mX0oVmRrJdeAdtuOhdDHE0K0rhlGK
	N2nP0PExdYZ8xa8mwNYjWUJkij6mOmNUlk+V7eFBBoxbS7CtA67nOEJetRTs7e4tG+fPfcSRYst
	g=
X-Received: by 2002:a05:6000:29d5:b0:47f:90df:4ec6 with SMTP id ffacd0b85a97d-47fec4e761bmr17445726f8f.6.1786007710473;
        Thu, 06 Aug 2026 02:15:10 -0700 (PDT)
X-Received: by 2002:a05:6000:29d5:b0:47f:90df:4ec6 with SMTP id ffacd0b85a97d-47fec4e761bmr17445663f8f.6.1786007710038;
        Thu, 06 Aug 2026 02:15:10 -0700 (PDT)
Received: from [192.168.188.103] (ip239-44-231-195.pool-bba.aruba.it. [195.231.44.239])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47ff7b26879sm4650653f8f.30.2026.08.06.02.15.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2026 02:15:09 -0700 (PDT)
Message-ID: <1f36d5be-906a-4ba5-8679-24cbcf899254@redhat.com>
Date: Thu, 6 Aug 2026 11:15:08 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3] tcp: honor BPF_SOCK_OPS_RWND_INIT on the
 active connect path
To: Tejas Birajdar <tejasbirajdar@meta.com>,
 Eric Dumazet <edumazet@google.com>
Cc: bpf@vger.kernel.org, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 sashiko-reviews@lists.linux.dev
References: <20260730220055.2946171-1-tejasbirajdar@meta.com>
 <20260731220124.B0C621F00AC4@smtp.kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260731220124.B0C621F00AC4@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/1/26 12:01 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [Medium] The `SOCK_RCVBUF_LOCK` check executes before the BPF program runs and before `full_space` is inflated, silently defeating BPF-requested windows and bypassing dynamic `SO_RCVBUF` adjustments.
> --
> 
> --- Patch [1]: [PATCH net-next v3] tcp: honor BPF_SOCK_OPS_RWND_INIT on the active connect path ---
> commit 2cf5d1d17ae1c7488533ecaa0fcbb83ae4591ec8
> Author: Tejas Birajdar <tejasbirajdar@meta.com>
> 
> tcp: honor BPF_SOCK_OPS_RWND_INIT on the active connect path
> 
> This commit updates tcp_connect_init() to honor the initial TCP receive
> window requested by a BPF_SOCK_OPS_RWND_INIT program on the active connect
> path. It inflates full_space if the program returns a non-zero window,
> matching the listener path's behavior, and uses u64 arithmetic to prevent
> overflows.
> 
> Link: https://lore.kernel.org/netdev/20260723214208.3655474-1-tejasbirajdar@meta.com/
> Link: https://lore.kernel.org/netdev/20260722170033.2763794-1-tejasbirajdar@meta.com/
> 
>> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
>> index d7c1444b5e304..fcaa04e65189b 100644
>> --- a/net/ipv4/tcp_output.c
>> +++ b/net/ipv4/tcp_output.c
> 
> [ ... ]
> 
>> @@ -4137,10 +4138,13 @@ static void tcp_connect_init(struct sock *sk)
>>  		WRITE_ONCE(tp->window_clamp, tcp_full_space(sk));
>>  
>>  	rcv_wnd = tcp_rwnd_init_bpf(sk);
>> +	full_space = tcp_full_space(sk);
>>  	if (rcv_wnd == 0)
>>  		rcv_wnd = dst_metric(dst, RTAX_INITRWND);
>> +	else if (full_space < (u64)rcv_wnd * tp->advmss)
>> +		full_space = min_t(u64, (u64)rcv_wnd * tp->advmss, INT_MAX);
> 
> [Severity: Medium]
> This is a pre-existing issue, but does the SOCK_RCVBUF_LOCK check happening
> before the BPF program runs defeat the purpose of allowing BPF to adjust
> the receive window?
> 
> If an application sets SO_RCVBUF prior to connect(), SOCK_RCVBUF_LOCK is
> set. In tcp_connect_init(), this caps tp->window_clamp to the old
> tcp_full_space() before tcp_rwnd_init_bpf() is invoked.
> 
> When the BPF program returns a large requested window and full_space is
> inflated, tcp_select_initial_window() bounds space by
> min(window_clamp, space).
> 
> This caps it right back to the pre-BPF full_space and discards the BPF
> request.
> 
> Conversely, if the application did not set SO_RCVBUF but the BPF program
> adjusts it dynamically (which sets SOCK_RCVBUF_LOCK), 

I read the above alike: 'a badly written bpf program could be
ineffective'; not much relevant.

This version LGTM; Eric do you have some comments?

Thanks,

Paolo

