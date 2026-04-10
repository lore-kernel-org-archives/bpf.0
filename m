Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FDB4CA4E
	for <bpf@vger.kernel.org>; Fri, 10 Apr 2026 22:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775859447; cv=pass; b=tHc3tcFN/+P4YnsQl1TaMFbt648cjAF4MZcrFvnDHGbExITYgegJAHfjUsitvVBsi8yFCkug+DUuBQX7YSYc07jqkFgmRiCHUEPCOtpzzhcCl9sfhpkIHclO2996dwbPW4n+dN29P0Q2Qx2LcGxwqSqZiCg0hqStW5GxGPj1cQg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775859447; c=relaxed/simple;
	bh=iAxbFpE6uMuN7Q8CwJklgUS+dnoclVhOdNxu8EY2coY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VsRop4Q97c8+BdEMMCk+5Oe8qXBEIOrmdJ+7gxoMKHAOJZjZpPy8i2HiqOcdXAbk+6wI0sNi0jE4twyGkIZWdnZfDiAN6y7KbH1fr+EZvg5OdRKGoOkHaT+i9T8OWs7cGXcoL/N8hSsUCn4nR/PGIMNKVpPFwBdMZVZhzrZzoqs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mqKZ8XyS; arc=pass smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mqKZ8XyS"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-43cfd1f9fd1so1628985f8f.3
        for <bpf@vger.kernel.org>; Fri, 10 Apr 2026 15:17:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775859444; cv=none;
        d=google.com; s=arc-20240605;
        b=QTzXdEGC7X3nA8QoWkDkUErKa2fPYkRfp277w3JJKabHFd9SSg6IdsITG4B7bPkScM
         lMN4Xy8l39lmpzR/KrezykV7pxH4bPsmsOOrscZNUYoRsS3dE9K1ZPzxuB7CQXKprMVX
         pcJTB549uSZkROCqnhbvzWx/UMZenNClhcV4R0cidJXJ2y7QAcCrHw4y6YfmqF7DUaKS
         Q6vRMxcaRckJul2PdfGdiMHref6rd8kfq+8Oh5uxYtWfYnekYqoTyYFGR8K//f/f0Fk/
         nzB7zO4hn6PqciUM6uQTH4PS50YHoOlJCejOLKOIZwVcLDq9+mwPfJH7Lh/nOus1zF06
         iyaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=l3VlCZ49NGzgELP/4teMbIpUVVVo3RXvXgqaAWAOCww=;
        fh=+zlp1AP1WGgvatVYjuyMnrRfEgh6MP/Ji2xF7L8HR4E=;
        b=HNjw6yIubxkKdYAGWOOqJdbWTF2Po72EUZoxro+TpNBlGkxQPNsyOsLz1Fw6g3sqbb
         ZcX2zHW6RmKQKlwnjFe4n7eNm0czGfbOKxAaBGJ9AG+AILNxqZeNUjFegrELhg9i9u+Z
         A2HhxQby22ZB5gr4VfXo9uVKg3HCLEgLYE0PPtFvv/jdf0nKgOBRysDRpjlaZURjHJ7j
         lTUijMLyi3Vt2ekOMiOyeVLifJ9NNqu+0HGcOKg609EXmH8GUqV2GCt8SFzi5Gvbl9SA
         pjR8SxYF5DzjlPtalX3Mo31RmDrmo8YVc/qaDqCmRiIxnPmg4CjBaqnq9OD5Z0o6UFPp
         ysZg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775859444; x=1776464244; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l3VlCZ49NGzgELP/4teMbIpUVVVo3RXvXgqaAWAOCww=;
        b=mqKZ8XySWdWGGZB+OKFwMdFajFkmecWOm03hUE+9m1Il/2EWE8wxJgoVDO9TfL8+Ga
         DJGP7rCEnCrST0Oa3oDCMzq0P5wDHbQRUd0lHmTN7jEBxaJzQMCj85Xs2DyBcndgBagr
         Scx46euTGAV4MdlbZpuqccdOHTAV3C/oZFRO5kltLz0PUaNL6mGsi0lr7mFapYMraxpm
         SV5i6K5zSa4Mtx42JlzMeGyB4Dwyjs+5NfrAOtKcOvLIocyGxJsZemB1JBeaY3qX597x
         xBucOi5I308t+fiW+Z3QV8SFc1Wjuz6mNPY2pyKOs7f1LQcNUPAr1h5kVG2SPxLlgfXE
         lHXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775859444; x=1776464244;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=l3VlCZ49NGzgELP/4teMbIpUVVVo3RXvXgqaAWAOCww=;
        b=ELgi6b6CkAqF4a1mGVRzgclPhMuRObuQp2AsZJOL9bOu4HYRV5Fb+zTnQrUENrDhYR
         tg06ATEMS8e484OAJQkj0mSzjCEf8w/nPUgHwXE/o2ZfbvzxIp4VCUcedqTOetiFnF/6
         u9ENsunpwJu9+kC060TmDU0zkwltVxcYVwCmPD/Td5oFBvkQ3wLAY7VCYHoyF3X2YSET
         tAlcdMsqY+4/WG5OZUaJEt/upMV/67Yd38cdlBBU0ptUsEmpbpn0r2m+Tk4tVVwPGxl8
         +UaYfeIPiUA1qxqMXJWmHULzZEL+vfDlKitTBxs1Zlrv/mdx7DtZK/q3EJ8TqCKjU6fu
         qbxg==
X-Forwarded-Encrypted: i=1; AJvYcCVAgqMrikq/q9+X8Lu5CzpUiH+i4b2ObF13fV6FKBgrrkS4YVLyEqTbBTxP8QKqSzH5juk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxRnxmyO3W1KTW8Bgm5A/arfzcU/tsF9w0GuZcVwUXkZ3J4nwo
	mJO9E7JPKHkZ0OIFZ55adEoYpXAXX2VU9juAbwI0LFNazxz85uvEMgMQJTd/+DYMXHq993meVTY
	4B1OYF/5ZACM3ZBxGwzrFGriPx55KpEk=
X-Gm-Gg: AeBDietywjbOOe9OjkJ2jvo2XNi16ctWZQzCSCuIE5OeR+ief/7pHomJ+/NJ9Qu6xlv
	javZKq5nHQD4xrZE+Zcu7IFI+JBSXjSiPhIJHMUGUWCijI4KqdxGx6pYX38zdNIl2l86Na3yrbI
	URCRcMyDB3jwBDFdnITU2CPuuaQQ+RGRddCFDJjNaANIm5CcNsh4HNRmhQq4eZGbhGsJtOGR4nS
	ecakmvqYF7oAzey937kgIAS5EXSeHDtwj/CfFgNA1UKQJj2NZAdpr3cShnL++7D6nHys1MMJ/si
	vmPNBiI3lTYBZC99eR3XkAMLxasYJ+OJYtADOwDaeNzaSaisLOA4NbwFAjEtYVmWJ4aKdXydMkF
	Fn5dYlyrxT4xeXA4jgDXs68xxrueuxxdNimkf
X-Received: by 2002:a05:6000:40c8:b0:43d:14cb:8470 with SMTP id
 ffacd0b85a97d-43d642dcb89mr7052115f8f.46.1775859443737; Fri, 10 Apr 2026
 15:17:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260410-patch-set-v4-7-5d4eecb343db@gmail.com>
 <fb5b061479a00ba43992f755435e158bb913fb80e5ce106d20c81c42f6bb4356@mail.kernel.org>
 <71cc59df90881090e7e74ca0cab7cb8b64e27979.camel@gmail.com>
In-Reply-To: <71cc59df90881090e7e74ca0cab7cb8b64e27979.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 10 Apr 2026 15:17:11 -0700
X-Gm-Features: AQROBzC4MUhC8neeHGJENEW7gjH26PEykmeDOUzR_ROywz40UDNfbeH2VbbBEz0
Message-ID: <CAADnVQJ6tsh-EsFDxY6USRfSWD5Su4vVEwj167iBX3BE=JjV0A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 07/14] bpf: introduce forward arg-tracking
 dataflow analysis
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bot+bpf-ci@kernel.org, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Kernel Team <kernel-team@fb.com>, Yonghong Song <yonghong.song@linux.dev>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Chris Mason <clm@meta.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 10, 2026 at 2:46=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Fri, 2026-04-10 at 21:44 +0000, bot+bpf-ci@kernel.org wrote:
> > > diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifie=
r.h
> > > index 7b31d8024c61..49b19118c326 100644
> > > --- a/include/linux/bpf_verifier.h
> > > +++ b/include/linux/bpf_verifier.h
> >
> > [ ... ]
> >
> > > @@ -886,6 +887,8 @@ struct bpf_verifier_env {
> > >     } cfg;
> > >     struct backtrack_state bt;
> > >     struct bpf_jmp_history_entry *cur_hist_ent;
> > > +   /* Per-callsite copy of parent's converged at_stack_in for cross-=
frame fills. */
> > > +   struct arg_track **callsite_at_stack;
> > >     u32 pass_cnt; /* number of times do_check() was called */
> >
> > [ ... ]
> >
> > > diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
> > > index a3af5972520f..c5d6760454d6 100644
> > > --- a/kernel/bpf/liveness.c
> > > +++ b/kernel/bpf/liveness.c
> >
> > [ ... ]
> >
> > > +static struct arg_track fill_from_stack(struct bpf_insn *insn,
> > > +                                   struct arg_track *at_out, int reg=
,
> > > +                                   struct arg_track *at_stack_out,
> > > +                                   int depth)
> > > +{
> >
> > [ ... ]
> >
> > > +   cnt =3D at_out[reg].off_cnt;
> > > +   if (cnt =3D=3D 0)
> > > +           return imp;
> > > +
> > > +   for (i =3D 0; i < cnt; i++) {
> > > +           s16 fp_off =3D arg_add(at_out[reg].off[i], insn->off);
> > > +           int slot =3D fp_off_to_slot(fp_off);
> > > +
> > > +           if (slot < 0)
> > > +                   return imp;
> > > +           result =3D __arg_track_join(result, at_stack_out[slot]);
> > > +   }
> > > +   return result;
> > > +}
> >
> > [ ... ]
> >
> > > +   } else if (class =3D=3D BPF_LDX) {
> > > +           u32 sz =3D bpf_size_to_bytes(BPF_SIZE(insn->code));
> > > +           bool src_is_local_fp =3D insn->src_reg =3D=3D BPF_REG_FP =
|| src->frame =3D=3D depth ||
> > > +                                  (src->frame =3D=3D ARG_IMPRECISE &=
& (src->mask & BIT(depth)));
> > > +
> >
> > [ ... ]
> >
> > > +           } else if (src->frame >=3D 0 && src->frame < depth &&
> > > +                      BPF_MODE(insn->code) =3D=3D BPF_MEM && sz =3D=
=3D 8) {
> > > +                   struct arg_track *parent_stack =3D
> > > +                           env->callsite_at_stack[callsites[src->fra=
me]];
> > > +
> > > +                   *dst =3D fill_from_stack(insn, at_out, insn->src_=
reg,
> > > +                                          parent_stack, src->frame);
> >
> > Can parent_stack be NULL here? bpf_compute_subprog_arg_access()
> > allocates callsite_at_stack with kvzalloc_objs (zero-filled), but
> > nothing in this commit ever writes to individual callsite_at_stack[]
> > entries. They all remain NULL.
> >
> > When a callee receives a parent-frame FP-derived pointer (e.g. r1 with
> > frame=3D0 at depth 1) and does an 8-byte load from it, this path is
> > taken. fill_from_stack() then dereferences the NULL at_stack_out:
> >
> >   fill_from_stack()
> >     cnt =3D at_out[reg].off_cnt;   /* > 0 for precise args */
> >     ...
> >     result =3D __arg_track_join(result, at_stack_out[slot]);
> >                                       ^^^^^^^^^^^^^^^^
> >                                       NULL dereference
> >
> > This appears to be a bisection hazard. The next commit in the series,
> > 0458daba63a9 ("bpf: record arg tracking results in bpf_liveness
> > masks"), adds the code that populates these entries:
> >
> >   if (bpf_pseudo_call(insn) || bpf_calls_callback(env, idx)) {
> >       env->callsite_at_stack[idx] =3D kvmalloc_objs(...);
> >       memcpy(env->callsite_at_stack[idx], at_stack_in[i], ...);
> >   }
> >
> > Would it make sense to either defer wiring up the
> > bpf_compute_subprog_arg_access() call into compute_live_registers()
> > until the next patch, or move the callsite_at_stack population into
> > this commit?
>
> Yeap, should be moved.

No point. The whole thing is not really bisectable.
