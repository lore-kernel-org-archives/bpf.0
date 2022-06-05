Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD74EC43334
	for <bpf@archiver.kernel.org>; Sun,  5 Jun 2022 16:55:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346226AbiFEQzs (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Sun, 5 Jun 2022 12:55:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232839AbiFEQzr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 5 Jun 2022 12:55:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B50EE2FE7D;
        Sun,  5 Jun 2022 09:55:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2CC52B80DB2;
        Sun,  5 Jun 2022 16:55:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF6B6C385A5;
        Sun,  5 Jun 2022 16:55:41 +0000 (UTC)
Date:   Sun, 5 Jun 2022 12:55:40 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH bpf-next 2/3] ftrace: Keep address offset in
 ftrace_lookup_symbols
Message-ID: <20220605125540.1519a522@rorschach.local.home>
In-Reply-To: <58130008-a5e4-50e2-0706-e5edb4bfb5a8@iogearbox.net>
References: <20220527205611.655282-1-jolsa@kernel.org>
        <20220527205611.655282-3-jolsa@kernel.org>
        <58130008-a5e4-50e2-0706-e5edb4bfb5a8@iogearbox.net>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 30 May 2022 22:20:12 +0200
Daniel Borkmann <daniel@iogearbox.net> wrote:

> On 5/27/22 10:56 PM, Jiri Olsa wrote:
> > We want to store the resolved address on the same index as
> > the symbol string, because that's the user (bpf kprobe link)
> > code assumption.
> > 
> > Also making sure we don't store duplicates that might be
> > present in kallsyms.
> > 
> > Fixes: bed0d9a50dac ("ftrace: Add ftrace_lookup_symbols function")
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >   kernel/trace/ftrace.c | 13 +++++++++++--
> >   1 file changed, 11 insertions(+), 2 deletions(-)  
> 
> Steven / Masami, would be great to get an Ack from one of you before applying.

I just don't care for the unnecessary "0x" in the memset, but other than that:

Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve
