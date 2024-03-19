Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878A37B3F6
	for <bpf@vger.kernel.org>; Tue, 19 Mar 2024 11:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710846521; cv=none; b=DGVdbEniWwCCCuf3P8mQqhjZEdRb2zMo6UFmrG0wqnAhUshOxfj4OMpTXD6qeyFG/57JUEhTNJ1Vb9oFr9e3GoOj5I38QuO3AW8NDtzv/nO+DfydCwrQhdDJGdUo+jxsE+m0vu4lx7EHeP9Vz81lseVTWovbfA17GK0sio0ao/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710846521; c=relaxed/simple;
	bh=Pn7YyemR6V93m6Y9epJlXlsUBH62juoZ6h1jCjy/qvs=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D3lmUuBRrTQAKcJOneF44WeJAxgrgTsaIKDhagwHiCpqbc0K+M+eJjS3SoJd7q0cypC3HQkp7mzUlm2TorURbvFN/3Fn7jIhj8Q5gb5MNOgN2/5XqJCUEAggolvI308fLj+3sCjbBHrgIoDePVFZGw1ryl6x3iRR1KeNwsPuuME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ebCHYWG9; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ebCHYWG9"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-56b93b45779so753061a12.1
        for <bpf@vger.kernel.org>; Tue, 19 Mar 2024 04:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710846518; x=1711451318; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4190Ua18Wn8FvNE3ZNw8DNUCDg0r5KBcCqm2cyOX0jg=;
        b=ebCHYWG9eaafwg6hg/bUCnfVpVGmO2DC0gbS/Hd0ttVv6cV36b2D/e77Uxxlv91hbk
         m76oqxdWx+dF3xdr4y5LlXUSN7c3lMkDNG/V1Rnz535eEszk5nJhsBq1USjBZvhpQGFO
         NgCCoJvwA/EGH3dFAS360xwLRsNonMOFdL1QVAg9z8waGlq656FtpaSRHYtaoTQGcaec
         KPESLg6e+0/ztlJJwpegbNCNfLhQfR80kBVTqiMiyPxWDUWbOiDcApTKEwqvDHUjpVm5
         UB/teaRcQdw8LRyT+mI0wJLGBwzA193eIzNSGaGXHKu+ta0uWAsYKF1RSchAx2ihRhZK
         CfVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710846518; x=1711451318;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4190Ua18Wn8FvNE3ZNw8DNUCDg0r5KBcCqm2cyOX0jg=;
        b=gw106GsJMcIxXCv4c7ftxyRHOZvK/9nWMtJImeqH1GumwNhpI1MaIohJnFIJpKxpnz
         WYjcMECu70D4yuie+rhrceqVGwrjIeCWybFrTZa0/GX8eCddWTbdtbGqjkqCkSFqOzIY
         pzzojFyW4uUUfEfBULyIUhDGoiPjzqe8XQcvPLzlAuOq2hAA8Cj5b2oR3k2+ydwKsOS/
         Hni/4MANppYJa8jPFASTD325l5r8xTKKTxEmDdW2Jq4qCc9i+ArelQkhRmd04ROzAlua
         t7WnoPUJQMfalVo9ozulMW36w7jwnDAlz+Cxc2OT1DGWIJgpv3kYP3lpkAJAHU7nRqYH
         cNKw==
X-Forwarded-Encrypted: i=1; AJvYcCVrpet+LKhfLDeGuF5KjfPySZ7LY3iiuDnaLus19HnkpUJcaCahB7ssosS70qRZFWqMz/VugVbb2ZygpvMUnB+NwNvk
X-Gm-Message-State: AOJu0Yzv/jM2hU2QdjnocWSck8IUeJQ4YF+mFq7lP4WYcm3MhhQvLGnd
	YBG+V+2Tn2vIBp5S3PYA8L3wN/iXIn2eXaGKuVD82xT1RJM6BMaM
X-Google-Smtp-Source: AGHT+IHa2c988NMoTcuJaMapzlk03CCtLfvWlK3X5V8+akHHYy8Fyl2b4/MmT5tOjGNCheAFeIsT8Q==
X-Received: by 2002:a05:6402:e9b:b0:568:2505:93b4 with SMTP id h27-20020a0564020e9b00b00568250593b4mr10738333eda.6.1710846517860;
        Tue, 19 Mar 2024 04:08:37 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id ek20-20020a056402371400b0056b9754fa1fsm543918edb.60.2024.03.19.04.08.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 04:08:37 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 19 Mar 2024 12:08:35 +0100
To: Oleg Nesterov <oleg@redhat.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org
Subject: Re: [PATCH RFC bpf-next 4/3] uprobe: ensure sys_uretprobe uses sysret
Message-ID: <ZflyM5U67c47i4Oo@krava>
References: <20240318093139.293497-1-jolsa@kernel.org>
 <20240319102523.GC20287@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240319102523.GC20287@redhat.com>

On Tue, Mar 19, 2024 at 11:25:24AM +0100, Oleg Nesterov wrote:
> Obviously not for inclusion yet ;) untested, lacks the comments, and I am not
> sure it makes sense.
> 
> But I am wondering if this change can speedup uretprobes a bit more. Any chance
> you can test it?
> 
> With 1/3 sys_uretprobe() changes regs->r11/cx, this is correct but implies iret.
> See the /* SYSRET requires RCX == RIP and R11 == EFLAGS */ code in do_syscall_64().

nice idea, looks like sysexit should be faster

> 
> With this patch uretprobe_syscall_entry restores rcx/r11 itself and does retq,
> sys_uretprobe() needs to hijack regs->ip after uprobe_handle_trampoline() to
> make it possible.
> 
> Comments?
> 
> Oleg.
> ---
> 
> diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
> index 069371e86180..b99f1d80a8c8 100644
> --- a/arch/x86/kernel/uprobes.c
> +++ b/arch/x86/kernel/uprobes.c
> @@ -319,6 +319,9 @@ asm (
>  	"pushq %r11\n"
>  	"movq $462, %rax\n"
>  	"syscall\n"
> +	"popq %r11\n"
> +	"popq %rcx\n"
> +	"retq\n"

using rax space on stack for return pointer, cool :)

I'll run the test with this change

thanks,
jirka

>  	".global uretprobe_syscall_end\n"
>  	"uretprobe_syscall_end:\n"
>  	".popsection\n"
> @@ -336,23 +339,20 @@ void *arch_uprobe_trampoline(unsigned long *psize)
>  SYSCALL_DEFINE0(uretprobe)
>  {
>  	struct pt_regs *regs = task_pt_regs(current);
> -	unsigned long sregs[3], err;
> +	unsigned long __user *ax_and_ret = (unsigned long __user *)regs->sp + 2;
> +	unsigned long ip, err;
>  
> -	/*
> -	 * We set rax and syscall itself changes rcx and r11, so the syscall
> -	 * trampoline saves their original values on stack. We need to read
> -	 * them and set original register values and fix the rsp pointer back.
> -	 */
> -	err = copy_from_user((void *) &sregs, (void *) regs->sp, sizeof(sregs));
> -	WARN_ON_ONCE(err);
> -
> -	regs->r11 = sregs[0];
> -	regs->cx = sregs[1];
> -	regs->ax = sregs[2];
> +	ip = regs->ip;
>  	regs->orig_ax = -1;
> -	regs->sp += sizeof(sregs);
> +	err = get_user(regs->ax, ax_and_ret);
> +	WARN_ON_ONCE(err);
>  
>  	uprobe_handle_trampoline(regs);
> +
> +	err = put_user(regs->ip, ax_and_ret);
> +	WARN_ON_ONCE(err);
> +	regs->ip = ip;
> +
>  	return regs->ax;
>  }
>  
> 
