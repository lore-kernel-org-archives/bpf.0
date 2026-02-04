Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFCB43FCC;
	Wed,  4 Feb 2026 00:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770166261; cv=none; b=ODdVHbbCmZxgao4+4aK18RNeaWK5G+I6dMAdwzS3vbnVVJRRmVxl9rWxj+3423bE3roNQGa56BxP864lL5nz5SF59OxLMlYKxfhdLs5GvzIFp0fVhmQtzU1KQBXVLrEP2+M1oCO5+z1SzEe4IaP9ELB6plGXgXSs/C7z63Km+YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770166261; c=relaxed/simple;
	bh=dO61T8QeCWjGc8b9NM0t59eQwnsgsf5V6trAeAwH6Es=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EAZjMoRWztv6OvFxxjjqH/Bg0nagOTHCc7hF2s4x4pS1/BOqXMEuqdysimYR08+AJfy/iMAmel5vPlA+5yof/JRhUOyOeRxN8Cz/J5cf3b9oQXBldvGaLs31eSDiVVxtgJDRK1ylgWNt4go2X+REKgWy4gBkQ1jJ+GnLC6/8tbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=fail (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=RWTj5e+h reason="signature verification failed"; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="RWTj5e+h"
Received: from [IPV6:2601:646:8081:9484:7f27:8faf:e50:c87b] ([IPv6:2601:646:8081:9484:7f27:8faf:e50:c87b])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 6140o2eC3687362
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Tue, 3 Feb 2026 16:50:05 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 6140o2eC3687362
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2026012301; t=1770166207;
	bh=Ejpaqsz9CMO56IB7gVAQcbMCdvB+s9mbb2E3+bpwa/4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RWTj5e+h1GfgY2uJUjhz+ZDqeE3AlVlEAgP9GkHrXJZVFnIPqKSm0iBR/rykX6U60
	 Pe7NjbAs0rJ2VbwvNuAooQlZj6dlXjUbjLB2AzoEAT0NyTPLYaHvr5IVlmySydgoKo
	 srrQOtWAUzNgHurf4mlIrxciyK6wAQL40q+qaJUNUR/nfnMw0PtdWFAA96j44VUZgS
	 VVzbV3gTd3t7nYdJMSRxY/FV4iNnhqTzuyVTsdIsayaKkqVUJmhdwYfzqNTR7gyikd
	 ZUfkPXSCCZ6FPF3kkb/4+YDggZf80bIpZJY+9rYq9aUfNIPNtK3u1SL417rVoujXia
	 KPQihnp3o/pnQ==
Message-ID: <f671c79a-ee73-4a12-af48-2811f97b9f3d@zytor.com>
Date: Tue, 3 Feb 2026 16:49:56 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 6/6] x86/vdso: Enable sframe generation in VDSO
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
 <20260203171958.1522030-7-jremus@linux.ibm.com>
Content-Language: en-US, sv-SE
From: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <20260203171958.1522030-7-jremus@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026-02-03 09:19, Jens Remus wrote:
> -
> +#if defined(__x86_64__) && defined(CONFIG_AS_SFRAME)
> +	.cfi_sections .eh_frame, .debug_frame, .sframe
> +#else
>  	.cfi_sections .eh_frame, .debug_frame
> +#endif
>  

It would be better to:

#undef CONFIG_AS_SFRAME	/* i386 doesn't support .sframe */

in fake_32bit_build.h.

	-hpa

