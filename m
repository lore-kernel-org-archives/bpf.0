Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A458B3C061D
	for <bpf@vger.kernel.org>; Fri, 20 Mar 2026 14:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774015306; cv=none; b=N4im9OG/XE4sSUXOMe0itFoRtMyYk6YqI7DmFHKAJEW0eUUWNTfmaCZS9BWfHQa6kqGlxOD841jTS5av7v+Dow7CKXyOI0+nbFgjLjvDLUWtCjdApheTGuG9qd4IW1ZK3ULts4BE+gQX+cqunm2/FWKxK9ClhpG8zgt+0oZhBUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774015306; c=relaxed/simple;
	bh=rgm+30RzqyLfplCZAhhg2e1uMDdrhPfgeOG6ziSXyn0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VoZAlila35qLLbCXxKjDnKYlmGOhzn17Gg2vm+SEqBxubrMWFM0CFPhhqpk+eMm4w5Ig0XxqEJguaYRMd+g9+gfm5kpjrF6Mc1MpGzVp5BlABUYAa0plsxX+S5byqrVBAB4s3lO3+Co61r53NW4Fa4mb+n9NPgcarrJVWtAmvpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SFeyL2mM; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SFeyL2mM"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-486fe655187so11037165e9.2
        for <bpf@vger.kernel.org>; Fri, 20 Mar 2026 07:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774015301; x=1774620101; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=L2e3felPcCk2121Y5bIhuiA5cprSPhyerpxVIBRBO+Q=;
        b=SFeyL2mMfoZvnvs409CKYKRwLCap+eQ5MqY7NY7TAt5Dyk4Nm+/h5mZRf6JTe+3OGp
         YjS7tj/pAEsKR/ixaclp2r2lk2E6/yqxGvv+e4BmujuN3kN4z11bfTUT2p+TZcEBLKvv
         UqCaIiJpNuX3bB07v7evA2NM3jVAZ/IwJ8bijup0tNAyy/42NKDywtV9RtQRT0c9wL/K
         KOW9RI61KQh9iw6F4W7d38atQXyF0X/MBkvpdrnJ2XUejwGQOjN0/9EIAzj5V3kfJq+y
         85v+OCWIbHXRQp4D2GGgut/XCG257qRDbicE4HkKPNKOyNfj2AT4nEdA+7nl7FMAgAIA
         XIfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774015301; x=1774620101;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L2e3felPcCk2121Y5bIhuiA5cprSPhyerpxVIBRBO+Q=;
        b=pNEk4ECN48Im9nqEK7h5JkWFFqfs40kke39z4uHGKwoyjnNqgbmsMr8YuAAwOx/8qV
         bOjNZIassTYjvzIF7NjbZt2/NO6JsWCRIg4LTQ4yrszLjFs8G0SXJPy1M3s5rNJrMiZU
         as/tVNwzSIhW2jkxIK6OY/EnGr5uDYyKu8w2c/8aongUq4zpF2ug6Zj/6GKYtJdhzhGN
         iwoe38h+ozRwDakAuglIQ8gS+1W4TOuQZ2PmJP0gSBC1Z2H/LevdN58+GvUIKPq0/qrZ
         1sqphnx+ssYIpgYr6n0so+AnuBCK3+jcOERSYhErjNGUvu+uBpFdAZe46qcKeo/2prEy
         yfog==
X-Forwarded-Encrypted: i=1; AJvYcCX9LAPUd2G1h+S1ohhHKi7OXN7f70NEc7LFZ9YxApkYCbjO9Z6IJZi3j71k6RN4vh+Eqlc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSbogSzf2hPyUjSZWZl8MFnL1/wdC3vHQkDrbgy9pNzR/kLWCi
	IlhgSfhxBeIHNsEgPLMwY4Df7hM1EOhr1m1/W9KN2mNO10qcFwNqd49k
X-Gm-Gg: ATEYQzzVaUcOljxvaipQPwg05aAKh4wJmbBlVl8pzSnKQtD9WZawlQKcEf/9ijVm6KM
	jJzTaKSSPt7a8D6/4Qa5IlRIljP4llzZr12zQ64scvWnDCmw0+sG9G96io0GXcnUJYzVPS6xcmY
	pbwpLDaujYgNDRVx7oqt2TK58Cf64HW9jJveVYGiocaoQZMO2y9/aTUuFA6qU2IyZu4xHPLgXrv
	+FIXSDoYoM3nSZtuR07MbcVDSfn5GjoRUBRbQ4Aw2zN4+sgBqLK3frhsnc+PxH4g+9GiRx9xxHn
	aHSK3Nlv1VIh+P2/3PUhN21u3sHpsfl80vZqnFzYe9LgKGBY72kF4DfmWYn0K/HggIYMDdKLOBV
	bq5D4tmxUYfG5YO1tsPQBPXaVpKK0lC3ocrA7x1GCjeuCdSgS0XP9ByaR/m2To+su0Bx53LGmiV
	n1p3xAysWC7FBFzQ==
X-Received: by 2002:a05:600c:3e0e:b0:483:2c98:4368 with SMTP id 5b1f17b1804b1-486fee02d8emr42772225e9.18.1774015293134;
        Fri, 20 Mar 2026 07:01:33 -0700 (PDT)
Received: from localhost ([2620:10d:c092:400::5:f9f5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486fe807262sm17993235e9.0.2026.03.20.07.01.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 07:01:32 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: Sun Jian <sun.jian.kdev@gmail.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 shuah@kernel.org, martin.lau@kernel.org, eddyz87@gmail.com,
 song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
 paul.chaignon@gmail.com, jolsa@kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, Sun Jian
 <sun.jian.kdev@gmail.com>
Subject: Re: [PATCH v3] selftests/bpf: move trampoline_count to dedicated
 bpf_testmod target
In-Reply-To: <20260320074150.628094-1-sun.jian.kdev@gmail.com>
References: <20260320074150.628094-1-sun.jian.kdev@gmail.com>
Date: Fri, 20 Mar 2026 14:01:31 +0000
Message-ID: <87zf42k3b8.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Sun Jian <sun.jian.kdev@gmail.com> writes:

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
> for fmod_ret attachment. Also route the final trigger through
> trigger_module_test_read, so the execution path exercises the  same
> dedicated target.
>
> This keeps the test semantics unchanged while isolating it from other
> selftests, so it no longer needs to run in serial mode. Remove the
> TODO comment as well.
Is it really worth it just for ditching serial mode, does it improve
test_progs speed? Either way it's worth adding a comment for
bpf_testmod_trampoline_count_test() explaining that no other test should
attempt attaching to it.
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
> Suggested-by: Jiri Olsa <jolsa@kernel.org>
> Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
> ---
> Link:https://lore.kernel.org/bpf/abicUI4YQ5KkQ_Ro@mail.gmail.com/T/#m6253b7fe96fe1a4df65b274c95aac786598a9857
>
> v3:
> - route the final trigger through trigger_module_test_read() and make
>   bpf_testmod_test_read() call the dedicated trampoline_count target,
>   as suggested by Jiri
>
> v2:
> - rewrite the subject to describe the change
> - resend with the correct patch content
>
>  .../bpf/prog_tests/trampoline_count.c         | 17 ++++----------
>  .../bpf/progs/test_trampoline_count.c         |  6 ++---
>  .../selftests/bpf/test_kmods/bpf_testmod.c    | 23 +++++++++++++++++++
>  3 files changed, 30 insertions(+), 16 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/trampoline_count.c b/tools/testing/selftests/bpf/prog_tests/trampoline_count.c
> index 6cd7349d4a2b..dd2e5c84a4b5 100644
> --- a/tools/testing/selftests/bpf/prog_tests/trampoline_count.c
> +++ b/tools/testing/selftests/bpf/prog_tests/trampoline_count.c
> @@ -30,16 +30,14 @@ static struct bpf_program *load_prog(char *file, char *name, struct inst *inst)
>  	return prog;
>  }
>  
> -/* TODO: use different target function to run in concurrent mode */
> -void serial_test_trampoline_count(void)
> +void test_trampoline_count(void)
>  {
>  	char *file = "test_trampoline_count.bpf.o";
>  	char *const progs[] = { "fentry_test", "fmod_ret_test", "fexit_test" };
> -	int bpf_max_tramp_links, err, i, prog_fd;
> +	int bpf_max_tramp_links, i;
>  	struct bpf_program *prog;
>  	struct bpf_link *link;
>  	struct inst *inst;
> -	LIBBPF_OPTS(bpf_test_run_opts, opts);
>  
>  	bpf_max_tramp_links = get_bpf_max_tramp_links();
>  	if (!ASSERT_GE(bpf_max_tramp_links, 1, "bpf_max_tramp_links"))
> @@ -80,17 +78,10 @@ void serial_test_trampoline_count(void)
>  		goto cleanup;
>  
>  	/* and finally execute the probe */
> -	prog_fd = bpf_program__fd(prog);
> -	if (!ASSERT_GE(prog_fd, 0, "bpf_program__fd"))
> +	if (!ASSERT_OK(trigger_module_test_read(256),
> +		       "trigger_module_test_read"))
>  		goto cleanup;
>  
> -	err = bpf_prog_test_run_opts(prog_fd, &opts);
> -	if (!ASSERT_OK(err, "bpf_prog_test_run_opts"))
> -		goto cleanup;
> -
> -	ASSERT_EQ(opts.retval & 0xffff, 33, "bpf_modify_return_test.result");
> -	ASSERT_EQ(opts.retval >> 16, 2, "bpf_modify_return_test.side_effect");
> -
>  cleanup:
>  	for (; i >= 0; i--) {
>  		bpf_link__destroy(inst[i].link);
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
>  {
>  	return 0;
> diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> index e62c6b78657f..47583577e021 100644
> --- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> +++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> @@ -470,6 +470,8 @@ noinline void bpf_testmod_stacktrace_test_1(void)
>  
>  int bpf_testmod_fentry_ok;
>  
> +noinline int bpf_testmod_trampoline_count_test(int a, int *b);
> +
>  noinline ssize_t
>  bpf_testmod_test_read(struct file *file, struct kobject *kobj,
>  		      const struct bin_attribute *bin_attr,
> @@ -548,6 +550,10 @@ bpf_testmod_test_read(struct file *file, struct kobject *kobj,
>  			21, 22, 23, 24, 25, 26) != 231)
>  		goto out;
>  
> +	i = 2;
> +	if (bpf_testmod_trampoline_count_test(1, &i) != 4 || i != 3)
> +		goto out;
> +
Do we need to add this test for the bpf_testmod_trampoline_count_test(),
if it's supposed to be used only for the trampoline count test, which
probably does not care what function actually does internally.
>  	bpf_testmod_stacktrace_test_1();
>  
>  	bpf_testmod_fentry_ok = 1;
> @@ -581,6 +587,12 @@ noinline int bpf_fentry_shadow_test(int a)
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
> @@ -1843,6 +1855,16 @@ struct bpf_struct_ops testmod_multi_st_ops = {
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
> @@ -1859,6 +1881,7 @@ static int bpf_testmod_init(void)
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
