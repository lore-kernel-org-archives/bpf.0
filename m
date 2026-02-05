Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642E5263F4A;
	Thu,  5 Feb 2026 18:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770315974; cv=none; b=ADU3qzT2ivN+9DRAdfu1JtNAedfxDW9u/Eurr6yvcxkK/pecqbV5C8eoCzmsl+Sts4OZ67olgsAkqTe5THQcjAvdZb4w4KdWheVDZMcRVnb4Tyh6kkIsInGih/aCU4dfHN0YyJlzNFueJ40fGW3CfXrquc0X2tXDjSTl8EtU2Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770315974; c=relaxed/simple;
	bh=ZgI4s4IJcqbYrOfugYledwXgFygfiU6a+fz/w80FIxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o7c2vphajSp7QdEf2OMCQdGTwkUQM6xbz22Nl67QNWvqdlG2PyViEcHW1zpINsb3JLXggalk37EIdc8fo5IbNGVUOnayOGt3s0Y1XAUbHNec6HK7EGPSdsgKH9Z4IBzZKttTZzRR86T9nMVU7ez10Svar0XEGZqcWrAgJzm2M9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z1Y/k+3S; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z1Y/k+3S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CB09C4CEF7;
	Thu,  5 Feb 2026 18:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770315973;
	bh=ZgI4s4IJcqbYrOfugYledwXgFygfiU6a+fz/w80FIxM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z1Y/k+3SJ4RKsX8YvKX86d51UTcLx1XomnMvEAaxmVVKLBE1BdoWJJE/+swWUIxmh
	 QdqPYoZLdyHu41x7DCQVqzexpwe/mriTIGMbyAvqPealoXRis9NuJaOjB8c7xlBMdf
	 B2OjtIExPowIFb8OWrbepKwlD5Mtb+TZMk+Ww1oFDDznGMz/xqiiyOmngHOjHOE5v1
	 +3Apngm2vNRIe4cgGITUaKtfpYwl4FgVLrw+AK9IYejkRXA0TkeaWzslBb9CyTA43W
	 W6vMFdREQO8O7vg+SKtW/7NWh0OQpyokQVaCengvMXduAPAMwApvEZLSFE1nNCTxxh
	 AtN6aWEKtonpA==
Date: Thu, 5 Feb 2026 10:26:10 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Jens Remus <jremus@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org, x86@kernel.org, linux-mm@kvack.org,
	Steven Rostedt <rostedt@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrii Nakryiko <andrii@kernel.org>,
	Indu Bhagat <indu.bhagat@oracle.com>,
	"Jose E. Marchesi" <jemarch@gnu.org>,
	Beau Belgrave <beaub@linux.microsoft.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Florian Weimer <fweimer@redhat.com>, Kees Cook <kees@kernel.org>,
	Carlos O'Donell <codonell@redhat.com>, Sam James <sam@gentoo.org>,
	Dylan Hatch <dylanbhatch@google.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Hildenbrand <david@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH v13 00/18] unwind_deferred: Implement sframe handling
Message-ID: <aYTgwoyRl8kxQShT@google.com>
References: <20260127150554.2760964-1-jremus@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260127150554.2760964-1-jremus@linux.ibm.com>

Hello,

On Tue, Jan 27, 2026 at 04:05:35PM +0100, Jens Remus wrote:
> This is the implementation of parsing the SFrame V3 stack trace information
> from an .sframe section in an ELF file.  It's a continuation of Josh's and
> Steve's work that can be found here:
> 
>    https://lore.kernel.org/all/cover.1737511963.git.jpoimboe@kernel.org/
>    https://lore.kernel.org/all/20250827201548.448472904@kernel.org/
> 
> Currently the only way to get a user space stack trace from a stack
> walk (and not just copying large amount of user stack into the kernel
> ring buffer) is to use frame pointers. This has a few issues. The biggest
> one is that compiling frame pointers into every application and library
> has been shown to cause performance overhead.
> 
> Another issue is that the format of the frames may not always be consistent
> between different compilers and some architectures (s390) has no defined
> format to do a reliable stack walk. The only way to perform user space
> profiling on these architectures is to copy the user stack into the kernel
> buffer.
> 
> SFrame [1] is now supported in binutils (x86-64, ARM64, and s390). There is
> discussions going on about supporting SFrame in LLVM. SFrame acts more like
> ORC, and lives in the ELF executable file as its own section. Like ORC it
> has two tables where the first table is sorted by instruction pointers (IP)
> and using the current IP and finding it's entry in the first table, it will
> take you to the second table which will tell you where the return address
> of the current function is located and then you can use that address to
> look it up in the first table to find the return address of that function,
> and so on. This performs a user space stack walk.
> 
> Now because the .sframe section lives in the ELF file it needs to be faulted
> into memory when it is used. This means that walking the user space stack
> requires being in a faultable context. As profilers like perf request a stack
> trace in interrupt or NMI context, it cannot do the walking when it is
> requested. Instead it must be deferred until it is safe to fault in user
> space. One place this is known to be safe is when the task is about to return
> back to user space.
> 
> This series makes the deferred unwind user code implement SFrame format V3
> and enables it on x86-64.
> 
> [1]: https://sourceware.org/binutils/wiki/sframe
> 
> 
> This series applies on top of the tip perf/core branch:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  perf/core
> 
> The to be stack-traced user space programs (and libraries) need to be
> built with the recent SFrame stack trace information format V3, as
> generated by the upcoming binutils 2.46 with assembler option --gsframe.
> It can be built from source from the binutils-2_46-branch branch:
> 
>   git://sourceware.org/git/binutils-gdb.git  binutils-2_46-branch
> 
> Namhyung Kim's related perf tools deferred callchain support can be used
> for testing ("perf record --call-graph fp,defer" and "perf report/script").

Is it possible for users to choose the unwinder - frame pointer or
SFrame at runtime?  I feel like the option should be
"--call-graph sframe,defer" or just "--call-graph sframe" if it always
uses deferred unwinding.

Thanks,
Namhyung

> 
> 
> Changes since v12 (see patch notes for details):
> - Rebase on tip perf/core branch (d55c571e4333).
> - Add support for SFrame V3, including its new flexible FDEs.  SFrame V2
>   is not supported.
> 
> Changes since v11 (see patch notes for details):
> - Rebase on tip master branch (f8fdee44bf2f) with Namhyung Kim's
>   perf/defer-callchain-v4 branch merged on top.
> - Adjust to Peter's latest undwind user enhancements.
> - Simplify logic by using an internal SFrame FDE representation, whose
>   FDE function start address field is an address instead of a PC-relative
>   offset (from FDE).
> - Rename struct sframe_fre to sframe_fre_internal to align with
>   struct sframe_fde_internal.
> - Remove unused pt_regs from unwind_user_next_common() and its
>   callers. (Peter)
> - Simplify unwind_user_next_sframe(). (Peter)
> - Fix a few checkpatch errors and warnings.
> - Minor cleanups (e.g. move includes, fix indentation).
> 
> Changes since v10:
> - Support for SFrame V2 PC-relative FDE function start address.
> - Support for SFrame V2 representing RA undefined as indication for
>   outermost frames.
> 
> 
> Patches 1, 4, 11, and 17 have been updated to exclusively support the
> latest SFrame V3 stack trace information format, that is generated by
> the upcoming binutils 2.46 release.  Old SFrame V2 sections get rejected
> with dynamic debug message "bad/unsupported sframe header".
> 
> Patches 7 and 8 add support to unwind user (sframe) for outermost frames.
> 
> Patches 12-15 add support to unwind user (sframe) for the new SFrame V3
> flexible FDEs.
> 
> Patch 16 improves the performance of searching the SFrame FRE for an IP.
> 
> Regards,
> Jens
> 
> 
> Jens Remus (7):
>   unwind_user: Stop when reaching an outermost frame
>   unwind_user/sframe: Add support for outermost frame indication
>   unwind_user: Enable archs that pass RA in a register
>   unwind_user: Flexible FP/RA recovery rules
>   unwind_user: Flexible CFA recovery rules
>   unwind_user/sframe: Add support for SFrame V3 flexible FDEs
>   unwind_user/sframe: Separate reading of FRE from reading of FRE data
>     words
> 
> Josh Poimboeuf (11):
>   unwind_user/sframe: Add support for reading .sframe headers
>   unwind_user/sframe: Store .sframe section data in per-mm maple tree
>   x86/uaccess: Add unsafe_copy_from_user() implementation
>   unwind_user/sframe: Add support for reading .sframe contents
>   unwind_user/sframe: Detect .sframe sections in executables
>   unwind_user/sframe: Wire up unwind_user to sframe
>   unwind_user/sframe: Remove .sframe section on detected corruption
>   unwind_user/sframe: Show file name in debug output
>   unwind_user/sframe: Add .sframe validation option
>   unwind_user/sframe/x86: Enable sframe unwinding on x86
>   unwind_user/sframe: Add prctl() interface for registering .sframe
>     sections
> 
>  MAINTAINERS                               |   1 +
>  arch/Kconfig                              |  23 +
>  arch/x86/Kconfig                          |   1 +
>  arch/x86/include/asm/mmu.h                |   2 +-
>  arch/x86/include/asm/uaccess.h            |  39 +-
>  arch/x86/include/asm/unwind_user.h        |  69 +-
>  arch/x86/include/asm/unwind_user_sframe.h |  12 +
>  fs/binfmt_elf.c                           |  48 +-
>  include/linux/mm_types.h                  |   3 +
>  include/linux/sframe.h                    |  60 ++
>  include/linux/unwind_user.h               |  18 +
>  include/linux/unwind_user_types.h         |  46 +-
>  include/uapi/linux/elf.h                  |   1 +
>  include/uapi/linux/prctl.h                |   6 +-
>  kernel/fork.c                             |  10 +
>  kernel/sys.c                              |   9 +
>  kernel/unwind/Makefile                    |   3 +-
>  kernel/unwind/sframe.c                    | 840 ++++++++++++++++++++++
>  kernel/unwind/sframe.h                    |  87 +++
>  kernel/unwind/sframe_debug.h              |  68 ++
>  kernel/unwind/user.c                      | 105 ++-
>  mm/init-mm.c                              |   2 +
>  22 files changed, 1414 insertions(+), 39 deletions(-)
>  create mode 100644 arch/x86/include/asm/unwind_user_sframe.h
>  create mode 100644 include/linux/sframe.h
>  create mode 100644 kernel/unwind/sframe.c
>  create mode 100644 kernel/unwind/sframe.h
>  create mode 100644 kernel/unwind/sframe_debug.h
> 
> -- 
> 2.51.0
> 
