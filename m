Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A075C433F5
	for <bpf@archiver.kernel.org>; Thu, 26 May 2022 14:44:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245366AbiEZOol (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 26 May 2022 10:44:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344542AbiEZOok (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 26 May 2022 10:44:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FDB0D8088;
        Thu, 26 May 2022 07:44:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0124CB820F7;
        Thu, 26 May 2022 14:44:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0B02C34114;
        Thu, 26 May 2022 14:44:31 +0000 (UTC)
Date:   Thu, 26 May 2022 10:44:30 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>,
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
        KP Singh <kpsingh@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org
Subject: Re: [PATCH v3] ftrace: Add FTRACE_MCOUNT_MAX_OFFSET to avoid adding
 weak functions
Message-ID: <20220526104430.7e6456a2@gandalf.local.home>
In-Reply-To: <20220526103810.026560dd@gandalf.local.home>
References: <20220526103810.026560dd@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 26 May 2022 10:38:10 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> +++ b/arch/x86/include/asm/ftrace.h
> @@ -9,6 +9,11 @@
>  # define MCOUNT_ADDR		((unsigned long)(__fentry__))
>  #define MCOUNT_INSN_SIZE	5 /* sizeof mcount call */
>  
> +/* Ignore unused weak functions which will have non zero offsets */
> +#ifdef CONFIG_HAVE_FENTRY
> +# define FTRACE_MCOUNT_MAX_OFFSET	0
> +#endif
> +

I screwed up this patch. Please ignore.

And Peter just informed me that IBT is in 5.18 already, and not 5.19. So,
I'll add his suggestion in v4.

-- Steve
