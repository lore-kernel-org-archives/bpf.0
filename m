Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D80C37F8B8;
	Fri, 22 May 2026 15:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779462063; cv=none; b=cR13DJtU2ZVaHCxjeUF0OYXZHPegv9MLpZxnmTHCvt05fk3KV7iFeev7IfeMwN8p4zvg6OKGRMY/eSqcaRTgZF6tTpJeXe4CkRc5j1bcN6GT9J5ngGNEfn/P+dhL8FLUf9Tq0UOAM5BJh0l0S/UOyPrtwmFbAsSoWrHf5MN+oFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779462063; c=relaxed/simple;
	bh=hP7zG0jjuVhwnl0z2gVnSp0KsWsgvAMKNkhd5AhIQAo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KWF0SBFqjk4XNuiIC7R1pGEMmcugH63EDTVnqY6dDC1pIpMJsBEkUXxuZN5Mt4YjwtzZh++bxy37f+bGgmVPPIwtyTq9tz8vYDwAdKU6GEYcxDXmocyWifCFWb+88l9qTuyINFDnYJc+ONRFX1Gsa6QYgNSlpxA14neG3KsVoxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BLWi9T7/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BLWi9T7/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 429F11F000E9;
	Fri, 22 May 2026 15:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779462062;
	bh=NIjEohfSDtw1Ut++P3AmpDRpqgKOz0KLQwiNAYD/Wy4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=BLWi9T7/FIVG5ZaqnphodPR6YtEN7tIf5QYaF/lrP41tiveqzIWs9bxAu8sj41087
	 VreeKUxFCqZUX6xOWe9Kgb7Wq/NCs5GJS0uziQFQIzz0h1MdQY5fhU7aBhe+YmrGeA
	 HBpKWF+pqk5IeEya3HhzgiHC36G2hG9UA3EIilaTnh+Yxqz6vFETn+TEZ8H1ilVnl/
	 QaQt8Hg0d5d+yMVBxlP9w+sH/nP+/QVcFSHcEzPCruKQd0Ts8ueQ5FpceiIkh7EXRB
	 DX80iEb6KEPXBR3GGEuHi7aAGtpIigOkgIo4vNNsflHB14P5htzkBK1J+Wn7MPVY6U
	 qvuJLJPzANBpg==
Date: Fri, 22 May 2026 11:01:21 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: Thomas =?UTF-8?B?V2Vpw59zY2h1aA==?= <thomas@t-8ch.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, bpf@vger.kernel.org, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Jens Remus <jremus@linux.ibm.com>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Jiri
 Olsa <jolsa@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Andrii Nakryiko <andrii@kernel.org>, Indu Bhagat <indu.bhagat@oracle.com>,
 "Jose E. Marchesi" <jemarch@gnu.org>, Beau Belgrave
 <beaub@linux.microsoft.com>, Linus Torvalds
 <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>,
 Florian Weimer <fweimer@redhat.com>, Kees Cook <kees@kernel.org>, Carlos
 O'Donell <codonell@redhat.com>, Sam James <sam@gentoo.org>, Dylan Hatch
 <dylanbhatch@google.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, David Hildenbrand <david@redhat.com>, "H.
 Peter Anvin" <hpa@zytor.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Michal Hocko
 <mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan
 <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>, Heiko Carstens
 <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH] unwind: Add sframe_(un)register() system calls
Message-ID: <20260522110121.660c5016@gandalf.local.home>
In-Reply-To: <7923f815-a8ce-4b64-8cbf-2b90e57cbd24@t-8ch.de>
References: <20260521183532.7a145c8a@gandalf.local.home>
	<7923f815-a8ce-4b64-8cbf-2b90e57cbd24@t-8ch.de>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 22 May 2026 16:36:56 +0200
Thomas Wei=C3=9Fschuh <thomas@t-8ch.de> wrote:

> On 2026-05-21 18:35:32-0400, Steven Rostedt wrote:
> > From: Steven Rostedt <rostedt@goodmis.org>
> >=20
> > Add system calls to register and unregister sframes that can be used by
> > dynamic linkers to tell the kernel where the sframe section is in memory
> > for libraries it loads. =20
>=20
> How is this system call related to the prctl() with the same
> functionality from Jens' series? I guess it will replace it,
> but some explanation would be nice.

I thought the patch with the prctl() stated it was for debug purposes only.
=46rom the change log:

[
  This adds an interface for prctl() for testing loading of sframes for
  libraries. But this interface should really be a system call. This patch
  is for testing purposes only and should not be applied to mainline.
]

Hence I didn't think there needs to be any explanation. The prctl() patch
should never be applied upstream.

>=20
> (...)
>=20
> > diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
> > index f5639d5ac331..992ccc401c5e 100644
> > --- a/include/linux/syscalls.h
> > +++ b/include/linux/syscalls.h
> > @@ -999,6 +999,8 @@ asmlinkage long sys_lsm_get_self_attr(unsigned int =
attr, struct lsm_ctx __user *
> >  asmlinkage long sys_lsm_set_self_attr(unsigned int attr, struct lsm_ct=
x __user *ctx,
> >  				      u32 size, u32 flags);
> >  asmlinkage long sys_lsm_list_modules(u64 __user *ids, u32 __user *size=
, u32 flags);
> > +asmlinkage long sys_sframe_register(void *data, unsigned int size);
> > +asmlinkage long sys_sframe_unregister(void *data, unsigned int size); =
=20
>=20
> Why not use the actual structure here?

Yeah, I was somewhat lazy here to make sure that this was the direction we
want to go. I just need to add a structure pointer reference at the top of
that file.

Will update in v2.

>=20
> >  /*
> >   * Architecture-specific system calls =20
>=20
> (...)
>=20
> > diff --git a/include/uapi/linux/sframe.h b/include/uapi/linux/sframe.h
> > new file mode 100644
> > index 000000000000..137a2ebf91f4
> > --- /dev/null
> > +++ b/include/uapi/linux/sframe.h
> > @@ -0,0 +1,12 @@
> > +/* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
> > +#ifndef _UAPI_LINUX_SFRAME_H
> > +#define _UAPI_LINUX_SFRAME_H
> > +
> > +struct sframe_setup {
> > +	unsigned long		sframe_start;
> > +	unsigned long		sframe_size;
> > +	unsigned long		text_start;
> > +	unsigned long		text_size;
> > +}; =20
>=20
> This will break for compat processes, as they use a different 'unsigned
> long' than the host kernel. Maybe just use __u64.

I'll update it. I was thinking we wouldn't support compat, but in case we
decide we should forcing the size is better than being architecture
specific.

>=20
> > +
> > +#endif /* _UAPI_LINUX_SFRAME_H */ =20
>=20
> (...)
>=20
> > +/**
> > + * sys_sframe_register - register an address for user space stacktrace=
 walking.
> > + * @data: Structure of sframe data used to register the sframe section
> > + * @size: The size of the given structure.
> > + *
> > + * This system call is used by dynamic library utilities to inform the=
 kernel
> > + * of meta data that it loaded that can be used by the kernel to know =
how
> > + * to stack walk the given text locations.
> > + *
> > + * Return: 0 if successful, otherwise a negative error.
> > + */
> > +SYSCALL_DEFINE2(sframe_register, __user struct sframe_setup *, data, u=
nsigned int, size) =20
>=20
> AFAIK the normal place for the '__user' is right before '*':
>=20
> 	struct sframe_setup __user *, data,

Will update.

>=20
> Use __kernel_size_t for 'size'?

Looking at the history of the accept() system call that started with int
and then wanted size_t, then changed to socklen_t, I guess there's
precedence to use __kernel_size_t.

Will update.

Thanks!

-- Steve

