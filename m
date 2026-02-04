Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6886185B48;
	Wed,  4 Feb 2026 00:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770165928; cv=none; b=eQbaYciZzdNxF2eHALymLcdlwytjasEQQSHW1IENGFeHm9Ie31n4PVFn0PpUOQ60ou5v+ConD13CUzw4PKYoECg+f4Lr+NfLboJVm67WK8lQ/nnP0/w0EDR0F3KOHXPekyqUOmKxg9yAF5N2WPUynG+HKTfF/Rw9DrcRWJQnWOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770165928; c=relaxed/simple;
	bh=3bPhxmVUocleFipC4reAR9MEKZH36EMxHLcWzmCJtUE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YGQifcaKpaPGOmvMwgXf2Nkh+TP4ZkFW59T8o373pv2cHFiANBlI+86VTbcW3Mebd1irSABeXxGqW5SQE2Wnzr9Th+jnypqL5xPjlk2mElUaZqn3ePWvzxuGWMgutOZ6NaULIjO1hmA4bpA5kdSvFfkANRZqG8J7a539f4oDLk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=fail (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=A667aHHn reason="signature verification failed"; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="A667aHHn"
Received: from [IPV6:2601:646:8081:9484:7f27:8faf:e50:c87b] ([IPv6:2601:646:8081:9484:7f27:8faf:e50:c87b])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 6140hAvH3684475
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Tue, 3 Feb 2026 16:44:10 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 6140hAvH3684475
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2026012301; t=1770165853;
	bh=SfjcLG/RUmRtt9wxHxBQ6mL+sKk+V7CX7MeisYlYpJc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=A667aHHnZjPtA3vHvH0jpqhwqdKf4X6/35CpgUlJSQSe8LQuTsAR5kPmP4uY2ByIn
	 ifXxRqU5OoZ1IoPKwL2BVP5QUwz+R3SGHYL3uh11dVN2rYTroBzK1nnGRvaco9x3AV
	 PJkukzXaZTKyfW4NdDv8FFAy72MvB3KMvFwpcfVVbCZ4l72ccV320HTpY/RDFTQiHJ
	 0B5tAvHF0AYi85FhQDMbDhUuXXulb3MZHpeluT4WdNX/UDpsLb9qVSVz8Tvxd3EigZ
	 2CCyraJ5yWcTjnGmIAjRCwmsIoillqKATqXgWxaHjK8wsBFZ/B/ylwPhstUWBamK/p
	 FX9idc7SfXpvw==
Message-ID: <bd2fdf83-e460-46ad-8617-16319bc55ca5@zytor.com>
Date: Tue, 3 Feb 2026 16:43:44 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/6] x86/asm: Avoid emitting DWARF CFI for non-VDSO
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
 <20260203171958.1522030-3-jremus@linux.ibm.com>
Content-Language: en-US, sv-SE
From: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <20260203171958.1522030-3-jremus@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026-02-03 09:19, Jens Remus wrote:
> From: Josh Poimboeuf <jpoimboe@kernel.org>
> 
> It was decided years ago that .cfi_* annotations aren't maintainable in
> the kernel.  They were replaced by objtool unwind hints.  For the kernel
> proper, ensure the CFI_* macros don't do anything.
> 
> On the other hand the VDSO library *does* use them, so user space can
> unwind through it.
> 
> Make sure these macros only work for VDSO.  They aren't actually being
> used outside of VDSO anyway, so there's no functional change.
> 
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> Signed-off-by: Jens Remus <jremus@linux.ibm.com>
> ---
>  arch/x86/include/asm/dwarf2.h | 51 ++++++++++++++++++++++++-----------
>  1 file changed, 35 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/x86/include/asm/dwarf2.h b/arch/x86/include/asm/dwarf2.h
> index 09c9684d3ad6..7cc30500c095 100644
> --- a/arch/x86/include/asm/dwarf2.h
> +++ b/arch/x86/include/asm/dwarf2.h
> @@ -6,6 +6,15 @@
>  #warning "asm/dwarf2.h should be only included in pure assembly files"
>  #endif
>  
> +#ifdef BUILD_VDSO
> +
> +	/*
> +	 * For the vDSO, emit both runtime unwind information and debug
> +	 * symbols for the .dbg file.
> +	 */
> +
> +	.cfi_sections .eh_frame, .debug_frame
> +
>  #define CFI_STARTPROC		.cfi_startproc
>  #define CFI_ENDPROC		.cfi_endproc
>  #define CFI_DEF_CFA		.cfi_def_cfa
> @@ -22,21 +31,31 @@
>  #define CFI_ESCAPE		.cfi_escape
>  #define CFI_SIGNAL_FRAME	.cfi_signal_frame
>  
> -#ifndef BUILD_VDSO
> -	/*
> -	 * Emit CFI data in .debug_frame sections, not .eh_frame sections.
> -	 * The latter we currently just discard since we don't do DWARF
> -	 * unwinding at runtime.  So only the offline DWARF information is
> -	 * useful to anyone.  Note we should not use this directive if we
> -	 * ever decide to enable DWARF unwinding at runtime.
> -	 */
> -	.cfi_sections .debug_frame
> -#else
> -	 /*
> -	  * For the vDSO, emit both runtime unwind information and debug
> -	  * symbols for the .dbg file.
> -	  */
> -	.cfi_sections .eh_frame, .debug_frame
> -#endif
> +#else /* !BUILD_VDSO */
> +
> +/*
> + * On x86, these macros aren't used outside VDSO.  As well they shouldn't be:
> + * they're fragile and very difficult to maintain.
> + */
> +
> +.macro nocfi args:vararg
> +.endm
> +
> +#define CFI_STARTPROC		nocfi
> +#define CFI_ENDPROC		nocfi
> +#define CFI_DEF_CFA		nocfi
> +#define CFI_DEF_CFA_REGISTER	nocfi
> +#define CFI_DEF_CFA_OFFSET	nocfi
> +#define CFI_ADJUST_CFA_OFFSET	nocfi
> +#define CFI_OFFSET		nocfi
> +#define CFI_REL_OFFSET		nocfi
> +#define CFI_REGISTER		nocfi
> +#define CFI_RESTORE		nocfi
> +#define CFI_REMEMBER_STATE	nocfi
> +#define CFI_RESTORE_STATE	nocfi
> +#define CFI_UNDEFINED		nocfi
> +#define CFI_ESCAPE		nocfi
> +
> +#endif /* !BUILD_VDSO */
>  
>  #endif /* _ASM_X86_DWARF2_H */

I guess patch 3 justifies this.

Acked-by: H. Peter Anvin (Intel) <hpa@zytor.com>

