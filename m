Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95A33F23A4
	for <bpf@vger.kernel.org>; Fri,  7 Aug 2026 22:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786140358; cv=pass; b=s+Vl7Fmv9+6oU/fygmDuF6Pu3xWB7p3qe16JUiK761fZeZFfmIi4EZT6rCiXu1HaLo0nrvilZ837BE7BvrEVWmJVzDAJxwsXRn7s9UtJZjBCBW0ngMM6yEqxJREDLTaKFNNGX6Bqy+VKVJnXdhKYFwa6j8dJTRHOzYfn50hEL0c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786140358; c=relaxed/simple;
	bh=5Xb1alAmdBaaDGWYV09Au7bmdJWaXBDIFWpMj8Juass=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QZSD1PbVAIyrD9bg0+JRAxt7F0jYW4FvtAcXzxzc2Xh+gPWE9gWQ2S1EjtEVHGC/7qVbMW13FWqgORRO62XNRe/LdKVZFumE7hN6RIyA6TzkwRMimAzDWyZMqfDkJkwKycvbg+ulnm2ggZF1SrJC7vffCgGqj9RqVwuZgu55Bug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pdntbZRA; arc=pass smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pdntbZRA"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2cf50c6f235so697975ad.0
        for <bpf@vger.kernel.org>; Fri, 07 Aug 2026 15:05:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786140356; cv=none;
        d=google.com; s=arc-20260327;
        b=XXGsiBQHEE1ZZUPbgKycW9vZ9j5C6otJK9L29wX4aq6nJGNMI41jo/q+MVoROUsbwh
         U/W22NZU5WwPQmdrtCE71BKSiS6fYMLkOc6i2WvM0S4DyFr6QO02pz6JrxJtKHpZkQcg
         7lJ9hJy99AtSaStoSF7rp7jMJLxudM2PMescvPHoDlTJ+7IHIBIIw8GRtnMKHONf2iJ4
         W72OFHQov9AfsX1Z/LbYb5uNTJLU5OXsRbBff+auHb6nZuTIt24JCreqKeouJoQHPnmE
         vK1xZ2BIK3rOlAAc8Reuo5OgZDoHv3QqU6dbMCuo3gc2fgd6oEuKDqrVq0/06YHr0TKg
         QArQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oBzhlymJq0i9dB4bSmpxHcz5q4k4mmAVB1xGwvA6mww=;
        fh=iw7+rQzlbDI58pgaP3Ojwlw8x3F/yp+Z3O6odXgNeYk=;
        b=NChalku6mTqZdzaNvnoH0WntDCrCt145WAQyKOzRqO+tSjUfHtVqNkrwpJiZYQ3dFv
         4/X5ToimfiWX0TSiC0/cKCAIz+PetX6rm9h7iJgfQ4UTScjCpqSiVQtrelVt5/60U8dC
         BsnSW97BHiQjQUZcqlnTaF1+fk1T83NvaoTwwGXO8EhGkZNSVwOdciXRk6tPEt69ZFPI
         A+qYvwuacGzywEqkLWtwm2yqoFY3HwES9pGtKRIrG8QO9NYOi7Zzord8eehFJlHYhJMy
         8EzlvfNuz9AfeIA2/rxZmTLPOoMKzr0/S93WDrvU67mP47yFJCoXvDwCBiJhu1mMbNIZ
         BlEQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786140356; x=1786745156; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oBzhlymJq0i9dB4bSmpxHcz5q4k4mmAVB1xGwvA6mww=;
        b=pdntbZRA0xBCVDlEDZpZPbMU519P/iojA+DvJfIHq2zubXFJRNHZb222GGslorPI54
         Z7FPbbpHxiy63se3kX9ZXgUhbyh4wtAjcVxkDCM3a+Dts68+NgUuQODU/gAfLAjyMWr/
         mxDvgWDI5qWwU6luLhYy1OJINXtUJeLjDBjLNWepjbQqEYPRNrQYhIOYG6c16ZY/uCD4
         IkLk41DG5/RKBiFS+wUyIbSNF7pdiJl1ySS5uOmJgDnY02zOvSHZ2rN9XrxJivDA9Cgs
         3y/vC5WPyLfhvdkj5bIhbyZN2DFgjI3JcJ2hDn9hQh9ybDeD/1fjgUA5N6+gm+YZ4awY
         LnuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786140356; x=1786745156;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oBzhlymJq0i9dB4bSmpxHcz5q4k4mmAVB1xGwvA6mww=;
        b=aCzDUAd0zXMEvFL3V+RvnVPewJ4l1F/3bTBQl2TA1DVrzD9RmiouQTnYcTbPgLzBVm
         a91tcdZfrT36+S3049WR0+ohlY9wuj/CoCXU6HpwnWCKMKfGrid6cTRM52A+2cbPd17t
         WNNaN5IFeNG2BAmMohI1Nmdsr+4VCfauo0uJ0OmjGI4OFwVr6JdUA6eD34EYZJZaiTp6
         Czc59/ZjFapyGT+u8IaZKQH/0IznJNenfA0w/QG907FbXwCndsG8rSI0iX36zWLVAPuJ
         sraC+oQGTFoBDKLvb1ncwRUsX8d5fVcPJX8wW5kVk54hwnsgDyddbYPQ5tLRz1K6GRVl
         A4og==
X-Gm-Message-State: AOJu0Yy8ZCDMSXxMa5dtDUpMCX/bB5VkUWT3Dj8pPXmVApf6VWDltXZ9
	A0UrTINZjNaseei+PhEBdlullgxucD23C9g7HSS96UMgIktsyuhMS3SFHMTeOp0N1Ag10dY27vp
	h73Q+QCGcgqR1CtA6Kx3Vqe5m9fzjyzw=
X-Gm-Gg: AR+sD13wH55H2geiGh8WMXC4kChAypybe7iFu/w7fa8c8nkNUfSy3PEiaax2JJkEFXh
	yulQqsFBp90Xz/njjGEH9IvcOrq6RW4q6i+EmNASUTqySjKMTsunieNidi9gcXbXfTAIliPmhmr
	Qf79NiJcgPK1fnqA4RiXJir3J6+jYXjVfJ4KL5tzNY776LfZU09MkE1W9gq4ZpFAI6LmlPFRn/F
	BVfu55SOdVTmQxT46HLjTJdAwnlr/MahersI+Ry7vQ2IKftH241KfKsjWCpdhM5mqlfO2Z1NJqX
	KN1kUmPHSCzU3jlN9Y8D/8YiXZiIl4os/Sr6hv+ZKD4Gck3xOm395PAsgVLXAPq1e2WDD5RTG0q
	lT1rPWJLI2KUEN8Sa5cMWF0P/qzUfTUTD0ma6x2nZXw==
X-Received: by 2002:a17:90b:4e8d:b0:38d:ec31:4840 with SMTP id
 98e67ed59e1d1-3903c5932femr27829359a91.13.1786140356051; Fri, 07 Aug 2026
 15:05:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260805011517.1717238-1-memxor@gmail.com>
In-Reply-To: <20260805011517.1717238-1-memxor@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 7 Aug 2026 15:05:42 -0700
X-Gm-Features: AUfX_myEbKoJT8EKlPR47sJxFg9N0TvSOAcAAZPX1iJbe7_F9c-qTPEM9XPCHY4
Message-ID: <CAEf4Bza1FG8ZYZyKWpzpjp24uQ+EtS6RuGQp+a6WichJH+3-2A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 0/6] Improve stack depth verification stats output
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Eduard Zingerman <eddyz87@gmail.com>, Emil Tsalapatis <emil@etsalapatis.com>, kkd@meta.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 4, 2026 at 6:15=E2=80=AFPM Kumar Kartikeya Dwivedi <memxor@gmai=
l.com> wrote:
>
> Some improvements for more clarity in the stack depth verification
> statistics output. See commit logs for details.
>
> For example, ./test_progs -t subprogs/subprogs_alone loads prog4,
> which has a main program, two static subprograms, and two independently
> verified global subprograms. A sample run produces:
>
>   verification time 1765 usec
>   stack depth max 48
>   subprog 0 (prog4) main insns_own 29 insns_total 51 stack 8

even though insn_own was my proposal, reading this I immediately went
"insns_self"! :) I think self is a better term, sorry

but other than that, this is great!

>   subprog 1 (get_task_tgid) global insns_own 9 insns_total 9 stack 8
>   subprog 2 (sub4) static insns_own 15 insns_total 22 stack 8
>   subprog 3 (sub3) static insns_own 7 insns_total 7 stack 0
>   subprog 4 (sub1) global insns_own 10 insns_total 10 stack 8
>   processed 70 insns (limit 1000000) max_states_per_insn 0 total_states 7=
 peak_states 7 mark_read 0
>
> The insns_own counts account for every processed instruction exactly once=
:
>
>   29 + 9 + 15 + 7 + 10 =3D 70
>
> The main program and global subprograms are independent exploration roots=
,
> so their insns_total counts also account for the full processed budget:
>
>   51 + 9 + 10 =3D 70
>
> Static subprogram totals provide a nested, top-down breakdown inside thei=
r
> root. In this example:
>
>   sub4: 22 =3D 15 own + 7 in sub3
>   prog4: 51 =3D 29 own + 22 in sub4
>
> The global subprogram bodies are accounted in their own root totals rathe=
r
> than being included in prog4 or the static callees which call them.
>
> Asynchronous callback work is propagated through every scheduling subprog=
ram
> in a nested callback chain. Running:
>
>   ./test_progs -t verifier_subprog_insn_stats/stats_async_nested -v
>
> produces the following stats:
>
>   stack depth max 0
>   subprog 0 (stats_async_nested) main insns_own 9 insns_total 23 stack 0
>   subprog 1 (stats_async_nested_leaf) static insns_own 2 insns_total 2 st=
ack 0
>   subprog 2 (stats_async_outer) static insns_own 6 insns_total 8 stack 0
>   subprog 3 (stats_async_nested_schedule) static insns_own 6 insns_total =
14 stack 0
>   processed 23 insns
>
> Here, 9 + 2 + 6 + 6 =3D 23. The nested callback work is propagated
> bottom-up through both scheduling subprograms:
>
>   stats_async_outer: 8 =3D 6 own + 2 in stats_async_nested_leaf
>   stats_async_nested_schedule: 14 =3D 6 own + 8 in stats_async_outer
>   stats_async_nested: 23 =3D 9 own + 14 in stats_async_nested_schedule
>
> Changelog:
> ----------
> v5 -> v6
> v5: https://lore.kernel.org/bpf/20260804081114.3871564-1-memxor@gmail.com
>
>  * Track own and inclusive instruction counts for main, global, and stati=
c
>    subprograms. (Andrii, Eduard)
>  * Keep instruction subtotals path-local across verifier state copies.
>  * Propagate async callback budget through nested scheduling chains. (And=
rii)
>  * Split per-subprogram instruction accounting into a preparatory patch.
>  * Add deterministic selftests with exact own, total, and processed count=
s.
>
> v4 -> v5
> v4: https://lore.kernel.org/bpf/20260803072733.191502-1-memxor@gmail.com
>
>  * Change the format to combine instruction counts and stack depths into
>    per-program records. (Andrii)
>  * Adjust veristat for the new format while retaining support for the leg=
acy format.
>  * Explain why the legacy stack parsing buffer is zero-initialized. (BPF =
CI Bot)
>
> v3 -> v4
> v3: https://lore.kernel.org/bpf/20260803031457.3115812-1-memxor@gmail.com
>
>  * Read names from subprog_info directly to avoid an out-of-bounds access
>    when func_info validation fails. (BPF CI Bot)
>
> v2 -> v3
> v2: https://lore.kernel.org/bpf/20260802225209.2511758-1-memxor@gmail.com
>
>  * Reuse subprog_name() to fetch subprogram names. (BPF CI Bot)
>
> v1 -> v2
> v1: https://lore.kernel.org/bpf/20260801230400.850271-1-memxor@gmail.com
>
>  * Use multi-line format. (Eduard)
>  * Adjust veristat to work with old and new format.
>  * Adjust selftest log_level without new option. (Eduard)
>
> Kumar Kartikeya Dwivedi (6):
>   bpf: Track verifier instruction stats for each subprogram
>   bpf: Propagate async callback instructions to scheduling subprograms
>   bpf: Show more useful info in stack depth stats
>   selftests/bpf: Adjust veristat stack depth parsing
>   selftests/bpf: Test stack depth stats without BTF subprog names
>   selftests/bpf: Test subprogram instruction statistics
>
>  include/linux/bpf_verifier.h                  |   7 +-
>  kernel/bpf/verifier.c                         |  88 +++++--
>  .../selftests/bpf/prog_tests/verifier.c       |   2 +
>  .../bpf/progs/verifier_basic_stack.c          |   8 +-
>  .../bpf/progs/verifier_bpf_fastcall.c         |  38 ++-
>  .../bpf/progs/verifier_global_subprogs.c      |   6 +-
>  .../bpf/progs/verifier_private_stack.c        |  22 +-
>  .../bpf/progs/verifier_subprog_insn_stats.c   | 225 ++++++++++++++++++
>  .../selftests/bpf/progs/verifier_var_off.c    |   8 +-
>  tools/testing/selftests/bpf/test_verifier.c   |   2 +-
>  tools/testing/selftests/bpf/verifier/calls.c  |  12 +-
>  tools/testing/selftests/bpf/veristat.c        |  16 +-
>  12 files changed, 395 insertions(+), 39 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/progs/verifier_subprog_in=
sn_stats.c
>
>
> base-commit: 6655c409707ec8ce9ce0850ffe4fe02331fd4d9c
> --
> 2.53.0
>
