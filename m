Return-Path: <SRS0=qXn4=SU=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7D91C10F14
	for <bpf@archiver.kernel.org>; Thu, 18 Apr 2019 06:51:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A483620821
	for <bpf@archiver.kernel.org>; Thu, 18 Apr 2019 06:51:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="puWcFqcE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728074AbfDRGvd (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 18 Apr 2019 02:51:33 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41868 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbfDRGvc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 18 Apr 2019 02:51:32 -0400
Received: by mail-pf1-f194.google.com with SMTP id 188so656130pfd.8;
        Wed, 17 Apr 2019 23:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/ByUJOV/VO9lTV2t/sBZ+fmTDs5fz6xMv1XYX6uKZZU=;
        b=puWcFqcETlSr6Nmt9lbot6tEZd1qM+XT4NcXD/Z9dYW/fLIxud97pEMUH/8cwVmSow
         ANwwGnfnBXWxCCijN84Bw/ZI0InCcpBT7JHoh3mfQv3DQgvCa4IWtT9WbVNPk/idct9D
         BVBMTG2hexpSxyOTuMJUGiSyUPzKAMgUtjchAsHxqspP7PDyN900jSy3VTaAIPkn3QsH
         OlOl0sN709z6rK32ACch0wTX/Rklsci8uFE0PYGPW4N9XDZC4av0kQlbGEKxHQ/cwmYD
         nnU8NPnZ8UG1V4iG+vmjLSGQGW3X8SEkQ8Q22mLUbOMO2xajwcPUmkfLXnQqTIcAokZY
         N75A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/ByUJOV/VO9lTV2t/sBZ+fmTDs5fz6xMv1XYX6uKZZU=;
        b=WKDXtVML9cmcwAG6QATtvHgjDaBVjnp4qk/eyiy/w211NZLL5j/i0K1UwCF4UrI0OY
         qwBLcLB9mTkOeuFvmlpYmSbnHmtMwPDri3VWozM2oPxBFXmN8Is2YIyOe2O1ZlYvPtB9
         HiWR0fBVFOpVD0U31wFcNRKSz9XOmSJitbzzzuFlY7nU8Ej1drsqQhsN4V++jC2nw0BS
         tRxkJdmMoDvsh7u9xcmx3oVz3/tDjVSjKud3aPiObpcpqnJm0AAHjdWPCnMG/wwuqr//
         LxqkMIZPuAB12NCNcxEknjFIcdqtB6t0o0TeHVGGoSQM23ATgDYGREWqeHTuIE9drpfG
         wH4A==
X-Gm-Message-State: APjAAAVpl5LOthCyLn4dq42f0R+86GHAiwsLr3MHZiN80C6NmQobAXD2
        BbqpTWWaeRI+fo1aZOmEpyY=
X-Google-Smtp-Source: APXvYqyvWFxGKWBJfwnRG/RmIArRwA4Ae3ix9lwmPjyM+aJULJ74q3G7cJEUs8mGwn8sPt4It1XrQw==
X-Received: by 2002:a63:6844:: with SMTP id d65mr88509752pgc.393.1555570291972;
        Wed, 17 Apr 2019 23:51:31 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:180::7103])
        by smtp.gmail.com with ESMTPSA id g4sm2156882pfc.75.2019.04.17.23.51.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 23:51:31 -0700 (PDT)
Date:   Wed, 17 Apr 2019 23:51:29 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Magnus Karlsson <magnus.karlsson@gmail.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Networking <netdev@vger.kernel.org>, bpf@vger.kernel.org,
        =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>
Subject: Re: linux-next: build failure after merge of the bpf-next tree
Message-ID: <20190418065127.exojundvv42i2cjx@ast-mbp.dhcp.thefacebook.com>
References: <20190418115748.0b0aefdc@canb.auug.org.au>
 <CAJ8uoz1T5xzx+RhJ=NZQ-WJhawE765ncMQUPMD9uGWHMeiuqOQ@mail.gmail.com>
 <20190418061842.t6ohwq6u7m33hcpo@ast-mbp.dhcp.thefacebook.com>
 <CAJ8uoz12d6mWBpVzmkWDFrFtOkVEJsk70poqzs9Q6YpeQHkObA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ8uoz12d6mWBpVzmkWDFrFtOkVEJsk70poqzs9Q6YpeQHkObA@mail.gmail.com>
User-Agent: NeoMutt/20180223
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Apr 18, 2019 at 08:25:22AM +0200, Magnus Karlsson wrote:
> On Thu, Apr 18, 2019 at 8:18 AM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Thu, Apr 18, 2019 at 07:55:30AM +0200, Magnus Karlsson wrote:
> > > On Thu, Apr 18, 2019 at 3:59 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > > >
> > > > Hi all,
> > > >
> > > > After merging the bpf-next tree, today's linux-next build (powerpc perf)
> > > > failed like this:
> > > >
> > > > In file included from xsk.c:32:
> > > > libbpf_util.h:49:3: error: #warning Architecture missing native barrier functions in libbpf_util.h. [-Werror=cpp]
> > > >  # warning Architecture missing native barrier functions in libbpf_util.h.
> > > >    ^~~~~~~
> > > > cc1: all warnings being treated as errors
> > > >
> > > > Caused by commit
> > > >
> > > >   b7e3a28019c9 ("libbpf: remove dependency on barrier.h in xsk.h")
> > > >
> > > > I have applied the following patch for today ... please fix this.
> > > >
> > > > From: Stephen Rothwell <sfr@canb.auug.org.au>
> > > > Date: Thu, 18 Apr 2019 11:54:56 +1000
> > > > Subject: [PATCH] suppress warning in tools/lib/bpf/libbpf_util.h
> > > >
> > > > Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > > > ---
> > > >  tools/lib/bpf/libbpf_util.h | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/tools/lib/bpf/libbpf_util.h b/tools/lib/bpf/libbpf_util.h
> > > > index 172b707e007b..a54eb2cdbdd6 100644
> > > > --- a/tools/lib/bpf/libbpf_util.h
> > > > +++ b/tools/lib/bpf/libbpf_util.h
> > > > @@ -46,7 +46,7 @@ do {                          \
> > > >  # define libbpf_smp_mb() asm volatile("dmb ish" : : : "memory")
> > > >  # define libbpf_smp_rwmb() libbpf_smp_mb()
> > > >  #else
> > > > -# warning Architecture missing native barrier functions in libbpf_util.h.
> > > > +//# warning Architecture missing native barrier functions in libbpf_util.h.
> > > >  # define libbpf_smp_rmb() __sync_synchronize()
> > > >  # define libbpf_smp_wmb() __sync_synchronize()
> > > >  # define libbpf_smp_mb() __sync_synchronize()
> > > > --
> > > > 2.20.1
> > > >
> > > > --
> > > > Cheers,
> > > > Stephen Rothwell
> > >
> > > My apologies, I will fix this. I just have two questions first so I do
> > > not mess things up.
> > >
> > > * I see my commit in bpf-next but not in bpf. As I submitted it
> > > against bpf, what was the reason it was applied to bpf-next instead?
> > > Unfortunately, I forgot to add "Fixes" tags to the commits, so was
> > > this the reason? I view 4 out of 5 of these patches as bug fixes, the
> > > last one being an optimization.
> >
> > new macros that users still have to learn how to use are hardly fixes.
> 
> That is fair.
> 
> > I can toss it out of bpf-next if it's easier.
> 
> How about you toss it out of bpf-next, then I resubmit the first two
> patches (the barrier fixes) to bpf and the last three (new macros,
> etc.) to bpf-next? Would that make it easier for you?

the easiest is to do a trivial patch for bpf-next,
but if you insist on first two as fixes that is ok as well.

