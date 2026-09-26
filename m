Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20CE7383323
	for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 16:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=148.163.148.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790441803; cv=pass; b=vDdZ30CELGqNbsSpANcdGPL0Tzcwd4VtnB88PHVoon6aNL675NevUy/Lg3jLrdIDFH3KXdgFUbSLk7fh0iLb/wKvnYBrrEjdYRbNhLZUspm8vU+mVQZa49PqgIYNX43v0V/ogIjQPBf8blueRUSwNLaVgwtPNU29k/vY36zaSMU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790441803; c=relaxed/simple;
	bh=XTck7I2DLVVO4cPgP5cHU3oQ0QFa64VQLKW2DcsV8Zg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ISaHXPNN4qvvRCJ+xUdTHVnFja58W2HfjEslvNOJaoifh3qUd3R/sX7cgAsZQZABkCubOx/1kw+iGFybG0RP5ME330ok6tMhSpWbkJIVHB7mr3lrjBEXfsXSxvEfwHBi9Yc8bB2/oPmsVeRCgg3Ex5D30xWK/b9t6UTg3PPm5kU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=WzVm3Hjf; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=LTR3YHBa; arc=pass smtp.client-ip=148.163.148.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="WzVm3Hjf";
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="LTR3YHBa"
Received: from pps.filterd (m0354651.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68QFPo41685913
	for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 16:56:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=0twsz6/zBP/tqc78tmHOP17EJdmzYzM420jrTW2g64Q=; b=WzVm
	3HjflFnzyr89YO1AfXeqIvlgbEr6aId7ax3AtQp5nJMSnnq0ZAL94fRqTMu1ryEl
	1AFhP/beH/wq0j+DtCkD4BLwOXN/wVcidJMygzRK5KOav7KvdWC03YsscXEfCqok
	2d6fuSiM5JjhPxG9WmXj6CVIEA2UZRgJYOMR8iBwz3c1FZyD45FbPoMuOMeIAa82
	bnYl/nSDOvy6c5FUN1UWkJyZJSvofWshPTjubkJp1vE+o28ylr+sgcIy5014UL9J
	rHSZOUllBLHbHkmmi4jelg+iWhCE3EnVu5afkWxIF1h3p5nXod7R3Bkv4XHyI0WP
	9Il7lhrFl6moy7Fy8A==
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com [209.85.128.197])
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 4gwm76vweb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 16:56:34 +0000 (GMT)
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-893d2c627b4so28916307b3.3
        for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 09:56:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790441794; cv=none;
        d=google.com; s=arc-20260327;
        b=nryQsQAAO06WchMAHldTjGWp/znyQArLwb8sjWZLpfejTTJQ+t3Rs5UVUKAV2MYOa9
         SYU+Q5vXxNVVdmCRqV8MvtvUWmE4E1v9mosNgiSP/4niu/HZWhNbt5G4KB98At07zL8u
         DJxbOo6SCUpc+UYBQ7mFAPKres8b+DYyccH4HGussClpfHs2z3mJlvl7ZwPmvmZRpoQi
         RCMTgNv3hCypOTRw4nYoG9mi/VNmr/6wuzmV5CvsDpcC916sWSV/HKmlN7gznL+Tw8Nj
         mS4GK12Q+1TJEve5+nBhgy1bfj/vZSIDNA1pvUsL2ou/FutBToJhlN6Rx0LeU8biHQgI
         dahQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0twsz6/zBP/tqc78tmHOP17EJdmzYzM420jrTW2g64Q=;
        fh=gRVdEfKsy6bBYj2FtlGsH3p7h37Tvsw1/iQP5r5HM4k=;
        b=P6vA0cOutBWxmSG1yUFxPF7OXM+CELcunW07NFI11oVQEswby9z++Y0mVT/mZ/1TDO
         eEZCehMWJkG7z9I7CladVys/BVV9wZfwpgCEWgc4t1pOFPARUB2bNSMPdASj43sWNta8
         42uGczvtfcrQ9A4/GnJZaerXbaPxxfKCwd+ekcCJHYvGLq7JMvB1iY8LnfaIP48cz1q/
         +DNg9+0UDbQFE4LvJhOjToaYi2WTjiNiN6FZPiRkBzGCrw27qys7kCm7tqsz7fqkFuRb
         /7Wov0D2h1QDj0SRcLp9sk8IUMA4X+UkneKA0PaODa5w6QgCpNDkVVRywTYvJgzfFEWi
         fVxg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crowdstrike.com; s=google; t=1790441794; x=1791046594; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0twsz6/zBP/tqc78tmHOP17EJdmzYzM420jrTW2g64Q=;
        b=LTR3YHBaNcCH0Fb+6+/hENNGU0hOoDV53NLvEXEwkWFgueZQ/BvbUl3jE/agxRDD1B
         rucRfnwmCbiMwfGhafs2OOQrFSoMQJ/JTsrWvkh9ZKfV5w/ro8R3tmyFC0uWAY8U/81D
         NIQ6DKkNguEUlwsyR4+wi9d1JW56d7K/wGmPdv3KgRFts48crBkyWxmtfxE32I9NQbak
         EI+REJUgdKeQR9uULP/kK8T+Gwb6jMzRJ60P+3MQo8IrNbMrhtQPE2HGBtNuL8UIPvB9
         8NfD+caqBgZqeddNf/hcREJUgtHT3Bv9k2OzfsHWGDHjF0V8hSs5OUocixFwkmKTM9VM
         cYLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790441794; x=1791046594;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0twsz6/zBP/tqc78tmHOP17EJdmzYzM420jrTW2g64Q=;
        b=eZ3PkxpOfdB190LJ9gmEn2K8hi6VzX1TyWoSH4pSAAPnD/o4LuyCcqTi2VeLISRDAJ
         PgTb19TpJFk3RWyF+zT8Vg2j9Yf5QcUPn9EABCJin36gmBQnmu/tqXT4dF0j5aWcsBX4
         Zim7r6yqiEDWItAF8Nuy8DM2NKf9EPDJq6py0SKS5RXWwyP0EZUp/+iAiFOZzVb9fjOu
         3PFA630RG1Yg+h2SyKnvVXJIOTJbuIJxpuKLvdLaju6nZbgOyxWeN7aUyQ/BHruXEkC0
         qgABlJZvwTEexYetW+1XiBTxAR2c6321O/WzlYHyagGc6b5CWze2++pIJZv8FhhSweCh
         YKnA==
X-Gm-Message-State: AFq9FYKAGx818SQfQus/qKRV5k/G3mzwTmcyqWTl3WeCsCC0MQL4VrXl
	HI1UnlUP4PybXhAoTqc4bnG955Aus8Q1QHvrodnbL23F3UW718B9mbD96ugcYQ445d03KlkLTEx
	0AOJX506qAw3bp5bTJ7K0XMKGjS5ZAXw6oUY+snHP+tQVA3NFMO/PtTMvAcpqNZ8YkPZwvNtcs9
	/XlpQAVvQjuwY1D3LGKNfHDsWpDydpvaTvT8bPoZw=
X-Gm-Gg: AYBFou23unDTnIvER/8BiK52QRxp+SEuOKkQVKBtpaERpoHNQ3nFbVdzWnQR3gFAAsC
	lUuwx2czlc53xFKWBpyIBDUqzutGlTE8zL9O4tJgz76W1khrCU6BbNwiilBG4MigPXKfHn042xq
	OF00yGC+WSv6M578yrCQWsb18NVaUwn84hDuQDKeGiOsVWNFPQs/ZYxK6n5A==
X-Received: by 2002:a05:690c:c513:b0:8a8:87e6:8f78 with SMTP id 00721157ae682-8a887e6a6c9mr19431047b3.47.1790441793953;
        Sat, 26 Sep 2026 09:56:33 -0700 (PDT)
X-Received: by 2002:a05:690c:c513:b0:8a8:87e6:8f78 with SMTP id
 00721157ae682-8a887e6a6c9mr19430997b3.47.1790441793408; Sat, 26 Sep 2026
 09:56:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260923232939.1886328-1-andrey.grodzovsky@crowdstrike.com>
 <20260923232939.1886328-3-andrey.grodzovsky@crowdstrike.com> <CAEf4BzY2vgk3nrEY_0P4y=t7JzCi8+BdDZM4nFO3bxkXP8Ri5A@mail.gmail.com>
In-Reply-To: <CAEf4BzY2vgk3nrEY_0P4y=t7JzCi8+BdDZM4nFO3bxkXP8Ri5A@mail.gmail.com>
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Date: Sat, 26 Sep 2026 12:56:22 -0400
X-Gm-Features: AclHuK9B-Q9CVln9iIJypo0bBjILNWXUdhmfryndcSc94MZkdmTitQnuyXJE37A
Message-ID: <CAOu3gNiVvPvmKQwbjouoQ7zD+w4mOXvNNv+QCZ5bCy3zKFj9+w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 2/8] libbpf: BPF programs manual loading and attaching
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org,
        martin.kelly@crowdstrike.com, slava.imameev@crowdstrike.com,
        linux-open-source@crowdstrike.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI2MDA2NyBTYWx0ZWRfX29G7fbt3IN6L
 /yngYd9Qvwq2DY/w3PEeUN95InjkUUlYZ2vjRXkKZofdfc6F9j5LN9Ob5IpR6UTDxMq03HD8VSH
 FSaz1EQoTM0uYGSMnfPs12uOcASnnOY9WimPfedY5KOitw/X3yz2smp0srtRSZrJdO7K3U3HHHW
 hAvkL2XoW9NfZS+W/HfsdgG/2e1hHuPGa+OzVZu9pQce+fC1+qnyBv5oThlRN2LK/i9oLRgs6bP
 HTQ/HNRmZlYBKiVrVcZdq3Y/aiAK7eR8utqMv7DuNPtCQN9jJxQHxDNlyP0OT2xDGnlYQcGn+UV
 rSg2th5/DsjFz98i+Gn7uSQXErwpV3+b6B4sWUkDqFxHxcP/RkxYuJguoQqmE6ILWC/NApUugWE
 HFq/wdWL8T6cK4ZB5J/5qCxWioXJ2E/PALw+Hq79sm6rRxm9lWoZ6Ob3xLqHUAn2r+K2lYwwq46
 tlE9c9yEXh5cBJRPuzg==
X-Proofpoint-GUID: wIyPZOnBWyq52VdZ4HtcAl-a0u01BQLN
X-Proofpoint-ORIG-GUID: wIyPZOnBWyq52VdZ4HtcAl-a0u01BQLN
X-Authority-Analysis: v=2.4 cv=QvLLTlyd c=1 sm=1 tr=0 ts=6ab7f943 cx=c_pps
 a=0mLRTIufkjop4KoA/9S1MA==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=KZhmPCYDdY0A:10 a=VkNPw1HP01LnGYTKEx00:22 a=T2KQ53IYiC3MXPrxx8bB:22
 a=b3B37AjAgz0HnGB3MuNd:22 a=pGLkceISAAAA:8 a=pl6vuDidAAAA:8
 a=WKDqPFQOycBVuWFf9-YA:9 a=QEXdDO2ut3YA:10 a=WgItmB6HBUc_1uVUp3mg:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI2MDA2NyBTYWx0ZWRfX7dsm2cfka74K
 tVjeqF/Gr/YE0R8BkvX6Sad0TCPD+YgcAmxcbkPyiaWd2JubM3SVVMXcpbBhY/FIlMCe86JKNXn
 6n6oMKnanftNYmwNw+Ag8KIPok6RfdKgRGiuI2MbUB7u52N8N9Tg
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11917
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 impostorscore=0 phishscore=0
 priorityscore=1501 adultscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609260067

On Thu, Sep 24, 2026 at 7:18=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Sep 23, 2026 at 4:29=E2=80=AFPM Andrey Grodzovsky
> <andrey.grodzovsky@crowdstrike.com> wrote:
> >
> > From: Slava Imameev <slava.imameev@crowdstrike.com>
> >
> > BPF programs designated as manually loaded can be loaded and
> > attached independently after the initial bpf_object loading and
> > attaching.
> >
> > These programs can also be reloaded and reattached multiple times,
> > enabling more flexible management of a resident BPF program set.
> >
> > A key motivation for this feature is to reduce load times for
> > utilities that include hundreds of BPF programs. When the selection
> > of a resident BPF program set cannot be determined at the time of
> > bpf_object loading and attaching, all BPF programs would otherwise
> > need to be marked as autoload, leading to unnecessary overhead.
> > This patch addresses that inefficiency.
> >
> > A manual-strategy program is loaded via bpf_program__load_manually()
> > and unloaded via bpf_program__unload_manually(), gated on
>
> forgot to update commit message?

Yes, I will fix it.

>
> > bpf_object__prepare() having already run (BTF loaded, maps created,
> > relocations applied) rather than requiring a full bpf_object__load().
> > Manual programs are skipped by the object's own autoload pass.
> >
> > Signed-off-by: Slava Imameev <slava.imameev@crowdstrike.com>
> > Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
> > ---
> >  tools/lib/bpf/libbpf.c   | 200 +++++++++++++++++++++++++++++++++------
> >  tools/lib/bpf/libbpf.h   |  32 ++++++-
> >  tools/lib/bpf/libbpf.map |   1 +
> >  3 files changed, 204 insertions(+), 29 deletions(-)
> >
>
> [...]
>
> > -       obj->btf_module_cnt =3D 0;
> > -       obj->btf_module_cap =3D 0;
> > -       obj->btf_modules_loaded =3D false;
> > -       zfree(&obj->btf_modules);
> >
> > -       /* clean up vmlinux BTF */
> > -       btf__free(obj->btf_vmlinux);
> > -       obj->btf_vmlinux =3D NULL;
> > +       /*
> > +        * The btf_vmlinux data is needed for manually loaded programs,
> > +        * so defer freeing it in that case to the end of the object li=
fetime.
> > +        */
> > +       if (force || !obj->has_manual_progs) {
>
>
> same condition as if above, why split into two ifs? and really better
> to just exit early if !force || obj->has_manual_progs

Will do.

>
>
> > +               btf__free(obj->btf_vmlinux);
> > +               obj->btf_vmlinux =3D NULL;
> > +       }
> >  }
> >
>
> [...]
>
> > @@ -15375,10 +15431,69 @@ void bpf_object__destroy_skeleton(struct bpf_=
object_skeleton *s)
> >
> >  int bpf_program__set_load_strategy(struct bpf_program *prog, enum bpf_=
prog_load_strategy strategy)
> >  {
> > -       if (prog->obj->state >=3D OBJ_LOADED)
> > +       struct bpf_object *obj =3D prog->obj;
> > +
> > +       /*
> > +        * has_manual_progs is snapshotted once in bpf_object_prepare_p=
rogs()
> > +        * and never recomputed; once the object is prepared, no transi=
tion
> > +        * into or out of MANUAL may change which programs are MANUAL,
> > +        * regardless of direction. AUTO<->DISABLED transitions never t=
ouch
> > +        * MANUAL and keep the looser, pre-existing OBJ_LOADED gate.
> > +        */
> > +       if (strategy =3D=3D BPF_PROG_LOAD_STRATEGY_MANUAL ||
> > +           prog->load_strategy =3D=3D BPF_PROG_LOAD_STRATEGY_MANUAL) {
> > +               if (obj->state >=3D OBJ_PREPARED)
> > +                       return libbpf_err(-EINVAL);
> > +       } else if (obj->state >=3D OBJ_LOADED) {
> > +               return libbpf_err(-EINVAL);
> > +       }
> > +
> > +       if (strategy =3D=3D prog->load_strategy)
> > +               return 0;
> > +
> > +       switch (strategy) {
> > +       case BPF_PROG_LOAD_STRATEGY_DISABLED:
> > +       case BPF_PROG_LOAD_STRATEGY_AUTO:
> > +               if (prog->load_strategy =3D=3D BPF_PROG_LOAD_STRATEGY_M=
ANUAL)
> > +                       prog->autoattach =3D prog->saved_autoattach;
> > +               prog->load_strategy =3D strategy;
>
> not completely follow the whole saved_autoattach thing, and the commit
> message doesn't even mention this aspect... why saving and restoring
> autoattach if we can leave it as is and just ignore if load strategy
> is manual?

I will update the commit message. Please see the reasoning behind this
in the next reply below.

> > +               break;
> > +       case BPF_PROG_LOAD_STRATEGY_MANUAL:
> > +               /*
> > +                * Manually-loaded programs are not supported for gen_l=
oader.
> > +                * This is because bpf_object_load_prog is not called f=
or
> > +                * manually-loaded programs, so such programs are not v=
isible
> > +                * to gen_loader. For this reason, prevent calling
> > +                * bpf_program__set_load_strategy(MANUAL) when gen_load=
er was
> > +                * used to generate a BPF object loader.
> > +                * A gen_loader implementation is being called for auto=
loaded
> > +                * programs and defines its own model for loading BPF p=
rograms.
> > +                * To pass a BPF program to gen_loader, set the program=
's load strategy
> > +                * to LD_AUTOLOAD.
>
> you are fixing this comment in the next commit
>
> and the comment doesn't have to be that verbose
>
> pw-bot: cr
>
> > +                */
> > +               if (obj->gen_loader)
> > +                       return libbpf_err(-EOPNOTSUPP);
> > +
> > +               /*
> > +                * struct_ops programs are incompatible with manual loa=
ding:
> > +                * bpf_map_prepare_vdata() bakes each member's fd into =
kern_vdata
> > +                * automatically during bpf_object__load(), before a MA=
NUAL member
> > +                * could ever be loaded, and nothing re-bakes it afterw=
ards.
> > +                */
> > +               if (prog->type =3D=3D BPF_PROG_TYPE_STRUCT_OPS)
> > +                       return libbpf_err(-EINVAL);
> > +
> > +               if (prog_is_subprog(obj, prog))
> > +                       return libbpf_err(-EINVAL);
> > +
> > +               prog->saved_autoattach =3D prog->autoattach;
> > +               prog->load_strategy =3D BPF_PROG_LOAD_STRATEGY_MANUAL;
> > +               prog->autoattach =3D false;
>
> keep autoattach as is and orthogonal to load strategy? if MANUAL is
> set, there is no auto-attach and user will have to manually attach,
> no?

The idea for coupling between autoattach and prog->load_strategy here
is to avoid situation where bpf_program__autoattach will report false
information, if we truely decouple those two and make them orthogonal
one to another we can end up wth bpf_program__autoattach() reproting
true for manual programs which is factually wrong since those programs
(and DISBLED too) skip autoattach in bpf_object__attach_skeleton().
Now, since coupled them, the CI BOT review in V2 i belive also flagged
the need to restore orignial values of autoattach when we switch
prog->load_strategy back and forth and that th reason for all the
saved_autoattach dance you asked above.
Having said that, and thinking more, this is the behavior in the
baseline code already: autoload and autoattach are truly orthogonal
and behave the same. You can have autoload =3D=3D false program (DISABLED
in current terminnology) still reporting bpf_program__autoattach() =3D=3D
true Therefore, by decoupling we simlpy adhere to exsiting convetion.

I will drop this messy logic.

Andrey

> > +               break;
> > +       default:
> >                 return libbpf_err(-EINVAL);
> > +       }
> >
> > -       prog->load_strategy =3D strategy;
> >         return 0;
> >  }
> >
>
> [...]
