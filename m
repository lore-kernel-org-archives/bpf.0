Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016AF8613E
	for <bpf@vger.kernel.org>; Wed, 20 Mar 2024 23:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710978394; cv=none; b=MiJBUkyIDkKyvro1K9uK8+N8R1UanSVcqllHkZ55HyuEGC8WZWALapVH5kAL+33BiXdJL9OEO77JwS3o6EO1LNnstJEp8txwbASqv4acCzAqq7n9Y2vRuW4stalakbhvI94obxJKfKtps358kIy9/lX5FVBtFaSG2EalHOTd2DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710978394; c=relaxed/simple;
	bh=QYTlPGkjW39YGcH+/7qPEy3JR4nMT2fEp3Zpz2wl+no=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=H6qpZolo236OYtEsVsSQh3kU68dMe9fCWUEIpQg1qptA6nBBLe84nexJBxBZQ6C9EG4BARVRo3KDuxQeYbFt/LwggNzhd4kv1ZpH17c9tMYXYG3qhV73v12P117i6Dol2rpfU4jew2S8H77MxJ+eCHN5NqnrQ5ggsnbfSoXpBAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TAUaHBBp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TAUaHBBp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6A0CC433F1;
	Wed, 20 Mar 2024 23:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710978393;
	bh=QYTlPGkjW39YGcH+/7qPEy3JR4nMT2fEp3Zpz2wl+no=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TAUaHBBpZ24DYS8DmlZkzjTcUTnD3CrZPAJrWs5h6PExIFlu81z1bHrQ8pdNFCP7w
	 U/AD89nuhbIQnhzwASQ1LLQJNc4bqW1l2ND2U78fEDxZMOM8/0fiwnVF7PwxnLVOqV
	 FRu6XwyTIKLoOmx+EoLBbObVep1bfqmLeWa5adLCK5UeBcWOoih/q4x4SkziQLVBzy
	 TimtB89A0msWduP1pzP9eXCLvXasW3ouMzRJwTWV7aFdtnJ+eg53oEVBx20HoGEnA3
	 LNT/LlYZQE2tOM8YOxpZpPTFEdelUpoKd4NF4GA7vPKn89LwW/S15fhYZUU4GIbMvq
	 YtUdvjxVq312A==
Date: Thu, 21 Mar 2024 08:46:28 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Masami Hiramatsu <mhiramat@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org,
 daniel@iogearbox.net, martin.lau@kernel.org, kernel-team@meta.com, Peter
 Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH bpf-next] bpf: avoid get_kernel_nofault() to fetch
 kprobe entry IP
Message-Id: <20240321084628.71442185b1fad5fdd47d0bab@kernel.org>
In-Reply-To: <CAEf4BzZ_HGWwc2KWGUtu+_e5OYoHEpdzrk0vLDfv7vYvyihniQ@mail.gmail.com>
References: <20240319212013.1046779-1-andrii@kernel.org>
	<20240320124742.5652f47b8f6dfea24cf84ce9@kernel.org>
	<Zfqfgn6lqwRCFQaD@krava>
	<CAEf4BzZ_HGWwc2KWGUtu+_e5OYoHEpdzrk0vLDfv7vYvyihniQ@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 20 Mar 2024 10:46:54 -0700
Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:

> On Wed, Mar 20, 2024 at 1:34 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> >
> > On Wed, Mar 20, 2024 at 12:47:42PM +0900, Masami Hiramatsu wrote:
> > > On Tue, 19 Mar 2024 14:20:13 -0700
> > > Andrii Nakryiko <andrii@kernel.org> wrote:
> > >
> > > > get_kernel_nofault() (or, rather, underlying copy_from_kernel_nofault())
> > > > is not free and it does pop up in performance profiles when
> > > > kprobes are heavily utilized with CONFIG_X86_KERNEL_IBT=y config.
> > > >
> > > > Let's avoid using it if we know that fentry_ip - 4 can't cross page
> > > > boundary. We do that by masking lowest 12 bits and checking if they are
> > > > >= 4, in which case we can do direct memory read.
> > > >
> > > > Another benefit (and actually what caused a closer look at this part of
> > > > code) is that now LBR record is (typically) not wasted on
> > > > copy_from_kernel_nofault() call and code, which helps tools like
> > > > retsnoop that grab LBR records from inside BPF code in kretprobes.
> >
> > I think this is nice improvement
> >
> > Acked-by: Jiri Olsa <jolsa@kernel.org>
> >
> 
> Masami, are you ok if we land this rather straightforward fix in
> bpf-next tree for now, and then you or someone a bit more familiar
> with ftrace/kprobe internals can generalize this in a more generic
> way?

I'm OK for this change for short term fix. As far as I can see, the
kprobe-side change may involve more kprobe internal changes, so

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

> 
> > >
> > > Hmm, we may better to have this function in kprobe side and
> > > store a flag which such architecture dependent offset is added.
> > > That is more natural.
> >
> > I like the idea of new flag saying the address was adjusted for endbr
> >
> 
> instead of a flag, can kprobe low-level infrastructure just provide
> "effective fentry ip" without any flags, so that BPF side of things
> don't have to care?

It's possible. But it is a bit only for BPF and not fit to kprobe
itself. I think we can add it in trace_kprobe instead of kprobe,
which can be accessed from struct kprobe *kp.

Thank you,

> 
> > kprobe adjust the address in arch_adjust_kprobe_addr, it could be
> > easily added in there and then we'd adjust the address in get_entry_ip
> > accordingly
> >
> > jirka
> >
> > >
> > > Thanks!
> > >
> > > >
> > > > Cc: Masami Hiramatsu <mhiramat@kernel.org>
> > > > Cc: Peter Zijlstra <peterz@infradead.org>
> > > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > > > ---
> > > >  kernel/trace/bpf_trace.c | 12 +++++++++---
> > > >  1 file changed, 9 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > > > index 0a5c4efc73c3..f81adabda38c 100644
> > > > --- a/kernel/trace/bpf_trace.c
> > > > +++ b/kernel/trace/bpf_trace.c
> > > > @@ -1053,9 +1053,15 @@ static unsigned long get_entry_ip(unsigned long fentry_ip)
> > > >  {
> > > >     u32 instr;
> > > >
> > > > -   /* Being extra safe in here in case entry ip is on the page-edge. */
> > > > -   if (get_kernel_nofault(instr, (u32 *) fentry_ip - 1))
> > > > -           return fentry_ip;
> > > > +   /* We want to be extra safe in case entry ip is on the page edge,
> > > > +    * but otherwise we need to avoid get_kernel_nofault()'s overhead.
> > > > +    */
> > > > +   if ((fentry_ip & ~PAGE_MASK) < ENDBR_INSN_SIZE) {
> > > > +           if (get_kernel_nofault(instr, (u32 *)(fentry_ip - ENDBR_INSN_SIZE)))
> > > > +                   return fentry_ip;
> > > > +   } else {
> > > > +           instr = *(u32 *)(fentry_ip - ENDBR_INSN_SIZE);
> > > > +   }
> > > >     if (is_endbr(instr))
> > > >             fentry_ip -= ENDBR_INSN_SIZE;
> > > >     return fentry_ip;
> > > > --
> > > > 2.43.0
> > > >
> > >
> > >
> > > --
> > > Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > >


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
