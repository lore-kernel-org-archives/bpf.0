Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99F578F2F
	for <bpf@vger.kernel.org>; Mon, 27 Jul 2026 00:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785112823; cv=pass; b=ATHYCLpaI09Wzqbb8b8+Hb0ePNm9hOoNf9utXcm1GNTbl91rUojj59D1lmfCCeZZ2aUaKqC8YdcUl7HtLc1vao7z6Xm4g4KeBogPIKMN5TW0bArAx3woii+XYQ8pLaJ4djR2QiEuavYyp0MzajtxMC/ItZmexPyHNxyoAUgjxyY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785112823; c=relaxed/simple;
	bh=cu0kBaiNZ+6Ryt7/mxs19i1OzrGh+mdVEoCwxTMVL84=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NDsrjCJ+UO5Qn9FkZTwsCExdNgr5u9VUFhBnw8iZOMB2Jyv9rXqIGfhTv6XM+FR0DSfvSbzrNqGbltCOuLanezOhtOymflhlAkMeGEpYhyPYMAVs0JDsOTIBKWCSeyrR97NL1eWr6zJEpDe7Du7BI/DtOXKn2pAYRQ40PHf1IuI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IXpA880m; arc=pass smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IXpA880m"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5b015b2d792so2247444e87.3
        for <bpf@vger.kernel.org>; Sun, 26 Jul 2026 17:40:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785112820; cv=none;
        d=google.com; s=arc-20260327;
        b=LO7T6CqcAuDoqlness670NPPBwDk/UoRS1YPEeNI0gy58meNlDco62+aj53I3tAJxd
         Sb7/1cfk075n0gQUn9B9P6VrDl/XjbUUXo75RN3T7f5dUb7+ic+RVtySF8v9wyirB3WW
         iUYdBBpLhGAfzM3qJDnb66XqZUAfF42Lfzc/vZSJ/g0tRn6To+jC8y9QRLWi+2A3VYte
         OKo9p+nfvdw/XOHnnlt0J3tHvqRLTYKNwFPd1ugrFj6wUwb/mzegbPIHUlHc7hxWHzDR
         Ld9y5B/gY39L6+rypbIC55cJ1UDIrDtyHSudstyrqB212FAQpREr6XDGADxDzJUDmg9K
         k33Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6CyfvHzrX9WXAXlnVNWJsJhYmyyWrG3FuVrwtYk9PvQ=;
        fh=uA360uvxR9S0K/Y4Lovo7aIaGlBwzVBnnb2BKWupr/4=;
        b=ZmVY2MfW/3iyKiiEp9WYcJpmtFvtcV892TBCQnRh5uibUMeQdcNkW6jIRSfd6VK08f
         peIoL8oVOM7MTT2lU9T+hlBiTlCq9LmSdnNRlU1+0QHUpi8/y/eAnW5sAHEXzwq9t/Ge
         Ys1NEYm7amVnk2cKuGWUSaGHmGZWIX2tcyENMowiLna3whqXfckObOh6IEk/Omo6mn7w
         lecfNQZ60kP0nmMsGM0Ls3Yh4SnE30vrgudZQspaNtFhG3Esou12BhdbjezLlBFng1Ha
         vQ5uAG3gL2RuWDPajPXQn7y31pkGlh6YV1zzTkD+bAkDMAXmbCiCrCAqwZHNpVGH7OiL
         xioA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785112820; x=1785717620; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6CyfvHzrX9WXAXlnVNWJsJhYmyyWrG3FuVrwtYk9PvQ=;
        b=IXpA880meO6mTcfmA1Qg50mzA2gtMNQbdheph/7CNQgAW74ZhN2Af5VvwWogp/Eh4n
         ++p7Rmb7bwzkTIIbaFGtjAeZS0zXVBrYfPCvqRU1WKnyta3Zd4TTcNBDpXf/WtnuDdv3
         kNXpg+1JwFjj1y9dJXqjZC8hTQ2bLWz7n1pUFzrzWUA+y6bH8DpuJc2iUMKzRoeD15M1
         /AjqQxNd9HT67DokGRmvPtIaHcxkVtei5SzGZmg4VmSci+ONRALC5NAov3nH0D56Z9lD
         SedKNzBUzruYu8EXaNYbyd9+FkLUAh6i24HJuAZuAy5HlqNpQhrNXm0vFqwjMXkKoEFt
         RhOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785112820; x=1785717620;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6CyfvHzrX9WXAXlnVNWJsJhYmyyWrG3FuVrwtYk9PvQ=;
        b=Q4ErvVRz2uyM2gluCeAxPW1Oap7N+LeuNp1f0guaxv0OgM20nV5V7AkbXmdks6IQ6M
         gc90faQtxbGpUblX6CeqyhriY37QXTWEVE8MxYnsxH/Hx4mmkC6lcXsLeyHK8vDS7MYG
         Nf8B+FHhAAer9J4suJRGqZc8rJEJUggZixCURGVbK6dd9ksHYIxFS4OvmS7k0WX/YrPP
         RNPHqFb9iEm/kYUxtMp3/n33X61VP2+L/YszlbuuXDfDmlZ/eJbc3ITCo6rSuDPYMgss
         GeHTkd9U+MPovrmSdwpJFexV5y2J8LrzQQXjsLX/QI/jAC8PUqF9paLEQ3dIHEvzZnEq
         tncA==
X-Gm-Message-State: AOJu0YxMvzTD8hWx5OcaXKn6wx8AheBDO9Ch1bgTFT80v3QMWi1NPfTW
	elmq6usCE609WWmm500EGJae6ciabikl8kTMxs4PM+qB7S4z5jt9TasvTkksCxITuj3wPf8pdhq
	1SaOoFdmGnUcBeenGpNwIxLbWyf6TF7I3Ht3vJ2+SEA==
X-Gm-Gg: AR+sD13hzkrsxfz/wG2m/4/fylnS+gN4GqwaimEVMLSjJyuQpCpkTJtcA7twZZUZcdw
	xCfMo5lP920dg3dO82T9jbKuX3UrgAzqTaDblg1ow8snn1dK6Ve3U878aliTPyVJRZHcILC+9iB
	9m8yb7QJMCHEGtZOBo6kzOeOhZzoniQlbJ6B/h1dZoioql0w0SekH2Zg+a+yFnxoeiYads7I+e8
	poCHB38Pt4uWDYP+F53qPDqx0E6/EhFGde9skXR8DvIiPJKjW3nbEqeLoAS
X-Received: by 2002:a05:6512:3195:b0:5b1:1b50:7201 with SMTP id
 2adb3069b0e04-5b2c1b2ef9emr1184352e87.36.1785112819522; Sun, 26 Jul 2026
 17:40:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260726235030.1152542-1-dingning04@gmail.com>
 <20260726235030.1152542-3-dingning04@gmail.com> <20260727001354.B3F1E1F000E9@smtp.kernel.org>
In-Reply-To: <20260727001354.B3F1E1F000E9@smtp.kernel.org>
From: Ning Ding <dingning04@gmail.com>
Date: Sun, 26 Jul 2026 17:40:08 -0700
X-Gm-Features: AUfX_mw5jYf4gaWMG50gpM8nwUKursbmWq_aWool25MmJRYUjdUk2KP0LWD3iMo
Message-ID: <CAJP4ius__AtzaGNVAPbHn+JyfR6+E8=SHNhcZA-dKdGVfnbk0A@mail.gmail.com>
Subject: Re: [PATCH bpf v2 2/2] bpf: Reject untrusted pointers in refcount_acquire
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This seems to be a separate issue from the refcount_acquire argument
check... For a pointer without NON_OWN_REF, code inspection shows that
direct access can reach verifier_bug(). If that warning is emitted, a
system configured with panic_on_warn may panic. (haven't reproduced
that yet)

In my runtime experiment, the stale address was reused for another BPF
object before physical reclamation. A read through the stale pointer
returned a value belonging to the recycled object. And I did not
observe a WARN, panic, physical-kfree UAF, or a successful stale write
in my experiment configuration. So the current experimental evidence
shows only a stale read from a recycled object, while the panic only
remains possibilities in the source code, but haven't done any
experiments to prove that it is feasible.

Regards,
Ning Ding

On Sun, Jul 26, 2026 at 5:13=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
>
> Pre-existing issues:
> - [Critical] check_ptr_to_btf_access() incorrectly allows writes to PTR_U=
NTRUSTED allocated objects or triggers a verifier_bug WARN_ONCE when readin=
g from them.
> --
>
> --- Patch [2]: [PATCH bpf v2 2/2] bpf: Reject untrusted pointers in refco=
unt_acquire ---
> commit 80e6c61503b2eee2d4804b0a7ec8927827ed7d92
> Author: Ning Ding <dingning04@gmail.com>
>
> bpf: Reject untrusted pointers in refcount_acquire
>
> This commit fixes an issue where a refcounted map kptr could still be pas=
sed
> to bpf_refcount_acquire() after being marked PTR_UNTRUSTED due to
> bpf_rcu_read_unlock(). It updates check_kfunc_args() to reject PTR_UNTRUS=
TED
> arguments for KF_ARG_PTR_TO_REFCOUNTED_KPTR.
>
> Link: https://lore.kernel.org/r/20260726021304.97ED91F000E9@smtp.kernel.o=
rg
>
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 1e7343b625de5..63b1d997fe804 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -12414,6 +12414,11 @@ static int check_kfunc_args(struct bpf_verifie=
r_env *env, struct bpf_kfunc_call_
> >                       meta->subprogno =3D reg->subprogno;
> >                       break;
> >               case KF_ARG_PTR_TO_REFCOUNTED_KPTR:
> > +                     if (reg->type & PTR_UNTRUSTED) {
> > +                             verbose(env, "%s is an untrusted refcount=
ed kptr\n",
> > +                                     reg_arg_name(env, argno));
> > +                             return -EACCES;
> > +                     }
>
> [Severity: Critical]
> This is a pre-existing issue, but I noticed a similar problem with
> PTR_UNTRUSTED handling in check_ptr_to_btf_access() for allocated objects=
:
>
> kernel/bpf/verifier.c:check_ptr_to_btf_access() {
> ...
>                 if (atype !=3D BPF_READ && !type_is_ptr_alloc_obj(reg->ty=
pe)) {
>                         verbose(env, "only read is supported\n");
>                         return -EACCES;
>                 }
>
>                 if (type_is_alloc(reg->type) && !type_is_non_owning_ref(r=
eg->type) &&
>                     !(reg->type & MEM_RCU) && !reg_is_referenced(env, reg=
)) {
>                         verifier_bug(env, "allocated object must have a r=
eferenced id");
>                         return -EFAULT;
>                 }
> ...
> }
>
> Does this logic incorrectly allow writes to PTR_UNTRUSTED allocated objec=
ts
> or trigger a verifier_bug WARN_ONCE when reading from them?
>
> If a program loads a program-allocated kptr containing an RCU-protected f=
ield
> inside bpf_rcu_read_lock(), the verifier marks it MEM_ALLOC | MEM_RCU (an=
d
> NON_OWN_REF if it contains a bpf_rb_node or bpf_list_node). When the prog=
ram
> calls bpf_rcu_read_unlock(), it strips MEM_RCU and adds PTR_UNTRUSTED.
>
> If the program subsequently tries to read or write this pointer,
> type_is_ptr_alloc_obj(reg->type) evaluates to true because it ignores
> PTR_UNTRUSTED, bypassing the read-only check for writes.
>
> Then, if the pointer lacks NON_OWN_REF, it hits the type_is_alloc() condi=
tion
> and triggers a verifier_bug(), leading to a BPF_WARN_ONCE. If it has
> NON_OWN_REF, it bypasses the verifier_bug() check entirely, and proceeds =
to
> allow a memory write to the untrusted pointer.
>
> Could a malicious BPF program exploit this to achieve a local denial of
> service via panic_on_warn or a use-after-free memory write?
>
> >                       if (!type_is_ptr_alloc_obj(reg->type)) {
> >                               verbose(env, "%s is neither owning or non=
-owning ref\n",
> >                                       reg_arg_name(env, argno));
>
> [ ... ]
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260726235030.11=
52542-1-dingning04@gmail.com?part=3D2
