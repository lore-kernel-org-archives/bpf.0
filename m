Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44A41C5799
	for <bpf@vger.kernel.org>; Wed, 15 Jul 2026 00:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784076838; cv=none; b=OqvUcAs3vQ8m+n14r2TjetoPwBndcA+hEpZf6iwgWDC2pDv2KPiP/+u0VCXjNZODWgxb557CkwaBxKMcQN8gH6aOUmdfpLfz1xSJTnTlN2horyUJ0OblyU/Bc4xehK0m15O6dsPz/uQob++8wCFKRgPffOysvc8ynME17Aun3Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784076838; c=relaxed/simple;
	bh=dzR4chfAqelA0jb4wh+0QfOekInSKSeLvL31Fd25vA4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TOag/4/fxlflx7ygL27QrLzBdL5vUhxXUgpGlIF9H9pnUVsRd7/n8/20kGeenS0Zgn0HeQ3MDoOGoEZX36NjagKd/cAMht57rzZZ16bMt2Uu0hg8WgnoaNDL5GVZI7xlxnJCIzNMLC911Mspvd2GWA50IE7BBQwYocK6r2fgBik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EuKIt3bQ; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EuKIt3bQ"
Message-ID: <5f38c9a5-a8a3-4bed-bb8c-b7260a1c1a11@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784076830;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S8Xr4dGhJZKjGNNQ6pEqCn3LF/D8kyTDL/foZNruU/k=;
	b=EuKIt3bQcp/69RLnkg8I8UrqG+DVbETJ5/MW5J7hZp0Z04CDFQhz9cvkCTvBpj8lh7YOdf
	s5aZ40lBh1GDs5aLXsbrX51qOjeHTrlRY2VwDkorbJOrQP93xsZ9gaGI/hPd8JZ3TM4Nqo
	b8X8LFYIOwe59C/DseApJESGNqckITk=
Date: Tue, 14 Jul 2026 17:53:28 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v5 04/10] bpf, x86: add helper to emit kasan
 checks in x86 JITed programs
To: =?UTF-8?Q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?=
 <alexis.lothore@bootlin.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Thomas Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Andrey Konovalov <andreyknvl@gmail.com>
Cc: ebpf@linuxfoundation.org,
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20260709-kasan-v5-0-1c64af8e4e1e@bootlin.com>
 <20260709-kasan-v5-4-1c64af8e4e1e@bootlin.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <20260709-kasan-v5-4-1c64af8e4e1e@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 7/9/26 3:01 AM, Alexis LothorÃ© (eBPF Foundation) wrote:
> Add the emit_kasan_check() function that emits KASAN shadow memory
> checks before memory accesses in JIT-compiled BPF programs. The
> implementation relies on the existing __asan_{load,store}X functions
> from KASAN subsystem. The helper:
> - ensures that the kasan instrumention is actually needed: if the
>   instruction being processed accesses the program stack, we skip the
>   instrumentation, as those accesses are already protected with page
>   guards
> - saves registers. This includes caller-saved registers, but also
>   temporary registers, as those were possibly used by the
>   affected program. Theoretically, r10 and r11 should be saved as well,
>   but the number of called function and their scope being limited, they
>   are skipped for the sake of reducing the overhead

My clanker got very excited about r10 and r11 not being saved, just
like sashiko. So I looked at this a bit closer. TL;DR it's fine

I built the kernel with gcc 11.5, gcc 15.2 and clang 22 and
disassembled __asan_{load,store}{1,2,4,8}: none of them touch r10 or
r11. gcc goes up to r8, clang uses nothing above rdi.

However, kasan_check_range() does use r10/r11.  And looks like we are
ok only because the fixed-size helpers inline the shadow check and
never call kasan_check_range().

If any of the fixed-size 1/2/4/8 helpers ever actually call
kasan_check_range(), r10 may get clobbered.

Maybe we should leave a comment on emit_kasan_check() about this?..

> - computes the accessed address and stores it in %rdi
> - calls the relevant function, depending on the instruction being a load
>   or a store, and the size of the access.
> - restores registers
> 
> The special care needed when inserting this instrumentation comes at the
> cost of a non negligeable increase in JITed code size. For example, a
> bare
> 
>   mov 	0x0(%si),rbx # Load in rbx content at address stored in rsi
> 
> becomes
> 
>   push    %rax
>   push    %rcx
>   push    %rdx
>   push    %rsi
>   push    %rdi
>   push    %r8
>   push    %r9
>   mov     %rsi,%rdi
>   call    0xffffffff81da0a60 <__asan_load8>
>   pop     %r9
>   pop     %r8
>   pop     %rdi
>   pop     %rsi
>   pop     %rdx
>   pop     %rcx
>   pop     %rax
>   mov     0x0(%rsi),rbx
> 
> Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
> ---
> Changes in v3:
> - skip kasan instrumentation if there is no verifier env (cBPF)
> - move helper up in the file
> 
> Changes in v2:
> - move asan functions declaration directly into jit compiler, and guard
>   them with IS_ENABLED
> - remove faulty stack alignment, no arg is passed to kasan funcs on the
>   stack anyway
> - make sure to emit call depth accounting code
> - do not save unneeded registers
> - update helper signature to let caller configure some values (eg:
>   is_write)
> ---
>  arch/x86/net/bpf_jit_comp.c | 95 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 95 insertions(+)
> 
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index de7515ea1bea..d35f58350d71 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -21,6 +21,17 @@
>  #include <asm/unwind.h>
>  #include <asm/cfi.h>
>  
> +#if IS_ENABLED(CONFIG_BPF_JIT_KASAN)
> +void __asan_load1(void *p);
> +void __asan_store1(void *p);
> +void __asan_load2(void *p);
> +void __asan_store2(void *p);
> +void __asan_load4(void *p);
> +void __asan_store4(void *p);
> +void __asan_load8(void *p);
> +void __asan_store8(void *p);
> +#endif
> +
>  static bool all_callee_regs_used[4] = {true, true, true, true};
>  
>  static u8 *emit_code(u8 *ptr, u32 bytes, unsigned int len)
> @@ -1110,6 +1121,90 @@ static void maybe_emit_1mod(u8 **pprog, u32 reg, bool is64)
>  	*pprog = prog;
>  }
>  
> +static int emit_kasan_check(struct bpf_verifier_env *env, u8 **pprog,
> +			    u32 addr_reg, struct bpf_insn *insn, u8 *ip,
> +			    bool is_write, bool accesses_stack_only)


nit: IMO it's not nice to introduce functions with no caller as a
separate patch: it triggers -Wunused-function on this commit, which
may or may not be used in a build. I'd fold this in patch #6 where the
function is actually called.

> [...]
