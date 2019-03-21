Return-Path: <SRS0=yvf5=RY=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3717BC43381
	for <bpf@archiver.kernel.org>; Thu, 21 Mar 2019 00:22:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F31D9218C3
	for <bpf@archiver.kernel.org>; Thu, 21 Mar 2019 00:22:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CETsi0Oz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727464AbfCUAWH (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 20 Mar 2019 20:22:07 -0400
Received: from mail-pf1-f169.google.com ([209.85.210.169]:37669 "EHLO
        mail-pf1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbfCUAWH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 Mar 2019 20:22:07 -0400
Received: by mail-pf1-f169.google.com with SMTP id 8so3102809pfr.4;
        Wed, 20 Mar 2019 17:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=STdkHujJ71al87EYN7gkgdW/JSoDS67uOSAyBHwlfGg=;
        b=CETsi0OzfHbPsq3fgNrP81bOau5NbGJi/b2OyCdYNuPMMgpQvSfVHE86R76Y21TShm
         8vDURJoC+KZ3EujMoOmHqZPK/LQ8DzRokErCSXqHBMD4QLc3nKWoEm3+DFPMkKxMxilE
         Cm7RhTPVD/S6hDBi0rrKY/ZGFzCZGjltuGaR2256M4PNExAwzVbByRJ5TOn0NiyDA8MK
         wVViJar+R0Sqvr6O/h21/FEcAxh5uvXYpOEgX3H+Ib5xrbCmyplTCPCopsaa190923Tg
         FnUcTlhTcr6I4nsjnvS3EGkShzTzAlU604eKCPyPsgsXqTKOrDNiPZcWYzvEJk1ismlC
         1tRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=STdkHujJ71al87EYN7gkgdW/JSoDS67uOSAyBHwlfGg=;
        b=AaBJ9L9QUtXoaAb8eTkRO9s9c+fCBVE/hBqasKFQjDH3F/5Qwr5w+HurwMZ6SB8x34
         6+G8DfNLM8oOmGuCFOQdlH6lE22yuE+dlBH1yadob0hzWB/hVPfCJVwQwCRJAzmM4Lpt
         7Y/pI6e6WzZMCa8XcWZax33wACwI1YTidUEuu31Ytmx6VSqLdDBxO62xVfk9daLvEp+j
         q8H70v8DIHHb0Sbdh2G/0N9hjBUgFX5gWzhx9sBVY+tZAcD5tEHGbPkAmzVptRZrUdPc
         +SvdynYoim0NUm8AuQMDGmqyWdgOB2YkKAhGM/VoT/L5/encAklI1mpVzoHL3DfL5NPe
         Xriw==
X-Gm-Message-State: APjAAAWWzqkkrlkY8iGqpuSa24/u5PoVI4SAK5943gvD2pUzVVsJNngw
        SWHyW/mTmibeR0Kz59UCio8=
X-Google-Smtp-Source: APXvYqxNx5J4ag6qw+cdylUfZInTAXoXCoM6NYWw49tqwssBvTfoeytcmEZAAYfOXRgVhZUeNDwpnA==
X-Received: by 2002:a65:6241:: with SMTP id q1mr741756pgv.340.1553127726228;
        Wed, 20 Mar 2019 17:22:06 -0700 (PDT)
Received: from localhost ([110.70.50.223])
        by smtp.gmail.com with ESMTPSA id f7sm3740398pgf.48.2019.03.20.17.22.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Mar 2019 17:22:05 -0700 (PDT)
Date:   Thu, 21 Mar 2019 09:22:01 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Stanislav Fomichev <sdf@fomichev.me>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [PATCHv2 bpf-next 1/3] bpf, tests: tweak endianness selection
Message-ID: <20190321002201.GA2097@jagdpanzerIV>
References: <20190320125335.19621-1-sergey.senozhatsky@gmail.com>
 <20190320171332.GJ7431@mini-arch.hsd1.ca.comcast.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190320171332.GJ7431@mini-arch.hsd1.ca.comcast.net>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On (03/20/19 10:13), Stanislav Fomichev wrote:
> Tested them locally with the compiler I saw the initial issues with - all
> fine, I don't see any errors with the older gcc.

Thanks!

> One last question I have is: what happens in the llvm+bpf case? Have
> you tested that? I think LLVM has all the builtins required, but since
> we are relying on the swab.h now (and it relies on
> __HAVE_BUILTIN_BSWAP16__), I wonder whether this detection works
> correctly on the llvm when targeting bpf. (sidenote: bpf_endian.h can be
> used from both userspace and bpf programs).

Honestly, I haven't, but I think we should be fine.

For !__HAVE_BUILTIN_BSWAP16__ compilers we still do constant folding.
swab16/swab32 turn into

	__builtin_constant_p((__u16)(x)) ? ___constant_swab16(x) : __fswab16(x))
and
	__builtin_constant_p((__u32)(x)) ? ___constant_swab32(x) : __fswab32(x))

clang/llvm support __builtin_constant_p GCC extension [1]:

 : Clang supports a number of builtin library functions with the same
 : syntax as GCC, including things like __builtin_nan, __builtin_constant_p,
 : __builtin_choose_expr, __builtin_types_compatible_p,
 : __builtin_assume_aligned, __sync_fetch_and_add, etc.

So clang should be able to detect swab on a compile time constant and
optimize it.

[1] https://clang.llvm.org/docs/LanguageExtensions.html

	-ss
