Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793046534;
	b=tIJ0ZbVQUXrrzEwABhepXQHO3Rzkue24NeGFAhcnJ1wlC4+nAzysCsTW8d9F7PzTcHSp
	 tl5VRmntb889ycLCGsu73JJ6ZDKlKsZnolW0Ui+mY4FhfsGNge70OGHuhYjirRknwwzGb
	 wbA6QXWMGo05YfDUTp325MacA7pZaMih3KXZfFYZf5SFRZf5fq/1awJLDwqkmjdIK4VPH
	 7w/7aJ4YlFKhk0mJEhT46WRWt42zYTihXCg1CUNcWEDyPKsPPYEfht0AkUpDDtr1t/QkI
	 chH/RuA1yJH6u7GWDNEk8sx75jyoLBSOUAnBHlV8+oy+Otob7xERcc99T1Ks2OLr/Ew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793046534;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Rspamd-Server:X-Rspamd-Queue-Id:
	 X-Stat-Signature:X-Spam-Status:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=JOR5bbIbiInINDDKl8udJD2n2rQt1cixikmX67XYQ94=;
	b=q4oQJW3inJkJywzlbMBBJ1WYUSbGhdm18EtP1Rqx8w8Y72IXNansu7VjjMJRg+/t85pg
	 0K39Yb5MDhyGKEz1ZSsyR5pir0ELpbqm6BnhbbMWIrh7WekgiBMj0NpEQBv3BYH+zgUfE
	 gxvWahL/F3tgraubpev3+VYIsuK5dc2TXDgJ/3Gl4KLpHmhekpBQ/8U5mGJgrleUK6UD1
	 YhQMmbFIweI+YnrZpi6nY/yrc1nDOPE36HBoU0xGAlNhM/CMdyitT5j0CHTK7oCilptmE
	 pe6GQUCSB4HMFA4mtI5BsbZaGd6BVuSuP2FtmwT+EPOVStENGsdDui2TF73s7Z5WEyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b="5G/pFS4k";
	arc=none smtp.remote-ip=216.40.44.14
Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5153C606A31A;
	Mon, 26 Oct 2026 20:28:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5153C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=5G/pFS4k
Received: from omf17.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id ECC7D140864;
	Mon, 26 Oct 2026 20:28:50 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf17.hostedemail.com (Postfix) with ESMTPA id 1955118;
	Mon, 26 Oct 2026 20:28:48 +0000 (UTC)
Date: Mon, 26 Oct 2026 16:28:46 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: BoxStrikesTeam <BoxStrikesTeam@proton.me>
Cc: "brauner@kernel.org" <brauner@kernel.org>, "kees@kernel.org"
 <kees@kernel.org>, "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
 "jack@suse.cz" <jack@suse.cz>, "mhiramat@kernel.org" <mhiramat@kernel.org>,
 "mathieu.desnoyers@efficios.com" <mathieu.desnoyers@efficios.com>,
 "jkoolstra@xs4all.nl" <jkoolstra@xs4all.nl>, "farid.m.zakaria@gmail.com"
 <farid.m.zakaria@gmail.com>, "linux-fsdevel@vger.kernel.org"
 <linux-fsdevel@vger.kernel.org>, "linux-trace-kernel@vger.kernel.org"
 <linux-trace-kernel@vger.kernel.org>, "linux-mm@kvack.org"
 <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [RFC PATCH] binfmt_misc: add binfmt_misc_select tracepoint
Message-ID: <20261026162846.23686159@gandalf.local.home>
In-Reply-To: <cmtfuzYFZMj7WozUoEjFs3RxYWe9UgdY5rK3ZGT7CPwO1mpemvEwNhG4v5ucoKBgUHMqFa7kSzOvLjFcVcxAybfmKdURZ4h-qoKX1lHXlAA=@proton.me>
References: <cmtfuzYFZMj7WozUoEjFs3RxYWe9UgdY5rK3ZGT7CPwO1mpemvEwNhG4v5ucoKBgUHMqFa7kSzOvLjFcVcxAybfmKdURZ4h-qoKX1lHXlAA=@proton.me>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 1955118
X-Stat-Signature: nk3fjntisjjnbaxtd3wt5bdqzs5m9dw7
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX193Yt8I2BKFgojrvTfdeQfvY6W/MQa/MvM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=JOR5bbIbiInINDDKl8udJD2n2rQt1cixikmX67XYQ94=; b=5G/pFS4kvRmY+FpqSfvYmgy1VmMMFvFIYFHxl+48nU9Q+OVL316//PslVP42qJzTQy+TJdC59hDbcVyb1GLW1YoUSJhkbm7wiSUUMR9Sjq9f8n1Pm5As6qgNjijzS9k+qBLc2+9PswJgFqS5pc0EMZ49z1Q22DHKMvSYB6pNQBk=
X-HE-Tag: 1793046528-319477
X-HE-Meta: U2FsdGVkX1/JMOcv1OjDojaLV+nCutKkXq36M/X9yG5D2u9mr6nzoEnPM7M+QucS41MT2z3fV9QQaSDEg85HXXiQNmFkcUj/ElBU/bA3Jkb7czxONW7s8b61PU1nZlCTSiML7BF9dwTqD2SZ7yx8ZbmmNRjnv7V3rmABebYT8ErViBrHGIsfMPR7RUNkjGK0k1fFKfcz+Gc+pGArKoXCTiN9yDmPU7zluTP3b7rRr7S1HiOvmwdEPIfrZ3QSWvtB7BOUc0RSnQl0LCaWjyeFkb7lgp/pxtVNMggzodPwzdzG2I/aFD2+mHADp3cLjs25m5aAwMwAAz5VYXAM7zgMk7TUC6+CmMfk


You shouldn't attach patches but inline them. Yeah, I know a lot of email
clients can't handle that. But claws-mail can! (and it can also reply to
attachments like they were inlined ;-) ).

I'll let others comment on whether or not this patch is needed, but I'll
comment on the tracing side of things.


On Mon, 26 Oct 2026 20:17:26 +0000
BoxStrikesTeam <BoxStrikesTeam@proton.me> wrote:

> From: Eneshan Erdo=C4=9Fan Karaca <BoxStrikesTeam@proton.me>
> Subject: [RFC PATCH] binfmt_misc: add binfmt_misc_select tracepoint
>=20
> A binfmt_misc entry can select an interpreter for an exec.  With a BPF
> 'B' handler, that selection can be made by a BPF struct_ops program.
> The kernel commits the decision in bprm->interp and bprm->flags, but it
> does not emit an event at the selection point.
>=20
> Existing observers have to reconstruct the decision from
> /proc/PID/exe, AT_EXECFD, AT_FLAGS, or /proc/PID/maps.  These sources
> are mode-dependent: a transparent dispatch still reports the original
> binary in /proc/PID/exe, and a short-lived process can exit before the
> observer reads it.  A classic dispatch reports the interpreter, but
> not which handler selected it or which invocation flags were used.
>=20
> Add a tracepoint after the interpreter and the invocation flags are
> selected.  It reports the binary filename, the selected interpreter,
> the handler name (for BPF handlers), the invocation flags, and the
> pid.  The flags are masked with MISC_FMT_INVOCATION_FLAGS so that
> static entry state does not leak into the event.
>=20
> The tracepoint is observability only; it does not change exec
> behavior.
>=20
> Assisted-by: LLM
> Signed-off-by: Eneshan Erdo=C4=9Fan Karaca <BoxStrikesTeam@proton.me>
> ---
>=20
> This is an RFC.  A small PoC and short A/B results are available for
> context; they are not needed to review the patch.
>=20
>  fs/binfmt_misc.c                  |  8 ++++++++
>  include/trace/events/binfmt_misc.h | 52 ++++++++++++++++++++++++++++++++=
++++++
>  2 files changed, 60 insertions(+)
>=20
> diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
> --- a/fs/binfmt_misc.c
> +++ b/fs/binfmt_misc.c
> @@ -41,6 +41,9 @@
> =20
>  #include "internal.h"
> =20
> +#define CREATE_TRACE_POINTS
> +#include <trace/events/binfmt_misc.h>
> +
>  /* Entry status and match type bit numbers. */
>  enum binfmt_misc_entry_bits {
>  	MISC_FMT_ENABLED_BIT	=3D 0,
> @@ -644,6 +647,11 @@
> =20
>  	flags =3D entry_invocation_flags(fmt, bprm);
> =20
> +	trace_binfmt_misc_select(bprm, interpreter,
> +				 test_bit(MISC_FMT_BPF_BIT, &fmt->flags) ?
> +				 fmt->bpf_ops->name : "",
> +				 flags & MISC_FMT_INVOCATION_FLAGS);

Logic like the above should be done in the trace event itself. Not in the
code path. That is, pass in fmt and flags.

> +
>  	/* No argv is built for a staged argument to land in. */
>  	if ((flags & (MISC_FMT_LOADER | MISC_FMT_TRANSPARENT)) &&
>  	    bprm->bpf_interp_arg)
>=20
> diff --git a/include/trace/events/binfmt_misc.h b/include/trace/events/bi=
nfmt_misc.h
> new file mode 100644
> --- /dev/null
> +++ b/include/trace/events/binfmt_misc.h
> @@ -0,0 +1,52 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Tracepoint for binfmt_misc binary type handler dispatch.
> + *
> + * Fires once for every exec a binfmt_misc entry matches, after the
> + * interpreter and the invocation flags have been selected. Unlike
> + * sched_process_exec (which reports bprm->filename) and /proc/PID/exe
> + * (which a transparent dispatch sets to the binary), this reports the
> + * interpreter that actually runs, so observers can see through a
> + * transparent dispatch.
> + */
> +#undef TRACE_SYSTEM
> +#define TRACE_SYSTEM binfmt_misc
> +
> +#if !defined(_TRACE_BINFMT_MISC_H) || defined(TRACE_HEADER_MULTI_READ)
> +#define _TRACE_BINFMT_MISC_H
> +
> +#include <linux/tracepoint.h>
> +#include <linux/binfmts.h>
> +
> +TRACE_EVENT(binfmt_misc_select,
> +
> +	TP_PROTO(struct linux_binprm *bprm, const char *interp,
> +		 const char *handler, unsigned long flags),
> +
> +	TP_ARGS(bprm, interp, handler, flags),
> +
> +	TP_STRUCT__entry(
> +		__string(filename,	bprm->filename)
> +		__string(interp,	interp)
> +		__string(handler,	handler)

Then here you would have:

		__string(handler, test_bit(MISC_FMT_BPF_BIT, &fmt->flags) ?
				 fmt->bpf_ops->name : "")


> +		__field(unsigned long,	flags)
> +		__field(pid_t,		pid)
> +	),
> +
> +	TP_fast_assign(
> +		__assign_str(filename);
> +		__assign_str(interp);
> +		__assign_str(handler);
> +		__entry->flags =3D flags;

and here:

		__entry->flags =3D flags & MISC_FMT_INVOCATION_FLAGS;

-- Steve


> +		__entry->pid =3D current->pid;
> +	),
> +
> +	TP_printk("pid=3D%d filename=3D%s interp=3D%s handler=3D%s flags=3D%#lx=
",
> +		  __entry->pid, __get_str(filename), __get_str(interp),
> +		  __get_str(handler), __entry->flags)
> +);
> +
> +#endif /* _TRACE_BINFMT_MISC_H */
> +
> +/* This part must be outside protection */
> +#include <trace/define_trace.h>

