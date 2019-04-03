Return-Path: <SRS0=5VBK=SF=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C64D6C4360F
	for <bpf@archiver.kernel.org>; Wed,  3 Apr 2019 14:41:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96B5A2084C
	for <bpf@archiver.kernel.org>; Wed,  3 Apr 2019 14:41:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbfDCOlB (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 3 Apr 2019 10:41:01 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53383 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbfDCOlB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Apr 2019 10:41:01 -0400
Received: by mail-wm1-f66.google.com with SMTP id q16so7685211wmj.3;
        Wed, 03 Apr 2019 07:40:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wJVrhUxUZrQqja8Q8nZAB0aOqA3G8IidgHu+ftttweg=;
        b=XJ6Maa2+fZ9iiGzLdecuJshJ7ay16eZ7fTZOVpsG1cGagdX3DjbUZVHHUUNnmpknjW
         scaKf+moGNSCtbAxt5B9try8YQzfR45JQkLAEw78Sexk7dSkWiy+gB959L9WnnGWChuq
         u9KYtvmYt7GKjgZrTlg+2YOW68F7zo3e5N5yexrrJky3fmZ0QlQR2SMcaZxk3AeCHceD
         EEacTnKHtFjrMpEc6fVfPPbNWGQFylNEgR+MWf40tms3alJLpsnFxpbmH2/zq44Onp8q
         y9cnQn9XI5vfHW7sA7JNsSLzybQMsQc0SV3kZziE8igqmLCful38F+2HVdLEFDCOkOrL
         553g==
X-Gm-Message-State: APjAAAW2yL5JW5fS2ddShRTqqodnDHCYi4I5GEO4Ro1ltxFM5nUVvfRJ
        NtztsEGMl+eYyM1tRv9h8LE=
X-Google-Smtp-Source: APXvYqw6KnVIDXoDnKwEJGhz56C7LLE3Pe3CifbV4z23wruRzKe2jwr99pJDEciSHl2+IFyj4JR8kw==
X-Received: by 2002:a1c:81cc:: with SMTP id c195mr295185wmd.61.1554302459216;
        Wed, 03 Apr 2019 07:40:59 -0700 (PDT)
Received: from Nover ([161.105.209.130])
        by smtp.gmail.com with ESMTPSA id y133sm16800765wmd.2.2019.04.03.07.40.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Apr 2019 07:40:59 -0700 (PDT)
Date:   Wed, 3 Apr 2019 16:40:55 +0200
From:   Paul Chaignon <paul.chaignon@orange.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, Xiao Han <xiao.han@orange.com>,
        paul.chaignon@gmail.com, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>
Subject: Re: [PATCH bpf] bpf: report verifier bugs as warnings
Message-ID: <20190403144054.GA25718@Nover>
References: <20190402115811.GA6303@Nover>
 <a79d7f5e-637e-df0a-e99c-beea05eca1d7@iogearbox.net>
 <20190402173927.pvqprcbjk42km3mc@ast-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190402173927.pvqprcbjk42km3mc@ast-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Apr 02, 2019 at 10:39:29AM -0700, Alexei Starovoitov wrote:
> On Tue, Apr 02, 2019 at 04:37:19PM +0200, Daniel Borkmann wrote:
> > On 04/02/2019 01:58 PM, Paul Chaignon wrote:
> > > Three checks for verifier bugs were introduced in commit f4d7e40 ("bpf:
> > > introduce function calls (verification)").  The bugs were reported as
> > > incorrect programs instead of kernel warnings as the present patch
> > > implements.
> > > 
> > > Signed-off-by: Paul Chaignon <paul.chaignon@orange.com>
> > 
> > Thanks for the patch, I think these WARN_ONCE() are a bit out of context though,
> > meaning it lacks additional information about the program in kernel log once we
> > actually manage to trigger it which we'd otherwise would potentially have had with
> > the verbose() log. And from a program debugging pov, it makes it harder after this
> > patch when verification log would suggest that all is fine. Looks like we already
> > have a few WARN_ONCE() in verifier, they should probably be converted to verbose()
> > as well to be consistent. If we really want to have a kernel warn, then lets add a
> > helper macro verbose_and_warn(...) which will trigger a one-time warning, but keeps
> > the verbose log intact as well.
> 
> I think they should stay as verbose() messages and some of the WARN_ON
> should be converted to verbose().
> I don't think there is a need for verbose_and_warn().
> 

Agreed for the verbose messages; it makes sense.  I'm a bit surprised you
don't think the verifier should warn on verifier bugs though.  It already
warns for other internal bugs such as 'regno >= MAX_BPF_REG'.  Or should
these be converted to verbose() as well?
