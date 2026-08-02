Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44083C2D
	for <bpf@vger.kernel.org>; Sun,  2 Aug 2026 21:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785706340; cv=pass; b=sj+3yEdjjMWKb7Ltq80gr/c7WE+PBtI/G3wBNOrafmg+1jqYJMztsvOE/x1VOFZg+frf0v9QY4L7aFh6SIVPzkwjRbV7QJAIvkVMYL44uTk41gvr54s9S6W/SyABbOK1xGv+BNq8WTaCT0kmZE2wW2kze2pPc3r0UICgpsoT2E8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785706340; c=relaxed/simple;
	bh=LSdofW40K1EnTz6Jum+TcVZgzGModR9w4wfzh8tJwkc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tDZ8gpSbtm7lPqDERcVllFjVH7d34ii79jc3snl4k3Y3arJi5Z+mVHrY8S8gmahmRcECOWEsROlw4rOdJ8mjh14adrlaf+tTu8WzXQpAzlpbOogwotGZAZHdo6ZFqW+ES8nD4yU9dbM7b+RytPpf1r0nHwxjLr1IcLhhX4IlVdA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZjrL+/80; arc=pass smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZjrL+/80"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-81dfdbd86d1so27259107b3.1
        for <bpf@vger.kernel.org>; Sun, 02 Aug 2026 14:32:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785706338; cv=none;
        d=google.com; s=arc-20260327;
        b=smaCKDJBtryVdEcuWjq7ZN8e/KOc6nZzAZ3b9s/M1a5vOIVSy1v9E2zXlo9KsZ8bjx
         jEqPkm9r2wYiAipeclhJGODfWlI2s9xM1HWr6KxWyyDNAg3tfG0R/VfFLS83spZdB+wW
         AEQzGCdTy8EDSEBIn6zLhCuTS1bujp/zer1ctClASv1z3IXqzFLJCa/iXKnVmNHqh8UC
         Lln8P5DgmxEjoFNJUeYh51Hjmle4OSbiFiPfyrfqd83af3Za4CbkV7kRaxAwoQdNwmlt
         5+iKduxCExVedsegHWQ8sED5fQ6jIbNRUn4dey2VQu9lD5tVGsSBr3Wj0mqNxfAZAn6W
         +WgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jJx4JmOa+C9zdV1VuAKgN9Q8DVXUZ1IOUzDIkXM6rE8=;
        fh=uA360uvxR9S0K/Y4Lovo7aIaGlBwzVBnnb2BKWupr/4=;
        b=oJ1pTIki2EKzVhtIBcoM41kNiN0KERD16/ODEEvv5NJAbjJGhevfmW8S/tAtz8mNhO
         +mIvxr+SQs65Llb76y/Y/cM1ZQY87l60NEp15MLuiwyB9kQI8HpKoPvL0C7FMIlepHqA
         KhGEf90V1eL19qawNQzY3psKMZC0KI8j0z+Sp3CaMcqykcsiZ6hDNfzqsoarNYmyUGpW
         zpYbz/Ej/eoe24gN34Js30YJG3g6q+siELFCVuzN0OiWpaTier/dAmZ4M2e/z5LljDC5
         G9Xlai3XS7zeevGd2xDr/EstBP3PxtWcCri8RchVa1Hd8yifl9USEUKVa9ow7xFBSIt+
         BEjw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785706338; x=1786311138; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jJx4JmOa+C9zdV1VuAKgN9Q8DVXUZ1IOUzDIkXM6rE8=;
        b=ZjrL+/80tTXDE0oGiLTea7AAl79dBwOO9pWFuyyUm2TZv+/kEE4xOljeiariM9cgo3
         D4e2rknpRMF7+gwJLj4GvTDX6RXvmTfWUyDn/yQAotl0DFwFM+3c0JXXu8bQ7iG9ZQL+
         A7zpGdOHY9aIo25/FRFpq1IT7PXeU7vwd+LM4nodWr8IUIDR0gx2qOgwCMyVxOKx6YsR
         6HqICODjvskzVp34SW4ik8/bI0OTFDpHIFt7wbrVe/BqPsPRPPqLh0Gtp2PvMe3gFi0O
         Zbll42QLAZJqZ345o+gorJbx9DXIRkKHjxEvegoUgz92O6K/IrMNcVTwdXrbHRTeeYeQ
         CGnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785706338; x=1786311138;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jJx4JmOa+C9zdV1VuAKgN9Q8DVXUZ1IOUzDIkXM6rE8=;
        b=tFcdTBbPhYkI4e0wfZvif3BVFIXyQge+N7Chb8rtN8Ksa3J5zKAXkjVrPjGITuB3gt
         a6jPGgiZuEkjPKE+4B3ttK2GM5rXmZHc6DVhQ2mOdfULDuyumNOG09p/fj8oIwWAK9nu
         YAKRrlt9BR+SFqlV2LtgkyD0xC5R/Pils2zSglGchkkREAn9+mYHFlEbvDCur7OvQXV7
         RunIxctwc6yR2q1RK9PW0BiGE1wPPqc+3bE+uY+xijjc1iLgoKo6Vp1w3EsQsXiFbcyv
         E5zgkxn/kMqnLpjkMCnLWMeuvIWMYpVDUIFoFr0M7/WoeAQpfoDSvY0HLDfOFvGFF7YA
         8DGg==
X-Gm-Message-State: AOJu0Yz5Qe0M9qJzXBVs0wQEeTDSdtffux1BSVq7z0XBMZytUhJQKD9w
	MUWExMWDHXUxUhjLcJCXXc119PD6H7ROzfZIrQ4JzhxqMMh/RmA5V9bTUYEF3oKavpr2gjTLMNO
	ihU2qyFK1rd73PGDDCkFjO5zkRmPOqMPB8y/H
X-Gm-Gg: AR+sD116cxsnPD88YsIXs7HLmoefv/R21qGyterBehazwWu1uC9mZFA4qpnB6nLl9YJ
	R8A2G/WPZrEzg3rx3aayKibaTMWktZsKC3sSN6IBfyKrs0r4oN67aPmkcY9ZWqcCKF9zsp/d9Be
	VTCN9blNGtdr9Vw1SUnr0WsRLukakH08YnefgoBYuUbv3vIcMvvXAabVtovG5JmwQDeFRpEsC2f
	n1XrDXWX7zZtxLKNA58xYqm6d5kYP4TrXFjNc2p2+rjBvSGHH9/CEh/4M1W3Pu+vlMd6QWw8Xwj
	2tO3wRPdun77lQPYl87dIeX6knsxKT0tD3fC0UoaRIjN
X-Received: by 2002:a05:690c:6e12:b0:80d:66b2:82c with SMTP id
 00721157ae682-81fd4a95542mr106658587b3.16.1785706337663; Sun, 02 Aug 2026
 14:32:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260801074633.1595644-1-ameryhung@gmail.com> <20260801074633.1595644-13-ameryhung@gmail.com>
 <20260801080940.55E721F00AC4@smtp.kernel.org>
In-Reply-To: <20260801080940.55E721F00AC4@smtp.kernel.org>
From: Amery Hung <ameryhung@gmail.com>
Date: Sun, 2 Aug 2026 14:32:06 -0700
X-Gm-Features: AUfX_mx9aBcMfMpdFxjzBrFWO3FK-gseHqnYyXY08NFWybw3UAkapxJ-BhWDtZ8
Message-ID: <CAMB2axP6CHeFRbBFxqnM9Ficnp-KgT+sYKVFVbdLX1b6jraXhA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 12/18] bpf: Classify kfunc mem_size args from
 BTF without register state
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 1, 2026 at 1:09=E2=80=AFAM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [High] Removing the register type check from `is_kfunc_arg_mem_size()` =
allows a BPF program to pass a pointer register as a memory size parameter =
(`__sz`), which triggers a `verifier_bug` and a kernel warning.
> --
>
> --- Patch [12]: [PATCH bpf-next v3 12/18] bpf: Classify kfunc mem_size ar=
gs from BTF without register state ---
> commit e7666ea9e561228e1708d772f8e42d33c514cde8
> Author: Amery Hung <ameryhung@gmail.com>
>
> bpf: Classify kfunc mem_size args from BTF without register state
>
> This commit removes register state checks from is_kfunc_arg_mem_size() an=
d
> is_kfunc_arg_const_mem_size(). It relies solely on BTF to classify kfunc
> memory size arguments to further decouple argument type classification fr=
om
> register state.
>
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 6fc22a4e38b26..d65da54f9c0f8 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -10785,26 +10785,24 @@ static bool is_kfunc_rcu_protected(struct bpf=
_call_arg_meta *meta)
> >  }
> >
> >  static bool is_kfunc_arg_mem_size(const struct btf *btf,
> > -                               const struct btf_param *arg,
> > -                               const struct bpf_reg_state *reg)
> > +                               const struct btf_param *arg)
> >  {
> >       const struct btf_type *t;
> >
> >       t =3D btf_type_skip_modifiers(btf, arg->type, NULL);
> > -     if (!btf_type_is_scalar(t) || reg->type !=3D SCALAR_VALUE)
> > +     if (!btf_type_is_scalar(t))
>
> [Severity: High]
> Does removing this SCALAR_VALUE check allow a BPF program to pass a point=
er
> register instead of a scalar to a kfunc's size argument, potentially
> triggering a verifier_bug()?

The issue is only temporary. It is not bisect safe but simplifies the
patches. The issue will go away after patch 17 once
check_mem_size_reg() is dispatched on KF_ARG_MEM_SIZE.

>
> If get_kfunc_ptr_arg_type() sets arg_mem_size purely based on BTF,
> check_kfunc_args() will process the memory pointer argument, peek ahead a=
t
> the size argument, and call check_mem_size_reg():

A later patch will also defer mem+size checking to KF_ARG_MEM_SIZE
similar to helper (look back) so check_mem_size_reg() will only be
called after size if validated.

>
> kernel/bpf/verifier.c:check_kfunc_args() {
>     ...
>     ret =3D check_mem_size_reg(env, buff_reg, size_reg, argno, next_argno=
,
>                              BPF_READ | BPF_WRITE, true, meta);
>     ...
> }
>
> This happens before the main loop reaches the size argument and ensures i=
t is
> a SCALAR_VALUE.
>
> If a pointer register with a fixed zero offset is passed,
> check_mem_size_reg() might assume it is a valid scalar value of 0, pass t=
he
> boundary checks, and call mark_chain_precision(). This explicitly trigger=
s
> verifier_bug(env, "backtracking misuse") if the register is not a
> SCALAR_VALUE.
>
> Could this lead to a kernel panic on systems with panic_on_warn=3D1?
>
> >               return false;
> >
> >       return btf_param_match_suffix(btf, arg, "__sz");
> >  }
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260801074633.15=
95644-1-ameryhung@gmail.com?part=3D12
