Return-Path: <SRS0=uxpp=Y5=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A63FCC5DF60
	for <bpf@archiver.kernel.org>; Tue,  5 Nov 2019 16:00:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82F5E2190F
	for <bpf@archiver.kernel.org>; Tue,  5 Nov 2019 16:00:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389843AbfKEQAg (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 5 Nov 2019 11:00:36 -0500
Received: from smtprelay0162.hostedemail.com ([216.40.44.162]:41752 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389760AbfKEQAg (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 5 Nov 2019 11:00:36 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 1B49218224D6E;
        Tue,  5 Nov 2019 16:00:35 +0000 (UTC)
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-HE-Tag: pail42_5c0b34e3fa954
X-Filterd-Recvd-Size: 2506
Received: from grimm.local.home (unknown [146.247.46.6])
        (Authenticated sender: rostedt@goodmis.org)
        by omf02.hostedemail.com (Postfix) with ESMTPA;
        Tue,  5 Nov 2019 16:00:32 +0000 (UTC)
Date:   Tue, 5 Nov 2019 11:00:28 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>, davem@davemloft.net,
        daniel@iogearbox.net, peterz@infradead.org, x86@kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org, kernel-team@fb.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH bpf-next 0/7] Introduce BPF trampoline
Message-ID: <20191105110028.7775192f@grimm.local.home>
In-Reply-To: <20191105154709.utmzm6qvtlux4hww@ast-mbp.dhcp.thefacebook.com>
References: <20191102220025.2475981-1-ast@kernel.org>
        <20191105143154.umojkotnvcx4yeuq@ast-mbp.dhcp.thefacebook.com>
        <20191105104024.4e99a630@grimm.local.home>
        <20191105154709.utmzm6qvtlux4hww@ast-mbp.dhcp.thefacebook.com>
X-Mailer: Claws Mail 3.17.4git49 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 5 Nov 2019 07:47:11 -0800
Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:

> > If you have to wait you may need to wait. The Linux kernel isn't
> > something that is suppose to put in temporary hacks, just to satisfy
> > someone's deadline.  
> 
> Ok. I will switch to text_poke and will make it hack free.
> ftrace mechanisms are being replaced by text_poke anyway.

I see that Facebook now owns Linux.

Peter's text poke patches most likely not be ready for the next
merge window either. Don't you require them?

The database of function nops are part of the ftrace mechanisms which
are not part of text poke, and there's strong accounting associated to
them which allows the user to see how their kernel is modified. This is
why I was against the live kernel patching modifying the function code
directly, because the user loses out on visibility into how their
kernel is being modified. Any "replacement" would require the same
transparency into the modification of the kernel.

I see how you work. You pressure someone into jumping to do your all
mighty work, and if they don't jump as you would like them too, you
work to circumvent them and try to make them irrelevant.

I'm sure the rest of the community will enjoy working with you too.

-- Steve
