Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7255474B
	for <bpf@vger.kernel.org>; Tue, 19 Mar 2024 10:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710845653; cv=none; b=TQGJl7sdt1z3g9ereYf6DPClIL/fmXWBKR6E+vZQrUH74J6DxGRGhky4dDp83EtidB4P7Qt9v7rkZ5V9E3XgzTylKTijjoyWkEt1NkSGiu6p1ls4drFdPj/vyExeIplZx5KjMVEdvhc/uv+c7e0txJv6RI4cdMadiR8tH42VS5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710845653; c=relaxed/simple;
	bh=XJu/01VFRk9BC4SkI1UWQGCgULm3X+i+h17yWa7OBjU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tXsaEYLJ84rQa1shh5hE2UwBvcXKZejdDUzA/FUZqXkIUsBS9I2Ph+vQz0lEhFuh4N+a7ptWV3CAteA8op7zjw3qOu9Dwz1j9jHmAb1b8Qlk1AMYoeKc7I4AcieOfJ53PEjDartLfsA2RtP1QAxj61F7YTxuQXwuKR1Czg7qLaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SOtt3u3g; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SOtt3u3g"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-56ba0b131dcso23680a12.0
        for <bpf@vger.kernel.org>; Tue, 19 Mar 2024 03:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710845650; x=1711450450; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W15XmJE1dBNccw4wu555ks2EY6Hc8C54XgWhRVvoU2Y=;
        b=SOtt3u3g4Yc+rq7pTvpv7Vkl6cXT/hk/Snzc5MFoJ/y7hBw0BqQwvHw63RnVSm47u9
         Wim34HtlYB9D1jRa57mcy4j5leIm981epzKiBgRT0jFcD6BeRt0DoN8oA87sFo8xokWc
         WewUi4gSDPFSx8WbI69+y1Fi88mGO3cr3MWC3kjk5b1L1oAbezl26KgubQgU67MYUSbu
         0jbx6oHQ+5ljdXCM4yL96sSg7eH4GxvChRIv6La6ejM9OfGVLJsmP9BH4+vJ0oQLIoT5
         g5Rp2SCFEy9LFaU5qNIJNvbP6g1IYRAeInC+K+XEN0u5wYO9p+dHQz0kaWoBmvfDUzYg
         jMvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710845650; x=1711450450;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W15XmJE1dBNccw4wu555ks2EY6Hc8C54XgWhRVvoU2Y=;
        b=vKmdy5OD4b6uWWT04FNCRjoaOlRvxESTkKulWiL90wz+XqhwM8PAijQedp6vwNzUtV
         maYi5LDP4wfCJRpCFKqg7GrXomkSFQgLCdekX1eMlzh2DzqCNZyj9+wcfBoSP/UXshCW
         tQndlHtbrIa+KMUg2z/mzYq2EQVQiWaiPIukgcUmb6048fADqsOb9jlt9n7wPV8MUdCC
         EY8lGJM7AYj84PQbDTfbzgDR40+qjwbphJeBQhZkjl07p/GIJ81SqBBN+6bmPk8LvcfM
         Unil1cxrKpMOqqsSOR4z1xCUAMOEMuw8Fj4An+7iSFIJSrrPFM+1CBm085iAZ32uaukJ
         ZKTw==
X-Forwarded-Encrypted: i=1; AJvYcCUqjgSilIKwO+19Bnd3e1OoYbxMD6H7hK5MSwldERCSKUrwCQxj1sIY5rS0lBM143dfp7Y2/Z6CC2cnXGvqnAKvdpgl
X-Gm-Message-State: AOJu0YyGhqlqKBbDm7rYWyd65q+mh0sqN0b7isOrcnHSWVXBApeMZ+D4
	bKiRFuFz1jaQoJVAB5hV8zZSrfsO17OXBoK3gK6DbblB/7e4L18FfxTJH7Aw
X-Google-Smtp-Source: AGHT+IFQi9qwIZN58eidZ8jaHAkp4pW6v6+JcqwfxjSKQG6+UXSpFqJd2ok2poEMLy1AwATq1l0GuQ==
X-Received: by 2002:a17:906:6545:b0:a45:2e21:c78c with SMTP id u5-20020a170906654500b00a452e21c78cmr10186076ejn.13.1710845650043;
        Tue, 19 Mar 2024 03:54:10 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id dk16-20020a170907941000b00a469f043d7fsm4068748ejc.41.2024.03.19.03.54.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 03:54:09 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 19 Mar 2024 11:54:07 +0100
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org
Subject: Re: [PATCH RFC bpf-next 1/3] uprobe: Add uretprobe syscall to speed
 up return probe
Message-ID: <Zfluzw6m42F3BCr7@krava>
References: <20240318093139.293497-1-jolsa@kernel.org>
 <20240318093139.293497-2-jolsa@kernel.org>
 <CAEf4BzaKDz-2Tavkb+Uu3zugZHcfVLqO-09F=bEJkWFre747eg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzaKDz-2Tavkb+Uu3zugZHcfVLqO-09F=bEJkWFre747eg@mail.gmail.com>

On Mon, Mar 18, 2024 at 06:11:06PM -0700, Andrii Nakryiko wrote:

SNIP

> > diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
> > index 7e8d46f4147f..af0a33ab06ee 100644
> > --- a/arch/x86/entry/syscalls/syscall_64.tbl
> > +++ b/arch/x86/entry/syscalls/syscall_64.tbl
> > @@ -383,6 +383,7 @@
> >  459    common  lsm_get_self_attr       sys_lsm_get_self_attr
> >  460    common  lsm_set_self_attr       sys_lsm_set_self_attr
> >  461    common  lsm_list_modules        sys_lsm_list_modules
> > +462    64      uretprobe               sys_uretprobe
> >
> >  #
> >  # Due to a historical design error, certain syscalls are numbered differently
> > diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
> > index 6c07f6daaa22..069371e86180 100644
> > --- a/arch/x86/kernel/uprobes.c
> > +++ b/arch/x86/kernel/uprobes.c
> > @@ -12,6 +12,7 @@
> >  #include <linux/ptrace.h>
> >  #include <linux/uprobes.h>
> >  #include <linux/uaccess.h>
> > +#include <linux/syscalls.h>
> >
> >  #include <linux/kdebug.h>
> >  #include <asm/processor.h>
> > @@ -308,6 +309,53 @@ static int uprobe_init_insn(struct arch_uprobe *auprobe, struct insn *insn, bool
> >  }
> >
> >  #ifdef CONFIG_X86_64
> > +
> > +asm (
> > +       ".pushsection .rodata\n"
> > +       ".global uretprobe_syscall_entry\n"
> > +       "uretprobe_syscall_entry:\n"
> > +       "pushq %rax\n"
> > +       "pushq %rcx\n"
> > +       "pushq %r11\n"
> > +       "movq $462, %rax\n"
> 
> nit: is it possible to avoid hardcoding 462 here? Can we use
> __NR_uretprobe instead?

yep, will do that

> 
> > +       "syscall\n"
> 
> oh, btw, do we need to save flags register as well or it's handled
> somehow? I think according to manual syscall instruction does
> something to rflags register. So do we need pushfq before syscall?

it's saved and restored by syscall instruction.. but apart from RF
flag as Oleg mentioned, it looks like we don't need to care about
that one

> 
> > +       ".global uretprobe_syscall_end\n"
> > +       "uretprobe_syscall_end:\n"
> > +       ".popsection\n"
> > +);
> > +
> > +extern u8 uretprobe_syscall_entry[];
> > +extern u8 uretprobe_syscall_end[];
> > +
> > +void *arch_uprobe_trampoline(unsigned long *psize)
> > +{
> > +       *psize = uretprobe_syscall_end - uretprobe_syscall_entry;
> > +       return uretprobe_syscall_entry;
> > +}
> > +
> > +SYSCALL_DEFINE0(uretprobe)
> > +{
> > +       struct pt_regs *regs = task_pt_regs(current);
> > +       unsigned long sregs[3], err;
> > +
> > +       /*
> > +        * We set rax and syscall itself changes rcx and r11, so the syscall
> > +        * trampoline saves their original values on stack. We need to read
> > +        * them and set original register values and fix the rsp pointer back.
> > +        */
> > +       err = copy_from_user((void *) &sregs, (void *) regs->sp, sizeof(sregs));
> > +       WARN_ON_ONCE(err);
> > +
> > +       regs->r11 = sregs[0];
> > +       regs->cx = sregs[1];
> > +       regs->ax = sregs[2];
> > +       regs->orig_ax = -1;
> > +       regs->sp += sizeof(sregs);
> > +
> > +       uprobe_handle_trampoline(regs);
> 
> probably worth leaving a comment that uprobe_handle_trampoline() is
> rewriting userspace RIP and so syscall "returns" to the original
> caller.
> 
> > +       return regs->ax;
> 
> and this is making sure that caller function gets the correct function
> return value, right? It's all a bit magical, so worth leaving a
> comment here, IMO.

ok will add more comments about that

thanks,
jirka
