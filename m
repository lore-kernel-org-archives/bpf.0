Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D52B391842
	for <bpf@vger.kernel.org>; Tue, 19 May 2026 20:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779221878; cv=pass; b=U6nbxA4I4xe8OMdYIlTxS/ZRICVdqCC1XxPFXgukODS538fV1vrcfzhXVghlwVQghb0WeB19QhvI0CgLpmflrC4N3hOUYBU1V4UK7EEuFdU9+rIvWpCNB1a2FcXeHVv09rs0tGrXggKB/omVQLqjOoebgMGi/naQxPhiB/ewxh0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779221878; c=relaxed/simple;
	bh=959ecGSQOyj9LzHHwylEt6lV1ltX7MjF7+EsFpGgheU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N4AUK27b+iXHQ1j7bm1n08T3No7myGcjYt1ryHHsMVTLvUk3GB+4rrElVRFv05ux7Nh4gMjjA2Pfv9AVip1pY5NRpi4CpO8ru8yrNOVecDiN485sRTxAPBjlLx1GEKXJS69TukX6JQraiXM0jA+O9Xl0ysMD42q1ozdQ6OyAmpk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U7r8jtG1; arc=pass smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U7r8jtG1"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-7cd35604a95so30156857b3.1
        for <bpf@vger.kernel.org>; Tue, 19 May 2026 13:17:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779221876; cv=none;
        d=google.com; s=arc-20240605;
        b=j67mIbtyH5xW37+eE8ibOoSspIddi3tPEPxC4hMwNRzrDbCrT9o6UmTmED1lpRF+/7
         20758pty6QH0zyoxYGBgNl+e5kV6K9ELIHIaoS4CSncwTSIKmw3HmJw1pTjqPpaHfdsm
         jQagEgFKzTqZ9MGIRt36qc8hsJ/UqO3R/+uni35/wvpGrKErQ8XWXW9aN0pGslXwgWIJ
         G2goi2o/ZcBSjd/SpYxIP73YPzkkvxiO3nYrB1iLRPu4YwjziU2hOKX7qPsEbsceQn90
         xuHZf06S7KvuhOCI5zhSUT4v/PobW2/VrvP3me0J94cYh5e9Etou5+sauAQBSVvd2ldT
         TRIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AeQJ/g2xW7OKfdXt1dZh7JNahioYNHjsulaXSVovxmU=;
        fh=SS7tT0KC3jLZdfo/Ptau2hbovOS8lxj95BG5rgPZ6kI=;
        b=fGuoeDZusNHPqfg7w7KfCTuMevpL4SwaqJOvURnoLvFSLtEkBmwrG6XXf2CiWPEVqO
         11qPSzV9raEcasEVv+GTsRU+xl/+byyDqrVm+AySNuRQgWtY1iyIt1Qbi33sir4ScRt/
         ovQDsS6pIwDZQrBBWPyKd34e0jHNtX5HhUoU1pjVMIEJNBP6QwcqjmiXItKopXDEVj5i
         hnvdJ5Fz8vQUv9VVUbwgXopwEK0rE9OrfRgK3tvaCi693MLwZAbqYe/SlXWx0LVOIGtF
         kYRmjOLsFjdRuvQx4WmEQQP0+8+5fCjU4fCyazs7OylPy3r2p+QtQ/xnU+yGGVOyHO9Q
         juEg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779221876; x=1779826676; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AeQJ/g2xW7OKfdXt1dZh7JNahioYNHjsulaXSVovxmU=;
        b=U7r8jtG15oV43+DFXGzPKa/7Dj0Y9t1Mx8+WJViHpzAtdIIf5I5vLI6QN6nl/1BEKr
         zsPh+efTmPmm0w3urEZm6rbnGwGApliQq5BChK9Zmu9zj8hKUY/j9cp/+IKe9Tgci1Cw
         kBK+V2BKeOOQ4bI7w37pkoX1gabFUFE1z0VSlSRRSTLbXO9hNOyDY4xeIfoNPune2i72
         6LzYivO55B38VXxnLEF4V9exjfi0vpMErXUaHeQQ6ebxblzYWhnQh8LwIs3m/u7tMIPp
         7LQ+YqmJdXjGgJ62cPLVY1PmZtFQG+YlStBmh1GTY2gDLk579hHf9mfVO+ze+inUuNUn
         rTpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779221876; x=1779826676;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AeQJ/g2xW7OKfdXt1dZh7JNahioYNHjsulaXSVovxmU=;
        b=tVCgTjj8EGqO7OSUWExQhSilNoHmY4uzxRhL/Lm6rg7mtl1ID20W+QP/tj2m2W6oHq
         OidRsKIZs3qWwsfU+yOzo3bJTx/TXdeeUxfBm2cJ1xHGHhmwr/eVd7hLoAx5qzz2eT76
         0RCMT/4hDjFdaIqQLSmZVkA5Qcp7JGweRTUxNDmXJxbI7wuyB7oCymTrysAyp0WruKPa
         Sk+ps0VNUPUO6ILYKNIcHpYI6iYFk0FEAliezUENLh11LHWzjWS1onmLkEAONp8+3raM
         18iBdaoRDE0BGNGKHwSD5i1Ox76gBLEwXO5LH6ztAxIbbpUe7pCAKlbJA2MNuA9QY9Fr
         9bzg==
X-Gm-Message-State: AOJu0YyKf639+pfFVTM9jw6NC9XIcXgchZTNVbqtPHiC07FRmRCpA85l
	koMDuhUIbHFjYDvWDqkpCmXXoSywdsC5pn20MbSs70ys3Hlsx+DrD5Cr8Eb6Sm53i7bKAAYOTOe
	Etd71kHoUUdmZ3TioGimWtGo0b/uy9E8=
X-Gm-Gg: Acq92OF7lh/czXwNlaMmlTYHvZR/XwjiNPi25VbpkMA/byMyQUZShsNpMb/wEiokrRl
	MCK2/kjCCwSa3yLwCf/rsN6ASOeVRtoKeRyPrOlM0UQQMSVGgEvyghmJTR0gxyy5Z9gVO9v/8iz
	DUCiBdqQv/FbD4dW8hNUJWvk3ejHN6qrgtPhuDs4ukVu4wwdtiRQ9cKW7hALsbw7ZWeS9f5svoo
	djvC/f5Oi3dXmh3A5zxy6I8XbLmvil8wAyEBdPQe/syO/4IyHrXWpQBYxSkyqeH9UVtzQGRKFub
	joXvuVSh+Yzw10hoyYxI
X-Received: by 2002:a05:690c:e566:b0:798:5213:d90e with SMTP id
 00721157ae682-7c949cc03c7mr149969607b3.25.1779221876361; Tue, 19 May 2026
 13:17:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260519181314.2731658-4-ameryhung@gmail.com> <2835fc606f98829230b388fc8c904e7ed52300b2b13e3c9368ec6449d17f5645@mail.kernel.org>
In-Reply-To: <2835fc606f98829230b388fc8c904e7ed52300b2b13e3c9368ec6449d17f5645@mail.kernel.org>
From: Amery Hung <ameryhung@gmail.com>
Date: Tue, 19 May 2026 13:17:42 -0700
X-Gm-Features: AVHnY4LOBIDu-OBUrVT8f--7dFCyYDTwkTr2rraD8hCw_C5sOM4z1o0c5f2AoTI
Message-ID: <CAMB2axPm6GUqSdjT49GxSjseuP+RHXMXSOnouBrSUwYiVYrzCA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 03/14] bpf: Assign reg->id when getting
 referenced kptr from ctx
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, memxor@gmail.com, 
	martin.lau@kernel.org, mykyta.yatsenko5@gmail.com, kernel-team@meta.com, 
	ast@kernel.org, yonghong.song@linux.dev, clm@meta.com, 
	ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2026 at 11:56=E2=80=AFAM <bot+bpf-ci@kernel.org> wrote:
>
> > bpf: Assign reg->id when getting referenced kptr from ctx
> >
> > Assign reg->id when getting referenced kptr from read program context
> > to be consistent with R0 of KF_ACQUIRE kfunc. skb dynptr will track the
> > referenced skb in qdisc programs using a new field reg->parent_id in
> > a later patch.
> >
> > Acked-by: Andrii Nakryiko <andrii@kernel.org>
> > Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> > Signed-off-by: Amery Hung <ameryhung@gmail.com>
>
> During the v3 review on lore, Eduard Zingerman noted that this patch is
> mandatory for the series because the .id link is needed to propagate
> invalidation triggered by free_skb() to child objects. Specifically, the
> test bpf_qdisc_fail__invalid_dynptr_cross_frame.c:invalid_dynptr_cross_fr=
ame
> fails if the line "regs[value_regno].id =3D info.ref_obj_id;" is commente=
d
> out. This invalidation propagation aspect is not mentioned in the current
> commit message.
>
> Reference:
>   https://lore.kernel.org/bpf/c84a7beccd4ae527981797a6e5a6af840ba9c312.ca=
mel@gmail.com/
>   Date: Wed, 22 Apr 2026 15:50:52 -0700
>   Reviewer: Eduard Zingerman
>
> Could the commit message be updated to mention the invalidation propagati=
on
> requirement?
>
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 564679f70afd..441950b43a4c 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -6209,8 +6209,6 @@ static int check_mem_access(struct bpf_verifier_e=
nv *env, int insn_idx, struct b
> >                       } else {
> >                               mark_reg_known_zero(env, regs,
> >                                                   value_regno);
> > -                             if (type_may_be_null(info.reg_type))
> > -                                     regs[value_regno].id =3D ++env->i=
d_gen;
> >                               /* A load of ctx field could have differe=
nt
> >                                * actual load size with the one encoded =
in the
> >                                * insn. When the dst is PTR, it is for s=
ure not
> > @@ -6220,8 +6218,11 @@ static int check_mem_access(struct bpf_verifier_=
env *env, int insn_idx, struct b
> >                               if (base_type(info.reg_type) =3D=3D PTR_T=
O_BTF_ID) {
> >                                       regs[value_regno].btf =3D info.bt=
f;
> >                                       regs[value_regno].btf_id =3D info=
.btf_id;
> > +                                     regs[value_regno].id =3D info.ref=
_obj_id;
> >                                       regs[value_regno].ref_obj_id =3D =
info.ref_obj_id;
> >                               }
> > +                             if (type_may_be_null(info.reg_type) && !r=
egs[value_regno].id)
> > +                                     regs[value_regno].id =3D ++env->i=
d_gen;
> >                       }
> >                       regs[value_regno].type =3D info.reg_type;
> >               }
>
> This looks like a bug fix for the id generation logic introduced when
> support for may-be-null types was added to the check_ctx_access path. The
> issue is that when getting a referenced kptr from program context (PTR_TO=
_BTF_ID
> with ref_obj_id), the code was generating a fresh id for nullable types b=
efore
> assigning ref_obj_id, causing inconsistency with KF_ACQUIRE kfunc behavio=
r
> where reg->id is set to info.ref_obj_id.
>
> Should this include:
>
>   Fixes: 93c230e3f5bd ("bpf: Enforce id generation for all may-be-null re=
gister type")

The inconsistency is not a bug. It is only needed later when I added
reg->parent_id that track reg->id. We do not need a fix tag here.

>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/261166=
80637
