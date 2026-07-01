Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5E0394EB7
	for <bpf@vger.kernel.org>; Wed,  1 Jul 2026 22:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782946483; cv=pass; b=aK39B26TOzow3mXiT0U1fkslQLJ3qHC+5aO93TYm+wQRGPZ5uAOo/ojYIF2yAI9YtH46AzmyEzC3tGXkCYztho7LNHnRp5/21v74KX5zF/+PsSQPCNyB5ghFxC8a7jT5iUvd0Z+Te6aV/iwt9k+Ue0WTDO3uUgHcz/jiWbbwE9M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782946483; c=relaxed/simple;
	bh=YrHz8YZ43CxSfARfvrAgifJB6HE6igo+tpoQ1A+WQNI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rh+sxZKWNwqKYj8l27ukG6f9jlXY7AGUfnCTO8AWmT1GWdHsPfTJ0rYeD9jfEpDD45/Ixc3FcdDP97QMm2+ze/yicgGS6WSOTvBE+Ia1CS1wEKMDzMrCaZuTBBf+RgVG5MLgdb+xGX/PVR8GLxq5s2XilyexRjOPLQ/ZT64bFZQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oe0D4n6h; arc=pass smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oe0D4n6h"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-8ee43b3e5abso7956236d6.3
        for <bpf@vger.kernel.org>; Wed, 01 Jul 2026 15:54:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782946481; cv=none;
        d=google.com; s=arc-20260327;
        b=A5ZUEat22kyxSpWIX4lLExsNPRy1LdMNkiDfEZGJzRx1Xk1DN13RKu6R5GIQBCPyhH
         FvVU+fL3SGTHN5Ts2keoJbGc1LC4BsIhrqzvoUisJDWDT6rLH55LW4b3H6STxXDfiHUE
         glwCD9yZEEcOTZ7kWM6T0j4WtAsd8wZq+yCVr+jS6YOZywiGQM0XoPE4zYbVAP71FAWM
         MJH4sINxUxnOSr9IlG4n6bdAc9LxqvD2dnBzIjZ1L0Ak4ZhFIYSASE3SBmyHn3AH1rDO
         NEviNqFIjIRjL6+Esgnx208vdGmfHdI71tMmCgf6PbJEWQNMJuRFnFRlhMfONx26kgms
         srdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FdFRIxxhmjTBAY4g/1wOYGYHr9cH8lfvdG8YM/zsTzo=;
        fh=S6DDseF5h3+g4zAU2M40h9tycaIPHDMVdwvfM/5iAnk=;
        b=RK+x6OtmE1LhdwIwmIsoBax0sbt9/FJnXVta8xu1zHKTUDCHfQPt6hNJZLrvDm9klo
         J9uYa4TjHwqu4g+l2MuodMorFYMix6w1Z9/oVrbCVeZhjSNCDz4yaDFTASuseDEp71U0
         lhUGDTMG6yggIvULQhHdILKinobksz+GTtne0496RzKYkP4gSINsziQ//5JpXUvpmC0l
         6lLrwfEN2ZB1et1raPboY5ALyuw3jtROIKi10RBMy50Sp7+zCKBVTMHkCjRXm+oS/+ee
         ycpEoGck3hlw8TvpwmxBdKAlQzLh/AXOfFUI3NWiEKoeYuqro2jECooVSn9Fs46c+P8y
         jp8Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782946481; x=1783551281; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FdFRIxxhmjTBAY4g/1wOYGYHr9cH8lfvdG8YM/zsTzo=;
        b=oe0D4n6hhppkiuohBMlsVwdoy+x6uP2UpPjgSx00nukU2I5NpdT6+DerAhcWZhs7aG
         FS4+SdR697SwCb6zjN5Tu6ksC4Dto92B5VlZX3VITT+Fko0bpl4/LOBOU3VPW60hOXPA
         RRrre8RBxmnO+upfTpkSqgb9MvP4qPAXT2WXWP8oOUx/CjG4RDQRhwD9/AGP8u5QwSa2
         ylYd24ruCGEoAgOuXhYjbOynmq3WMlMzH2IU1ZQX1wXrqtOeW7LO3xeDagvHHicyLI3A
         /zGc6CPl0F0ixLzuJK27Gqk3gH7vT1mX2fmYAaEq6cGhQtfK7yKTk5UHqZJcx9IdmWeP
         XQ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782946481; x=1783551281;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FdFRIxxhmjTBAY4g/1wOYGYHr9cH8lfvdG8YM/zsTzo=;
        b=U6WOKU+CIVOicVnMnyP9aE/EDRcbXRiztcaEF93ThK8YJ5bvX3awyBFFVFGhQ4QnZ+
         kY01qTQ0OXuZLHK+tRmIXHdP0SAbeiRDsMobv8pvNso++Ihkkf84yE30BeT0tCB2tVSJ
         D47MUDntkSLmEpCMSuDuel3kbsu7pke1IdU/EAqJHPZEnbRXnsJx6cjY3FkRxiB1DavP
         78aGtAjnmuGIZ0M/Qfq9grEPk6+sGt/SA6wppCz3bd8kjJ29GRBcHf4G60VdLhzu4tir
         33WNw+XgTncjzXP15+ZrYIuPwjWzHKLlxLsViCzAYo0wSfsnJFjW6Vf6oFRErIguLeZO
         VSVg==
X-Gm-Message-State: AOJu0YwWUwsJITqvRT7mDI+qleKaH80QjjzWW8Ce051piOiEC0fncjMu
	pgBW6SYUr1Fpl9pIvAL5hA2WZ14jyxvdb79Fk72JhvCRu/LPc32ZSFqJM7/Cp8lkOwy91WbUKoz
	YXghtFoHyoOMTAacw1vKA10vGK3o4+Y/9jEi9
X-Gm-Gg: AfdE7cl0xxCrc7VwNwhLeQVVFHr/0Mj8Ie1lIv8Sgzb7FEYqTDi48YmDRxwt76x1B5Z
	f6u/QjJMBgSUB0Z70pLv6BDaX5xGaAVjcs5HYkaied9FcE3a20VBTiS97ilxg2Rej7VYAFdTEsy
	Sc4RLDKi/AqbcVicQ2sI6QPBWOLjY4VxLli4mbX1vV2kMzwDL7K/WPeZmxZfsTkwxQIclp1qTqI
	JAcoQPTVB5wPyOtcUSzVAH9ulTiYbK7frnsB4Q/vCVQnuxWQGz5wiNRVRGv2q+Tdl2aMaIBkdd+
	oYW9eFNLLEz9tfF1jQ9eJpPUhkU=
X-Received: by 2002:a05:6214:5703:b0:8c4:edb4:a44a with SMTP id
 6a1803df08f44-8f3c73b6003mr55971746d6.23.1782946481604; Wed, 01 Jul 2026
 15:54:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260630183956.281293-1-dwindsor@gmail.com> <20260630183956.281293-3-dwindsor@gmail.com>
 <20260630185420.96A6B1F000E9@smtp.kernel.org>
In-Reply-To: <20260630185420.96A6B1F000E9@smtp.kernel.org>
From: David Windsor <dwindsor@gmail.com>
Date: Wed, 1 Jul 2026 18:54:29 -0400
X-Gm-Features: AVVi8CfjKMOaPkHqrop8tSk9s7QdUaQXIvtbHpp2DcyirtgW-I3jIDr4KPnWk_s
Message-ID: <CAEXv5_iqNay39fp_2jJjxWUpfzBtfiUgpfo5-TYysrLMGEfNGw@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 2/3] bpf: add bpf_init_inode_xattr kfunc for
 atomic inode labeling
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 30, 2026 at 2:54=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
> [ ... ]
> > @@ -385,6 +463,7 @@ BTF_ID_FLAGS(func, bpf_get_file_xattr, KF_SLEEPABLE=
)
> >  BTF_ID_FLAGS(func, bpf_set_dentry_xattr, KF_SLEEPABLE)
> >  BTF_ID_FLAGS(func, bpf_remove_dentry_xattr, KF_SLEEPABLE)
> >  BTF_ID_FLAGS(func, bpf_real_inode, KF_SLEEPABLE | KF_RET_NULL)
> > +BTF_ID_FLAGS(func, bpf_init_inode_xattr, KF_SLEEPABLE)
>
> [Severity: High]
> Does marking this kfunc as sleepable create a risk of deadlocks?
>
> Since the kfunc is only callable from the inode_init_security hook, marki=
ng
> the hook as sleepable allows BPF programs to trigger page faults
> (e.g., via bpf_copy_from_user). When a file is created (e.g., ext4_create=
),
> the filesystem acquires a transaction handle before invoking the hook. If=
 the
> BPF program triggers a page fault, it will attempt to take mmap_read_lock=
.
>
> Concurrently, another thread doing a write page fault (or mmap/mprotect)
> might acquire mmap_lock and attempt to start a transaction (e.g., in
> ext4_page_mkwrite), which blocks on the transaction handle held by the fi=
rst
> process. This creates an AB-BA deadlock between the filesystem transactio=
n and
> mmap_lock.
>

This is real. We can eliminate the deadlock by removing KF_SLEEPABLE,
which is fine here once we change the single allocation made by this
function to GFP_NOWAIT.


> >  BTF_KFUNCS_END(bpf_fs_kfunc_set_ids)
> >
> >  static int bpf_fs_kfuncs_filter(const struct bpf_prog *prog, u32 kfunc=
_id)
> [ ... ]
> > diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
> > index 564071a92d7d2..1c3f84a924203 100644
> > --- a/kernel/bpf/bpf_lsm.c
> > +++ b/kernel/bpf/bpf_lsm.c
> > @@ -315,6 +315,7 @@ BTF_ID(func, bpf_lsm_inode_create)
> >  BTF_ID(func, bpf_lsm_inode_free_security)
> >  BTF_ID(func, bpf_lsm_inode_getattr)
> >  BTF_ID(func, bpf_lsm_inode_getxattr)
> > +BTF_ID(func, bpf_lsm_inode_init_security)
>
> [Severity: High]
> Is it safe to add bpf_lsm_inode_init_security to the sleepable hooks list=
?
>
> As mentioned above, marking this hook as sleepable permits BPF programs t=
o
> take page faults from within a filesystem transaction, which violates
> filesystem locking rules and can freeze filesystem operations.
>
> >  BTF_ID(func, bpf_lsm_inode_mknod)
> >  BTF_ID(func, bpf_lsm_inode_need_killpriv)
> >  BTF_ID(func, bpf_lsm_inode_post_setxattr)
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260630183956.28=
1293-1-dwindsor@gmail.com?part=3D2
