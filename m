Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D5832549B
	for <bpf@vger.kernel.org>; Wed, 18 Feb 2026 15:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771427571; cv=none; b=FK6saMd18bL0sBVzHfn29roTbi/6a9D2Hi7JfTWmpcUHvMsiq18DjwQu8OGBZO+YRRNYs9+w4rQs33BiIjhSFeMRKmX5b2cvDHdeV/O6z9DmnoEF87lIfXK6uM60qpjSt1e52ZQiqggDmodU9xQ6vKTpUP6XcertFz5pGMmr09g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771427571; c=relaxed/simple;
	bh=aZwFDn92e4Cyphq2y1e7Zm0JwBMRaSI/n0mt1NwtGIo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f9voQxzEt6axfan+MHifzp+2plLiylub54VzLwIUoGqkKZYJVz4T5laybl83bzWVAkOFJbDSBn7P1Bc/7YNHDORx9P1jjCMBpvx0LT5UdU4iWEJGrO8Hlb5GjqLP4KbWjuD19Ilh+2UFuNpPWuVaD5Uym1GzmWSeLAup8rmFanc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KMkz+eXH; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KMkz+eXH"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-65baa72399fso7371582a12.0
        for <bpf@vger.kernel.org>; Wed, 18 Feb 2026 07:12:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771427568; x=1772032368; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d8i1/qiuVjRiaNsTRuJ4wR0Jh27Jsm4aKKMFk9Ffno4=;
        b=KMkz+eXHedopTpfNsJ18RKigM8G4wGJKdd1lzzYzP6QFbSefLxBN8VJ5ZCNFxj1CJ7
         pDhNtkqQ6JuldYjLCLXImd73SQfcgiU9k4bpv5XWqjYVpXZaLMk+xag0/5bN00FBOuud
         xxHtZJxLKMLrQxkzAp2XSL6bI3DAnjAwAH8a4A6EQt3C5GX1iCUXKY6Mz4PR897oiYgL
         CICKxLa4O49HR+x8wcckH2UoatmHoqdMO0NxxQJDqAjFOn0wznYepAgEAMP4EpehAyef
         qEIy5VHEDfJmEmmQITJNCHW8Fdr9rM4Pq2j+AzOpWdVoTPvz0i3JIDBJRON+d7SasnP9
         PQ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771427568; x=1772032368;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d8i1/qiuVjRiaNsTRuJ4wR0Jh27Jsm4aKKMFk9Ffno4=;
        b=vHW3dkCIzVTHix14tADQZ1molr2I/xYmD0VU772JY5ol72Aw4bBCWHyy9ZE6XSVPD4
         typVrReqk/3ibdb8aPnIX7OenJAV3ER1cThOK7AKL+wLKFuE0jT9dRTgRTtTu2Lc5hqw
         pgIrMBVV+xzp+bibM1BWCFK2XSf9wdnU1qlzZfqKRWEa/HcQgYy18iRn+0PXXx6G+KWz
         eNl5uTwa31DRaSuaEX8PdH47xabAhSe3dEh2eX5FjWNda+EAxxM4yMcFTh37nUkJ3Uk3
         L3qoejG5Z0nLzVNoSxFc3PD+/X4rnqNj3vfG+o/yKuSCHEvy3J4XhpPAUrg+765TjVMe
         3qTw==
X-Forwarded-Encrypted: i=1; AJvYcCUpYCpKYeVGrDPnteAFy2TdnAaj2J2ESr/JSnFvvwPlg1NT5llB/lgqNFkeVAJGoqk2ZQU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMoxuBreGdrvl2ZgfZEbqEmORimvYq3SGACsvFrBrAB529DcQp
	BXR5PDEsJ/8etpnSkhpUsrGANukiiJjBpEjkRmCcdkgYfgHYoNbAqsJn
X-Gm-Gg: AZuq6aK7REP/cfHHcxQTVcvGk2VpiqASEF93WKT5Y9jeK9VdabyUDr5eW0FrpHliOD8
	kzoTkJaCINRt/oemGsD/ywyWbNQByPAILpOdej1Ah1oU9/0nNMhTT/9jeW1LwkvYZOy2c+2uzmw
	d3brh1bByziuyZRIJHCZ/xxPLDJacShhWIQa1d67H/sbZHH3CFA6EXQN/fiv5Us6ZYH8sHgJptr
	rIIla9Oypw17XotO+Pg9Wy6RXUvd7TvzMYC9yoQpKfN9slra1bobgTpzka9hYR7geUXhwa2Eq9J
	6c5DHLuvr3ScM/IBGgBodDoBGxlcg3OV6Jdw+ZT20gCC9p8kOWalGUq1VTDMHjTheKFojqFkGsQ
	SWBTWA73zQXodAdJK6DwYS+U3hS48qJIB9tbcVeAtCpcSDq/0gono7z33NxZcy1R+nKdHZBP97g
	XJrMX82mrRGxPbS15Pe1c2QB76v5JfEjeIhe8g5hbO4+NaYnNrK0v2EBzAAfStm4A=
X-Received: by 2002:a17:907:72d1:b0:b83:1326:7d45 with SMTP id a640c23a62f3a-b8fc3ca8161mr940155966b.32.1771427567656;
        Wed, 18 Feb 2026 07:12:47 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1126:4:93ab:614:2c34:ab35? ([2620:10d:c092:500::6:66e8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8fc7385965sm465950766b.15.2026.02.18.07.12.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Feb 2026 07:12:47 -0800 (PST)
Message-ID: <a017dd5b-eb7e-4724-8f8a-cb6a6c970118@gmail.com>
Date: Wed, 18 Feb 2026 15:12:46 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v2 15/15] selftests/bpf: Don't override SIGSEGV
 handler with ASAN
To: Ihor Solodrai <ihor.solodrai@linux.dev>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman
 <eddyz87@gmail.com>, Jiri Olsa <olsajiri@gmail.com>,
 Mykyta Yatsenko <yatsenko@meta.com>,
 =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Cc: Amery Hung <ameryhung@gmail.com>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com
References: <20260218003041.1156774-1-ihor.solodrai@linux.dev>
 <20260218003041.1156774-16-ihor.solodrai@linux.dev>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <20260218003041.1156774-16-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/18/26 00:30, Ihor Solodrai wrote:
> test_progs has custom SIGSEGV handler, which interferes with the
> address sanitizer [1]. Add an #ifndef to avoid this.
>
> [1] https://lore.kernel.org/bpf/73d832948b01dbc0ebc60d85574bdf8537f3a810.camel@gmail.com/
>
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---
>   tools/testing/selftests/bpf/test_progs.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
> index 02a85dda30e6..b533cede933d 100644
> --- a/tools/testing/selftests/bpf/test_progs.c
> +++ b/tools/testing/selftests/bpf/test_progs.c
> @@ -1944,13 +1944,15 @@ int main(int argc, char **argv)
>   		.parser = parse_arg,
>   		.doc = argp_program_doc,
>   	};
> +	int err, i;
> +
> +#ifndef __SANITIZE_ADDRESS__
>   	struct sigaction sigact = {
>   		.sa_handler = crash_handler,
>   		.sa_flags = SA_RESETHAND,
> -		};
> -	int err, i;
> -
> +	};
>   	sigaction(SIGSEGV, &sigact, NULL);
> +#endif
>   
>   	env.stdout_saved = stdout;
>   	env.stderr_saved = stderr;
I think this is reasonable for the use case. We may try dumping logs
in |__asan_on_error(), if that proves useful.
Acked-by: Mykyta Yatsenko <yatsenko@meta.com>|
