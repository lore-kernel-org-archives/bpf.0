Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5472932B121
	for <bpf@vger.kernel.org>; Thu,  9 Jul 2026 23:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783640701; cv=pass; b=KAaBcFywPVBz0oyUK1rjDjeP3cF7qfSpODa0oiM90xe2qpTbUUax0/zPmPBqdj7qzxaVMBEzisDigYEjT00TBwEaMM3DC3oK7idm8CQHqE3NZlDcvllwMOXITlMmcibdMYI+IG2tiDpBNwhZ7456MsjIptALaOvxng2vRUFEDVI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783640701; c=relaxed/simple;
	bh=mycG0WIjcqFxC1i9zKchmdz6yos5TZRSwXdFbFARR5g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SiV+iQz6elVBn1AOsTaGi1eRbWOLSTWxQ5iDAxwO/wZRUL81QLzNzgtnbGI3IAzfejlFeXRLRCabQjzirOVD3JYRWi33UgZkJWO8tcUM9pYJjXL8RKa8hX5cYbTdphT3T3mG7NHnRXhRopu3dQCNpxUWLqXhu+9HJzVKbYn97Ug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r/NgVSiy; arc=pass smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r/NgVSiy"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-6651bc5730dso491392d50.2
        for <bpf@vger.kernel.org>; Thu, 09 Jul 2026 16:44:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783640697; cv=none;
        d=google.com; s=arc-20260327;
        b=f/Vy0rY6CLITBN/QZ5wXDvIt+kC2DjZ9DQWdSmdO7hXwkpf+wuEU947WXfwgZGjGPn
         mjcB+w5YKbY+G1bWVHyNkpUcifIQrA1tdqbPycKet9j15Yt0SHw8NC57HdOxGgK/HJdJ
         qkOELz06W8evBklbcurWV1jmzvliZi3rb7PVE/6geFWCgoqIa0ltKcVat4KGrRzLlV4K
         g+BjRRprPfgAPwA5QDZs5WqnZyY8nZMLFr4ijXP6PMuUGabp5LVJOTRJJiuY8MPDhHxJ
         /x+RSYka6+kdsfOLnil0x3yLdPd72YPnutO1EGHNKaivWi+gavtOn/IUDcpw/rdamTev
         cEHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OWohNBeQfOn/m+hJlzsn4NULDmDrEFw0IGuA43Bi8hc=;
        fh=uA360uvxR9S0K/Y4Lovo7aIaGlBwzVBnnb2BKWupr/4=;
        b=BHJ1WXjlUr6ALasLOasQwQof4ZvAN4zhpNyovkgf5Gk6Z0/CEm6onCQzhIkpWP18gN
         88ZrpsyYDk/BTkAgrRK2UKeN+ONaPuciSYpauXx/ib2P5x6wS5HUzV+jF9crV/6lqz9y
         e6woGyVSkHlamB/mdJsqUZu+oQZ/x4ppXzS0KQi0t4ZScZZFxiveRL658R9uIb/fwED/
         aMflxuj9eJ2zH8BFzNlbAWV35l+qSCeMALXyP4C0cYVGgp1TZqPO06o2JliLlf55TyWa
         ce/WkLXMBJRe8hayMxVYWcayOfwDMx8G2IJANwDw/IfD8FBV2kaPFs7AFGCJQ9InJvXK
         ggkA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783640697; x=1784245497; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OWohNBeQfOn/m+hJlzsn4NULDmDrEFw0IGuA43Bi8hc=;
        b=r/NgVSiyZaFjWcsl/lxZdJeiFhRpC36TmyJNue+n+4lcYwQCpzVaecXlL0YOeBJdqT
         UwJuDoStik3nKQ/3ZSHDH5I+Mqq5TsIAh76jjPMltxoMggZV6rz4pGlOI27hcAjkALLo
         63f45VAakT/rLpVCyS8V3dO6sEHpJN33vASmK1D7MgQzxpubj+3GEtm0ctJ6lkqNsyA4
         ZHPg1NaKXGgzNm2fq9IdzCE4Fb2JH83lXlMFS2rY6iJSYh6ZbQstehWrx6Z8g5SuYcRH
         MfpVJX6uAvfCeBBn6UJi5q+p9kck714Hx/8HsKscXo60q3fw3h3zC3qUeLMQhgZcKWjJ
         o3sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783640697; x=1784245497;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OWohNBeQfOn/m+hJlzsn4NULDmDrEFw0IGuA43Bi8hc=;
        b=pbk5ZUJJzML0dk3YzZJAP/0dDEU7IxrGsbTai/1/Rf3rDVAUuVO6XkvgKTJhR+zP+1
         3hPMKR/QM/Dz+rxrOJJerOjI0VoLD8av+BVbt5PHnBrEtgOhiQ9LaSOE+D3crR3Ru6nE
         EiMapKlyRlT73JMciS5uWbbooMRtUtnnEBvsSScAWdSFQdNLtp4JWya1/HxnDlmDXfXe
         yNRq3L3Iqm+sChJni7h8yCHAw2K4lQE3CDYN1SlWvfe2KiLf75+Eas7FBNWqBZMdo4Mx
         rtMGy6FGT2OsuexziV0RZhtx2MF3haGimnfwdXXSB6hDiHGKA8EZ9sQ46EXgRUvSBr3Y
         DPVA==
X-Gm-Message-State: AOJu0YwNj9E9id6odVlCW0M+YTEIvUEzI8xHTOXBms5zmzT65KQ4tio1
	uFK+wn80nwRcJ86X3YOSXlC9EwuEvjYgiCKe2Tk/1aBKx9KXpUmRAMZsQIIvz4OJnahUXhtTT1h
	mKdEWryvSYD+EeGNM8a1jeDCL4okYn14=
X-Gm-Gg: AfdE7cm8TgOKf/3O4jAtxdPLcjW4m+ccd/ci3Ykz2j9dMgpmdDyc0RypPTTpF8lM/vg
	3C200zdtYjH5vbUJ1g6JtQVTJzxf2Fe8IMkte//6M/GzkLJMIJBHmPaXEq/aFBIZhsWo7Qp5tzd
	thtNhgfQWp2BCzsqJnpZs7CxSfZaLrppAEWWXQNQ3GZEdbAQUFDJ0cBih+vtOhlyTWc74ojztro
	QNdpUuJwzl3bZBVggTaNgL/73R72HwppA7o+xP4m5XjiwXKFtTuEMp7tsYeBgGZdF7rHnlK3map
	sJeGZ9I=
X-Received: by 2002:a05:690e:190e:b0:667:ba34:51a2 with SMTP id
 956f58d0204a3-667ba345c2cmr2765001d50.101.1783640697335; Thu, 09 Jul 2026
 16:44:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260709230242.2003459-1-ameryhung@gmail.com> <20260709230242.2003459-5-ameryhung@gmail.com>
 <20260709231615.0519D1F000E9@smtp.kernel.org>
In-Reply-To: <20260709231615.0519D1F000E9@smtp.kernel.org>
From: Amery Hung <ameryhung@gmail.com>
Date: Thu, 9 Jul 2026 16:44:46 -0700
X-Gm-Features: AUfX_mzYJXMOtOOJaJMklifYptVOVdovtn8Z00cd9H3jAzrszap3HC_txOOMSuk
Message-ID: <CAMB2axO42=jbaOzy72DzNH_wRBE9Oxm_FJcnYG8tSFArOUaYLw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 4/4] bpf: Unify helper and kfunc call argument meta
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 9, 2026 at 4:16=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
>
> Pre-existing issues:
> - [High] Uninitialized stack memory read in `check_kfunc_call` when handl=
ing kfunc calls in signed BPF programs.
> --
>
> --- Patch [4]: [PATCH bpf-next v1 4/4] bpf: Unify helper and kfunc call a=
rgument meta ---
> commit b1105689a4b2bf6e2532e6d414d410ef55c0694b
> Author: Amery Hung <ameryhung@gmail.com>
>
> bpf: Unify helper and kfunc call argument meta
>
> Helper and kfunc argument checking carried two separate meta structs: the
> verifier-local struct bpf_call_arg_meta and bpf_kfunc_call_arg_meta.
> Merge them into a single struct bpf_call_arg_meta. This is groundwork for
> sharing argument checking between helpers and kfuncs.
>
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index fcd9715eff017..5ccb00a8c84ce 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
>
> [ ... ]
>
> > @@ -12972,7 +12953,7 @@ static int check_kfunc_call(struct bpf_verifier=
_env *env, struct bpf_insn *insn,
> >       struct bpf_reg_state *regs =3D cur_regs(env);
> >       const char *func_name, *ptr_type_name;
> >       const struct btf_type *t, *ptr_type;
> > -     struct bpf_kfunc_call_arg_meta meta;
> > +     struct bpf_call_arg_meta meta;
> >       struct bpf_insn_aux_data *insn_aux;
> >       int err, insn_idx =3D *insn_idx_p;
> >       const struct btf_param *args;
>
> [Severity: High]
> This is a pre-existing issue, but does this lead to reading an uninitiali=
zed
> pointer if bpf_fetch_kfunc_arg_meta() returns early?
>
> In check_kfunc_call() in kernel/bpf/verifier.c, the local variable meta i=
s
> declared without initialization and passed to bpf_fetch_kfunc_arg_meta().
> If the call to fetch_kfunc_meta() inside it returns an error like -EACCES=
,
> it returns early before initializing meta:
>
> kernel/bpf/verifier.c:bpf_fetch_kfunc_arg_meta() {
>         struct bpf_kfunc_meta kfunc;
>         int err;
>
>         err =3D fetch_kfunc_meta(env, func_id, offset, &kfunc);
>         if (err)
>                 return err;
>     ...
> }
>
> Back in check_kfunc_call(), the error path evaluates meta.func_name:
>
>         err =3D bpf_fetch_kfunc_arg_meta(env, insn->imm, insn->off, &meta=
);
>         if (err =3D=3D -EACCES && meta.func_name)
>                 verbose(env, "calling kernel function %s is not allowed\n=
", meta.func_name);
>
> If the stack memory is uninitialized, could meta.func_name contain a garb=
age
> pointer that leads to a crash or an info leak when dereferenced by vsnpri=
ntf
> during the verbose() call?

Confirmed the bug is reachable. I will include the fix in the next respin.

>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709230242.20=
03459-1-ameryhung@gmail.com?part=3D4
