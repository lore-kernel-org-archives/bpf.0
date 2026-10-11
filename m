Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7BAB33C195
	for <bpf@vger.kernel.org>; Sun, 11 Oct 2026 16:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791734794; cv=pass; b=k/q/aVQSe+8D9Ifr6JwxSOaZ8MmQlE4TKYbnRdEZ12wCbwuQDbVfp22chbYmwRvQqbg/gvt8FeFLIq1Q8dyUzFXbiz9yPhdbs+4HLj+gY9psk9vDKT+FPL/H1hW5aVj2KoVEn86jKYEbXcyhFr/AkJ09V0wdE87GlquV6Cdwzyg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791734794; c=relaxed/simple;
	bh=kXWZqUutZPFmlyWXPfCCFUk+WefMgzgFDuEDVNTRmc0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UduLuO9JrQHJ2/INOfAen8BBI7W6rzNiJ0b5Z7Bx3ZhpNcxU/AZcf2Tejcoti4EQMFa9xdYMs4haWsczmcxeU9hox9j2vlAaCMYwVaOYFugZUgjkQrmoE20fjIHMwXC18f1bXOjLW2qWuGaPRzTyukGMXAvox78dCknC/CdUFtU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Nx5wmVMl; arc=pass smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Nx5wmVMl"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6af9cc73235so380194a12.0
        for <bpf@vger.kernel.org>; Sun, 11 Oct 2026 09:06:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791734788; cv=none;
        d=google.com; s=arc-20260327;
        b=Uhme2NtvC6h4fPfhtxb3FCoVLFtnC4Y9gusdpnio6jkmlcY1oNxQi6/Shu/WRYM9SQ
         tZ1jiDBzFjgLv8qtumoD6Pb7LX1RI66U9dz82qdwaKvavtNqRwZsYmQoiRxn5DX1DkBN
         VuYQ5ZmO8n0qHBirpAp3+5V+VxiB0W1uIf6nWNgTKmhnoMnCqbRAtqroIWnB+u7z2P/5
         g/HQ8FNatybj4qQnHwd+kEwhGCNwKaS3nwlqFaUpb4qJ7whiKagqvvpyuW5lYDkTjOci
         W8g+vigmMs8tvNAZS8jnSi3AYL4Xe6BI/vZbn4yNFvAaj4njuVGw2XFH9PhyxLDWBwwN
         HYpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KCwS1dvCZg/JrnQTXuT0sf/Ob2X0hU5Es+KBduwk398=;
        fh=uA360uvxR9S0K/Y4Lovo7aIaGlBwzVBnnb2BKWupr/4=;
        b=gnSbrZS+TxXiI89BJqNxX29Ic+OSYyHqet5onX/VqSBOWXDgwuiam9dakbwI8AKq3O
         klSFyIKYG2OrrIJII2OZoPsqTKy4MpZNWvtFW8yTOQGSgL2eklLjsEtcULs+8iRVrV1R
         /6wEKJneQmyR8IqgG5anu8OccaB8PEiBWeUmIOdAuaIHrNzuxV0APrbyvCSt2zBcbhR1
         JWO+6o3HXBZLvoq/dEph0gXQFfG7IOtSRy+h+lLb4SWz3JJhDkxIO1Dd/orFYUUnFpJQ
         GLIDAmee72DU6hgdEi5FxCr8W6Nhol7jF/GZ4DDFLxlLKn1YQ+LtkmcZ7Sb8dqHmiCsE
         dSNA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791734788; x=1792339588; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KCwS1dvCZg/JrnQTXuT0sf/Ob2X0hU5Es+KBduwk398=;
        b=Nx5wmVMlV74sujfTzxP4082wDCWrEXA3H7vvjzYH4/OPxR+MMUDnnvT+9z2EkEm929
         VRMBWo4HgGapJG3a1YhMOB6XRv62HnJHDXiE9tA9bSV1wz9KnU/ClPs43P/al1tfr/Zj
         svjKznTzRv6jvOprWTsnb7LDvUc8CilVw+PWLlVbkB/IyAbZu3KJsYzqPAZvujNSFRbA
         0C15YJGYvUD+41u+eAvt28f+oB4EYpxATIuW/X7s+tE3e/pxpy6bJcisjWcZAlrgnaq9
         Ktr2ssnNcMSajL9URXNE5t8S2nkkjnBbk1VsA0SgL6BSWzDHPmiuytEOQudLwOIP5bg5
         9maw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791734788; x=1792339588;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KCwS1dvCZg/JrnQTXuT0sf/Ob2X0hU5Es+KBduwk398=;
        b=irXBRl4M9zrYwMJckzKYUlbmDrgGhtSlU5Akt1SK9l8icpP0YNGfDchcFwmGUosnDi
         O9AA73GwGg81DY7T171PFwsybGscJaGF23iXSLi1l93B3yepH6wR740r/+90uq7YZmYM
         xvWLWZYOJhQghSIZ5Xwgo1/kLBWJN20XpEqTBRcUUqEv39QYVeFpkpieZ6dliW2ltz7I
         JlP25SD//GLEA4VUb1j2XPHz7Bydpbdxfas52QbZ+USrrH+kPRxedWKBpe/2voEnqV+W
         h2Q6uRnNH+3h+G9Af2Mt7tRDaIcDnbFlHH9Iu6C9X7OI9aD8JkBORMGG61j0JvHrC89g
         d8uw==
X-Gm-Message-State: AFq9FYJBZzzz3QoPliSu+1vEUsRMzSs6dqkjegw0EtY2it1r0Tzr+VZe
	Ch4wDTkM6l/3fut/w5gxiMYC1aTc3poaBlTu+iKc4Hgfdux6BpTDrz0to5pKdVVeR46eMOGwr0J
	CxYcy3FQVDaNA2XYYjZiPG/HZCbaw6nSXhnMQN2F5
X-Gm-Gg: AYBFou140J23DHZClakXwDJu+Yo3kYPyptUBsYDMvZWuDOPVkS3BBJjoimH4wydq7Wy
	HSLNNnQM4oaRw6Dohpn/70T17j8aEJoLkNB/UoJKbbg4gD4BtjC32G6KzOaaGcmSc1g8xuxF6hF
	TDlQyAM42Tussn5sFU33CLv+WwhmiEwP8WvhPxKhqcsyOmUJC9lJBQ3wwhVGXYvkyBYKD1PslLP
	hHALNalXbb12XErja5PFfB7tpJXHeqjqdClJwgkMeWMo6NZ+d+rwHrz8BcRG96/j/7NKt8N9bw7
	JjfSSiWkYryQTwW/ikyfaC3OEuzY8rUyAT2vb469YWxJCQSjtJbHxlY=
X-Received: by 2002:a17:907:3e9e:b0:c31:5918:86d1 with SMTP id
 a640c23a62f3a-c31a9d3cfbbmr812341666b.10.1791734787484; Sun, 11 Oct 2026
 09:06:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261009130708.1370675-1-wusamuel@google.com> <sashiko-outbox-165614@kernel.org>
In-Reply-To: <sashiko-outbox-165614@kernel.org>
From: Samuel Wu <wusamuel@google.com>
Date: Sun, 11 Oct 2026 18:06:15 +0200
X-Gm-Features: AclHuK8LTbb90UNk1o9A5yhk3IMkWEC-G6WX12WS1kwBs93286784npXqzjRUwI
Message-ID: <CAG2Kctr8A+TOiGzdRYdo5rHyxgXHifKXExDivvApvjUhGeZ0dA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: Resolve typeless ksyms in the kernel
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 9, 2026 at 3:18=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
> - [Medium] libbpf: weak LTO ksyms fail to resolve and silently default to=
 zero
> - [Medium] libbpf: fast path bypasses ksym ambiguity check
> --
>
> commit fc5b255aa262ee9f680fe13bd2bcb9fc56ff8a8d
> Author: Samuel Wu <wusamuel@google.com>
>
> libbpf: Resolve typeless ksyms in the kernel
>
> This commit optimizes the resolution of typeless kernel symbols by using =
a
> BPF_PROG_TYPE_SYSCALL program to call bpf_kallsyms_lookup_name() in the
> kernel. This reduces load time significantly by avoiding a linear scan of
> /proc/kallsyms in the fast path, while falling back to the legacy parser
> if the kernel resolution fails.
>
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> > @@ -9590,6 +9590,58 @@ static int bpf_object__read_kallsyms_file(struct=
 bpf_object *obj)
> [ ... ]
> > +static int bpf_object__resolve_ksyms_in_kernel(struct bpf_object *obj)
> > +{
> [ ... ]
> > +     for (i =3D 0; i < obj->nr_extern; i++) {
> > +             ext =3D &obj->externs[i];
> > +             if (ext->type !=3D EXT_KSYM || ext->ksym.type_id)
> > +                     continue;
> > +             if (snprintf(ctx.name, sizeof(ctx.name), "%s", ext->name)=
 >=3D sizeof(ctx.name)) {
> > +                     err =3D -ENAMETOOLONG;
> > +                     break;
> > +             }
> > +             err =3D bpf_prog_test_run_opts(prog_fd, &topts) ?: (int)t=
opts.retval;
>
> [Severity: Medium]
> Does this fast path bypass the ambiguity checks normally enforced by the =
legacy
> kallsyms parser?
>
> In the legacy parser, kallsyms_cb() enforces a strict ambiguity check and
> returns -EINVAL if a symbol name maps to multiple addresses. However,
> bpf_kallsyms_lookup_name() simply returns the first matched address.
>
> If the fast path succeeds, ambiguous symbols might be silently accepted. =
If the
> fast path fails for any reason (such as older kernels without support, or=
 an
> unrelated missing strong symbol triggering a fallback), it drops into the=
 legacy
> parser which then unpredictably rejects those same ambiguous symbols. Cou=
ld this
> lead to non-deterministic behavior depending on which path is taken?

This matches the semantics of light skeletons, which also resolve
typeless ksyms directly via bpf_kallsyms_lookup_name(). However, this
is a semantic change, so I'm not 100% sure how to handle ambiguous
symbols and hope to get feedback.

> > +             if (err =3D=3D -ENOENT && ext->is_weak) {
> > +                     err =3D 0;
> > +                     continue;
> > +             }
>
> [Severity: Medium]
> When bpf_kallsyms_lookup_name() fails to find a weak LTO symbol (like tho=
se
> ending in .llvm.<hash>) because it expects an exact string match, this bl=
ock
> clears the -ENOENT error and continues.
>
> Because the error is cleared to 0, bpf_object__resolve_ksyms_in_kernel() =
will
> ultimately return success for this missing symbol.
>
> Will this cause the caller to unintentionally skip the necessary fallback=
 logic?

I believe this is fine, since the kernel intentionally removed
.llvm.<hash> matching from kallsyms_lookup_name() in commit
fb6a421fb615 ("kallsyms: Match symbols exactly with
CONFIG_LTO_CLANG"). Therefore, a weak LTO symbol will not resolve,
which is within the defined behavior of a weak symbol and matches the
precedent in the current code.

> In bpf_object__resolve_externs(), the fallback to
> bpf_object__read_kallsyms_file() is only triggered if
> bpf_object__resolve_ksyms_in_kernel() returns a non-zero error. By cleari=
ng
> the error here, the /proc/kallsyms fallback is bypassed, meaning weak LTO
> symbols that are actually present in the kernel might silently default to=
 zero
> instead of resolving properly.
>
> > +             if (err)
> > +                     break;
> > +             ext->is_set =3D true;
> > +             ext->ksym.addr =3D ctx.addr;
> > +             pr_debug("extern (ksym) '%s': resolved in kernel to 0x%ll=
x\n",
> > +                      ext->name, ext->ksym.addr);
> > +     }
> > +     close(prog_fd);
> > +     return err;
> > +}
> [ ... ]
> > @@ -9863,7 +9915,12 @@ static int bpf_object__resolve_externs(struct bp=
f_object *obj,
> [ ... ]
> >       if (need_kallsyms) {
> > -             err =3D bpf_object__read_kallsyms_file(obj);
> > +             err =3D bpf_object__resolve_ksyms_in_kernel(obj);
> > +             if (err) {
> > +                     pr_debug("failed to resolve ksyms in kernel: %s, =
falling back to /proc/kallsyms\n",
> > +                              errstr(err));
> > +                     err =3D bpf_object__read_kallsyms_file(obj);
> > +             }
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009130708.13=
70675-1-wusamuel@google.com?part=3D1
