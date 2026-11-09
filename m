Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794261499;
	b=c5APUl3kh78nhrwiI3w0KbEGFu8qPOvX/Qo0o4zAlr6mP920AX5cLbsyi0zzM3OXWtUA
	 9IZyyazJdFiGN7puZXD4n4zlk7K3/214GcYP6uQWWTKu7YEBLc15TSyI1YuP8XoAozso8
	 CDv3+uoRgzl5x0+R6OJJMoKzhhxwfoXTm/6R7TS3e2F3w1fGKe8m2hqdoepMi3Oa5nANu
	 FKUCbknl9F5Xp2lJV2EPQqycSecWGVhFmYXwa4nmThiEp1rB3TWg1MPNYbAYHfSdLGiso
	 9444YcfdgLhJ1nB8RUws1Ru/Ynnfets+Dmwf51BMpkpP9f03S5jPtr/TSdCKaK4Ms+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794261499;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=q03BRgBOcQNLCRjgQwIL6L5lX3ohT8w/lgFYZ6hcCWg=;
	b=jtWMazzdeOzFqRomRHYUdwrrlmfZHoAv/teQMvhUEYNQJkAMlxY1FeJVU5Yaa3OB0Zm9
	 6KN8GaEbIjp/xnQiQTcqTH34TL2+I7IstNbDg53me5KVq5Wwx4RzZwpq+G1rbP+o3Ts3o
	 JaHMq4lIuxpp83lItNzdQiuQfveovSH613De5SEABT9ole+yICl0H3ixQdgyACipNY0QJ
	 ej9MBuo8QvmnIjVYIYCSOESUy0WOmT8oSQCXQmt1Ael4t1J1D+bN9KL4zhQ5nOW3SF66+
	 NPzPFO2GBQ60tnfLtmantXvo8qGWn2Vef75KXCbaX5Dd9J5s1CprkeV6jcFEmTLbGqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zYO9x1Mb;
	arc=none smtp.remote-ip=209.85.218.42
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF340606A325
	for <bpf@vger.kernel.org>; Mon,  9 Nov 2026 21:58:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DF340606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zYO9x1Mb
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c4ced671398so176250066b.3
        for <bpf@vger.kernel.org>; Mon, 09 Nov 2026 13:58:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794261497; x=1794866297; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=q03BRgBOcQNLCRjgQwIL6L5lX3ohT8w/lgFYZ6hcCWg=;
        b=zYO9x1MbNwJ+vVirkbtAQ6GaGoIyfE3bXBdqwm8xZu7VLwvhFj56va0o++rdqRLDXj
         cX66Kt9oSCJSpPoic6oQcGqR90HFFOxD/LZDxfImAPBjX8+96UIQvHzxHYTcIYq3pSn8
         LeGbjCvPRg0P96wlmQyrNk2DlMCC6cpXszeBXUmTCJyxQFuWMC4L2xIu2LZqJqepnUCz
         fUSxPTQaKY9zrJpgs/A4ddA4wfQQfo8q4VgRxWqnISyokRQ7EooIkZaVRF1dd3pY47B+
         aRuCilGOQNLoZlBPm/N6cn25j/fuxjlXwPF+ma6WsWRx+ocCE6JRIri+aWgVv/urFg9C
         e33Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794261497; x=1794866297;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=q03BRgBOcQNLCRjgQwIL6L5lX3ohT8w/lgFYZ6hcCWg=;
        b=0kRe8DPI/kMwOd3NM7joilppuI6+w9naucdt6eKG5SGOtUrN4XxL1P2t1EWtjD/NP3
         6dFroaEMVrFpgAPgp2Doeh6O3DZZw3kXf/eqiX2tUlwh9HjbFS1p5ZCujOdMxx+qaZbJ
         leuH+ChsbWgnvZnHPz8zP1rUXcC12MkNBBBRMU+O4kGPB5Tm8Q9+1Zxq2sba4HZ2hGuG
         1YUdVLRxtc0Yt4LNylyq6UaBUI1//l97Qy7LONvbZ0vMdhVliaP1G9iS7QE/bqtKYoUn
         NkFqHNsZ6ejQxTNoC2gdOTmmO+pyvUpaF/PiRhqBGCm14QD+ovF1D3tomPS0b4rgIk1U
         D79A==
X-Forwarded-Encrypted: i=1; AL+hErHl+At4pQbQGgoblZtczToCzuJc8H8sMRLEOoiAo6svj9e+0VeFLqtPG1jlgOF3l0iOtNs=@vger.kernel.org
X-Gm-Message-State: APuU4Z/o9do6AiqSd39vtBjFK8zLThRtdfar7lG92Eib16pH/H0OLyXy
	OARE/9SPBZvkmaNQhU72xf00yPhi5zHf7hlrU2jjaea4PYy7XjDWEX8y
X-Gm-Gg: AYBFou1Z8i9hExti/V4EhtJU07WxxvESmERA85oFhs2YqcRn7mmOOy7RDY2eTGlidUH
	mBCZKLHhNNGC+c6UgenuoCdgqisUzv+dhzcbyCKgYQ1Gy5n/pEpi03BNskC4B1O+RFP4cbyvVAo
	2gQ0bHCFiuXacjl8FcG18M/wL23j/x+vLnvtpTbgq96Zo95Jwkt9/PVcB4ZT0rgD4q6wK5O1cvb
	q1X1juOQeMf+pmPlG41qMf0bDv8Sn+UIl7ywLyLzFm07nJS4xC+/YMHmysq9e9YZJnI2EugeSHQ
	bLUC6uzpBEZuG4BTFO6hZ25FH+O52xgPxlv1UvBvhNlTdP/eCPufkm/30T5g6Z14cdtq/ewqCk+
	Oz69h4OCW9SfsNElItwazdLvh8RgdnrCNAWKjlcB0Mr1vvHnVSvMuo9TAdo0XYNsvW70XZVZv8v
	iUtVYLHByoo3GdMNYNG3OAA2xw29CnrRCA3msTh/xgg3Ws72ugBUKAt8UID33IS8e9JHFI1S6kI
	NRHCGfcsRrHjaEbfndaX6MAoWsgjkBWMSrA/l0m0Rm8DfStkHy3V6UwYp206bnrNM10Nw3fLyEm
	V/mZS4XJR6rCx1ZEC+s4SFDp1JrJjsdwhqc/CNV8a90Olu0/3nJy/cD39XGg5J26YaeBKgd6L1a
	eTLcwIQ==
X-Received: by 2002:a17:907:1905:b0:c45:b99:f282 with SMTP id a640c23a62f3a-c50491c3b10mr53885866b.7.1794261497276;
        Mon, 09 Nov 2026 13:58:17 -0800 (PST)
Received: from ?IPV6:2a02:a03f:a75e:9a00:b7ed:a37a:5b51:f302? ([2a02:a03f:a75e:9a00:b7ed:a37a:5b51:f302])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c504a685f99sm20298666b.82.2026.11.09.13.58.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2026 13:58:17 -0800 (PST)
Message-ID: <1c0bd741-0e5d-428e-ac89-3907d62c4eb9@gmail.com>
Date: Mon, 9 Nov 2026 22:58:14 +0100
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
Subject: Re: [PATCH net-next] net: lwtunnel: use GFP_KERNEL in build_state
 paths
To: Max Boone <mboone@akamai.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 Andrea Mayer <andrea.mayer@uniroma2.it>
Cc: Donald Sharp <sharpd@nvidia.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 Debabrata Banerjee <dbanerje@akamai.com>, Nick Hudson <nhudson@akamai.com>
References: <20261106-build-state-use-gfp-kernel-v1-1-18084382f878@akamai.com>
Content-Language: en-US
From: Justin Iurman <justin.iurman@gmail.com>
In-Reply-To: <20261106-build-state-use-gfp-kernel-v1-1-18084382f878@akamai.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/6/26 12:40, Max Boone wrote:
> Since 3d25eabbbf67 ("ip_tunnel: Add dst_cache support in lwtunnel_state
> of ip tunnel"), build_state runs outside RCU and all its callers can
> sleep, but paths still use GFP_ATOMIC.
> 
> For dst caches, that limits allocation to populated percpu pages. A
> large burst of SRv6 nexthops outruns the refill worker and will fail
> with -ENOMEM despite there being free memory:
> 
>    percpu: allocation failed, size=40 align=8 atomic=1, atomic alloc
> failed, no space left
> 
> Batching 20000 RTM_NEWNEXTHOP under QEMU gave 10-109 failures per run
> before, none after.
> 
> This commit converts the allocations reached through ops->build_state()
> and are called after the rcu_read_unlock():
> 
>    - ila_build_state(), ioam6_build_state(), rpl_build_state(),
>      seg6_build_state(): build_state ops
>    - bpf_parse_prog(): only called from bpf_build_state()
>    - lwtunnel_state_alloc(): only called from build_state ops (also
>      affects mpls, ip/ip6 tunnel, xfrmi and seg6_local)
> 
> Signed-off-by: Max Boone <mboone@akamai.com>
> Reviewed-by: Debabrata Banerjee <dbanerje@akamai.com>
> Reviewed-by: Nick Hudson <nhudson@akamai.com>

Reviewed-by: Justin Iurman <justin.iurman@gmail.com>
