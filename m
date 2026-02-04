Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D954F2236F2;
	Wed,  4 Feb 2026 00:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770165948; cv=none; b=p2k+iQjP70tikWbvs7XT7onxAR686yCoVrflZctF3YNgJJ5mJZc9NR+f073vUiULfzayhPT9cVWiG18tO11N2Gr8bTtKnHFEyBTgfhIRpiaRmBQAhxQU8/+zKDMKQ3zVS7DLpULpgdyBvwM62/vlGGzaWeQqyRmYH1phaVwovKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770165948; c=relaxed/simple;
	bh=dVhqz+TNm6+MayUge/ltTg7wtft+OfqinNP8kbYDujc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eRkSz0+uk8YCkTYclx37DHyeJsqA92BYCEwf+TLoaLW3JwYbwD4poclZRgXCKUDLr3K13w4sjFNMT54IMUHrj45/sNmXUdYGaaPg4+5jj/qXJ/y2te6E4LKLMr/5sv33clF9ZgFUECD6aAOXgT/fsEA8llBUUJhlaBzi8nonJL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=fail (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=ZibLcVuL reason="signature verification failed"; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="ZibLcVuL"
Received: from [IPV6:2601:646:8081:9484:7f27:8faf:e50:c87b] ([IPv6:2601:646:8081:9484:7f27:8faf:e50:c87b])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 6140iX303686652
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Tue, 3 Feb 2026 16:44:57 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 6140iX303686652
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2026012301; t=1770165899;
	bh=QBm6ZcPisQkneG596+7CCtRNo4FR94Kwhkfm4afnAkE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZibLcVuLSIucGujyPOk0lr2GRGfUUCwgewWStAdXcf/4eRKgVHDfKOXWNg2lO5PRE
	 dLm7rAOfvt39WHhl2/igmMZiEMY3s9iDuDW3bqCuqMyFmk5KQRtQc8yHI24ggAN8BV
	 fLPIxXQMMaQsNFwEpHD7xnQBJgBepF2c5pqKRyIpJUDckn/K6QTq1Zaj/1xSk0QH1O
	 +O70azzWqPCTO/qEpBfMH18/eZUmOOAn5apaFAQw/mMtr683Ky5jXLKITWvhet4IQk
	 AxPzqM1kLIJxy/Bw5w89KatVX4Squ1ATMkFKGnR0NQIgkCFVVWjlzjEgsnvgGaunDY
	 NmVBuCBx8kDnw==
Message-ID: <7030a829-12aa-45dd-b78d-86cf72fb9a2d@zytor.com>
Date: Tue, 3 Feb 2026 16:44:53 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 5/6] x86/vdso: Use CFI macros in
 __vdso_sgx_enter_enclave()
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
 <20260203171958.1522030-6-jremus@linux.ibm.com>
Content-Language: en-US, sv-SE
From: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <20260203171958.1522030-6-jremus@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026-02-03 09:19, Jens Remus wrote:
> From: Josh Poimboeuf <jpoimboe@kernel.org>
> 
> Use the CFI macros instead of the raw .cfi_* directives to be consistent
> with the rest of the VDSO asm.  It's also easier on the eyes.
> 
> No functional changes.
> 
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> Signed-off-by: Jens Remus <jremus@linux.ibm.com>
> ---
>  arch/x86/entry/vdso/vdso64/vsgx.S | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/x86/entry/vdso/vdso64/vsgx.S b/arch/x86/entry/vdso/vdso64/vsgx.S
> index c0342238c976..8d7b8eb45c50 100644
> --- a/arch/x86/entry/vdso/vdso64/vsgx.S
> +++ b/arch/x86/entry/vdso/vdso64/vsgx.S
> @@ -24,13 +24,14 @@
>  .section .text, "ax"
>  
>  SYM_FUNC_START(__vdso_sgx_enter_enclave)
> +	SYM_F_ALIGN
>  	push	%rbp
> -	.cfi_adjust_cfa_offset	8
> -	.cfi_rel_offset		%rbp, 0
> +	CFI_ADJUST_CFA_OFFSET	8
> +	CFI_REL_OFFSET		%rbp, 0
>  	mov	%rsp, %rbp
> -	.cfi_def_cfa_register	%rbp
> +	CFI_DEF_CFA_REGISTER	%rbp
>  	push	%rbx
> -	.cfi_rel_offset		%rbx, -8
> +	CFI_REL_OFFSET		%rbx, -8
>  
>  	mov	%ecx, %eax
>  .Lenter_enclave:
> @@ -77,13 +78,11 @@ SYM_FUNC_START(__vdso_sgx_enter_enclave)
>  .Lout:
>  	pop	%rbx
>  	leave
> -	.cfi_def_cfa		%rsp, 8
> +	CFI_DEF_CFA		%rsp, 8
>  	RET
>  
> -	/* The out-of-line code runs with the pre-leave stack frame. */
> -	.cfi_def_cfa		%rbp, 16
> -
>  .Linvalid_input:
> +	CFI_DEF_CFA		%rbp, 16
>  	mov	$(-EINVAL), %eax
>  	jmp	.Lout
>  

Looks good to me.

Acked-by: H. Peter Anvin (Intel) <hpa@zytor.com>

