Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92DBD22CBE6
	for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 20:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776371017; cv=none; b=XOKPkH+coiPXYzosnnWimnFmgf2v3Q/AlyJEq6OX/2629gfHufCLIj4Sfei91BXxD/MQIcqv5tWFG+g7K9Xmkm49OTp4Q9Hz8Nl31tIY0LMYFOLfBuUzOuJhf9HmUsRraMKI8fLtTBKkloGdJCfWOQaQBtM42Ys5LwGZeQaYNuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776371017; c=relaxed/simple;
	bh=e12bpgLlzJSCZWEyHYvojiRIzMP3xxE7YUpfeYaNDZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ALRL8h6IBVTBvpKktEkQXBlMTy2Vmq1U7ffyMmVqolhLR9v8EtuSTfaMDGkzzIOAgtyOTBrEdiqEgoVV2mQ1uzW9Xg6B5srqTw9oIFKVlu5Naa88+H4Lo1Eh1pFU8E0MHQkmXgfqLn/Dy43Zd9mb7SM88TGqZ/t9Ey2IWajbzAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nl+KeIqh; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nl+KeIqh"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b941762394aso1064618366b.1
        for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 13:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776371014; x=1776975814; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HbkEjJKs8j/69Mz/SFuLuveshjQqfe+qKBcM51gbA7o=;
        b=nl+KeIqhDquARAgn6lgUWOyuIdb4MoWjHcFpjsOgFnxoRzr6Yy6+dOavWVoUomNI/P
         NB6zNf82yxNjHD3YxNXTZgEl+dIhBU3i8pTk+NNpAcB6aBwC9qxQZ3/KoHZNLto58TRz
         0zi+cwItcamlQ+fQzGyu1u0usmP/Jv01urPZymfXqyjEpO4UWV1PaXvA/xZowi1YfWYq
         P/dfzJis/rLPNa+wEjYtmRcJ4PKx86lEKPfDXmyNupqx4cJqD9ignOY3MIuPz5hcL+lo
         r+tZqd5CqK0eGpBSKg5nqZN05KXQRWx/67N7+yZyet65yN69iG+c35tedVDBf9lI8KS3
         zFAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776371014; x=1776975814;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HbkEjJKs8j/69Mz/SFuLuveshjQqfe+qKBcM51gbA7o=;
        b=I7lNBekT6fsW5fQXeT4T5NyYwVz7ow0ec8YLZ8GBaSNP5+jYEYRIoeDYGAII9KnOkV
         4IfPhA88jl13cTEpdld24KQbLt9qETDwh2TU/0HrK4tr873taJfzu7AULve0Fgt8uM22
         Q6j7JLtWuduiNWJnC4SWYuQ3FQJBBxRQTXrOjUzMuRHAhUQEDjErGwOw5fRiLW8JPftx
         Ztn9aHMFLD2DkaY2Vs7xYyh4LEHxso63oHa2Q6JtYJgQgU2uTBHt3j1rgbTHlSFecoSv
         y1G0vw4WT5MDTS7FT+Z+nP+/o+7gJPD7fSwFvDeM3fbfrgdUl6G51Y90QI7Oi5q/eQPq
         kWpw==
X-Gm-Message-State: AOJu0YzzBu3r1G0yrvs8U1encc59a3qDSIRv94M4dZMwWGO82cMrGIad
	hOOmJg76JpyDs0RsgOLQ5oCTdyZjOOhnu5rYnhiTD7wKj4OtbXUVT/LTVbZnYJM+cw==
X-Gm-Gg: AeBDieuNaAwgUIcNyX1arHyWywYWmVfEpNpR2IxNGoVA2o39X7fNKyplDT1CA7kWTgk
	WGTljp/vETNCY00df4zPiHuqmpBNseKWuNv8LPySmsjPyaOeUC+34/sAEkPzvUYoxRf/4gY5rsT
	fLjX1GZ+ASkeVG2MeMhPGJr4TxZoVvi+dfd7FLfsTAFcwxDFiK5JKQ2eNAgiyXp3LvX6nNTxFys
	xkhl0uxqK1180TV/8Typ4VMI9JO1nodF5jRc29SXT1J3rktYlaWvlvYRUxNB8o95ZNzIp/QlwHt
	cmODIMCcLmacnqs7fQqdMlKUWokG/LIeNtIYD6d0cAaPB72wOFKoL4c+0RzPnOcLfHRZu1mNZ5n
	b6+jxGg55hffzVpETbmJXAXnfeEm0IlDFivqmaHx07pSErr6fC09eL4lvyuCJAESU5b9u/YFBBN
	s/sfhCINBpvmS6zT5aERMH4+dixULr4eEP5a+6RR4hlo4HL2zkdq1Cq85rpsFfuhxulza4inUKf
	kKqkEXC7UYQ
X-Received: by 2002:a17:907:6094:b0:b9c:1c26:9eb with SMTP id a640c23a62f3a-ba41888265amr1885366b.10.1776371013248;
        Thu, 16 Apr 2026 13:23:33 -0700 (PDT)
Received: from google.com (57.35.34.34.bc.googleusercontent.com. [34.34.35.57])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ba17341a95esm202525166b.3.2026.04.16.13.23.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 13:23:32 -0700 (PDT)
Date: Thu, 16 Apr 2026 20:23:28 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
	memxor@gmail.com, daniel@iogearbox.net, eddyz87@gmail.com,
	song@kernel.org
Subject: Re: [PATCH bpf-next v7 0/9]  Introduce arena library and runtime
Message-ID: <aeFFQL-bOTN5dg7V@google.com>
References: <20260412174546.18684-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260412174546.18684-1-emil@etsalapatis.com>

On Sun, Apr 12, 2026 at 01:45:37PM -0400, Emil Tsalapatis wrote:
> Add a new subdirectory to tools/testing/selftests/bpf called libarena,
> along with programs useful for writing arena-based BPF code. This
> patchset adds the following:
> 
> 1) libarena, a subdirectory where arena BPF code that is generally useful
> to BPF arena programs can be easily added and tested.
> 
> 2) An ASAN runtime for BPF arena programs. BPF arenas allow for accessing
> memory after it has been freed or if it is out of bounds, making it more
> difficult to triage bugs combined to regular BPF. Use LLVM's recently added
> support for address-space based sanitization to selectively sanitize just
> the arena accesses.
> 
> 3) A buddy memory allocator that can be reused by BPF programs to handle
> memory allocation/deletion. The allocator uses the ASAN runtime to add
> address sanitization if requested.
> 
> The patch includes testing for the new allocators and ASAN features that
> can be built from the top directory using "make libarena_test" and
> "make libarena_test_asan". The generated binaries reside in libarena/.
> The patch also adds test-progs-based selftests to the codebase for the
> libarena code, so the new tests are run by ./test_progs.
> 
> The patchset has the following stucture:
> 
> 1-2: Addresses a verification failure triggered by SCALAR += PTR_TO_ARENA
> instructions.
> 
> 3-4: Minor changes to selftest headers to prepare for the introduction
> of libarena.
> 
> 5-7: Add the libarena directory and testing scaffolding, and introduce
> the ASAN runtime.
> 
> 8-9: Add the new buddy memory allocator along with self-contained and
> prog-tests-based selftests.

I haven't had an opportunity to go through this patch series just yet,
but can I just say that it excites me considerably! I've been wanting
to carve out some time to implement something exactly like this for a
very long time (since BPF arena maps were initially introduced) as I
think it's going to be incredibly valuable for BPF users moving
forward.

> Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
> 
> HISTORY
> =======
> 
> v6->v7 (https://lore.kernel.org/bpf/20260412011857.3387-1-emil@etsalapatis.com)
> - Modify patch 1 to allow operations between PTR_TO_ARENA src_reg
> and dst_reg of any type. Adjust selftests accordingly (Alexei)
> - Remove unnecessary include in patch 5 (Song)
> - Removed unused definitions/assignments in patches 8/9, update patch
>   descriptions
> 
> v5->v6 (https://lore.kernel.org/bpf/20260410163041.8063-1-emil@etsalapatis.com)
> - Fix subreg_def management for SCALAR += PTR_TO_ARENA operations (AI)
> - Add more selftests for the SCALAR += PTR_TO_ARENA patch (Sashiko)
> - Adjust fls() operation to be in line with the kernel version (Sashiko)
> - Address Sashiko selftests and debugging nits
> - Add ASAN loadN and storeN _noabort variants and associated BTF anchor
> - Remove unnecessary bit freeing of buddies during block splitting
> 
> v4->v5 (https://lore.kernel.org/bpf/20260407045730.13359-1-emil@etsalapatis.com)
> Omitting various nits and fixups.
> - Properly adjust subreg_def for scalar += ptr_to_arena calls (Sashiko)
> - Remove extraneous definition from prog_tests/arena_spin_lock.c (Song)
> - Trim extraneous comments from ASAN and buddy (Alexei)
> - Remove asan_dummy call and replace with function pointer array (Alexei)
> - Remove usersapi.h header and merge it into common.h (Alexei)
> - Replace ASAN macros with function calls (Alexei)
> - Embed buddy lock into the struct and move the buddy allocator to __arena_global
>   (Alexei)
> - Add commenting for buddy allocator constants (Alexei)
> - Add default buddy allocator directly in common.bpf.c, so that the user does
>   not need to define it.
> - Expand test harnesses to dynamically find individual selftests. Now the
>   selftests also reports each test individually (e.g., 5 entries for the
>   buddy allocator instead of 1). This brings them to par with the rest of
>   the test_progs.
> 
> v3->v4 (https://lore.kernel.org/bpf/20260403042720.18862-1-emil@etsalapatis.com)
> - Add Acks by Song to patches 1-4.
> - Expand the verifier's handling of scalar/arena operations to
>   include all 3-operand operations in Patch 1 (Alexei)
> - Add additional tests for arena/arena (allowed) and arena/pointer (not allowed)
> operations in Patch 2
> - Remove ASAN version of the library from default compilation since it requires
> LLVM 22 and up (CI)
> - Rework buddy allocator locking for clarity and add comments
> - Fix From: email to be consistent with SOB
> - Address (most) Sashiko comments
> 
> v2->v3 (https://lore.kernel.org/bpf/20260127181610.86376-1-emil@etsalapatis.com)
> Nonexhaustive due to significant patch rework.
> - Do not duplicate WRITE_ONCE macro (Mykyta, Kumar)
> - Add SPDX headers (Alexei)
> - Remove bump/stack allocators (Alexei)
> - Integrate testing with test_progs (Kumar)
> - Add short description of ASAN algorithm at the top of the file (Alexei)
> 
> v1->v2 (https://lore.kernel.org/bpf/20260122160131.2238331-1-etsal@meta.com/)
> 
> - Added missing format string argument (AI)
> - Fix outdated selftests prog name check (AI)
> - Fixed stack allocation check for segment creation (AI)
> - Fix errors in non-ASAN bump allocator selftests (AI)
> - Propagate error value from individual selftests in selftest.c
> - Removed embedded metadata from bump allocator as it was needlessly
>   complicating its behavior
> 
> 
> Emil Tsalapatis (9):
>   bpf: Allow instructions with arena source and non-arena dest registers
>   selftests/bpf: Add tests for non-arena/arena operations
>   selftests/bpf: Move bpf_arena_spin_lock.h to the top level
>   selftests/bpf: Move READ_ONCE/WRITE_ONCE macros to bpf_experimental.h
>   selftests/bpf: Add basic libarena scaffolding
>   selftests/bpf: Add arena ASAN runtime to libarena
>   selftests/bpf: Add ASAN support for libarena selftests
>   selftests/bpf: Add buddy allocator for libarena
>   selftests/bpf: Add selftests for libarena buddy allocator
> 
>  kernel/bpf/verifier.c                         |  14 +-
>  tools/testing/selftests/bpf/.gitignore        |   2 +
>  tools/testing/selftests/bpf/Makefile          |  28 +-
>  .../testing/selftests/bpf/bpf_arena_common.h  |   4 -
>  .../bpf/{progs => }/bpf_arena_spin_lock.h     |   4 +-
>  tools/testing/selftests/bpf/bpf_atomic.h      |   4 -
>  .../testing/selftests/bpf/bpf_experimental.h  |   3 +
>  tools/testing/selftests/bpf/libarena/Makefile |  77 ++
>  .../selftests/bpf/libarena/include/asan.h     | 118 +++
>  .../selftests/bpf/libarena/include/buddy.h    |  92 ++
>  .../selftests/bpf/libarena/include/common.h   |  67 ++
>  .../bpf/libarena/include/selftest_helpers.h   | 121 +++
>  .../bpf/libarena/selftests/selftest.c         | 188 ++++
>  .../libarena/selftests/st_asan_buddy.bpf.c    | 241 +++++
>  .../bpf/libarena/selftests/st_asan_common.h   |  47 +
>  .../bpf/libarena/selftests/st_buddy.bpf.c     | 208 ++++
>  .../selftests/bpf/libarena/src/asan.bpf.c     | 559 +++++++++++
>  .../selftests/bpf/libarena/src/buddy.bpf.c    | 903 ++++++++++++++++++
>  .../selftests/bpf/libarena/src/common.bpf.c   |  74 ++
>  .../bpf/prog_tests/arena_spin_lock.c          |   7 -
>  .../selftests/bpf/prog_tests/libarena.c       |  62 ++
>  .../selftests/bpf/progs/arena_spin_lock.c     |   2 +-
>  .../selftests/bpf/progs/verifier_arena.c      | 130 +++
>  23 files changed, 2934 insertions(+), 21 deletions(-)
>  rename tools/testing/selftests/bpf/{progs => }/bpf_arena_spin_lock.h (99%)
>  create mode 100644 tools/testing/selftests/bpf/libarena/Makefile
>  create mode 100644 tools/testing/selftests/bpf/libarena/include/asan.h
>  create mode 100644 tools/testing/selftests/bpf/libarena/include/buddy.h
>  create mode 100644 tools/testing/selftests/bpf/libarena/include/common.h
>  create mode 100644 tools/testing/selftests/bpf/libarena/include/selftest_helpers.h
>  create mode 100644 tools/testing/selftests/bpf/libarena/selftests/selftest.c
>  create mode 100644 tools/testing/selftests/bpf/libarena/selftests/st_asan_buddy.bpf.c
>  create mode 100644 tools/testing/selftests/bpf/libarena/selftests/st_asan_common.h
>  create mode 100644 tools/testing/selftests/bpf/libarena/selftests/st_buddy.bpf.c
>  create mode 100644 tools/testing/selftests/bpf/libarena/src/asan.bpf.c
>  create mode 100644 tools/testing/selftests/bpf/libarena/src/buddy.bpf.c
>  create mode 100644 tools/testing/selftests/bpf/libarena/src/common.bpf.c
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/libarena.c
> 
> -- 
> 2.53.0
> 
