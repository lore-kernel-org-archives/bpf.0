Received: from out162-62-57-137.mail.qq.com (out162-62-57-137.mail.qq.com [162.62.57.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFCDD36B07E
	for <bpf@vger.kernel.org>; Wed, 22 Jul 2026 01:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784685528; cv=none; b=Ye8Hv0gFqXvjkCMVEnG9x7foQjuEinzQpMke0GJKkztV+xt8rUB953DB8Ry1weUJbOm1s3vkU15OifOvtDdZr2rH3bgImAL/uThFhnnrFpUpr9zKmvFt4I/IT4TH9nzkfQYAacWZ4w+LPpZKRdhcYLbSWoQONz5z6GTrpScY6FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784685528; c=relaxed/simple;
	bh=IJje5SWngaVxyVDRRMaRKi47baqlOi3NlvwN/wrzDGA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jAIwhSDYvMlCof1vvLM/X0UfdkEwGUPRj2LKR5wwrUb8VTua5MUr6lcfUcQ/auEs+81YiqWftEnr3Rh6UJqIVZnhQZZJ0ea/aIGkWFozVj/JUWmZFDtgH3ETDgfUOgUA1BizX4ZwzaejmKXcHX83o5PGchc3JA9rcPYaGaEFRWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=dU2abQph; arc=none smtp.client-ip=162.62.57.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="dU2abQph"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1784685512;
	bh=JRIA3NSye7Iyw3yxerwqg3o5A+ZOodSIhP38nHVicJE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=dU2abQphQaKmqrdwvhsmO8O+b8TluHbVRNKVGUkNa9P8e4uXHB33aGS9a8xhrmJp2
	 T+KbThnqaG/OGSCg/H9fEI7NwkXGGjHtVBwSVXTysrVo0sqPH4i5TZ31090pBs8fnw
	 1Z12+SDr6klgFZzNJQyIGGj69hewtjp3DRB6YpHQ=
Received: from [10.56.52.25] ([39.156.73.14])
	by newxmesmtplogicsvrsza63-0.qq.com (NewEsmtp) with SMTP
	id E9E9CC6E; Wed, 22 Jul 2026 09:58:30 +0800
X-QQ-mid: xmsmtpt1784685510tg67knvj9
Message-ID: <tencent_3654D85F2D473F10ED0C7C8520B3A22EE709@qq.com>
X-QQ-XMAILINFO: NoN45VbJ/ow6qu4BJzMOSChMBzkHMfMFaxbbOxiFc2my+C70vqYZEsYOUpGh8x
	 QrHzJa/+Ql9TQq4Q7NJt0nzI7s2d5wZFocrwMc1HNMZ0rMgY4fqvVSt/uDQVQl37mwB3XAUk0vJw
	 CfejocGS6cepYGXQHamuh8+V8e2psfMhQagN0miVKzFRA4GygT4XoM0AdqpwOlWcKo3AmYR5h3ix
	 MDiVgIuxpIfh5uxLsjlNvPkvnLkDfnI2lNhNXx7MUmdxOGooKzHKLl/bWu1ReeCzl07PDRKDJ1Mg
	 mpoP0zA6INTVEHXLzupJrL+gzhWahnDLygjZk1VZygFNxTyl+tLNffXaBBQV0zCVLQy0cE79Llw8
	 h7oyI3t//hb1EmY+V8QWoXXu7SCzrYn1uBTxO9ffFAAorLFh7qdh/8vcXeDA2JKn3G5nwcFwkwDu
	 O0lST2xm+Ulx98D6UeQQSafMHUCvGrIePSArICoAu4CMZMRsIscl2OKh+1k1SkaKWoXmXZRv8DhJ
	 6gCWYlPXhssRHyIOyYrStB0DEhC4IFresrXz8HtXL0R4UuLgBsl4cFx3sOz5lpHM+UYTXMd5Syjt
	 GBLct4/TGMilUrdTTXOamYyiCpC8ccDIr7mrnA21rQtvEFKBvmLyUy49wktUllt+bNAdfKk3w4pW
	 Ad5KX6JlEMIfy1kl8TPI7jkwuezKO3tK4Oy7HGezgnJ3QmLB3j1R1AoG4ncSNgIUCdkwCFrFUeOd
	 ObB0JEWDkmczQMXVePjaj494CqNOR0yrVH2yE3bozaALf0eJ/7ye7pqI9CFjw/GvMPxK2NRU41wH
	 dKabMmbHGX1UP34+gkiTQkWi1aBOblLrk+BwKzZGe0Y/Dqh47lXZdil7vlEFkqqAz82c8hl9v3Iz
	 jSW7sIVD2FtozK9HNJoufv7xOTaI3+uTmxs8JKy0hljtdFXiLnaPRw3efNXT3ND/GSAC/TQc6QU3
	 PnFXb+IYIoG0aenxhvwGny7tLOULVflDtJJn5FdWYUq6cS78bY8iDYyFiarzYL5zZu0z1SQSjXFm
	 +kDtmMbOWLBOY4MOVn1vdH0h1gqx8=
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-OQ-MSGID: <82e93462-ba03-429f-9403-abde8bddc5e3@foxmail.com>
Date: Wed, 22 Jul 2026 09:58:30 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v4 2/2] selftests/bpf: Test
 bpf_strcat,bpf_strncat kfuncs
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <cover.1784536164.git.rtoax@foxmail.com>
 <tencent_1A540D31C1E052E8262BE0324005E7756D05@qq.com>
 <20260720085114.072751F000E9@smtp.kernel.org>
Content-Language: en-US
From: Rong Tao <rtoax@foxmail.com>
In-Reply-To: <20260720085114.072751F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 7/20/26 16:51, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 5 potential issue(s) to consider:
> - [Critical] `__bpf_strncat` contains a critical out-of-bounds read and potential kernel panic when `dst` is not null-terminated.
> - [High] The new failure tests passing scalar or invalid pointers to `bpf_strcat` and `bpf_strncat` will be rejected by the verifier, breaking the selftest suite.
> - [High] The `test_strncat_success` test asserts an incorrect return value and checks against the wrong string, guaranteeing runtime failure.
> - [High] The `src` argument in `bpf_strcat` and `bpf_strncat` lacks a string or size suffix, causing the verifier to only enforce a 1-byte size, leading to kernel memory disclosure.
> - [High] `run_too_long_tests` asserts `-E2BIG` but `__bpf_strncat` returns `-EINVAL`, breaking the test suite.
> --
>
> --- Patch [2]: [PATCH bpf-next v4 2/2] selftests/bpf: Test bpf_strcat,bpf_strncat kfuncs ---
> commit 08f044c5d96948cad08013caa519f6e718db089c
> Author: Rong Tao <rongtao@cestc.cn>
>
> selftests/bpf: Test bpf_strcat,bpf_strncat kfuncs
>
> This patch adds selftests for the newly introduced bpf_strcat() and
> bpf_strncat() kfuncs. It extends existing string kfunc failure and success
> test suites to validate these operations. It also cleans up some extra
> whitespace in string_kfuncs_failure1.c.
>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/string_kfuncs.c b/tools/testing/selftests/bpf/prog_tests/string_kfuncs.c
>> index 300032a194451..460567ef622a5 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/string_kfuncs.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/string_kfuncs.c
>> @@ -24,6 +24,8 @@ static const char * const test_cases[] = {
>>   	"strcasestr",
>>   	"strnstr",
>>   	"strncasestr",
>> +	"strcat",
>> +	"strncat",
>>   };
> [Severity: High]
> Will run_too_long_tests() fail for these new test cases due to a mismatched
> error code?
>
> The run_too_long_tests() loop expects all over-long string tests to return
> -E2BIG. However, looking at __bpf_strncat() in kernel/bpf/helpers.c, if the
> destination buffer is full because it lacks a null terminator within dsz
> bounds:
>
>      if (dlen >= dsz || sz == 0 || dsz == 0)
>          return -EINVAL;
>
> Since the test string is completely filled without a null terminator, wouldn't
> it return -EINVAL instead of -E2BIG, causing the ASSERT_EQ to fail?
Thanks, i'll fix it.
>
>> diff --git a/tools/testing/selftests/bpf/progs/string_kfuncs_failure1.c b/tools/testing/selftests/bpf/progs/string_kfuncs_failure1.c
>> index bddc4e8579d24..d432d4990f802 100644
>> --- a/tools/testing/selftests/bpf/progs/string_kfuncs_failure1.c
>> +++ b/tools/testing/selftests/bpf/progs/string_kfuncs_failure1.c
> [ ... ]
>> @@ -30,29 +31,31 @@ char *invalid_kern_ptr = (char *)-1;
>>   
>>   /* Passing NULL to string kfuncs (treated as a userspace ptr) */
> [ ... ]
>> +SEC("syscall") __retval(USER_PTR_ERR)int test_strcat_null1(void *ctx) { return bpf_strcat(kern_buf, sizeof(kern_buf), NULL); }
>> +SEC("syscall") __retval(USER_PTR_ERR)int test_strncat_null1(void *ctx) { return bpf_strncat(kern_buf, sizeof(kern_buf), NULL, 2); }
>>   
>>   /* Passing userspace ptr to string kfuncs */
> [ ... ]
>> +SEC("syscall") __retval(USER_PTR_ERR) int test_strcat_user_ptr1(void *ctx) { return bpf_strcat(user_ptr, 1, kern_buf); }
> [Severity: High]
> Will these tests fail to load during verification rather than failing at
> runtime?
>
> Because the dst and src parameters in bpf_strcat() lack the __ign or
> __nullable suffix in their kernel definitions, the verifier treats them as
> strictly typed KF_ARG_PTR_TO_MEM.
>
> If we pass a scalar like user_ptr or NULL, won't the verifier reject the
> program during the load phase, breaking the test suite when the skeleton is
> loaded?
Thanks, i think, we should remove these `user_ptr` tests.
>
>> diff --git a/tools/testing/selftests/bpf/progs/string_kfuncs_failure2.c b/tools/testing/selftests/bpf/progs/string_kfuncs_failure2.c
>> index 412c53b87b182..2dbd1349689ea 100644
>> --- a/tools/testing/selftests/bpf/progs/string_kfuncs_failure2.c
>> +++ b/tools/testing/selftests/bpf/progs/string_kfuncs_failure2.c
> [ ... ]
>> @@ -23,5 +24,7 @@ SEC("syscall") int test_strstr_too_long(void *ctx) { return bpf_strstr(long_str,
>>   SEC("syscall") int test_strcasestr_too_long(void *ctx) { return bpf_strcasestr(long_str, "hello"); }
>>   SEC("syscall") int test_strnstr_too_long(void *ctx) { return bpf_strnstr(long_str, "hello", sizeof(long_str)); }
>>   SEC("syscall") int test_strncasestr_too_long(void *ctx) { return bpf_strncasestr(long_str, "hello", sizeof(long_str)); }
>> +SEC("syscall") int test_strcat_too_long(void *ctx) { return bpf_strcat(long_str, sizeof(long_str), str); }
> [Severity: Critical]
> Could this test trigger an out-of-bounds read and kernel panic?
>
> Looking at __bpf_strncat() in kernel/bpf/helpers.c, when calculating dlen
> there is no bounds check against dsz:
>
>      while (dst[dlen] != '\0')
>          dlen++;
>
> If test_strcat_too_long() passes a completely filled long_str without a null
> terminator, won't this loop read past the end of the BPF-provided buffer into
> adjacent kernel memory?

Thanks, i'll change it to:


     while (dlen < dsz && dst[dlen] != '\0')

>
>> diff --git a/tools/testing/selftests/bpf/progs/string_kfuncs_success.c b/tools/testing/selftests/bpf/progs/string_kfuncs_success.c
>> index f65b1226a81a3..71fbbe97b4c50 100644
>> --- a/tools/testing/selftests/bpf/progs/string_kfuncs_success.c
>> +++ b/tools/testing/selftests/bpf/progs/string_kfuncs_success.c
> [ ... ]
>> +__test(0) int test_strcat_success(void *ctx) {
>> +	char buf[32] = "hello";
>> +	bpf_strcat(buf, sizeof(buf), str);
>> +	return bpf_strcmp(buf, "hellohello world");
>> +}
> [Severity: High]
> Does the signature of bpf_strcat() allow arbitrary kernel memory disclosure?
>
> The src parameter in bpf_strcat() is annotated simply as const char *src,
> lacking a __str suffix or a paired size argument in kernel/bpf/helpers.c:
>
>      __bpf_kfunc int bpf_strcat(char *dst, u32 dst__sz, const char *src)
>
> This causes the verifier to check only the size of the base type (1 byte).
> If a BPF program passes a valid 1-byte memory region, could
> strncpy_from_kernel_nofault() safely copy past the 1-byte verified region,
> exposing adjacent kernel memory into dst?
>
>> +__test(8) int test_strncat_success(void *ctx) {
>> +	char buf[32] = "hello";
>> +	bpf_strncat(buf, sizeof(buf), str, 3);
>> +	return bpf_strcmp(buf, "hellohe");
>> +}
> [Severity: High]
> Is the expected return value correct here?
>
> The test uses __test(8), expecting the program to return 8. However,
> bpf_strcmp() evaluates to 0 on a successful match. Wouldn't the program
> return 0 instead of 8, causing this test to fail reliably?
>

