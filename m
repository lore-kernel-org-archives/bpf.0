Return-Path: <SRS0=+2DZ=QZ=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38DB6C43381
	for <bpf@archiver.kernel.org>; Mon, 18 Feb 2019 12:48:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09CF421872
	for <bpf@archiver.kernel.org>; Mon, 18 Feb 2019 12:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550494094;
	bh=z8Ofir1KfmhJkr4nrU2Z0S0J75N3ChZgmnyJAkLY1yI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zPOCGF+PyhW7gJdFhQ5S3AHgdI8WK6J3CYjb679NfMLnv2dV6EoP7RtD8Ve2QjZxx
	 5kAK8kJZWGBO52ZjvNRWiMuGYEGH+4ru9UrDqBeIqL5NUWDB0cbvqI+c14dPko1Ipg
	 LFArDqCKx3jucF17W+Zbh5alMrd6MNHFWnQjPJso=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729400AbfBRMsN (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 18 Feb 2019 07:48:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:41556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729578AbfBRMsN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 18 Feb 2019 07:48:13 -0500
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B32A6217F5;
        Mon, 18 Feb 2019 12:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550494093;
        bh=z8Ofir1KfmhJkr4nrU2Z0S0J75N3ChZgmnyJAkLY1yI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B6tjF7owfLaikViBM0FC+tiW0QOHLSwYTt3X9PTe3I+FVqjXL+FuRvacq42zEpOtx
         0vensz8BgKcM8NMzva8zpYzGvZI/6ewk7gyyQ9hUJ5fFgpSXsbD2JLt7HyibsjF2Ku
         H+BV08M5m17fQL3Wlh8yTQPb4asRV2OWrMDSoR8U=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 2AD3D410D5; Mon, 18 Feb 2019 09:48:10 -0300 (-03)
Date:   Mon, 18 Feb 2019 09:48:10 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andrii Nakryiko <andriin@fb.com>
Cc:     ast@fb.com, dwarves@vger.kernel.org, bpf@vger.kernel.org,
        kernel-team@fb.com, andrii.nakryiko@gmail.com
Subject: Re: [PATCH pahole 1/2] libbpf: pull latest libbpf and build libbpf
 as shared lib
Message-ID: <20190218124810.GO31177@kernel.org>
References: <20190217082018.1008069-1-andriin@fb.com>
 <20190217082018.1008069-2-andriin@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190217082018.1008069-2-andriin@fb.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Sun, Feb 17, 2019 at 12:20:17AM -0800, Andrii Nakryiko escreveu:
> Bring in latest changes from libbpf which allow to use btf__dedup() for
> big binaries (e.g., linux kernel image).

I'm splitting this patch into two, one for the above part and another
for the part in the end of this commit message.

Thanks,
 
> This patch also changes CMakeLists.txt to build libbpf as shared
> library to satisfy libdwarves shared library compilation.
> 
> Signed-off-by: Andrii Nakryiko <andriin@fb.com>
> ---
>  CMakeLists.txt | 13 +++++++++----
>  lib/bpf        |  2 +-
>  2 files changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/CMakeLists.txt b/CMakeLists.txt
> index 0cc383a..d6929b4 100644
> --- a/CMakeLists.txt
> +++ b/CMakeLists.txt
> @@ -72,9 +72,14 @@ if (NOT HAVE_REALLOCARRAY_SUPPORT)
>  endif()
>  
>  file(GLOB libbpf_sources "lib/bpf/src/*.c")
> -add_library(bpf STATIC ${libbpf_sources})
> -set_target_properties(bpf PROPERTIES OUTPUT_NAME bpf)
> -target_include_directories(bpf PRIVATE
> +add_library(bpf-static STATIC ${libbpf_sources})
> +set_target_properties(bpf-static PROPERTIES OUTPUT_NAME bpf)
> +target_include_directories(bpf-static PRIVATE
> +			   ${CMAKE_CURRENT_SOURCE_DIR}/lib/bpf/include
> +			   ${CMAKE_CURRENT_SOURCE_DIR}/lib/bpf/include/uapi)
> +add_library(bpf-shared SHARED ${libbpf_sources})
> +set_target_properties(bpf-shared PROPERTIES OUTPUT_NAME bpf)
> +target_include_directories(bpf-shared PRIVATE
>  			   ${CMAKE_CURRENT_SOURCE_DIR}/lib/bpf/include
>  			   ${CMAKE_CURRENT_SOURCE_DIR}/lib/bpf/include/uapi)
>  
> @@ -84,7 +89,7 @@ set(dwarves_LIB_SRCS dwarves.c dwarves_fprintf.c gobuffer strings
>  add_library(dwarves SHARED ${dwarves_LIB_SRCS})
>  set_target_properties(dwarves PROPERTIES VERSION 1.0.0 SOVERSION 1)
>  set_target_properties(dwarves PROPERTIES INTERFACE_LINK_LIBRARIES "")
> -target_link_libraries(dwarves ${DWARF_LIBRARIES} ${ZLIB_LIBRARIES} bpf)
> +target_link_libraries(dwarves ${DWARF_LIBRARIES} ${ZLIB_LIBRARIES} bpf-shared)
>  
>  set(dwarves_emit_LIB_SRCS dwarves_emit.c)
>  add_library(dwarves_emit SHARED ${dwarves_emit_LIB_SRCS})
> diff --git a/lib/bpf b/lib/bpf
> index b19c6dc..d5fa415 160000
> --- a/lib/bpf
> +++ b/lib/bpf
> @@ -1 +1 @@
> -Subproject commit b19c6dcf623a7adc9e538ddbe2964c2f58dd2417
> +Subproject commit d5fa4150f0c3a36e3ce458e1301531bd2edbf74d
> -- 
> 2.17.1

-- 

- Arnaldo
