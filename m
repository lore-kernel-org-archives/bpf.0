Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC5A2D78A
	for <bpf@vger.kernel.org>; Fri, 22 Mar 2024 12:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711110389; cv=none; b=CKsHdZZdkO+wCCNIJMp0Cl/1s1VMDC51IZrSeaVTwx9HK3W9BJSaMRP7mueCenAfb9/BREkPQ9q+M4L1s8m6wIYR1yTrjyBMCvkEBvr66QH2zDTYO8abYFkdEi32RMKW9MFgNFcWNvF+dJiPqVni3MbuT2Y7o286B4u1I2Sc6wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711110389; c=relaxed/simple;
	bh=99scQygKhz+fbPpqrNOnmy5jJtR43QRSqXlyZn5GPRA=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GwIVQOrlPTgDCYtpsGyuRL8ANzLNCwlfAInMxkiWyQbaV//g1STg5ReP9Mg7hKtK2qKS9BLFj++4S53V7t8/VpXvACwCYgCwbrqGGL7QRgGPrkZWbCpYil0j5YjeUflpZcu3iUX3TJ9xkuWhXOYp2IMDSSexOjVHZRn0j9h3SHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gRkC1Ynh; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gRkC1Ynh"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2d2509c66daso27494161fa.3
        for <bpf@vger.kernel.org>; Fri, 22 Mar 2024 05:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711110385; x=1711715185; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SLgrg2q8nea+P1Tj9J2LHHN3qIuPwQknnyRDfnGLM70=;
        b=gRkC1YnhLYtGI9A1cWdRqpjfTKqln4i4oJd1komy6cpIu6PT3nFTVEt2FjAR+BRAUc
         HoMvBWlPLkkPfyvAqVOLPRKOsRdUecb3MILOfUsD+EDGT2FRqgxu0uVTAxTuYgRkdVPB
         WYpj2n1VLQXCxOsg6VpnPirKowf9hyBgjdwfZIZ9KU0Hj+M4Wvb7X4GldsfQsui2jGKP
         Vv4guAyqFgqqmhaGsdwE0Pp0RH/b9qkpva8EG1BsctuzIXKQTaHXdmqxHILj+ghSi0Pg
         ot5PxyMtzt9Tlk8a3Yu0VFFf7cqzAzUWi5uXqJp6BjSjIeuucd5wBgYXfkEOAfKLy/oQ
         hqBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711110385; x=1711715185;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SLgrg2q8nea+P1Tj9J2LHHN3qIuPwQknnyRDfnGLM70=;
        b=i1a9aGDYldnNAJ6TpSEcbuVloqK0tbTnLROUQ6uqHm92XQeWIzZ5CFKbr12KjqTkxJ
         Zt+okliRFPOABOcd1Z5PiLw95Zz+mHvmnOXAahU9ueB1UmxW4FBKXMeyG8ePsgycNeTC
         OfoYbAlPC5/M65KR5YKAm6WGoEJnKTuwBFa46Zi4T5IVS/3FqT10pTp7CYZE4zFah8O8
         lbb+B7F4noqvCu9W7iUEQGiDEMNmEvP7nQNx6QhaJjxAFNGKtE9QkJQkZHfpJssGpx2X
         hlCsM6IC9OT542broJYceHAQRfDcqt1Viggf4rm3obCPaDDTtsNUsn2nuXAnufBBNYYw
         f2sQ==
X-Gm-Message-State: AOJu0YzCYwLOI/cJFxopbslHPr6GNYZLY3k9pdNcbuD5q7bnoFximiXh
	R0FVp/ivAeGnY56MCcvQrBgFxqK34YODhOXLKDJl2ni3lZKBuOaZ
X-Google-Smtp-Source: AGHT+IHAG4E8Us1gR41L9BTjD7cZ8RdKMVPX3jEFVE99HDiz10GFRET39xZi3IJ3MnFxPfDSQiXtKA==
X-Received: by 2002:a2e:918f:0:b0:2d4:6c1c:7734 with SMTP id f15-20020a2e918f000000b002d46c1c7734mr1728922ljg.26.1711110385074;
        Fri, 22 Mar 2024 05:26:25 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id g11-20020a05600c310b00b0041408e16e6bsm2964793wmo.25.2024.03.22.05.26.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 05:26:24 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 22 Mar 2024 13:26:22 +0100
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: Re: [PATCH bpf-next v2 5/5] selftests/bpf: Add a selftest with
 available_filter_functions_addrs
Message-ID: <Zf147sHXbgMs1yDZ@krava>
References: <20240321200058.2218328-1-yonghong.song@linux.dev>
 <20240321200124.2220345-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240321200124.2220345-1-yonghong.song@linux.dev>

On Thu, Mar 21, 2024 at 01:01:24PM -0700, Yonghong Song wrote:
> The current kprobe_multi_bench_attach/kernel test
> reads sym names from /sys/kernel/tracing/available_filter_functions.
> Some names do not agree with the corresponding entries in /proc/kallsyms
> since the corresponding /proc/kallsyms syms have suffix '.llvm.<hash>'.
> Actually, if we pass symbol names in /proc/kallsyms,
> kprobe_multi_attach will be okay.
> 
> This patch added a new subtest where addresses are retrieved from
> /sys/kernel/tracing/available_filter_functions_addrs, and use the
> address to consule /proc/kallsyms to get the function name.

hm, I don't understand the reason for this test.. AFAICS test_kprobe_multi_bench_attach
is doing that already, just reading available_filter_functions file

both available_filter_functions_addrs and available_filter_functions have the
same functions, there's just extra addresses in available_filter_functions_addrs

> +	*symsp = syms;
> +	*cntp = cnt;
> +
> +error:
> +	fclose(f);
> +	hashmap__free(map);
> +	if (err) {
> +		for (i = 0; i < cnt; i++)
> +			free(syms[i]);
> +		free(syms);
> +	}
> +	return err;
> +}
> +
>  static void test_kprobe_multi_bench_attach(bool kernel)
>  {
>  	LIBBPF_OPTS(bpf_kprobe_multi_opts, opts);
> @@ -521,6 +617,47 @@ static void test_attach_override(void)
>  	kprobe_multi_override__destroy(skel);
>  }

there's lot of duplicated code in both
  get_syms_from_addr/get_syms
  test_attach_kernel_addrs_to_sym/test_kprobe_multi_bench_attach

would be great to put it together

>  
> +static void test_attach_kernel_addrs_to_sym(void)
> +{
> +	LIBBPF_OPTS(bpf_kprobe_multi_opts, opts);
> +	struct kprobe_multi_empty *skel;
> +	struct bpf_link *link;
> +	char **syms = NULL;
> +	size_t cnt = 0;
> +	int i, err;
> +
> +	err = get_syms_from_addr(&syms, &cnt);
> +	if (err == -ENOENT) {
> +		test__skip();
> +		return;
> +	}
> +	if (!ASSERT_OK(err, "get_syms_from_addr"))
> +		return;
> +
> +	skel = kprobe_multi_empty__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "kprobe_multi_empty__open_and_load"))
> +		goto cleanup;
> +
> +	opts.syms = (const char **) syms;
> +	opts.cnt = cnt;
> +
> +	link = bpf_program__attach_kprobe_multi_opts(skel->progs.test_kprobe_empty,
> +						     NULL, &opts);
> +
> +	if (!ASSERT_OK_PTR(link, "bpf_program__attach_kprobe_multi_opts"))
> +		goto cleanup;
> +
> +	bpf_link__destroy(link);
> +
> +cleanup:
> +	kprobe_multi_empty__destroy(skel);
> +	if (syms) {
> +		for (i = 0; i < cnt; i++)
> +			free(syms[i]);
> +		free(syms);
> +	}
> +}
> +
>  void serial_test_kprobe_multi_bench_attach(void)
>  {
>  	if (test__start_subtest("kernel"))
> @@ -550,4 +687,6 @@ void test_kprobe_multi_test(void)
>  		test_attach_api_fails();
>  	if (test__start_subtest("attach_override"))
>  		test_attach_override();
> +	if (test__start_subtest("kernel_addrs_to_sym"))
> +		test_attach_kernel_addrs_to_sym();

we moved the bench subtests to serial_test_kprobe_multi_bench_attach,
not to clash with others in parallel mode

jirka
