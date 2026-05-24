Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B286337AA77
	for <bpf@vger.kernel.org>; Sun, 24 May 2026 21:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779659674; cv=none; b=iXe2tp1F1mZKWJGunXGttSzTqTqPYhLnDJCU3CVz13lz3RZ6KP6Kb99p/VA47axtfK8UIlWhlr2R7iQbMWO2V+WmPuPK0q6/k4xByejFIU0pYXuaFfAw81MQmqZHBW67MYB8YB3Ef1DnYz1d2UJ9e6X6opRd/ztsxmdn55sHPRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779659674; c=relaxed/simple;
	bh=3VERMq+xiLZ9WUMPX8js5tvfdxGKD0cIlLNFz0YzHbA=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GC1TftJrPeByEKPeL+eTJKrep/lzAPAiIVSha1psVJ6KpWswvMwYd+5q+wtYYqLRAyzRCPmV1gJTl0lBjCfycLRgrrt+v0eFst5xyW7goh2rE03wEIBHBH8j/GNkfD8D6jKFcL5JRlfrYhkOLfqL3WyV889TepefjMXZ73xFVBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YzjAsLfW; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YzjAsLfW"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-48d146705b4so95294485e9.3
        for <bpf@vger.kernel.org>; Sun, 24 May 2026 14:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779659671; x=1780264471; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=I10QhtVmzV81xL+5R9qfUHIcQyyiwHM6k2SsnmlTNcg=;
        b=YzjAsLfWg0M9XiBiF5By4f147gf8F8+WJsiU26iQwXuusQD4Ulz5z0hz1wq/Xxa8ir
         tfJHxOYS2+t/nJ8apfGnD3Y3hPdaZ9zAYMJ2QY5dH4mM5h5hVcfAr8sgil5nXHuN6hte
         Wreu/1cCaTkVEJrBcbey0IE4g78KdWJ3wC5Vy2lNAsiqZvEZYgqnGE9mNwHtWpGCTwKK
         8OHE/iyWN1M5zJroxbVVG8eeE9HHIRU0PaMpEtmsniDGI0a27Bf1ag6FYzl/1JZ22uzi
         kla0ngDclrbR+TdLHw2kfDy5DVjYvOX6WdcmjRkNhJcRFtDI4N6CQZZZpfQWuNtDhv0d
         47rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779659671; x=1780264471;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I10QhtVmzV81xL+5R9qfUHIcQyyiwHM6k2SsnmlTNcg=;
        b=K2hZ4sJ60BcETOkBPGLX1hEBTPts7U8NFZGbBpE/50C8isRhypOVLxCYD+CHpxVWtn
         p1UQseyQLEUxBUUwE6fFNoRYq37wA0d/+kYkHCcEbWsoALQAzJv1PmtiV8h6DPUUhF8J
         zKjonQp8ZonEpNF1IjtyzTCtjxdqCWsh2dz/6O9EUn5LHus8Cc24chcZ1W/Q2a9sReI2
         iEbMumUbLPzjNUjS3yThN2eO+B0iQ4MnrI/sptepZwjtbkcaHYg7jQoKvqsPkbM7D0SB
         Fpoy4FF8BgBAJj3WvSIWD7K+ltvobR/KbVLpY0PxlkzlPC4gpzYtpIemzsf1Z5yGLiYS
         WZNw==
X-Forwarded-Encrypted: i=1; AFNElJ/qKLVcfZM47HMDGXxVD4mTMTSS98EIS/L6zlbGsIWGBSvYh89Bcpi+caU2HhSCsDuSiwc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqQQd5/Dmz1QB7m8r5j3NeiQyDwn/27hpCT8pTn7hIVbmjF+Fk
	qR6PU/FS9qv2fWGkpXdNISjImV/+2PGfJMBOeWO9KHIk3F6L756oNjut
X-Gm-Gg: Acq92OECZRrlqJwsZQBxPRz836GKLqVe4UQ03+87kOfNhCCZF0aKez+yMKwsaXLEvHM
	FI/KuQmXBPbIqtUU5DMwJ/dVtVLgOmyNa0dXDk7y43qc77MbuXYpQ8KlcEjLV0TBMPMHdP6ItlB
	LJ+uHQWe2Qh7miNuxf6EduJW+A3CqXEGv5iM7ugFR0TBUH2gOtEZEFrDJQhaoJrROQLZZ0F2j6H
	+5RfDhh3B107ywpAqAqj5Amwuq5ZG5Tz+X9Ym69KqFuOtLnT7+eOVbIscw/+4w3qULUIavuYdZa
	5IgnbTZ5JinGNMqaeYSiBm61oNRHnBSaXHpXgvbhVdeZAD+3L67/IOMh4ntFH5gopcUFqf7bP7I
	xXhukaV0w7p8BuVK5kgwPRnjnfY+l0hLbCxxg1BRK02SGsKJdlWITARtdvZ6slzKuCG9jtHdzuF
	tv3UCSf/cmb1Y=
X-Received: by 2002:a05:600c:4fd0:b0:490:3dc7:9778 with SMTP id 5b1f17b1804b1-490426d3f0dmr191593075e9.23.1779659670466;
        Sun, 24 May 2026 14:54:30 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4904526c926sm345299875e9.1.2026.05.24.14.54.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 14:54:29 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sun, 24 May 2026 23:54:28 +0200
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCHv3 03/12] uprobes/x86: Allow to copy uprobe trampolines on
 fork
Message-ID: <ahNzlAfUnymDDGOR@krava>
References: <20260521124411.31133-1-jolsa@kernel.org>
 <20260521124411.31133-4-jolsa@kernel.org>
 <CAEf4BzYo-8PAXFJt9MHoUn9ux1O2YVxJADC0tGSsacVu_R8Stw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzYo-8PAXFJt9MHoUn9ux1O2YVxJADC0tGSsacVu_R8Stw@mail.gmail.com>

On Fri, May 22, 2026 at 11:50:54AM -0700, Andrii Nakryiko wrote:
> On Thu, May 21, 2026 at 5:44 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > When we do fork or clone without CLONE_VM the new process won't
> > have uprobe trampoline vma objects and at the same time it will
> > have optimized code calling that trampoline and crash.
> >
> > Fixing this by allowing vma uprobe trampoline objects to be copied
> > on fork to the new process.
> >
> > Fixes: ba2bfc97b462 ("uprobes/x86: Add support to optimize uprobes")
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  arch/x86/kernel/uprobes.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
> > index 6824376e253d..11ec6b89b135 100644
> > --- a/arch/x86/kernel/uprobes.c
> > +++ b/arch/x86/kernel/uprobes.c
> > @@ -701,7 +701,7 @@ static struct vm_area_struct *get_uprobe_trampoline(unsigned long vaddr)
> >                 return ERR_PTR(vaddr);
> >
> >         return _install_special_mapping(current->mm, vaddr, PAGE_SIZE,
> > -                               VM_READ|VM_EXEC|VM_MAYEXEC|VM_MAYREAD|VM_DONTCOPY|VM_IO,
> > +                               VM_READ|VM_EXEC|VM_MAYEXEC|VM_MAYREAD|VM_IO,
> 
> so on fork we'll get sys_uprobe invocations which will go into uprobe
> trampoline and syscall will just keep returning -EPROTO, is that
> right?

so the child gets the inherited optimized call path.and now also the
trampoline, which executes the uprobe syscall and so if there's related
uprobe it will be processed

-EPROTO is returned for uprobe syscall executed out of uprobe trampoline


> 
> what would happen in the similar situation for process with int3
> uprobe being forked/cloned? Will it inherit int3 as well, and then
> will keep hitting interrupts that would just do nothing?
> 
> is there a way to restore original memory page for clones? this
> behavior (unless I'm misunderstanding) seems suboptimal
> performance-wise

the standard uprobes seem to handle this situation by removing the brekpoint
from current->mm, if the uprobe->handler returns UPROBE_HANDLER_REMOVE (for all
uprobe consumers) .. and the uprobe->handler does current->mm filter first in
uprobe_perf_func and returns UPROBE_HANDLER_REMOVE in case it does not match

this works also for optimized uprobes on top of standard uprobes

but we don't do that for uprobe_multi and I think we could do something similar,
the code is there, perhaps we just need to add the filter

jirka
