Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4E940BE6
	for <bpf@vger.kernel.org>; Fri, 15 Mar 2024 17:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710523811; cv=none; b=q3hIQJouj0hp8+X1XT3PjlBd2+kcvkgQRiluemV1NvbU89R0enBVocwchEwN1miIF4yFtpRVvZ1O0GVx6q3SPhrCdG/HkSJMjhKx1jzMcyFBld2Q/sX/Fvh/R+2PquUXLkOC/Aaf+G9aWbCgva4YsshL9F/W34KqxTQfLz+Py7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710523811; c=relaxed/simple;
	bh=BJTQapIM+UySjrCzfkLWtVfoCG78/IwiqPNk/OPU9nc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iRAMjpNzMkP0SIQ2gV/Zr6PDlDi7HlCfllPneRGxHCXVJPkxk25BrDAAP3JvRIvYe+io/quCA81kIroxAqT9gmkjfPSlAgDOQxC3974Yfb4vbnRZCcIarNmVbwNduXuGWNfocRncBWWW9tDHslB4kn5UP3EefRfvS/s459kU/U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ot8QL9Ay; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ot8QL9Ay"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6e6ccd69ebcso1495933b3a.0
        for <bpf@vger.kernel.org>; Fri, 15 Mar 2024 10:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710523809; x=1711128609; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+gEMV85yzPdVPQbK1zUZbbS8oNWn55RT/k9+IQ1NJEY=;
        b=Ot8QL9Ay9Z1pFhY8JzqbEesHOkHvMA5tpNfSRAP2eOQ+9eIhNALKB8I1m2sdGy3AAX
         MBvX6A+ZGTptL2iQkp5P1ah+r8+zv/zmCIxhGSWOGFUvP1Hrb2dnuCtXukgqbSbnfLgY
         O2cF5MEamEFDLqpmQi8hdlCfoO/UZqwr1TJxwp8uGW1sDUUy4E21xLCGX8LptsxJXbb0
         +Bl5TSpYY2kJfnK5zUjMcYL7NIk2N8nNd50LA0v6jZ9bbD6E9EE7B/GMUlA3rfcT4HHV
         vWw2kdmtR926sTKA7PYxbhkM5AewNijJmNfnLaeIe49jwZOmsPMpgE/rCOv2AFH74D4J
         tEWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710523809; x=1711128609;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+gEMV85yzPdVPQbK1zUZbbS8oNWn55RT/k9+IQ1NJEY=;
        b=RxsQH+e2pgl60P+sqjSU5ofb/YxQ+h116B+fmhaXdYfvVsxcey/ZxNp9A70bsrXnG9
         YYs24QbNaMe6/96Nyy0o9hjIv1gAELHsQ4uY1ZSzyyPltpgTwoyvKz44UzR68AyaIPw2
         kX9BriPedBfjfbg5blR+A8QtSWf/+L4U18KkxSd2Q9V8/HcVAshEQEPxWravjL8uj94N
         uROWgBNG+X3X+hAdK/w/PhR262PojfYwtoTnJ/wMimHpx7OuWeNf/O20QQMdTf8qy4oC
         iKpBoqgL7jyfBQTYMvLTjzP9k63RDfd7VRkynj25uDcZwxk5XQ3P0+b28u+3sirKaixu
         HE3Q==
X-Forwarded-Encrypted: i=1; AJvYcCX+8mmT1RvSo59v+IxjvPemsSNlYzhRyEqVjxHPTXXLDc5BHzkHjKZR5njJnfYSDaBf2psQu6WUYAOQG7jF/XOpTIz+
X-Gm-Message-State: AOJu0YzRETgFC0E36u88EOsL2B73dG8h+RehHA4s3EeqQh3PHcdJu7H5
	Asl2t3Ws7oVII5y1KwDojIaLabuaWCipG/FNQ/biC9j8JEHYa4CmCVWSH459AJx5ckzYox5htg8
	1bM6hAVJs3jhTBriXNPJI9IOs7Ws=
X-Google-Smtp-Source: AGHT+IFgmRG/BmZhWdZVQ+yhXiX5pGGV4S6qeLdysL0C0yT3Z4qu8IFs4Fgi6/BVgtQrEyoFfhDyY27jqGrLB6DD3nU=
X-Received: by 2002:a05:6a20:258d:b0:1a3:501a:2a10 with SMTP id
 k13-20020a056a20258d00b001a3501a2a10mr1847357pzd.52.1710523808895; Fri, 15
 Mar 2024 10:30:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240202162813.4184616-4-aspsk@isovalent.com> <CAADnVQLnk=UyKBkRAC1tNkiaF7C4+FG7V-b2xrR3oa_E4+QX7Q@mail.gmail.com>
 <ZcIDqnXFjsWYyu1G@zh-lab-node-5> <CAADnVQLfidjTWa4+kyRH-qC29gbGvFsRJHu6smcaL0Yk0HqgmA@mail.gmail.com>
 <ZcS1ZruKKZ1euzlb@zh-lab-node-5> <CAADnVQKH1aitaADzCo__PfMJJA2SxAvYjTS8Z7A6Y01G2OWJgw@mail.gmail.com>
 <Zc9p4e1EccPkMnmY@zh-lab-node-5> <CAADnVQJ+_+ok_io1_W7e5z_dZhxSqhEFZQkumRgmY4AJRYwW7g@mail.gmail.com>
 <ZehJFP11vi5sv/eW@zh-lab-node-5> <CAADnVQJnh+j9etPYkst7hhnepvsoBuJY-ds-AF0fn3VqqJNXNg@mail.gmail.com>
 <ZfK9Y5c7RuOu0YiN@zh-lab-node-5> <CAADnVQLXok7niyyvpUaJxq4pNFFrBP5Vsk47NNxw1V4ipBdRrg@mail.gmail.com>
 <CAEf4BzbkkrFACwWQQQkESrdRKWUvJz=NyWdrtu4v6m2aOJKztw@mail.gmail.com>
 <CAADnVQKdvKqNt0GJ5+vJFEHHjRF_YGUR_htrs+QjQ0SgUV5woA@mail.gmail.com>
 <CAEf4BzY9wov5rS_MmzPWLErr8RKxKmFGV17Y2zsMCQCz6HKx6Q@mail.gmail.com> <CAADnVQLOB6HHgrewH48RWYkx94aA2nkqJfmzrys5pTeQibVo3Q@mail.gmail.com>
In-Reply-To: <CAADnVQLOB6HHgrewH48RWYkx94aA2nkqJfmzrys5pTeQibVo3Q@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 15 Mar 2024 10:29:56 -0700
Message-ID: <CAEf4BzbTgEzAv01hLWHJHHN24byEy-VWr32ijrLah-G55OS6Zw@mail.gmail.com>
Subject: Re: [PATCH v1 bpf-next 3/9] bpf: expose how xlated insns map to
 jitted insns
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Anton Protopopov <aspsk@isovalent.com>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jiri Olsa <jolsa@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Stanislav Fomichev <sdf@google.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Quentin Monnet <quentin@isovalent.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 15, 2024 at 10:23=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Mar 15, 2024 at 9:33=E2=80=AFAM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Thu, Mar 14, 2024 at 2:41=E2=80=AFPM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Thu, Mar 14, 2024 at 1:06=E2=80=AFPM Andrii Nakryiko
> > > <andrii.nakryiko@gmail.com> wrote:
> > > > >
> > > > > > What could work and what I am proposing is to pass a list of bo=
und
> > > > > > maps in prog_load attributes. Then such maps can be used during=
 the
> > > > > > verification. For normal maps
> > > > > >
> > > > > >   prog =3D prog_load(attr=3D{.bound_maps=3Dmaps})
> > > > > >
> > > > > > will be semantically the same as
> > > > > >
> > > > > >   prog =3D prog_load()
> > > > > >   bpf_prog_bind_map(prog, maps)
> > > > >
> > > > > Instead of a whole new api, let's make libbpf insert
> > > > > ld_imm64 r0, map
> > > > > as the first insn for this case for now.
> > > >
> > > > This sounds like a big hack and unnecessary complication, tbh. I'd
> > > > like to avoid having to do this in libbpf.
> > > >
> > > > But I think we almost have this already supported. In BPF_PROG_LOAD
> > > > UAPI we have fd_array property, right? I think right now we lazily
> > > > refcnt referenced maps. But I think it makes total sense to just
> > > > define that bpf_prog will keep references to all BPF objects passed=
 in
> > > > through fd_array, WDYT? Verifier will just iterate all provided FDs=
,
> > > > determine kind of BPF object it is (and reject unknown ones), and t=
hen
> > > > just take refcnts on each of them once. On prog free we'll just do =
the
> > > > same in reverse and be done with it.
> > > >
> > > > It also can be used as a batch and single-step (in the sense it wil=
l
> > > > be done as part of program load instead of a separate command)
> > > > alternative for bpf_prog_bind_map(), I suppose.
> > >
> > > fd_array approach also works. There can be map and btf fds in there.
> > > I would only bind maps this way.
> >
> > Any reason why we should have non-uniform behavior between maps and
> > BTFs? Seems more error-prone to have a difference here, tbh.
>
> because maps are only held in used_maps while btfs are held
> in used_btfs and in kfunc_btf_tab.
> And looking at btf_fd it's not clear whether it will be in ld_imm64
> and hence used_btf or it's kfunc and will be in kfunc_btf_tab.
> All btfs can be stored unconditionally in used_btf,
> but that's unnecessary refcnt inc and module_get too.
> Doesn't hurt, but makes it harder to reason about everything.
> At least to me.
> I guess if the whole refcnt of maps and btfs is factored out
> and cleaned up into uniform used_maps/used_btf then it's ok,
> but fd_array is optional. So it feels messy.

Yeah, I was imagining that we'd iterate fd_array (if it's provided)
and add any map/btf into used_{map,btf}, refcnt. Then during
verification we'll just know that any referenced map or btf from
fd_array is already refcounted, so we wouldn't do it there. But I
haven't looked at kfunc_btf_tab, if that's causing some troubles with
this approach, then it's fine by me.

The assumption was that a uniform approach will be less messy and
simplify code and reasoning about the behavior, not the other way. If
that's not the case we can do it just for maps for now.
