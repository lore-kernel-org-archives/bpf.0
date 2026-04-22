Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008973750CB
	for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 22:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776898262; cv=none; b=J+IPFGziNKR6xk3fsZRmLD+3vH9zuu41XKUeIr4iiGhWM3vKmyKK78LQZXOAvR1XFDeWyqm/x1tY9M0A+BLSjxzUDht8AlOcm1NUGDj9/ukTtrzVYxzQunUMkY4mdII7YA6QdwrGGzIclWziM0rSRhhSJ0usKKVTZeVfxLF0om8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776898262; c=relaxed/simple;
	bh=ks+dCualzOaqs77AbQPlKYXvBqKtbOBNZnorH0jGzJs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KdH8xqPfFZzfTm2UyzQOqUL2+vYsKSwoWUCHwdGJP6abvzAtn55Kv3q+QRPpTFFiGgQG5m1DU6KZMwV9/hVc/eiI+2Wi7zvUDXaTQ1QH+8gB7Sl79Xx7ux5VPLACkWABta/+auL1+fT9C8MSS/KXLACfm0iLbQlsvYt4WNzgc5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EyI4fjzh; arc=none smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EyI4fjzh"
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-12c637089ccso3559891c88.1
        for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 15:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776898255; x=1777503055; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EsIQHrEiJD5FzpoBONUuhlECKQYQ9gBcLPk2ubeY5ao=;
        b=EyI4fjzheJmLMslMftbiCJbsvExX5Z0TDiI4LyK3u+VBtkPbbiZIn/8dRL4qjmDVUJ
         dR1I2/q5zK1lx0X9MmwCAFjMwzzyNnoBKMrjsiyaM9jfot5Ixkylfsu82GNypNd11DP/
         4ULbjG39JJO28vJ+pshVr/fKvhIimhn3WwFbW3NZ6pUtiQ3OXm/6GNyL0qpygJdYIIwP
         3/th6UscbJSViPdI15cx4DsjDVSLViUJqaBRu0jABpSKLXSBRzTeTUZPASkpXrcEd0xC
         TcXva58x2fAgMFLxtqrB7VcjG4FJ5HjmUW+VdCYVPNLw2NiEI6b/Dppua2gROrxYjYoT
         2ctg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776898255; x=1777503055;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EsIQHrEiJD5FzpoBONUuhlECKQYQ9gBcLPk2ubeY5ao=;
        b=EhMkgqDJshcRE1Wll5BaNs2+S12dpPRh75/mvR5roXQ+ByCJWQGcwbH2VZ1wQagbFW
         LpoqPYBYPieswgQppy4+VbbwF/HFR4z+jpGIpu40wi3cfUtTbh15bXeSYo6hu+YEekKz
         J4tyYGxKs6clza88OYejlQVxEG7WdQcjxkWN1wrn2uuIFJBCrnp/cSq131Gr9n0F1mtz
         SJZHDkC2ddJbu0HP+jPfYQGBoAikUFPqmv8dRVHvV9UCbohDLR25+h+bh4YSZ/NVycBW
         NhqHXBnzU57Df4DjHZ0NpO3s5r8O2op00h8gQyU7WsYj0UQr63zSbbKmUPtVTuQd+v6T
         wTRw==
X-Gm-Message-State: AOJu0YxFjP5fTo+oFTfUVUXpL5O+JVzEXxvyuQNiJaBHBYti4sgn7ou5
	Guc2hRX3WaiS9fAffdg4099P/54ByBfyflNdtpvI5UiliG1eVumamgMJ
X-Gm-Gg: AeBDiesL5pKwuac1deBeYpeJS0ttZT2yzVat2UdvpmsHx3RdZQtuLWJCCOkVblYxxmY
	9L8fIuDSv0M3Efsu6/e2TerhnIM8I6hL2Y6aXxVEomzD2XsY46jC7RdI5Di+DchVrqhfAS17w2/
	nNnB06PYi902jcCHLRt2UA2t3pzQZ1DOp0BzJw2ptoBnj8feyGkSvFUR65Nw1/zQRxx1aO+jYLJ
	TnMW+Ga7g4pt0fyd63zTn9GVrWyDyfapm0Xb0rFluf1Y2Sc6THLTnh1191vKF/agHLEErOjn7MB
	JWy0azIIw1kmIdThy4l0Pr2stXdfXcoFtncYYi7HMNJ3/UgVtenHkiPsj2BFLyy7cv/JLAhW/QC
	eGA61TJYljzsGDEpu2UXrXYCsUDg68uNMYrI6xp6JjPOm058bQFQEsCyqcESAwqOeOAyGhrKTc5
	c3P6rjIceJIzcElDlQ7AO2oVO4rIZBRbw3PnYo3NWZEyf8GxcmXo6/FCvd03+GNCunvyW0D3dH/
	DBPw7wLVfM6UzJkKzKEwl1lyBi4WdI=
X-Received: by 2002:a05:7022:129:b0:12a:68cc:3efb with SMTP id a92af1059eb24-12c73f9303fmr14127409c88.16.1776898255008;
        Wed, 22 Apr 2026 15:50:55 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:1053:1d3b:d6cb:4350? ([2620:10d:c090:500::2:bea8])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12dbaab165bsm5912690c88.6.2026.04.22.15.50.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 15:50:54 -0700 (PDT)
Message-ID: <c84a7beccd4ae527981797a6e5a6af840ba9c312.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 2/9] bpf: Assign reg->id when getting
 referenced kptr from ctx
From: Eduard Zingerman <eddyz87@gmail.com>
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
 alexei.starovoitov@gmail.com, 	andrii@kernel.org, daniel@iogearbox.net,
 memxor@gmail.com, martin.lau@kernel.org, 	mykyta.yatsenko5@gmail.com,
 kernel-team@meta.com
Date: Wed, 22 Apr 2026 15:50:52 -0700
In-Reply-To: <CAMB2axMzeQs3WzFd1PZFB=DgR6d2ye4qzHKhATK2895ryzAEog@mail.gmail.com>
References: <20260421221016.2967924-1-ameryhung@gmail.com>
	 <20260421221016.2967924-3-ameryhung@gmail.com>
	 <9237d7b35463c79863488e3f2180239aab679049.camel@gmail.com>
	 <CAMB2axMzeQs3WzFd1PZFB=DgR6d2ye4qzHKhATK2895ryzAEog@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-04-22 at 15:45 -0700, Amery Hung wrote:
> On Wed, Apr 22, 2026 at 2:46=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.c=
om> wrote:
> >=20
> > On Tue, 2026-04-21 at 15:10 -0700, Amery Hung wrote:
> > > Assign reg->id when getting referenced kptr from read program context
> > > to be consistent with R0 of KF_ACQUIRE kfunc. skb dynptr will track t=
he
> > > referenced skb in qdisc programs using a new field reg->parent_id in
> > > a later patch.
> > >=20
> > > Signed-off-by: Amery Hung <ameryhung@gmail.com>
> > > ---
> > >  kernel/bpf/verifier.c | 5 +++--
> > >  1 file changed, 3 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > index 41e4ea41c72e..93003a2a96b0 100644
> > > --- a/kernel/bpf/verifier.c
> > > +++ b/kernel/bpf/verifier.c
> > > @@ -6448,8 +6448,6 @@ static int check_mem_access(struct bpf_verifier=
_env *env, int insn_idx, u32 regn
> > >                       } else {
> > >                               mark_reg_known_zero(env, regs,
> > >                                                   value_regno);
> > > -                             if (type_may_be_null(info.reg_type))
> > > -                                     regs[value_regno].id =3D ++env-=
>id_gen;
> > >                               /* A load of ctx field could have diffe=
rent
> > >                                * actual load size with the one encode=
d in the
> > >                                * insn. When the dst is PTR, it is for=
 sure not
> > > @@ -6459,8 +6457,11 @@ static int check_mem_access(struct bpf_verifie=
r_env *env, int insn_idx, u32 regn
> > >                               if (base_type(info.reg_type) =3D=3D PTR=
_TO_BTF_ID) {
> > >                                       regs[value_regno].btf =3D info.=
btf;
> > >                                       regs[value_regno].btf_id =3D in=
fo.btf_id;
> > > +                                     regs[value_regno].id =3D info.r=
ef_obj_id;
> > >                                       regs[value_regno].ref_obj_id =
=3D info.ref_obj_id;
> > >                               }
> >=20
> > Hi Amery,
> >=20
> > Could you please help me double-check my understanding of this change?
> >=20
> > It adds a new behavior, if struct_ops method parameter is annotated
> > with __ref, then if a field is read from such struct_ops context
> > the destination register would now have it's .id =3D=3D ref_obj_id
> > allocated for the parameter at the beginning of do_check().
> > E.g. for `rB =3D *(T *)(rA + off)`, if `rA` is a pointer to struct_ops
> > context and parameter corresponding to `off` has `__ref` annotation
> > the `rB.id` will be assigned, contrary to old behavior, when it remaine=
d 0.
> >=20
>=20
> Right

Ack, thank you.

> > This change in behavior, however, becomes visible only after the
> > changes to release_reference() later in the series.
> > There the `rB.id` is used to initiate `mark_reg_invalid(env, reg)` for
> > the `rB`.
> >=20
>=20
> I probably should mention it in the commit message. The purpose of the
> patch is to make the implementation consistent with the design:
> parent_id tracks the id of the parent objects.
>=20
> Without this patch, it should still work since in this case ref_obj_id
> always equals to id. When release_reference() is called on a
> KF_RELEASE kfunc, the children objects will still be invalidated
> correctly.

bpf_qdisc_fail__invalid_dynptr_cross_frame.c:invalid_dynptr_cross_frame
fails if I comment out the line `regs[value_regno].id =3D info.ref_obj_id;`=
.
The added .id link is used to propagate invalidation triggered by
`free_skb(skb);` to  `hdr`.
The patch seem mandatory for the series.
