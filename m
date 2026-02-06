Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8D93AE6F7
	for <bpf@vger.kernel.org>; Fri,  6 Feb 2026 12:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770381869; cv=pass; b=Pzn0DDNH3TxtFmWshWnqoSCdKId8IKy0/LgY5HoX/nt4/ii8hY+HMGD4XFRmzr4pbEbt80OlPrM7T772jr/woa09miOckszr09uGiPNu4XovGzOYWLUGqFuNZw8ssu/u2TmeeToWbrUrDBmTZqr96ioQ7Jk1vzptW0mxwQA4+B4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770381869; c=relaxed/simple;
	bh=3mw8uJP0ZIcDNqYKhNkrQSFVmjQSE9rgWbRnkN5Bt+Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SYpo6FLPCEEIlbOxCqumhYjwgOSF9jk5m2lTG616qmxNcv+nXqk6ra4ObzT7A+VeUHdTyCJVYREOwG0eXQv7u1DaDThx94tytDPreutL4ZKkN/a05TdT0pJUSSESVu/cZZhWq0E2qbnkhCHMYFTb1tTLir1/eVja9JCaiR5JmAI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com; spf=pass smtp.mailfrom=mihalicyn.com; dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b=I9W7zIIs; arc=pass smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mihalicyn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b="I9W7zIIs"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-794f281eb04so22168097b3.2
        for <bpf@vger.kernel.org>; Fri, 06 Feb 2026 04:44:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770381868; cv=none;
        d=google.com; s=arc-20240605;
        b=Y19mhj73sCisyjC5MUH/3ugL9Bb3jYwilW3KbToJm4jSlX7K5koy3X2ZPehOwyNofC
         U55fM9ItP5bLzh15w1dhOJseEDlk+p6rBo1CqiwzvLD/u7DK3EUUr/zM83VtyB0jznU9
         AoFTYei6WwRwUnClMlED8XCYPoYfhIjWD68+QtDIMwq9ITvvuk4s2pyBUczoNw92inX+
         O1InK2jNzHEBNN3HYTo1qAbp/3hmJAI2pnff4d155SumbZRHYiaB24hyQbg4CMc1FSAq
         JQz2E34L5+hAYV7WePs+gM4b9ZkdsgY97k9VaeYG26woFv2ZmZ3BafUH4+PhFbfUlTP5
         i0Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=gi3nJRbnTdHkSlsltmqaPF5ojrlDv3hokMB+vZDqhcw=;
        fh=uyoXyA3FVuX3zOI42JOfyTjScZi/OGvvS5hMCYgy5kU=;
        b=GJYdQFmJDDMvYC5I4khEDABKgJ2tG9nFLsYdyH4R46zcX7+/dwS/MV2SHq6AfeK9y9
         o3hXr9S2iItMGp9UbfTX13NHjmxtb572mRpa+0oLzKSOUjUHRux1QN8OyQ08RqUI9UTo
         CIyGwt/d+netS8msVPBa8/lAcaQWKGptdfqMIs67rtFcynxAUS4zlYl+uRrQkpsGkEub
         yWYw52NXSbAnFHAnNykKsXeEOZmCw2uQcOewbOrd/LGnE5mVtSflIGXp+XtW0UvM8pve
         4exIVUCuCeoGfpC8cJ/2lwUsov/wa49ZRz2D/DRrWrWR05XSIno8l5M19m7UZuu+Hvey
         Dw8Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mihalicyn.com; s=mihalicyn; t=1770381868; x=1770986668; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gi3nJRbnTdHkSlsltmqaPF5ojrlDv3hokMB+vZDqhcw=;
        b=I9W7zIIseqoqUxW7SbhJXiGhjf6rafdA6zBBij5gQs6oxa1Ll6o+HclXVxD5krVu2g
         Lexl4gtI3mPOPS9jJY7xuO2T3wIx8/ZvI8o7KZRgWzzUCP8awlKRjL6p2CmoyQOjAoxb
         8iZUzBUBA/QrixGrNWHw4DxjFIT/Q1p+LEzTA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770381868; x=1770986668;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gi3nJRbnTdHkSlsltmqaPF5ojrlDv3hokMB+vZDqhcw=;
        b=r+/pkzICOsKTe8WtiRmotqF3hnYr/shEfUy9eOgAlMcUPLG1bJmLlIyXyscMN3+WTa
         bwZmcms/L66ZHH1FNgcKzfzuGz1bQc1jRxG3lKSVI0lmyHxshcdZfkM27odvFc3IvMZI
         DdVIOHo6vJ9rvq5gBxNyLnA8BXFAt0BEZuWbUZNvYEVTdbN1khNM8tzH05Np+4sJqhpY
         gyZwhnshMExuLNexuxxuOo1ehtG1v73JjEnUvX7UmkVG6eWt1sf9lr9XKaITPIp2KjvR
         CfnSPhld/6RVgSpv6543Cdy6lLXOn8kKRp/KV5mg3WyM2TQGZ6UpNfTOyIe+9dWCk8Nn
         EhVA==
X-Forwarded-Encrypted: i=1; AJvYcCVB31MD7xOpzgwQTjfLq5Uf2VxA8m/+CRLsvm0PcOo/iaugwIeMy/B9e1UByr/oSIhXWoY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5NimrGV2yV2ogvCmcKGDRPI9YiDaXuAxA6w80kGh6QOH7XDEx
	L0L1LdG2YrXb0VMrdnXXCYd54gf/3gDYLR62e3LcaLAAapn6hUIm1yUNlQcxEfkNzKNDp1Ij1Uf
	G4ChAXOLCchb7PFJnPY6kgxVTZQ+c9J/eVL7GaY0WVA==
X-Gm-Gg: AZuq6aK6JW8A27zSgku6wJYWraQLp7To7EynMXuUp9iRNT6iDgmOxorQXJJNx/0g25g
	aQxAmA6mm6+vU/sN+j6I9+nm07ladeT0w9WH2Twefkm8FvCnNRWe1xvURd2kvFN2DaYt/PLs+io
	Mljfqm0/87YftitaU6O2iM7FFALwU0vNhQMh6FydaYv6nTIgOO0wzxdibwxG/S3anLUc7JsRMqt
	MpOSMlzslJp/WexdeA03AZQrUDaAcArk/Td/gDtN3uHWqz1u+Y29uzaDx8mAzZMuPLv8O++N5Yt
	Cr/BDqImET/eqlDorX3Ps5s5u/M=
X-Received: by 2002:a05:690c:39c:b0:794:ef94:1222 with SMTP id
 00721157ae682-7952ab57b30mr48502987b3.55.1770381868226; Fri, 06 Feb 2026
 04:44:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260205104541.171034-1-alexander@mihalicyn.com>
 <20260206-gelenk-gierig-82ad15ec8080@brauner> <CAJqdLroezjW2qe+1CNykwhFc9OO7uGADzc6ffjZzvyVOxLjXVA@mail.gmail.com>
In-Reply-To: <CAJqdLroezjW2qe+1CNykwhFc9OO7uGADzc6ffjZzvyVOxLjXVA@mail.gmail.com>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Fri, 6 Feb 2026 13:44:14 +0100
X-Gm-Features: AZwV_QjKPM44JjJR4PKgkXJKTIpISniJnOL6jzJRVFwiWxRMDOew-ykuozR4V5U
Message-ID: <CAJqdLrrU-iJcSg-pA_L4iZLkt6Xd2Ju5=C3x71QZmB9X4zYtsQ@mail.gmail.com>
Subject: Re: [PATCH] bpf: use FS_USERNS_DELEGATABLE for bpffs
To: Christian Brauner <brauner@kernel.org>
Cc: ast@kernel.org, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Jeff Layton <jlayton@kernel.org>, bpf@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Content-Type: text/plain; charset="UTF-8"

Am Fr., 6. Feb. 2026 um 13:42 Uhr schrieb Alexander Mikhalitsyn
<alexander@mihalicyn.com>:
>
> Am Fr., 6. Feb. 2026 um 13:33 Uhr schrieb Christian Brauner
> <brauner@kernel.org>:
> >
> > On Thu, Feb 05, 2026 at 11:45:41AM +0100, Alexander Mikhalitsyn wrote:
> > > From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
> > >
> > > Instead of FS_USERNS_MOUNT we should use recently introduced
> > > FS_USERNS_DELEGATABLE cause it better expresses what we
> > > really want to get there. Filesystem should not be allowed
> > > to be mounted by an unprivileged user, but at the same time
> > > we want to have sb->s_user_ns to point to the container's
> > > user namespace, at the same time superblock can only
> > > be created if capable(CAP_SYS_ADMIN) check is successful.
> > >
> > > Tested and no regressions noticed.
> > >
> > > No functional change intended.
> > >
> > > Link: https://lore.kernel.org/linux-fsdevel/6dd181bf9f6371339a6c31f58f582a9aac3bc36a.camel@kernel.org [1]
> > > Fixes: 6fe01d3cbb92 ("bpf: Add BPF token delegation mount options to BPF FS")
> > > Cc: Alexei Starovoitov <ast@kernel.org>
> > > Cc: Daniel Borkmann <daniel@iogearbox.net>
> > > Cc: Andrii Nakryiko <andrii@kernel.org>
> > > Cc: Martin KaFai Lau <martin.lau@linux.dev>
> > > Cc: Eduard Zingerman <eddyz87@gmail.com>
> > > Cc: Song Liu <song@kernel.org>
> > > Cc: Yonghong Song <yonghong.song@linux.dev>
> > > Cc: John Fastabend <john.fastabend@gmail.com>
> > > Cc: KP Singh <kpsingh@kernel.org>
> > > Cc: Stanislav Fomichev <sdf@fomichev.me>
> > > Cc: Hao Luo <haoluo@google.com>
> > > Cc: Jiri Olsa <jolsa@kernel.org>
> > > Cc: Jeff Layton <jlayton@kernel.org>
> > > Cc: Christian Brauner <brauner@kernel.org>
> > > Cc: bpf@vger.kernel.org
> > > Cc: linux-fsdevel@vger.kernel.org
> > > Cc: linux-kernel@vger.kernel.org
> > > Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
> > > - RWB-tag from Jeff [1]
> > > Reviewed-by: Jeff Layton <jlayton@kernel.org>
> > > ---
> > >  kernel/bpf/inode.c | 6 +-----
> > >  1 file changed, 1 insertion(+), 5 deletions(-)
> > >
> > > diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
> > > index 9f866a010dad..d8dfdc846bd0 100644
> > > --- a/kernel/bpf/inode.c
> > > +++ b/kernel/bpf/inode.c
> > > @@ -1009,10 +1009,6 @@ static int bpf_fill_super(struct super_block *sb, struct fs_context *fc)
> > >       struct inode *inode;
> > >       int ret;
> > >
> > > -     /* Mounting an instance of BPF FS requires privileges */
> > > -     if (fc->user_ns != &init_user_ns && !capable(CAP_SYS_ADMIN))
> > > -             return -EPERM;
> >
> > Jeff's patch does:
> >
> >         if (user_ns != &init_user_ns &&
> >             !(fc->fs_type->fs_flags & (FS_USERNS_MOUNT | FS_USERNS_DELEGATABLE))) {
> >                 errorfc(fc, "VFS: Mounting from non-initial user namespace is not allowed");
> >                 return ERR_PTR(-EPERM);
> >         }
>
> Hi Christian,
>
> >
> > IOW, it only restricts the ability to end up in bpf_fill_super() if
> > FS_USERNS_DELEGATABLE is set. You still need to perform the permission
> > check in bpf_fill_super() though otherwise anyone can mount bpffs in an
> > unprivileged container now.
>
> Yeah, this is what  mount_capable(struct fs_context *fc) does. I'm removing
> FS_USERNS_MOUNT so know it checks capable(CAP_SYS_ADMIN), instead of
> ns_capable(fc->user_ns, CAP_SYS_ADMIN).
>
> No functional changes here.
>
> >
> > So either Jeff's patch needs to be changed to require
> > capable(CAP_SYS_ADMIN) when FS_USERNS_DELEGATABLE is set (which makes
> > sense to me in general) or the check needs to remain n bpf_fill_super().
> >
> > @Jeff do you require capable(CAP_SYS_ADMIN) from within nfs? I think you
> > somehow must because otherwise what prevents a container from mounting
> > arbitrary servers?
>
> Same point here. We have this check in mount_capable(struct fs_context
> *fc) already.

And of course, I would never send a patch like this without testing it
for unprivileged
user and without ensuring that it doesn't cause any obvious privilege
escalation ;-)

>
> Kind regards,
> Alex
>
> >
> > > -
> > >       ret = simple_fill_super(sb, BPF_FS_MAGIC, bpf_rfiles);
> > >       if (ret)
> > >               return ret;
> > > @@ -1085,7 +1081,7 @@ static struct file_system_type bpf_fs_type = {
> > >       .init_fs_context = bpf_init_fs_context,
> > >       .parameters     = bpf_fs_parameters,
> > >       .kill_sb        = bpf_kill_super,
> > > -     .fs_flags       = FS_USERNS_MOUNT,
> > > +     .fs_flags       = FS_USERNS_DELEGATABLE,
> > >  };
> > >
> > >  static int __init bpf_init(void)
> > > --
> > > 2.47.3
> > >
