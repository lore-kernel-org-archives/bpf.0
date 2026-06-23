Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881E7208D0
	for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 19:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782241876; cv=none; b=LTAWrJl+AdZuOQa/dTY/2vTkWAF9N63Ud95u1jSBMJAx0hdjcHfTprsOcaZYSJYkLPKQ7F0Mt6RacDiaVh3SbbHUiVfScPEKzmfsAQIPocj6alVigODzE9BXT/fkyGMXDKe5/c6QXJnYdHZ0a4mdAl91pWlUsAqAwV38+dJkAh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782241876; c=relaxed/simple;
	bh=ak2Pag302wzIU6JvetlLqwWRWhBzDXIm/3d0p/6xjDU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XrU21Bd3nzrGitokrd8Mcuu90hNhHprqn2XfxoOdyWcic9ufq/aip5l1PIjD55dsYNs1DTJxyAVPXjUt0rYagnOFkjcVab/GAjlb9NiDRvLhH9odtGWW6FsffSfSvQ8zBVJ3Z59YVm2xXNW4VZctwphKeP8Awr7WZr06PWtASXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jJOpDK8E; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jJOpDK8E"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-4629d80fa08so218497f8f.3
        for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 12:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782241873; x=1782846673; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6oU+L9zQu/aklDl++k+2cg0xhcWLV/5t/SZwmgE+09o=;
        b=jJOpDK8EoGAYU1uOUQB/YMRlIjyQYQX7RLUzFQZYY+CWml4gsOtNDVdcuQjDpvGqbQ
         BJBv8GoWxP2hX0JDB1M4c7axMl/ujLM8tMF24wJpyUv9LGvJep0IYdi/b34cfa1duCZW
         2tWp9+3kdQzbFV1ek3/7c5QgkNtMwAFnn3vfnJG/ia92EEPH79YtcflCpwyVHIQ2cXsT
         IkvA++yjnt7/1a0lD0rdmyXXuHCYm6H2FeHFqkzFa7wlWSI2QIe9A5oQKxqBgo9CaWfp
         SeaGw4KEneVgf7kmgu24fA+d2lfxcv7Qyr7GzkEC7iFPWp3vOBizjGDIjwQBmvKzr3H0
         x50A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782241873; x=1782846673;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6oU+L9zQu/aklDl++k+2cg0xhcWLV/5t/SZwmgE+09o=;
        b=i7wTSI8jlDXFKWp2eGilu8HWW/B61UoCo0WyUYxHju8E4yyW2QhR4Y/GSGgNtokhav
         cnPNxuW7KQggiHQbqIDNL+VIWAA7hDm9bbaa8ujL0qLmjEFMfn0VjS3HG9H3BIO28NkK
         PcoJm3qlZrkgSOpNgGWr9Tf3MjyLY9ba60bMtpO8CnA7TdfYpQcChcveUffp8D5F02Y4
         uLpCXRebC6B53F3dv8nuCro+OT7sKA567wEXFEVOXY3o57PbQr/g9QVA33+jh8LHlOMc
         G7D7J85L+M/sAq1UT5Uw2g/xmzRc3LuXhGlcZvp86p/y5JSP4BhTOD/Tpf8pmgZPIVTg
         waHQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr5SCo0+ZgtXNQ5uWFZR4rC59/ygsQ6d68OYb2ALos0+uajfpmMwfRtjqzV8m7emtPw6Fc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/cuxWPO0KnMJp6rGn/+DiediFkD/aYbpQq0obvqu9F58/qRFH
	h3QijMu+xaEef6AC+oDMjeJ+32lBnm5eJyH3geH7L2zVTMpzaBTVNZqK
X-Gm-Gg: AfdE7clBc/o2ODED4TRVCUEBVQojuvD+FHNdKE8o42pkvFGoMp/Vrgy6/98qaJN6cuo
	/Iy7MYMVt7fznlq3MYmSapWvwBskSxrYH4J8s32FHI9syP9LtX6QckpGEDJTQIXyDjzYKlg/GlK
	w8cWRNkzM7Y7FuXwPSCMwk/e4A4OR2n2btA5zbA1MAaqUdFHi1yRf/JXS1NE3OdT+r0YwJ0z5wr
	moZ+AsgquxKnWpDdgF1XpAW5JCNPSIcaczPlzMlhvc0+Tr4AKvxQXGmDZ/MQxU8fYy/SOr3f3nC
	h4cO3yjE6Qc7uymNCf3I10gFUn1LNkgkZrgjcJSb7xZqmLn4+Be0zJCQz9d291Qfe3pp/2IFpeB
	A0PhulRK/WEh4mX8LkdSs3hOy2CGEuS6GBIbG6cPN9hGF7bMM3QiD9Xu8wFbOd/nxMhqDLVYdH4
	2r
X-Received: by 2002:a05:6000:2209:b0:46a:8fab:ec6f with SMTP id ffacd0b85a97d-46c04a365damr367834f8f.4.1782241872756;
        Tue, 23 Jun 2026 12:11:12 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46666c57afasm39639063f8f.29.2026.06.23.12.11.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 12:11:12 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 23 Jun 2026 21:11:11 +0200
To: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>
Cc: Jiri Olsa <olsajiri@gmail.com>, Ingo Molnar <mingo@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCHv4 00/13] uprobes/x86: Fix red zone issue for optimized
 uprobes
Message-ID: <ajraT7xBqcKa83fy@krava>
References: <20260526205840.173790-1-jolsa@kernel.org>
 <aiEiP54zktDqAZpG@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aiEiP54zktDqAZpG@krava>

hi, ping, thanks

jirka


On Thu, Jun 04, 2026 at 08:59:11AM +0200, Jiri Olsa wrote:
> On Tue, May 26, 2026 at 10:58:27PM +0200, Jiri Olsa wrote:
> > hi,
> > Andrii reported an issue with optimized uprobes [1] that can clobber
> > redzone area with call instruction storing return address on stack
> > where user code may keep temporary data without adjusting rsp.
> > 
> > Fixing this by moving the optimized uprobes on top of 10-bytes nop
> > instruction, so we can squeeze another instruction to escape the
> > redzone area before doing the call.
> > 
> > Note we need upstream update first for patch 3 (github.com/libbpf/usdt),
> > if we decide to take this change.
> > 
> > thanks,
> > jirka
> > 
> > 
> > v1: https://lore.kernel.org/bpf/20260514135342.22130-1-jolsa@kernel.org/
> > v2: https://lore.kernel.org/bpf/20260518105957.123445-1-jolsa@kernel.org/
> > v3: https://lore.kernel.org/bpf/20260521124411.31133-1-jolsa@kernel.org/
> > 
> > v4 changes:
> > - do not use 2nd int3 (ont +5 offset) because the call instruction
> >   is allways the same for the given nop10 address [Andrii/Peter]
> > - unmap unused trampoline vma after unsuccesfull optimization [sashiko]
> > - small change to patch#2 moved user_64bit_mode earlier in the path
> >   and pass/use mm_struct pointer directly from arch_uprobe_optimize
> >   instead of gettting current->mm
> >   Andrii, keeping your ack, please shout otherwise
> 
> hi,
> I think bots did not find anything substantial, I have just small
> selftests changes queued for v5
> 
> any other feedback/review would be great
> 
> thanks,
> jirka
> 
> 
> > 
> > v3 changes:
> > - use nop10 update suggested by Peter in [2]
> > - remove struct uprobe_trampoline object, use vma objects directly instead
> > - selftests fixes [sashiko]
> > - ack from Andrii
> > 
> > v2 changes:
> > - several selftest fixes [sashiko]
> > - consolidate is_lea_insn and is_call_insn insto single check [Jakub Sitnicki]
> > - use proper mm_struct object in __in_uprobe_trampoline check [sashiko]
> > - allow to copy uprobe trampolines vma objects on fork [sashiko]
> > - change uprobe syscall detection error from -ENXIO to -EPROTO [Andrii]
> > - added fork/clone tests
> > - I kept the selftest changes and nop5->nop10 changes in separate
> >   commits for easier review, we can squash them later if we want to keep
> >   bisect working properly
> > 
> > 
> > [1] https://lore.kernel.org/bpf/20260509003146.976844-1-andrii@kernel.org/
> > [2] https://lore.kernel.org/bpf/20260518104306.GU3102624@noisy.programming.kicks-ass.net/#t
> > ---
> > Andrii Nakryiko (1):
> >       selftests/bpf: Add tests for uprobe nop10 red zone clobbering
> > 
> > Jiri Olsa (12):
> >       uprobes/x86: Use proper mm_struct in __in_uprobe_trampoline
> >       uprobes/x86: Remove struct uprobe_trampoline object
> >       uprobes/x86: Allow to copy uprobe trampolines on fork
> >       uprobes/x86: Unmap trampoline vma object in case it's unused
> >       uprobes/x86: Move optimized uprobe from nop5 to nop10
> >       libbpf: Change has_nop_combo to work on top of nop10
> >       libbpf: Detect uprobe syscall with new error
> >       selftests/bpf: Emit nop,nop10 instructions combo for x86_64 arch
> >       selftests/bpf: Change uprobe syscall tests to use nop10
> >       selftests/bpf: Change uprobe/usdt trigger bench code to use nop10
> >       selftests/bpf: Add reattach tests for uprobe syscall
> >       selftests/bpf: Add tests for forked/cloned optimized uprobes
> > 
> >  arch/x86/kernel/uprobes.c                               | 379 +++++++++++++++++++++++++++++++++++++++++++-----------------------------
> >  include/linux/uprobes.h                                 |   5 -
> >  kernel/events/uprobes.c                                 |  10 --
> >  kernel/fork.c                                           |   1 -
> >  tools/lib/bpf/features.c                                |   4 +-
> >  tools/lib/bpf/usdt.c                                    |  16 +--
> >  tools/testing/selftests/bpf/bench.c                     |  20 ++--
> >  tools/testing/selftests/bpf/benchs/bench_trigger.c      |  38 ++++----
> >  tools/testing/selftests/bpf/benchs/run_bench_uprobes.sh |   2 +-
> >  tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c | 307 +++++++++++++++++++++++++++++++++++++++++++++++++++++-----
> >  tools/testing/selftests/bpf/prog_tests/usdt.c           |  74 ++++++++++++--
> >  tools/testing/selftests/bpf/progs/test_usdt.c           |  25 +++++
> >  tools/testing/selftests/bpf/usdt.h                      |   2 +-
> >  tools/testing/selftests/bpf/usdt_2.c                    |  15 ++-
> >  14 files changed, 653 insertions(+), 245 deletions(-)
