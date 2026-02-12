Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C632611CAF
	for <bpf@vger.kernel.org>; Thu, 12 Feb 2026 13:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770903661; cv=none; b=XrKUP3k/PFNmcL9q/4NBVYkAhykFk1HGUn2l4/OFxVtvOOK6UD62l60+jyRNCMnKfF10Dcg3bA1s794/XHv0AQ7OLsePJPGGJqLvg20xqBflS8NXn/tiGDH+ZalZQhK3rhRZ93R+jdikh0+2e7NP91PmCjl/84ylQ00BlHmU2J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770903661; c=relaxed/simple;
	bh=w3t0DMK7E5AB1lyrci1NW1tZ6xExcnLKjjWNzsWrO8I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=URKNwG9ON55+sMB80AEOm/BDf9k2i7JpMbcEhkW1ZarASsncoaT8kbptexfaXWosCpRyrzuGBJl9OCvVvbCB7/Uxpz2pH2f7kZvnHVeiRYOH/Om9jzNyNUCoSHQ9xc+Y23N+t59AeLQ4pkRGasVvQiROFsA4CXtfTnc021n+kD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LiBtEj79; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LiBtEj79"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-47ee07570deso60340205e9.1
        for <bpf@vger.kernel.org>; Thu, 12 Feb 2026 05:40:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770903658; x=1771508458; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yJVg9Gk08nuxO2aNnlaxDCcb6k/MldzWyDY7N00ZSQk=;
        b=LiBtEj79xoMJtDLAdqS5gWJrnOyP84/NgkUrZTCwy5CTa7uUOVSLU9A6AHaqUpWc4T
         jaq8DXmPo00vrwXeG6qxMKbzRk4IHX1i+6K7arTl6nMP7a5GLTIbgFVn0726qNFUOvlx
         PmcmX55iUmLXQ8L39m/MFnnsXggbkkApKSXPi+1edjTOoTOmDHvoOKEZMb45rpLxArK6
         RROhc53L2PR5dPg6HiIACvaehzQmGLT2z3XHw9k24+P4+RDow45HxueVJzbxmo+x8pxv
         fkf16qZ9XG0dUJcTIjkqBowSKfWzYxLZ10XQey9KAdqpcEepuryG3k5Ts/zBBodkM5t4
         +C9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770903658; x=1771508458;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yJVg9Gk08nuxO2aNnlaxDCcb6k/MldzWyDY7N00ZSQk=;
        b=iMVo3u+W9FNoawuTRaXGszC6UjkQFUv92RT3+tMG5f55F9JnYa1mcB8qvprYPDURpF
         5GIyl4uy4zoSpX+wy0JTd6rQMP/BWdmfK+8cssfL/xF+XktNL1J5Q2twwMNBNnBBFGbZ
         Rn3EFXuIQ0HiRJ7zwQVkEj5NqPuopw4R0G3kKb5N6CA5JMoHvkTAm256mKmbl6eWuAVs
         X88VhFaBe2ZqUdepdLz4SEbkqNGLhw5DJMUkvKsHQQE9o0ZFj7sxBjfgJmNKVaruTDE7
         jACbZ5/HAq1nBPy4GT1iHZzQTLnTligOioSEQs14BxuFYhKdITDaeXoQaUlpYoOki6xm
         ruEg==
X-Forwarded-Encrypted: i=1; AJvYcCVOcxpCKzE6XjikzeExUzedheyN6AUXXp4JbOL9E0WdxJg1vm2Lus6KQxjf0NL0dcgj1f8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPgTjO0MaAZps9aJyNcJIMZkW3BTWnVvdw6hqfe43n6XQFi40G
	yJHjlV7K9SbWvsEDshU/Sw4QkebcvM392vVlTxQGQRBPUYqdH/Iz/0us
X-Gm-Gg: AZuq6aI8FqEMqDS9x18hcKXw/OLi/7xRI9fOTffzbONnYaD4J2G6HLX+GrdIUikyjS9
	f0MLodxD8kwjx3w9dngv66QovpBvcsCCSWLxPocCxJDNTpL1AYUoeVBtiTp2vBLk/+FLcv6k/+0
	/tByJ80gSF1JXx1YZi0J193YOuhpArkV5O7D+IW2Qyjprw3L3hqb8gvtQK9Xk/s1KAzQTSWc1I+
	b3IlRn/jy/rHdYtFDz7C7mjnbAzLnxvWYhTKcWgim3gD0POFe0J/bPKiVI/hnJi8SPGn7RTjdw8
	hdgorc6fmkNl9m2Do1X89Rf9LsRxJi151KDiC/U/YGDtSXwvI2Y0GQprE4h13SDC5ANBMLuTn9T
	wQ0QyNJTx2qc/5Cj1WdDIShbCu84eIwFrqVvY7snyF9RGiXxHEK2AceuJPgEsM2UYvUR4J7vDxY
	k6HHYVySFeFb7pItiZn07B1LyGg5G0uPaO1q/ECpEhzQF+vstwKFL/GvHuZtbkQeXKZhjoi+agq
	pbetPgcY12Z0Uo=
X-Received: by 2002:a05:600c:3b08:b0:483:885:f0b0 with SMTP id 5b1f17b1804b1-4836571fc70mr44875165e9.35.1770903658096;
        Thu, 12 Feb 2026 05:40:58 -0800 (PST)
Received: from ?IPV6:2a01:4b00:bd1f:f500:e85d:a828:282d:d5c7? ([2a01:4b00:bd1f:f500:e85d:a828:282d:d5c7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4835dd0deeasm107748385e9.12.2026.02.12.05.40.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Feb 2026 05:40:57 -0800 (PST)
Message-ID: <1489bda4-6d96-4a44-9486-aa63efcf2307@gmail.com>
Date: Thu, 12 Feb 2026 13:40:56 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v1 08/14] selftests/bpf: Fix use-after-free in
 xdp_metadata test
To: Ihor Solodrai <ihor.solodrai@linux.dev>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman <eddyz87@gmail.com>
Cc: Amery Hung <ameryhung@gmail.com>, Mykyta Yatsenko <yatsenko@meta.com>,
 =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com
References: <20260212011356.3266753-1-ihor.solodrai@linux.dev>
 <20260212011356.3266753-9-ihor.solodrai@linux.dev>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <20260212011356.3266753-9-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/12/26 01:13, Ihor Solodrai wrote:
> ASAN reported a use-after-free in close_xsk().
>
> The xsk->socket internally references xsk->umem via socket->ctx->umem,
> so the socket must be deleted before the umem. Fix the order of
> operations in close_xsk().
>
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---
>   tools/testing/selftests/bpf/prog_tests/xdp_metadata.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c b/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
> index 19f92affc2da..5c31054ad4a4 100644
> --- a/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
> +++ b/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
> @@ -126,10 +126,10 @@ static int open_xsk(int ifindex, struct xsk *xsk)
>   
>   static void close_xsk(struct xsk *xsk)
>   {
> -	if (xsk->umem)
> -		xsk_umem__delete(xsk->umem);
>   	if (xsk->socket)
>   		xsk_socket__delete(xsk->socket);
> +	if (xsk->umem)
> +		xsk_umem__delete(xsk->umem);
>   	munmap(xsk->umem_area, UMEM_SIZE);
>   }
>   

xsk_umem__delete() is indeed referencing umem, the change makes sense.
Acked-by: Mykyta Yatsenko <yatsenko@meta.com>


