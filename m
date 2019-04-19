Return-Path: <SRS0=ErZJ=SV=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 699FBC282E1
	for <bpf@archiver.kernel.org>; Fri, 19 Apr 2019 21:41:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 346C721736
	for <bpf@archiver.kernel.org>; Fri, 19 Apr 2019 21:41:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jUszBdaw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbfDSVl1 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 19 Apr 2019 17:41:27 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37446 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbfDSVl0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 19 Apr 2019 17:41:26 -0400
Received: by mail-pl1-f196.google.com with SMTP id w23so3112034ply.4;
        Fri, 19 Apr 2019 14:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nurtyoNn6lnVEbXsKkEKpfnPO2VtXW7uDiD2xO1ROEw=;
        b=jUszBdaw5kdk4AlG1NtvQMmHYYU4JF2wzSNn5IOYE4LusFSFcu7AY9QfofcfVCpO4o
         blRZgLXScE7TUU3AeuEDO21J/HKgbznsOtgi7jXhfiPn+xoxmabVohggE5l1ZW4cNAKY
         oakRF1Vl6eHNlGOxkiF8f5mc/Ki/PA5z7Eq3i7UQNZVIC3ALQ751sVVw3G6lLP1Dopk0
         0Fx0ENAGjcrn+EJI01IGzHyO8U50j5iTfuKPkKK45jWdlLfQPrQM+5EyWSFtQ/NSrxmu
         IiDsd4GXmVSLWiJhHIK6tEWzGnwGJpRKOHlI+RYoVLDalOyObGNSmwY60deN9NOQlxjT
         mdXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nurtyoNn6lnVEbXsKkEKpfnPO2VtXW7uDiD2xO1ROEw=;
        b=BEm8PJ+JZrRl7E47q7usJDbOwAWlOKoquCEKSE9rnSJuIyYRJRrhxD0n/JAYd6h9Tr
         WZGOc2OCY+FoT4XD084xYspn5qx/o9hgL7+UWiX/bLcj9kfXV9fWVoxIffJ1gEmrs+zZ
         1+Pwr16jF5uznw4PTC+kXyHPqQtmMMgt5EG30DeSaX6LcrfewXC24ELV+04wOnzG8HNt
         xcwCt6wILRVimeELyr205yWWIFWwxakRWguwAy3pGpeRLIT9ZqJXF4KtSqziSZc4ANOF
         kZu8ebdBzO4lzhRDcSdlKpZ/mILs1MAAAR25XtybPnQpJ7W97/Z0DmI+lLRk6sCQTfcW
         kXEA==
X-Gm-Message-State: APjAAAVZBgDq1JfonDENvVHUN9R584pPKonWwil7/8C9od+n5AdTpKPJ
        TXblqrkJG/yuEdTWYW5rHbo=
X-Google-Smtp-Source: APXvYqwGcA1E4So9MP/KyQkT1tt0/GfMN8Amjy92NJTs/iQdWyU1ighl7uyVUdQ0GeAdOEW40RxMmw==
X-Received: by 2002:a17:902:7785:: with SMTP id o5mr6067219pll.33.1555710085482;
        Fri, 19 Apr 2019 14:41:25 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:200::6f64])
        by smtp.gmail.com with ESMTPSA id g2sm9636681pfd.134.2019.04.19.14.41.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Apr 2019 14:41:24 -0700 (PDT)
Date:   Fri, 19 Apr 2019 14:41:23 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Jakub Kicinski <jakub.kicinski@netronome.com>
Cc:     Jiong Wang <jiong.wang@netronome.com>, daniel@iogearbox.net,
        bpf@vger.kernel.org, netdev@vger.kernel.org,
        oss-drivers@netronome.com
Subject: Re: [PATCH v4 bpf-next 02/15] bpf: mark lo32 writes that should be
 zero extended into hi32
Message-ID: <20190419214121.2rbmmms6qozmiuke@ast-mbp.dhcp.thefacebook.com>
References: <1555349185-12508-1-git-send-email-jiong.wang@netronome.com>
 <1555349185-12508-3-git-send-email-jiong.wang@netronome.com>
 <20190418235747.jv4yocuf6fgwahli@ast-mbp.dhcp.thefacebook.com>
 <20190419134051.71eeea08@cakuba.netronome.com>
 <20190419211403.6iovh26bu6cg2x36@ast-mbp.dhcp.thefacebook.com>
 <20190419143310.6c749160@cakuba.netronome.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190419143310.6c749160@cakuba.netronome.com>
User-Agent: NeoMutt/20180223
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Apr 19, 2019 at 02:33:10PM -0700, Jakub Kicinski wrote:
> On Fri, 19 Apr 2019 14:14:05 -0700, Alexei Starovoitov wrote:
> > > This reminds me, I'm not entirely clear on the need to propagate the
> > > zext through stack slots...  Pointers are guaranteed to be 64bit, we
> > > don't save parentage on scalars (AFAICT),  
> > 
> > scalars have parentage chain too.
> > we don't track them precisely when they're spilled to stack.
> > That actually caused an issue recently when valid program was rejected,
> > so we might add a feature to track full contents of scalars in the stack.
> 
> Interesting..
> 
> > > why not pass REG_LIVE_READ
> > > or READ64 to mark_reg_read() from stack_read?  
> > 
> > can we agree on only two states first ? ;)
> 
> Yess, the LIVE_READ was thought to be more of a mask for those accesses
> that only care about "any read" being set, to be honest.  As you said
> read64 is a strict superset of read32.  Keeping the name REG_LIVE_READ,
> rather than REG_LIVE_READ_ANY or _MASK let us leave some of the
> existing code untouched.
> 
> Jiong's original idea was to add a read32, and have read mean read64.
> 
> I think you said we should have read32 and read64 flags, but clear
> read32 once read64 gets set?  SGTM!

yep.

any subsequent read64 means that earlier read32 marks are irrelevant
from zext optimization pov.

