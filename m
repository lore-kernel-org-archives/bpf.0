Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA3C3FEF
	for <bpf@vger.kernel.org>; Sat, 24 Jan 2026 06:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769235022; cv=none; b=Eni3Xz3b2N57AoFpSyVpy3gF7T844/RqvYdVSKGlLbhi9N5q034b/Dc+9XEwIPC8p/2QFRNQ2uN2DBr/GfgB8cMHm5o9ATHA82YyWYWH8bj5LQjLf19VKn1nK0CO8LKPK/igu/M0ljnZugVwJQBB/pajRBaGKQ9InFu6JFddZBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769235022; c=relaxed/simple;
	bh=3DshowPd5UH8QdtymmXbXqHLZNSLQexFMhz/sxvHnbI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pZkNjVTUXYshm/0raDMyEn/P2dIOAbOlb0s55nRUf0X1NSUP1PUcHPYu4DB9vu6cwbX+Qi9Ss6u0O9khxq6VLYl7TnEtH+8Ey25kFLh/yES1j/OZhoZ1VvJNiAvtBjROpndLT8HE7MoPpYdMUgXzGnQc43178Y6aLDxdcMqZvfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=caspnkqA; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="caspnkqA"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769235017;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qLL+DSALaiaCyHkccN04ZlpoBn+BdgA+NrFlgliZ5k4=;
	b=caspnkqAJ50SJc8nbFa/JkdpIe/38FO1OkKTaLWqSf0RhEa6aowplV8D9JthGmVAYzxrHY
	QgTYulyJQnW56EH7bZMQDLwHjntqgFsZO8Qaoqx44sr3Tm9sYh63aFGH71BGoPPL8H9AkK
	+RACdOkhT0r7JqMUWdqnGMg44xO/9TY=
From: Menglong Dong <menglong.dong@linux.dev>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, davem@davemloft.net,
 dsahern@kernel.org, tglx@linutronix.de, mingo@redhat.com,
 jiang.biao@linux.dev, bp@alien8.de, dave.hansen@linux.intel.com,
 x86@kernel.org, hpa@zytor.com, bpf@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH bpf-next v12 11/13] selftests/bpf: test bpf_get_func_* for
 fsession
Date: Sat, 24 Jan 2026 13:09:12 +0800
Message-ID: <5962490.DvuYhMxLoT@7950hx>
In-Reply-To: <20260124033119.28682-12-dongml2@chinatelecom.cn>
References:
 <20260124033119.28682-1-dongml2@chinatelecom.cn>
 <20260124033119.28682-12-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2026/1/24 11:31, Menglong Dong wrote:
> Test following bpf helper for fsession:
>   bpf_get_func_arg()
>   bpf_get_func_arg_cnt()
>   bpf_get_func_ret()
>   bpf_get_func_ip()
> 
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> ---
>  .../bpf/prog_tests/get_func_args_test.c       |  1 +
>  .../bpf/prog_tests/get_func_ip_test.c         |  2 ++
>  .../selftests/bpf/progs/get_func_args_test.c  | 31 ++++++++++++++++++-
>  .../selftests/bpf/progs/get_func_ip_test.c    | 14 +++++++++
>  4 files changed, 47 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/get_func_args_test.c b/tools/testing/selftests/bpf/prog_tests/get_func_args_test.c
> index fadee95d3ae8..96b27de05524 100644
> --- a/tools/testing/selftests/bpf/prog_tests/get_func_args_test.c
> +++ b/tools/testing/selftests/bpf/prog_tests/get_func_args_test.c
> @@ -41,6 +41,7 @@ void test_get_func_args_test(void)
>  	ASSERT_EQ(skel->bss->test4_result, 1, "test4_result");
>  	ASSERT_EQ(skel->bss->test5_result, 1, "test5_result");
>  	ASSERT_EQ(skel->bss->test6_result, 1, "test6_result");
> +	ASSERT_EQ(skel->bss->test7_result, 1, "test7_result");
>  
>  cleanup:
>  	get_func_args_test__destroy(skel);
> diff --git a/tools/testing/selftests/bpf/prog_tests/get_func_ip_test.c b/tools/testing/selftests/bpf/prog_tests/get_func_ip_test.c
> index c40242dfa8fb..7772a0f288d3 100644
> --- a/tools/testing/selftests/bpf/prog_tests/get_func_ip_test.c
> +++ b/tools/testing/selftests/bpf/prog_tests/get_func_ip_test.c
> @@ -46,6 +46,8 @@ static void test_function_entry(void)
>  	ASSERT_EQ(skel->bss->test5_result, 1, "test5_result");
>  	ASSERT_EQ(skel->bss->test7_result, 1, "test7_result");
>  	ASSERT_EQ(skel->bss->test8_result, 1, "test8_result");
> +	ASSERT_EQ(skel->bss->test9_entry_result, 1, "test9_entry_result");
> +	ASSERT_EQ(skel->bss->test9_exit_result, 1, "test9_exit_result");
>  
>  cleanup:
>  	get_func_ip_test__destroy(skel);
> diff --git a/tools/testing/selftests/bpf/progs/get_func_args_test.c b/tools/testing/selftests/bpf/progs/get_func_args_test.c
> index 5b7233afef05..8ecc5f339552 100644
> --- a/tools/testing/selftests/bpf/progs/get_func_args_test.c
> +++ b/tools/testing/selftests/bpf/progs/get_func_args_test.c
> @@ -1,5 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0
> -#include <linux/bpf.h>
> +#include <vmlinux.h>
>  #include <bpf/bpf_helpers.h>
>  #include <bpf/bpf_tracing.h>
>  #include <errno.h>
> @@ -165,3 +165,32 @@ int BPF_PROG(tp_test2)
>  
>  	return 0;
>  }
> +
> +__u64 test7_result = 0;
> +SEC("fsession/bpf_fentry_test1")
> +int BPF_PROG(test7)
> +{
> +	__u64 cnt = bpf_get_func_arg_cnt(ctx);
> +	__u64 a = 0, z = 0, ret = 0;
> +	__s64 err;
> +
> +	test7_result = cnt == 1;
> +
> +	/* valid arguments */
> +	err = bpf_get_func_arg(ctx, 0, &a);
> +	test7_result &= err == 0 && ((int) a == 1);
> +
> +	/* not valid argument */
> +	err = bpf_get_func_arg(ctx, 1, &z);
> +	test7_result &= err == -EINVAL;
> +
> +	if (bpf_session_is_return(ctx)) {
> +		err = bpf_get_func_ret(ctx, &ret);
> +		test7_result &= err == 0 && ret == 2;
> +	} else {
> +		err = bpf_get_func_ret(ctx, &ret);
> +		test7_result &= err == 0 && ret == 0;
> +	}
> +
> +	return 0;
> +}

CI failed, as this testcase can't run on !CONFIG_X86_64, and
"#ifdef __TARGET_ARCH_x86" should be used here.

Will send a V13 later :)

> diff --git a/tools/testing/selftests/bpf/progs/get_func_ip_test.c b/tools/testing/selftests/bpf/progs/get_func_ip_test.c
> index 2011cacdeb18..bd7598a037cd 100644
> --- a/tools/testing/selftests/bpf/progs/get_func_ip_test.c
> +++ b/tools/testing/selftests/bpf/progs/get_func_ip_test.c
> @@ -103,3 +103,17 @@ int BPF_URETPROBE(test8, int ret)
>  	test8_result = (const void *) addr == (const void *) uprobe_trigger;
>  	return 0;
>  }
> +
> +__u64 test9_exit_result = 0;
> +__u64 test9_entry_result = 0;
> +SEC("fsession/bpf_fentry_test1")
> +int BPF_PROG(test9, int a)
> +{
> +	__u64 addr = bpf_get_func_ip(ctx);
> +
> +	if (bpf_session_is_return(ctx))
> +		test9_exit_result = (const void *) addr == &bpf_fentry_test1;
> +	else
> +		test9_entry_result = (const void *) addr == &bpf_fentry_test1;
> +	return 0;
> +}
> 




