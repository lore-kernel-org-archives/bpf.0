Return-Path: <SRS0=yvf5=RY=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70C0CC43381
	for <bpf@archiver.kernel.org>; Thu, 21 Mar 2019 15:49:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E9EC218E2
	for <bpf@archiver.kernel.org>; Thu, 21 Mar 2019 15:49:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fomichev-me.20150623.gappssmtp.com header.i=@fomichev-me.20150623.gappssmtp.com header.b="eRTZ5yWU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728528AbfCUPtd (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 21 Mar 2019 11:49:33 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40694 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728570AbfCUPtb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Mar 2019 11:49:31 -0400
Received: by mail-pg1-f194.google.com with SMTP id u9so4463251pgo.7
        for <bpf@vger.kernel.org>; Thu, 21 Mar 2019 08:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fomichev-me.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5I+OlaKnQTe0DlSxwVdiOq8OWO2x7dsn0d2mdijCKto=;
        b=eRTZ5yWUxu8cLzpcWc6uX3c9ZGG4IqqdpPxSKzK40yE54yk2uHoHbSV68Nmc0B/T93
         DQhtrfSCB3q2cRIjlPLgeN97hdW8BMGKILm8GMVkY3/SEiwWKjyrOEP8ehSjAqZTwWu3
         ZS+dtELU3fHUdX0Clav3Hhj+FCcKRevfAOw/vmXwAGVJNMojxwsh9LH/lIV6xJrkLDht
         8YxU8QtJ6RMHAigfTA7YtzFdX+fyhrtT9egbkMYj7T839jSlSIAZYi9XHNrvLT98cJNS
         jZrfxsdu0lZFb06bcuJ7sWdC3bgIlpTfDwrn0g4Bd6KR4u7RaDTvuot099cl2pSl/xVh
         cQzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5I+OlaKnQTe0DlSxwVdiOq8OWO2x7dsn0d2mdijCKto=;
        b=bBrI3H8oL7czeNe8oUx7ilDsnVlozW0joaCDMOajY1TCgaLB9YUiREOjlaNM396+4f
         xoyMW14HBS3URY7xpEUxLQdvouF8n+3nPYqDSunuhf+9txrcLfPx0fdiKMd9LxxgtWyy
         FmJ3lwqDm1SWgNwu6eklQ91pXOrJJnkiEHWgUhwkXGz+Y5HtT5VjAv+xO9/mLjmUJjbs
         Mt2xw7dKAj/SphqX79UWyXbH4xwsa02Htk0b7f8ydSQr5mEOpMLl8KgnRuJYZQntEA8n
         YWJpD8d7z9garfBsDLQkCDNkLNyH7a0T1bUsdMk146GePxngA93brzR/cIfdeAXZ44Ng
         c6Kg==
X-Gm-Message-State: APjAAAXNFgj0M8qLkBSxhL5BUgzR0yEzoJsaDdtjaculX+SJw1z7vYgY
        cIzoLPFVVpH38Q35yfWvgx1jKw==
X-Google-Smtp-Source: APXvYqzWAvvFE7RghX2cl0irv6No04B/cl2VKaVh5o7VxphZCSn+rkJ4AaKg6UguIYXAp0FJRGkt2w==
X-Received: by 2002:a63:2bcd:: with SMTP id r196mr3833424pgr.355.1553183370088;
        Thu, 21 Mar 2019 08:49:30 -0700 (PDT)
Received: from localhost ([2601:646:8f00:18d9:d0fa:7a4b:764f:de48])
        by smtp.gmail.com with ESMTPSA id d25sm493584pfn.152.2019.03.21.08.49.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Mar 2019 08:49:29 -0700 (PDT)
Date:   Thu, 21 Mar 2019 08:49:28 -0700
From:   Stanislav Fomichev <sdf@fomichev.me>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [PATCHv2 bpf-next 1/3] bpf, tests: tweak endianness selection
Message-ID: <20190321154928.GT7431@mini-arch.hsd1.ca.comcast.net>
References: <20190320125335.19621-1-sergey.senozhatsky@gmail.com>
 <20190321032429.2e7jddbltblaekjc@ast-mbp.dhcp.thefacebook.com>
 <20190321050852.GA1534@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190321050852.GA1534@jagdpanzerIV>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 03/21, Sergey Senozhatsky wrote:
> On (03/20/19 20:24), Alexei Starovoitov wrote:
> > On Wed, Mar 20, 2019 at 09:53:33PM +0900, Sergey Senozhatsky wrote:
> > > Not all compilers have __builtin_bswap16() and __builtin_bswap32(),
> > > thus not all compilers are able to compile the following code:
> > > 
> > >         (__builtin_constant_p(x) ? \
> > >                 ___constant_swab16(x) : __builtin_bswap16(x))
> > > 
> > > That's the reason why bpf_ntohl() doesn't work on GCC < 4.8, for
> > > instance:
> > 
> > nack to fixes to support such old compilers.
> 
> Fair enough.
What is too old? Documentation/process/changes.rst says that minimum
supported gcc is 4.6, do we lift that requirement for the tests?

> 	-ss
