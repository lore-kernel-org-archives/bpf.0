Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC054176D
	for <bpf@vger.kernel.org>; Fri, 22 Mar 2024 12:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711111087; cv=none; b=GWcofF8UrQVEoKgX7Gxocsw6Ybuhoq8ZXVsVXzFaZoF/5FdKpy68Ae6rxwBWyrYw9GPvsLuhHi/LLG1tvgA5JTOMu7OwnQviyF3T5+3zdk4lhGUrov8iZSDAW8qMBONnx4ECN7OVqbPrFj4r4S90F5L2Ake7AVZmPbJcZ3c/5EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711111087; c=relaxed/simple;
	bh=kL1ujXU4kxp/pNMIVJUvZco+IkxUINwZArJnDRSDh9A=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FXubECBTSYa3EN0du79N6NvhI7+7Wh90jP6hwwGMvxTeA1IAQSDrCc6ev70TMd9VQnxikIWdwrFyE05JnnxAmYdDOTCIu/5b2vi2Mvxu1IQ7fb+EjLT+Isd4z9J4xfEDIxyKVvlOAL7/bqsge0yQnu+aKhPq1DxMiW0HhwVmJS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EXTLnFTS; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EXTLnFTS"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-41477e77151so8725875e9.2
        for <bpf@vger.kernel.org>; Fri, 22 Mar 2024 05:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711111083; x=1711715883; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KCoujfogz+us42j8ESknoUMe5fkwCg2/rUQOeR4krbg=;
        b=EXTLnFTSB4Ro8fINdn6T/CGO1uXkBQa3oehg2Pd7/kXbLQOnb2RrImJqyCQv3lKIyU
         F1m2rFgOllgNqFEI3G1/EQiolfl7Tx18nmSA7OUNkTD7prgwvqikgQu5ji+/dfmRB7AA
         TC1BJ6uoutut5ab9B4sDiLzRO5QADT6gyREQiN2vmlQMuqhcTB+4+zNNPMXKH+YTObTB
         wXt5bmBN6RakcA0fz2Rm/AOBG1Svso0BTKCNhzuv3zrTvSG22v3XgZRb/8X9xQ9ubdlX
         qQ5NYD7LCCKuG5wKytHL0hiXjt9OgXmtoD/aNnqkrleTpUw7YEkDs9RC7J+xj3/bEo6E
         Diqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711111083; x=1711715883;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KCoujfogz+us42j8ESknoUMe5fkwCg2/rUQOeR4krbg=;
        b=XG89DG4nGbkOvMUJf5mlFm3KSE68Suqgzp36bpdKycFz0JYz9VMvV/lFaIie7WxK9E
         TPfw0YqISLw6OKRRtOudc8SEZnRr2gmAJnM1X4lIYITgWILBbL/aSyomvMIkaLjhtSol
         JadHdMhmahyz5RO8H8l80vxmLhf5ulkUjS25CSrxiviPJYSmBmqdChuOlN/t5B4GMNZd
         bvxKJTS9Ro9HTZcL5Bfp4EW2cXUyLgGLzdpz1Ybsq9ZDkEiIoUPtNKiDti21Jd6SaIlz
         CImfWLauUl8RmhAjQeHMEK4w2lvEw9jEUHjkk1+zCL4Ai08NadN54/iHuw46Ye7uw6C0
         Betg==
X-Gm-Message-State: AOJu0YwWKOEcA+7nNGG5lEu6ywv1QYFR4neOt88+t/rBlJP1h4/X0iQO
	myShJnTmDJLfHT0NLsA4GwnO4ML2PynLj4ypvQvcZM2dFQx8yhU+
X-Google-Smtp-Source: AGHT+IGXBufbklJZknn7A0PLgNbBq8tueAIPJcHIcCeoobV91LwmKU7ZQOTXLcZ6cueh59L+iljlYA==
X-Received: by 2002:a05:6000:1042:b0:33f:6ec0:d228 with SMTP id c2-20020a056000104200b0033f6ec0d228mr1491064wrx.1.1711111083383;
        Fri, 22 Mar 2024 05:38:03 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id t17-20020a0560001a5100b0033dd2c3131fsm1996168wry.65.2024.03.22.05.38.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 05:38:03 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 22 Mar 2024 13:38:01 +0100
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: Re: [PATCH bpf-next v2 1/5] selftests/bpf: Replace CHECK with ASSERT
 macros for ksyms test
Message-ID: <Zf17qT_wvwQ8MtVq@krava>
References: <20240321200058.2218328-1-yonghong.song@linux.dev>
 <20240321200103.2218888-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240321200103.2218888-1-yonghong.song@linux.dev>

On Thu, Mar 21, 2024 at 01:01:03PM -0700, Yonghong Song wrote:
> I am going to modify ksyms test later so take this opportunity
> to replace old CHECK macros with new ASSERT macros.
> No functionality change.
> 
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

> ---
>  .../testing/selftests/bpf/prog_tests/ksyms.c  | 30 ++++++-------------
>  1 file changed, 9 insertions(+), 21 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/ksyms.c b/tools/testing/selftests/bpf/prog_tests/ksyms.c
> index b295969b263b..6a86d1f07800 100644
> --- a/tools/testing/selftests/bpf/prog_tests/ksyms.c
> +++ b/tools/testing/selftests/bpf/prog_tests/ksyms.c
> @@ -5,8 +5,6 @@
>  #include "test_ksyms.skel.h"
>  #include <sys/stat.h>
>  
> -static int duration;
> -
>  void test_ksyms(void)
>  {
>  	const char *btf_path = "/sys/kernel/btf/vmlinux";
> @@ -18,43 +16,33 @@ void test_ksyms(void)
>  	int err;
>  
>  	err = kallsyms_find("bpf_link_fops", &link_fops_addr);
> -	if (CHECK(err == -EINVAL, "kallsyms_fopen", "failed to open: %d\n", errno))
> -		return;
> -	if (CHECK(err == -ENOENT, "ksym_find", "symbol 'bpf_link_fops' not found\n"))
> +	if (!ASSERT_TRUE(err != -EINVAL && err != -ENOENT, "bpf_link_fops"))
>  		return;
>  
>  	err = kallsyms_find("__per_cpu_start", &per_cpu_start_addr);
> -	if (CHECK(err == -EINVAL, "kallsyms_fopen", "failed to open: %d\n", errno))
> -		return;
> -	if (CHECK(err == -ENOENT, "ksym_find", "symbol 'per_cpu_start' not found\n"))
> +	if (!ASSERT_TRUE(err != -EINVAL && err != -ENOENT, "__per_cpu_start"))
>  		return;
>  
> -	if (CHECK(stat(btf_path, &st), "stat_btf", "err %d\n", errno))
> +	if (!ASSERT_OK(stat(btf_path, &st), "stat_btf"))
>  		return;
>  	btf_size = st.st_size;
>  
>  	skel = test_ksyms__open_and_load();
> -	if (CHECK(!skel, "skel_open", "failed to open and load skeleton\n"))
> +	if (!ASSERT_OK_PTR(skel, "test_ksyms__open_and_load"))
>  		return;
>  
>  	err = test_ksyms__attach(skel);
> -	if (CHECK(err, "skel_attach", "skeleton attach failed: %d\n", err))
> +	if (!ASSERT_OK(err, "test_ksyms__attach"))
>  		goto cleanup;
>  
>  	/* trigger tracepoint */
>  	usleep(1);
>  
>  	data = skel->data;
> -	CHECK(data->out__bpf_link_fops != link_fops_addr, "bpf_link_fops",
> -	      "got 0x%llx, exp 0x%llx\n",
> -	      data->out__bpf_link_fops, link_fops_addr);
> -	CHECK(data->out__bpf_link_fops1 != 0, "bpf_link_fops1",
> -	      "got %llu, exp %llu\n", data->out__bpf_link_fops1, (__u64)0);
> -	CHECK(data->out__btf_size != btf_size, "btf_size",
> -	      "got %llu, exp %llu\n", data->out__btf_size, btf_size);
> -	CHECK(data->out__per_cpu_start != per_cpu_start_addr, "__per_cpu_start",
> -	      "got %llu, exp %llu\n", data->out__per_cpu_start,
> -	      per_cpu_start_addr);
> +	ASSERT_EQ(data->out__bpf_link_fops, link_fops_addr, "bpf_link_fops");
> +	ASSERT_EQ(data->out__bpf_link_fops1, 0, "bpf_link_fops1");
> +	ASSERT_EQ(data->out__btf_size, btf_size, "btf_size");
> +	ASSERT_EQ(data->out__per_cpu_start, per_cpu_start_addr, "__per_cpu_start");
>  
>  cleanup:
>  	test_ksyms__destroy(skel);
> -- 
> 2.43.0
> 
> 
