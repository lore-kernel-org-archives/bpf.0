Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E56828642D;
	Fri,  6 Feb 2026 23:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770419525; cv=none; b=r3Krm+zW2gY49ZeB0AVB1/CVOt0WqWDBGJA4Cg0gkvR1gv8jWsBZFdPIaI2eGDufnt8NWMu73FCInEbOvcP1ZOWsvOsjO3Jmc0z37Fe9GEC03GpMeK0OMtrgtVIiDjIqUxFMATuanznDhcJTN0aNBPQWzUDhXsmMB/sbrZ41K7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770419525; c=relaxed/simple;
	bh=n/Gw3B7dhzs5kbVhcSZwxQThMptQ12DJ7MK3V38XV94=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M9DHvK6TEt0tK7dKktNBpb3pspCAoGr7FTWapJ0Wew+CF1VNzewWeSHbrfyz38dTv8o0WmxJ53e9Krh2aLNeX710Pe1E8Z62eFUbCFwkqTGjj8X6lDrYRbSBLNwIrVpcms1UOS3KVfHlhhKleaT/tGVzpsr07DJx4kne7KzWNH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=fail (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=f6mExEWV reason="signature verification failed"; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="f6mExEWV"
Received: from [IPV6:2601:646:8081:9484:da7e:5e09:3c1e:8002] ([IPv6:2601:646:8081:9484:da7e:5e09:3c1e:8002])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 616N8MNN1391383
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Fri, 6 Feb 2026 15:08:29 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 616N8MNN1391383
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2026012301; t=1770419312;
	bh=FVE23sU8f0tF/woG1DKU3iF/2D4ifdEew5Zjv3zRdio=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=f6mExEWVcFoGl+DPFS7WpxlxeCRIHac6tvcqDNllvY7fcn5iEbosRIzvziGMVi/jr
	 IlZrZd/QABAJm2OHwDCNpqS9Bw2KbrG4IncZjpAWpmV6APHhylB1Bq9EOsCNzpQe1c
	 pz4U8RZ3j8bVG6TzLrp+r8xc4p+Kt8wLNpOS0TqiPsWKN/d9wFnwjWOh04emb2YoTR
	 svx3yUV2tx8YCHfBHxvpyy21Ps1+5ztp55UBPmKZTWspjimi2ZvfuvNGRAI5DS5db8
	 5dBNmHcpOQXuS2bisH9Fug5kgfNmaEss+y8njKZu8sjy7noBU6YSnK1NreRaOSUXl0
	 4okmimMg43c4g==
Message-ID: <4304d18a-f647-4709-9f29-43d9995cc24e@zytor.com>
Date: Fri, 6 Feb 2026 15:08:17 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 6/6] x86/vdso: Enable sframe generation in VDSO
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
        David Hildenbrand <david@kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Michal Hocko
 <mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>
References: <20260206193642.1580787-1-jremus@linux.ibm.com>
 <20260206193642.1580787-7-jremus@linux.ibm.com>
Content-Language: en-US, sv-SE
From: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <20260206193642.1580787-7-jremus@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026-02-06 11:36, Jens Remus wrote:
> From: Josh Poimboeuf <jpoimboe@kernel.org>
> 
> Enable sframe generation in the VDSO library so kernel and user space
> can unwind through it.
> 
> SFrame isn't supported for x32 or x86-32.  Discard .sframe sections for
> those VDSOs.
> 
> [ Jens Remus: Add support for SFrame V3.  Prevent GNU_SFRAME program
> table entry to empty .sframe section. ]
> 

This will not break the x86-32 build if the assembler encounters .sframe?

> Notes (jremus):
>     Changes in v8:
>     - Discard .sframe for x32 and x86-32 VDSOs. (Josh/Indu)
>       Note that the use of KEEP_SFRAME enables to define it for x86-64
>       VDSO only.  Unlike CONFIG_AS_SFRAME, which may also be defined
>       for x32 and x86-32 VDSO.  In x32 VDSO it would result in superfluous
>       .sframe (copied from the x86-64 build - could be removed in X32
>       build step).  In x86-32 VDSO it would cause a bogus GNU_SFRAME
>       program table entry.

For x32, this would be a "valid" sframe, right, even if the tools currently
don't know how to consume it (and potentially never will)? If so, is there
really any reason to explicitly remove it?

>  	/*
>  	 * Text is well-separated from actual data: there's plenty of
>  	 * stuff that isn't used at runtime in between.
> @@ -80,6 +87,10 @@ SECTIONS
>  		*(.discard)
>  		*(.discard.*)
>  		*(__bug_table)
> +#ifndef KEEP_SFRAME
> +		*(.sframe)
> +		*(.sframe.*)
> +#endif

This #ifndef is actually not necessary: if we have already "consumed" the
.sframe* sections they will not be encountered here.

I would prefer to have KEEP_SFRAME always defined (as true or false, and using
#if) instead of using #ifdef. I believe that also means you can do:

#define KEEP_SFRAME IS_ENABLED(CONFIG_AS_SFRAME)

... instead of #ifdef.

	-hpa

