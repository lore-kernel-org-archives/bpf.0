Received: from mx0b-00206402.pphosted.com (mx0b-00206402.pphosted.com [148.163.152.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E0B214A9B
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 00:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=148.163.152.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789605573; cv=pass; b=Gm5pDJkIvjCjC5Fh5++n2UlePovGGGKrPdVY5SM1s2fnwtuBj/cqiSXXFw2ZHRHS4oQvMKQEz22QdHdCjEvUijbsn2BC56vx9h8uzT2//GcYWSM1QK9cW0Ka6N+S+N6REWCv0OjWaM2+09xJd2ABYR8jXcZhi9OIC8W4Mp8gtKY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789605573; c=relaxed/simple;
	bh=bf7sG3+hQbyfzvv/rnDwaLVyCpml0Tk8jDvZewVC1NE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UmuBCKyQZT9POKT3Ofu47BmO/TeXZLtZuXtc7uB/3pGr/mgKivYLNhLQDhLCeekZvmcXoZZIhKF3aFzEJi8Mhj3xvJcdU8diJZWpAfpgSDdco8JDohKhNaMmysl0pL4cE3+rZy7BTwtJIPN2hsly0tL6zYyZ0Oe5Qf0SBia6XLo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=SlHzAmg+; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=lJqj7Jis; arc=pass smtp.client-ip=148.163.152.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="SlHzAmg+";
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="lJqj7Jis"
Received: from pps.filterd (m0354654.ppops.net [127.0.0.1])
	by mx0b-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68GNifx71205795
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 00:39:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=2ddDCg8mwUaWtaw9w0u3MPxg8tw+xllyDfgOCSBIsSE=; b=SlHz
	Amg+/sXLYdD8u6O5SOTCUiB6BtPlTnxfto2t/Vg3kaWu/ujWUeAHV8J6LTcCv4PO
	I/FHuj3C3f1RJZiDRDYNOju+71LvBXHHHT6SD20fzJytKDsMbA9R08WPvcfwAdFB
	mov3OIfV/n5yFop2gIGNyNxfDUx9oCMAGVvSydQ2umiL3CO0j1KFGSgvlu4wfr5P
	wznBV2hm7T+GfQ/g0V1RaixTaaJ3fndjLihy+f/Ddw7+8TEACxZeMWW0IddTFAMy
	h8L5+ibUlypmDi0uvFsWD+en4LWfl1afYGb8Kjp2Sjb3P1PFf6cdZ6PNHOs86eB6
	AwGsQ+duuJ64EMC7Vg==
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com [209.85.128.197])
	by mx0b-00206402.pphosted.com (PPS) with ESMTPS id 4gqyajhj9g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 00:39:30 +0000 (GMT)
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-8789206f693so2232437b3.3
        for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 17:39:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789605570; cv=none;
        d=google.com; s=arc-20260327;
        b=rx/tJcaDPxBNE2zbzJaVpkbhx0TyfQ70NECTuc3KwM694bQm2fsWywfFN1aJ/PpAQE
         vfp7VyojS40o9Wpmpxc00FP5YZlE+WuWziC2aQ2YThzC7S0UJPXCVj+ijSt6SSMGh+GX
         AwxyN/PuBB56PQCquvf9RswrmCzPjjrF9m66+14Lr/zgCjgXtN6JUCLS0caWvdvjYE+s
         8sTsYjrfrjWcdi4d+mSmhuMuXVenGFYewIK3bHaup+SKpkoKsdh8EdCB6jUMhzrAAT0D
         TPqObj4bUGKebcQmvey2E39tywkWFCv8otnLVzT3meFE2T7qIsOMzadoSyulS/me8WNh
         i1MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2ddDCg8mwUaWtaw9w0u3MPxg8tw+xllyDfgOCSBIsSE=;
        fh=qt29tRmMv9RTRwthwC9TubzTxuwxPM3tixKceu/18cU=;
        b=mS9zNe0SkfBKP4B50bya2mMx2S0p1IfLtLmmsm8rEOhNR7vhthlFSJ6X555mfbF5Sf
         +sHYGtR3uc0dFbEeJE1Up5H5oH04WNOTk58gSjANcveO3AYgz88OvmYxNINmcn00F7L5
         pLkJtgSuepwm/D6zFmOz5V0wvyouuG/LXNY8vRR0m/xv4OkIHK2KBdRkw9zM6to4d9M/
         lmj0f2t8oInPji5FW6Nm9pUnxTVqJx45B2xaQQPo+tGYfFSvJgrLXVQ9ZHxfoskb81es
         H1sG7SzTjEG3xX4gdQAmOv/ayCA2ijLdsf54kx5bhgm2UyEziAqphBWKyoE7PzT4NGFI
         6oYw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crowdstrike.com; s=google; t=1789605570; x=1790210370; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2ddDCg8mwUaWtaw9w0u3MPxg8tw+xllyDfgOCSBIsSE=;
        b=lJqj7Jis6cqea5xKparbnUzDLR3VlgEwaKYEe8dB213CMIIbdGhRDyCryH2gk97fXS
         baJa6u3yNu8qVYe0+Vfdw5WbvwtKAJsn8ZrxkIMUhdaZyep362PP0FWRBedWnByN7QY3
         y3ndQdlUId6z1fKdrQkKKbFZSrRi0hKC/oZZfdG2tGauD8mYP5I//Yd2tmwakI30IdTw
         pB493AH1xiLNixE6uroTcjbTCabFtKxP4ksNLsIdgdqIWz5WsLfabFXf5/71Vz31Oogn
         sN4L4Edr9UPVn9lkfBIMz2cUuuhdm33pRZ/ylm6RDQIiAOGiBguKhbQ/MaqtY8iDkIFe
         X66Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789605570; x=1790210370;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2ddDCg8mwUaWtaw9w0u3MPxg8tw+xllyDfgOCSBIsSE=;
        b=utpCLE1Aee2jQ1U4rbuaXywVpFzzEzdnHGOSAgKkX5MYWlFDzaLBB62VYqbeMMhdce
         Yvnxer1qxeJtKKBMMchWqmVLiZ0qj5th5XDv0gMKEwTtJd2Su/uc8edn1tlGwE7EDwLy
         xG06LXr/xACP/3m7nINRSpt5qN42nXrzIE+9qmlV2Tcf/KiBelDA5KnA53jTPayuOOAd
         yh5dzkOnBVZEDJFmPZ+MyyrAQdLUO7C6l271DG/8u3DBOS7CuZ26vJ9mDSnP9OSSw9gi
         mqEMiGVhS9rzthbxNMDkLDu6EiCjx0vf5dhU8IuiabZyLV1Tc07ZxAPK8M5JBdobOq+u
         HR8w==
X-Gm-Message-State: AFuF++l4A72idSTT7Af6SuMVt/BXbP/xV3J2KXnXUU76//CzYKrWqPN3
	yHnGuivlRwYRNTAnawu0iMatOgABUDiCw10H7qnCLfwEcrq6Q/QicsIvdq/KdxuB0UQoH+8iKmz
	Rzf+XyagsIqakDigdCcgyPS/fLuaN2obAxVc0d+0m+Jhn8oTZvWRxxIospQ3weTbIc60AU5Sx4P
	qoQV/+70mzVxgP52679iiFMK3kmUSg
X-Gm-Gg: AYBFou3QvAGO29SnO8zBuAzHZ+VnDw/QjPv6PGBtR6OZH33bLDbU+vC4qNB8tKdqnxk
	S8kjMcoLIhrqfBjzBtzVgY9BUEo1sjDMBhqmjkDOFXzDV4oQfBPj3Q8QUwNlBfNOuZyc9fPqLjr
	4e078ZiwznqDi2YFszhY4pEbEL+UX9H+051Hw7ldrigKTZpj9L+q2ro63X+g==
X-Received: by 2002:a05:690c:e255:10b0:853:a9c4:c3eb with SMTP id 00721157ae682-89221bc93ecmr12345077b3.28.1789605570011;
        Wed, 16 Sep 2026 17:39:30 -0700 (PDT)
X-Received: by 2002:a05:690c:e255:10b0:853:a9c4:c3eb with SMTP id
 00721157ae682-89221bc93ecmr12345037b3.28.1789605569437; Wed, 16 Sep 2026
 17:39:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260826181825.1826541-1-andrey.grodzovsky@crowdstrike.com>
 <20260826181825.1826541-3-andrey.grodzovsky@crowdstrike.com> <CAEf4BzY8LLT6_=sOyof7mE+GenAwtVNhzEP_Emy_U07WFjU+Eg@mail.gmail.com>
In-Reply-To: <CAEf4BzY8LLT6_=sOyof7mE+GenAwtVNhzEP_Emy_U07WFjU+Eg@mail.gmail.com>
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Date: Wed, 16 Sep 2026 20:39:17 -0400
X-Gm-Features: AcwNN1XeVXW-Z35ax2D2rLxHhyxKggrrjSgYIjLGByacy3N4iu7zFPKo0BmKsZ8
Message-ID: <CAOu3gNgoopD0=8_0_OmVrt1bWdffRy3GmbBBC2Qe_9MaYjvEdg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/5] libbpf: BPF programs dynamic loading and attaching
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, martin.kelly@crowdstrike.com,
        slava.imameev@crowdstrike.com, linux-open-source@crowdstrike.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDAwNSBTYWx0ZWRfX3mTsRPoOVDTm
 pa2CRE/vwDLNYQaT4t5AH9L75bdGTFY2eMkCmUV5CfnQLI7RtyDtjeDyUFGCzkB5CSg/8VwEvwE
 YPugSS2ixBT0qPu/wr5Up0ICG9AobJHz7+X6KPq+F1g0C98Qyw25
X-Authority-Analysis: v=2.4 cv=K823jCWI c=1 sm=1 tr=0 ts=6aab36c2 cx=c_pps
 a=0mLRTIufkjop4KoA/9S1MA==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=KZhmPCYDdY0A:10 a=VkNPw1HP01LnGYTKEx00:22 a=T2KQ53IYiC3MXPrxx8bB:22
 a=R_n4Uisa8axJ7jemP0ek:22 a=pGLkceISAAAA:8 a=pl6vuDidAAAA:8
 a=I9erYxI3bX_sdJO_UdsA:9 a=QEXdDO2ut3YA:10 a=WgItmB6HBUc_1uVUp3mg:22
X-Proofpoint-ORIG-GUID: fANgxokF5rB34yNr2U74XJ2D8OMpESWr
X-Proofpoint-GUID: fANgxokF5rB34yNr2U74XJ2D8OMpESWr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDAwNSBTYWx0ZWRfX9aHYArvEMwXT
 npsflmPpZ8PJ1ZvzYAcvJwuefF6BeCAax/GM1/2trUhu5VYjWp1XwApDP4FIq8e56vE3olxMYeZ
 Cj5LT9Wp2dcP2mxWVtk2NClu6O0lNzi102Co13ckyvAa+Holyaemuzy6gUo2OHuKGHdoIZKgnpg
 KtbQNw0hKdMAGDOJjKnhIRigkZU4/00ieIsaFdDehvmCvsH2djkZC6BesYAfkdM24HaBZ6aDMfM
 x59pz1kTuO/GCjyBVNpEJAdO4F2RqJmBM96UkVzZ1BpfGm/EvjHCiYA0ddN5z3fxkMlcCxUTNi3
 3HUtCGh8y9PGkHWfS/kd0JDWElMg5+a0SjiahLCHTrVwywjtVClJk45sDjqzGVAY8bJ/9bcGdkD
 FLG9mTgMqqzupfkX480yzmgOAriEun+HZTMMDucMEWyko/kHzm5jUSjWB/bqnuAnYCg8cLea5bL
 WwPEX723+H7ECFOO0UQ==
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11907
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 impostorscore=0 adultscore=0 phishscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609170005

On Fri, Sep 11, 2026 at 7:44=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Aug 26, 2026 at 11:18=E2=80=AFAM Andrey Grodzovsky
> <andrey.grodzovsky@crowdstrike.com> wrote:
> >
> > From: Slava Imameev <slava.imameev@crowdstrike.com>
> >
> > BPF programs designated as dynamically loaded can be loaded and
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
> > Signed-off-by: Slava Imameev <slava.imameev@crowdstrike.com>
> > Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
> > ---
> >  tools/lib/bpf/libbpf.c   | 144 ++++++++++++++++++++++++++++++++++++---
> >  tools/lib/bpf/libbpf.h   |   4 ++
> >  tools/lib/bpf/libbpf.map |   2 +
> >  3 files changed, 141 insertions(+), 9 deletions(-)
> >
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index 821d854d43a9..c3fe1de43210 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> > @@ -725,6 +725,7 @@ struct bpf_object {
> >
> >         bool has_subcalls;
> >         bool has_rodata;
> > +       bool has_dynload_progs;
> >
> >         struct bpf_gen *gen_loader;
> >
> > @@ -8056,7 +8057,7 @@ static int bpf_object_load_prog(struct bpf_object=
 *obj, struct bpf_program *prog
> >                         log_buf =3D prog->log_buf;
> >                         log_buf_size =3D prog->log_size;
> >                         own_log_buf =3D false;
> > -               } else if (obj->log_buf) {
> > +               } else if (obj->log_buf && prog->load_type !=3D BPF_PRO=
G_LOAD_TYPE_DYNAMIC) {
>
> DYNAMIC as opposed to AUTO isn't all that clear a distinction, IMO. If
> we go with "load strategy" for terminology, wouldn't this be AUTO vs
> MANUAL?

Agreed.

>
> >                         log_buf =3D obj->log_buf;
> >                         log_buf_size =3D obj->log_size;
> >                         own_log_buf =3D false;
> > @@ -8403,6 +8404,7 @@ bpf_object__load_progs(struct bpf_object *obj, in=
t log_level)
> >                         pr_debug("prog '%s': skipped auto-loading\n", p=
rog->name);
> >                         continue;
> >                 }
> > +
> >                 prog->log_level |=3D log_level;
> >
> >                 if (obj->gen_loader)
> > @@ -9076,15 +9078,22 @@ static void bpf_object_cleanup_btf(struct bpf_o=
bject *obj)
> >         obj->btf_modules_loaded =3D false;
> >         zfree(&obj->btf_modules);
> >
> > -       /* clean up vmlinux BTF */
> > -       btf__free(obj->btf_vmlinux);
> > -       obj->btf_vmlinux =3D NULL;
> > +       /* The btf_vmlinux data is needed for dynamically loaded progra=
ms,
>
> nit: we've switched to more kernel-standard '/*' on separate line
> style, please adjust comments in the next revision accordingly
>
> > +        * so defer freeing it in that case to the end of the object li=
fetime.
> > +        */
> > +       if (!obj->has_dynload_progs) {
> > +               btf__free(obj->btf_vmlinux);
> > +               obj->btf_vmlinux =3D NULL;
> > +       }
> >  }
> >
> >  static void bpf_object_post_load_cleanup(struct bpf_object *obj)
> >  {
> > -       /* clean up fd_array */
> > -       zfree(&obj->fd_array);
> > +       /* The fd array is needed for dynamically loaded programs,
> > +        * so defer freeing it in that case to the end of the object li=
fetime.
> > +        */
> > +       if (!obj->has_dynload_progs || !obj->fd_array_cnt)
>
> why the added fd_array_cnt condition?
>

To avoid keeping the array  in case no program ever referenced module kfunc=
s

> > +               zfree(&obj->fd_array);
> >
> >         /* clean up BTF */
> >         bpf_object_cleanup_btf(obj);
> > @@ -9678,6 +9687,8 @@ void bpf_object__close(struct bpf_object *obj)
> >                 close(obj->jumptable_maps[i].fd);
> >         zfree(&obj->jumptable_maps);
> >
> > +       zfree(&obj->fd_array);
> > +
> >         free(obj);
> >  }
> >
> > @@ -9805,8 +9816,16 @@ bool bpf_program__autoload(const struct bpf_prog=
ram *prog)
> >
> >  int bpf_program__set_autoload(struct bpf_program *prog, bool autoload)
> >  {
> > -       return bpf_program__set_load_type(prog,
> > -               autoload ? BPF_PROG_LOAD_TYPE_AUTO : BPF_PROG_LOAD_TYPE=
_DISABLED);
> > +       enum bpf_prog_load_type type =3D prog->load_type;
> > +
> > +       if (autoload)
> > +               type =3D BPF_PROG_LOAD_TYPE_AUTO;
> > +       else if (prog->load_type =3D=3D BPF_PROG_LOAD_TYPE_AUTO)
> > +               type =3D BPF_PROG_LOAD_TYPE_DISABLED;
> > +       else
> > +               return 0; /* Otherwise, keep the current load type. */
>
> why? should we unconditionally set DISABLED if autoload=3D=3Dfalse?

Yea, I will refactor to this, I guess any current user who set it to
false intends to disable anyway.

>
> > +
> > +       return bpf_program__set_load_type(prog, type);
> >  }
> >
> >  bool bpf_program__autoattach(const struct bpf_program *prog)
> > @@ -15220,12 +15239,73 @@ void bpf_object__destroy_skeleton(struct bpf_=
object_skeleton *s)
> >         free(s);
> >  }
> >
> > +static int bpf_program__set_dynamicload(struct bpf_program *prog)
>
> we use double underscore naming only for public APIs (apart from a
> bunch of legacy functions)
>
> but also why this separate function at all, just inline it in
> set_load_type below

Will do.

>
> > +{
> > +       struct bpf_object *obj;
> > +       const char *attach_name;
> > +
> > +       obj =3D prog->obj;
> > +       if (!obj)
> > +               return libbpf_err(-EINVAL);
>
> do we ever check this anywhere?

 No, we don't; I will remove it.

>
> > +
> > +       /* Dynamically-loaded programs are not supported for gen_loader=
.
> > +        * This is because bpf_object_load_prog is not called for
> > +        * dynamicload programs, so dynamicload programs are not visibl=
e
> > +        * to gen_loader. For this reason, prevent calling
> > +        * bpf_program__set_dynamicload when gen_loader was used to
> > +        * generate a BPF object loader.
> > +        * A gen_loader implementation is being called for autoloaded
> > +        * programs and defines its own model for loading BPF programs.
> > +        * To pass a BPF program to gen_loader, set the program's load =
type
> > +        * to LD_AUTOLOAD.
> > +        */
> > +       if (obj->gen_loader)
> > +               return libbpf_err(-ENOTSUP);
> > +
>
> ENOTSUP is kernel-internal, use EOPNOTSUPP
>
> > +       if (prog_is_subprog(obj, prog))
> > +               return libbpf_err(-EINVAL);
> > +
> > +       attach_name =3D strchr(prog->sec_name, '/');
> > +       if (!attach_name || strchr(attach_name, ':')) {
> > +               /* Only reject programs that require BTF-based attach t=
arget
> > +                * resolution (indicated by the SEC_ATTACH_BTF flag). S=
uch
> > +                * programs need the section name parsed for the attach=
 target
> > +                * function name (after '/') and optionally the module =
name
> > +                * (before ':') for libbpf_find_attach_btf_id.
>
> hm... this looks ugly... why BTF-base dattach targets can't be set to
> dynamic/manual load?

I checked again and they can be supported. The comment was misleading.
Original intention was to avoid supporting kernel module attach
targets for simplicity. I tested and made code updates regarding
retaining module BTFs; the next patch set iteration will support them.

>
> > +                *
> > +                * Programs like SEC("classifier"), SEC("socket"), etc.=
 do
> > +                * not require BTF attach resolution and can safely use
> > +                * dynamic loading despite having no '/' in their secti=
on
> > +                * name. The BTF guard in libbpf_prepare_prog_load (che=
cking
> > +                * SEC_ATTACH_BTF) is the authoritative check; this is =
an
> > +                * early-reject for programs that would fail there.
> > +                */
> > +               long flags =3D prog->sec_def ?
> > +                       (long)prog->sec_def->cookie : SEC_ATTACH_BTF;
> > +               if ((flags & SEC_ATTACH_BTF) && !prog->attach_btf_id)
> > +                       return libbpf_err(-EINVAL);
> > +       }
> > +
> > +       obj->has_dynload_progs =3D true;
>
> if someone sets load type to DISABLED from what used to be DYNAMIC
> (e.g., because kernel is not supported), we don't recalculate
> has_dynload_progs. I think we should determine has_dynload_progs at
> the beginning of preparation step (and disable changing that), instead
> of trying to keep track of it like you do here

Agreed, will do.

>
> pw-bot: cr
>
> > +       prog->load_type =3D BPF_PROG_LOAD_TYPE_DYNAMIC;
> > +       prog->autoattach =3D false;
> > +
> > +       return 0;
> > +}
> > +
> >  int bpf_program__set_load_type(struct bpf_program *prog, enum bpf_prog=
_load_type type)
> >  {
> >         if (prog->obj->state >=3D OBJ_LOADED)
>
> I think this should be OBJ_PREPARED, after bpf_object__prepare() is
> called, it's too late to change this load type

Will do.
>
> >                 return libbpf_err(-EINVAL);
> >
> > -       prog->load_type =3D type;
> > +       switch (type) {
> > +       case BPF_PROG_LOAD_TYPE_DYNAMIC:
> > +               return bpf_program__set_dynamicload(prog);
> > +       default:
>
> let's have explicit case XXX listed, with default returning -EINVAL
>
> > +               prog->load_type =3D type;
> > +               break;
> > +       }
> > +
> >         return 0;
> >  }
> >
> > @@ -15233,3 +15313,49 @@ enum bpf_prog_load_type bpf_program__load_type=
(const struct bpf_program *prog)
> >  {
> >         return prog->load_type;
> >  }
> > +
> > +/*
> > + * This function must be called after bpf_object__load_progs.
>
> any problems with it being called after bpf_object__prepare()? what's mis=
sing?

Mostly, moving if (obj->state < OBJ_LOADED) bellow to (obj->state <
OBJ_PREPARED), i tested and with this i can past a unit test with
loading and attaching right after bpf_object__prepare. Will do.

>
> > + * Dynamically-loaded program data is initialized on object load.
> > + * Post-load initialization is not supported.
> > + */
> > +int
> > +bpf_program__load_dynamically(struct bpf_program *prog, int extra_log_=
level)
>
> just call it bpf_program__load()

Problem with this is we already the legacy bpf_program__unload (full
unload, irrevarsable) and we have our lightweighet
bpf_program__unload_manually which just closes the prog FD but retains
the data so it's reversible. So this renaming creates the wrong
conceptual pairing. I am open to other ideas on how to proceed.

>
> > +{
> > +       int err;
> > +       struct bpf_object *obj;
> > +
> > +       obj =3D prog->obj;
> > +       if (!obj || obj->state < OBJ_LOADED)
>
> prog->obj should always be set, stop checking for it
>
> > +               return libbpf_err(-EINVAL);
> > +
> > +       if (prog_is_subprog(obj, prog) || prog->load_type !=3D BPF_PROG=
_LOAD_TYPE_DYNAMIC)
>
> we should also check that program is not already loaded (probably
> enough to check prog->fd, double check)
>
> > +               return libbpf_err(-EINVAL);
> > +
> > +       prog->log_level |=3D extra_log_level;
>
> hm... why this extra_log_level? Why can't user just set
> bpf_program__set_log_level() before attempting to bpf_program__load()

Agreed, I will remove it.

Andrey

>
> > +
> > +       err =3D bpf_object_load_prog(obj, prog, prog->insns, prog->insn=
s_cnt,
> > +                                  obj->license, obj->kern_version, &pr=
og->fd);
> > +       if (err) {
> > +               pr_warn("prog '%s': failed to dynamically load: %d\n", =
prog->name, err);
> > +               prog->log_level &=3D ~extra_log_level;
> > +               return err;
> > +       }
> > +
> > +       prog->log_level &=3D ~extra_log_level;
> > +       return 0;
> > +}
> > +
> > +int bpf_program__unload_dynamically(struct bpf_program *prog)
> > +{
> > +       int err;
> > +
> > +       if (!prog || prog->load_type !=3D BPF_PROG_LOAD_TYPE_DYNAMIC)
> > +               return libbpf_err(-EINVAL);
>
> we don't expect NULL, unless it's explicitly specified as a
> possibility. And you didn't check prog for NULL in
> bpf_program__load_dynamically(). let's be consistent (and not check
> for NULL)
>
>
> > +
> > +       /* Close the file descriptor but retain the program's data to
> > +        * support reloading the program if it is required again.
> > +        */
> > +       err =3D zclose(prog->fd);
> > +       return err ? libbpf_err(-errno) : 0;
> > +}
> > diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> > index 700634664e32..54d755861289 100644
> > --- a/tools/lib/bpf/libbpf.h
> > +++ b/tools/lib/bpf/libbpf.h
> > @@ -2083,15 +2083,19 @@ LIBBPF_API int bpf_program__clone(struct bpf_pr=
ogram *prog, const struct bpf_pro
> >   *
> >   * - BPF_PROG_LOAD_TYPE_DISABLED: the program is not loaded.
> >   * - BPF_PROG_LOAD_TYPE_AUTO: the program is autoloaded when the bpf_o=
bject is loaded.
> > + * - BPF_PROG_LOAD_TYPE_DYNAMIC: the program is loaded and attached dy=
namically.
> >   */
> >  enum bpf_prog_load_type {
> >         BPF_PROG_LOAD_TYPE_DISABLED =3D 0,
> >         BPF_PROG_LOAD_TYPE_AUTO,
> > +       BPF_PROG_LOAD_TYPE_DYNAMIC,
> >  };
> >
> >  LIBBPF_API int bpf_program__set_load_type(struct bpf_program *prog,
> >                                           enum bpf_prog_load_type loadt=
ype);
> >  LIBBPF_API enum bpf_prog_load_type bpf_program__load_type(const struct=
 bpf_program *prog);
> > +LIBBPF_API int bpf_program__load_dynamically(struct bpf_program *prog,=
 int extra_log_level);
> > +LIBBPF_API int bpf_program__unload_dynamically(struct bpf_program *pro=
g);
> >
> >  #ifdef __cplusplus
> >  } /* extern "C" */
> > diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> > index 4d63dac8c3b7..a0389c58efe9 100644
> > --- a/tools/lib/bpf/libbpf.map
> > +++ b/tools/lib/bpf/libbpf.map
> > @@ -464,4 +464,6 @@ LIBBPF_1.8.0 {
> >                 btf__new_empty_opts;
> >                 bpf_program__load_type;
> >                 bpf_program__set_load_type;
> > +               bpf_program__load_dynamically;
> > +               bpf_program__unload_dynamically;
> >  } LIBBPF_1.7.0;
> > --
> > 2.34.1
> >
