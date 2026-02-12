Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1819F2D0614
	for <bpf@vger.kernel.org>; Thu, 12 Feb 2026 23:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770940672; cv=none; b=icrCjoK6nhXKnk6BaCJPBwE21FgYZJVczAA3nelLBfDYhh6Z8Wl/7qgNgGOPhsK7EdV++9rhwhkFdS08oMRizDjPOiL7AKtpRhzgHQOZEw4I4QQTMPtqlRLG+ZYnuiZpKG2JrtPaXG4LZmcls9qKAYBCGEVZfKrcS7950X8m7+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770940672; c=relaxed/simple;
	bh=PajcFVsvFt23r8TLHfyurkIfJaAbM8tqyZzhLNzcd2I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U/OIDU3mDyZpkUGGHqtDn70fVYTQBUzf+hvfquisY8YYFr5TnbxueDxEAzIsIMtotdLEYTHZVUo/wbMAhI208rKBKQE8A2ZBrR5Ue/2MXxKKrAnR/KYKeLL9bvs3CKzN5wxw1VuGnWzQAjRJif/KCM9MPtDqV3yz7uJ+TM4/KAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eHsVHfxJ; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eHsVHfxJ"
Message-ID: <2a532f02-a7ed-43d5-a0fc-129ee4eeb0c1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770940669;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IyuyX9gbm7FsXqvdBZYVsroWaPrFZwuUVzD+4Ni+R1U=;
	b=eHsVHfxJuka5FlcqyAubrtcmkN4/yKJQppqi25oo1LiJIEFeA5m+vIwUShbwsLnNC1gxU8
	Sh2ANgJ8ryjrY2yJC7NvvzUQ7gSLXwwEsmjBQ5DkaYIHzfYslukOcDlavbEuO99WOxXR3c
	2PrQjZPSu5lPkn8DGs58iruO4Hu52IQ=
Date: Thu, 12 Feb 2026 15:57:41 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v1 00/14] selftests/bpf: Fixes for userspace ASAN
To: Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov
 <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>
Cc: Amery Hung <ameryhung@gmail.com>, Mykyta Yatsenko <yatsenko@meta.com>,
 =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com
References: <20260212011356.3266753-1-ihor.solodrai@linux.dev>
 <59d226c413864ec7229e4a74af7e663e9982c534.camel@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <59d226c413864ec7229e4a74af7e663e9982c534.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 2/12/26 2:00 PM, Eduard Zingerman wrote:
> On Wed, 2026-02-11 at 17:13 -0800, Ihor Solodrai wrote:
>> This series includes various fixes aiming to enable test_progs run
>> with userspace address sanitizer on BPF CI.
>>
>> The first patch fixes the selftests/bpf/test_progs build with:
>>
>>     SAN_CFLAGS="-fsanitize=address -fno-omit-frame-pointer"
>>
>> The subsequent patches fix bugs reported by the address sanitizer on
>> attempt to run the tests.
>>
>> The series is a pre-requisite for enabling "test_progs with ASAN"
>> workflow on BPF CI.
> 
> I did an experiment:
> - applied the diff as at the bottom of the email;
> - compiled with export SAN_CFLAGS="-fsanitize=address -fno-omit-frame-pointer"
>   (using gcc 15.2.1);
> - double-checked that resulting executable depends on libasan;
> - did a test run: ./test_progs -a verifier_and.
> 
> The error report looks as follows:
> 
>   Caught signal #11!
>   Stack trace:
>   /lib64/libasan.so.8(+0x525e7) [0x7f6a506525e7]
>   ./test_progs(crash_handler+0xb5) [0xd152c9]
>   /lib64/libc.so.6(+0x19c30) [0x7f6a50427c30]
>   /lib64/libasan.so.8(+0xdf4a) [0x7f6a5060df4a]
>   /lib64/libasan.so.8(+0xe5bba) [0x7f6a506e5bba]
>   ./test_progs() [0xd19ccc]
>   ./test_progs(main+0xcf6) [0xd1aa79]
>   /lib64/libc.so.6(+0x35f5) [0x7f6a504115f5]
>   /lib64/libc.so.6(__libc_start_main+0x88) [0x7f6a504116a8]
>   ./test_progs(_start+0x25) [0x401935]
> 
> Am I doing something wrong, or does test_progs signal handler
> interfere with ASAN reporting?
> 
> [...]
> 
> ---
> 
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index a0a594de9007..3820077e74e4 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -46,7 +46,7 @@ srctree := $(patsubst %/,%,$(dir $(srctree)))
>  endif
>  
>  CFLAGS += -g $(OPT_FLAGS) -rdynamic -std=gnu11                         \
> -         -Wall -Werror -fno-omit-frame-pointer                         \
> +         -Wall -fno-omit-frame-pointer                         \

I think you've cheated a little bit here, because with -Werror 

    free(test_state->log_buf + 10);

doesn't compile:

    test_progs.c: In function ‘free_test_states’:
    test_progs.c:1927:17: error: ‘free’ called on pointer ‘*test_state.log_buf’ with nonzero offset 10 [-Werror=free-nonheap-object]
     1927 |                 free(test_state->log_buf + 10);
          |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    cc1: all warnings being treated as errors
    make: *** [Makefile:767: /home/isolodrai/kernels/bpf-next/tools/testing/selftests/bpf/test_progs.o] Error 1
    make: *** Waiting for unfinished jobs....

If it's removed, then I can reproduce the same stacktrace, which AFAIU
is an invalid dereference inside the ASAN itself.

I'm no expert here, but it appears ASAN only tracks exact pointers? Or
maybe the assumption is that dumb errors like this one are caught at
compile time, so no need to check for them at runtime?

It could also be a bug in ASAN or gcc. I don't want to assume that, but
after unexpected adventures with llvm-objcopy I wouldn't be surprised.

I think a conclusion here is that ASAN doesn't guarantee the absence
of segfaults at runtime. It just helps to catch certain bugs.

I tried to trigger use-after-free, but also get a segfault.
Apparently at that point log_buf is already NULL.

diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
index 02a85dda30e6..5ff1d9fc5e4d 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -1924,7 +1924,10 @@ static void free_test_states(void)
                        free_subtest_state(&test_state->subtest_states[j]);
 
                free(test_state->subtest_states);
+               printf("log_buf = %p\n", test_state->log_buf);
                free(test_state->log_buf);
+               char c = test_state->log_buf[0];
+               printf("c: %c\n", c);
                test_state->subtest_states = NULL;
                test_state->log_buf = NULL;
        }


#522/1   verifier_and/invalid and of negative number:OKtest_progs -v -a verifier_and
#522/2   verifier_and/invalid and of negative number @unpriv:OK
#522/3   verifier_and/invalid range check:OK
#522/4   verifier_and/invalid range check @unpriv:OK
#522/5   verifier_and/check known subreg with unknown reg:OK
#522/6   verifier_and/check known subreg with unknown reg @unpriv:OK
#522     verifier_and:OK
Summary: 1/6 PASSED, 0 SKIPPED, 0 FAILED
log_buf = (nil)
tester_init:PASS:tester_log_buf 0 nsec
process_subtest:PASS:obj_open_mem 0 nsec
process_subtest:PASS:specs_alloc 0 nsec
#522     verifier_and:FAIL
Caught signal #11!
Stack trace:
/lib64/libasan.so.8(+0x525e7) [0x7f311290e5e7]
./test_progs(crash_handler+0xb5) [0xd15af6]
/lib64/libc.so.6(+0x1a290) [0x7f311269f290]
./test_progs() [0xd1a595]
./test_progs(main+0xcf6) [0xd1b35d]
/lib64/libc.so.6(+0x35b5) [0x7f31126885b5]
/lib64/libc.so.6(__libc_start_main+0x88) [0x7f3112688668]
./test_progs(_start+0x25) [0x401865]
[  246.835249] test_progs[232]: segfault at 0 ip 0000000000d1a595 sp 00007ffd8e64cc00 error 4 in test_progs[91a595,400000+a34000] likely on CPU 0 (core 0, socket 0)
[  246.838738] Code: 48 81 c2 00 80 ff 7f 0f b6 12 84 d2 40 0f 95 c6 48 89 c7 83 e7 07 40 38 d7 0f 9d c2 21 f2 84 d2 74 08 48 89 c7 e8 1b 6a 6e ff <0f> b6 01 88 45 ef 0f be 45 ef 89 c6 bf c0 58 b2 01 b8 00 00 00 00
Segmentation fault         ./test_progs -a verifier_and


>           -Wno-unused-but-set-variable                                  \
>           $(GENFLAGS) $(SAN_CFLAGS) $(LIBELF_CFLAGS)                    \
>           -I$(CURDIR) -I$(INCLUDE_DIR) -I$(GENDIR) -I$(LIBDIR)          \
> diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
> index 02a85dda30e6..8839e00167fa 100644
> --- a/tools/testing/selftests/bpf/test_progs.c
> +++ b/tools/testing/selftests/bpf/test_progs.c
> @@ -1924,7 +1924,7 @@ static void free_test_states(void)
>                         free_subtest_state(&test_state->subtest_states[j]);
>  
>                 free(test_state->subtest_states);
> -               free(test_state->log_buf);
> +               free(test_state->log_buf + 10);
>                 test_state->subtest_states = NULL;
>                 test_state->log_buf = NULL;

