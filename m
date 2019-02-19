Return-Path: <SRS0=c2E3=Q2=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C46DBC43381
	for <bpf@archiver.kernel.org>; Tue, 19 Feb 2019 13:17:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 868FE21736
	for <bpf@archiver.kernel.org>; Tue, 19 Feb 2019 13:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550582224;
	bh=LvnnYrAQttqCeOO381XS9xBiidroZFfy2LUIpuwwNgg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bWHshiEs2ll0Fo4VBpCuHIs4ZOPBTX8EasAWU9UDxmpaCt4KE/T+FgxYuXmx2LKUs
	 bP2FmKDogzB2Ahcs/nJe6C3Om83UpNCkxQZGAeBLqboSgaXHKG8ChmJuDBoC68lVzl
	 cUBr4aX9LD9Y3PdaqxEJRwY643mLJlzU0AD0opC4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728520AbfBSNRE (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 19 Feb 2019 08:17:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:35284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726221AbfBSNRE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 Feb 2019 08:17:04 -0500
Received: from quaco.ghostprotocols.net (unknown [179.162.130.119])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 98CD22146E;
        Tue, 19 Feb 2019 13:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550582223;
        bh=LvnnYrAQttqCeOO381XS9xBiidroZFfy2LUIpuwwNgg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1wWrtXo42Zx33xjaYE/CIKZKUVDGlqznXwo9EtjYveal+3LZvVXcRXQvXO03Gm7y2
         C/ZG5EDYQ0NfhnEQ6aGBeLjJEEJwWCEPdFhkkgLjLscTQr9Z/Rh397IwckY3fWVu5r
         Ht6P7R6VxJEm8j5FYOmYAxbwMWjzCFiz7sMut6cw=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 1A5F6410D5; Tue, 19 Feb 2019 10:17:00 -0300 (-03)
Date:   Tue, 19 Feb 2019 10:16:59 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Andrii Nakryiko <andriin@fb.com>, Alexei Starovoitov <ast@fb.com>,
        dwarves@vger.kernel.org, bpf@vger.kernel.org,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Kernel Team <Kernel-team@fb.com>, jolsa@kernel.org,
        namhyung@kernel.org, wangnan0@huawei.com,
        Yonghong Song <yhs@fb.com>
Subject: Re: [PATCH pahole] libbpf: build as PIC and statically link into
 libdwarves
Message-ID: <20190219131659.GY31177@kernel.org>
References: <20190219030208.3903269-1-andriin@fb.com>
 <CAEf4BzYjpaeOE+upCHjt4GhO07nPXepHHfTgebe0c8zfJgAFAw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzYjpaeOE+upCHjt4GhO07nPXepHHfTgebe0c8zfJgAFAw@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Mon, Feb 18, 2019 at 07:04:17PM -0800, Andrii Nakryiko escreveu:
> cc Yonghong (mistyped his email)

Applied, but before I split it into two patches, one bumping the minimum
required cmake version, with an explanation about why that is needed,
then the rest of the patch, with the explanation you provided.

Please try to make the patches in a granular fashion, with justification
for each independent part,

Thanks,

- Arnaldo
 
> On Mon, Feb 18, 2019 at 7:02 PM Andrii Nakryiko <andriin@fb.com> wrote:
> >
> > As libbpf is not yet widely available, it's safer to statically link it
> > into libdwarves for now. Easiest way to define that in cmake is through
> > OBJECT library with PIC.
> >
> > Signed-off-by: Andrii Nakryiko <andriin@fb.com>
> > ---
> >  CMakeLists.txt | 17 ++++++-----------
> >  1 file changed, 6 insertions(+), 11 deletions(-)
> >
> > diff --git a/CMakeLists.txt b/CMakeLists.txt
> > index d6929b4..e0fdaf7 100644
> > --- a/CMakeLists.txt
> > +++ b/CMakeLists.txt
> > @@ -1,5 +1,5 @@
> >  project(pahole C)
> > -cmake_minimum_required(VERSION 2.4.8)
> > +cmake_minimum_required(VERSION 2.8.8)
> >  cmake_policy(SET CMP0005 NEW)
> >
> >  INCLUDE_DIRECTORIES( ${CMAKE_CURRENT_BINARY_DIR} ${CMAKE_CURRENT_SOURCE_DIR} )
> > @@ -72,24 +72,19 @@ if (NOT HAVE_REALLOCARRAY_SUPPORT)
> >  endif()
> >
> >  file(GLOB libbpf_sources "lib/bpf/src/*.c")
> > -add_library(bpf-static STATIC ${libbpf_sources})
> > -set_target_properties(bpf-static PROPERTIES OUTPUT_NAME bpf)
> > -target_include_directories(bpf-static PRIVATE
> > -                          ${CMAKE_CURRENT_SOURCE_DIR}/lib/bpf/include
> > -                          ${CMAKE_CURRENT_SOURCE_DIR}/lib/bpf/include/uapi)
> > -add_library(bpf-shared SHARED ${libbpf_sources})
> > -set_target_properties(bpf-shared PROPERTIES OUTPUT_NAME bpf)
> > -target_include_directories(bpf-shared PRIVATE
> > +add_library(bpf OBJECT ${libbpf_sources})
> > +set_property(TARGET bpf PROPERTY POSITION_INDEPENDENT_CODE 1)
> > +target_include_directories(bpf PRIVATE
> >                            ${CMAKE_CURRENT_SOURCE_DIR}/lib/bpf/include
> >                            ${CMAKE_CURRENT_SOURCE_DIR}/lib/bpf/include/uapi)
> >
> >  set(dwarves_LIB_SRCS dwarves.c dwarves_fprintf.c gobuffer strings
> >                      ctf_encoder.c ctf_loader.c libctf.c btf_encoder.c btf_loader.c libbtf.c
> >                      dwarf_loader.c dutil.c elf_symtab.c rbtree.c)
> > -add_library(dwarves SHARED ${dwarves_LIB_SRCS})
> > +add_library(dwarves SHARED ${dwarves_LIB_SRCS} $<TARGET_OBJECTS:bpf>)
> >  set_target_properties(dwarves PROPERTIES VERSION 1.0.0 SOVERSION 1)
> >  set_target_properties(dwarves PROPERTIES INTERFACE_LINK_LIBRARIES "")
> > -target_link_libraries(dwarves ${DWARF_LIBRARIES} ${ZLIB_LIBRARIES} bpf-shared)
> > +target_link_libraries(dwarves ${DWARF_LIBRARIES} ${ZLIB_LIBRARIES})
> >
> >  set(dwarves_emit_LIB_SRCS dwarves_emit.c)
> >  add_library(dwarves_emit SHARED ${dwarves_emit_LIB_SRCS})
> > --
> > 2.17.1
> >

-- 

- Arnaldo
