Return-Path: <SRS0=25sv=V5=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 010ADC433FF
	for <bpf@archiver.kernel.org>; Thu,  1 Aug 2019 07:39:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFEE6206B8
	for <bpf@archiver.kernel.org>; Thu,  1 Aug 2019 07:39:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B5jtyM/7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725946AbfHAHjm (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 1 Aug 2019 03:39:42 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53912 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbfHAHjm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 1 Aug 2019 03:39:42 -0400
Received: by mail-wm1-f66.google.com with SMTP id x15so63520743wmj.3;
        Thu, 01 Aug 2019 00:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=MZEEIPgnARUyVNJPJBbjhN6MQZ0NcCMZUIjXrV1XLGA=;
        b=B5jtyM/7N7P+h7S0miHuyOMZM7DGYb6OpMk9f7hfpVqghwWupy3X2SFQ0NpoJi8+Dd
         dSliVccV8NsBYUlrbpR/wtdz3tmDEHCRii+9yHLkffn8GP08UsI+dCXZ/TsQHVk6O9nK
         7EarYIafwpnpVw7ivp3tu48EXzgWWrHGiA3DRGQ1+NKQBeaYsLQ+WAiS6JpC5PQ+HvJO
         l+i8o//qYyRAjC7t3neR64hH4j+yb2T4N7QOgNBtKRDcyKvWZzc+P106olxghaoCDtFO
         0GEPRAw61FpKWRGj85GZY3qAgM/b3Aw7NSKrO9WedSOvhRX0mSs7zD2an/96afLW8xGo
         PuOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=MZEEIPgnARUyVNJPJBbjhN6MQZ0NcCMZUIjXrV1XLGA=;
        b=fu7jxeYssZrU8NSfywoXCVDtdJav9in5N3gTvNSJmlKXyO1dpYSG4Uguc156FsGWtu
         rk+QLB9GhyY7h82vGZncTVHx3o7mnCigva6dRuxA1VYQQVy600J6DShZTPa9rX0M/5GX
         gZFNejLuxIaqwmxAuz5Aj/AxsS81w7KL0aG7+RuRERRHyGfYzHgYDJe7klWtwHA6RvCB
         RrobxAYYK/h9Pu8d0zROSh86HjfLv0EX8X6Fw83vXclxeFMj16vj6cIj1N8S56DnKvvY
         sSPStPCC21z8CvNBJ+NokxAuOlLTXS2y9Wif0MmDWlQ1BbUm33cwxPuxPaevByoGpdMn
         forw==
X-Gm-Message-State: APjAAAXRqnGRaTAcz0FYbNkcu0bqK51yY1cQdHQ4WbLXICOfg74Tpf/O
        LPqnef4B8pbr+v2vbNnbJ7/vJ6L0EH3j1urwePA=
X-Google-Smtp-Source: APXvYqwiyl4aEmnXT2kMh/UcOcVmTpEZVIF/ZiNbXJ8fHwODGWymingKX8zY6dKppxhJtVe4uhYMNCWt58WhTmGP+8g=
X-Received: by 2002:a1c:5f87:: with SMTP id t129mr120710192wmb.150.1564645179900;
 Thu, 01 Aug 2019 00:39:39 -0700 (PDT)
MIME-Version: 1.0
References: <CA+icZUWF=B_phP8eGD3v2d9jSSK6Y-N65y-T6xewZnY91vc2_Q@mail.gmail.com>
 <c2524c96-d71c-d7db-22ec-12da905dc180@fb.com>
In-Reply-To: <c2524c96-d71c-d7db-22ec-12da905dc180@fb.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Thu, 1 Aug 2019 09:39:27 +0200
Message-ID: <CA+icZUW1YQqDjFCX5Ek100SbveX0Zevr7T5gbtdpcmZD+kCuZg@mail.gmail.com>
Subject: Re: next-20190723: bpf/seccomp - systemd/journald issue?
To:     Yonghong Song <yhs@fb.com>, Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

just want to let you know that I did a git bisect with Linux v5.3-rc2
(where the problem also exists) and the result (details see [1]):

e55a73251da335873a6e87d68fb17e5aabb8978e is the first bad commit
commit e55a73251da335873a6e87d68fb17e5aabb8978e
Author: Josh Poimboeuf <jpoimboe@redhat.com>
Date:   Thu Jun 27 20:50:47 2019 -0500

    bpf: Fix ORC unwinding in non-JIT BPF code

    Objtool previously ignored ___bpf_prog_run() because it didn't understand
    the jump table.  This resulted in the ORC unwinder not being able to unwind
    through non-JIT BPF code.

    Now that objtool knows how to read jump tables, remove the whitelist and
    annotate the jump table so objtool can recognize it.

    Also add an additional "const" to the jump table definition to clarify that
    the text pointers are constant.  Otherwise GCC sets the section writable
    flag and the assembler spits out warnings.

    Fixes: d15d356887e7 ("perf/x86: Make perf callchains work without
CONFIG_FRAME_POINTER")
    Reported-by: Song Liu <songliubraving@fb.com>
    Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
    Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
    Acked-by: Alexei Starovoitov <ast@kernel.org>
    Cc: Peter Zijlstra <peterz@infradead.org>
    Cc: Kairui Song <kasong@redhat.com>
    Cc: Steven Rostedt <rostedt@goodmis.org>
    Cc: Borislav Petkov <bp@alien8.de>
    Cc: Daniel Borkmann <daniel@iogearbox.net>
    Link: https://lkml.kernel.org/r/881939122b88f32be4c374d248c09d7527a87e35.1561685471.git.jpoimboe@redhat.com
    Signed-off-by: Ingo Molnar <mingo@kernel.org>

:040000 040000 4735e9d14fa416c1c361ec3923440a3d586a627d
31de80b85c7b0292e47a719ecb6b1a451de2f8ef M      kernel

Maybe you want to look at this, too.

The object files are attached in [2].

Thanks,
- Sedat -

[0] https://github.com/ClangBuiltLinux/linux/issues/619
[1] https://github.com/ClangBuiltLinux/linux/issues/619#issuecomment-517152467
[2] https://github.com/ClangBuiltLinux/linux/issues/619#issuecomment-517159635
