Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795426863;
	b=mBPW1AlIGlisQQr+VWm+KMLsnEQY4VdUazXkV4r73inXR90t0x/RQIYjSYPVgXTuOiR1
	 ZEvdp/lLXjq1sVlTVflO/DlIIgJx79+1nP9y0vR8wPLkIYUBYG3bsTy6iTqgAiaO3SlFV
	 qRPuhn6n0CdS6t6aBLwa56ZCqweQSgNaGjN9od9Vx206/eBt46gTgML5ELheZYIA0A8/K
	 xE/Olddx9zjMTykpkQcNIax/htUmJObI3pTFgB0TdmG/HWNO/WkHfASYBBmn6cQj1NOe1
	 wKI7wS9c6Cn/lxuQ9cHyVsYGe/k/q+Qa0MODkyzHv5KJApoUr+PkvUpDx2fQZnP/Xlg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795426863;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:Content-Language:To:Cc:References:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=QVGOvGqgP3IqKLf2mJCZsL1j4ZVbv+zPgvIcG957g+Y=;
	b=yEME+CmRww8dMut3gIZ77yL5gOCr80CLujXjhUQIjGEUimgesk2SSZw98+zRM2nkIGUi
	 2FY5bpQuM+JUFLJEQRAl7wrQgFaDTU6re+fQS7GcLZR2RxQ0CISM92dhi2JK3VOvIhmML
	 wMDSasTPTAcuhh8Ix59zAnWW7ORZhb1FFnCLZX0D9+V3LpmF2KCV0fjuxLMWPwqEhPLDA
	 6dhIItr6DroV/D2Xr24YrD158WLjAUT+8RFwhTlxDj57gKlAx0JTFZFDjZ0wQxIuYFDoJ
	 PScHseyEHjW4EhvsRcnYfnJoCriR/AYA4rlgPuHAzNez/GiLVm/jHbFkyO1gabMdsOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=blackwall.org;
	spf=none smtp.mailfrom=blackwall.org;
	dkim=pass header.d=blackwall.org header.i=@blackwall.org header.a=rsa-sha256 header.s=google header.b=PU6niAqs;
	arc=none smtp.remote-ip=209.85.221.50
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA67606A327
	for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 09:41:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DDA67606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.a=rsa-sha256 header.s=google header.b=PU6niAqs
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-4a7b8abe209so2316819f8f.0
        for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 01:41:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1795426860; x=1796031660; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QVGOvGqgP3IqKLf2mJCZsL1j4ZVbv+zPgvIcG957g+Y=;
        b=PU6niAqsIUvfaWjY/71t6CCcBFF7/W01kwVAvtvkTQKM/0Yn80oh/fgIJav7KH/XZw
         SZUJk92uBcDFCe8mdyG8R4ZhJ/P2x6FOliPvNQYrcOx9dtX7pNE5hwJWYvslYUz80O4d
         4ACwLaEXUgT4KKXZVXpnOV2c9kRezA7kIGPdMQM+A/+UE5qyObBnCyBAENN+ZJtDIAwV
         7VkYpQU2qitiLpsU9HKFD+i352qCrr9UuuBYf3Q/HoQPRe/P+QMplGt0jkZgKP64PUva
         iXqTyd1ZMGbBtKbXB2/K+auE6jLPeTYk6oGbmtgDRB0YiGOit28UQKrQmZucgHYuPTGu
         C4AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795426860; x=1796031660;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QVGOvGqgP3IqKLf2mJCZsL1j4ZVbv+zPgvIcG957g+Y=;
        b=RcRk6Sj0g10HPFkiVfEpFn6Oede+5LgnTSdBuKLLc/vZkq0Ru1iDnTdsUbqsplvoFq
         v2tsHbwwhTrrbEgsFmTrZ2DypZ0H1+nudt4fst67T2yYdEQHMExSRQC/qUfvIxh19R4O
         ak1UfWULkrooU7YExDxtoDbWc2/HLEVA0+G59Exq8VBO1e00JgmzE3QQN2i+j76qYwEd
         RQPRWGhzF+RLZUBmPCaf/9ViVjeFcmZrn5zHUe0ra8OKUKAPYKJSb28BthphRmBqe4eG
         b0p5r0YqdUrCmBz6LYwMmVl1VFBwTckhMlYfeBJL3WVaPTfNey+avCEN6NPDGy8SVr3B
         fU4Q==
X-Gm-Message-State: APuU4Z+gkJPLDmfT9o8Dpd+FHVH3bRZsZU5DuK6r0uhNoLVC1jFsiB2p
	gPcOPO8GIEjK8fXrLMf0edJbXLVPXWExENjVsQjuF8kkRADwadil09zShGWFUGkW8wfNLGCdzgV
	yiG5Q91jzmyeF
X-Gm-Gg: AZFdTZf6xR3EqwhGyzjQKzkTsjRnIrryTVWcDziwChJi24+NDxqosL/zieNZlhUU66b
	arPGBr5uzXChF5l1G6syAa2BsROwbXk/LX+ESZSpurizaUqxhLayYSthrHbZ0X+jvVIsNBhbtyM
	ElqYnr5Y9TrzVVJah3UA3J7O3pJnj9TMdDF0PcHVtAvjzjgeY/0uok/IVQagCQO+SStNMHFRCuL
	IemwdakTnwXbvsN4jM48yqwcBDeww30/ub/BH5wiO7GcIC/pQ/7nKEsgj13+85YSUagQtw5XYSw
	pwhkWC/DWif5QCWw8WM3OxsQs9xM5LIpX1hG84YKKlsP3iYb5tFjVqQqfGddCnMWUEO/KNTVwmS
	7HlwlQYTMsBNVtaAflv/Ycr1MJYbC5NYxyyMRNe0hs0RlnGJMhXl41kmAHyufWX/9tKFFYXtTYE
	UbYb4zOXCGvp302yvAgkYGzJpuSyLHBYWIr2yzuvsRq778Zl4fmVwiCRYIIcgKHAu3xyvD4aPLW
	R248umsbynvLe3bqPTUl4+ge4od+QqcgekkJkZQN4hV2alw1Ue4mXN4tNyW/6I5O5yRZuK3cSoG
	dJ7MIWkmMbozjgeRV8HDGBLdBxh18zOHPWmaNlhZk2Y4V1rWjcHTFCz1IwoN
X-Received: by 2002:a05:6000:481c:b0:4a5:ebcc:2260 with SMTP id ffacd0b85a97d-4abb2dda518mr20901962f8f.29.1795426860310;
        Mon, 23 Nov 2026 01:41:00 -0800 (PST)
Received: from [192.168.0.161] (78-154-14-127.ip.btc-net.bg. [78.154.14.127])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6b205443sm21919575f8f.39.2026.11.23.01.40.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2026 01:40:59 -0800 (PST)
Message-ID: <e3ca53b3-2b57-4927-b93a-91c8458f7ccb@blackwall.org>
Date: Mon, 23 Nov 2026 11:40:58 +0200
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf 0/2] bpf, net: fix assigned socket mismatches
Content-Language: en-US, bg
To: bpf@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Kuniyuki Iwashima <kuniyu@google.com>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Martin KaFai Lau <kafai@fb.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org
References: <20261123084138.723275-1-razor@blackwall.org>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20261123084138.723275-1-razor@blackwall.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23/11/2026 10:41, Nikolay Aleksandrov wrote:
> Hi,
> Patch 01 fixes various mismatches (protocol, netns etc) that can happen
> with assigned sockets which can lead to different corruptions. Patch 02
> exercises such mismatches for IPv4 and IPv6. For more information please
> check the commit messages. The problem was found during LLM review of
> the sk assign egress patch-set.
> 
> Cheers,
>   Nik
> 
> CC: David S. Miller <davem@davemloft.net>
> CC: Eric Dumazet <edumazet@kernel.org>
> CC: Jakub Kicinski <kuba@kernel.org>
> CC: Paolo Abeni <pabeni@redhat.com>
> CC: Simon Horman <horms@kernel.org>
> CC: Kuniyuki Iwashima <kuniyu@google.com>
> CC: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> CC: Martin KaFai Lau <kafai@fb.com>
> CC: Alexei Starovoitov <ast@kernel.org>
> CC: Daniel Borkmann <daniel@iogearbox.net>
> CC: John Fastabend <john.fastabend@gmail.com>
> CC: netdev@vger.kernel.org
> 
> Nikolay Aleksandrov (2):
>    bpf, net: validate assigned socket on receive
>    selftests/bpf: Test assigning a TCP listener to a UDP datagram
> 
>   include/net/inet6_hashtables.h                | 33 ++++++++++++-----
>   include/net/inet_hashtables.h                 | 34 +++++++++++++-----
>   include/net/inet_sock.h                       |  2 ++
>   net/ipv4/inet_hashtables.c                    | 13 +++++++
>   net/ipv4/udp.c                                |  2 +-
>   net/ipv6/udp.c                                |  2 +-
>   .../selftests/bpf/prog_tests/sk_assign.c      | 36 +++++++++++++++++++
>   .../selftests/bpf/progs/test_sk_assign.c      |  2 +-
>   8 files changed, 105 insertions(+), 19 deletions(-)
> 

Sashiko found a few more mismatch cases that can happen, I will address them
in v2.

Thanks,
  Nik

---
pw-bot: cr
