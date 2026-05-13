Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84B64014AE;
	Wed, 13 May 2026 14:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778683351; cv=none; b=Qs/pCi/RgTt9mIl3yVyVvVwQ/kE+W/E/7qvIIJG7R5s1AqK0QF6ALbKdcr1RstVx4jQDRyA9pzUhM69llEj3utBPCfuaI0cg5VX6hMidlb8QuIbMnf2tAxOZ5+t5Nph+ydKDYNtbO/xCb8sgPTpBtXhg0tzoL6VNKoDFN6kpuqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778683351; c=relaxed/simple;
	bh=oXeuqrZEkA/fNl9k+GX1v5NLeF6Hi57IW0JIYsar1PE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D/Klk15wPL5HuouZHeKrWwKlqS1VjOKsNm4HNsbt3yQjHBDOIhbRu4Yer92M3QzK/nQMVBAhK3EoFPWfkZZp55QOEyd1FNzvAF1FVMJ/T0kKclqnbVzgrJVWC6SVs2mzmdCIvgYo1CUuIILtQHIJ9XSygH+VMspOfAhXgfUmiIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf09.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id 4CBAF1C01FE;
	Wed, 13 May 2026 14:42:28 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf09.hostedemail.com (Postfix) with ESMTPA id 5F4EB2002E;
	Wed, 13 May 2026 14:42:26 +0000 (UTC)
Date: Wed, 13 May 2026 10:42:29 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Donglin Peng <dolinux.peng@gmail.com>
Cc: mhiramat@kernel.org, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org, pengdonglin
 <pengdonglin@xiaomi.com>, Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
Subject: Re: [PATCH v4 1/3] ftrace: Build trace_btf.c when
 CONFIG_DEBUG_INFO_BTF is enabled
Message-ID: <20260513104229.2f39eb03@gandalf.local.home>
In-Reply-To: <20251215034153.2367756-2-dolinux.peng@gmail.com>
References: <20251215034153.2367756-1-dolinux.peng@gmail.com>
 <20251215034153.2367756-2-dolinux.peng@gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 5F4EB2002E
X-Rspamd-Server: rspamout06
X-Stat-Signature: yfww5w3g1qfie6zda5a5fitmsy7rdjzr
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18EzArn/luMmjPOD5iKxt3M1haSl69msq8=
X-HE-Tag: 1778683346-215066
X-HE-Meta: U2FsdGVkX19ZCnSar7H3ctwpOeR5RbZWxUH5n+U7kAGnrEQG8WuEjBgwVlJ9NWlRN6MRgYIymaNYOeKzt81Rttl42bMqDAJRL8/DNdJmt+DibR6i3sRuuY8uvBrVaJjq/WyqrMYbbA+xbNbp9Wh5uoYGeI8UlyQokUsyvCOA2Nj7o8rtwnxQPOfAqSPLNEPvAeYBBVqoLffgw9YyLjLczS0n33d1gwkrVXKijMHBCI2uOfMyUFdgrnupzvMcg5WY9rgvCpV9rr2rjgcOhIpzDbpxs5lcuUDXu/d0eTF1pq90XQkIPIq6n4H5YwzFKGj8WGdOpVNpLbzzmmBwbf3zinuKEyp99nlSIlV/yiNzbwAQnvJqEEF0FfNPUCfzF7Hei7SkFj1BOE28Xc6+X0RPQbBTeIpI2HRY+U51Rou5RjLbLBT5/oBrrR2aQxd13XoibPgOBVYLh7k=


Sorry for the late reply, I've been a bit busy on other things recently.

On Mon, 15 Dec 2025 11:41:51 +0800
Donglin Peng <dolinux.peng@gmail.com> wrote:

> From: pengdonglin <pengdonglin@xiaomi.com>
> 
> The trace_btf.c file provides BTF helper functions used by the ftrace
> subsystem. This change makes its compilation solely dependent on

Nit, change logs should never say "This change". Instead it should be
worded as:

  "Make the compilation of trace_btf.c soley depend on..."

-- Steve

> CONFIG_DEBUG_INFO_BTF, allowing features like funcgraph-retval to also
> utilize these helpers.
> 
> Additionally, the redundant dependency on CONFIG_PROBE_EVENTS_BTF_ARGS
> is removed, as CONFIG_DEBUG_INFO_BTF already depends on
> CONFIG_BPF_SYSCALL.
> 
> Cc: Steven Rostedt (Google) <rostedt@goodmis.org>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
> Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
> ---
>  kernel/trace/Kconfig  | 2 +-
>  kernel/trace/Makefile | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
> index e1214b9dc990..653c1fcefa4c 100644
> --- a/kernel/trace/Kconfig
> +++ b/kernel/trace/Kconfig
> @@ -755,7 +755,7 @@ config FPROBE_EVENTS
>  config PROBE_EVENTS_BTF_ARGS
>  	depends on HAVE_FUNCTION_ARG_ACCESS_API
>  	depends on FPROBE_EVENTS || KPROBE_EVENTS
> -	depends on DEBUG_INFO_BTF && BPF_SYSCALL
> +	depends on DEBUG_INFO_BTF
>  	bool "Support BTF function arguments for probe events"
>  	default y
>  	help
> diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
> index fc5dcc888e13..6c4bf5a6c4f3 100644
> --- a/kernel/trace/Makefile
> +++ b/kernel/trace/Makefile
> @@ -116,7 +116,7 @@ obj-$(CONFIG_KGDB_KDB) += trace_kdb.o
>  endif
>  obj-$(CONFIG_DYNAMIC_EVENTS) += trace_dynevent.o
>  obj-$(CONFIG_PROBE_EVENTS) += trace_probe.o
> -obj-$(CONFIG_PROBE_EVENTS_BTF_ARGS) += trace_btf.o
> +obj-$(CONFIG_DEBUG_INFO_BTF) += trace_btf.o
>  obj-$(CONFIG_UPROBE_EVENTS) += trace_uprobe.o
>  obj-$(CONFIG_BOOTTIME_TRACING) += trace_boot.o
>  obj-$(CONFIG_FTRACE_RECORD_RECURSION) += trace_recursion_record.o

