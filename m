Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F9D2C11FE
	for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 20:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776371506; cv=none; b=pe0xNC2OFamirgN8DjhFKI8sLvxSyMBX1BeD1BukFCOuhPOO3nOsyHv/dL03ufuPLjk1J+9mwtnTnn4bYh8zJylfPYWHd/DCWk/rCCO0wfvar4YBB1vUOjwdSwkutwY/YECseP/IfEo8ag6R/iBzRy4osEs0XDIbQ8Cnv6wTkXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776371506; c=relaxed/simple;
	bh=cJkTr2uHhR4iw2BR7Lu4QXhKVR6uWOJXsmizF815Hr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s6RdTMRLPC+t6r0g3qDYa+/eQmCQo7UicE0/JAHpbqewO4FBDMmAcd6rzAIhGD6cDoXIxZBGzOZIyxk3Z221V9AEyxWeofjKPt/Y0K5TDvgFpMKAEk1ribnTpAt0ZJscOKnQAPfgb1wsH0WkhVYChdzV49AKwODmmwBw4DfjJIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tDuWNoMd; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tDuWNoMd"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-671a2f4fd28so7202971a12.3
        for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 13:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776371503; x=1776976303; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=q/Ixr3Wkn5LXYiGAdVY2EFGdgUtjaHEr0djHwqnIRqs=;
        b=tDuWNoMdNuAjLTA7mImfFB6aEVyTT8n28gdIZifNJu79H6h0a724Xba7Jf+FlJGABR
         +Bv/2P5maB7WjQOe2ypMOUF65nB3KKXfMTqp0yybRdyeXDmR/IfQge/ZFheZjZnU4tFb
         X/FuMyVpbv05abRUpYEa+I+ZHlSwJQjhkGxX41qsY3LyWjDcqoNyPE7MsTjz6/LE8k1L
         czo8knFjdx78NSJEin/rYSWyaLBer8+xMfC8UOhes9/iLbIdfMITaOw0pDvzshrxAIZf
         2AsHuqB2SiP71BncNWiS0WllJJt7eo0zSn3O+N/9GLSTil46oN/94r3x2U69DB6cjRH1
         XdlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776371503; x=1776976303;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q/Ixr3Wkn5LXYiGAdVY2EFGdgUtjaHEr0djHwqnIRqs=;
        b=jJl5S+MpjLLKp91astmwE6Z88/zLjnh5cNLBTNt4rYQqEnfYuH/uRHdQJCc6E5946a
         iqGmCs/Jqj3QQI0uu/bc00x0N4dqq9ywnwY3HzahL7pfCtgPC3W/na5tikgCQ3v9I9Ft
         pmIDDZJXGZXvrWsj0G1rdFsGRD8W5ERkXAApiaDSqaPSmqdPwhAo1a6LG0zCesACWcFP
         iG0ZC94cCsKdvrJPuVXAYzsUQlMPuTSnLRf5gy9PHN6L+hvsXfhnmLmsekQ1kPZzvMz4
         ATjClCOsQswYKOhxdXnoSLER0Tj7Z4LE0h48DJ218ZZdMIUgShaIHoUHjkkXqeBn1+kb
         rEGQ==
X-Gm-Message-State: AOJu0YztFkhU52dxox5VKLqvhX8ozP2cu3Q3hfxZeUJyQ+y2uv4Ga/z9
	mGVnq4bnD0NDgufUM9yAc211IXgZFeA2vBiXtEBy5W2qYitUAiIMIiX6dpVt/YE+Tw==
X-Gm-Gg: AeBDievGSBWZthViJF9yLbKitNnkV7dI8SbU2Y9JbzQRXz68Z9qhjI9uR7DkhYvmPG0
	IodPFzIKeWe+QAv3jybXCsarxLl/i/O5oSN8mUQdEQzWaNqxdVm++Q9fI8MYpqmkJRz+bMtxqP9
	HgFqJ14JMXiMwVdIfjiw1W78DlGSwdc2jtOEbaZOeYytMb+HelZ/ejkkB6UPn+0IS+81vSuVzo+
	2FaEnAgSst9KHItHt/BvQ2mjCJ2u1+k1Zd1BXSKPQO/lHd73eYw251hlwROrbDDcfDHPB1ICDkk
	Hn5QIj+/Or7ewGFURjWi3p6O1dFLbEYepNGxOP2JVZsu/SwVqK/wQKxjXmnObH1+jzjWk+a4ntY
	MS1uhnV9vtHI/pJMUjd27EEul39y9t50liUpXtBthsErDOog5eCtEVByJlNXEIzV4+8VOa/36H6
	d3ngmwkrkhGoveOhRQxnk0NoMF/q4GjotGFbs8ITxKoMfTYNy0ZXfmv1eF8AIO4+zn1V4Ikc+kp
	wxcSqOcrhd5
X-Received: by 2002:a17:907:d28:b0:b9b:e346:9a7d with SMTP id a640c23a62f3a-ba41a91a6e0mr1877466b.35.1776371502464;
        Thu, 16 Apr 2026 13:31:42 -0700 (PDT)
Received: from google.com (57.35.34.34.bc.googleusercontent.com. [34.34.35.57])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ba17341bdf6sm198369066b.1.2026.04.16.13.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 13:31:41 -0700 (PDT)
Date: Thu, 16 Apr 2026 20:31:37 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
	memxor@gmail.com, daniel@iogearbox.net, eddyz87@gmail.com,
	song@kernel.org
Subject: Re: [PATCH bpf-next v7 0/9]  Introduce arena library and runtime
Message-ID: <aeFHKUsf86jw1v9W@google.com>
References: <20260412174546.18684-1-emil@etsalapatis.com>
 <aeFFQL-bOTN5dg7V@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aeFFQL-bOTN5dg7V@google.com>

On Thu, Apr 16, 2026 at 08:23:28PM +0000, Matt Bobrowski wrote:
> On Sun, Apr 12, 2026 at 01:45:37PM -0400, Emil Tsalapatis wrote:
> > Add a new subdirectory to tools/testing/selftests/bpf called libarena,
> > along with programs useful for writing arena-based BPF code. This
> > patchset adds the following:
> > 
> > 1) libarena, a subdirectory where arena BPF code that is generally useful
> > to BPF arena programs can be easily added and tested.
> > 
> > 2) An ASAN runtime for BPF arena programs. BPF arenas allow for accessing
> > memory after it has been freed or if it is out of bounds, making it more
> > difficult to triage bugs combined to regular BPF. Use LLVM's recently added
> > support for address-space based sanitization to selectively sanitize just
> > the arena accesses.
> > 
> > 3) A buddy memory allocator that can be reused by BPF programs to handle
> > memory allocation/deletion. The allocator uses the ASAN runtime to add
> > address sanitization if requested.
> > 
> > The patch includes testing for the new allocators and ASAN features that
> > can be built from the top directory using "make libarena_test" and
> > "make libarena_test_asan". The generated binaries reside in libarena/.
> > The patch also adds test-progs-based selftests to the codebase for the
> > libarena code, so the new tests are run by ./test_progs.
> > 
> > The patchset has the following stucture:
> > 
> > 1-2: Addresses a verification failure triggered by SCALAR += PTR_TO_ARENA
> > instructions.
> > 
> > 3-4: Minor changes to selftest headers to prepare for the introduction
> > of libarena.
> > 
> > 5-7: Add the libarena directory and testing scaffolding, and introduce
> > the ASAN runtime.
> > 
> > 8-9: Add the new buddy memory allocator along with self-contained and
> > prog-tests-based selftests.
> 
> I haven't had an opportunity to go through this patch series just yet,
> but can I just say that it excites me considerably! I've been wanting
> to carve out some time to implement something exactly like this for a
> very long time (since BPF arena maps were initially introduced) as I
> think it's going to be incredibly valuable for BPF users moving
> forward.

I swear that I also saw a notification stating that this series was
applied to bpf/bpf-next.git (master), but upon checking I only see
that commit 4c5f21d4dfa ("selftests/bpf: Add tests for non-arena/arena
operations") from the series was applied. What's going on there?

> > Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
> > 
> > HISTORY
> > =======
> > 
> > v6->v7 (https://lore.kernel.org/bpf/20260412011857.3387-1-emil@etsalapatis.com)
> > - Modify patch 1 to allow operations between PTR_TO_ARENA src_reg
> > and dst_reg of any type. Adjust selftests accordingly (Alexei)
> > - Remove unnecessary include in patch 5 (Song)
> > - Removed unused definitions/assignments in patches 8/9, update patch
> >   descriptions
> > 
> > v5->v6 (https://lore.kernel.org/bpf/20260410163041.8063-1-emil@etsalapatis.com)
> > - Fix subreg_def management for SCALAR += PTR_TO_ARENA operations (AI)
> > - Add more selftests for the SCALAR += PTR_TO_ARENA patch (Sashiko)
> > - Adjust fls() operation to be in line with the kernel version (Sashiko)
> > - Address Sashiko selftests and debugging nits
> > - Add ASAN loadN and storeN _noabort variants and associated BTF anchor
> > - Remove unnecessary bit freeing of buddies during block splitting
> > 
> > v4->v5 (https://lore.kernel.org/bpf/20260407045730.13359-1-emil@etsalapatis.com)
> > Omitting various nits and fixups.
> > - Properly adjust subreg_def for scalar += ptr_to_arena calls (Sashiko)
> > - Remove extraneous definition from prog_tests/arena_spin_lock.c (Song)
> > - Trim extraneous comments from ASAN and buddy (Alexei)
> > - Remove asan_dummy call and replace with function pointer array (Alexei)
> > - Remove usersapi.h header and merge it into common.h (Alexei)
> > - Replace ASAN macros with function calls (Alexei)
> > - Embed buddy lock into the struct and move the buddy allocator to __arena_global
> >   (Alexei)
> > - Add commenting for buddy allocator constants (Alexei)
> > - Add default buddy allocator directly in common.bpf.c, so that the user does
> >   not need to define it.
> > - Expand test harnesses to dynamically find individual selftests. Now the
> >   selftests also reports each test individually (e.g., 5 entries for the
> >   buddy allocator instead of 1). This brings them to par with the rest of
> >   the test_progs.
> > 
> > v3->v4 (https://lore.kernel.org/bpf/20260403042720.18862-1-emil@etsalapatis.com)
> > - Add Acks by Song to patches 1-4.
> > - Expand the verifier's handling of scalar/arena operations to
> >   include all 3-operand operations in Patch 1 (Alexei)
> > - Add additional tests for arena/arena (allowed) and arena/pointer (not allowed)
> > operations in Patch 2
> > - Remove ASAN version of the library from default compilation since it requires
> > LLVM 22 and up (CI)
> > - Rework buddy allocator locking for clarity and add comments
> > - Fix From: email to be consistent with SOB
> > - Address (most) Sashiko comments
> > 
> > v2->v3 (https://lore.kernel.org/bpf/20260127181610.86376-1-emil@etsalapatis.com)
> > Nonexhaustive due to significant patch rework.
> > - Do not duplicate WRITE_ONCE macro (Mykyta, Kumar)
> > - Add SPDX headers (Alexei)
> > - Remove bump/stack allocators (Alexei)
> > - Integrate testing with test_progs (Kumar)
> > - Add short description of ASAN algorithm at the top of the file (Alexei)
> > 
> > v1->v2 (https://lore.kernel.org/bpf/20260122160131.2238331-1-etsal@meta.com/)
> > 
> > - Added missing format string argument (AI)
> > - Fix outdated selftests prog name check (AI)
> > - Fixed stack allocation check for segment creation (AI)
> > - Fix errors in non-ASAN bump allocator selftests (AI)
> > - Propagate error value from individual selftests in selftest.c
> > - Removed embedded metadata from bump allocator as it was needlessly
> >   complicating its behavior
> > 
> > 
> > Emil Tsalapatis (9):
> >   bpf: Allow instructions with arena source and non-arena dest registers
> >   selftests/bpf: Add tests for non-arena/arena operations
> >   selftests/bpf: Move bpf_arena_spin_lock.h to the top level
> >   selftests/bpf: Move READ_ONCE/WRITE_ONCE macros to bpf_experimental.h
> >   selftests/bpf: Add basic libarena scaffolding
> >   selftests/bpf: Add arena ASAN runtime to libarena
> >   selftests/bpf: Add ASAN support for libarena selftests
> >   selftests/bpf: Add buddy allocator for libarena
> >   selftests/bpf: Add selftests for libarena buddy allocator
> > 
> >  kernel/bpf/verifier.c                         |  14 +-
> >  tools/testing/selftests/bpf/.gitignore        |   2 +
> >  tools/testing/selftests/bpf/Makefile          |  28 +-
> >  .../testing/selftests/bpf/bpf_arena_common.h  |   4 -
> >  .../bpf/{progs => }/bpf_arena_spin_lock.h     |   4 +-
> >  tools/testing/selftests/bpf/bpf_atomic.h      |   4 -
> >  .../testing/selftests/bpf/bpf_experimental.h  |   3 +
> >  tools/testing/selftests/bpf/libarena/Makefile |  77 ++
> >  .../selftests/bpf/libarena/include/asan.h     | 118 +++
> >  .../selftests/bpf/libarena/include/buddy.h    |  92 ++
> >  .../selftests/bpf/libarena/include/common.h   |  67 ++
> >  .../bpf/libarena/include/selftest_helpers.h   | 121 +++
> >  .../bpf/libarena/selftests/selftest.c         | 188 ++++
> >  .../libarena/selftests/st_asan_buddy.bpf.c    | 241 +++++
> >  .../bpf/libarena/selftests/st_asan_common.h   |  47 +
> >  .../bpf/libarena/selftests/st_buddy.bpf.c     | 208 ++++
> >  .../selftests/bpf/libarena/src/asan.bpf.c     | 559 +++++++++++
> >  .../selftests/bpf/libarena/src/buddy.bpf.c    | 903 ++++++++++++++++++
> >  .../selftests/bpf/libarena/src/common.bpf.c   |  74 ++
> >  .../bpf/prog_tests/arena_spin_lock.c          |   7 -
> >  .../selftests/bpf/prog_tests/libarena.c       |  62 ++
> >  .../selftests/bpf/progs/arena_spin_lock.c     |   2 +-
> >  .../selftests/bpf/progs/verifier_arena.c      | 130 +++
> >  23 files changed, 2934 insertions(+), 21 deletions(-)
> >  rename tools/testing/selftests/bpf/{progs => }/bpf_arena_spin_lock.h (99%)
> >  create mode 100644 tools/testing/selftests/bpf/libarena/Makefile
> >  create mode 100644 tools/testing/selftests/bpf/libarena/include/asan.h
> >  create mode 100644 tools/testing/selftests/bpf/libarena/include/buddy.h
> >  create mode 100644 tools/testing/selftests/bpf/libarena/include/common.h
> >  create mode 100644 tools/testing/selftests/bpf/libarena/include/selftest_helpers.h
> >  create mode 100644 tools/testing/selftests/bpf/libarena/selftests/selftest.c
> >  create mode 100644 tools/testing/selftests/bpf/libarena/selftests/st_asan_buddy.bpf.c
> >  create mode 100644 tools/testing/selftests/bpf/libarena/selftests/st_asan_common.h
> >  create mode 100644 tools/testing/selftests/bpf/libarena/selftests/st_buddy.bpf.c
> >  create mode 100644 tools/testing/selftests/bpf/libarena/src/asan.bpf.c
> >  create mode 100644 tools/testing/selftests/bpf/libarena/src/buddy.bpf.c
> >  create mode 100644 tools/testing/selftests/bpf/libarena/src/common.bpf.c
> >  create mode 100644 tools/testing/selftests/bpf/prog_tests/libarena.c
> > 
> > -- 
> > 2.53.0
> > 
