Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A294B26ED48;
	Mon,  9 Feb 2026 19:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770664574; cv=none; b=PKEj3lZT1sOYl+0NvJsD7dSj8qW/W79EmHAW+/azk5PFAXii8amYjiNLP6aeTyhV4Z51+F/3t7xhLjwxS/q+Hk7zMx4+STg+6HdtYOs3Ric+ivxgTs40R8/v5la37rTDJ0Y3G3AX4aUXTwZG1jf6aFL+txFRgcAuRxO/s31d4G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770664574; c=relaxed/simple;
	bh=K84LMYSwPhj85e7p7HD8CMLWkcmCZVvN1rA19YO+YOw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Uq/oCAIVcQpvO6F+bIrWGxcqSFYe7xl7dBC4R8bWWYVNhHyHvRx1X7hqdNFohcuXVJaAFxBxmimYmhVK4WAEupj2lwdoAadKK3aWszMAKWi8FmvWIN4HM63Qwtyn30R1Wq2VE2O+hrUKznOfVoZIZ1NKZTdrSw5+aPz1DFa0ksA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=fail (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=iPd00tHw reason="signature verification failed"; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="iPd00tHw"
Received: from [172.27.2.41] (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 619JE36v2934652
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Mon, 9 Feb 2026 11:14:18 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 619JE36v2934652
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2026012301; t=1770664463;
	bh=pIyV62SWjV0SKyjGknYDYzfBqyYNpDlb53BKVk3jI10=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=iPd00tHw1jd3dEOTaiXmF3ei63floLH1KlJ9NcceCfS7Irgbtsq1kJWJWR/Ws1wSO
	 dxmQur9xlMilqnU2Nf75lUielVCCnq8y1WPMJlWg9Z9m4NPXYlnIOKjmk90TqyAVWt
	 WEtv508aS+ox+SRIPrFJWTiFqYiZ2LdDJ3tM5IMknKj7G4lYx4oCTmq3gSHdI2vW3v
	 J1L7aibbo0NPOrXwGJZ26pULK5COAnIiRZK39Ya1u4HxVgQa7Q5reMHGhCC4/pOjU7
	 QpJaJprS7T1nobbmkUs/3fAUEo9YRPiUsM3N6R78c9K0S8x96V6q0mPrfs/ZtjKmfH
	 BDNnlP7Bz/8eA==
Message-ID: <b074b10e-6b3e-4c69-a986-6b2eb665e535@zytor.com>
Date: Mon, 9 Feb 2026 11:13:58 -0800
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
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Steven Rostedt <rostedt@kernel.org>,
        Indu Bhagat <indu.bhagat@oracle.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrii Nakryiko <andrii@kernel.org>,
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
 <4304d18a-f647-4709-9f29-43d9995cc24e@zytor.com>
 <22bc8f74-1943-4ceb-bc6b-ea404ba013d9@linux.ibm.com>
Content-Language: en-US, sv-SE
From: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <22bc8f74-1943-4ceb-bc6b-ea404ba013d9@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026-02-09 08:45, Jens Remus wrote:
> On 2/7/2026 12:08 AM, H. Peter Anvin wrote:
>> On 2026-02-06 11:36, Jens Remus wrote:
>>> From: Josh Poimboeuf <jpoimboe@kernel.org>
>>>
>>> Enable sframe generation in the VDSO library so kernel and user space
>>> can unwind through it.
>>>
>>> SFrame isn't supported for x32 or x86-32.  Discard .sframe sections for
>>> those VDSOs.
>>>
>>> [ Jens Remus: Add support for SFrame V3.  Prevent GNU_SFRAME program
>>> table entry to empty .sframe section. ]
>>>
>>
>> This will not break the x86-32 build if the assembler encounters .sframe?
> 
> I cannot follow.  Assembler option --gsframe-3 is only specified in
> vdso64/Makefile if CONFIG_AS_SFRAME3, which affects the x86-64 and x32
> VDSOs.  The latter as the x32 VDSO is built from x86-64 objects
> converted to x86-32 objects using the X32 build step.  Assembler
> directive ".cfi_sections .sframe" is no longer used in dwarf2.h, which
> affected the x86-32 VDSO if cross build on x86-64 (so that
> CONFIG_AS_SFRAME3=y).
> 
> The reason to discard .sframe in the common VDSO linker script if
> !KEEP_SFRAME is to remove it from x32 VDSO (built from x86-64 objects
> having .sframe).  It should also prevent linker errors from linkers that
> do not support R_X86_64_PC64 in x32 mode, such as the meanwhile fixed
> GNU linker:
> https://www.sourceware.org/bugzilla/show_bug.cgi?id=33807
> 

OK, the linker not handing R_X86_64_PC64 is probably a good enough reason to
discard .sframe.

The x32 ABI and object format is explicitly intended to be as close to the
x86-64 as possible; it even uses the same architectural identifier. That's
pretty much the reason we don't even bother recompiling the objects in the
first place; the 64-bit objects can simply be downconverted from ELF64 to
ELF32. This also means that the compiler doesn't need to support x32, although
objcopy and ld does.

This also means the DWARF data is the one generated for 64 bits.

This works because the following is true for all vdso entrypoints:
	- No vdso entry point access pointers or explicit "long"s *in memory*.
	  (The latter formally violates POSIX for struct timespec, but that
	   was a deliberate decision imposed by Linus at the time the x32 API
	   was defined: "no 32-bit time_t in a new ABI.")
	- No vdso entry point calls system calls that do, either.
	- No vdso entry point takes a *signed* long as an argument.
	- No vdso entry point calls system calls that differ in behavior
	  between x86-64 and x32, making it OK to call the 64-bit system call
	  from an x32 process.

"unsigned long" and pointers *can* be safely passed in argument registers
(because the architecture will zero-extend those registers), and in addition
"signed long" *can* be safely passed as returns.

If ANY of the constraints above were ever violated, OR the binary format would
start diverging to the point that objcopy can't properly convert it, then we
would need to start compiling the x32 binaries separately.


> The following works and indeed looks nicer with #if KEEP_SFRAME.  Will
> wait for further feedback on whether or not to discard .sframe in x32
> VDSO before sending a v9.

I think ld tripping over a bug justifies dropping .sframe at this point. *Make
sure* to document that in the checkin, and add a comment to vdso32.lds.S that
that is the motivation, so that if x32 gains support for .sframe in the future
(which should be simple enough, since the formats are so similar) we don't get
stuck in some kind of cargo cult programming problem.

It also will avoid issues on the off chance .sframe ends up being defined
differently for x32 for some reason, perhaps for consistency with other 32-bit
platforms.


Include the version of binutils which fixed the problem in your comments.


	-hpa



> diff --git a/arch/x86/entry/vdso/common/vdso-layout.lds.S b/arch/x86/entry/vdso/common/vdso-layout.lds.S
> @@ -60,7 +60,7 @@ SECTIONS
>  		*(.eh_frame.*)
>  	}					:text
>  
> -#ifdef KEEP_SFRAME
> +#if KEEP_SFRAME
>  	.sframe		: {
>  		KEEP (*(.sframe))
>  		*(.sframe.*)
> @@ -87,7 +87,7 @@ SECTIONS
>  		*(.discard)
>  		*(.discard.*)
>  		*(__bug_table)
> -#ifndef KEEP_SFRAME
> +#if !KEEP_SFRAME
>  		*(.sframe)
>  		*(.sframe.*)
>  #endif
> @@ -116,7 +116,7 @@ PHDRS
>  	dynamic		PT_DYNAMIC	PF_R;
>  	note		PT_NOTE		PF_R;
>  	eh_frame_hdr	PT_GNU_EH_FRAME PF_R;
> -#ifdef KEEP_SFRAME
> +#if KEEP_SFRAME
>  	sframe		PT_GNU_SFRAME	PF_R;
>  #endif
>  	gnu_stack	PT_GNU_STACK	PF_RW;
> diff --git a/arch/x86/entry/vdso/vdso32/vdso32.lds.S b/arch/x86/entry/vdso/vdso32/vdso32.lds.S
> @@ -10,6 +10,7 @@
>  #include <asm/page.h>
>  
>  #define BUILD_VDSO32
> +#define KEEP_SFRAME	false
>  
>  #include "common/vdso-layout.lds.S"
>  
> diff --git a/arch/x86/entry/vdso/vdso64/vdso64.lds.S b/arch/x86/entry/vdso/vdso64/vdso64.lds.S
> @@ -8,10 +8,7 @@
>   */
>  
>  #define BUILD_VDSO64
> -
> -#ifdef CONFIG_AS_SFRAME
> -# define KEEP_SFRAME
> -#endif
> +#define KEEP_SFRAME	(CONFIG_AS_SFRAME)

This needs to be IS_ENABLED(CONFIG_AS_SFRAME). Otherwise you get either "y" or
"CONFIG_AS_SFRAME", neither of which are what you want.

>  #include "common/vdso-layout.lds.S"
>  
> diff --git a/arch/x86/entry/vdso/vdso64/vdsox32.lds.S b/arch/x86/entry/vdso/vdso64/vdsox32.lds.S
> @@ -8,6 +8,7 @@
>   */
>  
>  #define BUILD_VDSOX32
> +#define KEEP_SFRAME	false

Is "false" supported by all appropriate cpp versions? "0" is probably a safer
choice, and matches the IS_ENABLED() output anyway.

	-hpa

