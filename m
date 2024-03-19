Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8DD739FE0
	for <bpf@vger.kernel.org>; Tue, 19 Mar 2024 19:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710876929; cv=none; b=hkmKPIbawNTufRsZKLn5B17kw2bPy4WEyeo5D1jwP5KjOZ238puQ5shdp4SGlwOJgz/Tkx0TrzB4d7oi5tRPBcJIqM2LhgEutnNfub8zKIFI0Yp+LpgLgQt9KkLd0rwbYxWXMnzmZygFYifVzkFVksAF9mFd2l8dQ2Mqz6+LW1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710876929; c=relaxed/simple;
	bh=g/JWKrNSxwS2IVK7J7sDhUFZW3YqGPpOYI5msa16GB0=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mAMG5FeYMf5mqLEF/uEm1kZ3ZZkvxFmBlDq5ys5XhMzd4bPioWENW+cyjzlQnYmpMTAUFVu9bdC0q2YZ4g7+ip9HduoLDGR5lKzacgS07eJWkGA9yduD1G+m/wQgXQntC4BUFXpi00fKUiqWDukX5nDHlgm6X7yI6Jf7Pb1rHZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K/xPaaF5; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K/xPaaF5"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-565c6cf4819so317386a12.1
        for <bpf@vger.kernel.org>; Tue, 19 Mar 2024 12:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710876926; x=1711481726; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IYv6d4iuQSD2CNzjhdK1ZdvDP7fIUTZPnLuARund5b4=;
        b=K/xPaaF54xhTR/4M5sPVDO60QD47ONf9jGQi2pOY/in/Xf7Sq4nyOrEytWLL/pv2yS
         DxUdHpCYA6uhULoVdQraidTr9+zvKKGDRm1ogcx9ilUzCwqTdor94h/d043LPCyUVYex
         SZHI0Gsy5WeJvHqg/HpQUacZObI0VfLap4ReoA7KQEDfqEnp35j8JJdXzjGDRfnM4R1h
         8x99p0PToWu8AiYWZkpScp8h8zV6+rRJbz/43ynH8Mt0ohX6HCLh9Ms3WPBnC16hjAQw
         K3J/WgLHtEKOFbaKZwBWYlerLAEtX89g+m+WYuI5f5eZTm+mM71v5LqX32J2v2kh8cCf
         LGnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710876926; x=1711481726;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IYv6d4iuQSD2CNzjhdK1ZdvDP7fIUTZPnLuARund5b4=;
        b=qRTGUlLY9sKpYP8oQujq0Ks9rFZ9p8b1m93wCRe65nZ4q145auzizHXBG587fMZsvW
         9m0zkkC3f7DAGGRK0YXBYd7SWMRZ89k+nG9hJh+n26MNgAwQkdhdBSw356L7bjZVqMNa
         unzb+AmiIjMLoTRlxLHglQ32HWSgZiPMSiHKDsIOsWurr9hc/Ol2HMScczWT32AB4r6v
         WXvotklIVjwpXAH+CRsbOCMD7xaGlAHD+NjsPLxckXQQg3LWc7SZRq8Y47fXhVCOFARf
         ScMQL5P5tG9Bc0rMZu9XM5+s+3C+jZp7Vb2IMl4opQ+hvQVDSGdmAQvd1/qbx49zcsQy
         uGGA==
X-Forwarded-Encrypted: i=1; AJvYcCWPR6N6TLdnesQv3ERiWU1wtwDgPbjhdVap9ICx+SLjcu2R49+GscNflWtb02chzPIeBIbA59vtqupSN6RBPVWgPBFt
X-Gm-Message-State: AOJu0YxJSLSVOuhTEE1vYuBqRO/SNwK8qj/LQB6Js7V+kDQm111mt5sq
	Y45nnLgfvnb3jbSDJTxgoDJ4kFEsaXImEXHcDQzKti9cmxwzqs0F
X-Google-Smtp-Source: AGHT+IFAvn/LI6AIm9ci7rBC22DZ7oE6fSCwI+YLXgdNlxnDPcvY/hfFdr5sBVfhs1de54UWZdCyqw==
X-Received: by 2002:a17:906:709:b0:a46:984f:4a65 with SMTP id y9-20020a170906070900b00a46984f4a65mr428625ejb.19.1710876926035;
        Tue, 19 Mar 2024 12:35:26 -0700 (PDT)
Received: from krava ([83.240.63.214])
        by smtp.gmail.com with ESMTPSA id a18-20020a170906685200b00a46ed889fc0sm204716ejs.184.2024.03.19.12.35.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 12:35:25 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 19 Mar 2024 20:35:24 +0100
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Oleg Nesterov <oleg@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org
Subject: Re: [PATCH RFC bpf-next 4/3] uprobe: ensure sys_uretprobe uses sysret
Message-ID: <Zfno_H5fWDH_xOUs@krava>
References: <20240318093139.293497-1-jolsa@kernel.org>
 <20240319102523.GC20287@redhat.com>
 <ZflyM5U67c47i4Oo@krava>
 <CAEf4BzZ-cAByJq8FmgxJgMt7WKAsDME6K00hYJpcS6XiwYO=-w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzZ-cAByJq8FmgxJgMt7WKAsDME6K00hYJpcS6XiwYO=-w@mail.gmail.com>

On Tue, Mar 19, 2024 at 09:25:57AM -0700, Andrii Nakryiko wrote:
> On Tue, Mar 19, 2024 at 4:08 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> >
> > On Tue, Mar 19, 2024 at 11:25:24AM +0100, Oleg Nesterov wrote:
> > > Obviously not for inclusion yet ;) untested, lacks the comments, and I am not
> > > sure it makes sense.
> > >
> > > But I am wondering if this change can speedup uretprobes a bit more. Any chance
> > > you can test it?
> > >
> > > With 1/3 sys_uretprobe() changes regs->r11/cx, this is correct but implies iret.
> > > See the /* SYSRET requires RCX == RIP and R11 == EFLAGS */ code in do_syscall_64().
> >
> > nice idea, looks like sysexit should be faster
> >
> > >
> > > With this patch uretprobe_syscall_entry restores rcx/r11 itself and does retq,
> > > sys_uretprobe() needs to hijack regs->ip after uprobe_handle_trampoline() to
> > > make it possible.
> > >
> > > Comments?
> > >
> > > Oleg.
> > > ---
> > >
> > > diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
> > > index 069371e86180..b99f1d80a8c8 100644
> > > --- a/arch/x86/kernel/uprobes.c
> > > +++ b/arch/x86/kernel/uprobes.c
> > > @@ -319,6 +319,9 @@ asm (
> > >       "pushq %r11\n"
> > >       "movq $462, %rax\n"
> > >       "syscall\n"
> > > +     "popq %r11\n"
> > > +     "popq %rcx\n"
> > > +     "retq\n"
> >
> > using rax space on stack for return pointer, cool :)
> >
> > I'll run the test with this change
> >
> 
> I can do some benchmarking on my side as well, given I have everything

that'd be great, thanks

> set up for this anyways. Thanks for the help with speeding all this
> up!
> 
> BTW, Jiri, what are you plans regarding sys_uprobe (entry probe
> optimization through syscall), while we are on the topic?

I plan to work on that after this one is sorted out

jirka
