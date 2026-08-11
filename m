Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D443E6DEC
	for <bpf@vger.kernel.org>; Tue, 11 Aug 2026 20:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786478698; cv=none; b=pDn48xAdfGq5osFnN+cia8UVN1wq0mi9t0mRv4Lq6FA2alUrwJM3eTqpqi8RpPfD9kiIaY0AZsLX4Vu8k9fESUwFDwkUh6aNPZhe1uGaQdN7G376/mbHPN+2nsDySTXjvUHwcLhFNCR2CaBY2hK8Ca4nt8aodrR/ApzbUGGh1mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786478698; c=relaxed/simple;
	bh=8+MQ3PAmrdM/T+sX9Uz5RIcAMFUVnrmwBf5vR1gGAVA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BxCjmjy73pbUwXIG3uweqrgbXznUsEOndfiE2V5pNz4NAYvNMf+XB2ATd9XJcPSK+SyP30eVc9N9XTmX/5M3IppCFnBREJj0E8utl0YWnc8uIXNThgABYY6r6DrF85f21qmuOGAqlFqHRuZE5+e1Vx/oM9P2+4ak8Z3F0RPJgqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ApDXSvbl; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ApDXSvbl"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3811f512167so155048a91.3
        for <bpf@vger.kernel.org>; Tue, 11 Aug 2026 13:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786478697; x=1787083497; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=vU3Qzb/zPA8rCksH7GNN+GT6sKZBOTFbFjwnJ2Ezlfw=;
        b=ApDXSvbly2aMOh7c+Wk5/zgd6+EZkTMqsSLb+KFl5YutxLXG58uu81/54/2mTL+OUC
         sbjvDweK3ecDzQHlvLa8HTKpqrq7QifWQXTntBRZA3q8yiOWC7mCGL8OqSMulKUYzCid
         IVXuYcsWLH8Js5zpu4hYuBJmkNh6GuZUM4NbUOmUGWTDlPsR9CKJ3MWkZxlqDOeNAxOS
         mm9GsOTG6LQIIv9d17QE5iB+iSED6EtTpKrZTHZp5DC8ERGCHCHC6YvS9vxIxa1Ts7I2
         xXIkVs4N4j4XHXIME4gc6IwoUfvL7IET3pPWzlai2CdsKyRF7tLx3uZNu2oaiLMcGGfm
         5dxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786478697; x=1787083497;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vU3Qzb/zPA8rCksH7GNN+GT6sKZBOTFbFjwnJ2Ezlfw=;
        b=d9fsoGGPq0DiAcK+Y30Ar0xyYFAk6cc7rYyo+Hqf1NT1KJrA63eMldOAoQKyOlP7sh
         jEYDkjiB3txtePy/TNsJIXaeh3HMbE8SDMi5ZrFMeDQhFnpHCFbIEWox9ECqDEbNOWmq
         Y8fdtKpZGp4R1NF8G8qwEhPQnp9bKrJX7dYOGuhwoRiAccVVTzqDA7X0dyjf3qz22gyj
         6338AbhC6R1Sk7ftpCJ/7BQX+ijQhLKp+DgkbOU9Tz8c580w65WeYPbOhRlKUtCSrhDF
         hFLGFw6PB/FGgJ4c+zt5YwOCZ3UqZPab3v8GqyKwEQZbcmyFhzb5bkjdhDL6JZsQsg86
         lXuQ==
X-Forwarded-Encrypted: i=1; AHgh+RqWmiRcN18UcefUt8RrhSO946o2YN4neWVNjBXV71YsOvFr0Kd9+KfPx5KylPi+Yc+6IHg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2CSalu38+MhRhry3gOJU5u8+Y3M++0Bs8/0o9ggkRAEyDb3YA
	LGULwUW+3mgXx14/nX9Oj2aOYmB3DurA3w3v/Dea7jEOT7kM5fATs06t
X-Gm-Gg: AR+sD10mL1+AvImCMRNM7nyT7Y7T68qFdv2pIabdIhoYZvj88ymRq2j3v2lLF5IACxJ
	E2+wMVe2Wjr8liOvJDuOgccr498HpTkU7S6mrm+/hpfSUx3eIXwF4IEGHz7u/dQH8tovtaBnAUx
	9YVWngtGin4OKnd9q9stOw+ANKSpwIOZmZ7M9kF6nComCMJTiyL+W8o4G7SddfQXCd1L8tQk26M
	mqSSH/g2Q1xNS9gRfknb0aMJzYIoKxUNiDsbb0GOSf68MjJ2kX79gtq3NMi5xx23wDBVFbwBeT6
	Vd/EhPrqjc7xMpEA3g1dttlPTu4glUMr0/bk7M+dExfx0cfCrIGE2JhS5uEYtYWSKDPAEi8fzjM
	2VgdXxrmd//jUYLztJeeH7VvhEpTPCarJhvuoeGjw8/yjYTz1b3AI+flN8pApJPNc2j7VPbSW7M
	VbPL1fmNssUkJXUcjwjhbEdD3vRJ6y3nXd929W4V+0CBKv5n//7cRfBV4aRbotaPFSlXzilYDpQ
	ENtxdudLeFdJ6KlZ2GAsQ5G93ciyCyxwa6c5LK2cfS3ZA==
X-Received: by 2002:a17:90b:3fc4:b0:38e:6d4c:14e6 with SMTP id 98e67ed59e1d1-392ec2fbc12mr6892265a91.3.1786478696496;
        Tue, 11 Aug 2026 13:04:56 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:cd18:dfe8:e39c:4123? ([2620:10d:c090:500::4:f345])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1412458a390sm2133196c88.14.2026.08.11.13.04.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 13:04:56 -0700 (PDT)
Message-ID: <58931262ff528992ebcf900a3b45708b20939be2.camel@gmail.com>
Subject: Re: [PATCH bpf-next v7 3/6] bpf: Show more useful info in stack
 depth stats
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov
 <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Emil Tsalapatis
 <emil@etsalapatis.com>, kkd@meta.com, kernel-team@meta.com
Date: Tue, 11 Aug 2026 13:04:54 -0700
In-Reply-To: <20260808062601.1070988-4-memxor@gmail.com>
References: <20260808062601.1070988-1-memxor@gmail.com>
	 <20260808062601.1070988-4-memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2026-08-08 at 08:25 +0200, Kumar Kartikeya Dwivedi wrote:
> Stack depth statistics list captured depths in subprogram-number order,
> while per-verification instruction counts are reported separately. Since
> libbpf determines subprogram numbers, it is hard to associate either
> statistic with its subprogram name or see where verifier work is spent.
>=20
> Now that self and inclusive instruction counts are available for every
> subprogram, keep the combined maximum stack depth on its own line and pri=
nt
> one uniform record for each subprogram. Represent the main program as
> subprog 0, then classify each record as main, global, or static before
> reporting insns_self, insns_total, and stack depth.
>=20
> The aggregate processed count is the sum of all self counts, while each
> total shows verifier work rooted at that subprogram.
>=20
> When no subprogram name is available, print <unknown>. Keep the existing
> aggregate "processed ... insns" record unchanged for compatibility.
>=20
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

...

> diff --git a/tools/testing/selftests/bpf/progs/verifier_basic_stack.c b/t=
ools/testing/selftests/bpf/progs/verifier_basic_stack.c
> index d3df7a9f1d8c..3a9ee8b55fbd 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_basic_stack.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_basic_stack.c
> @@ -27,7 +27,9 @@ __naked void stack_out_of_bounds(void)
> =20
>  SEC("socket")
>  __description("uninitialized stack1")
> -__success __log_level(4) __msg("stack depth 8")
> +__success __log_level(4)
> +__msg("subprog 0 (uninitialized_stack1) main insns_self {{[0-9]+}} "
> +      "insns_total {{[0-9]+}} stack 8")

Nit: let's avoid splitting these literals, also the following would do:

     __msg("subprog 0 (uninitialized_stack1) main {{.*}} stack 8").

...
