Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3809042F6FF
	for <bpf@vger.kernel.org>; Tue, 14 Jul 2026 23:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784071394; cv=pass; b=tD+V4lryOPyB6AKAlZBzszVNRtEwgEo4ZJoWgIPihCZdj9Gbl+JpDpe6d3wY1BWMeJYroWT6ODJKL0uiIunUnSWRDAiOL4tIu6JYvPs0P08m8CmSt2iJEn217AsxPwje6ll5aGcPjyfXuJduobEf1eZFeN4sjgZGIN+GULkJwUQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784071394; c=relaxed/simple;
	bh=M0BlR+Pn+/GcLZGG/Z/3njw+2k5ihHPYnua6D81gWqw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BcTO1C7hdqq/vIXz4qHR3aleU6bE4h5cVJJOm7/g76PXQNGqgn5tZwQ7UlVjz1BIokYDIEKeAFBSJ4+mmDdww4ESb5dXLd/n8+v9FH3xdEnK6XD9DiR7bxhadd+LttSHqr6+eRs1rsd/CqRxPvJ2OYD+HeiQC2dygzS2PzVc/oY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qrhw4V/J; arc=pass smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qrhw4V/J"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-664d78637f8so8624682d50.3
        for <bpf@vger.kernel.org>; Tue, 14 Jul 2026 16:23:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784071392; cv=none;
        d=google.com; s=arc-20260327;
        b=S92CuBPN/SxvMpj4B4sD6xzz0tt1diYkDSPT4Nq9zk//8cICEHrfbnHt5HNmGV0tRl
         GlncNyBKBeMMMSUfz9gZtW69fDj7roANTQJODuc8JarJBi3BkPK2EH22ljIWKkA6/yR4
         EmAYHfZfd4dNgm7q5ChTixSXwjIUZO042MKCXE5VW4HOcf05MsvtQCC4xFYjrlg4DS9U
         jrtnc5e+iYW7sDnixYxpWiVj4XMjEbIWtIRrLf+6AZOGO/eWEaBQWKBynXBp/j9RQLBV
         V85J77kOomVjcu/mxxuXGvHfMggNkSIlNQ6r/v1Pm0EPuN51LEmE9Fk6A+c2tLbBw9e6
         wQbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4vSjA2aXnY2RGrFw6W6ktGjEAzJAM1MaKwwJ8FFUV5o=;
        fh=6Z4J3xNs+qgwS2aK097++l2x6CIWkNCmJIKZe8W3oU4=;
        b=LH1SM7WYm5gh6NYT2NbxkLkfuSmg4v7Ik4tA2mkzub4AHy8G6oVcZaFAY0SvhBu5Ei
         KrppPkwL5aGzKuIxuwEVP84l20ylgQiS+gBBIHLy2OOxbwOArxozNbJHNOT3jmsunTaM
         fbxINeXelKID4RbzGP5osSPfCH2VsIg5r164I6KmL1nJj9KTqM/oNjC9wDdu6yDIP4k0
         ng/y6YElz6gVgGLJMUrk9NTYKgGoGkI8WHeYSNYv23nAMX/wAV2/2xInzUZKyHlp40sR
         Ozi01HJyCFwpK0wE8l96SYlrkq5jNlxKc2Fg2RIYAAk7vZZf+CqISNnYSRFtHoCONPeq
         AY4g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784071392; x=1784676192; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4vSjA2aXnY2RGrFw6W6ktGjEAzJAM1MaKwwJ8FFUV5o=;
        b=Qrhw4V/JjvIjgzXbBDLOuF8aOYqkgh0cuXUEr/pkFB/LRA5JcTpr7moTeWuU7iGyPU
         iFae1+pUGFVu+h429Y4QQeDkgJPkToOjSgvaAuJy8k8xx76L/HNWKCDHPHsdMhlC/0sj
         /O+EsgGDvAF/r2XEPjACMGIYw2tY7Dx6zHh9IOhKkFWJWvU1hXba6vURCJO9rr9bTw5L
         MyT0ss4PMaq46c8fK/1ZK4s8T3AhvJote8HXxjZo9lo+VM2W6ILxs3WizptjFu9DsF/b
         X1eZMsInc/TeMLkP4M0hwm937hgzHYkb7o9shgrfKnyUmxLGYxqHiWvD5RiuMcWFC1I7
         8jsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784071392; x=1784676192;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4vSjA2aXnY2RGrFw6W6ktGjEAzJAM1MaKwwJ8FFUV5o=;
        b=gP+HNBZyiOUKFGmTGWYtmsS+HjilE5Um++3FaYH8vW1hcW2cflQ2qrQEfNP7FNithf
         LIvRmiLLbs7F9LNSCPl94TTlarVM57xgy1on2rQbj0PaStHsn+8zhNRojdfk6+zOFYjr
         u+DdRfFyS1xXYbrsKFa+bqzEMdgUwbGDJbv4WsJ7/AxR/3fb/p2SIdvFPBtN+0Q6JOxj
         ZWK/9vvCUDKb56rSMPI3zmLdfYIrq7hx4LKJMXonwfSogbsMci+d962sYc6/ZdnHdV2K
         bgAP3shVCCChfYtZKCA49h8eIUAzl1DVmt13hFEICm+rV3MIH0j/crixTH6TQSGbVa7N
         tqvQ==
X-Gm-Message-State: AOJu0Yz1jIWyV23d9sfdNScYAyrBGyHXY8D8x/g3gMNv5AaugVPcoYH+
	8Oyfj6dm6LWiLK7k6DnR5JxsbJBs6rdbtzJZlbHUibXbAmj0P9C6QxsE/5MZ2xj2CtiOuSS7M40
	kHNY48tu8n3OdgQjCfElqcNcT/fWBHM0=
X-Gm-Gg: AfdE7clYe5s1ZdPWGMQ0EQ/X/kzy7UsUn469Ai2G+5WU03gxd1NN9wzsMhOjpCFD6jl
	QwpvSe02IYXL0hg8eICmCB7DFk7UJATSOuK323JjY9VsCq/44TDR040MAigDIYg4qp23ORbogI0
	+IZhYxbdeRtVEVdc/fTTPR/LLcciHMPWBsZJe/nkp6iEPzcbZ/2D46naXbU4y7pTmypp/hkBAyG
	0xLPnDbJ5MTKNvBV7ins9g0ALbXW+7u3KDL5oECG7bCff+spOJE9+ksCwiO46TSv2/bgaJP3vwQ
	uW4+MRrwjQ==
X-Received: by 2002:a05:690e:2181:b0:667:8b91:244b with SMTP id
 956f58d0204a3-6681347533emr451427d50.98.1784071392001; Tue, 14 Jul 2026
 16:23:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260709230242.2003459-1-ameryhung@gmail.com> <20260709230242.2003459-3-ameryhung@gmail.com>
 <47f61a7ec3c41bbe3503723cd24d9d78db9a913a.camel@gmail.com>
In-Reply-To: <47f61a7ec3c41bbe3503723cd24d9d78db9a913a.camel@gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Tue, 14 Jul 2026 16:22:58 -0700
X-Gm-Features: AUfX_mwmUJAlIryGS7DgCM3y5dklNInN-kIndr4c5uxhMye4ymBZmAsY43rfR8U
Message-ID: <CAMB2axOTM46oErtKiQecTTV4Qmk2Yh2MZqmf-Koo_NRbNT75OA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 2/4] bpf: Factor out raw_mode-related fields
 in bpf_call_arg_meta
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org, 
	daniel@iogearbox.net, memxor@gmail.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 13, 2026 at 5:08=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Thu, 2026-07-09 at 16:02 -0700, Amery Hung wrote:
> > To prepare for unifying the helper and kfunc call_arg_meta, group the
> > scattered MEM_UNINIT ("raw") memory argument fields (raw_mode, regno an=
d
> > access_size) into a new struct arg_raw_mem_desc. The intention is to
> > make it clear about when these are set and used instead of fields with
> > overly generic names.
> >
> > Identify the raw argument once, up front, in check_raw_mode_ok() (
> > like check_proto_release_reg() does for release_regno), recording its
> > regno. check_stack_range_initialized() now recognizes the raw buffer by
> > matching that regno, so the separate raw_mode flag is no longer needed.
> >
> > Also drop the bogus raw_mode assignment in the ARG_PTR_TO_MAP_VALUE cas=
e:
> > arg_type_is_raw_mem() only matches ARG_PTR_TO_MEM | MEM_UNINIT, and a m=
ap
> > value pointer is handled by check_map_access(), never reaching
> > check_stack_range_initialized(), so tagging it raw mode had no effect.
> >
> > No functional change intended. This patch does not enable raw_mode
> > memory access for kfunc (i.e., uninit stack will not be allowed to be
> > passed to kfunc for unprivileged programs). Existing kfuncs with argume=
nts
> > tagged with __uninit are either priviledged or dynptr kfuncs, which tak=
e
> > another path to make sure the access is checked by check_mem_access().
> >
> > Signed-off-by: Amery Hung <ameryhung@gmail.com>
> > ---
>
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
>
> >  include/linux/bpf_verifier.h | 10 ++++++++
> >  kernel/bpf/verifier.c        | 50 +++++++++++++++---------------------
> >  2 files changed, 30 insertions(+), 30 deletions(-)
> >
> > diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.=
h
> > index 317e99b9acc0..056b99d26cca 100644
> > --- a/include/linux/bpf_verifier.h
> > +++ b/include/linux/bpf_verifier.h
> > @@ -1464,6 +1464,15 @@ struct ref_obj_desc {
> >       u8 cnt;
> >  };
> >
> > +/*
> > + * A memory argument a call fills in. The verifier allows the stack to=
 be uninitialized if
> > + * the range is a known constant. Stack slots are marked as STACK_MISC=
 by check_mem_access().
> > + */
> > +struct arg_raw_mem_desc {
> > +     u8 regno;
> > +     int size;
> > +};
> > +
> >  struct bpf_kfunc_call_arg_meta {
> >       /* In parameters */
> >       struct btf *btf;
> > @@ -1510,6 +1519,7 @@ struct bpf_kfunc_call_arg_meta {
> >       struct bpf_map_desc map;
> >       struct bpf_dynptr_desc dynptr;
> >       struct ref_obj_desc ref_obj;
> > +     struct arg_raw_mem_desc arg_raw_mem;
>
> Nit: this field is not used in patch #2 (this one).

Thanks for reviewing the set!

Indeed. Currently, there is no raw mode use case for kfunc. I will
drop it here and move it to the helper only section in patch 4 o make
it less confusing.

>
> >       u64 mem_size;
> >  };
>
> [...]
