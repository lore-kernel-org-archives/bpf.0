Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16BC344DB9
	for <bpf@vger.kernel.org>; Thu, 12 Feb 2026 11:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770895750; cv=none; b=TziVtkZP26T6zusdB0vcvyZZ+p0m6hn2P6I9OSB0/D/xVO0fv46fshv8nSzxcmxvhM2fBruPYE03H94rBlqxZkwfzLDsx3NctyJnredNx0g/o/iccGqwz8zHAK7dMb6hBQKtgDrb+CgurGdaMJDssHbDkjR8eDhsOX8Up7AaCSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770895750; c=relaxed/simple;
	bh=Gx1vvXbcDJDnpJiOrm7MOVp20kNBtF3rmekpgGStkxw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q9I/Y5bAQTr/xrCdyudbQzHnKXeIjY1MA4WLwepVpe/uE9A5V+oIpNGOam+9VnXGri6LWoe+l3NbrvT9fQd419tXFMcs06eKsiBxjZ6X1lpV3JKY2WMRueYHYc7tabjOkLntNSXwo7n6GY3lbWniwxLeX/lV1RpbBSazYHi/RPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VZbRX4Xx; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VZbRX4Xx"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-4362197d174so2043979f8f.3
        for <bpf@vger.kernel.org>; Thu, 12 Feb 2026 03:29:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770895747; x=1771500547; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=E8/mcInWOKOyu54erChwZBT6B8PNIkwl9baqwd32+Xc=;
        b=VZbRX4XxPNDHqoczjsGF8eJGrgKFSSLftM8nJkGKdnZ3KzVnD/JRKONWRdKpRo+llh
         5m/+quYgS2TlYjNq8WagAGZjn1uupGXFgYqkgPTw3Ae/5K7kuWOjYxJ1G/NdYK8hOsaK
         A2hddi0Hjw//QnUtST8URGXrHuXU6Sy34wbhEcaxS5jA0QeK4/evXcxeZc8Zb1TkVL2z
         10GrY8Y7IvJpJh6bCMqX74LYEZRbUYhO5fmdi2XAi41/yGJhQkbUmJayUPfTQxqd/NI5
         JVxcSaxbcnB86UTIwoQ753Q3Zn8L/2Ds3VwiU920A+mDFCk8V3O/8/CkBoD5o2t7h1TP
         Pzlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770895747; x=1771500547;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E8/mcInWOKOyu54erChwZBT6B8PNIkwl9baqwd32+Xc=;
        b=knynilkZtFiAylcMIy+Vg1AwztgFkafAaBEZNV3MH7ccF0TWc4DjbAykuZfPhAV2Qa
         exFHEOeDvSItFfS8jaMl9ZgQkeT/sxiXwA1hS+CMtbuTn25CtjUY7Yv3MXGgQ51c8ME/
         aPnYDhapF+c9UZ3R2K4xrzPwpV/i9F3o2kFjCrh0dm71RiPSoh1fz7ruAtEbjnV1wt30
         68kcuFwjqa1tLLOBKYxluIfVrfTeDXxSDs+Qucg7v8wLaXs/2WvvSk1mv8jnJck7UJ0+
         iKvrLVEGURuWQw/WVqhwSiw7ERyyVlq8YBZTU8pHa3i+7kc6JbuSevD79ncc/Wju0psm
         Dyig==
X-Forwarded-Encrypted: i=1; AJvYcCWxzrGFv1jOp4gDiLBst4SEnUcKiKct+4LOyFpS0f5TJJ9Z4gkCPnJVxtUK8pA8Xc23/XA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhUzaFdwZwsaX7DwzLKgT7kGfDTM/EqIFxyqdpJ5oFXk5VHttZ
	RKRpDhqPFandbPTnQqn7kHoqRbcEvvQ5oFxcoYkwMaGQQ+zW4iSbL/eS
X-Gm-Gg: AZuq6aJh9pK2UeSLH3MEEvDHQBoslNGENgcpBK/ik+VKKdn/HL3acBxn5/oq2WHwDy/
	B4zfAyIoP07BzDXEFItbTemCYZSeIVn1FfJ045nFtea1HRDFtMGPoKLH1sSXmxI6vtIVmA7UUJX
	2IQdiFgOlDJsU3hrXJz9ZhpR+RWXNqI4HmF93KYDHkvBYI/2EX9QeQiXlhMDEYW31bkK2WTt+gO
	u0Ogvamwkl+MSFevivvg4eDHse38SqAB72E4K6UbgLw4eqlQdzSJmVRoNvXSDuyGBDbi1ngO+Um
	Nokq3eXyaWHumF/VMKRfTqKPGURPoia3YOkJJn8Stx/mVuj07eZ1ReHGq4rZjPzRWIpJZHte0lQ
	7HfRMgSCAriB05E+90tJ+/C6AUuk/37r8v+kBHVu2BnNsvg5hvRiSh/iGtKwtk5WCQKsnSxf9
X-Received: by 2002:a05:600c:470e:b0:479:3a86:dc1c with SMTP id 5b1f17b1804b1-4836717ec41mr27935195e9.36.1770895746931;
        Thu, 12 Feb 2026 03:29:06 -0800 (PST)
Received: from krava ([2a02:8308:a00c:e200::b44f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4835dcfafcdsm177464745e9.9.2026.02.12.03.29.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 03:29:06 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 12 Feb 2026 12:29:04 +0100
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Amery Hung <ameryhung@gmail.com>,
	Mykyta Yatsenko <yatsenko@meta.com>,
	Alexis =?iso-8859-1?Q?Lothor=E9?= <alexis.lothore@bootlin.com>,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH bpf-next v1 04/14] selftests/bpf: Refactor
 bpf_get_ksyms() trace helper
Message-ID: <aY25gB6NDmlPJPUB@krava>
References: <20260212011356.3266753-1-ihor.solodrai@linux.dev>
 <20260212011356.3266753-5-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260212011356.3266753-5-ihor.solodrai@linux.dev>

On Wed, Feb 11, 2026 at 05:13:46PM -0800, Ihor Solodrai wrote:
> ASAN reported a memory leak in bpf_get_ksyms(): it allocates a struct
> ksyms internally and never frees it.
> 
> Moe struct ksyms to trace_helpers.h and return it from the
> bpf_get_ksyms(), giving ownership to the caller. Add filtered_syms and
> filtered_cnt fields to the ksyms to hold the filtered array of
> symbols, previously returned by bpf_get_ksyms().
> 
> Fixup the call sites: kprobe_multi_test and bench_trigger.
> 
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---
>  .../selftests/bpf/benchs/bench_trigger.c      |  9 ++++----
>  .../bpf/prog_tests/kprobe_multi_test.c        | 12 ++++------
>  tools/testing/selftests/bpf/trace_helpers.c   | 23 ++++++++++---------
>  tools/testing/selftests/bpf/trace_helpers.h   | 11 +++++++--
>  4 files changed, 30 insertions(+), 25 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/benchs/bench_trigger.c b/tools/testing/selftests/bpf/benchs/bench_trigger.c
> index aeec9edd3851..7231b88cf21a 100644
> --- a/tools/testing/selftests/bpf/benchs/bench_trigger.c
> +++ b/tools/testing/selftests/bpf/benchs/bench_trigger.c
> @@ -230,8 +230,7 @@ static void trigger_fentry_setup(void)
>  static void attach_ksyms_all(struct bpf_program *empty, bool kretprobe)
>  {
>  	LIBBPF_OPTS(bpf_kprobe_multi_opts, opts);
> -	char **syms = NULL;
> -	size_t cnt = 0;
> +	struct ksyms *ksyms = NULL;
>  
>  	/* Some recursive functions will be skipped in
>  	 * bpf_get_ksyms -> skip_entry, as they can introduce sufficient
> @@ -241,13 +240,13 @@ static void attach_ksyms_all(struct bpf_program *empty, bool kretprobe)
>  	 * So, don't run the kprobe-multi-all and kretprobe-multi-all on
>  	 * a debug kernel.
>  	 */
> -	if (bpf_get_ksyms(&syms, &cnt, true)) {
> +	if (bpf_get_ksyms(&ksyms, true)) {
>  		fprintf(stderr, "failed to get ksyms\n");
>  		exit(1);
>  	}
>  
> -	opts.syms = (const char **) syms;
> -	opts.cnt = cnt;
> +	opts.syms = (const char **)ksyms->filtered_syms;
> +	opts.cnt = ksyms->filtered_cnt;
>  	opts.retprobe = kretprobe;
>  	/* attach empty to all the kernel functions except bpf_get_numa_node_id. */
>  	if (!bpf_program__attach_kprobe_multi_opts(empty, NULL, &opts)) {

hi,

missing free_kallsyms_local call in here ?


> diff --git a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
> index 9caef222e528..f81dcd609ee9 100644
> --- a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
> +++ b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
> @@ -456,25 +456,23 @@ static void test_kprobe_multi_bench_attach(bool kernel)
>  {
>  	LIBBPF_OPTS(bpf_kprobe_multi_opts, opts);
>  	struct kprobe_multi_empty *skel = NULL;
> -	char **syms = NULL;
> -	size_t cnt = 0;
> +	struct ksyms *ksyms = NULL;
>  
> -	if (!ASSERT_OK(bpf_get_ksyms(&syms, &cnt, kernel), "bpf_get_ksyms"))
> +	if (!ASSERT_OK(bpf_get_ksyms(&ksyms, kernel), "bpf_get_ksyms"))
>  		return;
>  
>  	skel = kprobe_multi_empty__open_and_load();
>  	if (!ASSERT_OK_PTR(skel, "kprobe_multi_empty__open_and_load"))
>  		goto cleanup;
>  
> -	opts.syms = (const char **) syms;
> -	opts.cnt = cnt;
> +	opts.syms = (const char **)ksyms->filtered_syms;
> +	opts.cnt = ksyms->filtered_cnt;
>  
>  	do_bench_test(skel, &opts);
>  
>  cleanup:
>  	kprobe_multi_empty__destroy(skel);
> -	if (syms)
> -		free(syms);
> +	free_kallsyms_local(ksyms);
>  }
>  
>  static void test_kprobe_multi_bench_attach_addr(bool kernel)
> diff --git a/tools/testing/selftests/bpf/trace_helpers.c b/tools/testing/selftests/bpf/trace_helpers.c
> index eeaab7013ca2..0e63daf83ed5 100644
> --- a/tools/testing/selftests/bpf/trace_helpers.c
> +++ b/tools/testing/selftests/bpf/trace_helpers.c
> @@ -24,12 +24,6 @@
>  #define TRACEFS_PIPE	"/sys/kernel/tracing/trace_pipe"
>  #define DEBUGFS_PIPE	"/sys/kernel/debug/tracing/trace_pipe"
>  
> -struct ksyms {
> -	struct ksym *syms;
> -	size_t sym_cap;
> -	size_t sym_cnt;
> -};
> -
>  static struct ksyms *ksyms;
>  static pthread_mutex_t ksyms_mutex = PTHREAD_MUTEX_INITIALIZER;
>  
> @@ -54,6 +48,8 @@ void free_kallsyms_local(struct ksyms *ksyms)
>  	if (!ksyms)
>  		return;
>  
> +	free(ksyms->filtered_syms);
> +
>  	if (!ksyms->syms) {
>  		free(ksyms);
>  		return;
> @@ -610,7 +606,7 @@ static int search_kallsyms_compare(const void *p1, const struct ksym *p2)
>  	return compare_name(p1, p2->name);
>  }
>  
> -int bpf_get_ksyms(char ***symsp, size_t *cntp, bool kernel)
> +int bpf_get_ksyms(struct ksyms **ksymsp, bool kernel)
>  {
>  	size_t cap = 0, cnt = 0;
>  	char *name = NULL, *ksym_name, **syms = NULL;
> @@ -637,8 +633,10 @@ int bpf_get_ksyms(char ***symsp, size_t *cntp, bool kernel)
>  	else
>  		f = fopen("/sys/kernel/debug/tracing/available_filter_functions", "r");
>  
> -	if (!f)
> +	if (!f) {
> +		free_kallsyms_local(ksyms);
>  		return -EINVAL;
> +	}
>  
>  	map = hashmap__new(symbol_hash, symbol_equal, NULL);
>  	if (IS_ERR(map)) {
> @@ -679,15 +677,18 @@ int bpf_get_ksyms(char ***symsp, size_t *cntp, bool kernel)
>  		syms[cnt++] = ksym_name;
>  	}
>  
> -	*symsp = syms;
> -	*cntp = cnt;
> +	ksyms->filtered_syms = syms;
> +	ksyms->filtered_cnt = cnt;
> +	*ksymsp = ksyms;
>  
>  error:
>  	free(name);
>  	fclose(f);
>  	hashmap__free(map);
> -	if (err)
> +	if (err) {
>  		free(syms);
> +		free_kallsyms_local(ksyms);
> +	}

I think we could just call free_kallsyms_local unconditionally in here
and fix callers to free syms pointer? seems easier than adding filtered*
fields to ksyms

thanks,
jirak


>  	return err;
>  }
>  
> diff --git a/tools/testing/selftests/bpf/trace_helpers.h b/tools/testing/selftests/bpf/trace_helpers.h
> index a5576b2dfc26..d5bf1433675d 100644
> --- a/tools/testing/selftests/bpf/trace_helpers.h
> +++ b/tools/testing/selftests/bpf/trace_helpers.h
> @@ -23,7 +23,14 @@ struct ksym {
>  	long addr;
>  	char *name;
>  };
> -struct ksyms;
> +
> +struct ksyms {
> +	struct ksym *syms;
> +	size_t sym_cap;
> +	size_t sym_cnt;
> +	char **filtered_syms;
> +	size_t filtered_cnt;
> +};
>  
>  typedef int (*ksym_cmp_t)(const void *p1, const void *p2);
>  typedef int (*ksym_search_cmp_t)(const void *p1, const struct ksym *p2);
> @@ -53,7 +60,7 @@ ssize_t get_rel_offset(uintptr_t addr);
>  
>  int read_build_id(const char *path, char *build_id, size_t size);
>  
> -int bpf_get_ksyms(char ***symsp, size_t *cntp, bool kernel);
> +int bpf_get_ksyms(struct ksyms **ksymsp, bool kernel);
>  int bpf_get_addrs(unsigned long **addrsp, size_t *cntp, bool kernel);
>  
>  #endif
> -- 
> 2.53.0
> 
> 
