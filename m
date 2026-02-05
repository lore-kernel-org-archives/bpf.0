Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F86543CEF5
	for <bpf@vger.kernel.org>; Thu,  5 Feb 2026 17:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770312302; cv=pass; b=AKMh5HKpxlzhlqTVjBeAdni3zFsrcSFfmdlcd9eBMjiDaY99aj+2ghBlp6rn5zDIuQcKXJAvHj8jDZ0yYs2djSSp4tBd/OmiBg72sqF8HnOe9EbxpMx3i60TL/3yfu7DBzCRlQc8rOfLqvVDqr19bodRfrFKdi1OkoR1PWj59Tw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770312302; c=relaxed/simple;
	bh=DMTb5B9qkJKFk7NxcxzA+QYfWF8VXD8biOcK5qjwuL8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hgkx4Q7JYltz0mrbZAXBoe2SQaaL1s2+l+AXsr6F9tKwVweJIXVHwFutfCWrVkt0uBcRF4snoSK0hrqgLdjEezw7aYXyiN1v9rOLBkyQzDCP5ckOzch5mb47Q8CxeJa6TSbYb4pW7+uv1qDQ8+P39Ixw8cG51dJAxtH4GkO8sus=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dfzH+NjV; arc=pass smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dfzH+NjV"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-4359a16a400so1292947f8f.1
        for <bpf@vger.kernel.org>; Thu, 05 Feb 2026 09:25:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770312301; cv=none;
        d=google.com; s=arc-20240605;
        b=BrKqnGDmKLLrjCCIDSSqLUGGr6Z5ncrbr09pxHx+5q8wVTrTYGFOKRJMOJ/f5dtCa1
         u1sDHpTRsxLVGN3zNgtMLrd+FRvqeOwrZa3cdruausUw66Ny0ecrI3o0f92UxaRDwXa2
         LO9BZwBPRwt5SB4DmXSwD4Z0/rtvNbZ89i4qkUwJWRDoSjQcoH1aPIGUNR4zLU9k/gHC
         PfJ4+VcRe4Ov8ixHZOBGfH8wQEQl7+Akz21x9vCLXcJkQ/YioLePzP9lEP+uH0jP2JYn
         S8S67GSMdVovIHy/0n1FbE1gABjTK1ypKxgY4ub1ZR4GGytK502O+Cg4aYfYVTmC1EcP
         Oclw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Qk4pZJZ2L+ZEgp09mij+ITzhn9MAtWKZuACbdw3VFPQ=;
        fh=MYaZDeuPswRMTi3XOmthQUYsgNGhaBR4iFp4PxJmLQM=;
        b=YurqGa5JFDBOCq4qFB1wkVjyjcbvt8OTNifkYZxjPUD6HXzCvMtH+AqxaZK7Ky+jA1
         btVKyLC4KTB5WFkVZ/dyRecMO6BSA5ornVaemMaq9+LtS2mVLmdHQYYguGgapb85VICN
         FKzrRBqhLmwLqK38eQBAiPFdGGFTb2Xewkc89R0aTFUpIoHz55hCAXDUkKzD8TsJEOxQ
         x4rQ+2v26ftReSgWUyJz8Jtba+sKMUfQwb7asbayU7nIicdbS/uaUrlwbJaUWd3lMpCE
         jRY1IZ2NHRZZAdOK+37PlBB0cGMW6JPyLrrV4XvauyQviO7ySCLJZ4vDjWB6MKGmzy5N
         Shfw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770312301; x=1770917101; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qk4pZJZ2L+ZEgp09mij+ITzhn9MAtWKZuACbdw3VFPQ=;
        b=dfzH+NjVsPRTQaT+MI04BrLTzFdnFq849xrb7TqLra0ULaoWvqlm8eN1ivYBbxRDca
         g1brMQrkXIkcK6IClGfbOwwdtl3VsiHVIvQKoK9U/ADUL4AizFtq7I+NysB5V9AwSSid
         UMae1Nb2sz+Di7HEm73361xZpawzUheBWhGACeeno40zOCnUnHE1QTH4D3/z+CPG6Qtu
         h2poZko8w85SMn+cNpLnPmGv/LXhZc5+D5pZCCI6Ei7rg2eSMY0pWccjgdgz0Glm7Yvy
         LE6VhF3DhbCA9LNRQavF4KNlh4zpCbOnzFcZxcs/k0pSjWl66s7qS8HjvjnmrcUTBtTq
         xHwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770312301; x=1770917101;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Qk4pZJZ2L+ZEgp09mij+ITzhn9MAtWKZuACbdw3VFPQ=;
        b=C3UkfchAx/RwyW4YlYMq2zUlPNHBNHDw/VVion1z/KCsMURgVaFoi4Y5h8SisYvApi
         3Mh3B9HZlGRdvS2visNudD6ZylsD+8td21lkRUFttw/YAuQPjFEc8Y3KFGEMEgrQ6M+Y
         JHVwIbru/dMAGU+sWqO/OE5SpxvEntcoVd4v+BIgeyDjgcNBGvnc3VDsY74HZOtHHBx2
         nqk9TnSI3uTi00w/7sMaCLc8i3IduwXRs8ePj0/DTJ6OTsSBpKF8fkCUOHl7znemWpri
         qQ/XL6gexmZpHvbLCCyOYHgxV3zbUKlDx90GM+S15i8aUsImPwkG6vD67z3mctCpq6eE
         7n6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWvlSuBuk8BfdLf7gGNKQlO9AQ/mLNs/6jQIxI4Zg1kqV4/k5LjFwEV1r8ARNqlt3tDYlQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxH8toam1kA+UFTUwjdojYyVths1yp9xKrUQGQOpc2FW0b/cyNz
	2Vk1wCIQe6cvSY2g12lK2xdO/Iaym3l0tYHRpc+OG98ZlJI7I76P64ZiRidi/8Nonzg4d6IU3F1
	Okj0TXS2S84XxxrgiT0BljhsnUSz2yAo=
X-Gm-Gg: AZuq6aI3DFQzzqr9OfDNrX3GmGhu5XxcMOMJp6SGBVfPXjlpaCl7lU0ZrNihHkvroKR
	dlHmKLGUyjUKItonroJPlnYZ1fHhFwKBTUMTs1z0c5QvOYsQ/a2EIozhmcBjH7X8UdfPSOGoixS
	6nq4ePYlEUSiQMMtKAc/vrzLXUAwYXCzI9wdto8dy8gRkAZnhHJPm6HcEWwyV9iDwkLAg5a4yn3
	eb6fjVD3LxVhQ6YJG5Rz+FwdBhzVXJfvmMzAly50Dy8UYxLob1Q7REb8dzdveIG5fw/6polGt8b
	6a2tk7EeL7jJpn6CDqKyDlGxWAfyGmJ/ooyVkOiR/PcAjW71335P4WhC9UC7gTwduj6R7FtH
X-Received: by 2002:a5d:5f49:0:b0:435:db6e:e3b3 with SMTP id
 ffacd0b85a97d-436180510b8mr11032357f8f.36.1770312300694; Thu, 05 Feb 2026
 09:25:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260205104541.171034-1-alexander@mihalicyn.com>
 <4502642b48f31719673001628df90526071649bc4555c5432d88d2212db3f925@mail.kernel.org>
 <CAJqdLrqRBhmrQQA0MA9f5Js6rTZkJFf6-=KT+eZahakgX4_3fw@mail.gmail.com>
 <CAADnVQJqL0FUKZ5Vo4thH1Xk-O6d4BSO2M6kPNRZP0V=opEMNg@mail.gmail.com> <CAJqdLrpOGmCC2TpUGisBYQCHpjd6L+LQ40UiuNqWS3pOHFkcFQ@mail.gmail.com>
In-Reply-To: <CAJqdLrpOGmCC2TpUGisBYQCHpjd6L+LQ40UiuNqWS3pOHFkcFQ@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 5 Feb 2026 09:24:49 -0800
X-Gm-Features: AZwV_QhX8jNgLQecMVLNMt9XW360bpfLh21FFI_JxTtrSwJ4_tNSTUL9Po7oC3A
Message-ID: <CAADnVQK_nd0MSo2RZ7upNyPPkpUy5QhJHwA189Lbeo=5DptN4g@mail.gmail.com>
Subject: Re: [PATCH] bpf: use FS_USERNS_DELEGATABLE for bpffs
To: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Cc: bot+bpf-ci@kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Jeff Layton <jlayton@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Linux-Fsdevel <linux-fsdevel@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	aleksandr.mikhalitsyn@futurfusion.io, 
	Martin KaFai Lau <martin.lau@kernel.org>, Chris Mason <clm@meta.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 5, 2026 at 9:18=E2=80=AFAM Alexander Mikhalitsyn
<alexander@mihalicyn.com> wrote:
>
> Am Do., 5. Feb. 2026 um 17:43 Uhr schrieb Alexei Starovoitov
> <alexei.starovoitov@gmail.com>:
> >
> > On Thu, Feb 5, 2026 at 3:27=E2=80=AFAM Alexander Mikhalitsyn
> > <alexander@mihalicyn.com> wrote:
> > >
> > > Am Do., 5. Feb. 2026 um 12:20 Uhr schrieb <bot+bpf-ci@kernel.org>:
> > > >
> > > > > diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
> > > > > index 005ea3a2c..c350857b2 100644
> > > >
> > > > [ ... ]
> > > >
> > > > > @@ -1077,7 +1073,7 @@ static struct file_system_type bpf_fs_type =
=3D {
> > > > >       .init_fs_context =3D bpf_init_fs_context,
> > > > >       .parameters     =3D bpf_fs_parameters,
> > > > >       .kill_sb        =3D bpf_kill_super,
> > > > > -     .fs_flags       =3D FS_USERNS_MOUNT,
> > > > > +     .fs_flags       =3D FS_USERNS_DELEGATABLE,
> > > > >  };
> > > >
> > > > FS_USERNS_DELEGATABLE does not appear to be defined anywhere in the=
 kernel
> > > > tree. A search of include/linux/fs.h shows only FS_USERNS_MOUNT is =
defined
> > > > (at line 2268), not FS_USERNS_DELEGATABLE.
> > > >
> > > > The commit message states this flag was "recently introduced", but =
it is not
> > > > present in this codebase. Will this cause a build failure due to an=
 undefined
> > > > identifier?
> > >
> > > Yeah, this should be applied on top of
> > > https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/commit/?h=
=3Dvfs-7.0.misc&id=3D269c46e936f3b5f2b6b567ca124d5f5ea07a371c
> > > in vfs/vfs-7.0.misc I think.
>
> Hi Alexei,
>
> >
> > I think it's better to go via bpf-next this after the merge window
> > to make sure it goes through full CI run with AI review, etc.
>
> Yeah, thanks to Daniel's suggestion it went through full CI already.
> Please, see https://github.com/kernel-patches/bpf/pull/10970#issue-390141=
0145

No. It did not. AI was skipped and all of netdev tests too.
