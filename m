Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B24FC433EF
	for <bpf@archiver.kernel.org>; Wed, 15 Sep 2021 21:47:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C06C61131
	for <bpf@archiver.kernel.org>; Wed, 15 Sep 2021 21:47:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232273AbhIOVsk (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 15 Sep 2021 17:48:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:51196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232427AbhIOVsj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Sep 2021 17:48:39 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C0C3D60EE4;
        Wed, 15 Sep 2021 21:47:19 +0000 (UTC)
Date:   Wed, 15 Sep 2021 17:47:18 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>
Subject: Re: [PATCH 7/8] ftrace: Add multi direct modify interface
Message-ID: <20210915174718.77acaf8b@gandalf.local.home>
In-Reply-To: <20210914174134.1d8fd944@oasis.local.home>
References: <20210831095017.412311-1-jolsa@kernel.org>
        <20210831095017.412311-8-jolsa@kernel.org>
        <20210914174134.1d8fd944@oasis.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 14 Sep 2021 17:41:34 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> A better solution, that prevents having to do this, is to first change
> the function fentry's to call the ftrace list loop function, that calls
> the ftrace_ops list, and will call the direct call via the ops in the
> loop. Have the ops->func call the new direct function (all will be
> immediately affected). Update the entries, and then switch from the
> loop back to the direct caller.

An easy way to force the loop function to be called instead of the direct
trampoline, is to register a stub ftrace_ops to each of the functions that
the direct function attaches to. You can even share the hash in doing so.

Having the ftrace_ops attached in the same locations as the direct
trampoline, will force the loop function to be called (to call the stub
ftrace_ops as well as the direct trampoline ftrace_ops helper).

Then change the direct trampoline address, which will have the ftrace_ops
helper use that direct trampoline immediately*. Then when you remove the
ftrace_ops stub, it will update all the call sites to call the new direct
trampoline directly.

(*) not quite immediately, as there's no read memory barrier with the
direct helper, so it may still be calling the old trampoline. But this
shouldn't be an issue. If it is, then you would need to include some memory
barrier synchronization.

I'm curious to what the use case is for the multi direct modify interface
is?

-- Steve
