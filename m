Return-Path: <SRS0=IWuG=RQ=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 745E0C10F03
	for <bpf@archiver.kernel.org>; Wed, 13 Mar 2019 16:30:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37E1520854
	for <bpf@archiver.kernel.org>; Wed, 13 Mar 2019 16:30:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=netflix.com header.i=@netflix.com header.b="mtnK2E4t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbfCMQab (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 13 Mar 2019 12:30:31 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46427 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726485AbfCMQaa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 13 Mar 2019 12:30:30 -0400
Received: by mail-wr1-f66.google.com with SMTP id 33so2692691wrb.13
        for <bpf@vger.kernel.org>; Wed, 13 Mar 2019 09:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netflix.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8FAbz8OodGpKKBMBnfD03Nn//jmUx/fpTGyYC2ty5hM=;
        b=mtnK2E4tnJzu5Q91jVksCgUzDl5fV8RkndBXwCIjrUvuTaNEUGQRf3sywQsP3EUDHL
         rqYH1W41RNMXkbvQI8aJsGlihUJIu/r4UMLrTmdacLUP+ETsIXmQQtnZ/qSVmEvnWQUg
         rcC2SokVZqR8lWDtA3S1uKVg4URim6b9ukxVw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8FAbz8OodGpKKBMBnfD03Nn//jmUx/fpTGyYC2ty5hM=;
        b=a/QwbM34YmMKgt7t1owkcOehxQ7ZeKkFnE9jY+sz1AhAsLL2Q2DLEu07Xe27xE5rv0
         LH4qq9NvlxgH0t+exRi/D28SmI5ZparvhBU40LdOWvKM4A55BOS0igtDh5iNhCoT9sVW
         2Y/kZlp7k7369J5reEGLkVC33RJYYyLQ44zJra+uS5ECnQbYKznNoPnsI9iwG/Q68BXW
         4XoxHa6aiVWtpi8aKZIxDJxRj7+PoiCNK31/3c8Rq9XHTPvUwkDJlk/N9Y0jBRVJNLhJ
         yA2A5d5heODbNpvgR4BtQ/dN59WwCWXP76KqbnMcm6nTUffQiF7xmqZnUrNDOLFbAceN
         3IBw==
X-Gm-Message-State: APjAAAXZMMIPx/goIKjJ6dCfbOxjLiCB5kVOr7d8774U+q2vc8AKBNl0
        Mhy4l5CwAsnv3k4erjptiBGGjL80L8cNpO1PiredOw==
X-Google-Smtp-Source: APXvYqxbdyGSczJ1gmi6L3x1L0hQhe3ibp3qI9kuc5EhCRctd+jqV8FZeX3q7DMDnacqAoCRiH6gjeaHwJ2sPlo2208=
X-Received: by 2002:adf:b211:: with SMTP id u17mr30138758wra.322.1552494627943;
 Wed, 13 Mar 2019 09:30:27 -0700 (PDT)
MIME-Version: 1.0
References: <201902251554.x1PFsD3w017626@userv0121.oracle.com>
 <20190226061823.f7hfs7yojfuycqmg@ast-mbp.dhcp.thefacebook.com>
 <20190226064601.GE16689@oracle.com> <20190305185950.rpx7srzpbya5psnf@ast-mbp.dhcp.thefacebook.com>
 <20190306020357.GG32758@oracle.com> <20190307213035.5eagphx6vswxalai@ast-mbp.dhcp.thefacebook.com>
 <20190311142127.GA11634@oracle.com> <CAJN39ohS0+GCLMsc3s_JyROTDty8eomRJ==QW34YxhDrDGr9KA@mail.gmail.com>
 <20190312032405.GE11634@oracle.com> <CAJN39ohP2+k5V3CbNRKixdZ+_u4Zgk=Cdt5m5eE27vAv0Pp=Rg@mail.gmail.com>
 <20190312165335.GG11634@oracle.com>
In-Reply-To: <20190312165335.GG11634@oracle.com>
From:   Brendan Gregg <bgregg@netflix.com>
Date:   Wed, 13 Mar 2019 09:30:02 -0700
Message-ID: <CAJN39oio2i_TJ-DY62EO-59ed0mL1hvoPtgTBoVZYfZU6Ja4bg@mail.gmail.com>
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

On Tue, Mar 12, 2019 at 9:54 AM Kris Van Hees <kris.van.hees@oracle.com> wrote:
>
> On Mon, Mar 11, 2019 at 11:03:10PM -0700, Brendan Gregg wrote:
> > On Mon, Mar 11, 2019 at 8:24 PM Kris Van Hees <kris.van.hees@oracle.com> wrote:
> > >
> > > On Mon, Mar 11, 2019 at 06:29:55PM -0700, Brendan Gregg wrote:
> > > > On Mon, Mar 11, 2019 at 7:21 AM Kris Van Hees <kris.van.hees@oracle.com> wrote:
> > > > >
> > > > > On Thu, Mar 07, 2019 at 01:30:37PM -0800, Alexei Starovoitov wrote:
> > > > > > On Tue, Mar 05, 2019 at 09:03:57PM -0500, Kris Van Hees wrote:
> > > > [...]
> > > > > > > But being able to do things like this without
> > > > > > > needing to touch the context of any other BPF program type is a great benefit
> > > > > > > to offer tracing tools, as far as I see it.
> > > > > >
> > > > > > I still don't understand what you're referring to by 'things like this'
> > > > > > that somehow will be possible in the future, but not possible today.
> > > > > > Could you please give concrete example?
> > > > >
> > > > > My apologies for not being clear.  I am referring to the features of the
> > > > > gtrace context in terms of containing task information, and output buffers
> > > > > to be used in BPF programs triggered from various probe sources (kprobe,
> > > > > tracepoints, ...)  I would not want to suggest making changes to all the
> > > > > different program contexts in order to support tracing needs because that
> > > > > would be wrong.  Doing it in a central place makes it a lot easier to maintain
> > > > > without impacting other program types, etc.
> > > > >
> > > > > Of course, yes, bpf_probe_read() and bpf_perf_event_output() can be used
> > > > > to implement a lot of what existing tracing tools like DTrace can do, if you
> > > > > write them based on that.  One limitations I am obviously working with is
> > > > > that DTrace already exists and has existed for a long time.  And while it is
> > > > > 100% available as open source, it involves a pretty involved set of patches to
> > > > > be applied to the kernel to be able to use it which is just not ideal.  Hence
> > > > > the goal to make it available by re-using as much of the existing features in
> > > > > Linux as possible, while still maintaining the same level of functionality in
> > > > > DTrace.  That means we need to fill the gaps - and from where I am sitting,
> > > > > the ways to do that might as well be of use to others (if they want to).
> > > > >
> > > > > If phrasing things in the context of DTrace would make the conversation easier
> > > > > I certainly don;t mind doing that, but I really don't want to limit my patches
> > > > > to supporting just DTrace (even if right now it might be the only tracer using
> > > > > it).
> > > >
> > > > As a concrete example, can you point to one of my own published DTrace
> > > > tools that BPF can't do? These were created to solve many real
> > > > production issues, and make good use cases. I've been porting them
> > > > over to BPF (bcc and bpftrace) without too much problem, and I can't
> > > > think of a single one that I couldn't port over today.
> > >
> > > I am unclear how pointing at one of your published DTrace tools would
> > > contribute to this discussion.  Surely the scope of use cases is not limited
> > > to the DTrace scripts you published?
> > >
> > > Either way, one of the features that I make use of is speculative tracing.
> >
> > The subject was a concrete example. I don't think I used speculative
> > tracing in any of my scripts. Can you pick a better example of
> > something BPF can't do?
>
> Well, then speculative tracing is a good example of something that cannot be
> done right now.  The specopen.d script that is part of the DTrace documentation
> and is also featured in the test suite makes for a concrete example.  That
> script has been used as a kind of template script in situations where we had
> to analyze code paths associated with a specific subset of conditions that
> could not be known beforehand.

I used spec tracing zero times in any of my published scripts from
fifteen years of using DTrace, and zero times in my 1152-page DTrace
book. Might I find a use one day? Maybe, just as you have. But I
wouldn't call it a great example of necessary functionality!

Besides, I bet we could implement spec tracing using existing BPF maps
if we wanted -- I just haven't had that need.

>
> Are there other ways to accomplish the same thing?  Sure.  But I don't think
> that is really the point.  There are often multiple tools that can do the same
> thing (or close to the same thing), and people have the option to choose one
> or the other.  DTrace is one of those tools, as is systemtap, bpftrace, perf,
> and other tools.
>
> > > And yes, even that could be handled with some ugly workarounds but my intent
> > > is to implement things in a more clean way rather than depending on a bunch
> > > of workarounds to make it somewhat work.
> > >
> > > > There's a few minor things that I'm currently doing workarounds for,
> > > > like ppid, but that should be satisfied with a few more helpers. And
> > > > if it's really niche, then BTF sounds like a good solution.
> > >
> > > Of course, we can always add more helpers to get to information that is
> > > needed, but that is hardly a practical solution in the long run, and at
> > > Plumbers 2019 it was already indicated that just adding helpers to get to
> > > more information about tasks is not the route people want to take.
> > >
> > > > If your ultimate goal is to have a command called "dtrace" that runs D
> > > > programs, to support your existing users, then I'd add a lex/yacc pair
> > > > to bpftrace and have it emit a dtrace binary.
> > >
> > > My goal is not to have a command called dtrace that somehow simply provides
> > > some form of support for dtrace scripts in some legacy support model.  My
> > > goal is to make DTrace available on Linux based on existing kernel features
> > > (and contributing extra features where needed, in a collaborative manner).
> >
> > If bpftrace builds a dtrace binary that runs D code, then you just did
> > make DTrace available on Linux.
> >
> > And without changing the kernel.
>
> If bpftrace could do everything that DTrace does, in a way that is 100%
> transparent to the user, and without requiring extra dependencies like e.g.
> software development packages (llvm, etc) to be installed on the system where
> it will be used in production, I think we wouldn't be having this conversation.

bpftrace is solving that need, and it was built from the ground up to
work with eBPF. It's going to provide 100% of useful functionality.
Getting it available out of the box is both a user-space and distro
problem.

>
> Anyway, I feel we're getting off track here...  the discussion is not about
> whether bpftrace can do what dtrace can do, or any other tool for that matter.
> There is a need for DTrace on Linux and I am working on making that possible

I wanted DTrace on Linux five years ago. Now I don't. We have eBPF,
which does more.

> in a way where DTrace is one among multiple tracing tools, and by leveraging

Multiple tracing tools? This will fracture the user and engineering
communities. People have complained enough about Ftrace and perf and
BPF -- we don't need a fourth tracing framework that doesn't solve any
new problems.

We can add a legacy interface to bpftrace for running D programs, to
help people transition. That can be done as a user-space parser.

Brendan

-- 
Brendan Gregg, Senior Performance Architect, Netflix
