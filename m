Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA7B1353EF
	for <bpf@vger.kernel.org>; Thu, 21 Mar 2024 20:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711052980; cv=none; b=mbAHxBEyFaBrDhT/kiQSpAEbRe8pf3hyG3obW/FH/Hut1l2dlhwQ2x7uVdQEVQHw5lAggzzbh9uVI/OLa2sHNkay2gwiHGA2K/bYG5YYptapJ1vzsvcT5hZb8jAFZLI3H4fWVJd1lrI4oV6Ehp2RB1NBzCqE/o0z2SyO2bqov1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711052980; c=relaxed/simple;
	bh=gwDBAHYYWX9SNJSwULPzaIm0vAlBKMveSnnp8rl7DUI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=By3T+WyTfjOcWyU9VCW0BTaDMnEGgnhjVcXUbyRungnB6N+P185ozgxrktRd2fE4RfGQTxjvGUF0M4M98NaYBpkrRVRe2xVegaUTzM08METf842TK0VRiub1Oy8GTVpBqEwp76lrGcUVm835StRc+M4d15KZKkA3MrGoqd6oRPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f5F18Nyh; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f5F18Nyh"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-513e6777af4so2706154e87.2
        for <bpf@vger.kernel.org>; Thu, 21 Mar 2024 13:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711052977; x=1711657777; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=re6OeXVcPAPnx+5iSvYCXlk2y/eQ+Oi4QWORv9hyX7g=;
        b=f5F18Nyh9o3MtrRfgInvt2VdbQIwQkVMTcIyfD3VXJ6A3eHtM3Fzyt9KsXtBnnZG5q
         S8wO8MC2+vI3F8bP/oJ6RYojvWvsi3Cz0TpwXg3fmysyZdrrIa1bykS2tQ/e4pZ4EnGm
         zpXQda3TWC0IvqhZycUEWx/eDn9Jk9fKfwqLfmYXX51G1bGuW/r53gwEVLISLnudoqVv
         m4ZjLyWsWVO2E0C75tJc//spfXi7NmMxeQ9wbF8yzl3lwXLPBJV98ubHwkquiSXXJEUY
         ljJqCJvuTzPu1kCP8iE7f7D1K1PxIIGTIE85pQZaMSmBI4Y7t8K/yzZdwBMAhIt3F6Oc
         QUdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711052977; x=1711657777;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=re6OeXVcPAPnx+5iSvYCXlk2y/eQ+Oi4QWORv9hyX7g=;
        b=k74op1Mejuy4iheVsNs+TOl+fDJ2y4t31VCmDXo3LGPR3TfV1ljZ0VoeA2KXgtxPhb
         DrMyw6Vl8ivVuXY10pUCfxd6CZLpxLmORVHRYSYW2jl6OXtzdDdH4JhUzJWWQZikfN9l
         4c1nnDupFa4Oa3mI6MmhEcHsiUq7pmk27Q9j+kKKBL4LFcK2ykAHhOyniYUjheYNn6m+
         4FPE05r2eCQcimkMCLXZtaOnKvy5NVIsV5Om2fTBVw2icR1wKqMNwsp5DIXcAVBZoRRQ
         HfPDTcPAzB+hLIxeQDDXykJmvuy2kBL1ptmdGPU7roflyaGWga7Ki1rp5j+CKQpgyYSI
         iIpA==
X-Forwarded-Encrypted: i=1; AJvYcCVOGbn2XUvNl8VBkSf+Q3qBO5R6Ihp/ZkSeODg5EwVLVdmID7odWnRdDwgWb84wdQX4pYn9Ju6R06aR1u1VGjNj8adi
X-Gm-Message-State: AOJu0YxP+3FsbRP/6gnQ29//qWdYoUiw3Iqu97SGVfOamSTlFW1s8CSh
	MOK9W/jTMonV7DAzywxTRHL8GjaNZyH+/v5dH19kLJGe2eMD2roM
X-Google-Smtp-Source: AGHT+IFzxh7T8wZtB6+QBVnKNbVHin96BCKz2rYnGJmdrvhSudOTTglSE0HJ7zxq0veqHX9jyT8C1g==
X-Received: by 2002:a19:ca43:0:b0:513:cfaa:e618 with SMTP id h3-20020a19ca43000000b00513cfaae618mr404304lfj.0.1711052976526;
        Thu, 21 Mar 2024 13:29:36 -0700 (PDT)
Received: from krava ([83.240.62.66])
        by smtp.gmail.com with ESMTPSA id mf20-20020a170906cb9400b00a46e56c8764sm277906ejb.114.2024.03.21.13.29.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 13:29:36 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 21 Mar 2024 21:29:34 +0100
To: Oleg Nesterov <oleg@redhat.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org
Subject: Re: [PATCH RFC bpf-next 4/3] uprobe: ensure sys_uretprobe uses sysret
Message-ID: <ZfyYriG3ttxbkpix@krava>
References: <20240319102523.GC20287@redhat.com>
 <ZflyM5U67c47i4Oo@krava>
 <ZfnoK8aQDJMgOYfY@krava>
 <ZfrC0NZWxmWBuUIe@krava>
 <20240320143739.GA32579@redhat.com>
 <20240320152848.GA7613@redhat.com>
 <ZfwFBgfdHUzQBdxS@krava>
 <20240321101750.GB14646@redhat.com>
 <ZfwRbf0FMHVizZAC@krava>
 <20240321121456.GC14646@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240321121456.GC14646@redhat.com>

On Thu, Mar 21, 2024 at 01:14:56PM +0100, Oleg Nesterov wrote:
> On 03/21, Jiri Olsa wrote:
> >
> > On Thu, Mar 21, 2024 at 11:17:51AM +0100, Oleg Nesterov wrote:
> > > On 03/21, Jiri Olsa wrote:
> > > >
> > > > On Wed, Mar 20, 2024 at 04:28:48PM +0100, Oleg Nesterov wrote:
> > > >
> > > > SNIP
> > > >
> > > > > 	SYSCALL_DEFINE0(uretprobe)
> > > > > 	{
> > > > > 		struct pt_regs *regs = task_pt_regs(current);
> > > > > 		unsigned long err, ip, sp, r11_cx_ax[3];
> > > > >
> > > > > 		err = copy_from_user(r11_cx_ax, (void __user*)regs->sp, sizeof(r11_cx_ax));
> > > > > 		WARN_ON_ONCE(err);
> > > > >
> > > > > 		// Q1: apart from ax, do we really care?
> > > > > 		// expose the "right" values of r11/cx/ax/sp to uprobe_consumer's
> > > > > 		regs->r11 = r11_cx_ax[0];
> > > > > 		regs->cx  = r11_cx_ax[1];
> > > > > 		regs->ax  = r11_cx_ax[2];
> > > > > 		regs->sp += sizeof(r11_cx_ax);
> > > > > 		regs->orig_ax = -1;
> > > > >
> > > > > 		ip = regs->ip;
> > > > > 		sp = regs->sp;
> > > > >
> > > > > 		uprobe_handle_trampoline(regs);
> > > > >
> > > > > 		// Q2: is it possible? do we care?
> > > > > 		// uprobe_consumer has changed sp, we can do nothing,
> > > > > 		// just return via iret.
> > > > > 		if (regs->sp != sp)
> > > > > 			return regs->ax;
> > > > > 		regs->sp -= sizeof(r11_cx_ax);
> > > > >
> > > > > 		// Q3: is it possible? do we care?
> > > > > 		// for the case uprobe_consumer has changed r11/cx
> > > > > 		r11_cx_ax[0] = regs->r11;
> > > > > 		r11_cx_ax[1] = regs->cx;
> > > >
> > > > I wonder we could add test for this as well, and check we return
> > > > proper register values in case the consuer changed them, will check
> > > >
> > > > >
> > > > > 		// comment to explain this hack
> > > > > 		r11_cx_ax[2] = regs->ip;
> > > > > 		regs->ip = ip;
> > > >
> > > > we still need restore regs->ip in case do_syscall_64 decides to do
> > > > iret for some reason, right?
> > >
> > > I don't understand... could you spell?
> >
> > I was wondering why to restore regs->ip for sysret path, but do_syscall_64
> > can decide to do iret return (for which we need proper regs->ip) even if we
> > prepare cx/r11 registers for sysexit
> 
> Still don't understand... Yes, we prepare cx/r11 to avoid iret if possible.
> But (apart from performance) we do not care if do_syscall_64() picks iret.
> Either way
> 
> 			regs->ip = ip;
> 
> above ensures that usermode returns to uretprobe_syscall_entry right after
> the syscall insn. 

hm, I think above ensures that do_syscall_64 will skip the 'regs->cx != regs->ip'
check.. and after the sysret returns to rcx register value and ignores regs->ip

but in any case we need to set it

> ... Then popq %r11/cx will restore r11/cx even if they were
> changed by uprobe_consumer's. And then "retq" will return to the address
> "returned" by handle_trampoline(regs) because we do
> 
> 			// comment to explain this hack
> 			r11_cx_ax[2] = regs->ip;
> 
> after handle_trampoline(). This all doesn't depend on iret-or-sysret.
> 
> OK, I am sure you understand this, so I guess I misunderstood your concerns.

thanks for the patience ;-)

jirka
