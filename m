Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E2440F8D8
	for <bpf@vger.kernel.org>; Thu, 26 Feb 2026 15:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772120176; cv=none; b=Rz2Kwz2ug8vxli0YlsuX8WBun7yO0qpbrpbRtS6MGyzZdG/tsQXvBGW3uNBHCZYU1QCAfwgRvn9f7Nkikf+WiTPhCEyq6B5MO0/91ucNA7ajactJu80ItQANyIWP1c6+FJTiHDqHEEeUprhqpZtrYW2be306101J+pVtPZG08Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772120176; c=relaxed/simple;
	bh=nxzCbi2MzfPt3kaMaWM/lwHZ/NWVoOrFC/qoGTjHLuU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lnF1ws8j8vdCGFBqHcsJnqnavy3zH0GV8eFS+ulN0hB17YERd3yWLR1ddHLwJ1Gw9sJTkSfeSZ2oBiqdEfkqkxkCLRFCe7RNicaNhPblRAV6UzRfP2PG+6bUNqhf2rVH83n3jMBSgG3L0gFc6i0EQ0R0/5bmnHdMxMukcOZSkZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LnawsyIK; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LnawsyIK"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7d4c9537f90so665651a34.0
        for <bpf@vger.kernel.org>; Thu, 26 Feb 2026 07:36:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772120174; x=1772724974; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y1Q27Vo37l5jke2x5kYEj3BGxv95cJSIbkx6Yir20Fc=;
        b=LnawsyIKgiuWD7bm7bj0iRAol5a7ur9FiOxJ4igx/cC7vgtcq0vKGaZF/hU8SmNYOt
         L43+MPVeCmxsc41bFlaEih6Y/V+SxC+SpiUaDO6RzESSZF0a5hjub1EDxLNxZd4sOR4/
         IldXn9hoR8q2RVF4LEkuvJJKlmCOMmE4Xob/wic19PFc67ianNHAQloigxSwrg78XJMq
         e26gvwQdyEjEo5SFVYGMxHhwUQ34/sZGYyyByD7rhv+RfL7dg68JIld0sTJ2kFRFUDnw
         NWLLQFn3zd3hNmBP0MeGlInvAXCvQIRjKop6tsk1yp0AkyFo2+h//iSVVNJV9Iw3GxUT
         J3zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772120174; x=1772724974;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y1Q27Vo37l5jke2x5kYEj3BGxv95cJSIbkx6Yir20Fc=;
        b=F70RlGBbGo9hBbXNGY44XRzQQITM4gYhzNclX7MglcR98hmbeMvxWEzceQlNOAf7is
         jp6xx3yYbyK7/So3a3CTl3fmJTUpGwiniFbIYYF7MrKD83PtHqVT2Bwbn8CQA7B9CRdY
         HoqB6pQF5anQkBFcRDiV1PBOtg9C0A3yDf6yBMwFLjOKgxQkqoZeQmidh1iGx98N/duX
         ELBp6l/tGiNjkAfeQprg6MfoITUDplgF11/LN7Buu0NXaotnMXuB2URpjVRo+lhunE1e
         NaQzy3eubzoJPuvb3WvO03Fij9fE0DI288wax4Pcapc35WOixwTJnWsLDEG/XciL9Dx+
         moWw==
X-Forwarded-Encrypted: i=1; AJvYcCWkJUXD/XZ0sFhg6Ru+xAgFgOrFHgBZdn45U3Yar8abZj27mSyo1a4CbgvA+Qw1Nts8Log=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWk9MJ3/tfn6b0WSkYWwM2Uin8Pe++rk7hk9k5OqdvoyTI0G/z
	Uv0cwDDE4yHVQbSp3gtsVUS4sZTW4TKlHzphxZMtb5RsUa7zW9ZCclfU
X-Gm-Gg: ATEYQzxOyV8HTC61P5PqapDqgjjUEvxTx9UUlM6vXnEfH0cG1ZjahqdFBiVBIBlccPF
	wHgHVuvF8+8fUFEZyTic5Ty8TrLvEY+DPZmdk45ZTBg9PWf7ykG1YYgpjsupx3BJ9sZ0sywihdi
	HhOwqv7XubqVP9Qv94xbzFgSzP3r0PMjDa7dmuqwWnhhBBXP1LbCcf/H+MJjWu64xtXCjJvBKP2
	C1oc6SuIa2AEN6uzSa02J1qlHFcJ3jieSfxoAs7cml1KDeuf6DA1n5CuC5ZBnNaM2q3Q4KQoPuF
	Hj88HpHzqawxLyGzeXmJdYyiPES3lO5CC7h3Yg7o3jy3x3Fs9rSGwV23lVf4RDr04gPJxfXMQah
	LOk+Maj6SAIA6RNO+1NscLe53ZWIA17ABeSve3dcdsICkx7wp0LJfWgnNRGTP1UrVv0XzpyESsp
	6b5mSdVkGkxzR97XoiFh9vtnyQfMHGnNd399X7yRATfEFj8yS2z25MSJDyj+52N9UxDJ/SVh3Nb
	1YFtE8vacf4emNNDQ==
X-Received: by 2002:a05:6830:b82:b0:7d4:becc:400e with SMTP id 46e09a7af769-7d586f6d9d8mr1461419a34.34.1772120173688;
        Thu, 26 Feb 2026 07:36:13 -0800 (PST)
Received: from ?IPV6:2601:282:1e02:1040:481e:870c:b200:7ebe? ([2601:282:1e02:1040:481e:870c:b200:7ebe])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-7d586653f81sm1939958a34.23.2026.02.26.07.36.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Feb 2026 07:36:13 -0800 (PST)
Message-ID: <bf293e1c-b2d9-4ef8-87c5-579e523d74de@gmail.com>
Date: Thu, 26 Feb 2026 08:36:10 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH bpf-next 8/9] bpf: fib_lookup: Allow output lookups
 for IPv6 link-local addresses
Content-Language: en-US
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org,
 bpf@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, petrm@nvidia.com, horms@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
 john.fastabend@gmail.com, sdf@fomichev.me
References: <20260226080003.524935-1-idosch@nvidia.com>
 <20260226080003.524935-9-idosch@nvidia.com>
From: David Ahern <dsahern@gmail.com>
In-Reply-To: <20260226080003.524935-9-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/26/26 1:00 AM, Ido Schimmel wrote:
> Currently, the bpf_fib_lookup() helper returns an error when IPv6
> link-local addresses are used. This is the correct behavior from input
> perspective as such packets should not be forwarded, but the helper can
> also be used to perform a lookup from output perspective (i.e., with
> BPF_FIB_LOOKUP_OUTPUT). In this case, passing IPv6 link-local addresses
> should be allowed and one legitimate use case is having the helper
> resolve the destination MAC for such packets.
> 
> Therefore, relax the limitation and allow IPv6 link-local addresses when
> the BPF_FIB_LOOKUP_OUTPUT flag is used.
> 
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>  net/core/filter.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/net/core/filter.c b/net/core/filter.c
> index e92552b139b1..8f0d2aeffc3d 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -6241,8 +6241,15 @@ static int bpf_ipv6_fib_lookup(struct net *net, struct bpf_fib_lookup *params,
>  	u32 mtu = 0;
>  
>  	/* link local addresses are never forwarded */
> -	if (rt6_need_strict(dst) || rt6_need_strict(src))
> -		return BPF_FIB_LKUP_RET_NOT_FWDED;
> +	if (rt6_need_strict(dst) || rt6_need_strict(src)) {
> +		int rej_type = IPV6_ADDR_MULTICAST | IPV6_ADDR_LOOPBACK;
> +
> +		if (!(flags & BPF_FIB_LOOKUP_OUTPUT))
> +			return BPF_FIB_LKUP_RET_NOT_FWDED;
> +		if ((ipv6_addr_type(dst) & rej_type) ||
> +		    (ipv6_addr_type(src) & rej_type))
> +			return BPF_FIB_LKUP_RET_NOT_FWDED;
> +	}
>  
>  	dev = dev_get_by_index_rcu(net, params->ifindex);
>  	if (unlikely(!dev))

Reviewed-by: David Ahern <dsahern@kernel.org>


