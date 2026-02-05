Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F253E8C6A
	for <bpf@vger.kernel.org>; Thu,  5 Feb 2026 13:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770299861; cv=pass; b=O15byBkNEUhfxg9AzfIhtIh2OX7XmYxVsNx3rpm5q0+JQlYpGIyP/rmLso45sF31szltV4KIphyMGVoGtIehDpLj+BUqpocUt6+q/dYdP5glKt5C9GPW/vlAYbZTg7ks7a93YdwZnJyUsekgnpiYQILaM3pqYrcpVnbQFNua4Ec=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770299861; c=relaxed/simple;
	bh=oadeknu5pggRVyIIVgA4TEeGW4cY+QtMhF+tlOuYHt4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YvnZlBfnBWEZ3oYsv+DqRegls6R+t3b4yZ1+LoqiNsJmPXCWx2dt3FVufGlX80sA9FzcP3ohyf53/udqAUChMi4gBwaKhwz8Y2T7yKACfVOvLqkeIspyt4P9DGdzHOsaib1DGEg4fnYY0XbpitOadVXVFZBuMiup0Sge20U6YrU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com; spf=pass smtp.mailfrom=mihalicyn.com; dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b=LQRhCHvu; arc=pass smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mihalicyn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b="LQRhCHvu"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-59ddb31ddcaso1295621e87.2
        for <bpf@vger.kernel.org>; Thu, 05 Feb 2026 05:57:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770299859; cv=none;
        d=google.com; s=arc-20240605;
        b=jrP2a873Q8TwqVGHAdgwWkqpPSd12c9HsdH56Xlf41ZZMGFoOPzjtZnLRieOatByoQ
         Xy+Y8HbiwK//7vUGdv2jTQ9bhhf97tA/m78g8GeYSWZnQNTMwgYOcEXIlFf9gJ4KMgI/
         ntc5OSnOFLbFEcKVkCX1hAcNyY5oxELKL62kxj92t3iJWozdj1ODRlhFFVs7pfrt+O9Z
         zWYmSbKSE+99uMM1gWZq9xfkREONNjVnYvPNYhl2rwgkd9EssPn3j4s97u6lnzDH2gKL
         ZFYg11q/khXy1K7oEmsKBdTY6wQ4BesGPT2dfNu89CMW/Trdty3S1rj1D0H/l2dqlkIq
         lzfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=0LNeuKL87GBX2RRx9untVeVZ+MuGVKScy/9f8vIzBNo=;
        fh=U8TVTdIz6n4mbCTFqNgQPisxZ2CcHxlV7MH6bNjfWZc=;
        b=Xn8v6+PG4lylxhxQ9pqGBLytR0WQXI7gBZ9U1QejjRFhV+63oXKZQ41TiGCwTXIArf
         MdYbqtLA63bhqqPA6r8eeYpoNp49CQ7I/g1Ru9P8bWiXw1BVeBsq+34/+vhesdAGNaX/
         mddQw5aIekiqA/yEa3Id2McUayRZnCRDQzqe5/P+Ltsdw5Wr/jwfEwoFEF0OashJ9gM8
         KVSc94WJ/AbMjH+VeSqGnwiJyMcRuOhQiuwr+I2e+dCxHL1+80eHGmfmLCK9WzwmfAX3
         SPgmrM+TchJlKuEEXo/gwpBvz8yxoJaQCDKeTS7OBdqqLOOv3RSyx/AlFdo988OKkis4
         AJYA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mihalicyn.com; s=mihalicyn; t=1770299859; x=1770904659; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0LNeuKL87GBX2RRx9untVeVZ+MuGVKScy/9f8vIzBNo=;
        b=LQRhCHvubT4bCozL6wzNLq9vmqb7ideKQR2ps/qOwoO8Cz/stavSm2U788sSx3A66e
         h8xdRlO7+oFfNBYt6PWo4YUgH7kbPZnNN5tsZtglmu6exYuHpkl6VJY+015sHsgO5Sj/
         h/6+zMYGiTB+WhmhIxofspCKeStGDFEmMMrK0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770299859; x=1770904659;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0LNeuKL87GBX2RRx9untVeVZ+MuGVKScy/9f8vIzBNo=;
        b=mpK1VrvusQa9/Ca79ZMSk41BfY5iIGrCz6395Ys70D9x0WSqdKaNZUYNysp26uxVN9
         23EKya/BUdKgkiqbAwwtaxM7Ss5qSdUFopw9syXzCVs/LizaMKq/mMwbFMKHdI+zhyPe
         DwRgLYfEl352aqk+IrwKTmPae9nxs2NhSOsSv1dK95sstudeUgygtBm5y3A493t6Zym9
         MeXBf6D8123HtVjtBB5FJzFfNhh3GISF0Rr9xseoUbRRjcanuovzmwu+fI7oH/D1TEcE
         8MC8hvDOEItv3j8MoT0YJl35YLD9mmSOvKYjXq/ZELtABVCnF23xL2aZOykwdB/Ygd1z
         mpaw==
X-Forwarded-Encrypted: i=1; AJvYcCW9wGE+gwr1R2dFfrFGKuuO8UZO0uEcDSJHGn1Dtnedbl18Z8RGeSjRqlcZgDgZftc00JY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBl15F6OJAw/tE9kLHGXRYa4lsP9lTNXDsq5x4SmNFubodpCVm
	bQgoKUiMB9vOX+KideclXLCazhgZXb/xMZpLE+W2HUzIqlkXOEJmZkpGwJAHf4G6t+HD9+LYG8i
	p8DzhEbvdpj1Avfg+Paa2rzqCyCB0ikxAsS/MVs3dfQ==
X-Gm-Gg: AZuq6aJEAYPiL604H6rlPogkqmNY3uBx5+fO+K/fQns5joGWYK/gomGe8k9wOpPJ7Ly
	SACSwCBsDM0np9AybWt93TbQPiEHL6xyAOuW2Pr7vzOtOgIjHS/VSIVPvUJ5sn3xVa6vZnRiFcS
	kPePGzCtiEI++hPqIgiElIaDR2Ql8ONw6Vyb4QzLDP3rJuY3gDAjh+mAyippEF0a6NXACtWjrMq
	4m2RK03HB9O7lvHQOnosxmMsNrbxSb7tZ+W6wOi74XnUbEEDdvmr2GPdLNw5h8BnKyRs+k6LT+E
	X2dcvkO3yxGqgrM11hmSdnimG/s=
X-Received: by 2002:a05:6512:acb:b0:59d:e446:c7a with SMTP id
 2adb3069b0e04-59e38c08e2dmr2659853e87.17.1770299858759; Thu, 05 Feb 2026
 05:57:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260205104541.171034-1-alexander@mihalicyn.com>
 <4502642b48f31719673001628df90526071649bc4555c5432d88d2212db3f925@mail.kernel.org>
 <CAJqdLrqRBhmrQQA0MA9f5Js6rTZkJFf6-=KT+eZahakgX4_3fw@mail.gmail.com>
 <174025c0-e13c-49a1-8835-5d971c024bb5@iogearbox.net> <CAJqdLroDeo2CFQA_BT_zV+1NC7WGBo_eb5xG1+hna7sOyAF_Pg@mail.gmail.com>
In-Reply-To: <CAJqdLroDeo2CFQA_BT_zV+1NC7WGBo_eb5xG1+hna7sOyAF_Pg@mail.gmail.com>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Thu, 5 Feb 2026 14:57:27 +0100
X-Gm-Features: AZwV_Qg2m06cnKHDUJ1VsUzeKU_0ovl-31-xmPMNyP6_BJpdS8SpPv67DcY3M-A
Message-ID: <CAJqdLrrqCxt4iS4m57G6fEEOPBkXsi81hmM_sb1WgQ_96K-qKg@mail.gmail.com>
Subject: Re: [PATCH] bpf: use FS_USERNS_DELEGATABLE for bpffs
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: bot+bpf-ci@kernel.org, ast@kernel.org, andrii@kernel.org, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, jlayton@kernel.org, 
	brauner@kernel.org, bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, aleksandr.mikhalitsyn@futurfusion.io, 
	martin.lau@kernel.org, clm@meta.com, ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"

Am Do., 5. Feb. 2026 um 13:49 Uhr schrieb Alexander Mikhalitsyn
<alexander@mihalicyn.com>:
>
> Am Do., 5. Feb. 2026 um 13:38 Uhr schrieb Daniel Borkmann
> <daniel@iogearbox.net>:
> >
> > Hi Alexander,
> >
> > On 2/5/26 12:27 PM, Alexander Mikhalitsyn wrote:
> > > Am Do., 5. Feb. 2026 um 12:20 Uhr schrieb <bot+bpf-ci@kernel.org>:
> > >>
> > >>> diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
> > >>> index 005ea3a2c..c350857b2 100644
> > >>
> > >> [ ... ]
> > >>
> > >>> @@ -1077,7 +1073,7 @@ static struct file_system_type bpf_fs_type = {
> > >>>        .init_fs_context = bpf_init_fs_context,
> > >>>        .parameters     = bpf_fs_parameters,
> > >>>        .kill_sb        = bpf_kill_super,
> > >>> -     .fs_flags       = FS_USERNS_MOUNT,
> > >>> +     .fs_flags       = FS_USERNS_DELEGATABLE,
> > >>>   };
> > >>
> > >> FS_USERNS_DELEGATABLE does not appear to be defined anywhere in the kernel
> > >> tree. A search of include/linux/fs.h shows only FS_USERNS_MOUNT is defined
> > >> (at line 2268), not FS_USERNS_DELEGATABLE.
> > >>
> > >> The commit message states this flag was "recently introduced", but it is not
> > >> present in this codebase. Will this cause a build failure due to an undefined
> > >> identifier?
> > >
> > > Yeah, this should be applied on top of
> > > https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/commit/?h=vfs-7.0.misc&id=269c46e936f3b5f2b6b567ca124d5f5ea07a371c
> > > in vfs/vfs-7.0.misc I think.
>
> Hi Daniel,
>
> > If this goes via Christian's vfs tree, it would make sense at least to open a
> > test PR against https://github.com/kernel-patches/bpf to run this through the
> > BPF CI with the vfs branch + your patch on top to make sure the tests don't
> > break.
>
> Sure, https://github.com/kernel-patches/bpf/pull/10970#issue-3901410145

All looks good, except
x86_64 llvm-21 / test (sched_ext, false, 360) / sched_ext on x86_64 with llvm-21
which seems unrelated.

>
> Thanks for suggestion ;-)
>
> Kind regards,
> Alex
>
> >
> > Thanks,
> > Daniel
