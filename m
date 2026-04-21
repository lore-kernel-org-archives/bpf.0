Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB09E370D56
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 18:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776796328; cv=none; b=BPVo3piiUHetQLpWA7VqHVoRUXCVmPAzxAWazpMHPJocHTNoT/z7akPsVDgQVPYLFzVehZE4B2ca1koRs+QnaVxRdOfMBGUJdBBNIbJXHVg4HDkJyfY7ZkCMfYIHG9T34U2lgur9JrHgNirx1JrmVI6PtK3YMZz4bVt4p8Of4U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776796328; c=relaxed/simple;
	bh=ij+QIHpFUQyZIYh8EZt9NenTS4afIzL27SdoH8Ox4Ck=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bwyCKHjoyWvTjxOoB3zQ93fvhTAYBTRbyHrlgmejMR2tsp2os/cvZJocBAEYgnJRphJW3U2sYe5UQe7Q9uH/EfAFOSUUWl5sQl5aFN0xPAqikHtSMYZCGnrBleFBYxPn1AYX7fVWrQkVUu9RV89CzN/h+PfI+Q0TCrxF6kUu2yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hyC4YRUS; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hyC4YRUS"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-35fb0bb27e7so2981861a91.1
        for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 11:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776796321; x=1777401121; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lK7+3C2uByBRR9Frq1UsNZvguw0WhkY54cekKawpE+o=;
        b=hyC4YRUStJzOC1CqClkrhf7MHDs/uwjYMeL3q5mezeVDBDTmRBkVLgFsRWFYc+VxDr
         Mkpu+rcsA4b+Vb+RQ/NL58z7ZBDZDDo9z0eE2iOQO5pEONmtk0MYob1u2KdKQy6ofZlX
         DeD97f2Pv1IUZsUpnWVGKYTozk4PaBMBqVEN3nMzLxsmdV3bjmlpwP14fcs/alXmE7ww
         rstmdhe8bQDGAwwB9tE9JayF1PmoccfGon5M2ZjpyrVuDshKjNysGYpwM5HmdExPrHCj
         /cUR3qgzK/iuIU5EcnRvukKbJNG4KqXNzgB/Moq0QcbvWqp0fYAHGjrMSM/FaKJBVy+G
         bc4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776796321; x=1777401121;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lK7+3C2uByBRR9Frq1UsNZvguw0WhkY54cekKawpE+o=;
        b=eGjcBjsfrKXFX5TTPsyLb5ZEm2CJzTVPpZucSPzp+pvonqstAswZ4wEH7OFq/hsQwi
         azvMsU1T7m2EW0fN8djXofXkOjXDwnnaLl6nvY8RIjF0WX4dAxOVmNMcz3MVsFOqQWDX
         6zPmw4TyaSz7/OGL2y6262BFjiW3Hi4TIj2oD6RniCKO0sf/XFXicIoOiAiUjvHZzMRw
         nAbZoI3gjoeEB7d2Mk581+5x+MQ4a+hI5YHF4pHxVFXi0N47CgulKURuhac+9aLuiNsj
         P2pC2hY7mK73f9CGX1/dnfZMZ0zs+CFSCDRBRczS9CwNZwv10/NRLD7JEE55o5zJLvSD
         47dw==
X-Gm-Message-State: AOJu0Yy0xf6q7cSj/m0aqC5bfkEkwAuZ8PlRrbL0mISIBdU4nfRlnYdq
	J80nnwvTJX8Bfgqr/V2cc4JYGdEjCCSR5+6MVFfoWTpRYjQ+y4A/z2yFf+C3d4w3
X-Gm-Gg: AeBDievq4tNJp/xeyPdPnSKg5vR91X0JiuyZHzA4IToW0kVaMJlHl7P0GFOov08BIUx
	TD2E969OLjbXV+W6ZPVSJtlAH27fsMG+WcHIufI9IGIzr0BJ7Sd0KQLnU0OWwrOllc0ZoxZNDaY
	/v0az7GkvPxR8yf/TsGGEW1hQ61Vfz3f9ntM0xnEAyDPkKvtsB63W0RlzimayOVlc/B252/mNHu
	Bjv14tBuPR/9yDGkOuyLJarn0w0nNbBEUDAFcRMHKbJXEzWI2/62873bXv2HqMfhjH4TP+ZMANV
	7PA2GphkeKPTsmuvwNUUA5CyFXNHRGDTfwPynRy7fgcx4toI5BsjPkhvNFON6vf7h6Lw08k/kzE
	N0HsVmpOmvjSDTQzpfqibylegl5ErDqyNQdbsEqoj1EOnNhP9OUp5B2YIKAvPhqwMqe13cUuUvE
	y5p2+8CQ4ZJmsY+EJdv3P8hHBbXwk8wVPvFoHXVkrDuLu9dlRkJnyNugPSjmQoCvQ=
X-Received: by 2002:a17:90b:2e45:b0:35b:e4f8:7cc7 with SMTP id 98e67ed59e1d1-36140473f8amr18060116a91.17.1776796321078;
        Tue, 21 Apr 2026 11:32:01 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-362bbf963c9sm4437875a91.16.2026.04.21.11.32.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 11:32:00 -0700 (PDT)
Message-ID: <273f0062e24d927208c46da5b0a323067ab876e0.camel@gmail.com>
Subject: Re: [PATCH RFC bpf-next 3/4] bpf: replace min/max fields with
 struct cnum{32,64}
From: Eduard Zingerman <eddyz87@gmail.com>
To: sashiko@lists.linux.dev
Cc: bpf@vger.kernel.org
Date: Tue, 21 Apr 2026 11:31:57 -0700
In-Reply-To: <20260421180631.B0A44C2BCB0@smtp.kernel.org>
References: <20260421-cnums-everywhere-rfc-v1-v1-3-8f8e98537f48@gmail.com>
	 <20260421180631.B0A44C2BCB0@smtp.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-04-21 at 18:06 +0000, sashiko-bot@kernel.org wrote:
> Sashiko AI review found 1 potential issue(s):
> - [High] Incorrect range constructor used for BPF_JSLT (signed less-than)=
, causing verifier soundness issues.
> --
>
> commit 1fb11732c3d626f4a1777699934aa05d07b7eb56
> Author: Eduard Zingerman <eddyz87@gmail.com>
>
> bpf: replace min/max fields with struct cnum{32,64}
>
> This commit replaces the independent s64, u64, s32, and u32 min/max field=
s in
> bpf_reg_state with two circular number fields, cnum64 and cnum32. It also
> refactors how bounds deductions are performed and updates conditional bra=
nch
> refinements to use circular numbers for set intersections.
>
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 2e896f5d92a2d..90ed32f064650 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
>
> [ ... ]
>
> > @@ -15861,38 +15209,54 @@ static void regs_refine_cond_op(struct bpf_re=
g_state *reg1, struct bpf_reg_state
>
> [ ... ]
>
> >  	case BPF_JSLT:
> >  		if (is_jmp32) {
> > -			reg_set_srange32(reg1, reg_s32_min(reg1), min(reg_s32_max(reg1), re=
g_s32_max(reg2) - 1));
> > -			reg_set_srange32(reg2, max(reg_s32_min(reg1) + 1, reg_s32_min(reg2)=
), reg_s32_max(reg2));
> > +			lo32 =3D cnum32_from_urange(S32_MIN, reg_s32_max(reg2) - 1);
> > +			hi32 =3D cnum32_from_urange(reg_s32_min(reg1) + 1, S32_MAX);
> > +			reg1->r32 =3D cnum32_intersect(reg1->r32, lo32);
> > +			reg2->r32 =3D cnum32_intersect(reg2->r32, hi32);
> >  		} else {
> > -			reg_set_srange64(reg1, reg_smin(reg1), min(reg_smax(reg1), reg_smax=
(reg2) - 1));
> > -			reg_set_srange64(reg2, max(reg_smin(reg1) + 1, reg_smin(reg2)), reg=
_smax(reg2));
> > +			lo =3D cnum64_from_urange(S64_MIN, reg_smax(reg2) - 1);
> > +			hi =3D cnum64_from_urange(reg_smin(reg1) + 1, S64_MAX);
> > +			reg1->r64 =3D cnum64_intersect(reg1->r64, lo);
> > +			reg2->r64 =3D cnum64_intersect(reg2->r64, hi);
> >  		}
> >  		break;
>
> Are the unsigned range constructors cnum32_from_urange() and
> cnum64_from_urange() correct to use here for a signed less-than compariso=
n?
>
> Passing S32_MIN and S64_MIN into the unsigned constructors might cause th=
em to
> evaluate min > max, resulting in invalid or empty ranges being intersecte=
d with
> the registers. Should these use cnum32_from_srange() and cnum64_from_sran=
ge()
> like the BPF_JSLE case does?

This is a bug as well.
