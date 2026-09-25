Received: from mail-pj2-f6.google.com (mail-pj2-f6.google.com [74.125.227.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A4B39E6FD
	for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 19:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790362949; cv=none; b=D/tpMpGxVKUn/wg1J5qQM33OMw0TpmZ2/Cf1cH4CMj0tRNDylsAKbDTcn6Ac585w2w98XfYZtvgVffq/sLg9CxHEFbLbDvHEXA8NbqqrVemLDB1hkY92CSMBE+qCXh/z622nUe4yt+2a6KzXnbvgiSigv7QV6RYvJrKEbFchZAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790362949; c=relaxed/simple;
	bh=miYvRcEGFmsRj3R3StAtd5ze/ExutceELLrIDIigKYo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ppXtjEaKcp5YqPSzT6HDstP990218bnvnzmj/9nEECb4XVV/nF05NiBiiGVHizIrrrTX++59oT+/xWViSJ5UHJWBr+4GPVxQHmKccBCJgw6MbtvFlvIeJd5cqAkw18qQUOOGMnoqtT0A+0YvWdLwrC1eO9agxrcgasiav3ub5Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N4Z0c5iH; arc=none smtp.client-ip=74.125.227.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N4Z0c5iH"
Received: by mail-pj2-f6.google.com with SMTP id 98e67ed59e1d1-3964e7720afso747607a91.1
        for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 12:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790362948; x=1790967748; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZbHzbG6KX4HjmnobdQp+43LfGiR+GIwDBr6SWkkO9VU=;
        b=N4Z0c5iHeZIAOdlqnWJXQD9W9KmfOn82z65vrzTrFjRMYKFNe2K+RB7I1B2bRudVim
         8J6V49/+ciBaFeJIQUBEP34DY8m7hTw/2tGjHH69ZtZB5CVEcBRh316lyqs4BCOv1u/7
         QP0qFDo/+Vlz1nJQe5NrIrOMKMCZL4SWCXcSR3tbvbo8H21RD7A0X5TPUVm+VvIOe31w
         emjqMwaRZFugSNIPyez1xgN3otfi9u7ZvdnOQ31Wl3gS0wPKtWFBzmJg3jIy+javRALB
         wj6STZ0SJTZa3Pjpgcj40D7W0/NrWe5mrr4Yq3erZtERx8Z6oGVFIUy+cVwtM6dnyc9c
         36Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790362948; x=1790967748;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZbHzbG6KX4HjmnobdQp+43LfGiR+GIwDBr6SWkkO9VU=;
        b=26dktcfS0mCO7Y83FtkpbnURyH0K+o1GFWufmBYWjyNpUv5iRutTOQzceZWcvvdTat
         2JTIGrZkpfygMT/Vf7xSZM5DIDAJXb5wP5xEPo/FcKStOMVOHZ98jIMiuv0rRR5KHkOm
         5dFY7cGJr5Q3ZOnjn79T2BsH0Y9CcFPwdlFFEaUK5nKEogCT/PlsNqd5/zGPrMjp0TWi
         tj0s9AEKUlIkqsO5ZWyH2/u/tHRQfWLdHiZraduCzpiNWw2QVZ/tucJdwysaz04TjhYA
         zdC6YmSIr3g4GeERNzOk0DNZJ32ahRI+aMyIcuUoQKNS3R5+RdoK6IJHjgrREUq8eV1n
         Q9mw==
X-Forwarded-Encrypted: i=1; AKwUvBzQeyhYjVA2JJu0Neu4yp10P+aZwIgJP7sNEojgL6c5XduVU6SYdGHIBCGiX/hOIJiomRA=@vger.kernel.org
X-Gm-Message-State: AFuF++njvlENXrTX+BIvi513VJ22CJG7LkZpu5coAg3hyOIaxSGrKzgE
	CtsjWHuYLF7bn91h721VxOK53lox14hkhu3r0W0N77cf4BmLQnbFxSfl
X-Gm-Gg: AYBFou2rE9G5mKp2oHkxk5t/aVpgfCMo5EuVxpF4loZV1h1au96MgHTx/k/J4Cdx/sF
	FUbrUdIHrGyaHqpHHPmBECnauK8BLTcFXlMsA2RPWOxzpatHpTy+Oi/NrH8vYkA1fRydLYUvgMQ
	85ILzEt+fOr4+lZkgmHFrrRoTsW/yPIVdUEbpd896vOWfTAoT5MtnwQrhtK1zQpkXtu5wbGdLmo
	wy+1tN/RjyCX1jzhlU50m2keOZP1ElItY2Cm+2MQmJ23jM2XKVimUKidP7R6+aDu4XAAvZxsCkf
	I+kEB9uuKKBQDEL0iWpX0AbyDHc6nyd9RGKynKPGOgf6FSQB/4AwENZRL2jdIg0IM2ORo/o0TLx
	Mk//U8olT2USIsPu0Y+RNNY5UQl6NJ2z6KCi/l2S4hgWRCFlaAMuiq4VIOceQxSlsOXn5rX9Jpx
	fejm+ZEauw3HJNC4EHEndjYMpW2RZvsvkfsBVn9GdpR2MxuwE46j48GHcJi8N/Q9hq
X-Received: by 2002:a17:90b:1dcd:b0:39e:d36c:ee54 with SMTP id 98e67ed59e1d1-3a0bb55308cmr2493435a91.5.1790362947509;
        Fri, 25 Sep 2026 12:02:27 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:5e::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0976c8f8dsm12331068a91.12.2026.09.25.12.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 12:02:26 -0700 (PDT)
Date: Fri, 25 Sep 2026 12:02:22 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Breno Leitao <leitao@debian.org>
Cc: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	Jiri Olsa <jolsa@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	david.laight.linux@gmail.com, kernel-team@meta.com
Subject: Re: [PATCH net-next 1/6] ipv6: reject a negative optlen in
 do_ipv6_getsockopt()
Message-ID: <arbE6i8JZrOs-DO9@devvm7509.cco0.facebook.com>
References: <20260925-sockopt_expand_out_v2-v1-0-c3ef2e3bb5c0@debian.org>
 <20260925-sockopt_expand_out_v2-v1-1-c3ef2e3bb5c0@debian.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260925-sockopt_expand_out_v2-v1-1-c3ef2e3bb5c0@debian.org>

On 09/25, Breno Leitao wrote:
> IPv4's do_ip_getsockopt() rejects a negative optlen right after reading
> it. do_ipv6_getsockopt() never has, and nothing downstream treats it as
> an error either: len is an int, but every consumer compares it unsigned,
> so -1 behaves as a huge value and each site clamps to its own reply
> size.
> 
> 	len = min_t(unsigned int, sizeof(int), len);
> 
> So getsockopt(fd, SOL_IPV6, IPV6_TCLASS, buf, &len) with len set to -1
> answers 4 bytes and reports 4, rather than failing.
> 
> This is a bug ready to bite us in the near future, let's get this fixed.
> 
> I've found this because testing the rest of the patch was returning
> inconsistency when optlen = -1.

If I can do getsockopt with len=-1 today and get 4 bytes back, isn't
that a uapi and we are gonna break someone?
