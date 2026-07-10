Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC9C3BB12D
	for <bpf@vger.kernel.org>; Fri, 10 Jul 2026 23:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783726934; cv=none; b=GW8COtu+79BZ7izRAoNL0I3qVfS65hkpkodFavlGQXJZofQ/a2cz8SumjG82iv+wnUXdfXWCBy/NUpI1hz3wiIQ87dUy/sHMBMxOxASvR1tvQkuDwhyL7zsvdp1lZ+J5zVHYN/wSdDIrOroHqsy5Dtv4u9XpkQditvB4Wa77aAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783726934; c=relaxed/simple;
	bh=E9/9TuyHz+vhRwqTt3wnqGuUknTfuECvyapAS5S/naM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=g9gOXJBD9Sz4qN/LPM5AUOvinmGWeq7vctTA+0u7tgbSjlIDogJZhI3H+tg5Bsfyo2a9Z/8RanuMwf7twkrYuiKiskJrW58fr4XwKzUkNgjTD+21Mx72ZHaYOPjztxCRmm9YjlPdtV86qDn7txsa91H6edxAh6t+jYP4JTOWeu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=CyKfJzUC; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="CyKfJzUC"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c9e607d81fcso919094a12.2
        for <bpf@vger.kernel.org>; Fri, 10 Jul 2026 16:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1783726929; x=1784331729; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=R4FB1H/ZXfd+gXZ1WSaZrp9C6WUDHWyhV1zt1MSL4AU=;
        b=CyKfJzUCL2E9jg109Q5c4N3oRZ8P5zHbh19U+HgjcVIqaJMxYBryGhkFfcFCtWGVpb
         B04fyQ0rgyj/VoJ/WZoPRZAOdP+dsbIzsGJvz7ExJgIzMU/u5tPyM9hxgccDFJ748wyc
         7SSgLAkjHICH43kZJOSqjiUYH0QlKEm97kcE01YFiSLCJ0OPHSBcmKBMQAJDyJiPcrOy
         FuPDO9oUFxpjq/Pj5M3pYcxkRglrK2qdf//HRj2pWvHZbQzAHG8KMLZjpqkrSV+IAA6d
         h9topLAnBNLmDr6YMufD5GHkbgDqNKUzT9Qu34ku1h2XYV1KXD4T/tCuLyDA/5/EV5q/
         mBuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783726929; x=1784331729;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=R4FB1H/ZXfd+gXZ1WSaZrp9C6WUDHWyhV1zt1MSL4AU=;
        b=H5a/ncRE7w2tfSnanXcnAaOC8MIs0z4Q3yG4QBjcC0M13pGNU6MtHgq4BarHjHgrPc
         ypUtcT/mBc7rnct7S2MSVQIX0RkIiBplHbjiMm2jOCQLDJooCz5Rs22fR9gZiAWkS8c7
         yN6LFsqZTgso7Sh8VJTD9RpnFyJd/9qbdhZmo5DROyNr4Xa2GOGYlKYb1dNEsrHqlmQD
         zlye1ger9ZIZRxDMDmfuSp3erB4Zd1dJvmQI4RJ5GUGQGxVB+WIS+YmCgzk3ur8tAbx2
         KwxXGjc/ekr5OXqr44QyUQ/HZHPddU7cdiAKqxePxdtpWHsZ0927gwjBwP9LK6V5PG3a
         BytA==
X-Forwarded-Encrypted: i=1; AHgh+RqPnQd+9qMwsoSfv6Pe9DiDCd6PbU50eRKHxgoGP0ttpxK6NnNx//+BHDdJ0SidVNWTCZg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6U7TtonT7utbAJd128Agt7bnwB9FIAymB0IJE/8AaQoSqKI9q
	sAWAL+AVfjpFuR1Z066AAZGef3Bbpmh0pAjQPvmhrhdy3glbZI4rvNy7l7K4I7QQxMo=
X-Gm-Gg: AfdE7ckAekqXdtzArE6yUQgCqX2Y5LTNVjYwTZM4WFML7iZYCB7Te9+bIRDNPM7hsaN
	lRNJhJALeX8JEB/J/YjtYnTIXbRF0gJIx3dBESK3hhx/YQmm1uIdewGYSFt7RUeRXwFqSGaSVyb
	h/293qXBohguECJ9UOuOXVJ5Lf8eiyvOitEef/DxgQycOkIssKlMEzWgSTMyqqO08tHxgkiYApl
	FoVjlaljLupOrzQGQARx0qLt7fbDt3pApfmV/FakCvRvAMI0BifT9zFnGSRtUilC4kFtnFP2K0L
	2hRHZ3q/p+xNI36m0kFMteSrq0k9hxlO7ddNL5L6TuMPqy2IFxWYFH0fvI81auCkeEwLrTm6dN1
	zUpO45UXXw4JpANCVwGtUQoKcydIAH7DfIdaYNGi3GmpCcs0I+mNGngIXiPlgj4gFHN8pHkS3JC
	lIIjs2
X-Received: by 2002:a05:6a21:4a98:b0:3c1:657:4c95 with SMTP id adf61e73a8af0-3c11077660fmr940669637.15.1783726928529;
        Fri, 10 Jul 2026 16:42:08 -0700 (PDT)
Received: from localhost ([2620:10d:c090:600::6185])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-311b00048a3sm14764211eec.5.2026.07.10.16.42.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2026 16:42:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 10 Jul 2026 19:42:06 -0400
Message-Id: <DJVAF9H7DVKE.339TIKL2QFYF6@etsalapatis.com>
Cc: <tj@kernel.org>, <void@manifault.com>, <arighi@nvidia.com>,
 <changwoo@igalia.com>, <bpf@vger.kernel.org>, <sched-ext@lists.linux.dev>
Subject: Re: [PATCH bpf-next v3 1/2] bpf: Require a BPF cpumask for
 bpf_cpumask_populate()
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Nicholas Dudar" <main.kalliope@gmail.com>, <ast@kernel.org>,
 <daniel@iogearbox.net>, <andrii@kernel.org>, <eddyz87@gmail.com>,
 <memxor@gmail.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260709182800.2037938-1-main.kalliope@gmail.com>
 <20260709182800.2037938-2-main.kalliope@gmail.com>
In-Reply-To: <20260709182800.2037938-2-main.kalliope@gmail.com>

On Thu Jul 9, 2026 at 2:27 PM EDT, Nicholas Dudar wrote:
> bpf_cpumask_populate() writes to its destination with bitmap_copy(), but
> the destination is typed as struct cpumask *. That allows the verifier to
> accept borrowed cpumask pointers returned by read-only kfuncs, such as
> scx_bpf_get_online_cpumask(), as a writable destination.
>
> Make the destination a struct bpf_cpumask * so populate follows the same
> ownership rule as the other mutating cpumask kfuncs. Query kfuncs continu=
e
> to accept const struct cpumask * inputs.
>
> Fixes: 950ad93df2fc ("bpf: add kfunc for populating cpumask bits")
> Signed-off-by: Nicholas Dudar <main.kalliope@gmail.com>
> Assisted-by: Claude:claude-opus-4-8

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> ---
>  kernel/bpf/cpumask.c                     | 6 +++---
>  tools/sched_ext/include/scx/compat.bpf.h | 2 +-
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/bpf/cpumask.c b/kernel/bpf/cpumask.c
> index b8c805b4b06a..1336a4efa755 100644
> --- a/kernel/bpf/cpumask.c
> +++ b/kernel/bpf/cpumask.c
> @@ -449,12 +449,12 @@ __bpf_kfunc u32 bpf_cpumask_weight(const struct cpu=
mask *cpumask)
>   * @src__sz: Length of the BPF memory region in bytes.
>   *
>   * Return:
> - * * 0 if the struct cpumask * instance was populated successfully.
> + * * 0 if the struct bpf_cpumask * instance was populated successfully.
>   * * -EACCES if the memory region is too small to populate the cpumask.
>   * * -EINVAL if the memory region is not aligned to the size of a long
>   *   and the architecture does not support efficient unaligned accesses.
>   */
> -__bpf_kfunc int bpf_cpumask_populate(struct cpumask *cpumask, void *src,=
 size_t src__sz)
> +__bpf_kfunc int bpf_cpumask_populate(struct bpf_cpumask *cpumask, void *=
src, size_t src__sz)
>  {
>  	unsigned long source =3D (unsigned long)src;
> =20
> @@ -467,7 +467,7 @@ __bpf_kfunc int bpf_cpumask_populate(struct cpumask *=
cpumask, void *src, size_t
>  		!IS_ALIGNED(source, sizeof(long)))
>  		return -EINVAL;
> =20
> -	bitmap_copy(cpumask_bits(cpumask), src, nr_cpu_ids);
> +	bitmap_copy(cpumask_bits(&cpumask->cpumask), src, nr_cpu_ids);
> =20
>  	return 0;
>  }
> diff --git a/tools/sched_ext/include/scx/compat.bpf.h b/tools/sched_ext/i=
nclude/scx/compat.bpf.h
> index 87f15f296234..3f74d522f7e7 100644
> --- a/tools/sched_ext/include/scx/compat.bpf.h
> +++ b/tools/sched_ext/include/scx/compat.bpf.h
> @@ -84,7 +84,7 @@ bool scx_bpf_dispatch_vtime_from_dsq___old(struct bpf_i=
ter_scx_dsq *it__iter, st
>   *
>   * Compat macro will be dropped on v6.19 release.
>   */
> -int bpf_cpumask_populate(struct cpumask *dst, void *src, size_t src__sz)=
 __ksym __weak;
> +int bpf_cpumask_populate(struct bpf_cpumask *dst, void *src, size_t src_=
_sz) __ksym __weak;
> =20
>  #define __COMPAT_bpf_cpumask_populate(cpumask, src, size__sz)		\
>  	(bpf_ksym_exists(bpf_cpumask_populate) ?			\

