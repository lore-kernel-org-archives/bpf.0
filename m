Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE3926B764
	for <bpf@vger.kernel.org>; Sun,  8 Feb 2026 13:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770556072; cv=pass; b=g34nAyKt+EgIgGUiULqbbR0p2P0BgbuN6Ux2h9bB7Khe8C0uCftLESc2wohZQ65jhLxS8fJ1XJ05TNn83dtJniiwOXNgMKiBZQoQZ7r5+tvsu/EGyYfXVxjArJEe4HjdYTytvhJtVKM9pe7Mktdj+9XqHa74gTCeKJCdOpx2w0Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770556072; c=relaxed/simple;
	bh=1Lh2M9MV6l1zfYMfYfAA4oRMXUg/S1a/HJ99t2BQ6ag=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qwRAtYDrIafyYy6DQFj6r1uRhs92KVzleLW88S1UHaKvmcvlJt10Ea4MduIp8plki6itcd2kNKdDtEO5v8jdFARUaVbTTG+DgDlZXYf270l+qMI0SK9CTNiOdUUxvFtkmkaFiyvmUXDUzWui+TlyvLj5zTx7acC7e902nBSI0rc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZJIvfzS6; arc=pass smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZJIvfzS6"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b8870ac4c4eso351191366b.2
        for <bpf@vger.kernel.org>; Sun, 08 Feb 2026 05:07:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770556070; cv=none;
        d=google.com; s=arc-20240605;
        b=ZG+m7JPWthYNLwzna/2ok+Z+CKUM0eW/5yn1vOJrWtQ0Twz1PHUifhTumIALHZSZCt
         AfeqiZDZS7tAD6azsUVexMP82JjeeSwMqbwhIQX48C91o4rBlR6wVvy/qvEbK0Ag43f6
         Z8iPi/rKQFxjFWllxICkOkFju5yXzXF2KboKUc5jxx49hSe3M93Af5899kZaKWYC9mZ9
         WIU5ynTBi6zCnB7UlVTUxwkfrxq7YYSQODC09ZgbvzG+nsZmzgaLPRYTfUw8FmeznLZh
         6U7RDKVbxiAM+tMw6H+NdyQ5+sO1+Nh9umFQz7m9tlqzD/rZMQ70E6zHPpDj4COuE8N8
         WJfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Lpk7186utWa07lVburlY6Omhhb1I4wGPFXBY93Ojxf0=;
        fh=XL2jPfvqjcyaHu3y9d8ob5jONML1E8BXDx9GcwdzAfc=;
        b=aRavWPvU8TKOft+sqBywOMXNsmneY63lk5NazB2WyH7VLsDjiu/KZqwysz3Hopy/ys
         eflA8timxnWOKJd/838QzbioIbJ6badhjEvO6dxug51EwkSbX9cTPmfOPfyvS3wzhx0b
         5pe1CqkI/RVpk7gJanepZTk9MqV4pxYcxxvfXxlqOBCy6cV/m+igxeqoI/pWOIFydW2p
         4Q+lC9S1ybghmT2IuyRUmOSDDU/0SKuVnw6VhWTiCijFyv3hAEfDw4fXYbc6F1ZQwT5r
         IOGzaCPf9/EYJF/Mi0MJSGbn65XTxmr0WTktu5iQzQzz1m06X9tfE70ub4PrvxydqJfr
         nyPw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770556070; x=1771160870; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lpk7186utWa07lVburlY6Omhhb1I4wGPFXBY93Ojxf0=;
        b=ZJIvfzS6tDKInHr/TstleNlPkHi5Yd3HGom2HjRlJjjYg57ZQENTi1evIcdp0JMbeo
         dEfn2+ZEx99jGKohLUOZ6+SobQSNDY/IDotrpYR/NP5Fvi1CJlNRVi5Se4mQD6jX7TSz
         xWb9/6OKtAVUngiiYhBVDnJk3bGzen8hgBcyPwFapcAJHUuF461TmZ5je2K15Sm8jEvl
         3DxUErY8jQtxxI3yOI4Rhm666411MNqJgOiXmSjqokBf9F2YGe8w9nPA0lhpNHdv/4M/
         3Br65pOz7homXmRiCNJsE5Sw8C3cyUNvM+NkIsZpeZe/p2UY9v/E/pzaXWU1zr/naGWb
         6f7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770556070; x=1771160870;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Lpk7186utWa07lVburlY6Omhhb1I4wGPFXBY93Ojxf0=;
        b=CUym7rcyqIFIdwvbgyoLY1SadeYp2nR7tPDJvAikMd8hDfX005k0aW2CGbpKePTK/h
         o/D/kLxdYKbZPPjJFJ1rQGRgbCigFSxvA32WlptIiWDP1+BO5A1OgBkrlFzRXFJvWQx1
         FQGpHZpTb2uug6gc9Gd8b4Ru2vRSdMW3R5Tyh1abUnRK5pJOFa7SwysLh37+qfy7ei2q
         ypd5yai/i4m6V4reAF3OmcmM8uisvRsUr7Bpr8gcbZxVgFB7IqYK9my2UkzAyVS1yBxL
         fKMwqQiov26uvlTS59V+9ISRABlg30P1J1j9wKsfNO0hl00pqf3i04F229F88cwcYpZZ
         skgw==
X-Forwarded-Encrypted: i=1; AJvYcCUlWNo1o8PTb9xLPU8BNMhZZw0xHbUXcuYBcp54KRs5hkstcgC+UU0vseTtviaAGzvh/4A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTc8B1F61b9MhDfKxcCtdK/UxHj6ZOheDvVFzDR9P99Xu1B/zW
	/OAvpt26oY0ugYzIBQIhgANUBtxTyxSwMXnLqvFvBTGhbna5uojAcBcEWrGO8/dKuDQl9YBAojL
	v4/tndGdKV/EasWAxOUvesol9vy+VN+I=
X-Gm-Gg: AZuq6aJSpqLKhXaVt8hyAL3ZzZV4qedwFAqg6Vd4qJYyK6r6lVeTxSpThG1ESM+GmrU
	FTlQhvIK6FMxqy0ejj5LY3DMDMePmJNarEGROK8sWBtQ66lXOszPqq3I9jckpTmutF4JwGdhGoF
	N1bs0f/SfE50P6LseXqftP8SU7MnrIZ6keHfJ+GtQPgoWGqkV39nxDwWA/mmnd2JtWtHUPjV0E+
	hIb2JxKASwxbpUE27zrV5R7BqOMqYvIGEQKmD/0pgGCOUkAJD3KhEQrH8iBywIlT03TSo0SUY0S
	x2fnWns=
X-Received: by 2002:a17:907:2da6:b0:b87:117f:b6f9 with SMTP id
 a640c23a62f3a-b8edf174430mr469352266b.8.1770556069578; Sun, 08 Feb 2026
 05:07:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260202111548.3555306-1-dolinux.peng@gmail.com>
 <20260202111548.3555306-3-dolinux.peng@gmail.com> <20260202111249.649ac338@gandalf.local.home>
 <CAErzpmuFQqT3+7cSjq4HrYj0Bp_qjagJSh313_ePJxs+0QjVFA@mail.gmail.com>
 <CAErzpmvgR7QgUTkcEfYstci9wNfGZBksczbkMv5w0ijoUcsBwg@mail.gmail.com>
 <20260203101707.52965eb0@gandalf.local.home> <CAADnVQKXMzTsbrD8j0spJETXL77x=r30fEiPQLCiNr=XWtgB+Q@mail.gmail.com>
 <CAErzpmu9mNXTOw-WwkSGEdvmJY2VjyUbGWZD=5s6kXNRE_YkJQ@mail.gmail.com> <20260205130459.0ff532f3@robin>
In-Reply-To: <20260205130459.0ff532f3@robin>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Sun, 8 Feb 2026 21:07:37 +0800
X-Gm-Features: AZwV_Qhtrwbg9jnGoduBNEr6Oncp7yRGU_wrKqlI5ZNeTdjeTOHhCmBD0TzKe2Y
Message-ID: <CAErzpmsajhJ45TkPx_TPwAPwN1fxO0cNYFTKFgLaosiPMo9wew@mail.gmail.com>
Subject: Re: [PATCH 2/2] tracing: resolve enum names for function arguments
 via BTF
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
	Andrii Nakryiko <andrii.nakryiko@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Donglin Peng <pengdonglin@xiaomi.com>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 6, 2026 at 2:05=E2=80=AFAM Steven Rostedt <rostedt@goodmis.org>=
 wrote:
>
> On Wed, 4 Feb 2026 22:52:11 +0800
> Donglin Peng <dolinux.peng@gmail.com> wrote:
>
> > > > I have trace-cmd reading BTF now (just haven't officially released =
it) and
> > > > doing an extract and reading the trace.dat file is much faster than=
 reading
> > > > the trace file with arguments. I'll need to implement the enum logi=
c too in
> > > > libtraceevent.
> > >
> > > If you mean to do pretty printing of the trace in user space then +1 =
from me.
> > >
> > > I don't like sorting enums either in resolve_btfid, pahole or kernel.
> > > Sorted BTF by name was ok, since it doesn't change original semantics=
.
> > > While sorting enums by value gets us to the grey zone where
> > > the sequence of enum names in vmlinux.h becomes different than in dwa=
rf.
> >
> > Thanks, I agreed.
>
> BTW, I just officially released trace-cmd v3.4 (where you can see whats
> new in that release here[1]).
>
> The biggest change is that it saves the BTF file in the trace.dat file
> and parses it on the report (it requires libtraceevent v1.9):
>
>  ~# trace-cmd record -p function_graph -O funcgraph-args -g do_sys_openat=
2
>  [..]
>  ~# trace-cmd report
>        trace-cmd-50935 [002] ...1.  3490.518138: funcgraph_entry:        =
           |  do_sys_openat2(dfd=3D4294967196, filename=3D0x557bb9e3ee10, h=
ow=3D0xffff88815220fea8) {
>        trace-cmd-50935 [002] ...1.  3490.518141: funcgraph_entry:        =
           |    getname_flags(filename=3D0x557bb9e3ee10, flags=3D0) {
>        trace-cmd-50935 [002] ...1.  3490.518142: funcgraph_entry:        =
           |      getname_flags.part.0(filename=3D0x557bb9e3ee10, flags=3D0=
) {
>        trace-cmd-50935 [002] ...1.  3490.518143: funcgraph_entry:        =
           |        kmem_cache_alloc_noprof(s=3D0xffff888106c7e000, gfpflag=
s=3D0xcc0) {
>        trace-cmd-50935 [002] ...1.  3490.518145: funcgraph_entry:        =
           |          stack_trace_save(store=3D0xffff88815220fac8, size=3D0=
x40, skipnr=3D0x0) {
>        trace-cmd-50935 [002] ...1.  3490.518147: funcgraph_entry:        =
           |            arch_stack_walk(consume_entry=3D0xffffffff94d9dfe0,=
 cookie=3D0xffff88815220fa58, task=3D0xffff88812d4c3580, regs=3D0x0) {
>        trace-cmd-50935 [002] ...1.  3490.518148: funcgraph_entry:        =
           |              __unwind_start(state=3D0xffff88815220f988, task=
=3D0xffff88812d4c3580, regs=3D0x0, first_frame=3D0xffff88815220fa28) {
>        trace-cmd-50935 [002] ...1.  3490.518149: funcgraph_entry:        =
1.518 us   |                get_stack_info(stack=3D0xffff88815220f938, task=
=3D0xffff88812d4c3580, info=3D0xffff88815220f988, visit_mask=3D0xffff888152=
20f9a8); (ret=3D0x0)
>        trace-cmd-50935 [002] ...1.  3490.518152: funcgraph_entry:        =
           |                unwind_next_frame(state=3D0xffff88815220f988) {
>        trace-cmd-50935 [002] ...1.  3490.518153: funcgraph_entry:        =
0.951 us   |                  __rcu_read_lock(); (ret=3D0xffff88812d4c3580)

Hi Steve,

I noticed that trace-cmd 3.4 introduced a new feature:

- Add support for showing parent functions in function graph

  If the "funcgraph-retaddr" option is set during function graph tracing,
  the parent functions will now be displayed:

  preempt_count_add(val=3D65536); /* <-irq_enter_rcu */ (ret=3D0x10001)

However, it currently only prints the caller's entry point. I suggest
enhancing this to include the **offset within the caller** as well. This
would allow tools like `faddr2line` to locate the exact call site accuratel=
y.

I implemented a tool named FuncGraph[1] to convert function_graph
ftrace output into an interactive HTML file. It leverages fastfaddr2line
to map return addresses (e.g., __sys_bpf+0x51/0x500) to their
corresponding call sites, such as: __sys_bpfat kernel/bpf/syscall.c:6115.

What do you think?

Thanks,
Donglin

[1] https://github.com/pengdonglin137/FuncGraph

>
> -- Steve
>
>
>
> [1] https://git.kernel.org/pub/scm/utils/trace-cmd/trace-cmd.git/tag/?h=
=3Dtrace-cmd-v3.4
