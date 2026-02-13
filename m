Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43B82D6E58
	for <bpf@vger.kernel.org>; Fri, 13 Feb 2026 16:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770999228; cv=none; b=cQxGbTIxmNAACZVUBdRImnCK2OsAYyMJyCmJMBE84vW08XjVQQk2P0FE072lIpdcmb7A5i6V9c1XwX4wCDouO49G8pG58XbMwUaEfE83WJ2Xg/mQn5GZBTghIKA5oB8xfRnHC3z8U+m6H5bfhJrsW9Jj/DmMkKW0X/UYDgMf2jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770999228; c=relaxed/simple;
	bh=QDH5BqE+Huqq1nEVLGcqRBuhKMbz6qneCSo8+ctPFHw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ggAyubyYpd8K40tH1qfiV8O+d6II51E75+w3ngfD8N3zTcRiFZLs3TW3UpILT/MRoIILMC5z2OYxGDR7//Cc0R9vwTacSkivO1lamG2gf5RRWhJxEP1JkA1fmel9cUICVJX/DmpCXdVHYBi77tR1l0mR29OQHSr8YlBzOCP30yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DLaRgM+M; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DLaRgM+M"
Message-ID: <de259393-c414-4834-bd62-b65774e201a7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770999224;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5IAFvfP6T9H5d9tUk5GebB/MCFzZPtLOUJ6Nl3pHbmM=;
	b=DLaRgM+MyYq1rAI0hPXlPqyCeCQTHdllAeJOssNQoFdJr03RAxurrtYw12k8hwDKZkEBup
	KRg/F8Vqfy1LLnT/qLstKLjrvVl/hwERfTE/D8xism5pht1yYLLzyZdpylzq/cYOXcvSNa
	AFFfBY02BNIUXLCP4HeSy/bTe/3dIkE=
Date: Fri, 13 Feb 2026 08:13:38 -0800
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
 <2a532f02-a7ed-43d5-a0fc-129ee4eeb0c1@linux.dev>
 <b1399390b3e34961c3afd5a6a06c3c7bb3a4666a.camel@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <b1399390b3e34961c3afd5a6a06c3c7bb3a4666a.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 2/12/26 4:23 PM, Eduard Zingerman wrote:
> On Thu, 2026-02-12 at 15:57 -0800, Ihor Solodrai wrote:
> 
> [...]
> 
>>>  CFLAGS += -g $(OPT_FLAGS) -rdynamic -std=gnu11                         \
>>> -         -Wall -Werror -fno-omit-frame-pointer                         \
>>> +         -Wall -fno-omit-frame-pointer                         \
>>
>> I think you've cheated a little bit here, because with -Werror
> 
> It's just a model of a memory error, see below an example that does
> not generate compiler warnings.
> 
>> If it's removed, then I can reproduce the same stacktrace, which AFAIU
>> is an invalid dereference inside the ASAN itself.
> 
> See below, if I remove custom signal handler there is a regular ASAN
> error message:
> 
>   ==156==ERROR: AddressSanitizer: SEGV on unknown address 0xfffffffffffffffa (pc 0x7fa03160df4a bp 0x7fa0317bc980 sp 0x7ffee7c85170 T0)
>   ==156==The signal is caused by a WRITE memory access.
>       #0 0x7fa03160df4a in __asan::Allocator::Deallocate(void*, unsigned long, unsigned long, __sanitizer::BufferedStackTrace*, __asan::AllocType) (/lib64/libasan.so.8+0xdf4a) (BuildId: d3cb6206dff19da52969c009f4cd93611901c478)
>       #1 0x7fa0316e5bb9 in free.part.0 (/lib64/libasan.so.8+0xe5bb9) (BuildId: d3cb6206dff19da52969c009f4cd93611901c478)
>       #2 0x000000d19cd9 in free_test_states /home/eddy/work/bpf-next/tools/testing/selftests/bpf/test_progs.c:1930
>       #3 0x000000d1a897 in main /home/eddy/work/bpf-next/tools/testing/selftests/bpf/test_progs.c:2107
>       #4 0x7fa0313c45f4 in __libc_start_call_main (/lib64/libc.so.6+0x35f4) (BuildId: a1dda014206b55b07f58fe8db80121b752dc3d03)
>       #5 0x7fa0313c46a7 in __libc_start_main@@GLIBC_2.34 (/lib64/libc.so.6+0x36a7) (BuildId: a1dda014206b55b07f58fe8db80121b752dc3d03)
>       #6 0x000000401934 in _start (/home/eddy/work/bpf-next/tools/testing/selftests/bpf/test_progs+0x401934) (BuildId: 9190db005d475ee7a8e9294bb32cfbd520c330dc)
>   
>   ==156==Register values:
>   rax = 0x0000000000000002  rbx = 0x000000000000000a  rcx = 0x0000000000000000  rdx = 0x0000000000000003  
>   rdi = 0x000000000000000a  rsi = 0x000000000000000a  rbp = 0x00007fa0317bc980  rsp = 0x00007ffee7c85170  
>    r8 = 0x00007ffee7c851d0   r9 = 0x0000000000000001  r10 = 0x0000000000000005  r11 = 0x0000000000401935  
>   r12 = 0x00007ffee7c851d0  r13 = 0xfffffffffffffffa  r14 = 0x0000000000000001  r15 = 0x0000000000000000  
>   AddressSanitizer can not provide additional info.
>   SUMMARY: AddressSanitizer: SEGV /home/eddy/work/bpf-next/tools/testing/selftests/bpf/test_progs.c:1930 in free_test_states
> 
> So, there is indeed a conflict between test_progs signal handler and
> ASAN default signal handler.

As it turns out, only one signal handler can be installed at a time [1].
From man [2]:

    The sigaction() system call is used to *change* the action taken by
    a process on receipt of a specific signal.

So what happens is test_prog's custom signal handler *overwrites* ASAN's
signal handler leading to the weirdness we are seeing.

[1] https://stackoverflow.com/questions/17102919/is-it-valid-to-have-multiple-signal-handlers-for-same-signal
[2] https://man7.org/linux/man-pages/man2/sigaction.2.html

We should probably do then:

diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
index 02a85dda30e6..77a36f6ca352 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -1672,14 +1672,15 @@ static void server_main(void)
 {
        pthread_t *dispatcher_threads;
        struct dispatch_data *data;
+       int i;
+
+#ifndef __SANITIZE_ADDRESS__
        struct sigaction sigact_int = {
                .sa_handler = sigint_handler,
                .sa_flags = SA_RESETHAND,
        };
-       int i;
-
        sigaction(SIGINT, &sigact_int, NULL);
-
+#endif
        dispatcher_threads = calloc(sizeof(pthread_t), env.workers);
        data = calloc(sizeof(struct dispatch_data), env.workers);


> 
> [...]
> 
> --- a/tools/testing/selftests/bpf/test_progs.c
> +++ b/tools/testing/selftests/bpf/test_progs.c
> @@ -1913,6 +1913,8 @@ static int worker_main(int sock)
>         return 0;
>  }
>  
> +void *ptr;
> +
>  static void free_test_states(void)
>  {
>         int i, j;
> @@ -1924,7 +1926,8 @@ static void free_test_states(void)
>                         free_subtest_state(&test_state->subtest_states[j]);
>  
>                 free(test_state->subtest_states);
> -               free(test_state->log_buf);
> +               ptr = test_state->log_buf + 10;
> +               free(ptr);
>                 test_state->subtest_states = NULL;
>                 test_state->log_buf = NULL;
>         }
> @@ -1944,13 +1947,15 @@ int main(int argc, char **argv)
>                 .parser = parse_arg,
>                 .doc = argp_program_doc,
>         };
> -       struct sigaction sigact = {
> -               .sa_handler = crash_handler,
> -               .sa_flags = SA_RESETHAND,
> -               };
> +       /*
> +        * struct sigaction sigact = {
> +        *      .sa_handler = crash_handler,
> +        *      .sa_flags = SA_RESETHAND,
> +        *      };
> +        */
>         int err, i;
>  
> -       sigaction(SIGSEGV, &sigact, NULL);
> +       //sigaction(SIGSEGV, &sigact, NULL);
>  
>         env.stdout_saved = stdout;
>         env.stderr_saved = stderr;

