Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795427194;
	b=pp5zpC4RWZOeqdFqo/hnhuns/X4gmaCOMV/9GtsahXrWuXNMnNe84Lz1xA+v/IXuHX0/
	 bFNLtRjePwSuVMVc7ww+IopyJhctR3dC8andDUUt6ScVfd5Aq8f3scg+CXecPnVCbBXk2
	 dqlLViMbZER/hToHub9OHe/PrFCIbjtbUvD0CLocDidx2dmO4MOdvHp9t/tKHws69c61/
	 YE04lv/8RAdnjEyyS0tG7/AVhOyn77W0duXh5OJ+8nZeUMgKNiGeCDlVAEsr/IHQO5Edb
	 zp9282SiWwtZ10y9VEW1x8UxjUvgmrSg6g/37NRLS5vB0bhS8CcPYLLTQ0L2ua+JzLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795427194;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:To:
	 Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=eZEk4cOQr2FPxoxTzq089dU3C50eIos+X1Vfo3checo=;
	b=iJH8SS2zHOYCoAXVKFRFDhaIpyuohEHeFQYuBmGM7AlTlpfghqD6slle6h9iWrqwX+X5
	 Krflx9mm0E4p22e5GRkpzvZCBSLPMm1V8/d8kSv8LU80W/NXk4IrGec+ktrJZ4K6rP+Qg
	 BJqepKEs6tFOEwOn1OM/UPtySMFZNu/NfcIvU7rUD7pwjQeahZXyzYg/BuyBGf95JDN62
	 Dm7Qq+bPO4lhm1FOYaso/yYgo/PL7S7yVqeBenytA5SiZ0tbSD0RFXB7jXJzraNL3vdLw
	 pdMsCY22H6PabyqNFX3hmxTAmlUP5nWAlyltxmMgoNhh9jWRdr5Zkv0++oolSA02zsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=blackwall.org;
	spf=none smtp.mailfrom=blackwall.org;
	dkim=pass header.d=blackwall.org header.i=@blackwall.org header.a=rsa-sha256 header.s=google header.b="A/ifu4BV";
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3642A606A33C
	for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 09:46:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3642A606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.a=rsa-sha256 header.s=google header.b=A/ifu4BV
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4bb6c7b6dbdso27947115e9.0
        for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 01:46:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1795427192; x=1796031992; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=eZEk4cOQr2FPxoxTzq089dU3C50eIos+X1Vfo3checo=;
        b=A/ifu4BVrq3O89qvkUvzk1f9L4nihg4FyRXFGOwwPVfjEscRp2Bf7hR4kjhux28dF5
         5GwP1/mzMeOCJ/KKn4f5LfS9Dhr/kWLL1/xUCCstTyZIMQWhzUAABspTFsxVdbbfy57o
         8gA8/wtBUiaIhx82SqhhAinJ2rr3b1IMEenJXhijV02aR3kM1NJ5hiaDtVlR+WdQwhtx
         G4+LW2+Xm/YGpsQ7kjw/+MG4VbgEX+dWJquFYll4oLgeaXsI99IvQAKV/gwbgbd+o2wM
         YQh0Z1mRWhWTzIGiSz4U7rQMmyZE/D9Yjj/zyOlsN7A7vtJTm0yeB3TmZQLGhAP8oRHo
         gzUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795427192; x=1796031992;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eZEk4cOQr2FPxoxTzq089dU3C50eIos+X1Vfo3checo=;
        b=GAaAtAWvJl2Fei9YNjGJSiYdGltrWaTVnFt6Kk6J0cdu9r3c9SfvL1QtWiwJRThu+b
         f2d+Q6uqUAcHXJo6GqfQGkqW41DsD+O2pqEihwJeoAWPOMUPtjRe7vq7XUc/aCoRIfJJ
         gidgNQc7dSuCwEoepwkIy5bR9P/9OZxegczuuJp/BFKU1px56VQby1HHA1CLc8XMVJu0
         htq0GwoUrzp/IPzELV6Wb4aW7eh3cMGh3J1vCRUI/gOVNWz351oHhjXvnGhgbzHnILKO
         P5W9dABFnsM/jzHmIemwok39CLtXJ983yfgIc35blPCP8+ngdCdh+z3G8/QcGHBdxyW6
         +xsw==
X-Forwarded-Encrypted: i=1; AL+hErHIow1j6WdcjRS2gEyf3VpyideeTpVbcDEYlEGcKuWomYB+fGiwyQk9s17XCVPeFiBBjXQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z/os8v8M5ycVIICn3IpoU6uOxpNvJkM83fUFJT649dsPD4tOSFO
	sjc70muC7SgXud0TR3wueszS7ceRjIwv9vV46TRe6WxFKFSMzM+Kz0+0s7ua35wG1wY=
X-Gm-Gg: AZFdTZeB1f1pu0LHhGs7fbEKY22wKEL4NPWaZKThiWqow592fUk0sokD0BMLBCo7Vi0
	39GrUVV/GpKWciMb2ofF6ZgBXw6y6PfaR13c4pTQtRZlKHemTBtswaqYcAt+TYK4Xv1JgP9v8Jj
	mWkbrSZyc2Fnrbf7IN+XhRH1Al7+d+1B1+OBQFH2SO8fHFtTa7cUbuOGUV1f6pBO06gFpgb2157
	kb1eBcJFDVDaiV/cnYu0SALnbJ36IrC19u7EN+9TE6MYc43hH4tVTD/23QlRPjyt/Wz4qn6VqG1
	3FIp9UVNbAQ/lCFEseehymfli9dCGSNO7Luakdr4/aF80tqqMn7fwReP1vhLEQm5U2fVit8HtB5
	EZtVoQ3KqFyWorALGWDQ2NA7rmIG0SHnw6GSAvIfLD2QqdRE/BMjpXwtx1TQhnBb2flX0dUAgrE
	NoFbUAbt1OfZqLI0Zkal9tmhCMlLJebgxpZQtkAdVBRCVWUlSHNt3zYkyHDP3aAvVRUsIWijGxt
	Y5PN6fRNzFIjuX2gsbC8rhLJxlX/sYYJbpZHBkP4kLHrNoWMgauLG3IsDESWJOhzGpAJeBV8AiQ
	Xou9qL9BBeR8zMa/RhHErSn+Tckh+3Oql+yt3YEXAPlecDqkK0K93dZKuJo=
X-Received: by 2002:a05:600d:82c5:b0:4a3:5aee:2c25 with SMTP id 5b1f17b1804b1-4bb88822642mr254981035e9.31.1795427192587;
        Mon, 23 Nov 2026 01:46:32 -0800 (PST)
Received: from [192.168.0.161] (78-154-14-127.ip.btc-net.bg. [78.154.14.127])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4abbd84e661sm19669233f8f.18.2026.11.23.01.46.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2026 01:46:32 -0800 (PST)
Message-ID: <114c2bff-6d09-4b0b-8f7a-df0f45832f6f@blackwall.org>
Date: Mon, 23 Nov 2026 11:46:31 +0200
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
Subject: Re: [PATCH bpf 1/2] bpf, net: validate assigned socket on receive
Content-Language: en-US, bg
To: Jiayuan Chen <jiayuan.chen@linux.dev>, bpf@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Kuniyuki Iwashima <kuniyu@google.com>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Martin KaFai Lau <kafai@fb.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org
References: <20261123084138.723275-1-razor@blackwall.org>
 <20261123084138.723275-2-razor@blackwall.org>
 <3c96d878-0326-43c2-9869-e941cae675f4@linux.dev>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <3c96d878-0326-43c2-9869-e941cae675f4@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23/11/2026 11:41, Jiayuan Chen wrote:
> 
> 
> On 11/23/26 4:41 PM, Nikolay Aleksandrov wrote:
>> bpf_sk_assign accepts any hashed socket and the rx path uses it without
>> checking against the packet which can also be rewritten after the
>> assignment. A TCP socket can then reach UDP receive, AF_INET socket
>> IPv6 receive, a v6only AF_INET6 socket IPv4 receive etc. A queued skb can
>> also be delivered in another netns than the one checked at assignment, e.g.
>> after an rx_handler forwards it to an upper device there.
>>
>> Check the socket where it is consumed: inet_steal_sock and
>> inet6_steal_sock take the protocol of the caller and drop a prefetched
>> socket on a mismatch. Like bpf_sk_lookup_assign, IPv4 also rejects v6only
>> sockets which tcp_v6_conn_request would otherwise accept through
>> tcp_v4_conn_request. A syncookie request socket left on the skb is released
>> as well.
> 
> 
> Some old discussion is here:
> https://lore.kernel.org/netdev/20260403015851.148209-1-jiayuan.chen@linux.dev/
> https://lore.kernel.org/netdev/20260608125846.157004-1-jiayuan.chen@linux.dev/
> 
> But the situation will change as time goes on. Hope the issue can be fixed.
> 

Ah! Thanks a lot for the pointers, I see. I can just document this as a pre-existing
problem in my patch-set and leave it for the time being, I don't see how it can be
hit by accident, someone has to be malicious to do it and I think Alexei has a good
point that there will always be a way to crash the kernel.

Sorry for the noise.

Thanks,
  Nik

