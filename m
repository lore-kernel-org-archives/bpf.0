Received: from out162-62-57-87.mail.qq.com (out162-62-57-87.mail.qq.com [162.62.57.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0993B4E9F
	for <bpf@vger.kernel.org>; Thu, 16 Jul 2026 08:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784191158; cv=none; b=laHXSik1olALiNLXPUZJUc9rHUiBO258SZOgr+jTLGf5aKQLNOAHk2uJ9vTbS7YJyzMVig7b+Y7tD2iGdbu3bT4/6eLS5pjJ+lubdWHUzFCNt3CmxWTy0Ehk6EW8XBUDAcrC9/wRZPradiEKHvSiidvVq95AI1ClSnXNiH5TPjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784191158; c=relaxed/simple;
	bh=x2bQJ7vfupd36anNgI86CIztM7aj/1OzOlOjAoooFSI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iDlLUz8Fhl8NN8tBfZnGbRMnQZ5m6fjfRrsNmNgWTIhWcieVx2DREAVgQ+W2Ku1gNNL6nmL9xofYH+rpumg6Adsk2z85PzLaYVvvhe9djIFRLBwrC0WLqxYMkPsP26J2cJYLA8Rj8/0ktfRIdIH5RH/C9WzNhHVVWSFkRr/iM6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=OVlno6UJ; arc=none smtp.client-ip=162.62.57.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="OVlno6UJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1784191151;
	bh=WkeEU9gbBbAhKaoVq8Px2vG3HlKEpMx6/DAQ8mAJqfI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=OVlno6UJ3c7Zz+E2tvzlsbZshBXH3lfTvlKWp/a9tf4xL9E5qk9XfU4/Az0gyXrQc
	 s//9yYhKat2Gcmleiq72Lr3rFG0gSAKpozUWRhnIho9LcLQV1T4zfoF9fAx8ZR7ZRk
	 d6NVeq8CZxn/yVJHRoOhIRjcrkwkgMSYJYk6wAys=
Received: from [10.56.52.25] ([39.156.73.14])
	by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
	id 9C9216DA; Thu, 16 Jul 2026 16:39:09 +0800
X-QQ-mid: xmsmtpt1784191149tl4vgbkl2
Message-ID: <tencent_93F2525405E17565340D71CA005A482C6B05@qq.com>
X-QQ-XMAILINFO: NwU6Bou9okj/YUfiKeZ/EUpwxIzIK8n26/Z3RJkzrNM3M9hq8yIvbzlbUgX1uy
	 IPpKxNnMlW+r8BNC9Y2m1D1KoEXrLV/Riq/ipXkqWJ+FOwDngI2qhaUWpanYyCOPnqZC9oaURYoU
	 70eUmJ38xO62s8qsxe0CwNsJuVUFhnSaDpSgedMadDY2rjaKV/oTNa8LUHUehYBLX8ULE+NGoZaq
	 reVnByMEVl1NroZPI+yOxrrMCHQhCFy/oQh+FAYpd7tp6bLxEOknRUkWkEVpxtiI40/t02ebE6U5
	 ucyx1JtXIt1okk20fkYy4GtmSz0+w/nW9nl9WaMwOSx/A4z6GEcBVF2bKz/yi+jKSsUgKiQBtRJq
	 /HiocMhv0QeFLTwQ0CB0Fi+d40xd44U0P8032iks7FD4UXgzhZjdw1mJwYl1qtwihH/ueoK9AubZ
	 gsS0JGM9Zlxt722711J5KgT1nhJYjb5YeTcYAnJIzRtbCGSBc5nwFYsCHwu2QaRpYZPKS87VwrOe
	 T2hJLxsdLAu82mpf+MdXRtpbxg4vE06/L1N0yaG6xXMgY2slqQP9zLSodXYQLWpqlrXupxEfE16N
	 6x1FCHcAhcEntycK1T4vlZ77hcum0bEdGPM1yc/LrdMKvpn9p4ISZA2cxvoNWDf3MQ4GqIbLbEm+
	 PLReuaXunTX1Vs7w4Z9mHPWwp9Bj5ucSK8fdYcyy6+65CSTFpNfY1nrMPd9jmMs9q72+XhIbm9hD
	 ymrhl7MYqf05EZcTGharHPoxF2TVs+zn3JRDNRZ1vvP8yo+gZw5ZCGRo9YYTsyP0kYiQwNK8FISO
	 qDHsbu1MehKqB8r5mXxSpk9YUwthM8wU+ZbC6qX8xR8KzeEaV6PjJkQJfRryge2ddMhPVdnOGtVP
	 xdXMh2BJ3GJ71Zsv4FPSLGhCZGKtbQZTnO94AojnJo/E8VzOZ6e8c8MfSEApDFQyo6/+STs4tQaq
	 /ZWgWSS+i2i8Xa0KliEb6SRc61v7VM3423JIMsiDdzR9wOEg0hk7CqSXcJ2Kc+Rn25uiS6mNUF1E
	 Z61JevM1GVoe5dDeQXnTuUM/5YpJk2yLLr3rOkyw==
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
X-OQ-MSGID: <b2ea354e-cdbd-4b21-a9cb-3f6389e847e2@foxmail.com>
Date: Thu, 16 Jul 2026 16:39:08 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: Test
 bpf_strcat,bpf_strncat kfuncs
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <cover.1784078494.git.rtoax@foxmail.com>
 <tencent_DB0510330C3A8574B3C62E6154165FCB4709@qq.com>
 <20260715014256.15E721F000E9@smtp.kernel.org>
Content-Language: en-US
From: Rong Tao <rtoax@foxmail.com>
In-Reply-To: <20260715014256.15E721F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 7/15/26 09:42, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
>
> New issues:
> - [Medium] The selftest `test_strncat_success` unconditionally fails because it incorrectly expects a return value of 13, assuming the global buffer retains state across subtests.
> - [Medium] Six failure tests for `strcat` and `strncat` will fail to load in the verifier because they pass invalid scalars (`NULL`, `1`, `-1`) to the strictly typed `dst` memory pointer argument.
>
> Pre-existing issues:
> - [High] The `__bpf_strncat` kfunc unconditionally performs an out-of-bounds read of the source string to check for truncation, erroneously returning `-EFAULT` on perfectly valid memory.
> --
>
> --- Patch [2]: [PATCH bpf-next v2 2/2] selftests/bpf: Test bpf_strcat,bpf_strncat kfuncs ---
> commit a3847dce2f7db636af75a6ec747d26e7cc1b00dd
> Author: Rong Tao <rongtao@cestc.cn>
>
> selftests/bpf: Test bpf_strcat,bpf_strncat kfuncs
>
> Add tests for new kfuncs bpf_strcat() and bpf_strncat().
>
>> diff --git a/tools/testing/selftests/bpf/progs/string_kfuncs_failure1.c b/tools/testing/selftests/bpf/progs/string_kfuncs_failure1.c
>> index bddc4e8579d24..29bc7eabbb6aa 100644
>> --- a/tools/testing/selftests/bpf/progs/string_kfuncs_failure1.c
>> +++ b/tools/testing/selftests/bpf/progs/string_kfuncs_failure1.c
> [ ... ]
>> @@ -53,6 +54,10 @@ SEC("syscall")  __retval(USER_PTR_ERR)int test_strnstr_null1(void *ctx) { return
>>   SEC("syscall")  __retval(USER_PTR_ERR)int test_strnstr_null2(void *ctx) { return bpf_strnstr("hello", NULL, 1); }
>>   SEC("syscall")  __retval(USER_PTR_ERR)int test_strncasestr_null1(void *ctx) { return bpf_strncasestr(NULL, "hello", 1); }
>>   SEC("syscall")  __retval(USER_PTR_ERR)int test_strncasestr_null2(void *ctx) { return bpf_strncasestr("hello", NULL, 1); }
>> +SEC("syscall")  __retval(USER_PTR_ERR)int test_strcat_null1(void *ctx) { return bpf_strcat(NULL, 6, "hello"); }
> [Severity: Medium]
> Will this test, along with test_strcat_user_ptr1 and test_strcat_pagefault1
> added below, fail to load in the verifier?
>
> Because the dst argument in bpf_strcat() lacks the __ign suffix, the verifier
> strictly checks it as a KF_ARG_PTR_TO_MEM_SIZE. Passing NULL or scalar values
> like 1 or -1 causes load-time rejection with -EACCES.
>
> Since the __retval(...) annotation expects a successful load followed by a
> runtime error, will these tests cause the test runner to abort with an
> unexpected load failure?
>
>> +SEC("syscall")  __retval(USER_PTR_ERR)int test_strcat_null2(void *ctx) { return bpf_strcat(kern_buf, sizeof(kern_buf), NULL); }
>> +SEC("syscall")  __retval(USER_PTR_ERR)int test_strncat_null1(void *ctx) { return bpf_strncat(NULL, 6, "hello", 2); }
>> +SEC("syscall")  __retval(USER_PTR_ERR)int test_strncat_null2(void *ctx) { return bpf_strncat(kern_buf, sizeof(kern_buf), NULL, 2); }
> [ ... ]
>> diff --git a/tools/testing/selftests/bpf/progs/string_kfuncs_success.c b/tools/testing/selftests/bpf/progs/string_kfuncs_success.c
>> index f65b1226a81a3..93996b0e9595e 100644
>> --- a/tools/testing/selftests/bpf/progs/string_kfuncs_success.c
>> +++ b/tools/testing/selftests/bpf/progs/string_kfuncs_success.c
> [ ... ]
>> @@ -59,5 +60,7 @@ __test(-ENOENT) int test_strncasestr_notfound1(void *ctx) { return bpf_strncases
>>   __test(-ENOENT) int test_strncasestr_notfound2(void *ctx) { return bpf_strncasestr(str, "hello", 4); }
>>   __test(-ENOENT) int test_strncasestr_notfound3(void *ctx) { return bpf_strncasestr("", "a", 0); }
>>   __test(0) int test_strncasestr_empty(void *ctx) { return bpf_strncasestr(str, "", 1); }
>> +__test(10) int test_strcat_success(void *ctx) { return bpf_strcat(buf, sizeof(buf), "world"); }
>> +__test(13) int test_strncat_success(void *ctx) { return bpf_strncat(buf, sizeof(buf), "world", 3); }
> [Severity: Medium]
> Does this test expect an incorrect return value?
>
> The BPF test loader isolates subtests by reloading the skeleton for each test
> program. This resets the global variable buf back to its initial .data state
> of "hello" (5 bytes) before this test runs.
>
> Because bpf_strncat() appends "wor" (3 bytes) to "hello", won't the correct
> return value be 8 instead of 13?
>
> [Severity: High]
> This is a pre-existing issue, but I noticed a potential problem in the
> __bpf_strncat() implementation being tested here.
>
> kernel/bpf/helpers.c:__bpf_strncat() {
>          ...
>          __get_kernel_nofault(&cs, src, char, err_out);
>          if (cs != '\0' && sz > copied)
>                  return -E2BIG;
>          ...
> }
>
> Does this unconditionally read past the requested size boundary?
>
> If a caller requests exactly sz bytes, and the source string satisfies this
> but ends at a page boundary, won't the unconditional read of the next byte
> cause a spurious page fault and incorrectly return -EFAULT instead of success?

Thanks, i'll fix it in v3 ;)

Rong Tao

>
>>   char _license[] SEC("license") = "GPL";

