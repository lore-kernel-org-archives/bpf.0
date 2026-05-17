Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53FE92D879E
	for <bpf@vger.kernel.org>; Sun, 17 May 2026 11:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779018317; cv=none; b=UUA5MVimIzfs2NqKFxfxvvWOHbtkn6XK6Cobve7ps2/1GlsJxh6S2/DhVH/7l8sJN/WahmCGQnoZ88zDwiVRRmwrBEFHqwDis/MbNkwM9MmjW8FBeaC40Rtzd60AAPSXUAQ7h3IbZ8Bcvkh77yawwga7KA/NnqfDtnlum951gPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779018317; c=relaxed/simple;
	bh=3l7pJGBdrNdxcgGvxQPumHi6XTbYUKTv0qSBktVIClA=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U1Te8DHqG9eOIwBd78mLPTW6Qgk2uudsVuAL8ddIBXdXG+DPSHseeVV561ZGjvqoRUjfPMM0Lpeq7MnYLLhGJnODcw8PhLY9u9pe53JN1/OdINKrb0FrTYrOTbwEP4SEfGBIkqS8ulamipfRbu7hTlinhg0WzZ6AfBqYdoylB1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oDwlr0Ek; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oDwlr0Ek"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-488ff90d6c7so8737445e9.2
        for <bpf@vger.kernel.org>; Sun, 17 May 2026 04:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779018315; x=1779623115; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9YJjc/QiWZeE3TL65SN8Kq4yKPUHyJIwfqQZVmxkSt4=;
        b=oDwlr0EkLTN4IVU0hhvH94jI4/fAGVcH0btgKCnAIlvDdui8EeqiXdb38tfwmvgZkm
         /m1eUZiPXX5wAY4z6sGmZQETjxiIKr9uCHRg9TMeueQa4PyKzA8UR86wQe3yCZ1oBd8i
         yIcbCuy0jEBj50s10wv0r/6pmwq3G0xkM65bB+Z0r4q+uuy6KyO7IItIV8E73ovw1Gd/
         a/mQrEDOVE25S+2vTb/FjHF7Do5QJIkuv1jyJ8kFcZN7P1aqr109jaRHQMVOcvFhN4/+
         Mnfv90JIMT8B8fcTLI1LA30kpCmonBfBMrIr2L1+YlZXRH3VfOE8dwJUQFEX8LNvu1F2
         C1ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779018315; x=1779623115;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9YJjc/QiWZeE3TL65SN8Kq4yKPUHyJIwfqQZVmxkSt4=;
        b=KkSMw1Q3J3mVuJPbjhF5PH6xiui7DBN8I/MDBNj7APFHqW5sYT+zoqMmGt4Fqssit8
         w+n7gowp4TuPERZWzlVWHWZGD+0h1N96tGzGWeSj/aE4DWgvAC3eE2oTJYX3g0Exv7mI
         qJ0FuzPlct8kUJ7VrZkzX34d5cAaeTTHAUPCTlvhahOC8fu8XP4CVJwjhC5KO6MnC6B1
         Lnd5YETgsXon5vg4t1CQbZZCSNIN3EHXC7ZpD4/a4huJjFGmxppjjb6E9m6uDF0NFGbt
         a0AymkA1IIDy8aHN+2cCDp3SXzgVYva9GabyPuMDb0bBAevdB0ux7XSQbF4tMvFsu43H
         hoNA==
X-Forwarded-Encrypted: i=1; AFNElJ8AMbzhjeXBmtypgir0oC0QswRSSZWqoRqyA+OupeAMeHGQBy41HwjrjkqrYPHdAN6aPWA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtMq9HpPHL++ypDhD2Q41SzzWJ0hqDm3FqxttIa+5ro4HfXwPy
	AATYV1cHZCZynujVITfjGp76mclUhqCIw3JQfdzt/M0Vv/HXhAlRUPdv
X-Gm-Gg: Acq92OFrdMEqgGXCZieEoloNF7OXpvre/2cOw9tH0QvP7WxfvMsV8dFiob59YkIMLow
	z6ADw1Tu1GZTn819y4vMheDO/Ho+Px2HCzln/7Fz55Fpa/LfhLKXPpj6Y7m4rEKwaucjKsERora
	algVoRQfOiJ5XNs25jxlVBLIPyCwcTWOleASe6YQlS9sjAc2NgPzxBboQK4i606FXNT2PAQCze2
	+WV62F8xCGVoH3h6/bfvbmwg7jEylWs7uE1T2qxYc4K7JcxSCixrqElQPoORdbsIWV+TrGr8KdQ
	hi+2D0MehvJQs/oWfoWX+fF8iSqRZKQwc5z7/d1XDfziaPgWD4BvUAVSxLG9gwTh8X0SmigBAMN
	r6Z+yyQ5OluzSMVTBvCJekvrqtLplqmYke8W1I8Q/CnbyzfDkQD/vZ6YYEUBRHAkMTSZhNVDYyL
	HcpRPpbS/4lLjlk0mgT8GBsPELkw==
X-Received: by 2002:a05:600c:a293:b0:48f:e6de:1cba with SMTP id 5b1f17b1804b1-48fe6de1dc5mr98844695e9.17.1779018314603;
        Sun, 17 May 2026 04:45:14 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200:b655:ff13:e355:16a3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0fe13b4sm29688465f8f.28.2026.05.17.04.45.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 04:45:14 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sun, 17 May 2026 13:45:13 +0200
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] uprobes/x86: Move optimized uprobe from nop5 to nop10
Message-ID: <agmqSdXV0LTEIoUP@krava>
References: <20260514135342.22130-1-jolsa@kernel.org>
 <20260514135342.22130-2-jolsa@kernel.org>
 <CAEf4BzZxNLEeyDE2aJVm=T=RzDayaHzAbHxXQqn6M6uqa45obA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzZxNLEeyDE2aJVm=T=RzDayaHzAbHxXQqn6M6uqa45obA@mail.gmail.com>

On Fri, May 15, 2026 at 01:31:31PM -0700, Andrii Nakryiko wrote:
> On Thu, May 14, 2026 at 6:53 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Andrii reported an issue with optimized uprobes [1] that can clobber
> > redzone area with call instruction storing return address on stack
> > where user code may keep temporary data without adjusting rsp.
> >
> > Fixing this by moving the optimized uprobes on top of 10-bytes nop
> > instruction, so we can squeeze another instruction to escape the
> > redzone area before doing the call, like:
> >
> >   lea -0x80(%rsp), %rsp
> >   call tramp
> >
> > Note the lea instruction is used to adjust the rsp register without
> > changing the flags.
> 
> I think it should be very loudly explained that we can't go back to
> nop10 and have to do short jump over patched sequence (and why).

there's comment in swbp_unoptimize:

         * We have optimized nop10 (lea, call), changing it to 'jmp rel8' to
         * end of the 10-byte slot instead of restoring the original nop10,
         * because we could have thread already inside lea instruction.

I'll add it in here as well

> 
> >
> > The optimized uprobe performance stays the same:
> >
> >         uprobe-nop     :    3.129 ± 0.013M/s
> >         uprobe-push    :    3.045 ± 0.006M/s
> >         uprobe-ret     :    1.095 ± 0.004M/s
> >   -->   uprobe-nop10   :    7.170 ± 0.020M/s
> >         uretprobe-nop  :    2.143 ± 0.021M/s
> >         uretprobe-push :    2.090 ± 0.000M/s
> >         uretprobe-ret  :    0.942 ± 0.000M/s
> >   -->   uretprobe-nop10:    3.381 ± 0.003M/s
> >         usdt-nop       :    3.245 ± 0.004M/s
> >   -->   usdt-nop10     :    7.256 ± 0.023M/s
> >
> > [1] https://lore.kernel.org/bpf/20260509003146.976844-1-andrii@kernel.org/
> > Reported-by: Andrii Nakryiko <andrii@kernel.org>
> > Closes: https://lore.kernel.org/bpf/20260509003146.976844-1-andrii@kernel.org/
> > Fixes: ba2bfc97b462 ("uprobes/x86: Add support to optimize uprobes")
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  arch/x86/kernel/uprobes.c | 121 +++++++++++++++++++++++++++-----------
> >  1 file changed, 86 insertions(+), 35 deletions(-)
> >
> > diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
> > index ebb1baf1eb1d..f7c4101a4039 100644
> > --- a/arch/x86/kernel/uprobes.c
> > +++ b/arch/x86/kernel/uprobes.c
> > @@ -636,9 +636,21 @@ struct uprobe_trampoline {
> >         unsigned long           vaddr;
> >  };
> >
> > +#define LEA_INSN_SIZE          5
> > +#define OPT_INSN_SIZE          (LEA_INSN_SIZE + CALL_INSN_SIZE)
> > +#define OPT_JMP8_OFFSET                (OPT_INSN_SIZE - JMP8_INSN_SIZE)
> > +#define REDZONE_SIZE           0x80
> > +
> > +static const u8 lea_rsp[] = { 0x48, 0x8d, 0x64, 0x24, 0x80 };
> > +
> > +static bool is_lea_insn(const uprobe_opcode_t *insn)
> > +{
> > +       return !memcmp(insn, lea_rsp, LEA_INSN_SIZE);
> > +}
> > +
> >  static bool is_reachable_by_call(unsigned long vtramp, unsigned long vaddr)
> >  {
> > -       long delta = (long)(vaddr + 5 - vtramp);
> > +       long delta = (long)(vaddr + OPT_INSN_SIZE - vtramp);
> >
> >         return delta >= INT_MIN && delta <= INT_MAX;
> >  }
> > @@ -651,7 +663,7 @@ static unsigned long find_nearest_trampoline(unsigned long vaddr)
> >         };
> >         unsigned long low_limit, high_limit;
> >         unsigned long low_tramp, high_tramp;
> > -       unsigned long call_end = vaddr + 5;
> > +       unsigned long call_end = vaddr + OPT_INSN_SIZE;
> >
> >         if (check_add_overflow(call_end, INT_MIN, &low_limit))
> >                 low_limit = PAGE_SIZE;
> > @@ -826,8 +838,8 @@ SYSCALL_DEFINE0(uprobe)
> 
> should we change -ENXIO to -EPROTO or some other distinct error code,
> so libbpf can avoid using nop5 attachment on kernels new enough to
> support nop5 optimization, but old enough to not do this properly with
> nop10?

right, I'll take that change as well

thanks,
jirka
