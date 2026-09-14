Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441E23093CF
	for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 13:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789392140; cv=none; b=GOK3MX3kc2yT2ljTZUuvZNI1fGjZhnlPJk1VCasTbJEEGMWR+OjaXo48wVZULtcz/dLjrOpM1VtmI3fJsq32Y6Dqy2gsccYFiiyiOJqlGXNhhWeq616C03BU/8lVTBowaAprIEQ4XpUBZfwE/ylvzI4AMlMRlZR6GXefUK9UrkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789392140; c=relaxed/simple;
	bh=n7aX+8kZ9LXKzmnUDnSoeH2PxL/Lefk9d4ihaUPODPE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ffJ/IwZhmlTBZzcaIdpTy/bByYmr1frbhUAmxPHqNxC+eMTi1Ncn/aVARa2AZWJdolSvY3xUNGWGB367zlsgjmId2XSI2a0hGz/lpp8KDzxL4WW09Rz+3OdOUa/kHHDVRXjo2k7Ki9xkLbTBL9+mkHTgqk4Y15ScQ813jMBuou8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c02B9JzG; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c02B9JzG"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49d097b4939so9080695e9.0
        for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 06:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789392135; x=1789996935; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=68CLQdhSjTAyvUMuVP7kMZoX9zgZl750X8olIiK9eCU=;
        b=c02B9JzGYWJhvsRqr0CAaM55FAiU2h2L+wGUif+SmEFpCF81OKTbv3H2sAs3pKArPh
         aDwU0G0lksWUMpBp/WQ9H6SvdBDXZxCQeXYJ4XgpIwSlt0ya03/tGTZSEhkoZF9JCbUi
         mCrfdEOLWCAMPeEIlYYI/jWoEkvBwKPQ2cQn1DyXnHmnGgit6zC3Pmvjmk5SyeOdGJAi
         PfEw27EPFqdglLGAX1RqXKPs6DGW+iuN86fo7XsDuVbLffDTI9FRPWbRs/v510jREe/Z
         r2kCfjtvK5FjC3UQ6U8mayqceaTjSZ7304YEe+3o1GF8voBhkxSJ3IIgCQoQBRD6oW3q
         7JDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789392135; x=1789996935;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=68CLQdhSjTAyvUMuVP7kMZoX9zgZl750X8olIiK9eCU=;
        b=fp8ya3pus7gGqZfqzjoee5VQdNu1MrMo0OKH/aPzAl7V18sD7ce9uTcQOcXd94F7kK
         fzib21HLTUoe+lIHjsibohdejhRuN11L1vhNc26gwT7YvptPMGt76hubClsLKIGaJwtI
         h19Va9gLB0sBZMj4iDqw5LyoZpOVIhhOCo/e5Q2wuCIpNXI6INREv+8mwd3M2Eo2uTIU
         RtcaK0+rGzXRj+ncE8O9ey7G2ChwfsgMGS+ljGyn0xCicLRGt9gXfZGk3Ui0f35ilE7B
         LnjDjXNkLL2j0uQDCNG1xVaWiuLlt/1m+ZOH1+Zk7SOcp6dE208VHzAqWYdmwLederzg
         qKjw==
X-Gm-Message-State: AFuF++mDYTgtu5yY7qMUV7xui3BR9eLQ76VLBVLKCN7JGAWqn6kmosAu
	j7KY2nS2CBXHZ9rbVHnfp0BzTPj56GKgZFRqv8kOTKPgGXSIP04C7aMq
X-Gm-Gg: AYBFou08e+B8rMuIWO3HefT4d3dML0gg/NzCzc+X5vwwh4kglCCCfRqCZZX25uNw2hc
	2U+J9uFkZ/lVkr970ASP8vlTvZ0r0sWBqlXKy/WWVrM9nH2xbyCkegq36PSINeUK59ZDPn7NMsM
	9ZXftVK3APSCC78keFYf4MpkjlALnBIQJ+0RY2ENMURRtxqpaYNrZX/kbCqvcwcPzc+ys4Up0OT
	Lpk5BsgMKUhdbDBRgQKpdh+enX1ULRe/atyq7TQexYrvqSR1ydEe1UhOpdeQYC9MzSI8P4cV/Ly
	bcCZXfiSc2iGnPvuzAN6wqk8PkRaECQOZHq3q2RWnUvI/4GYJOdXF1ha/lklRVHQUSSAo/2is9W
	XFjoWdl6SdhnsiFnnOggAH0AtVLR+tYbaYB6JOs8cGJE1I2FXyfSFyfsdzBmT/DhFnY5H9fpfu6
	i1UWLsf8huBn7n0GNm8FlIrN9E0QwgEWMRN47ZaWcEFf+ZsDVCkLaECmQu7DEZ+qix2rjpr+YfA
	eZwPModtN9EspFp96daeF258zHJXLLOfFf/e/M3zh8Zyg==
X-Received: by 2002:a05:6000:430a:b0:486:f18b:3cf8 with SMTP id ffacd0b85a97d-48702abf773mr3234183f8f.22.1789392135207;
        Mon, 14 Sep 2026 06:22:15 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:37f5:891d:1d21:b3d3? ([2620:10d:c092:500::7:35f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb34f353sm26261378f8f.26.2026.09.14.06.22.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Sep 2026 06:22:14 -0700 (PDT)
Message-ID: <05221557-59b5-4d93-ac55-d9e372d0862b@gmail.com>
Date: Mon, 14 Sep 2026 14:22:13 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf] libbpf: Fix program log buffer size validation
To: Luis Vieira <luisflavieira@gmail.com>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>, Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20260914-libbpf-log-buf-fix-v1-1-f592caffcc71@gmail.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <20260914-libbpf-log-buf-fix-v1-1-f592caffcc71@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/14/26 12:50 PM, Luis Vieira wrote:
> bpf_program__set_log_buf() intends to reject log buffer sizes larger
> than UINT_MAX.
> 
> However, the function checks the existing prog->log_size instead of
> the incoming log_size argument. As a result, an oversized value can
> be accepted.
> 
> Validate the supplied log_size instead.
> 
> Add a regression test that verifies that values larger than UINT_MAX
> are rejected with -EINVAL on platforms where size_t can represent
> such values.
> 
> Fixes: b3ce90795035 ("libbpf: Add per-program log buffer setter and getter")
> Signed-off-by: Luis Vieira <luisflavieira@gmail.com>
> ---

The change looks correct, few questions:
 * Do we really need a unit test for this? We are not testing those error
conditions now.
 * While here should we rewrite the first check as (!!log_buf != !!log_size), to
cover the case when log_size == 0 but log_buf is nonnull (we check it later in
bpf_prog_load()) (AI)
 * Fixes tag is probably not needed, because this is libbpf, target bpf-next.

>  tools/lib/bpf/libbpf.c                           |  2 +-
>  tools/testing/selftests/bpf/prog_tests/log_buf.c | 25 ++++++++++++++++++++++++
>  2 files changed, 26 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index b749c01742ee..e1fed7735614 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -9955,7 +9955,7 @@ int bpf_program__set_log_buf(struct bpf_program *prog, char *log_buf, size_t log
>  {
>  	if (log_size && !log_buf)
>  		return libbpf_err(-EINVAL);
> -	if (prog->log_size > UINT_MAX)
> +	if (log_size > UINT_MAX)
>  		return libbpf_err(-EINVAL);
>  	if (prog->obj->state >= OBJ_LOADED)
>  		return libbpf_err(-EBUSY);
> diff --git a/tools/testing/selftests/bpf/prog_tests/log_buf.c b/tools/testing/selftests/bpf/prog_tests/log_buf.c
> index d6f14a232002..31c842d27fb4 100644
> --- a/tools/testing/selftests/bpf/prog_tests/log_buf.c
> +++ b/tools/testing/selftests/bpf/prog_tests/log_buf.c
> @@ -3,6 +3,8 @@
>  
>  #include <test_progs.h>
>  #include <bpf/btf.h>
> +#include <limits.h>
> +#include <stdint.h>
>  
>  #include "test_log_buf.skel.h"
>  #include "bpf_util.h"
> @@ -267,6 +269,27 @@ static void bpf_btf_load_log_buf(void)
>  	btf__free(btf);
>  }
>  
> +static void prog_log_buf_size_limit(void)
> +{
> +#if SIZE_MAX > UINT_MAX
> +	struct test_log_buf *skel;
> +	char log_buf[1];
> +	int err;
> +
> +	skel = test_log_buf__open();
> +	if (!ASSERT_OK_PTR(skel, "skel_open"))
> +		return;
> +
> +	err = bpf_program__set_log_buf(skel->progs.good_prog, log_buf,
> +				       (size_t)UINT_MAX + 1);
> +	ASSERT_EQ(err, -EINVAL, "set_log_buf_too_big");
> +
> +	test_log_buf__destroy(skel);
> +#else
> +	test__skip();
> +#endif
> +}
> +
>  void test_log_buf(void)
>  {
>  	if (test__start_subtest("obj_load_log_buf"))
> @@ -275,4 +298,6 @@ void test_log_buf(void)
>  		bpf_prog_load_log_buf();
>  	if (test__start_subtest("bpf_btf_load_log_buf"))
>  		bpf_btf_load_log_buf();
> +	if (test__start_subtest("prog_log_buf_size_limit"))
> +		prog_log_buf_size_limit();
>  }
> 
> ---
> base-commit: ee363e055895364039bf28348ff13c615afad4ba
> change-id: 20260913-libbpf-log-buf-fix-49f5038caa5d
> 
> Best regards,
> --  
> Luis Vieira <luisflavieira@gmail.com>
> 
> 

