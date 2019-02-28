Return-Path: <SRS0=vk/n=RD=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D6C3C43381
	for <bpf@archiver.kernel.org>; Thu, 28 Feb 2019 02:47:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A0D62186A
	for <bpf@archiver.kernel.org>; Thu, 28 Feb 2019 02:47:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EF7mTSH+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730663AbfB1CrV (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 27 Feb 2019 21:47:21 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41199 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730630AbfB1CrV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 27 Feb 2019 21:47:21 -0500
Received: by mail-pl1-f194.google.com with SMTP id y5so8977145plk.8;
        Wed, 27 Feb 2019 18:47:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KPYC4whOh4LOnk+DqaCAKb37RmQQvl4meieNy087rtw=;
        b=EF7mTSH+d93LsAomYmA0mTJvNf6qtxzYwlAVL7Ke9mK02iHViRSMeJLtdpYszRadRM
         rDzjBNJgP9CMlt+nhDFBBYjSriX3VSirHTAmm7j7uQkdwM8U7xvCbLm50fmzMaOQQnf1
         nf5DBsZmmk+pNsrpLny8YAGbHQTjwPOvy0gm4hscNgpZK+3RIReNg2w8a0oQcUowPO86
         wDBobb4EBLws/iabDZAhvSULjbabacFBAKMziLonNs0J0dx6mXl8yKryn2XuuwYpZKpq
         FFFmEYQbNWwnGxHt6pdf3xEXrNiYJbYW/19QMmPpNofKI0vKt3pd4KzhqDxC9Z5n1lsN
         rqkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KPYC4whOh4LOnk+DqaCAKb37RmQQvl4meieNy087rtw=;
        b=CznuH44LNKr7ZMdqEdkTHd52G0enq+8yvDqgsbJj9GeQ8Pl3QvbrAGdKC5JtJHBAJ5
         1XXTwV0okFgYZ5mdYrrAJwiG3q9uA0sdDrycJQxeqLp+omXRJKK2Jq17YHcdeBZKgRzQ
         HwIQ042HYVkOWJuWYZKNZOrKPq4YJQN8N00/1C1y2Zqv5ulS2U/bkTvIZCdpnhmQOQ2c
         CHCA+m/kFHU/baDcL08p0+tkClym/C5x4cjl5l5qPY6Vgf9/GZak5PddHwmYIDNirQ2E
         gFwIomCwP6FOxajHv37Fj7pdk1/2kSQcEyidTo26VtdsPiCjg0kgq/uPS4hH2UmFDcIS
         /zPg==
X-Gm-Message-State: AHQUAubXPy/bTByHwUi+aBtvoA0SAJfdxMIUV6dAFdJgOkVKszhAwoPK
        3oii5ngemfevqhtS0rEeQBw=
X-Google-Smtp-Source: AHgI3IZSzEZ1MIpwvM9sruEWqIB6tLJCtqFxQ2HpMUvWQPZzPaPhodUA37PP730n4FL45X/d6OminQ==
X-Received: by 2002:a17:902:5a42:: with SMTP id f2mr5550511plm.157.1551322040620;
        Wed, 27 Feb 2019 18:47:20 -0800 (PST)
Received: from ast-mbp ([2620:10d:c090:200::3:9b13])
        by smtp.gmail.com with ESMTPSA id 133sm29574106pge.60.2019.02.27.18.47.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Feb 2019 18:47:19 -0800 (PST)
Date:   Wed, 27 Feb 2019 18:47:17 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Jakub Kicinski <jakub.kicinski@netronome.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, oss-drivers@netronome.com
Subject: Re: [PATCH bpf-next 3/5] tools: libbpf: add a correctly named define
 for map iteration
Message-ID: <20190228024715.ijjki2fleuunxydn@ast-mbp>
References: <20190227233046.11718-1-jakub.kicinski@netronome.com>
 <20190227233046.11718-4-jakub.kicinski@netronome.com>
 <CAEf4BzZR+7R9TjXSMHiYzbHCvuwL+Z_LBD=Pk+rRW+X+pgdg4w@mail.gmail.com>
 <20190227155703.121514a2@cakuba.netronome.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190227155703.121514a2@cakuba.netronome.com>
User-Agent: NeoMutt/20180223
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Feb 27, 2019 at 03:57:03PM -0800, Jakub Kicinski wrote:
> On Wed, 27 Feb 2019 15:47:56 -0800, Andrii Nakryiko wrote:
> > On Wed, Feb 27, 2019 at 3:31 PM Jakub Kicinski
> > <jakub.kicinski@netronome.com> wrote:
> > >
> > > For historical reasons the helper to loop over maps in an object
> > > is called bpf_map__for_each while it really should be called
> > > bpf_object__for_each_map.  Rename and add a correctly named
> > > define for backward compatibility.  
> > 
> > Seems like there are at least 3 more functions that are not named correctly:
> > - __bpf_map__iter (__bpf_object__iter_map?)
> > - bpf_map__next (=> bpf_object__next_map?)
> > - bpf_map__prev (=> bpf_object__prev_map?)
> > 
> > Let's rename them as well?
> 
> At least those are consistently named between programs and maps.

I think this patch makes naming consistent enough.

> I'm happy to do the rename if we don't need backward compat, seems 
> a little much to add aliases?
> 
> > > Switch all in-tree users to the correct name (Quentin).
> > >
> > > Signed-off-by: Jakub Kicinski <jakub.kicinski@netronome.com>
> > > Reviewed-by: Quentin Monnet <quentin.monnet@netronome.com>
> 
> > > diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> > > index 6c0168f8bba5..b4652aa1a58a 100644
> > > --- a/tools/lib/bpf/libbpf.h
> > > +++ b/tools/lib/bpf/libbpf.h
> > > @@ -278,10 +278,11 @@ bpf_object__find_map_by_offset(struct bpf_object *obj, size_t offset);
> > >
> > >  LIBBPF_API struct bpf_map *
> > >  bpf_map__next(struct bpf_map *map, struct bpf_object *obj);
> > > -#define bpf_map__for_each(pos, obj)            \
> > > +#define bpf_object__for_each_map(pos, obj)             \
> > >         for ((pos) = bpf_map__next(NULL, (obj));        \
> > >              (pos) != NULL;                             \
> > >              (pos) = bpf_map__next((pos), (obj)))
> > > +#define bpf_map__for_each bpf_object__for_each_map  
> > 
> > Should we get rid of this as well, instead of accumulating cruft?
> 
> Well, we did some gymnastics in the past to maintain backward compat, 
> I thought we do need it..?

We do need to keep backward compat.
This line is necessary.

imo this set looks good to me as-is.

