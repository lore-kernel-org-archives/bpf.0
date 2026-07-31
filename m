Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584472D1913
	for <bpf@vger.kernel.org>; Fri, 31 Jul 2026 13:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785504819; cv=none; b=mDv/M33XhXc7eQuFH/UYtGSqMrEUrVQS4MTX01MHoyIGcEc2ru8oFNsId3hnbD5VLijPfaaJ7oUXaWT63NzzfH+pZ1tsxFWyYlZbKgxrVQuTP9DZt+4N3tDGdo8GBVErjal91KMuHU5vrSrpLzF6ao0jB4SIbwO3APmwq16J/nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785504819; c=relaxed/simple;
	bh=K7Jt/03j2E/nBWtbs3xzvPMx8diVxInfuo7eQUCGPek=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kkw/CXDV8lmm3n9RfeGHPFVG3Xjzw98X82zM+y2d6iLCdZBsDtJLViSibpID9IQv68RQraMNOAOdtVKe07+OfWPtkgs041nRXaFS5Mn7cNMjnQ5OBFl1YAWRau89LkhKpTBl1uqfoJJEpDKxA1hLJwg1xQ+45r/OzkBmXYMfFAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oHHonUc4; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oHHonUc4"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-69c7ab350e9so1642670a12.0
        for <bpf@vger.kernel.org>; Fri, 31 Jul 2026 06:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785504817; x=1786109617; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=nT/A7StUBJVo+5huVgI7XcKfAIWGaG1tCoqkKTZnw9I=;
        b=oHHonUc4H0XZ+DLtWfUdQNa8wXeaCN1Java/yVBLC670XC6UoFh/i0Kt4VnUYx2a+Q
         uLFd6jLZGRlkK3EhHEFob4v43VheVbcMxUqIoriMNJwQb+NI07Rhb22ZTA0OTC0M2t2G
         pXH/uYInxL7rolbalZeWh+eGnZxPnc1pJOFTJrAxB5cJCw3TDV425en7kGV7EMTdpdbW
         n8YdW+FSaGubXSYm9VdbfvFeRu9RikmV40VkCBDfY1ffF11SYQjXlnmnl8oIRVBAN86m
         fdTgsDAh/SiyHFE8O9xtE1uW4iz/MawYcC5+afIhygX7JypTXQzZwlBFvM++g03WMlJ3
         +r8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785504817; x=1786109617;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=nT/A7StUBJVo+5huVgI7XcKfAIWGaG1tCoqkKTZnw9I=;
        b=tDMhasI9ZhVcW8PkmTrp6lzqjA8oF72OC1GVPkapqG0aWvR7M5R1FPyDvE1d5nteik
         +UiGoxur/6wnAU6kNaEmuPSH17XP1RvEy+dlCiC11IvQZf0FUL7vcC+N4M05lXefDztt
         8eEuKbq2T9Lb/A6EHQQHyYD3qVGG/CdJDYvxVd4iK+EXqlW2ozWTNAf10r/JQSphKuS2
         7DL+kcC0qomrSZnLEqTvr7CVv3bU+gVRUpygvYdaXen94/YMZcon+uj6CYKcc5rf3uRG
         vYJ2vasl7dcEwqQ6DOT9NE2U9Pw8oVSqDBew5Ps7RcQqumF+NiICYSUq+68DvBsNIPif
         A0mg==
X-Forwarded-Encrypted: i=1; AHgh+Rr6YneZurpQQltBEGkgFvsYlYgqPnA178T1hptlNgY8B8/9I7xJWeY2dKhGjak1Ohm8qMc=@vger.kernel.org
X-Gm-Message-State: AOJu0YztDrVuIv/fRrXMWQTju6V8AqPuzk3mhVLLxXWw3M6gxTKy9S8M
	kUpVFdApNzkZZjWRz4aEPwMZxy38vnJTykfZsf+gmQmMJJc9qDhEq3do
X-Gm-Gg: AR+sD13YnajP//2HeFDL+ZHWHj57aiwubp8zogUxGDgQh81zoH15WNUcYguseGuP9RR
	A5Wt/bu82yhaPTmXM2gm5f0p51VySlofjtLNBK3WgJxYHuN1nm+uCzV6OusN2wev1BWHjUHOZR+
	fNQ7Neh/ApY6GZmz8+W5rnoh4ydg309q015JG0j/Nyt0XsOOZBGHGNkYFtfyz2pKLvNCZniHFVY
	00UNBcOQUxdcD0siegZOMGfWv0H/S76zNiDMVfZ5A9w9mX8DEZ850Js08IKnhArSc8hi0nCEpvD
	dq/Xyk3fY0Of8caL96lQpE3b8xyhbIYnw9xbcI0fxP0Xs9TKvEblTT92LnN/QQBvo4ZPjiLaeZ5
	io6lpvXe6k26Enm5y6GzihjmAFz/k/ykARPbVLdL9RvUseRB60vT708HowVdnSArmH0PgiDf/gd
	nfMf1jk30ByUPmaMGEtg/w0byA3M/WKcK9CVMO/2LS8T/OaGvnAFdMIPS+KA==
X-Received: by 2002:a05:6402:528e:b0:69a:9355:d1ca with SMTP id 4fb4d7f45d1cf-6a098d0d7e8mr1070663a12.42.1785504816272;
        Fri, 31 Jul 2026 06:33:36 -0700 (PDT)
Received: from krava ([173.38.220.53])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a09c6551cbsm1467494a12.20.2026.07.31.06.33.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 06:33:35 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 31 Jul 2026 15:33:33 +0200
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Sashiko <sashiko-bot@kernel.org>, bpf@vger.kernel.org,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	Quentin Monnet <qmo@kernel.org>, Tao Chen <chen.dylane@linux.dev>,
	STAR Labs SG <info@starlabs.sg>,
	Arnaud Lecomte <contact@arnaud-lcm.com>
Subject: Re: [PATCHv2 bpf-next 11/11] bpf: Clear buf on error in
 __bpf_get_task_stack
Message-ID: <amykLSjSzayP4WHa@krava>
References: <20260729083807.1588544-1-jolsa@kernel.org>
 <20260729083807.1588544-12-jolsa@kernel.org>
 <CAEf4BzYvmVJ7bFZ_dmW-HbwwM1yUxzs40yHNdF_JTn+Hr+0w4A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzYvmVJ7bFZ_dmW-HbwwM1yUxzs40yHNdF_JTn+Hr+0w4A@mail.gmail.com>

On Thu, Jul 30, 2026 at 04:11:02PM -0700, Andrii Nakryiko wrote:
> On Wed, Jul 29, 2026 at 1:40 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Both bpf_get_task_stack and bpf_get_task_stack helpers that use
> > __bpf_get_task_stack have buf defined as ARG_PTR_TO_UNINIT_MEM
> > argument, and we should initialize the buf on every return path.
> >
> 
> why "should"? what's the point to initialize it to all zeroes if we
> failed to get stack trace? we shouldn't allow grabbing stack trace
> without CAP_PERFMON, and with CAP_PERFMON we shouldn't be worried
> about "leaking kernel memory" because CAP_PERFMON is plenty privileged
> and allows to access any kernel memory.

hum __bpf_get_stack already clears buf on error, so I did not question it ;-)

there's this comment:

        /* Pointer to memory does not need to be initialized, since helper function
         * fills all bytes or clears them in error case.
         */
        ARG_PTR_TO_UNINIT_MEM           = MEM_UNINIT | MEM_WRITE | ARG_PTR_TO_MEM,

IIUC from verifier POV bpf_get_task_stack switches un-initialized buffer to
initialized regardless of the returned error and such buffer could be then
passed to another helper that allows only initialized buffer

jirka

> 
> or am I missing more reasoning behind this change?
> 
> > Adding missing buf memset for __bpf_get_task_stack fail paths.
> > The __bpf_get_stack call does clear the buf properly.
> >
> > Fixes: 06ab134ce8ec ("bpf: Refcount task stack in bpf_get_task_stack")
> > Fixes: b992f01e6615 ("bpf: Guard against accessing NULL pt_regs in bpf_get_task_stack()")
> > Reported-by: Sashiko <sashiko-bot@kernel.org>
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  kernel/bpf/stackmap.c | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> > index f4827afbfed9..9ab0c2523a41 100644
> > --- a/kernel/bpf/stackmap.c
> > +++ b/kernel/bpf/stackmap.c
> > @@ -890,14 +890,17 @@ static long __bpf_get_task_stack(struct task_struct *task, void *buf, u32 size,
> >         struct pt_regs *regs;
> >         long res = -EINVAL;
> >
> > -       if (!try_get_task_stack(task))
> > +       if (!try_get_task_stack(task)) {
> > +               memset(buf, 0, size);
> >                 return -EFAULT;
> > +       }
> >
> >         regs = task_pt_regs(task);
> >         if (regs)
> >                 res = __bpf_get_stack(regs, task, buf, size, flags, may_fault);
> > +       else
> > +               memset(buf, 0, size);
> >         put_task_stack(task);
> > -
> >         return res;
> >  }
> >
> > --
> > 2.54.0
> >
