Return-Path: <SRS0=wUMJ=RW=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF28FC43381
	for <bpf@archiver.kernel.org>; Tue, 19 Mar 2019 16:01:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B410F206B7
	for <bpf@archiver.kernel.org>; Tue, 19 Mar 2019 16:01:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fomichev-me.20150623.gappssmtp.com header.i=@fomichev-me.20150623.gappssmtp.com header.b="DtEABpFi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727102AbfCSQBT (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 19 Mar 2019 12:01:19 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46365 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726763AbfCSQBT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 Mar 2019 12:01:19 -0400
Received: by mail-pg1-f196.google.com with SMTP id a22so14122069pgg.13
        for <bpf@vger.kernel.org>; Tue, 19 Mar 2019 09:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fomichev-me.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SgZYRRELtQG8y/urfWvwSdwlCQCW9WSctv0L7J618BY=;
        b=DtEABpFifeVhkG6R6gtahcQM/ajdrW6mtGQIGo1jWw2HLDURff4ASx9RKtJy2egz5l
         /lWAhu7AMTTGOAQzgm/aieEhfBHEGHouZ3AyCMwUsNnmkgIDdErM0+O65dvr5PvDen6S
         pA41brzF7YUh8YaNDiSXAI25OMAwcPWZ7vDj3sC97/zUdpdAaiVpOUmbNI4u64kzWJJZ
         t89d3+bnLos0A0EMnM49gWwaAW5qtZyjVJIU4JTJ1NMybKIW7atzN6JlfrG7QEYHwoIT
         fFqK5BBDizCzH0vuGw3gm3YEgsKI7QSLI/qeYevq73d+90bq7bzWfyDn9MpHKrX4joR5
         Le0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SgZYRRELtQG8y/urfWvwSdwlCQCW9WSctv0L7J618BY=;
        b=FbNOCRbBSjq8R7A8mXBfSo+6Hq3fIXMJ+Fa0rw5bPSAn0smZOn8Z4KITH80PUOpEBp
         3z69i7BUEI2zgB5RZ4cOozX4vwEuj1j0FhlW1lzD2odnx/cdTlpTiJhDs2JFmInrqtz1
         WYlsNW5Ba2ykPVpwHnGiniY+49ENz5pQbqMH8vH+2gRBRHhwj4NyfuRLDLlDNAxOH7RR
         bpxpUOnTRCl3BZtULWZR1MBcbhXKX7tv67En4ULwKUWhSB4lAinxErPOPiM8FhNfqjGW
         8LTbutnHrXwODePo2j8sCNBdw9Hprb1uwiylKU8b6C140P0vO+0mquhi1KowyqgMKwSP
         Qx+w==
X-Gm-Message-State: APjAAAUSn18AdENJkr2ghm2a5QEsCD2SAHArmPBA+LgSCXqq4kiV0vGO
        at8qyhKhbuAgPMkj6mYfO8V2qQ==
X-Google-Smtp-Source: APXvYqwx1S2vhTSfBs6U06DVzOnDPbhnZoeD3g5reKIX9tjLJR7z/dXMD67YndScAGemi3hsloiWKQ==
X-Received: by 2002:a63:d30b:: with SMTP id b11mr2536760pgg.116.1553011277566;
        Tue, 19 Mar 2019 09:01:17 -0700 (PDT)
Received: from localhost ([2601:646:8f00:18d9:d0fa:7a4b:764f:de48])
        by smtp.gmail.com with ESMTPSA id g25sm10304757pfi.36.2019.03.19.09.01.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Mar 2019 09:01:16 -0700 (PDT)
Date:   Tue, 19 Mar 2019 09:01:15 -0700
From:   Stanislav Fomichev <sdf@fomichev.me>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Shuah Khan <shuah@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCH] bpf, tests: tweak endianness selection
Message-ID: <20190319160115.GD7431@mini-arch.hsd1.ca.comcast.net>
References: <20190319023331.23207-1-sergey.senozhatsky@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190319023331.23207-1-sergey.senozhatsky@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 03/19, Sergey Senozhatsky wrote:
> Not all compilers have __builtin_bswap16() and __builtin_bswap32(),
> thus not all compilers are able to compile the following code
> (bpf_htons):
> 
> 	(__builtin_constant_p(x) ? \
> 	 	___constant_swab16(x) : __builtin_bswap16(x))
> 
> That's why, for instance, bpf_htons() doesn't work on GCC < 4.8:
> 
> 	error: implicit declaration of function '__builtin_bswap16'
> 
> We can use __builtin_bswap16() only if compiler has this built-in,
> that is, only if __HAVE_BUILTIN_BSWAP16__ is defined. Standard UAPI
> __swab16()/__swab32() take care of that, and, additionally, handle
> __builtin_constant_p() cases as well (if compiler doesn't provide
> builtin bswap with constants folding):
> 
>  #ifdef __HAVE_BUILTIN_BSWAP16__
>  #define __swab16(x) (__u16)__builtin_bswap16((__u16)(x))
>  #else
>  #define __swab16(x)                             \
>          (__builtin_constant_p((__u16)(x)) ?     \
>          ___constant_swab16(x) :                 \
>          __fswab16(x))
>  #endif
> 
> So we can tweak selftests/bpf/bpf_endian.h and use UAPI
> __swab16()/__swab32().
> 
> Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> ---
>  tools/testing/selftests/bpf/bpf_endian.h | 37 +++++-------------------
>  1 file changed, 8 insertions(+), 29 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/bpf_endian.h b/tools/testing/selftests/bpf/bpf_endian.h
> index b25595ea4a78..ba06222963d5 100644
> --- a/tools/testing/selftests/bpf/bpf_endian.h
> +++ b/tools/testing/selftests/bpf/bpf_endian.h
> @@ -20,38 +20,17 @@
>   * use different targets.
>   */
>  #if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
> -# define __bpf_ntohs(x)			__builtin_bswap16(x)
> -# define __bpf_htons(x)			__builtin_bswap16(x)
> -# define __bpf_constant_ntohs(x)	___constant_swab16(x)
> -# define __bpf_constant_htons(x)	___constant_swab16(x)
This breaks the build until your next patch is applied (in other
words, breaks bisection). Can we do it in three steps?
Convert to swab (without breaking existing tests), convert the tests,
remove unused __bpf_xyz defines?

Could you also send it as a series (git format-patch --thread)? Those
patches depend on each other. And pls use [PATCH bpf-next] ... subj.

> -# define __bpf_ntohl(x)			__builtin_bswap32(x)
> -# define __bpf_htonl(x)			__builtin_bswap32(x)
> -# define __bpf_constant_ntohl(x)	___constant_swab32(x)
> -# define __bpf_constant_htonl(x)	___constant_swab32(x)
> +# define bpf_ntohs(x)		__swab16(x)
> +# define bpf_htons(x)		__swab16(x)
> +# define bpf_ntohl(x)		__swab32(x)
> +# define bpf_htonl(x)		__swab32(x)
>  #elif __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
> -# define __bpf_ntohs(x)			(x)
> -# define __bpf_htons(x)			(x)
> -# define __bpf_constant_ntohs(x)	(x)
> -# define __bpf_constant_htons(x)	(x)
> -# define __bpf_ntohl(x)			(x)
> -# define __bpf_htonl(x)			(x)
> -# define __bpf_constant_ntohl(x)	(x)
> -# define __bpf_constant_htonl(x)	(x)
> +# define bpf_ntohs(x)		(x)
> +# define bpf_htons(x)		(x)
> +# define bpf_ntohl(x)		(x)
> +# define bpf_htonl(x)		(x)
>  #else
>  # error "Fix your compiler's __BYTE_ORDER__?!"
>  #endif
>  
> -#define bpf_htons(x)				\
> -	(__builtin_constant_p(x) ?		\
> -	 __bpf_constant_htons(x) : __bpf_htons(x))
> -#define bpf_ntohs(x)				\
> -	(__builtin_constant_p(x) ?		\
> -	 __bpf_constant_ntohs(x) : __bpf_ntohs(x))
> -#define bpf_htonl(x)				\
> -	(__builtin_constant_p(x) ?		\
> -	 __bpf_constant_htonl(x) : __bpf_htonl(x))
> -#define bpf_ntohl(x)				\
> -	(__builtin_constant_p(x) ?		\
> -	 __bpf_constant_ntohl(x) : __bpf_ntohl(x))
> -
>  #endif /* __BPF_ENDIAN__ */
> -- 
> 2.21.0
> 
