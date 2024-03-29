Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1216213C3D5
	for <bpf@vger.kernel.org>; Fri, 29 Mar 2024 22:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711749880; cv=none; b=lIdeKgxn77lpYbru2BkOrrd/gDFY1f7sqXnrYMwjsMYUwN5ipr5hSB9qyuRFEhqiqmmZq1dlrpjEOhArcCMhZnxQJZw9F233Xjtm+Wwxw4c05fEPfn59BpY8TPBQ4RhOU0bgS0Ms7oyxkXeKn5h4rTqZ/HFwTeJvEHgav1+T/oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711749880; c=relaxed/simple;
	bh=xkchRkPGk8/7Kr1Mlt8HHFT2P+fPg0XG00nj6hVBRHk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PseZJmraclQ49XToGDmy7RzKZUJwhhCqF3omLq/xyXY8D5dHVfN4BUAXfS/wzPy0qXmxmxY9VC9glWKLPHmC+lARuU/0YykIHM7n7xTQNHkMQej3h08fC5lflGBYoS1noR5IvffD8cVNfIlxWNNQnCj62/RtQTL/xz6dwl7xzHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fdTVQ9Kg; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fdTVQ9Kg"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a44f2d894b7so281922066b.1
        for <bpf@vger.kernel.org>; Fri, 29 Mar 2024 15:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711749877; x=1712354677; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xud9jLFBx6c1cAS2Nl7HZBsMjUPIYP3+VF3HfvHcLIE=;
        b=fdTVQ9KgMiibby0Rpr2EIH7KY78UKtpuHlTc14aItci0Ejmsd7QoWpdfOSFDIyh3rM
         V57VdRP0tEVefVo46M9wbYbfGm9KF1F9vJ4PHL1hUKnuiHGxMYYaD218GLNC4GjwUu+0
         XVNl+JjE4d/uQEZMSamLarTiS4XyOBu2WVj6/ZNWnhVZXERzRqJAQibnJ41GQhJWMwpW
         vuK38y8wFSqQNr5aS8wTMchBQ6jGAqJNIc4/SLKWNX+2tBCL80lAor70XIY/7zlNDg+N
         aKpR0aO0CHskXfU61XT9Rj2vRq6Ak9/9ddE+BIeKHWAOVR3NLuFrV7lGUz4IWTDTDvGo
         nCGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711749877; x=1712354677;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xud9jLFBx6c1cAS2Nl7HZBsMjUPIYP3+VF3HfvHcLIE=;
        b=qjeIs2Va8wI1OBIRHI2a5xTBpL3/2YLwSZ6+tsSt9UJE4ITcZqJ/5/f73l+4lnk4a9
         LhhbCr7xwgIYQhhIoya/K9aKPmwZJsW/sx/SbWIO8Nr7Gi7S2h4XYmu38+nbEzpNb6g3
         KzhCWgqGIhsyYLCjWujIY48vz3ByH0pUu7hWp6vT8pJ6wVuDQ/ENh70ysiyLhL3XznFi
         LzXer4k8Ebkom8R/2hU1kQDp2OB1TxxhS4qojjQ/B7Qul50Fr4TKb+6kX7KQsbvskIqe
         j3F7ak0a+Qe6LZw/kUgxfRfHuwXRYRfQ2lTnBh+9fDZHzIkgCOvixeGqukLX1db4qfEz
         GkJg==
X-Forwarded-Encrypted: i=1; AJvYcCX27ALwyG6xRHPs67jTot+m1u4owQc5sMjBQUT7hpVtL23XiPl8PzqkEUyVZxMtrGmIJy+tyjpn4npcwSwnORhnzr1I
X-Gm-Message-State: AOJu0YwWVWPiVf6Gwp5HZxRp1f79G0wOLI7PkqICyu3wlksbFrT9zgHT
	cUBwA/lA5iOp+IJDTu+ieDdYP5ztqgiv3RBXkfszwtnWZxC8lcVCE9c7xW1v+9BsjX0J0zJtIn8
	SZWUtYCIAOwJ+xrlptF8x4ORVAvo=
X-Google-Smtp-Source: AGHT+IEsOAzjsz23HowLZafvrZ566VvQxoJE/pIKrKKgIay9vgqiWLzrvgwTn2c7sM3CR4dFEkZ3F1mwGjz4q/XtoeY=
X-Received: by 2002:a17:906:68c2:b0:a46:5a46:7512 with SMTP id
 y2-20020a17090668c200b00a465a467512mr2250986ejr.74.1711749877375; Fri, 29 Mar
 2024 15:04:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240322102455.98558-1-alan.maguire@oracle.com> <20240322102455.98558-13-alan.maguire@oracle.com>
In-Reply-To: <20240322102455.98558-13-alan.maguire@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 29 Mar 2024 15:04:21 -0700
Message-ID: <CAEf4BzZjm+Q7wP4bZ+kAV_6Q-zAsYeK45WArCrzfn2aP6s8p7Q@mail.gmail.com>
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

On Fri, Mar 22, 2024 at 3:26=E2=80=AFAM Alan Maguire <alan.maguire@oracle.c=
om> wrote:
>
> Share reconciliation implementation with the kernel.  As part of this,
> we also need the type/string visitation functions so add them to a
> btf_common.c file that also gets shared with the kernel. Reconciliation
> code between kernel and userspace is identical save for the
> implementation of the reparenting of split BTF to the reconciled base
> BTF; this depends on struct btf internals so is different in kernel and
> userspace.
>
> One other wrinkle on the kernel side is we have to map .BTF.ids in
> modules as they were generated with the type ids used at BTF encoding
> time. btf_reconcile() optionally returns an array mapping from old BTF
> ids to reconciled ids, so we use that to fix up these references where
> needed for kfuncs.
>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>  include/linux/btf.h           |  29 +++++
>  kernel/bpf/Makefile           |   8 ++
>  kernel/bpf/btf.c              | 197 +++++++++++++++++++++++++++++-----
>  tools/lib/bpf/Build           |   2 +-
>  tools/lib/bpf/btf.c           | 130 ----------------------
>  tools/lib/bpf/btf_common.c    | 146 +++++++++++++++++++++++++
>  tools/lib/bpf/btf_reconcile.c |  24 +++++
>  7 files changed, 376 insertions(+), 160 deletions(-)
>  create mode 100644 tools/lib/bpf/btf_common.c
>

[...]

> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index 09a11954cad8..e034f0c26c96 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@ -5026,136 +5026,6 @@ struct btf *btf__load_module_btf(const char *modu=
le_name, struct btf *vmlinux_bt
>         return btf__parse_split(path, vmlinux_btf);
>  }
>
> -int btf_type_visit_type_ids(struct btf_type *t, type_id_visit_fn visit, =
void *ctx)

This and btf_type_visit_str_offs are heavily recursive functions not
appropriate for kernel code, so you can't just share the code with
kernel.

And before you rush adding artificial depth limits for kernel-side,
let's discuss implementing btf_type_visit_type_ids and
btf_type_visit_str_offs through iterator approach, just like we did
for elf symbols iteration.

I think it would be a general improvement to the point where we can
probably think about exposing these BTF type id/string ref iterators
as public API, as that's a very useful functionality. I just never
felt like callback based API is the right abstraction (and still think
that). But iterator sounds like a good idea and is worth doing as a
preparatory series to simplify code in libbpf and preparing everything
for kernel as well.

> -{
> -       int i, n, err;
> -

[...]
