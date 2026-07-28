Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F253A3826
	for <bpf@vger.kernel.org>; Tue, 28 Jul 2026 17:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785261285; cv=pass; b=GVtDvRElHhy+XvwzuhKe1ebZ2R8huxAQi0Yc2I6fVn2V9VoUpFWIHGKe/xrwi0ePn20Ud7zMUHWiHH2tajiJ6URO2Pklx90qBl0IAHuKsa2QN8kNbDFlZWAqD6IZDQCR08gvxInM4YK0SaSgx2KeLo6QXYkOLqEu/XJgo3mdbuw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785261285; c=relaxed/simple;
	bh=SuOmh8W15DG9bJdm3X8C2jQjWcVuFIjonnapMDm5cq0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UrjQCJFMvGLaJahfSfVZnRH1cjq4UODTdAyG6K2NZdFv9jMtO53+umwB6P59jK4sHDkfFwu2euwWYXRskgnAVaTpjndgozWE3A0hpx+wngESkYyb6flPMK1c4vWT9hBBBR9IiD+2Yia8MUU7BAGwIJ8tZwx/IDOKuh16oppNPGM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lAuSIiTA; arc=pass smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lAuSIiTA"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-81ed000b507so1952857b3.0
        for <bpf@vger.kernel.org>; Tue, 28 Jul 2026 10:54:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785261283; cv=none;
        d=google.com; s=arc-20260327;
        b=mjnFdWbYhM5htoD3VLUKvMmw0LrEQ2+JxizNVyzzUr6DpX/EZh2nwRCm6jDcn4M7If
         em1QHIoBWAdkHz0D7BefMJVeGe3w7pWZctIJZTL30qxkH+TgpznzIBDjj/LYYtzpe7En
         SxCJonypAGxl51D6cBBbdEALX/ffexXl1QgzkTGZBDJSPPnuAvatPtYJooG39c3nKJ2U
         Ed8LhuJW1kEX6vxX/ISNPJlxjAX/zfvRlC9Y6jh1T9i9/m/dw2mdy92hSTsPEZRRYHbV
         Mj/7wE0HgzvlxrRRw8VbS+Mm43yopZcQkScbYG0kQjLvv0juWgJXdeeX21kcIrSidmhq
         izPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dZJ4aLAHmL8c3AcQzheRDkRATQofVjSdwl8y9/FgaD4=;
        fh=6Z4J3xNs+qgwS2aK097++l2x6CIWkNCmJIKZe8W3oU4=;
        b=oW/WTFDfidgVcZVg8Tgg9b+7ayAfh2yLN/OMeg9myzQFlS+I6zxAad/l+QrvzFcgGk
         31lTR+ZRT9SYVp9dJ1ZM2bax2FcKpQ1FOJaPVXrEgHn7+AvX0QGu8eJys1gpzC3yDXMn
         fEcTRHJbpJawLbKBGDRYE3zocNE4LL0K2WVJQExxO7N+c8qkUrzxbiSSqvQGW9YXHAGn
         pbqnTivhU99RfRo0GITMJIsL2EPH8WlkwFReAtvlv2uGmP3RexXqJhflGQ9GfoTBlSZK
         qKi0WFYduv/3qjDRT1mePZmSvHLmiremOGaZSJUvpUTxv/Scio/AlgQX9Uoysgq1xx7R
         s99g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785261283; x=1785866083; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dZJ4aLAHmL8c3AcQzheRDkRATQofVjSdwl8y9/FgaD4=;
        b=lAuSIiTAeTZm9WNIwFL9kWLGr7TKeS67uKbIz/W7Ty37kITDOoy6BP2tpiQftSmULv
         VU27MniurEXP+3xbE3eyszarTp2a7vPevIOg1CmirSv/xjwTJjfDs3PEccf0jTMCVLe9
         yKkydJIgg3W06wX6zbM+JWamBrDMDXLK3g18+xFChYzCEnearGQFPtxfadxTVsSnKHe+
         YD9PMn/eZgvK2hDb5L8ExO3uq9d2jKh/YYwXum/Fwx7QH/oX8HU9G/OumCz4vjnbcN5k
         ysxQLxw4fzjWSCIcEflgsHzGOXrwLOs0+TtpuN+tDYVl1VKgt6lRv4yv+eHtY6u5opVK
         KzTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785261283; x=1785866083;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dZJ4aLAHmL8c3AcQzheRDkRATQofVjSdwl8y9/FgaD4=;
        b=MYrxsmO0qV73VOS2PzpZDokmweZbU8/grUMTsyBwzokw0+KYC4u6EKWZJHqUnVshxm
         Ya1hlt4lEj9QXBuXOFXVqnKT+af8fXorYsT2xv8SHVaMprfAn3RJ9UHtyiaDG08/e5zK
         lZfFkCwQgGJmUB020HhZuLFwH7SMDNGThTk5iFbIpvxfzDjRVzqh0F6mfYE6dnxRP3Qp
         dzI251E4CeUArDx89H53LlWLvmWO4377e+v6um0vvzDMqjROkOcvaIzrQqU99Tf1uLqO
         Kb7m7r7N/BONEpDEGsGj6Za4hTOsxIHmyr1M0tbb4q5BP3pAUOLW4lUiOGlwwiw0K380
         pEaQ==
X-Gm-Message-State: AOJu0Yz+PyTSZK6Apm5p5Lvf2FdVs4MeXjLSrIZhfyrhA6DR4qhWUoRS
	etMON4JW51ss2JEUrp+hUd/7i65Vs63fVl5AFQdtWfnKLwIpZz4mJ/DjB2SLymT8rB2KcCkPLS7
	BqHwP9GOqsr6q/ZoAX0b8InH00OVN17k=
X-Gm-Gg: AR+sD12G7MPKjLQnXhKFPtHs94h4w1fiUdQhKxRvh2vt7f5FYdN/PQ1wzy+UIo3YHyS
	e/OBpt8SUYAZe+zHWOXZKiiqWGrC9HR5g3VNebi+5GfCSXnC5Y+qz+VOIoBziPGBBa6vCr1sEOJ
	4FSLHf5btbj5YRMKklmp28XsK2Saav1ZVXXqgDFNTYAKEX7gGW2npLmap9GYERtudI//XPbmv5R
	j2C00oKztMirDGfUz5Yf6d44iaUZLVmHNJ70rPRlE9bny5EP/f9VQLuiOG6xQ==
X-Received: by 2002:a05:690c:3705:b0:7ba:f690:70be with SMTP id
 00721157ae682-81f9908e6bcmr13921127b3.7.1785261282891; Tue, 28 Jul 2026
 10:54:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260724190813.1458271-1-ameryhung@gmail.com> <20260724190813.1458271-6-ameryhung@gmail.com>
 <d8dd78c7a3d7f023ae115808cb1165f61916b371.camel@gmail.com>
In-Reply-To: <d8dd78c7a3d7f023ae115808cb1165f61916b371.camel@gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Tue, 28 Jul 2026 10:54:32 -0700
X-Gm-Features: AUfX_mxnwUQcMbr9W8LlnvqlQ0Lw5tplkDtdyElFUaABng-QLnBqjrsSLwN1xQU
Message-ID: <CAMB2axN8dgqBZvNfyQeyWxsjWe=Zeu+QKFkABbL9HwYeq96NZg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 05/18] bpf: Check helper and kfunc mem+size
 arguments identically
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org, 
	daniel@iogearbox.net, memxor@gmail.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 27, 2026 at 1:39=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Fri, 2026-07-24 at 12:07 -0700, Amery Hung wrote:
> > Helper ARG_CONST_SIZE and kfunc KF_ARG_PTR_TO_MEM_SIZE memory
> > arguments already share check_mem_size_reg(), but only the kfunc wrappe=
r
> > check_kfunc_mem_size_reg() ran mark_ptr_not_null_reg() on a possibly-NU=
LL
> > pointer before the access check. That call does more than clearing
> > PTR_MAYBE_NULL: it converts special map-value-or-null registers to thei=
r
> > real non-NULL type, e.g. a map-in-map value to CONST_PTR_TO_MAP. Withou=
t
> > it the register keeps base type PTR_TO_MAP_VALUE and check_map_access()
> > treats it as raw data.
> >
> > Because the helper path skipped that step, an un-narrowed map-of-maps
> > value could be passed to a nullable helper mem argument (e.g.
> > bpf_csum_diff()) and read as bytes, leaking the inner map descriptor (a
> > kernel pointer). The kfunc path already rejected the same program.
> >
> > Handle the possibly-NULL pointer in the shared mem-argument checking so
> > helper and kfunc arguments are verified the same way, and drop the now
> > redundant check_kfunc_mem_size_reg() wrapper. Both paths now reject an
> > un-narrowed map-in-map value used as memory.
> >
> > Signed-off-by: Amery Hung <ameryhung@gmail.com>
> > ---
>
> Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>
>

Thank you reviewing the patchset!

> ...
>
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 468702b09c50..2e56f726c12a 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -6873,7 +6873,14 @@ static int check_mem_size_reg(struct bpf_verifie=
r_env *env,
> >                             bool zero_size_allowed,
> >                             struct bpf_call_arg_meta *meta)
> >  {
> > -     int err;
> > +     bool may_be_null =3D type_may_be_null(mem_reg->type);
> > +     struct bpf_reg_state saved_reg;
> > +     int err =3D 0;
> > +
> > +     if (may_be_null) {
> > +             saved_reg =3D *mem_reg;
> > +             mark_ptr_not_null_reg(mem_reg);
> > +     }
> >
> >       /* This is used to refine r0 return value bounds for helpers
> >        * that enforce this value as an upper bound on return values.
> > @@ -6910,8 +6917,14 @@ static int check_mem_size_reg(struct bpf_verifie=
r_env *env,
>
> Nit: change the prototype of the check_mem_size_reg() to have 'access_typ=
e'
>      declared as u32? As it is no longer an enum, but a mask.

Make sense. Will change.

>
> ...
>
> I think there is a followup for this patch, consider the selftest
> added by the next patch:
>
>   int mapofmaps_value_as_helper_mem_buf(struct __sk_buff *skb)
>   {
>         __u32 key =3D 0;
>         void *inner;
>
>         inner =3D bpf_map_lookup_elem(&outer_map, &key);
>         /* intentionally NOT NULL-checked: reg stays PTR_TO_MAP_VALUE_OR_=
NULL */
>
>         /* @from is a nullable read-only mem+size arg; outer value_size i=
s 4 */
>         return bpf_csum_diff(inner, 4, NULL, 0, 0) + skb->len;
>   }
>
> It reports the following error with this patch-set applied:
>
>   ; inner =3D bpf_map_lookup_elem(&outer_map, &key); @ verifier_mem_size_=
reg.c:55
>   5: (18) r1 =3D 0xffff88810813c000       ; R1=3Dmap_ptr(map=3Douter_map,=
ks=3D4,vs=3D4)
>   7: (85) call bpf_map_lookup_elem#1    ; R0=3Dmap_value_or_null(id=3D1,m=
ap=3Douter_map,ks=3D4,vs=3D4)
>   ; return bpf_csum_diff(inner, 4, NULL, 0, 0) + skb->len; @ verifier_mem=
_size_reg.c:59
>   8: (bf) r1 =3D r0                       ; R0=3Dmap_value_or_null(id=3D1=
,map=3Douter_map,ks=3D4,vs=3D4) R1=3Dmap_value_or_null(id=3D1,map=3Douter_m=
ap,ks=3D4,vs=3D4)
>   9: (b4) w2 =3D 4                        ; R2=3D4
>   10: (b7) r3 =3D 0                       ; R3=3D0
>   11: (b4) w4 =3D 0                       ; R4=3D0
>   12: (b4) w5 =3D 0                       ; R5=3D0
>   13: (85) call bpf_csum_diff#28
>   R1 type=3Dmap_ptr expected=3Dfp
>                   ^^^^^^^^^^^
> That's not the right thing to report here.

I will include this in a follow-up patchset.



>
> ...
