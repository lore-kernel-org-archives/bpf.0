Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA0C7C433E0
	for <bpf@archiver.kernel.org>; Tue, 23 Feb 2021 14:45:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A560164E12
	for <bpf@archiver.kernel.org>; Tue, 23 Feb 2021 14:45:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbhBWOp3 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 23 Feb 2021 09:45:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:43315 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229823AbhBWOp3 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 23 Feb 2021 09:45:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614091442;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LpYOhXHGVxU0xOZjyTmBsPRLytwkVqdBdOt50mvBPSs=;
        b=YtECZbi9sXNYe/UePn9P2ZAzgcpa7Em1bSG8UeSnmzu6ix0j9HWpLwfnqdBhc6kLEDsEld
        9DyRhQeVf4TXhdIanaCn34PKQH8GlKHb2/TlbimQ65Z4e+wEma8eGkaj7sekt3bfdt8WOv
        8U5gLixksT3G5YBaHkIyT3EpeZoS/xE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-342-8S5jRRWLPqObCUaM2wahPQ-1; Tue, 23 Feb 2021 09:42:57 -0500
X-MC-Unique: 8S5jRRWLPqObCUaM2wahPQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BC7CB814304;
        Tue, 23 Feb 2021 14:42:55 +0000 (UTC)
Received: from krava (unknown [10.40.192.54])
        by smtp.corp.redhat.com (Postfix) with SMTP id 6284760CDE;
        Tue, 23 Feb 2021 14:42:54 +0000 (UTC)
Date:   Tue, 23 Feb 2021 15:42:53 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Kun-Chuan Hsieh <jetswayss@gmail.com>
Cc:     ast@kernel.org, bpf@vger.kernel.org, jolsa@kernel.org,
        andrii@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] tools/resolve_btfids: Fix build error with older host
 toolchains
Message-ID: <YDUUbRJ1waVyoO+f@krava>
References: <20210223012001.1452676-1-jetswayss@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210223012001.1452676-1-jetswayss@gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Feb 23, 2021 at 01:20:01AM +0000, Kun-Chuan Hsieh wrote:
> Older versions of libelf cannot recognize the compressed section.

so it's the SHF_COMPRESSED value the build fails on?

maybe we could do just this:

#ifndef SHF_COMPRESSED
 #define SHF_COMPRESSED      (1 << 11)  /* Section with compressed data. */
#endif

jirka

> However, it's only required to fix the compressed section info when
> compiling with CONFIG_DEBUG_INFO_COMPRESSED flag is set.
> 
> Only compile the compressed_section_fix function when necessary will make
> it easier to enable the BTF function. Since the tool resolve_btfids is
> compiled with host toolchain. The host toolchain might be older than the
> cross compile toolchain.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Kun-Chuan Hsieh <jetswayss@gmail.com>
> ---
>  tools/bpf/resolve_btfids/main.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
> index 7409d7860aa6..ad40346c6631 100644
> --- a/tools/bpf/resolve_btfids/main.c
> +++ b/tools/bpf/resolve_btfids/main.c
> @@ -260,6 +260,7 @@ static struct btf_id *add_symbol(struct rb_root *root, char *name, size_t size)
>  	return btf_id__add(root, id, false);
>  }
>  
> +#ifdef CONFIG_DEBUG_INFO_COMPRESSED
>  /*
>   * The data of compressed section should be aligned to 4
>   * (for 32bit) or 8 (for 64 bit) bytes. The binutils ld
> @@ -292,6 +293,7 @@ static int compressed_section_fix(Elf *elf, Elf_Scn *scn, GElf_Shdr *sh)
>  	}
>  	return 0;
>  }
> +#endif
>  
>  static int elf_collect(struct object *obj)
>  {
> @@ -370,8 +372,10 @@ static int elf_collect(struct object *obj)
>  			obj->efile.idlist_addr  = sh.sh_addr;
>  		}
>  
> +#ifdef CONFIG_DEBUG_INFO_COMPRESSED
>  		if (compressed_section_fix(elf, scn, &sh))
>  			return -1;
> +#endif
>  	}
>  
>  	return 0;
> -- 
> 2.25.1
> 

