Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC043ACEF2
	for <bpf@vger.kernel.org>; Fri,  6 Feb 2026 12:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770381751; cv=pass; b=YXFee1vaQLTtZf2uVIxmzsmXLS4YOaJ7BNi9iRNuzTHJP3kW1CaCgiyUwt4pUHXLZC2gDxS4y00t/pve0ms6uXTlla7RbiOVpwUWbg21ngGcl6t5DX2T22QiL+4ZJ8aoUvqj278ot3LCTr3nso7I5hj79AAnrP2lMLl3pWvHl60=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770381751; c=relaxed/simple;
	bh=zdhBWmvj+JKFWU/nHEjqvB/HzAnQKmeTgyhMS0D9RWw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gJpzXIArMjLGrVTLy+TyIRfFSsak53fxUuvxkYy1eLcgsIY6orHxCaYdVd4+ef3FJcGwBaESBd6iv2miS/2yed8TsJ9+TXyNmpmXUxn+qHW1I15CLK/iuBALSWe5bmqVEGq61cNzh59PtxTwtqksG0BGlHkU+hj69dx6aI3t8ws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com; spf=pass smtp.mailfrom=mihalicyn.com; dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b=TqnNaZCJ; arc=pass smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mihalicyn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b="TqnNaZCJ"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-59b6d5bd575so2139117e87.1
        for <bpf@vger.kernel.org>; Fri, 06 Feb 2026 04:42:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770381749; cv=none;
        d=google.com; s=arc-20240605;
        b=LF9gOE/mK1JAzQ1pnEjS+N1Y5HiNac6KVRnUaumIqS6XHkHDFn5nI6uM+/FVuoWVGR
         J0IPGqeNEy6KbiDyrdeZVr6jXD46nnoundUCzX1X6nuFxcWJfQDLVP9SchAL1gJ0RNEq
         d3ttX8mtsjauTyBZnUrslG84i7f2Tnpg9fuIpi6jAElnRvAG1jqUZfWZCtOOowMlBWsk
         O84dOg/6HubTbo3o2R51n1/ND8Tx/TIMLg/t5R7mQ84JzDNXeyx5J23kBZUkGX76uCj1
         ZLh/xoe8UOhjOtFdTEWYe7t2RRXzcab2dy4JXgAjDjj6kzwdhpdlv+SBsz8zaxbFdI8v
         9D4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=pILuumm4s94M5+C2aJ63ms278oe7itYtLuvXSi366vg=;
        fh=T8e2i69DcevrKc8oK8jC/Tx6uLQ44CTCseu9gxnj0bg=;
        b=XS6LztNOSIvMsJwaeGtiINy5BIZPs9zUU5FWWl+15PYH4Gl5momFEIwIZgGXERlmeQ
         Pl5WW/mVOc6k0tJx0t5eoOe2mpZve0aSib8ocUgGgqWEsvPWejRe4dfx32q5LL9HiPkj
         QvGn1mZegYwHhXle2N/xOvL3Gwy/W1TaJcp1iEZy9/L1pD7E1AleDFPwjgYVsAEm3gKW
         KHENOy6VEk9lvsV1bU/rJBVyxf8OgKP0Y8XSxMNnLAGCSliKYwjIa+SsoIKggc+T8xyt
         jMXz7kps9nR95g46ZTVhIqxOWU1C87cNcVWCpBRHH7l4BkU80Fys+DE4Vro6N8yLvGUO
         lPFA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mihalicyn.com; s=mihalicyn; t=1770381749; x=1770986549; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pILuumm4s94M5+C2aJ63ms278oe7itYtLuvXSi366vg=;
        b=TqnNaZCJZKDgERTbB2O9RwX5KuxSimAIghe/aagR/qPzjAwjRyvzeCSvMOuyjy6M8G
         QrqskpvjYrPhWinHVcC+pIMVNqWEDvflwH88SFxyt52NiYfoybLL3zN9YcucA6TwxlqC
         qp+KeMIUqb1deDSE5WZxVUCrzj9+++lV0ok2A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770381749; x=1770986549;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pILuumm4s94M5+C2aJ63ms278oe7itYtLuvXSi366vg=;
        b=B5ooR3rhi8XTo1QlfeOGPT10X9v5Op57dh9rErtAgJ+TkYW0GzI1NQ1YKdQZWyN1Vz
         tZ+2cckJvm7YlwjkVr13HFS94+EfrHhdA3R85ZKakdvsvl/zqK/WCeT4zsYMuQQ2gIfP
         SF2vNXeHN6E39A0guCpop21Hxb63TXt7OCTbcP0/lGFdaEd/4BNZHDl0MXxhAJlXQwZt
         I9j4HXM6XHmg/4wZDVAb1f8OExsi0jFDbsfeZVkFfIRxel8nO5niNkIxAD/d7OHggidL
         AmT4Do28MHudE0ADCnWrJD795hoCog/5ELW5mwNb2ZAuEPkJU7TcjtaBDbTSNPk+lEnt
         0RiA==
X-Forwarded-Encrypted: i=1; AJvYcCVlhYizZFijJDQ0JJvgCD9AHVje67uG/UGYY9j4zEZ2V9VIaJdAlRLxqvrQIIqIeYfUBc8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJRbTaYFEtBwcWKLUbdeRcSaVg1KW83+aKDWJ/sv7N0FI1J1gM
	iXKpqvdnFfXHyOfj7GDNK/ufMMGUc29qsmlEq4zGfb8R2FOICQUysueEjzA8iTy8jwkwqV1kU+T
	Iiz4DZHBa1y33l6zrmOCKO6mCPhwl+P9JHNCGTzSB3A==
X-Gm-Gg: AZuq6aJMOZ4N7VKO9FNtGq3kUFeYmv0PqXtJIaaUHicsRkOjEsygu+RQLR14Es3ahqr
	VeZTZbdfuMaduTxSLw6BeKM3JRuA68ykQk8nO8aQn81EdE6Fbq2xRljEX4K6SHVPVDc+MtiQzwD
	qUxI9CkGfrq0GLlDlIQhhI30WopIQNYuKt6qIrGOLwtmwnPNrTHdTk0/zWZU4iYAAe3O2Q0WGgN
	cvwS3F41V3x57SIFnMMGg9hV7GiMZuyfD/QIDWC2Xs5hw8Ci+0c1v4ttnby7tq7Z1Ysv4LGelLm
	VmyUYJkgmzVGa93724edn0kWEdA=
X-Received: by 2002:a05:6512:1390:b0:59e:476:a1cf with SMTP id
 2adb3069b0e04-59e45173187mr806234e87.49.1770381749061; Fri, 06 Feb 2026
 04:42:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260205104541.171034-1-alexander@mihalicyn.com> <20260206-gelenk-gierig-82ad15ec8080@brauner>
In-Reply-To: <20260206-gelenk-gierig-82ad15ec8080@brauner>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Fri, 6 Feb 2026 13:42:17 +0100
X-Gm-Features: AZwV_QgkLBXyWCcKj5zjTf7523gOvqXKWBYJGr6JBO7fN7jZv7v_4Ao7HJZnJug
Message-ID: <CAJqdLroezjW2qe+1CNykwhFc9OO7uGADzc6ffjZzvyVOxLjXVA@mail.gmail.com>
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

Am Fr., 6. Feb. 2026 um 13:33 Uhr schrieb Christian Brauner
<brauner@kernel.org>:
>
> On Thu, Feb 05, 2026 at 11:45:41AM +0100, Alexander Mikhalitsyn wrote:
> > From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
> >
> > Instead of FS_USERNS_MOUNT we should use recently introduced
> > FS_USERNS_DELEGATABLE cause it better expresses what we
> > really want to get there. Filesystem should not be allowed
> > to be mounted by an unprivileged user, but at the same time
> > we want to have sb->s_user_ns to point to the container's
> > user namespace, at the same time superblock can only
> > be created if capable(CAP_SYS_ADMIN) check is successful.
> >
> > Tested and no regressions noticed.
> >
> > No functional change intended.
> >
> > Link: https://lore.kernel.org/linux-fsdevel/6dd181bf9f6371339a6c31f58f582a9aac3bc36a.camel@kernel.org [1]
> > Fixes: 6fe01d3cbb92 ("bpf: Add BPF token delegation mount options to BPF FS")
> > Cc: Alexei Starovoitov <ast@kernel.org>
> > Cc: Daniel Borkmann <daniel@iogearbox.net>
> > Cc: Andrii Nakryiko <andrii@kernel.org>
> > Cc: Martin KaFai Lau <martin.lau@linux.dev>
> > Cc: Eduard Zingerman <eddyz87@gmail.com>
> > Cc: Song Liu <song@kernel.org>
> > Cc: Yonghong Song <yonghong.song@linux.dev>
> > Cc: John Fastabend <john.fastabend@gmail.com>
> > Cc: KP Singh <kpsingh@kernel.org>
> > Cc: Stanislav Fomichev <sdf@fomichev.me>
> > Cc: Hao Luo <haoluo@google.com>
> > Cc: Jiri Olsa <jolsa@kernel.org>
> > Cc: Jeff Layton <jlayton@kernel.org>
> > Cc: Christian Brauner <brauner@kernel.org>
> > Cc: bpf@vger.kernel.org
> > Cc: linux-fsdevel@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
> > - RWB-tag from Jeff [1]
> > Reviewed-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >  kernel/bpf/inode.c | 6 +-----
> >  1 file changed, 1 insertion(+), 5 deletions(-)
> >
> > diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
> > index 9f866a010dad..d8dfdc846bd0 100644
> > --- a/kernel/bpf/inode.c
> > +++ b/kernel/bpf/inode.c
> > @@ -1009,10 +1009,6 @@ static int bpf_fill_super(struct super_block *sb, struct fs_context *fc)
> >       struct inode *inode;
> >       int ret;
> >
> > -     /* Mounting an instance of BPF FS requires privileges */
> > -     if (fc->user_ns != &init_user_ns && !capable(CAP_SYS_ADMIN))
> > -             return -EPERM;
>
> Jeff's patch does:
>
>         if (user_ns != &init_user_ns &&
>             !(fc->fs_type->fs_flags & (FS_USERNS_MOUNT | FS_USERNS_DELEGATABLE))) {
>                 errorfc(fc, "VFS: Mounting from non-initial user namespace is not allowed");
>                 return ERR_PTR(-EPERM);
>         }

Hi Christian,

>
> IOW, it only restricts the ability to end up in bpf_fill_super() if
> FS_USERNS_DELEGATABLE is set. You still need to perform the permission
> check in bpf_fill_super() though otherwise anyone can mount bpffs in an
> unprivileged container now.

Yeah, this is what  mount_capable(struct fs_context *fc) does. I'm removing
FS_USERNS_MOUNT so know it checks capable(CAP_SYS_ADMIN), instead of
ns_capable(fc->user_ns, CAP_SYS_ADMIN).

No functional changes here.

>
> So either Jeff's patch needs to be changed to require
> capable(CAP_SYS_ADMIN) when FS_USERNS_DELEGATABLE is set (which makes
> sense to me in general) or the check needs to remain n bpf_fill_super().
>
> @Jeff do you require capable(CAP_SYS_ADMIN) from within nfs? I think you
> somehow must because otherwise what prevents a container from mounting
> arbitrary servers?

Same point here. We have this check in mount_capable(struct fs_context
*fc) already.

Kind regards,
Alex

>
> > -
> >       ret = simple_fill_super(sb, BPF_FS_MAGIC, bpf_rfiles);
> >       if (ret)
> >               return ret;
> > @@ -1085,7 +1081,7 @@ static struct file_system_type bpf_fs_type = {
> >       .init_fs_context = bpf_init_fs_context,
> >       .parameters     = bpf_fs_parameters,
> >       .kill_sb        = bpf_kill_super,
> > -     .fs_flags       = FS_USERNS_MOUNT,
> > +     .fs_flags       = FS_USERNS_DELEGATABLE,
> >  };
> >
> >  static int __init bpf_init(void)
> > --
> > 2.47.3
> >
