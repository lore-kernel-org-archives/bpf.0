Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E178C433F5
	for <bpf@archiver.kernel.org>; Sat,  7 May 2022 13:53:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385351AbiEGN47 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Sat, 7 May 2022 09:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385316AbiEGN46 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 7 May 2022 09:56:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C1F847047;
        Sat,  7 May 2022 06:53:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3F8FBB808D5;
        Sat,  7 May 2022 13:53:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7928AC385A9;
        Sat,  7 May 2022 13:53:07 +0000 (UTC)
Date:   Sat, 7 May 2022 09:53:04 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>, x86@kernel.org
Subject: Re: : [PATCH] ftrace/x86: Add FTRACE_MCOUNT_MAX_OFFSET to avoid
 adding weak functions
Message-ID: <20220507095304.0688200b@rorschach.local.home>
In-Reply-To: <YnV5NQ6lMwFY05nf@hirez.programming.kicks-ass.net>
References: <20220503150410.2d9e88aa@rorschach.local.home>
        <YnV5NQ6lMwFY05nf@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 6 May 2022 21:38:29 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> You forgot about IBT again? __fentry__ no longer lives at +0 on x86
> anymore.

I didn't forget. It was that the kernel I wrote this for didn't have it ;-)

I wasn't sure if it was accepted into mainline yet.

-- Steve
