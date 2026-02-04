Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F66E1E5B9E;
	Wed,  4 Feb 2026 00:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770165928; cv=none; b=hc3mpPz8lMamoXFisfTRMjokURgzwamhZYKJuvygzN+g/4Sn0amX8jmh67u+2lr65EaVvZ/4hmk/FMxmZtudYk9rFDUV0Tve6afXsW95J1Y7suBM59Wn5ZdznRhmlmcv/5EWzzlJD2zLOg4F2RBVxN9qDPcJokY9YtEeTJCK8uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770165928; c=relaxed/simple;
	bh=V3I7Q4Fbw1F7sPSsGSef+f4HqY6JWUJSJ9fsn+Tkm8U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FnB5dTe+UWWP268n8jD1MEtveBoXbLIPNxQYzc43x8W7rYpIf20/pEZZT9hgU/895JbBXiux7h/d8ieRJw2HD0Xbfm99Om9BGlSzrpknx0JhNZCrPgPuEJv93Yk6Pn/V4YGkVywdx57IOqTTPVA3cFUs7/C09qlWlOptjPVNng4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=fail (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=GNRLYIoY reason="signature verification failed"; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="GNRLYIoY"
Received: from [IPV6:2601:646:8081:9484:7f27:8faf:e50:c87b] ([IPv6:2601:646:8081:9484:7f27:8faf:e50:c87b])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 6140hAvI3684475
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Tue, 3 Feb 2026 16:44:13 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 6140hAvI3684475
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2026012301; t=1770165855;
	bh=GRxhu1y96n3UH4hdO/qWkE190Cf2AF4FqJrGWR7q6xQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GNRLYIoY9SpQilkizC8FaQUne5RT0+llizCOZTFclKFfPdeiVruz/e/sLFutiAuSm
	 CbhmY4DWqyb2eVket35KKUR0JRXTX1QzXDZuc0L3iXQqLPpn8aXP1yP57jHp6rzR8B
	 AruzaMp+6X5KvlBPyEZ6cYq9hU1oS//kFwKBgRzAQ5yvh0k0BZcTWT/cxpHnYJujRW
	 IzxdYqSozkZr5Iu+H0ua7HgepLndfOUZzhCtQUihOTtcMA3sLUr+W7pA3g4mPb1/Sc
	 32YOh37hNKxEOV4mEzkkd3UIkk3/gBO+RtGjItROA+lrtAId271Qld6A+9vrixxWYl
	 U4jLPEQt9xhQQ==
Message-ID: <b8d73b0e-c007-4556-960a-96ee3d74a9f5@zytor.com>
Date: Tue, 3 Feb 2026 16:44:02 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 3/6] x86/asm: Simplify VDSO DWARF generation
To: Jens Remus <jremus@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
        x86@kernel.org, linux-mm@kvack.org,
        Steven Rostedt <rostedt@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrii Nakryiko <andrii@kernel.org>,
        Indu Bhagat <indu.bhagat@oracle.com>,
        "Jose E. Marchesi" <jemarch@gnu.org>,
        Beau Belgrave <beaub@linux.microsoft.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Florian Weimer <fweimer@redhat.com>, Kees Cook <kees@kernel.org>,
        "Carlos O'Donell" <codonell@redhat.com>, Sam James <sam@gentoo.org>,
        Dylan Hatch <dylanbhatch@google.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Michal Hocko
 <mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>
References: <20260203171958.1522030-1-jremus@linux.ibm.com>
 <20260203171958.1522030-4-jremus@linux.ibm.com>
Content-Language: en-US, sv-SE
From: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <20260203171958.1522030-4-jremus@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026-02-03 09:19, Jens Remus wrote:
> From: Josh Poimboeuf <jpoimboe@kernel.org>
> 
> Add CFI_STARTPROC and CFI_ENDPROC annotations to the SYM_FUNC_* macros
> so the VDSO asm functions don't need to add them manually.  Note this
> only affects VDSO, the CFI_* macros are empty for the kernel proper.
> 
> [ Jens Remus: Reword commit subject and message as suggested by Josh. ]
> 
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> Signed-off-by: Jens Remus <jremus@linux.ibm.com>
> ---
>  arch/x86/entry/vdso/common/vdso-layout.lds.S  |  2 +-
>  .../x86/entry/vdso/vdso64/vgetrandom-chacha.S |  2 --
>  arch/x86/entry/vdso/vdso64/vsgx.S             |  4 ---
>  arch/x86/include/asm/linkage.h                | 33 +++++++++++++++----
>  arch/x86/include/asm/vdso.h                   |  1 -
>  5 files changed, 28 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/x86/entry/vdso/common/vdso-layout.lds.S b/arch/x86/entry/vdso/common/vdso-layout.lds.S
> index a1e30be3e83d..856b8b9d278c 100644
> --- a/arch/x86/entry/vdso/common/vdso-layout.lds.S
> +++ b/arch/x86/entry/vdso/common/vdso-layout.lds.S
> @@ -1,5 +1,5 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
> -#include <asm/vdso.h>
> +#include <asm/page_types.h>
>  #include <asm/vdso/vsyscall.h>
>  #include <vdso/datapage.h>
>  
> diff --git a/arch/x86/entry/vdso/vdso64/vgetrandom-chacha.S b/arch/x86/entry/vdso/vdso64/vgetrandom-chacha.S
> index cc82da9216fb..a33212594731 100644
> --- a/arch/x86/entry/vdso/vdso64/vgetrandom-chacha.S
> +++ b/arch/x86/entry/vdso/vdso64/vgetrandom-chacha.S
> @@ -22,7 +22,6 @@ CONSTANTS:	.octa 0x6b20657479622d323320646e61707865
>   *	rcx: number of 64-byte blocks to write to output
>   */
>  SYM_FUNC_START(__arch_chacha20_blocks_nostack)
> -	CFI_STARTPROC
>  .set	output,		%rdi
>  .set	key,		%rsi
>  .set	counter,	%rdx
> @@ -175,5 +174,4 @@ SYM_FUNC_START(__arch_chacha20_blocks_nostack)
>  	pxor		temp,temp
>  
>  	ret
> -	CFI_ENDPROC
>  SYM_FUNC_END(__arch_chacha20_blocks_nostack)
> diff --git a/arch/x86/entry/vdso/vdso64/vsgx.S b/arch/x86/entry/vdso/vdso64/vsgx.S
> index 37a3d4c02366..c0342238c976 100644
> --- a/arch/x86/entry/vdso/vdso64/vsgx.S
> +++ b/arch/x86/entry/vdso/vdso64/vsgx.S
> @@ -24,8 +24,6 @@
>  .section .text, "ax"
>  
>  SYM_FUNC_START(__vdso_sgx_enter_enclave)
> -	/* Prolog */
> -	.cfi_startproc
>  	push	%rbp
>  	.cfi_adjust_cfa_offset	8
>  	.cfi_rel_offset		%rbp, 0
> @@ -143,8 +141,6 @@ SYM_FUNC_START(__vdso_sgx_enter_enclave)
>  	jle	.Lout
>  	jmp	.Lenter_enclave
>  
> -	.cfi_endproc
> -
>  _ASM_VDSO_EXTABLE_HANDLE(.Lenclu_eenter_eresume, .Lhandle_exception)
>  
>  SYM_FUNC_END(__vdso_sgx_enter_enclave)
> diff --git a/arch/x86/include/asm/linkage.h b/arch/x86/include/asm/linkage.h
> index 9d38ae744a2e..9d7f90c57451 100644
> --- a/arch/x86/include/asm/linkage.h
> +++ b/arch/x86/include/asm/linkage.h
> @@ -40,6 +40,10 @@
>  
>  #ifdef __ASSEMBLER__
>  
> +#ifndef LINKER_SCRIPT
> +#include <asm/dwarf2.h>
> +#endif
> +
>  #if defined(CONFIG_MITIGATION_RETHUNK) && !defined(__DISABLE_EXPORTS) && !defined(BUILD_VDSO)
>  #define RET	jmp __x86_return_thunk
>  #else /* CONFIG_MITIGATION_RETPOLINE */
> @@ -112,34 +116,51 @@
>  # define SYM_FUNC_ALIAS_MEMFUNC	SYM_FUNC_ALIAS
>  #endif
>  
> +#define __SYM_FUNC_START				\
> +	CFI_STARTPROC ASM_NL
> +
> +#define __SYM_FUNC_END					\
> +	CFI_ENDPROC ASM_NL
> +
>  /* SYM_TYPED_FUNC_START -- use for indirectly called globals, w/ CFI type */
>  #define SYM_TYPED_FUNC_START(name)				\
>  	SYM_TYPED_START(name, SYM_L_GLOBAL, SYM_F_ALIGN)	\
> +	__SYM_FUNC_START					\
>  	ENDBR
>  
>  /* SYM_FUNC_START -- use for global functions */
>  #define SYM_FUNC_START(name)				\
> -	SYM_START(name, SYM_L_GLOBAL, SYM_F_ALIGN)
> +	SYM_START(name, SYM_L_GLOBAL, SYM_F_ALIGN)	\
> +	__SYM_FUNC_START
>  
>  /* SYM_FUNC_START_NOALIGN -- use for global functions, w/o alignment */
>  #define SYM_FUNC_START_NOALIGN(name)			\
> -	SYM_START(name, SYM_L_GLOBAL, SYM_A_NONE)
> +	SYM_START(name, SYM_L_GLOBAL, SYM_A_NONE)	\
> +	__SYM_FUNC_START
>  
>  /* SYM_FUNC_START_LOCAL -- use for local functions */
>  #define SYM_FUNC_START_LOCAL(name)			\
> -	SYM_START(name, SYM_L_LOCAL, SYM_F_ALIGN)
> +	SYM_START(name, SYM_L_LOCAL, SYM_F_ALIGN)	\
> +	__SYM_FUNC_START
>  
>  /* SYM_FUNC_START_LOCAL_NOALIGN -- use for local functions, w/o alignment */
>  #define SYM_FUNC_START_LOCAL_NOALIGN(name)		\
> -	SYM_START(name, SYM_L_LOCAL, SYM_A_NONE)
> +	SYM_START(name, SYM_L_LOCAL, SYM_A_NONE)	\
> +	__SYM_FUNC_START
>  
>  /* SYM_FUNC_START_WEAK -- use for weak functions */
>  #define SYM_FUNC_START_WEAK(name)			\
> -	SYM_START(name, SYM_L_WEAK, SYM_F_ALIGN)
> +	SYM_START(name, SYM_L_WEAK, SYM_F_ALIGN)	\
> +	__SYM_FUNC_START
>  
>  /* SYM_FUNC_START_WEAK_NOALIGN -- use for weak functions, w/o alignment */
>  #define SYM_FUNC_START_WEAK_NOALIGN(name)		\
> -	SYM_START(name, SYM_L_WEAK, SYM_A_NONE)
> +	SYM_START(name, SYM_L_WEAK, SYM_A_NONE)		\
> +	__SYM_FUNC_START
> +
> +#define SYM_FUNC_END(name)				\
> +	__SYM_FUNC_END					\
> +	SYM_END(name, SYM_T_FUNC)
>  
>  /*
>   * Expose 'sym' to the startup code in arch/x86/boot/startup/, by emitting an
> diff --git a/arch/x86/include/asm/vdso.h b/arch/x86/include/asm/vdso.h
> index e8afbe9faa5b..498ac423741c 100644
> --- a/arch/x86/include/asm/vdso.h
> +++ b/arch/x86/include/asm/vdso.h
> @@ -2,7 +2,6 @@
>  #ifndef _ASM_X86_VDSO_H
>  #define _ASM_X86_VDSO_H
>  
> -#include <asm/page_types.h>
>  #include <linux/linkage.h>
>  #include <linux/init.h>
>  

Makes sense to me.

Acked-by: H. Peter Anvin (Intel) <hpa@zytor.com>

