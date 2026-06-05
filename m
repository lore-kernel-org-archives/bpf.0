Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8DA138490
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 14:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780668408; cv=none; b=PPm/suBOk5Wee4Ucdm7hie0Igk66aRxKkBf8WrcDxF3X53DGHXvsk6R6lqpWPFG3oxsa9oUVTWTXFnKLiEJET3gHGuU2+Eu6+G7xr/JPUPjoeyF+RuzhQS5hqGaZohsyFQ+Nj4ivA6tf3tq2IhaKDKZfmk90uO/TvNAhCd8mX0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780668408; c=relaxed/simple;
	bh=1nNQ2oLmYHhRTdoVFpntDJC8qNTkKJT4QU7NykxcDFU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pT7Zwv4UJWhDAvQlJSMhIa7PGePSz9r50pPglEWzv3G54Zec6SYqRX9Xt47EUWRStVzPj2xwj8albOXmkcvjXpuYwa7epWR1LgjiBsO/dDb8K9dQtQEWUXSvsvJ9zUJDVS73zq2zCED8uPpXPpB8UtvluoHJP2LgBT7xaYluxfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GqLUoMur; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GqLUoMur"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-490c1915793so8205845e9.2
        for <bpf@vger.kernel.org>; Fri, 05 Jun 2026 07:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780668405; x=1781273205; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dCcP4TVf3aNgZJZJktNdPuXr0mIH8V5tAXXqh5Ye3C8=;
        b=GqLUoMurrRg9oJLARKaCmwI0JfTdonmCdcB77yYCDInPOdZo1A1brzQE1BFzfHHv1M
         OqwtAyZVbvA0AlMIR5qAxfWmOsSlotUSr7pIyv85La4tALAEPVJewpHxU9HuUXTc5mwK
         hVapZ463wbqAu7d0jr3U/hGAShFGFxKkoY+N7o5y9AgiHCOYYclnUrvVWI6Pj8PWW9NV
         xX6Y43hM700QecG+oSiAE5B3TO1ffC8+JPtLw7JYRBFSNGlpeta1OX55+hgwuNMG9r/a
         sWkrp5WTcBuO9iUuS0x3H4X6M8RBeE3SjlAqoP85OtGcklSlL9qNqv952SvVmIqd8b5G
         zwtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780668405; x=1781273205;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dCcP4TVf3aNgZJZJktNdPuXr0mIH8V5tAXXqh5Ye3C8=;
        b=FGpg00I9Kzq+DDgzp/Fyvr8LSbTt3FCP/mxH3nLNo42s5DGsL8wOCClgTqrzGHKrBF
         5RNPQE1oTFSrrNsO13exsfBHYASnez3nu4eBBvTBhGLNK2nEL3SUUoIoC7kDpTcnInD9
         KXnGqMMt2vwylXzCMvW/duU51hLdvw4utGwt7GtxTnO0EBew62r4ZE5qZSJwePM0+mYY
         hyeVeOlInt8JY5v8pVkV/HLB4CUP+hLusq6l7UTfjNiv3ouDy4A7gFb2UXqvFXorvrnL
         X4beuUEKMAVeVaVO5LiSDevli08yNPgTpraayh36gXbAJmKsQd1oxhjboHpFyJCnKw9M
         XFGg==
X-Forwarded-Encrypted: i=1; AFNElJ/Vwm9OgI4rnH6DePfwEWbCqQJwoCfqCDMKeFgZq8Q5mfqDMbMPHGTQIRlTygsXT2bfD7Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4x0hhSgqf4p/Sdavr4PmiBwyrTMIepkLjyHIiwjRwc9oZRKV1
	8frcnpbn3UH3bVZL+SU+3hWgiRFcDglf/K9VDN1FxEx3tzx1nWPcVzfzSWjfoYmY
X-Gm-Gg: Acq92OFU0mUr9R9PbcYcgYRGKRiMtAzkSIiXQF/Dvx9d6rjWNFJGQRlsb5nc3xiSETC
	ixt0OgDPuvYGCZ85wQwOArtHP7EHXsmRdKRzwtHBvpkRWEej+JwU5Fh3eHvZ8GSuyA1lckL4WBK
	p9bwZdUmJzmkibb9xwq5i8Hd2Tie/vZp/6GY9WS41czreB8UM1DCTN3S2O/Tj2D25hGqrCQH/n/
	tyqoGrgT/n9Nua+VoFtANh8mSUfck8JKztxg2szqEI2YAqFnMxiLFFZU9fGS+VClKCvugKASbr2
	9QjKx+LB//X45jd0YEAocEE/nGkWizShancT6RdFGGmtralrdPmgpttBB/2M6F64QNVhJiVnvwH
	5ZhD6yGKf3FSRxc7IA+qvZ1fIWoFb/3deIgwh5M43YArkSFfB9wH2e4ORn6Ptc4yK57PT7PiEMu
	uiWFc7wEVDFalBGHunWpXeOnfmZKolUxDAIt7LFdghlQOsN24CRyodzwId05eLWZn7OVvqGffDs
	sD91qwKH2/5sH9Z2lqGmA==
X-Received: by 2002:a05:600c:37c9:b0:490:adb6:7957 with SMTP id 5b1f17b1804b1-490c262dcb5mr59369655e9.33.1780668405124;
        Fri, 05 Jun 2026 07:06:45 -0700 (PDT)
Received: from ?IPV6:2a02:8109:a307:d900:9c30:fc5f:5bdd:2e3f? ([2a02:8109:a307:d900:9c30:fc5f:5bdd:2e3f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f351ac0sm43474029f8f.27.2026.06.05.07.06.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jun 2026 07:06:44 -0700 (PDT)
Message-ID: <5ac74b9b-3738-49c7-bf44-70b72a1ec1b1@gmail.com>
Date: Fri, 5 Jun 2026 15:06:43 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2] selftests/bpf: Run test_perf_branches more
 than 1 time
To: Maya Matuszczyk <mayamatuszczyk@google.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>
Cc: Matt Bobrowski <mattbobrowski@google.com>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260605130601.2699172-1-mayamatuszczyk@google.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <20260605130601.2699172-1-mayamatuszczyk@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/5/26 2:06 PM, Maya Matuszczyk wrote:
> test_perf_branches bpf program was only being ran once, and
> perf_branches test would fail if the only sample that was passed to
> test_perf_branches didn't have branch data.
> Fix those failures by running it a few more times and waiting until a valid
> sample shows up, and leave the perf event only enabled for the duration of
> test spins.
> 
> Signed-off-by: Maya Matuszczyk <mayamatuszczyk@google.com>
> ---

Change looks good.
minor nit: Maybe it makes sense to migrate all CHECKs in this test to ASSERT, 
though.

Acked-by: Mykyta Yatsenko <yatsenko@meta.com>

> Changes from v1:
> - Switched from CHECK to ASSERT_OK (Alexei Starovoitov)
> - bpf -> bpf-next
> 
> v1: https://lore.kernel.org/bpf/20260408095710.4090495-1-mayamatuszczyk@google.com/
> ---
>  .../selftests/bpf/prog_tests/perf_branches.c  | 57 +++++++++++++------
>  .../selftests/bpf/progs/test_perf_branches.c  | 11 ++--
>  2 files changed, 43 insertions(+), 25 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/perf_branches.c b/tools/testing/selftests/bpf/prog_tests/perf_branches.c
> index 0a7ef770c487..153afcdc082e 100644
> --- a/tools/testing/selftests/bpf/prog_tests/perf_branches.c
> +++ b/tools/testing/selftests/bpf/prog_tests/perf_branches.c
> @@ -15,10 +15,6 @@ static void check_good_sample(struct test_perf_branches *skel)
>  	int pbe_size = sizeof(struct perf_branch_entry);
>  	int duration = 0;
>  
> -	if (CHECK(!skel->bss->run_cnt, "invalid run_cnt",
> -		  "checked sample validity before prog run"))
> -		return;
> -
>  	if (CHECK(!skel->bss->valid, "output not valid",
>  		 "no valid sample from prog"))
>  		return;
> @@ -49,10 +45,6 @@ static void check_bad_sample(struct test_perf_branches *skel)
>  	int written_stack = skel->bss->written_stack_out;
>  	int duration = 0;
>  
> -	if (CHECK(!skel->bss->run_cnt, "invalid run_cnt",
> -		  "checked sample validity before prog run"))
> -		return;
> -
>  	if (CHECK(!skel->bss->valid, "output not valid",
>  		 "no valid sample from prog"))
>  		return;
> @@ -73,7 +65,6 @@ static void test_perf_branches_common(int perf_fd,
>  	bool detached = false;
>  	struct bpf_link *link;
>  	volatile int j = 0;
> -	cpu_set_t cpu_set;
>  
>  	skel = test_perf_branches__open_and_load();
>  	if (CHECK(!skel, "test_perf_branches_load",
> @@ -85,19 +76,35 @@ static void test_perf_branches_common(int perf_fd,
>  	if (!ASSERT_OK_PTR(link, "attach_perf_event"))
>  		goto out_destroy_skel;
>  
> -	/* generate some branches on cpu 0 */
> -	CPU_ZERO(&cpu_set);
> -	CPU_SET(0, &cpu_set);
> -	err = pthread_setaffinity_np(pthread_self(), sizeof(cpu_set), &cpu_set);
> -	if (CHECK(err, "set_affinity", "cpu #0, err %d\n", err))
> +	err = ioctl(perf_fd, PERF_EVENT_IOC_RESET, 0);
> +	if (!ASSERT_OK(err, "ioctl(PERF_EVENT_IOC_RESET)"))
>  		goto out_destroy;
>  
> -	/* Spin the loop for a while by using a high iteration count, and by
> -	 * checking whether the specific run count marker has been explicitly
> -	 * incremented at least once by the backing perf_event BPF program.
> +	err = ioctl(perf_fd, PERF_EVENT_IOC_REFRESH, 10);
> +	if (!ASSERT_OK(err, "ioctl(PERF_EVENT_IOC_REFRESH)"))
> +		goto out_destroy;
> +
> +	/* Make up a bunch of branch events until we time out or bpf prog sets a flag
> +	 * that it caught a valid event. To be completely sure that required_size_out,
> +	 * written_stack_out or written_global_out writes and reads won't get
> +	 * reordered by anyone in a way that would fail this test, use atomic
> +	 * operations
>  	 */
> -	for (i = 0; i < 100000000 && !*(volatile int *)&skel->bss->run_cnt; ++i)
> +	for (i = 0; i < 100000000; ++i) {
> +		/* This technically should be an atomic load with acquire
> +		 * ordering, but we don't want to clog up memory bus while
> +		 * spinning
> +		 */
> +		if (READ_ONCE(skel->bss->valid) > 0)
> +			break;
>  		++j;
> +	}
> +
> +	__atomic_thread_fence(__ATOMIC_ACQUIRE);
> +
> +	err = ioctl(perf_fd, PERF_EVENT_IOC_DISABLE, 0);
> +	if (!ASSERT_OK(err, "ioctl(PERF_EVENT_IOC_DISABLE)"))
> +		goto out_destroy;
>  
>  	test_perf_branches__detach(skel);
>  	detached = true;
> @@ -121,6 +128,7 @@ static void test_perf_branches_hw(void)
>  	attr.size = sizeof(attr);
>  	attr.type = PERF_TYPE_HARDWARE;
>  	attr.config = PERF_COUNT_HW_CPU_CYCLES;
> +	attr.disabled = 1;
>  	attr.freq = 1;
>  	attr.sample_freq = 1000;
>  	attr.sample_type = PERF_SAMPLE_BRANCH_STACK;
> @@ -162,6 +170,7 @@ static void test_perf_branches_no_hw(void)
>  	attr.size = sizeof(attr);
>  	attr.type = PERF_TYPE_SOFTWARE;
>  	attr.config = PERF_COUNT_SW_CPU_CLOCK;
> +	attr.disabled = 1;
>  	attr.freq = 1;
>  	attr.sample_freq = 1000;
>  	pfd = syscall(__NR_perf_event_open, &attr, -1, 0, -1, PERF_FLAG_FD_CLOEXEC);
> @@ -175,6 +184,18 @@ static void test_perf_branches_no_hw(void)
>  
>  void test_perf_branches(void)
>  {
> +	int err, duration = 0;
> +	cpu_set_t cpu_set;
> +
> +	/* Pin ourselves to cpu0 so that all branches we generate would be
> +	 * also on cpu0
> +	 */
> +	CPU_ZERO(&cpu_set);
> +	CPU_SET(0, &cpu_set);
> +	err = pthread_setaffinity_np(pthread_self(), sizeof(cpu_set), &cpu_set);
> +	if (!ASSERT_OK(err, "pthread_set_affinity"))
> +		return;
> +
>  	if (test__start_subtest("perf_branches_hw"))
>  		test_perf_branches_hw();
>  	if (test__start_subtest("perf_branches_no_hw"))
> diff --git a/tools/testing/selftests/bpf/progs/test_perf_branches.c b/tools/testing/selftests/bpf/progs/test_perf_branches.c
> index 05ac9410cd68..9806414cebc4 100644
> --- a/tools/testing/selftests/bpf/progs/test_perf_branches.c
> +++ b/tools/testing/selftests/bpf/progs/test_perf_branches.c
> @@ -8,7 +8,6 @@
>  #include <bpf/bpf_tracing.h>
>  
>  int valid = 0;
> -int run_cnt = 0;
>  int required_size_out = 0;
>  int written_stack_out = 0;
>  int written_global_out = 0;
> @@ -25,13 +24,11 @@ int perf_branches(void *ctx)
>  	__u64 entries[4 * 3] = {0};
>  	int required_size, written_stack, written_global;
>  
> -	++run_cnt;
> -
>  	/* write to stack */
>  	written_stack = bpf_read_branch_records(ctx, entries, sizeof(entries), 0);
>  	/* ignore spurious events */
>  	if (!written_stack)
> -		return 1;
> +		return 0;
>  
>  	/* get required size */
>  	required_size = bpf_read_branch_records(ctx, NULL, 0,
> @@ -40,14 +37,14 @@ int perf_branches(void *ctx)
>  	written_global = bpf_read_branch_records(ctx, fpbe, sizeof(fpbe), 0);
>  	/* ignore spurious events */
>  	if (!written_global)
> -		return 1;
> +		return 0;
>  
>  	required_size_out = required_size;
>  	written_stack_out = written_stack;
>  	written_global_out = written_global;
> -	valid = 1;
> +	__atomic_add_fetch(&valid, 1, __ATOMIC_RELEASE);
>  
> -	return 0;
> +	return 1;
>  }
>  
>  char _license[] SEC("license") = "GPL";

