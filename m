Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B107327BF8
	for <bpf@vger.kernel.org>; Sun,  1 Mar 2026 19:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772395202; cv=none; b=ZF2YM5oSOGY6DqvGV6pYY0lvfJcxCxQWQ76XpXQu62WeWxL2PbshPbpUv43lDMZ6DiolPV2OIe4jSgXs3PlGHQTtGrFI0/NGcGTyjty/Y9gYpqmMgDkcB/V0hEe+NS7TETIDdVZ1kJ0L93Pvzl7HHExUlrFCumobMuChKtzzLgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772395202; c=relaxed/simple;
	bh=WWIkJNVmNbb5s40Lw7qY9ZV/U/jfKqwR3caVxyzHWEk=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=UPnPLQH1nCyAO6ycfHbJMMEAIyhKLJe0kTZAvibUEszX2DmsTLrKi3a+509fmDpztOo8JocTvR1Gowx4YiXLlWeE9990+F4xMOZMhKuCBqvDHVookxNwmCn31x4irGgOogh2ZGZvKoQbieeEtiI0sTTkC5Ubn0L456Zuu9V4nqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=QhqX+In/; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="QhqX+In/"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-506aa68065eso39203711cf.1
        for <bpf@vger.kernel.org>; Sun, 01 Mar 2026 11:59:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1772395199; x=1772999999; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2MPuDLHfqvO1ZyfsytNxtGmAvrYVDUhBX3Sj2y7Z8a8=;
        b=QhqX+In/jpocOt8pcFOqGN/WoqxqFpgjExgLkzFY/1cYnojI3vKo5C10Y1dcGVd+xK
         eX2ORL/zKJafjLDicg+SlcqrDIS9F5/G5TtlZRHG1Cfan16566jALO6qjWHxLNLdbStD
         6BeBx3iftJDMfuRW/qq7oRC53AznzUwH0wXrLjqe2pHQlEGtgJA9q+TGlSitTZGOA6CC
         xwIoYUfomNrPp2QL8QUa3iDeNoFxzrcMk8tH8sBrjtPwATZMSHpyONcscvqo9jc+GWzu
         Tc+/F8JvR/MuRBY35HUm1fADKz/2mVufYaZ+SjN2WAA/E+07LnzGafxGcBcaC6xktN/d
         iR5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772395199; x=1772999999;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2MPuDLHfqvO1ZyfsytNxtGmAvrYVDUhBX3Sj2y7Z8a8=;
        b=DTRTz2i68Qc0fpY9lekGDZr8fmFDpEsub5jqdrCN4VaZz6bXcoYd43BV61k20tpTqX
         Sz9CxrpqdZT0OrBinsQeZb3cctaunHRbOvs/EaCAnvMRx6kZvlttz7IeC4WKPP1fr2A+
         gRWexHrAC9RzuPvGtuPAvpihGBR4J80VeoMjdrR586ybfT8srrfHNhU1TPI9YJfcPF35
         QzRSByGB6ZwAeKEL4Bcx9rXEnZ29Ktk2TcsAABbk+iNCr+HNi4yozheUFEobiNJa3Ls4
         GC6G8Jns//v/2fKxeuccyn5kplaTZlvyYQ44iLrbQZvM2KNk7t9yTkvCrW6P0la4D+xw
         cx2A==
X-Forwarded-Encrypted: i=1; AJvYcCXlYiRx3cLlS1gbKkR5n69adhEpWXnNpxYcDcXCAfak0ytJKL4d8I0vnNg4kFUrzEZHsJo=@vger.kernel.org
X-Gm-Message-State: AOJu0YygvKsZI9qIqTujSKuwfjd1RrFCIO/fnwbyj30a225D1REFHNym
	KQgPSqTuv8jMRQcQIYs6m3yyka0htc+rItfNK8Y+q0jdrN8rImzfCUIgD6zvHeOsaYY=
X-Gm-Gg: ATEYQzwUkkXXO6W0RMoqkP2WPCv4L4ZFWYbvuGdj8vMphOgzijyjktwIOMm9sAHyjgC
	usFfauGTMR21yaguMsIIPp3WWcYYMUTOgcZcVgFpRgmna0JwN7XzJkOqg1wk/Obsmdbiy4QdLf1
	jJKqoAh0mDwgbowHuNTAJ1gXrDcmns1m+xl3n+ruidpvpjy/wGQOXaWK2GovnM0Sre5Z/e/Z3BP
	AqtYF25ySK96SH3WkR9BDi2fjE3d+HC1loQWYV2QublghZZqO4tLtFXMT3MXD5BaBo5BA04WzYp
	UfjqNQhPP86fzLgI2lVwaQny79GFcdGZl29Uwjoh94yAYXQdKbeN2A7WiznBKLBJdQ+WyxIYvKh
	0iMt+8GaRQU5WV0oKqghcke/HRgL6fi0wbY3zc4zsyleX0lUyGi+AStym3735OPbOtf+OwE+2a5
	TyeaY3RjpL7STQC9opqDMDzW4jMqgibg2+Gw==
X-Received: by 2002:ac8:5d15:0:b0:506:a22d:9c71 with SMTP id d75a77b69052e-507528fcf08mr127998801cf.33.1772395198897;
        Sun, 01 Mar 2026 11:59:58 -0800 (PST)
Received: from localhost ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-899fc95502dsm4630116d6.25.2026.03.01.11.59.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Mar 2026 11:59:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 01 Mar 2026 14:59:57 -0500
Message-Id: <DGRPNT4T4EJP.1USTJ2K0RETA3@etsalapatis.com>
To: "Sun Jian" <sun.jian.kdev@gmail.com>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Shuah Khan" <shuah@kernel.org>
Cc: "Eduard Zingerman" <eddyz87@gmail.com>, "Alexei Starovoitov"
 <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>,
 <bpf@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] selftests/bpf: bpf_cookie: make perf_event subtest
 trigger reliably
From: "Emil Tsalapatis" <emil@etsalapatis.com>
X-Mailer: aerc 0.20.1
References: <20260227164037.84110-1-sun.jian.kdev@gmail.com>
 <20260227164037.84110-3-sun.jian.kdev@gmail.com>
In-Reply-To: <20260227164037.84110-3-sun.jian.kdev@gmail.com>

On Fri Feb 27, 2026 at 11:40 AM EST, Sun Jian wrote:
> The perf_event subtest relies on SW_CPU_CLOCK sampling to trigger the BPF
> program, but the current CPU burn loop can be too short on slower systems
> and may fail to generate any overflow sample. This leaves pe_res unchange=
d
> and makes the test flaky.
>
> Make burn_cpu() take a loop count and use a longer burn only for the
> perf_event subtest. Also scope perf_event_open() to the current task to
> avoid wasting samples on unrelated activity.
>
> Tested:
>   ./test_progs -t bpf_cookie/perf_event -vv (30 runs): 0 failures
>
> Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

Nit below, but change makes sense.

> ---
>  .../selftests/bpf/prog_tests/bpf_cookie.c       | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c b/tools/=
testing/selftests/bpf/prog_tests/bpf_cookie.c
> index 50f5e11e6e65..35adc3f6d443 100644
> --- a/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
> +++ b/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
> @@ -6,6 +6,7 @@
>  #include <sys/syscall.h>
>  #include <sys/mman.h>
>  #include <unistd.h>
> +#include <linux/compiler.h>
>  #include <test_progs.h>
>  #include <network_helpers.h>
>  #include <bpf/btf.h>
> @@ -431,11 +432,12 @@ static void tp_subtest(struct test_bpf_cookie *skel=
)
>  	bpf_link__destroy(link3);
>  }
> =20
> -static void burn_cpu(void)
> +static void burn_cpu(long loops)
>  {
> -	volatile int j =3D 0;
> +	long j =3D 0;

Nit: AFAICT most of these changes are unnecessary, you could just bump
the cycle count to 100M and add the barrier. Moving everything to longs
and factoring out the loop count is unnecessary.

>  	cpu_set_t cpu_set;
> -	int i, err;
> +	long i;

> +	int err;
> =20
>  	/* generate some branches on cpu 0 */
>  	CPU_ZERO(&cpu_set);
> @@ -443,9 +445,10 @@ static void burn_cpu(void)
>  	err =3D pthread_setaffinity_np(pthread_self(), sizeof(cpu_set), &cpu_se=
t);
>  	ASSERT_OK(err, "set_thread_affinity");
> =20
> -	/* spin the loop for a while (random high number) */
> -	for (i =3D 0; i < 1000000; ++i)
> +	for (i =3D 0; i < loops; ++i) {
>  		++j;
> +		barrier();
> +	}
>  }
> =20
>  static void pe_subtest(struct test_bpf_cookie *skel)
> @@ -470,7 +473,7 @@ static void pe_subtest(struct test_bpf_cookie *skel)
>  	if (!ASSERT_OK_PTR(link, "link1"))
>  		goto cleanup;
> =20
> -	burn_cpu(); /* trigger BPF prog */
> +	burn_cpu(100000000L); /* trigger BPF prog */
> =20
>  	ASSERT_EQ(skel->bss->pe_res, 0x100000, "pe_res1");
> =20
> @@ -489,7 +492,7 @@ static void pe_subtest(struct test_bpf_cookie *skel)
>  	if (!ASSERT_OK_PTR(link, "link2"))
>  		goto cleanup;
> =20
> -	burn_cpu(); /* trigger BPF prog */
> +	burn_cpu(100000000L); /* trigger BPF prog */
> =20
>  	ASSERT_EQ(skel->bss->pe_res, 0x200000, "pe_res2");
> =20

