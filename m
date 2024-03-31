Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CCA0146D65
	for <bpf@vger.kernel.org>; Sun, 31 Mar 2024 19:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711913829; cv=none; b=d+rGrtEFCkYFc3FmAzF56ZbyxIbhWAJhykdfgoXIJLEFM6LqDKpN6VkZsgfMdHGTfIvNMqHdia2sQZ7a24/3x3lwOvffuX0IbTK1Gc1lhzAHw66z1SeivPebSQIY7Zpb6T2u4nRgKFQNSUj37abCduOWh2+zvXRDL1WyNIzJRCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711913829; c=relaxed/simple;
	bh=gHdlRdlt/ABFlwPOqowdAbKXf4xGUngo3sp81YkMpCA=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GOLJOfPm4vI05yDeyZMNy+zz14OV1hJp4Grlmm+XudX8n7774eB6XiRWQYw8WHZjm0vCNnInaX/xvDtNUqJ8z8+laIk7lB92d9xC9g5eyzqcGljm9ZJ/ANuKXUb3FhU+RYriANMXTmsu6C9uiCuUijb0Pr1Jg+8tpOycaI3thh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F/4CPmKA; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F/4CPmKA"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-33ddd1624beso2163913f8f.1
        for <bpf@vger.kernel.org>; Sun, 31 Mar 2024 12:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711913826; x=1712518626; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5/mTsUGCckh6ZVyWzbdkp99lB6BYn+WoiGmpAdkvTeQ=;
        b=F/4CPmKAzauG8n4n9WptYDRhu/bz+u5Ntycpvc1/22gfJn6cf7I9J9ODqMn0CEj1WU
         XDPwyD4mSU4KmI1PE3g3SHbenMAxkOMZwXQd+IIwbzADTg2N8aPOjc9wWC/pOs5ml9Fv
         RcPaLa6EKIc26MmbA90p2t48JwkWsCWeaNLEpIxD9f+WCWlr5PLQHeIJSs1aUAw50+Li
         fGmoyMY/aUyG1kyXVzjrPhY6RPK8y0A7IFmm3EBnhNz8gUse0zwnRZwQilmYyU44Nnhk
         9yaY1+R2L5Cjxoun4uTOIOMgG3w2RTH5ngBoOJd2vU0qfFuKEdkqUqVphIOrKKt8rZdQ
         GJUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711913826; x=1712518626;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5/mTsUGCckh6ZVyWzbdkp99lB6BYn+WoiGmpAdkvTeQ=;
        b=fWvDMKu0gn0u5n3ZAZviuLw90ZKLdVg3pDCOhM4rEH+5+4oSvhUYjxzjxhHx/1Dp2n
         Acwi6UIWm8YbpZzlHSUnyotmnLxUQwMHcGpcET4ilfM+R4TwSNzQqjGEpvkyDBq27/3g
         2sn7VfRMkabTsu6OLv22jLVQHb6E4lwoS7/j36VJYIeQkcRC1cRSwwHEV5axmqo4Evxd
         nXIVkls8/ZMYLod4tiZqbYEyX7xH+YFwJM0Wp7Kn7tuT1TQlWxr6XCig1NrlH9UqsXh8
         3Ahl7AsESrScKLMYAV10Pe8O/XCK78uhk7k4eZJdK/qatGu35OD5tf6Ot/8qLXPUdI3q
         U03A==
X-Forwarded-Encrypted: i=1; AJvYcCUVobc/TRZCXwTCC2FXLU6sSMOGw2X3jqgqnLs845BLWA5fbHpF3/Spm6lnVUwmnoZn3pZpj6G54MtqvW2kmyxz0eUr
X-Gm-Message-State: AOJu0YzvEfA00Rqu3iTAF1BqpxGt8RlxkTxiN19GWMDhBF4HbAlv583M
	3iBDG7XyhwJ3rvANLYmyCUeR8JmMumNjRf3wZmnyNHZ5CrKjrPhB
X-Google-Smtp-Source: AGHT+IF0SGDs7Ubg0c8wujOEvYPhRxrmK4BBbx7cjhHb7hzDay7VPZ38ZT3kCh3h8o2/WZ6HIEA2mQ==
X-Received: by 2002:a5d:4583:0:b0:343:35b5:240 with SMTP id p3-20020a5d4583000000b0034335b50240mr6322747wrq.29.1711913825799;
        Sun, 31 Mar 2024 12:37:05 -0700 (PDT)
Received: from krava ([83.240.62.118])
        by smtp.gmail.com with ESMTPSA id fs11-20020a05600c3f8b00b004146dd6bfe2sm12392687wmb.47.2024.03.31.12.37.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Mar 2024 12:37:05 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sun, 31 Mar 2024 21:37:03 +0200
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org
Subject: Re: [PATCH bpf-next 2/3] selftests/bpf: Add uretprobe syscall test
 for regs integrity
Message-ID: <Zgm7X1_3iRewLNQQ@krava>
References: <20240327102036.543283-1-jolsa@kernel.org>
 <20240327102036.543283-3-jolsa@kernel.org>
 <CAEf4BzZps+OdPoyRz1=7mEzh=shjVjT=ZznhMD0Y-w98GW782g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzZps+OdPoyRz1=7mEzh=shjVjT=ZznhMD0Y-w98GW782g@mail.gmail.com>

On Fri, Mar 29, 2024 at 03:30:11PM -0700, Andrii Nakryiko wrote:
> On Wed, Mar 27, 2024 at 3:21 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Add uretprobe syscall test that compares register values before
> > and after the uretprobe is hit. It also compares the register
> > values seen from attached bpf program.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  tools/include/linux/compiler.h                |   4 +
> >  .../selftests/bpf/prog_tests/uprobe_syscall.c | 163 ++++++++++++++++++
> >  .../selftests/bpf/progs/uprobe_syscall.c      |  15 ++
> >  3 files changed, 182 insertions(+)
> >  create mode 100644 tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> >  create mode 100644 tools/testing/selftests/bpf/progs/uprobe_syscall.c
> 
> [...]
> 
> > +__naked unsigned long uprobe_syscall_arch_test(void)
> > +{
> > +       asm volatile (
> > +               "movq $0xdeadbeef, %rax\n"
> > +               "ret\n"
> > +       );
> > +}
> > +
> > +__naked void uprobe_syscall_arch(struct pt_regs *before, struct pt_regs *after)
> 
> don't you get compiler warnings for using __naked with explicit
> function arguments?

nope, both gcc and clang are silent

> 
> > +{
> > +       asm volatile (
> > +               "movq %r15,   0(%rdi)\n"
> > +               "movq %r14,   8(%rdi)\n"
> 
> [...]
> 
> > +       err = uprobe_syscall__attach(skel);
> > +       if (!ASSERT_OK(err, "uprobe_syscall__attach"))
> > +               goto cleanup;
> > +
> > +       uprobe_syscall_arch(&before, &after);
> 
> uprobe_syscall_arch() doesn't really do an explicit `syscall
> uretprobe`, it should work for int3-based uretprobes as well? Let's
> call it something a bit more generic then?

ok, how about

  uprobe_syscall_arch -> uretprobe_regs
  uprobe_syscall_arch_test -> uretprobe_regs_trigger

> 
> Also, I think patch #1 will go through Masami's trace tree, right? But
> we can land selftests into bpf-next even before that, given they
> should work for both syscall and interrupt based uretprobes.

hm, not sure.. I did not originally cc Masami/Steven :-\  adding now

Masami, could patch 1 go through:

  https://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
  probes/for-next

thanks,
jirka
