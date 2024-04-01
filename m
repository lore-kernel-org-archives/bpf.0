Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F13510A3E
	for <bpf@vger.kernel.org>; Mon,  1 Apr 2024 09:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711964827; cv=none; b=apvr9nXzfYyTsqstNcAbW096TtU4VXz3Z50Hwx3tlGsuBAPyfiR0SmQI1rygx9H5fA53JnD03OLTVmF/Xigv2BmzVH78E2FOUCFtQNWU+4N8mEzL3cfCDlfnH1artkhZ/pYkEUdDvCDZjBF9CmOo1EU7QuP6MNFwhLqlFkykOGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711964827; c=relaxed/simple;
	bh=c4iN5KKDP2ORl5rtTNfbEYRFiRwBmlnV0Me7/XKC89g=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=QntJQBYzDq4vHQkwgOUXCxqemuzCJ3r5yoAgidSvHOIMQhN7yA0d68qxAQWP6A9piyauTqEImKivZ7D6WgpRc3PRYyVSxsbNz+eRoFfCTu3VDM9/H0/Iw47rqsw5to9f+HoHC/x/78wNWIseeW+OvjTyOz/n6Ky1OW8ZauKPkZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oe76QBc+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oe76QBc+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70C75C433F1;
	Mon,  1 Apr 2024 09:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711964826;
	bh=c4iN5KKDP2ORl5rtTNfbEYRFiRwBmlnV0Me7/XKC89g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oe76QBc+GlfOR1n1VXj6PglRY4RwXO5Q1lRqfFb+thria4r5MYf+NoeaKnsr+179F
	 7KpQKs675X4tgs8HXw4UuCsfztAG50FOfZLEbOh9/LbeepRBxeeKlgyVZo9M3s8j7W
	 BukPxRH5PhTlLTtqU4/1UeWO5ku5vDUi5xUbxF+BMWHqgtR3QjSRbwoDS7y1JRlNgL
	 29EcrL8w0L+yuZ0KZIGZX8RYaC1N5a1aCijgzNnhOfi80p1unTM4vdjD/r5F+LykhG
	 JFMuMu1GwE7SLvQkRtNVzd6Ow43iSH9GTfYkGgDIQ/aO1PHUf0lLrWXsSma71tnuUu
	 aeRJ2VanGP/Sw==
Date: Mon, 1 Apr 2024 18:47:00 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Steven Rostedt
 <rostedt@goodmis.org>, Oleg Nesterov <oleg@redhat.com>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, bpf@vger.kernel.org, Song Liu <songliubraving@fb.com>,
 Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>,
 Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner
 <tglx@linutronix.de>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 x86@kernel.org
Subject: Re: [PATCH bpf-next 2/3] selftests/bpf: Add uretprobe syscall test
 for regs integrity
Message-Id: <20240401184700.2ffdbb7fea8b95d2e716675c@kernel.org>
In-Reply-To: <Zgm7X1_3iRewLNQQ@krava>
References: <20240327102036.543283-1-jolsa@kernel.org>
	<20240327102036.543283-3-jolsa@kernel.org>
	<CAEf4BzZps+OdPoyRz1=7mEzh=shjVjT=ZznhMD0Y-w98GW782g@mail.gmail.com>
	<Zgm7X1_3iRewLNQQ@krava>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Jiri,

On Sun, 31 Mar 2024 21:37:03 +0200
Jiri Olsa <olsajiri@gmail.com> wrote:

> On Fri, Mar 29, 2024 at 03:30:11PM -0700, Andrii Nakryiko wrote:
> > On Wed, Mar 27, 2024 at 3:21 AM Jiri Olsa <jolsa@kernel.org> wrote:
> > >
> > > Add uretprobe syscall test that compares register values before
> > > and after the uretprobe is hit. It also compares the register
> > > values seen from attached bpf program.
> > >
> > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > > ---
> > >  tools/include/linux/compiler.h                |   4 +
> > >  .../selftests/bpf/prog_tests/uprobe_syscall.c | 163 ++++++++++++++++++
> > >  .../selftests/bpf/progs/uprobe_syscall.c      |  15 ++
> > >  3 files changed, 182 insertions(+)
> > >  create mode 100644 tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> > >  create mode 100644 tools/testing/selftests/bpf/progs/uprobe_syscall.c
> > 
> > [...]
> > 
> > > +__naked unsigned long uprobe_syscall_arch_test(void)
> > > +{
> > > +       asm volatile (
> > > +               "movq $0xdeadbeef, %rax\n"
> > > +               "ret\n"
> > > +       );
> > > +}
> > > +
> > > +__naked void uprobe_syscall_arch(struct pt_regs *before, struct pt_regs *after)
> > 
> > don't you get compiler warnings for using __naked with explicit
> > function arguments?
> 
> nope, both gcc and clang are silent
> 
> > 
> > > +{
> > > +       asm volatile (
> > > +               "movq %r15,   0(%rdi)\n"
> > > +               "movq %r14,   8(%rdi)\n"
> > 
> > [...]
> > 
> > > +       err = uprobe_syscall__attach(skel);
> > > +       if (!ASSERT_OK(err, "uprobe_syscall__attach"))
> > > +               goto cleanup;
> > > +
> > > +       uprobe_syscall_arch(&before, &after);
> > 
> > uprobe_syscall_arch() doesn't really do an explicit `syscall
> > uretprobe`, it should work for int3-based uretprobes as well? Let's
> > call it something a bit more generic then?
> 
> ok, how about
> 
>   uprobe_syscall_arch -> uretprobe_regs
>   uprobe_syscall_arch_test -> uretprobe_regs_trigger
> 
> > 
> > Also, I think patch #1 will go through Masami's trace tree, right? But
> > we can land selftests into bpf-next even before that, given they
> > should work for both syscall and interrupt based uretprobes.
> 
> hm, not sure.. I did not originally cc Masami/Steven :-\  adding now

Would you mean this patch?

https://lore.kernel.org/all/20240327102036.543283-2-jolsa@kernel.org/

It seems you don't Cc/To me nor linux-kernel-trace ML.

> 
> Masami, could patch 1 go through:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
>   probes/for-next

Could you resend it to linux-kernel-trace ML?  (only the first one?)

Thank you,

> 
> thanks,
> jirka


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
