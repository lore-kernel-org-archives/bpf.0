Return-Path: <SRS0=Kw1S=Q6=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30B2EC43381
	for <bpf@archiver.kernel.org>; Sat, 23 Feb 2019 02:38:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F284320700
	for <bpf@archiver.kernel.org>; Sat, 23 Feb 2019 02:38:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UL/llQTn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbfBWCiO (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 22 Feb 2019 21:38:14 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33706 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbfBWCiO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Feb 2019 21:38:14 -0500
Received: by mail-pl1-f194.google.com with SMTP id y10so1916490plp.0;
        Fri, 22 Feb 2019 18:38:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kyb8ZiyTfzCMKkyo7YIWgta+wwPH/+0FO/7FVI5Sp6Y=;
        b=UL/llQTnoIHPAl0vcnJBmjJhjzajZUSOjB3Hfq9voPvCwfKdvpQJrBJC217je3diE+
         yHpzMeWvKHPBH9EBLiMgfo58//htVpGqwS+h5FzBkk27EMqwReQYPoEQnnQtKjDBp6Fk
         1OqVjXip2AGjhrt/TNQwutaCFPuHFt69ACy3hwbeF20+ngRqpHdMqx9m7QruTFveW4Nj
         mWZYG8jOYmRpj1dEG+pNDsdPMEcP4m7y33CIKFLUP9tudevWI5fXE4hCZN+BjRaa81fw
         7fr6QG4TdwW+WJLgMNGWWAbys/J+GQckx4NhgSwsIzFhujy5VdRQi3DdIfqvYbSBIL7X
         FbIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kyb8ZiyTfzCMKkyo7YIWgta+wwPH/+0FO/7FVI5Sp6Y=;
        b=arQq1gHCyhr8O+hMQrsSzvfN7beTlZR7l6EM1THLXnpTJSqevgmCzXEiGldahXaeWH
         qPYtKMFgy10NT6NlP6CVuHoKkp7kGbAKsdnHfIm8SJssYIIsY2vGpeCkfG1Ck7+OLD6Q
         oFyhfXvD8fE2GN2ARNXxBJSvvqddyXbInzgNzsRIGLN7izgtLeSM4g3Zn4OO4dmkeaQM
         amF5epzwcSXHqmpou7KXXYTeWmEaiyOLdpCe88kwUIPm9vMYQNEWusz02tXrVH470N5i
         M1QTPAri4yUblrWy19BXCQFbWBokMc+7MGeEy243uux5nnXSK6xY3Hf2nTJgYPF910lH
         PJyg==
X-Gm-Message-State: AHQUAuYrZhcOW+Pg6aDSai9OG6uIynRqGy8DoKLGgXffKhPK0egKcecV
        454PaGoo12YVYKxboRrA36c=
X-Google-Smtp-Source: AHgI3Ib8RwS53UtDfP2yvAhBeb9AkPx/Rmd2R2zfUJYtork7EUhac8kMM3A5fc04/MH9s9Ju/xx0lw==
X-Received: by 2002:a17:902:2e01:: with SMTP id q1mr7345811plb.240.1550889493636;
        Fri, 22 Feb 2019 18:38:13 -0800 (PST)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:200::4:1d52])
        by smtp.gmail.com with ESMTPSA id 70sm8081180pfr.43.2019.02.22.18.38.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Feb 2019 18:38:12 -0800 (PST)
Date:   Fri, 22 Feb 2019 18:38:11 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Roman Gushchin <guro@fb.com>, Alexei Starovoitov <ast@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH bpf-next 1/4] bpf: enable program stats
Message-ID: <20190223023810.5s7zyj4zqe6poigg@ast-mbp.dhcp.thefacebook.com>
References: <20190222233644.1487087-1-ast@kernel.org>
 <20190222233644.1487087-2-ast@kernel.org>
 <20190223003434.GA17559@tower.DHCP.thefacebook.com>
 <8de20612-c32a-9370-254d-9ebf1df78efa@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8de20612-c32a-9370-254d-9ebf1df78efa@iogearbox.net>
User-Agent: NeoMutt/20180223
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Feb 23, 2019 at 02:06:56AM +0100, Daniel Borkmann wrote:
> 
> In general, having some stats and timing info would be useful, but I
> guess people might want to customize it in future even more specifically
> beyond number of runs + time it takes. One thing that would be super
> useful is to have some notion of __attribute__((constructor)) and
> __attribute__((destructor)) support in BPF which gets then inlined into
> prologue / epilogue of program. E.g. such infrastructure would allow to
> mark an skb and measure time it takes through the BPF prog till it hits
> an exit point somewhere (without having to explicitly code this into the
> program everywhere). Other examples may be histograms or p99 latencies
> that might probably be useful. Feels like for monitoring more ways to
> program would be nice and to move it into the BPF insns sequence (e.g.
> enforced globally or by choice of prog as another option)? Thoughts?

the constructor/destructor you mean to capture the full sequence of tail_calls?
Or full path of skb through the stack with all hook points?
That is likely very useful without any bpf, but I think hw timestamping
already serves that purpose.

I've been thinking about doing this stats per program
(instead of static_key for all).
Like replacing a bpf_prog->bpf_func with a wrapper function
that does stats, but that is more costly in retpoline world
due to extra indirect call.
Another alternative is to patch the stats in via JITs, but
it's much more complex and error prone.
So went with the simplest approach.

With all stats ideas we need to be careful not to reintroduce what
perf is already great at.
These stats are _not_ for performance analysis. That's what perf does.
These stats are for 24/7 monitoring to catch things that not suppose to happen.

