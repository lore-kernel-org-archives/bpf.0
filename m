Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29E882899;
	Sat,  7 Feb 2026 00:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770425320; cv=none; b=P66ecA24lMBP7K/6W3ZYFrR42UeJrg9ex/dqaxCkQCIZ4tS/vLipecLidOTZjD+g4OhtzBNC3XbxW/1/P0ATTSnrFqllOyUJnL+t+K4mz9+TYctOSM/uBQGP3hR1aUHWvCLIzRfdCBQC6qiXFyg3j3t9pt4nmYszePYpdJS7yuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770425320; c=relaxed/simple;
	bh=vsvgKR4j92CFsccFD6/N2XzrLJouwtpGWdBZS6Ku7o4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FWqj/+gxD7IEgK5pCB/jPyMRoDdUIg5Coie5ljmPMrIAbDyQn5XK7pCGhx5mTW2I8HBe9AeJhGq3S6rPuNt1B6n45+Od921g/VwKuB4qeq330t+KB546LMYfofAQ34+Eahrvq/vSHtjy/lR/8VAay3r62wEMYFssyOFZkVgHq4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p7nX2vVX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p7nX2vVX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBE14C116C6;
	Sat,  7 Feb 2026 00:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770425320;
	bh=vsvgKR4j92CFsccFD6/N2XzrLJouwtpGWdBZS6Ku7o4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p7nX2vVXviUESlx8Jk7ISlG4N0+euZ5ks+pQQGhT+J9tbyWxYHXPF0ekRxG4DpISu
	 dN0sohT7CkSMHGV9T+qTysmH9D3OwEVm7lwkrKWA3YrXYAngHjdlU9x7KFPUWUdnha
	 st16aMTVH4R1YRqLofCAFIho4042/FJbxmc8klRZcNVe/tzZgBVbFQq5Opaf2Oq0vu
	 4xA9SmmFpUkT5UCdZ/2z8fZK438ADxP7SYh1OWlkkcmpqruhh98c9Ua5YW+eG8q0l8
	 3nsSWFD+Z/epBoJzv9V7wUmw0f9yrFRrN8pjk9ZGQ8sCEl8VDpQ8yZdPAXl9FiPNWs
	 Z+HRp3xKIi3aA==
Date: Fri, 6 Feb 2026 16:48:37 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Jens Remus <jremus@linux.ibm.com>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, x86@kernel.org, linux-mm@kvack.org, 
	Steven Rostedt <rostedt@kernel.org>, Indu Bhagat <indu.bhagat@oracle.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Andrii Nakryiko <andrii@kernel.org>, 
	"Jose E. Marchesi" <jemarch@gnu.org>, Beau Belgrave <beaub@linux.microsoft.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Florian Weimer <fweimer@redhat.com>, Kees Cook <kees@kernel.org>, 
	Carlos O'Donell <codonell@redhat.com>, Sam James <sam@gentoo.org>, Dylan Hatch <dylanbhatch@google.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	David Hildenbrand <david@redhat.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	"Steven Rostedt (Google)" <rostedt@goodmis.org>
Subject: Re: [PATCH v7 6/6] x86/vdso: Enable sframe generation in VDSO
Message-ID: <h34g66ujiebhuxzcqo4hg4zq2mbpbh5c3u7b7qlznaqxxwpczf@3kwv2wydbuiq>
References: <20260203171958.1522030-1-jremus@linux.ibm.com>
 <20260203171958.1522030-7-jremus@linux.ibm.com>
 <f671c79a-ee73-4a12-af48-2811f97b9f3d@zytor.com>
 <9a63ce89-84f0-4782-90bf-dfd7c8ec8c52@linux.ibm.com>
 <1AE3ED79-C094-46AE-B455-06199D5699DD@zytor.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1AE3ED79-C094-46AE-B455-06199D5699DD@zytor.com>

On Fri, Feb 06, 2026 at 03:56:59PM -0800, H. Peter Anvin wrote:
> On February 6, 2026 9:48:24 AM PST, Jens Remus <jremus@linux.ibm.com> wrote:
> >On 2/4/2026 1:49 AM, H. Peter Anvin wrote:
> >> On 2026-02-03 09:19, Jens Remus wrote:
> >>> -
> >>> +#if defined(__x86_64__) && defined(CONFIG_AS_SFRAME)
> >
> >My understanding is that you would like above changed to:
> >
> >#ifdef CONFIG_AS_SFRAME
> >
> >>> +	.cfi_sections .eh_frame, .debug_frame, .sframe
> >>> +#else
> >>>  	.cfi_sections .eh_frame, .debug_frame
> >>> +#endif
> >>>  
> >> 
> >> It would be better to:
> >> 
> >> #undef CONFIG_AS_SFRAME	/* i386 doesn't support .sframe */
> >> 
> >> in fake_32bit_build.h.
> >Due to (binutils 2.46 pre-release) GNU assembler supporting --gsframe-3,
> >but only for x86-64 not for x86-32 (nor x32) CONFIG_AS_SFRAME is enabled
> >even for my i386 cross build attempt.  This then wrongly causes the
> >.cfi_sections with .sframe to be selected (verified by adding an #error
> >for testing).
> >
> >IIUC the .cfi_sections is there to have DWARF in both .eh_frame and
> >.debug_frame.  For .sframe it basically has the same effect as
> >specifying the common assembler option --gsframe.  Given the more
> >specific option --gsframe-3 is explicitly specified I think it would
> >be better to drop the changes to both dwarf2.h and fake_32bit_build.h
> >and solely rely on --gsframe-3.
> >
> >Josh, Indu, do you agree?
> >
> >Thanks and rRegards,
> >Jens
> 
> Seems a lot cleaner to me, too, assuming it actually works.

+1

-- 
Josh
