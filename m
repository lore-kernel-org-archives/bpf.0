Return-Path: <SRS0=/Hy+=DC=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D869C4346E
	for <bpf@archiver.kernel.org>; Fri, 25 Sep 2020 01:55:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB84420866
	for <bpf@archiver.kernel.org>; Fri, 25 Sep 2020 01:55:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EaJ7/a4c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbgIYBzO (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 24 Sep 2020 21:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726704AbgIYBzO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 24 Sep 2020 21:55:14 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83621C0613D3;
        Thu, 24 Sep 2020 18:55:14 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id o25so1213465pgm.0;
        Thu, 24 Sep 2020 18:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pmx4C1dtZyNzbTWCnrUjbiV406vdOj+1T8GPghm2QwE=;
        b=EaJ7/a4c9WtkliGh/DYbqOiH80G4RWNyo2KqWBHF0u1jetk6xKJXfcrYWFUGdwGk9N
         cko/6jOLwFKwJOAD9xtOFOubNsleb4AEbwj/GwcJrca5RA1dBVr64JyqQTnQmI2m2h73
         o2PCzDXhPuV7i20KVacKica5fsdMyP2fe7GIcNoogYDeAcHyqUZn5UVqpZt5TQhvxvmS
         UZMuhIR80F2ucDe5XnG7Hasm6aOv93CFFxxzuiKA26UqDj/34S5t9bTmCKtFA7wTLtRI
         4cPdoyx46+T1Aa0c5N5TvODHar29fZ+mDfAb23T+yk7ya5HL93xcS0TUqJQCedGFdDxw
         s5fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pmx4C1dtZyNzbTWCnrUjbiV406vdOj+1T8GPghm2QwE=;
        b=dQf4eBzSMm1aE+QAWdWzBBGJZk/vmeyRP3wanlJuaykfrSdkI/P/VF3PnyEoNcDgLl
         u4ywsMgcT6QVfpE2kFFE2uq9hFI/Ti5BgUtO0mchacsIQpomEOXjSW/07q/JW05emsub
         5phm5n5T3qlx2MDpKJZrkC0BEqOc3cWklf2Bm0C+hVS+GaWCtuhv12HKE5UVubTL27e5
         NwoF8mWbx0XHTA68Riskz89p9yZnrjlzYTN+A3N0hSpGarq5LkFdYogV28V1WQuhmRP5
         V1XUGCrc5JEi6GC+VvVVGpTKLRE1tec9MI+SKiW0HWkTZnrbdYXu7CSZ08w7hRrwvSNg
         Ygvg==
X-Gm-Message-State: AOAM532cgrHv3VM+NM7cgcmM8r9Viz+FeMgbhgVO2vur1vNJChipai5e
        p13UDSxqHo2/2f1BkqdW1uO4wHygbODrCYHhNVk=
X-Google-Smtp-Source: ABdhPJx3ucWbmrm7/0i2a6Fm4liKGVkgl0Fvznjg5vw5jSbIBsA3/utS5x5k2GxvLbWKtN2O/YrGlJU0pZ3jmX+pLCk=
X-Received: by 2002:a63:511d:: with SMTP id f29mr1603013pgb.11.1600998913975;
 Thu, 24 Sep 2020 18:55:13 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1600951211.git.yifeifz2@illinois.edu> <64052a5b81d5dacd63efb577c1d99e6f98e69702.1600951211.git.yifeifz2@illinois.edu>
 <202009241640.7E3C54CF@keescook>
In-Reply-To: <202009241640.7E3C54CF@keescook>
From:   YiFei Zhu <zhuyifei1999@gmail.com>
Date:   Thu, 24 Sep 2020 20:55:03 -0500
Message-ID: <CABqSeAS1wmCL8gRW+atNO0ZBe0JTzUcbQAR6n461AwhCotNVZg@mail.gmail.com>
Subject: Re: [PATCH v2 seccomp 4/6] seccomp/cache: Lookup syscall allowlist
 for fast path
To:     Kees Cook <keescook@chromium.org>
Cc:     Linux Containers <containers@lists.linux-foundation.org>,
        YiFei Zhu <yifeifz2@illinois.edu>, bpf <bpf@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Dimitrios Skarlatos <dskarlat@cs.cmu.edu>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        Jack Chen <jianyan2@illinois.edu>,
        Jann Horn <jannh@google.com>,
        Josep Torrellas <torrella@illinois.edu>,
        Tianyin Xu <tyxu@illinois.edu>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Tycho Andersen <tycho@tycho.pizza>,
        Valentin Rothberg <vrothber@redhat.com>,
        Will Drewry <wad@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Sep 24, 2020 at 6:46 PM Kees Cook <keescook@chromium.org> wrote:
> This protects us from x32 (i.e. syscall_nr will have 0x40000000 bit
> set), but given the effort needed to support compat, I think supporting
> x32 isn't much more. (Though again, I note that NR_syscalls differs in
> size, so this test needs to be per-arch and obviously after
> arch-discovery.)
>
> That said, if it really does turn out that x32 is literally the only
> architecture doing these shenanigans (and I suspect not, given the MIPS
> case), okay, fine, I'll give in. :) You and Jann both seem to think this
> isn't worth it.

MIPS has the sparse syscall shenanigans... idek how that works. Maybe
someone can clarify?

> I think this linear search for the matching arch can be made O(1) (this
> is what I was trying to do in v1: we can map all possible combos to a
> distinct bitmap, so there is just math and lookup rather than a linear
> compare search. In the one-arch case, it can also be easily collapsed
> into a no-op (though my v1 didn't do this correctly).

I remember yours was:

static inline u8 seccomp_get_arch(u32 syscall_arch, u32 syscall_nr)
{
[...]
        switch (syscall_arch) {
        case SECCOMP_ARCH:
                seccomp_arch = SECCOMP_ARCH_IS_NATIVE;
                break;
#ifdef CONFIG_COMPAT
        case SECCOMP_ARCH_COMPAT:
                seccomp_arch = SECCOMP_ARCH_IS_COMPAT;
                break;
#endif
        default:
                seccomp_arch = SECCOMP_ARCH_IS_UNKNOWN;
        }

What I'm relying on here is that the compiler will unroll the loop.
How does the compiler perform switch statements? I was imagining it
would be similar, with "case" corresponding to a compare on the
immediate, and the assign as a move to a register, and break
corresponding to a jump. this would also be O(n) to the number of
arches. Yes, compilers can also do an O(1) table lookup, but that is
nonsensical here -- the arch numbers occupy the MSBs.

That said, does O(1) or O(n) matter here? Given that n is at most 3
you might as well consider it a constant.

Also, does "collapse in one arch case" actually worth it? Given that
there's a likely(), and the other side is a WARN_ON_ONCE(), the
compiler will layout the likely path in the fast path and branch
prediction will be in our favor, right?

YiFei Zhu
