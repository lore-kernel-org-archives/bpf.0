Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3643DE439;
	Thu, 11 Jun 2026 11:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781176974; cv=none; b=oUAp77Ew0lpb7J2ngVSFqwR7Hzi6FFXlcyGee7B11sCA3M67WztfGMUfeTOaFu/PRQkzRELSOCAz5xFvY9z+F/BNCB3LlzT5caAzx/M3kXY8XWT2EFvJnrHSd6s8rgOEw0/NtUqlwBT4/7hEP0vwwwNJbGRGyjmK6j3q/nsQnnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781176974; c=relaxed/simple;
	bh=sIkoD90dsA2/h+owQ5rfH3AZMnRfSiTrBB41fjNGsqo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JrmtamR77oL7OiwFx1RDpyR20G4VSPICo5aJNaSXM0wkNOXFtxFH8bSXV5F0jkw9EQ0yH6XFBYiOynIN4yYw3FvSJ0DQgzhikhxCTqYDdnqMn8272XgosNT00knPAqjk8j6dOdJQFjL3aR9Hjznui4hCRi8nuPFzNegxzCvazs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oNVYEIzn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oNVYEIzn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 469D31F00893;
	Thu, 11 Jun 2026 11:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781176972;
	bh=fUjEhPihvAgKIeS0vkP/dqhW32QCbB+0VtmkbkN7PKE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=oNVYEIzn2GOUMObsuReviEW/N8TnFb2OzhstcgTEO9TNPKsTNzllGK1bloANXk2Ng
	 TU74suxzVwZRgSijuIyHyaCCoEzlB0anupyzwfNM7fdeEEQR63Buytjpuj8EboQ2ZH
	 2owL5sUaLLn3rAfZGLWb8PxDuYqz2YGwOwKl3dZQ63J+ZylZRHgNYnpZJLROHFrfWn
	 +c2EheRWvwawyUUbLZdhGi0V+RD6pDQyK6f8qdqXWh9PS19EDvT3id4t5bKhwaOLaM
	 jx1NPWzri4lDN259D+F+mdqfhQP2usy7T4+QcfqX7kvHTlst6xLX654QfBw4bsEZxW
	 ZvP62HgrGJbjw==
Date: Thu, 11 Jun 2026 07:22:49 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: Fangrui Song <i@maskray.me>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, bpf@vger.kernel.org, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Jens Remus <jremus@linux.ibm.com>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Jiri
 Olsa <jolsa@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Andrii Nakryiko <andrii@kernel.org>, Indu Bhagat <ibhagatgnu@gmail.com>,
 "Jose E. Marchesi" <jemarch@gnu.org>, Beau Belgrave
 <beaub@linux.microsoft.com>, Linus Torvalds
 <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>,
 Florian Weimer <fweimer@redhat.com>, Kees Cook <kees@kernel.org>, Carlos
 O'Donell <codonell@redhat.com>, Sam James <sam@gentoo.org>, Dylan Hatch
 <dylanbhatch@google.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, David Hildenbrand <david@redhat.com>, "H.
 Peter Anvin" <hpa@zytor.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Michal Hocko
 <mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan
 <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>, Heiko Carstens
 <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Thomas
 =?UTF-8?B?V2Vpw59zY2h1aA==?= <thomas@t-8ch.de>
Subject: Re: [RESEND][PATCH v2] unwind: Add sframe_(un)register() system
 calls
Message-ID: <20260611072249.2222fd9d@gandalf.local.home>
In-Reply-To: <aipWtXVRqNmZY4gr@archer>
References: <20260528151626.4573592d@gandalf.local.home>
	<aipWtXVRqNmZY4gr@archer>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 11 Jun 2026 00:00:25 -0700
Fangrui Song <i@maskray.me> wrote:

> Hi Steven,
> 
> This is not an objection to deferred userspace unwinding itself -- my
> concern is narrower: these syscalls permanently encode the kernel's
> commitment to the SFrame format family at exactly the moment the
> format's size trajectory is heading the wrong way, and while arguably
> superior formats exist.
> 
> I raised related size concerns about SFrame's viability for userspace
> stack walking earlier:
> https://lore.kernel.org/all/3xd4fqvwflefvsjjoagytoi3y3sf7lxqjremhe2zo5tounihe4@3ftafgryadsr/
> ("Concerns about SFrame viability for userspace stack walking")
> 
> SFrame v3 is even larger than v2.
> 
> For comparison: Microsoft is currently upstreaming its Windows x64
> Unwind V3 implementation to LLVM, which will make a side-by-side reading
> of the two formats straightforward. Unwind V3 provides correct
> exception-handling unwind -- full prologue replay, SEH handlers,
> funclets -- and supports Intel APX. SFrame v3 provides stack tracing
> only, no EH, yet comes out larger than .eh_frame. A format revision that
> adds capability without adding bulk is demonstrably achievable; SFrame
> v3 went the other way.

My main concern is simplicity in implementation on the kernel side. One
thing we would like to avoid is any interpreter that becomes basically
executing user space code to perform the stack tracing (i.e. DWARF). I
haven't looked at the Windows x64 but will do so.

> 
> I understand IBM is doubling down on SFrame for their s390x and ppc64,

That's because this is currently the only way s390 can perform stack
walking in user space.

> but I'm not convinced the size overhead of v3 will make it appealing on
> x86-64. I have learned that the person driving their SFrame work at
> Google had left and the SFrame at data center effort was being
> reevaluated per a toolchain manager.

I believe the person who left Google that was driving the SFrame work was
me ;-)

Thanks,

-- Steve
