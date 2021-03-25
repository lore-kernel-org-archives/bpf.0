Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF417C433DB
	for <bpf@archiver.kernel.org>; Thu, 25 Mar 2021 00:27:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC62961A1B
	for <bpf@archiver.kernel.org>; Thu, 25 Mar 2021 00:27:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234929AbhCYA0a (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 24 Mar 2021 20:26:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:45090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232029AbhCYA0S (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Mar 2021 20:26:18 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B3F6361A1A;
        Thu, 25 Mar 2021 00:26:15 +0000 (UTC)
Date:   Wed, 24 Mar 2021 20:26:13 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, X86 ML <x86@kernel.org>,
        Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, kuba@kernel.org, mingo@redhat.com,
        ast@kernel.org, tglx@linutronix.de, kernel-team@fb.com, yhs@fb.com,
        linux-ia64@vger.kernel.org,
        Abhishek Sagar <sagar.abhishek@gmail.com>
Subject: Re: [PATCH -tip v4 10/12] x86/kprobes: Push a fake return address
 at kretprobe_trampoline
Message-ID: <20210324202613.7cad6f4f@oasis.local.home>
In-Reply-To: <20210325084741.74bdb2b1d2ed00fe68840cea@kernel.org>
References: <161639518354.895304.15627519393073806809.stgit@devnote2>
        <161639530062.895304.16962383429668412873.stgit@devnote2>
        <20210323223007.GG4746@worktop.programming.kicks-ass.net>
        <20210324104058.7c06aaeb0408e24db6ba46f8@kernel.org>
        <20210324160143.wd43zribpeop2czn@treble>
        <20210325084741.74bdb2b1d2ed00fe68840cea@kernel.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 25 Mar 2021 08:47:41 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> > I think the REGS and REGS_PARTIAL cases can also be affected by function
> > graph tracing.  So should they use the generic unwind_recover_ret_addr()
> > instead of unwind_recover_kretprobe()?  
> 
> Yes, but I'm not sure this parameter can be applied.
> For example, it passed "state->sp - sizeof(unsigned long)" as where the
> return address stored address. Is that same on ftrace graph too?

Stack traces on the return side of function graph tracer has never
worked. It's on my todo list, because that's one of the requirements to
get right if we every manage to combine kretprobe and function graph
tracers together.

-- Steve
