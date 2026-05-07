Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31CD38656C
	for <bpf@vger.kernel.org>; Thu,  7 May 2026 12:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778157546; cv=pass; b=Jmmb7S++3/jHf5ioUUVXD1uVrFNg8+1JW79QDcdMbR5GKnLf4qFmZ7Y+qFP3ZaZdOf7/Y3DY1AS62chxnKk8+XO/gRGtYBxfYuLUEyO7cRPxFGLWiuDMpIpy4DUFqWhNTIioKZX9aBV/Aobj8i/LMSIlt/AI3ddHtt4Wq9KZf0o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778157546; c=relaxed/simple;
	bh=fV9SbuhPu+ZC2t3/nHhYdEpTV0whbwwDTfKjD88hpYk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DupCoUAzTTzhnTmGlxWzhGvXrZbd7Y1bRJGVVaGR7pltnvzClRmdDl/tOCWVtCaUgDBSNdL3l12Li1az5q9IMlSQ51HCxVD3HPpn1s+cKdSCpMMBYeL/AZB+mO4+4hpkvk7apZnfBXhOAf4DBUX6iaF52plbLXetTLPrZjPT2aQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GxsZSBGV; arc=pass smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GxsZSBGV"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-7bdaa68cf81so7087297b3.3
        for <bpf@vger.kernel.org>; Thu, 07 May 2026 05:39:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778157544; cv=none;
        d=google.com; s=arc-20240605;
        b=auxyE2GwCFxHzOcyRFVAetl7BRYiiOLQyUGS2qNDOAfGwzn+eeKL5dvdo08tt/2Ocf
         wgnn37pjCARM0fmJwVte+jAMHFJH3/fD2gSH7OhdSzRwRJLOBeXVEMPk56fFz3m55KKE
         KOXXZc7iZKokYB+xwLZsAjDazYUsHIc7P4kYcOUuWMbuw9R6Nxq9SQM3i7ZQr7nkBhRT
         9Ue6fPAbBY7I/7+cljxVrkF3t1xJLOzKayiN94M07LZ3+cJx9HJXF9qpFCwQZGOBcL7o
         FYPglCBhcHiYOAGz8aGjHdTQcKKvXjZ0+TyDdI+/2p9cU45ipqBu2BqAYFe8sLmo8ddu
         JMkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=24f92+2s3Bem/6CFNRp+DVqIBOUC5rSCjbALyAaR/O4=;
        fh=SS7tT0KC3jLZdfo/Ptau2hbovOS8lxj95BG5rgPZ6kI=;
        b=BX5ycowclYkuC4Kpqx5ACy4AU7otSNojaIRpI5ybjY9UFO1KocgyNOg3wbyBUf+e3H
         RQPDS+bBqUHoXf/PNOAUH1Qs+inu533taxJNsB3r+zNngoeCl2kAbJJcoerzmjxr4nvA
         Jvg3xlUUnyo9tn/alX1kdevDPTOrwToviXjgqJnPPaWY/+VE52lTpqL0Z3NahAbURtg/
         kpFLxNb8mvSUwUAtVnI+rKebTPhPvrEtSVl8Yp4MXGhMDLIrGLTRD3ZhF+RcVQ9agP9O
         zVxgtE/WPfFDNSlRFzu+9ud4EVsaGLHVLX39i3C/1ww/TF15+aQbapJAIVNRn8o9n5YP
         gCgw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778157544; x=1778762344; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=24f92+2s3Bem/6CFNRp+DVqIBOUC5rSCjbALyAaR/O4=;
        b=GxsZSBGVghZFXY0aonSpU3atIw/Vr1tH3M+/bzr1O08Op/M+5YRQkNinR2ZT5GaWKv
         hrn7zgDsHy9xdz9LsPkDBd1N8NFU+Kz9mGjlWgxm5GG/4M6mjLkZ0ogJFRopPmVNm6N8
         C+VuFoUJXVgvzbdv5FZ9xtEJte5tZMlkLruAtFiEjoMkt09Am3p7Mn+D2rS7yrD6QxI0
         YLXsDAZdYb7TxMqMzbBA469D5ZM+3ICrzccRcxLSLsaXKn6ZVWdh8p2puZBRP+/ZHy4u
         oWltswfeL1y5R1/p9+tHqK8nEgS8tVD3iqvJylACPst8sZl9TE8xRXiRnnoDKSie4mCy
         AuAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778157544; x=1778762344;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=24f92+2s3Bem/6CFNRp+DVqIBOUC5rSCjbALyAaR/O4=;
        b=oI4DhbVcWOYvR0mjzYD0hK6UmIOABV4j7wIemsA96MTKG79LhHLVDzF6Uvq17Wc/i5
         SJ1i/xfc5v5DL7rnQvAJiIgqLrX9RtpCVyl49sAxSXXYaZWPk0vSkzwd3++PDlNj9R+z
         ZAuGzrisEhwcPS0by/mi0GisFYM8kuzQOlJd1E9dWFXo/Dd6zNVIGFbxAAdHN7dATo+u
         s6LWIRI0LoyYFxOKLdIZrZRAGt5kJfjCOYqO0+EucFFfGO3xPtsmXC59PJ+8ozGLY+8Y
         Z9hwmsfmVG1vSYpUhdCFn0oJOlXfwEB7vPq845FHufrdo5gqq8yrPL2vQcqu6PrrCeSj
         UCyA==
X-Gm-Message-State: AOJu0Yywl8Rh6RQtoeZB7Gdj4+KJvkvih3JKguaKI+yH6iXgW5BXTz7g
	vw++foyfE7LQk8EnlSNFTArhlqXNLXLQaauYjtGwtxzm6/5Doee1889rgix+II48LYWBP/jobyx
	iWOu87vFjVnOhIrNU1qMhDB6q2uTugks=
X-Gm-Gg: Acq92OETn17SXWOEMRtsJGVYXTuAJAXcWhtIrdnyMOpCbbc3T09CY3p1u/id9MgPEAh
	B9SNbjOQgub2satomQi59Z2mtvh8ASyMP8oCrhec0Ket0TzdC3hkK3yAzzQ1XRGaNozeEh5WlKh
	gDRqkMfW/xawUu7AQQGrdofiq1mXkvD1eVCUCZDV660KIWLkAfPdKLnxslKGgYrhl2OXuCuQNh0
	Zfu9UFhAqzOWyI2VNBz0I/eFnlBBXQnyehyDrNnYoh2+GBitdFnXuOQqopIcMI4iK1rpXe8ydVO
	OHTcz9JJIeS7xdR98ZoFKS6HSGebZA==
X-Received: by 2002:a05:690c:dd5:b0:7bd:4a12:f08c with SMTP id
 00721157ae682-7bdf5eeea18mr85704497b3.39.1778157543721; Thu, 07 May 2026
 05:39:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260506142709.2298255-4-ameryhung@gmail.com> <c50e87ba73094da8cf153aa71d110868fe0e0e27bea866e294af7647712c9a6a@mail.kernel.org>
In-Reply-To: <c50e87ba73094da8cf153aa71d110868fe0e0e27bea866e294af7647712c9a6a@mail.kernel.org>
From: Amery Hung <ameryhung@gmail.com>
Date: Thu, 7 May 2026 14:38:52 +0200
X-Gm-Features: AVHnY4L8BTSGTMkaQ_vSAxNoM8ylP56QTtO1zr33GYSdvSMLCwJhuls_W3Ifc34
Message-ID: <CAMB2axM=8U08vR0HE3yi341G8K_6CjL7QiVh1VUe2UUi7yL54A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 03/12] bpf: Assign reg->id when getting
 referenced kptr from ctx
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, memxor@gmail.com, 
	martin.lau@kernel.org, mykyta.yatsenko5@gmail.com, kernel-team@meta.com, 
	ast@kernel.org, yonghong.song@linux.dev, clm@meta.com, 
	ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 6, 2026 at 4:27=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -6057,8 +6057,6 @@ struct bpf_insn_access_aux info =3D {
> >                       } else {
> >                               mark_reg_known_zero(env, regs,
> >                                                   value_regno);
> > -                             if (type_may_be_null(info.reg_type))
> > -                                     regs[value_regno].id =3D ++env->i=
d_gen;
> >                               /* A load of ctx field could have differe=
nt
> >                                * actual load size with the one encoded =
in the
> >                                * insn. When the dst is PTR, it is for s=
ure not
> > @@ -6068,8 +6066,11 @@ struct bpf_insn_access_aux info =3D {
> >                               if (base_type(info.reg_type) =3D=3D PTR_T=
O_BTF_ID) {
> >                                       regs[value_regno].btf =3D info.bt=
f;
> >                                       regs[value_regno].btf_id =3D info=
.btf_id;
> > +                                     regs[value_regno].id =3D info.ref=
_obj_id;
>                                         ^^^^
>
> Does this introduce a bug when reading the same nullable context field
> multiple times?
>
> The new code sets reg->id =3D info.ref_obj_id, where ref_obj_id comes fro=
m
> ctx_arg_info->ref_obj_id. The ctx_arg_info structure is initialized once
> during program type setup in check_attach_btf_id(), making ref_obj_id a
> static value per context field, not per read.
>
> When a BPF program reads the same nullable context field into different
> registers, they would share the same ID:
>
>     r1 =3D ctx->nullable_kptr;  // r1->id =3D ref_obj_id =3D 5
>     r2 =3D ctx->nullable_kptr;  // r2->id =3D ref_obj_id =3D 5 (SAME!)
>     if (r1 !=3D NULL) {
>         // mark_ptr_or_null_regs(id=3D5) marks ALL registers with id=3D=
=3D5
>         // Both r1 AND r2 are now considered safe
>         use(r2);  // BUG: r2 was never checked but verifier allows use
>     }
>
> The mark_ptr_or_null_reg() function uses reg->id to identify which
> registers should be updated together after a NULL check. With shared IDs,
> independent reads are incorrectly treated as aliases.

I don't think this is a bug. They are indeed aliases. The referenced
kptr acquired from struct_ops argument, if valid, should always have
the same ref_obj_id (also id) because they point to the same kernel
object

>
> The old code generated a unique ID via ++env->id_gen for each nullable
> read, ensuring proper NULL-check tracking.
>
> >                                       regs[value_regno].ref_obj_id =3D =
info.ref_obj_id;
> >                               }
> > +                             if (type_may_be_null(info.reg_type) && !r=
egs[value_regno].id)
> > +                                     regs[value_regno].id =3D ++env->i=
d_gen;
>
> Would this fallback path prevent fresh ID generation when id was already
> set to ref_obj_id? The condition '!regs[value_regno].id' is now false for
> nullable PTR_TO_BTF_ID pointers, so each read gets the same static ID
> instead of a unique one.

Yes. It is intentional. This mirror referenced object obtained through
KF_ACQUIRE kfunc, where id =3D=3D ref_obj.

>
> Eduard Zingerman's review comment from v3 suggested that the commit messa=
ge
> should mention that this patch is mandatory for proper invalidation
> propagation in later patches. He noted that without the line
> 'regs[value_regno].id =3D info.ref_obj_id;', the test
> 'bpf_qdisc_fail__invalid_dynptr_cross_frame.c:invalid_dynptr_cross_frame'
> fails because the .id link is needed to propagate invalidation triggered =
by
> 'free_skb(skb);' to 'hdr'. The current commit message mentions consistenc=
y
> and parent_id tracking but does not explicitly mention the invalidation
> propagation aspect.
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/254424=
56702
