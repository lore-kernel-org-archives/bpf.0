Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF43126C03
	for <bpf@vger.kernel.org>; Fri, 27 Mar 2026 21:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774648052; cv=pass; b=QyE5D1gkfuT8WSfUY6sdcaxvAJp505UGjW4wKf+/OYXXtyQ8TVWPn6dgQlUEAEAhRzb4HffQyQfYVqH4f4WNpIzHQGrKYuMkyaw3hx2Pjmo+qioqJvxUMcWZtydpKYa1kmIeMcHf3ECoIDZ0OQDRlFR+N01j0UC7O6Zu5Bwutuk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774648052; c=relaxed/simple;
	bh=m0ogoGa56Kd7FPOw6DSe/hLmOP4ku8lnyAzSSr2Y3/o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hkKwpgQLewDkBXKQNoV0nlpA1fYIlT/KSBN7txW3zuULC8JcLEuVEDVSV4q891w9KmGTOLfigwPx29KqVDnkf1I12kZHKSCspmTfEjp7dDrQHrEDsNVF7VbmTGq2lOG3Dumti8/TipG5/8IvtDxu7KR96EzHB4no/YNGcM6nP1Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mX0s8CCe; arc=pass smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mX0s8CCe"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-486fb14227cso32842475e9.3
        for <bpf@vger.kernel.org>; Fri, 27 Mar 2026 14:47:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774648049; cv=none;
        d=google.com; s=arc-20240605;
        b=b26oJJyo47rDEybsxeCuWgQXK5oRPfYE1Tcm3TtLi2BApGPuxWwgz6Gpc7JOPrXIpE
         c7+hVzA3MrPV4bEa1UaCNbDiCb/FcuRkRQLF11aIaAgqvXKVOINmpnM2Bfdr/4aD+WJn
         MypMocQRLamLtT1wuOhk/WnWyydwgMrZ4Z/OXNC1ihRZeeFmn4000t37JR9/riQUel56
         Ml6ZZMLA+dHxp2HFk0AjIdkPPPJBwQWLLoz4E3EFfrJUAvdEG2o21wOc8AO+JN0b14J6
         kIO6QD3KzLdaMgFcJnt3kQWfP/b3OO0acIBOVNs5EKAkeaiEhpil8FHKOcGVg603r/cs
         kjdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=m0ogoGa56Kd7FPOw6DSe/hLmOP4ku8lnyAzSSr2Y3/o=;
        fh=GEe9OqfB2tM7Tyno7kBRdp2G4rGfDtkA4xLDvs5YVFY=;
        b=F2KDn88nP5ACui8QHuqgAnL7n9Ss1HB4gn24EC1vBXiiGMctb5EcgFqdT3ubz/FoSg
         228PHvg0oI01WIPB83s0xxs8JPoj/bORtNr2OX1fftQ/NfH0SfWW/FsCA8jl4/rIGBW0
         BgJKhjdHwIPHpxr+AAl2WPm2LKQ9KiKX6n+I3EmcqkU1GtFmsLUWjkJVjLp6FsFZqUPI
         MKw6INeY0rTn0UE6QiWSJ197YcqhP2COQt6EMeJRe46xbDqDJNj7pCOO4OUzjy7ybnzo
         wvfcVTMLFXCLVDRo/Wmnc0O9fVCiZmmd9ZDcgXCiiOa8lKo4nurZ8udKsXsjHquyFKdx
         Mo+A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774648049; x=1775252849; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m0ogoGa56Kd7FPOw6DSe/hLmOP4ku8lnyAzSSr2Y3/o=;
        b=mX0s8CCePgE2Cuud7RkrM/jBXeW2vr+AFLBhJrWwXFS8hT3t9HiLNGdJaKAP17FlQb
         FLDIFRXF4S8xvvxGHxK4bCLeP5lC1j8RjgWX7Ltpb5vov6pnkKzWI9GQRlG3H5OFycW7
         gFAcPazerjwhWb8rY/bOjis634n4C9SvCyVbYoUnYxhYicJEoQ2qFnzwCu8cRo+/fYk7
         S0KNBOEqg2/lrBgj7MhaeFqboJQt8w3BGYDw6qLB3OhXhAFjbin4SfIvOM/U2osuYYAM
         08R3LtoChYAnpjmLngYNNi9uqeIjB4X6ucaBiXwwaXr+fUYcEcPgZo5IfSCoMNn0ON/n
         O5RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774648049; x=1775252849;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=m0ogoGa56Kd7FPOw6DSe/hLmOP4ku8lnyAzSSr2Y3/o=;
        b=qcpXnq5Ga1H1tRqldz7nF2dD1UiIJttDGla3KHpN1OaJLhpBBc9ZzuuMuo20jE2Ysz
         21pYF18lcuT7bLZAg6r9S/+zQaeDHyfyEWnFGO7syFoSAilotAfJq+nO/09NN7iSqwFH
         quCgMajq/vCrqEFHCtmw6FAdj9MAvIhU4fxoYdZQWLHJpU+P316F+6eEtl8ABXuZ6MGE
         rXlh17lzjtNe/ZLobLD2JDqFPj2ANC7+ILP1FH9Dwyl22YANM1Wqeyh85Yn2+6HFu7CS
         030yMvy4j5POq4N4aW9tofFjvIwej+WWouSPEymcO7wvI2TrXooCB6zTz+xND7x19CRE
         h+UQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDquntYO8N9Q/LtwaXJT88jOMqPiRgsGLZzXC5kJnpBpx0LbDcn0G2i4iJQ/xK6QLilIE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGA58BiO1ZVx7/qjZY9jrYDBkHuHLCHIz2Zr1/TTcGQNcAmwgz
	2of0bqnj7BXq6Zf1ITgrxaUGzMyjy+2fmL8Da+da4mptIYMpBmBBX0Am8f5rFwwT1MHaM+9n/QL
	ER+1HPc8IeCrPNCnpmZrp52GFRMTAnxI=
X-Gm-Gg: ATEYQzwzqG7FSq8N5/MbBY3V/wynTV4f4H1nALA2/wy9cE7a66m8961ADSe3wA/eiRM
	VsojA1ZwUs+M+eX4/wLGtajx2/9U/WUo2EB0TbMX0F/tcJbf7uD+eguMB/ZggLC08PMfyS4yShj
	EilgKInGqfF1f1ADX/CfVADz3ch/ybzZqFlaQUZ1SMhxS/MlWa3XOgd383X1TTOEBVm+/gNLOwb
	KjWBRLz9Qpo54LCUAF+oWYlIemvNrWWC14NlNV/fxpxxAfO3Ov4MU+BlaK/JL2J2laWK+6qLRxg
	5eOBi5wGUlq8tEBSNsnFrySjQINuCc64oEA1l+9arfAW+DPFKXl7s3k6teDzYE1Sh49OYSEMA4J
	9bsYUN+SE8vSDprLA4ljjUmxyFg==
X-Received: by 2002:a05:6000:2892:b0:43b:4352:1bdd with SMTP id
 ffacd0b85a97d-43b9ea63927mr7093492f8f.39.1774648048799; Fri, 27 Mar 2026
 14:47:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260318234210.1840295-1-ihor.solodrai@linux.dev>
 <CAADnVQ+iXJK46cFcGN-Ta8KGxe7Y+m_DxgWNS=QC-gOWT=WxCw@mail.gmail.com>
 <b040711c-0fd1-475f-b807-e4e0b4324f6e@linux.dev> <CAADnVQKVEYhFXGXJ0u6TWQDe4t=zmq_tLpGKe2n_pOYT-J58qA@mail.gmail.com>
 <21e5333c-0b57-46ce-99c8-f6c414270e70@linux.dev> <CAADnVQ+bj2z0kzLcGTJ62NJgReTvqEu8fn6=7=bn+WKmfe9iTQ@mail.gmail.com>
 <676332b5-1f7f-4c8d-b41e-e2dbbc1d7e4e@linux.dev> <CAADnVQLUTNoa4qXW357CU5e2hP+DpxM=QYK2ZuWHR_aLbmb7Hg@mail.gmail.com>
 <97357814-57e9-498f-894f-4c5dc4e3d0ce@linux.dev>
In-Reply-To: <97357814-57e9-498f-894f-4c5dc4e3d0ce@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 27 Mar 2026 14:47:17 -0700
X-Gm-Features: AQROBzDwh03Yc4V6FHVDrKtxR1kTKPiUmPTVhJOZHmdJM0o5ZVfTtX-RNIcO_oU
Message-ID: <CAADnVQKRDHu=kn1U98jnY1XVk__ZGC1iyRQZdPH1g1=wgA1pWQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/2] bpf: Support struct btf_struct_meta via KF_IMPLICIT_ARGS
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman <eddyz87@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 27, 2026 at 2:08=E2=80=AFPM Ihor Solodrai <ihor.solodrai@linux.=
dev> wrote:
>
> On 3/27/26 2:00 PM, Alexei Starovoitov wrote:
> > On Fri, Mar 27, 2026 at 1:55=E2=80=AFPM Ihor Solodrai <ihor.solodrai@li=
nux.dev> wrote:
> >>
> >> On 3/27/26 1:48 PM, Alexei Starovoitov wrote:
> >>> On Thu, Mar 26, 2026 at 12:13=E2=80=AFPM Ihor Solodrai <ihor.solodrai=
@linux.dev> wrote:
> >>>>
> >>>> [...]
> >>>>
> >>>> The above works, and the question now is if we like this mechanism
> >>>> more than current setup with explicit enums.
> >>>
> >>> Got it. Thanks for the explanation.
> >>> Your approach does sound a lot better than explicit enums.
> >>> Make a proper patch out of it.
> >>>
> >>> If we do this can we remove <counter><line> approach everywhere
> >>> while at it and only use named ?
> >>
> >> This crossed my mind too. I'll try to *replace* the suffixes and if
> >> it works fine submit that.
> >>
> >> One inconvenience is that with named suffixes BTF_ID() macro will
> >> have to accept an additional arg (the list name), but I think
> >> that's ok. We already have to pass struct/func everywhere too.
> >
> > and that name has to be unique.. I think it's fine.
> > I'd do such change, and reuse all of BTF_ID macros.
> > So that only BTF_SET_START line will differ.
> >
> > The overall diff stat shouldn't be big ?
>
> Depends on whether we are refactoring BTF_ID, or just adding new
> BTF_ID_NAMED set of macros.

I meant that BTF_ID_NAMED(special_kfunc_list
would somehow remember that it belongs to BTF_ID_LIST_NAMED
that started this "scrope" few lines above an actual BTF_ID(..)
?

or for BTF_ID(func, bpf_lsm_bpf_prog_free)
we consider 'func' to be that 'scope' ?

we don't have uniqueness across files:
BTF_SET_START(untrusted_lsm_hooks)
BTF_ID(func, bpf_lsm_bpf_map_free)
BTF_ID(func, bpf_lsm_bpf_prog_free)
..

BTF_SET_START(sleepable_lsm_hooks)
...
BTF_ID(func, bpf_lsm_bpf_map_free)
...
BTF_ID(func, bpf_lsm_bpf_prog_free)

but does it matter?
This new BTF_ID() will define multiple extern u32 with the same name.
Make them weak since they point to the same id ?
