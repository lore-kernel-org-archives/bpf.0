Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C26224AF7;
	Wed,  4 Feb 2026 00:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770165942; cv=none; b=YCNtXqckHJ9A7bAzYynDMM7ipciua29rISs9tFA1Mhoq/BNx50sbfQwohQ0XYsoZyhdAloRziqAhwor1B9RPPiUA+0FeGSsEvtGBUkuLibr8xZevha1J7V/N1sRwVtW3pQDI9WXvVrdDU1L/2Yo5t+FLBJGwc4qF+BFxQcUk/Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770165942; c=relaxed/simple;
	bh=j9aAjw8wq9x5Wg9UQ/iT7LKiHLKGpYIZuPc8vwLMFUc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z6roP9fcqmXzabHB7VMKc0WU7xNA3qoUirjaC/5rieqgMlDboD6JR7fmWAjYePWkBq/YZw9yrJaVDN0OFlAiCXtECAvCylraM7wryoHHfg3bnpCOeC6JfqzkJd1QWMKbPFYzCeA+NrZ4qWTpDbZkvsBvd5pEFfzEq+3nEIJ6uac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=fail (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=1WuCWlAZ reason="signature verification failed"; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="1WuCWlAZ"
Received: from [IPV6:2601:646:8081:9484:7f27:8faf:e50:c87b] ([IPv6:2601:646:8081:9484:7f27:8faf:e50:c87b])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 6140iX2x3686652
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Tue, 3 Feb 2026 16:44:53 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 6140iX2x3686652
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2026012301; t=1770165897;
	bh=j99Bl1HWmVYx7aLiUOrbHBPAuPixzOzdzIN5XbrCTiI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=1WuCWlAZ2LhZ2XdJJ//0ZKbxmRZIMy+v0Q5Gs+tyjOaTdMQRWYkOsudn7MKWqWVj9
	 7MOkiVAg9MeJkyt9wpViQhHOzhaI4cLck8cqu8Q5oZAn3yaGJ3hmgnZUwC57NKUG4a
	 9Cd6aLdiAeDMlHU31HZdzetIgs+2qDwu0z7wG6CRIA8wiZhY5Vm7Sr/URCsMiP2TWx
	 92ZwmWLg4zz9CBBrZu7gBRDNA0XHl3a0Y4HhbfY4l97iKjFZxMD3dDVAuaTF9vYaMi
	 lIOUHeu+YHDGAZko7kuLNPRKFLShhAcrJhcISGLtcCf3nrmXRK5Q4rRz5da+K79hPT
	 vqMZkagnMRgMw==
Message-ID: <63dd1427-06c3-4bb8-b57e-f36cb417c381@zytor.com>
Date: Tue, 3 Feb 2026 16:44:28 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 4/6] x86/vdso: Use SYM_FUNC_{START,END} in
 __kernel_vsyscall()
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
 <20260203171958.1522030-5-jremus@linux.ibm.com>
Content-Language: en-US, sv-SE
From: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <20260203171958.1522030-5-jremus@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026-02-03 09:19, Jens Remus wrote:
> From: Josh Poimboeuf <jpoimboe@kernel.org>
> 
> Use SYM_FUNC_{START,END} instead of all the boilerplate.  No functional
> change.
> 
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> Signed-off-by: Jens Remus <jremus@linux.ibm.com>
> ---
> 
> Notes (jremus):
>     Changes in v7:
>     - Rebase on H. Peter Anvin's vDSO changes on tip:x86/entry.
> 
>  arch/x86/entry/vdso/vdso32/system_call.S | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/x86/entry/vdso/vdso32/system_call.S b/arch/x86/entry/vdso/vdso32/system_call.S
> index 9157cf9c5749..a90f4f7de396 100644
> --- a/arch/x86/entry/vdso/vdso32/system_call.S
> +++ b/arch/x86/entry/vdso/vdso32/system_call.S
> @@ -9,11 +9,7 @@
>  #include <asm/alternative.h>
>  
>  	.text
> -	.globl __kernel_vsyscall
> -	.type __kernel_vsyscall,@function
> -	ALIGN
> -__kernel_vsyscall:
> -	CFI_STARTPROC
> +SYM_FUNC_START(__kernel_vsyscall)
>  
>  	/*
>  	 * If using int $0x80, there is no reason to muck about with the
> @@ -85,7 +81,5 @@ SYM_INNER_LABEL(int80_landing_pad, SYM_L_GLOBAL)
>  	CFI_RESTORE		ecx
>  	CFI_ADJUST_CFA_OFFSET	-4
>  	RET
> -	CFI_ENDPROC
> -
> -	.size __kernel_vsyscall,.-__kernel_vsyscall
> +SYM_FUNC_END(__kernel_vsyscall)
>  	.previous

Looks good to me.

Acked-by: H. Peter Anvin (Intel) <hpa@zytor.com>

