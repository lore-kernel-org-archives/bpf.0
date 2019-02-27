Return-Path: <SRS0=P9GS=RC=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C916DC00319
	for <bpf@archiver.kernel.org>; Wed, 27 Feb 2019 22:43:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 893982133D
	for <bpf@archiver.kernel.org>; Wed, 27 Feb 2019 22:43:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FoJmyTbr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730254AbfB0WnA (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 27 Feb 2019 17:43:00 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:40125 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729412AbfB0WnA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 27 Feb 2019 17:43:00 -0500
Received: by mail-it1-f195.google.com with SMTP id l139so10551791ita.5;
        Wed, 27 Feb 2019 14:42:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W5sli1yFUrBl9ZS6IgmfWyh0MoFuHh/omhrW77OGzlM=;
        b=FoJmyTbrnoy282NyQNaiMhnrROalpBFwSnHERwVFOW3TmsN0QLeuYWFQpjy9ddiGn9
         nfT9slybPAeLuZX1d9rddTIdUeyoy/0ayFz7TMmGzjhyHMiVM8zo5q04O2zArdHbK6FN
         T/PMG8DSp5UEef323VQlFj1k6VX7ifJYcqePsiWqfUL0ady4KXc38I/crtRmnJsiFI1S
         Jp2rdzttTglk6X70azlFON4icBqJ4IPyGFajcOf3H87YBRkn4NLSsECkxVCx2VzlM5gu
         30eF+Cox9Wpzq8YjEjytxOxFk3I92j3TbVdVVSb+JyciW4ZfD+/ybAJC1WM/URcodnGK
         DJdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W5sli1yFUrBl9ZS6IgmfWyh0MoFuHh/omhrW77OGzlM=;
        b=Ph/BzpIht7Vua/Jy0kHtqP8k8Wv6F48pGNsvOdN+g1aCkQtBkXMUYJ6XPyysi6JEtj
         PzDGcRzyoV4tIOWf0j9WNmJag6Lp44oPZzNaAjAIhJao0eHr+44xfcDPXOkFj7DBjTk4
         KYyyn8ZIhE3tMNZLMb+eWQVPMZaKxkR/uEe4cBvXePc4dJf43PEVhub8dmISkAAvTlgF
         wik2skYJzKaeK1nqh311HjoZoNMuxjETv2S2uzMkHbchhCr7FstGB8v7sxnsul7YerN/
         lJyOLsV8Y+KzjZqxhCixTKh/jve5ejAVL+byqAxj5fMuCOw6yggQjojbq4QOSAW5oJ9w
         eXLg==
X-Gm-Message-State: AHQUAuYNUzlEHq5IcvyXASY/knKUBsmGkL3e4nq1AIzM/p4BPZ7nCfXi
        QstP7fjRgSq740n5pSEUHGczepVCtFFfHcp1APRYc9+t
X-Google-Smtp-Source: AHgI3IY2X/xdOF42Z9vxDy0rM1/JZ40Og5kKbmqdtdH1oJI1hM1UhVJRXFM86s15Wa2GhmBiVzF4Obl9E91XCW6Plk8=
X-Received: by 2002:a02:4c50:: with SMTP id a77mr2833100jab.59.1551307378585;
 Wed, 27 Feb 2019 14:42:58 -0800 (PST)
MIME-Version: 1.0
References: <20190212004729.535-1-joe@wand.net.nz> <20190212004729.535-3-joe@wand.net.nz>
 <CAH3MdRVU5ayEm6eb9Fz53Q5gjA60vadyJ+0_meCkWBo+t+XXYA@mail.gmail.com>
 <CAOftzPjFbBHabG2SR=QrC053Y8cC+Gi1LvK19oLEvDvR6LSLkw@mail.gmail.com> <CAH3MdRWrwMgjd7UT+7w=xCmEBD+mxv-YBqW+Q8zL8t5WvGTn8A@mail.gmail.com>
In-Reply-To: <CAH3MdRWrwMgjd7UT+7w=xCmEBD+mxv-YBqW+Q8zL8t5WvGTn8A@mail.gmail.com>
From:   Y Song <ys114321@gmail.com>
Date:   Wed, 27 Feb 2019 14:42:28 -0800
Message-ID: <CAH3MdRXHdysYLccCsawKqcmzScW=7B-ArPaMq7F8qjm+wsCWQg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/4] libbpf: Support 32-bit static data loads
To:     Joe Stringer <joe@wand.net.nz>
Cc:     bpf@vger.kernel.org, netdev <netdev@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

FYI.The latest llvm trunk will not emit errors for static variables. The patch
also gives detailed information how to relate a particular static
variable to a particular
relocation.

https://reviews.llvm.org/rL354954

Thanks,
Yonghong

On Fri, Feb 15, 2019 at 12:18 PM Y Song <ys114321@gmail.com> wrote:
>
> On Thu, Feb 14, 2019 at 11:16 PM Joe Stringer <joe@wand.net.nz> wrote:
> >
> > On Thu, 14 Feb 2019 at 21:39, Y Song <ys114321@gmail.com> wrote:
> > >
> > > On Mon, Feb 11, 2019 at 4:48 PM Joe Stringer <joe@wand.net.nz> wrote:
> > > >
> > > > Support loads of static 32-bit data when BPF writers make use of
> > > > convenience macros for accessing static global data variables. A later
> > > > patch in this series will demonstrate its usage in a selftest.
> > > >
> > > > As of LLVM-7, this technique only works with 32-bit data, as LLVM will
> > > > complain if this technique is attempted with data of other sizes:
> > > >
> > > >     LLVM ERROR: Unsupported relocation: try to compile with -O2 or above,
> > > >     or check your static variable usage
> > >
> > > A little bit clarification from compiler side.
> > > The above compiler error is to prevent people use static variables since current
> > > kernel/libbpf does not handle this. The compiler only warns if .bss or
> > > .data section
> > > has more than one definitions. The first definition always has section offset 0
> > > and the compiler did not warn.
> >
> > Ah, interesting. I observed that warning when I attempted to define
> > global variables of multiple sizes, and I thought also with sizes
> > other than 32-bit. This clarifies things a bit, thanks.
> >
> > For the .bss my observation was that if you had a definition like:
> >
> > static int a = 0;
> >
> > Then this will be placed into .bss, hence why I looked into the
> > approach from this patch for patch 3 as well.
> >
> > > The restriction is a little strange. To only work with 32-bit data is
> > > not a right
> > > statement. The following are some examples.
> > >
> > > The following static variable definitions will succeed:
> > > static int a; /* one in .bss */
> > > static long b = 2;  /* one in .data */
> > >
> > > The following definitions will fail as both in .bss.
> > > static int a;
> > > static int b;
> > >
> > > The following definitions will fail as both in .data:
> > > static char a = 2;
> > > static int b = 3;
> >
> > Are there type restrictions or something? I've been defining multiple
>
> There is no type restrictions.
> -bash-4.4$ cat g.c
> struct t {
>   int a;
>   char b;
>   long c;
> };
> static volatile struct t v;
> int test() { return v.a + v.b; }
> -bash-4.4$ clang -O2 -g -c -target bpf g.c
> -bash-4.4$
>
> > static uint32_t and using them per the approach in this patch series
> > without hitting this compiler assertion.
>
> -bash-4.4$ cat g1.c
> static volatile int a;
> static volatile int b;
> int test() { return a + b; }
> -bash-4.4$ clang -O2 -g -c -target bpf g1.c
> fatal error: error in backend: Unsupported relocation: try to compile
> with -O2 or above, or check your static variable
>       usage
> -bash-4.4$
>
> >
> > > Using global variables can prevent compiler errors.
> > > maps are defined as globals and the compiler does not
> > > check whether a particular global variable is defining a map or not.
> > >
> > > If you just use static variable like below
> > > static int a = 2;
> > > without potential assignment to a, the compiler will replace variable
> > > a with 2 at compile time.
> > > An alternative is to define like below
> > > static volatile int a = 2;
> > > You can get a "load" for variable "a" in the bpf load even if there is
> > > no assignment to a.
> >
> > I'll take a closer look at this too.
> >
> > > Maybe now is the time to remove the compiler assertions as
> > > libbpf/kernel starts to
> > > handle static variables?
> >
> > I don't understand why those assertions exists in this form. It
> > already allows code which will not load with libbpf (ie generate any
> > .data/.bss), does it help prevent unexpected situations for
> > developers?
>
> The error is introduced by the following llvm commit:
> commit 39184e407cd937f2f20d3f61eec205925bae7b13
> Author: Yonghong Song <yhs@fb.com>
> Date:   Wed Aug 22 21:21:03 2018 +0000
>
>     bpf: fix an assertion in BPFAsmBackend applyFixup()
>
>     Fix bug https://bugs.llvm.org/show_bug.cgi?id=38643
>
>     In BPFAsmBackend applyFixup(), there is an assertion for FixedValue to be 0.
>     This may not be true, esp. for optimiation level 0.
>     For example, in the above bug, for the following two
>     static variables:
>       @bpf_map_lookup_elem = internal global i8* (i8*, i8*)*
>           inttoptr (i64 1 to i8* (i8*, i8*)*), align 8
>       @bpf_map_update_elem = internal global i32 (i8*, i8*, i8*, i64)*
>           inttoptr (i64 2 to i32 (i8*, i8*, i8*, i64)*), align 8
>
>     The static variable @bpf_map_update_elem will have a symbol
>     offset of 8 and a FK_SecRel_8 with FixupValue 8 will cause
>     the assertion if llvm is built with -DLLVM_ENABLE_ASSERTIONS=ON.
>
>     The above relocations will not exist if the program is compiled
>     with optimization level -O1 and above as the compiler optimizes
>     those static variables away. In the below error message, -O2
>     is suggested as this is the common practice.
>
>     Note that FixedValue = 0 in applyFixup() does exist and is valid,
>     e.g., for the global variable my_map in the above bug. The bpf
>     loader will process them properly for map_id's before loading
>     the program into the kernel.
>
>     The static variables, which are not optimized away by compiler,
>     may have FK_SecRel_8 relocation with non-zero FixedValue.
>
>     The patch removed the offending assertion and will issue
>     a hard error as below if the FixedValue in applyFixup()
>     is not 0.
>       $ llc -march=bpf -filetype=obj fixup.ll
>       LLVM ERROR: Unsupported relocation: try to compile with -O2 or above,
>           or check your static variable usage
>
> Its main purpose is to fix a behavior difference with and without
> -DLLVM_ENABLE_ASSERTIONS=ON. The patch generated an error
> regardless whether the compiler time assertion is turned on or not.
>
> It does not catch all the cases e.g., only one static variable is defined,
> which needs fine tuning as there are legitimate cases (e.g., in some dwarf
> sessions) where the Fixup is valid with FixedValue = 0.
>
> If you try to use more than onee static variables, the compiler will
> print an error and let you know your potential issues.
>
> The question is since we are on the path to allow static variables
> in the bpf programs for later patching, we probably should remove
> this compiler fatal error?
