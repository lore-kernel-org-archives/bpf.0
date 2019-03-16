Return-Path: <SRS0=MJ0i=RT=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3F6EC43381
	for <bpf@archiver.kernel.org>; Sat, 16 Mar 2019 01:49:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B605218D8
	for <bpf@archiver.kernel.org>; Sat, 16 Mar 2019 01:49:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="2epCKxb7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbfCPBt4 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 15 Mar 2019 21:49:56 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:50700 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbfCPBtz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 15 Mar 2019 21:49:55 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2G1nenv042483;
        Sat, 16 Mar 2019 01:49:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=8Bxk/snTCF6X3aOuDkkMSlA5Ps4wCCozcOLtLAdHaOw=;
 b=2epCKxb7a3hUF6bq5+yjRNUb+MiiZJi1V61M1uEhQkYQLRS5L+Pb9fANoeeEVPnWtGZk
 HePaKVnE6VFqf5kqf2hQLHL3V8V8OeKDYH0vg6yZMpKCA9vUWaZc+SM/es1GqtJRv3Dy
 h7Eicz/e1zMRBzXJlZVidiyTnp1owkE2zRqpFa4g+tvIgEOxvqdHfgTxKe7nTNP+eGwX
 L3ZWhYog/FwPBE5u8fhCamTW9gTHR7G8sMObHLtkREhK6JYHLnXLpeBFPPMvu3B79m5N
 RRQNX7ydGvMXaFmuTpZZgsXvbUJ+fbtjjrTEh1XvRoMKcYlYd978FN9S9QaPcYlO592i Sg== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2r44wusmp1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 16 Mar 2019 01:49:40 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x2G1nefw029278
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 16 Mar 2019 01:49:40 GMT
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x2G1ndY2023088;
        Sat, 16 Mar 2019 01:49:39 GMT
Received: from localhost (/10.159.211.98)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 16 Mar 2019 01:49:38 +0000
Date:   Fri, 15 Mar 2019 21:49:35 -0400
From:   Kris Van Hees <kris.van.hees@oracle.com>
To:     Brendan Gregg <bgregg@netflix.com>
Cc:     Kris Van Hees <kris.van.hees@oracle.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [PATCH 0/2] bpf: context casting for tail call and gtrace prog
 type
Message-ID: <20190316014935.GP11634@oracle.com>
References: <20190226064601.GE16689@oracle.com>
 <20190305185950.rpx7srzpbya5psnf@ast-mbp.dhcp.thefacebook.com>
 <20190306020357.GG32758@oracle.com>
 <20190307213035.5eagphx6vswxalai@ast-mbp.dhcp.thefacebook.com>
 <20190311142127.GA11634@oracle.com>
 <CAJN39ohS0+GCLMsc3s_JyROTDty8eomRJ==QW34YxhDrDGr9KA@mail.gmail.com>
 <20190312032405.GE11634@oracle.com>
 <CAJN39ohP2+k5V3CbNRKixdZ+_u4Zgk=Cdt5m5eE27vAv0Pp=Rg@mail.gmail.com>
 <20190312165335.GG11634@oracle.com>
 <CAJN39oio2i_TJ-DY62EO-59ed0mL1hvoPtgTBoVZYfZU6Ja4bg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJN39oio2i_TJ-DY62EO-59ed0mL1hvoPtgTBoVZYfZU6Ja4bg@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9196 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903160011
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 13, 2019 at 09:30:02AM -0700, Brendan Gregg wrote:
> On Tue, Mar 12, 2019 at 9:54 AM Kris Van Hees <kris.van.hees@oracle.com> wrote:
> >
> > On Mon, Mar 11, 2019 at 11:03:10PM -0700, Brendan Gregg wrote:
> > > On Mon, Mar 11, 2019 at 8:24 PM Kris Van Hees <kris.van.hees@oracle.com> wrote:
> > > >
> > > > On Mon, Mar 11, 2019 at 06:29:55PM -0700, Brendan Gregg wrote:
> > > > > On Mon, Mar 11, 2019 at 7:21 AM Kris Van Hees <kris.van.hees@oracle.com> wrote:
> > > > > >
> > > > > > On Thu, Mar 07, 2019 at 01:30:37PM -0800, Alexei Starovoitov wrote:
> > > > > > > On Tue, Mar 05, 2019 at 09:03:57PM -0500, Kris Van Hees wrote:
> > > > > [...]
> > > > > > > > But being able to do things like this without
> > > > > > > > needing to touch the context of any other BPF program type is a great benefit
> > > > > > > > to offer tracing tools, as far as I see it.
> > > > > > >
> > > > > > > I still don't understand what you're referring to by 'things like this'
> > > > > > > that somehow will be possible in the future, but not possible today.
> > > > > > > Could you please give concrete example?
> > > > > >
> > > > > > My apologies for not being clear.  I am referring to the features of the
> > > > > > gtrace context in terms of containing task information, and output buffers
> > > > > > to be used in BPF programs triggered from various probe sources (kprobe,
> > > > > > tracepoints, ...)  I would not want to suggest making changes to all the
> > > > > > different program contexts in order to support tracing needs because that
> > > > > > would be wrong.  Doing it in a central place makes it a lot easier to maintain
> > > > > > without impacting other program types, etc.
> > > > > >
> > > > > > Of course, yes, bpf_probe_read() and bpf_perf_event_output() can be used
> > > > > > to implement a lot of what existing tracing tools like DTrace can do, if you
> > > > > > write them based on that.  One limitations I am obviously working with is
> > > > > > that DTrace already exists and has existed for a long time.  And while it is
> > > > > > 100% available as open source, it involves a pretty involved set of patches to
> > > > > > be applied to the kernel to be able to use it which is just not ideal.  Hence
> > > > > > the goal to make it available by re-using as much of the existing features in
> > > > > > Linux as possible, while still maintaining the same level of functionality in
> > > > > > DTrace.  That means we need to fill the gaps - and from where I am sitting,
> > > > > > the ways to do that might as well be of use to others (if they want to).
> > > > > >
> > > > > > If phrasing things in the context of DTrace would make the conversation easier
> > > > > > I certainly don;t mind doing that, but I really don't want to limit my patches
> > > > > > to supporting just DTrace (even if right now it might be the only tracer using
> > > > > > it).
> > > > >
> > > > > As a concrete example, can you point to one of my own published DTrace
> > > > > tools that BPF can't do? These were created to solve many real
> > > > > production issues, and make good use cases. I've been porting them
> > > > > over to BPF (bcc and bpftrace) without too much problem, and I can't
> > > > > think of a single one that I couldn't port over today.
> > > >
> > > > I am unclear how pointing at one of your published DTrace tools would
> > > > contribute to this discussion.  Surely the scope of use cases is not limited
> > > > to the DTrace scripts you published?
> > > >
> > > > Either way, one of the features that I make use of is speculative tracing.
> > >
> > > The subject was a concrete example. I don't think I used speculative
> > > tracing in any of my scripts. Can you pick a better example of
> > > something BPF can't do?
> >
> > Well, then speculative tracing is a good example of something that cannot be
> > done right now.  The specopen.d script that is part of the DTrace documentation
> > and is also featured in the test suite makes for a concrete example.  That
> > script has been used as a kind of template script in situations where we had
> > to analyze code paths associated with a specific subset of conditions that
> > could not be known beforehand.
> 
> I used spec tracing zero times in any of my published scripts from
> fifteen years of using DTrace, and zero times in my 1152-page DTrace
> book. Might I find a use one day? Maybe, just as you have. But I
> wouldn't call it a great example of necessary functionality!

Perhaps not for you, but it is for me.  There are other much simpler things
that are currently missing, such as being able to obtain euid/egid, ppid (as
you mentioned already), ...  There are workaround possible or helpers can be
added, but I would think that making them available by means of a mechanism
that is very much native to BPF (obtaining data from context, as is done for
networking packets) makes a lot more sense.

> Besides, I bet we could implement spec tracing using existing BPF maps
> if we wanted -- I just haven't had that need.
> 
> >
> > Are there other ways to accomplish the same thing?  Sure.  But I don't think
> > that is really the point.  There are often multiple tools that can do the same
> > thing (or close to the same thing), and people have the option to choose one
> > or the other.  DTrace is one of those tools, as is systemtap, bpftrace, perf,
> > and other tools.
> >
> > > > And yes, even that could be handled with some ugly workarounds but my intent
> > > > is to implement things in a more clean way rather than depending on a bunch
> > > > of workarounds to make it somewhat work.
> > > >
> > > > > There's a few minor things that I'm currently doing workarounds for,
> > > > > like ppid, but that should be satisfied with a few more helpers. And
> > > > > if it's really niche, then BTF sounds like a good solution.
> > > >
> > > > Of course, we can always add more helpers to get to information that is
> > > > needed, but that is hardly a practical solution in the long run, and at
> > > > Plumbers 2019 it was already indicated that just adding helpers to get to
> > > > more information about tasks is not the route people want to take.
> > > >
> > > > > If your ultimate goal is to have a command called "dtrace" that runs D
> > > > > programs, to support your existing users, then I'd add a lex/yacc pair
> > > > > to bpftrace and have it emit a dtrace binary.
> > > >
> > > > My goal is not to have a command called dtrace that somehow simply provides
> > > > some form of support for dtrace scripts in some legacy support model.  My
> > > > goal is to make DTrace available on Linux based on existing kernel features
> > > > (and contributing extra features where needed, in a collaborative manner).
> > >
> > > If bpftrace builds a dtrace binary that runs D code, then you just did
> > > make DTrace available on Linux.
> > >
> > > And without changing the kernel.
> >
> > If bpftrace could do everything that DTrace does, in a way that is 100%
> > transparent to the user, and without requiring extra dependencies like e.g.
> > software development packages (llvm, etc) to be installed on the system where
> > it will be used in production, I think we wouldn't be having this conversation.
> 
> bpftrace is solving that need, and it was built from the ground up to
> work with eBPF. It's going to provide 100% of useful functionality.
> Getting it available out of the box is both a user-space and distro
> problem.
> 
> >
> > Anyway, I feel we're getting off track here...  the discussion is not about
> > whether bpftrace can do what dtrace can do, or any other tool for that matter.
> > There is a need for DTrace on Linux and I am working on making that possible
> 
> I wanted DTrace on Linux five years ago. Now I don't. We have eBPF,
> which does more.

I respect your personal feeling on this, but there are people who use DTrace
on Linux, and who want DTrace to keep improving and be more based on existing
core kernel features.  You say that eBPF does more, but clearly it does not
since there are features DTrace has that eBPF currently does not provide (as
basic as ppid of a task).

But really, where does that even matter?  If eBPF ends up being able to do
more than the current DTrace can, then a DTrace that is making use of eBPF
will obviously be able to do more as well.  That's a great benefit in my
opinion.

> > in a way where DTrace is one among multiple tracing tools, and by leveraging
> 
> Multiple tracing tools? This will fracture the user and engineering
> communities. People have complained enough about Ftrace and perf and
> BPF -- we don't need a fourth tracing framework that doesn't solve any
> new problems.

People already use multiple tools and those tools continue being developed.
And I am not working on a tracing framework alongside whatever already exists,
but rather on integrating DTrace with the existing tracing features in the
kernel.  Even if you feel you don't need another tracing tool, fact is that
DTrace already exists on Linux even though the patches are not in the upstream
kernel.  People use it and like it.  Working to make it available without the
rather invasive kernel changes and instead building on the existing kernel
features means we also can contribute new features that expand the capabilities
of eBPF (within its excellent safety mechanisms) and hopefully other tracing
features.  What is wrong with that?

There will always be new features added to tools, there will always be new
tools that emerge.  That's the nature of software development.  And people
have a tendency to work with tools they like.  Should everyone stop writing
C programs because C++ exists?

> We can add a legacy interface to bpftrace for running D programs, to
> help people transition. That can be done as a user-space parser.

Perhaps - but there clearly are features you are missing.  And your statement
makes the rather big assumption that people *want* to transition.  Why would
you force people to transition, or live with some kind of legacy interface?

But the point of the discussion here is not whether bpftrace can be made to
behave as if it is dtrace - I submitted patches that implement new
functionality.  Are you suggesting that those patches should be rejected
off-hand based on the fact that you feel they are unnecessary because people
should use bpftrace instead?

	Kris
