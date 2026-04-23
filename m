Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119E430C63A
	for <bpf@vger.kernel.org>; Thu, 23 Apr 2026 22:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776984411; cv=pass; b=agpfB7ZGIHkP1rygmMqqSP/qurtRoieG+WdZ+4jg82TyLNdUZPBKf81OR3+Se8iSAmb8bi9m+/qoVSuZObZ7C3h1glfDYi7BX5hRMG6EUp6Vb7VV1om6jIHmV6xvl+el6j3X2hMUtlgFqw4TclHA25k7oSBQxoKpCsEjg+IIakU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776984411; c=relaxed/simple;
	bh=Wxr23wANLnnyuzn218fgcEsk3niAu/vPTkNHqBH3Tn8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZOKfBBc1YTNwzLfbb9XGYLDjfqxhSyxnMK8GqzygXWGw6PyACQ1cOYs4NmRCVh1acVYM3bXCrXDyFZ5UelLeCdAlMnF7BAB8hJIuXWdUwC97TJ64hFJitS6uBFHIGGSvznmV8X00FzwEIz1GdIOpG13UWAkfwRRmHzi5O4vnx+g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=hUQ7Hbix; arc=pass smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="hUQ7Hbix"
Received: from pps.filterd (m0528005.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63NH8hhu2715733
	for <bpf@vger.kernel.org>; Thu, 23 Apr 2026 15:46:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=PquePwN2z+FIAknp17G21flfgP6AWqZXSQwJJptNxF8=; b=hUQ7Hbixk7KH
	V6p3ES/P2a8CUtPmNt74t2cfuKABvfu/m4D6tbVY5gJFj9eJ/n3+/iJQWTVArvg/
	oMqQVJ95qtjzKP32JCFVknOAexBRDj6Mffc7oJ5QInNnJhytcy2KTnv6notZJeEr
	k0j7rbuOZ+ELiPyAddoRU/DteHRQnxXE7Q6qu1e5SKVCpdCr6MkdXCA5t6Yuy7sV
	iqxBpub2msTYWRBiu5ecNK90BXZB0calftezHQR5aB/iqFzdFZSYtVp8nwE1WH60
	w5hHU4VPDIZ1gHuPhwWch+XnA48N/04PWW0oPI9beYdQn+hd/m+6t2/MmJVqAlp0
	P7NU/bVRyA==
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4dpepaqh7x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Thu, 23 Apr 2026 15:46:40 -0700 (PDT)
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-ba4a20f4718so465530666b.2
        for <bpf@vger.kernel.org>; Thu, 23 Apr 2026 15:46:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776984399; cv=none;
        d=google.com; s=arc-20240605;
        b=GYDta/pNg271mb5ANLeCMvVAK5tZ0v6RpIRuLjaAAFj6h36e1JuL2D8a7CJI8DBWI4
         2eGmHNjCLe0JLUJmXYQvzu1ZI3hSjmYM8ICj7aKe8IIQOpFD4yU5/gFfr95RKL6QPiFg
         MdxJZPffBL4kVD9aQO0W6cQq1m/x3cK702ToNZA/wai8cdRiwgUOAs8TL10wLfwHI337
         o1arsNmTq38TsSGgcYkCJI9B5x9AV8CKeuDEDA9Tbsx77OI7MQttXO2YS0uYcOVAa8od
         i3lyg2YNopHYRpXKAaFjkmrEUohwYQICafQ1XX941CseqYpqBBWuWwYqS7dXLLaF/GU3
         +9bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=PquePwN2z+FIAknp17G21flfgP6AWqZXSQwJJptNxF8=;
        fh=pcV3TiNByo9PKlDfTJ+CZ2SVTkKSMxcNQQVbf2BBAfM=;
        b=M732BEPpZY19vOEVyjX/tpr+GyVld2HzAy2mF8HChjr4ttqbCZ/MaMl+R3A5fP64hD
         57GQcryqXrDdCMxh+tm8MeE77+CbQGs+q/N05slMWAHU0pOXVCvbJQrLi41+Lf19Suzj
         iBtOgx9e50l+1OZXXEdqSs7cVb/TvBY3GHPXSPirHEXN0r3sPtZt5AZPwt8MUWK/T5hj
         Sdlj8Kw/r0LZgycxDVEdg7oXxiazcfN+TsOnFkOLzwDDkth3N8gmOg027NdKf6iUkKhP
         TBQO+DXetGGsrwBrNWrws7zmSFSh0TX2vDY6LBGH3YqMYzK238j030mgSdvg2qLTC39s
         5SHQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776984399; x=1777589199;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PquePwN2z+FIAknp17G21flfgP6AWqZXSQwJJptNxF8=;
        b=BHQQ32BYX8P0XuSeiju5E9/BJ94OE9cAHewz9QNVJLDh4vsQeoOpWiA529YXRKwEN0
         uQAl6xgM4y6MUMeFJaAhu/AIsFc04YSIQ6aWIT5I8D88BVslGvbMNwsPxJOlZ6UDOGcp
         HtHqiHLZBK8dRUe8Oq3yMqA3mnNX8bWjI/ICwK3RqXXWcVD2DjPqYCB8tonWlx3vmcWD
         cA96DJQW3BN99SBzaxHP453kfYbmQqusE04F22nqkw2Nr/QHlUnQtBecP70TqL/TZPo+
         b5vMPzS7GRkpcuQIYa0JoccG47IkDq+inE9y2RddEUt86WgzvkiUqourB9tDut20u7O1
         1bQQ==
X-Forwarded-Encrypted: i=1; AFNElJ81CRNTF3RGa+Gnv4nh1xAnwLpo2dXOfdNWUc1SvK9nuUPGLDi/KTJvMycq9UzzSdsiCLo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOCLR3SpnSZsZR9Y/A9zrfV1/9HJgvNUR3khIaaXSjRdI/OJ9F
	nbKAb9F4XVDYiHlDvOYexz21iwbKFtU8tCL1BPk4sIr8yqH2+C7cXXrFj7hnvA3vpNNjs9tpwC/
	dt3fmzJvD0LovyO1HZb4JPLWxDue4jzsq05qY0dCg/bzK3VG6PzbVGuEaY+ut7CPiusiNN6CKr4
	9FXf7UdeO9QKCvg5N8x2g4yjYSucI=
X-Gm-Gg: AeBDievfq2fY+WfkLzZE4D4P/kuiCMEPOObYErJ6oJ13uBe2toUTOQ15oAbLp01Z/lf
	vWlo6asm4FYM+uM6tRmE8HS0CiHxFRSbfrRH7Skf/h7aMgHW2YHi5Xyd8iGP8yRPW0cLSMQFJd5
	Gdb2uDKakq+/Tv/M6G83sg93+d96L2WB4x/rVJtGiYgbZtMo8emT2umdqiyW7/L/15evg0wYaz3
	Mgs8vSkkumfJwJtNbq39OjmON4pqQ==
X-Received: by 2002:a17:907:7fa0:b0:ba5:962f:9db8 with SMTP id a640c23a62f3a-ba5962fcc19mr1234842366b.29.1776984399325;
        Thu, 23 Apr 2026 15:46:39 -0700 (PDT)
X-Received: by 2002:a17:907:7fa0:b0:ba5:962f:9db8 with SMTP id
 a640c23a62f3a-ba5962fcc19mr1234841166b.29.1776984398771; Thu, 23 Apr 2026
 15:46:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260421221016.2967924-1-ameryhung@gmail.com> <20260421221016.2967924-3-ameryhung@gmail.com>
 <9237d7b35463c79863488e3f2180239aab679049.camel@gmail.com>
 <CAMB2axMzeQs3WzFd1PZFB=DgR6d2ye4qzHKhATK2895ryzAEog@mail.gmail.com> <c84a7beccd4ae527981797a6e5a6af840ba9c312.camel@gmail.com>
In-Reply-To: <c84a7beccd4ae527981797a6e5a6af840ba9c312.camel@gmail.com>
From: Amery Hung <ameryhung@meta.com>
Date: Thu, 23 Apr 2026 15:46:24 -0700
X-Gm-Features: AQROBzC1De56wmESn2eT6JrBcX_snpphIjr5o2acJR5S3Bb8bBEZf2if_Th2DN4
Message-ID: <CAP17u3Nh=_9ftdp-tA=yS5TRW7j-5Tk1PPdaDz-GZCW6k_Nvvw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/9] bpf: Assign reg->id when getting
 referenced kptr from ctx
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Amery Hung <ameryhung@gmail.com>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, alexei.starovoitov@gmail.com,
        andrii@kernel.org, daniel@iogearbox.net, memxor@gmail.com,
        martin.lau@kernel.org, mykyta.yatsenko5@gmail.com,
        kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: 04pV9OyoKlAv1Jf3o68CpyZPZ9AbQnlf
X-Authority-Analysis: v=2.4 cv=KMxqylFo c=1 sm=1 tr=0 ts=69eaa150 cx=c_pps
 a=D+UBI74RbQA8i2EYnbuvxw==:117 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=jCddH8ec0KUNCymVuxII:22
 a=pGLkceISAAAA:8 a=rXDmgZ6x93T5uffNZgUA:9 a=QEXdDO2ut3YA:10
 a=PsfoTyiJ_72bb7xyA04f:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIzMDIyMSBTYWx0ZWRfXyWeYaG3JzssO
 WBO+k7jKq57/PcgVqUr5cde69cjWesv0Rgp6Hf+sNJJQ4o0wszdg7e8tUZ01oL640SkqwaJ45t9
 moybi3vP7L4P2PFmIqx0Z/3Oe9HghrhbtT/ULL7TYjbOogIMiNnHDZvSdb+FKKExHapWTCWpCZ6
 MjkRuIP838NFKFzZ4YKbsrFa1tjSWMu3v4bB8TVkkjF7XWkiYIRplCznMQoEv4gLOmOx5xCl4Qx
 XebhrRrf0biFaI4mCEPvVrUwPuDGLGpGjE3/8uIPcgn1grzGaDJs/3Cp9Q28jZ03G3dWUftCANT
 +0TaLVbkyLHW0duaFSbmFaePlIxz444/bfEysfN0BTUJKLDqP4UC3qA3CmRO5icfS+/lXIyxhzE
 J/Vtcc468zD4N6WqN9Phn6RHUb6jGTjDOOHCHT2yexxLrohINwPhulzVXsdtyw0eCgl8Ct+fsPD
 TETJ1PhaVIhkBJRL8JA==
X-Proofpoint-GUID: 04pV9OyoKlAv1Jf3o68CpyZPZ9AbQnlf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01

On Wed, Apr 22, 2026 at 3:50=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Wed, 2026-04-22 at 15:45 -0700, Amery Hung wrote:
> > On Wed, Apr 22, 2026 at 2:46=E2=80=AFPM Eduard Zingerman <eddyz87@gmail=
.com> wrote:
> > >
> > > On Tue, 2026-04-21 at 15:10 -0700, Amery Hung wrote:
> > > > Assign reg->id when getting referenced kptr from read program conte=
xt
> > > > to be consistent with R0 of KF_ACQUIRE kfunc. skb dynptr will track=
 the
> > > > referenced skb in qdisc programs using a new field reg->parent_id i=
n
> > > > a later patch.
> > > >
> > > > Signed-off-by: Amery Hung <ameryhung@gmail.com>
> > > > ---
> > > >  kernel/bpf/verifier.c | 5 +++--
> > > >  1 file changed, 3 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > > index 41e4ea41c72e..93003a2a96b0 100644
> > > > --- a/kernel/bpf/verifier.c
> > > > +++ b/kernel/bpf/verifier.c
> > > > @@ -6448,8 +6448,6 @@ static int check_mem_access(struct bpf_verifi=
er_env *env, int insn_idx, u32 regn
> > > >                       } else {
> > > >                               mark_reg_known_zero(env, regs,
> > > >                                                   value_regno);
> > > > -                             if (type_may_be_null(info.reg_type))
> > > > -                                     regs[value_regno].id =3D ++en=
v->id_gen;
> > > >                               /* A load of ctx field could have dif=
ferent
> > > >                                * actual load size with the one enco=
ded in the
> > > >                                * insn. When the dst is PTR, it is f=
or sure not
> > > > @@ -6459,8 +6457,11 @@ static int check_mem_access(struct bpf_verif=
ier_env *env, int insn_idx, u32 regn
> > > >                               if (base_type(info.reg_type) =3D=3D P=
TR_TO_BTF_ID) {
> > > >                                       regs[value_regno].btf =3D inf=
o.btf;
> > > >                                       regs[value_regno].btf_id =3D =
info.btf_id;
> > > > +                                     regs[value_regno].id =3D info=
.ref_obj_id;
> > > >                                       regs[value_regno].ref_obj_id =
=3D info.ref_obj_id;
> > > >                               }
> > >
> > > Hi Amery,
> > >
> > > Could you please help me double-check my understanding of this change=
?
> > >
> > > It adds a new behavior, if struct_ops method parameter is annotated
> > > with __ref, then if a field is read from such struct_ops context
> > > the destination register would now have it's .id =3D=3D ref_obj_id
> > > allocated for the parameter at the beginning of do_check().
> > > E.g. for `rB =3D *(T *)(rA + off)`, if `rA` is a pointer to struct_op=
s
> > > context and parameter corresponding to `off` has `__ref` annotation
> > > the `rB.id` will be assigned, contrary to old behavior, when it remai=
ned 0.
> > >
> >
> > Right
>
> Ack, thank you.
>
> > > This change in behavior, however, becomes visible only after the
> > > changes to release_reference() later in the series.
> > > There the `rB.id` is used to initiate `mark_reg_invalid(env, reg)` fo=
r
> > > the `rB`.
> > >
> >
> > I probably should mention it in the commit message. The purpose of the
> > patch is to make the implementation consistent with the design:
> > parent_id tracks the id of the parent objects.
> >
> > Without this patch, it should still work since in this case ref_obj_id
> > always equals to id. When release_reference() is called on a
> > KF_RELEASE kfunc, the children objects will still be invalidated
> > correctly.
>
> bpf_qdisc_fail__invalid_dynptr_cross_frame.c:invalid_dynptr_cross_frame
> fails if I comment out the line `regs[value_regno].id =3D info.ref_obj_id=
;`.
> The added .id link is used to propagate invalidation triggered by
> `free_skb(skb);` to  `hdr`.
> The patch seem mandatory for the series.

Ah yes... because an skb dynptr do track parent's id in
check_kfunc_args(). Thanks for the correction.

ret =3D process_dynptr_func(env, regno, insn_idx, dynptr_arg_type,
                          meta->ref_obj_id ? meta->id : 0, &meta->dynptr);
