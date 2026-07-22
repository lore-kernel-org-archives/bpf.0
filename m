Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F17D466AFF
	for <bpf@vger.kernel.org>; Wed, 22 Jul 2026 16:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784738498; cv=none; b=Z2/1Q7nUXb5fSdtvgeCWsu11udh94qpAZZ6qaRbBUFljVLsqf2MkyXE2cr7boAJNrkLJ2aygbLYmldWibSI6Cx6Z0isT42l7Q3ikI20XfOtujYuPP2rHpTWj6PNBXOIjoOfed6tQBV+xuZFqfDUNdI/5yZERxQ7q1MIzY0HhmLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784738498; c=relaxed/simple;
	bh=RXqcfcZSbNb3rB21Ph12lQCkkQdPMp95EfoTarPxUao=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=r5/Xn4m4Upb0igim+j6Jpkq1oQTaqi6PiEny+V0PNRD0ZXs+3twmJCHI3AWYAntHRAye7+HNKQVGNJlE7odlD2Mjhr+RX30vyckGdbpq90qnR2cPPgE2KGdpd+/78C3SOAK1tkLBkjVH2fc35B9C24UocjFdm4KhKBTRf8NhWY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=WzLFxW5f; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="WzLFxW5f"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-38de840f2f0so8693632a91.0
        for <bpf@vger.kernel.org>; Wed, 22 Jul 2026 09:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1784738485; x=1785343285; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Rk7HaColAzxmgyqV5k+/tQbJI9Q9Gz2mbZ9N8yXhieA=;
        b=WzLFxW5fNRJwW96xE+FfglPtzF6bBN4ZJsUodDhGy8X72MW4CnLlUdSipf/kxMVs0N
         dITUpOLCbUMKYBnXq6tsl7WPysUcmMbhpvaFl56Ij/+K+SeiJy38emz0GIgje+JPHMl2
         DfgmWb+k210ye+riXiichKWQCkWO/qTkdxaHxu4PTECAN1EIKiRgD8auGMn+0foiokQj
         THOGuifVYE//CIXjhuizT6J9B19r1hhCCpD1K1DYU6bJHM2sjrFq5QiiZHm//eLJoLQz
         io9xuWXdFEYAVKhazENQemdHXIUYFCkO3NzKiicQvpiIVN7TN5MwF+9otsClbsHJVUr0
         bI3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784738485; x=1785343285;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Rk7HaColAzxmgyqV5k+/tQbJI9Q9Gz2mbZ9N8yXhieA=;
        b=XinaOLCXJ5oWdB+o7fOxr7ukimxRSG986BhRUFzSGcvwkDsZab6N9dqUkLJKg0yONV
         59/jwcvZQ9wUW+1XO/lP6oz2IXujGreMMNIF4Lv88yrYKD0m8864T3b6iLLYdL9aBHYW
         7tTGz5Ctppq3l+jk7YHea3EYsjDdEGBI6sTDrceonkWBkr+KSmOJomE6rDJsdgNKrMA7
         tebd2fyTzZqbL8caj0o7Hk9Bc5welQsY0RMlh6p+dXMH6m8txu6cu0FtUHfnqmRcvQJn
         MEBOyelMN77JMSpDIAuqNfevd9pch5pKeFpTcEQQ04HW/kjKrWI8m1Kk6evQhV5nNNG/
         odbQ==
X-Forwarded-Encrypted: i=1; AHgh+RqDfmSkrgorlMOSJTLRvue88UGSaoCkA23P15RuIPAYGrDeKDb3Ymgbko4Fpq9pc/yv/6o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzOK8SDqqjC77k9CpjqX4Cj96/Y1MGHCwsfDQSm/9A/g/xKj4e
	kfIzzC8+stiYAHZYcu9uUhkarXxYC0wES13hcXHqdLU0L/qQEiBxttnDbVM5EfZCXZ0=
X-Gm-Gg: AR+sD12PUVDpbQ8lkqFKHoodtqKlTcaJ+CxkFylxDfasTHhr6oUlLoY/dVimjfnxuO4
	XZS7RFu4VxElGmetMnGVUQcmEx7/adeK+BRhKUdfA1nCeE+fHFcyW4PK6eNKqIlpGn5y7RvykAz
	qCxZzNwVbw3ryKUyjlaajFhdilQ9dos0YCVdL/o1w9zTXelZCxv3sMQ20nN0SQa1nEybz/366uF
	ZqTVBLe51egoyV9e1vCHnEYx4JDF1y47cEAZ7mQVjnURJY75fPd6QrwRXjG7ueifom3LQ/5Bvnv
	0Z925N+YLA6v8lpEPz+wcbGduTvQrYE1fN9SqvD4Vj5h/q93GcDISU7eUnhFERNju57QXf5LLyc
	YZ+hgrCV/uNPvOJcJ6F7L7SQOHA4r13nKwm0Z5u0Z4XoRSaeZA5xpklU80ZZk3eWODpst3lF+fB
	rx0X8npnWt6daRQll3btcYt+iQMPiMNmI=
X-Received: by 2002:a17:90b:2f4b:b0:37f:9cdf:f03e with SMTP id 98e67ed59e1d1-38e4b540acbmr23711630a91.33.1784738485186;
        Wed, 22 Jul 2026 09:41:25 -0700 (PDT)
Received: from localhost (107-190-31-17.cpe.teksavvy.com. [107.190.31.17])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38e92091875sm3559948a91.7.2026.07.22.09.41.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jul 2026 09:41:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 22 Jul 2026 12:41:23 -0400
Message-Id: <DK58ZON5P6RO.2LTH6C3PKW2VJ@etsalapatis.com>
Cc: "Andrii Nakryiko" <andrii@kernel.org>, "Eduard Zingerman"
 <eddyz87@gmail.com>, "Alexei Starovoitov" <ast@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Martin KaFai Lau" <martin.lau@linux.dev>, "Song Liu"
 <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>, "Jiri Olsa"
 <jolsa@kernel.org>, "Emil Tsalapatis" <emil@etsalapatis.com>, "Shuah Khan"
 <shuah@kernel.org>, "Ihor Solodrai" <ihor.solodrai@linux.dev>,
 <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next] selftests/bpf: Report the real error from
 libarena parallel workers
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Jiayuan Chen" <jiayuan.chen@linux.dev>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260722064713.357277-1-jiayuan.chen@linux.dev>
In-Reply-To: <20260722064713.357277-1-jiayuan.chen@linux.dev>

On Wed Jul 22, 2026 at 2:47 AM EDT, Jiayuan Chen wrote:
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
> Let any other error win over -EINTR, and log each worker that returned an
> error.
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

Overall change makes sense, a couple things.

I'll also look into the error itself.

>
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> ---
>  .../testing/selftests/bpf/prog_tests/libarena.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/libarena.c b/tools/te=
sting/selftests/bpf/prog_tests/libarena.c
> index df7e4b8dc394..65743920ff69 100644
> --- a/tools/testing/selftests/bpf/prog_tests/libarena.c
> +++ b/tools/testing/selftests/bpf/prog_tests/libarena.c
> @@ -112,13 +112,28 @@ static int run_libarena_parallel_test_workers(struc=
t libarena *skel,
> =20
> =20
>  	for (i =3D 0; i < nthreads; i++) {
> +		int worker_err;
> +

Let's hoist this definition up to the top of the function.

>  		ret =3D pthread_join(threads[i], &thread_ret);
>  		if (!ASSERT_OK(ret, "pthread_join")) {
>  			err =3D err ?: ret;
>  			continue;
>  		}
> =20
> -		err =3D err ?: (long)thread_ret;
> +		worker_err =3D (long)thread_ret;
> +		if (!worker_err)
> +			continue;
> +
If we are ignoring -EINTR errors from workers then let's skip the
printing for them altogether, otherwise below we keep printing the
"main" error for every interrupted thread.

> +		/*
> +		 * A worker that bails out because another one already gave up
> +		 * reports -EINTR. That is collateral damage, so let any other
> +		 * error win: it tells us what actually went wrong.

Capitalize "it"

> +		 */
> +		if (!err || err =3D=3D -EINTR)
> +			err =3D worker_err;
> +
> +		fprintf(stdout, "%.*s__%d returned %d\n", (int)prefixlen, name,
> +			i, worker_err);

>  	}
> =20
>  	free(threads);

