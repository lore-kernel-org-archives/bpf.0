Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F23737BE83
	for <bpf@vger.kernel.org>; Sun,  2 Aug 2026 21:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785705443; cv=pass; b=PLhS6fBtWoH3jur01/CQG49OYyObGTvAMD/CmZzvvTzzzaZ1pHECZO5Uk2YVyqYlmV+evMxb2gpEgMNVVCIa4cFdUgZRpZo5nuXkpWCz/8X+EiKIvDxTnOsLtixalTnYs/0lbATU76S5Ln1Qs0SuuJ/47z4uTmM+6QAeSzDtHGs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785705443; c=relaxed/simple;
	bh=g4IWA26zx0bHnq3hh34jBR4BuCV9r2Uy61AF0oiLWC0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zi1SBtrf61MUWSI6iBgHyt4iOMKrSU31V+nX1PE7gsI5kBZO+YehKx7ns4GtZ1ZEtCuRZv7qVoKVkJO6IjctdjdnKhSkv57aM+eg+QwK/ubC8aVCHOFqDV42wJrn504A+HDfA+BRqG506QATWzVLC2l2FFEjbwhHS/uo4FoTq9I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cZigfxU1; arc=pass smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cZigfxU1"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-80e24970f1dso18610257b3.0
        for <bpf@vger.kernel.org>; Sun, 02 Aug 2026 14:17:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785705433; cv=none;
        d=google.com; s=arc-20260327;
        b=E6IClMxXKqaum9D/ZI4taY1PjHwwC9kaCq1jqVElSAsb/BWXhvPCqlJ6CdO6s4YTTa
         L6Ys1WQyaYOzxe70/fq3r25Tp+NkEsNlMmmnQhV5U5kZxpdf1Ck8vw/D1cLZMm1AY+HU
         r+q90yRHGSzxLqlu0O0HiR9votxkwsqEMtB8cTUwRqETVKDLR/0s5CzvbpK4AQQwYm8k
         Yg5XZzTmWK0EcS7sgFf14TRFPmq7y8Zwzz+q72AMD1NLQ8mews2bz9M7XoohTqOsuVr9
         kjnmXHJGI2a1HL8f4F7j3AZBORnhIDAcx8DITk3wLik49FOG5DEoMwMgjZr+ML9y/yUP
         pFRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zFSmz8MhaD6rw0nUEtZ2eNIsd9/R8mrR1PriLE2pH+w=;
        fh=uA360uvxR9S0K/Y4Lovo7aIaGlBwzVBnnb2BKWupr/4=;
        b=Qe2XNWS+XgU50VDSH05MGZbuINayngxjoW/SBooUi4XVwKD6EWT9JtiC/tvyBcJ/IE
         6QBC5fN6Xq2iggoza8jt1Q7qHho0cAZRDsO5Rz39PcAuxREJI5qvj+Y47GLrlYsPYDsZ
         yTvD5tmJktDQ3fd/A/3XHKNyf3QEQFP84Kze1Y1Nl4l4V+mSwqRUe9L+x2eoG8SxErww
         1aDrjVZZSmc/x4K0Cli/NZj0HxiU5e3lZq3q3Z/KQh7vSW83bFiLGd+eV2sbwTc+VZPD
         cL9iwZnhP+80Jc9e8WKnkwfvexNO5NVKJJQeOybRCPVG6vOkH6RSFWcu1FSDu6z6NEMV
         xzZQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785705433; x=1786310233; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zFSmz8MhaD6rw0nUEtZ2eNIsd9/R8mrR1PriLE2pH+w=;
        b=cZigfxU14rLJ/WlwCrNIGIgB345k/NGgXyTPCpzIq4j3NvzL1xT5D/BixW5TwoYRAT
         77dxnbX2YePJCAhxMGAiJKBH6G6e/RrJnd5Nn7DPjyFrjJaP1HSNY2snwIZXy6q9cdbh
         RuPNVO6gW03p9I7mCtf1t6/WBsutaOAndfNUpD5nBV95JF1S2iiYQYBT9uGKInk+5isK
         Swi5ziJ60nW8AsxJFSzFF6pm+xi+TKZjP0ovAljQMYjBpofyG7D+P17qiGIDIiTTBfuZ
         EMQ9cTRM0QQTiD5BoPYtL5KW4mRcqVqmknHIVPkPrDK7VQ27LB+oLFufzNl8WnzaQOeN
         gX8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785705433; x=1786310233;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zFSmz8MhaD6rw0nUEtZ2eNIsd9/R8mrR1PriLE2pH+w=;
        b=i0uiNnxN5Di0g2Pd+kL3qzgCfEGxqEv6l2f4ZYq6m13O4aHfcCuE45DFtrkE8gr8lf
         PFNgOpFSRK5bYddKPnYYaexqcKov5nJmvevn73AqTZvYJG3vjeq7s0P2mR7cOZxAGrl7
         5Izun6I7D1ffqQ8SNUOeoMj6A8Hs4D0kuVAC4n2oOSWUJIk67G5CtT5Yw29vngAfsacB
         vRsZPOC4EdWcMuZcaf1VQQelXKWI5gYFoGYvDnSKYMCVSf93hN+nzrhYO4Egl8OVgmci
         JfZQtFaq7Vch9tr7r2KvGg5LL6Nd+q5a5RMMwpT3G+DZLYi4y46JYi7IYIZqS8hRI0un
         ACLw==
X-Gm-Message-State: AOJu0Yy5k11etqUihjI0EKyipOzc+41AIFOH9euuAnCl7m4yQig2x+Oo
	wTOyWwHY7f5Lz865sQncUBZNVXt+tlf/1BSPuf0BuDGhgadMG8oi3nCDwPM+CAovmnxlAy3llkY
	Ol72/cZlvOS+y0u4NR58rwaxngocxP8zO3K89
X-Gm-Gg: AR+sD10+fztrp/BRNI+mZ76ewgVbP/BpWxLfeSoI/MXbJVNpsHe7/gNzIFKqPWT2y91
	7m3ki5FTQU9lUHHs0UwqeVH/00WUOPapaCutGEbFY4yVmknZzIHiA1RWmkqkx+gldMhxwaU84UT
	ONKWEeJ5Gxk0f+onzlge7b+ohhoPqQM4+4S61po26TlauQr1ka2ddmklyrb/odKljr6h9mg2/0D
	cIiPaYx107Z36hz/AgB5/x6QpD+BqdjnL8/HOG7ZMikoI6tLY0hzXHRo4mn8VxVW1X5qRmXH1RQ
	521rOA1b0QNc0ZseysAg5CJfHc2dEYP6tpG5KjI8hBnuyQ==
X-Received: by 2002:a05:690c:6012:b0:81d:e7d2:a46d with SMTP id
 00721157ae682-81fd49b4b75mr106198867b3.5.1785705432922; Sun, 02 Aug 2026
 14:17:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260801074633.1595644-1-ameryhung@gmail.com> <20260801074633.1595644-16-ameryhung@gmail.com>
 <20260801082246.17FB41F00AC4@smtp.kernel.org>
In-Reply-To: <20260801082246.17FB41F00AC4@smtp.kernel.org>
From: Amery Hung <ameryhung@gmail.com>
Date: Sun, 2 Aug 2026 14:17:01 -0700
X-Gm-Features: AUfX_mwqin35OOhhJi4HSRb-zRXAQeOE2bagBf40buMwDEnUQ6iYIq0e4QK1WXA
Message-ID: <CAMB2axMVAk70e8ktN6_kr_8Y6N1yV8gTfJ4JyhDooGwg46j19w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 15/18] bpf: Classify kfunc pointer arguments
 from BTF, resolve type against the register
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 1, 2026 at 1:22=E2=80=AFAM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] Allowing PTR_TO_BTF_ID as a KF_ARG_PTR_TO_MEM argument is eith=
er broken or fundamentally unsafe due to unvalidated access flags.
> --
>
> --- Patch [15]: [PATCH bpf-next v3 15/18] bpf: Classify kfunc pointer arg=
uments from BTF, resolve type against the register ---
> commit d5adf1f80d7ac5827091492c5099bcb0c05e15d1
> Author: Amery Hung <ameryhung@gmail.com>
>
> bpf: Classify kfunc pointer arguments from BTF, resolve type against the =
register
>
> This commit changes kfunc pointer argument classification to rely strictl=
y
> on BTF rather than register state. It introduces support for passing a
> PTR_TO_BTF_ID as a fixed-size memory buffer when pointing to a scalar str=
uct.
>
> >     The new design now accepts one previously rejected case: passing
> >     PTR_TO_BTF_ID to a pointer to scalar w/o a following __sz/__szk. Th=
e
> >     argument will be classified as KF_ARG_PTR_TO_MEM | MEM_FIXED_SIZE. =
The
> >     PTR_TO_BTF_ID register will go through check_mem_reg() ->
> >     check_helper_mem_access() -> check_ptr_to_btf_access(), and by defa=
ult only
> >     read is allowed.
>
> [Severity: Medium]
> Will this newly accepted case always fail verification?
>
> While the commit message states that "by default only read is allowed,"
> the call to check_mem_reg() for KF_ARG_PTR_TO_MEM arguments
> unconditionally demands BPF_READ | BPF_WRITE access. This causes
> check_ptr_to_btf_access() to reject standard kernel pointers with -EACCES=
.

I see the problem in my wording. So it should be:

For a pointer to scalar arg, a kernel btf id will be rejected unless
explicitly granted by btf_struct_access(); a program allocated btf id
will be allowed.

>
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 1ccf3b764c515..9045369ba5694 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -11405,37 +11414,37 @@ get_kfunc_ptr_arg_type(struct bpf_verifier_en=
v *env,
> [ ... ]
> > -     /* This is the catch all argument type of register types supporte=
d by
> > -      * check_helper_mem_access. However, we only allow when argument =
type is
> > -      * pointer to scalar, or struct composed (recursively) of scalars=
. When
> > -      * arg_mem_size is true, the pointer can be void *.
> > +     /* A pointer to a struct without a size argument is classified as=
 KF_ARG_PTR_TO_BTF_ID */
> > +     if (btf_type_is_struct(ref_t))
> > +             return KF_ARG_PTR_TO_BTF_ID;
> > +
> > +     /*
> > +      * Otherwise this is a fixed-size memory buffer supported by
> > +      * check_helper_mem_access(): a pointer to a scalar or a struct o=
f
> > +      * scalars. The access size is derived from the pointed-to BTF ty=
pe.
> >        */
> > -     if (!btf_type_is_scalar(ref_t) && !__btf_type_is_scalar_struct(en=
v, meta->btf, ref_t, 0) &&
> > -         (arg_mem_size ? !btf_type_is_void(ref_t) : 1)) {
> > -             verbose(env, "%s pointer type %s %s must point to %sscala=
r, or struct with scalar\n",
> > -                     reg_arg_name(env, argno),
> > -                     btf_type_str(ref_t), ref_tname, arg_mem_size ? "v=
oid, " : "");
> > +     if (!btf_type_is_scalar(ref_t) &&
> > +         !__btf_type_is_scalar_struct(env, meta->btf, ref_t, 0)) {
> > +             verbose(env, "%s pointer type %s %s must point to scalar,=
 or struct with scalar\n",
> > +                     reg_arg_name(env, argno), btf_type_str(ref_t), re=
f_tname);
> >               return -EINVAL;
> >       }
> > -     return arg_mem_size ? KF_ARG_PTR_TO_MEM : KF_ARG_PTR_TO_MEM | MEM=
_FIXED_SIZE;
> > +     return KF_ARG_PTR_TO_MEM | MEM_FIXED_SIZE;
> >  }
>
> [Severity: Medium]
> When get_kfunc_ptr_arg_type() returns KF_ARG_PTR_TO_MEM | MEM_FIXED_SIZE =
for
> a PTR_TO_BTF_ID, or when check_kfunc_args() falls through to KF_ARG_PTR_T=
O_MEM,
> it verifies the argument as a memory buffer:
>
> kernel/bpf/verifier.c:check_kfunc_args() {
>     ...
>                 case KF_ARG_PTR_TO_MEM:
>                         if (kf_arg_type & MEM_FIXED_SIZE) {
>                                 resolve_ret =3D btf_resolve_size(btf, ref=
_t, &type_size);
>                 ...
>                                 ret =3D check_mem_reg(env, reg, argno, ty=
pe_size, BPF_READ | BPF_WRITE, meta);
>     ...
> }
>
> Because check_mem_reg() is passed BPF_READ | BPF_WRITE, it requires write
> access. When this goes through check_helper_mem_access() and reaches
> check_ptr_to_btf_access(), it will be rejected because atype !=3D BPF_REA=
D:
>
> kernel/bpf/verifier.c:check_ptr_to_btf_access() {
>     ...
>                 if (atype !=3D BPF_READ && !type_is_ptr_alloc_obj(reg->ty=
pe)) {
>                         verbose(env, "only read is supported\n");
>                         return -EACCES;
>                 }
>     ...
> }
>
> Could this unconditionally break the newly introduced feature for standar=
d
> (non-allocated) kernel pointers? Also, if the BPF_READ | BPF_WRITE flag w=
ere
> simply changed to BPF_READ to pass verification, could it introduce a
> vulnerability since the verifier cannot guarantee that the underlying kfu=
nc
> will not write to the buffer?
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260801074633.15=
95644-1-ameryhung@gmail.com?part=3D15
