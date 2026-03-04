Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8438730FF37
	for <bpf@vger.kernel.org>; Wed,  4 Mar 2026 01:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772588628; cv=none; b=BKPSgWDhUQNjlJAG+sV43sju1CaHCRLSeB9S9VSrLBFVmrlrXwuLcRT+jKVqOOnAQr2Ws9aoLyEsR241K8nxtilXo/3jxWdwicz/liCuAyfKf+RLNroKDCwR1siEIl2FSEKmblLe9s+2gmrJ2n3IM2TzxRY0v/rJTgcsiG11SMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772588628; c=relaxed/simple;
	bh=pweUVnV31JEUF1FTpI7AIMRyaMvVExRTL4LgxaNelNA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YK47hAFzbr1dKy8h6nGng+/6LVbvpTHWQoKqMuRqJ3nOVtqPaOJY84H+z5i6ZpDkcGaj1wEtslHCkgWCXPYwziBV5tJAvQe6Mq0r5tbjROAVcErxUI9KmyaryMceP5Nu9erIK1opGExmEO4c+5DwIyOA0GtbqigqbbyFKXF3buo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dwxnXhtu; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dwxnXhtu"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772588624;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LoH1JvM5eEae/EYrTmhHLOmzHKnwbLDxV3lBHEOw8I4=;
	b=dwxnXhtuW9xxBJiPrcL/yVbKD+aFJmHutNPXcdkUlkOedu9W4G6v3yXVZIUtmwDG8zWWQ1
	iZi1Jpq4VOISMIKQ4XPlCW0jV/7gOSH4hEhundUQ53euRMEq8/HXt04RLlxaekf/sXdCe9
	rZTAn7osiXMl1FHPZPKRLinJjLD3ovA=
From: Menglong Dong <menglong.dong@linux.dev>
To: Hengqi Chen <hengqi.chen@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, chenhuacai@kernel.org, yangtiezhu@loongson.cn,
 vincent.mc.li@gmail.com, menglong8.dong@gmail.com, loongarch@lists.linux.dev,
 bpf@vger.kernel.org, Hengqi Chen <hengqi.chen@gmail.com>
Subject:
 Re: [PATCH bpf-next 3/3] bpf/selftests: Enable fsession tests for LoongArch
Date: Wed, 04 Mar 2026 09:43:28 +0800
Message-ID: <5970598.DvuYhMxLoT@7940hx>
In-Reply-To: <20260226065952.4082859-4-hengqi.chen@gmail.com>
References:
 <20260226065952.4082859-1-hengqi.chen@gmail.com>
 <20260226065952.4082859-4-hengqi.chen@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2026/2/26 14:59 Hengqi Chen <hengqi.chen@gmail.com> write:
> Now that the LoongArch JIT supports BPF_TRACE_FSESSION, allow
> the fsession-related tests to run on LoongArch.
> 
>     $ ./test_progs -a fsession_test,get_func_args_test,get_func_ip_test
>     #136/1   fsession_test/fsession_test:OK
>     #136/2   fsession_test/fsession_reattach:OK
>     #136/3   fsession_test/fsession_cookie:OK
>     #136     fsession_test:OK
>     #138     get_func_args_test:OK
>     #139     get_func_ip_test:OK
>     Summary: 3/3 PASSED, 0 SKIPPED, 0 FAILED

Hi Hengqi,

The testcases is updated in c1eee8d1e84f "selftests/bpf: factor out
get_func_* tests for fsession", so we don't need the 3rd patch anymore.

Thanks!
Menglong Dong

> 
> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
> ---
>  tools/testing/selftests/bpf/progs/get_func_args_test.c | 3 ++-
>  tools/testing/selftests/bpf/progs/get_func_ip_test.c   | 3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/progs/get_func_args_test.c b/tools/testing/selftests/bpf/progs/get_func_args_test.c
> index 075a1180ec26..afb185fdf60c 100644
> --- a/tools/testing/selftests/bpf/progs/get_func_args_test.c
> +++ b/tools/testing/selftests/bpf/progs/get_func_args_test.c
> @@ -167,7 +167,8 @@ int BPF_PROG(tp_test2)
>  }
>  
>  __u64 test7_result = 0;
> -#if defined(bpf_target_x86) || defined(bpf_target_arm64) || defined(bpf_target_riscv)
> +#if defined(bpf_target_x86) || defined(bpf_target_arm64) || \
> +    defined(bpf_target_riscv) || defined(bpf_target_loongarch)
>  SEC("fsession/bpf_fentry_test1")
>  int BPF_PROG(test7)
>  {
> diff --git a/tools/testing/selftests/bpf/progs/get_func_ip_test.c b/tools/testing/selftests/bpf/progs/get_func_ip_test.c
> index 45eaa54d1ac7..3816a3616fbe 100644
> --- a/tools/testing/selftests/bpf/progs/get_func_ip_test.c
> +++ b/tools/testing/selftests/bpf/progs/get_func_ip_test.c
> @@ -106,7 +106,8 @@ int BPF_URETPROBE(test8, int ret)
>  
>  __u64 test9_entry_result = 0;
>  __u64 test9_exit_result = 0;
> -#if defined(bpf_target_x86) || defined(bpf_target_arm64) || defined(bpf_target_riscv)
> +#if defined(bpf_target_x86) || defined(bpf_target_arm64) || \
> +    defined(bpf_target_riscv) || defined(bpf_target_loongarch)
>  SEC("fsession/bpf_fentry_test1")
>  int BPF_PROG(test9, int a)
>  {
> -- 
> 2.43.5
> 
> 
> 




