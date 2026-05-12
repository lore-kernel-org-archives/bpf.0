Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D37C135A53
	for <bpf@vger.kernel.org>; Tue, 12 May 2026 21:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778621296; cv=pass; b=e2ENSnCEy1LekILN2WeRMNjWSSgpBYYMxGzS0xb/zMHKyGz2rudQ+2y4bAenD6Ap7k2m+DQVBdZmr+nfOXcf8zVaW5O+1ZapNF6HJiNAlaCJ1a0CTjS9BX53/mUGUZMd7sREHK4e/FgPSihCqrSSD+2Q/YzmThJVBcAKn/SR4Oo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778621296; c=relaxed/simple;
	bh=21LBVV1P4gD2k+Z9sRRMdd4+WwOTsiU1kAa8YZ8YOyk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NjzE9lQ8dVj0DQWVkuEAYz0b7Q3S3LLOFOOqBioSbu6VjeCw4+BWgz+DnufRtUN/ugZeApiyWk+tIm6xktR7dNnluUNVkEdoatnnDqn2eefN14VBVLUpNsVNMmBDwV59QwGu56Xgs+FcEQE/m6+GbDdNGKPBA/Z0dvA8QDXV/N0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TM0MY0Ek; arc=pass smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TM0MY0Ek"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-7bf14e33f5bso55571787b3.1
        for <bpf@vger.kernel.org>; Tue, 12 May 2026 14:28:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778621294; cv=none;
        d=google.com; s=arc-20240605;
        b=a61RqX7D7maQ9zwr0oT/Uut4Sz0DpYkD+B8rluZ7NTueRkF2wl2A0Ql1I2nPrES86N
         2Wagx8KiuVdL2d/s8luxKMJGJDWeeh1f/CDkF+JklNFOq4S8EJEzA2r0Pj/Jf64mrUtk
         mW8gnsYHUI7NVphsjOU2B2uGhqo12jai5FjdiIJRmoWIqK+Boh4Z+lNgXC8FYYki7xJC
         4hij5lQxpr4d2XtGwccjB+Pnc9A8Raho5dnpVEdislojPP0Ch38+jEFvja7Hv9TnuVRI
         rdM542952hhxbWJdH8iL/zBNQcej9jWT+toL19trDy8H5MjL4gPQgsuGgZnKsj8UxlzN
         5h/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/XCRpqvCyWSh/CuUPSVyp2FYQA/PwDdIevbENX39xtY=;
        fh=bCoLUvtAu1D3hCyKghQ3VLRStVvdR9Sgh3Xhk/87lZg=;
        b=UbT4kGWiaqNWRyCh1+/qq7yVk4guIcOExMzSIimPZJusHmI2+0Ja7pM8DDIf9jqEft
         3jvqGymQ/NP5FqScMjoUvLsEQ7kogNiTKLN9/nuDcN23Pk1G2psBZwDMPvv0WQbAXWKk
         /bnuKanTBrw3sDbl0SwGb8UwKs/Pqb+m/PXqn51s7v4n6JD9Ko05MuxUZnIRLEm1bZVb
         7xXugGrw+l/sdTPnkfFl07ItMvq0oe62dnQ7iPoWX9W8O7rxvqfOSywePs8xXtqQnHhB
         XpLOtZ/fK55uLeEyrET9YznAv1hgKL7cbZg2F0z0+UCDw9xDFDXhQtskxQJnYuDnI9cL
         xJDQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778621294; x=1779226094; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/XCRpqvCyWSh/CuUPSVyp2FYQA/PwDdIevbENX39xtY=;
        b=TM0MY0EkOWUjg0nQbdQUA6BvLONiWyUDro7GKUozwyligN+WXJHtpnvv6tZagDfnRP
         JeOS1fgZDyg+SahMWs0FDIuwuKn2qxO9oMAvQeVdADRF7TXPCeRb7BzWWIevxLy8TAAD
         HtQjiXNQOy5j34xws6i3gvIQ0DmuEoa7/THs0aXhCY2q7VuFHbw4mD3yO4jGiPm/g3hB
         UnHuBFSh1X3cQTeZemtHXa31jaFHAmVhg3smb9asDXAUKyZINCix88+7hRj1T5K3e6t8
         9H6JQJjK9ySAyChOgHT86mRRT/YiYyfA41m3GJ7GoW7p2uDU4TxlCwuYDF2R7EZEgOBZ
         uZdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778621294; x=1779226094;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/XCRpqvCyWSh/CuUPSVyp2FYQA/PwDdIevbENX39xtY=;
        b=s3Y3+UdGe7eIC3ZCTK+4TG7dMdSH+tbNxjqFvEmNcnXJht921dJZRySXH1RenkDJh4
         WEtrYvWD385o5SuHSzlL/MiejKlBMo1WhLf82FAbrtOJI12NUDg31pKOHQU4IkQ3u0R+
         +oKOMqNqF7Y3Gawf5qe770ZKaxjSELwZc8qOcrdWnBgdl/4ujUns3GERC7LcXDwrfGXN
         x5MX43u4JHkTa+ZC7tanHDnciS/Uz3EBGmlVWAPZG7U6++l4hgoHX7TG/wzt2kTJF6XZ
         Oxkp+a5HyaqMMJ95TRzwUuXHuvU4ib9MlnVmH80LCWIksYXPnNfXqD+S8hNFreC9goeI
         LGGA==
X-Gm-Message-State: AOJu0YyIigndaBvTDVkH1S+Q2KU31tV8N4y/3kPh3+A4Qq6VeS5nUncW
	M1ByW2xkiTKXViILZJdgAzd0iMViXMW7+Jjk+Xb0hLvP67xxlf39x6SE3fc42aA/qGANZNdom4J
	mJ6CVUNHeQVWl5DrV3maaDWPQCQv3Hj0=
X-Gm-Gg: Acq92OF30GZmNK66r06o9mrbBY1Jfl+5+kwUXoZjnTLuGDj1x5FBdF/+X9b5B7jb8Hw
	Xjw+k0rWTROiLsGodlWpg1fnBa6leTNrfT71CYxWlBeEZYtZcjjbz4+IYnANafP6MX6sqmDF0ZX
	8F0X6OaGlyyR/4tdAdFbdmbHwmUHnYUlZ6/W1R3VX9o6Pc/V0v5B5CSpBy+HO7v9F+YEyUmXd8G
	8f2bcRXZ7dD6yktyzHdwWW9JtmOKk112ZbsxlJRxf7vC2KvmIcNf0e+ruNMGd6Sfrj5Z2AFcpat
	KinKWhbDdeyjOrZNonChcts=
X-Received: by 2002:a05:690c:ec9:b0:7b2:7dc9:360e with SMTP id
 00721157ae682-7c6a64272cfmr7436117b3.0.1778621294144; Tue, 12 May 2026
 14:28:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260506142709.2298255-1-ameryhung@gmail.com> <20260506142709.2298255-8-ameryhung@gmail.com>
 <23140ed4c48babfa8af91f3b67f379773bdc04c1.camel@gmail.com>
 <CAMB2axM8hR=OVqbkbTMJw_ej2pfnEm9Cm-quuoFPqsVhmJxO0g@mail.gmail.com> <701f9924ff6d13cf948c4ce4527eb866a26950e2.camel@gmail.com>
In-Reply-To: <701f9924ff6d13cf948c4ce4527eb866a26950e2.camel@gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Tue, 12 May 2026 23:27:59 +0200
X-Gm-Features: AVHnY4I8zXbLo124_0hoTCIR87mCYE_vVz86xXIvUSAf6JMnpPU94tv_fvbGDbQ
Message-ID: <CAMB2axOsnVj=PBuMU8utqKsSj7DsVhWNi9Vddytx6BKfFGs0JQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 07/12] bpf: Unify referenced object tracking
 in verifier
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, memxor@gmail.com, 
	martin.lau@kernel.org, mykyta.yatsenko5@gmail.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 12, 2026 at 2:09=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Tue, 2026-05-12 at 22:37 +0200, Amery Hung wrote:
> > On Tue, May 12, 2026 at 12:04=E2=80=AFPM Eduard Zingerman <eddyz87@gmai=
l.com> wrote:
> > >
> > > On Wed, 2026-05-06 at 07:27 -0700, Amery Hung wrote:
> > >
> > > LGTM, a nit below.
> > >
> > > [...]
> > >
> > > > @@ -8028,14 +8024,13 @@ static int check_func_arg(struct bpf_verifi=
er_env *env, u32 arg,
> > > >       }
> > > >
> > > >       if (reg->ref_obj_id && base_type(arg_type) !=3D ARG_KPTR_XCHG=
_DEST) {
> > > > -             if (meta->ref_obj_id) {
> > > > -                     verbose(env, "more than one arg with ref_obj_=
id R%d %u %u",
> > > > -                             regno, reg->ref_obj_id,
> > > > -                             meta->ref_obj_id);
> > > > +             if (meta->release_regno && meta->ref_obj.cnt) {
> > > > +                     verbose(env, "more than one arg with ref_obj_=
id %s %u %u",
> > > > +                             reg_arg_name(env, argno), reg->ref_ob=
j_id,
> > > > +                             meta->ref_obj.ref_obj_id);
> > >
> > > I think this should be reported from update_ref_obj() itself,
> > > it is more consistent logically and also avoids reporting code
> > > duplication in check_kfunc_args() and check_kfunc_call().
> > > Also, technically the reg_arg_name() is an independent fix.
> >
> > We have kfuncs that have more than one ref_obj. This is not a problem
> > unless ref_obj is referenced in the verification and is ambiguous
> > (e.g., used it to tie the lifetime of the allocated memory with
> > ref_obj). Therefore, it is kept at the location of use instead of
> > update_ref_obj() to prevent breaking existing kfuncs.
>
> Ack, thank you for explaining.
>
> > >
> > > > Drop the selftest introduced in 7ec899ac90a2 (=E2=80=9Cselftests/bp=
f: Negative
> > > > test case for ref_obj_id in args=E2=80=9D) since the verifier no lo=
nger
> > > > complains about ambiguous ref_obj if it is not used.
> > >
> > > On the other hand, if you think that this property is worth having,
> > > then maybe wrap the check with in some utility function?
> >
> > A utility function like below makes sense if we fold ref_obj_id into
> > id. It would be too cumbersome for v3 as we may need two of this for
> > ref_obj->ref_obj_id and ref_obj->id.
> >
> > static int get_ref_obj_id()
> > {
> >         if (ref_obj->cnt > 1) {
> >                 verifier_bug(env, "function expects only one
> > referenced object but got %d\n", ref_obj->cnt);
> >                 return -EFAULT;
> >         }
> >         return ref_obj->id;
> > }
>
> Maybe just like this:
>
>   static void validate_ref_obj(struct ref_obj_desc *d) { ... }
>

Do you mean:
static int validate_ref_obj(struct ref_obj_desc *d) { ... }

Then to use it:
err =3D validate_ref_obj(meta.ref_obj);
if (err)
        return err;

regs[BPF_REG_0].ref_obj_id =3D meta.ref_obj.ref_obj_id;

> ?
