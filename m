Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16C4479894
	for <bpf@vger.kernel.org>; Tue, 28 Jul 2026 23:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785280807; cv=none; b=a1GegTD2Rwv5Dr3BhFig6ChvGWmXg0orSAWylNTlnvc7W2wCk2C2F3VMRWDpXZSBMZUC0eut8WxVmS6NH6SbQ0+Qm5rlvPLHqpGcYJGfklwhSfV16Yyhy3s2FTxW/5EAaM6664Jqhzpp1q2m+IPhQ7H3ky/ecogg8KBGMlDUX9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785280807; c=relaxed/simple;
	bh=dO/Mo9w20ruGqt0ERGgOi1GdcC4mvEapV2dnYTZvRa8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eQdH6Ff3fK1WzJ9/xYjKKM4TT8tBvECctDaLeN6gHHOCYOEu1i1eu43AhyA4fD/dSJuYO5FeJcDVtlbMzLWTF62vxHuUoU2/5D5M+ZO7b+y5bJSvBnW6dG04o3aa5xdxjVSXBQtml/hOH35qdzC1mB0J6mvHoIlk3LPK3otPd4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qrfVcdff; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qrfVcdff"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c9e0b89e228so179401a12.1
        for <bpf@vger.kernel.org>; Tue, 28 Jul 2026 16:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785280805; x=1785885605; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Ffw6N7j4a4gaCEhw88d/8nig4dKrQlJvzZLGm6hAUU4=;
        b=qrfVcdffxqpglQ5dgH2Yb73dZ9OZKl7pmsW91gm20YHPpr8JrnY6FMyFdDfGHCpESp
         4+Wt9PH+VHWJR1zDxIEWJL7P4qzlErwmzZpJMJ86Y9eTDO6e4RxNX4JjYyqRu68JWXO3
         2BRbPemP9J2bBOiGEuI4nqijJ42n9r+ZPmCX5OVCSxCKRv+dZehPFoYPaTLIEb3gjgVt
         O0bo8/ZswSnusWijZkK/CIR4spEKPiQaSqrOfFtIlxFjTLqzdQL61l6Tp9HqWf5f8G7S
         iUsJlBQy9UjVH55K82t6VM4ljIg8Vm5fWIDgae81Ei5X+Iq9py5XgebUYMLmfCvV1VIB
         iHUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785280805; x=1785885605;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ffw6N7j4a4gaCEhw88d/8nig4dKrQlJvzZLGm6hAUU4=;
        b=EBGHNc0Lru3I5DKmG3i0K7sEht4pINtX3pb7bITB/5IM05r62RSB7/SCMUFfjTxtbT
         6i5DdbuOro7bO64D4wFMkhj8TcIO4v1uFCUb0bMPqL9kEGpHGHFkSiIxQWkKpWn/7WrU
         /j6hRGucetIflpqQ6qMYAI38Ib/yLk2t54bj7xszXcOzONjzgj0zfoZanSsWnBh66lBw
         ssxfstfbLQMAaBgvMiYuoJBKaVbQRZlivTSfdeDXwXcaU098pwYmfHHTVn2LfDZag09i
         Mv9k/U1+yMxlUDw/eZ1TMqCIjUQsFz4kPgwE0al76PNB0esmWkr4hf62t2RMH6Q/+zAv
         J8OQ==
X-Gm-Message-State: AOJu0Yxdz2qLOLkwOs93HB5jKTVlYbj5ubkDJ4+2I7uhpYlxtLWS4HEE
	aCM3fVYjmJnHw/4e7KnTGYcFNd/TVX1G/UNPXrNJ0USunLjZiWjQnTp09ff35YpH
X-Gm-Gg: AR+sD10KneAEaXbbol/aD6hVscSzMhUK626cKE7+KPTDyDgfVu12IpfgCl21MLdp1Ov
	goIVU35dWs18/MNFbZjQl3obgq1RtsfCn71+6dGEJqsAVkgz5qogY2CCWl7RJRG1jrHgbJDU46C
	kld281obWnq19N264CwqYBt5/tA16iJEEnLacMmVJ41GH+INDPTmrZYPy5prODEebzUDsCFW5LR
	jIBAA5jLdoRtX3/+EV3gXBLQc3yfpS+Wsz/STJMSHNqpF7Womei3dDul6Sdg/qcbxdpvWl7nKaf
	Z8Pz3v34hLQn5EkEFV6d6i13/D2F+vPOSx/6NNtzbmPcfZRC0M4FqDiOsFZBZKdfJjJmbKueZ7T
	etMrhF5WpYmbVB3+6CoLSEL/fUTcSaiC51QtDB6fEeQqcqtUg1U3bGNAuWCUhORUfu05xIBgQbE
	nxeyL2rnBMOLV/bS3u2RriMVkmeEAXi35cDJl9Qsl4tGHQ2gOCZZZ46X5pWRiuv5anttUzdH6OK
	eNRJ4mLJxL0CF6ycSGhc4e8Fik8fjuBjQ9DiN7n/D+APw==
X-Received: by 2002:a05:6a20:908:b0:3c8:e313:8d42 with SMTP id adf61e73a8af0-3c8e3139510mr146075637.31.1785280805041;
        Tue, 28 Jul 2026 16:20:05 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:a358:4bd1:35cd:2e45? ([2620:10d:c090:500::5:ff91])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13e72735084sm2544610c88.12.2026.07.28.16.20.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 16:20:04 -0700 (PDT)
Message-ID: <933cbc8d75fddf0dd94a7ae8614a55e9dfc231e5.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 05/18] bpf: Check helper and kfunc mem+size
 arguments identically
From: Eduard Zingerman <eddyz87@gmail.com>
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org, 
	daniel@iogearbox.net, memxor@gmail.com, kernel-team@meta.com
Date: Tue, 28 Jul 2026 16:20:03 -0700
In-Reply-To: <CAMB2axPcdjVA6Pwp0TpGpMtJGiOB5khJ4HA13iJ9XT1qpyfNtw@mail.gmail.com>
References: <20260724190813.1458271-1-ameryhung@gmail.com>
	 <20260724190813.1458271-6-ameryhung@gmail.com>
	 <27739a12b7f7d5cd6e7fceeb389cff0072aefef2.camel@gmail.com>
	 <CAMB2axPcdjVA6Pwp0TpGpMtJGiOB5khJ4HA13iJ9XT1qpyfNtw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-07-28 at 10:57 -0700, Amery Hung wrote:
> On Mon, Jul 27, 2026 at 1:51=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.c=
om> wrote:
> >=20
> > On Fri, 2026-07-24 at 12:07 -0700, Amery Hung wrote:
> >=20
> > ...
> >=20
> > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > index 468702b09c50..2e56f726c12a 100644
> > > --- a/kernel/bpf/verifier.c
> > > +++ b/kernel/bpf/verifier.c
> > > @@ -6873,7 +6873,14 @@ static int check_mem_size_reg(struct bpf_verif=
ier_env *env,
> > >                             bool zero_size_allowed,
> > >                             struct bpf_call_arg_meta *meta)
> > >  {
> > > -     int err;
> > > +     bool may_be_null =3D type_may_be_null(mem_reg->type);
> > > +     struct bpf_reg_state saved_reg;
> > > +     int err =3D 0;
> > > +
> > > +     if (may_be_null) {
> > > +             saved_reg =3D *mem_reg;
> > > +             mark_ptr_not_null_reg(mem_reg);
> > > +     }
> >=20
> > Also, this pre-existing hack with saved_reg and mark_ptr_not_null_reg()
> > is quite ugly. Consider mark_ptr_not_null_reg():
> >=20
> >   static void mark_ptr_not_null_reg(struct bpf_reg_state *reg)
> >   {
> >         if (base_type(reg->type) =3D=3D PTR_TO_MAP_VALUE) {
> >                 const struct bpf_map *map =3D reg->map_ptr;
> >=20
> >                 if (map->inner_map_meta) {
> >                         reg->type =3D CONST_PTR_TO_MAP;
> >                         reg->map_ptr =3D map->inner_map_meta;
> >                         /* transfer reg's id which is unique for every =
map_lookup_elem
> >                          * as UID of the inner map.
> >                          */
> >                         if (btf_record_has_field(map->inner_map_meta->r=
ecord,
> >                                                  BPF_TIMER | BPF_WORKQU=
EUE | BPF_TASK_WORK)) {
> >                                 reg->map_uid =3D reg->id;
> >                         }
> >                 } else if (map->map_type =3D=3D BPF_MAP_TYPE_XSKMAP) {
> >                         reg->type =3D PTR_TO_XDP_SOCK;
> >                 } else if (map->map_type =3D=3D BPF_MAP_TYPE_SOCKMAP ||
> >                            map->map_type =3D=3D BPF_MAP_TYPE_SOCKHASH) =
{
> >                         reg->type =3D PTR_TO_SOCKET;
> >                 } else {
> >                         reg->type =3D PTR_TO_MAP_VALUE;
> >                 }
> >                 return;
> >         }
> >=20
> >         reg->type &=3D ~PTR_MAYBE_NULL;
> >   }
> >=20
> > Note that the check_helper_mem_access() already calls base_type(mem_reg=
),
> > so the '&=3D ~PTR_MAYBE_NULL' part is irrelevant, what matters are the
> > following mutations:
> > - PTR_TO_MAP_VALUE -> CONST_PTR_TO_MAP (plus it's uid, type, ptr)
> > - BPF_MAP_TYPE_XSKMAP -> PTR_TO_XDP_SOCK
> > - BPF_MAP_TYPE_SOCKMAP -> PTR_TO_SOCKET
> > - BPF_MAP_TYPE_SOCKHASH -> PTR_TO_SOCKET
> >=20
> > A better design compared to current temporary fixup for a helper/kfunc
> > call would be to deal with types CONST_PTR_TO_MAP | PTR_MAYBE_NULL,
> > PTR_TO_XDP_SOCK | PTR_MAYBE_NULL etc, instantiated at map lookup.
> > Wdyt?
>=20
> I agree that this is a better approach. This can be another follow-up
> considering that this is an independent refactor and the size of the
> current set.

Hi Amery,

The change appears small enough to include in the current patch-set.
Here is the patch:

  https://github.com/kernel-patches/bpf/commit/e59423209d66e71baa7c66e5cda3=
b2018fcf273a

Wdyt?
