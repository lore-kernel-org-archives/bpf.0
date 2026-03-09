Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8D4175A75
	for <bpf@vger.kernel.org>; Mon,  9 Mar 2026 19:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773083077; cv=none; b=ZGtjKiApa26pCCXov9ytEGYW+oxqmMkXNTVKi+u9GCusR2Njd0EpvV8pmIGx6eGFW5GTDAl/rznuz3U2nrfKbGkXM4U8is6FrjHpxnfVwRpT3eKCLB5wZQ6QIHaG8mHcxT5qEaba4lK/MG2HcFPMJbDSmsjJQBb9tmDN3GleLyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773083077; c=relaxed/simple;
	bh=OJIxbxUB/mPc1MsH/trIQwUKxaiFN+OBB3Sc6LvIV7U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kxD42kqhAGpQ286nk+1eCHmQQC8SjOU4492hn/e0lqQNUgyBBhLXj9Vf1JpzVldjGOiIEfXce9zy9t2ghKGqx53ZkCtab5IqV7Ycjw7WOQ7w6nvv2MbHbKIIdCzPkpF3wwpeTqTKZ6JbI/6uMG2viisxCk6hAEK8+QY6LkYLMzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QmU0FqBf; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QmU0FqBf"
Message-ID: <015010b0-6009-4234-85a4-3d4752a80a94@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773083073;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ASl86C8OyqVUKFYmsiuhDpLqzj2F5sgECF6WPGsiXWQ=;
	b=QmU0FqBf8+qtrYIG3vAtTkiOhdbJOh4TcWiD1nUQ4LMOdnpBEH3o5X5c/2OVRR5U9Xi8dO
	VAZxSU0GOMThRljLEw1rDcaoD29oLJh4a+r+Vhk8OgWxfkCHdR8tEcSGc99k9KJotHjwT0
	FTL5nQWu2uxgjmp4Of2SUFq/xAD4nAs=
Date: Mon, 9 Mar 2026 12:04:26 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] bpftool: Enable aarch64 ISA extensions for JIT
 disassembly
To: Puranjay Mohan <puranjay@kernel.org>, bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay12@gmail.com>, Alexei Starovoitov
 <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, Quentin Monnet
 <qmo@kernel.org>, kernel-team@meta.com
References: <20260306163906.2870529-1-puranjay@kernel.org>
Content-Language: en-GB
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260306163906.2870529-1-puranjay@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 3/6/26 8:39 AM, Puranjay Mohan wrote:
> The LLVM disassembler needs ISA extension features enabled to correctly
> decode instructions from those extensions. On aarch64, without these
> features, instructions like LSE atomics (e.g. ldaddal) are silently
> decoded as incorrect instructions and disassembly is truncated.
>
> Use LLVMCreateDisasmCPUFeatures() with "+all" features for aarch64
> targets so that the disassembler can handle any instruction the kernel
> JIT might emit.
>
> Before:
>
> int bench_trigger_uprobe(void * ctx):
> bpf_prog_538c6a43d1c6b84c_bench_trigger_uprobe:
> ; int cpu = bpf_get_smp_processor_id();
>     0:   mov     x9, x30
>     4:   nop
>     8:   stp     x29, x30, [sp, #-16]!
>     c:   mov     x29, sp
>    10:   stp     xzr, x26, [sp, #-16]!
>    14:   mov     x26, sp
>    18:   mrs     x10, SP_EL0
>    1c:   ldr     w7, [x10, #16]
> ; __sync_add_and_fetch(&hits[cpu & CPU_MASK].value, 1);
>    20:   and     w7, w7, #0xff
> ; __sync_add_and_fetch(&hits[cpu & CPU_MASK].value, 1);
>    24:   lsl     x7, x7, #7
>    28:   mov     x0, #-281474976710656
>    2c:   movk    x0, #32768, lsl #32
>    30:   movk    x0, #35407, lsl #16
>    34:   add     x0, x0, x7
>    38:   mov     x1, #1
> ; __sync_add_and_fetch(&hits[cpu & CPU_MASK].value, 1);
>    3c:   mov     x1, #1
>
> After:
>
> int bench_trigger_uprobe(void * ctx):
> bpf_prog_538c6a43d1c6b84c_bench_trigger_uprobe:
> ; int cpu = bpf_get_smp_processor_id();
>     0:   mov     x9, x30
>     4:   nop
>     8:   stp     x29, x30, [sp, #-16]!
>     c:   mov     x29, sp
>    10:   stp     xzr, x26, [sp, #-16]!
>    14:   mov     x26, sp
>    18:   mrs     x10, SP_EL0
>    1c:   ldr     w7, [x10, #16]
> ; __sync_add_and_fetch(&hits[cpu & CPU_MASK].value, 1);
>    20:   and     w7, w7, #0xff
> ; __sync_add_and_fetch(&hits[cpu & CPU_MASK].value, 1);
>    24:   lsl     x7, x7, #7
>    28:   mov     x0, #-281474976710656
>    2c:   movk    x0, #32768, lsl #32
>    30:   movk    x0, #35407, lsl #16
>    34:   add     x0, x0, x7
>    38:   mov     x1, #1
> ; __sync_add_and_fetch(&hits[cpu & CPU_MASK].value, 1);
>    3c:   ldaddal x1, x1, [x0]
> ; return 0;
>    40:   mov     w7, #0
>    44:   ldp     xzr, x26, [sp], #16
>    48:   ldp     x29, x30, [sp], #16
>    4c:   mov     x0, x7
>    50:   ret
>    54:   nop
>    58:   ldr     x10, #8
>    5c:   br      x10
>
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>

Acked-by: Yonghong Song <yonghong.song@linux.dev>

> ---
>   tools/bpf/bpftool/jit_disasm.c | 13 ++++++++++++-
>   1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/tools/bpf/bpftool/jit_disasm.c b/tools/bpf/bpftool/jit_disasm.c
> index 8895b4e1f690..317d810a30ba 100644
> --- a/tools/bpf/bpftool/jit_disasm.c
> +++ b/tools/bpf/bpftool/jit_disasm.c
> @@ -93,7 +93,18 @@ init_context(disasm_ctx_t *ctx, const char *arch,
>   		p_err("Failed to retrieve triple");
>   		return -1;
>   	}
> -	*ctx = LLVMCreateDisasm(triple, NULL, 0, NULL, symbol_lookup_callback);
> +
> +	/*
> +	 * Enable all aarch64 ISA extensions so the disassembler can handle any
> +	 * instruction the kernel JIT might emit (e.g. ARM64 LSE atomics).
> +	 */
> +	if (strstr(triple, "aarch64"))

As mentioned by Quentin, "aarch64" should be in the leading triple, so it
would be great to check with that instead of strstr.

There are another variant "arm64" which is used for Apple platformas, so
we can ignore them.

> +		*ctx = LLVMCreateDisasmCPUFeatures(triple, "", "+all",
> +						   NULL, 0, NULL,
> +						   symbol_lookup_callback);
> +	else
> +		*ctx = LLVMCreateDisasm(triple, NULL, 0, NULL,
> +					symbol_lookup_callback);
>   	LLVMDisposeMessage(triple);
>   
>   	if (!*ctx) {
>
> base-commit: 6dd780f973816133f189efec04118c1e6b1b443d

