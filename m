Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A3F1EEE6;
	Fri, 20 Mar 2026 13:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774012889; cv=none; b=Skz+x/3DS2iMq7Y1CALrniP7CjqNIUTl3hCbjk0drprgdGxkMpwciKMf9YZspN7L0CrfHb9l5kchJvk0wzTojzu/XQmBNAI3NSf9LIEPme2Rtai+bYN0FeMzTSX/evv+hMhTAEMEv91lEyaV+jFdb57QBsFBDjjDA6m6Fq2vjRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774012889; c=relaxed/simple;
	bh=qFsuBH7hc/SQe2it9kyWh9hw7Uw23MFvw6yA0QnTAck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q7CHJ3+XI72g3Kafc/94Jv/TEzSQhAUj9qNRjYUbQQBJ5tbLj466WqQfKhUp/v7h/HAkzNJNxjM/rz0gnYWqxYfnaAvJMlD1HlD0gngcLE9MhRCesIn2nulBd2+8cBI9IPdkWl+tYUywmqTZdyjt26o43lB1EYdlxsTkiHEZGxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u2e17s8e; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u2e17s8e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1DBDC4CEF7;
	Fri, 20 Mar 2026 13:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774012888;
	bh=qFsuBH7hc/SQe2it9kyWh9hw7Uw23MFvw6yA0QnTAck=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u2e17s8eLuMYF68mIZ5XjW040CwH0L2d05rjIwLkg2t0iydE6udpU8RfCYQG69alj
	 iCbVlZiK9C9BNZoxYW1/M2v4RETLOnknNhlFgZZMA4dmaG9s0lMfY8TgjcQGW6M/fb
	 wlCVUnYomCHeyUvxhdgUomKGdTBJughQZog2e0XD07/3KrW+gOZ4mP2PF0ptg/KT9l
	 99jGSYtpaFqecdlBBkrqiaOWN9dZb0G4oASTbVM4U0DUUUVyL3hlupiOSH/vU116y0
	 MKepGk69yRXHtwJxa40w7V41vZOvlUrAJU8mcJKUPxFXN46k1txjd9FfID60K0pH4U
	 BbRpSsv3LvqkQ==
Date: Fri, 20 Mar 2026 14:21:23 +0100
From: Christian Brauner <brauner@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, kernel-team@meta.com, 
	Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH] coredump: add tracepoint for coredump events
Message-ID: <20260320-erlitt-ergibt-255e86a66414@brauner>
References: <20260320-coredump_tracepoint-v1-1-34864746cbb3@debian.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260320-coredump_tracepoint-v1-1-34864746cbb3@debian.org>

On Fri, Mar 20, 2026 at 05:33:34AM -0700, Breno Leitao wrote:
> Coredump is a generally useful and interesting event in the lifetime
> of a process. Add a tracepoint so it can be monitored through the
> standard kernel tracing infrastructure.
> 
> BPF-based crash monitoring is an advanced approach that
> allows real-time crash interception: by attaching a BPF program at
> this point, tools can use bpf_get_stack() with BPF_F_USER_STACK to
> capture the user-space stack trace at the exact moment of the crash,
> before the process is fully terminated, without waiting for a
> coredump file to be written and parsed.
> 
> However, there is currently no stable kernel API for this use case.
> Existing tools rely on attaching fentry probes to do_coredump(),
> which is an internal function whose signature changes across kernel
> versions, breaking these tools.
> 
> Add a stable tracepoint that fires at the beginning of
> do_coredump(), providing BPF programs a reliable attachment point.
> At tracepoint time, the crashing process context is still live, so
> BPF programs can call bpf_get_stack() with BPF_F_USER_STACK to
> extract the user-space backtrace.
> 
> The tracepoint records:
>   - sig: signal number that triggered the coredump
>   - comm: process name
>   - pid: process PID
> 
> Example output:
> 
>   $ echo 1 > /sys/kernel/tracing/events/coredump/coredump/enable
>   $ sleep 999 &
>   $ kill -SEGV $!
>   $ cat /sys/kernel/tracing/trace
>   #           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
>   #              | |         |   |||||     |         |
>              sleep-634     [036] .....   145.222206: coredump: sig=11 comm=sleep pid=634
> 
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  fs/coredump.c                   |  5 +++++
>  include/trace/events/coredump.h | 47 +++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 52 insertions(+)
> 
> diff --git a/fs/coredump.c b/fs/coredump.c
> index 29df8aa19e2e7..bb6fdb1f458e9 100644
> --- a/fs/coredump.c
> +++ b/fs/coredump.c
> @@ -63,6 +63,9 @@
>  
>  #include <trace/events/sched.h>
>  
> +#define CREATE_TRACE_POINTS
> +#include <trace/events/coredump.h>
> +
>  static bool dump_vma_snapshot(struct coredump_params *cprm);
>  static void free_vma_snapshot(struct coredump_params *cprm);
>  
> @@ -1090,6 +1093,8 @@ static inline bool coredump_skip(const struct coredump_params *cprm,
>  static void do_coredump(struct core_name *cn, struct coredump_params *cprm,
>  			size_t **argv, int *argc, const struct linux_binfmt *binfmt)
>  {
> +	trace_coredump(cprm->siginfo->si_signo);
> +
>  	if (!coredump_parse(cn, cprm, argv, argc)) {
>  		coredump_report_failure("format_corename failed, aborting core");
>  		return;
> diff --git a/include/trace/events/coredump.h b/include/trace/events/coredump.h
> new file mode 100644
> index 0000000000000..59617eba3dbcf
> --- /dev/null
> +++ b/include/trace/events/coredump.h
> @@ -0,0 +1,47 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2026 Meta Platforms, Inc. and affiliates.
> + * Copyright (c) 2026 Breno Leitao <leitao@debian.org>
> + */
> +#undef TRACE_SYSTEM
> +#define TRACE_SYSTEM coredump
> +
> +#if !defined(_TRACE_COREDUMP_H) || defined(TRACE_HEADER_MULTI_READ)
> +#define _TRACE_COREDUMP_H
> +
> +#include <linux/sched.h>
> +#include <linux/tracepoint.h>
> +
> +/**
> + * coredump - called when a coredump starts
> + * @sig: signal number that triggered the coredump
> + *
> + * This tracepoint fires at the beginning of a coredump attempt,
> + * providing a stable interface for monitoring coredump events.
> + */
> +TRACE_EVENT(coredump,
> +
> +	TP_PROTO(int sig),
> +
> +	TP_ARGS(sig),
> +
> +	TP_STRUCT__entry(
> +		__field(int, sig)
> +		__array(char, comm, TASK_COMM_LEN)
> +		__field(pid_t, pid)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->sig = sig;
> +		memcpy(__entry->comm, current->comm, TASK_COMM_LEN);
> +		__entry->pid = current->pid;

That's the TID as seen in the global pid namespace.
I assume this is what you want but worth noting.
