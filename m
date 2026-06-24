Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0473876CF
	for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 07:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782286936; cv=pass; b=dIsmwL6NFlTwscvPnVUfR9NqsSdk53yeTnjziCz0edX09kds9pKUe7+IXmHDl7Au/roPbenw94WlVyUIi6Ak3Oz35f4T7FS1V2g0eArk9Ky5LLC/+eUb0svKy8f7MyzZr0/xMAukIUK+XWbjYbyIkMbXNulFixySdL+Avu9qilU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782286936; c=relaxed/simple;
	bh=QR4Wy0tL8cCx/yg2BbocD46eH1jIHB4yYuylS36en84=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bKXyCl9djZ+UjyqBdBeoEmTzcPBfBZuR2CyY860utJbv+o6F9RDfgyJfz4CYGBrcmsTCI1+fy2qrAuTktm5yDgeP2cf7t0p3TGiW7rvDCdaM0Un36kXJtI5Q9t8Ohi4HnP3RxwJCaEN2ZocHUAj/xPrYeucPqelFyl/5bRSpCw8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gSFzCiXz; arc=pass smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gSFzCiXz"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-8041a8fd711so25323047b3.1
        for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 00:42:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782286931; cv=none;
        d=google.com; s=arc-20260327;
        b=r3ZG6APVGtbRHp56d15poj/YLEX4Gc2aXzMi7QHc5dne77bkifcAkHLQ2eZpXLu2OS
         h5DIHi8es0H/kEDluFVFKnfig+B3QO8rz+j+8/u39ZmSCgyYrqnzW7Fm49gq2bMWpetn
         u+WSWPJz9sSygU+yrNaww87za/u70ZFsn9TH5jaMvqN14hBGeo6aFHctNrM3JDxU2UIB
         HmtQuySteoBzwhza808EiUVUSe4MuAEBRhJgrM6OA5uoZCoJJlgqDmQFb07pQqXPM20U
         gXfsmLmUU0ximBrQm0pxjb9ylmGsXMl1Gm0tRuNbDUC9WYS97V9p69T0GslB7o//LU7X
         rXVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0+yTRolSITyDjcXP+5W2UVcOpjVAsvKMU8I2YD9YKI0=;
        fh=uA360uvxR9S0K/Y4Lovo7aIaGlBwzVBnnb2BKWupr/4=;
        b=Lfg2wFdYcQxRKlyyk3dov07XtLel2ApMNnikBsL2ewbA4N9gnNefZIqnJBEccbDY3X
         WWfKgNXNqp33oH90Rd5iCpprpRUZMEPslBMOKJtbzSY/1xeNAldFi7X68MiGS2KML9WE
         oI31GZskzmfh1hqf5UkgrA4QA1UY/nGf/czjXYJcUK/37QnTEik+CICog0+rhsWW/zNA
         o2TmZapNF9eKYSNryIKFHcXi8s14/ZOWaUF+w2MBInwb6YMmPClEpfqmDOecKFa3bgh+
         nsIpNCVzJHuIc44L23k95If0YwdMY1kMb1NQVX2jEBC5tiZol7Ko7kr0ExkxzTzXQ+Q6
         /vAg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782286931; x=1782891731; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0+yTRolSITyDjcXP+5W2UVcOpjVAsvKMU8I2YD9YKI0=;
        b=gSFzCiXz+teHKhXH0zs2Reguikj8B+X5KwBCw2Fdg3W3eUvJXG5b7E1b1794psXqLR
         F53e1kTt9MjHgrEePFm1LNum22lZDrLyVOgxq1Qb25pGF3M5NxrnR8DgeSkdhQVsalkp
         ZBHoWOOe1KniCuwd6pYLL9vm6lAcfwBuZMJ3yxDQdBllxTxKxv9uiRAvtEtFzLVOH0Jn
         Cb9sCJOKk9P+9dUBeWUkS7GRiwOZUBr95CYE5qUjZuGzk+RPMW11G7Ben0YTfEEXPWr5
         uN8smRVWN4EOwEPoNu5AgvuIluF/dscgAYroZ41qwNSfGlDcVV4DohBQgk7YImCuQfge
         DtDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782286931; x=1782891731;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0+yTRolSITyDjcXP+5W2UVcOpjVAsvKMU8I2YD9YKI0=;
        b=TbPrYww1f7hV8uHsHwuCSH3N314XpopJ9qtY46DLxVtJmRCd+hOzNsA/6frwOD4ZRc
         xyVzBvsv2GaO3O1p55MDWOysbOrJFmSS6aDB5N4+gQB2LJXM/oV6RpZqBvRP3RkJep2r
         9HIOOoSlei/r+ZSPua4G0HN73/OPj/gVdBE8OMJ7GFPGV68rQGlJ92n/SfuiM15+99Ll
         EwHbHdj7c1QHSqGdjjaM9sKeKyToJR/yFt/fuXcQ5vBb9pWLTrI+tlroSffyioOO8GPz
         s/RZ717j+2vFjWlejolGCU6/VuCvGOVWob0vJrwh4i6iMjv+mshG4ZKQC629oRnErzI9
         n9LA==
X-Gm-Message-State: AOJu0YwbQEpkFocQ443na4inLO5m/fevQiLOaV44K8Ka0Z8rNXALC/fQ
	Q2b2GnglzmvaffOj2mAF617Ytlat8AeCKhFvtGtr1O/CHAKhLz1oPzAW8CPPGtCR7FksPRyPkNV
	DIdzYwR2HXpTvyMYwafbqjCkIkFDGzh350cZpfARQwk/y
X-Gm-Gg: AfdE7cnilQpVoYmpd7trh3W8vS99QVAX0rpnrUdaWrLrWM8SQDpqoNNRDGmu9AjkbaQ
	YF4qiDU7+QVaRNDSvuCvuGMV0Dk4D3xjnksc6fAaIWttpUAfLSIyWGvby1ftDD6GAJHw0aFHM1q
	6WGa7lluuZ270EGSqztnmfcU/9KcFLYEc7BXYJpUdiVR3RfuO/U4Kxrpcr0V+lQ2w+2a05Rfmlm
	Li5igQ8KR8ArVVGN1tnI8UcbsH8CyJyZba9CqQLvxMxNKLMVfCCMjcD1RAeCGkJtPni5ZNnMpP3
	3GqjfXB7fjW/0G5MYsNgGcfa9OrI8+95Hek9IMmD
X-Received: by 2002:a05:690c:660b:b0:7b1:9036:a23a with SMTP id
 00721157ae682-80672115b07mr70122167b3.14.1782286931474; Wed, 24 Jun 2026
 00:42:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260624072031.735846-1-sun.jian.kdev@gmail.com> <20260624073738.86F361F000E9@smtp.kernel.org>
In-Reply-To: <20260624073738.86F361F000E9@smtp.kernel.org>
From: sun jian <sun.jian.kdev@gmail.com>
Date: Wed, 24 Jun 2026 15:41:58 +0800
X-Gm-Features: AVVi8CeAGESJLiZKG7OzP6_ac3ToJrHzDDedwPDcUfl7iYoO0CEiUoore4N-_u4
Message-ID: <CABFUUZFSwaQoq6_uRA0qwsuSO7hxfvyn9jmD-i-iUer7QZ_eSQ@mail.gmail.com>
Subject: Re: [PATCH bpf 1/2] bpf: Avoid eliding lookup NULLness for inner map templates
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 24, 2026 at 3:37=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
>
> Pre-existing issues:
> - [Critical] The patch relies on the `BPF_F_INNER_MAP` flag to prevent un=
safe NULL-check elision for inner map templates. However, this fix is funda=
mentally incomplete because `BPF_MAP_TYPE_PERCPU_ARRAY` explicitly rejects =
the `BPF_F_INNER_MAP` flag during creation. This leaves per-CPU arrays vuln=
erable to out-of-bounds memory accesses and NULL pointer dereferences.
> --
>
> commit 3ab30507af620d9da556d3b2d80a1f172474785b
> Author: Sun Jian <sun.jian.kdev@gmail.com>
>
> bpf: Avoid eliding lookup NULLness for inner map templates
>
> This commit prevents the verifier from eliding NULLness checks for array =
maps
> used as inner map templates. It achieves this by requiring that the
> BPF_F_INNER_MAP flag is not set on the map before clearing the PTR_MAYBE_=
NULL
> flag from the register.
>
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 69d75515ed3f7..a32704bb5e058 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -10577,6 +10577,7 @@ static int check_helper_call(struct bpf_verifie=
r_env *env, struct bpf_insn *insn
> >
> >               if (func_id =3D=3D BPF_FUNC_map_lookup_elem &&
> >                   can_elide_value_nullness(meta.map.ptr->map_type) &&
> > +                 !(meta.map.ptr->map_flags & BPF_F_INNER_MAP) &&
>
> [Severity: Critical]
> This isn't a bug introduced by this patch, but does this check completely
> prevent NULL-check elision for all inner map templates?
>
> Looking at can_elide_value_nullness(), it allows both BPF_MAP_TYPE_ARRAY
> and BPF_MAP_TYPE_PERCPU_ARRAY.
>
> However, in array_map_alloc_check(), the BPF_F_INNER_MAP flag is
> explicitly rejected for per-CPU arrays:
>
> kernel/bpf/arraymap.c:array_map_alloc_check() {
>     if (attr->map_type !=3D BPF_MAP_TYPE_ARRAY &&
>         attr->map_flags & (BPF_F_MMAPABLE | BPF_F_INNER_MAP))
>         return -EINVAL;
>     ...
> }
>
> Since BPF_MAP_TYPE_PERCPU_ARRAY can never have the BPF_F_INNER_MAP flag
> set, won't this allow the verifier to still incorrectly elide NULLness
> checks for per-CPU arrays used as inner map templates?
>
> If a per-CPU array with a large max_entries is used as an inner map
> template, and a concrete map with a smaller max_entries is inserted at
> runtime (which is possible because percpu_array_map_ops.map_meta_equal us=
es
> bpf_map_meta_equal() which ignores max_entries checks), couldn't this
> lead to an out-of-bounds access or NULL pointer dereference?
>
> Additionally, since percpu_array_map_gen_lookup() also relies on
> BPF_F_INNER_MAP to skip JIT inlining, will it inline the lookup with the
> template's excessively large bounds hardcoded, resulting in out-of-bounds
> heap reads on the concrete inner map?
>
> >                   meta.const_map_key >=3D 0 &&
> >                   meta.const_map_key < meta.map.ptr->max_entries)
> >                       ret_flag &=3D ~PTR_MAYBE_NULL;
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260624072031.73=
5846-1-sun.jian.kdev@gmail.com?part=3D1

Please ignore this series.

I just noticed that Nuoqi Gui's "[PATCH bpf v2 0/2] Keep dynamic inner
array lookups nullable" already covers the same verifier issue and
selftest.

Sorry for the noise.
