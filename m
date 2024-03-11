Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA26154FA9
	for <bpf@vger.kernel.org>; Mon, 11 Mar 2024 21:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710191522; cv=none; b=C34ZVB9PKVJNolUVdgktRdrVaDQ/tNf+znmBgiAHxwlqIbhROGU2CgYhOd0h9ooG0q9aBsFjsCC/GuxlNLgk3/EMVg/xmEiXc54pIgky62l7aapPy1Ht+q80YyaAO48p68CAQbdlflV+6Q9VDD9RwnVd4ZkW7WthklYklV3fpZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710191522; c=relaxed/simple;
	bh=7j8Xz9nHF7KqxVZdVTRAVQzWKE6DvsQ2707nsjogB3o=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ROmkjW92tqfMqZl2SKFIbIh2CTE2TbhNrxllSzvU/1Vl1IBzN4Ww1udX4AwjEVV1/uh4l5Ml+3j6CzT8CMFOOnf5C92fswdckQMDZ3836b4ogMGT5UnuD8h/5l1oskdfbLcHNM0L0Dd7oCoixJ4VN9/unUdBI/BjMtnB5WQDeKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QGezwGv8; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QGezwGv8"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-513af1a29b1so1243593e87.1
        for <bpf@vger.kernel.org>; Mon, 11 Mar 2024 14:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710191519; x=1710796319; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Mci0q1n+94f/dbi2FlrVq2SblcDj3AOQmb9piY35Z5Q=;
        b=QGezwGv8I/EOqizeB9Ad477eszbuFGdqhxuE2lSnDGYlRxUjcdfyRz4pAx1zGX/Pct
         RHE6ELBITaUS8btX6qjbUoPZQGxxCxhyFVuD07SrdNzTJQAL760N/C0DQOdqvlr5U8lR
         0qLCEdehWRBX1VKEpw3V0cHLzVvf3ygsXZUPBIl/d/XiKVqYk5c6Z+nwAf21U7xE/zcH
         Yo9lRgAZySrNGHVfkihx135+a9b627bfOICFCxe5L2v3Qqwyrm8FCwQLISMR03KSldbO
         4BRMJ1/+JlP+fze9e4eqjx+ayAFKyyj9qYwnuQvP2cyEXlwrTGCGyoazmYaP01KW+dWh
         m/bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710191519; x=1710796319;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mci0q1n+94f/dbi2FlrVq2SblcDj3AOQmb9piY35Z5Q=;
        b=wrzxTFdG2cY59q0on5csWaiRg8duQxR0s8mylY1zDJH8mjhH9Acr91gD6nRcac/XuO
         5kLgB57fUWJox4z9PCSog+flL6f0Mon8Ce6vVOADgOZDQhUJaNUmlec9AUugMAfCoeVM
         a9DLMaja99T9uucywuPt+FXRPAvHMQWgTvTtES6EhM7x6K4to1H3JAoO4JHEhFziRWly
         QCGJTAcEiJy/fB8eMkbByzv/x1Yh1iSujEH4dq0hvyKvciDSWXC7ted5HUivJOaP77Du
         xwmrkjBuWSK1T8vXdbJZTVEsrplxuuba+wv5C7FizZnqz647gAYbaqEtuIJpry9Kwxix
         NFMw==
X-Forwarded-Encrypted: i=1; AJvYcCWgzpIwkywqTVqbcX0SQ/5SYFdWPS1J6PiGhI4FJRquwqFbWakSf/4mGJdoBV3chaT3qf4V12MCXWPgGSDN9sqxSWBb
X-Gm-Message-State: AOJu0YyjmKxAMqlR8feyOaNRCiazQfBupfQuFr6vCwYcpL/bFUF1kWTL
	mT1Rc24QTyCPK5tYeE46wvH6GOqenlN1ARIqcFlRtR8OPe/A3n2M
X-Google-Smtp-Source: AGHT+IFXDojMaPEPe6eAxOc0AOB9OepkzXbZccbiUSlEDE/ViPk7IhLP5oXdkAsMva9TVSguAKE2oQ==
X-Received: by 2002:a05:6512:3baa:b0:513:b102:7d93 with SMTP id g42-20020a0565123baa00b00513b1027d93mr2396696lfv.24.1710191518541;
        Mon, 11 Mar 2024 14:11:58 -0700 (PDT)
Received: from krava ([83.240.63.214])
        by smtp.gmail.com with ESMTPSA id ay7-20020a170906d28700b00a45bf1c7425sm3199597ejb.185.2024.03.11.14.11.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 14:11:58 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 11 Mar 2024 22:11:55 +0100
To: Oleg Nesterov <oleg@redhat.com>
Cc: Jiri Olsa <olsajiri@gmail.com>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	yunwei356@gmail.com, bpf <bpf@vger.kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	lsf-pc <lsf-pc@lists.linux-foundation.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [LSF/MM/BPF TOPIC] faster uprobes
Message-ID: <Ze9zmyRiAU5kptah@krava>
References: <ZeGPU8FRqwNuUJwd@krava>
 <CAADnVQKW4Qk55NjaApx1caPDF_pA8f5JZFE12DKA2R8cKWmtcw@mail.gmail.com>
 <CAEf4Bzbv5_yG8S4c22QUXp1FhLZGSSRZS6FFjXfvo=4RdAThZA@mail.gmail.com>
 <ZeRO9_IiLSy9D7jQ@krava>
 <CAEf4BzZQnqjoCc6Y_N3Wu4eMpioqgZC04QrTujgyiYMMRpG3Nw@mail.gmail.com>
 <ZebWqIgABbk8dQXT@krava>
 <Ze7kGP5aAYGseRuM@krava>
 <20240311150658.GA28588@redhat.com>
 <Ze81Y2oal2Lg03HA@krava>
 <20240311170231.GB28588@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240311170231.GB28588@redhat.com>

On Mon, Mar 11, 2024 at 06:02:31PM +0100, Oleg Nesterov wrote:
> On 03/11, Jiri Olsa wrote:
> >
> > On Mon, Mar 11, 2024 at 04:06:59PM +0100, Oleg Nesterov wrote:
> > > I forgot everything about the low-level x86_64 code, but...
> > >
> > > On 03/11, Jiri Olsa wrote:
> > > >
> > > >  #ifdef CONFIG_X86_64
> > > > +
> > > > +asm (
> > > > +       ".pushsection .rodata\n"
> > > > +       ".global uretprobe_syscall_entry\n"
> > > > +       "uretprobe_syscall_entry:\n"
> > > > +       "push %rax\n"
> > > > +       "mov $462, %rax\n"
> > > > +       "syscall\n"
> > >
> > > Hmm... I think you need to save/restore more registers clobbered by
> > > syscall/entry_SYSCALL_64 ?
> >
> > hum, so the call happens on the function call return, so I thought
> > we should just preserve callee saved registers which seems to be
> > taken care of by the entry_SYSCALL_64 path..
> 
> Yes, but we do not know if the (ret)probed function obeys the C-calling
> convention, perhaps it is low level asm code or not a C function.

ah right.. I think we need to make sure all is saved/restored

thanks,
jirka

> 
> > I will double check
> 
> but I won't insist if you think we do not care.
> 
> > > > +
> > > > +	regs->ax = ax;
> > >
> > > probably not strictly needed, we are going to return ax...
> >
> > it needs to be there for the bpf program to read proper return
> > value from regs
> 
> OK, I see, thanks.
> 
> Oleg.
> 
