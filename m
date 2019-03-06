Return-Path: <SRS0=uow0=RJ=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21F7DC43381
	for <bpf@archiver.kernel.org>; Wed,  6 Mar 2019 02:04:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0B2020663
	for <bpf@archiver.kernel.org>; Wed,  6 Mar 2019 02:04:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="L9counOC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727901AbfCFCEW (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 5 Mar 2019 21:04:22 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:56850 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727181AbfCFCEW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 5 Mar 2019 21:04:22 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2623fJu020921;
        Wed, 6 Mar 2019 02:04:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=7Bp0DSvNGrePO78we+MbzFIiA9rT5AbFx7X4IhN/6ME=;
 b=L9counOCsgVx2p7khfwZ0mkNtT9ipwkmykQ7BdaB+hZDLH7wMObAomn9BM9u4eK56Wav
 vdcFT/XKTxnLE1kovs12FFsocTPKkPIIbYG54LzdD/g0iN9JWW1UgDJJuQvXRN9wIICI
 hV6deQO+xQ/spWH1/Mm/bAbTLiVWFxhuZSKLv54XoL+mRrxET1dgLxIyHxR2t+bsNADS
 xHmIIb9MuO608wk078H6lYDJvU56P4ozgPQFm4K/HDgq7jkiTqlTSlyBaISVZ2b8n+7J
 8HrUJQf0BpthYjYEUiGutQUQoP881o+8IhvVzcKQRwsxwoSXAbvTvPxXS2E8o169dgUf 2w== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2130.oracle.com with ESMTP id 2qyfbe9a00-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Mar 2019 02:04:02 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x2624014022768
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 6 Mar 2019 02:04:01 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x26240ED007620;
        Wed, 6 Mar 2019 02:04:00 GMT
Received: from localhost (/10.159.211.98)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 05 Mar 2019 18:03:59 -0800
Date:   Tue, 5 Mar 2019 21:03:57 -0500
From:   Kris Van Hees <kris.van.hees@oracle.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Kris Van Hees <kris.van.hees@oracle.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, daniel@iogearbox.net
Subject: Re: [PATCH 0/2] bpf: context casting for tail call and gtrace prog
 type
Message-ID: <20190306020357.GG32758@oracle.com>
References: <201902251554.x1PFsD3w017626@userv0121.oracle.com>
 <20190226061823.f7hfs7yojfuycqmg@ast-mbp.dhcp.thefacebook.com>
 <20190226064601.GE16689@oracle.com>
 <20190305185950.rpx7srzpbya5psnf@ast-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190305185950.rpx7srzpbya5psnf@ast-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9186 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903060011
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 05, 2019 at 10:59:52AM -0800, Alexei Starovoitov wrote:
> On Tue, Feb 26, 2019 at 01:46:01AM -0500, Kris Van Hees wrote:
> > On Mon, Feb 25, 2019 at 10:18:25PM -0800, Alexei Starovoitov wrote:
> > > On Mon, Feb 25, 2019 at 07:54:13AM -0800, Kris Van Hees wrote:
> > > > 
> > > > The goal is to further extend the BPF_PROG_TYPE_GTRACE implementation to
> > > > support what tracers commonly need, and I am also looking at ways to further
> > > > extend this model to allow more tracer-specific features as well without the
> > > > need for adding a BPF program types for every tracer.
> > > 
> > > It seems by themselves the patches don't provide any new functionality,
> > > but instead look like plumbing to call external code.
> > 
> > The patches are definitely not plumbing to call external code, and if I gave
> > that impression I apologise.  I overlooked the information you quote below on
> > allowing new functionality through modules when I wrote the comment above but
> > please note that it was a forward-looking comment in terms of what could be
> > done - not a reason for the patches that I submitted.
> > 
> > The patches accomplish something that is totally independent from that: they
> > make it possible for existing events that execute BPF programs when triggered
> > to transfer control to a BPF program with a more rich context.  The first
> > patch makes such a transfer possible (using tail-call combined with converting
> > the context to the new program type), and the second patch provides one such
> > program type (generic trace).  The new functionality provided by the program
> > type is direct access to task information that previously could only be
> > obtained through helper calls.  E.g. the new program type allows programs to
> > access the task state, prio, ppid, euid, and egid.  None of those pieces of
> > information can currently be obtained unless you start poking around in
> > memory using bpf_probe_read() helper calls.
> 
> I don't think I understand the problem you're trying to solve.
> >From kprobe/tracepoints/etc bpf prog can use bpf_probe_read() to read everything.
> Are you saying direct access to state, prio, ppid, euid, and egid via context
> is much superior? Why? Because it's more stable?

When you provide tracing to non-privileged users you definitely do not want
to allow BPF programs to access any memory they want in kernel space, yet you
would still want to be able to provide a decent amount of information about
tasks at time of probe firing.

> Why stop at these fields then? task_struct has many others.
>
> What we observed that no matter how many fields we add to stable uapi
> somebody will always request one more. For networking the total number of
> such fields is contained, but for tracing we're talking about thousands
> of useful fields. We cannot make them stable.
> Hence we've been working on alternative approach via BTF to make all
> of kernel internal fields sort-of stable via 'compile once' technique that
> we described at the last LPC.

Sure, but the ones I put in there were an example of how this can be used.
And again, in the case of unprivileged tracing, this easily becomes an issue
about where you end up enforcing what a tracing program can do and cannot do.
There will always be cases where more than the 'standard' information is
needed for a tracing task, and then it would be quite reasonable to conclude
that a higher level of privileges is required to accomplish that - but that
shouldn't prevent unprivileged tracing from being able to be useful as well.

Again, the limited set of fields I put in there right now is a matter of
showing how this can be used.  It is certainly meant to be expended quite a
bit.

The primary reason though behind the context conversion approach and the
generic tracing program type and context is that tracing on Linux based on
the existing kernel facilities limits the userspace tools because userspace
has quite limited control over what happens when a probe/event fires.  One
of the features of advanced tracing tools has been the ability to have more
(safe) control over what happens when the probe/event fires and how data is
stored in output buffers.  Since the userspace tool is the one requested data
and ultimately processes the generated data, it stands to reason that it
would benefit from being able to have more freedom in that area.  But that
means it needs to be able to provide a BPF program of a type that more closely
relates to the tracing tool functionality rather than the probe or event
itself (especially since probes and events are very specific, and by their
very nature should not really care about how userspace uses information).
This is again even more true for privileged tracing - right now there is a lot
of useful task information that you cannot get to without bpf_probe_read() but
unprivileged users really shouldn't be able to just read arbitrary kernel
memory.

So in summary, I am trying to solve two (related) problems:

- Ensure that unprivileged tracing can obtain information about the task that
  triggered a probe or event.  There will always be limitations but we can do
  better than is available now.
- Allow tracing tools ab ability to provide actions to be performed when a
  probe or event fires, beyond what the individual BPF program types allow
  for the specific probe/event types (and do it in a generic manner, in a
  sense encapsulating multiple probe/event types in a more generic tracing
  context).

A patch I am currently working on ties into this (and I hope to get it ready
sometime next week).  It builds on the support you already have for accessing
packet data from the __sk_buff context.  If we can make this same functionality
available to other contexts as well, my goal would be to make it possible for
the generic tracing context to have a buffer (data and data_end members) that
the BPF program can issue direct stores to as a means to allow a tracing
program to control how data is written into the buffer.  I am still working
out some details but I have a prototype working, and it retains all safety
provisions that BPF offres us.  But being able to do things like this without
needing to touch the context of any other BPF program type is a great benefit
to offer tracing tools, as far as I see it.

	Kris
