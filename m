Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709CD39FE9
	for <bpf@vger.kernel.org>; Tue, 19 Mar 2024 19:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710876721; cv=none; b=hlaHVy8O//UVCIXXNVdOKGvh9Z2OGneBlzyJcx6gTPxlLEqeMcDr3bOSON7ok7999eZReOpTwvsWL7JAzIl3HA/URBvfAGpdbPqRFv0Z+T1B0KweUxjj20MCeRem7iLVTdLVaLkZ3vsGYIsP3908IyZ4Chpb53AS6GdNRYE7BQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710876721; c=relaxed/simple;
	bh=wH7tpr3RimBNELsm1EX+IclcVIWHWr0ySDyDkm2JTrg=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FmCIOBl+nPPqdPNrZBXY4trVW7ARHNFgbBfknq9aEm3Y60RJ3JOq7IDxYfMf69LHIZxDkKyqHgVryFD70OPtfZ932AyvJeA0sloqIiHu7qbmJdYerGMw0qYkoejXW3t6vSHKSLvxEMOiMZzaLI+lpDLikELErvBuwoKoSadl4vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gg2/f+AL; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gg2/f+AL"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a44f2d894b7so710575866b.1
        for <bpf@vger.kernel.org>; Tue, 19 Mar 2024 12:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710876718; x=1711481518; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=s0NpchFYyzEXJ+eqB3eo7/ra5EkntoEDOBdlZF9R/v4=;
        b=gg2/f+ALzcgSfgkUl27dkNyGSg5pkxAvzBxCOD5QLYEY7QVtyqU0hDC/5jdJUxpso0
         MJwlqFcxsQhOYjYF8U64V8UDZtH5GnuBluoFkhoiqAgVkiFlb8YxUy9+Fa++R+HxvkrO
         D1IOabOa0wwZqT8Wtt5xN3y2+Jq/RKrxS1UtDuuDvwTuvPIb8nyR4RyhdwYQJ4EdRFDc
         gVqoD92lMWHQkdNsFVj7yhLB10/0HmN2RHxJzIM2PhQyYmrpPmTy45KG8OhA9USsnvxl
         KDFmz12gIRCwwxg12kdZceN+AkCjbXFeYNuMLN1yTVctYMvuC7hxgb2ruQpbKFjR/o2P
         ClKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710876718; x=1711481518;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s0NpchFYyzEXJ+eqB3eo7/ra5EkntoEDOBdlZF9R/v4=;
        b=AvFvsWUy04XXlOA7/oXB25msqymWd4iO1JkXGNHi5HHKEBUYMJiPye77TfqR0lboKe
         aneBv3wl+TSu3ctAhLMP7dkGRUarwGEMdA53J/bicpCWrne4WfGQSLJJRQrZjOCYObTn
         606jD9USq9c/de5+8n4+IcrIZ7dHIZkVomsqah+CN4LnKZD5VEbRBpnPtKp9vV27OFO4
         T+GZOsVxAJZaTBF1EuYfpSpQPo6VfEOXSeJxZyBla0rE9P6iwsy5Ac8zYuWiuZCNa/7S
         jPwHqsDGadB95SDxo2AjpRaE+p+VM1vKjEIQl/XYJhSEnG3YsO+z2GcPC/beAYjwXHLR
         R4Mw==
X-Forwarded-Encrypted: i=1; AJvYcCWD8uuKyTSGPyQoU5l/ozwvHkpdrnftnlXZsiHLIWai/JMm+xW+oZPbNuczzejfkqzCo3Xx7KZFpYg81VToNcPUqXfc
X-Gm-Message-State: AOJu0YzsYEa8AQC55/NcpHXYohcxALoYR/SQ0DgDIQMOoEopJ2ocxkrR
	lTawl6YjYbmcoxXP6aqMqzLJLmyrgPDwDCYkKk0trFwJ75RIVtMB
X-Google-Smtp-Source: AGHT+IET2xUa9HYGV4S3HfDMO2Oy39SeyHPI/VuLg48JxF3KkUxCqt9I5yihkgSiPqdMDLNHa+cvMw==
X-Received: by 2002:a17:907:a092:b0:a46:4d76:106b with SMTP id hu18-20020a170907a09200b00a464d76106bmr14459185ejc.34.1710876717417;
        Tue, 19 Mar 2024 12:31:57 -0700 (PDT)
Received: from krava ([83.240.63.214])
        by smtp.gmail.com with ESMTPSA id xe2-20020a170907318200b00a46b10861acsm3483084ejb.208.2024.03.19.12.31.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 12:31:57 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 19 Mar 2024 20:31:55 +0100
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org
Subject: Re: [PATCH RFC bpf-next 4/3] uprobe: ensure sys_uretprobe uses sysret
Message-ID: <ZfnoK8aQDJMgOYfY@krava>
References: <20240318093139.293497-1-jolsa@kernel.org>
 <20240319102523.GC20287@redhat.com>
 <ZflyM5U67c47i4Oo@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZflyM5U67c47i4Oo@krava>

On Tue, Mar 19, 2024 at 12:08:35PM +0100, Jiri Olsa wrote:
> On Tue, Mar 19, 2024 at 11:25:24AM +0100, Oleg Nesterov wrote:
> > Obviously not for inclusion yet ;) untested, lacks the comments, and I am not
> > sure it makes sense.
> > 
> > But I am wondering if this change can speedup uretprobes a bit more. Any chance
> > you can test it?
> > 
> > With 1/3 sys_uretprobe() changes regs->r11/cx, this is correct but implies iret.
> > See the /* SYSRET requires RCX == RIP and R11 == EFLAGS */ code in do_syscall_64().
> 
> nice idea, looks like sysexit should be faster
> 
> > 
> > With this patch uretprobe_syscall_entry restores rcx/r11 itself and does retq,
> > sys_uretprobe() needs to hijack regs->ip after uprobe_handle_trampoline() to
> > make it possible.
> > 
> > Comments?
> > 
> > Oleg.
> > ---
> > 
> > diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
> > index 069371e86180..b99f1d80a8c8 100644
> > --- a/arch/x86/kernel/uprobes.c
> > +++ b/arch/x86/kernel/uprobes.c
> > @@ -319,6 +319,9 @@ asm (
> >  	"pushq %r11\n"
> >  	"movq $462, %rax\n"
> >  	"syscall\n"
> > +	"popq %r11\n"
> > +	"popq %rcx\n"
> > +	"retq\n"
> 
> using rax space on stack for return pointer, cool :)
> 
> I'll run the test with this change

I got bigger speed up on intel, amd stays the same (I'll double check that)

current:
  base           :   16.133 ± 0.035M/s
  uprobe-nop     :    3.003 ± 0.002M/s
  uprobe-push    :    2.829 ± 0.001M/s
  uprobe-ret     :    1.101 ± 0.001M/s
  uretprobe-nop  :    1.485 ± 0.001M/s
  uretprobe-push :    1.447 ± 0.000M/s
  uretprobe-ret  :    0.812 ± 0.000M/s

fix:
  base           :   16.522 ± 0.103M/s
  uprobe-nop     :    2.920 ± 0.034M/s
  uprobe-push    :    2.749 ± 0.047M/s
  uprobe-ret     :    1.094 ± 0.003M/s
  uretprobe-nop  :    2.004 ± 0.006M/s  < ~34% speed up
  uretprobe-push :    1.940 ± 0.003M/s  < ~34% speed up
  uretprobe-ret  :    0.921 ± 0.050M/s  < ~13% speed up

original fix:
  base           :   15.704 ± 0.076M/s
  uprobe-nop     :    2.841 ± 0.008M/s
  uprobe-push    :    2.666 ± 0.029M/s
  uprobe-ret     :    1.037 ± 0.008M/s
  uretprobe-nop  :    1.718 ± 0.010M/s  < ~25% speed up
  uretprobe-push :    1.658 ± 0.008M/s  < ~23% speed up
  uretprobe-ret  :    0.853 ± 0.004M/s  < ~14% speed up


jirka
