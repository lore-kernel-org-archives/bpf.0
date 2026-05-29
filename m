Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699F833AD99;
	Fri, 29 May 2026 13:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780061477; cv=none; b=giCExDP+yRmJgsQ7RfNVK0ua1hw4GdFNKPdeBtySSPD82Sf+pJRTZa0SpizlyK/aNdsD2n2e3fj3Mhrujd27dejf9FYyTHa5aCdHxFVnjQcX0FUAGcnvBJFrEPl6Q8MLJq1hH3kN5OOVTdWwpJneEoNkNiPXq8grQGsYFThwpSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780061477; c=relaxed/simple;
	bh=mtZZ7D04Xz85pjxEpJWMZ+12/fuY8FJUl+abWbE25o4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JVX7bQowEDvNrtdpoT51k+shXoZ7uDUS7pKvmbnZkde+KzQfP9i++fyssuL/HCD6b4iKwp2AHnpedqbpDdPqSOvtBz+L9qgn+IYnZezqb19eM5qSY73NFacvyf1XszLrclVz5fUrAmAcBo/it8d/M6tExv/nU0sQdoOibbXd+3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mC7pAgxK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mC7pAgxK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71FE81F00893;
	Fri, 29 May 2026 13:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780061476;
	bh=kJIk5IgVmpZCa7NB+AjYuCCJBVbazDoFrgQwRh6eA0c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=mC7pAgxKjArQ/0r27X/2mkUYu1fMpo3Zn0jIrve7axUO0+X1ZXVt+A7etNUkFRyA3
	 A0sh7hfobfSmPeCJh6mE0ty5WSCVZtL8hxd5Pb5odVuoWgsRQxwV4Xh7ZQxS1sne8k
	 llFIDTiZrJro4DRhOoCacosCVm5UllKTVLy7tBFx6jKxPw8i0Gf8gjLWyiEDv7Cwlr
	 MYj1FjpjNelJUJaMZ74pRnIVzgMOiO7eCMBkQ0Ak1jh4rLPxmggqdnLzrNFitBfWzY
	 /+7HZ/twun8TecA7/g+03+kYvRCv1w8giFUqDgXRkMddJD65+b9ocxi6Gcg+ZdBk5t
	 aDXViOFJurYkw==
Date: Fri, 29 May 2026 09:31:10 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, bpf@vger.kernel.org, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Jens Remus <jremus@linux.ibm.com>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Jiri
 Olsa <jolsa@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Andrii Nakryiko <andrii@kernel.org>, Indu Bhagat <indu.bhagat@oracle.com>,
 "Jose E. Marchesi" <jemarch@gnu.org>, Beau Belgrave
 <beaub@linux.microsoft.com>, Linus Torvalds
 <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>,
 Florian Weimer <fweimer@redhat.com>, Kees Cook <kees@kernel.org>, "Carlos
 O'Donell" <codonell@redhat.com>, Sam James <sam@gentoo.org>, Dylan Hatch
 <dylanbhatch@google.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, David Hildenbrand <david@redhat.com>, "H.
 Peter Anvin" <hpa@zytor.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Michal Hocko
 <mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan
 <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>, Vasily Gorbik
 <gor@linux.ibm.com>, Thomas =?UTF-8?B?V2Vpw59zY2h1aA==?= <thomas@t-8ch.de>
Subject: Re: [PATCH v2] unwind: Add sframe_(un)register() system calls
Message-ID: <20260529093110.6f3ed243@fedora>
In-Reply-To: <20260529082840.26496A2c-hca@linux.ibm.com>
References: <20260528151023.00f5ec4e@gandalf.local.home>
	<20260529082840.26496A2c-hca@linux.ibm.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 29 May 2026 10:28:40 +0200
Heiko Carstens <hca@linux.ibm.com> wrote:

> > diff --git a/arch/s390/kernel/syscalls/syscall.tbl b/arch/s390/kernel/syscalls/syscall.tbl
> > index 09a7ef04d979..52519e2acdc8 100644
> > --- a/arch/s390/kernel/syscalls/syscall.tbl
> > +++ b/arch/s390/kernel/syscalls/syscall.tbl
> > @@ -398,3 +398,6 @@
> >  469	common	file_setattr			sys_file_setattr
> >  470	common	listns				sys_listns
> >  471	common	rseq_slice_yield		sys_rseq_slice_yield
> > +472	common	stacktrace_setup		sys_stacktrace_setup
> > +472	common	sframe_register			sys_sframe_register
> > +473	common	sframe_unregister		sys_sframe_unregister  
> 
> What is stacktrace_setup? And why only for s390? Looks like a leftover.

Oops! Yes it's a left over. Thanks for noticing.

-- Steve
