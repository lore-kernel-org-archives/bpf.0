Return-Path: <SRS0=joy4=5R=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8C9BC43331
	for <bpf@archiver.kernel.org>; Wed,  1 Apr 2020 14:21:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5AA12073B
	for <bpf@archiver.kernel.org>; Wed,  1 Apr 2020 14:21:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732852AbgDAOVR (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 1 Apr 2020 10:21:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:34964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732781AbgDAOVR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Apr 2020 10:21:17 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D1F020705;
        Wed,  1 Apr 2020 14:21:15 +0000 (UTC)
Date:   Wed, 1 Apr 2020 10:21:12 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     kernel test robot <rong.a.chen@intel.com>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Peter Wu <peter@lekensteyn.nl>,
        Jonathan Corbet <corbet@lwn.net>,
        Tom Zanussi <zanussi@kernel.org>,
        Shuah Khan <shuahkhan@gmail.com>, bpf <bpf@vger.kernel.org>,
        lkp@lists.01.org
Subject: Re: [tracing] cd8f62b481:
 BUG:sleeping_function_called_from_invalid_context_at_mm/slab.h
Message-ID: <20200401102112.35036490@gandalf.local.home>
In-Reply-To: <20200401230700.d9ddb42b3459dca98144b55c@kernel.org>
References: <20200319232731.799117803@goodmis.org>
        <20200326091256.GR11705@shao2-debian>
        <20200401230700.d9ddb42b3459dca98144b55c@kernel.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 1 Apr 2020 23:07:00 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Hi Steve,
> 
> On Thu, 26 Mar 2020 17:12:56 +0800
> kernel test robot <rong.a.chen@intel.com> wrote:
> 
> > FYI, we noticed the following commit (built with gcc-7):
> > 
> > commit: cd8f62b481530fafbeacee0d3283b60bcf42d854 ("[PATCH 02/12 v2] tracing: Save off entry when peeking at next entry")
> > url: https://github.com/0day-ci/linux/commits/Steven-Rostedt/ring-buffer-tracing-Remove-disabling-of-ring-buffer-while-reading-trace-file/20200320-073240
> >   
> 
> Hmm, this seems that we can not call kmalloc() in ftrace_dump().
> Maybe we can fix it by
> - Use GFP_ATOMIC.
>  or
> - Do not use iter->temp if it is NULL. (it is safe since ftrace_dump() stops tracing)
> 
> What would you think?
> 

Thanks for the reminder, I knew there was something that I had to deal with
and forgot to mark this report!

I already looked at it, and yes, this is an issue, but for PREEMPT_RT even
GFP_ATOMIC will fail. As it's not critical to record it, we can just check
for in atomic and not bother with the allocation.

-- Steve

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 6519b7afc499..7f1466253ca8 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -3487,6 +3487,14 @@ struct trace_entry *trace_find_next_entry(struct trace_iterator *iter,
 	 */
 	if (iter->ent && iter->ent != iter->temp) {
 		if (!iter->temp || iter->temp_size < iter->ent_size) {
+			/*
+			 * This function is only used to add markers between
+			 * events that are far apart (see trace_print_lat_context()),
+			 * but if this is called in an atomic context (like NMIs)
+			 * we can't call kmalloc(), thus just return NULL.
+			 */
+			if (in_atomic() || irqs_disabled())
+				return NULL;
 			kfree(iter->temp);
 			iter->temp = kmalloc(iter->ent_size, GFP_KERNEL);
 			if (!iter->temp)
