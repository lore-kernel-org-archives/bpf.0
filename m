Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035FC2BE02C
	for <bpf@vger.kernel.org>; Fri, 24 Jul 2026 17:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784915344; cv=none; b=q0ZBNhVorfM0yMkVG0K59/dlL7QLMwp0Jc3q2ijjizdSjXky3sWYpXZMzM3QF191r/evvq+YJoL4Tw6tikX8993mYFDGvj9fYI6vUvl10kNQJDdMSbK/EcVKPbGG0Rb6BhHAqIvCFgPO9ITVQYO6X8a/FNlAiiRJjE9kUIo1y3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784915344; c=relaxed/simple;
	bh=56ibPZILETfHThBDfKbmus1vKcZ8DorsFStksKP13ps=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=V4pL4r0cAxWAmqqBlyw7W7MuoIzW5J81Epgav0BSW67w/7V2Q0bOMepUjY5H+TyyOjf+aHY3IqWN2CiHEvFkLlxHAftARdYrHfHXn88OGi8gm2hPwkgf7hDU4T0/GGSEDMv91aR5rZWY/LfPFoE8laWiUfbVpTVvp0t5tDXcHa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=e89bBeIB; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="e89bBeIB"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2cf52d15d88so7827045ad.2
        for <bpf@vger.kernel.org>; Fri, 24 Jul 2026 10:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1784915341; x=1785520141; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=8nT0uL29XlQVyhgfVPiRJ/FmnyaYBwM55XjwIgPxDPM=;
        b=e89bBeIBXChRV32h/rN3zDtAfFNNueE0HAY+/4didJzxZnfPiCo0SNO1z1Gy4vEspN
         m144MIKhQ1bXTCXVLNqJCmkSDH9JzPuhZ/gPR7c6YHbdeR6xewkaugXASYEBPQXWE0nG
         KzmZLQ/f7g6c/Z0chJ//iBjRDxCu+J9pH88/ba8Nzn9z3rNA9LcXSfH3R5FT78/H98WR
         JMmULLPFsvhzynT6WvrN6QQbXdGyViYZAjczEwhN7ISHeRO37CidWs/JumGHjPhkH6QT
         v0Rdu6ixjab8GYKNDjpFZw66ouiAKkh6umJm3RrtXUHX4zPw3C1PkzwXM/SdSQzzsRGM
         ge2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784915341; x=1785520141;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8nT0uL29XlQVyhgfVPiRJ/FmnyaYBwM55XjwIgPxDPM=;
        b=EfYXi3Kl4Bn3oetrl3QhwlLkNseJj4DzuW3ECojwEvlv6CHyIeNVR6+RVlpq+wE7PT
         jzr/xB0lV65+DEGBV2e7jEwIYRdhLrE0ayXCtv7lbZ/bzZmz7I5C142lOUyJZlizbP4N
         QE9c0yhjwaBi73tcIo6GPo8pnkhKqf/dsyXX11BTVFj/bgd6Y1GRGlzrZFBmCn70eWXE
         F+c5/g8n5QyeCHVEMAds649KLl9VzamiCqowlqsXXaVu9Bc5Wog5OIfjKyF/fRRu8Lxo
         l8Rt4OFwK6gaTDcxxgqUWT5pvDt0za+BioywraAfyuTCzIUgPiPpdWBk5AXASP+b11Ik
         AXMQ==
X-Forwarded-Encrypted: i=1; AHgh+RpbeI7boJwIL9Z4bzyH1Jko9woXNwMLSFEFnAu4ZKAv0gzeYmMDE5ySP6ytBsfeGfQA7EY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxT30JSMQVGAUG3qIB8Y9Qb3XBueXygNJLTlQhf/bq7FMNDYANn
	UYLTZmd8vDatmKOmZZuJZcTf2gi8gkSawNohHRbst5p60lNOF0GfcezrD1PYA3wvauo=
X-Gm-Gg: AR+sD11drLaIYyCEyoLmTeIwcc5GoN65FOtqeukAfgHxp5vE4zGOGwq3Rrq03rJY5vd
	asp9rpeLJxwOBdVLVD2Hz5kAOcrAkQpLpVFDlpGoZJGDWR7pfmMqpENgYOpYMN0s93bF+DgIKbA
	tvinQfX33TTgILNrnbRWUCWPmTklRzq2DoFI0fnsD9VjZz//JWLvLcdOjFdq+aV1eGTOSgACdnU
	38fJB0fSMMxqeHAZDIXjbmmZUlGNsku62/MSPJcxkrp0fk4uV9AE29IhavQg73BKg+g5nH+n+Wd
	arpF5XY1B+FxUtxs54JNmvcNSQwHfVVB5MIMh22z6lv9rnyPl38GcoE9jsn/GqqCE68szRpnpTN
	vJBp3RlIgiNSeAQ8KKIRYRXiN9Neb5ARkv1kt5cmWJiEpiy/AArBQ8+pQEfjYB/cGG5aIM25V
X-Received: by 2002:a17:90a:dfc5:b0:38e:3a8:2374 with SMTP id 98e67ed59e1d1-38ec6631d0emr7873518a91.30.1784915341289;
        Fri, 24 Jul 2026 10:49:01 -0700 (PDT)
Received: from localhost ([2620:10d:c090:600::1:5d77])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13d6ba579c3sm889647c88.8.2026.07.24.10.48.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jul 2026 10:49:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 24 Jul 2026 13:48:58 -0400
Message-Id: <DK6ZOIMWWEH5.3TSZNM0MNS8Z3@etsalapatis.com>
To: "Jiayuan Chen" <jiayuan.chen@linux.dev>, <bpf@vger.kernel.org>
Cc: "Andrii Nakryiko" <andrii@kernel.org>, "Eduard Zingerman"
 <eddyz87@gmail.com>, "Alexei Starovoitov" <ast@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Martin KaFai Lau" <martin.lau@linux.dev>, "Song Liu"
 <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>, "Jiri Olsa"
 <jolsa@kernel.org>, "Emil Tsalapatis" <emil@etsalapatis.com>, "Shuah Khan"
 <shuah@kernel.org>, "Ihor Solodrai" <ihor.solodrai@linux.dev>,
 <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next v2] selftests/bpf: Report the real error from
 libarena parallel workers
From: "Emil Tsalapatis" <emil@etsalapatis.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260723061347.398591-1-jiayuan.chen@linux.dev>
In-Reply-To: <20260723061347.398591-1-jiayuan.chen@linux.dev>

On Thu Jul 23, 2026 at 2:13 AM EDT, Jiayuan Chen wrote:
> Several CI runs failed in the libarena parallel tests with -4 (-EINTR) [1=
],
> which says nothing about what actually went wrong.
>
> Two workers can fail like this:
>
>   worker 1: gives up, e.g. the rendezvous times out, sets test_abort and
>             returns its own error (-ETIMEDOUT)
>   worker 2: sees test_abort and returns -EINTR
>
> -EINTR only means "someone else already gave up", so it carries no
> information. Which of the two gets reported depends on the order
> pthread_join() collects them, because
>
> 	err =3D err ?: (long)thread_ret;
>
> keeps the first non-zero value and drops the rest. When the -EINTR worker
> comes first, the error describing the actual failure is lost.
>
> Skip -EINTR entirely: a worker only returns it once another worker has
> already reported the real error, so report and log only the real errors.
>
> It is still unclear whether the timeouts come from CI load or from a
> problem in the test itself. Report the error accurately first, so the nex=
t
> failure can be diagnosed.
>
> [1]:
> https://github.com/kernel-patches/bpf/actions/runs/29867905253/job/887644=
63566
> https://github.com/kernel-patches/bpf/actions/runs/29878191901/job/887948=
45824
>
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

>
> ---
> v1 -> v2:
> - hoist the worker_err declaration to the top of the function
> - skip -EINTR workers entirely: do not aggregate and do not log them
> - comment/commit message wording fixes
>
> v1: https://lore.kernel.org/bpf/20260722064713.357277-1-jiayuan.chen@linu=
x.dev/
> ---
>  .../selftests/bpf/prog_tests/libarena.c        | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/libarena.c b/tools/te=
sting/selftests/bpf/prog_tests/libarena.c
> index df7e4b8dc394..daade4150af6 100644
> --- a/tools/testing/selftests/bpf/prog_tests/libarena.c
> +++ b/tools/testing/selftests/bpf/prog_tests/libarena.c
> @@ -73,6 +73,7 @@ static int run_libarena_parallel_test_workers(struct li=
barena *skel,
>  	uint32_t nthreads;
>  	void *thread_ret;
>  	int ret, err =3D 0;
> +	int worker_err;
>  	int i;
> =20
>  	for (nthreads =3D 0; nthreads < UINT_MAX; nthreads++) {
> @@ -118,7 +119,22 @@ static int run_libarena_parallel_test_workers(struct=
 libarena *skel,
>  			continue;
>  		}
> =20
> -		err =3D err ?: (long)thread_ret;
> +		worker_err =3D (long)thread_ret;
> +
> +		/*
> +		 * A worker that bails out because another one already gave up
> +		 * reports -EINTR. It is collateral damage that carries no
> +		 * information, so skip it entirely: never let it become the
> +		 * reported error, and don't log it either.
> +		 */
> +		if (!worker_err || worker_err =3D=3D -EINTR)
> +			continue;
> +
> +		if (!err)
> +			err =3D worker_err;
> +
> +		fprintf(stdout, "%.*s__%d returned %d\n", (int)prefixlen, name,
> +			i, worker_err);
>  	}
> =20
>  	free(threads);

