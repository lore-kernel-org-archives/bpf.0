Return-Path: <SRS0=c2E3=Q2=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06C5EC43381
	for <bpf@archiver.kernel.org>; Tue, 19 Feb 2019 18:22:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C426A217D9
	for <bpf@archiver.kernel.org>; Tue, 19 Feb 2019 18:22:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rrg9SKZV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725936AbfBSSWf (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 19 Feb 2019 13:22:35 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:38739 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbfBSSWf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 Feb 2019 13:22:35 -0500
Received: by mail-ot1-f67.google.com with SMTP id m1so35878358otf.5;
        Tue, 19 Feb 2019 10:22:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JxHz7knJYjU5T26+Q/yESFcCnT/saw0xAihzhH8ea54=;
        b=rrg9SKZVpNdKrr7mNQxRw2auCN4ZzfJhgG/omPh+fWB28ysXpHI36ZR3l2TnQxWGOo
         FMNBh9RJnvdKQFcNzgt8ZXx/yFjxMzkfCbcdLSGopriJqLWZvgoXE9f0Yo7I/8Efsniw
         lqsebrqugBQQq96rawlOtpGxOZNf6PHSZ2rJtcPMGp5dTKo6IJb9J8pdtJoCa5lImAci
         3ELy4KNQqzXJV4cTK/Ss/aRjGxvamjWcCH88GcI9v0InlrhorvvLNUs0YVQ3ENVMrVf7
         6P56Gkp2asL0cJkOaNX3vpOZtR8wwqoiwsp2Slk6ya7OuHx/3gC7BIBx1ifrvXb+C7Kj
         Z0zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JxHz7knJYjU5T26+Q/yESFcCnT/saw0xAihzhH8ea54=;
        b=LjdpoQ0z22vgS1PXOTxAYfnrrd/OaaJ+4dOf4NB/tOu3Yj/lcBClqXcVet2Ta7+x6w
         NIFfO2OOesmJQN1ToOBOg3rxOtYolccAPcGNgeAHskVMiXVtgus4zFLpPyHqJzZ/gk7S
         KC/v/I5nQwjQo/gEhQeBS6B2hKvVcUpvBcWi0Qm6JCCTcwSly5QSTT3WUu/tVx0Fj1mY
         3gGtP0dBXLgwYH2UF2IirLpKBR4aPJVHMN0gEjHDLxApEi0jnYy+wXgBHRPdJuOjAxz/
         RYihFxhXZO5SJ2Bt/4o1csr7O+GNgwGih6m1JKyiP3qbfcg3Le0a9apLSTOS2RIxzNsm
         XMOg==
X-Gm-Message-State: AHQUAuZEHp0bVxSBxbAH7IlVX5QHgidw12jwlLg07eyJ0+bW+JTe8Z+v
        uxFfSlmJPenole6+71mhq0M4IP5iwyihc7AA0ns=
X-Google-Smtp-Source: AHgI3IYKjiO6GAe59nAcCpC7GIYzmdhQ2xt9wIbU4h23ZCVi0L9IpzJPXeQ+nlpCb2VYnG4q0OYeX+AY4SZh+sSnuLM=
X-Received: by 2002:aca:d6cc:: with SMTP id n195mr3415148oig.27.1550600554098;
 Tue, 19 Feb 2019 10:22:34 -0800 (PST)
MIME-Version: 1.0
References: <20190219030208.3903269-1-andriin@fb.com> <CAEf4BzYjpaeOE+upCHjt4GhO07nPXepHHfTgebe0c8zfJgAFAw@mail.gmail.com>
 <20190219131659.GY31177@kernel.org>
In-Reply-To: <20190219131659.GY31177@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 19 Feb 2019 10:22:22 -0800
Message-ID: <CAEf4BzboJYpkPfNG202gxABWoaTSH11SXwoJWeV_vWT2Hpm+RQ@mail.gmail.com>
Subject: Re: [PATCH pahole] libbpf: build as PIC and statically link into libdwarves
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Andrii Nakryiko <andriin@fb.com>, Alexei Starovoitov <ast@fb.com>,
        dwarves@vger.kernel.org, bpf@vger.kernel.org,
        Kernel Team <Kernel-team@fb.com>, jolsa@kernel.org,
        namhyung@kernel.org, wangnan0@huawei.com,
        Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Feb 19, 2019 at 5:17 AM Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
> Em Mon, Feb 18, 2019 at 07:04:17PM -0800, Andrii Nakryiko escreveu:
> > cc Yonghong (mistyped his email)
>
> Applied, but before I split it into two patches, one bumping the minimum
> required cmake version, with an explanation about why that is needed,
> then the rest of the patch, with the explanation you provided.
>
> Please try to make the patches in a granular fashion, with justification
> for each independent part,

Yep, sorry about that, will do next time.

>
> Thanks,
>
> - Arnaldo
>
> > On Mon, Feb 18, 2019 at 7:02 PM Andrii Nakryiko <andriin@fb.com> wrote:
> > >
> > > As libbpf is not yet widely available, it's safer to statically link it
> > > into libdwarves for now. Easiest way to define that in cmake is through
> > > OBJECT library with PIC.
> > >
> > > Signed-off-by: Andrii Nakryiko <andriin@fb.com>
> > > ---
> > >  CMakeLists.txt | 17 ++++++-----------
> > >  1 file changed, 6 insertions(+), 11 deletions(-)
> > >
> > > diff --git a/CMakeLists.txt b/CMakeLists.txt
> > > index d6929b4..e0fdaf7 100644
> > > --- a/CMakeLists.txt
> > > +++ b/CMakeLists.txt
> > > @@ -1,5 +1,5 @@
> > >  project(pahole C)
> > > -cmake_minimum_required(VERSION 2.4.8)
> > > +cmake_minimum_required(VERSION 2.8.8)
> > >  cmake_policy(SET CMP0005 NEW)
> > >
> > >  INCLUDE_DIRECTORIES( ${CMAKE_CURRENT_BINARY_DIR} ${CMAKE_CURRENT_SOURCE_DIR} )
> > > @@ -72,24 +72,19 @@ if (NOT HAVE_REALLOCARRAY_SUPPORT)
> > >  endif()
> > >
> > >  file(GLOB libbpf_sources "lib/bpf/src/*.c")
> > > -add_library(bpf-static STATIC ${libbpf_sources})
> > > -set_target_properties(bpf-static PROPERTIES OUTPUT_NAME bpf)
> > > -target_include_directories(bpf-static PRIVATE
> > > -                          ${CMAKE_CURRENT_SOURCE_DIR}/lib/bpf/include
> > > -                          ${CMAKE_CURRENT_SOURCE_DIR}/lib/bpf/include/uapi)
> > > -add_library(bpf-shared SHARED ${libbpf_sources})
> > > -set_target_properties(bpf-shared PROPERTIES OUTPUT_NAME bpf)
> > > -target_include_directories(bpf-shared PRIVATE
> > > +add_library(bpf OBJECT ${libbpf_sources})
> > > +set_property(TARGET bpf PROPERTY POSITION_INDEPENDENT_CODE 1)
> > > +target_include_directories(bpf PRIVATE
> > >                            ${CMAKE_CURRENT_SOURCE_DIR}/lib/bpf/include
> > >                            ${CMAKE_CURRENT_SOURCE_DIR}/lib/bpf/include/uapi)
> > >
> > >  set(dwarves_LIB_SRCS dwarves.c dwarves_fprintf.c gobuffer strings
> > >                      ctf_encoder.c ctf_loader.c libctf.c btf_encoder.c btf_loader.c libbtf.c
> > >                      dwarf_loader.c dutil.c elf_symtab.c rbtree.c)
> > > -add_library(dwarves SHARED ${dwarves_LIB_SRCS})
> > > +add_library(dwarves SHARED ${dwarves_LIB_SRCS} $<TARGET_OBJECTS:bpf>)
> > >  set_target_properties(dwarves PROPERTIES VERSION 1.0.0 SOVERSION 1)
> > >  set_target_properties(dwarves PROPERTIES INTERFACE_LINK_LIBRARIES "")
> > > -target_link_libraries(dwarves ${DWARF_LIBRARIES} ${ZLIB_LIBRARIES} bpf-shared)
> > > +target_link_libraries(dwarves ${DWARF_LIBRARIES} ${ZLIB_LIBRARIES})
> > >
> > >  set(dwarves_emit_LIB_SRCS dwarves_emit.c)
> > >  add_library(dwarves_emit SHARED ${dwarves_emit_LIB_SRCS})
> > > --
> > > 2.17.1
> > >
>
> --
>
> - Arnaldo
