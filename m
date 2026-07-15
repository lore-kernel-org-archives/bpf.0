Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73ACB757EA
	for <bpf@vger.kernel.org>; Wed, 15 Jul 2026 05:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784094521; cv=pass; b=I+A7Zt3i5xcmzqd1xGU6H4c7igi6CniA4PmHaYbJEEc47i4H7MzdEEInbUfV5/TwQWyYjkNy3X5yGkS7nTQ5ikwc3h2ZBanBFORmEqDCLT9d38AWMo2hSpUDzsfDGM63nKKoMQLkg3huiZxZk8sdeI8d4ldayLL7jGNdy/3XAwo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784094521; c=relaxed/simple;
	bh=0OfVz1et9FxYeXW11/UgUT4oA9GBL9x1ZK68UGpzcjc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P+3uZ0wwyCx2mIQQQ4vTmCrE5Ya8DjZbGyr2qbxck+Mg3fLUch1G0G1O7WvajRbix3T88hskIudvFEKnk/HFhbCQoWnOJL3zA+FyVvt9qOv4tiizzzYVRLQ3s5Etjk9UTVbZYPXDcBS2CXYuHDtm6MHBj1KpDBra6lDeqlSRAr8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bOdzi/m2; arc=pass smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bOdzi/m2"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-667f0cfb2bfso697918d50.3
        for <bpf@vger.kernel.org>; Tue, 14 Jul 2026 22:48:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784094519; cv=none;
        d=google.com; s=arc-20260327;
        b=QDDJQGxRK0cfhQijOPuS3o3Kpg4EAqydEtFODkjKE6uIAK+5NmqdSarEPgE+6z5dNJ
         beKMI/oIBbXJWGClKbFZ9KBh2k8MqGa+OiSZxa4/6Jtn9Dq4EBQHWMFbE2LCO4QZC5qQ
         R+gPS/yit6Drf00H6gjReuw0b/H/LhaGjKWHIjAdkeS1oYZernCpK7eWIDxy+qA8fVR0
         lOg25V0tRnQGoZcSdnpZRsfEdKmeL+496IZsawcvaMD0jm8vimGjXzpKTJlV74RGz5Qz
         Xg2CQTXJveb4p+Tdoaz/UHT6ZQgPsuEsArqtgbSjtiPFepUE+e4coJdiXYwlkrqTQMDI
         nsfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IBsM76exL4SFDnnMhHO0BgMMr/BT5bOV9fjnRY4cauI=;
        fh=6Z4J3xNs+qgwS2aK097++l2x6CIWkNCmJIKZe8W3oU4=;
        b=iJ0zbu3iCpiH2RxCBjm4fFeZsSEmphd6hkvdV4JEFLcAxcAgB5SpZW/bQnd4pt2wHK
         9EmABKnKuaq0bBtNx2BFyDSz/haunt+VZTeLYMnFdvWnJQL35AB9QllqsaaF6gkusNg2
         88qZo+uRg0SSYnU3LhHm6bzGQfjMjRrGXCBQJMWF+fYQqWg3RdEkNr/jvYp4qJQ3V0QU
         N0j/+uT5cGoui9xjeHE2swJ5BQdqGGJao8905ewkiNDw5R+8q/tyD22pi7U4wphA2MzF
         H4Na1Dl70rc1ZUg6UhIGxp/gQ9ycBAAwEc/zG8vD30tjPi+NMio6O2PKvu+iC3pP5Etl
         qJ0Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784094519; x=1784699319; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IBsM76exL4SFDnnMhHO0BgMMr/BT5bOV9fjnRY4cauI=;
        b=bOdzi/m2M3QcOz12MH3WJJYqFEIADsK8F8e3g3Xrz9QQY3Mw7BBmkB5r24LIr5Qsfp
         nB2J7sn0uHtwbOZllPc7DRN0nJRkuP6EyUdSsBr7Suq1IxvpxISFjM19JyRCXzflbILM
         z0HrluHiUlJIRVoV9hatcTbdTmnVsCcuCGqn96NRYQQSQ7wmkld8L1xKmsC+NfLZNgN8
         Xbk43poHggUpVj9DGpB7Z5R9X7heg1uBhrKMsXCJQuKyz4nFKCkWJoYwSD0Zuu0M24oT
         RYdB7Jfxv1Yyoj+tRwNFTxTYQapvp3xKYnq0dEuvXfy/o926BBUqmI9b+qeijdPgQpum
         9Vug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784094519; x=1784699319;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IBsM76exL4SFDnnMhHO0BgMMr/BT5bOV9fjnRY4cauI=;
        b=D1n8kvQPXjHsqXzLCf5OY09mMTBDzsvS7lNjAHvQIgpTU44HbVpz02dA4CDKuexbYT
         jZUPBQ3JBhddY6zVmP9w8jyZw1g6Q4p2D9/xySioGew2TS2CWXvQw+FvX287pK/afevE
         4YQFzeFZOoWOxrznJ4457IuLT/OINrdpaPYCRgufY1mnT2eJ0+TWYNP/6aq0D5+KyVrU
         siVYRsGlRN4JjEd5KEaMOYQV3Nv+Vi/Ch/SAzusOD32k2nACO5k1yxcGBj5CuAaUEed/
         RsKoaAEQWHlXxkVV4X0/JZcM8s9RjljqN9yeKu4K08BmkG3IvS0WCw3YQGj5L8HEfqJS
         PP5g==
X-Gm-Message-State: AOJu0YzjuEAkys0VWh4diWeH/brF1xoFcGE8wUyIMhcakOdZRV/vQI55
	FjjzKycJnTY6frjdAGVNFMtYZALZs2/QZjWgeXhTeGIqrQhK8iizc3OCn+SEceLLvTk7TRRHLor
	umW9O0ahg1AqHq40znZK2/ZJXHy9961s=
X-Gm-Gg: AfdE7ckrrWrEKYQZobU48HV4t3YFbbyirMeSyuJ5sqyIwmqjEkrN9qWpMp9YMZKqZ3W
	fcD/JaeeU5zclrLLOx6oh3hD+ttiBJIEsiU4TCwVBVF6uRWz4uT1IJWFLGqpgVTirRhFc/1hfz7
	XdZVek+KEooMqrb6LLX0suUP8qf7+JJSHDAk8EjYRcpdB6a4Mw0dpY6ss8uoQV7qoCWo7RIfbSQ
	1LjHFTK4D9DSlkk9cY0kx4Z0ayIpa6oUS44gsuX1NAEU/mU8ufh1ypfI6i++wEhx/4Ko88Z
X-Received: by 2002:a05:690e:d53:b0:664:ae68:ca0d with SMTP id
 956f58d0204a3-668078642eemr3046911d50.83.1784094519486; Tue, 14 Jul 2026
 22:48:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260709230242.2003459-1-ameryhung@gmail.com> <20260709230242.2003459-5-ameryhung@gmail.com>
 <08cc4cf4992b72088e59cd9aafe2bfa78d87f738.camel@gmail.com>
In-Reply-To: <08cc4cf4992b72088e59cd9aafe2bfa78d87f738.camel@gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Tue, 14 Jul 2026 22:48:28 -0700
X-Gm-Features: AUfX_mxf1Jw9F_0V6LOVX5AT8YrHW_9QQHleU3SoNNQBcSvER7bFsvpSRa1Q3P4
Message-ID: <CAMB2axPFgzOgteigxT8OVZcFtxPryCPu5tnFixWOM3A674MAWA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 4/4] bpf: Unify helper and kfunc call argument meta
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org, 
	daniel@iogearbox.net, memxor@gmail.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 14, 2026 at 11:48=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
>
> On Thu, 2026-07-09 at 16:02 -0700, Amery Hung wrote:
> > Helper and kfunc argument checking carried two separate meta structs: t=
he
> > verifier-local struct bpf_call_arg_meta and bpf_kfunc_call_arg_meta.
> > Merge them into a single struct bpf_call_arg_meta. This is groundwork f=
or
> > sharing argument checking between helpers and kfuncs.
> >
> > While merging, drop the btf_id field from the helper meta since it is
> > never used.
> >
> > No functional change.
> >
> > Signed-off-by: Amery Hung <ameryhung@gmail.com>
> > ---
>
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
>
> >  include/linux/bpf_verifier.h | 40 +++++++++------
> >  kernel/bpf/cfg.c             |  2 +-
> >  kernel/bpf/verifier.c        | 95 +++++++++++++++---------------------
> >  3 files changed, 63 insertions(+), 74 deletions(-)
> >
> > diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.=
h
> > index 3ed788ec6afc..5fbc3dfe5b19 100644
> > --- a/include/linux/bpf_verifier.h
> > +++ b/include/linux/bpf_verifier.h
> > @@ -1479,18 +1479,24 @@ struct arg_alloc_mem_desc {
> >       bool found;
> >  };
> >
> > -struct bpf_kfunc_call_arg_meta {
> > -     /* In parameters */
> > +struct bpf_call_arg_meta {
> > +     /* Common */
> >       struct btf *btf;
> >       u32 func_id;
> > -     u32 kfunc_flags;
> > -     const struct btf_type *func_proto;
> > -     const char *func_name;
> > -     /* Out parameters */
> >       u8 release_regno;
> > -     bool r0_rdonly;
> >       u32 ret_btf_id;
> >       u32 subprogno;
> > +     struct bpf_map_desc map;
> > +     struct bpf_dynptr_desc dynptr;
> > +     struct ref_obj_desc ref_obj;
> > +     struct arg_raw_mem_desc arg_raw_mem;
> > +     struct arg_alloc_mem_desc arg_alloc_mem;
> > +
> > +     /* Only set by kfunc */
> > +     bool r0_rdonly;
> > +     u32 kfunc_flags;
> > +     const struct btf_type *func_proto;
> > +     const char *func_name;
> >       struct {
> >               u64 value;
> >               bool found;
> > @@ -1521,29 +1527,31 @@ struct bpf_kfunc_call_arg_meta {
> >               u8 spi;
> >               u8 frameno;
> >       } iter;
> > -     struct bpf_map_desc map;
> > -     struct bpf_dynptr_desc dynptr;
> > -     struct ref_obj_desc ref_obj;
> > -     struct arg_raw_mem_desc arg_raw_mem;
> > -     struct arg_alloc_mem_desc arg_alloc_mem;
> > +
> > +     /* Only set by helper */
> > +     bool pkt_access;
>
> It appears this one can be dropped altogether:
>
>     diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>     index 5ccb00a8c84c..b1d5a359c78b 100644
>     --- a/kernel/bpf/verifier.c
>     +++ b/kernel/bpf/verifier.c
>     @@ -4654,7 +4654,7 @@ static int check_map_access(struct bpf_verifier=
_env *env, struct bpf_reg_state *
>      }
>
>      static bool may_access_direct_pkt_data(struct bpf_verifier_env *env,
>     -                              const struct bpf_call_arg_meta *meta,
>     +                              const struct bpf_func_proto *fn,
>                                    enum bpf_access_type t)
>      {
>             enum bpf_prog_type prog_type =3D resolve_prog_type(env->prog)=
;
>     @@ -4678,8 +4678,8 @@ static bool may_access_direct_pkt_data(struct b=
pf_verifier_env *env,
>             case BPF_PROG_TYPE_LWT_XMIT:
>             case BPF_PROG_TYPE_SK_SKB:
>             case BPF_PROG_TYPE_SK_MSG:
>     -               if (meta)
>     -                       return meta->pkt_access;
>     +               if (fn)
>     +                       return fn->pkt_access;
>
>                     env->seen_direct_write =3D true;
>                     return true;
>     @@ -8307,7 +8307,7 @@ static int check_func_arg(struct bpf_verifier_e=
nv *env, u32 arg,
>             }
>
>             if (type_is_pkt_pointer(type) &&
>     -           !may_access_direct_pkt_data(env, meta, BPF_READ)) {
>     +           !may_access_direct_pkt_data(env, fn, BPF_READ)) {
>                     verbose(env, "helper access to the packet is not allo=
wed\n");
>                     return -EACCES;
>             }
>
> > +     u64 msize_max_value;
> > +     s64 const_map_key;
> > +     struct btf *ret_btf;
> > +     struct btf_field *kptr_field;
> >  };

Make sense. I will incorporate this in the respin.

>
> [...]
