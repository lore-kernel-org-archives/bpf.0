Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1A9333730
	for <bpf@vger.kernel.org>; Wed, 15 Jul 2026 05:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784094453; cv=pass; b=JYicOS8wlFcxxDWpDy5+f0JbJ5j1N7LrLfGeM2kR/TnPNlcq4zW9f5bHMaMhv1ftrPMQQ8YR0nVYD1IkCQzyv3TxTbuPJVFaq8lhNKKX70PTcDosRSTuq1XkQLUcFMRHlPaaExYpMxflRLf2x1k7UE1qBbX59orI7QdMj1ZaiCE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784094453; c=relaxed/simple;
	bh=4JLajTu0FO/qWJoIfkHjWR8qPD66qYSp7rWfDr6lce4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i2kU0SUUqWfYkf9LXqogkUIg4vMB95Ls5rsVQeP6RkY6GpXhtE2iDtv3Um8bN/vQxTAb751wsGR9l76DmBij2agi7btbSuVz8s2pGlLyFYtX3K822vU6Y8PhgxpeejnoxErbL5+jsTfJMNnc7HsbWh5z4t7HGBuI/k0byCTwkcw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=seTnZQLm; arc=pass smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="seTnZQLm"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-664cdeab266so7110672d50.3
        for <bpf@vger.kernel.org>; Tue, 14 Jul 2026 22:47:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784094451; cv=none;
        d=google.com; s=arc-20260327;
        b=Nm4+Bj80PZ0LkrWgac8ZEeZedloOe/h4lbLmjScXIitDhRB4spgbzBKHMSz2+vVoG+
         VSG+kpBJYIiC1xmYjUdx4HAnhl02yAgrrUGMMRPIp1nUTuWiRZpWytp5wOIHsEDrnGbj
         JMdWM1DotNilqXCzjJ7va6FvtYh9oj25fRi57FZN2E8DKO//SLOIUuHZdRhngy5WpVcR
         rsNSYi6yMhIy8nFqofMqW1eZTsRoPiG1VdBltE9rSVdHqpDsfsN4rJyr/cHQrYAS/LhB
         lhWlfyXxdXj+u/37rvrvvbjeOHEQPKfXnQ4fIsXHr0cwWX0APsOSP2orhBZllxYWFec4
         Bvqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OIYiKWjJwre8BJ11NjV9uPvXEfGYHlRKalfzw/jXDUg=;
        fh=6Z4J3xNs+qgwS2aK097++l2x6CIWkNCmJIKZe8W3oU4=;
        b=mcaglubB/lh/V63YFTk+WcsBWJj+kOztPXKJ+/fQfZ/1IuKocM4VQkxYVT0UAadr8x
         yLcvGcY+cIeQfnIQ4x0+oWkBdb4yzDgm3Qd3ekvM1w05CYtUramzk++bplmzUC//Xy+H
         YrjD6KzH+868wnm9FHrbY2JEyLkKRplNVgv0phPUayQ/jS8HfA41DfIMQQ2J7wKgl7JQ
         bq9zKbgGJrzgWF1XVFykPG30DaVQm/n1fQsHbF+vHfXoq6PtQKpUf4NRy7fKnyPNOd/a
         cnAB0UpG2AMpPOHkCBKXFq4qGryNxZ62YRJoU6FXxBLP2Ad0j0nCYAOg2XK2zKjUbjBD
         yZzA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784094451; x=1784699251; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OIYiKWjJwre8BJ11NjV9uPvXEfGYHlRKalfzw/jXDUg=;
        b=seTnZQLmb8HeHbRpAoddMRe2phg5ifWZaekEMcdJK1tOO8xcY9F8NeH5WlIzRNhSCW
         uxs9w/X9W7dSl8chpMmfW0V5bsAdEyxAhTvsX3ts7kHAk06+wdEdaWRzbaExLdUmxMoT
         pF29uZ533z1vOiX4Thj0MiUf6iDYwcYDJVnekfFVjg9/rc0GrVsYaWSNQv6N55WrmD9D
         nBm/vB2VX91Z4ojiEcE1Mrn3BKou53jst4tClo1jsr7HhxfEOFu9VR5nEp5oEwgAiv8h
         6wRkSivgyrgjxsYG1UmugpzBUqGVyFYjE0Ov16b1wvpoUoOcDHFGoAemf7A2935PlHGZ
         a56g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784094451; x=1784699251;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OIYiKWjJwre8BJ11NjV9uPvXEfGYHlRKalfzw/jXDUg=;
        b=Ni3L4pQ5jlu9QIbuT/c2PmzpTgyJNT7/lRC/AbcwAnh/5Az9pSuY0qt/oRzUF+QCVr
         EPFy4INvbjE4xydgupyFVYdD9/wiZ69LKMLs0y+8qvKiYdUz4X/o/H215HVsyaB15f6v
         63HS4jVMxnlvHU6Cs3hHnx5qE1T7XVLVL7vgrfBKYkZBdH8xlWf9UyUScR1hiKqHkqNB
         u0XA2gLEyfENl5DDAELOwq7SyPksIks935S1Gohf6rn8FcoQ+zRHmW3lsV9pescgTFHe
         6QTamgra/iiUL5pAVDe/xUJ5VvOlZDhnKcDCQGJtk1Q+23gV0+3IflokcmHmc7Ncg28b
         geng==
X-Gm-Message-State: AOJu0YzWbde8h4NsxwmJ1ImRhhtamYCSS5ajVOMFS84nPxwyKtitAGQI
	lqrFvuYfgD2lj5Iu+S6FsJChKzFdqLq/OX2+3XvEbQ0s6gJ8Oyl6GFs//dzcC/LzYC8Lvn2pTcc
	/qC1gTs2rG8TxigCSvXEj+EhTFkV4DlM=
X-Gm-Gg: AfdE7clqRvnInOEpJft2c/gdVXAbwAdIHKS08RMFP+M7aqiU8rqTH8Msm45+VDF5z71
	qGNkEvA7Nqc/05Tzccrs4q1FhHVgYBXgEkyW5Pz0D+jTNvWt76JR8SQ6mV8LFeMzkkDQC/MZfDj
	meTs2taZZTfiMoW0lxEDxx6qoxBi1aDS+oUrWs9PHE28ruOt0zcpvPPLc+Vhu1tlrXIKFKUimiV
	2Uaa2++UUpkOQGywIUWI78esfi3PPIF4IFCBLiOoWkvAFolAg3qBOqIx5kivz6lGP2BKyq6
X-Received: by 2002:a53:a08e:0:b0:667:b503:4d34 with SMTP id
 956f58d0204a3-6681332257amr888997d50.36.1784094451165; Tue, 14 Jul 2026
 22:47:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260709230242.2003459-1-ameryhung@gmail.com> <20260709230242.2003459-4-ameryhung@gmail.com>
 <04106a6f388a8852e456e473085a38000723be69.camel@gmail.com>
In-Reply-To: <04106a6f388a8852e456e473085a38000723be69.camel@gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Tue, 14 Jul 2026 22:47:20 -0700
X-Gm-Features: AUfX_mwy3JSPgTKjdSn1uC34x1YVVfJxC2t9bMpr5Z3ENzT89MH_gqUMzKLFoiI
Message-ID: <CAMB2axPLu0w6uvd6vE5i8C6bCALd7iKPPsWcNh6LM1v5eTJuyQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 3/4] bpf: Unify helper and kfunc
 allocation-size argument handling
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org, 
	daniel@iogearbox.net, memxor@gmail.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 14, 2026 at 11:14=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
>
> On Thu, 2026-07-09 at 16:02 -0700, Amery Hung wrote:
> > The constant "size of the PTR_TO_MEM returned in R0" argument is handle=
d by
> > both helpers (ARG_CONST_ALLOC_SIZE_OR_ZERO) and kfuncs (__rdonly_buf_si=
ze /
> > __rdwr_buf_size), each with its own meta field (meta->mem_size,
> > meta->r0_size) and duplicated validation. Add struct arg_alloc_mem_desc
> > and a shared process_const_alloc_mem_size(), and replace both fields wi=
th
> > meta->arg_alloc_mem.
> >
> > The desc records presence with a 'found' flag instead of using a non-ze=
ro
> > size as the sentinel. This also fixes a pre-existing bug on the kfunc
> > return path: "no size argument" was tested as r0_size =3D=3D 0, so an e=
xplicit
> > __rdonly_buf_size/__rdwr_buf_size of 0 was treated as absent and fell
> > through to btf_resolve_size(), giving R0 the size of the pointed-to ret=
urn
> > type instead of 0. With 'found', an explicit zero size is honored and
> > btf_resolve_size() is used only when no size argument was passed.
>
> Could you please add a selftest that triggers this bug w/o the change?

Ah yes. I will add a selftest testing size =3D=3D 0.

>
> > The size is stored in a u32, matching regs[R0].mem_size. The U32_MAX
> > check now apply to both helper and kfunc through
> > process_const_alloc_mem_size().
> >
> > Fold bpf_session_cookie return size assignment into current kfunc retur=
n
> > size resolution path.
> >
> > Note that verifier saves kfunc return size through r0_size instead of
> > mem_size. The later has no active readers so remove it.
> >
> > Signed-off-by: Amery Hung <ameryhung@gmail.com>
> > ---
>
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
>
> [...]
>
> > diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.=
h
> > index 056b99d26cca..3ed788ec6afc 100644
> > --- a/include/linux/bpf_verifier.h
> > +++ b/include/linux/bpf_verifier.h
> > @@ -1473,6 +1473,12 @@ struct arg_raw_mem_desc {
> >       int size;
> >  };
> >
> > +/* Size of PTR_TO_MEM returned, taken from a constant allocation-size =
argument */
> > +struct arg_alloc_mem_desc {
>
> Nit: 'returned_mem_desc' seem to be a better name.

Sure. I will change it to ret_mem_desc.

Also worth noting that r0_rdonly is intentionally left out. This is
because the information can be derived from BTF before the main
verification loop. In the future when we generate bpf_func_proto for
kfunc, this can be saved in ret_type (i.e., {rdwr,rdonly}_buf_size
imply ret_type =3D RET_PTR_TO_MEM | {0,MEM_RDONLY}).

>
> > +     u32 size;
> > +     bool found;
> > +};
> > +
>
> [...]
>
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index e2a3ed67d2eb..fcd9715eff01 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
>
> [...]
>
> > @@ -6974,6 +6974,40 @@ static int check_mem_reg(struct bpf_verifier_env=
 *env, struct bpf_reg_state *reg
> >       return err;
> >  }
> >
> > +static int process_const_alloc_mem_size(struct bpf_verifier_env *env, =
struct bpf_reg_state *reg,
> > +                                     int regno, argno_t argno,
>
> Nit: argno_t can encode both register and stack arguments,
>      would it be possible to adjust the code initializing
>      'argno' variable in check_func_arg() such that it is
>      constructed properly based on 'arg < 5' condition and
>      passed here as a single value?
>      It appears that such a change would also remove a lot of
>      duplicated 'argno_from_reg(regno)' calls in that function.

I will add a patch to first remove the duplicated returned_mem_desc()
in check_func_arg().

>
> > +                                     struct arg_alloc_mem_desc *arg_al=
loc_mem)
> > +{
> > +     int err;
> > +
> > +     if (arg_alloc_mem->found) {
> > +             verifier_bug(env, "only one allocation size argument perm=
itted");
> > +             return -EFAULT;
> > +     }
> > +
> > +     if (!tnum_is_const(reg->var_off)) {
> > +             verbose(env, "%s is not a const\n", reg_arg_name(env, arg=
no));
> > +             return -EINVAL;
> > +     }
> > +
> > +     if (reg->var_off.value > U32_MAX) {
>
> Fun fact: when passing parameters to a function, the verifier forces
>           the buffer's size to be < BPF_MAX_VAR_SIZ (see check_mem_size_r=
eg()).
>           But that's pre-existing inconsistency.

Noted.

>
> > +             verbose(env, "%s allocation size exceeds u32 max\n", reg_=
arg_name(env, argno));
> > +             return -EINVAL;
> > +     }
> > +
> > +     if (regno >=3D 0)
> > +             err =3D mark_chain_precision(env, regno);
> > +     else
> > +             err =3D mark_stack_arg_precision(env, arg_idx_from_argno(=
argno));
> > +     if (err)
> > +             return err;
> > +
> > +     arg_alloc_mem->size =3D reg->var_off.value;
> > +     arg_alloc_mem->found =3D true;
> > +
> > +     return 0;
> > +}
> > +
> >  static int check_kfunc_mem_size_reg(struct bpf_verifier_env *env, stru=
ct bpf_reg_state *mem_reg,
> >                                   struct bpf_reg_state *size_reg, argno=
_t mem_argno, argno_t size_argno)
> >  {
>
> [...]
