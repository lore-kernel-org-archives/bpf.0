Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E005372051
	for <bpf@vger.kernel.org>; Tue, 12 May 2026 20:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778618271; cv=pass; b=I4LJ1lDKUOIKQoplL4+fA3deRrJeWkK7e/TIQqrcGQWeS4WFhfV1EJh+YE+6kHeqRCyCXCR38APeF3ywxNypuq/TvRy7jPNDR5X+5sg0l/f2MLh1GRPCV5q1L9IfjS+3aa8l4roXCmnF9lS9yhQHFIUVdpC2zbwqVJdOlxALJRc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778618271; c=relaxed/simple;
	bh=INKRh2r5TxtEA0CusznPy9TbIEWkCxEu7I/5d62aR5s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cp2hKiIIju+0XjXpsb9tg8I6II9Ae1Wm9j85W7cGX6JAh4mVl+yTO9WHWwioe0noQK0DEW/kyRQXdVqqAdkb91nn33UzzSmgkOmTrFeG10Mg2IVzsV0IZqpGfwMxAVTxiBbMH3XQWEgDkZRC7U3XTh/6V8aJN3BEHlYCVCVY4v4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=akbh/fBo; arc=pass smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="akbh/fBo"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-7c0dea734b8so33532687b3.3
        for <bpf@vger.kernel.org>; Tue, 12 May 2026 13:37:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778618269; cv=none;
        d=google.com; s=arc-20240605;
        b=Wfb+e+oSouPK05f+2cMSrFB2VlUPdIJGfHjHDGJIjjPJ2ZpEkRG2UX1zd3F6jDRPZ7
         mZAVIDibqJKbvIzxDiL0u2Sh95b/ZU/j4tr4aZgSTwmBI/WVCL9tBL7l+Vt3ct3xqNdu
         GNjz3oTL/fVTpSkhtGjcI0xSNKaPOW7H4MuGed0IpQteRm+VjeInLoJ4TGU2JnQC3VJL
         HSef1Kt0HLKC8XzCTmXDBBSyo9c38BtDod4P+crwMPpMHOHMFDerEKwh4T9pIoOAVDZo
         /syXLRDRHcSHP8O4MPdKLbyxhYfxDoR1e9aQ2sFJ7WhpCr3Lrh+zPYEIPeZxl7MpZKf7
         4ubg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aQcZV7DJIyQpUIFVZVp01UmNF7qQBH5otnKV69pByp0=;
        fh=bCoLUvtAu1D3hCyKghQ3VLRStVvdR9Sgh3Xhk/87lZg=;
        b=NXpRxif63TNF8UXAOpZIyapGqWuLuysapOz0DnCsu10o5bhnH6P+N86Ii8QoVdY/Eg
         RA9cv75ctVC40DPLTuHr08FEQWE8SiyiS+SghbIY01PbK4dH3Tp2z1SujOIfx3CrnIwo
         BZCBft4Nl1Y6xZ+UugQbSYT55SZVnQwyIpaTD75XXgxo7i3P6gOQalXeLNEeIGrt66Iu
         QLa/10rfqQHVADVulFwL4rDWwQGcU+UpMF4IlPN7yTWzSqKpv6G4iNUBeFKLgI7ilc1F
         ClylAz0hD3ajwEyfjlYO2dA4iLJKxOsaeJMHCc03j+aOyTK4r/puYMfKRkIVk7YsBHzC
         6JKQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778618269; x=1779223069; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aQcZV7DJIyQpUIFVZVp01UmNF7qQBH5otnKV69pByp0=;
        b=akbh/fBoxxD0OISH3XkwXyu0apo/saYneCSbCr1gaZtaWHMJvYYR+IoRL8uHNdsgPO
         KpWTC/ip6FaW6r937AHlpWG0pxqDXae7lNZsqcYNIgYIUpXshdILjoP6U1j7KQiqVt6V
         jVpM8+hTJd9dKps+mshn42xMv3KLuh4+Synm3tpNN034zoAkSdc6HLozSYoREO9TFWj0
         dgDUzw09x+9YayfZes+XL+nUwBJnosYH1lL2HTaOXLygSL5HJl1GiZNPKNFoBl3lsSYy
         4bKRsH+uzFmTz7y6/7xWYehNWHyyIYGZpnCysO7ttE7UmwKzkK6I0K9jcXzDfF2QgIBQ
         tWeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778618269; x=1779223069;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aQcZV7DJIyQpUIFVZVp01UmNF7qQBH5otnKV69pByp0=;
        b=mr5i74FslraRWn+xO9Wilzbi2ufTCcVbFGvaqQBz0E+avL0QDBzRwuDhAu6MfvvABK
         MZnHI9pudAPf7n+cr76FsFhtcbPBpmsYOrs/VmsDOtj/xQSrBijTdSY6QvULOl2n1bJt
         gP8cqwjXenbRgWL3m1pHVTZZEcnLnx1cLHrVZexjVxqGSaSnLkfeU+7z1Bjj03VnTBCt
         ho0JQ4vjfIr/3i+RZPY5vCnV+qILWbwVMQTHIi84lg90mvpRx1SPFoBIp+vTcoeb5RwP
         CO57hX2i4aY9PUfmK/AGXU2FD+DlYhreFzr1dfKRbdjUUc1QJtxPCPi0Q6SFhMTvRXci
         cl3Q==
X-Gm-Message-State: AOJu0Yxbl4qSiLd2WzrsZTa0gAOQ8popuwCxCa75ncscfxvUKZTbD97t
	8L9YwF7mUvv0Uvdqht11g9m1EBaXbpfJZdx+u8pE2A3kBaAOwRq/rEkgjm0iYFHB9g18Cli3yV/
	AbJ5zVYDyHpxuLBp4zlXR3/rV94Rt7Ds=
X-Gm-Gg: Acq92OGnises9fKqeHGuW5jeOO/26I5F+6iqUO40CJrdjFyHcy9C0SVVldrE/YUJiMi
	pOFjx77Gvv71SdmTnQDZST9mMeMtuJB3caUKbgRLpI7SeAvW8UFhbE+r/LM3Q1cboXeAhmvmv+B
	osCZzkdmq8gdiY/k8V/tZMzt7jDq8ZW7Vw14acJIWxGqqvWJulmr8VJzzxE0IYsQaKNxfw2ZnEB
	JU9tl4Qw0e9Viz2U44CQ2hhbCgohT5qwQ+z0l0mmsd7XNV1leQNoMKZGNCzmpNWca3Qxu0h83lg
	FbUlTrd4BAhV07khdLY6ga8=
X-Received: by 2002:a05:690c:660f:b0:7b7:5f48:d9aa with SMTP id
 00721157ae682-7c6ad761263mr4513107b3.50.1778618269545; Tue, 12 May 2026
 13:37:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260506142709.2298255-1-ameryhung@gmail.com> <20260506142709.2298255-8-ameryhung@gmail.com>
 <23140ed4c48babfa8af91f3b67f379773bdc04c1.camel@gmail.com>
In-Reply-To: <23140ed4c48babfa8af91f3b67f379773bdc04c1.camel@gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Tue, 12 May 2026 22:37:36 +0200
X-Gm-Features: AVHnY4KnwsBMhnS_vPcREhSf-Ap5IvPHQJczvldmbXJF_pKdl5DnYDe8W042Crg
Message-ID: <CAMB2axM8hR=OVqbkbTMJw_ej2pfnEm9Cm-quuoFPqsVhmJxO0g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 07/12] bpf: Unify referenced object tracking
 in verifier
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, memxor@gmail.com, 
	martin.lau@kernel.org, mykyta.yatsenko5@gmail.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 12, 2026 at 12:04=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
>
> On Wed, 2026-05-06 at 07:27 -0700, Amery Hung wrote:
>
> LGTM, a nit below.
>
> [...]
>
> > @@ -8028,14 +8024,13 @@ static int check_func_arg(struct bpf_verifier_e=
nv *env, u32 arg,
> >       }
> >
> >       if (reg->ref_obj_id && base_type(arg_type) !=3D ARG_KPTR_XCHG_DES=
T) {
> > -             if (meta->ref_obj_id) {
> > -                     verbose(env, "more than one arg with ref_obj_id R=
%d %u %u",
> > -                             regno, reg->ref_obj_id,
> > -                             meta->ref_obj_id);
> > +             if (meta->release_regno && meta->ref_obj.cnt) {
> > +                     verbose(env, "more than one arg with ref_obj_id %=
s %u %u",
> > +                             reg_arg_name(env, argno), reg->ref_obj_id=
,
> > +                             meta->ref_obj.ref_obj_id);
>
> I think this should be reported from update_ref_obj() itself,
> it is more consistent logically and also avoids reporting code
> duplication in check_kfunc_args() and check_kfunc_call().
> Also, technically the reg_arg_name() is an independent fix.

We have kfuncs that have more than one ref_obj. This is not a problem
unless ref_obj is referenced in the verification and is ambiguous
(e.g., used it to tie the lifetime of the allocated memory with
ref_obj). Therefore, it is kept at the location of use instead of
update_ref_obj() to prevent breaking existing kfuncs.

>
> > Drop the selftest introduced in 7ec899ac90a2 (=E2=80=9Cselftests/bpf: N=
egative
> > test case for ref_obj_id in args=E2=80=9D) since the verifier no longer
> > complains about ambiguous ref_obj if it is not used.
>
> On the other hand, if you think that this property is worth having,
> then maybe wrap the check with in some utility function?

A utility function like below makes sense if we fold ref_obj_id into
id. It would be too cumbersome for v3 as we may need two of this for
ref_obj->ref_obj_id and ref_obj->id.

static int get_ref_obj_id()
{
        if (ref_obj->cnt > 1) {
                verifier_bug(env, "function expects only one
referenced object but got %d\n", ref_obj->cnt);
                return -EFAULT;
        }
        return ref_obj->id;
}

>
> >                       return -EACCES;
> >               }
> > -             meta->ref_obj_id =3D reg->ref_obj_id;
> > -             meta->id =3D reg->id;
> > +             update_ref_obj(&meta->ref_obj, reg);
> >       }
> >
> >       switch (base_type(arg_type)) {
>
> [...]
