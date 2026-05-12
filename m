Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6CE6361663
	for <bpf@vger.kernel.org>; Tue, 12 May 2026 19:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778613494; cv=pass; b=eh5sdYe9E4jB3F+SepovvGZKYgwxUOWwdf8AO/zVLD+N/3ONbVRIzqQbTHyvdh6DUZPBeOGNU2zVET4np2w+N6SyUMNr7XDXOU29t46znA5e3oBon26kqX0mqLEy8PpxaNsd0kvQUjG/R2A7HHp5wHpNyHPzQmgO850rmkuzQwA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778613494; c=relaxed/simple;
	bh=x0EJ9IIQlmLp0s2Di6cqa87rcp0GEiNnoqauM01YemM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uWwBlNyzg5PnUdl0sexx18uhrmQhMwJ3TCSAsW+QIR6ti6//l/+yxPIgb3JHEfo2qSeVaRyLzFftGqlKsodgeHkNWBKzr6+0o4stIGhH3BepR3Bh+BrpCJslyI9puDjRQRl6y7ppg1A85jKWhy9y7XsUYvqYX1QJdkBgF3Rez7c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=VzaSG/zY; arc=pass smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="VzaSG/zY"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2b4650d5f5cso23575195ad.0
        for <bpf@vger.kernel.org>; Tue, 12 May 2026 12:18:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778613491; cv=none;
        d=google.com; s=arc-20240605;
        b=l1oCtonIgwVuovLmnNZzk59ZOR6TLJlzoKoMLTYAtUpnwOWE0vv0w1dZ+hBXTCINIk
         K4caI28uGHpg5E8AK4dFu21Eqw8F11u7UTm29hgLwBmUWSYOxiVGnEiq+zp/gAtStFzw
         aVkX/wdh/3S8Fo3YX9342PlpLa8H6UnjBuysP9uQlN6MrH2RtFLyJ0+FzxrhKGKNb5TN
         wAnBn3zYKFPjgCtysnT5lSbHOTlWe1CjwfZg8YlMwGXPlCehI+i6K3eb84i6kleGilXb
         wZPPKl8xhoJcBhwMlNRfLe5kdTgDZf9QcFVAKjtQwwmum/qU3jPQUXMDYZfhg5uNPkNv
         T2XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EvRcW1Qh/576NOLilmJxxhESnWbBM64hf3VFbtNvDPg=;
        fh=33xbOHzAcXuocl/gf9sBuog4xD6zbJhUd7pcQwxSPoY=;
        b=BM2iXv0h5beFmCvCVhYMw956GD8l3HvuQBciy8dAeZ9+nkMzxrZPT9e19ur579+Vkx
         df4pJSl8fkWioL/9qlYkcJePJzMqoq3eX9u7SdjjGEVRPpx4Hjf+bICLuo+MLnlTOk8N
         fRzgPBnstolKKwVWZbWm3eeBY4OnGFlVL8JXj6YswHIZqVGjDXjnQUyvsabgh9+7tva0
         AXORQDJOSiwKihY9tLWDoCDZdOnwwaPCEVz521Sj2fWlRSWP4U6yY7+/y7DzUmtwau+e
         iNb1ri6Bck65kmv4or+5hz62kCFZytK2EODN2WRv6eOTNLrXcoJ3wwhm3+CwRMnWU2WD
         nKJA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1778613491; x=1779218291; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EvRcW1Qh/576NOLilmJxxhESnWbBM64hf3VFbtNvDPg=;
        b=VzaSG/zY21rzktdtMYdicKzLpl/YoFm7iv3uzlED+W1CLf0OX7D9vnHpRbX8v/JN8O
         0QO7LwC2GJ/CqzCCfVtawFHkZplgFF/LgAe65N/MQSGAczPaFltFEbxseJrGd5CW5W89
         rAdQJj0e/w42EuDkCHdNePJV/wlZZfSB5NjaRAkx2XXTA7lp4WXvHiUvFpsBTVbxio+/
         tSxgNoli+vuOOfFJZeAceCHCoPthBWLCqDu1NTh2y3a1RgsgOUD/AtkoDdwIHEGZndvN
         j4WtdPqsKhk7Dt8z8XNFaQ0MKF2uKSDeIa8+7uC1ZTVE1s8ZzgiK5kuAMKgZMvhAKfzC
         QPLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778613491; x=1779218291;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EvRcW1Qh/576NOLilmJxxhESnWbBM64hf3VFbtNvDPg=;
        b=ezYX24rxhAeq8DxQigu3sUY2gOmI85RtzPPtT1Su/OCQE4aJF9EEKaH3qsdrvHo5S4
         bZrCG6G2ULOsP2c1Zpx47dicjgAJjZ7qX8fwybtqbsdi6aERf/cKTYeY32wHhaSa4p4/
         yGI7lUWUZI8xKTLor2BL0p11D2rka7z5cNynpXHinbAG8reWm0W2frAAFmdUPOSuk5Fv
         oChbiXRaedmsgFs03UACrGWRDuJ3x5HXsMrhlEkcvxsrGFiruUAVct19fyq2jK5FdB2a
         d5VRX5ZYyGL0M4Occp10JtfMMwUWdmu3O5jMY/eQZQ628SfwKHa0KaoO16cMzaAA0csz
         2qrg==
X-Forwarded-Encrypted: i=1; AFNElJ+NuXTstKyBVX24sEMH9Rn8Hkq+CPVU0wm+XYqh/6JKpK9TZMa5BXvBfjpgRBhU47dx04o=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywode+XyTpJ/jwJfU2CQWMTEiqMCUPHGSlnjyd5fa/6nEcLMyLt
	bHwl73rdUS2jJTNz+Y0yvk3bJUiWWnhroC/R7wYPHHZrnxT1BHyqJfIM3ku3KsaG7mBEYT4oEVn
	5E/JHe5KzyWEECC819fRW+zkJe0fZzkPpoOliGaFg
X-Gm-Gg: Acq92OFKzxGHuYy89rzoyh+0CbXfcXVtm3uP9ESqXjFbrKKn33/Nx9NEfvHa9C701pR
	VWznREtreP6fF/xX2bbPJMnfhdwinH9qqPvBTn4k3VZrJ2fMVouWr4Ks+Fuqx9I9FRYwk91X9F1
	17K5isDrkkiY60DeSLEzwaBZAb6bpb7TBZh/kKBKSuxQ91kvWPFnqT79EsfdpLC5/3+xxLK+ntj
	hAx5cHxnmENZwFYh6TaqenIQ7ybUs/PkiOyyUPG+q+4l+mC0FtIeqjhWqyx5jkdeEVO9fjxzUoN
	0oeettE=
X-Received: by 2002:a17:902:ea0b:b0:2bc:6784:525f with SMTP id
 d9443c01a7336-2bd2711a4e2mr3804045ad.15.1778613491141; Tue, 12 May 2026
 12:18:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <agDuCdGIeM-6z-j-@altlinux.org> <CAHC9VhQ4VyAvG-z2h2NFpPx9PcJP4Ot2Ap=MPbCRk2TosJWOTA@mail.gmail.com>
 <agI9Rdi-72f8dNbB@altlinux.org> <CAHC9VhRWNEzYx3Xxtxv_0BBkM7skisVdnKXx3CGn3S=aoBCiyQ@mail.gmail.com>
 <agJPqiSKvHrrg6Qn@altlinux.org> <agJajS11YK1XGB-y@altlinux.org>
In-Reply-To: <agJajS11YK1XGB-y@altlinux.org>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 12 May 2026 15:17:59 -0400
X-Gm-Features: AVHnY4IItDSDQ_dFikFYv9ElTowZ6XiRLaS1GWsgcMI4Py0or-SaDs883yt9alk
Message-ID: <CAHC9VhT1d6xSboPErjrNqx41YefJ-fzs+FKnF5hDAhCWCGMfdw@mail.gmail.com>
Subject: Re: [BUG] lsm= with bpf before selinux breaks fscreate with EINVAL
To: Vitaly Chikunov <vt@altlinux.org>
Cc: linux-security-module@vger.kernel.org, bpf@vger.kernel.org, 
	selinux@vger.kernel.org, KP Singh <kpsingh@kernel.org>, 
	Matt Bobrowski <mattbobrowski@google.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 11, 2026 at 6:43=E2=80=AFPM Vitaly Chikunov <vt@altlinux.org> w=
rote:
> On Tue, May 12, 2026 at 12:54:21AM +0300, Vitaly Chikunov wrote:
> > On Mon, May 11, 2026 at 05:49:39PM -0400, Paul Moore wrote:
> > > On Mon, May 11, 2026 at 5:03=E2=80=AFPM Vitaly Chikunov <vt@altlinux.=
org> wrote:
> > > > On Mon, May 11, 2026 at 04:19:34PM -0400, Paul Moore wrote:
> > > > > On Sun, May 10, 2026 at 5:17=E2=80=AFPM Vitaly Chikunov <vt@altli=
nux.org> wrote:

...

> > > The patch below is what I had in mind (although be warned that was
> > > just a cut-n-paste into this email so it is likely whitespace
> > > damaged).  If you are able to give that a test it would be great, if
> > > not, I can throw it on the todo pile.
> > >
> > > diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_d=
efs.h
> > > index 2b8dfb35caed..12724e259900 100644
> > > --- a/include/linux/lsm_hook_defs.h
> > > +++ b/include/linux/lsm_hook_defs.h
> > > @@ -298,9 +298,9 @@ LSM_HOOK(int, -EOPNOTSUPP, getselfattr, unsigned =
int attr,
> > >         struct lsm_ctx __user *ctx, u32 *size, u32 flags)
> > > LSM_HOOK(int, -EOPNOTSUPP, setselfattr, unsigned int attr,
> > >         struct lsm_ctx *ctx, u32 size, u32 flags)
> > > -LSM_HOOK(int, -EINVAL, getprocattr, struct task_struct *p, const cha=
r *name,
> > > +LSM_HOOK(int, 0, getprocattr, struct task_struct *p, const char *nam=
e,
> > >         char **value)
> > > -LSM_HOOK(int, -EINVAL, setprocattr, const char *name, void *value, s=
ize_t size)
> > > +LSM_HOOK(int, 0, setprocattr, const char *name, void *value, size_t =
size)
> > > LSM_HOOK(int, 0, ismaclabel, const char *name)
> > > LSM_HOOK(int, -EOPNOTSUPP, secid_to_secctx, u32 secid, struct lsm_con=
text *cp)
> > > LSM_HOOK(int, -EOPNOTSUPP, lsmprop_to_secctx, struct lsm_prop *prop,
> >
> > We will test it and report, but this may take some time.
>
> Before trying the full system boot test, I tried to reproducer I posted
> before. With this patch applied (just ensure it's correct) over v6.12.87:
>
> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.=
h
> index 9eca013aa5e1..b38f6194699b 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -288,9 +288,9 @@ LSM_HOOK(int, -EOPNOTSUPP, getselfattr, unsigned int =
attr,
>           struct lsm_ctx __user *ctx, u32 *size, u32 flags)
>  LSM_HOOK(int, -EOPNOTSUPP, setselfattr, unsigned int attr,
>           struct lsm_ctx *ctx, u32 size, u32 flags)
> -LSM_HOOK(int, -EINVAL, getprocattr, struct task_struct *p, const char *n=
ame,
> +LSM_HOOK(int, 0, getprocattr, struct task_struct *p, const char *name,
>           char **value)
> -LSM_HOOK(int, -EINVAL, setprocattr, const char *name, void *value, size_=
t size)
> +LSM_HOOK(int, 0, setprocattr, const char *name, void *value, size_t size=
)
>  LSM_HOOK(int, 0, ismaclabel, const char *name)
>  LSM_HOOK(int, -EOPNOTSUPP, secid_to_secctx, u32 secid, char **secdata,
>           u32 *seclen)
>
> 1. `cat /proc/thread-self/attr/current` does not report `kernel` as befor=
e.
> 2. `echo > /proc/thread-self/attr/fscreate` process hangs in R state, wit=
h strace
> showing infinite loop of
>   write(1, "\n", 1)                       =3D 0
>   write(1, "\n", 1)                       =3D 0
>   write(1, "\n", 1)                       =3D 0

Bummer, I was worried userspace would be expecting something, but wasn't su=
re.

Thanks for giving that a test, it looks like we'll need some special
handling for these hooks (which is okay, you'll see they already have
special handling if you look at the code).  In the meantime the
workaround would be to place the BPF LSM after SELinux in your LSM
ordering.

--=20
paul-moore.com
