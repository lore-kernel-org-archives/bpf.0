Return-Path: <SRS0=yvf5=RY=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2355DC43381
	for <bpf@archiver.kernel.org>; Thu, 21 Mar 2019 05:08:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1806218AE
	for <bpf@archiver.kernel.org>; Thu, 21 Mar 2019 05:08:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qTfV+d+O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725995AbfCUFI6 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 21 Mar 2019 01:08:58 -0400
Received: from mail-pf1-f169.google.com ([209.85.210.169]:40854 "EHLO
        mail-pf1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbfCUFI6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Mar 2019 01:08:58 -0400
Received: by mail-pf1-f169.google.com with SMTP id c207so3538034pfc.7;
        Wed, 20 Mar 2019 22:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ts0k1KLhxSA6pa4Cq5wsJpOKYXo4qR+TuzuzqbvehaE=;
        b=qTfV+d+OLIqVbix2l3vyWubMOKdZlvwsLDP+TrEnXuXDXVgO1ONsuB1kKsmBisQvku
         Ug05p7aO07efhTzmvLpMl/gsvbziMCqsbsiH6K79Rs4DecRzhOWKdvkcpZLsRMzO0AAe
         TcFLxWh6d5qEGf389lEkYqqtYTl4iR96rVSNBxMuwi0HgEg4h+/LnWFdSwUM08pOj0DD
         aCDJNkZhbvyiJ9Vu0Zomjp8jum19gHoEgXedeTXLEBbMTQ9qgZcTWjpn0gR+wxKoXCIZ
         ePsKDRIaygh4nKIl/zlFcrTJ3CS/pCSnO+GA8RvJnUOffYQ8OROL2sNCPt/QWZm549zx
         cs5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ts0k1KLhxSA6pa4Cq5wsJpOKYXo4qR+TuzuzqbvehaE=;
        b=KdQhWroqx9scjazHIRkmLL9PrjOa2ZOmhisZk9PGvCRQPEVBG3MH35wEN+aoct9k8w
         Qh6Jn5Y/TfSsX3/oWtVkdCz522ogl8eFBKIn3u2O2FuXxRnB4aZD05iZKj/fkbM59D45
         Y9aDe5kybx69eZhlwBfKLDhuMwAJRMQzhXSGsny3q0uSD6GnFS+7Maqflosu8K3sNVnw
         nApe+V2lSVDUF+HdMfm5355o2EqJAKo90oq5STy8Eq2b9bRfJuPAfy+Ie9JRgKjj0VWu
         7svl08WSaYAz6BMQG7c1UvH9W1hGuPielCH2zMFrj+7w1VjxgpLWaZF6EewosaHyPblG
         7AdQ==
X-Gm-Message-State: APjAAAXHJmLqQ2KdvD0EXGW4b5++jrputZMZdSxhjyeVs3HFIj5LUnyK
        ynF3eOMaYw0HBkkIRz80o6k=
X-Google-Smtp-Source: APXvYqyImTJ3FfjKnwMmDXsu5vps2zah1fEl+nb/y8P5gYSGb6Vp8SM8wVJFdxnOJsZuLNoC8CVC2Q==
X-Received: by 2002:a65:6548:: with SMTP id a8mr1650470pgw.103.1553144937055;
        Wed, 20 Mar 2019 22:08:57 -0700 (PDT)
Received: from localhost ([110.70.50.223])
        by smtp.gmail.com with ESMTPSA id 202sm4987243pfc.86.2019.03.20.22.08.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Mar 2019 22:08:56 -0700 (PDT)
Date:   Thu, 21 Mar 2019 14:08:52 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
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
Message-ID: <20190321050852.GA1534@jagdpanzerIV>
References: <20190320125335.19621-1-sergey.senozhatsky@gmail.com>
 <20190321032429.2e7jddbltblaekjc@ast-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190321032429.2e7jddbltblaekjc@ast-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On (03/20/19 20:24), Alexei Starovoitov wrote:
> On Wed, Mar 20, 2019 at 09:53:33PM +0900, Sergey Senozhatsky wrote:
> > Not all compilers have __builtin_bswap16() and __builtin_bswap32(),
> > thus not all compilers are able to compile the following code:
> > 
> >         (__builtin_constant_p(x) ? \
> >                 ___constant_swab16(x) : __builtin_bswap16(x))
> > 
> > That's the reason why bpf_ntohl() doesn't work on GCC < 4.8, for
> > instance:
> 
> nack to fixes to support such old compilers.

Fair enough.

	-ss
