Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D0029BDA5
	for <bpf@vger.kernel.org>; Wed, 11 Feb 2026 01:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770774491; cv=pass; b=DWqvaCKJ4+16hyRKpyP9M2a82VSWM5sSmlpmU/VPXntdKWF0/NO0ZrIYNo60mtc2OIyQxDdnn9bo8f57LW6JPPrn/NicW77ZkLZ22LHQugWyt+1GaDLNCSd1lfxrpHzdt1L4Dg2rZBJfi7CShF62K36qhEirCd3721l7qHW+0nM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770774491; c=relaxed/simple;
	bh=vL/5jYq0SwUdxKiiLLzX4hk6FHmq+VFamsZvnreeAg8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jKVpoBwvV5dfzS0rG47OjBbQjiOprelm/hB4FXCZmrnyqnnhHa5fSXKr/P+zBanWabsn1HKGB8hTi1qjIYLdKUb4foTEG828B7LS3VkGrsNd785rmulHB65GPZA51Qn3K8x7jCCTBOxgRapa5vbp1esiw51U7rpiVQ8fFwV0V28=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mFI/Q7GQ; arc=pass smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mFI/Q7GQ"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-79627af6349so17215877b3.0
        for <bpf@vger.kernel.org>; Tue, 10 Feb 2026 17:48:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770774487; cv=none;
        d=google.com; s=arc-20240605;
        b=Ony6vG8aW+UlV6G9+V+LGajFVr62jLkSNZExppF6S/gVPhifUznMraR4Xe0Jnh6Tlt
         SQmVKSo4K2xvRL/syoGEqFowJ+866MwAqsmnZbPB4etpcFCjfDivfPdaxHMjq9f9sOWc
         adaK/Hz+TqaIKC88g4lfo2ZOhi2Bb06YPi7q2CjOBWqQ52R1lQwNh3lkeCuVa7mikmSK
         xIttVV8XZJSNgFaP9APNBqFwJae+Qh1weR1pi23Ccg3uwRAnT04/OPo5nUZArgSsvOn+
         MRt3ns8Iy07kZZosQPz0TpqVYTU6HgQzPB3o09sOYW8M5uhz3Qqv8v24vYc1cCn2FDpk
         SYSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nIhDAJJR+YXegWy/wL3i8yaBjUwW4vdjx7/rh4TvX9Y=;
        fh=FaafL4xZID6KQdlgRZK8he3hb+W9/MCJ1z68dsujPxY=;
        b=FT0Tr7lxkB7YTm9Xpu9OPEp2rwIzz9XhEdXf+Vyi//QoeyjD/Jk0vQtWYXiy5Q90+6
         CyKsZ5FYzdU0yJBcFvO5TMJBRFp1XNrylIbR0NIEawBWdzY81OP6mxpeqMaYOJzor1VL
         KgPaOyrKXjj2trU1jDaJY8jl3EzVIZksxLIuarEGmieW5Vt+Ji/oLJxpit4EDzwaMvro
         H4wYM+pq1adm6+Y6aA75rOyT9vaozNpmhNhSlzE8idhqit8Oct1XA81DY+4EvZ0S2r8G
         Iur3nW5fClj8LQUAb353eiucS19ZuUsuuw+mS6klzUJe1N+ciLiCWifqV32MdOKz74El
         Hv5g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770774487; x=1771379287; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nIhDAJJR+YXegWy/wL3i8yaBjUwW4vdjx7/rh4TvX9Y=;
        b=mFI/Q7GQfi0/VWD0MLeyse/pLC5Sai8OS08PbQjmRLTDOtxYr2As+myKhKw7IO3gfh
         yJT78Vb5GqXd4Ellttqw/YST6q5D18PjPZY0z6+iaQfviOIetsmUhckBe4RnndqZKVZa
         mDWSeOXtHrE/z6232e18XCRwF1YnpT20U6ssSvrePiKloX/K93LDw/RbQK6V9goMxnF0
         xFewiqSB5UyQalFpEsR3MNV3kUUEEWpdluqZcpvAsuFHZk9kef+BbbeX6ZoKYck53S0L
         1pG5gPT4pP9XnzTAsfRE2W1PWYabfDRObIv52fYL63FCJY+RuankPrKgF4rQhA/A/miO
         clfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770774487; x=1771379287;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nIhDAJJR+YXegWy/wL3i8yaBjUwW4vdjx7/rh4TvX9Y=;
        b=RKPWKxYFn/w+CfI4VtWwQgD8UOD5w1/TI6jwb9otzCzBnBK/cZcnxX88d8bHqb1b8o
         eUhI+OTiJUaG7cdy4mTt2i6Cd3FFA4748vfAL6pB9jexK4DB3OPPmagQqLIqFRC7DXIe
         AUdpJR9X6wcZnaggxDFJo+nhNsN5woj47LxkhPSfVbuj80FXZv/NbSFbKozCJW5O5FyJ
         iP6NzESTpeUqE8WWAojHq4qt+JmR7gjsBbC420rzW1JosQ1X9mAXA21HnOgQcw7hvVi3
         uYYd5wnb1J6/j5O3rCrhXmP5MQB61l7jn6PYxzHN9DVoux1T1CJ5+zh2RubAKnNA+7+n
         Q83w==
X-Forwarded-Encrypted: i=1; AJvYcCVxEnFF7sE+Z8IcuNDLaf8GKbgiFgjf/pEzUJ1JYbD90XYDrxbXcbQFYRrC5Xc1XopbxR8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc6gjm4Ts7ABpomnYF/gxtjVrA4qBbMB7htCucj9PtW70kJ8zm
	z09Wz54duUcpKDuUdt3Dt1iLVqvIgug5AHa09mM9FlaUgfjP/dVJ3b2nuwDcpMa/8Rj1rt9dMvY
	c18AkOOMlyyeODtP3hqT9xuZ2G9dneE6gDQ6ZHet/+IFqAZFjt3E36s6Bcyjw+Q==
X-Gm-Gg: AZuq6aIQYoFqudK2mgbJSx2xDIftXJoV7H7QyCqXRJ+94ZOiPrq//MGzNywuvt/KLuT
	PlfpOWuUffmIcfuo3DpcNmu6Rik+aYOWFsNOFfO11r/hKm8Adn9aBrntk7wZ0cv2pVT/R/Fk/SV
	dOYza4aIK56r2+6ZPeRtoT/4xdb3UDLrCW01xLCURuy1JhvrsJAGNjYe1KB0x+ihBY0mrbdiO9E
	yhxb/EScAg+sMKCXTcqj56be6fp2pwXHmEC3vlSKCZqsAHo8s1n9FYKVKALlIMGNp7E3eBf6Hq5
	iwoUgs9qDIbmaXTcf52F2nZQdOfj7gUXdpqVyPtErP/yxoA=
X-Received: by 2002:a05:690c:60c6:b0:794:d4c3:3152 with SMTP id
 00721157ae682-7952aaa7866mr322145887b3.31.1770774486955; Tue, 10 Feb 2026
 17:48:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260127150554.2760964-1-jremus@linux.ibm.com>
In-Reply-To: <20260127150554.2760964-1-jremus@linux.ibm.com>
From: Dylan Hatch <dylanbhatch@google.com>
Date: Tue, 10 Feb 2026 17:47:55 -0800
X-Gm-Features: AZwV_QhqlaaRHUZ_sLIEmaOa0r2FI4v1zw3ijD25N_cAxghl966m-JoOQmBSKPk
Message-ID: <CADBMgpyHw_kgb+Fc+h+Z3ytwMBwDG9B=yai=7g4UWP6AErE77w@mail.gmail.com>
Subject: Re: [PATCH v13 00/18] unwind_deferred: Implement sframe handling
To: Jens Remus <jremus@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, x86@kernel.org, linux-mm@kvack.org, 
	Steven Rostedt <rostedt@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Andrii Nakryiko <andrii@kernel.org>, 
	Indu Bhagat <indu.bhagat@oracle.com>, "Jose E. Marchesi" <jemarch@gnu.org>, 
	Beau Belgrave <beaub@linux.microsoft.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Florian Weimer <fweimer@redhat.com>, 
	Kees Cook <kees@kernel.org>, "Carlos O'Donell" <codonell@redhat.com>, Sam James <sam@gentoo.org>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	David Hildenbrand <david@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 27, 2026 at 7:06=E2=80=AFAM Jens Remus <jremus@linux.ibm.com> w=
rote:
>
> This is the implementation of parsing the SFrame V3 stack trace informati=
on
> from an .sframe section in an ELF file.  It's a continuation of Josh's an=
d
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
> Another issue is that the format of the frames may not always be consiste=
nt
> between different compilers and some architectures (s390) has no defined
> format to do a reliable stack walk. The only way to perform user space
> profiling on these architectures is to copy the user stack into the kerne=
l
> buffer.
>
> SFrame [1] is now supported in binutils (x86-64, ARM64, and s390). There =
is
> discussions going on about supporting SFrame in LLVM. SFrame acts more li=
ke
> ORC, and lives in the ELF executable file as its own section. Like ORC it
> has two tables where the first table is sorted by instruction pointers (I=
P)
> and using the current IP and finding it's entry in the first table, it wi=
ll
> take you to the second table which will tell you where the return address
> of the current function is located and then you can use that address to
> look it up in the first table to find the return address of that function=
,
> and so on. This performs a user space stack walk.
>
> Now because the .sframe section lives in the ELF file it needs to be faul=
ted
> into memory when it is used. This means that walking the user space stack
> requires being in a faultable context. As profilers like perf request a s=
tack
> trace in interrupt or NMI context, it cannot do the walking when it is
> requested. Instead it must be deferred until it is safe to fault in user
> space. One place this is known to be safe is when the task is about to re=
turn
> back to user space.
>
> This series makes the deferred unwind user code implement SFrame format V=
3
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
> for testing ("perf record --call-graph fp,defer" and "perf report/script"=
).
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

Hi Jens,

Do you by chance have this work uploaded in a public branch somewhere?
I'd like to get a new version of the SFrame for reliable stacktrace on
arm64 patch series [1] working for SFrame V3, ideally with the SFrame
library in your patch series here.

https://lore.kernel.org/lkml/20250904223850.884188-1-dylanbhatch@google.com=
/

Thanks,
Dylan
