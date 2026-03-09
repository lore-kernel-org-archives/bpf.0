Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78AB2C11C4
	for <bpf@vger.kernel.org>; Mon,  9 Mar 2026 17:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773075888; cv=none; b=AJID7hOAPE3jDkymjrgvtorYloSCOjrJbI+uzpCaK3cV8U0nkLc6gIi+Q1xn4t7NqsLoQ/RaHQ4E4qQuZRIENeG/WOJ19HwFvyPwkYVa9opHL+ce48oYYq2D4rY2iHun7HyiRosHY8Jtuap5CCtD4EljW5xmy0d+fJZij4jPN6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773075888; c=relaxed/simple;
	bh=4vAyTgY0hFYxGUDiaPscXs6T5drknuBH9pohHWVQDLg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n6tWfnbLB83at+YpNPjpOgJXbyKIrA6Mp57BPHal6/dc5wx/+J1aiwiqAuB7Svi8d5FG+4Wiyf1WqmcgGb10VR5GfWgjLhwRkw/mHWRSc3QMcilxRjyO0ZEQJ9Lstx83ZMbvEDH74o+4jCS1NnA7lVsO48707sR9/TdV3vPi6go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=czQxb4Ar; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="czQxb4Ar"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41B3BC4CEF7;
	Mon,  9 Mar 2026 17:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773075888;
	bh=4vAyTgY0hFYxGUDiaPscXs6T5drknuBH9pohHWVQDLg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=czQxb4ArQBo2H/T87WN8mmy7meLLif5N9fNg88DCpiUY26qaukEE0ol84Fmp6XkUJ
	 VlUG3osGtErwpQxbECD7G989kxiS8EqCJ9xlTiQH/6dijzhBVEKNsCtjIS+CWDZcVU
	 iKSPQdovcVu+QLHnhjoAxs5KBfeYovKy4YD5WgUm/o3cQqUtIjl7LlmsmGH045/Xw5
	 vqLYUpGl+Xp/Ls8CczxJOiFxK6HrHSkdxBuzjDVEcy/ho1sP4yaodM2xI28Saff7xy
	 FCpzpUQE7uDAkk6uAR/XleI9+6AZDBiBKqOJE/LsH4UQ8gOEAGAIHU3Uts/oczfBK9
	 VKIF/SGW1l26A==
Message-ID: <1573c2e9-c3fe-491d-8f51-8a4af7d30ea2@kernel.org>
Date: Mon, 9 Mar 2026 17:04:44 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] bpftool: Enable aarch64 ISA extensions for JIT
 disassembly
To: Puranjay Mohan <puranjay@kernel.org>, bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay12@gmail.com>, Alexei Starovoitov
 <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, kernel-team@meta.com
References: <20260306163906.2870529-1-puranjay@kernel.org>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20260306163906.2870529-1-puranjay@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 06/03/2026 16:39, Puranjay Mohan wrote:
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
>    0:   mov     x9, x30
>    4:   nop
>    8:   stp     x29, x30, [sp, #-16]!
>    c:   mov     x29, sp
>   10:   stp     xzr, x26, [sp, #-16]!
>   14:   mov     x26, sp
>   18:   mrs     x10, SP_EL0
>   1c:   ldr     w7, [x10, #16]
> ; __sync_add_and_fetch(&hits[cpu & CPU_MASK].value, 1);
>   20:   and     w7, w7, #0xff
> ; __sync_add_and_fetch(&hits[cpu & CPU_MASK].value, 1);
>   24:   lsl     x7, x7, #7
>   28:   mov     x0, #-281474976710656
>   2c:   movk    x0, #32768, lsl #32
>   30:   movk    x0, #35407, lsl #16
>   34:   add     x0, x0, x7
>   38:   mov     x1, #1
> ; __sync_add_and_fetch(&hits[cpu & CPU_MASK].value, 1);
>   3c:   mov     x1, #1
> 
> After:
> 
> int bench_trigger_uprobe(void * ctx):
> bpf_prog_538c6a43d1c6b84c_bench_trigger_uprobe:
> ; int cpu = bpf_get_smp_processor_id();
>    0:   mov     x9, x30
>    4:   nop
>    8:   stp     x29, x30, [sp, #-16]!
>    c:   mov     x29, sp
>   10:   stp     xzr, x26, [sp, #-16]!
>   14:   mov     x26, sp
>   18:   mrs     x10, SP_EL0
>   1c:   ldr     w7, [x10, #16]
> ; __sync_add_and_fetch(&hits[cpu & CPU_MASK].value, 1);
>   20:   and     w7, w7, #0xff
> ; __sync_add_and_fetch(&hits[cpu & CPU_MASK].value, 1);
>   24:   lsl     x7, x7, #7
>   28:   mov     x0, #-281474976710656
>   2c:   movk    x0, #32768, lsl #32
>   30:   movk    x0, #35407, lsl #16
>   34:   add     x0, x0, x7
>   38:   mov     x1, #1
> ; __sync_add_and_fetch(&hits[cpu & CPU_MASK].value, 1);
>   3c:   ldaddal x1, x1, [x0]
> ; return 0;
>   40:   mov     w7, #0
>   44:   ldp     xzr, x26, [sp], #16
>   48:   ldp     x29, x30, [sp], #16
>   4c:   mov     x0, x7
>   50:   ret
>   54:   nop
>   58:   ldr     x10, #8
>   5c:   br      x10
> 
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>


Thanks! The change looks OK to me, I just have a few nits below.


> ---
>  tools/bpf/bpftool/jit_disasm.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/bpf/bpftool/jit_disasm.c b/tools/bpf/bpftool/jit_disasm.c
> index 8895b4e1f690..317d810a30ba 100644
> --- a/tools/bpf/bpftool/jit_disasm.c
> +++ b/tools/bpf/bpftool/jit_disasm.c
> @@ -93,7 +93,18 @@ init_context(disasm_ctx_t *ctx, const char *arch,
>  		p_err("Failed to retrieve triple");
>  		return -1;
>  	}
> -	*ctx = LLVMCreateDisasm(triple, NULL, 0, NULL, symbol_lookup_callback);
> +
> +	/*
> +	 * Enable all aarch64 ISA extensions so the disassembler can handle any
> +	 * instruction the kernel JIT might emit (e.g. ARM64 LSE atomics).
> +	 */
> +	if (strstr(triple, "aarch64"))


I don't think the arch name can appear in the middle of the triple, can
it? So maybe just strncmp(triple, "aarch64", 7)?


> +		*ctx = LLVMCreateDisasmCPUFeatures(triple, "", "+all",
> +						   NULL, 0, NULL,
> +						   symbol_lookup_callback);
> +	else
> +		*ctx = LLVMCreateDisasm(triple, NULL, 0, NULL,
> +					symbol_lookup_callback);


Formatting nit: The line length limit is 100 char so you could have
these LLVMCreateDisasm...() calls on 2 and 1 lines (rather than 3 and 2
lines), respectively.

Thanks,
Quentin
