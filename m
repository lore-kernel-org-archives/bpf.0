Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B917139527C
	for <bpf@vger.kernel.org>; Mon, 23 Mar 2026 11:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774264652; cv=none; b=Pz5xYDRUkDqU3mpq2lEl+BeOiHZeLCeYJ8raFOqgUisCaFPxMcBzwt2cSN94mke4hfiRFoztyNXhZ+nFFFgqYY6Lp09cuP2djzIlllSZjYolbMSAkOldf2NsruimpvnN9eTgkZfzSx+oH5jWInDRVWvcHXC+aWxUKvvmQquaD5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774264652; c=relaxed/simple;
	bh=BT6NNaAoOShDb1u2LciS7e+GmnloPrpqRug8bySgVkc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pDcuUh6lRbqTxAI7C2lQSqjjNoxW/bpRpjkN99RP4Fvd/9bBr/6WsWot5s08bq9Dt5ZaQgCSK/v4gTlj7eCaOCvVMQ+KHitN019PIsPa8TsODvVs4Vgvj9v9SmPHvwxqlPEFVSYKQOSC6wc5EP2T+vrFsxQF0OMVj8XoB/zi8Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JDT5tncJ; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JDT5tncJ"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-486ff3a0fc1so22267095e9.2
        for <bpf@vger.kernel.org>; Mon, 23 Mar 2026 04:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774264649; x=1774869449; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ho18lJBj7LSd/yPU0XL87x0gbx/dLwi70W/auWqoB3U=;
        b=JDT5tncJojVHoUgisPtZf1DrguTYOtjoS2o5W2j4x3JAoQ16HLbfWypWCNBFwKkqNM
         vTh5mQG/qm8OInPd7JNLbMlegvUOhYoC+te0dmjeSVAlzU0Hng5kYEFF3r9jEhUpwGQ6
         F3/KxL5IcUGTKnH6e2l1YYLA9CwYHJ276Xjw/nEcTDcj55wjzbmcj6W9I6y5w+P7+ltB
         uSg8DE/TYCPBg+RYAd2WaEGc9wJ+B/QuyIIdTBBIBlBsFYOn53vx0imCARIWMTKiXvDY
         j2hIsd1AH/huYy1QiKcWvyzzjd0AtT8B7+je9J3hyAleFN6f9nUfT/g8govzDPoeu/Qc
         M85A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774264649; x=1774869449;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ho18lJBj7LSd/yPU0XL87x0gbx/dLwi70W/auWqoB3U=;
        b=GhJyuGCcLHruTz+CeMGLOZ5kvyAI7jRo8weZYWPL4PxlivoYwFfv27EF81S3fl+xpj
         kblVdiybjrbLoHsUzY4mcuUFTcJzfnw5cacxwEnt3Ii619ifexLxvX/WFedgBklrryeS
         SahcUrM4N+inuSk7ULwwNC0y6q7+yi66RRidEyQLN9ksBxT7PfmAM5UK/bSet5r2W7k3
         ZPtBYmshphrpLqVoomGEkzvruG2v4mAmK+RaPBXx4aNj7ziBuB3qNvIFdtvewUUuAjnG
         44Asc2aUn0po1FHEljYRh3JqulZvBu7T0DS7P/1Dqn1IIcuBBYQGhsFj6nMRi1nTCTVn
         ta6w==
X-Gm-Message-State: AOJu0YxLn5Aq8cj5FpGIbJtPUUPy+sHplvKM1ctP0MBuKVYCNRH/bG8T
	vRi0Yzum9+LaCTBBBF7xFKLJ84xMU2TbVclCq9++bt0RDP1bcz6ARsNh
X-Gm-Gg: ATEYQzwqWBsXF5UBkVxfuFxopzupBL7DPIxb2sNu6vvC9whbRaH+CaN7br09977AwBx
	s9SGZfPipmdQKZNZ5sNRt94sJBxuYyy09tmJmaVdHLuDqIgsEXTwjdmex4/lffrLhh/fN3nB0Kl
	DsytiE21wQvBuxDeEOokwggvmB4qkLcPuyA6SEoSr10BRvGanKJ1xc9/0YkVfRcjjno9RXQ0n2P
	QQfn6Gn8GD5oNcmLqVR0ayOZf+YoSJNlldlpPe4CXIssgkzwlwAiutjXVONpZK24SoptpIu3gaN
	eQaSxEf87V1vPN0qzFTm2e8ojW+XsFvEU/zTDxqpA2K6it1cwa+fLC8dEx+poRIuq80rDOUT+1R
	GoHv9g+QO+vyTiKV2xoPTLJ9ZomPMwKO4SVaIexf/pMogVGki0PU+Pv0BTgUsePfLQ7mRtFukXM
	/mNuVm1dKL/paWeB96
X-Received: by 2002:a05:600c:c09c:b0:485:4bd1:4c64 with SMTP id 5b1f17b1804b1-486ff01ca98mr131743975e9.31.1774264648800;
        Mon, 23 Mar 2026 04:17:28 -0700 (PDT)
Received: from krava ([2a00:102a:502b:faa8:f878:ffa9:3b65:76be])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486fe868cb1sm77733365e9.5.2026.03.23.04.17.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 04:17:28 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 23 Mar 2026 12:17:26 +0100
To: Sun Jian <sun.jian.kdev@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, shuah@kernel.org, martin.lau@kernel.org,
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
	haoluo@google.com, paul.chaignon@gmail.com,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] selftests/bpf: move trampoline_count to dedicated
 bpf_testmod target
Message-ID: <acEhRhymOUw78d3_@krava>
References: <20260320074150.628094-1-sun.jian.kdev@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260320074150.628094-1-sun.jian.kdev@gmail.com>

On Fri, Mar 20, 2026 at 03:41:50PM +0800, Sun Jian wrote:
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

I only suggested change as part of review, not the change itself ;-)
you can drop the tag

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

could be just single line, also no need for the condition and
goto cleanup, just this will do:

     ASSERT_OK(trigger_module_test_read....)

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

we could define bpf_testmod_trampoline_count_test in here,
so we would go without the declaration

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

do we need all those arguments? progs don't do anything with them..
I'd stick with just simple module function used by trampoline_count test

jirka
