Return-Path: <SRS0=ZyRU=QW=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80CE6C43381
	for <bpf@archiver.kernel.org>; Fri, 15 Feb 2019 20:18:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 420CD222A1
	for <bpf@archiver.kernel.org>; Fri, 15 Feb 2019 20:18:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fvw6eX9L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387442AbfBOUSz (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 15 Feb 2019 15:18:55 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:39328 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729429AbfBOUSy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 15 Feb 2019 15:18:54 -0500
Received: by mail-it1-f193.google.com with SMTP id l15so13593456iti.4;
        Fri, 15 Feb 2019 12:18:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x4D1UNWwQAb8q/FUZrbs87kwnHiMuSXAx2YpfhBxYkk=;
        b=Fvw6eX9LdDRVW8KpjtZR0+1k7SCL9QAlDW5zr94vXavSjBE9p5kmbiUPVqhnqlphUc
         MrDBPf6Ysm51xAfM1UgCKCmS1brSl52UvI+FVzEHMjowvTkE9ytax2dDzUW+c+eNaIrq
         k4LIzRNtbYVZ0MD+LH3d/wFwueYKsPpedpu5jF5rUQ3SJ5wivf6JKCaNYpsaKBJ3iAXj
         F2ECu3yc4EM2AFOaG+W3eAXJIwKof6ohVsy+T0VnHINJTeJ9FBfE4HGOinOQcpOF5KjZ
         NPLSbKRFFGgUsg1MJ3YnaatF+XH7EppDJqLNJexMvQ9TfhrhDsRHoRmWYPnh0ZvYxTeV
         dnCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x4D1UNWwQAb8q/FUZrbs87kwnHiMuSXAx2YpfhBxYkk=;
        b=nCDehuPtCfbHE1DK8K8fXEpv2qpG9/K9Sk5j2IzKfrDjDz8kQgstKImDCvfco13Sbk
         JO3IPX1pWlRaaOBo5wVtNUhdoH38w1Ss5GxediGnZkvuKG7ElWtxoFMIqVttvk81+oJe
         Nh1v+6KF/uJnpoa/eqQ8h9IzmPGdmQM3wiOzcYTpHOQf4ZWRHD5UxjITM8hBVF8UIGIW
         BASQNf3t2YwAeir0tIyTBAzDyZXHsqOQmanr/EJuZAbLG61G6yiuWffKIOYrH8Z2c4mh
         BD/piubN63fuW00gna8ktD44yXzp1hY0YJNy4boa4sCBebm9ONnR9hMLPqvaGnAwTH3c
         OKJA==
X-Gm-Message-State: AHQUAuaTrCUF1/2VvsBhRTN2Hybe8fjvurSnYjZkWWtqcmpiauBkxrzB
        zFsaEpN3XK9PHAhTuGHosL/T6yufJQA13J64WfQ=
X-Google-Smtp-Source: AHgI3IbvER1icwMYxI+bKtQFwuFDAu8QtfkMPOpxppJcebuDIv6XzTqls9fz8TmX+g6rtT9FUz7F26gR8WroBXP7DJU=
X-Received: by 2002:a5e:9412:: with SMTP id q18mr6739858ioj.233.1550261933061;
 Fri, 15 Feb 2019 12:18:53 -0800 (PST)
MIME-Version: 1.0
References: <20190212004729.535-1-joe@wand.net.nz> <20190212004729.535-3-joe@wand.net.nz>
 <CAH3MdRVU5ayEm6eb9Fz53Q5gjA60vadyJ+0_meCkWBo+t+XXYA@mail.gmail.com> <CAOftzPjFbBHabG2SR=QrC053Y8cC+Gi1LvK19oLEvDvR6LSLkw@mail.gmail.com>
In-Reply-To: <CAOftzPjFbBHabG2SR=QrC053Y8cC+Gi1LvK19oLEvDvR6LSLkw@mail.gmail.com>
From:   Y Song <ys114321@gmail.com>
Date:   Fri, 15 Feb 2019 12:18:18 -0800
Message-ID: <CAH3MdRWrwMgjd7UT+7w=xCmEBD+mxv-YBqW+Q8zL8t5WvGTn8A@mail.gmail.com>
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

On Thu, Feb 14, 2019 at 11:16 PM Joe Stringer <joe@wand.net.nz> wrote:
>
> On Thu, 14 Feb 2019 at 21:39, Y Song <ys114321@gmail.com> wrote:
> >
> > On Mon, Feb 11, 2019 at 4:48 PM Joe Stringer <joe@wand.net.nz> wrote:
> > >
> > > Support loads of static 32-bit data when BPF writers make use of
> > > convenience macros for accessing static global data variables. A later
> > > patch in this series will demonstrate its usage in a selftest.
> > >
> > > As of LLVM-7, this technique only works with 32-bit data, as LLVM will
> > > complain if this technique is attempted with data of other sizes:
> > >
> > >     LLVM ERROR: Unsupported relocation: try to compile with -O2 or above,
> > >     or check your static variable usage
> >
> > A little bit clarification from compiler side.
> > The above compiler error is to prevent people use static variables since current
> > kernel/libbpf does not handle this. The compiler only warns if .bss or
> > .data section
> > has more than one definitions. The first definition always has section offset 0
> > and the compiler did not warn.
>
> Ah, interesting. I observed that warning when I attempted to define
> global variables of multiple sizes, and I thought also with sizes
> other than 32-bit. This clarifies things a bit, thanks.
>
> For the .bss my observation was that if you had a definition like:
>
> static int a = 0;
>
> Then this will be placed into .bss, hence why I looked into the
> approach from this patch for patch 3 as well.
>
> > The restriction is a little strange. To only work with 32-bit data is
> > not a right
> > statement. The following are some examples.
> >
> > The following static variable definitions will succeed:
> > static int a; /* one in .bss */
> > static long b = 2;  /* one in .data */
> >
> > The following definitions will fail as both in .bss.
> > static int a;
> > static int b;
> >
> > The following definitions will fail as both in .data:
> > static char a = 2;
> > static int b = 3;
>
> Are there type restrictions or something? I've been defining multiple

There is no type restrictions.
-bash-4.4$ cat g.c
struct t {
  int a;
  char b;
  long c;
};
static volatile struct t v;
int test() { return v.a + v.b; }
-bash-4.4$ clang -O2 -g -c -target bpf g.c
-bash-4.4$

> static uint32_t and using them per the approach in this patch series
> without hitting this compiler assertion.

-bash-4.4$ cat g1.c
static volatile int a;
static volatile int b;
int test() { return a + b; }
-bash-4.4$ clang -O2 -g -c -target bpf g1.c
fatal error: error in backend: Unsupported relocation: try to compile
with -O2 or above, or check your static variable
      usage
-bash-4.4$

>
> > Using global variables can prevent compiler errors.
> > maps are defined as globals and the compiler does not
> > check whether a particular global variable is defining a map or not.
> >
> > If you just use static variable like below
> > static int a = 2;
> > without potential assignment to a, the compiler will replace variable
> > a with 2 at compile time.
> > An alternative is to define like below
> > static volatile int a = 2;
> > You can get a "load" for variable "a" in the bpf load even if there is
> > no assignment to a.
>
> I'll take a closer look at this too.
>
> > Maybe now is the time to remove the compiler assertions as
> > libbpf/kernel starts to
> > handle static variables?
>
> I don't understand why those assertions exists in this form. It
> already allows code which will not load with libbpf (ie generate any
> .data/.bss), does it help prevent unexpected situations for
> developers?

The error is introduced by the following llvm commit:
commit 39184e407cd937f2f20d3f61eec205925bae7b13
Author: Yonghong Song <yhs@fb.com>
Date:   Wed Aug 22 21:21:03 2018 +0000

    bpf: fix an assertion in BPFAsmBackend applyFixup()

    Fix bug https://bugs.llvm.org/show_bug.cgi?id=38643

    In BPFAsmBackend applyFixup(), there is an assertion for FixedValue to be 0.
    This may not be true, esp. for optimiation level 0.
    For example, in the above bug, for the following two
    static variables:
      @bpf_map_lookup_elem = internal global i8* (i8*, i8*)*
          inttoptr (i64 1 to i8* (i8*, i8*)*), align 8
      @bpf_map_update_elem = internal global i32 (i8*, i8*, i8*, i64)*
          inttoptr (i64 2 to i32 (i8*, i8*, i8*, i64)*), align 8

    The static variable @bpf_map_update_elem will have a symbol
    offset of 8 and a FK_SecRel_8 with FixupValue 8 will cause
    the assertion if llvm is built with -DLLVM_ENABLE_ASSERTIONS=ON.

    The above relocations will not exist if the program is compiled
    with optimization level -O1 and above as the compiler optimizes
    those static variables away. In the below error message, -O2
    is suggested as this is the common practice.

    Note that FixedValue = 0 in applyFixup() does exist and is valid,
    e.g., for the global variable my_map in the above bug. The bpf
    loader will process them properly for map_id's before loading
    the program into the kernel.

    The static variables, which are not optimized away by compiler,
    may have FK_SecRel_8 relocation with non-zero FixedValue.

    The patch removed the offending assertion and will issue
    a hard error as below if the FixedValue in applyFixup()
    is not 0.
      $ llc -march=bpf -filetype=obj fixup.ll
      LLVM ERROR: Unsupported relocation: try to compile with -O2 or above,
          or check your static variable usage

Its main purpose is to fix a behavior difference with and without
-DLLVM_ENABLE_ASSERTIONS=ON. The patch generated an error
regardless whether the compiler time assertion is turned on or not.

It does not catch all the cases e.g., only one static variable is defined,
which needs fine tuning as there are legitimate cases (e.g., in some dwarf
sessions) where the Fixup is valid with FixedValue = 0.

If you try to use more than onee static variables, the compiler will
print an error and let you know your potential issues.

The question is since we are on the path to allow static variables
in the bpf programs for later patching, we probably should remove
this compiler fatal error?
