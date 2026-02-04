Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E456221DAD;
	Wed,  4 Feb 2026 00:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770165928; cv=none; b=ckqT2QM9B32wIbs6UXc5NidCU04G+cpHIrEUT2ydWqmbOoyPWO6QezPpBXhgtlNQlvG7RJ1T1QCJ6RtHk1DkGCO/uELQ/V0AZSypnSy3dxx7rHw5l+XE0jg19+6cxYH2q9HkVr7wQgg8p/Ucr4m5CSeRuTX9xV8sBqHxizq7R9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770165928; c=relaxed/simple;
	bh=LNs/wQqdCO+IBfymQut6DspRIPR8PXrI46N6Wk3IUn8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=re0I1sRph2pl8Dfqlfhd36kRs5rKKYPxeMe7uioliXM7W5FTOx2h4SnQ0mOuWeK0FkzirwqRbtfWrOwKTlh850mHvsCfyBcwtiajPPJOwSb8uHlbO0POPTWzXmycnz+leor2minXe7dd6ir+WnKA1mg4BebxwnYrH/CSV+PsIn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=fail (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=crXiy018 reason="signature verification failed"; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="crXiy018"
Received: from [IPV6:2601:646:8081:9484:7f27:8faf:e50:c87b] ([IPv6:2601:646:8081:9484:7f27:8faf:e50:c87b])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 6140hAvG3684475
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Tue, 3 Feb 2026 16:44:06 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 6140hAvG3684475
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2026012301; t=1770165850;
	bh=UfjaUaIuA0bRrAc4cE77mBYy+gfHHyNJYKQPy6J33YE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=crXiy01897ayeasjguHKSzOn2NtespesB5xpL8Yz8Rro2GlQ+haqoeVfRwHO2y2Ex
	 m3GhQjzYodiuSlJ6RZGrBCU6iR57vXf5PayhAHKnL1Pv112u37riVXjQKdaq0vCe/b
	 ydVdAY7lyHrnl4HKaNsjKP8nG4CWoFCSEDXkPVeRUuwjWF9XDdYGeUicLa/knHNU/N
	 C2QNci0MUUj5Y7z1je88PgYSuhPDWNZGcNbn1GC/aVVG8aBNf5SGwaVgFGiCwU5wmj
	 IPwjHDCPKoUJkoh55eUg9V82sNLOEkpCqYnTGSiLUg7sGJ4ZrLnoHASpDWWnGpOsQK
	 zp+2hiw2M+duw==
Message-ID: <45453806-e861-4084-a89a-38adc48ff67b@zytor.com>
Date: Tue, 3 Feb 2026 16:43:04 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/6] x86/vdso: Fix DWARF generation for getrandom()
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
 <20260203171958.1522030-2-jremus@linux.ibm.com>
Content-Language: en-US, sv-SE
From: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <20260203171958.1522030-2-jremus@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026-02-03 09:19, Jens Remus wrote:
> From: Josh Poimboeuf <jpoimboe@kernel.org>
> 
> Add CFI annotations to the VDSO implementation of getrandom() so it will
> have valid DWARF unwinding metadata.
> 
> Fixes: 33385150ac45 ("x86: vdso: Wire up getrandom() vDSO implementation")
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> Signed-off-by: Jens Remus <jremus@linux.ibm.com>
> ---
>  arch/x86/entry/vdso/vdso64/vgetrandom-chacha.S | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/entry/vdso/vdso64/vgetrandom-chacha.S b/arch/x86/entry/vdso/vdso64/vgetrandom-chacha.S
> index bcba5639b8ee..cc82da9216fb 100644
> --- a/arch/x86/entry/vdso/vdso64/vgetrandom-chacha.S
> +++ b/arch/x86/entry/vdso/vdso64/vgetrandom-chacha.S
> @@ -4,7 +4,7 @@
>   */
>  
>  #include <linux/linkage.h>
> -#include <asm/frame.h>
> +#include <asm/dwarf2.h>
>  
>  .section	.rodata, "a"
>  .align 16
> @@ -22,7 +22,7 @@ CONSTANTS:	.octa 0x6b20657479622d323320646e61707865
>   *	rcx: number of 64-byte blocks to write to output
>   */
>  SYM_FUNC_START(__arch_chacha20_blocks_nostack)
> -
> +	CFI_STARTPROC
>  .set	output,		%rdi
>  .set	key,		%rsi
>  .set	counter,	%rdx
> @@ -175,4 +175,5 @@ SYM_FUNC_START(__arch_chacha20_blocks_nostack)
>  	pxor		temp,temp
>  
>  	ret
> +	CFI_ENDPROC
>  SYM_FUNC_END(__arch_chacha20_blocks_nostack)

Looks good to me.

Acked-by: H. Peter Anvin (Intel) <hpa@zytor.com>

