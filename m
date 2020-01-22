Return-Path: <SRS0=pBRf=3L=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8F7FC2D0DB
	for <bpf@archiver.kernel.org>; Wed, 22 Jan 2020 16:54:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE57424656
	for <bpf@archiver.kernel.org>; Wed, 22 Jan 2020 16:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579712073;
	bh=mx+redtQzWmHCWsQ3WGM+eVOVVPg++rcY3qMRQLWuQw=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=HUgg2IKLsLJlBd8V5PyvwGsBC9ckugcfZ1sM0MTH0UNuzrUklS/j9SEDVQmpRbp+5
	 ktVDEAgCz34Km8OIRugje4FsO2F7k3ZcflZVH4dmHe3sMovU75amfUwhaZPuQ6uMGe
	 VfsubmySYZgPnytauKkBq537u7kConlqpZ4hmJs4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbgAVQyd (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 22 Jan 2020 11:54:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:37018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725802AbgAVQyd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Jan 2020 11:54:33 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6CB0A21569;
        Wed, 22 Jan 2020 16:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579712072;
        bh=mx+redtQzWmHCWsQ3WGM+eVOVVPg++rcY3qMRQLWuQw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=eNaKdzifcvURTJfoaboy5eTRTDWi0uaE8ycchff0qcNqPRWHkOsq79miUlZuhEl5i
         xQYKaDcV4OC/WHwaNHji1SiVzk2Wz0fIwavWF1IFET3i3w2ngjIN5F2Is3bAVjIm/f
         Xcko2vpiba3ZzFQZwHar9Xkk1XyfJFS82sgzLm8c=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 3F1113520A91; Wed, 22 Jan 2020 08:54:32 -0800 (PST)
Date:   Wed, 22 Jan 2020 08:54:32 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        "David S . Miller" <davem@davemloft.net>, joel@joelfernandes.org,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
Subject: Re: [RFT PATCH 04/13] kprobes: Make optimizer delay to 1 second
Message-ID: <20200122165432.GH2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <157918584866.29301.6941815715391411338.stgit@devnote2>
 <157918589199.29301.4419459150054220408.stgit@devnote2>
 <20200121192905.0f001c61@gandalf.local.home>
 <20200122162317.0299cf722dd618147d97e89c@kernel.org>
 <20200122071115.28e3c763@gandalf.local.home>
 <20200122221240.cef447446785f46862fee97a@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200122221240.cef447446785f46862fee97a@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jan 22, 2020 at 10:12:40PM +0900, Masami Hiramatsu wrote:
> On Wed, 22 Jan 2020 07:11:15 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > On Wed, 22 Jan 2020 16:23:17 +0900
> > Masami Hiramatsu <mhiramat@kernel.org> wrote:
> > 
> > > On Tue, 21 Jan 2020 19:29:05 -0500
> > > Steven Rostedt <rostedt@goodmis.org> wrote:
> > > 
> > > > On Thu, 16 Jan 2020 23:44:52 +0900
> > > > Masami Hiramatsu <mhiramat@kernel.org> wrote:
> > > >   
> > > > > Since the 5 jiffies delay for the optimizer is too
> > > > > short to wait for other probes, make it longer,
> > > > > like 1 second.  
> > > > 
> > > > Hi Masami,
> > > > 
> > > > Can you explain more *why* 5 jiffies is too short.  
> > > 
> > > Yes, I had introduced this 5 jiffies delay for multiple probe registration
> > > and unregistration like systemtap, which will use array-based interface to
> > > register/unregister. In that case, 5 jiffies will be enough for the delay
> > > to wait for other kprobe registration/unregsitration.
> > > 
> > > However, since perf and ftrace register/unregister probes one-by-one with
> > > RCU synchronization interval, the optimizer will be started before
> > > finishing to register/unregister all probes.
> > > And the optimizer locks kprobe_mutex a while -- RCU-tasks synchronization.
> > > Since the kprobe_mutex is also involved in disabling kprobes, this also
> > > stops probe-event disabling.
> > > 
> > > Maybe 5 jiffies is enough for adding/removing a few probe events, but
> > > not enough for dozens of probe events.
> > > 
> > 
> > Perhaps we should have a mechanism that can detect new probes being
> > added, and just continue to delay the optimization, instead of having
> > some arbitrary delay.
> 
> Yes, that is what [03/13] does :) 
> Anyway, it seems that the RCU-synchronization takes more than 5 jiffies.
> And in that case, [03/13] still doesn't work. That's why I added this patch
> after that.

If the RCU synchronization is synchronize_rcu_tasks(), then yes, it
will often take way more than 5 jiffies.  If it is synchronize_rcu(),
5 jiffies would not be unusual, especially on larger systems.
But in the case of synchronize_rcu(), one option is to instead use
synchronize_rcu_expedited().  It is not clear that this last is really
justified in this case, but figured it might be worth mentioning.

							Thanx, Paul
