Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94FC2DC322
	for <bpf@vger.kernel.org>; Wed, 28 Jan 2026 03:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769569856; cv=pass; b=sMRMwp4V1pz19DcLTVGsxHRYVLFIFdjHnkRfo60UKRWYsgaF814oYjGMMdKdXswpzziPjZDtxfwJLqlUYGPgwLzu+BXSWVkq/2lEMnkkjArI/b+FpNA5N/4AeI49816UY5hmDhlFn5rylOFJQwEN1E8Hh9VKvtnDdvrMz+7eGlw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769569856; c=relaxed/simple;
	bh=aU7Yelh0WeEW8tHjaqgUNWAqcA4lom3gUnjAJjMQFJ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kqqv6Pi4jH0uodjEIP9r2gafXljyDF+OPtDT5fFaTrnMc24E1+U8oid6B6rx8YvZZHrn9Na/b2dh1dT+bgFZv3YvVKZ1UnpZUjj0Tq0iAjcQOQDCedEeWK7rWvjnMBQ28r05Gm7PqhKZZiquvudwSND8SLgU4R3p0hRcfl+HGbo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Qwdvwmwr; arc=pass smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Qwdvwmwr"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-5033b0b6eabso75141cf.1
        for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 19:10:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769569847; cv=none;
        d=google.com; s=arc-20240605;
        b=OrmqmonNwXYSQFngemAFaDWdpNozFye4e7L4cU6jocS2HN8uIe5Ba41NDtnFHWqwg4
         pjnCSwbj/ss7pRYR81qc/75nmtuqrn2t5bPboWKril95Cau9JSjBYEbVsdAXvjPLUKCO
         3+9TL48XBD5OyzepcJFcKPF7nQ50SdDRJdkKG90ZFqDNGQdAmwo6707YGTYyDBH9geid
         w08X7QF7pUMjnah/r5UNUcZsbZF1iRYAKG5zMfUmdO6bKqP2n0mh44hDeV1E8kX7rGEP
         BqDN88ifhFur503p+fVSBeq3hpvczWnaXQGPjxtIuKvZutSN2/zLCZwidP+Xl32k0ytd
         MquQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5/5XNX0NIr83WC5bOdhhJC5S1PzkaEr8t27CnKmRubw=;
        fh=S28IKLljYO5ribukOX+7btu0mmxV7tW1bx2QZ2d+1I4=;
        b=GryK/SgEhOA/fsom8odNOOdOdQ9G5XYE6490nXHpqBS/XYIUPsFcMnJp7VcN9p2P0e
         q6nbZmKW7Io2ViVsNPHvm4wJYf+IVhxqxDurnHsdenp2XHn5VGrq6kCpPmhu42b1QASu
         GictjmeZsWjuzAVUJ30nualjrjeqEwwWCyCDughABnLm2RvrpOnIQaHdzmyN9NOzhKB5
         9JTuSTeO/pxZ/D95jyqi/8LFaFnIj7ghMWZwZPUamp01dzN0GQe4I4EMUEiOI1bJBLDP
         UJ7DVzcqIaXPc6KBqpvzxmuUfnc21TP5MrdPMk4lcIH/yb+E7A7W8lDGabG7AVpKtV0G
         qFQw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769569847; x=1770174647; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5/5XNX0NIr83WC5bOdhhJC5S1PzkaEr8t27CnKmRubw=;
        b=Qwdvwmwr4LJ2a8wUgGXo5Tr3zksw7HLIAdVy5fP7WjW52IBGhDOeKx+YccbXOckCrf
         470mB/fvcG1QDoxVC5RFq7DQAQQ5eLuITIDUl/mm+IV4NAoC2an4UF5AUPLCsC0g4qkz
         uGV7Kub1iT2bNmnlh4pcYh2+A5Js/DM0EXLomSPkEShhaHJBz4kTpJmzJfZtwKb0y21a
         mBnzRVxrT1GPSAClVgbO0Dg16eWbEFzioHPF9C2OUgczQctxRDi+0JnfYqJ7HQFTF/3B
         SGKzFxQMYShOnqqNzVOU0LjYOb/ElJP2EVx9pkT564hRNviElY34/l3jF8PWzo6U2xnP
         fSwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769569847; x=1770174647;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5/5XNX0NIr83WC5bOdhhJC5S1PzkaEr8t27CnKmRubw=;
        b=jB5aLZjgDNOuEnrugsugrxBcQMh9us8jEp/uSqbocFvJsj3RujoPAlkxNHkQknl3iJ
         HSVokNv5e+g+5LS/pHDXicWmMpvMdj4fT+9IK15xuYeFjtvSXvOVSuy9kEE9vjpPi+OR
         OXRQNudFLGZN/5s0n0SuIic/0Xw7fIPALyf3oAknLvAIqw0geZ6AxulkD5oucDpd6HUu
         lp+S8ZyF1VAASHLTT55iZvJWvFIttR6fRqJ9F/5nIRI2beIPZBZQT1GaIa9wDoe17myp
         7oLvbYUKD9WUqgYfrj7VxaPPYWHQFm0bsf0L3QrVITyUWXWmZno/f/TUTH/RCfU5FHze
         CRcA==
X-Gm-Message-State: AOJu0YywR3dFX2Eyw7T1qJjU187PEM7hpXelgww0Kc8Kj9h1UwT6RImD
	hEH76oukvZ+DnTGlhjxJGl3/hCoZGNsiXJs9CyIIfYKUFpPL4Z481xqOnG7yGNJ98uRxXnmm8Bi
	b6dqR34I6G6NxQVNrqQQZs331tp2b2lnWemWSGK1m
X-Gm-Gg: AZuq6aKzb7/9HfK2GSc3R0BY7f+3g3R2VzV9aJ1h5AzoimwCG1G016T9GQZM4OJwVlY
	9BhfE1Ts8vDJPcn6Fs410onrrpQfeY0am9pGEx7kN9sM+8ddNbRiyp0qETtoeVUYxzzSFRPrCHL
	IWmPC2ZTos09NEabaH5xmPt+2LxC5KTAMP6uozI1Pz48VYHOT7EMT12VW2RDNp5PYJvCsdREu1f
	MR+iuLM838GUaffoqaXjXgctrJrn0dCjKDnWUC1jGV1NFp1zH7TMvbK6/XDr7HUHyjJ14n/
X-Received: by 2002:a05:622a:14cc:b0:4f1:9c3f:2845 with SMTP id
 d75a77b69052e-5032f4c7effmr16160051cf.9.1769569847132; Tue, 27 Jan 2026
 19:10:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260127024421.494929-1-roman.gushchin@linux.dev> <20260127024421.494929-3-roman.gushchin@linux.dev>
In-Reply-To: <20260127024421.494929-3-roman.gushchin@linux.dev>
From: Josh Don <joshdon@google.com>
Date: Tue, 27 Jan 2026 19:10:35 -0800
X-Gm-Features: AZwV_QgLB-AwxBPbb9RgtshaQD3BxstmR9oUwNC7yUpAS1o0R_J-bs8gRUVrEaM
Message-ID: <CABk29NvS+4F-a=Z7Jp27OUZCJ2YUWR3LJcwT-NBoWYAK8JeCEg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 02/17] bpf: allow attaching struct_ops to cgroups
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: bpf@vger.kernel.org, Michal Hocko <mhocko@suse.com>, 
	Alexei Starovoitov <ast@kernel.org>, Matt Bobrowski <mattbobrowski@google.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, JP Kobryn <inwardvessel@gmail.com>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Suren Baghdasaryan <surenb@google.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Roman,

On Mon, Jan 26, 2026 at 6:50=E2=80=AFPM Roman Gushchin <roman.gushchin@linu=
x.dev> wrote:
>
> Introduce an ability to attach bpf struct_ops'es to cgroups.
>
[snip]
>  struct bpf_struct_ops_value {
>         struct bpf_struct_ops_common_value common;
> @@ -1220,6 +1222,10 @@ static void bpf_struct_ops_map_link_dealloc(struct=
 bpf_link *link)
>                 st_map->st_ops_desc->st_ops->unreg(&st_map->kvalue.data, =
link);
>                 bpf_map_put(&st_map->map);
>         }
> +
> +       if (st_link->cgroup)
> +               cgroup_bpf_detach_struct_ops(st_link->cgroup, st_link);
> +

I was worried about concurrency with cgroup ops until I saw
cgroup_bpf_detach_struct_ops() takes cgroup_lock() internally (since
you take it inline sometimes below I falsely assumed it wasn't
present). In any case, I'm wondering why you need to pass in the
cgroup pointer to cgroup_bpf_detach_struct_ops() at all, rather than
just the link?


> @@ -1357,8 +1386,12 @@ int bpf_struct_ops_link_create(union bpf_attr *att=
r)
>         struct bpf_link_primer link_primer;
>         struct bpf_struct_ops_map *st_map;
>         struct bpf_map *map;
> +       struct cgroup *cgrp;
>         int err;
>
> +       if (attr->link_create.flags & ~BPF_F_CGROUP_FD)
> +               return -EINVAL;
> +
>         map =3D bpf_map_get(attr->link_create.map_fd);
>         if (IS_ERR(map))
>                 return PTR_ERR(map);
> @@ -1378,11 +1411,26 @@ int bpf_struct_ops_link_create(union bpf_attr *at=
tr)
>         bpf_link_init(&link->link, BPF_LINK_TYPE_STRUCT_OPS, &bpf_struct_=
ops_map_lops, NULL,
>                       attr->link_create.attach_type);
>
> +       init_waitqueue_head(&link->wait_hup);
> +
> +       if (attr->link_create.flags & BPF_F_CGROUP_FD) {
> +               cgrp =3D cgroup_get_from_fd(attr->link_create.target_fd);
> +               if (IS_ERR(cgrp)) {
> +                       err =3D PTR_ERR(cgrp);
> +                       goto err_out;
> +               }
> +               link->cgroup =3D cgrp;
> +               err =3D cgroup_bpf_attach_struct_ops(cgrp, link);

We have to be careful at this point. cgroup release could now occur
concurrently which would clear link->cgroup. Maybe worth a comment
here since this is a bit subtle.

> +               if (err) {
> +                       cgroup_put(cgrp);
> +                       link->cgroup =3D NULL;
> +                       goto err_out;
> +               }
> +       }
