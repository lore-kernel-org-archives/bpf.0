Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C93556B70
	for <bpf@vger.kernel.org>; Mon, 11 Mar 2024 23:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710198185; cv=none; b=PaMX1Ft3xIi48MPZzVBDkpqiHQZc5/EuFIPRY+XNgOobJfJ+zLjpg9GSzpmtSulmjttKhQ4g+THphgk6xfGxl3wIcHlWQ1PLFXcREsdwsJYGLVoskNUg/T74uJbf+wONPLQZJ9CNgsyf0oMB87JHCHITlluhp9FrZf7pVo4cUro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710198185; c=relaxed/simple;
	bh=f6hMD9mQcHI4HxwXCNcl81EuqfNDFkSemN90xxWyP9s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OWH8h8A/Qyid1aJfFsPsRGM8yTjY0+covBnkReuyn9satlmQf8bGIqiJ6/MLoVtnajfF0tX5uNVLx+SmBjj7KfEKP71CGMKxv6l6VIqzfXU8chiOTFWUsV+aHCyYXpSLiYUmvPLhT9jq5fN4KA/QSZQWvahXRyDCPprGAhdwSi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OCEc1xMG; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OCEc1xMG"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-33e99915809so1094305f8f.3
        for <bpf@vger.kernel.org>; Mon, 11 Mar 2024 16:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710198181; x=1710802981; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d4dmxu+SWq+3xSszaIAWWzfY8zg4uor+kSDuvUvAOFc=;
        b=OCEc1xMGj8BRaZ6BQ8HL/PO8gU8C8DRZjiUEaziyzdQsvcQPBeYq2BZF6EmRzlB6TN
         Hd3YbBax0SD/B/Su3BAU8EOBG4q08jFg+GndBjQ374agCMZ1EBLNbiGFRunZWGa/y63G
         B8NDPLBA+r+MRZCPf3MDDxUrrmIC6LusMn9KYbaCr2qj4zeAHbEjx2u8K+5hApa0+rMn
         NV8xm4h2aNWnSA+7l7U8qnE58YcsN2nex5Rg7orp49IKnUL+Gfo7eZLfU1GJdU/BIQJm
         PUD9/EnFl2yUAHQUQigQqDdFdB00s9XkRYr3xETAUVfUMJ7oa4A/UhWxH0jzWRlVvH5A
         nNsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710198181; x=1710802981;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d4dmxu+SWq+3xSszaIAWWzfY8zg4uor+kSDuvUvAOFc=;
        b=CuBaYwHRHff7aOSwPolzKtwbSgkqS2Qw2LqBvaZ2MolaJ+0H6ALaFDp9fvlUXfqLLP
         o6NPeIKU/ooACocDUO72xZKM7emgL7/gd+FTXALArMNTIMel89+sULX/miwJbFaCyALN
         IWmpCv/AU2WscEfYK6tDE5UM5/9ajICD1wBZFVZwjmn6tBnPL0DgIwUg2FRRT04Gclur
         9VG9HhGKjZsofpdhTxwG06/rlQBNoz6OPrq5grVGc/CWe5nOPqdiMXpumpv1TAL7eqzy
         H5ipMXqK3+1rkjofU7g7K0w1O1UldwZV/PK5ErZetOea8r61xh2WS2Yr1eFAiYDbdqAH
         kOag==
X-Gm-Message-State: AOJu0YzR80xaYPqXyoyMapmCOUOPfWncxCk4uOVltiFblAesLshBOvSC
	jlHzXSECrTTSTETTD5pN5aTKl+6F7o5YfkEmuiH2k7N2h9C73/cjuTRZIHXlAzgj/4QYfqOU56m
	nRIfNzDod08EfWOtB7DNZvZCHQKxQT5wgpZs=
X-Google-Smtp-Source: AGHT+IGYAFrDAcr+GNhsy0h8ReBdmoFFgz4WJhzXeFB0Q4eVwczINZLvJ3xcKP1UeBaaO0mmYzIuMTqi02qiXF+w2u8=
X-Received: by 2002:adf:ecc8:0:b0:33e:629d:38c2 with SMTP id
 s8-20020adfecc8000000b0033e629d38c2mr5929637wro.8.1710198181209; Mon, 11 Mar
 2024 16:03:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240308010812.89848-1-alexei.starovoitov@gmail.com> <CAEf4Bzauehm0_jYBYCLXORF_Ff3m5N3h720OK0eMJfD6kSFyaw@mail.gmail.com>
In-Reply-To: <CAEf4Bzauehm0_jYBYCLXORF_Ff3m5N3h720OK0eMJfD6kSFyaw@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 11 Mar 2024 16:02:50 -0700
Message-ID: <CAADnVQKuxHEvaqxA=ho9mW6GOKyNEXiEk3gBBPTWx2rtSLMxDA@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 00/14] bpf: Introduce BPF arena.
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Barret Rhoden <brho@google.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Uladzislau Rezki <urezki@gmail.com>, 
	Christoph Hellwig <hch@infradead.org>, linux-mm <linux-mm@kvack.org>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 11, 2024 at 3:45=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Mar 7, 2024 at 5:08=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > From: Alexei Starovoitov <ast@kernel.org>
> >
> > v2->v3:
> > - contains bpf bits only, but cc-ing past audience for continuity
> > - since prerequisite patches landed, this series focus on the main
> >   functionality of bpf_arena.
> > - adopted Andrii's approach to support arena in libbpf.
> > - simplified LLVM support. Instead of two instructions it's now only on=
e.
> > - switched to cond_break (instead of open coded iters) in selftests
> > - implemented several follow-ups that will be sent after this set
> >   . remember first IP and bpf insn that faulted in arena.
> >     report to user space via bpftool
> >   . copy paste and tweak glob_match() aka mini-regex as a selftests/bpf
> > - see patch 1 for detailed description of bpf_arena
> >
> > v1->v2:
> > - Improved commit log with reasons for using vmap_pages_range() in aren=
a.
> >   Thanks to Johannes
> > - Added support for __arena global variables in bpf programs
> > - Fixed race conditions spotted by Barret
> > - Fixed wrap32 issue spotted by Barret
> > - Fixed bpf_map_mmap_sz() the way Andrii suggested
> >
> > The work on bpf_arena was inspired by Barret's work:
> > https://github.com/google/ghost-userspace/blob/main/lib/queue.bpf.h
> > that implements queues, lists and AVL trees completely as bpf programs
> > using giant bpf array map and integer indices instead of pointers.
> > bpf_arena is a sparse array that allows to use normal C pointers to
> > build such data structures. Last few patches implement page_frag
> > allocator, link list and hash table as bpf programs.
> >
> > v1:
> > bpf programs have multiple options to communicate with user space:
> > - Various ring buffers (perf, ftrace, bpf): The data is streamed
> >   unidirectionally from bpf to user space.
> > - Hash map: The bpf program populates elements, and user space consumes
> >   them via bpf syscall.
> > - mmap()-ed array map: Libbpf creates an array map that is directly
> >   accessed by the bpf program and mmap-ed to user space. It's the faste=
st
> >   way. Its disadvantage is that memory for the whole array is reserved =
at
> >   the start.
> >
> > Alexei Starovoitov (13):
> >   bpf: Introduce bpf_arena.
> >   bpf: Disasm support for addr_space_cast instruction.
> >   bpf: Add x86-64 JIT support for PROBE_MEM32 pseudo instructions.
> >   bpf: Add x86-64 JIT support for bpf_addr_space_cast instruction.
> >   bpf: Recognize addr_space_cast instruction in the verifier.
> >   bpf: Recognize btf_decl_tag("arg:arena") as PTR_TO_ARENA.
> >   libbpf: Add __arg_arena to bpf_helpers.h
> >   libbpf: Add support for bpf_arena.
> >   bpftool: Recognize arena map type
> >   bpf: Add helper macro bpf_addr_space_cast()
> >   selftests/bpf: Add unit tests for bpf_arena_alloc/free_pages
> >   selftests/bpf: Add bpf_arena_list test.
> >   selftests/bpf: Add bpf_arena_htab test.
> >
> > Andrii Nakryiko (1):
> >   libbpf: Recognize __arena global varaibles.
> >
> >  arch/x86/net/bpf_jit_comp.c                   | 231 +++++++-
> >  include/linux/bpf.h                           |  10 +-
> >  include/linux/bpf_types.h                     |   1 +
> >  include/linux/bpf_verifier.h                  |   1 +
> >  include/linux/filter.h                        |   4 +
> >  include/uapi/linux/bpf.h                      |  14 +
> >  kernel/bpf/Makefile                           |   3 +
> >  kernel/bpf/arena.c                            | 558 ++++++++++++++++++
> >  kernel/bpf/btf.c                              |  19 +-
> >  kernel/bpf/core.c                             |  16 +
> >  kernel/bpf/disasm.c                           |  10 +
> >  kernel/bpf/log.c                              |   3 +
> >  kernel/bpf/syscall.c                          |  42 ++
> >  kernel/bpf/verifier.c                         | 123 +++-
> >  .../bpf/bpftool/Documentation/bpftool-map.rst |   2 +-
> >  tools/bpf/bpftool/gen.c                       |  13 +
> >  tools/bpf/bpftool/map.c                       |   2 +-
> >  tools/include/uapi/linux/bpf.h                |  14 +
> >  tools/lib/bpf/bpf_helpers.h                   |   1 +
> >  tools/lib/bpf/libbpf.c                        | 163 ++++-
> >  tools/lib/bpf/libbpf.h                        |   2 +-
> >  tools/lib/bpf/libbpf_probes.c                 |   7 +
> >  tools/testing/selftests/bpf/DENYLIST.aarch64  |   2 +
> >  tools/testing/selftests/bpf/DENYLIST.s390x    |   2 +
> >  tools/testing/selftests/bpf/bpf_arena_alloc.h |  67 +++
> >  .../testing/selftests/bpf/bpf_arena_common.h  |  70 +++
> >  tools/testing/selftests/bpf/bpf_arena_htab.h  | 100 ++++
> >  tools/testing/selftests/bpf/bpf_arena_list.h  |  92 +++
> >  .../testing/selftests/bpf/bpf_experimental.h  |  43 ++
> >  .../selftests/bpf/prog_tests/arena_htab.c     |  88 +++
> >  .../selftests/bpf/prog_tests/arena_list.c     |  68 +++
> >  .../selftests/bpf/prog_tests/verifier.c       |   2 +
> >  .../testing/selftests/bpf/progs/arena_htab.c  |  48 ++
> >  .../selftests/bpf/progs/arena_htab_asm.c      |   5 +
> >  .../testing/selftests/bpf/progs/arena_list.c  |  87 +++
> >  .../selftests/bpf/progs/verifier_arena.c      | 146 +++++
> >  tools/testing/selftests/bpf/test_loader.c     |   9 +-
> >  37 files changed, 2028 insertions(+), 40 deletions(-)
> >  create mode 100644 kernel/bpf/arena.c
> >  create mode 100644 tools/testing/selftests/bpf/bpf_arena_alloc.h
> >  create mode 100644 tools/testing/selftests/bpf/bpf_arena_common.h
> >  create mode 100644 tools/testing/selftests/bpf/bpf_arena_htab.h
> >  create mode 100644 tools/testing/selftests/bpf/bpf_arena_list.h
> >  create mode 100644 tools/testing/selftests/bpf/prog_tests/arena_htab.c
> >  create mode 100644 tools/testing/selftests/bpf/prog_tests/arena_list.c
> >  create mode 100644 tools/testing/selftests/bpf/progs/arena_htab.c
> >  create mode 100644 tools/testing/selftests/bpf/progs/arena_htab_asm.c
> >  create mode 100644 tools/testing/selftests/bpf/progs/arena_list.c
> >  create mode 100644 tools/testing/selftests/bpf/progs/verifier_arena.c
> >
> > --
> > 2.43.0
> >
>
> Besides a few comments on patch #1 (and maybe one or two potential
> corner case issues I mentioned, which can be easily fixed),
> the series
> looked good. So I've applied patches as is. I fixed typo ("varaibles")
> in one of the commit subjects while applying.

Thanks! That subj typo survived two months of reviews in v1,v2,v3 and
I swear I use ./scripts/checkpatch.pl --codespell all the time.
I guess it got drowned in all of the messages like:
WARNING: 'mmaped' may be misspelled - perhaps 'mapped'?
#356: FILE: tools/lib/bpf/libbpf.c:13666:
+            *mmaped =3D map->mmaped;
              ^^^^^^

WARNING: 'mmaped' may be misspelled - perhaps 'mapped'?
#356: FILE: tools/lib/bpf/libbpf.c:13666:
+            *mmaped =3D map->mmaped;
                            ^^^^^^
> Also, in one of the selftests you hard-coded PAGE_SIZE to 4096, which
> isn't correct on some architectures, so please see how you can make it
> not hard-coded (but still work for both bpf and user code). It seemed
> minor enough to not delay patches (either way those architectures
> don't support ARENA just yet).

yes. It's on todo list already.
I've added #define PAGE_SIZE 4096 to user space side of bpf selftest,
because it's used in bpf_arena_*.h code which is dual
compiled as bpf prog (and then it's using PAGE_SIZE from vmlinux.h)
and compiled as native code.
So bpf side gets correct PAGE_SIZE automatically as a nice constant
at compile time, but for user space there is no good PAGE_SIZE
constant to use.
Just doing
#define PAGE_SIZE sysconf(_SC_PAGE_SIZE)
produces inefficient code.
Hence I left it as a todo to figure out later.
