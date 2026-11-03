Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.234
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793665507;
	b=gzD26SwaTvw7xm/0mIKt5WKMppPaAc4E88ICifqRv81hNHc3zO6w1V/sENf5W8tHZjT0
	 v9juqjG4ggDVI8FqNe2M3HenoV/FKmxwMS3/J3/G2aCukxcS3zVBoZxWomXfBuCD7aX0c
	 NLv40ZRfDbV1K+mHMPqljgGkujVMF7SxOCXRJo+55W0qZcSabDnw5tP9VrdqooCKKWwtF
	 djMzVW5DO0eFpYylWS0wQqmcPP5qKsOhpocYRToSUMZ3nQ2TY7j0KmtuDXMOkN7V61+H3
	 oEi6SI4285Xq5YJ2T0DrLuvBt4fYPQWBHAZU3Tyjo38bDtrKbdwSS+OkIUGipe6Jiag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793665507;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=WL5iolAf94oLsqAEcWGHL9OqEh2AXtCdQtE3qaXwqSA=;
	b=QrNvv8pXYNBaawXjYCAz5jQkMu/uB2sGu/JzQPKO21HesivMyyihj5BAcM+WVwNNGrfC
	 ar5YLDX9kXD/irmFPMvmuq+i/8yN6i9RHiCVF+WOAGb5dMwwroFI+aL2qG8di9e37Kf0G
	 jpzZ/7kqQKvAs9aG9x3NM7sWIzy75ReHnsrKOQf1d2UH+SbHYJ/thqKAKe90IIyK69QNm
	 LFv7YE1G/ITY9By/n2IXfApyD2kbKC3WB5e600XdyZQIIk7UOUi3aiuHoMu68lrOt4jDT
	 jWdi9rKh0eHhRUjeHite6jAm+vl7S8XI+laeY8XRH1NwPiVdIHNtST6pTO3sIQrsH7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=n1kKVMDy;
	arc=none smtp.remote-ip=95.215.58.234
Received: from mta1.migadu.com (out-234.mta1.migadu.com [95.215.58.234])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE9C606A324
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 00:25:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2CE9C606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=n1kKVMDy
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=0NiGdF1zPVMSf3imwwweoeAtV33VTkvQTK2VMLHyPXI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793665503; v=1; x=1794270303;
 b=n1kKVMDyzOkE3Z5GuYcJ3e540E+GN2izrpKr5kzbrFbv0FnKXi/AcmKVicmKzkxWhfYrGXrv
 sWYHZtvd6O0Y94Upp88TEkcLL2cc7FjtA5MKILse6luLLMGe8Ik41SP6dQxBTT+3CMT3COplgk2
 j2KeHsI2+ABYZ2Dt9huu0nVo=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 47407431e2103519;
	Tue, 03 Nov 2026 00:25:03 +0000
X-Mizu-Trace-ID: 47407431e2103519
X-Migadu-Flow: FLOW_OUT
Message-ID: <31855f25-0fce-4460-a550-a2b93222fba4@linux.dev>
Date: Mon, 2 Nov 2026 16:24:58 -0800
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 3/8] selftests/bpf: report SKIP for arena
 tests a compiler cannot build
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
 memxor@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 ihor.solodrai@linux.dev, john.fastabend@gmail.com, shuah@kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 jose.marchesi@oracle.com, david.faust@oss.qualcomm.com
References: <20261102220717.4079739-1-vineet.gupta@linux.dev>
 <20261102220717.4079739-4-vineet.gupta@linux.dev>
 <DML31IUICB7B.2FO0J06WCREC8@gmail.com>
From: Vineet Gupta <vineet.gupta@linux.dev>
Content-Language: en-US
In-Reply-To: <DML31IUICB7B.2FO0J06WCREC8@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/2/26 2:36 PM, Alexei Starovoitov wrote:
> On Mon, Nov 02, 2026 at 02:07 PM Vineet Gupta <vineet.gupta@linux.dev> wrote:
>> Give each guard an #else with a dummy marked __skip(), so the skip gap is
>> reported rather than invisible.  Add __skip_without_arena for it, which
>> expands to __skip() with a fixed reason when the compiler cannot do arena.
> How about the following approach instead...
> looks much simpler to me...

Agree: it does look simpler and they uncover more code to be tested now 
than being skipped.

Thx,
-Vineet

> pw-bot: cr
>
> diff --git a/tools/testing/selftests/bpf/progs/arena_kfunc_jit.c b/tools/testing/selftests/bpf/progs/arena_kfunc_jit.c
> index b5a01cb..16c3dd9 100644
> --- a/tools/testing/selftests/bpf/progs/arena_kfunc_jit.c
> +++ b/tools/testing/selftests/bpf/progs/arena_kfunc_jit.c
> @@ -23,8 +23,6 @@ struct {
>   /* volatile to force the scalar reloads below */
>   volatile u64 stash;
>
> -#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
> -
>   SEC("syscall")
>   __arch_x86_64
>   __jited("...")
> @@ -93,6 +91,7 @@ __jited("	cbz	w4, L0")
>   __jited("	add	x4, x28, w4, uxtw")
>   __jited("L0:	{{.*}}")
>   __success
> +__skip_without_arena
>   int arena_arg_jit_args5(void *ctx)
>   {
>   	u64 __arena *val;
> @@ -113,6 +112,4 @@ int arena_arg_jit_args5(void *ctx)
>   	return 0;
>   }
>
> -#endif /* __BPF_FEATURE_ADDR_SPACE_CAST */
> -
>   char _license[] SEC("license") = "GPL";
> diff --git a/tools/testing/selftests/bpf/progs/bpf_misc.h b/tools/testing/selftests/bpf/progs/bpf_misc.h
> index d7f706c..4ec840b 100644
> --- a/tools/testing/selftests/bpf/progs/bpf_misc.h
> +++ b/tools/testing/selftests/bpf/progs/bpf_misc.h
> @@ -116,6 +116,10 @@
>    *                   feature the toolchain or JIT cannot provide, so a run does
>    *                   not report OK for coverage it never executed.
>    *
> + * __skip_without_arena
> + *                   __skip() when the compiler does not support the arena
> + *                   address space, nothing otherwise.
> + *
>    * __log_level       Log level to use for the program, numeric value expected.
>    *
>    * __flag            Adds one flag use for the program, the following values are valid:
> @@ -156,6 +160,11 @@
>   #define __success		__test_tag("test_expect_success")
>   #define __description(desc)	__test_tag("test_description=" desc)
>   #define __skip(reason)		__test_tag("test_skip=" reason)
> +#ifdef __BPF_FEATURE_ADDR_SPACE_CAST
> +#define __skip_without_arena
> +#else
> +#define __skip_without_arena	__skip("compiler does not support the arena address space")
> +#endif
>   #define __msg_unpriv(msg)	__test_tag("test_expect_msg_unpriv=" msg)
>   #define __not_msg_unpriv(msg)	__test_tag("test_expect_not_msg_unpriv=" msg)
>   #define __msg_next_unpriv(msg)	__test_tag("test_expect_msg_next_unpriv=" msg)
> diff --git a/tools/testing/selftests/bpf/progs/jit_insns_arena.c b/tools/testing/selftests/bpf/progs/jit_insns_arena.c
> index 95736ea..77d135a 100644
> --- a/tools/testing/selftests/bpf/progs/jit_insns_arena.c
> +++ b/tools/testing/selftests/bpf/progs/jit_insns_arena.c
> @@ -106,6 +106,14 @@ int cast_to_user(void *ctx)
>   	: "r1", "r2", "r7", "r9");
>   	return res != 0;
>   }
> +#else
> +SEC("socket")
> +__skip_without_arena
> +__success
> +int arena_unsupported(void)
> +{
> +	return 0;
> +}
>   #endif
>
>   char _license[] SEC("license") = "GPL";
> diff --git a/tools/testing/selftests/bpf/progs/verifier_arena_large.c b/tools/testing/selftests/bpf/progs/verifier_arena_large.c
> index dbdea14..428b984 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_arena_large.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_arena_large.c
> @@ -181,7 +181,6 @@ int free_reserved(void *ctx)
>   	return 0;
>   }
>
> -#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
>   #define PAGE_CNT 100
>   __u8 __arena * __arena page[PAGE_CNT]; /* occupies the first page */
>   __u8 __arena *base;
> @@ -220,6 +219,7 @@ __noinline int alloc_pages(int page_cnt, int pages_atonce, bool first_pass,
>
>   SEC("syscall")
>   __success __retval(0)
> +__skip_without_arena
>   int big_alloc2(void *ctx)
>   {
>   	__u8 __arena *pg;
> @@ -290,9 +290,9 @@ int big_alloc2(void *ctx)
>   /* Nonsleepable because it binds to a socket program. */
>   SEC("socket")
>   __success __retval(0)
> +__skip_without_arena
>   int big_alloc3(void *ctx)
>   {
> -#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
>   	char __arena *pages;
>   	u64 i;
>   	int err = 0;
> @@ -314,16 +314,14 @@ int big_alloc3(void *ctx)
>
>   	bpf_arena_free_pages(&arena, pages, LARGE_PAGE_CNT);
>   	return err;
> -#endif
> -	return 0;
>   }
>
>   /* SYSCALL programs are always sleepable. */
>   SEC("syscall")
>   __success __retval(0)
> +__skip_without_arena
>   int big_alloc4(void *ctx)
>   {
> -#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
>   	char __arena *pages;
>   	u64 i;
>   	int err = 0;
> @@ -345,8 +343,6 @@ int big_alloc4(void *ctx)
>
>   	bpf_arena_free_pages(&arena, pages, LARGE_PAGE_CNT);
>   	return err;
> -#endif
> -	return 0;
>   }
> -#endif
> +
>   char _license[] SEC("license") = "GPL";

