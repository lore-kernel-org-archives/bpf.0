Return-Path: <SRS0=xp9Q=RK=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC27BC43381
	for <bpf@archiver.kernel.org>; Thu,  7 Mar 2019 01:14:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ECEB20684
	for <bpf@archiver.kernel.org>; Thu,  7 Mar 2019 01:14:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c5AmOuC0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726161AbfCGBOO (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 6 Mar 2019 20:14:14 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:36698 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbfCGBON (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 6 Mar 2019 20:14:13 -0500
Received: by mail-it1-f196.google.com with SMTP id v83so13284952itf.1;
        Wed, 06 Mar 2019 17:14:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TASnh/dTmZD2GyOcsnJBVvVM53xsu2ADp/oxEsMYj9A=;
        b=c5AmOuC0tf8kxjPJQnklOoJO0G1IM3XFk9w37aOLPx3hEYINFQPx1Iddg1sB6fAl9n
         PBOgZ8mwiNmPzcGYFyn26f29AWzF9pFrmMLV3Mo4vR3eTab5htm6jIbtg5kWMBkEsj3f
         TpMeep13GnO4Ql/UV2tDI191ax1HpDrWJ3g14ufo1+IWhAsfXF4HsAWtufS3Wjm39/it
         HTPsYdFvF3b4aH0x8HQbD0uXFvfBOrjrfE6qQz8cDsrXBT96/iqnsVU2mx+6Osd37odJ
         0feQ4DueBc4TZo0Lkj0zfXMqbloHiYP5f+FBvtsBl/Uesw1wprxXIgSRqLMwPAKTgY2Z
         cgmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TASnh/dTmZD2GyOcsnJBVvVM53xsu2ADp/oxEsMYj9A=;
        b=iYe5xEzfzgddiQkLABgl3qjHI587gJRA7tmsxd/PqQRONV6AjqC6BdQ8eo2fGz8ZcA
         V+zvi+CEoJeGXUxUe2JVbjyo+IFzP2ZBkVEdn5vbkAI07rxF7UUi/KiuPNr+6Kug78tQ
         Ul1b9VqFDtH7/cyNVQDjPyh8Wudr3BOSmbZDLY7Sk+Iw+mYlw0CMYL5qOJZ5taFCVw1M
         +YF5PeGBufFnmNYr47AHeykPlrKYzdg4qWet+s8A5Z98xJUe2KHx3rrMsmHSDewkaIIe
         cVDg9Fe4EE8p8VrA4rDfj6YGNjs4Q8nOQsrpIWpuI3qIDrJUTOPxlBqmttcWJEmDtyoT
         bx/Q==
X-Gm-Message-State: APjAAAXKaiQZHF/YvAengvO4ihVL/Sk/wZq+ALQFqWgB7CdyWAD4l/HR
        k2Yk6n8yhAFAR+8Qof55a6sXKIGbieL7g6cckH8=
X-Google-Smtp-Source: APXvYqyx3NRsOXoVQ2jdMjfRq7BdUvsUZmbc2YuhgT3Ig7GmP0q7oTt/m8AxnpNBwvaqe1qSbWdJNRYhSiNSPJk2UKI=
X-Received: by 2002:a02:6012:: with SMTP id i18mr6083079jac.24.1551921252547;
 Wed, 06 Mar 2019 17:14:12 -0800 (PST)
MIME-Version: 1.0
References: <20190306195927.208503-1-sdf@google.com> <20190306195927.208503-2-sdf@google.com>
In-Reply-To: <20190306195927.208503-2-sdf@google.com>
From:   Y Song <ys114321@gmail.com>
Date:   Wed, 6 Mar 2019 17:13:36 -0800
Message-ID: <CAH3MdRU_OQ03Jd7Y6RvdaPE2hvXt+qoPn0-+25Gma-HX6k-DnA@mail.gmail.com>
Subject: Re: [PATCH bpf 2/2] libbpf: force fixdep compilation at the start of
 the build
To:     Stanislav Fomichev <sdf@google.com>
Cc:     netdev <netdev@vger.kernel.org>, bpf@vger.kernel.org,
        David Miller <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 6, 2019 at 1:14 PM Stanislav Fomichev <sdf@google.com> wrote:
>
> libbpf targets don't explicitly depend on fixdep target, so when
> we do 'make -j$(nproc)', there is a high probability, that some
> objects will be built before fixdep binary is available.
>
> Fix this by running sub-make; this makes sure that fixdep dependency
> is properly accounted for.
>
> For the same issue in perf, see commit abb26210a395 ("perf tools: Force
> fixdep compilation at the start of the build").
>
> Before:
>
> $ rm -rf /tmp/bld; mkdir /tmp/bld; make -j$(nproc) O=3D/tmp/bld -C tools/=
lib/bpf/
>
> Auto-detecting system features:
> ...                        libelf: [ on  ]
> ...                           bpf: [ on  ]
>
>   HOSTCC   /tmp/bld/fixdep.o
>   CC       /tmp/bld/libbpf.o
>   CC       /tmp/bld/bpf.o
>   CC       /tmp/bld/btf.o
>   CC       /tmp/bld/nlattr.o
>   CC       /tmp/bld/libbpf_errno.o
>   CC       /tmp/bld/str_error.o
>   CC       /tmp/bld/netlink.o
>   CC       /tmp/bld/bpf_prog_linfo.o
>   CC       /tmp/bld/libbpf_probes.o
>   CC       /tmp/bld/xsk.o
>   HOSTLD   /tmp/bld/fixdep-in.o
>   LINK     /tmp/bld/fixdep
>   LD       /tmp/bld/libbpf-in.o
>   LINK     /tmp/bld/libbpf.a
>   LINK     /tmp/bld/libbpf.so
>   LINK     /tmp/bld/test_libbpf
>
> $ head /tmp/bld/.libbpf.o.cmd
>  # cannot find fixdep (/usr/local/google/home/sdf/src/linux/xxx//fixdep)
>  # using basic dep data
>
> /tmp/bld/libbpf.o: libbpf.c /usr/include/stdc-predef.h \
>  /usr/include/stdlib.h /usr/include/features.h \
>  /usr/include/x86_64-linux-gnu/sys/cdefs.h \
>  /usr/include/x86_64-linux-gnu/bits/wordsize.h \
>  /usr/include/x86_64-linux-gnu/gnu/stubs.h \
>  /usr/include/x86_64-linux-gnu/gnu/stubs-64.h \
>  /usr/lib/gcc/x86_64-linux-gnu/7/include/stddef.h \
>
> After:
>
> $ rm -rf /tmp/bld; mkdir /tmp/bld; make -j$(nproc) O=3D/tmp/bld -C tools/=
lib/bpf/
>
> Auto-detecting system features:
> ...                        libelf: [ on  ]
> ...                           bpf: [ on  ]
>
>   HOSTCC   /tmp/bld/fixdep.o
>   HOSTLD   /tmp/bld/fixdep-in.o
>   LINK     /tmp/bld/fixdep
>   CC       /tmp/bld/libbpf.o
>   CC       /tmp/bld/bpf.o
>   CC       /tmp/bld/nlattr.o
>   CC       /tmp/bld/btf.o
>   CC       /tmp/bld/libbpf_errno.o
>   CC       /tmp/bld/str_error.o
>   CC       /tmp/bld/netlink.o
>   CC       /tmp/bld/bpf_prog_linfo.o
>   CC       /tmp/bld/libbpf_probes.o
>   CC       /tmp/bld/xsk.o
>   LD       /tmp/bld/libbpf-in.o
>   LINK     /tmp/bld/libbpf.a
>   LINK     /tmp/bld/libbpf.so
>   LINK     /tmp/bld/test_libbpf
>
> $ head /tmp/bld/.libbpf.o.cmd
> cmd_/tmp/bld/libbpf.o :=3D gcc -Wp,-MD,/tmp/bld/.libbpf.o.d -Wp,-MT,/tmp/=
bld/libbpf.o -g -Wall -DHAVE_LIBELF_MMAP_SUPPORT -DCOMPAT_NEED_REALLOCARRAY=
 -Wbad-function-cast -Wdeclaration-after-statement -Wformat-security -Wform=
at-y2k -Winit-self -Wmissing-declarations -Wmissing-prototypes -Wnested-ext=
erns -Wno-system-headers -Wold-style-definition -Wpacked -Wredundant-decls =
-Wshadow -Wstrict-prototypes -Wswitch-default -Wswitch-enum -Wundef -Wwrite=
-strings -Wformat -Wstrict-aliasing=3D3 -Werror -Wall -fPIC -I. -I/usr/loca=
l/google/home/sdf/src/linux/tools/include -I/usr/local/google/home/sdf/src/=
linux/tools/arch/x86/include/uapi -I/usr/local/google/home/sdf/src/linux/to=
ols/include/uapi -fvisibility=3Dhidden -D"BUILD_STR(s)=3D$(pound)s" -c -o /=
tmp/bld/libbpf.o libbpf.c
>
> source_/tmp/bld/libbpf.o :=3D libbpf.c
>
> deps_/tmp/bld/libbpf.o :=3D \
>   /usr/include/stdc-predef.h \
>   /usr/include/stdlib.h \
>   /usr/include/features.h \
>   /usr/include/x86_64-linux-gnu/sys/cdefs.h \
>   /usr/include/x86_64-linux-gnu/bits/wordsize.h \
>
> Reported-by: Eric Dumazet <edumazet@google.com>
> Fixes: 7c422f557266 ("tools build: Build fixdep helper from perf and basi=
c libs")
>
> Signed-off-by: Stanislav Fomichev <sdf@google.com>
Acked-by: Yonghong Song <yhs@fb.com>
