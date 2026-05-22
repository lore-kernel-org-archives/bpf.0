Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEDE23630AD;
	Fri, 22 May 2026 14:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779460622; cv=none; b=OG5GmD/63BI4WzpISXFWN9R+/F/diX6G/J1N3+iCdH71foo5ijWu42I4NcLLcrb/LUSuuK2e2t4U1EzQXmyDJzhscCqCtipefxP6Dlrgzs+Y6wgE+WEIPLg5ZI7GMID84TsZmzNJUVIYYXHyAsdPf7QvcaR8sz1s9ynzqo8kLk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779460622; c=relaxed/simple;
	bh=FXCPyGLE1CeqNu190mNEcpSSRAcm9KEMFVeAYQWV9hU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sDgdbxYmXeA6RThsRZ0aY/hs5uwueSdSCNQZFufPMoKmjF98ygAwXZU1VZoBm67avDxnyO/dSFzTIJ/H6nUWfs3lsRACRu+e7jdkhBd06SZnoqNdbfimWb9CLzY8l+aDRkC8q0yzDcKKKe1/EQr2H32w7mWF3/gSwhHNiPVsa74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=t-8ch.de; spf=pass smtp.mailfrom=t-8ch.de; dkim=pass (1024-bit key) header.d=t-8ch.de header.i=@t-8ch.de header.b=DC/A+e67; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=t-8ch.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-8ch.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=t-8ch.de header.i=@t-8ch.de header.b="DC/A+e67"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
	t=1779460616; bh=FXCPyGLE1CeqNu190mNEcpSSRAcm9KEMFVeAYQWV9hU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DC/A+e67LHSQkJkagoTuL5Xa/HLBYp4Qm0GxjJMsE6LV1B539/rSSnrCbpMR7QJD0
	 Dw2R8XToKMPWRRvNdrVJj/EZGPZZu9gC9zINu198J9hb7uRv9G+fkp7uQKOYmkYNvR
	 VXtqd+vK68wKbA1wt+rTlGXy+b2hDlMGD0Dw60/k=
Date: Fri, 22 May 2026 16:36:56 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To: Steven Rostedt <rostedt@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>, bpf@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Jens Remus <jremus@linux.ibm.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Andrii Nakryiko <andrii@kernel.org>, 
	Indu Bhagat <indu.bhagat@oracle.com>, "Jose E. Marchesi" <jemarch@gnu.org>, 
	Beau Belgrave <beaub@linux.microsoft.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Florian Weimer <fweimer@redhat.com>, Kees Cook <kees@kernel.org>, 
	Carlos O'Donell <codonell@redhat.com>, Sam James <sam@gentoo.org>, Dylan Hatch <dylanbhatch@google.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	David Hildenbrand <david@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH] unwind: Add sframe_(un)register() system calls
Message-ID: <7923f815-a8ce-4b64-8cbf-2b90e57cbd24@t-8ch.de>
References: <20260521183532.7a145c8a@gandalf.local.home>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260521183532.7a145c8a@gandalf.local.home>

On 2026-05-21 18:35:32-0400, Steven Rostedt wrote:
> From: Steven Rostedt <rostedt@goodmis.org>
> 
> Add system calls to register and unregister sframes that can be used by
> dynamic linkers to tell the kernel where the sframe section is in memory
> for libraries it loads.

How is this system call related to the prctl() with the same
functionality from Jens' series? I guess it will replace it,
but some explanation would be nice.

(...)

> diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
> index f5639d5ac331..992ccc401c5e 100644
> --- a/include/linux/syscalls.h
> +++ b/include/linux/syscalls.h
> @@ -999,6 +999,8 @@ asmlinkage long sys_lsm_get_self_attr(unsigned int attr, struct lsm_ctx __user *
>  asmlinkage long sys_lsm_set_self_attr(unsigned int attr, struct lsm_ctx __user *ctx,
>  				      u32 size, u32 flags);
>  asmlinkage long sys_lsm_list_modules(u64 __user *ids, u32 __user *size, u32 flags);
> +asmlinkage long sys_sframe_register(void *data, unsigned int size);
> +asmlinkage long sys_sframe_unregister(void *data, unsigned int size);

Why not use the actual structure here?

>  /*
>   * Architecture-specific system calls

(...)

> diff --git a/include/uapi/linux/sframe.h b/include/uapi/linux/sframe.h
> new file mode 100644
> index 000000000000..137a2ebf91f4
> --- /dev/null
> +++ b/include/uapi/linux/sframe.h
> @@ -0,0 +1,12 @@
> +/* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
> +#ifndef _UAPI_LINUX_SFRAME_H
> +#define _UAPI_LINUX_SFRAME_H
> +
> +struct sframe_setup {
> +	unsigned long		sframe_start;
> +	unsigned long		sframe_size;
> +	unsigned long		text_start;
> +	unsigned long		text_size;
> +};

This will break for compat processes, as they use a different 'unsigned
long' than the host kernel. Maybe just use __u64.

> +
> +#endif /* _UAPI_LINUX_SFRAME_H */

(...)

> +/**
> + * sys_sframe_register - register an address for user space stacktrace walking.
> + * @data: Structure of sframe data used to register the sframe section
> + * @size: The size of the given structure.
> + *
> + * This system call is used by dynamic library utilities to inform the kernel
> + * of meta data that it loaded that can be used by the kernel to know how
> + * to stack walk the given text locations.
> + *
> + * Return: 0 if successful, otherwise a negative error.
> + */
> +SYSCALL_DEFINE2(sframe_register, __user struct sframe_setup *, data, unsigned int, size)

AFAIK the normal place for the '__user' is right before '*':

	struct sframe_setup __user *, data,

Use __kernel_size_t for 'size'?

> +{
> +	struct sframe_setup sframe;

(...)
