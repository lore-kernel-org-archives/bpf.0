Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3410E34389C
	for <bpf@vger.kernel.org>; Fri, 17 Jul 2026 07:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784273695; cv=none; b=eWJc+aLhL8uEq+dRpiyim+4ydfos1H4o4HfhHnuPA1HfMW5w9dYrrCCU6PG87bmmsRmZSionBxU7u66jcsR0VG2jJB6UQk2rdD6zM2tsONXauA3PwPbqfw284aVdq3LZclaDu5j00Kk0SFD1K4a/p8WUmTMJz1ucj61yhsFX2Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784273695; c=relaxed/simple;
	bh=cO1IGSY2kR1S+CU8X47rMQseSu7VWEo8gGKPmpMe360=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O5ZohATSEACiZXG5pwdFG8zCoXDn0TdmujGSe4V2vwHLubM+9rP/CVzmWCr2Q6lcNYMse2Q7PMOPyI3BMHVsksYplvhec2YHGCKN8k/uL+S/2PQYEmX8uVzuk8NcsTd29WvvkoChiNFcoquYQXz4GoPHPbBugsqtYFjWft/Y9C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=exl9RKm3; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=lqWDs/Il; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="exl9RKm3";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="lqWDs/Il"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784273681;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/p0wnuezKiJPh1zgcwZ/NKm0lJtDtQFy3Op/vB/faRY=;
	b=exl9RKm3FU6zGIkon73DPvRbF2OCX0GvjEIQnXINhPza31dcqzWIIsVXS+0C8ogCf86+6X
	HjY5tDzGN00Kl/tiqt5Y+v3umyu2NgcrDrZerLf/5bumhNyMpkQeBLHCVlcOFta8AYmy4q
	XsH24fKNEZatd8PnuHAsAcdgIskvZLM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-573-ZcyU60v3MG-IN6XCy6htYA-1; Fri, 17 Jul 2026 03:34:40 -0400
X-MC-Unique: ZcyU60v3MG-IN6XCy6htYA-1
X-Mimecast-MFC-AGG-ID: ZcyU60v3MG-IN6XCy6htYA_1784273679
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-49547298689so4012785e9.1
        for <bpf@vger.kernel.org>; Fri, 17 Jul 2026 00:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1784273679; x=1784878479; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/p0wnuezKiJPh1zgcwZ/NKm0lJtDtQFy3Op/vB/faRY=;
        b=lqWDs/IlTYNup/Z0QBvzB9xC5LvqU4rTnfR/eEVsPPmp0BuW1jevkw5Cvtrbr4gC+c
         +F4nj4qI7175tUbjogIi1tzxbZm212LWwoMrbHitjo7/hz5h7pVTzjT33IZVOKUvENhJ
         WLTTRt/g77YjFOG4k9znPHMV/RcAfpukd/DcQBD9xHSninLOq7A+h3IUBWP2koaS8old
         a3pZB4sL1PbXJMP/8bLsPHiEK1gH/RR3CZiOHQJK6CZGl1o+Z3PnS3XyIzg7ekkdueIP
         pVAJsqAxZY1Gr4s+JkYOfmyfH2Sf1qNTg/2/fRBTXLsKvHfO+cyRL+4RENlqfJiu9tQg
         Bv2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784273679; x=1784878479;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/p0wnuezKiJPh1zgcwZ/NKm0lJtDtQFy3Op/vB/faRY=;
        b=MOoZ89rqvMMBFpzPN4TkqS9J7z3btcB8YPyIPE81fXkypqaApq25xk5PI+b3p1Hsqg
         HbNfAm8XFqql/Qs8uIbQnWx5OwZs0IypILliGn3Q+93KLSBA3j9Y8+Z6jc0zl4LxcIGc
         XgPoCjspxiDbeHhH18Jmis8FnD6/IVcXbKHYrgWZ31ies9mgKo0/eIYFze0Miiw1XTjL
         npj4RQD4ERbOQaH5dlF7gp4Fh8cipBDAsenK/SDcFbkJOY0TNrAkIWecNAmpb1GcHdIo
         bdYidIl+UIyYuyuNRXwPW+TiwGGgWQtfCw2JOpKhfsJkN7qO627lXfSe2B7teKEuh+z/
         B1bA==
X-Forwarded-Encrypted: i=1; AHgh+RrBauQpm/K2oY+/mI4kUgH2agEareFgAGNQVj8aLUpdRl6du0TyycqWaXTEQ0IdMQkCzeg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsS7W7vbcg/fNYwOGfzknma5F6+2NHocvttDXPcFVn/gvSYllU
	aPsNAkEJIICIA1gQMBjegQy0LbVUvWrgRBsIZkRzXzIB9kOJ4fd5iGSb5jGJOjIeOWIYtrUwvsi
	Re3WEfrh3cbQ9x9m6iA/71p+oQW5EKqxOKcyHYAC2tocM2SKVmmSL
X-Gm-Gg: AfdE7cmtExgT4IN40FK576XYijccnsEL3zArYdwI7koCfpDfKFii+NUf3nJlclfsxoa
	BoVMLNup0Gdp5bFSGg8+G/nc1K42/uAUBl93gz/JweRlO6XYBMLDhsW6l4NucHdaowdnKQWLBri
	PidhDQSo3Gay5bYLIAnEdoe/3drbtHBB+/2sOJN0pbXJAChocprIcx2TwTwn5oR2LUx90q3g69v
	tG01/gSrh85uhSbIj/GGRRR27etA2nHbLk9SxjX0Fcy2Q45YBo4Rib+4ta0yLP5zp/FxqfPi9wB
	i1w2zauLAHexa5Qb0zJL/jmAo0DkUT7bnMGXS2cr6kOyCpvdTJLHgJHOOByNC97k2XpPyX63V2Q
	1ce05U/hm+Cn6lFrfZk45G47n1gwO8gw2Vr4=
X-Received: by 2002:a05:600c:150c:b0:493:bba7:e9f4 with SMTP id 5b1f17b1804b1-4954a402dedmr9340705e9.18.1784273678920;
        Fri, 17 Jul 2026 00:34:38 -0700 (PDT)
X-Received: by 2002:a05:600c:150c:b0:493:bba7:e9f4 with SMTP id 5b1f17b1804b1-4954a402dedmr9340415e9.18.1784273678340;
        Fri, 17 Jul 2026 00:34:38 -0700 (PDT)
Received: from [192.168.0.135] (185-219-167-205-static.vivo.cz. [185.219.167.205])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63eeece9sm1470257f8f.37.2026.07.17.00.34.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jul 2026 00:34:37 -0700 (PDT)
Message-ID: <0f252920-38a8-4280-81aa-67240f60cadd@redhat.com>
Date: Fri, 17 Jul 2026 09:34:36 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 2/2] selftests/bpf: Test
 bpf_strcat,bpf_strncat kfuncs
To: Rong Tao <rtoax@foxmail.com>, andrii@kernel.org, ast@kernel.org
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
From: Viktor Malik <vmalik@redhat.com>
Content-Language: en-US
In-Reply-To: <tencent_C7A5E27560540491DBE052682ACBE1F24405@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/16/26 11:34, Rong Tao wrote:
> From: Rong Tao <rongtao@cestc.cn>
> 
> Add tests for new kfuncs bpf_strcat() and bpf_strncat().
> 
> Signed-off-by: Rong Tao <rongtao@cestc.cn>
> ---
>  .../testing/selftests/bpf/prog_tests/string_kfuncs.c  |  2 ++
>  .../selftests/bpf/progs/string_kfuncs_failure1.c      | 11 +++++++++++
>  .../selftests/bpf/progs/string_kfuncs_failure2.c      |  2 ++
>  .../selftests/bpf/progs/string_kfuncs_success.c       |  4 ++++
>  4 files changed, 19 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/string_kfuncs.c b/tools/testing/selftests/bpf/prog_tests/string_kfuncs.c
> index 300032a19445..460567ef622a 100644
> --- a/tools/testing/selftests/bpf/prog_tests/string_kfuncs.c
> +++ b/tools/testing/selftests/bpf/prog_tests/string_kfuncs.c
> @@ -24,6 +24,8 @@ static const char * const test_cases[] = {
>  	"strcasestr",
>  	"strnstr",
>  	"strncasestr",
> +	"strcat",
> +	"strncat",
>  };
>  
>  void run_too_long_tests(void)
> diff --git a/tools/testing/selftests/bpf/progs/string_kfuncs_failure1.c b/tools/testing/selftests/bpf/progs/string_kfuncs_failure1.c
> index bddc4e8579d2..973a6ba643d4 100644
> --- a/tools/testing/selftests/bpf/progs/string_kfuncs_failure1.c
> +++ b/tools/testing/selftests/bpf/progs/string_kfuncs_failure1.c
> @@ -8,6 +8,7 @@
>  
>  char *user_ptr = (char *)1;
>  char *invalid_kern_ptr = (char *)-1;
> +char kern_buf[32] = { "hello" };
>  
>  /*
>   * When passing userspace pointers, the error code differs based on arch:
> @@ -53,6 +54,8 @@ SEC("syscall")  __retval(USER_PTR_ERR)int test_strnstr_null1(void *ctx) { return
>  SEC("syscall")  __retval(USER_PTR_ERR)int test_strnstr_null2(void *ctx) { return bpf_strnstr("hello", NULL, 1); }
>  SEC("syscall")  __retval(USER_PTR_ERR)int test_strncasestr_null1(void *ctx) { return bpf_strncasestr(NULL, "hello", 1); }
>  SEC("syscall")  __retval(USER_PTR_ERR)int test_strncasestr_null2(void *ctx) { return bpf_strncasestr("hello", NULL, 1); }
> +SEC("syscall")  __retval(USER_PTR_ERR)int test_strcat_null1(void *ctx) { return bpf_strcat(kern_buf, sizeof(kern_buf), NULL); }
> +SEC("syscall")  __retval(USER_PTR_ERR)int test_strncat_null1(void *ctx) { return bpf_strncat(kern_buf, sizeof(kern_buf), NULL, 2); }
>  
>  /* Passing userspace ptr to string kfuncs */
>  SEC("syscall") __retval(USER_PTR_ERR) int test_strcmp_user_ptr1(void *ctx) { return bpf_strcmp(user_ptr, "hello"); }
> @@ -79,6 +82,10 @@ SEC("syscall") __retval(USER_PTR_ERR) int test_strnstr_user_ptr1(void *ctx) { re
>  SEC("syscall") __retval(USER_PTR_ERR) int test_strnstr_user_ptr2(void *ctx) { return bpf_strnstr("hello", user_ptr, 1); }
>  SEC("syscall") __retval(USER_PTR_ERR) int test_strncasestr_user_ptr1(void *ctx) { return bpf_strncasestr(user_ptr, "hello", 1); }
>  SEC("syscall") __retval(USER_PTR_ERR) int test_strncasestr_user_ptr2(void *ctx) { return bpf_strncasestr("hello", user_ptr, 1); }
> +SEC("syscall") __retval(USER_PTR_ERR) int test_strcat_user_ptr1(void *ctx) { return bpf_strcat(user_ptr, 1, "hello"); }
> +SEC("syscall") __retval(USER_PTR_ERR) int test_strcat_user_ptr2(void *ctx) { return bpf_strcat(kern_buf, sizeof(kern_buf), user_ptr); }
> +SEC("syscall") __retval(USER_PTR_ERR) int test_strncat_user_ptr1(void *ctx) { return bpf_strncat(user_ptr, 1, "hello", 2); }
> +SEC("syscall") __retval(USER_PTR_ERR) int test_strncat_user_ptr2(void *ctx) { return bpf_strncat(kern_buf, sizeof(kern_buf), user_ptr, 1); }
>  
>  #endif /* __TARGET_ARCH_s390 */
>  
> @@ -107,5 +114,9 @@ SEC("syscall") __retval(-EFAULT) int test_strnstr_pagefault1(void *ctx) { return
>  SEC("syscall") __retval(-EFAULT) int test_strnstr_pagefault2(void *ctx) { return bpf_strnstr("hello", invalid_kern_ptr, 1); }
>  SEC("syscall") __retval(-EFAULT) int test_strncasestr_pagefault1(void *ctx) { return bpf_strncasestr(invalid_kern_ptr, "hello", 1); }
>  SEC("syscall") __retval(-EFAULT) int test_strncasestr_pagefault2(void *ctx) { return bpf_strncasestr("hello", invalid_kern_ptr, 1); }
> +SEC("syscall") __retval(-EFAULT) int test_strcat_pagefault1(void *ctx) { return bpf_strcat(invalid_kern_ptr, 1, "hello"); }
> +SEC("syscall") __retval(-EFAULT) int test_strcat_pagefault2(void *ctx) { return bpf_strcat(kern_buf, sizeof(kern_buf), invalid_kern_ptr); }
> +SEC("syscall") __retval(-EFAULT) int test_strncat_pagefault1(void *ctx) { return bpf_strncat(invalid_kern_ptr, 1, "hello", 2); }
> +SEC("syscall") __retval(-EFAULT) int test_strncat_pagefault2(void *ctx) { return bpf_strncat(kern_buf, sizeof(kern_buf), invalid_kern_ptr, 2); }
>  
>  char _license[] SEC("license") = "GPL";
> diff --git a/tools/testing/selftests/bpf/progs/string_kfuncs_failure2.c b/tools/testing/selftests/bpf/progs/string_kfuncs_failure2.c
> index 412c53b87b18..38f0a5f326b5 100644
> --- a/tools/testing/selftests/bpf/progs/string_kfuncs_failure2.c
> +++ b/tools/testing/selftests/bpf/progs/string_kfuncs_failure2.c
> @@ -23,5 +23,7 @@ SEC("syscall") int test_strstr_too_long(void *ctx) { return bpf_strstr(long_str,
>  SEC("syscall") int test_strcasestr_too_long(void *ctx) { return bpf_strcasestr(long_str, "hello"); }
>  SEC("syscall") int test_strnstr_too_long(void *ctx) { return bpf_strnstr(long_str, "hello", sizeof(long_str)); }
>  SEC("syscall") int test_strncasestr_too_long(void *ctx) { return bpf_strncasestr(long_str, "hello", sizeof(long_str)); }
> +SEC("syscall") int test_strcat_too_long(void *ctx) { return bpf_strcat(long_str, sizeof(long_str), "hello"); }
> +SEC("syscall") int test_strncat_too_long(void *ctx) { return bpf_strncat(long_str, sizeof(long_str), "hello", 3); }
>  
>  char _license[] SEC("license") = "GPL";
> diff --git a/tools/testing/selftests/bpf/progs/string_kfuncs_success.c b/tools/testing/selftests/bpf/progs/string_kfuncs_success.c
> index f65b1226a81a..b24456ad3d43 100644
> --- a/tools/testing/selftests/bpf/progs/string_kfuncs_success.c
> +++ b/tools/testing/selftests/bpf/progs/string_kfuncs_success.c
> @@ -6,6 +6,8 @@
>  #include "errno.h"
>  
>  char str[] = "hello world";
> +char buf1[32] = "hello";
> +char buf2[32] = "hello";
>  
>  #define __test(retval) SEC("syscall") __success __retval(retval)
>  
> @@ -59,5 +61,7 @@ __test(-ENOENT) int test_strncasestr_notfound1(void *ctx) { return bpf_strncases
>  __test(-ENOENT) int test_strncasestr_notfound2(void *ctx) { return bpf_strncasestr(str, "hello", 4); }
>  __test(-ENOENT) int test_strncasestr_notfound3(void *ctx) { return bpf_strncasestr("", "a", 0); }
>  __test(0) int test_strncasestr_empty(void *ctx) { return bpf_strncasestr(str, "", 1); }
> +__test(10) int test_strcat_success(void *ctx) { return bpf_strcat(buf1, sizeof(buf1), "world"); }
> +__test(8) int test_strncat_success(void *ctx) { return bpf_strncat(buf2, sizeof(buf2), "world", 3); }

We should also add tests that verify that the string was actually
copied.

Viktor

>  
>  char _license[] SEC("license") = "GPL";

