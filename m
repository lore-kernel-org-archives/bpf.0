Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=79.135.106.99
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793134948;
	b=DOGuC+S5cIegMUnYLHWAEG91bne7aHhyYxUWyR0yl/Li2yuCVHo5t66EcUxhS9h+rtZ/
	 6iv16lPmlVztC9AVIBGDD6mMPcqYDoBhOpjW6r5JMawXj7HmPaXZe8I37yfjTniiYq/6q
	 UT4uoJz7qFWhdi01ZNIcxyiMTs3KYClZpiGr7QcMYVhdQDK9KI8wPQGS/r9I8mPEHGdvC
	 nAOemcE+rqeLbiSBgjrjj1UMeITZEcCj1vPd5luHbFFIF0ispH0i5kdvQIPVV14AhRaNG
	 NkKHqrrQCnpwMGDSGLauxBRJiu2DB1ueIp2AZtybDIkh/oFyppbG/p+STJ5C4TdQgQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793134948;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=0gdBK2a/7BtrvxXUlX9He8n64shVCDBHPI0R3YZSOO8=;
	b=WQ+/3F9rWefVt7PiygCYt9Z/kD913kLbHPlsb8r+9DTgo7d9qkVB9wG1dEVbpgprJbS4
	 0wucca7u9OOSkBRz9ofantEn1Dp3A9nfYP5qBxcj925UMQ6rW3eKgW68eBIVvw6f9Bxh4
	 X6IQpO4Xtp7ZgFBBLWmOesQwTHC4Blv5Sxv7XH6sNp7tYbqMfRogM0LTelzG9QHg2kxXa
	 Uk2hK14xR5rKQc3r4yEvFuT/lIDgjjPX6r+JCscjc68JJjjI0wkU3T05XfECrPZzdUrMm
	 2fXnFJk87aDM/In7TUg27DdbHF8NeEBWoZAuSVODN3OFCTk/JEPDFm7HtAoidE0FeUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=proton.me;
	spf=pass smtp.mailfrom=proton.me;
	dkim=pass header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=RPvtGViX;
	arc=none smtp.remote-ip=79.135.106.99
Received: from mail-10699.protonmail.ch (mail-10699.protonmail.ch [79.135.106.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA6B606A31A;
	Tue, 27 Oct 2026 21:02:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ACA6B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=RPvtGViX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail2; t=1793134944; x=1793394144;
	bh=0gdBK2a/7BtrvxXUlX9He8n64shVCDBHPI0R3YZSOO8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=RPvtGViX8DtOI+cYibDYRy7LwnkDbu8zH1jzLEv9eW8+BP0fHvfB4+MkW/x7UxS2J
	 dzER/G6vV7gCCK3TFaFCiuR04uvdpoIh0uQkl4yLM/t1zkehwDOQwXjsBN3Q1XeO9N
	 c3VFwUSEc0XmqrnZd4Vv3KvF8/JNCxePthUV5MFS48HYFmRTZzIH3WnQiZr3zccZ6d
	 hzBYwCs5bqVRt5DKj7qKynQ7BvfBb0WVED7vph2zIkwghsuNdQ6CECjjdXPcOLtrmy
	 BlWFBr8Bx8/H8KUgUQT8NRlFK1PPxWBAWk+taXftlZ/diT6g/c3/iKj6H7QT6uQmj4
	 rrrHzr3ZcXPMQ==
Date: Tue, 27 Oct 2026 21:02:16 +0000
To: Steven Rostedt <rostedt@goodmis.org>, "kees@kernel.org" <kees@kernel.org>, "brauner@kernel.org" <brauner@kernel.org>
From: BoxStrikesTeam <BoxStrikesTeam@proton.me>
Cc: "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, "jack@suse.cz" <jack@suse.cz>, "mhiramat@kernel.org" <mhiramat@kernel.org>, "mathieu.desnoyers@efficios.com" <mathieu.desnoyers@efficios.com>, "jkoolstra@xs4all.nl" <jkoolstra@xs4all.nl>, "farid.m.zakaria@gmail.com" <farid.m.zakaria@gmail.com>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Ynt: Re: [RFC PATCH] binfmt_misc: add binfmt_misc_select tracepoint
Message-ID: <Z3h154GvGuNo0lQQgNCwWxpvOkPCUZblnFrYRF1R9dx3Lqyh7mG96XAdo4GDq2Sy-wjlmqcQKcgmosaapO4gy82voeR2rAerZh9u2LmCEiA=@proton.me>
In-Reply-To: <20261026162846.23686159@gandalf.local.home>
References: <cmtfuzYFZMj7WozUoEjFs3RxYWe9UgdY5rK3ZGT7CPwO1mpemvEwNhG4v5ucoKBgUHMqFa7kSzOvLjFcVcxAybfmKdURZ4h-qoKX1lHXlAA=@proton.me> <20261026162846.23686159@gandalf.local.home>
Feedback-ID: 205449183:user:proton
X-Pm-Message-ID: 9f98da1da7a4f9aead59ee0aee5c9d5707e0cf2b
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Thank you! Steve, for your suggestions.

I=E2=80=99ll take a look at the suggested fixes for the patch tomorrow. The=
 main issue I ran into was that Proton Mail=E2=80=99s SMTP submission setup=
 requires a paid plan, which caused me quite a bit of trouble. That=
=E2=80=99s why I=E2=80=99ve included the patch as an attachment for now.

It seems that Yandex Mail doesn=E2=80=99t have the same limitation. Once I=
=E2=80=99ve prepared version 2 of the patch, I=E2=80=99ll send it to you us=
ing Yandex Mail.

Thanks again for your help and suggestions!



Proton Mail g=C3=BCvenli e-posta ile g=C3=B6nderildi.

Steven Rostedt <rostedt@goodmis.org>, 26 Ekim 2026 Pazartesi saat 23:28 tar=
ihinde =C5=9Funu yazd=C4=B1:

>=20
> You shouldn't attach patches but inline them. Yeah, I know a lot of email
> clients can't handle that. But claws-mail can! (and it can also reply to
> attachments like they were inlined ;-) ).
>=20
> I'll let others comment on whether or not this patch is needed, but I'll
> comment on the tracing side of things.
>=20
>=20
> On Mon, 26 Oct 2026 20:17:26 +0000
> BoxStrikesTeam <BoxStrikesTeam@proton.me> wrote:
>=20
> > From: Eneshan Erdo=C4=9Fan Karaca <BoxStrikesTeam@proton.me>
> > Subject: [RFC PATCH] binfmt_misc: add binfmt_misc_select tracepoint
> >
> > A binfmt_misc entry can select an interpreter for an exec.  With a BPF
> > 'B' handler, that selection can be made by a BPF struct_ops program.
> > The kernel commits the decision in bprm->interp and bprm->flags, but it
> > does not emit an event at the selection point.
> >
> > Existing observers have to reconstruct the decision from
> > /proc/PID/exe, AT_EXECFD, AT_FLAGS, or /proc/PID/maps.  These sources
> > are mode-dependent: a transparent dispatch still reports the original
> > binary in /proc/PID/exe, and a short-lived process can exit before the
> > observer reads it.  A classic dispatch reports the interpreter, but
> > not which handler selected it or which invocation flags were used.
> >
> > Add a tracepoint after the interpreter and the invocation flags are
> > selected.  It reports the binary filename, the selected interpreter,
> > the handler name (for BPF handlers), the invocation flags, and the
> > pid.  The flags are masked with MISC_FMT_INVOCATION_FLAGS so that
> > static entry state does not leak into the event.
> >
> > The tracepoint is observability only; it does not change exec
> > behavior.
> >
> > Assisted-by: LLM
> > Signed-off-by: Eneshan Erdo=C4=9Fan Karaca <BoxStrikesTeam@proton.me>
> > ---
> >
> > This is an RFC.  A small PoC and short A/B results are available for
> > context; they are not needed to review the patch.
> >
> >  fs/binfmt_misc.c                  |  8 ++++++++
> >  include/trace/events/binfmt_misc.h | 52 ++++++++++++++++++++++++++++++=
++++++++
> >  2 files changed, 60 insertions(+)
> >
> > diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
> > --- a/fs/binfmt_misc.c
> > +++ b/fs/binfmt_misc.c
> > @@ -41,6 +41,9 @@
> >
> >  #include "internal.h"
> >
> > +#define CREATE_TRACE_POINTS
> > +#include <trace/events/binfmt_misc.h>
> > +
> >  /* Entry status and match type bit numbers. */
> >  enum binfmt_misc_entry_bits {
> >  =09MISC_FMT_ENABLED_BIT=09=3D 0,
> > @@ -644,6 +647,11 @@
> >
> >  =09flags =3D entry_invocation_flags(fmt, bprm);
> >
> > +=09trace_binfmt_misc_select(bprm, interpreter,
> > +=09=09=09=09 test_bit(MISC_FMT_BPF_BIT, &fmt->flags) ?
> > +=09=09=09=09 fmt->bpf_ops->name : "",
> > +=09=09=09=09 flags & MISC_FMT_INVOCATION_FLAGS);
>=20
> Logic like the above should be done in the trace event itself. Not in the
> code path. That is, pass in fmt and flags.
>=20
> > +
> >  =09/* No argv is built for a staged argument to land in. */
> >  =09if ((flags & (MISC_FMT_LOADER | MISC_FMT_TRANSPARENT)) &&
> >  =09    bprm->bpf_interp_arg)
> >
> > diff --git a/include/trace/events/binfmt_misc.h b/include/trace/events/=
binfmt_misc.h
> > new file mode 100644
> > --- /dev/null
> > +++ b/include/trace/events/binfmt_misc.h
> > @@ -0,0 +1,52 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Tracepoint for binfmt_misc binary type handler dispatch.
> > + *
> > + * Fires once for every exec a binfmt_misc entry matches, after the
> > + * interpreter and the invocation flags have been selected. Unlike
> > + * sched_process_exec (which reports bprm->filename) and /proc/PID/exe
> > + * (which a transparent dispatch sets to the binary), this reports the
> > + * interpreter that actually runs, so observers can see through a
> > + * transparent dispatch.
> > + */
> > +#undef TRACE_SYSTEM
> > +#define TRACE_SYSTEM binfmt_misc
> > +
> > +#if !defined(_TRACE_BINFMT_MISC_H) || defined(TRACE_HEADER_MULTI_READ)
> > +#define _TRACE_BINFMT_MISC_H
> > +
> > +#include <linux/tracepoint.h>
> > +#include <linux/binfmts.h>
> > +
> > +TRACE_EVENT(binfmt_misc_select,
> > +
> > +=09TP_PROTO(struct linux_binprm *bprm, const char *interp,
> > +=09=09 const char *handler, unsigned long flags),
> > +
> > +=09TP_ARGS(bprm, interp, handler, flags),
> > +
> > +=09TP_STRUCT__entry(
> > +=09=09__string(filename,=09bprm->filename)
> > +=09=09__string(interp,=09interp)
> > +=09=09__string(handler,=09handler)
>=20
> Then here you would have:
>=20
> =09=09__string(handler, test_bit(MISC_FMT_BPF_BIT, &fmt->flags) ?
> =09=09=09=09 fmt->bpf_ops->name : "")
>=20
>=20
> > +=09=09__field(unsigned long,=09flags)
> > +=09=09__field(pid_t,=09=09pid)
> > +=09),
> > +
> > +=09TP_fast_assign(
> > +=09=09__assign_str(filename);
> > +=09=09__assign_str(interp);
> > +=09=09__assign_str(handler);
> > +=09=09__entry->flags =3D flags;
>=20
> and here:
>=20
> =09=09__entry->flags =3D flags & MISC_FMT_INVOCATION_FLAGS;
>=20
> -- Steve
>=20
>=20
> > +=09=09__entry->pid =3D current->pid;
> > +=09),
> > +
> > +=09TP_printk("pid=3D%d filename=3D%s interp=3D%s handler=3D%s flags=3D=
%#lx",
> > +=09=09  __entry->pid, __get_str(filename), __get_str(interp),
> > +=09=09  __get_str(handler), __entry->flags)
> > +);
> > +
> > +#endif /* _TRACE_BINFMT_MISC_H */
> > +
> > +/* This part must be outside protection */
> > +#include <trace/define_trace.h>
>=20
> 
