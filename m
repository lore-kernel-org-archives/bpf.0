Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58461E892
	for <bpf@vger.kernel.org>; Fri, 22 Mar 2024 12:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711111080; cv=none; b=BaU1zDTpD9fpoZX9x9otzDLSbNW//nbPW7BB/LSFL7FVOOpoE74PnvupgyW0COznQAwZupdJ097f7h6ehDWHq0+spAi940IoRv5HQlfzRpxZaOzqcmAEahaPv89//WeTAGSmSkU3vBzZ0x4k3YGzP3efYRiw+NngJSCiQf4sWYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711111080; c=relaxed/simple;
	bh=oQrhchMVvBH97sJZzwj5GTsv6zJ45LCKNuKCkHMUFqA=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qj33H2HwsoTrdfnWlzbNxllRNm7y4RrFTTlxzqFlwbHXrO95rLNlniyNZ8WFXd5OMGADdnttzxHlAk9/Yx+jT2JkUWw+vr+Ud0iarDS8q88xo/8tkB7p/9d50D3E6It84nmrlzVuutW0sXYuqjefsn6LdxFkuGZr3iFpgaR3v2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XpPCeI7Q; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XpPCeI7Q"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4147b5d8a0dso3848175e9.3
        for <bpf@vger.kernel.org>; Fri, 22 Mar 2024 05:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711111077; x=1711715877; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6RsRQraHAJinl2idq31kkeGHdqanXD9pMzuHqWxlu4Q=;
        b=XpPCeI7Q6OXFRA+SDZLGr4qq2a3RNWUEm2NVCpoIxe1m+F+FHS6Gr2EhP/xjfEWOKR
         EkzUAtGKR9khsvO8P2AsBvmLq1JWOPlgi6WX9lDpvRtD4wB2NSGbVVF19/Mb2qKqXLKE
         nw2j70yP1Lrh8AbTDXAK01qSJXcVz83+eBhf67tNswhybcfjJCO3sBtfWA/sN1d+l9Sv
         7F11ikwUHnQy6ovFfSTou9eroMK1YK/dJNnK9FFRqwFW7mlzXsKhYyJJOruzoolKSsWh
         /RCCFk9qmHEmlNqeBwUldfJT+6YvMsg/k1eGhUcls40JwTUuyEbROKL8CnBVO9gsYPVK
         SKZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711111077; x=1711715877;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6RsRQraHAJinl2idq31kkeGHdqanXD9pMzuHqWxlu4Q=;
        b=DJ1tTOq4BlaGlNJIS/E+sPg0qJuBBDkBga1QAmQLTTelm23SpfBwGtU/7fELkR4p2l
         U78Ny1lQxmTXPHaxTZzTziC+UlkVM5InlMwvo65Em1wOoA7jqYNDFJcsU4Zwd1uDYD9S
         hW5scyAmiFOjNTIX1FV9wDykcEmdcOmVfU2uQ/gRClfCZLJEEah4TJrsppRF8HDDzlkC
         wQAFx0GII5HDPcaTzKdXPJzJ/9YSm+2nO4DGMeYofkuZ+q3xZDZlaXy9UnsLW1F/x6PI
         Hx05eXumKhhV9i5qiV1Q0IRiHwDzYOJCFYVCCf+Z4wAuofOaa4R8PeITUxaygl9Xer56
         jMZw==
X-Gm-Message-State: AOJu0Yy705gkXDQ6VWI9id/Uc9A9F/nUl/N/KPyVvKzBJ+FjLFZjzTOl
	zj8ItwfLLDStU6tJgHSfvYlSRV3FY66l3O5VIUlXY7QADeekrtcO
X-Google-Smtp-Source: AGHT+IGJdjoy3asmzkvcnBOHmppCtEox1Zkz8XSWM041lf1+MRI4SqM76fgy2xXrkb+CyWxdc0ZgIQ==
X-Received: by 2002:a05:600c:35c9:b0:414:132e:b485 with SMTP id r9-20020a05600c35c900b00414132eb485mr1424501wmq.27.1711111076958;
        Fri, 22 Mar 2024 05:37:56 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id fk12-20020a05600c0ccc00b004147dd0915dsm1009989wmb.21.2024.03.22.05.37.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 05:37:56 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 22 Mar 2024 13:37:54 +0100
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: Re: [PATCH bpf-next v2 4/5] selftests/bpf: Fix
 kprobe_multi_bench_attach test failure with LTO kernel
Message-ID: <Zf17ovmfcfAfAIBa@krava>
References: <20240321200058.2218328-1-yonghong.song@linux.dev>
 <20240321200119.2220027-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240321200119.2220027-1-yonghong.song@linux.dev>

On Thu, Mar 21, 2024 at 01:01:19PM -0700, Yonghong Song wrote:
> In my locally build clang LTO kernel (enabling CONFIG_LTO and
> CONFIG_LTO_CLANG_THIN), kprobe_multi_bench_attach/kernel subtest
> failed like:
>   test_kprobe_multi_bench_attach:PASS:get_syms 0 nsec
>   test_kprobe_multi_bench_attach:PASS:kprobe_multi_empty__open_and_load 0 nsec
>   libbpf: prog 'test_kprobe_empty': failed to attach: No such process
>   test_kprobe_multi_bench_attach:FAIL:bpf_program__attach_kprobe_multi_opts unexpected error: -3
>   #117/1   kprobe_multi_bench_attach/kernel:FAIL
> 
> There are multiple symbols in /sys/kernel/debug/tracing/available_filter_functions
> are renamed in /proc/kallsyms due to cross file inlining. One example is for
>   static function __access_remote_vm in mm/memory.c.
> In a non-LTO kernel, we have the following call stack:
>   ptrace_access_vm (global, kernel/ptrace.c)
>     access_remote_vm (global, mm/memory.c)
>       __access_remote_vm (static, mm/memory.c)
> 
> With LTO kernel, it is possible that access_remote_vm() is inlined by
> ptrace_access_vm(). So we end up with the following call stack:
>   ptrace_access_vm (global, kernel/ptrace.c)
>     __access_remote_vm (static, mm/memory.c)
> The compiler renames __access_remote_vm to __access_remote_vm.llvm.<hash>
> to prevent potential name collision.
> 
> The kernel bpf_kprobe_multi_link_attach() and ftrace_lookup_symbols() try
> to find addresses based on /proc/kallsyms, hence the current test failed
> with LTO kenrel.
> 
> This patch removed __access_remote_vm and other similar functions from
> kprobe_multi_attach by checking if the symbol like __access_remote_vm
> does not exist in kallsyms with LTO kernel. The test succeeded after this change:
>   #117/1   kprobe_multi_bench_attach/kernel:OK
> 
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>  .../selftests/bpf/prog_tests/kprobe_multi_test.c     | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
> index 05000810e28e..f6130f4f3d88 100644
> --- a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
> +++ b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
> @@ -345,6 +345,9 @@ static int get_syms(char ***symsp, size_t *cntp, bool kernel)
>  	FILE *f;
>  	int err = 0;
>  
> +	if (!ASSERT_OK(load_kallsyms(), "load_kallsyms"))
> +		return -EINVAL;
> +
>  	/*
>  	 * The available_filter_functions contains many duplicates,
>  	 * but other than that all symbols are usable in kprobe multi
> @@ -393,6 +396,15 @@ static int get_syms(char ***symsp, size_t *cntp, bool kernel)
>  		if (!strncmp(name, "__ftrace_invalid_address__",
>  			     sizeof("__ftrace_invalid_address__") - 1))
>  			continue;
> +		/*
> +		 * In certain cases, e.g., clang lto kernel, the 'name' here
> +		 * may be different from the one in /proc/kallsyms due to
> +		 * /proc/kallsyms name might be "<name>.llvm.<hash>" instead
> +		 * of "<name>". Exclude these 'name's since they will cause
> +		 * later kprobe_multi_attach failure.
> +		 */
> +		if (ksym_get_addr(name) == 0)
> +			continue;

curious how many symbols like that are there?

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

>  
>  		err = hashmap__add(map, name, 0);
>  		if (err == -EEXIST) {
> -- 
> 2.43.0
> 
> 
