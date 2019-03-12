Return-Path: <SRS0=5gB9=RP=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B49AC4360F
	for <bpf@archiver.kernel.org>; Tue, 12 Mar 2019 01:30:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18A552084F
	for <bpf@archiver.kernel.org>; Tue, 12 Mar 2019 01:30:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=netflix.com header.i=@netflix.com header.b="B0+f6j4i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbfCLBaY (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 11 Mar 2019 21:30:24 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33262 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726494AbfCLBaY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 11 Mar 2019 21:30:24 -0400
Received: by mail-wr1-f68.google.com with SMTP id i8so901538wrm.0
        for <bpf@vger.kernel.org>; Mon, 11 Mar 2019 18:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netflix.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vcLEEZW7c6xWr4HYDXZz9Ig+J7aT3W1UqEZQc7EPqXU=;
        b=B0+f6j4i5IIwHx+hd62mKmdSTyxdADq+4qGouLcI5Dslpfkko3WpFVrgLCDPydUeLR
         PMZUphk4JNXUJbtwnZIE6ypL86JOkzgYCbqXCkv5f+WnTJ2KRw66arWuatzCGTLTMAM5
         5XukrYuTn4R0Il0KfZr+99e1PRxTTPnAlQmmU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vcLEEZW7c6xWr4HYDXZz9Ig+J7aT3W1UqEZQc7EPqXU=;
        b=JRD8S7jAlrR1WxTmEYdMbBpdLfuHAgxnOmSv3lH9II17nN5EXZYB75G0rB717NsJKp
         GV24vvybD7m4OrNVqsF5lcFpmc8EsZJjAKrBZ2q8Y5yIqE9zoffaG+YBZ2lavL8uksmI
         +0QKiW/ch4r0Aw8l4nMUBKoMTiiMb/dLOTzNtT21+kL0QeikI10RobX9m2bPrCqXALpB
         H1gHD4Wgm2fBvQo9CWFHrGvfTsA8dzICaVhGkYNh7cQffTs1NiBuXl+fNCbsmhu3wMlt
         J/HBappOkQCzrRiR3nDgy5n8mPO2d32V+zyDzb+3nfPp78DHESb0eVkx76q6UigvBDXV
         GnmQ==
X-Gm-Message-State: APjAAAW0wPk6xfkP07XKvAihKmxT48IhkgizQqZQmo9Pncrz20eAmzmx
        +fD21w18Bbbw4JP/th13TEd+bT4L0/TFPyW82FAK/w==
X-Google-Smtp-Source: APXvYqwJ2bPocVJhw0kIWhSrGIxCovhbF1J7OIWKzQ3P4sR29/+s+Iic7l4uL3gqortacuoNcboES8qZf8o4YU0YC+0=
X-Received: by 2002:adf:b784:: with SMTP id s4mr21612092wre.155.1552354221673;
 Mon, 11 Mar 2019 18:30:21 -0700 (PDT)
MIME-Version: 1.0
References: <201902251554.x1PFsD3w017626@userv0121.oracle.com>
 <20190226061823.f7hfs7yojfuycqmg@ast-mbp.dhcp.thefacebook.com>
 <20190226064601.GE16689@oracle.com> <20190305185950.rpx7srzpbya5psnf@ast-mbp.dhcp.thefacebook.com>
 <20190306020357.GG32758@oracle.com> <20190307213035.5eagphx6vswxalai@ast-mbp.dhcp.thefacebook.com>
 <20190311142127.GA11634@oracle.com>
In-Reply-To: <20190311142127.GA11634@oracle.com>
From:   Brendan Gregg <bgregg@netflix.com>
Date:   Mon, 11 Mar 2019 18:29:55 -0700
Message-ID: <CAJN39ohS0+GCLMsc3s_JyROTDty8eomRJ==QW34YxhDrDGr9KA@mail.gmail.com>
Subject: Re: [PATCH 0/2] bpf: context casting for tail call and gtrace prog type
To:     Kris Van Hees <kris.van.hees@oracle.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Mar 11, 2019 at 7:21 AM Kris Van Hees <kris.van.hees@oracle.com> wrote:
>
> On Thu, Mar 07, 2019 at 01:30:37PM -0800, Alexei Starovoitov wrote:
> > On Tue, Mar 05, 2019 at 09:03:57PM -0500, Kris Van Hees wrote:
[...]
> > > But being able to do things like this without
> > > needing to touch the context of any other BPF program type is a great benefit
> > > to offer tracing tools, as far as I see it.
> >
> > I still don't understand what you're referring to by 'things like this'
> > that somehow will be possible in the future, but not possible today.
> > Could you please give concrete example?
>
> My apologies for not being clear.  I am referring to the features of the
> gtrace context in terms of containing task information, and output buffers
> to be used in BPF programs triggered from various probe sources (kprobe,
> tracepoints, ...)  I would not want to suggest making changes to all the
> different program contexts in order to support tracing needs because that
> would be wrong.  Doing it in a central place makes it a lot easier to maintain
> without impacting other program types, etc.
>
> Of course, yes, bpf_probe_read() and bpf_perf_event_output() can be used
> to implement a lot of what existing tracing tools like DTrace can do, if you
> write them based on that.  One limitations I am obviously working with is
> that DTrace already exists and has existed for a long time.  And while it is
> 100% available as open source, it involves a pretty involved set of patches to
> be applied to the kernel to be able to use it which is just not ideal.  Hence
> the goal to make it available by re-using as much of the existing features in
> Linux as possible, while still maintaining the same level of functionality in
> DTrace.  That means we need to fill the gaps - and from where I am sitting,
> the ways to do that might as well be of use to others (if they want to).
>
> If phrasing things in the context of DTrace would make the conversation easier
> I certainly don;t mind doing that, but I really don't want to limit my patches
> to supporting just DTrace (even if right now it might be the only tracer using
> it).

As a concrete example, can you point to one of my own published DTrace
tools that BPF can't do? These were created to solve many real
production issues, and make good use cases. I've been porting them
over to BPF (bcc and bpftrace) without too much problem, and I can't
think of a single one that I couldn't port over today.

There's a few minor things that I'm currently doing workarounds for,
like ppid, but that should be satisfied with a few more helpers. And
if it's really niche, then BTF sounds like a good solution.

If your ultimate goal is to have a command called "dtrace" that runs D
programs, to support your existing users, then I'd add a lex/yacc pair
to bpftrace and have it emit a dtrace binary.

Brendan

--
Brendan Gregg, Senior Performance Architect, Netflix
