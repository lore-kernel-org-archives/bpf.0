Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE5A3148A6
	for <bpf@vger.kernel.org>; Thu, 29 Jan 2026 01:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769649257; cv=none; b=cIvzWTHT2tppBaQ9SLHJbwFcb5rDJTKSXosqFXLrM9hhFvBhpVdLDk8sfhg4zSm6c2sH2rAZfbEIzMloXtkpNlQlk1AkpqkOijCQOvSczv1jziJYjT1hztY5sUKas4BNdKR2zOJTownz4yE7rOIjRAjonpHLektvz4S5Fiab0H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769649257; c=relaxed/simple;
	bh=JwUKXO1Ia8RWi17FWbKEtvJ2PKaprLgYC/IMbu+JgtA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kJWbsEV/Kbh5afq9//tzs4QeTSrBy2gMlJm+YCf5A4m94kP6Y7jguPcvcxUaAdXIhe9So3r3XNW8yDD8Ix1ezyXu0zM1JVo6z0vXQco16tTP1CSwHXlU+/kclAMNhKOKj6zBL2DJcAIkq4GbZi3fqF8OysYg/nmgH7GWy0y0zFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hvtxWaio; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hvtxWaio"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769649243;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Dl/DTgnR2LWZ4WWPq9bsPwP22gj/Iby75/e7ptvtrsk=;
	b=hvtxWaioRsELgv1IwyJU6puKmtAvyQMj4OSLRY2L32HSM1UQfDRs0nQHSXKsnMJxOM4nKW
	mtUGgnKGS+jMfQJ2IAwfsiU/jkNrd/8M9cBlJpQrZiOy+uOk47up35mqf7/9UaPimaHqw3
	Ml1BJn6Dp6m+/leKr496oZi1r8RS1FM=
From: Menglong Dong <menglong.dong@linux.dev>
To: bpf@vger.kernel.org, Leon Hwang <leon.hwang@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Puranjay Mohan <puranjay@kernel.org>,
 Xu Kuohai <xukuohai@huaweicloud.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Shuah Khan <shuah@kernel.org>, Menglong Dong <menglong8.dong@gmail.com>,
 Leon Hwang <leon.hwang@linux.dev>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 kernel-patches-bot@fb.com
Subject:
 Re: [PATCH bpf-next v2 3/3] bpf/selftests: Enable get_func_args and
 get_func_ip tests on arm64
Date: Thu, 29 Jan 2026 09:13:49 +0800
Message-ID: <6233558.lOV4Wx5bFT@7940hx>
In-Reply-To: <20260128150112.8873-4-leon.hwang@linux.dev>
References:
 <20260128150112.8873-1-leon.hwang@linux.dev>
 <20260128150112.8873-4-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2026/1/28 23:01 Leon Hwang <leon.hwang@linux.dev> write:
> Allow get_func_args, and get_func_ip selftests to run on arm64.

Hi, Leon.

I think you missed the fsession_test.c, right? You need to
enable the test_fsession_test() for arm64 too. Therefore,
the title of this patch maybe:
    bpf/selftests: Enable fsession tests on arm64

Thanks!
Menglong Dong

> 
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
>  tools/testing/selftests/bpf/progs/get_func_args_test.c | 2 +-
>  tools/testing/selftests/bpf/progs/get_func_ip_test.c   | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/progs/get_func_args_test.c b/tools/testing/selftests/bpf/progs/get_func_args_test.c
> index 0a3236a7a109..180ba5098ca1 100644
> --- a/tools/testing/selftests/bpf/progs/get_func_args_test.c
> +++ b/tools/testing/selftests/bpf/progs/get_func_args_test.c
> @@ -167,7 +167,7 @@ int BPF_PROG(tp_test2)
>  }
>  
>  __u64 test7_result = 0;
> -#ifdef __TARGET_ARCH_x86
> +#if defined(bpf_target_x86) || defined(bpf_target_arm64)
>  SEC("fsession/bpf_fentry_test1")
>  int BPF_PROG(test7)
>  {
> diff --git a/tools/testing/selftests/bpf/progs/get_func_ip_test.c b/tools/testing/selftests/bpf/progs/get_func_ip_test.c
> index 65f7e1f182bf..43ff836a8ed8 100644
> --- a/tools/testing/selftests/bpf/progs/get_func_ip_test.c
> +++ b/tools/testing/selftests/bpf/progs/get_func_ip_test.c
> @@ -106,7 +106,7 @@ int BPF_URETPROBE(test8, int ret)
>  
>  __u64 test9_entry_result = 0;
>  __u64 test9_exit_result = 0;
> -#ifdef __TARGET_ARCH_x86
> +#if defined(bpf_target_x86) || defined(bpf_target_arm64)
>  SEC("fsession/bpf_fentry_test1")
>  int BPF_PROG(test9, int a)
>  {
> -- 
> 2.52.0
> 
> 
> 




