Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A81F3D349E
	for <bpf@vger.kernel.org>; Thu,  5 Feb 2026 12:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770295796; cv=pass; b=LsK+/6vuQWEZy0pax+wiCDWP8RBJVCsIspS/9boVMWIPSv++jRBrZvUUlPAf28pkg7QTz6Du9iRGIEXvn/XT1UfPlY0SxJbhbErDNS4c/jE15XP+1QF0MNrBe8WRKBZ/AJ2p8nRBBdJilLrhTTxoANTmR7Rs6k1lsH0SB0SlB6U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770295796; c=relaxed/simple;
	bh=0IV88BrpvTHgfPYK0mSBgTtEV2ZqRryzAk6hOcvufqM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TfLzkJiTa6Amv8JgGVL6tlNkebWPqyyXt0IbflIEe4ZUSPx8fZEpnvPs8iFMs1gy7Z6+3KlzaFKejQFwLPZ0wKYIB8cT3oYwcZjiUJCzChCXmQDXQTdIhEA8atHffGRRKlWQEdtBXtLCZzzj0IwwCpwszcgg3pNZMfzrJY1oUDo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com; spf=pass smtp.mailfrom=mihalicyn.com; dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b=AMOJ8QmY; arc=pass smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mihalicyn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b="AMOJ8QmY"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-59de66fda55so1179249e87.3
        for <bpf@vger.kernel.org>; Thu, 05 Feb 2026 04:49:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770295795; cv=none;
        d=google.com; s=arc-20240605;
        b=C2yn4HyJCFDmG6S6WjGKAm9HGS57SZUM/vG8itcSPXcddKn7KdbleKYyGRqn+q3Z82
         F0wuoezZhuJa/6QoHSUEELjGJmfsUMnNfK3yEEIuBhUIc1E/kjnpXJkY+mBVV1ae6Ror
         vlhCroJyznhTKumx8l9WJ2iw7aLKhhOpSk6wTcAaqFLvE+zmOK+JjS2O78MFHio49PzT
         ruiK+MYGLH/rUhKzvbjWauVAHNooM4CWG0DKD2KXRrAi9vX6yhMsIQcd+sDOcgJBAJ6Z
         SFlkHLTHr3HGkIvqWOaQZfBfDqzCXHyID1LAIF9pygGkSm03QYAODVkw8gnrLITFuC0z
         bRxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=xUfCxD01pAqNYSrDhfC2Admgs/AauiNaUapYDxklD98=;
        fh=rrPwd9UBJff7FdfxQhR7bYd+F705aZN77GVvZBdnk+Q=;
        b=Y7QiREISpXxOtvpVA6Gif4CvZAZp2sn0F1BX9e8Gq3Hw6oUHDur12AghewshT6EekL
         yxUDgvR9qGNoqFQ+ugZ1ZTEWO6PPAuLRtYAa001m14b3sqU8Dq7Oodx8rIM6xiTPqdyr
         7HZ7mgdx+y+6aW7dzQaGciDqLylatQyj2TKw5eWAOxsUCROPrlBAIHWN4IUqB6iSFAKN
         isW43tgkKKvm+AlIMmPvMDu5XomD6USxvo4rKUEz8udRxuD88h+RIiyYEB8zum8he1jH
         xk/rzLxjna5rY9uoLcvkMzmoAeJfBG0QEX7rlsHU+3v7Bw30m3GO/wFdI97+116lxvIb
         BHew==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mihalicyn.com; s=mihalicyn; t=1770295794; x=1770900594; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xUfCxD01pAqNYSrDhfC2Admgs/AauiNaUapYDxklD98=;
        b=AMOJ8QmY8pMPxFmJxn63DWhTbMBIESOEqGJS4IDlrWZL5PECLi+PBQ4TtaUWP7qr1F
         JtjlPV+xCKdFG0n2n0aMFNYKsFtl/0mtKeneFdUA2T7tA+qqw7znVN1zOCT5/l9Jh1s7
         7rpVCRM8A1VOmWub2IzpwoB4m0VQ6RYhdXz+o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770295794; x=1770900594;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xUfCxD01pAqNYSrDhfC2Admgs/AauiNaUapYDxklD98=;
        b=L9nHNztHY/aOFZBUZemZNPrTpLiamDojAzcFK6JICZ0nTrmPBGNS0v5fgFCFTXuyDA
         tfwQim9IiM2vWwWKCj8b/XCCdCvRmEKLjUaKzKPcCx29zKvF3Uheafjqpe7KNTCWzbi0
         m+ii0jUMwShOIDGe5oo/njEO9ODDbpgxtWjKAKk5xh2n7aM8eZPsoT+WzFn97njpwvWS
         50f9m3Zq8VyRCI0LK00RfUNIZaGhThEESaUPHb+s/j2vjeSqyNRxqtbcB9uIzCrXqmqu
         2YwUQF4M2cQw1ln4GIhSz7KdSSJEsEAqqOYO/YoDCsDfn29jp4BQW9NPh1UxBpYshuE/
         NHkA==
X-Forwarded-Encrypted: i=1; AJvYcCXIefesKplHfU43KpbVaHsJrFGUvePGAI7D+JuR+RUzyrnnBBFAa7UpbWzeI4R7V51CEdU=@vger.kernel.org
X-Gm-Message-State: AOJu0YylQ/va+yd/RQNOXoeJ+k70MfjYEvjuZPy6OK1HdDJPs4gI3M+w
	hiekT6Nu4UTsDweiG0XV78Z93H6IYBH4dH5QUfm6ld8FxvBdc8Ae57XbukE1sAoAej1o7alPi9t
	kNrepBINzvhGNiPFAjUjrhIKQ/oLdLX4BKUwB/ycfCA==
X-Gm-Gg: AZuq6aKk34/5rA67ipK0XldStLJEJ1ogfY8hKbkH3ao8n82iK8brME+nWx9EnuWiEGD
	RxoGAoPcupDEJdJ2Uz3LJt8tztDe8GmVguxnMdyHBTsJmqSwMThkS3n5agWU7fbX/ZPJ5GE1+lB
	YfvqqZQl/bXsxW9Lbh/Zuc8QfxbNDD3WYmLORpQtLbCp9gyz6Aia6YhYUZiRkg4plFuowV+ByqI
	6HxCFX214UiaSTSBzYsr/UHwMFU4V+1zXeG8iQDsgQ+N1pBA18qL58gotf9apcH4E91VIeC9rF+
	617Js1kBzieB7jN7RwPHXrEMvq8=
X-Received: by 2002:a05:6512:3c9e:b0:59d:f474:656b with SMTP id
 2adb3069b0e04-59e38c3b99amr2303693e87.42.1770295794441; Thu, 05 Feb 2026
 04:49:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260205104541.171034-1-alexander@mihalicyn.com>
 <4502642b48f31719673001628df90526071649bc4555c5432d88d2212db3f925@mail.kernel.org>
 <CAJqdLrqRBhmrQQA0MA9f5Js6rTZkJFf6-=KT+eZahakgX4_3fw@mail.gmail.com> <174025c0-e13c-49a1-8835-5d971c024bb5@iogearbox.net>
In-Reply-To: <174025c0-e13c-49a1-8835-5d971c024bb5@iogearbox.net>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Thu, 5 Feb 2026 13:49:43 +0100
X-Gm-Features: AZwV_QiBdeLrN6qoIZklCvfKrZACYbBqxhI-762jltOk6f5fGR71l2wgmgEW5PE
Message-ID: <CAJqdLroDeo2CFQA_BT_zV+1NC7WGBo_eb5xG1+hna7sOyAF_Pg@mail.gmail.com>
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

Am Do., 5. Feb. 2026 um 13:38 Uhr schrieb Daniel Borkmann
<daniel@iogearbox.net>:
>
> Hi Alexander,
>
> On 2/5/26 12:27 PM, Alexander Mikhalitsyn wrote:
> > Am Do., 5. Feb. 2026 um 12:20 Uhr schrieb <bot+bpf-ci@kernel.org>:
> >>
> >>> diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
> >>> index 005ea3a2c..c350857b2 100644
> >>
> >> [ ... ]
> >>
> >>> @@ -1077,7 +1073,7 @@ static struct file_system_type bpf_fs_type = {
> >>>        .init_fs_context = bpf_init_fs_context,
> >>>        .parameters     = bpf_fs_parameters,
> >>>        .kill_sb        = bpf_kill_super,
> >>> -     .fs_flags       = FS_USERNS_MOUNT,
> >>> +     .fs_flags       = FS_USERNS_DELEGATABLE,
> >>>   };
> >>
> >> FS_USERNS_DELEGATABLE does not appear to be defined anywhere in the kernel
> >> tree. A search of include/linux/fs.h shows only FS_USERNS_MOUNT is defined
> >> (at line 2268), not FS_USERNS_DELEGATABLE.
> >>
> >> The commit message states this flag was "recently introduced", but it is not
> >> present in this codebase. Will this cause a build failure due to an undefined
> >> identifier?
> >
> > Yeah, this should be applied on top of
> > https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/commit/?h=vfs-7.0.misc&id=269c46e936f3b5f2b6b567ca124d5f5ea07a371c
> > in vfs/vfs-7.0.misc I think.

Hi Daniel,

> If this goes via Christian's vfs tree, it would make sense at least to open a
> test PR against https://github.com/kernel-patches/bpf to run this through the
> BPF CI with the vfs branch + your patch on top to make sure the tests don't
> break.

Sure, https://github.com/kernel-patches/bpf/pull/10970#issue-3901410145

Thanks for suggestion ;-)

Kind regards,
Alex

>
> Thanks,
> Daniel
