Return-Path: <SRS0=rM0N=7W=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8653AC433E0
	for <bpf@archiver.kernel.org>; Tue,  9 Jun 2020 07:12:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D967207F9
	for <bpf@archiver.kernel.org>; Tue,  9 Jun 2020 07:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591686762;
	bh=Zoe/5AXhdJcm13q+lPAQH677WgRV+Gd44TJnwDEoY1I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=QTPwEg3efqbjn3imCZXvdUvkFwUj0QiE34i4lROfEHExJG/lZU+209fhmZr3485w9
	 TId9YO9ZRpGW6iH+zUKggXofmGnid5JyupTSTydBgBUwsqbK6TC6UEJe/+OfIm40R+
	 Z3zLLNTwVPn9kNiwHNymhHygdxEHma7SzTyjhMV8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726116AbgFIHMl (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 9 Jun 2020 03:12:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:34934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726099AbgFIHMk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Jun 2020 03:12:40 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 968E2207C3;
        Tue,  9 Jun 2020 07:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591686759;
        bh=Zoe/5AXhdJcm13q+lPAQH677WgRV+Gd44TJnwDEoY1I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VyTsQ+PU0OR2ZxRMKgar1E33sFQ+EPibbwHx2C8YiTQBrYxctPKKg6frtUC2ZRZAK
         trl4gs9x0QbQPFF5dKzqRv2g3k77gZr06jFqK2pb+sRp4+jggKPkUSoHCN+nfOjqB3
         uBPoctnKMHTG+TAr1IxxSCZ32fo2GrJeG1jRFF6o=
Date:   Tue, 9 Jun 2020 16:12:34 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        mhiramat@kernel.org, rostedt@goodmis.org, mingo@redhat.com,
        ast@kernel.org, daniel@iogearbox.net, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, andriin@fb.com,
        john.fastabend@gmail.com, kpsingh@chromium.org
Subject: Re: [PATCH] tracing/probe: Fix bpf_task_fd_query() for kprobes and
 uprobes
Message-Id: <20200609161234.c0b1460e6a6ce73ba478a22a@kernel.org>
In-Reply-To: <20200608124531.819838-1-jean-philippe@linaro.org>
References: <20200608124531.819838-1-jean-philippe@linaro.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon,  8 Jun 2020 14:45:32 +0200
Jean-Philippe Brucker <jean-philippe@linaro.org> wrote:

> Commit 60d53e2c3b75 ("tracing/probe: Split trace_event related data from
> trace_probe") removed the trace_[ku]probe structure from the
> trace_event_call->data pointer. As bpf_get_[ku]probe_info() were
> forgotten in that change, fix them now. These functions are currently
> only used by the bpf_task_fd_query() syscall handler to collect
> information about a perf event.
> 

Oops, good catch!

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>


> Fixes: 60d53e2c3b75 ("tracing/probe: Split trace_event related data from trace_probe")
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

Cc: stable@vger.kernel.org


Thank you!

> ---
> Found while trying to run the task_fd_query BPF sample. I intend to try
> and move that sample to kselftests since it seems like a useful
> regression test.
> ---
>  kernel/trace/trace_kprobe.c | 2 +-
>  kernel/trace/trace_uprobe.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> index 35989383ae113..8eeb95e04bf52 100644
> --- a/kernel/trace/trace_kprobe.c
> +++ b/kernel/trace/trace_kprobe.c
> @@ -1629,7 +1629,7 @@ int bpf_get_kprobe_info(const struct perf_event *event, u32 *fd_type,
>  	if (perf_type_tracepoint)
>  		tk = find_trace_kprobe(pevent, group);
>  	else
> -		tk = event->tp_event->data;
> +		tk = trace_kprobe_primary_from_call(event->tp_event);
>  	if (!tk)
>  		return -EINVAL;
>  
> diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
> index 2a8e8e9c1c754..fdd47f99b18fd 100644
> --- a/kernel/trace/trace_uprobe.c
> +++ b/kernel/trace/trace_uprobe.c
> @@ -1412,7 +1412,7 @@ int bpf_get_uprobe_info(const struct perf_event *event, u32 *fd_type,
>  	if (perf_type_tracepoint)
>  		tu = find_probe_event(pevent, group);
>  	else
> -		tu = event->tp_event->data;
> +		tu = trace_uprobe_primary_from_call(event->tp_event);
>  	if (!tu)
>  		return -EINVAL;
>  
> -- 
> 2.27.0
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
