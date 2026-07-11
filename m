Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEACA301474
	for <bpf@vger.kernel.org>; Sat, 11 Jul 2026 20:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783802204; cv=none; b=HuINJg775vvsIVaoe9G8UjhEdgvN8ynCAfBGSAn7VLpdmZmkUysoMFA6Wm7nnxTV93pe9X5CK7AX9p6O3CUjXCIwmLr0Rs1I/2p48CNrqBdu9vMLnVZ5BtACzDNys8dv4JianDRclW3mlu3y6GloHw2x0S0clMevODiJgKwW/SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783802204; c=relaxed/simple;
	bh=2dgTfI/XJodV0qrch/DBF4/9UUIJ0kWIW04OEz8+46Y=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DFHdpVL8450XXiCjpi7vZyPF9QrkS36Zs94fP1IlEyOH5AsxsrZXWW0MY2T7WwVMuwKuh50QKNYsNL20XjhTCtjTgwdwI9sNJw+Az0Jrp/QqOwi5GhAj5OVTdVLWW8zmtdALuZwiz9+wlM60LpFzXunQzFPg0ubkhoTuUsfHf9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BAfYSKKH; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BAfYSKKH"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-493f431e317so18524815e9.0
        for <bpf@vger.kernel.org>; Sat, 11 Jul 2026 13:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783802201; x=1784407001; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YLlcSGdxTmLHCyux2hhQn4ZHpYp2OmIxTmU5fTrJllk=;
        b=BAfYSKKH2cIQvIqSs2mypDCmr5OKLkQn7O5rsfqJl5VmBLFGbOgcimrHuj/ZotbQCD
         SZD/Sovf5O1IcwaLanAmnH7HCEHNBL5GxXEgIDJS38wMp9f71nGpswNhwee+J60h1yc8
         k/R96ZPv7PTPJoDXYerrQUyALWeTaLXHXgz9r7QHphjW0cPQtTM+CRFkzE5BqOAXzSMl
         YkTjmzFwoJlgjk25oto2DJkUnci3bpH379830kzICnx7cS7A/ha1ZWC1jHO/0Yv+huQQ
         jPHr89/3qhvEbLxdlbhIP3UXVTN9bOtnJ2YwfuIYSdQhLmHEJ+blh7z68e01UKzJ3XUV
         nRFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783802201; x=1784407001;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YLlcSGdxTmLHCyux2hhQn4ZHpYp2OmIxTmU5fTrJllk=;
        b=ka3ncWiJbj5tR5QKyjKenJCEGCZKPWqDc492X7BrPluE6l1tcEmqSSeVopZIgJMrIS
         NDHE3rpAgrpBbv8pM0awXx5AFR/TfI91K/fvv2n7HLIC8AJZCmb78XJ/YYEzrHUZGP8Z
         xG0IQWTuE0HIV7HE3NCCs4PWCnZEbYojVcNHm1th/yws5pbI3P9JtgBCV6DTIAfOk4h1
         BgRSmgvLN3g8LlQmzIKlmWG2RzxyC8LXTl/bF04HTElmgf13SndcfUBqnN2ABeaAef9X
         xEMXfeA7QmtW9dRue5AsNWG8Ll0FDn8MQ1fHuGTnKVZ7xP3C3bfgA2yA1RcJ44P+8qDS
         guOQ==
X-Gm-Message-State: AOJu0YwvxfA/x08MO2gthgEqDNl2CthL5v6ZxEB1/Brm2YpPbNJFUuTl
	PYVe81aoGfz/271uhw475T5a1uIOhNEy8hKs0fEegnZ2+S/U6nd1kKfr
X-Gm-Gg: AfdE7cllTH87zQowGY7mMvBuW92triBjOM4FE93g44Ggga17KUCsCaeiFy7rnQh7zIM
	k5c3ux6zjBlUKu1XE4l/LcdXuzHwo4FGWEntBpsWJc6yNmKV0u6Sy7WCCQ6mziKO78Pwh++4OC9
	u2Gt18TEqUw0Y1YQqIp35bY70V2Yb/spIg7Kxx+ryDP0yC25IlWM/rF4IyZ8V+ypD2bg9YhaeY6
	XKegHq8jRiKICnL9fOCScYg8l5CVUAub68+pm4WKtV/VtR7/0sPzmyGPhavsMHCqMSLdxCCK9WQ
	fGsKEJD5saS6UNtKYls86oKmpuoR8G5OZxYT8IPI95fywGjKpuPZyFvBla7vc5wVncqPN0THnma
	GM05yTZsWkQnshRacMp8DpPuMSAX3OMd06YAvHH18yeOXsRYdISwgZG/taTDxEAJFjak1M0xrk2
	SyBKBYBAwfcE0=
X-Received: by 2002:a05:600c:46c7:b0:493:bc92:ba9a with SMTP id 5b1f17b1804b1-493f87e4983mr39479415e9.13.1783802200892;
        Sat, 11 Jul 2026 13:36:40 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493eb6ccaf1sm418501875e9.2.2026.07.11.13.36.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 13:36:40 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sat, 11 Jul 2026 22:36:38 +0200
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, kernel-patches-bot@fb.com
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: Test fentry link after
 tracing_multi link
Message-ID: <alKpVgOkHyc7kS_W@krava>
References: <20260711124822.29406-1-leon.hwang@linux.dev>
 <20260711124822.29406-3-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260711124822.29406-3-leon.hwang@linux.dev>

On Sat, Jul 11, 2026 at 08:48:22PM +0800, Leon Hwang wrote:
> Verify that there's no any issue to attach tracing_multi link, then attach
> fentry link.
> 
> Assisted-by: Codex:gpt-5.6-sol
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka


> ---
>  .../selftests/bpf/prog_tests/tracing_multi.c  | 69 +++++++++++++++++++
>  .../progs/tracing_multi_intersect_attach.c    |  8 +++
>  2 files changed, 77 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/tracing_multi.c b/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
> index f02ffc7f41d7..0aa9532a05cf 100644
> --- a/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
> +++ b/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
> @@ -460,6 +460,73 @@ static void test_intersect(void)
>  	tracing_multi_intersect__destroy(skel);
>  }
>  
> +static void test_fentry_after_multi(void)
> +{
> +	static const char * const funcs[] = {
> +		"bpf_fentry_test1",
> +	};
> +	struct bpf_link *fentry_link = NULL, *multi_link = NULL;
> +	struct tracing_multi_intersect *skel = NULL;
> +	LIBBPF_OPTS(bpf_tracing_multi_opts, opts);
> +	LIBBPF_OPTS(bpf_test_run_opts, topts);
> +	__u32 *ids = NULL;
> +	int err;
> +
> +	skel = tracing_multi_intersect__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "tracing_multi_intersect__open_and_load"))
> +		return;
> +
> +	skel->bss->pid = getpid();
> +
> +	ids = get_ids(funcs, ARRAY_SIZE(funcs), NULL);
> +	if (!ASSERT_OK_PTR(ids, "get_ids"))
> +		goto cleanup;
> +
> +	opts.ids = ids;
> +	opts.cnt = ARRAY_SIZE(funcs);
> +	multi_link = bpf_program__attach_tracing_multi(skel->progs.fentry_1, NULL, &opts);
> +	if (!ASSERT_OK_PTR(multi_link, "attach_multi"))
> +		goto cleanup;
> +
> +	fentry_link = bpf_program__attach(skel->progs.fentry);
> +	if (!ASSERT_OK_PTR(fentry_link, "attach_fentry"))
> +		goto cleanup;
> +
> +	err = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.fentry_1), &topts);
> +	if (!ASSERT_OK(err, "test_run"))
> +		goto cleanup;
> +	ASSERT_EQ(skel->bss->test_result_fentry_1, 1, "multi_fentry");
> +	ASSERT_EQ(skel->bss->test_result_fentry, 1, "fentry");
> +
> +	err = bpf_link__destroy(fentry_link);
> +	fentry_link = NULL;
> +	if (!ASSERT_OK(err, "destroy_fentry"))
> +		goto cleanup;
> +
> +	err = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.fentry_1), &topts);
> +	if (!ASSERT_OK(err, "test_run_multi"))
> +		goto cleanup;
> +	ASSERT_EQ(skel->bss->test_result_fentry_1, 2, "multi_fentry_only");
> +	ASSERT_EQ(skel->bss->test_result_fentry, 1, "fentry_detached");
> +
> +	err = bpf_link__destroy(multi_link);
> +	multi_link = NULL;
> +	if (!ASSERT_OK(err, "destroy_multi"))
> +		goto cleanup;
> +
> +	err = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.fentry_1), &topts);
> +	if (!ASSERT_OK(err, "test_run_detached"))
> +		goto cleanup;
> +	ASSERT_EQ(skel->bss->test_result_fentry_1, 2, "multi_fentry_detached");
> +	ASSERT_EQ(skel->bss->test_result_fentry, 1, "fentry_still_detached");
> +
> +cleanup:
> +	bpf_link__destroy(fentry_link);
> +	bpf_link__destroy(multi_link);
> +	free(ids);
> +	tracing_multi_intersect__destroy(skel);
> +}
> +
>  static void test_session(void)
>  {
>  	LIBBPF_OPTS(bpf_test_run_opts, topts);
> @@ -957,4 +1024,6 @@ void test_tracing_multi_test(void)
>  	if (test__start_subtest("attach_api_fails"))
>  		test_attach_api_fails();
>  	RUN_TESTS(tracing_multi_verifier);
> +	if (test__start_subtest("fentry_after_multi"))
> +		test_fentry_after_multi();
>  }
> diff --git a/tools/testing/selftests/bpf/progs/tracing_multi_intersect_attach.c b/tools/testing/selftests/bpf/progs/tracing_multi_intersect_attach.c
> index cd5be0bb6ffd..5b0af8f4c62f 100644
> --- a/tools/testing/selftests/bpf/progs/tracing_multi_intersect_attach.c
> +++ b/tools/testing/selftests/bpf/progs/tracing_multi_intersect_attach.c
> @@ -11,6 +11,14 @@ __u64 test_result_fentry_1 = 0;
>  __u64 test_result_fentry_2 = 0;
>  __u64 test_result_fexit_1 = 0;
>  __u64 test_result_fexit_2 = 0;
> +__u64 test_result_fentry = 0;
> +
> +SEC("fentry/bpf_fentry_test1")
> +int BPF_PROG(fentry)
> +{
> +	tracing_multi_arg_check(ctx, &test_result_fentry, false);
> +	return 0;
> +}
>  
>  SEC("fentry.multi")
>  int BPF_PROG(fentry_1)
> -- 
> 2.55.0
> 
