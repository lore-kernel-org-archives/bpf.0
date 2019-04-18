Return-Path: <SRS0=qXn4=SU=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6690BC10F0B
	for <bpf@archiver.kernel.org>; Thu, 18 Apr 2019 06:18:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31156214DA
	for <bpf@archiver.kernel.org>; Thu, 18 Apr 2019 06:18:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hsl8nX22"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733049AbfDRGSs (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 18 Apr 2019 02:18:48 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46230 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbfDRGSs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 18 Apr 2019 02:18:48 -0400
Received: by mail-pl1-f196.google.com with SMTP id y6so638942pll.13;
        Wed, 17 Apr 2019 23:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=29TCmc3mON0WRcYQRHWvmBg8vLY4IROpscTDxQY5+Ik=;
        b=Hsl8nX22HBvq+BbF4Y8/wVF2c7qzQeL3FZZlYYpMiDzxY/11CEnesjiKGSEhEoXbF0
         +8jPz4R3I4KVja68oli21lBNQ51t4kmXj17fcCZCawq63d/R2lLDt7R7N0V39KqjafH2
         yQ624O3Z0Q0VfSWA9n/mzklc8MU3dfk7GBLh9n1foafFN+c8g92DAn8vAAVN4M7X4hnC
         uajEW4z1HuHSrPUNbEX1XXj4MXGa5thjlE6+vlRHWuWxsq+jZEuXHEqwztWTYXxB1/mp
         W95gC5Y8KBW5fIKjNMkA/TltzdefpdMUVNe6wtJgEiI6eFWiyPRjuoW118MDYN+qpe4K
         7kfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=29TCmc3mON0WRcYQRHWvmBg8vLY4IROpscTDxQY5+Ik=;
        b=ipN6o85M8ytQ/LNvzyy/u9NafxlDXoa2AtRyekLUchMsqWJ23ZzD3yZc1ll8fcuq70
         p5GW/0RQhBmGLvQGD51Fc1rMQDlpsCB/nahV9hqSt38ATB0ll1bDPGr6dIbAFOXVxtUC
         zWxrNRnejdWn5n5T+mM6A6LbFhbo8c2N0D8A7VZSjuRJ1paVDw0Z2TxKIF3NqkQs9eyC
         iajmqSDRM4FslwLGAYlBO+kByClvNFGMGO/4PIztQPT+S0x4b3KFEZy0IBDhtlI6Tbly
         2EoDBamUSsk41hW17KH2U0JYhZUMdMb4krCxcgT/CUmn+AL0odAr+2sLfwO6nG6fUjxP
         Thkg==
X-Gm-Message-State: APjAAAX1CsGuV7cviqmj1SGgSBWz9QuAinsjiDd2jCfXfuWmLaMWMetz
        9T347qIsNw1Ag4OQwBCqYP8=
X-Google-Smtp-Source: APXvYqz9/O8zBRlhdN5+d6hspm1NdFkMe6qs2afF+gDNoLAiObA8t3YMA2PBY6kzqJj+Hv+WxGyabQ==
X-Received: by 2002:a17:902:a01:: with SMTP id 1mr65474589plo.36.1555568327825;
        Wed, 17 Apr 2019 23:18:47 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:180::7103])
        by smtp.gmail.com with ESMTPSA id k79sm2898728pfj.28.2019.04.17.23.18.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 23:18:46 -0700 (PDT)
Date:   Wed, 17 Apr 2019 23:18:44 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Magnus Karlsson <magnus.karlsson@gmail.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Networking <netdev@vger.kernel.org>, bpf@vger.kernel.org,
        =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>
Subject: Re: linux-next: build failure after merge of the bpf-next tree
Message-ID: <20190418061842.t6ohwq6u7m33hcpo@ast-mbp.dhcp.thefacebook.com>
References: <20190418115748.0b0aefdc@canb.auug.org.au>
 <CAJ8uoz1T5xzx+RhJ=NZQ-WJhawE765ncMQUPMD9uGWHMeiuqOQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ8uoz1T5xzx+RhJ=NZQ-WJhawE765ncMQUPMD9uGWHMeiuqOQ@mail.gmail.com>
User-Agent: NeoMutt/20180223
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Apr 18, 2019 at 07:55:30AM +0200, Magnus Karlsson wrote:
> On Thu, Apr 18, 2019 at 3:59 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > Hi all,
> >
> > After merging the bpf-next tree, today's linux-next build (powerpc perf)
> > failed like this:
> >
> > In file included from xsk.c:32:
> > libbpf_util.h:49:3: error: #warning Architecture missing native barrier functions in libbpf_util.h. [-Werror=cpp]
> >  # warning Architecture missing native barrier functions in libbpf_util.h.
> >    ^~~~~~~
> > cc1: all warnings being treated as errors
> >
> > Caused by commit
> >
> >   b7e3a28019c9 ("libbpf: remove dependency on barrier.h in xsk.h")
> >
> > I have applied the following patch for today ... please fix this.
> >
> > From: Stephen Rothwell <sfr@canb.auug.org.au>
> > Date: Thu, 18 Apr 2019 11:54:56 +1000
> > Subject: [PATCH] suppress warning in tools/lib/bpf/libbpf_util.h
> >
> > Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > ---
> >  tools/lib/bpf/libbpf_util.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/lib/bpf/libbpf_util.h b/tools/lib/bpf/libbpf_util.h
> > index 172b707e007b..a54eb2cdbdd6 100644
> > --- a/tools/lib/bpf/libbpf_util.h
> > +++ b/tools/lib/bpf/libbpf_util.h
> > @@ -46,7 +46,7 @@ do {                          \
> >  # define libbpf_smp_mb() asm volatile("dmb ish" : : : "memory")
> >  # define libbpf_smp_rwmb() libbpf_smp_mb()
> >  #else
> > -# warning Architecture missing native barrier functions in libbpf_util.h.
> > +//# warning Architecture missing native barrier functions in libbpf_util.h.
> >  # define libbpf_smp_rmb() __sync_synchronize()
> >  # define libbpf_smp_wmb() __sync_synchronize()
> >  # define libbpf_smp_mb() __sync_synchronize()
> > --
> > 2.20.1
> >
> > --
> > Cheers,
> > Stephen Rothwell
> 
> My apologies, I will fix this. I just have two questions first so I do
> not mess things up.
> 
> * I see my commit in bpf-next but not in bpf. As I submitted it
> against bpf, what was the reason it was applied to bpf-next instead?
> Unfortunately, I forgot to add "Fixes" tags to the commits, so was
> this the reason? I view 4 out of 5 of these patches as bug fixes, the
> last one being an optimization.

new macros that users still have to learn how to use are hardly fixes.

I can toss it out of bpf-next if it's easier.

