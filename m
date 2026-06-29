Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA00407576
	for <bpf@vger.kernel.org>; Mon, 29 Jun 2026 13:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782739194; cv=pass; b=Xx/PHMKH2p3rcgXg7OOdzgYCbYr61PaXbub9Md+m5vnPWiePhXZNkliuHBmkrVgvpuABeNss5BKFplnWCeVxbetFcfzDH3Q3/AvlpkSVY/XChOloKBFf14G3tJYbM6QjNzDvwk2oq6oTPZgYez3wd1e7DNzWnSkp99aL2a9xKgY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782739194; c=relaxed/simple;
	bh=hxkC8KIlEaT56UtUTbB70emjyEUY+aE3e7gX7vJtRy0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AJP/y+t9b/z0ghqWKECIZ4u95RW2k1VB4eXX/yIpFvIMasEhqkINJiRuqLNfHrIxMi5kj1UObUlsyejkx4uSvDN1Xy99Q1g2UMa8oH+YbVckCeGUWyDi7FkORgq8L42L0K9T9kvWe3uJX6jfu2r88RP501QCN6lnJ+KWwz0C9xo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CKDJZhrs; arc=pass smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CKDJZhrs"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-698439b6e8aso4060409a12.3
        for <bpf@vger.kernel.org>; Mon, 29 Jun 2026 06:19:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782739191; cv=none;
        d=google.com; s=arc-20260327;
        b=it4n2rHW+JevxTz3w/9eMUD5GsLTEDnmjVf3ZM2FKIHB0ZSFECPZDyMi5tTQQaAqgM
         hrsHAo6UknFdT3GbqCwE5AVVmbk/9HIVgtAuZmEFA33uYKlMM2sfSrBFEYVCEWSNnyZr
         3fe7mOO8OFxlUtdEDoCUeP+m7n3NAD4AUkbQWFGTHM9ucwBgxsX03OQ/0sDqciYtlLCc
         UrYf7uotY2gepyNs+cgJ5+dOmDIVnwFzQV3n4kfjF+DAre/N+RDpbMhEZzS6DR+1GW1l
         0Vf+DIxKNcgzK4Jzd7rLPQQY0ucs3yGr2gwKIi9tRtSOdv1epHXWWSgkIecF4S48FW41
         LcYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dJHc5P5+QXd+EJ+9kQea+isULXn2Dht38UwjjlHyyKw=;
        fh=umwVaqay8xLda7qhkbwm7WxzXk1ZVGAIVWck5h7g4Vc=;
        b=kKM7b+wCLHiEclS3mCaGgXPmvJaDcApZGSfdQdGVUCqtFdl+W/noc9g/i6EUQGeNww
         onLWm4DrKPyqJl7dIv6BpWulqyR54++H+uB/wEqmNsT51GHZICXLJv0l5QGxn6vyZQlW
         7nCgHK+RoY4uKaQsHrdCetsnyqd/gh/qH2v6efOvPrPEsFIbJ6Q4k3BjqvfuUs5HJhqL
         wXrk5ghNkyW7mV8WOYnlNrIg6c7PVN3hipOscETwPcH+lF1zXAiZg6xmSkh18SraGSPm
         GkN85iHq2c2pArEv6aYCuChk+4kWOnAU9a+97Gic972dDvGZzfaJh0A5uhehKAqOLHko
         kFTg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782739191; x=1783343991; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dJHc5P5+QXd+EJ+9kQea+isULXn2Dht38UwjjlHyyKw=;
        b=CKDJZhrsAaQ/2cVur7FBd2Us7z31bC0ySPVoXEJKUSMo8oTV6nQJ2cC/6YsKejMKjv
         FMVMTXNGKYrh8yXGEavElD1CAUpTUl/gMqIaWsumAErwxS/WlDKENWd5vDcSDmHzjho/
         MTiZO/Cfw7XE+MCckG3O01cQkCCIru2y12BjfAn3Dg0VuiVxpVT/c5ctuD9qP9e7ITFZ
         lP9sB5WDvzNQYgfQiR80B/1xPs4ATp6lHTYAxqkGGwtm1odlnyqnTDC1pULObRa7lqXR
         Lqt7pd9V+pCEiSdcQpM6vtO3ehzgfZNGfTGg1oIj36gN2Cbz2yEa0mBS9KFcxCMJv7Tl
         GdPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782739191; x=1783343991;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dJHc5P5+QXd+EJ+9kQea+isULXn2Dht38UwjjlHyyKw=;
        b=fniTpry9EAb3svw4FG6OpfOnpASXf3zF3zOG2ChkqUnbO/5tXkXwQ4Jcdh7Uh6Kijm
         j0jnu/Ow7UhZHjm5E4WuoXf3n/Z4nNsS973YXt33TV757htHID+aoGezAqL6cdJb10DI
         Kv+VmhUAhR1/+J/PKGTIA3GWuVcYhjW+eR0Dh8DqbEvSttrxtUrWatbizpwZHmcRqjQy
         cQxIx7C44S6Qo6rSv/rCObMnEf+ygRN2fklV4nFhV/J/OnotvZIrJSAfq6qgfgNXEeZF
         I5n6dHrNiZ7oWmJCvEzE67sCDKM1qML+GoTkhkw549bpi1Zi1+06FWx1u6Yzw5KZVpNR
         CK8w==
X-Forwarded-Encrypted: i=1; AHgh+RrYHGWYQ9N1cstv4DAOlK5ZgTpt3vLir04LJJa8YSOonh8EISLKbr985qkRHxdzYeA3tAY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxjl+CAmxfzrv4OD1AXwyGYcsmdnW3zyo8k4GQNLGnmxJh86p7X
	9dLipB+604K6fxc0nqn2qqgOGiEUoyVt5RxCkykGZDnZZcTSKQRRIKw60p8ziwQBGSvCR9huhiQ
	xrDKclKWVxGunzAG8KscxSY0MrMhb0cg=
X-Gm-Gg: AfdE7clByfeiiHIQNNv188X98nhIbvzXqoZlFrdjwGoAQuJtFYvU1KIGu+RX3N3jp6Y
	KHS5U9clFoxBmwKQXHEnrWtSitKiw9FMwHAjmZlcvivVym80IwgZJZmBVHvDB6EyLcvthbnP0nR
	pJJXMjsoYpDyzqTytQwVOHXiCW7SjBsUDfNCcj3yQnvA/9gnnWRZ8DMYYTAMAO+V3dH83HDtFuk
	mCue3uiy06sTrHJ1R/w5w3iJL0fnGiAHCRILnW5dDBDeta7WM4UjIGLIu/PX5cfUKdlg1Yeow==
X-Received: by 2002:aa7:d30d:0:b0:698:3b7c:7e39 with SMTP id
 4fb4d7f45d1cf-6983b7c7f6cmr3492229a12.35.1782739190617; Mon, 29 Jun 2026
 06:19:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251215034153.2367756-1-dolinux.peng@gmail.com>
 <20251215034153.2367756-2-dolinux.peng@gmail.com> <20260513104229.2f39eb03@gandalf.local.home>
In-Reply-To: <20260513104229.2f39eb03@gandalf.local.home>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Mon, 29 Jun 2026 21:19:37 +0800
X-Gm-Features: AVVi8CcwXsWLmGI1EfghufBHUvXsCA3iL3jmwnaCxFFFF7XYRD1PwQR0Vk7rgC8
Message-ID: <CAErzpmvMd9Vixtue0pm5GJAFFvT4-8DcmopgShGNXxG5UyVsQw@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] ftrace: Build trace_btf.c when CONFIG_DEBUG_INFO_BTF
 is enabled
To: Steven Rostedt <rostedt@goodmis.org>
Cc: mhiramat@kernel.org, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	pengdonglin <pengdonglin@xiaomi.com>, Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 13, 2026 at 10:42=E2=80=AFPM Steven Rostedt <rostedt@goodmis.or=
g> wrote:
>
>
> Sorry for the late reply, I've been a bit busy on other things recently.
>
> On Mon, 15 Dec 2025 11:41:51 +0800
> Donglin Peng <dolinux.peng@gmail.com> wrote:
>
> > From: pengdonglin <pengdonglin@xiaomi.com>
> >
> > The trace_btf.c file provides BTF helper functions used by the ftrace
> > subsystem. This change makes its compilation solely dependent on
>
> Nit, change logs should never say "This change". Instead it should be
> worded as:
>
>   "Make the compilation of trace_btf.c soley depend on..."

Thanks, I will fix it.

>
> -- Steve
>
> > CONFIG_DEBUG_INFO_BTF, allowing features like funcgraph-retval to also
> > utilize these helpers.
> >
> > Additionally, the redundant dependency on CONFIG_PROBE_EVENTS_BTF_ARGS
> > is removed, as CONFIG_DEBUG_INFO_BTF already depends on
> > CONFIG_BPF_SYSCALL.
> >
> > Cc: Steven Rostedt (Google) <rostedt@goodmis.org>
> > Cc: Masami Hiramatsu <mhiramat@kernel.org>
> > Cc: Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
> > Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
> > ---
> >  kernel/trace/Kconfig  | 2 +-
> >  kernel/trace/Makefile | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
> > index e1214b9dc990..653c1fcefa4c 100644
> > --- a/kernel/trace/Kconfig
> > +++ b/kernel/trace/Kconfig
> > @@ -755,7 +755,7 @@ config FPROBE_EVENTS
> >  config PROBE_EVENTS_BTF_ARGS
> >       depends on HAVE_FUNCTION_ARG_ACCESS_API
> >       depends on FPROBE_EVENTS || KPROBE_EVENTS
> > -     depends on DEBUG_INFO_BTF && BPF_SYSCALL
> > +     depends on DEBUG_INFO_BTF
> >       bool "Support BTF function arguments for probe events"
> >       default y
> >       help
> > diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
> > index fc5dcc888e13..6c4bf5a6c4f3 100644
> > --- a/kernel/trace/Makefile
> > +++ b/kernel/trace/Makefile
> > @@ -116,7 +116,7 @@ obj-$(CONFIG_KGDB_KDB) +=3D trace_kdb.o
> >  endif
> >  obj-$(CONFIG_DYNAMIC_EVENTS) +=3D trace_dynevent.o
> >  obj-$(CONFIG_PROBE_EVENTS) +=3D trace_probe.o
> > -obj-$(CONFIG_PROBE_EVENTS_BTF_ARGS) +=3D trace_btf.o
> > +obj-$(CONFIG_DEBUG_INFO_BTF) +=3D trace_btf.o
> >  obj-$(CONFIG_UPROBE_EVENTS) +=3D trace_uprobe.o
> >  obj-$(CONFIG_BOOTTIME_TRACING) +=3D trace_boot.o
> >  obj-$(CONFIG_FTRACE_RECORD_RECURSION) +=3D trace_recursion_record.o
>
