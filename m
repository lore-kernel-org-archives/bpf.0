Return-Path: <SRS0=US5c=RX=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 337A2C43381
	for <bpf@archiver.kernel.org>; Wed, 20 Mar 2019 17:13:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F174420850
	for <bpf@archiver.kernel.org>; Wed, 20 Mar 2019 17:13:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fomichev-me.20150623.gappssmtp.com header.i=@fomichev-me.20150623.gappssmtp.com header.b="Vpjy3puJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727055AbfCTRNf (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 20 Mar 2019 13:13:35 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45957 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726449AbfCTRNf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 Mar 2019 13:13:35 -0400
Received: by mail-pf1-f195.google.com with SMTP id v21so2360452pfm.12
        for <bpf@vger.kernel.org>; Wed, 20 Mar 2019 10:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fomichev-me.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CKeoIChyeUmrTBsKsb73mPefe68iJ/ZFcWoOHnJb9NA=;
        b=Vpjy3puJLElgbQr8aZ7EXhnzVlf4+Z0CbAmWN89zuOZTiXMoa8QRAmRT1cusL7BeBq
         h1ZS+nErp0OVi6o5ZB6c60WpiDdZE89BqFB3WxzfMCusouOdXPkxcK54kuKMUkvgEF3p
         IM9iVPKYEc13yT8sDFnui4ATLUtkwA6E111pPtrUL3Oeg81UYdu74orhnFdEMNEQnO9O
         f42wtnuYWVWAalbmnjOQierFsGRZcduvNmX3vn4o/vjwjIcfMhYGEB4a2qNtRJLjFOMU
         veLQwSrBdsYnWinkOyD5I3+R3Ih1HC00b69tUjVldZ+GJKJ12jAUDcevLBhWqOx9XoPb
         UJsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CKeoIChyeUmrTBsKsb73mPefe68iJ/ZFcWoOHnJb9NA=;
        b=jr+L9aj9XNeGz/rTySJsZzhJ7VwB2hXTIDgB9nEDO9XuNmE5NimndbkpLAspWiOIU0
         ykqPFVVCwUXnH7/xH7N8nODSR388YKraKwx4S9P6nf+V6xidgSokFXvOqbtCE2BehBX1
         Wgkns34QVCTkipA4WL/+cuNsPWyeG0V2kxIcahi37qMv22hLa/IR9DaRfTUbTWQndNXL
         xtGZSnuBUN4D+8gPeewF+IvbLaZmok65+OAnP7jjIbdQcRlFPT09u4vRNoiKtzqhsVii
         8FoGh1F8jYKf+nd5rGNTjj53Um9no4gya/C7YtbXjDytqzCOsSE7QzENB3KV+wNDsNPn
         EpFA==
X-Gm-Message-State: APjAAAUj2IoWY4gstG+1/QZzojysFfNUp0+ZJH2bh6mdiw38kztnAo8H
        f2VZQtXAplyxTj/VuXuodAdZuA==
X-Google-Smtp-Source: APXvYqwixRnfUhsoo7fYJdaiBsJt+8lW5G4PXBSK0GHRYZvaWDPWNuki2bHGhisZvWpCtAFXZ/RaWQ==
X-Received: by 2002:a17:902:2e03:: with SMTP id q3mr8912440plb.166.1553102013776;
        Wed, 20 Mar 2019 10:13:33 -0700 (PDT)
Received: from localhost ([2601:646:8f00:18d9:d0fa:7a4b:764f:de48])
        by smtp.gmail.com with ESMTPSA id l19sm3260945pff.185.2019.03.20.10.13.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Mar 2019 10:13:33 -0700 (PDT)
Date:   Wed, 20 Mar 2019 10:13:32 -0700
From:   Stanislav Fomichev <sdf@fomichev.me>
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Shuah Khan <shuah@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [PATCHv2 bpf-next 1/3] bpf, tests: tweak endianness selection
Message-ID: <20190320171332.GJ7431@mini-arch.hsd1.ca.comcast.net>
References: <20190320125335.19621-1-sergey.senozhatsky@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190320125335.19621-1-sergey.senozhatsky@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 03/20, Sergey Senozhatsky wrote:
> Not all compilers have __builtin_bswap16() and __builtin_bswap32(),
> thus not all compilers are able to compile the following code:
> 
>         (__builtin_constant_p(x) ? \
>                 ___constant_swab16(x) : __builtin_bswap16(x))
> 
> That's the reason why bpf_ntohl() doesn't work on GCC < 4.8, for
> instance:
> 
>         error: implicit declaration of function '__builtin_bswap16'
> 
> We can use __builtin_bswap16() only if compiler has this built-in,
> that is, only if __HAVE_BUILTIN_BSWAP16__ is defined. Standard UAPI
> __swab16()/__swab32() take care of that, and, additionally, handle
> __builtin_constant_p() cases as well:
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
> 
> v2: fixed build error, reshuffled patches (Stanislav Fomichev)
Tested them locally with the compiler I saw the initial issues with - all
fine, I don't see any errors with the older gcc.

One last question I have is: what happens in the llvm+bpf case? Have
you tested that? I think LLVM has all the builtins required, but since
we are relying on the swab.h now (and it relies on
__HAVE_BUILTIN_BSWAP16__), I wonder whether this detection works
correctly on the llvm when targeting bpf. (sidenote: bpf_endian.h can be
used from both userspace and bpf programs).

> 
>  tools/testing/selftests/bpf/bpf_endian.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/bpf_endian.h b/tools/testing/selftests/bpf/bpf_endian.h
> index b25595ea4a78..1ed268b2002b 100644
> --- a/tools/testing/selftests/bpf/bpf_endian.h
> +++ b/tools/testing/selftests/bpf/bpf_endian.h
> @@ -20,12 +20,12 @@
>   * use different targets.
>   */
>  #if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
> -# define __bpf_ntohs(x)			__builtin_bswap16(x)
> -# define __bpf_htons(x)			__builtin_bswap16(x)
> +# define __bpf_ntohs(x)			__swab16(x)
> +# define __bpf_htons(x)			__swab16(x)
>  # define __bpf_constant_ntohs(x)	___constant_swab16(x)
>  # define __bpf_constant_htons(x)	___constant_swab16(x)
> -# define __bpf_ntohl(x)			__builtin_bswap32(x)
> -# define __bpf_htonl(x)			__builtin_bswap32(x)
> +# define __bpf_ntohl(x)			__swab32(x)
> +# define __bpf_htonl(x)			__swab32(x)
>  # define __bpf_constant_ntohl(x)	___constant_swab32(x)
>  # define __bpf_constant_htonl(x)	___constant_swab32(x)
>  #elif __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
> -- 
> 2.21.0
> 
