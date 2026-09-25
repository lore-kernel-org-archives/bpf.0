Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0211943BDCF;
	Fri, 25 Sep 2026 23:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790378608; cv=none; b=tfQSlhVPIHE6LTm1F5b3GYpl4kPyZSj/QGC7fFzk6xtAqOoEhf8XeZCdcHyWDFJTpaBaLYh8SbgxTtiu1ErChy6XwT0smNjoA4emPimvMB6mU/nnTV3kL9L2GucDuFcmrSaN0lHp8qKaXSa3bbztW/Agc6oSISgzbLgB1IrwjBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790378608; c=relaxed/simple;
	bh=kJTBGXn2n9s4+UU2B+dVVbXHfyqDDh8sTBkcF8KCZHM=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=q6UJ4BWT9Y6RNYBjW2jJQqLGvaZBQ0Ck5jKuMLFn5u3swzwdt592vJBpDhqeHkF7GIg8xvBm+ReY9cVXrzMuF1X5OTGkbJ50Xr8qyOfBR5G+yQmKk5Lgb4sEGFMwWSouf2Wpls17ezqBbPzMMUypXeujOYEX8aOf/d6hCrh/wqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a5Mjr2sw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a5Mjr2sw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 443221F000FF;
	Fri, 25 Sep 2026 23:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790378606;
	bh=uV8cuBJOC+LcX62tWc3kCcI/UQQR3hOIpfwdkUPiceE=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=a5Mjr2swo65sPP309YrObWfp9L8nDJ7T9zcmBnkxqdysDEQ8EUu6WZ3N1e04zWoN4
	 NR0va9j5bMHBeDFMKU8e2SjAA9MN0re2+fqzieyfjZTuO5m3l+4H2FSuPR+Gqa51oh
	 IYEUzoRezw/LdUKn3hZ4hwiJ7FUrYS1BD8FPoe5eeFHV2DeIJs489joVfWAnGDwArh
	 /h0vr0ClwLKA0ebgnA/fS76Z5RkILFcROijswiOLSa8NSOmnX7n+lEBcOMmJZIboFj
	 Zg514AGYDvE8eHxIh6kYhVRD2ncrtKyf8Q9Y6heQA/pXxXWVMqgbJpytF0lIlHW18l
	 m31YO450SDoAg==
Content-Type: multipart/mixed; boundary="===============5203265522271237676=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <973216fc6e2c9c225b847f0f82941b5e1e2d49944c2b16ff5cbcdcdf2910e8d6@mail.kernel.org>
In-Reply-To: <20260925224229.1850-9-wanjay@amazon.com>
References: <20260925224229.1850-9-wanjay@amazon.com>
Subject: Re: [PATCH bpf-next v3 8/9] bpf, trace, net: prepare CONFIG_DEBUG_INFO_BTF checks for a tristate
From: bot+bpf-ci@kernel.org
To: wanjay@amazon.com,bpf@vger.kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com
Cc: alan.maguire@oracle.com,martin.lau@linux.dev,yonghong.song@linux.dev,jolsa@kernel.org,nathan@kernel.org,nsc@kernel.org,linux-kbuild@vger.kernel.org,mcgrof@kernel.org,petr.pavlu@suse.com,samitolvanen@google.com,linux-modules@vger.kernel.org,ojeda@kernel.org,rust-for-linux@vger.kernel.org,arnd@arndb.de,linux-kernel@vger.kernel.org,abuehaze@amazon.com,doebel@amazon.de,mpohlack@amazon.de,jay.wang.upstream@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri, 25 Sep 2026 23:23:25 +0000 (UTC)

--===============5203265522271237676==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/Makefile b/Makefile
> index 751a08643bf8..f561516e1735 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1208,7 +1208,8 @@ endif
>  # include additional Makefiles when needed
>  include-y			:= scripts/Makefile.warn
>  include-$(CONFIG_DEBUG_INFO)	+= scripts/Makefile.debug
> -include-$(CONFIG_DEBUG_INFO_BTF)+= scripts/Makefile.btf
> +# CONFIG_DEBUG_INFO_BTF is a tristate; BTF is generated for both y and m
> +include-$(subst m,y,$(CONFIG_DEBUG_INFO_BTF)) += scripts/Makefile.btf
>  include-$(CONFIG_KASAN)		+= scripts/Makefile.kasan
>  include-$(CONFIG_KCSAN)		+= scripts/Makefile.kcsan
>  include-$(CONFIG_KMSAN)		+= scripts/Makefile.kmsan

[ ... ]

> diff --git a/include/trace/trace_events.h b/include/trace/trace_events.h
> index 93011f800d0f..2a0098929771 100644
> --- a/include/trace/trace_events.h
> +++ b/include/trace/trace_events.h
> @@ -398,7 +398,7 @@ static inline notrace int trace_event_get_offsets_##call(		\
>  #define _TRACE_PERF_INIT(call)
>  #endif /* CONFIG_PERF_EVENTS */
>
> -#if defined(CONFIG_BPF_EVENTS) && defined(CONFIG_DEBUG_INFO_BTF)
> +#if defined(CONFIG_BPF_EVENTS) && IS_ENABLED(CONFIG_DEBUG_INFO_BTF)

Can this change introduce a deadlock when DEBUG_INFO_BTF=m and the
btf_vmlinux module is not yet loaded?

Before this change, with =m the preprocessor guard was false, so
_TRACE_BTF_IDS_INIT() expanded to nothing and trace_event_class.btf_ids
stayed NULL. With IS_ENABLED() the guard is now true for both =y and =m,
so built-in tracepoint classes initialize .btf_ids and create
events/<sys>/<event>/btf_ids tracefs files.

Reading that file for a built-in event goes through event_btf_ids_read()
in kernel/trace/trace_events.c:

    scoped_guard(mutex, &event_mutex) {
        ...
        ids = call->class->btf_ids;
        ...
        btf = btf_get_module_btf(mod);   /* mod == NULL for built-in */

btf_get_module_btf(NULL) calls bpf_get_btf_vmlinux(), which in the
IS_MODULE(CONFIG_DEBUG_INFO_BTF) case calls request_module("btf_vmlinux")
when the vmlinux BTF has not been loaded yet.

request_module() waits for modprobe to exit (UMH_WAIT_PROC) while
event_mutex is still held. Meanwhile, modprobe does finit_module() ->
load_module() -> prepare_coming_module(), which calls
trace_module_notify():

    mutex_lock(&event_mutex);
    mutex_lock(&trace_types_lock);

so the btf_vmlinux module load blocks on event_mutex held by the reader,
and the reader blocks waiting for modprobe.

The reader hangs until SIGKILLed, and every other module load and
event_mutex user (enabling/disabling events, kprobe/uprobe creation, etc.)
is stuck. Trigger: with DEBUG_INFO_BTF=m and btf_vmlinux not yet loaded,
`cat /sys/kernel/tracing/events/sched/sched_switch/btf_ids` (or any
syscall event's btf_ids).

Should the BTF be resolved before taking event_mutex, or should this path
return -ENOENT when the vmlinux BTF is not yet present?

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/36198628965
--===============5203265522271237676==--
