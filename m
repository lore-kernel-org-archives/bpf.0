Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4DB27F017
	for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 16:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768925833; cv=none; b=XMX5ou0/F1MsaYblyjdoLdH6joUUxr30/zK3K0ZxRSj6gwQuQG4HO0FBrdrXjY/azccL0y8GsJRMckRPQH7MPcztTjdxG5xDlKNA+BrGnuGO5D7L2YgNOh0yrIP7C+9aiyz7gTA/p8gCgGBjTClWgwAn4MgG/NO+lK68iqCiPoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768925833; c=relaxed/simple;
	bh=PmOIAqTODMTgWMF8/2juxnklYND8v64jg8vnxapTPvs=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DkzZmMcduzo5K0JxSvKMc8dzJi6ZXk4v6tEW4LeX/QLqu/9CvbWfbvMDSaLjq/WIBNsQj7MMs11aRDklCSgDxqiwK0pWovKFWTufTvj0SKbKuCoaO6hTPrQ8ddyVs1U6kV4PWiUIU1dMxG5GOVv1CM7rI7uXiUT5u9WON9Lwd70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XOObbfQQ; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XOObbfQQ"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4801bbbdb4aso28901325e9.1
        for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 08:17:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768925830; x=1769530630; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=koUhaSfBzYpa7sLxEUiUMYtFrPSfWsUlovv+DUvky20=;
        b=XOObbfQQWQ486VC8bUZF3ob+RE0qCgmayOfE7Bp5vAyS7o9HWBaaUYHHUlo3XCd2hL
         wEzwRxz5X0doiIVZSuacoHi2jB8jhAJMgccLfgVUyXlyuz2zM4nm3Ak9mSlPmo3+iGQ+
         yKOPBkNS9oW/SE51VswH89/NO759YzasUoOV2QAhXCFKc81sOG4D/EJA1TisHZaFEjgf
         Yau3TjIN2tSOulZLk1dkfD8Gx7SMBR9aOACvvErIlwLIF6Nwm6ePOBKshZjQOoZo7pq8
         ylzPJq/5m3AwLD0ADjKDj6WF2qt3MuFjzyb1w5sYBYZOn2DgImMGpFO9OGoo4qDX717U
         jkog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768925830; x=1769530630;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=koUhaSfBzYpa7sLxEUiUMYtFrPSfWsUlovv+DUvky20=;
        b=fmx0AJmSl3wWaQv1fmdD7Fj/0n6ruG2ccOchtYqdscURJfMxi7B9IpZpfHHtqkbxUo
         o91Ek1sd+mFgt2jKHrrmeMXc1wCgMFhhbSV7Gg+FTStn/B2X8Q8JCCo8V0zlM+8nBLrN
         qverVM2evT1F/VxiO9fB36Ib5QzJsPnyzAZfP0CZ3IijtVDHrvvTwWVlyh4ve4ksm9Wl
         HROIP6/IT3NwTrlwOpIUwDT5T8DjF/5jA0OhlOvUpGw8+fHxMqINLxigLka5LeTE4twt
         VRu9V/8UzlpQmDwev0Tzo9IgdQorwoBu3W8Eb2cITaMs17IWEzNUnKpDAQ2dpvPXrTSZ
         b1BA==
X-Forwarded-Encrypted: i=1; AJvYcCVcFZqfzwin173Rwb5j+CC1pJIdgO5bCmum3180Mkz0aIQx5zRC2eGLkBn4SgiSclngyvI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywmy+0kaoxN5S7OpYu5N345LFKOkPWRl0nyv3GGkZweOzAULwDN
	beisIEoHVufDJlb/nI3HJOFT0Wh9kl++ECIF3vdOCsfaYAZGV8Y26wef
X-Gm-Gg: AY/fxX67UDIjCrb8/Fj7SH46b935/1FKjgTrAUQx9DSFRFOj6FaawGmkcUWhuFf5Ewj
	2RnqzakrZyBceyjzaf0saXtnBZLnNx+92qYLExGo9L/UNtY6An/OymKbPrrZqv5m7Pok6RHXxd8
	/7j+2uDVW6PfNqZUZAPF8E428EuL+TSy8J0COU1wufWi5GAmrPYzYZXehND8g380ciuT9Xo15Tp
	14BjwWv+z30qN/OLfh4xZ5/pkpRIFtwuVsScD0Gah6PAyVRoWlJ11mZRAMv/yZkLCntt8AMwvBu
	H+hE1gZshA2znnG6M7euchnWwJIGaQeL1p8NbcAX9IO38Q6wjOmwEaAxjBJ7UEKFCWN6g3LTKzs
	Q8KTKMPfH6xXoOdzU5mcGYGu6927PIvVGwqJpa3Z8ORrrgo4MynlMRnZyhZmw
X-Received: by 2002:a05:600c:314f:b0:479:13e9:3d64 with SMTP id 5b1f17b1804b1-4801e67c8ecmr190818375e9.15.1768925829948;
        Tue, 20 Jan 2026 08:17:09 -0800 (PST)
Received: from krava ([2a02:8308:a00c:e200::b44f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4801e9434d9sm116205165e9.0.2026.01.20.08.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 08:17:09 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 20 Jan 2026 17:17:08 +0100
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Mahe Tardy <mahe.tardy@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>, bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, x86@kernel.org,
	Yonghong Song <yhs@fb.com>, Song Liu <songliubraving@fb.com>,
	Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH bpf-next 2/4] x86/fgraph,bpf: Switch kprobe_multi program
 stack unwind to hw_regs path
Message-ID: <aW-qhJ2pige8aRl4@krava>
References: <20260112214940.1222115-1-jolsa@kernel.org>
 <20260112214940.1222115-3-jolsa@kernel.org>
 <20260112170757.4e41c0d8@gandalf.local.home>
 <aWYv6864cdO2PWbb@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aWYv6864cdO2PWbb@krava>

On Tue, Jan 13, 2026 at 12:43:39PM +0100, Jiri Olsa wrote:
> On Mon, Jan 12, 2026 at 05:07:57PM -0500, Steven Rostedt wrote:
> > On Mon, 12 Jan 2026 22:49:38 +0100
> > Jiri Olsa <jolsa@kernel.org> wrote:
> > 
> > > To recreate same stack setup for return probe as we have for entry
> > > probe, we set the instruction pointer to the attached function address,
> > > which gets us the same unwind setup and same stack trace.
> > > 
> > > With the fix, entry probe:
> > > 
> > >   # bpftrace -e 'kprobe:__x64_sys_newuname* { print(kstack)}'
> > >   Attaching 1 probe...
> > > 
> > >         __x64_sys_newuname+9
> > >         do_syscall_64+134
> > >         entry_SYSCALL_64_after_hwframe+118
> > > 
> > > return probe:
> > > 
> > >   # bpftrace -e 'kretprobe:__x64_sys_newuname* { print(kstack)}'
> > >   Attaching 1 probe...
> > > 
> > >         __x64_sys_newuname+4
> > >         do_syscall_64+134
> > >         entry_SYSCALL_64_after_hwframe+118
> > 
> > But is this really correct?
> > 
> > The stack trace of the return from __x86_sys_newuname is from offset "+4".
> > 
> > The stack trace from entry is offset "+9". Isn't it confusing that the
> > offset is likely not from the return portion of that function?
> 
> right, makes sense.. so standard kprobe actualy skips attached function
> (__x86_sys_newuname) on return probe stacktrace.. perhaps we should do
> the same for kprobe_multi
> 
> I managed to get that with the change below, but it's wrong wrt arch code,
> note the ftrace_regs_set_stack_pointer(fregs, stack + 8) .. will try to
> figure out better way when we agree on the solution
> 
> thanks,
> jirka
> 
> 
> ---
> diff --git a/arch/x86/include/asm/ftrace.h b/arch/x86/include/asm/ftrace.h
> index c56e1e63b893..b0e8ce4934e7 100644
> --- a/arch/x86/include/asm/ftrace.h
> +++ b/arch/x86/include/asm/ftrace.h
> @@ -71,6 +71,9 @@ arch_ftrace_get_regs(struct ftrace_regs *fregs)
>  #define ftrace_regs_set_instruction_pointer(fregs, _ip)	\
>  	do { arch_ftrace_regs(fregs)->regs.ip = (_ip); } while (0)
>  
> +#define ftrace_regs_set_stack_pointer(fregs, _sp)	\
> +	do { arch_ftrace_regs(fregs)->regs.sp = (_sp); } while (0)
> +
>  
>  static __always_inline unsigned long
>  ftrace_regs_get_return_address(struct ftrace_regs *fregs)
> diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
> index 6279e0a753cf..b1510c412dcb 100644
> --- a/kernel/trace/fgraph.c
> +++ b/kernel/trace/fgraph.c
> @@ -717,7 +717,8 @@ int function_graph_enter_regs(unsigned long ret, unsigned long func,
>  /* Retrieve a function return address to the trace stack on thread info.*/
>  static struct ftrace_ret_stack *
>  ftrace_pop_return_trace(struct ftrace_graph_ret *trace, unsigned long *ret,
> -			unsigned long frame_pointer, int *offset)
> +			unsigned long *stack, unsigned long frame_pointer,
> +			int *offset)
>  {
>  	struct ftrace_ret_stack *ret_stack;
>  
> @@ -762,6 +763,7 @@ ftrace_pop_return_trace(struct ftrace_graph_ret *trace, unsigned long *ret,
>  
>  	*offset += FGRAPH_FRAME_OFFSET;
>  	*ret = ret_stack->ret;
> +	*stack = (unsigned long) ret_stack->retp;
>  	trace->func = ret_stack->func;
>  	trace->overrun = atomic_read(&current->trace_overrun);
>  	trace->depth = current->curr_ret_depth;
> @@ -810,12 +812,13 @@ __ftrace_return_to_handler(struct ftrace_regs *fregs, unsigned long frame_pointe
>  	struct ftrace_ret_stack *ret_stack;
>  	struct ftrace_graph_ret trace;
>  	unsigned long bitmap;
> +	unsigned long stack;
>  	unsigned long ret;
>  	int offset;
>  	int bit;
>  	int i;
>  
> -	ret_stack = ftrace_pop_return_trace(&trace, &ret, frame_pointer, &offset);
> +	ret_stack = ftrace_pop_return_trace(&trace, &ret, &stack, frame_pointer, &offset);
>  
>  	if (unlikely(!ret_stack)) {
>  		ftrace_graph_stop();
> @@ -824,8 +827,11 @@ __ftrace_return_to_handler(struct ftrace_regs *fregs, unsigned long frame_pointe
>  		return (unsigned long)panic;
>  	}
>  
> -	if (fregs)
> -		ftrace_regs_set_instruction_pointer(fregs, trace.func);
> +	if (fregs) {
> +		ftrace_regs_set_instruction_pointer(fregs, ret);
> +		ftrace_regs_set_stack_pointer(fregs, stack + 8);

actually looks like this might be better solution.. storing the proper
rsp value directly to the regs in return_to_handler

jirka


---
diff --git a/arch/x86/kernel/ftrace_64.S b/arch/x86/kernel/ftrace_64.S
index a132608265f6..971883045b75 100644
--- a/arch/x86/kernel/ftrace_64.S
+++ b/arch/x86/kernel/ftrace_64.S
@@ -368,13 +368,16 @@ SYM_CODE_START(return_to_handler)
 	subq $8, %rsp
 	UNWIND_HINT_FUNC
 
+	movq %rsp, %rdi
+	addq $8, %rdi
+
 	/* Save ftrace_regs for function exit context  */
 	subq $(FRAME_SIZE), %rsp
 
 	movq %rax, RAX(%rsp)
 	movq %rdx, RDX(%rsp)
 	movq %rbp, RBP(%rsp)
-	movq %rsp, RSP(%rsp)
+	movq %rdi, RSP(%rsp)
 	movq %rsp, %rdi
 
 	call ftrace_return_to_handler
