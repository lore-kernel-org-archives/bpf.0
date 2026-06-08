Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9CC392C4A
	for <bpf@vger.kernel.org>; Mon,  8 Jun 2026 20:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780951753; cv=pass; b=iglOUMigz9uUZUvYcJTlKHr/eMXyh32Qbv3YE+NLwnMc67QeGkr4dYVhUyf5ssUVnBHFXXlejKSoATZOafdRDZe66PnjfrGipe382X/6jnvNAmPJmAz19Hgx8xr8XvLxOZ4aNnUe0q1nHugxwgF9se9E2EcfwEM/0wI9tDqcDGc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780951753; c=relaxed/simple;
	bh=mqw2OrB4l7ryqRoi0JsPC1biAGfzHf38qCJAbRmuB+U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z0z0fKjzea2QMxEcR9+rV7HFrQgyDvaaPlImE/aou3JIswNqS0QnPX75BpZ7cw2meH8ycjX5tBmx6RXJQLs0uidXxqo2aTtv22vYh+Ibr6LKGtJAmukThtl5ZcigQVO7HYf8AhPjDe8g+5PF/egQiso9skB1RyBm2Gdkhhbw+FU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WiXPxBsO; arc=pass smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WiXPxBsO"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-36da8439078so4217298a91.2
        for <bpf@vger.kernel.org>; Mon, 08 Jun 2026 13:49:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780951750; cv=none;
        d=google.com; s=arc-20240605;
        b=RaSYNV7Tx7GBERRarMcY3dciD7ye0vnS3huvfAUF1BDaEtTY2EckKVPsVETRHxZrIJ
         yQLBaxYp1y7aCYCAHfd0J2t1WDX5ksQdLCpeJy0k9Iy6YO6rOAyfyKU2hLSRrGfD0bSP
         h6vtUyD4s8LHlGiyPw+dYRN3lrVKJEb9NDVZptO/qNY1yv0eZMPa+I3zkw5gxtExdeTt
         sIdxCplqBjRO/qkmtjNShPF4k6BsSqr9XR0L5MOM6lDXMh/59crGiqxkbftjiV2RwBgj
         VrzVJIBRzMT3QkNPYcF6oFSR2c6R+Lxxi8DDfeSPpgRubpmBPy9xkQHvx3VuaPzTtaXB
         kuXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=szcQRKKYkYYaFVP42s66uUUsYAUfyJsuIUeX1ksEXwA=;
        fh=JG5AkB+JIu52pJ5Y6D6J3MSrAlnvNgynHfJ5nEGTi+U=;
        b=PVg7edzyxJlGzvy4JR9WRfV+9u2g9bjNKYAwD6IZWTi7pL0FElkEIUUzJMndyczFA0
         lViKtHq9KFZ789Ns4y7WQUiiVyrmjE/Z/9nCBNZpl6cEOQcOdkpHQG76CDlxiH6pa7dc
         TrpzY42R3OexY1HNtpZ3Uda5PM9rZ5n/L4+nOfwPtMLNjLFdqnG+zpdP1aO2GD5j8MMH
         6oDnphP2Yps8eKQnzh3wvglMK5YlhQryWzpeBr9EERRmzs4JkYSN3NxJpw9bptkRNtK+
         1zQ1ZbjtysSTEWlqpS1b+4ovOi96KJGz2+dy2EWjuh1uACx5UUhMMgjVZhP8oU9TGk+F
         gc6Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780951750; x=1781556550; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=szcQRKKYkYYaFVP42s66uUUsYAUfyJsuIUeX1ksEXwA=;
        b=WiXPxBsOpuWgrCjCeMlGEsIooX1nPU0qOSQDX1pQX6jUvEMrbCypazfzir7e8hAinI
         UBka2LtWotYfpdw/V1+NFwyJ2EDKPq9qeMixW5SkYRAhR4+mKEddQPvFK+UgzU+iD8bo
         nzbNFWPM9A6fl4s2BvKEG1e7AZtuYpPzKCpnqvpuW60Kq1Bd1EB0LMS0+XxFzFIzedC4
         M46UptFlA1ocUvob6xEOSExONzPxXUroO3dyIE49wwgaNAa2BtvrJECWGI+CgzBFFyXO
         1Wy0ZmnlBZIFVdTrahZ2IoLPM3so7kJHe9QXa6epI51//9XBtdUSupdNQdy1WbBUGvYX
         gBVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780951750; x=1781556550;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=szcQRKKYkYYaFVP42s66uUUsYAUfyJsuIUeX1ksEXwA=;
        b=FeYHsvh33YILpDJXTFIVnLvATFtQ5Y5r09IbBHvWVkTe16U8KudKUrA/N5rhfru0vr
         5uTEMjPZbXwM8vrca7TM3mI+BgB1/KNj8BUGcsACoIJ88jw/Tt76gqCiDRrZbZ+B4INa
         j44UDFaowXcylhLxv5TJj84xGkaZPdiU3hLj+b1SXMAGsFvwpxneOgHOaDdCnRKPNxEZ
         TSMctMdmHc8InKawayNGul4mxjklKXL0qJkZTXSzoSqOs+8V//bL+H91xQMdFOa5tQZ5
         x9nj5UCltQ3awZPLxjki2WMv0WUBOIHkLZif/4drsnmC6An04gA0ra4EWqAkdg38lxaL
         4gjA==
X-Forwarded-Encrypted: i=1; AFNElJ/QM0MAZeBvNBXoqcHDhbnTtyVMUGGsHm/a/4gWiIA6OfkOD/PPxNcCzFC3I8Px1Vcirlc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzphd1qOoFRzRh60TG+G3MFJQOyre9RiA3UiMf67xWhZxXmj8KT
	c3qmTFuRHnzjbKbcAihWsodU6O9rxX6MJEYmzmMotxp/AX54m3348ZiqlthvEGXpiCnerVLFEfT
	3zZ+Znv08bugUXDzbwyglqcQyimw/7FI=
X-Gm-Gg: Acq92OHhWCJ29qdGyeg61Vp7BYSg8l8gM1po15Z5VGiv7caZmdapweE0iJkrD7Ev7AD
	onnZfLJXhGawy/mD5kQQv+bVzxc8MgGDmUJw0IGvDROUr9B9dDfF9jNyf5CZPLNLy+59g3CbrAy
	RK2ac3Udw62eVyUyVyFQWFYjL88wFMv64PiZkyf+6z9ElkbepIMKYJd0rayQiGKQlEzFVt9W81v
	NYZtdKVkHk8iw2ppJnfKmXPfg7lRJ8s3AIbCyFNA5NAvvgB0Yr0UnfTKBPMscYhceI8zXxYupDq
	8EZZCc+KvYeAwUWdAJqDdFIJaxezf5z/9DgCPy6hSHNbVX8yN5ApomGDprOAfXYzUM85mdv3h6J
	vuenWYha3rt5qaHhrdCcU5P2wNA==
X-Received: by 2002:a17:90b:3bcb:b0:367:cb53:7435 with SMTP id
 98e67ed59e1d1-370f1525ed1mr16914932a91.24.1780951750236; Mon, 08 Jun 2026
 13:49:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260526205840.173790-1-jolsa@kernel.org> <aiEiP54zktDqAZpG@krava>
In-Reply-To: <aiEiP54zktDqAZpG@krava>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 8 Jun 2026 13:48:54 -0700
X-Gm-Features: AVVi8CcxWz4v5RpKgGDZlxpIi02CKmV66vQtWBFlpZJuRHPawXW7c-U_nKUu48I
Message-ID: <CAEf4Bzbrd8xs5sSwEPR336=7z2FGcdXVtV-aVZ4W1zSjHkwwcg@mail.gmail.com>
Subject: Re: [PATCHv4 00/13] uprobes/x86: Fix red zone issue for optimized uprobes
To: Jiri Olsa <olsajiri@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 3, 2026 at 11:59=E2=80=AFPM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
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
> > Note we need upstream update first for patch 3 (github.com/libbpf/usdt)=
,
> > if we decide to take this change.
> >
> > thanks,
> > jirka
> >
> >
> > v1: https://lore.kernel.org/bpf/20260514135342.22130-1-jolsa@kernel.org=
/
> > v2: https://lore.kernel.org/bpf/20260518105957.123445-1-jolsa@kernel.or=
g/
> > v3: https://lore.kernel.org/bpf/20260521124411.31133-1-jolsa@kernel.org=
/
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

one small nit on only, otherwise LGTM.

Peter, Masami, Ingo, should this go through tip tree or should we
route this through bpf-next tree? I think we are fine either way, but
might be more convenient to route through bpf-next given libbpf and
BPF selftest changes.

If so, I'd appreciate another look at first 5 patches by Peter, if
that's ok. Thanks!



> thanks,
> jirka
>
>
> >
> > v3 changes:
> > - use nop10 update suggested by Peter in [2]
> > - remove struct uprobe_trampoline object, use vma objects directly inst=
ead
> > - selftests fixes [sashiko]
> > - ack from Andrii
> >
> > v2 changes:
> > - several selftest fixes [sashiko]
> > - consolidate is_lea_insn and is_call_insn insto single check [Jakub Si=
tnicki]
> > - use proper mm_struct object in __in_uprobe_trampoline check [sashiko]
> > - allow to copy uprobe trampolines vma objects on fork [sashiko]
> > - change uprobe syscall detection error from -ENXIO to -EPROTO [Andrii]
> > - added fork/clone tests
> > - I kept the selftest changes and nop5->nop10 changes in separate
> >   commits for easier review, we can squash them later if we want to kee=
p
> >   bisect working properly
> >
> >
> > [1] https://lore.kernel.org/bpf/20260509003146.976844-1-andrii@kernel.o=
rg/
> > [2] https://lore.kernel.org/bpf/20260518104306.GU3102624@noisy.programm=
ing.kicks-ass.net/#t
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
> >  arch/x86/kernel/uprobes.c                               | 379 ++++++++=
+++++++++++++++++++++++++++++++++++-----------------------------
> >  include/linux/uprobes.h                                 |   5 -
> >  kernel/events/uprobes.c                                 |  10 --
> >  kernel/fork.c                                           |   1 -
> >  tools/lib/bpf/features.c                                |   4 +-
> >  tools/lib/bpf/usdt.c                                    |  16 +--
> >  tools/testing/selftests/bpf/bench.c                     |  20 ++--
> >  tools/testing/selftests/bpf/benchs/bench_trigger.c      |  38 ++++----
> >  tools/testing/selftests/bpf/benchs/run_bench_uprobes.sh |   2 +-
> >  tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c | 307 ++++++++=
+++++++++++++++++++++++++++++++++++++++++++++-----
> >  tools/testing/selftests/bpf/prog_tests/usdt.c           |  74 ++++++++=
++++--
> >  tools/testing/selftests/bpf/progs/test_usdt.c           |  25 +++++
> >  tools/testing/selftests/bpf/usdt.h                      |   2 +-
> >  tools/testing/selftests/bpf/usdt_2.c                    |  15 ++-
> >  14 files changed, 653 insertions(+), 245 deletions(-)
