Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4AA405F9
	for <bpf@vger.kernel.org>; Mon, 11 Mar 2024 16:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710175593; cv=none; b=uRxkS/h5LrVzaR6f3OwvlyU7W+eP0mQLl3Pag9hBaMSsiUGg5UWabyrzAFXnzBm52RGZT43zRP5aIhY/EY9jIwVop3Uo7BGcv9BSC5AKFrMmmtgXscwJWmMj1sBIMFuwezAKSMZf7JaM2jTIkWJNOPAls46cF+PMpEgD3ZN4usg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710175593; c=relaxed/simple;
	bh=tWqWR50thwDEOKvvP22rRnDxKRT/0CYyjp1qfx/iGmI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FuCf5pthT8ryUlz1wOD5skvC4v/pDK2Ae9sq1RIssvU0FKqeyKAKj1epSFBLBUl4n/9PzDBzWGVz7WifI3h8i/yBcXPKO+Nnrn9arduM6+R92oeO2AbhFhq764kvJuIxkEuh604QpC6pvNy1myKb9vPATbKJjEbatdLJzSQSbu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l7TG80XN; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l7TG80XN"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5684f95cc9bso2558168a12.1
        for <bpf@vger.kernel.org>; Mon, 11 Mar 2024 09:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710175590; x=1710780390; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zHReTrME8uoKqyR8ATAaezTDb2HTSwyf8OT5Kp+HoMo=;
        b=l7TG80XNVm5lllLeqLAPxFQPF8m5Dzd/sYIuqeOjkFXNz9HCDSBPXkUPfDAlc1jyv+
         542/5U4w7XyOwBi5j3x79XeVj6BsjP4/9wLbeTbS3vuswldg1H2QZO3L+5Kk/4OjAMR3
         OTW1vx/3qMCL8jiOkap6MJijlFzQyDv7IQt2jEtoIXxCPfQUnXdap6acJHSPeWp9yTyj
         qRe3K/G+7obSwA3YwsCWhUNRJoXCict7hLCHWr/MXarRjPPHpMP5wt2iqlDyyzInSm00
         wEMG79zKjIBnKQDfdGzFIHvMcGLzUNdb5qpQcvfJgyOSEEgrCCTfcOM8AYgf4lJkIRuk
         x7yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710175590; x=1710780390;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zHReTrME8uoKqyR8ATAaezTDb2HTSwyf8OT5Kp+HoMo=;
        b=EEHSX1LB8drCAik/J6iG9z263xvjyAku5ecIUkYCQSc0awQQPn/TmNPSmVrsQotO+e
         dGS1WoZ7HKOtgX7+FYv15d9yHZPtqNDtgMw6fHZ/5nEn87Ol0Q+VzIclAzRSU4gPykgO
         iXmBVEVikfJbOOOaDTE3vX+MNuu2zkCadzjh3K9w1q8AQqwXYJ/MGEtVUp0gn0yuOCd7
         vfmygbaHo2hiZutsSuXPhW2kR/Ylj0kpMwi85tu/jy6GKqkznC/kR9Y/UU6YUNoJRCjz
         waR9AH2k3+TWLDUzr++6o0BbLtjootImSFNVF2Ar70DYrBFOSdhtbtNnQtIlshTx/uOw
         xMIA==
X-Forwarded-Encrypted: i=1; AJvYcCVTZiDA4RCNy3iqR+xxl9P36dIjLH+3HRfA//i/h9Gsx8jMNrhu+gz5rGfcRHgLbd/0LmZs33XkAgByFfYdLeLbQ3iC
X-Gm-Message-State: AOJu0Yz2IYfw6a635zY2CBI8SH+EMsmNtZukPa+kSFjlBiqHjlRRMgXj
	5rlzyGb+RXc/jJGSGvP+TP5tgdEkR+R6vhioFJIY4YguYEKHZnrr
X-Google-Smtp-Source: AGHT+IEOVbreSKP+rDUNLmhRkeIjGq3cGrQ4MJ7PnFJQPEc1zOgox2wpq6z+nC43Rm/i2DSZUNZl2Q==
X-Received: by 2002:a50:9550:0:b0:567:a2c7:27b4 with SMTP id v16-20020a509550000000b00567a2c727b4mr8000823eda.5.1710175590343;
        Mon, 11 Mar 2024 09:46:30 -0700 (PDT)
Received: from krava ([83.240.63.214])
        by smtp.gmail.com with ESMTPSA id r26-20020a056402019a00b005686184eb77sm932852edv.78.2024.03.11.09.46.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 09:46:30 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 11 Mar 2024 17:46:27 +0100
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
Message-ID: <Ze81Y2oal2Lg03HA@krava>
References: <ZeCXHKJ--iYYbmLj@krava>
 <CAEf4Bzbs4toMxw62kVTWNHA7sW-CncamyKHCWynCT0GnG+fOfQ@mail.gmail.com>
 <ZeGPU8FRqwNuUJwd@krava>
 <CAADnVQKW4Qk55NjaApx1caPDF_pA8f5JZFE12DKA2R8cKWmtcw@mail.gmail.com>
 <CAEf4Bzbv5_yG8S4c22QUXp1FhLZGSSRZS6FFjXfvo=4RdAThZA@mail.gmail.com>
 <ZeRO9_IiLSy9D7jQ@krava>
 <CAEf4BzZQnqjoCc6Y_N3Wu4eMpioqgZC04QrTujgyiYMMRpG3Nw@mail.gmail.com>
 <ZebWqIgABbk8dQXT@krava>
 <Ze7kGP5aAYGseRuM@krava>
 <20240311150658.GA28588@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240311150658.GA28588@redhat.com>

On Mon, Mar 11, 2024 at 04:06:59PM +0100, Oleg Nesterov wrote:
> I forgot everything about the low-level x86_64 code, but...
> 
> On 03/11, Jiri Olsa wrote:
> >
> >  #ifdef CONFIG_X86_64
> > +
> > +asm (
> > +       ".pushsection .rodata\n"
> > +       ".global uretprobe_syscall_entry\n"
> > +       "uretprobe_syscall_entry:\n"
> > +       "push %rax\n"
> > +       "mov $462, %rax\n"
> > +       "syscall\n"
> 
> Hmm... I think you need to save/restore more registers clobbered by
> syscall/entry_SYSCALL_64 ?

hum, so the call happens on the function call return, so I thought
we should just preserve callee saved registers which seems to be
taken care of by the entry_SYSCALL_64 path.. I will double check

> 
> > +SYSCALL_DEFINE1(uprobe, unsigned long, cmd)
> > +{
> > +	struct pt_regs *regs = task_pt_regs(current);
> > +	unsigned long ax, err;
> > +
> > +	/*
> > +	 * We get invoked from the trampoline that pushed rax
> > +	 * value on stack, read and restore the value.
> > +	 */
> > +	err = copy_from_user((void*) &ax, (void *) regs->sp, sizeof(ax));
> > +	WARN_ON_ONCE(err);
> > +
> > +	regs->ax = ax;
> 
> probably not strictly needed, we are going to return ax...

it needs to be there for the bpf program to read proper return
value from regs

> 
> > +	regs->orig_ax = ax;
> 
> This doesn't look right. I think you need
> 
> 	regs->orig_ax = -1;
> 
> Say, to avoid the "Did we come from a system call" checks in
> arch_do_signal_or_restart() or handle_signal().

ugh right that's probably wrong, I need check on that

thanks,
jirka
