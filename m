Return-Path: <SRS0=yvf5=RY=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E6EDC43381
	for <bpf@archiver.kernel.org>; Thu, 21 Mar 2019 03:24:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BA65218A5
	for <bpf@archiver.kernel.org>; Thu, 21 Mar 2019 03:24:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n58TlX87"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727871AbfCUDYe (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 20 Mar 2019 23:24:34 -0400
Received: from mail-pg1-f176.google.com ([209.85.215.176]:35927 "EHLO
        mail-pg1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727507AbfCUDYe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 Mar 2019 23:24:34 -0400
Received: by mail-pg1-f176.google.com with SMTP id r124so3275928pgr.3;
        Wed, 20 Mar 2019 20:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=J3gG8YnnG2xGQfmkVWeNgUXyYgDXrAFghqQHDeLVZ6M=;
        b=n58TlX87mIHnHmRQSBDxOY9vDrVSj+R51aSrCRG8LLymCVKPhaRMUA+jL81Ia3SVN5
         w8qLLaaQG8NaA3Xx8jQMpaJnNhS1liL1ovC6mmcDCTQ0CNHyWf4Gp66cUyi6AN7jOPxw
         F5JP1iMfZg7VlLzXOL8NH5QLppRjrCAswttB8WDSRcYR2NC92rh3/FXzufsYdTsYgnB8
         b4iDmqXq1LP7vGG3jr4bX5Y9al6RuPDxzfsNN977TWWRsmEPpM0Fr04dYeUJPcDy9CpN
         Vc74x20kIRwFQiRY4NMgi2qfH+FhtGFTmyd61AOWU7I1KIytDMINdB92+pe2vnhdAjvl
         BFfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=J3gG8YnnG2xGQfmkVWeNgUXyYgDXrAFghqQHDeLVZ6M=;
        b=DcHW5Uw6mmeaEvtraqScuAxcKpizuMrSyhr98j1YnqvUrhCdf0cgr6D/gN7I1fsARC
         IxGmNTkzv+cESoiUGqf3qqmHGgNIISlMZJe1VIsbRDFnFWQXieA+XHqqPp2uNM9oZaOA
         Yl6VKVdLVBt6N9zmMcMEN5+O3u4wrruSTw74+J/v/LNpc8JslQOIrKobXs79lsbN5Ths
         yElcLyfOHQSHZSroxcGggbF9wT2xj+vclA9/Nr0ngFPAhX/FRdZy1XrtxFjnVg0oTJRQ
         6+R78CCfHtZYqBTYvImvxgAqjE4QdgnOB/EHVI9klUEZLj/L4CrVcAFdoEZx95SGEyAY
         RCig==
X-Gm-Message-State: APjAAAUnmpFyUI7WsTmGOwrYc5DA0QeUZffbsu9EkKgu/RrwJTiK8fxO
        lACAl+MZyGOlCNaugQsL7Fg=
X-Google-Smtp-Source: APXvYqynJDxwKz7+31JixM9zBZxJTbmBfyO0s0SZKH6UDC0L8SKiPQHG1oxYUgXZgVPPwyvlikbv/g==
X-Received: by 2002:a17:902:9008:: with SMTP id a8mr1327747plp.38.1553138673747;
        Wed, 20 Mar 2019 20:24:33 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:180::c891])
        by smtp.gmail.com with ESMTPSA id y14sm5573421pgg.6.2019.03.20.20.24.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2019 20:24:32 -0700 (PDT)
Date:   Wed, 20 Mar 2019 20:24:30 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Shuah Khan <shuah@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [PATCHv2 bpf-next 1/3] bpf, tests: tweak endianness selection
Message-ID: <20190321032429.2e7jddbltblaekjc@ast-mbp.dhcp.thefacebook.com>
References: <20190320125335.19621-1-sergey.senozhatsky@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190320125335.19621-1-sergey.senozhatsky@gmail.com>
User-Agent: NeoMutt/20180223
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 20, 2019 at 09:53:33PM +0900, Sergey Senozhatsky wrote:
> Not all compilers have __builtin_bswap16() and __builtin_bswap32(),
> thus not all compilers are able to compile the following code:
> 
>         (__builtin_constant_p(x) ? \
>                 ___constant_swab16(x) : __builtin_bswap16(x))
> 
> That's the reason why bpf_ntohl() doesn't work on GCC < 4.8, for
> instance:

nack to fixes to support such old compilers.

