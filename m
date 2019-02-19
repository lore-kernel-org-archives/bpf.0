Return-Path: <SRS0=c2E3=Q2=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA22CC43381
	for <bpf@archiver.kernel.org>; Tue, 19 Feb 2019 03:04:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 779582177E
	for <bpf@archiver.kernel.org>; Tue, 19 Feb 2019 03:04:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m0Cz8TyQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726176AbfBSDEa (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 18 Feb 2019 22:04:30 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:40813 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725308AbfBSDE3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 18 Feb 2019 22:04:29 -0500
Received: by mail-ot1-f65.google.com with SMTP id s5so31834914oth.7;
        Mon, 18 Feb 2019 19:04:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TfbaT9QbZr6w2rmdAn3MBnnH+ObwoQw3MZZqvE8WhIc=;
        b=m0Cz8TyQqdwF/v3d71hS7oUaeSNJ7RP9h1RzdVT4EtkUaJHW5Zw/Z1XJFVaxj2jDql
         IIJzd0wqBhlOYiQlUKH14h2BA6y8R2+jjQBV6C1ux62mVclGFGVSBhBcC7QOnn2PwxwT
         MMMJDYZ37S1i1XX0/T90Eg+SK6IKilAAuKkSlDcy3v1RNf2FTX129itA/Cca9MwASsiG
         P1J9qwL4k3L/oralzJyudUQVBKaSWLkdH8ivnatBiJe/flkSpDdhXogsaVuHVcj3jgZb
         Ip30WbxhzZYuqZQ2B11jq2Gnfy+kWUPyaXPK904uLyGDlEP36NtwfizVwsmTcBiEAIo7
         W58g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TfbaT9QbZr6w2rmdAn3MBnnH+ObwoQw3MZZqvE8WhIc=;
        b=t7NQxvwzHHxuEXxfNksVGL5QWuM5grC2o26WNIn27s7b5dn2zhwO47SfnU5asmyk/g
         G01KzvNFxFqkoBtWuR3KBaQxf4Z64QMr9LpDqTnvTkVWc6gEp1xYaT8GFKbbSFz0rJXJ
         OAak6uLJty6N2hD3GU35jNVrGMMN0JYHnWw8fNia1QnhUpw1pFQ0X/C1IpxqfPl/J/6G
         lAQJUa9EEYX6j3Zi580xRcq8tVQqmegxYYgX9+m79vv5fAZGN2xB916dtupT6F+hX2sW
         ay7kXLIuSsKiM/vigYjF/x2VAvLDTAnKKwiJXAqB5U/ulkzYuraKYc5rNb+ttS1mgSe7
         cARw==
X-Gm-Message-State: AHQUAuZoohuWZNvKJwwGM3L+3gvQYau4RPIJMqRYh6dvU61Lu+TuDLI5
        hSGdjd8RYEXezCskeSkV5KbCK3bsZ503OhEzJLE=
X-Google-Smtp-Source: AHgI3Ib/uDMrlQvL73uIgA27aSAvNgEMog/OHkL8Q2Z8Q+eV9/iqz07wTCKX7eMMKC5sZ9SFw8jkYoLovDmWu9UUlwY=
X-Received: by 2002:a9d:6a08:: with SMTP id g8mr9575762otn.191.1550545468694;
 Mon, 18 Feb 2019 19:04:28 -0800 (PST)
MIME-Version: 1.0
References: <20190219030208.3903269-1-andriin@fb.com>
In-Reply-To: <20190219030208.3903269-1-andriin@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 18 Feb 2019 19:04:17 -0800
Message-ID: <CAEf4BzYjpaeOE+upCHjt4GhO07nPXepHHfTgebe0c8zfJgAFAw@mail.gmail.com>
Subject: Re: [PATCH pahole] libbpf: build as PIC and statically link into libdwarves
To:     Andrii Nakryiko <andriin@fb.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexei Starovoitov <ast@fb.com>, dwarves@vger.kernel.org,
        bpf@vger.kernel.org,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Kernel Team <Kernel-team@fb.com>, jolsa@kernel.org,
        namhyung@kernel.org, wangnan0@huawei.com,
        Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

cc Yonghong (mistyped his email)

-- Andrii

On Mon, Feb 18, 2019 at 7:02 PM Andrii Nakryiko <andriin@fb.com> wrote:
>
> As libbpf is not yet widely available, it's safer to statically link it
> into libdwarves for now. Easiest way to define that in cmake is through
> OBJECT library with PIC.
>
> Signed-off-by: Andrii Nakryiko <andriin@fb.com>
> ---
>  CMakeLists.txt | 17 ++++++-----------
>  1 file changed, 6 insertions(+), 11 deletions(-)
>
> diff --git a/CMakeLists.txt b/CMakeLists.txt
> index d6929b4..e0fdaf7 100644
> --- a/CMakeLists.txt
> +++ b/CMakeLists.txt
> @@ -1,5 +1,5 @@
>  project(pahole C)
> -cmake_minimum_required(VERSION 2.4.8)
> +cmake_minimum_required(VERSION 2.8.8)
>  cmake_policy(SET CMP0005 NEW)
>
>  INCLUDE_DIRECTORIES( ${CMAKE_CURRENT_BINARY_DIR} ${CMAKE_CURRENT_SOURCE_DIR} )
> @@ -72,24 +72,19 @@ if (NOT HAVE_REALLOCARRAY_SUPPORT)
>  endif()
>
>  file(GLOB libbpf_sources "lib/bpf/src/*.c")
> -add_library(bpf-static STATIC ${libbpf_sources})
> -set_target_properties(bpf-static PROPERTIES OUTPUT_NAME bpf)
> -target_include_directories(bpf-static PRIVATE
> -                          ${CMAKE_CURRENT_SOURCE_DIR}/lib/bpf/include
> -                          ${CMAKE_CURRENT_SOURCE_DIR}/lib/bpf/include/uapi)
> -add_library(bpf-shared SHARED ${libbpf_sources})
> -set_target_properties(bpf-shared PROPERTIES OUTPUT_NAME bpf)
> -target_include_directories(bpf-shared PRIVATE
> +add_library(bpf OBJECT ${libbpf_sources})
> +set_property(TARGET bpf PROPERTY POSITION_INDEPENDENT_CODE 1)
> +target_include_directories(bpf PRIVATE
>                            ${CMAKE_CURRENT_SOURCE_DIR}/lib/bpf/include
>                            ${CMAKE_CURRENT_SOURCE_DIR}/lib/bpf/include/uapi)
>
>  set(dwarves_LIB_SRCS dwarves.c dwarves_fprintf.c gobuffer strings
>                      ctf_encoder.c ctf_loader.c libctf.c btf_encoder.c btf_loader.c libbtf.c
>                      dwarf_loader.c dutil.c elf_symtab.c rbtree.c)
> -add_library(dwarves SHARED ${dwarves_LIB_SRCS})
> +add_library(dwarves SHARED ${dwarves_LIB_SRCS} $<TARGET_OBJECTS:bpf>)
>  set_target_properties(dwarves PROPERTIES VERSION 1.0.0 SOVERSION 1)
>  set_target_properties(dwarves PROPERTIES INTERFACE_LINK_LIBRARIES "")
> -target_link_libraries(dwarves ${DWARF_LIBRARIES} ${ZLIB_LIBRARIES} bpf-shared)
> +target_link_libraries(dwarves ${DWARF_LIBRARIES} ${ZLIB_LIBRARIES})
>
>  set(dwarves_emit_LIB_SRCS dwarves_emit.c)
>  add_library(dwarves_emit SHARED ${dwarves_emit_LIB_SRCS})
> --
> 2.17.1
>
