Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38286130493
	for <bpf@vger.kernel.org>; Fri, 29 Mar 2024 22:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711752259; cv=none; b=qT75cCRfRVr6/jIZvEoAtTDj1y6lBN36XfsiMtRH40n5mHDhhiu3Jd7HV+zXnCrZkTzaR/fb4T0VSl48vCZV02r1I6Za4hs7EkBMQ1Y7Y0JQzHIEbt/up2MKfuBZ+iwwrpJrm+pyqnNHwYVdhYxxx2+YGbLTP0S9KdVUOypVm6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711752259; c=relaxed/simple;
	bh=0Jj/4KyavFbWjA5oP8M7hiUyTTLQIWZ8N/CuXjBgkmY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SjfYU8atA/upieFhvsfM3CzK7Ib6RgDRzm/bS6U5M+4/8lf3UlcDurGlh8lDOjLTxbIFahLrWseQhl6LBv1zXXDQ7h6/Y1EOfFqTFfMQ4WPJYFUpgR1pqyspwz+12UEUsCAhPpwLmuS8ecdXUaYvQQ/1eczbMquTPNvshkdc4GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YWVRLrlg; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YWVRLrlg"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-5ce07cf1e5dso1647726a12.2
        for <bpf@vger.kernel.org>; Fri, 29 Mar 2024 15:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711752257; x=1712357057; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vDUm1lD/PIiozoDa8SE3zb9WhyjGBzWVk6WaEuXxEzw=;
        b=YWVRLrlgCeXXXKvO629Bl9OXXU88Xt7PNoBPxr/jFaYaPzLQGaSJbh1/pjv6+At2xn
         OU2Ex05F0YG+WUke3M2i/eZiY15L8YITL9GFpUROi2JIUwe/R5Xv35Qu/WeuoccWr0MB
         YJNVGyTBD4z80qclDBco/Vr3OJEM64AykurV7o76elOrgwEuXh8UBRHtOpcyte6ageGd
         5WWzu0NVL5df2QEtTiDyPEYyoHrxJWtkuiZjGA/4ieemMJx3nLmGYNZL8SU9/wVX56pv
         FNFIId8nYm7IerGIvy+5CM1/f/TPIJW8p4Fadk8xmvrIW5QMNNZqaAT0ekdxH23VfXye
         TrKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711752257; x=1712357057;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vDUm1lD/PIiozoDa8SE3zb9WhyjGBzWVk6WaEuXxEzw=;
        b=abxZanRC0efM6tU2X7BrAIK04vpLyWZl2JuKv5DiOZXtxnlXq/Y4Xn21d8HZIh4bp7
         SD5PzYQ+2c0DEcxJp3oL3rUKFoLA50prIFNE0ID0nlxVDT2E7oeVPJA4pFNuF0+scTgQ
         XTyrtNgkswKSnS4mDV8Z9HrhPWuUMqAKZg9PYpeHQruI2MPgWdC71eQknR8fQmdC4y51
         oVDjvnKjKoT0sxhHhieixp5K/dPLMoz6db52Ie2H2LR81WMM2437kni1xN/ipd2Hi75A
         RJeQj6a/n8lwZvA2B7K0gfQ+HXVyv48sk9CsGnPKTXPdBIC0nIDms5EzhlzP/1ib5wnV
         sI7A==
X-Forwarded-Encrypted: i=1; AJvYcCXdGcBTdaHYr+bl2zTEKktL2Zn5XxIdlg991vd35nvirpW4igbhFssNnq8TZ4CEoXmIqHNT3QdzSOph8tJ1TJ/SztRo
X-Gm-Message-State: AOJu0YwoDtYZ3nj2LMIVJAQzCtn8rxdpOpasGyaUMQCR383INUycmGxr
	VH3QjFuAsUiXfBEO2s9GxC6YMeIcwhV8/ciH3jQynSaSbn7HIDTkaVAuy5Kfi/q3duGkRBR5AHR
	mqwhu6TECF7OFSLVejjyth2RP47k=
X-Google-Smtp-Source: AGHT+IE3eyKqzjaj+VG+EQcJvgn08AsLQ16NyzwhXmZbxS+FQlZsavokcUcuUUTexwKwPhsnhTWDpaEhwdIPOZVzbbo=
X-Received: by 2002:a05:6a20:3c90:b0:1a3:c408:42e6 with SMTP id
 b16-20020a056a203c9000b001a3c40842e6mr3799290pzj.11.1711752257442; Fri, 29
 Mar 2024 15:44:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAADnVQJ+_+ok_io1_W7e5z_dZhxSqhEFZQkumRgmY4AJRYwW7g@mail.gmail.com>
 <ZehJFP11vi5sv/eW@zh-lab-node-5> <CAADnVQJnh+j9etPYkst7hhnepvsoBuJY-ds-AF0fn3VqqJNXNg@mail.gmail.com>
 <ZfK9Y5c7RuOu0YiN@zh-lab-node-5> <CAADnVQLXok7niyyvpUaJxq4pNFFrBP5Vsk47NNxw1V4ipBdRrg@mail.gmail.com>
 <CAEf4BzbkkrFACwWQQQkESrdRKWUvJz=NyWdrtu4v6m2aOJKztw@mail.gmail.com>
 <CAADnVQKdvKqNt0GJ5+vJFEHHjRF_YGUR_htrs+QjQ0SgUV5woA@mail.gmail.com>
 <CAEf4BzY9wov5rS_MmzPWLErr8RKxKmFGV17Y2zsMCQCz6HKx6Q@mail.gmail.com>
 <CAADnVQLOB6HHgrewH48RWYkx94aA2nkqJfmzrys5pTeQibVo3Q@mail.gmail.com>
 <CAEf4BzbTgEzAv01hLWHJHHN24byEy-VWr32ijrLah-G55OS6Zw@mail.gmail.com> <ZgWcsKZR23JIg51e@lavr>
In-Reply-To: <ZgWcsKZR23JIg51e@lavr>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 29 Mar 2024 15:44:04 -0700
Message-ID: <CAEf4BzaMtK1D7yo_FWHEbF8E_SE9Pqte0u8uFr56CaBQSbYfeA@mail.gmail.com>
Subject: Re: [PATCH v1 bpf-next 3/9] bpf: expose how xlated insns map to
 jitted insns
To: Anton Protopopov <aspsk@isovalent.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jiri Olsa <jolsa@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Stanislav Fomichev <sdf@google.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Quentin Monnet <quentin@isovalent.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2024 at 9:37=E2=80=AFAM Anton Protopopov <aspsk@isovalent.c=
om> wrote:
>
> On 24/03/15 10:29, Andrii Nakryiko wrote:
> > On Fri, Mar 15, 2024 at 10:23=E2=80=AFAM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Fri, Mar 15, 2024 at 9:33=E2=80=AFAM Andrii Nakryiko
> > > <andrii.nakryiko@gmail.com> wrote:
> > > >
> > > > On Thu, Mar 14, 2024 at 2:41=E2=80=AFPM Alexei Starovoitov
> > > > <alexei.starovoitov@gmail.com> wrote:
> > > > >
> > > > > On Thu, Mar 14, 2024 at 1:06=E2=80=AFPM Andrii Nakryiko
> > > > > <andrii.nakryiko@gmail.com> wrote:
> > > > > > >
> > > > > > > > What could work and what I am proposing is to pass a list o=
f bound
> > > > > > > > maps in prog_load attributes. Then such maps can be used du=
ring the
> > > > > > > > verification. For normal maps
> > > > > > > >
> > > > > > > >   prog =3D prog_load(attr=3D{.bound_maps=3Dmaps})
> > > > > > > >
> > > > > > > > will be semantically the same as
> > > > > > > >
> > > > > > > >   prog =3D prog_load()
> > > > > > > >   bpf_prog_bind_map(prog, maps)
> > > > > > >
> > > > > > > Instead of a whole new api, let's make libbpf insert
> > > > > > > ld_imm64 r0, map
> > > > > > > as the first insn for this case for now.
> > > > > >
> > > > > > This sounds like a big hack and unnecessary complication, tbh. =
I'd
> > > > > > like to avoid having to do this in libbpf.
> > > > > >
> > > > > > But I think we almost have this already supported. In BPF_PROG_=
LOAD
> > > > > > UAPI we have fd_array property, right? I think right now we laz=
ily
> > > > > > refcnt referenced maps. But I think it makes total sense to jus=
t
> > > > > > define that bpf_prog will keep references to all BPF objects pa=
ssed in
> > > > > > through fd_array, WDYT? Verifier will just iterate all provided=
 FDs,
> > > > > > determine kind of BPF object it is (and reject unknown ones), a=
nd then
> > > > > > just take refcnts on each of them once. On prog free we'll just=
 do the
> > > > > > same in reverse and be done with it.
> > > > > >
> > > > > > It also can be used as a batch and single-step (in the sense it=
 will
> > > > > > be done as part of program load instead of a separate command)
> > > > > > alternative for bpf_prog_bind_map(), I suppose.
> > > > >
> > > > > fd_array approach also works. There can be map and btf fds in the=
re.
> > > > > I would only bind maps this way.
> > > >
> > > > Any reason why we should have non-uniform behavior between maps and
> > > > BTFs? Seems more error-prone to have a difference here, tbh.
> > >
> > > because maps are only held in used_maps while btfs are held
> > > in used_btfs and in kfunc_btf_tab.
> > > And looking at btf_fd it's not clear whether it will be in ld_imm64
> > > and hence used_btf or it's kfunc and will be in kfunc_btf_tab.
> > > All btfs can be stored unconditionally in used_btf,
> > > but that's unnecessary refcnt inc and module_get too.
> > > Doesn't hurt, but makes it harder to reason about everything.
> > > At least to me.
> > > I guess if the whole refcnt of maps and btfs is factored out
> > > and cleaned up into uniform used_maps/used_btf then it's ok,
> > > but fd_array is optional. So it feels messy.
> >
> > Yeah, I was imagining that we'd iterate fd_array (if it's provided)
> > and add any map/btf into used_{map,btf}, refcnt. Then during
> > verification we'll just know that any referenced map or btf from
> > fd_array is already refcounted, so we wouldn't do it there. But I
> > haven't looked at kfunc_btf_tab, if that's causing some troubles with
> > this approach, then it's fine by me.
> >
> > The assumption was that a uniform approach will be less messy and
> > simplify code and reasoning about the behavior, not the other way. If
> > that's not the case we can do it just for maps for now.
>
> fd_array is sent in attrs without specifying its size, so individual
> fds are copied to kernel as needed. Therefore, this is not possible
> to pass extra fds (not used directly by the program) without changing
> the API. So either a pair of new fields, say, (fd_extra,fd_extra_len),
> or just another field fd_array_len should be added. What sounds better?

I'd say we should extend fd_array with (optional) fd_array_cnt and
have the following logic:

  - if fd_array !=3D NULL and fd_array_cnt =3D=3D 0, then only maps/btfs
referenced from BPF program instructions should be refcnt/fetched;
  - if fd_array !=3D NULL and fd_array_cnt > 0, we can eagerly fetch all
FDs and refcnt, as discussed. If any instruction uses the fd index
which is >=3D fd_array_cnt, that's an error (the user didn't provide a
big enough FD array and we can now detect this).

WDYT?
