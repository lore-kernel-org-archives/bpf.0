Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48BB62DB7BA
	for <bpf@vger.kernel.org>; Fri, 24 Apr 2026 05:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777008899; cv=pass; b=U655VnzDD4SWUB44NQm44STvAp3PWFq/bBrpO5KPFVzHwm6Gd56T+lCS0q0GT1pxnDI6tki/0KZKuPV5nbBzJgRfe7xDbl3n0kS/9oVPe4pSPst7vwrGK5Z6xCunHdSCQ9r7AtIaaRq/VDzKGH1ogg/NbGXrzErwUEMzYJ5Cfbw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777008899; c=relaxed/simple;
	bh=nJMfrq4tRFpvzrW37H2S2vo5RQzb38ojM1/0Nck60UQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MSEhpKsKMHB/gwMNHSwbN7ozbmaSGos7AO5kVvLKPZq/w2375fglmS6stkJbeYF+DTUq33beNEw73OBc4+Y8IoPp5JSHGi4slogjY5D0a2C17Nzn5OZxYmVGzGgHHHseXoGlgOGTZdHEvFchoirDvRVoi9KjthUaM9So/pZPmLs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MuOlUEPP; arc=pass smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MuOlUEPP"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-7991db3dc98so82732317b3.0
        for <bpf@vger.kernel.org>; Thu, 23 Apr 2026 22:34:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777008897; cv=none;
        d=google.com; s=arc-20240605;
        b=dKqaxZPOTJpNTIR6644HNrd7dnBxbhzSH5uasn3cjxGy16oYH3P6LbPbK5VqLGsdDb
         38MJ992zOglSvL/cVfLkqYaYtMpRyQO8LxlVv0tyeLt0iWQ9uFaH3J6klUiaRe+oirhS
         AX4YU9W34qFIcOzH1YE/Y0FraaX4XDtzPJmhJQM5Y8eUK2PJ4/yyN3v8vTXrQeKnmUWJ
         OhvFyfSMnfJ4nr9JUnKr6ORCUPwFP5XIwDqfydaTnVFnDOzW7nrEj+aCMpJGXHotIVSd
         xa0yX+LLzFrmIGocq9ERnYtkFMy8MEOA8m+A/RZkZW/Gj4W2GEwnqBfdtj1qS3XuS0Gv
         jDzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8Mco96ugiiVLyRZYUFRtNHTAzHRl/YzNAOoenKfciLs=;
        fh=QgK3Obne9eUJc0PZSYgsPqJHYiKApKQZTo9VOIot4kU=;
        b=KDLGw5wB/fsFck0OerehJ0ZeMb7NgP1tdIQt4dYV/kdFgPdxIbSD6ErorIVHSqKCPx
         bErfLlOtkdeSFBNaST7zsh6JSej3VxwrXUWndieg366JZtpYUXqn57Wg/x2xcWF33Rvz
         ZIFxqyvVql3rCXBF3lMScKhW1fexr5Shd7AA0ZTf+fC/mS9DGx9nzkVhytBVM7ed6tcf
         SOHy54brv71L5QwOVDElZZLELsCuVHvBERZwgaq0rISbMc3JfC1NZcBufJW8MNs+BcQU
         MY311PYFuTfu1HEKLsfGdbagIgp62eD3lmGJIOkJ1uzjTEHJW6QQWt6G5gjo1+gjURBT
         s1hA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777008897; x=1777613697; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Mco96ugiiVLyRZYUFRtNHTAzHRl/YzNAOoenKfciLs=;
        b=MuOlUEPPa8OBQ985mfstEuLGKdIhww073pDFlYJrwYQLpgs+vlfgHsAl8rXw1IMTfZ
         eIzbe6WNZjYYAKhSR7PFMesln0DPD0cY/bk69pc4Xx4GZBWRuLn522mJPVHHQgvlxPQL
         2DEB//oxlUsOePHixZvgzOD8kAddq8yqf3/Hy7jdeWEp02nnlSw2AjBlW/NLJGof+HgP
         tjeOyY8XZTrUL+rcehQldRRAw0fEXcMZ7ZTc/O9yrHSkEUYRIM+tPX4kIpnuFgHA5+dq
         pdsGlnlgnZb+nWq+NtiJ36Ly6nXQ4TeXWNRZQUJLf1ww7LML3MhPW88fU6vm6G+yb/aR
         s35g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777008897; x=1777613697;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8Mco96ugiiVLyRZYUFRtNHTAzHRl/YzNAOoenKfciLs=;
        b=dpbjMZ0Dldgq91UFUk/gV3MdDpgf/hCLX1XIB6Qg6jamSEgbiDcl4ascmnwhTpXGrk
         AMLzCYNp2Nxkfc18hlQX5Fj1UwTbLQ2NZ9xbVTlDS/aLLp06pUE0ZZbKg34v0jcfTMqv
         IWxQdm/u9K9twuf0y+iQM0nyUsjdFM9mX2IAF/6GH8wg/5tV63OYp+7smwrcAPa2v7Rl
         QTdqgOHXjbiP5N8i4sBeNBztGoei6JSXk+yTo0mmBLR3vzwO5QTppjfj/44VSnOp+aj/
         VgYMfcfBO4P+KVTz3z3xnH+z7gQx0qyk1i69NvsA1IL3RqjMonZkze8ae7onClgYOlSG
         gutA==
X-Gm-Message-State: AOJu0Ywq30xhvCsCitzuz3uApTjhrm1ccTpqBmfMu1buigESlB/Ie08C
	9nSSA8N01il9h76mmTHrkdSsYyPLfcKJt9Esa5+tQprtXN10pcUm01PFgFv4EZPjL6tTHxEd90q
	nmVdU05jKwPgxv44OlDZpXM+/SXlcuQXNJw37
X-Gm-Gg: AeBDietoTVyUECIOxPYK5jAM4dyDBQ5sAzSFIhKNbQkrcFoqaTtJE0/otUCyNsDxK3g
	N3zdFvyetsQdG7jfi9Z0Ze16iXeit3dZyxGFGvSO0yu5V9D1YjtQDo4eJNvw7Mn/WJevCzFmqKq
	a7X2ynIasOKZDyNnZP/Qo2Og9N0iTbg7AGUaezr6GVY+6jS9kr5W1fpVQRyLgTsf2tgTfG5Ltst
	IVqaoUnK4AuyCn8C07VvwCaZRjgt0s4piIdGqWLxXak7QgyChWBgm4RtBFM65j3JkwaHz/wVSVY
	8Sy/4IA6tQX3pA1HGZE/EnMuK5GR
X-Received: by 2002:a05:690c:941c:b0:79f:d961:47bf with SMTP id
 00721157ae682-7b9eceb5c27mr256699517b3.8.1777008897374; Thu, 23 Apr 2026
 22:34:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260421221016.2967924-1-ameryhung@gmail.com> <20260421221016.2967924-2-ameryhung@gmail.com>
 <CAEf4BzZGg1EKwYFG6QKrkNbiE6RwWKew_Zz8mz9rjshKjWzcKA@mail.gmail.com>
In-Reply-To: <CAEf4BzZGg1EKwYFG6QKrkNbiE6RwWKew_Zz8mz9rjshKjWzcKA@mail.gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Thu, 23 Apr 2026 22:34:46 -0700
X-Gm-Features: AQROBzAECWMJ15GcfaCGgs5nF8PZG0BrwMnhTANNSqKOcTnjKUnZMafn0Ia7ElQ
Message-ID: <CAMB2axMw7mOs8kTFZG8Z1wn8fX4D0Si3Ge4F58DXKkBBQwrjyw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/9] bpf: Unify dynptr handling in the verifier
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, memxor@gmail.com, 
	martin.lau@kernel.org, mykyta.yatsenko5@gmail.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 23, 2026 at 5:04=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, Apr 21, 2026 at 3:10=E2=80=AFPM Amery Hung <ameryhung@gmail.com> =
wrote:
> >
> > Simplify dynptr checking for helper and kfunc by unifying it. Remember
> > the initialized dynptr (i.e.,g !(arg_type |=3D MEM_UNINIT)) pass to a
> > dynptr kfunc during process_dynptr_func() so that we can easily
> > retrieve the information for verification later. By saving it in
> > meta->dynptr, there is no need to call dynptr helpers such as
> > dynptr_id(), dynptr_ref_obj_id() and dynptr_type() in check_func_arg().
> >
> > Remove and open code the helpers in process_dynptr_func() when
> > saving id, ref_obj_id, and type. It is okay to drop spi < 0 check as
> > is_dynptr_reg_valid_init() has made sure the dynptr is valid.
> >
> > Besides, since dynptr ref_obj_id information is now pass around in
> > meta->bpf_dynptr_desc, drop the check in helper_multiple_ref_obj_use.
> >
> > Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> > Signed-off-by: Amery Hung <ameryhung@gmail.com>
> > ---
> >  include/linux/bpf_verifier.h |  12 ++-
> >  kernel/bpf/verifier.c        | 178 +++++++----------------------------
> >  2 files changed, 41 insertions(+), 149 deletions(-)
> >
>
> [...]
>
> > @@ -7433,7 +7426,8 @@ static int process_kptr_func(struct bpf_verifier_=
env *env, int regno,
> >   * and checked dynamically during runtime.
> >   */
> >  static int process_dynptr_func(struct bpf_verifier_env *env, int regno=
, int insn_idx,
> > -                              enum bpf_arg_type arg_type, int clone_re=
f_obj_id)
> > +                              enum bpf_arg_type arg_type, int clone_re=
f_obj_id,
> > +                              struct bpf_dynptr_desc *dynptr)
> >  {
> >         struct bpf_reg_state *reg =3D reg_state(env, regno);
> >         int err;
> > @@ -7499,6 +7493,20 @@ static int process_dynptr_func(struct bpf_verifi=
er_env *env, int regno, int insn
> >                 }
> >
> >                 err =3D mark_dynptr_read(env, reg);
>
> if mark_dynptr_read() fails, should we exit instead of proceeding to
> fill out dynptr info?.. even if mark_dynptr_read() cannot fail because
> of is_dynptr_reg_valid_init(), it still looks wrong and error-prone

I think I will change mark_dynptr_read() to receive spi from the
caller and make the function return void (It is technically nofail
after liveness tracking code is removed). Then, move dynptr_get_spi()
before it and don't error out. A comment seems to be enough.

/* Cannot fail as we already make sure reg is valid dynptr */
spi =3D dynptr_get_spi(env, reg);

mark_dynptr_read(env, reg, spi);

>
> > +
> > +               if (dynptr) {
> > +                       struct bpf_func_state *state =3D bpf_func(env, =
reg);
> > +                       int spi;
> > +
> > +                       if (reg->type !=3D CONST_PTR_TO_DYNPTR) {
> > +                               spi =3D dynptr_get_spi(env, reg);

^ move this up

> > +                               reg =3D &state->stack[spi].spilled_ptr;
> > +                       }
> > +
> > +                       dynptr->id =3D reg->id;
> > +                       dynptr->type =3D reg->dynptr.type;
> > +                       dynptr->ref_obj_id =3D reg->ref_obj_id;
> > +               }
> >         }
> >         return err;
> >  }
>
> [...]
