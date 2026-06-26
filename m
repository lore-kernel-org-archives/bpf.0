Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACBB82E091B
	for <bpf@vger.kernel.org>; Fri, 26 Jun 2026 05:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782452673; cv=pass; b=rpTMUMgtDv7VYCtP17B9T0SX+xi/qElrIcSsQgnBg1ZYyGzBn6w2kBTOUghJapSrQpFWAnGEO8S33wZ/DsFILKORT+0li6DSu9ds0ko5TReREPpbSSoNVEVmzv2k4kUq7nvvkJpHo20pJvmLkwmV/o3UebQohCjRW15U8vaj9gI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782452673; c=relaxed/simple;
	bh=LgMCkxlnlEjf31QSKYSyLVy690adKEPdMobqywq7vJk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j6PaUdNvC/qftsJKsOLcsQvgPCg/8huifvfe95k6jQn6VwlXAr4Jp3n6PzEVqQPcSqUNyqWRGVGKldoVE8suHHtKKDhoo0qG5lno/iddYz4ytTNjdKvGQrn9mU2j5H5uDNx00rtYYbIE/UFyJbEIslDHp9Fj+jwk7ugeTC+5lzA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=coi7/387; arc=pass smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="coi7/387"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c8894560c89so230297a12.0
        for <bpf@vger.kernel.org>; Thu, 25 Jun 2026 22:44:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782452671; cv=none;
        d=google.com; s=arc-20260327;
        b=QoTnOqOehmfMvfPmiI5vMre+XoQvU4o+eXURRB0S1D7kWD31HTJKB+/6KG3UsccZ75
         0/aakj6aADnqGHS8HSg0pmZDfqwZ6qUaJ9yFBZNf3xCODfxasQtJJbHhh7s7GmrDmIe+
         6TavAYOWxYAYdzEqYH2RKUo97UJ6TFY4EDbnUzasMRSwHir0elObdylpy2to5fha23Cv
         QTjrWt84CISb5YxYiurGxbLZxw//JlWEbaOBagei7cbA3pMUJVyFUHYgjsNG1QYPBGy5
         A0zo755Yl9fHxUy8Et7PwSROzLxyxONcbaUFBt0ObDZqidQaNGB+v5/mJJcW8B7/JzFu
         OZ0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZhTrT9L75Q7te0mn0gkYVv6yY0/Erfss1oWJLr7g+Sk=;
        fh=b19RcmsiPp5pMPnFcTMuvYFCKGKYFL3E76toTRdOARY=;
        b=hguNWeSZzAfF4vkJaH4HbBFymjb5RPDDkwNowuGdxpcwhc4sI7r1ss135wbdmkCohQ
         UMDMKgrHotYyEOImZu7VMEKul9rm7mmdqjMANp4SsXeRsOT5QhmpwINAUuM/vw9ztK4d
         gIc+3/NZPMyo2K/+P3yxHZvTB4GqciUQoeASkpuLLQR6BBZqU82vfDf9jM+E5Hn0lqq0
         f8WUSyzkurZT0TXqm+h7ETnsLV6oqGnTs3olf62Nz/RFUcrKqUEFFxK5cYIS25JpBShr
         8s143HSfG4EHY4Dp4A0BXOZ+/yfDcyyYIlIhujxNK85cnv5IeKvo4v0G/cFSVBzTbnIN
         JexA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782452671; x=1783057471; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZhTrT9L75Q7te0mn0gkYVv6yY0/Erfss1oWJLr7g+Sk=;
        b=coi7/387mmH5Cfj52b57vvri0DeOf77YkaVc4k5yh8jzHAhfNdxn9xbsh2BSm3jHk7
         IMdOhNn37OE0asvijXPLr4ElkLk8r9tsajd7vlCsNpmrtwTlqZp7L5/rG+bmKkm6jiYm
         +vfT9/P8YEYH7N28KIewJ+1C2VkLd9Yi+xI3cz6WKakNeyVJt9+/HsJCgLcwgk1Hp5aI
         FXg/Dcqnwyu76AH+TbrGhVKjjh2W9cwOrh3Gg96hoP+v9Rsh5+12l68LmSmK8a9Oo6tO
         Mjdo0v2Jl3xOnyS/5m9h/TzPmVyYL2y/5X5ZLogwqazjTdWuoI5PW06lK4vnaaPcNIO6
         U+ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782452671; x=1783057471;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZhTrT9L75Q7te0mn0gkYVv6yY0/Erfss1oWJLr7g+Sk=;
        b=BslO5Vcq5oO58ro4LwzgNwqk2qrK/yl82RR5zWttI363FSo4Tb73sEtKccgkz9md7J
         p2/zSeXI/nkrcc9U018mntxUy4pu0ZrpEYdgVDhFr4exsY/i1KdSiXZu7gD/so1JSXCm
         oYCcjjJn44lzIljEBiFVFhNO/X4EHM1j/KyKEh56n8Jde2sNUBRs4ho4LEas33qZVmtf
         MGogn3OJutyco4W57RsqRLW/5H3KQSA62IZb5w7SyrqpXADhnOJCrUxxH7LPesdFfShz
         BJBmhrxYisvUEVHAi1SIiAl8ZygW0j36ba+kVg8eQE2T0tnp5OuUBdiuyVlo6ffwVLlA
         WtsQ==
X-Forwarded-Encrypted: i=1; AFNElJ91t9fTIk+h3MmdCHd025b2UGE9hqb1K/GHuMPREvsgd+MQ+pP/8h//9UzFv9UJOx34+Y8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxjyvgpw4E/seqQYyTTynbspu+hqmWjJIBxmto8FATCo11tHR89
	4T/eEka07n8qPBVZflva/RrznzzigfI9CB05dOEqRre5dTz8xeRLR0LqPxu+4CswNuI/UIYaSar
	EmA6MLYmkmOOi8m1auhU0HqA7nEagoCN0TA==
X-Gm-Gg: AfdE7cnB/cAyWUkM5/Fk1KAi9Le9gK5a5dCdmcHhL2Ji4QlsH8j1IBrJk7QcXIU7nC8
	szknnAFFMjqzKyEb3syRkT6c5+4TlVa09aTKEyNkJShsZLJasEm1g9JFNW7qGlNHFrraiWrLxiE
	UjaEoz/o3U0cF21HojjGOBR0D8UAV5CCQppDrM1ghYLmqKVtZBja76bWs+oZWC4NRp3bxNakzab
	4pcr/iwT7Z4pOQF8RzuJHoFsdg9K6APeCZsJyZozSfBP2/cGlnT37iajYRxscxy5RNqmWeiHGCf
	V98wAgqnq5egzvzDHoY7xhTMvlY+4E1nwqri9HDXtleyM9dkG3EOfw==
X-Received: by 2002:a05:6a21:6e97:b0:3b4:65ad:b417 with SMTP id
 adf61e73a8af0-3bd4af208b7mr6221165637.45.1782452670819; Thu, 25 Jun 2026
 22:44:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260526205840.173790-1-jolsa@kernel.org> <aiEiP54zktDqAZpG@krava>
 <CAEf4Bzbrd8xs5sSwEPR336=7z2FGcdXVtV-aVZ4W1zSjHkwwcg@mail.gmail.com>
In-Reply-To: <CAEf4Bzbrd8xs5sSwEPR336=7z2FGcdXVtV-aVZ4W1zSjHkwwcg@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 25 Jun 2026 22:44:18 -0700
X-Gm-Features: AVVi8CfO6esbsI6YTqzAiYGe6LSSJIEgjFKY99NhG40a9_xC6lXQfgkkPy17DAA
Message-ID: <CAEf4BzYmgj55UnBX2fRoKwtc-97vc7Sf1opWcAXzSKKLr_Ei6A@mail.gmail.com>
Subject: Re: [PATCHv4 00/13] uprobes/x86: Fix red zone issue for optimized uprobes
To: Jiri Olsa <olsajiri@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 8, 2026 at 1:48=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Jun 3, 2026 at 11:59=E2=80=AFPM Jiri Olsa <olsajiri@gmail.com> wr=
ote:
> >
> > On Tue, May 26, 2026 at 10:58:27PM +0200, Jiri Olsa wrote:
> > > hi,
> > > Andrii reported an issue with optimized uprobes [1] that can clobber
> > > redzone area with call instruction storing return address on stack
> > > where user code may keep temporary data without adjusting rsp.
> > >
> > > Fixing this by moving the optimized uprobes on top of 10-bytes nop
> > > instruction, so we can squeeze another instruction to escape the
> > > redzone area before doing the call.
> > >
> > > Note we need upstream update first for patch 3 (github.com/libbpf/usd=
t),
> > > if we decide to take this change.
> > >
> > > thanks,
> > > jirka
> > >
> > >
> > > v1: https://lore.kernel.org/bpf/20260514135342.22130-1-jolsa@kernel.o=
rg/
> > > v2: https://lore.kernel.org/bpf/20260518105957.123445-1-jolsa@kernel.=
org/
> > > v3: https://lore.kernel.org/bpf/20260521124411.31133-1-jolsa@kernel.o=
rg/
> > >
> > > v4 changes:
> > > - do not use 2nd int3 (ont +5 offset) because the call instruction
> > >   is allways the same for the given nop10 address [Andrii/Peter]
> > > - unmap unused trampoline vma after unsuccesfull optimization [sashik=
o]
> > > - small change to patch#2 moved user_64bit_mode earlier in the path
> > >   and pass/use mm_struct pointer directly from arch_uprobe_optimize
> > >   instead of gettting current->mm
> > >   Andrii, keeping your ack, please shout otherwise
> >
> > hi,
> > I think bots did not find anything substantial, I have just small
> > selftests changes queued for v5
> >
> > any other feedback/review would be great
> >
>
> one small nit on only, otherwise LGTM.
>
> Peter, Masami, Ingo, should this go through tip tree or should we
> route this through bpf-next tree? I think we are fine either way, but
> might be more convenient to route through bpf-next given libbpf and
> BPF selftest changes.
>

I'll assume that no one has any objections to route this through
bpf-next. We got reviews from Oleg, so that's great. Jiri, seems like
you will do small adjustments and send v5, please do, and then unless
meanwhile no one raises any issues, this will go through bpf-next.
Thanks!

> If so, I'd appreciate another look at first 5 patches by Peter, if
> that's ok. Thanks!
>
>
>
> > thanks,
> > jirka
> >
> >
> > >
> > > v3 changes:
> > > - use nop10 update suggested by Peter in [2]
> > > - remove struct uprobe_trampoline object, use vma objects directly in=
stead
> > > - selftests fixes [sashiko]
> > > - ack from Andrii
> > >
> > > v2 changes:
> > > - several selftest fixes [sashiko]
> > > - consolidate is_lea_insn and is_call_insn insto single check [Jakub =
Sitnicki]
> > > - use proper mm_struct object in __in_uprobe_trampoline check [sashik=
o]
> > > - allow to copy uprobe trampolines vma objects on fork [sashiko]
> > > - change uprobe syscall detection error from -ENXIO to -EPROTO [Andri=
i]
> > > - added fork/clone tests
> > > - I kept the selftest changes and nop5->nop10 changes in separate
> > >   commits for easier review, we can squash them later if we want to k=
eep
> > >   bisect working properly
> > >
> > >
> > > [1] https://lore.kernel.org/bpf/20260509003146.976844-1-andrii@kernel=
.org/
> > > [2] https://lore.kernel.org/bpf/20260518104306.GU3102624@noisy.progra=
mming.kicks-ass.net/#t
> > > ---
> > > Andrii Nakryiko (1):
> > >       selftests/bpf: Add tests for uprobe nop10 red zone clobbering
> > >
> > > Jiri Olsa (12):
> > >       uprobes/x86: Use proper mm_struct in __in_uprobe_trampoline
> > >       uprobes/x86: Remove struct uprobe_trampoline object
> > >       uprobes/x86: Allow to copy uprobe trampolines on fork
> > >       uprobes/x86: Unmap trampoline vma object in case it's unused
> > >       uprobes/x86: Move optimized uprobe from nop5 to nop10
> > >       libbpf: Change has_nop_combo to work on top of nop10
> > >       libbpf: Detect uprobe syscall with new error
> > >       selftests/bpf: Emit nop,nop10 instructions combo for x86_64 arc=
h
> > >       selftests/bpf: Change uprobe syscall tests to use nop10
> > >       selftests/bpf: Change uprobe/usdt trigger bench code to use nop=
10
> > >       selftests/bpf: Add reattach tests for uprobe syscall
> > >       selftests/bpf: Add tests for forked/cloned optimized uprobes
> > >
> > >  arch/x86/kernel/uprobes.c                               | 379 ++++++=
+++++++++++++++++++++++++++++++++++++-----------------------------
> > >  include/linux/uprobes.h                                 |   5 -
> > >  kernel/events/uprobes.c                                 |  10 --
> > >  kernel/fork.c                                           |   1 -
> > >  tools/lib/bpf/features.c                                |   4 +-
> > >  tools/lib/bpf/usdt.c                                    |  16 +--
> > >  tools/testing/selftests/bpf/bench.c                     |  20 ++--
> > >  tools/testing/selftests/bpf/benchs/bench_trigger.c      |  38 ++++--=
--
> > >  tools/testing/selftests/bpf/benchs/run_bench_uprobes.sh |   2 +-
> > >  tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c | 307 ++++++=
+++++++++++++++++++++++++++++++++++++++++++++++-----
> > >  tools/testing/selftests/bpf/prog_tests/usdt.c           |  74 ++++++=
++++++--
> > >  tools/testing/selftests/bpf/progs/test_usdt.c           |  25 +++++
> > >  tools/testing/selftests/bpf/usdt.h                      |   2 +-
> > >  tools/testing/selftests/bpf/usdt_2.c                    |  15 ++-
> > >  14 files changed, 653 insertions(+), 245 deletions(-)
