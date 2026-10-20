Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792505148;
	b=T+CsUHEHs0+fb5d2iH5RuhCDfbd5w+P+kbda7l943wCLOqTPIT4kVljIFTV3tgLKsmhu
	 1t7dDN58vXVpqfDPD7IaxPZ7skD3xRrJMS4psOGjbnA1WicR292bQFnWCqcbokKpPFcWl
	 3khpWvx4iFTYL/5uRo79ORqnTNYXBWVoE2DpYEvmg3Ef+JLRfnejuD6qzV5ageqIe3M8j
	 mQEUqG/gubQwODQR0uYbW6hOXTKbYXz5enlhT3eLUsSMW6Zc/bn+BBMm4mBLpYLYJFSaX
	 Ct7j2WqiRZCDkr0EAzg2SFqT2e4H6PtGKUqcJ2jTgrCPuXVaSxVKsJ9vNzhuGZB8sEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792505148;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=9ykT13PSVdEhkpSDogty+KQ6PO4mrXSOM4DldWxwlI4=;
	b=Gw1eu7ZQYf3YTAXfhUBNyrUwasTXd3dP7pGjMPGrUxSxl5ctHondA4oU+SgSOLH+1XJV
	 9JztlffKG0rXU/cVHBI5DZrdFn12ft4TJV0FgZH3prB1DDcUb5xvRH85VDwNndKdZbtdS
	 Nt/jEyaTjUrGIAeexmSXW1cpf7gRZ6/8Rx2xhFg1SYtZsAc2SnmX0wFcgHLv3cO0cWbN8
	 agp2RJGZ4+ip1f3RIgh0+AGAg7bZQHEWqLCIaw2jhUYkIsGPbDxvsrM7H3VRhILrWiGHJ
	 uWgx55xneLrkvNEleAyYrmR2tTs1iHNlViXWMEN2csqeBd5Gb3DSVqtyd2lpTTCQxbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Nt3i5266;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=BVuZOrII;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D48606A31B
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 14:05:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 77D48606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Nt3i5266;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=BVuZOrII
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792505146;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9ykT13PSVdEhkpSDogty+KQ6PO4mrXSOM4DldWxwlI4=;
	b=Nt3i5266bYeuVgqKkSRC0hAc8PiaObZbifV92h75U+uebHzPRgBkHDjvvGnPVdGZUGTbkC
	B2pRS/AbJgBjxsDfbZjzIZYLs1SpcDXwHUDGd8i/XbddCTuM7PmcsL5/wnvo4pbThi3x2y
	W8Px53qxTnh6NsQZCIAboO7jqhx+1NU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-260-2I4SIGUXNCu5r8AF_NdGCg-1; Tue, 20 Oct 2026 14:05:44 +0000
X-MC-Unique: 2I4SIGUXNCu5r8AF_NdGCg-1
X-Mimecast-MFC-AGG-ID: 2I4SIGUXNCu5r8AF_NdGCg_1792505143
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4a1f03f2e8aso12584565e9.1
        for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 07:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792505143; x=1793109943; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9ykT13PSVdEhkpSDogty+KQ6PO4mrXSOM4DldWxwlI4=;
        b=BVuZOrIIRZeNQ7/dQ54GjubARN7Ii/zM6ccftk6Numa1K1g6WTAo2y6KApvG1+TA+b
         VhM6V+oduSJOVU3pQR5H11182ZJL2rPOGYmVpySDisop50RXbEJsCHiNPpmQ1SroM5Y/
         mpCwq+y8luRBaJ5FSwRoHQp8jqg9BUEgWiFAl8l0WRKdpzKALRRP3CMHsWatOHJU2aXm
         inV6qDJwsbNK0pFpnFblyXeiBvUpIknGMLOp9DpWZq7qsG165txoBQnfx4pNgFygcrr4
         Hh+8sedn03eXfvIc56XssmAttSBjVd7lz7fddPOyn2223/Ep8xbANcj5l7vdLbKquic7
         FqXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792505143; x=1793109943;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9ykT13PSVdEhkpSDogty+KQ6PO4mrXSOM4DldWxwlI4=;
        b=idhsc/X871kgEufavs1A2eA9yW/Otj564L5k3uulQzLeluygCby0gVBeMaWQ4WYyt4
         9iFVhr3fUsA+NIpKsvCDuYOj36G9ZtPnTyoUtdgwHEKAj9hhlWcjArI/i/qmDrIPvikY
         kxem3WurO5OmjzekEtCwgmYfbIOfV2+9PwhDrHgTMFlMctzEI+E2y8r8XrHeU1Y62w/v
         53EEOsAz/mvlJQT9oMM0TxDxKd9D8cA0rxaT5NDWfcPNHcCZX1ox9pixblNuHjRhFev/
         UTVvj+zDxFNQNi/qlFUqDRyZVpt53LT8YYTRUl/JBwU2wm+T2aDc5sp+22KG5pcGE9OQ
         25jg==
X-Forwarded-Encrypted: i=1; AKwUvBy5ul6MxR/1I11aBXMU2C4C3cK6/7MsDIeCd4988OyZfU9G3a3CiydaR5RzJHBlMrbSCq0=@vger.kernel.org
X-Gm-Message-State: AFq9FYLef1jfXnbiv1Ea1o7jeUowSFY0TLC6eMu7kRTdrO1KublTUKjv
	y6a+riu1gAP8WupYK/Q/I1DRc5oBusFUOtY5not1UA0UCRndHs86aeELNemaV5pcP51Q4w2J51E
	I4THnHInyw3N6VfZv/XYdpemFlpWGRi3gJfuHpuX0wkNY90WG66G84g==
X-Gm-Gg: AYBFou0hVoRMOGQb7poTTWK1bITLd2XcBCmqSBoOzHjU0tWjl3sFZT0/julPaE0Kary
	WDFck/NA5TsA+NRy7dcc2GO9+KVs79139LEMT+Js4oJZWEqcxfpX3A2Kc89+OA+xQZhrqjE1cPL
	GOE/bDUUJChTMzZNMUT42XedG0h2cSV3QkwlrEVtXJzw1+8xtNowhA4FCIrlban8/mJyj4WPeAO
	tpDtXUsBCGxNJjb91QaR0nwFAn1WYnfh/ln6h37cghWUCbdezv+Psr6X9FO0HsuMXEIvMW65/F2
	Qr5CwroUIpZmaYGxe7f2TdetMtV3US2EYn74XKiWmgGytOZ0G8DhCL+JifU0iGubB9II5n9PSKs
	M+HVFRLlAJzMECCBkGnATwQuwriYrGt/0Y83WZEwKKv3CG8H81W5YriEr1rhF3FrqR0RioET33w
	==
X-Received: by 2002:a05:600c:3f0e:b0:4a1:fa33:441a with SMTP id 5b1f17b1804b1-4a1fa33452cmr18514575e9.2.1792505142705;
        Tue, 20 Oct 2026 07:05:42 -0700 (PDT)
X-Received: by 2002:a05:600c:3f0e:b0:4a1:fa33:441a with SMTP id 5b1f17b1804b1-4a1fa33452cmr18513575e9.2.1792505142147;
        Tue, 20 Oct 2026 07:05:42 -0700 (PDT)
Received: from [192.168.188.234] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1f2d43242sm69875765e9.9.2026.10.20.07.05.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Oct 2026 07:05:41 -0700 (PDT)
Message-ID: <7ceef2dc-717c-44f5-9974-1ed8f0440fa3@redhat.com>
Date: Tue, 20 Oct 2026 16:05:39 +0200
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
Subject: Re: [PATCH net-next v3 0/7] ipv4,ipv6: convert the getsockopt
 switches to sockopt_t
To: Ido Schimmel <idosch@nvidia.com>, Breno Leitao <leitao@debian.org>
Cc: David Ahern <dsahern@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Shuah Khan <shuah@kernel.org>,
 Eric Dumazet <edumazet@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, david.laight.linux@gmail.com,
 kernel-team@meta.com
References: <20261015-sockopt_expand_out_v2-v3-0-7d05ef2df448@debian.org>
 <20261019081907.GA2725184@shredder>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20261019081907.GA2725184@shredder>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/19/26 10:19, Ido Schimmel wrote:
> On Thu, Oct 15, 2026 at 03:05:29AM -0700, Breno Leitao wrote:
>> This series continues the migration to sockopt_t, as described in [1].
>> do_ip_getsockopt() and do_ipv6_getsockopt() still take a sockptr_t pair,
>> and everything they forward to now takes a sockopt_t, so convert them
>> both.
> 
> Acked-by: Ido Schimmel <idosch@nvidia.com>
> 
> Given the user visible changes, the fact that the merge window is now
> open and that this isn't the last part of the conversion, my preference
> would be for this to be re-posted after the merge window.

I agree on the above, also clashiko noted that patch 7 lacks an additional

CONFIG_IP_MULTICAST=y

/P

