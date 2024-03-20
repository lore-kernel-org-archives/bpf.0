Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D611E4AD
	for <bpf@vger.kernel.org>; Wed, 20 Mar 2024 19:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710961717; cv=none; b=S/vppl7wPYpZHKtylj+GA2N/mJv6LnGUIb7nwPYvBXzPsjpA3reFrCwZSkdF4V70/3yDt4yfKOlJpnSe2QZVJm9DwBTV2aWiX9bsPBlA+127YKWrNCXLzSYu2x6T0eho4JLgBJkvPESc0FG24fAChM2jggI5pv147MMEoRrchjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710961717; c=relaxed/simple;
	bh=o7zUitqjdPfh9TW/FSHNzqyPXz1INR4gTr3vDm695uk=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rwxv4sxqzQm6rpgCb+nYWQxRpWN26tk7QnRqyUNKoLbNaww3XJBoBmb1K4NKTf/j3aSwBSA4ZjwA2fIU201gEa2l0uKkdwuy8CXV1vhdmpkbepW0FyHtN3USM88OO10pdN4Gx6i3htKBtC3r8MANOExpLW8+81cmraZkg6W8eB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O5A7GCpx; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O5A7GCpx"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5101cd91017so234406e87.2
        for <bpf@vger.kernel.org>; Wed, 20 Mar 2024 12:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710961714; x=1711566514; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=A3eVEsm6rISunJXzbcml6xm75ZT5Tn13w1tjvfLg9Ac=;
        b=O5A7GCpxVj7ne0QlSZt8TRLBknDUIhJqdT8TOuClWPB4Tqdoh62DD7OTH+aN8vCZw9
         1DHTX/IECXt0kY01+eYoJUdkWTomXddfilihL27Ki97yCmWt3wcUqW+hSEydEXQddJpv
         ptM6uHTvhU5czTp9lhnwbbjHhKv4wZW8Iw91D8PXRjS8A32nP49EzmxUgs3XDt8ljiD0
         U7nUYgSKAbLXdO37BxQyh6ZIh69cfcI+KLt5rhQHUP7CIS1VawxqzHK8cxaUfrdO3cKC
         EOVF10Ysx3QwTuqSqBzrDP6d/mA9H85g3bL2rzsTlGKdUb2NzjiiY8jNbni76RGKujAT
         L9nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710961714; x=1711566514;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A3eVEsm6rISunJXzbcml6xm75ZT5Tn13w1tjvfLg9Ac=;
        b=nIpS2JUvRBlhdZ6UCnUw252RVGBFIZ4OamQAqVrBgxGZ9M7Yyl560p+EXrYjsX1HdF
         WFgw8C6EW5ShQkwK4+bkw6mBB5NAKjoS+Z+nz7SNA4jmQfbfp+KUelHS/KSA5mHvhkE0
         Sea8r//P9GsxcLBw9/FbYxvPzW51j//SRvKQeysX6yFybYNhg6MFpaSxHPpDUF3ILZCR
         3hd1mZ7bflJXyEJv68icwULB5JtaH41i5gLQ2lIePgS74EY517k/Lts2c0FeqOrrFzqK
         rIlqzr03RpynwGHWx4uFXZ76BTWpc390NHcXXKeuhE0kNOn3dLblubK7Xm/lvQ+eWYWY
         i4Bg==
X-Forwarded-Encrypted: i=1; AJvYcCU5FzOvv5i/PJ0WamTkysOH4avM/pieKBm8e/CJNj813ih5SlRSzpDkOShZab+RZ472vsxrP4VC+YKZAQ1XiHuGwm/m
X-Gm-Message-State: AOJu0Ywz9jsSpWnI2dOiQUaMkcH3hpELZ7485jO7YSRs01iW14RK4wvJ
	rs5OauC2jHagqKyF+VBocwYqQfIrFn8BpXKcLJyoyP2AHPbvzwQH
X-Google-Smtp-Source: AGHT+IFADiOqtG2ljfkTV55AoGm7MqJ5iiIu45RBC48zsaojDnLkyLSHAK7ovismV1EvXVBCy6lvEw==
X-Received: by 2002:a05:6512:4844:b0:513:c8b8:aad2 with SMTP id ep4-20020a056512484400b00513c8b8aad2mr12662586lfb.57.1710961713648;
        Wed, 20 Mar 2024 12:08:33 -0700 (PDT)
Received: from krava ([83.240.62.66])
        by smtp.gmail.com with ESMTPSA id r17-20020aa7cb91000000b0056bafdda14bsm1009920edt.28.2024.03.20.12.08.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 12:08:32 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 20 Mar 2024 20:08:29 +0100
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Jiri Olsa <olsajiri@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org
Subject: Re: [PATCH RFC bpf-next 4/3] uprobe: ensure sys_uretprobe uses sysret
Message-ID: <Zfs0LSuw-JOhBn8e@krava>
References: <20240318093139.293497-1-jolsa@kernel.org>
 <20240319102523.GC20287@redhat.com>
 <ZflyM5U67c47i4Oo@krava>
 <ZfnoK8aQDJMgOYfY@krava>
 <ZfrC0NZWxmWBuUIe@krava>
 <20240320143739.GA32579@redhat.com>
 <20240320152848.GA7613@redhat.com>
 <CAEf4Bzbw4CGCptxi7tXoZEEkm_wcBzkaJgTN_tYE5K7sSUgMhw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4Bzbw4CGCptxi7tXoZEEkm_wcBzkaJgTN_tYE5K7sSUgMhw@mail.gmail.com>

On Wed, Mar 20, 2024 at 10:44:30AM -0700, Andrii Nakryiko wrote:
> On Wed, Mar 20, 2024 at 8:30 AM Oleg Nesterov <oleg@redhat.com> wrote:
> >
> > On 03/20, Oleg Nesterov wrote:
> > >
> > > On 03/20, Jiri Olsa wrote:
> > > >
> > > > are you ok if I squash the patches together
> > >
> > > Yes, thanks, I am fine.
> > >
> > > But lets discuss this change a bit more. So, with this poc we have the
> > > (intentionally) oversimplified
> > >
> > >       SYSCALL_DEFINE0(uretprobe)
> > >       {
> > >               struct pt_regs *regs = task_pt_regs(current);
> > >               unsigned long __user *ax_and_ret = (unsigned long __user *)regs->sp + 2;
> > >               unsigned long ip, err;
> > >
> > >               ip = regs->ip;
> > >               regs->orig_ax = -1;
> > >               err = get_user(regs->ax, ax_and_ret);
> > >               WARN_ON_ONCE(err);
> > >
> > >               uprobe_handle_trampoline(regs);
> > >
> > >               err = put_user(regs->ip, ax_and_ret);
> > >               WARN_ON_ONCE(err);
> > >               regs->ip = ip;
> > >
> > >               return regs->ax;
> > >       }
> > >
> > > I have no idea what uprobe consumers / bpf programs can do, so let me ask:
> > >
> > >       - uprobe_consumer's will see the "wrong" values of regs->cx/r11/sp
> > >         Is it OK? If not - easy to fix.
> > >
> > >       - can uprobe_consumer change regs->cx/r11 ? If yes - easy to fix.
> > >
> > >       - can uprobe_consumer change regs->sp ? If yes - easy to fix too,
> > >         but needs a separate check/code.
> >
> > IOW. If answer is "yes" to all the questions above, then we probably need
> > something like
> 
> yes to first, so ideally we fix registers to "correct" values
> (especially sp), but no to the last two (at least as far as BPF is
> concerned)

I think we should keep the same behaviour as it was for the trap,
so I think we should restore all registers and allow consumer to change it

jirka

> 
> >
> >         SYSCALL_DEFINE0(uretprobe)
> >         {
> >                 struct pt_regs *regs = task_pt_regs(current);
> >                 unsigned long err, ip, sp, r11_cx_ax[3];
> >
> >                 err = copy_from_user(r11_cx_ax, (void __user*)regs->sp, sizeof(r11_cx_ax));
> >                 WARN_ON_ONCE(err);
> >
> >                 // Q1: apart from ax, do we really care?
> >                 // expose the "right" values of r11/cx/ax/sp to uprobe_consumer's
> >                 regs->r11 = r11_cx_ax[0];
> >                 regs->cx  = r11_cx_ax[1];
> >                 regs->ax  = r11_cx_ax[2];
> >                 regs->sp += sizeof(r11_cx_ax);
> >                 regs->orig_ax = -1;
> >
> >                 ip = regs->ip;
> >                 sp = regs->sp;
> >
> >                 uprobe_handle_trampoline(regs);
> >
> >                 // Q2: is it possible? do we care?
> >                 // uprobe_consumer has changed sp, we can do nothing,
> >                 // just return via iret.
> >                 if (regs->sp != sp)
> >                         return regs->ax;
> >                 regs->sp -= sizeof(r11_cx_ax);
> >
> >                 // Q3: is it possible? do we care?
> >                 // for the case uprobe_consumer has changed r11/cx
> >                 r11_cx_ax[0] = regs->r11;
> >                 r11_cx_ax[1] = regs->cx;
> >
> >                 // comment to explain this hack
> >                 r11_cx_ax[2] = regs->ip;
> >                 regs->ip = ip;
> >
> >                 err = copy_to_user((void __user*)regs->sp, r11_cx_ax, sizeof(r11_cx_ax));
> >                 WARN_ON_ONCE(err);
> >
> >                 // ensure sysret, see do_syscall_64()
> >                 regs->r11 = regs->flags;
> >                 regs->cx  = regs->ip;
> >
> >                 return regs->ax;
> >         }
> >
> > Oleg.
> >
