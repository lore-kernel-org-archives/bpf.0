Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA86217552
	for <bpf@vger.kernel.org>; Mon,  1 Apr 2024 15:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711987105; cv=none; b=Y+DlVpvBAc62WGWJEfRMxYFW/vYtI6vGJrucQ1GZPGJipatrjr6PvlfV8lCKKF4gAhvD2j5tu3bMLwSHAf6xFTJr9atMWb9iuJxh5mFqnTAy8ArgFvEgNceSCjdDBCHlWYpAV6m/8GKceFaG72QEVdN/cUeuhJSTBG41XwhRnPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711987105; c=relaxed/simple;
	bh=XrCRvOXImQIrwYCV3NhMIp4djlball5QFlWz7bHdUos=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GTs2E7ffSG5ePsrPs1LAu3bvr7/sASLAkTjhy0velmL4Ki0bRJkY2BMUMPvgUlytYHqQNmYYQ4dDkd2/1PUr0Azf+FN1siI9dXsH7q6ISoU/e8kt4XD0UOBaF6O0OLboBCDc/hm7o+uKEUBjNsNvXOB0Q0BhdpI4mAVlNvzzdYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bG+brDtv; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bG+brDtv"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-29ddfd859eeso3452841a91.1
        for <bpf@vger.kernel.org>; Mon, 01 Apr 2024 08:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711987103; x=1712591903; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5g2bA7wbvaYJDGwhnP868BxT5rPYQ/Pt5K6Kkx4y7Xc=;
        b=bG+brDtv//ddx6oTs59D/xXCi6sF9M978TlVTaAYL1NxNjkNLmJqMaOCFzHbcb0qh8
         1VgplCtDel2XTuGBypfbIN0PfEHU14obPTf894lc5BgsIDVPcCILseGww3llckjK9zdX
         ZOUaqnXPvFXzyVt7hrbm5DdlTIbfB0YDNRSGpRf/oHmNAZwCbeUbpa5wZ9OOSZKF6Kv8
         5LwPfyq+LQD8+Utx5IVq1HZYDgFwYGiZ8hXli0wFEy3hkvCT+k17n5ARaM0GOKHv6UVn
         6CCy/F67oGpfAeqzO8uqluwCCXeMspjTLqhcY/qhqHMV2a5GT2HhJ+alTqgRE1kfCawQ
         Zy/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711987103; x=1712591903;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5g2bA7wbvaYJDGwhnP868BxT5rPYQ/Pt5K6Kkx4y7Xc=;
        b=CyB8UuQo5DkzbqOhTUf4AgEC2YtPR3x7Z5sCOO3wzogHYBhsehMZhDTL3hK4Y5NTHE
         gU7m3ZZGNdd4G1eIP7FqGhHs31RaWpX7VuqsnNc0kfY4SM+WtrjZ1PTXOnRa8TvYbm5K
         ri22Y7ivHBI+48xdHeMw1L8nEvwFyKK4udGUJG/Hka+122hmncdnKV6+KA7cKlKxo5pf
         Zd8wv73SKYx0Q06iD1doFRZzdMypjHH7InBJyEb+xizGeUwXBp0uYOxp34eDnQHrhtkG
         hTOFUzZLg0SHg+yLtcTy4zyBkr3JgPfM8aKTfVb+jkMP9T0bijTxh338hhbxNIe7kJGn
         8ktQ==
X-Forwarded-Encrypted: i=1; AJvYcCUyi4ZCcD2pHRnBbvJT5bDgo8mOdWfpfdSay2ADThGNe/utSgAJ/vRBiHCcR+xHhsrRJwY/JudRNkmSoiz17UBZHf8T
X-Gm-Message-State: AOJu0YwxLmlZMPZG127vEHXHkzcDNJWwZKF+s6l2SmrQMVuG9GClVtPA
	0DjRqlktiQ6DmtoLgO1LkwPcMIsuv6EeS/SrLeYYYuoHGPbeJv7wFhanLeaj1gN7Hr2k099+1ON
	s+UJJA+kpW5vN7WjJTygDmJ+1DUk=
X-Google-Smtp-Source: AGHT+IFRnL0inylMoIxCN4dthepnV5bAoMzn+P4jHxzOUB2vDlrtFwuqbTlWQ6v5JQzfYxaX2l0oAoXYkKToDleYJAc=
X-Received: by 2002:a17:90a:134b:b0:2a1:fe2c:75e9 with SMTP id
 y11-20020a17090a134b00b002a1fe2c75e9mr8756664pjf.42.1711987102940; Mon, 01
 Apr 2024 08:58:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240322102455.98558-1-alan.maguire@oracle.com>
 <20240322102455.98558-13-alan.maguire@oracle.com> <CAEf4BzZjm+Q7wP4bZ+kAV_6Q-zAsYeK45WArCrzfn2aP6s8p7Q@mail.gmail.com>
In-Reply-To: <CAEf4BzZjm+Q7wP4bZ+kAV_6Q-zAsYeK45WArCrzfn2aP6s8p7Q@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 1 Apr 2024 08:58:09 -0700
Message-ID: <CAEf4BzaiAtXpztndNdgKWXzwtiPsApcqka6iP_cXHjDa_RKEJA@mail.gmail.com>
Subject: Re: [RFC bpf-next 11/13] libbpf,bpf: share BTF reconcile-related code
 with kernel
To: Alan Maguire <alan.maguire@oracle.com>
Cc: andrii@kernel.org, jolsa@kernel.org, acme@redhat.com, 
	quentin@isovalent.com, eddyz87@gmail.com, mykolal@fb.com, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@google.com, haoluo@google.com, houtao1@huawei.com, bpf@vger.kernel.org, 
	masahiroy@kernel.org, mcgrof@kernel.org, nathan@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 29, 2024 at 3:04=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Mar 22, 2024 at 3:26=E2=80=AFAM Alan Maguire <alan.maguire@oracle=
.com> wrote:
> >
> > Share reconciliation implementation with the kernel.  As part of this,
> > we also need the type/string visitation functions so add them to a
> > btf_common.c file that also gets shared with the kernel. Reconciliation
> > code between kernel and userspace is identical save for the
> > implementation of the reparenting of split BTF to the reconciled base
> > BTF; this depends on struct btf internals so is different in kernel and
> > userspace.
> >
> > One other wrinkle on the kernel side is we have to map .BTF.ids in
> > modules as they were generated with the type ids used at BTF encoding
> > time. btf_reconcile() optionally returns an array mapping from old BTF
> > ids to reconciled ids, so we use that to fix up these references where
> > needed for kfuncs.
> >
> > Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> > ---
> >  include/linux/btf.h           |  29 +++++
> >  kernel/bpf/Makefile           |   8 ++
> >  kernel/bpf/btf.c              | 197 +++++++++++++++++++++++++++++-----
> >  tools/lib/bpf/Build           |   2 +-
> >  tools/lib/bpf/btf.c           | 130 ----------------------
> >  tools/lib/bpf/btf_common.c    | 146 +++++++++++++++++++++++++
> >  tools/lib/bpf/btf_reconcile.c |  24 +++++
> >  7 files changed, 376 insertions(+), 160 deletions(-)
> >  create mode 100644 tools/lib/bpf/btf_common.c
> >
>
> [...]
>
> > diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> > index 09a11954cad8..e034f0c26c96 100644
> > --- a/tools/lib/bpf/btf.c
> > +++ b/tools/lib/bpf/btf.c
> > @@ -5026,136 +5026,6 @@ struct btf *btf__load_module_btf(const char *mo=
dule_name, struct btf *vmlinux_bt
> >         return btf__parse_split(path, vmlinux_btf);
> >  }
> >
> > -int btf_type_visit_type_ids(struct btf_type *t, type_id_visit_fn visit=
, void *ctx)
>
> This and btf_type_visit_str_offs are heavily recursive functions not
> appropriate for kernel code, so you can't just share the code with
> kernel.

Sorry, a complete brain fart on my part. Of course they are not
recursive, there is no reason for them to be. So this iterator idea I
proposed, while I think is worth doing, strictly speaking isn't
necessary for your work.

>
> And before you rush adding artificial depth limits for kernel-side,
> let's discuss implementing btf_type_visit_type_ids and
> btf_type_visit_str_offs through iterator approach, just like we did
> for elf symbols iteration.
>
> I think it would be a general improvement to the point where we can
> probably think about exposing these BTF type id/string ref iterators
> as public API, as that's a very useful functionality. I just never
> felt like callback based API is the right abstraction (and still think
> that). But iterator sounds like a good idea and is worth doing as a
> preparatory series to simplify code in libbpf and preparing everything
> for kernel as well.
>
> > -{
> > -       int i, n, err;
> > -
>
> [...]
