Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5941E4D9FA
	for <bpf@vger.kernel.org>; Fri, 15 Mar 2024 17:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710523393; cv=none; b=JcAtwm0psCNZb/pxf3L3MzP4St1Bp2kYNvi9S4TrpVp7ziqWFx8EqKd1fs/hkQ9dBCXvAmgd2cd5n24hhnCZn26+FK5g52Cq84zJcqOBPtWhWSB3ASrocpDCfkROlmVZq4YsD8damGTM7WuFz9HSACaHUID7PNVhUL54TZyqS7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710523393; c=relaxed/simple;
	bh=6x4UWYxPgk47z7IOAwTwM6Surx82Ey91VhiT7G7E6wo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c6ymHfSy3uagM4GLralmArmKKTji7ZM3Va5HgXOSxe/dBkkAqPKdvMrrIHHPOIvaOZiDPOTO5pocLXOR4lJioj00r4u9Jr1vRieaXHg603otF8O2Bpq3scBurLqKmpCTW60vSWVB8lcS77TytSjZ3xmEx3v23IrutC+7EJiujko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QVh4Y6zX; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QVh4Y6zX"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-413f2721129so16392955e9.1
        for <bpf@vger.kernel.org>; Fri, 15 Mar 2024 10:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710523389; x=1711128189; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MTc9SFXEiGKRxPDESRqXMXl2YqQYLYe6PV+ABOBGts8=;
        b=QVh4Y6zXLKvluDk8kbpaiThlqwxbg3SoU3fao0EhBBUjGm7Qj7IrD4SO4F/MVftvNh
         w1GYI8gHqSD9xQyZFq9jB5ZnbVxMr18zb2L3m3MRbXjmMxx1Dwxnee+q0HwXmttg4ZVs
         EIbP6tXz6Yz0qWhPzlT3b8wm1Xt3uSbtfqj1TJwC+/Si9h1TY0f9crMDeJ13jddVn5+s
         mDBIt57K5F5uuMfc8gLOyjAMm5AY6uC7LY+9dPIMZVlMjaMywQCmwBG5/F1WATwpMBpV
         3A6MP6nMux5yrTWZmIvw0Knfzdf63mxC7L2Q0gAPypFvBZIccYLNRXXv1llfdlkHVm0T
         H44g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710523389; x=1711128189;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MTc9SFXEiGKRxPDESRqXMXl2YqQYLYe6PV+ABOBGts8=;
        b=ZgKQcjyAACP3HNKB6cIchsJEMM6L4/ygMg/7MTXdHIewaaEgwqhegyJQib94BBQANN
         pijQP4vKdj5SPV0S8yZnCL7vL0aqJ2gXdKi3Jk2P2BLIr3boKO/mMbjLQWFjjvG+q90j
         1u/KgvmmdkpYlpB5lG5dSKjWP/HFhq3/7LDLxkpK8FM3LeI0BZ/nYUkUsNR5eGWuwVAD
         bL7No1yNSeI0I5Ie2fH1Uou13XSnFmExc3X2W5gIQ+MEym4X5OHCZgmMu/Ofi1r1Y9R8
         2mU0U85S3ZNyaH0RHD69uMtTKWqSTi3MQKvGkbkQouOOVfd4aT6gL3CympmwutNDEfTE
         8VCA==
X-Forwarded-Encrypted: i=1; AJvYcCXo0HyTFjFLRg0Xv0LY7ZbkKib6mXrkOg3MJOqUD6MrGhdahM5Lyz9n6JH+bNH0+TUam7GMYtTnIVc2/KBszi+I41d8
X-Gm-Message-State: AOJu0YwCG6i+U+maW0/n9prHH8s/+825FIssGi8UFWK7b9yBydieIXRo
	uVDmPd/QP44uIOc51mjtB2frjq/h4YLxLZXi0zxwpfLGD8yW4CaM2rkdAmSmMA7rEds2zFdLL8h
	PhCqwtEUaI/H8fOk9tWy5vccA9ZU=
X-Google-Smtp-Source: AGHT+IEKXTL+rEq6cP9XJUsuIWFaAzYcFqGP3IBSnvDbZ6Nnerev/DEyig57+GdHC70ETPi/PN5UfLeaqcYprk+2oY0=
X-Received: by 2002:a05:600c:a54:b0:414:44:8125 with SMTP id
 c20-20020a05600c0a5400b0041400448125mr2039872wmq.10.1710523389246; Fri, 15
 Mar 2024 10:23:09 -0700 (PDT)
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
 <CAADnVQKdvKqNt0GJ5+vJFEHHjRF_YGUR_htrs+QjQ0SgUV5woA@mail.gmail.com> <CAEf4BzY9wov5rS_MmzPWLErr8RKxKmFGV17Y2zsMCQCz6HKx6Q@mail.gmail.com>
In-Reply-To: <CAEf4BzY9wov5rS_MmzPWLErr8RKxKmFGV17Y2zsMCQCz6HKx6Q@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 15 Mar 2024 10:22:57 -0700
Message-ID: <CAADnVQLOB6HHgrewH48RWYkx94aA2nkqJfmzrys5pTeQibVo3Q@mail.gmail.com>
Subject: Re: [PATCH v1 bpf-next 3/9] bpf: expose how xlated insns map to
 jitted insns
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Anton Protopopov <aspsk@isovalent.com>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jiri Olsa <jolsa@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Stanislav Fomichev <sdf@google.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Quentin Monnet <quentin@isovalent.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 15, 2024 at 9:33=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Mar 14, 2024 at 2:41=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Thu, Mar 14, 2024 at 1:06=E2=80=AFPM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > > >
> > > > > What could work and what I am proposing is to pass a list of boun=
d
> > > > > maps in prog_load attributes. Then such maps can be used during t=
he
> > > > > verification. For normal maps
> > > > >
> > > > >   prog =3D prog_load(attr=3D{.bound_maps=3Dmaps})
> > > > >
> > > > > will be semantically the same as
> > > > >
> > > > >   prog =3D prog_load()
> > > > >   bpf_prog_bind_map(prog, maps)
> > > >
> > > > Instead of a whole new api, let's make libbpf insert
> > > > ld_imm64 r0, map
> > > > as the first insn for this case for now.
> > >
> > > This sounds like a big hack and unnecessary complication, tbh. I'd
> > > like to avoid having to do this in libbpf.
> > >
> > > But I think we almost have this already supported. In BPF_PROG_LOAD
> > > UAPI we have fd_array property, right? I think right now we lazily
> > > refcnt referenced maps. But I think it makes total sense to just
> > > define that bpf_prog will keep references to all BPF objects passed i=
n
> > > through fd_array, WDYT? Verifier will just iterate all provided FDs,
> > > determine kind of BPF object it is (and reject unknown ones), and the=
n
> > > just take refcnts on each of them once. On prog free we'll just do th=
e
> > > same in reverse and be done with it.
> > >
> > > It also can be used as a batch and single-step (in the sense it will
> > > be done as part of program load instead of a separate command)
> > > alternative for bpf_prog_bind_map(), I suppose.
> >
> > fd_array approach also works. There can be map and btf fds in there.
> > I would only bind maps this way.
>
> Any reason why we should have non-uniform behavior between maps and
> BTFs? Seems more error-prone to have a difference here, tbh.

because maps are only held in used_maps while btfs are held
in used_btfs and in kfunc_btf_tab.
And looking at btf_fd it's not clear whether it will be in ld_imm64
and hence used_btf or it's kfunc and will be in kfunc_btf_tab.
All btfs can be stored unconditionally in used_btf,
but that's unnecessary refcnt inc and module_get too.
Doesn't hurt, but makes it harder to reason about everything.
At least to me.
I guess if the whole refcnt of maps and btfs is factored out
and cleaned up into uniform used_maps/used_btf then it's ok,
but fd_array is optional. So it feels messy.
