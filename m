Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C080273D6D
	for <bpf@vger.kernel.org>; Mon,  1 Jun 2026 05:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780292736; cv=none; b=AB7KPbXfaPa0RNrz99P003mOZ2qKC8M/9RySVwdAdpyRQrqlIrzBtG00w/Wm795TWI1WNTz/DIlKpk3IjulvqAqpToNydrg+Ib/bhM6JjJ5IHZ2JYDry1gcoexMYabOWSNCNRLx5Zl1zFYPEsHy6r4clcXePb3ZjJB2W5I977Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780292736; c=relaxed/simple;
	bh=39/3PFSkcNJWHUPBkv0omN/oj876F7VG69IVjU8nXAI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=YQhyRK98kIJlv8z5TvHS7AF8m/QDQU0NaE9oh2SDCCiEDcOLM1BCDiLshodg2NKXHnH398V2NTRXFw8Q/H4vELSVcoBVpsFUAlNdrVGYJHFnGCAifHUKmUZU49nnFxvZF/3yUhjr6xgSgoBbw5iBA7y9YtEzF/peL2ZVPR6eL4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=utDJEGVJ; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="utDJEGVJ"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c85ba774551so121945a12.0
        for <bpf@vger.kernel.org>; Sun, 31 May 2026 22:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1780292734; x=1780897534; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T8Eqep7/7/Qu02hD6m9ahHFR65zImADFmwc1B3Gd9/8=;
        b=utDJEGVJCWMUrBTTNM9VDEiv0+bqhpbR7xzRMJnp1Y94aA6YnmpBbSs9lVuVjhN1PB
         x06y1H5caZhe6RLroa1/waekw/f6K68Qtqz5K1pxAAdvNokmGoE5nf5pFg4M3+K1n2GY
         wwTS+y/uRTFwk9J2kgbjiLPFPeMMZVZMxcO8AbN11ta8RIBgZUQDNlHRZOB049XVBhdU
         GzJIqwWliwWeVTdlpHZKb1oJK4YZjteKXzhByxzgcbezFscH3NqOqJgeyXMlD4GrCCaT
         exDWt9RiJNo2F8kATw3LSh6Bf2Iv7fZnVHKtcXNoZhQNZ9RdPsEP02hRbG+WfQW/hbXe
         +ypA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780292734; x=1780897534;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T8Eqep7/7/Qu02hD6m9ahHFR65zImADFmwc1B3Gd9/8=;
        b=i4hOHimz61XI0IQZFAWUZKWaY/5h/9IWmVNRMqicucRTULN47JNckqRBsk4ey8HaXH
         Xv64CN0fQXvOsvmxJ42iRQ+Nutc9KSswkytu9Y7X0b2tuZT7mknoN6qlFXXwLrwa5zrO
         r5CRdqvY2dkjFx/sMJFhm9AexS4k9IkToOhkg/d9f5xMz5ilWDfq2teEQQEzdKSv0K78
         GT6O92d9/yTZZwJfAX8ZtytIWjBvi7xVXmAJY+jljYPFTaHYD1FGccyeNpMiBGpzrCR2
         X3MtrPhs5z1PWt7D9wMnAMvbOh0jlqTHqwvUMRp7kXzwp4l5AfJm4aeXSRfoT4UDebrb
         Q+1A==
X-Forwarded-Encrypted: i=1; AFNElJ9XKRH2vhuW0H3kX7JZe6hbVUDUzGzI7+GKNSfyg2T6wGdANpkayRXx8yAuKVByry/MG1g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnuUXNIlN9cQBl580cR71U7vyIu0VstZLg8MWR1sRfaE309foQ
	sJlUq5OwcukidUCYKN2awzRiR2lwGWOoJqFXrOHfq1D+jFEPkRZDhIb5Tk1sLpVkI14=
X-Gm-Gg: Acq92OFwP0cJ4MeEgca36gD//O8A0ur4EBEIejux2XoGMzZ/IR0SzkcftKN7BmhwGzO
	tCPmsruAO2l/y7rLfq1uxuuz0tygLoIdI2AdFB0zj9wzeNpkqolMbh6syPGkXxKsY+bqs0DwF5m
	jGw3l4sk2Xlxhmqoejnnob5mXWS5hAWzwe9zEwyt5J1BY1wufX2lmeE2JnIQjGz1rqSB0z1FJGQ
	Vi6Y/KI29dIqryx260l9f1UVDW7a0w8UvJnnA8RCSWTsliFOQKzmuwvxjQJN/ga/RVymIGYLxg9
	n66CxM2XYyqk6u3E/D6XGOfAmF3oCBvqkQI8IoqaQfzU9FXnvJfOH1JNv2YQx6+yPHwdUvyKEqq
	9aFjidQrOArgajoaJYoznZUX5QAEbNOxqU9+7ApbQx+pW65NKFW7gZH2YnWsSjLEDimjmJN7JN9
	uWiFZ6DYTMuG4Q5t8mC7qeeoPWf3orpkUTS6c=
X-Received: by 2002:a05:6a21:6089:b0:398:b95c:51ed with SMTP id adf61e73a8af0-3b4281db742mr10663823637.35.1780292734609;
        Sun, 31 May 2026 22:45:34 -0700 (PDT)
Received: from localhost ([2001:569:58a0:da00:a5c8:c4ce:f7c1:40c1])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8583333e80sm6466873a12.18.2026.05.31.22.45.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 May 2026 22:45:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 01 Jun 2026 01:45:33 -0400
Message-Id: <DIXH3R3D33MX.125DN9V9BR7QX@etsalapatis.com>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, "Eduard Zingerman" <eddyz87@gmail.com>,
 "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Yonghong Song"
 <yonghong.song@linux.dev>, "Stanislav Fomichev" <sdf@fomichev.me>, "YiFei
 Zhu" <zhuyifei@google.com>, "Matt Bobrowski" <mattbobrowski@google.com>,
 "Quan Sun" <2022090917019@std.uestc.edu.cn>
Subject: Re: [PATCH bpf v3 2/3] selftests/bpf: Fix cgroup bpf tests broken
 by bpf_set_retval validation
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Xu Kuohai" <xukuohai@huaweicloud.com>, <bpf@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260530101239.590395-1-xukuohai@huaweicloud.com>
 <20260530101239.590395-3-xukuohai@huaweicloud.com>
In-Reply-To: <20260530101239.590395-3-xukuohai@huaweicloud.com>

On Sat May 30, 2026 at 6:12 AM EDT, Xu Kuohai wrote:
> From: Xu Kuohai <xukuohai@huawei.com>
>
> Add explicit return value checks for cgroup bpf progs rejected by the
> bpf_set_retval validation.
>
> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>

Since these tests are breaking with patch 1 you should put this patch
before them to avoid the breakage in the first place.

> ---
>  .../selftests/bpf/progs/cgroup_getset_retval_hooks.c        | 6 +++++-
>  tools/testing/selftests/bpf/progs/sk_bypass_prot_mem.c      | 2 ++
>  2 files changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/bpf/progs/cgroup_getset_retval_hooks=
.c b/tools/testing/selftests/bpf/progs/cgroup_getset_retval_hooks.c
> index 13dfb4bbfd28..c0bfa2d12dc7 100644
> --- a/tools/testing/selftests/bpf/progs/cgroup_getset_retval_hooks.c
> +++ b/tools/testing/selftests/bpf/progs/cgroup_getset_retval_hooks.c
> @@ -2,12 +2,16 @@
> =20
>  #include <linux/bpf.h>
>  #include <bpf/bpf_helpers.h>
> +#include <errno.h>
> +#include "err.h"
> =20
>  #define BPF_RETVAL_HOOK(name, section, ctx, expected_err) \
>  	__attribute__((__section__("?" section))) \
>  	int name(struct ctx *_ctx) \
>  	{ \
> -		bpf_set_retval(bpf_get_retval()); \
> +		int val =3D bpf_get_retval(); \
> +		set_if_not_errno_or_zero(val, -EFAULT); \
> +		bpf_set_retval(val); \
>  		return 1; \
>  	}
> =20
> diff --git a/tools/testing/selftests/bpf/progs/sk_bypass_prot_mem.c b/too=
ls/testing/selftests/bpf/progs/sk_bypass_prot_mem.c
> index 09a00d11ffcc..bae5283fca6b 100644
> --- a/tools/testing/selftests/bpf/progs/sk_bypass_prot_mem.c
> +++ b/tools/testing/selftests/bpf/progs/sk_bypass_prot_mem.c
> @@ -5,6 +5,7 @@
>  #include <bpf/bpf_helpers.h>
>  #include <bpf/bpf_tracing.h>
>  #include <errno.h>
> +#include "err.h"
> =20
>  extern int tcp_memory_per_cpu_fw_alloc __ksym;
>  extern int udp_memory_per_cpu_fw_alloc __ksym;
> @@ -97,6 +98,7 @@ int sock_create(struct bpf_sock *ctx)
>  	return 1;
> =20
>  err:
> +	set_if_not_errno_or_zero(err, -EFAULT);
>  	bpf_set_retval(err);
>  	return 0;
>  }

