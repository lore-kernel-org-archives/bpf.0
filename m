Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8044D387581
	for <bpf@vger.kernel.org>; Mon,  4 May 2026 22:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777934562; cv=pass; b=kJdubhQENHlnG9NrGuY761td8Qn9St8ritahfxq18Q7l5znpTXJXbPhPQqwPVt4J8Pdxp2QcUH92lkzCfj1wVg8NYfngGkguv+Yt+HpIYHOIuraY0bH7bO/2wulSlz8Tu9U152jpB5mDQ7nMhN8CCvu73DA872m2soxsIe23STQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777934562; c=relaxed/simple;
	bh=jrK/HiPlfROzpLQwuaupLlvkZBTy1nkn4zGH4/MZ46M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iyaKfvgvDFU39WStUWYrPh9y3kfkr44Bm8dzWYRkSOCuKlDxVNt9shG5I9wEl64/N3+we4HVq9FNOoBT1TK2OZ/GZZfTVmaS6eKsz0Y6+oSbsIKtYGVyMuN//Gm6QZBUA4d0xxfv+ox6VeKgdnHl9qAIjAyRbm1+DDu4HMiwnR8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=UGi3Z9fJ; arc=pass smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="UGi3Z9fJ"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3650a4eb605so1927372a91.0
        for <bpf@vger.kernel.org>; Mon, 04 May 2026 15:42:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777934560; cv=none;
        d=google.com; s=arc-20240605;
        b=crXxWaBuSEX1ZMcy4hBlj2wgCu44pxexNZBk7c5oW+OIqC3361LefylaQDXgE0Gf/K
         gyYHlHn5+ZvvYcYm5q0mgwJqE/55NAz24xrfzmAnc0LcxsDzd8q+szcV1L+YAjhVhZgo
         BQiYREgqbY4f4RplZHoD6DRgK9x3rkU3J8N+Nr+HsjFbiwpmyAj7TzJM30Dq2rd21R4u
         9yijmLL3aTXXdJBk7wp/hEER0zFPs6FuO2UgmvNA9PyAeaTNUDmaBO5dwe5ggJxFzLU8
         DoQuvkkKTh74/jPBJvkIL7GJCe4x4PRckjYcSigqASCA9LE9a5MBFO4045Uru4uGc6NK
         MCVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IXBRZAGpUpDHDZmPqiOWgzQrVjT26h5rDl2WnSWzU/8=;
        fh=AxlwUVTSn4o+dsPKMPSjRoiMjXeF5aRCtbM4LZ98g9A=;
        b=gB3w+UrRsjCDp3PCDaGKDAUFk2BeXXtcy+pOofg873i43oqFvFhoSBJmlmbLOIHWj/
         PqtOSq2BHO/26pddC8lCCWsyN28IOh8N1Kb4FlpwLclXUjRFkTVAjCMAXUvKQHyhsZ++
         zJ7oHdKEc7Gh40ZldgTVgJB2qJ3AUcHVTHrbtc60Wwa2dtY+t2WzjCz+/mHkRJbRFwte
         8sc7Qoqqbkd5529ibm6EMZ9ThnWzjnzf3tuuq6gM6WZ8wEgWkQbt9uaRO2Onls3V9ukJ
         Xj+JJHkEytcQymTzacQbmONlass2RAamhC5ZZntrUkYcFnFe8AwnhL2/Yj5/2lUhsQ78
         Hwqw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1777934560; x=1778539360; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IXBRZAGpUpDHDZmPqiOWgzQrVjT26h5rDl2WnSWzU/8=;
        b=UGi3Z9fJLfezyp0OJDVLLNFuIoLRa1wo0OTjff6UNOlY3ZRdPTNMPdO5YcjAc9iyOl
         agb1F/QUPJpTdLppeZa1vhhJ9CJWO6vuQAz0W6fnIwxs5/92na+qXx0bY7Z5CTFYp03C
         R6WaF18KHUojniaVITwSsnJ5fWLuAfuz1zDC+ZAacmzaXr7bNbFx7ZunXCjlp4VWhZ1l
         EfeBeF12UbEmxFtdekM345BWt6iU0Hf51Fujf50LqcFVmZoiCpoNsAgG6AojobDbZAxh
         x8ZpGDJ5PU+eN39u6K/ADsd6KozqsTsvdp6jpJI3RZbXjlm3X+o0N1H1nwDGuQonit9Y
         0kww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777934560; x=1778539360;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IXBRZAGpUpDHDZmPqiOWgzQrVjT26h5rDl2WnSWzU/8=;
        b=XO8uELaiCOnchOsPGLs3IsM7Zky1EP/+vR8RRcWs/aKP2+cm1mUEOVgwul10L1h78h
         sIfxg9N4eJttYvJeVsAAFE0T64r/8R8UESUAg0xrA1QSyNSromhSD+l3l+X/OI1c6373
         T8Qdkwr4JrQBdfc95tngIlH/RAcdL7RWhH5xVGFuVYDiIoaerFpZa3aUJi5TSy8WixRJ
         dORa/T/GStycBLy0SJCBtG08lj+UwhWyTm5UpMeITHEKmOSTUXx6bK48CaNToPW59sPq
         TEqmHU/GfOdcFPvLSnccRKXSGB3D0O+B2UcvY35to14gS4LlF+K782xRI2MOETHn+g98
         DcLw==
X-Forwarded-Encrypted: i=1; AFNElJ9hD3HcG7qVY20S/SvxXF2FQwiOQO7pijM4LtFa9IWprvJoVNqcaHDoteEtsATy2PbMe7A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/LjmEJ7S1uaNjVJxCGIV9PaLj5kFc9KrVpzh35e5fwtwBC/8L
	YGIdWF2iH7KKvS13uFl7INgLF/RnDzF/H5GDlRtC7Ifwfct6iM5PIarRUPnWhRObzwj0MddNBxX
	kLeXO4GWsSJtJXvtilRkIHBoihO5NeL6H+REvC9H+
X-Gm-Gg: AeBDieuK9orlTXaW0r7M0Cdqn6Rdk67Lj0WnaXtUBQ6FH/XUwtIQUles1tDZQJBtbNj
	wGvp+oAmaRiOrY7uABLAkVsEsYOaeGXsmBGxwq51OVe1ERxxwxI3ICc8SnkSU1O72nNDo10AABa
	sofGRkB3YYVtFqbbq49cFSuxwp+JSI9MDfCqW5LdLSDuejnUXAghKqpEg9/9IDIK963NTr1L51j
	wkr/ataP4wEDUaECIeCbVfntLPYCbgUEOCF4UD1WyFwRzDg6ujhOafXiMC/HKUt1pIpGt3EMPhe
	ArPMWKMKZBm3MRpFQQ==
X-Received: by 2002:a05:6a20:7350:b0:398:7792:3882 with SMTP id
 adf61e73a8af0-3a7f1ad975cmr12466464637.16.1777934559848; Mon, 04 May 2026
 15:42:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260503211835.16103-1-dwindsor@gmail.com> <20260503211835.16103-2-dwindsor@gmail.com>
 <CAHC9VhSy5K5nQTtFUE4BScy1Ur61v7eZW067vTcUYDQeJb13Bw@mail.gmail.com> <CAPhsuW6sy2cdC4B7Z48-5A-yVX6fmVWxS_fWVjQxiX95KeUguw@mail.gmail.com>
In-Reply-To: <CAPhsuW6sy2cdC4B7Z48-5A-yVX6fmVWxS_fWVjQxiX95KeUguw@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 4 May 2026 18:42:27 -0400
X-Gm-Features: AVHnY4JwC15TGqrqFYxmzxatkMEXynJIr-3OCdScUP6s2DMx5Fh0pwblgffVK-0
Message-ID: <CAHC9VhQLN5NA_ZMMNyUdMCZVdwC3VM4PUnzka8xDK5rpR2a3sw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] bpf: add bpf_init_inode_xattr kfunc for atomic
 inode labeling
To: Song Liu <song@kernel.org>
Cc: David Windsor <dwindsor@gmail.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Matt Bobrowski <mattbobrowski@google.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Casey Schaufler <casey@schaufler-ca.com>, 
	Jan Kara <jack@suse.cz>, John Fastabend <john.fastabend@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Yonghong Song <yonghong.song@linux.dev>, 
	Jiri Olsa <jolsa@kernel.org>, Eric Snowberg <eric.snowberg@oracle.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, 
	selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 4, 2026 at 5:40=E2=80=AFPM Song Liu <song@kernel.org> wrote:
> On Mon, May 4, 2026 at 10:14=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> [...]
> > > diff --git a/fs/bpf_fs_kfuncs.c b/fs/bpf_fs_kfuncs.c
> > > index 9d27be058494..193accc00796 100644
> > > --- a/fs/bpf_fs_kfuncs.c
> > > +++ b/fs/bpf_fs_kfuncs.c
> > > @@ -10,6 +10,7 @@
> > >  #include <linux/fsnotify.h>
> > >  #include <linux/file.h>
> > >  #include <linux/kernfs.h>
> > > +#include <linux/lsm_hooks.h>
> > >  #include <linux/mm.h>
> > >  #include <linux/xattr.h>
> > >
> > > @@ -353,6 +354,97 @@ __bpf_kfunc int bpf_cgroup_read_xattr(struct cgr=
oup *cgroup, const char *name__s
> > >  }
> > >  #endif /* CONFIG_CGROUPS */
> > >
> > > +static int bpf_xattrs_used(const struct lsm_xattr_ctx *ctx)
> > > +{
> > > +       const size_t prefix_len =3D sizeof(XATTR_BPF_LSM_SUFFIX) - 1;
> > > +       int i, n =3D 0;
> > > +
> > > +       for (i =3D 0; i < *ctx->xattr_count; i++) {
> > > +               const char *name =3D ctx->xattrs[i].name;
> > > +
> > > +               if (name && !strncmp(name, XATTR_BPF_LSM_SUFFIX, pref=
ix_len))
> > > +                       n++;
> > > +       }
> > > +       return n;
> > > +}
> [...]
> > > +
> > >  static int bpf_fs_kfuncs_filter(const struct bpf_prog *prog, u32 kfu=
nc_id)
> > >  {
> > >         if (!btf_id_set8_contains(&bpf_fs_kfunc_set_ids, kfunc_id) ||
> > > -           prog->type =3D=3D BPF_PROG_TYPE_LSM)
> > > +           prog->type =3D=3D BPF_PROG_TYPE_LSM) {
> > > +               /* bpf_init_inode_xattr only attaches to inode_init_s=
ecurity. */
> > > +               if (kfunc_id =3D=3D bpf_init_inode_xattr_btf_ids[0] &=
&
> > > +                   prog->aux->attach_btf_id !=3D bpf_lsm_inode_init_=
security_btf_ids[0])
> > > +                       return -EACCES;
>
> We need to mark bpf_init_inode_xattr with KF_RCU (requires a trusted
> pointer), then we can remove this check above.
>
> > >                 return 0;
> > > +       }
> > >         return -EACCES;
> > >  }
> >
> > Perhaps I'm simply not seeing it, but is there a check to ensure that
> > there is only one BPF LSM calling into security_inode_init_security()
> > at any given time?  With the BPF LSM only reserving a single xattr
> > slot, multiple loaded BPF LSM programs providing
> > security_inode_init_security() callbacks will be a problem.
>
> I don't think there is such a check. Also, a single BPF LSM function
> may call the kfunc multiple times, which is also problematic.
>
> I think we will need to make the default bigger, and also introduce
> some realloc mechanism for the worst case scenario. This should
> work, but the code might be a bit messy.

Thanks for the clarification, that is what I was afraid of when
looking at the code, but I was hoping I was just missing it.

Increasing the default is an option, but I don't think we want to
support a dynamic reallocation scheme for the xattr slots, that will
likely get extremely messy with synchronization between the LSM
framework and BPF LSM hook registrations as well as special code to
handle inodes with lifetimes that are disjoint from the BPF LSM
programs ... I suppose there may be a way to do it, but it will surely
be ugly and come at a cost.

--=20
paul-moore.com
