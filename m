Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2583905EA;
	Wed, 12 Aug 2026 04:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786507635; cv=none; b=qn0jihkOXn13t/sQwnC6YSnQVWFfgMDOIlld8sIWCEsraI+lbqRY29izx09dhDX555/6TN5baPEfJuHMBA+4UHBfAnbHeN+hgI7vdGyEC82sW1Wqd+l1kaTYIBFL4QIeYHZleWvSIGCWqL/kU8RyxZmzkE0XKMyAOI40aRcCdWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786507635; c=relaxed/simple;
	bh=jEfwf6pY2c/ehx5EqOVxqtxCTc31f1emrXYEoOLX5/U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NKq3E7rN/nXBEX1r6BtR4wdZ7u+Ej5zVpb1CcOCNvnWEQX2ZxubsH3xZpQVPXlAXuhiSqieGHSpryMrvtKWYROOZjlOehdZrhADvHgFSGKe5zHDdAJmENFmUPXS05oBmIQn1nKBs/zAP6fhIklMqxwVgPnicQoiHbz+wgQu7SEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iGjc0MJJ; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iGjc0MJJ"
Message-ID: <90e79390-569b-4ff9-8828-f7eb839cef6f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786507631;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=puo0fp38rYZgwJqTaTvd8UMYu3clFBbGtdCSz6QQqZ0=;
	b=iGjc0MJJKdKhd0HiIWTPDl31V+PiXhwq7hwqy+ioQPvScVH+uZseDgvQ9itZAeRRn1Fd44
	n/1da9Ya4YI480prq6uv6s0JGxFiHLs8uwYW55O7nyYc/QvDXVj2PiiA5CWJ99ASqtzWe/
	ON9eb3IKHw5LmBhvKJzexLguu4r6xkA=
Date: Wed, 12 Aug 2026 12:06:39 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 10/13] selftests/bpf: Add tracing_multi bpf prog
 cookie test
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, emil@etsalapatis.com, ihor.solodrai@linux.dev,
 qmo@kernel.org, shuah@kernel.org, yatsenko@meta.com,
 avinash.duduskar@gmail.com, a.s.protopopov@gmail.com, ameryhung@gmail.com,
 jordan@jrife.io, rongtao@cestc.cn, eyal.birger@gmail.com,
 pulehui@huawei.com, tanjingguo@huawei.com, malin89@huawei.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, martin.lau@kernel.org, clm@meta.com
References: <20260809150111.45000-11-leon.hwang@linux.dev>
 <64e207da37d7fd430e941082680bc7d32ee40ef7098bc40c5bf2c9d318c37e5c@mail.kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <64e207da37d7fd430e941082680bc7d32ee40ef7098bc40c5bf2c9d318c37e5c@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 10/8/26 00:20, bot+bpf-ci@kernel.org wrote:
>> diff --git a/tools/testing/selftests/bpf/prog_tests/tracing_multi.c b/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
>> index 5cf11707eaf89..070266a864d4f 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
>> @@ -304,9 +304,12 @@ static int run_bpf_target(struct bpf_program *prog, __u32 retval, const char *na
>>  	return 0;
>>  }
>>
>> -static void test_link_api_bpf_prog(void)
>> +static void __test_link_api_bpf_prog(bool test_cookies)
>>  {
>>  	const char *funcs[] = { "target_1", "target_2" };
>> +	__u64 fentry_cookies[] = { 0xfeed01, 0xfeed01 };
>> +	__u64 fexit_cookies[] = { 0xfeed02, 0xfeed02 };
>> +	__u64 fsession_cookies[] = { 0xfeed03, 0xfeed03 };
> 
> A subsystem pattern flags this as potentially concerning: every per-target
> cookie array holds the same value twice. The test on the BPF side compares
> against a single scalar global set from element [0]:
> 
>   skel->bss->fentry_cookie = fentry_cookies[0];
> 
> and in progs/tracing_multi_bpf.c:
> 
>   if (!test_cookies || bpf_get_attach_cookie(ctx) == fentry_cookie)
>           test_result_fentry++;
> 
> Since cookie[0] == cookie[1] for all three arrays, the test cannot
> distinguish a correct cookie-to-target mapping from a permuted one. The
> assertions (test_result_fentry == 2, etc.) succeed as long as some
> correct-looking cookie value is delivered on both invocations, but swapping
> the cookies of target_1 and target_2 in the kernel is invisible.
> 
> That matters because the kernel path this commit exercises is exactly a
> permutation: bpf_tracing_multi_attach() calls check_dup_keys() which calls
> keys_swap_r() in kernel/trace/bpf_trace.c to reorder the cookies, ids, and
> progs arrays to follow the sorted trampoline keys:
> 
>   id_a    = ids + (key_a - keys);
>   if (data->progs) { ... swap(*prog_a, *prog_b); }
>   if (cookies) { cookie_a = cookies + (id_a - ids); ... swap(*cookie_a, *cookie_b); }
> 
> An indexing mistake in that swap could desynchronise cookies from progs/ids,
> yet the test would still pass. Since fds[]/ids[] come from BPF prog FDs, the
> sort order is not the array order the caller supplied.
> 
> The neighbouring test for kernel-function targets in this same file already
> does this correctly: bpf_fentry_test_cookies[] uses ten distinct values
> deliberately out of order (8, 9, 7, 5, 4, 2, 3, 1, 10, 6) and
> progs/tracing_multi_check.c checks the cookie per-IP with something like:
> 
>   err |= test_cookies ? cookie != 8 : 0;
> 
> under `ip == &bpf_fentry_test1`.
> 
> Can the test use distinct cookies and a bpf_get_func_ip()-based per-target
> expectation so it is sensitive to cookie mis-association?
> 

Will update the cookies with different values.

>>  	LIBBPF_OPTS(bpf_tracing_multi_opts, opts);
>>  	struct tracing_multi_bpf *skel = NULL;
>>  	int fds[ARRAY_SIZE(funcs)];
> 
> [ ... ]
> 
>> @@ -356,6 +367,16 @@ static void test_link_api_bpf_prog(void)
>>  	tracing_multi_bpf__destroy(skel);
>>  }
>>
>> +static void test_link_api_bpf_prog(void)
>> +{
>> +	__test_link_api_bpf_prog(false);
>> +}
>> +
>> +static void test_cookies_bpf_prog(void)
>> +{
>> +	__test_link_api_bpf_prog(true);
>> +}
> 
> This isn't a bug, but would calling __test_link_api_bpf_prog(false) and
> __test_link_api_bpf_prog(true) straight from the two subtest arms read more
> consistently? The neighbouring test_link_api_ids() is dispatched directly as
> test_link_api_ids(false) and test_link_api_ids(true) just a dozen lines
> down, without wrapper functions.
> 

Okay, will drop these two wrappers.

Thanks,
Leon

> [ ... ]
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31320427087

