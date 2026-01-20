Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C823F23A5
	for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 11:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768907291; cv=none; b=nJnPcXTVps2G/1b7BaOw/qUfAV0iQElxMTVyIwDbgSVAaydbFguBi+bBpEHtOGaNjP0+nhJeXVsOYZnK9CL2Wy8jBO+x/vblSTmGwMzy1cZ0hbVraWXFIqaqAHKL5srtlx2zpdKRYcwP33tvbXbRuyLo4+nVx1QAD7ziDmjhgwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768907291; c=relaxed/simple;
	bh=9XUaPXbAciIR4i/XCR+yVt6ph2Fq2pRUWYBI5vFR6z0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oYWddUqG3swIEEjQFqRTv7HaS23BaNr7mrru+a0FUKxKILUVmlMq1JpWDd14ZapgiR8nV8CkwmKkNPGwL/iMCEGiFTZTE/5byjo0lP8NW6YjSO3VXWAdAvvZs6I03S3HkZ8Nbw4vjV4FGHWczqtretoTOCUbD/Alnba/qxhgAVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g/61dUSg; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=J6bRGnRI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g/61dUSg";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="J6bRGnRI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768907288;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q0Z5OmfgNKMygHheIvjMMTKnIR/+j8hDWZ1R1Kk8AHg=;
	b=g/61dUSgpbDycVLe/RX5uqNkf3fiZZbt7FS956mzAn7PuuokT0D7hKyzVCt66U6Pztko09
	5xi+xkxlhDKS3jFHZeO9Og9f7lND1driGr8Xa+J9lisJDVcEXsi1MFSlVQZc3RCLTWCDjO
	V3iUIdTE8M2DInG71SkOF0yztXJnCxY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-X4KbMirHPXaXl53CjA0d5A-1; Tue, 20 Jan 2026 06:08:05 -0500
X-MC-Unique: X4KbMirHPXaXl53CjA0d5A-1
X-Mimecast-MFC-AGG-ID: X4KbMirHPXaXl53CjA0d5A_1768907284
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-42fb1c2c403so4081297f8f.3
        for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 03:08:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768907284; x=1769512084; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q0Z5OmfgNKMygHheIvjMMTKnIR/+j8hDWZ1R1Kk8AHg=;
        b=J6bRGnRIRnTXvPGy4uFJf7ZrIANLJGU0J8NCMozYeFkp35Q3b6ROtqX+/ew+Y0oQQ9
         W967NA7ES09VvMmmM328Mff6U6SWsvnj4UuRsKQBbpulKWa6xfWFLy+DrK/dQ4OkYJK3
         FRBUdBb7PLrNZbYPAGeUebxoNiGLo6de0YBny9I+SvIYB76FvTSmRAtqOU7oo2LiFSGJ
         XC6AVg0pQG/LFcmSjQNzys9CbH2eeUNLtK1O184T7dko30jAQULZZYCFpWEwi6vnMw5j
         VVBIGTc1IMY5Iw1vPmmbdE0AeocoA1sqzwClQr9t9WuZFQFVAYQuiwvu5JftV5QWMqCa
         zewg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768907284; x=1769512084;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q0Z5OmfgNKMygHheIvjMMTKnIR/+j8hDWZ1R1Kk8AHg=;
        b=c00Rz8w0cL0DkFNGdFi2rilcctHDEArMBPYA3M5t/AvCT2KztIYyXIyvnoKymH8vVV
         FXnd6KeP9zuIWpIv1Ys4dcBGr7V3bTxllwNBY2RVtD2LuWV7dIL30aodK3B7B0qpw+eX
         UDYpgq10VAN+xlD5/DC+CE7w8PSWokLZ4zRhKKIlPVp+0v1d4PcShW4FiBTxLObvEdxX
         +xXrK5vBnPc7+UCtIUJiNKQUbEqWTOOTTkbZFPRPuhXoUdeJkoCMGf1NBErD6cXxVpDZ
         kmQ7qxfGCSkZETyA6IZNlU9zbzV8ZFHsWzRju+wlXEtw9ViZ/+ZmcwvMb/kOZOFfHYLm
         Kfaw==
X-Forwarded-Encrypted: i=1; AJvYcCUJykzsRdzeovQGQcGckPVBxePIO0+dv/2Ke8ecnuNDpMoMqCVrZ5XLqnpuSHsMqSvS0Zo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSxQ4Q/bgp0L+Uab4/s9lnh8inq9tyiWo8QOja3K+cLPTQY3yy
	74Bs4/bDxBx7f6j6xJ4DSSYphzNPPRqINHbVex5JhYQFwOEAZ9ZjIVJghf5o9zmK4k7WP/ArRTB
	SeiPyOYdGsew3FhmZZTYCcJLgDja4HWVLTiu8UjE5eLE8a3tZIehK
X-Gm-Gg: AZuq6aK+D0tstb3Zf5wMqj640gGETsAtvByYdomdeivRrdhJmZmcu9+98GUGkU86828
	SWZjMCzTuyo911oHiqLwqYr/5yCvDsFP7ix2De9f/zi9RZLVBbHpU64DrdUa2E6dysGaFIEHWRh
	bplfKtlIrzmo/kwQLRJOR5wtV/GFgDAR3aa+t2zI7cMlFafGBoyQD+7GFhvWcwnZ6xu4ZeCs0Ej
	uAodzXc/06GdCGd7Fg1tq4Q2czyBZb0+0xYMzXykf0DHz6akbsoIu+v/v+MW/oWJpqORyIVoegG
	yPmw53cAC5bZalv86ETf94WGWajKw3ZlxAX17Xxd5vd34sT8pZ3pK0zO+uQ6WuZEPXN3qOHV
X-Received: by 2002:a05:6000:400f:b0:431:8f8:7f31 with SMTP id ffacd0b85a97d-43569bd6a3fmr20189062f8f.56.1768907283829;
        Tue, 20 Jan 2026 03:08:03 -0800 (PST)
X-Received: by 2002:a05:6000:400f:b0:431:8f8:7f31 with SMTP id ffacd0b85a97d-43569bd6a3fmr20189016f8f.56.1768907283353;
        Tue, 20 Jan 2026 03:08:03 -0800 (PST)
Received: from [10.43.17.17] ([213.175.46.86])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435924ae6f1sm2225038f8f.33.2026.01.20.03.08.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jan 2026 03:08:02 -0800 (PST)
Message-ID: <a91e5340-ec43-4801-b740-9b46766657e1@redhat.com>
Date: Tue, 20 Jan 2026 12:08:02 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v4 2/2] selftests/bpf: Test kfunc bpf_strncasecmp
To: Yuzuki Ishiyama <ishiyama@hpc.is.uec.ac.jp>, bpf@vger.kernel.org
Cc: mykyta.yatsenko5@gmail.com, andrii@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev
References: <20260120110011.1805037-1-ishiyama@hpc.is.uec.ac.jp>
 <20260120110011.1805037-3-ishiyama@hpc.is.uec.ac.jp>
From: Viktor Malik <vmalik@redhat.com>
Content-Language: en-US
In-Reply-To: <20260120110011.1805037-3-ishiyama@hpc.is.uec.ac.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/20/26 12:00, Yuzuki Ishiyama wrote:
> Add testsuites for kfunc bpf_strncasecmp.
> 
> Signed-off-by: Yuzuki Ishiyama <ishiyama@hpc.is.uec.ac.jp>
> Acked-by: Viktor Malik <vmalik@redhat.com>
> ---
>  tools/testing/selftests/bpf/prog_tests/string_kfuncs.c     | 1 +
>  tools/testing/selftests/bpf/progs/string_kfuncs_failure1.c | 6 ++++++
>  tools/testing/selftests/bpf/progs/string_kfuncs_failure2.c | 1 +
>  tools/testing/selftests/bpf/progs/string_kfuncs_success.c  | 7 +++++++
>  4 files changed, 15 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/string_kfuncs.c b/tools/testing/selftests/bpf/prog_tests/string_kfuncs.c
> index 0f3bf594e7a5..300032a19445 100644
> --- a/tools/testing/selftests/bpf/prog_tests/string_kfuncs.c
> +++ b/tools/testing/selftests/bpf/prog_tests/string_kfuncs.c
> @@ -9,6 +9,7 @@
>  static const char * const test_cases[] = {
>  	"strcmp",
>  	"strcasecmp",
> +	"strncasecmp",
>  	"strchr",
>  	"strchrnul",
>  	"strnchr",
> diff --git a/tools/testing/selftests/bpf/progs/string_kfuncs_failure1.c b/tools/testing/selftests/bpf/progs/string_kfuncs_failure1.c
> index 826e6b6aff7e..bddc4e8579d2 100644
> --- a/tools/testing/selftests/bpf/progs/string_kfuncs_failure1.c
> +++ b/tools/testing/selftests/bpf/progs/string_kfuncs_failure1.c
> @@ -33,6 +33,8 @@ SEC("syscall") __retval(USER_PTR_ERR) int test_strcmp_null1(void *ctx) { return
>  SEC("syscall")  __retval(USER_PTR_ERR)int test_strcmp_null2(void *ctx) { return bpf_strcmp("hello", NULL); }
>  SEC("syscall") __retval(USER_PTR_ERR) int test_strcasecmp_null1(void *ctx) { return bpf_strcasecmp(NULL, "HELLO"); }
>  SEC("syscall")  __retval(USER_PTR_ERR)int test_strcasecmp_null2(void *ctx) { return bpf_strcasecmp("HELLO", NULL); }
> +SEC("syscall") __retval(USER_PTR_ERR)int test_strncasecmp_null1(void *ctx) { return bpf_strncasecmp(NULL, "HELLO", 5); }
> +SEC("syscall")  __retval(USER_PTR_ERR)int test_strncasecmp_null2(void *ctx) { return bpf_strncasecmp("HELLO", NULL, 5);	 }
>  SEC("syscall")  __retval(USER_PTR_ERR)int test_strchr_null(void *ctx) { return bpf_strchr(NULL, 'a'); }
>  SEC("syscall")  __retval(USER_PTR_ERR)int test_strchrnul_null(void *ctx) { return bpf_strchrnul(NULL, 'a'); }
>  SEC("syscall")  __retval(USER_PTR_ERR)int test_strnchr_null(void *ctx) { return bpf_strnchr(NULL, 1, 'a'); }
> @@ -57,6 +59,8 @@ SEC("syscall") __retval(USER_PTR_ERR) int test_strcmp_user_ptr1(void *ctx) { ret
>  SEC("syscall") __retval(USER_PTR_ERR) int test_strcmp_user_ptr2(void *ctx) { return bpf_strcmp("hello", user_ptr); }
>  SEC("syscall") __retval(USER_PTR_ERR) int test_strcasecmp_user_ptr1(void *ctx) { return bpf_strcasecmp(user_ptr, "HELLO"); }
>  SEC("syscall") __retval(USER_PTR_ERR) int test_strcasecmp_user_ptr2(void *ctx) { return bpf_strcasecmp("HELLO", user_ptr); }
> +SEC("syscall") __retval(USER_PTR_ERR) int test_strncasecmp_user_ptr1(void *ctx) { return bpf_strncasecmp(user_ptr, "HELLO", 5); }
> +SEC("syscall") __retval(USER_PTR_ERR) int test_strncasecmp_user_ptr2(void *ctx) { return bpf_strncasecmp("HELLO", user_ptr, 5);	 }
>  SEC("syscall") __retval(USER_PTR_ERR) int test_strchr_user_ptr(void *ctx) { return bpf_strchr(user_ptr, 'a'); }
>  SEC("syscall") __retval(USER_PTR_ERR) int test_strchrnul_user_ptr(void *ctx) { return bpf_strchrnul(user_ptr, 'a'); }
>  SEC("syscall") __retval(USER_PTR_ERR) int test_strnchr_user_ptr(void *ctx) { return bpf_strnchr(user_ptr, 1, 'a'); }
> @@ -83,6 +87,8 @@ SEC("syscall") __retval(-EFAULT) int test_strcmp_pagefault1(void *ctx) { return
>  SEC("syscall") __retval(-EFAULT) int test_strcmp_pagefault2(void *ctx) { return bpf_strcmp("hello", invalid_kern_ptr); }
>  SEC("syscall") __retval(-EFAULT) int test_strcasecmp_pagefault1(void *ctx) { return bpf_strcasecmp(invalid_kern_ptr, "HELLO"); }
>  SEC("syscall") __retval(-EFAULT) int test_strcasecmp_pagefault2(void *ctx) { return bpf_strcasecmp("HELLO", invalid_kern_ptr); }
> +SEC("syscall") __retval(-EFAULT) int test_strncasecmp_pagefault1(void *ctx) { return bpf_strncasecmp(invalid_kern_ptr, "HELLO", 5); }
> +SEC("syscall") __retval(-EFAULT) int test_strncasecmp_pagefault2(void *ctx) { return bpf_strncasecmp("HELLO", invalid_kern_ptr, 5);	 }
>  SEC("syscall") __retval(-EFAULT) int test_strchr_pagefault(void *ctx) { return bpf_strchr(invalid_kern_ptr, 'a'); }
>  SEC("syscall") __retval(-EFAULT) int test_strchrnul_pagefault(void *ctx) { return bpf_strchrnul(invalid_kern_ptr, 'a'); }
>  SEC("syscall") __retval(-EFAULT) int test_strnchr_pagefault(void *ctx) { return bpf_strnchr(invalid_kern_ptr, 1, 'a'); }
> diff --git a/tools/testing/selftests/bpf/progs/string_kfuncs_failure2.c b/tools/testing/selftests/bpf/progs/string_kfuncs_failure2.c
> index 05e1da1f250f..412c53b87b18 100644
> --- a/tools/testing/selftests/bpf/progs/string_kfuncs_failure2.c
> +++ b/tools/testing/selftests/bpf/progs/string_kfuncs_failure2.c
> @@ -8,6 +8,7 @@ char long_str[XATTR_SIZE_MAX + 1];
>  
>  SEC("syscall") int test_strcmp_too_long(void *ctx) { return bpf_strcmp(long_str, long_str); }
>  SEC("syscall") int test_strcasecmp_too_long(void *ctx) { return bpf_strcasecmp(long_str, long_str); }
> +SEC("syscall") int test_strncasecmp_too_long(void *ctx) { return bpf_strncasecmp(long_str, long_str, sizeof(long_str)); }
>  SEC("syscall") int test_strchr_too_long(void *ctx) { return bpf_strchr(long_str, 'b'); }
>  SEC("syscall") int test_strchrnul_too_long(void *ctx) { return bpf_strchrnul(long_str, 'b'); }
>  SEC("syscall") int test_strnchr_too_long(void *ctx) { return bpf_strnchr(long_str, sizeof(long_str), 'b'); }
> diff --git a/tools/testing/selftests/bpf/progs/string_kfuncs_success.c b/tools/testing/selftests/bpf/progs/string_kfuncs_success.c
> index a8513964516b..3ccfae4d27d3 100644
> --- a/tools/testing/selftests/bpf/progs/string_kfuncs_success.c
> +++ b/tools/testing/selftests/bpf/progs/string_kfuncs_success.c
> @@ -17,6 +17,13 @@ __test(0) int test_strcasecmp_eq2(void *ctx) { return bpf_strcasecmp(str, "HELLO
>  __test(0) int test_strcasecmp_eq3(void *ctx) { return bpf_strcasecmp(str, "HELLO world"); }
>  __test(1) int test_strcasecmp_neq1(void *ctx) { return bpf_strcasecmp(str, "hello"); }
>  __test(1) int test_strcasecmp_neq2(void *ctx) { return bpf_strcasecmp(str, "HELLO"); }
> +__test(0) int test_strncasecmp_eq1(void *ctx) { return bpf_strncasecmp(str, "hello world", 11); }
> +__test(0) int test_strncasecmp_eq2(void *ctx) { return bpf_strncasecmp(str, "HELLO WORLD", 11); }
> +__test(0) int test_strncasecmp_eq3(void *ctx) { return bpf_strncasecmp(str, "HELLO world", 11); }
> +__test(0) int test_strncasecmp_eq4(void *ctx) { return bpf_strncasecmp(str, "hello", 5); }
> +__test(0) int test_strncasecmp_eq6(void *ctx) { return bpf_strncasecmp(str, "hello world!", 11); }

One more nit and sorry for noticing this only now. You skipped _eq5 here
so the last one should be test_strncasecmp_eq5. If you change that, feel
free to retain my ack.

> +__test(-1) int test_strncasecmp_neq1(void *ctx) { return bpf_strncasecmp(str, "hello!", 6); }
> +__test(1) int test_strncasecmp_neq2(void *ctx) { return bpf_strncasecmp(str, "abc", 3); }
>  __test(1) int test_strchr_found(void *ctx) { return bpf_strchr(str, 'e'); }
>  __test(11) int test_strchr_null(void *ctx) { return bpf_strchr(str, '\0'); }
>  __test(-ENOENT) int test_strchr_notfound(void *ctx) { return bpf_strchr(str, 'x'); }

