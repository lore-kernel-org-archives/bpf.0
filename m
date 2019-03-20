Return-Path: <SRS0=US5c=RX=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A60B4C10F05
	for <bpf@archiver.kernel.org>; Wed, 20 Mar 2019 22:28:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74D1D218B0
	for <bpf@archiver.kernel.org>; Wed, 20 Mar 2019 22:28:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fomichev-me.20150623.gappssmtp.com header.i=@fomichev-me.20150623.gappssmtp.com header.b="XuE/r9ro"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727569AbfCTW2D (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 20 Mar 2019 18:28:03 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45646 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727541AbfCTW2D (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 Mar 2019 18:28:03 -0400
Received: by mail-pf1-f196.google.com with SMTP id v21so2902643pfm.12
        for <bpf@vger.kernel.org>; Wed, 20 Mar 2019 15:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fomichev-me.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1SYRjQSPP2Ne0ZHRYNvOiB8TmnTsw4qO+UFvKv8l9mk=;
        b=XuE/r9rosaoK0tyOgzc2kTeRqtMey5TjbjqhLPR4nsh7el9ImI1RswqILvrJ9Dni2k
         UDWnbO/t1z82Zlu7scKBvXC7JliSgLoL2z6gkLi/tqgxEIFyfXejV6THgPhFQd8t4IjS
         SmGt/V7jpLR1U+ZegqktFnv4Qys1n6ZHl3VuzkAHa3aI2dng+J4kdcyFtw7ve3fXkeTy
         ZIfOR9PwKRCaDJERcMpJiXVYT1pC+05KRsTWiYkEIIZwy9iiaS2W98z/szbcMqj+Pqy7
         VLPKNCUak3jlZzG8Sk1rhi6S/2LwjxQ6ghzANFv/PXEBnDVTrOCPZj2evOYY8/lBzo+4
         G9Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1SYRjQSPP2Ne0ZHRYNvOiB8TmnTsw4qO+UFvKv8l9mk=;
        b=W9KjiGIOPTRJG1nBakohd7N+DUpP/VHuZhEb52kLZJ+EktkUMEEn56M2aEukKkhn8W
         LsqZDzTJ5I+lWAfsIXtMSZa1pbNyZLbev8zGigFZQ0RTJcOcWio78kt+pMj6Ivv7wFfG
         vicUZMEUXwoCPts2lz+rs6KFx1z+ojkNQ5QBAzJJRWoQAqPclGDGlnPRFSXYmdfcqh9l
         9Cc43ZGlZhobqe115wtSlW6QrAN6EsYCFmUvN0AhNxQIu2gT3lBx84S2klYTo2zOtyTw
         6ppiGsPbPkCnvPITZbl/QTB1D+pYikBi1C3KgRDfbd29BKbTTUVE8+4sLMg3SM56torx
         bATA==
X-Gm-Message-State: APjAAAVl6xJY30oQkpE3bQKZjyEE8dwD7sahc3muAOfuZSGE6/kkvBZl
        ck/NvN/5Zr/e9/oH1xVOqMHZEQ==
X-Google-Smtp-Source: APXvYqyKGrleGJ5a8/g6M7t9UDtuOz6aynJgQ5vlPVxrJmY0DSzmQYLEc+miH/6mAiqHGdxu0nSfkw==
X-Received: by 2002:a17:902:9688:: with SMTP id n8mr152782plp.133.1553120881981;
        Wed, 20 Mar 2019 15:28:01 -0700 (PDT)
Received: from localhost ([2601:646:8f00:18d9:d0fa:7a4b:764f:de48])
        by smtp.gmail.com with ESMTPSA id v4sm5603768pff.181.2019.03.20.15.28.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Mar 2019 15:28:00 -0700 (PDT)
Date:   Wed, 20 Mar 2019 15:27:59 -0700
From:   Stanislav Fomichev <sdf@fomichev.me>
To:     Yonghong Song <yhs@fb.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [PATCHv2 bpf-next 1/3] bpf, tests: tweak endianness selection
Message-ID: <20190320222759.GQ7431@mini-arch.hsd1.ca.comcast.net>
References: <20190320125335.19621-1-sergey.senozhatsky@gmail.com>
 <20190320171332.GJ7431@mini-arch.hsd1.ca.comcast.net>
 <4c6db4e5-8e77-2e01-a4ab-25808df2b857@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c6db4e5-8e77-2e01-a4ab-25808df2b857@fb.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 03/20, Yonghong Song wrote:
> 
> 
> On 3/20/19 10:13 AM, Stanislav Fomichev wrote:
> > On 03/20, Sergey Senozhatsky wrote:
> >> Not all compilers have __builtin_bswap16() and __builtin_bswap32(),
> >> thus not all compilers are able to compile the following code:
> >>
> >>          (__builtin_constant_p(x) ? \
> >>                  ___constant_swab16(x) : __builtin_bswap16(x))
> >>
> >> That's the reason why bpf_ntohl() doesn't work on GCC < 4.8, for
> >> instance:
> >>
> >>          error: implicit declaration of function '__builtin_bswap16'
> >>
> >> We can use __builtin_bswap16() only if compiler has this built-in,
> >> that is, only if __HAVE_BUILTIN_BSWAP16__ is defined. Standard UAPI
> >> __swab16()/__swab32() take care of that, and, additionally, handle
> >> __builtin_constant_p() cases as well:
> >>
> >>   #ifdef __HAVE_BUILTIN_BSWAP16__
> >>   #define __swab16(x) (__u16)__builtin_bswap16((__u16)(x))
> >>   #else
> >>   #define __swab16(x)                             \
> >>           (__builtin_constant_p((__u16)(x)) ?     \
> >>           ___constant_swab16(x) :                 \
> >>           __fswab16(x))
> >>   #endif
> >>
> >> So we can tweak selftests/bpf/bpf_endian.h and use UAPI
> >> __swab16()/__swab32().
> >>
> >> Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> >> ---
> >>
> >> v2: fixed build error, reshuffled patches (Stanislav Fomichev)
> > Tested them locally with the compiler I saw the initial issues with - all
> > fine, I don't see any errors with the older gcc.
> > 
> > One last question I have is: what happens in the llvm+bpf case? Have
> > you tested that? I think LLVM has all the builtins required, but since
> > we are relying on the swab.h now (and it relies on
> > __HAVE_BUILTIN_BSWAP16__), I wonder whether this detection works
> > correctly on the llvm when targeting bpf. (sidenote: bpf_endian.h can be
> > used from both userspace and bpf programs).
> 
> Inside kernel clang compiler header (linux/compiler-clang.h) does not 
> define __HAVE_BUILTIN_BSWAP16__. So it will go to the "else" branch in 
> the above. So I think it should work with clang + bpf.
Hm, isn't it the opposite of what we want then? I think for llvm+bpf we always
want to use the builtins to make it properly generate
BPF_TO_BE/BPF_TO_LE instructions.

> > 
> >>
> >>   tools/testing/selftests/bpf/bpf_endian.h | 8 ++++----
> >>   1 file changed, 4 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/tools/testing/selftests/bpf/bpf_endian.h b/tools/testing/selftests/bpf/bpf_endian.h
> >> index b25595ea4a78..1ed268b2002b 100644
> >> --- a/tools/testing/selftests/bpf/bpf_endian.h
> >> +++ b/tools/testing/selftests/bpf/bpf_endian.h
> >> @@ -20,12 +20,12 @@
> >>    * use different targets.
> >>    */
> >>   #if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
> >> -# define __bpf_ntohs(x)			__builtin_bswap16(x)
> >> -# define __bpf_htons(x)			__builtin_bswap16(x)
> >> +# define __bpf_ntohs(x)			__swab16(x)
> >> +# define __bpf_htons(x)			__swab16(x)
> >>   # define __bpf_constant_ntohs(x)	___constant_swab16(x)
> >>   # define __bpf_constant_htons(x)	___constant_swab16(x)
> >> -# define __bpf_ntohl(x)			__builtin_bswap32(x)
> >> -# define __bpf_htonl(x)			__builtin_bswap32(x)
> >> +# define __bpf_ntohl(x)			__swab32(x)
> >> +# define __bpf_htonl(x)			__swab32(x)
> >>   # define __bpf_constant_ntohl(x)	___constant_swab32(x)
> >>   # define __bpf_constant_htonl(x)	___constant_swab32(x)
> >>   #elif __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
> >> -- 
> >> 2.21.0
> >>
