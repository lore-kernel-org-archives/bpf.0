Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5677A330641
	for <bpf@vger.kernel.org>; Thu, 19 Mar 2026 08:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773907762; cv=none; b=r75U8/+elFzRPTv9NTQdiN4H2XhJadarnPQkG56LiVGzMMO/PoK1/UVJfbqhisk0rr+/d0tCJl80oMsTKHvlxnCv626HSMHALgTouV8LKuigmgQuHufCScCKjSs/QG0AiFOMzciibIt0WiGrRXerqOdVnLDopQMRRshZ13dY0rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773907762; c=relaxed/simple;
	bh=9HCjcz1ZaBKpGqOlxhy2gEzigHWfwfIbgjPAOTBjU40=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gv7oF5XxJ+sBGJbQzSqL+fabSCkiOIPFnIdxQT1BJGVnuymV4d/KSd2bFA+iPGn0NvX9jelXiOqrpxrZnvh0UmieLj85nIiHa0Styl/cxVonEt0b4F9NbK/fEQW3kVEsVj/Zf7D+c4jgi4l7gWxzB7vHdJbHvUumOHzC3kKI9sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BmicJZwQ; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BmicJZwQ"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4852f8ac7e9so3738505e9.1
        for <bpf@vger.kernel.org>; Thu, 19 Mar 2026 01:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773907760; x=1774512560; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=i5/KWZ2KC3mOSlZnSNWNvP91BfBBZR4N9DqaTZXz5O0=;
        b=BmicJZwQWGQ37KgDjl7YkM2JNwUt43L/QNeKoY2bXWRxZtVb91qX0wVmcJSE2G/F++
         aXfkOeXceusVE0PR+rHoFpVkUo4+hKzb7URLrVzQ3zLutyDenM79c0iDu0mW4ZqsFzT+
         Dj6qSYkNeieHBkVetEVjkNaMcKlLlP8W410/MKd09OFLqkCEY/YZ8K5uc6FJAKSxJfoy
         fqbI6dyJSKNInPKjqU5axbxwjmhNrhHQ6P20QqGkw+q0VdEsCaN7fsvvYqVeNnLv87J8
         vrN/8+mYt9c2U5+y8EFQU/Ns5gRQUedeoWh8o46jf0a8xJzgG/w7UMJ2p4E1W5lLtUkQ
         v/LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773907760; x=1774512560;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i5/KWZ2KC3mOSlZnSNWNvP91BfBBZR4N9DqaTZXz5O0=;
        b=VWR7gZqDEZ75z7BrL0Z+lXEqtQFGt4ykdY8a0scaeK6Ww5+i62ZOkdmVP+jJDgZ8Lt
         i7A5FFJqZa1JqXS4zKFG5fQDLgdhXCrEYNlsfzIFP1auebT/vVWDduvtkumAuPBq8+RB
         yAEMC4cUTKr8L4Ec1Na+R+CwXDLmYmx8s9UqjTkX/xv6uguBw3iJ5ppNis2jho2jqsPp
         A0MaEFPTyRpr2VSsihK6HJ+binft3zElBX8WFIqdtbB/pA5YijfSSJjWP9LsC2NmcZ9h
         U5Cme0Wyu0tCXHfwA4/0qHXelr4/iUnlgPMLA27cpcS6tOi1m6VOmuyWtWNruMvWJ6FD
         f2fg==
X-Forwarded-Encrypted: i=1; AJvYcCVWgzlq/ykyRH/7btEmI8lMv5TPmEktfUDniWB2KCioEPGr3J5iGMggP+7Z/frrFV9Jh/o=@vger.kernel.org
X-Gm-Message-State: AOJu0YydXLVpCnMEfbBzCq+UeGSbcCJboSHxL9Wgb3wB7CVwLwSgBw4S
	60EUIr6oyy9UBoGk1ad7S0IdlBwTi9V2GjekQLdMVv9PHhGoQdkCoF6i
X-Gm-Gg: ATEYQzxHd1IxdIgESrRcXuSFSO9WI5ED+GvbrCoK+oXN5/nt0MonsVRq8Nn47muyb/A
	CqRdOEUYWTR5krKeHo8qrgsvvbRmU4C6gYTflWvEXTstPHfpmcLKLh/WPplULlZ8s+XjxaOQNcr
	wjGdSgo2KunAag7RaKojnYDYuoLW5emPfqzFRBkwT751MeLg8DkvCv/ULGhdLmkToTHfAqTZINR
	mwOW+6rYAEj+vNSinYFoQpl8+FFjrK+Uq5SJSRk35RSq9fyNga31py8ED/fwDftal1wjIZT29Wt
	rpp1UAmx6CU6/vzv+LISNGMHI174F59vnGW0RxLggsmUXowJ2N1tgn3E2Bmg2NnNfKOd1ubkXMw
	d0IQZW4gvfw5YQmbPn9iyxzTqbLhh8i1dx4t49EBxgJv5WWI9SDII4zaXY31v5UvHk3Ri52vd
X-Received: by 2002:a05:600c:4585:b0:483:709e:f238 with SMTP id 5b1f17b1804b1-486f4479926mr106286935e9.29.1773907759363;
        Thu, 19 Mar 2026 01:09:19 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200::d99c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486f462caf0sm56441725e9.2.2026.03.19.01.09.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 01:09:18 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 19 Mar 2026 09:09:16 +0100
To: Sun Jian <sun.jian.kdev@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	shuah@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com,
	song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
	paul.chaignon@gmail.com, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] selftests/bpf: move trampoline_count to dedicated
 bpf_testmod target
Message-ID: <abuvLDBz2GJ6cx_X@krava>
References: <20260319031227.330505-1-sun.jian.kdev@gmail.com>
 <20260319040337.366375-1-sun.jian.kdev@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260319040337.366375-1-sun.jian.kdev@gmail.com>

On Thu, Mar 19, 2026 at 12:03:37PM +0800, Sun Jian wrote:
> trampoline_count fills all trampoline attachment slots for a single
> target function and verifies that one extra attach fails with -E2BIG.
> 
> It currently targets bpf_modify_return_test, which is also used by
> other selftests such as modify_return, get_func_ip_test, and
> get_func_args_test. When such tests run in parallel, they can contend
> for the same per-function trampoline quota and cause unexpected attach
> failures. This issue is currently masked by harness serialization.
> 
> Move trampoline_count to a dedicated bpf_testmod target and register it
> for fmod_ret attachment. This keeps the test semantics unchanged while
> isolating it from other selftests, so it no longer needs to run in
> serial mode. Remove the TODO comment as well.
> 
> Tested:
>   ./test_progs -t trampoline_count -vv
>   ./test_progs -t modify_return -vv
>   ./test_progs -t get_func_ip_test -vv
>   ./test_progs -t get_func_args_test -vv
>   ./test_progs -j$(nproc) -t trampoline_count -vv
>   ./test_progs -j$(nproc) -t
>     trampoline_count,modify_return,get_func_ip_test,get_func_args_test,\
> kprobe_multi_test -vv
>   20 runs of:
>     ./test_progs -j$(nproc) -t
>     trampoline_count,modify_return,get_func_ip_test,get_func_args_test,\
> kprobe_multi_test
> 
> Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
> ---
> 
> v2:
> - rewrite the subject to describe the change
> - resend with the correct patch content
> - resend as a reply to v1
> 
>  .../selftests/bpf/prog_tests/trampoline_count.c |  3 +--
>  .../selftests/bpf/progs/test_trampoline_count.c |  6 +++---
>  .../selftests/bpf/test_kmods/bpf_testmod.c      | 17 +++++++++++++++++
>  3 files changed, 21 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/trampoline_count.c b/tools/testing/selftests/bpf/prog_tests/trampoline_count.c
> index 6cd7349d4a2b..b19358aed126 100644
> --- a/tools/testing/selftests/bpf/prog_tests/trampoline_count.c
> +++ b/tools/testing/selftests/bpf/prog_tests/trampoline_count.c
> @@ -30,8 +30,7 @@ static struct bpf_program *load_prog(char *file, char *name, struct inst *inst)
>  	return prog;
>  }
>  
> -/* TODO: use different target function to run in concurrent mode */
> -void serial_test_trampoline_count(void)
> +void test_trampoline_count(void)
>  {
>  	char *file = "test_trampoline_count.bpf.o";
>  	char *const progs[] = { "fentry_test", "fmod_ret_test", "fexit_test" };
> diff --git a/tools/testing/selftests/bpf/progs/test_trampoline_count.c b/tools/testing/selftests/bpf/progs/test_trampoline_count.c
> index 7765720da7d5..14ad2f53cf33 100644
> --- a/tools/testing/selftests/bpf/progs/test_trampoline_count.c
> +++ b/tools/testing/selftests/bpf/progs/test_trampoline_count.c
> @@ -3,19 +3,19 @@
>  #include <bpf/bpf_helpers.h>
>  #include <bpf/bpf_tracing.h>
>  
> -SEC("fentry/bpf_modify_return_test")
> +SEC("fentry/bpf_testmod_trampoline_count_test")
>  int BPF_PROG(fentry_test, int a, int *b)
>  {
>  	return 0;
>  }
>  
> -SEC("fmod_ret/bpf_modify_return_test")
> +SEC("fmod_ret/bpf_testmod_trampoline_count_test")
>  int BPF_PROG(fmod_ret_test, int a, int *b, int ret)
>  {
>  	return 0;
>  }
>  
> -SEC("fexit/bpf_modify_return_test")
> +SEC("fexit/bpf_testmod_trampoline_count_test")
>  int BPF_PROG(fexit_test, int a, int *b, int ret)

last part of the trampoline_count test executes the probe through the
kernel's test_run which executes bpf_modify_return_test

I don't think it changes much because the programs are doing nothing
I guess it's there just to make sure the link failure did not screw
up anything

we could call bpf_testmod_trampoline_count_test from
bpf_testmod_test_read and have the test to call
trigger_module_test_read

jirka


>  {
>  	return 0;
> diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> index e62c6b78657f..6eaceb4dfbec 100644
> --- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> +++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> @@ -581,6 +581,12 @@ noinline int bpf_fentry_shadow_test(int a)
>  }
>  EXPORT_SYMBOL_GPL(bpf_fentry_shadow_test);
>  
> +noinline int bpf_testmod_trampoline_count_test(int a, int *b)
> +{
> +	*b += 1;
> +	return a + *b;
> +}
> +
>  __bpf_hook_end();
>  
>  static struct bin_attribute bin_attr_bpf_testmod_file __ro_after_init = {
> @@ -1843,6 +1849,16 @@ struct bpf_struct_ops testmod_multi_st_ops = {
>  
>  extern int bpf_fentry_test1(int a);
>  
> +BTF_KFUNCS_START(bpf_testmod_trampoline_count_ids)
> +BTF_ID_FLAGS(func, bpf_testmod_trampoline_count_test)
> +BTF_KFUNCS_END(bpf_testmod_trampoline_count_ids)
> +
> +static const struct
> +btf_kfunc_id_set bpf_testmod_trampoline_count_fmodret_set = {
> +	.owner = THIS_MODULE,
> +	.set = &bpf_testmod_trampoline_count_ids,
> +};
> +
>  static int bpf_testmod_init(void)
>  {
>  	const struct btf_id_dtor_kfunc bpf_testmod_dtors[] = {
> @@ -1859,6 +1875,7 @@ static int bpf_testmod_init(void)
>  	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &bpf_testmod_kfunc_set);
>  	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL, &bpf_testmod_kfunc_set);
>  	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS, &bpf_testmod_kfunc_set);
> +	ret = ret ?: register_btf_fmodret_id_set(&bpf_testmod_trampoline_count_fmodret_set);
>  	ret = ret ?: register_bpf_struct_ops(&bpf_bpf_testmod_ops, bpf_testmod_ops);
>  	ret = ret ?: register_bpf_struct_ops(&bpf_testmod_ops2, bpf_testmod_ops2);
>  	ret = ret ?: register_bpf_struct_ops(&bpf_testmod_ops3, bpf_testmod_ops3);
> 
> base-commit: 8a30aeb0d1b4e4aaf7f7bae72f20f2ae75385ccb
> -- 
> 2.43.0
> 
