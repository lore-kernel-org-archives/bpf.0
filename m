Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7C358220
	for <bpf@vger.kernel.org>; Mon, 11 Mar 2024 22:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710197125; cv=none; b=B+TlGJSLRACt1v3/NhvUiRRpcHv0Yl6ESkuV2+qu4ZHXJKeuZT2dQX+sTv+FxnZ9OWf40d9/mZdTkyRUt1pQEhA/WR89jVENWAzQ+/I4Q4aAeIhvtpTdoBvGeVgJKcbDI7HKZoAyRlkAZ0MN0fYLPyKF2nNO1JUaATwausezvWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710197125; c=relaxed/simple;
	bh=x6yJDlIkttf9PBAbUZ1ZwoR5ZpGZGDZF11pp+z8gYao=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rSppB+jKUnODHBdmRL6G6rvvR0fRtC35kfmmEEwItZDc61UocRjNwoFn9xoMY4V7COknujibRfe0Z2Y6j/42lNMHmE87eEn+PID1tHa3kOEdssoj+Ejg6YxXyPJNZjLlGdyTnE2rJvJNXeL2R3aJ8abWT1hTk08n+z1nnUD69Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uhr9K6cS; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uhr9K6cS"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-29b70bf6c58so2815416a91.0
        for <bpf@vger.kernel.org>; Mon, 11 Mar 2024 15:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710197123; x=1710801923; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8NaRF1UcYNKuVhmQKcLCX1HToQxH2gsLpAwn60nGP6Y=;
        b=Uhr9K6cSg16hW3lwchuWUgEQ6m0eNEW20iykYR9S9Nwm4i9Py3/z1C3AosZ1JoV2dZ
         WTQCBQ2ZLQxG54BB8WFCaOHOFWJuFM5jFlIZq50BZBi9sl1zYYX+snGJaEHfCN+y7jJK
         +apzpmOTFefEybisnxbLm0gq6e8OYTeG/f+V1TG2/Uqr0/smuJqrEC8uW7ryqCCKqqAi
         zvCK61WP9UG+LAnPVmx6iQY1aHzvuf5Pzhy0sgDA2mf2oinUCSJ7jieyQI88xt531c3q
         SnG9hL+Rxx0ptPZe3k/dT3tLTP7FIXhad9T+8Z9evLuu8JJpSkAZI52W8SkJURt+mV9Q
         cLgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710197123; x=1710801923;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8NaRF1UcYNKuVhmQKcLCX1HToQxH2gsLpAwn60nGP6Y=;
        b=qqnXSMPBdAH5eusVxB+A7l10ZvwC+/XNeL5sl+P+r9ckMkuil4FHWvjNYc8UEjS/TE
         ISCL9UMuQ8sLspNpAVhz8hqe5M41RWKIjkGB+lbRCvxuByZVrmYJ8uDsZ3xgTmK+FdHC
         3zKr1PvWheX3r0V2KPNG4/S52CydMhk8Aefo/BSQoEQtEAIazYBmqWVPx2WQbbnjg8Lz
         3OgLKnA7CjWHP6wlNEK6plLkkagbi1hg/LKhAePbWapuveh+I8a1Rro/UcGGyo1aqHUY
         vr5kWGJJa/W5I38C+2vzRLkDXnLBNxjhOp3fMfZ0jMMEzlge2nv5LQDJWatrHRuPwCNp
         9JUA==
X-Gm-Message-State: AOJu0YwGoR35r4tlcJCZwfXCxXUvq7Pp309ItgLnZ9pkVzuMF6A6yXQe
	HjS6xiaeX8a825X+Sjz3uIufdJu9YwAaoGucv/zoZTNgdaKZVl62lhcJKrpn2Jjb6QTD3z6ua+R
	SpdhLBp3gPyQ3AID5jg0G2aYlvdY=
X-Google-Smtp-Source: AGHT+IE0pigo0eTF3sH/ZoUUgemSf4u92krF+Owg5ehe/czZnB7utxH+KS4cwh228NwrYjDluyxxN+6cVqpDgfZpNkM=
X-Received: by 2002:a17:90a:d249:b0:29b:c3a5:1909 with SMTP id
 o9-20020a17090ad24900b0029bc3a51909mr6174769pjw.7.1710197122625; Mon, 11 Mar
 2024 15:45:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240308010812.89848-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20240308010812.89848-1-alexei.starovoitov@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 11 Mar 2024 15:45:10 -0700
Message-ID: <CAEf4Bzauehm0_jYBYCLXORF_Ff3m5N3h720OK0eMJfD6kSFyaw@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 00/14] bpf: Introduce BPF arena.
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	torvalds@linux-foundation.org, brho@google.com, hannes@cmpxchg.org, 
	akpm@linux-foundation.org, urezki@gmail.com, hch@infradead.org, 
	linux-mm@kvack.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 7, 2024 at 5:08=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> From: Alexei Starovoitov <ast@kernel.org>
>
> v2->v3:
> - contains bpf bits only, but cc-ing past audience for continuity
> - since prerequisite patches landed, this series focus on the main
>   functionality of bpf_arena.
> - adopted Andrii's approach to support arena in libbpf.
> - simplified LLVM support. Instead of two instructions it's now only one.
> - switched to cond_break (instead of open coded iters) in selftests
> - implemented several follow-ups that will be sent after this set
>   . remember first IP and bpf insn that faulted in arena.
>     report to user space via bpftool
>   . copy paste and tweak glob_match() aka mini-regex as a selftests/bpf
> - see patch 1 for detailed description of bpf_arena
>
> v1->v2:
> - Improved commit log with reasons for using vmap_pages_range() in arena.
>   Thanks to Johannes
> - Added support for __arena global variables in bpf programs
> - Fixed race conditions spotted by Barret
> - Fixed wrap32 issue spotted by Barret
> - Fixed bpf_map_mmap_sz() the way Andrii suggested
>
> The work on bpf_arena was inspired by Barret's work:
> https://github.com/google/ghost-userspace/blob/main/lib/queue.bpf.h
> that implements queues, lists and AVL trees completely as bpf programs
> using giant bpf array map and integer indices instead of pointers.
> bpf_arena is a sparse array that allows to use normal C pointers to
> build such data structures. Last few patches implement page_frag
> allocator, link list and hash table as bpf programs.
>
> v1:
> bpf programs have multiple options to communicate with user space:
> - Various ring buffers (perf, ftrace, bpf): The data is streamed
>   unidirectionally from bpf to user space.
> - Hash map: The bpf program populates elements, and user space consumes
>   them via bpf syscall.
> - mmap()-ed array map: Libbpf creates an array map that is directly
>   accessed by the bpf program and mmap-ed to user space. It's the fastest
>   way. Its disadvantage is that memory for the whole array is reserved at
>   the start.
>
> Alexei Starovoitov (13):
>   bpf: Introduce bpf_arena.
>   bpf: Disasm support for addr_space_cast instruction.
>   bpf: Add x86-64 JIT support for PROBE_MEM32 pseudo instructions.
>   bpf: Add x86-64 JIT support for bpf_addr_space_cast instruction.
>   bpf: Recognize addr_space_cast instruction in the verifier.
>   bpf: Recognize btf_decl_tag("arg:arena") as PTR_TO_ARENA.
>   libbpf: Add __arg_arena to bpf_helpers.h
>   libbpf: Add support for bpf_arena.
>   bpftool: Recognize arena map type
>   bpf: Add helper macro bpf_addr_space_cast()
>   selftests/bpf: Add unit tests for bpf_arena_alloc/free_pages
>   selftests/bpf: Add bpf_arena_list test.
>   selftests/bpf: Add bpf_arena_htab test.
>
> Andrii Nakryiko (1):
>   libbpf: Recognize __arena global varaibles.
>
>  arch/x86/net/bpf_jit_comp.c                   | 231 +++++++-
>  include/linux/bpf.h                           |  10 +-
>  include/linux/bpf_types.h                     |   1 +
>  include/linux/bpf_verifier.h                  |   1 +
>  include/linux/filter.h                        |   4 +
>  include/uapi/linux/bpf.h                      |  14 +
>  kernel/bpf/Makefile                           |   3 +
>  kernel/bpf/arena.c                            | 558 ++++++++++++++++++
>  kernel/bpf/btf.c                              |  19 +-
>  kernel/bpf/core.c                             |  16 +
>  kernel/bpf/disasm.c                           |  10 +
>  kernel/bpf/log.c                              |   3 +
>  kernel/bpf/syscall.c                          |  42 ++
>  kernel/bpf/verifier.c                         | 123 +++-
>  .../bpf/bpftool/Documentation/bpftool-map.rst |   2 +-
>  tools/bpf/bpftool/gen.c                       |  13 +
>  tools/bpf/bpftool/map.c                       |   2 +-
>  tools/include/uapi/linux/bpf.h                |  14 +
>  tools/lib/bpf/bpf_helpers.h                   |   1 +
>  tools/lib/bpf/libbpf.c                        | 163 ++++-
>  tools/lib/bpf/libbpf.h                        |   2 +-
>  tools/lib/bpf/libbpf_probes.c                 |   7 +
>  tools/testing/selftests/bpf/DENYLIST.aarch64  |   2 +
>  tools/testing/selftests/bpf/DENYLIST.s390x    |   2 +
>  tools/testing/selftests/bpf/bpf_arena_alloc.h |  67 +++
>  .../testing/selftests/bpf/bpf_arena_common.h  |  70 +++
>  tools/testing/selftests/bpf/bpf_arena_htab.h  | 100 ++++
>  tools/testing/selftests/bpf/bpf_arena_list.h  |  92 +++
>  .../testing/selftests/bpf/bpf_experimental.h  |  43 ++
>  .../selftests/bpf/prog_tests/arena_htab.c     |  88 +++
>  .../selftests/bpf/prog_tests/arena_list.c     |  68 +++
>  .../selftests/bpf/prog_tests/verifier.c       |   2 +
>  .../testing/selftests/bpf/progs/arena_htab.c  |  48 ++
>  .../selftests/bpf/progs/arena_htab_asm.c      |   5 +
>  .../testing/selftests/bpf/progs/arena_list.c  |  87 +++
>  .../selftests/bpf/progs/verifier_arena.c      | 146 +++++
>  tools/testing/selftests/bpf/test_loader.c     |   9 +-
>  37 files changed, 2028 insertions(+), 40 deletions(-)
>  create mode 100644 kernel/bpf/arena.c
>  create mode 100644 tools/testing/selftests/bpf/bpf_arena_alloc.h
>  create mode 100644 tools/testing/selftests/bpf/bpf_arena_common.h
>  create mode 100644 tools/testing/selftests/bpf/bpf_arena_htab.h
>  create mode 100644 tools/testing/selftests/bpf/bpf_arena_list.h
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/arena_htab.c
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/arena_list.c
>  create mode 100644 tools/testing/selftests/bpf/progs/arena_htab.c
>  create mode 100644 tools/testing/selftests/bpf/progs/arena_htab_asm.c
>  create mode 100644 tools/testing/selftests/bpf/progs/arena_list.c
>  create mode 100644 tools/testing/selftests/bpf/progs/verifier_arena.c
>
> --
> 2.43.0
>

Besides a few comments on patch #1 (and maybe one or two potential
corner case issues I mentioned, which can be easily fixed), the series
looked good. So I've applied patches as is. I fixed typo ("varaibles")
in one of the commit subjects while applying.

Also, in one of the selftests you hard-coded PAGE_SIZE to 4096, which
isn't correct on some architectures, so please see how you can make it
not hard-coded (but still work for both bpf and user code). It seemed
minor enough to not delay patches (either way those architectures
don't support ARENA just yet).
