Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B204C00140
	for <bpf@archiver.kernel.org>; Tue,  2 Aug 2022 14:52:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233655AbiHBOwh convert rfc822-to-8bit (ORCPT
        <rfc822;bpf@archiver.kernel.org>); Tue, 2 Aug 2022 10:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231368AbiHBOwg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 Aug 2022 10:52:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DBF31EED3;
        Tue,  2 Aug 2022 07:52:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 26C3CB81F28;
        Tue,  2 Aug 2022 14:52:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A7B7C433D6;
        Tue,  2 Aug 2022 14:52:31 +0000 (UTC)
Date:   Tue, 2 Aug 2022 10:52:30 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>, linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Daniel =?UTF-8?B?TcO8bGxlcg==?= <deso@posteo.net>
Subject: Re: [PATCH] x86/kprobes: Fix to update kcb status flag after
 singlestepping
Message-ID: <20220802105230.43bb6079@gandalf.local.home>
In-Reply-To: <165942025658.342061.12452378391879093249.stgit@devnote2>
References: <165942025658.342061.12452378391879093249.stgit@devnote2>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue,  2 Aug 2022 15:04:16 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Fix kprobes to update kcb (kprobes control block) status flag to
> KPROBE_HIT_SSDONE even if the kp->post_handler is not set.
> This may cause a kernel panic if another int3 user runs right
> after kprobes because kprobe_int3_handler() misunderstands the
> int3 is kprobe's single stepping int3.
> 
> Fixes: 6256e668b7af ("x86/kprobes: Use int3 instead of debug trap for single-step")
> Reported-by: Daniel Müller <deso@posteo.net>
> Tested-by: Daniel Müller <deso@posteo.net>
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/all/20220727210136.jjgc3lpqeq42yr3m@muellerd-fedora-PC2BDTX9
> ---

Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

I guess this will go through the tip tree?

-- Steve
