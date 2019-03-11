Return-Path: <SRS0=tULY=RO=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3904DC43381
	for <bpf@archiver.kernel.org>; Mon, 11 Mar 2019 14:21:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0AC32087C
	for <bpf@archiver.kernel.org>; Mon, 11 Mar 2019 14:21:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GeV6CU2b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727489AbfCKOVu (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 11 Mar 2019 10:21:50 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:48190 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726826AbfCKOVu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 11 Mar 2019 10:21:50 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2BEJCch188465;
        Mon, 11 Mar 2019 14:21:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=0nAdMcoSAytBTgzc4hQRzOt8zb/A6NEbRzt0YAusBUM=;
 b=GeV6CU2bY0s7676ERz++0xYtNHe6gLb2RK9lQewJBu8YZEiq30D3XT0EWIospPLg8tbW
 hSioziBxxi24Pl5Z+1V4a943EFAWdj81K2lMIPIPcHfQsEmnC0HAL3v/2DpkjHvxH/cd
 9BhY3bumfu5ElVqOSgRvoPQxgKxd3PdeSfALitXLyN8uUhuJj1gy+1wbc1wxiyxLUHzN
 FYbn21eRHdKutEnCE7BUQsdsKyHXLZjd5Ja3pHpWTcqIfjHKTwCxJCiLEq1aQ5Nrwguv
 ZNnn4e2NT07ulhI9yVZGKEzpum8pLAfQpiHIwj+KvPOTQ+U7NmDNbgDUFym/Fut1IjCl NQ== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2130.oracle.com with ESMTP id 2r430ef60w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Mar 2019 14:21:29 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x2BELTtp012358
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Mar 2019 14:21:29 GMT
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x2BELTo2017786;
        Mon, 11 Mar 2019 14:21:29 GMT
Received: from localhost (/10.159.211.98)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 11 Mar 2019 07:21:29 -0700
Date:   Mon, 11 Mar 2019 10:21:27 -0400
From:   Kris Van Hees <kris.van.hees@oracle.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Kris Van Hees <kris.van.hees@oracle.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, daniel@iogearbox.net
Subject: Re: [PATCH 0/2] bpf: context casting for tail call and gtrace prog
 type
Message-ID: <20190311142127.GA11634@oracle.com>
References: <201902251554.x1PFsD3w017626@userv0121.oracle.com>
 <20190226061823.f7hfs7yojfuycqmg@ast-mbp.dhcp.thefacebook.com>
 <20190226064601.GE16689@oracle.com>
 <20190305185950.rpx7srzpbya5psnf@ast-mbp.dhcp.thefacebook.com>
 <20190306020357.GG32758@oracle.com>
 <20190307213035.5eagphx6vswxalai@ast-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190307213035.5eagphx6vswxalai@ast-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9192 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903110104
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Mar 07, 2019 at 01:30:37PM -0800, Alexei Starovoitov wrote:
> On Tue, Mar 05, 2019 at 09:03:57PM -0500, Kris Van Hees wrote:
> > 
> > So in summary, I am trying to solve two (related) problems:
> > 
> > - Ensure that unprivileged tracing can obtain information about the task that
> >   triggered a probe or event.  There will always be limitations but we can do
> >   better than is available now.
> 
> I think unprivileged tracing is a huge topic on its own.
> It's too easy to create security holes with such mechanism.
> kprobe/tracepoints/etc have been historically root only and I don't see a way
> for them to become unpriv.

I agree it is a huge topic and one that needs very careful attention, but I
believe it certainly can be done (DTrace on Solaris provided it, and while we
haven't implemented it on Linux thus far, the availability of BPF actually
makes it more realistic).  This remains an important goal for us, and while
it will take a while to get there, we certain want to contribute in this area.

> imo the existing /proc/pid/status is already more powerful than
> what you're proposing with gtrace context.

THe problem with /proc/pid/status is that it cannot be read at the exact same
time as when a peobe fires.  And when you're doing tracing, that is one of the
main requirements: looking at the system at the moment of the probe firing.
Surely, /proc/pid/status contains more information right now but as I mentioned
in earlier email, the gtrace context I proposed so far was merely showing what
I am trying to do - it is nowhere near the final version.

> > - Allow tracing tools ab ability to provide actions to be performed when a
> >   probe or event fires, beyond what the individual BPF program types allow
> >   for the specific probe/event types (and do it in a generic manner, in a
> >   sense encapsulating multiple probe/event types in a more generic tracing
> >   context).
> 
> I think existing bpf tracing is generic whereas proposed gtrace is not generic at all.
> 'generic' is a loaded word. we can throw it back and forth and won't make
> any forward progress. Let's focus on technical bits, ok?

Sure, I definitely agree that we can mean very different things with 'generic'.
It is important then to explain what I mean here though because it is rather
crucial to the design.  From the perspective of tracing that we want to be able
to do we are mostly interested in being able to look at the system as a whole
through the sequence of probes that fire.  In that way, the specific context of
each probe is important, but the actions to be executed when probes fire need
more than just that probe context - they also need information about the task
that is executing.  An example would be to trace whether non-root executables
(often scripts) make use of setuid executables that could potentially be a
security risk.  You end up tracing through a possible complex tree of task
clones, tasks issueing exec syscalls, and performing file operations.  The
probes themselves are pretty meaningless without the larger context.  It is the
task context combined with the probe specifics that provide the information you
need to execute meaningful actions when a probe fires.  And that information
needs to be obtained when the probe fires - reading it from /proc when the
probe data reaches userspace is often too late.  Think of the case where you
need to trace information when an exec syscall is executed - by the time
tracing data is available in a buffer for userspace to process, the syscall
will usually have completed and userspace will only be able to obtain task
info about the state *after* the exec took place.

The majority of tracing use-cases that I encounter relate to observing one or
more tasks rather than probes without caring about the task context, and I
would argue that most use-cases I have read about from other people match this
observation,  Since we want to be able to use BPF as the execution engine for
the probe actions, it seems to make sense to me that the BPF context available
to those programs would therefore be providing the task data and probe data,
so that the programs can be more naturally written based on the context that
makes sense for the functionality they are providing.

So, my patches provide a initial implementation of a BPF program context (and
a mechanism to execute programs in it as a result of probes triggering) that
serves the perspective of the tracer looking at tasks.

> > A patch I am currently working on ties into this (and I hope to get it ready
> > sometime next week).  It builds on the support you already have for accessing
> > packet data from the __sk_buff context.  If we can make this same functionality
> > available to other contexts as well, my goal would be to make it possible for
> > the generic tracing context to have a buffer (data and data_end members) that
> > the BPF program can issue direct stores to as a means to allow a tracing
> > program to control how data is written into the buffer. 
> 
> sounds like you're trying to reinvent bpf_perf_event_output() mechanism.

It sure sounds like that, but the difference is that bpf_perf_event_output()
encapsulates data you are providing in a specific format already.  Most of the
tracers that support BPF in some way seems to pick a perf_event output type
that allows providing raw data and use that to write out what they need to pass
to userspace.

Our situation is a bit different because we have an existing tracing tool
(DTrace) with its own requirements on what the output buffer data is supposed
to look like.  When I looked at the options of using (somewhat abusing) the
bpf_perf_event_output() mechanism as a vehicle to get data to userspace vs
supporting DTrace's format, I concluded that being able to let the tracer
(DTrace in my case) define the output format is a benefit because it means
others can do the same (if they want to).  And given that DTrace works with
multiple buffer types and with things like speculation buffers (buffers that
are used as temporary output store in place of the default buffer - in a way
that the rest of the action need not be aware of - and written to the default
buffer upon commit, or discarded when not needed), bpf_perf_event_output() is
not sufficient.

> > But being able to do things like this without
> > needing to touch the context of any other BPF program type is a great benefit
> > to offer tracing tools, as far as I see it.
> 
> I still don't understand what you're referring to by 'things like this'
> that somehow will be possible in the future, but not possible today.
> Could you please give concrete example?

My apologies for not being clear.  I am referring to the features of the
gtrace context in terms of containing task information, and output buffers
to be used in BPF programs triggered from various probe sources (kprobe,
tracepoints, ...)  I would not want to suggest making changes to all the
different program contexts in order to support tracing needs because that
would be wrong.  Doing it in a central place makes it a lot easier to maintain
without impacting other program types, etc.

Of course, yes, bpf_probe_read() and bpf_perf_event_output() can be used
to implement a lot of what existing tracing tools like DTrace can do, if you
write them based on that.  One limitations I am obviously working with is
that DTrace already exists and has existed for a long time.  And while it is
100% available as open source, it involves a pretty involved set of patches to
be applied to the kernel to be able to use it which is just not ideal.  Hence
the goal to make it available by re-using as much of the existing features in
Linux as possible, while still maintaining the same level of functionality in
DTrace.  That means we need to fill the gaps - and from where I am sitting,
the ways to do that might as well be of use to others (if they want to).

If phrasing things in the context of DTrace would make the conversation easier
I certainly don;t mind doing that, but I really don't want to limit my patches
to supporting just DTrace (even if right now it might be the only tracer using
it).

	Kris
