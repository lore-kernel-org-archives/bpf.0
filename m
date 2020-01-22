Return-Path: <SRS0=pBRf=3L=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51E17C2D0DB
	for <bpf@archiver.kernel.org>; Wed, 22 Jan 2020 12:11:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BD2324683
	for <bpf@archiver.kernel.org>; Wed, 22 Jan 2020 12:11:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbgAVMLT (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 22 Jan 2020 07:11:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:59314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726094AbgAVMLT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Jan 2020 07:11:19 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 922862467F;
        Wed, 22 Jan 2020 12:11:17 +0000 (UTC)
Date:   Wed, 22 Jan 2020 07:11:15 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Brendan Gregg <brendan.d.gregg@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        "David S . Miller" <davem@davemloft.net>, paulmck@kernel.org,
        joel@joelfernandes.org,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
Subject: Re: [RFT PATCH 04/13] kprobes: Make optimizer delay to 1 second
Message-ID: <20200122071115.28e3c763@gandalf.local.home>
In-Reply-To: <20200122162317.0299cf722dd618147d97e89c@kernel.org>
References: <157918584866.29301.6941815715391411338.stgit@devnote2>
        <157918589199.29301.4419459150054220408.stgit@devnote2>
        <20200121192905.0f001c61@gandalf.local.home>
        <20200122162317.0299cf722dd618147d97e89c@kernel.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 22 Jan 2020 16:23:17 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> On Tue, 21 Jan 2020 19:29:05 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > On Thu, 16 Jan 2020 23:44:52 +0900
> > Masami Hiramatsu <mhiramat@kernel.org> wrote:
> >   
> > > Since the 5 jiffies delay for the optimizer is too
> > > short to wait for other probes, make it longer,
> > > like 1 second.  
> > 
> > Hi Masami,
> > 
> > Can you explain more *why* 5 jiffies is too short.  
> 
> Yes, I had introduced this 5 jiffies delay for multiple probe registration
> and unregistration like systemtap, which will use array-based interface to
> register/unregister. In that case, 5 jiffies will be enough for the delay
> to wait for other kprobe registration/unregsitration.
> 
> However, since perf and ftrace register/unregister probes one-by-one with
> RCU synchronization interval, the optimizer will be started before
> finishing to register/unregister all probes.
> And the optimizer locks kprobe_mutex a while -- RCU-tasks synchronization.
> Since the kprobe_mutex is also involved in disabling kprobes, this also
> stops probe-event disabling.
> 
> Maybe 5 jiffies is enough for adding/removing a few probe events, but
> not enough for dozens of probe events.
> 

Perhaps we should have a mechanism that can detect new probes being
added, and just continue to delay the optimization, instead of having
some arbitrary delay.

-- Steve
