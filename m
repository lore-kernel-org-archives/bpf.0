Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536EB45970
	for <bpf@vger.kernel.org>; Fri, 15 Mar 2024 16:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710520387; cv=none; b=tJ2j2DjfISjl5LuKUpiHZC6ic9kJsLNP0+HnxPr7CZJd0jnZAtOPzRc4h8NXVOEwEAsLhMrBmfauLzezwYUv+/WU6Zahl1GpAJxWwu9xljdFUimp/z0SNMrE6Gcln0jo91l82+xSvqoRAKNG1ch/mLW8UusjyB4TijAdPgCni/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710520387; c=relaxed/simple;
	bh=s/BDewy2og3gZ1LCUXxuxGEeN0vfxyfHKGu3DaFPrFg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DIMAIRSbFKklOxTI1VFz335+sgAMjej+h4R0Pwo2X/MWZs4+IRRIkuJiLl3jLCkeEyIQHg5r8CETvPAhZFcTMmbemMRhzYufMV3do1LDh1D670Bx/CUX+bfEqigb9n4RrTLtGWBAIh+FkYwcT9ukFO6rZYPVrNeQ4D6MwXsE0qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fJLT5XSl; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fJLT5XSl"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-29c16b324ecso1726237a91.3
        for <bpf@vger.kernel.org>; Fri, 15 Mar 2024 09:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710520385; x=1711125185; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tVq28LuJUHVImSegoPYnyTJIQo9AajCxAmkjABn6qTo=;
        b=fJLT5XSlB4wikujvpAaKPVtfZLnvIYXeUlA3cBm49qXI4fc8g6wdyCiUfkR65HEw2j
         qSEGN6xX6ln5zFo2jYkOfdH+dvDNUmK80KDapMCfPVHg23jvn4sZzH0cE3+P0vnMTwRJ
         EjW9I/9+3NzaGifvCvT535qWyofJuqxsHLXgeKZHKhXSS+UKP6n2zxQC9B5N2PVp6vpn
         w2PybicaHjotwleNSOua69As67kc+oEgFScbiH99ev7Q/23Ln6oadk3sYkcVfJq3haVC
         RFyo1+sodC8Q1EFa3JmLR7D5PPN+zY8NLyFHXZ4ONdGh4J+tElidxgBUp6axGmGaI5x6
         KtoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710520385; x=1711125185;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tVq28LuJUHVImSegoPYnyTJIQo9AajCxAmkjABn6qTo=;
        b=gTfhgwIOS57REJzxngRexxR9TJVsrH99MXkcNhX0jXeKiLjkYoUvZ5Air2FUo4ZM6z
         ZKYxmxLWij3LAqszN6hlyRdrDs0bgvonYOhNyC44lKmiogpkf314NgPTGqCjhKvh8fjd
         lOBzZq+jiWEezVATh3BzU0eC9tIOjCpecS7wAzd0LK90yRAArc15yqN5fKx9ApDD615v
         WMlF2FjCZ+uOUNmCxSQMev/FCVk88lmRIKk8qX/DkADDd2bIs4p/qf7WgZWEI2nb3slL
         e5XaT4ldtAfpbhqWWL5TfUJsZZiMccMFIS7FNFwaeta+/qTsK3zrECFaQiruD27zOzhT
         nLsQ==
X-Forwarded-Encrypted: i=1; AJvYcCUv8oDDxL2coxjy502wTq3+YMhEQg0wqQ3z43ZbRb+pxH3ZHiY0EnwnBtiqQzLq7tnMziVYIXgd5/uC302JsQLbTJ7D
X-Gm-Message-State: AOJu0Ywn92zQxiW2kkdc4d7V8RBxOTnvjd+vBM3fddCsts8RxYP9J0vD
	h5DJg4PoR2fRcrcTGtFhsuXpIY5anjUxQ1WP+ZJLepsw6qR5AuxcZZoJEWgWFFH5NIE6Iywt1wa
	34zKPRhIGDqFAK5Vv+LjgtFo8l4c=
X-Google-Smtp-Source: AGHT+IEbemYwqH5K78I6LYVMJ98kY+gpl+EsooT7C5ZlT520qPvPEq8hw8IU+A9DMJg2RGDKpv+cFYR4zi+9ZpaObTU=
X-Received: by 2002:a17:90a:bc9:b0:29a:6b1d:4d32 with SMTP id
 x9-20020a17090a0bc900b0029a6b1d4d32mr5334127pjd.38.1710520385470; Fri, 15 Mar
 2024 09:33:05 -0700 (PDT)
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
 <CAEf4BzbkkrFACwWQQQkESrdRKWUvJz=NyWdrtu4v6m2aOJKztw@mail.gmail.com> <CAADnVQKdvKqNt0GJ5+vJFEHHjRF_YGUR_htrs+QjQ0SgUV5woA@mail.gmail.com>
In-Reply-To: <CAADnVQKdvKqNt0GJ5+vJFEHHjRF_YGUR_htrs+QjQ0SgUV5woA@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 15 Mar 2024 09:32:53 -0700
Message-ID: <CAEf4BzY9wov5rS_MmzPWLErr8RKxKmFGV17Y2zsMCQCz6HKx6Q@mail.gmail.com>
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

On Thu, Mar 14, 2024 at 2:41=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Mar 14, 2024 at 1:06=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> > >
> > > > What could work and what I am proposing is to pass a list of bound
> > > > maps in prog_load attributes. Then such maps can be used during the
> > > > verification. For normal maps
> > > >
> > > >   prog =3D prog_load(attr=3D{.bound_maps=3Dmaps})
> > > >
> > > > will be semantically the same as
> > > >
> > > >   prog =3D prog_load()
> > > >   bpf_prog_bind_map(prog, maps)
> > >
> > > Instead of a whole new api, let's make libbpf insert
> > > ld_imm64 r0, map
> > > as the first insn for this case for now.
> >
> > This sounds like a big hack and unnecessary complication, tbh. I'd
> > like to avoid having to do this in libbpf.
> >
> > But I think we almost have this already supported. In BPF_PROG_LOAD
> > UAPI we have fd_array property, right? I think right now we lazily
> > refcnt referenced maps. But I think it makes total sense to just
> > define that bpf_prog will keep references to all BPF objects passed in
> > through fd_array, WDYT? Verifier will just iterate all provided FDs,
> > determine kind of BPF object it is (and reject unknown ones), and then
> > just take refcnts on each of them once. On prog free we'll just do the
> > same in reverse and be done with it.
> >
> > It also can be used as a batch and single-step (in the sense it will
> > be done as part of program load instead of a separate command)
> > alternative for bpf_prog_bind_map(), I suppose.
>
> fd_array approach also works. There can be map and btf fds in there.
> I would only bind maps this way.

Any reason why we should have non-uniform behavior between maps and
BTFs? Seems more error-prone to have a difference here, tbh.
