Return-Path: <SRS0=yvf5=RY=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1C8EC4360F
	for <bpf@archiver.kernel.org>; Thu, 21 Mar 2019 22:01:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CE6A21917
	for <bpf@archiver.kernel.org>; Thu, 21 Mar 2019 22:01:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sEOGT1+5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727530AbfCUWBP (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 21 Mar 2019 18:01:15 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43017 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727528AbfCUWBO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Mar 2019 18:01:14 -0400
Received: by mail-pg1-f194.google.com with SMTP id l11so5102179pgq.10;
        Thu, 21 Mar 2019 15:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Rh/KxJwYqkqs8QKNm4MJro81RvcCr+q6ZyZLOLqt8mA=;
        b=sEOGT1+56SJd7gYaZYAFDMI0AW+R0sX5HRjPTSx6LFMqa8Hqqso/pj1Q0BvTh0BNpt
         uPr6MsScuwzJBGR05Qbjna1NZqrUPbf5G0lVAJkEiAKqGuq0J97t+4++VtJ02R8/+qvO
         shcQ3Bz0oC88QcA1T4ej7M1kekjCft32fZDCFIOm4J4yHQJGhy+od91qtBPqXp02niLe
         6cucD9vf2BPfgkOEcRAmwJF01pHtlM9Pbw3OJlpB2MzA5RFOM4jh1D0l2NldCjCPUpnR
         T8Dj+0yAnDWeORU6VgITMrh0iWgeCQN9lCWYoxgbuVDATpuTmJloRL0/HmEQYcBoWWIm
         gzBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Rh/KxJwYqkqs8QKNm4MJro81RvcCr+q6ZyZLOLqt8mA=;
        b=JKB4DjqmxfaT8qBxPZXvJPyaLHGvW4pQdmou7T9ECrkxecfs8WtxNFhCzqwocQEO0a
         K9sC3U0dCYRMhdr2vEdRrN8JjSUKQJR4Rzp/M4oGUU83DN9CZGa/sNaqSPZJbzn1RkdO
         XAxlTnaXyzqtj7H5JWULiVNlYVvX0rMD7piDBbH5c+D5oSVzIQEE1Mh2LdLz5oA8REEd
         Ysj39wAidrUUEiJOJZwa6Oxymcm0g5D22JfDKPjNzDRAU6nRl4RHfPEGq64bu8PSl9rl
         /ndOvhfuBChZHd+XyJUdNdsQEmk5wG2YewrkhtRypxavIE0d2lzK4kildsOcvPUrvp0J
         UblQ==
X-Gm-Message-State: APjAAAW7t3bqcvu7HN+elh/mloUG1Imym3gQ3VYiokauU1GGrUjQOYCV
        xZXhZTLOXEiTfIXpEns9qqA=
X-Google-Smtp-Source: APXvYqy84Xh5OAxXn19vUeGrmQVlRriLdLYVYhlcZzpJgJXe3UKjPKgdUUdUlvZmVXCowXMjRFYUdQ==
X-Received: by 2002:a63:535c:: with SMTP id t28mr5578862pgl.128.1553205672928;
        Thu, 21 Mar 2019 15:01:12 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:200::3:6115])
        by smtp.gmail.com with ESMTPSA id l12sm11993084pgn.83.2019.03.21.15.01.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 15:01:12 -0700 (PDT)
Date:   Thu, 21 Mar 2019 15:01:09 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Andrey Ignatov <rdna@fb.com>
Cc:     "luca.boccassi@gmail.com" <luca.boccassi@gmail.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        bpf@vger.kernel.org, daniel@iogearbox.net
Subject: Re: [PATCH bpf-next v4] tools/bpf: generate pkg-config file for
 libbpf
Message-ID: <20190321220107.pcvf6e23kun4gj7r@ast-mbp.dhcp.thefacebook.com>
References: <20190319210639.6282-1-bluca@debian.org>
 <20190321102531.31810-1-luca.boccassi@gmail.com>
 <20190321160042.GB13709@rdna-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190321160042.GB13709@rdna-mbp>
User-Agent: NeoMutt/20180223
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Mar 21, 2019 at 04:00:46PM +0000, Andrey Ignatov wrote:
> luca.boccassi@gmail.com <luca.boccassi@gmail.com> [Thu, 2019-03-21 03:26 -0700]:
> > From: Luca Boccassi <bluca@debian.org>
> > 
> > Generate a libbpf.pc file at build time so that users can rely
> > on pkg-config to find the library, its CFLAGS and LDFLAGS.
> > 
> > Signed-off-by: Luca Boccassi <bluca@debian.org>
...
> > diff --git a/tools/lib/bpf/libbpf.pc.template b/tools/lib/bpf/libbpf.pc.template
> > new file mode 100644
> > index 000000000000..0ecd334c109f
> > --- /dev/null
> > +++ b/tools/lib/bpf/libbpf.pc.template
> > @@ -0,0 +1,11 @@
> > +prefix=@PREFIX@
> > +libdir=@LIBDIR@
> > +includedir=${prefix}/include
> > +
> > +Name: libbpf
> > +URL: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> > +Description: Linux kernel BPF library

github/libbpf/libbpf is a true mirror of kernel's libbpf.
I think if we start shipping libbpf.so from kernel and from github
it will be very confusing to the users...
Which one is the true libbpf?
Also the package should mention the license.
And the license for libbpf is dual lgpl/bsd.
But if we point to the url above it will not make much sense.
I think the packages URL should point to github/libbpf/libbpf
and packaging scripts should be in github only.

Daniel,
what do you think?

