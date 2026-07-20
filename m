Received: from out162-62-57-87.mail.qq.com (out162-62-57-87.mail.qq.com [162.62.57.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC773CE0A2;
	Mon, 20 Jul 2026 08:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784535794; cv=none; b=KvQWabxdTSY70zQvnGSRP2xYrwqlhU1MlrOYRPfKe0ryIHQuH6ycDJ3dBd1Zh5WCyghvNUuyFykzeRhPkqvdfaSicCm/Wgvsgkq2lD23oDLaVGzn9KYoAhB/8IZ5aP5WsFyEokGVzUrxV3UQmTAVnSTbxaeQ9QIdLDkSXjZBeWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784535794; c=relaxed/simple;
	bh=+Ww6g1BOOIZYRU/HB8YQ2wLFM1gTjWhXy8zjVIcpeSA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dnPNm/GW9m6LucEdBACm2ahtbWlGwSiKE8D8eCKIcSUGmFWtl1dTM0+pjbZ0316CFw+LQzQy0M2wiHsJT+q7fAHtGf72AcmfE+ni7zF93I1ns7qcqi5ZjwHtRmLflxwQGZndejugkFhyq96lG3zN6SnLvVyMt4lEdhy4l1rY0Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=xC8zVxd0; arc=none smtp.client-ip=162.62.57.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="xC8zVxd0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1784535778;
	bh=lvSebG/Y5H0wiZe3nPazWfG36HyzRFxSERP/HX+bkj4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=xC8zVxd0CB0Zu3Z1Oz5l67LKLcnPBN355NXxfcn5ePv+lMkea+lpJhhu9O6NHW4Ou
	 bLv4w2CnI7Zov+LDCtx/u+3k59wUO9Pozvd5hz/sPrOddxBhDQnQrlxIkUsIw6gYQH
	 OHH4Tn7swVBOe6lpxNEernj+owJMMMOy1FvskUn8=
Received: from [10.56.52.25] ([39.156.73.14])
	by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
	id 5B4B4258; Mon, 20 Jul 2026 16:22:52 +0800
X-QQ-mid: xmsmtpt1784535772tubsdpmld
Message-ID: <tencent_C08570B3402EE154BA5F4F466110390DDC09@qq.com>
X-QQ-XMAILINFO: NwU6Bou9okj/QhVoYQKmklN+cjTKvUUYdRD+4L7iEVB9XYqUG62LQYeAagPKtU
	 vLYF9+5g1Jdn+ayKsulfVFUYcLxj25b6fMvM1osqvOeLAruWUcK5XIox19eMp3YXdTY6GSmKGRnt
	 vsDLR8KKyzNZpLEt9PqNYY+czZBGMPYvYCrxvShu4RY7/g2OJIIvr0kJVFOxIyPsaGWUsfU93wKt
	 Gpw7ryZw2XpHjDALgeqYXGXvbDC8PRed2GIWJ0q2OCBJdcpJVf2glcNJJJ3RAntKXSFxY9S89FPg
	 ngWF9b7iPZZSDzQu2CNk7IbEaL5Ctc4E8MM5wU9HWYAX7UDVUY8oDU7u2XnJQUYowM9idN9d4ewx
	 yu1YDjwQSVCpxa//47zDNsAqiIWO0D06pKB7Pb3C9EUXRBhSg3noDy+94tp8+rLGHTxGram6dFB5
	 MtBeFmg3r+uuFGdkKlqQkooWzrXczkqd4TILlU1kWChbNOVkmVkkClclGk8IOM17Paq33yzSiPAG
	 ivMnj+z9N7HlUXZqOzPL8ivr8435BmIEkydD+r1k+BYFsbgzc/3o87N+xEJb8lk0obBahTldJzxi
	 850S5i7S/AnPUpmTVYB3iGl3AllfC3MB6uRLOffcUywvYU+8aZ690U/WIzVVBaA6N5rjLBmzBtDT
	 hceLX6osmMFz+j7eBQZL9SEyXokgy3b8Wvk8NH96YflYZdEJs66M4w9w6uv6lPejXGvLihHVz3Bs
	 S1vm6JGgrPtsT3kvu30cp3pthnucLCuY+DEtTUB1Bmk2BrqEqvuLLW7LMXtlvatxd0xcCgyBmu1w
	 Mzlep67zsKjl9EK+fhFrL7hKtCLYzGGVz/ghubL+aFqQzgsRELpgYTeAW4K5C6O+qhKcYNS4Gqhy
	 Kms2Qi/Yasijm7dEIne6NCN7mHA0BNTJn180NwR2TbNpCeCnbtpbnu4R0PImFA14Wx5KN/ynFly9
	 J/IUy43fsIZiJdThkNF5YetFJ7tungeWPACG8ACLO6EW2BPuLgEb4nhkh725gSZxjwLBsiRmX90X
	 hrlAZ6KyP4O1Gr4ZS15DZAXTtMZcBnrnKcXS1G4zf3WyAopcLM
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-OQ-MSGID: <e17ad0d1-4c68-430f-8548-ee0dbd2674c1@foxmail.com>
Date: Mon, 20 Jul 2026 16:22:52 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 2/2] selftests/bpf: Test
 bpf_strcat,bpf_strncat kfuncs
To: Viktor Malik <vmalik@redhat.com>, andrii@kernel.org, ast@kernel.org
Cc: Rong Tao <rongtao@cestc.cn>, Daniel Borkmann <daniel@iogearbox.net>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>, Shuah Khan <shuah@kernel.org>,
 Yuzuki Ishiyama <ishiyama@hpc.is.uec.ac.jp>,
 "open list:BPF [GENERAL] (Safe Dynamic Programs and Tools)"
 <bpf@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
References: <cover.1784194024.git.rtoax@foxmail.com>
 <tencent_C7A5E27560540491DBE052682ACBE1F24405@qq.com>
 <0f252920-38a8-4280-81aa-67240f60cadd@redhat.com>
Content-Language: en-US
From: Rong Tao <rtoax@foxmail.com>
In-Reply-To: <0f252920-38a8-4280-81aa-67240f60cadd@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 7/17/26 15:34, Viktor Malik wrote:
> On 7/16/26 11:34, Rong Tao wrote:
>> From: Rong Tao <rongtao@cestc.cn>
>>
>> Add tests for new kfuncs bpf_strcat() and bpf_strncat().
>>
>> Signed-off-by: Rong Tao <rongtao@cestc.cn>
>> ---
>>   .../testing/selftests/bpf/prog_tests/string_kfuncs.c  |  2 ++
>>   .../selftests/bpf/progs/string_kfuncs_failure1.c      | 11 +++++++++++
>>   .../selftests/bpf/progs/string_kfuncs_failure2.c      |  2 ++
>>   .../selftests/bpf/progs/string_kfuncs_success.c       |  4 ++++
>>   4 files changed, 19 insertions(+)
>>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/string_kfuncs.c b/tools/testing/selftests/bpf/prog_tests/string_kfuncs.c
>> index 300032a19445..460567ef622a 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/string_kfuncs.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/string_kfuncs.c
>> @@ -24,6 +24,8 @@ static const char * const test_cases[] = {
>>   	"strcasestr",
>>   	"strnstr",
>>   	"strncasestr",
>> +	"strcat",
>> +	"strncat",
>>   };
>>   
>>   void run_too_long_tests(void)
>> diff --git a/tools/testing/selftests/bpf/progs/string_kfuncs_failure1.c b/tools/testing/selftests/bpf/progs/string_kfuncs_failure1.c
>> index bddc4e8579d2..973a6ba643d4 100644
>> --- a/tools/testing/selftests/bpf/progs/string_kfuncs_failure1.c
>> +++ b/tools/testing/selftests/bpf/progs/string_kfuncs_failure1.c
>> @@ -8,6 +8,7 @@
>>   
>>   char *user_ptr = (char *)1;
>>   char *invalid_kern_ptr = (char *)-1;
>> +char kern_buf[32] = { "hello" };
>>   
>>   /*
>>    * When passing userspace pointers, the error code differs based on arch:
>> @@ -53,6 +54,8 @@ SEC("syscall")  __retval(USER_PTR_ERR)int test_strnstr_null1(void *ctx) { return
>>   SEC("syscall")  __retval(USER_PTR_ERR)int test_strnstr_null2(void *ctx) { return bpf_strnstr("hello", NULL, 1); }
>>   SEC("syscall")  __retval(USER_PTR_ERR)int test_strncasestr_null1(void *ctx) { return bpf_strncasestr(NULL, "hello", 1); }
>>   SEC("syscall")  __retval(USER_PTR_ERR)int test_strncasestr_null2(void *ctx) { return bpf_strncasestr("hello", NULL, 1); }
>> +SEC("syscall")  __retval(USER_PTR_ERR)int test_strcat_null1(void *ctx) { return bpf_strcat(kern_buf, sizeof(kern_buf), NULL); }
>> +SEC("syscall")  __retval(USER_PTR_ERR)int test_strncat_null1(void *ctx) { return bpf_strncat(kern_buf, sizeof(kern_buf), NULL, 2); }
>>   
>>   /* Passing userspace ptr to string kfuncs */
>>   SEC("syscall") __retval(USER_PTR_ERR) int test_strcmp_user_ptr1(void *ctx) { return bpf_strcmp(user_ptr, "hello"); }
>> @@ -79,6 +82,10 @@ SEC("syscall") __retval(USER_PTR_ERR) int test_strnstr_user_ptr1(void *ctx) { re
>>   SEC("syscall") __retval(USER_PTR_ERR) int test_strnstr_user_ptr2(void *ctx) { return bpf_strnstr("hello", user_ptr, 1); }
>>   SEC("syscall") __retval(USER_PTR_ERR) int test_strncasestr_user_ptr1(void *ctx) { return bpf_strncasestr(user_ptr, "hello", 1); }
>>   SEC("syscall") __retval(USER_PTR_ERR) int test_strncasestr_user_ptr2(void *ctx) { return bpf_strncasestr("hello", user_ptr, 1); }
>> +SEC("syscall") __retval(USER_PTR_ERR) int test_strcat_user_ptr1(void *ctx) { return bpf_strcat(user_ptr, 1, "hello"); }
>> +SEC("syscall") __retval(USER_PTR_ERR) int test_strcat_user_ptr2(void *ctx) { return bpf_strcat(kern_buf, sizeof(kern_buf), user_ptr); }
>> +SEC("syscall") __retval(USER_PTR_ERR) int test_strncat_user_ptr1(void *ctx) { return bpf_strncat(user_ptr, 1, "hello", 2); }
>> +SEC("syscall") __retval(USER_PTR_ERR) int test_strncat_user_ptr2(void *ctx) { return bpf_strncat(kern_buf, sizeof(kern_buf), user_ptr, 1); }
>>   
>>   #endif /* __TARGET_ARCH_s390 */
>>   
>> @@ -107,5 +114,9 @@ SEC("syscall") __retval(-EFAULT) int test_strnstr_pagefault1(void *ctx) { return
>>   SEC("syscall") __retval(-EFAULT) int test_strnstr_pagefault2(void *ctx) { return bpf_strnstr("hello", invalid_kern_ptr, 1); }
>>   SEC("syscall") __retval(-EFAULT) int test_strncasestr_pagefault1(void *ctx) { return bpf_strncasestr(invalid_kern_ptr, "hello", 1); }
>>   SEC("syscall") __retval(-EFAULT) int test_strncasestr_pagefault2(void *ctx) { return bpf_strncasestr("hello", invalid_kern_ptr, 1); }
>> +SEC("syscall") __retval(-EFAULT) int test_strcat_pagefault1(void *ctx) { return bpf_strcat(invalid_kern_ptr, 1, "hello"); }
>> +SEC("syscall") __retval(-EFAULT) int test_strcat_pagefault2(void *ctx) { return bpf_strcat(kern_buf, sizeof(kern_buf), invalid_kern_ptr); }
>> +SEC("syscall") __retval(-EFAULT) int test_strncat_pagefault1(void *ctx) { return bpf_strncat(invalid_kern_ptr, 1, "hello", 2); }
>> +SEC("syscall") __retval(-EFAULT) int test_strncat_pagefault2(void *ctx) { return bpf_strncat(kern_buf, sizeof(kern_buf), invalid_kern_ptr, 2); }
>>   
>>   char _license[] SEC("license") = "GPL";
>> diff --git a/tools/testing/selftests/bpf/progs/string_kfuncs_failure2.c b/tools/testing/selftests/bpf/progs/string_kfuncs_failure2.c
>> index 412c53b87b18..38f0a5f326b5 100644
>> --- a/tools/testing/selftests/bpf/progs/string_kfuncs_failure2.c
>> +++ b/tools/testing/selftests/bpf/progs/string_kfuncs_failure2.c
>> @@ -23,5 +23,7 @@ SEC("syscall") int test_strstr_too_long(void *ctx) { return bpf_strstr(long_str,
>>   SEC("syscall") int test_strcasestr_too_long(void *ctx) { return bpf_strcasestr(long_str, "hello"); }
>>   SEC("syscall") int test_strnstr_too_long(void *ctx) { return bpf_strnstr(long_str, "hello", sizeof(long_str)); }
>>   SEC("syscall") int test_strncasestr_too_long(void *ctx) { return bpf_strncasestr(long_str, "hello", sizeof(long_str)); }
>> +SEC("syscall") int test_strcat_too_long(void *ctx) { return bpf_strcat(long_str, sizeof(long_str), "hello"); }
>> +SEC("syscall") int test_strncat_too_long(void *ctx) { return bpf_strncat(long_str, sizeof(long_str), "hello", 3); }
>>   
>>   char _license[] SEC("license") = "GPL";
>> diff --git a/tools/testing/selftests/bpf/progs/string_kfuncs_success.c b/tools/testing/selftests/bpf/progs/string_kfuncs_success.c
>> index f65b1226a81a..b24456ad3d43 100644
>> --- a/tools/testing/selftests/bpf/progs/string_kfuncs_success.c
>> +++ b/tools/testing/selftests/bpf/progs/string_kfuncs_success.c
>> @@ -6,6 +6,8 @@
>>   #include "errno.h"
>>   
>>   char str[] = "hello world";
>> +char buf1[32] = "hello";
>> +char buf2[32] = "hello";
>>   
>>   #define __test(retval) SEC("syscall") __success __retval(retval)
>>   
>> @@ -59,5 +61,7 @@ __test(-ENOENT) int test_strncasestr_notfound1(void *ctx) { return bpf_strncases
>>   __test(-ENOENT) int test_strncasestr_notfound2(void *ctx) { return bpf_strncasestr(str, "hello", 4); }
>>   __test(-ENOENT) int test_strncasestr_notfound3(void *ctx) { return bpf_strncasestr("", "a", 0); }
>>   __test(0) int test_strncasestr_empty(void *ctx) { return bpf_strncasestr(str, "", 1); }
>> +__test(10) int test_strcat_success(void *ctx) { return bpf_strcat(buf1, sizeof(buf1), "world"); }
>> +__test(8) int test_strncat_success(void *ctx) { return bpf_strncat(buf2, sizeof(buf2), "world", 3); }
> We should also add tests that verify that the string was actually
> copied.
Thanks, i'll submit v4 ;)
>
> Viktor
>
>>   
>>   char _license[] SEC("license") = "GPL";

