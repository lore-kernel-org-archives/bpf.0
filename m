Received: from mx0b-00206402.pphosted.com (mx0b-00206402.pphosted.com [148.163.152.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F1A2949E0
	for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 17:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=148.163.152.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790444995; cv=pass; b=VIiXlwqSr6WRjINesMKOjUIbwRMxLr6S9JwJbb6WMXmQIgBVcT/4TxwRmYsbMMfvFJtDRghOv0/f8zpVIZGS1hRlXWVfTfveNxmNjf7BZBTIMCnE0TrSw3DQG7p8QyWJka92eSXU6uG7ebLS4CPoG4DMb3szrBzzoinh3UDBZ1E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790444995; c=relaxed/simple;
	bh=rfi19DtODvmH5+xGbPJMxvZmZr9evv0YluJb0Ha5kY0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B611qcXiGCqLT3Cu4Ha6BRDqWlg3viPQiQ0kSgvkwRygn+vSOaRy50XJ8QhyO/DSyTHjG9tbqe1my75r6wbFqmY9X9V67QGfvhPebebKmyNAjwExMNln2n15yU4FdY3kK/mpIuc8W1STbo45qU+Kr349V16ylTVlqQGdmsd9g/Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=nXoBhZ+5; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=hDfdbUNQ; arc=pass smtp.client-ip=148.163.152.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="nXoBhZ+5";
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="hDfdbUNQ"
Received: from pps.filterd (m0354654.ppops.net [127.0.0.1])
	by mx0b-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68QFPgJB169635
	for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 17:49:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=UW5aCBe8Ipm7CppmhRwkpWFwNLcyHIqqMU6hlR56wg4=; b=nXoB
	hZ+5P4uHZwQkG10KXofJ229fl3WyiLRwbX9P8O5qaeeuwU4dk0Zq5Qr1ZhoAZR+x
	O8tUR09kZGQdVTWecn3CUFPVo8lejh9YzQgEmBt5f8LvRwUGRSQEPK6ifkx9Ytyi
	XaicJZhs8SuAJqvMM3eTrefKsH9E5VsN7+ucglL24EMx5xlBd3g7/GCbuVF8amQP
	udVj/6j61kIqU4KF67Kek8eNyWwKzfjxbpdi66gVelM972I8l9JuBCtfBjhZlt+n
	wJeq8qhLkvy27TThyyD0phDYsAIpksZJNRWWvVFag+k5ksWpmepdSsMCA67Ailjc
	6PTrRyac6BE1K3KDDg==
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com [209.85.128.200])
	by mx0b-00206402.pphosted.com (PPS) with ESMTPS id 4gwrv2kwsw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 17:49:46 +0000 (GMT)
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-86e8abd7136so23789407b3.0
        for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 10:49:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790444986; cv=none;
        d=google.com; s=arc-20260327;
        b=hLLuV6wIllht7/rFu/4RhjTxXKDhbFvtXJx3c1D2A83VtYXbkL9QKrqzSwC8G9Jk3A
         wBoOSbIguFdS1ApfZQ6bnSxJ0Yp0WkWVoxyk7N8E/MCDXMD9LBaYmDWx8RXPUk5xVR3L
         pjhKoPXXknylRpxoCDcjaCq6Bgmw8pZWws5LsEaIPNpbFIjbigQAaoR2hLES81zinF6I
         e3dZ0M691ZKtqKare+XnNG7PzbwrYWijgE+4rvU3JST3PgNYU1m1QK9lXUddaw5meESo
         BbMSHCPbLBPz3Omp7Yw4nBQrEHgR9EzB74Y3X6jaLMEPKDB18fDXkwgcfeh/OWDq4f8d
         yB3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UW5aCBe8Ipm7CppmhRwkpWFwNLcyHIqqMU6hlR56wg4=;
        fh=gRVdEfKsy6bBYj2FtlGsH3p7h37Tvsw1/iQP5r5HM4k=;
        b=mcslXhR2Ser6T0B/euIoNagk8M4p87+Tf+9yKcGpYqbG93vabl0zNnueWnGBWDSrD9
         nCQUsRacHv3gkApgwoDZA6NT0p+WWF2Hw7t5Uy4TftMCQK1bEgLrCwQZbipxZbHrqUXL
         s0+xw+ZLjTnjV+5I1ukcbngCAuk5maG34f9Vff4oH5UsFPHdsqYZ8fdqbfFsIEoV4Jb5
         pCPULRX8WfcWLayfIpqKvHXrS2LmfVxFqYpt1KAaLVdBEiUQvZUWv5yhl/29C2g7oKGw
         cnmPFK58u/GCDhdjiXDtI4S5Y0HM8yH2sButqSt2zvsZeY4JeRIosXUQUpP7OqjHhPQN
         zYfg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crowdstrike.com; s=google; t=1790444986; x=1791049786; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UW5aCBe8Ipm7CppmhRwkpWFwNLcyHIqqMU6hlR56wg4=;
        b=hDfdbUNQGwBRCIXCperOEImivPycJnUaC0Y0YMDPGsx6M6E1iZ+0kohfQJSbx8aHeb
         a/f6DejzFb+izourA8dKBK0LvM/fQSDwhrn6Djwx7rAixB/Y9OG0l8BiGRdop8GRuYm2
         bRcYBaZO9pCOqddrmXA4jSRmiU4AiE5hBrbng4XNN8lonS9TPFRPzWS0Nn3E1s6NDuCU
         x/dCZXuQUD1HcD7020l5HiZ0lzF4n1e8MhxuDgCOfs0mYvWh8apGz4xUxY3Wyf7TtVse
         XT3Z9KdBO3ndwrNLch/YFki9ooYhd4jF2neKisQO7hUWwoBOFQ3L2+iRvMFxLkYfYqKI
         dpFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790444986; x=1791049786;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UW5aCBe8Ipm7CppmhRwkpWFwNLcyHIqqMU6hlR56wg4=;
        b=qgW05H8l2xO4vLdLEgBvcKKnVENsuYahEX/SkpdrbRKlLf53Uj21GUkosl6+AhxAQb
         Iqv3xlLrURaUbxhqBu+U9EV9iShNMynLlbJBO/KNDuORPRm1fK4q07ha2RK/HmTVQ/Nw
         qsmB+sLvOfzJPrODeIVODd28AAO0tx6Ve3erIFRsM1qtefipLRvUnC9ijpEwdEzqPvRr
         wf9LUytiLyaHO2zcPwOz+FdGQcnqSezNaFtX/WREIEHUoVYhn7YahoRsBkR25p5ZP0mz
         J9ssPv0MS1ksAcQFSJmHrdZmOK3KtIhDI0MWPC/W4smkMZQ/HSRpSyDJ8y0DK5R6i6YN
         2lTQ==
X-Gm-Message-State: AFq9FYIeLyZn1ZHBPI6d64BA/ybF6K+AK35b2Bn4q4pbHolx0ag3qClW
	qjcx85AH52d7XgCnXsOmQhxPNmS1XlfmGx+DrJx5Yb564uufhQUEj7eTU13QFUNTPqgKi3dUbPw
	scRTyZCPrqH7kU8Dg+7XXi2Wq6CAf20w6vdbJlqES1pE4Ho5aeVZ0Rt7M+5O13Ofm0bJ4tWBHcX
	RbW6HgRXm62aEyrLVLbrvoPeRy+TeP3iVoYGhxzKY=
X-Gm-Gg: AYBFou3s6SEG3olKIrl9rq3r2zdwNAWSrrxWwecoK3nekmxVANdz9SdKGQo9DGrOwuq
	ZAEOwT+I+oOOfRC2iNZWr433FmdwcY1+Njbv4oGQct8dMOjSal8xh52E0UVHHNlexhN9gPNhZrF
	GB+Mg3dld7t8jUpwD3KB8/o/l9Ctxib+v7cEMsrwzvzcCIIlqvcZPTDTFByA==
X-Received: by 2002:a05:690c:6603:b0:870:47a0:6fce with SMTP id 00721157ae682-8a64af412b3mr49202937b3.4.1790444985598;
        Sat, 26 Sep 2026 10:49:45 -0700 (PDT)
X-Received: by 2002:a05:690c:6603:b0:870:47a0:6fce with SMTP id
 00721157ae682-8a64af412b3mr49202877b3.4.1790444985046; Sat, 26 Sep 2026
 10:49:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260923232939.1886328-1-andrey.grodzovsky@crowdstrike.com>
 <20260923232939.1886328-5-andrey.grodzovsky@crowdstrike.com> <CAEf4BzYJe6FXO5Fj+RQtd9R1SYR0Lo-1Cm9G77kgvZ2uSe3K4w@mail.gmail.com>
In-Reply-To: <CAEf4BzYJe6FXO5Fj+RQtd9R1SYR0Lo-1Cm9G77kgvZ2uSe3K4w@mail.gmail.com>
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Date: Sat, 26 Sep 2026 13:49:33 -0400
X-Gm-Features: AclHuK_nNAVkCR2EHKG9BZugP0MbIKWzHbrmSJ1PN99Sr7MY4pZCjgYyc012AuQ
Message-ID: <CAOu3gNhwtmPhF7-1jbmP36LyBL+AQYMWqHSSGg2-dZq+Y+oD1w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 4/8] libbpf: Reject gen_loader for objects
 with already-manual programs
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org,
        martin.kelly@crowdstrike.com, slava.imameev@crowdstrike.com,
        linux-open-source@crowdstrike.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI2MDA3MCBTYWx0ZWRfX7KG3WD0tAwe8
 X9TA6Oi8XAOXgw0p3rFj7EHI3lI8R5oO6hS4hT/42n7LtBhCBVMYnoWUe4OiZ3PR0lFOGM4of9i
 DS0lZbQDNvfHChmyZoTRsdXu5CwAOkDcigE0MCZCw5WlDN3Forr/
X-Proofpoint-GUID: tPFldIGkwFNPB-9BMeFE21ZzZHzmDQde
X-Authority-Analysis: v=2.4 cv=Sadi5fRu c=1 sm=1 tr=0 ts=6ab805ba cx=c_pps
 a=NMvoxGxYzVyQPkMeJjVPKg==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=KZhmPCYDdY0A:10 a=VkNPw1HP01LnGYTKEx00:22 a=T2KQ53IYiC3MXPrxx8bB:22
 a=R_n4Uisa8axJ7jemP0ek:22 a=pGLkceISAAAA:8 a=pl6vuDidAAAA:8 a=VwQbUJbxAAAA:8
 a=7sI1ZtEq0_VebrSbackA:9 a=QEXdDO2ut3YA:10 a=kLokIza1BN8a-hAJ3hfR:22
X-Proofpoint-ORIG-GUID: tPFldIGkwFNPB-9BMeFE21ZzZHzmDQde
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI2MDA3MCBTYWx0ZWRfX6XYMzAthPbm0
 WaM+cCdSUOTLEL9lr7GNU6oBej4FWthrz4YKBhIatv0HPSH1RTeif1a8UWvfMn9oYqV6580GoTe
 ks+s4PobcIpTJopqP+HYZcLx30jugvCJ259/m00QhidugB/X1uocgknF/ptQ6cN6BcwQlU4Ik52
 RO5s++kxZOYU1TeMueG6H5k/UAWC1P5R7enAAcv46dA/w3eip3fMqFx8UUHTjiZK/GzDL/e1cUq
 pxqcH4TUPK8la9ENyrW7/NPkY6f+EdqOgI7t2fXX3Lw6c4yPJ1B+gsmaqHhfrkRVkLntHP1+yJe
 /O8DBdIFlAdR4jXbnBMXYuimOmO6lovqwavY3Ln6ErZmoOfE1EmyHs52wHa5hhcMTC9yKNblEri
 s3Uyru+p0zpv05gZ09OXMCpvLHP8PijcP2ModhMMo07r7drUQdEySXLVslv0YdEaI0lATYb2lnq
 EawMjR5N8982RDRHpyg==
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11917
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0
 malwarescore=0 impostorscore=0 priorityscore=1501 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609260070

On Thu, Sep 24, 2026 at 7:19=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Sep 23, 2026 at 4:29=E2=80=AFPM Andrey Grodzovsky
> <andrey.grodzovsky@crowdstrike.com> wrote:
> >
> > bpf_program__set_load_strategy()'s MANUAL case rejects setting MANUAL
> > strategy while a gen_loader is already attached, but a program marked
> > MANUAL declaratively (SEC("!...")) gets that strategy during
> > bpf_object__open(), before bpf_object__gen_loader() can ever be
> > called, so the existing guard can never observe it.
> >
> > Left unchecked, bpf_object_load_progs() skips such programs, so
> > gen->nr_progs undercounts relative to the object's real program
> > count. bpf_gen__finish() only rejects the opposite mismatch direction
> > (nr_progs < gen->nr_progs), so this passes silently, and every
> > generated skeleton program slot after the manual one ends up wired to
> > the wrong prog_fd.
> >
> > Catch it at the one point guaranteed to run after any MANUAL marking
> > has already happened: reject in bpf_object__gen_loader() itself if any
> > program already has load_strategy =3D=3D BPF_PROG_LOAD_STRATEGY_MANUAL.
> >
> > Assisted-by: Claude:claude-sonnet-5
> > Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> > Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
> > ---
> >  tools/lib/bpf/libbpf.c | 34 ++++++++++++++++++++++++----------
> >  1 file changed, 24 insertions(+), 10 deletions(-)
> >
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index d815e53e8295..85e1d9c775ab 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> > @@ -9859,11 +9859,31 @@ int bpf_object__set_kversion(struct bpf_object =
*obj, __u32 kern_version)
> >  int bpf_object__gen_loader(struct bpf_object *obj, struct gen_loader_o=
pts *opts)
> >  {
> >         struct bpf_gen *gen;
> > +       size_t i;
> >
> >         if (!opts)
> >                 return libbpf_err(-EFAULT);
> >         if (!OPTS_VALID(opts, gen_loader_opts))
> >                 return libbpf_err(-EINVAL);
>
> gen_loader shouldn't be set after prepare step, we should just reject
> that operation, it's a misuse of the API

I will capture this in a separate commit in the next patchset iteration.

>
> > +
> > +       /*
> > +        * Manually-loaded programs are not visible to gen_loader (see
> > +        * bpf_program__set_load_strategy()'s MANUAL case), and marking=
 a
> > +        * program MANUAL happens during bpf_object__open(), before thi=
s
> > +        * function can ever run, so that guard can never catch it here=
.
> > +        * Reject any pre-existing MANUAL program now, since this is th=
e
> > +        * earliest point where both are known.
> > +        */
> > +       for (i =3D 0; i < obj->nr_programs; i++) {
> > +               struct bpf_program *prog =3D &obj->programs[i];
> > +
> > +               if (prog->load_strategy =3D=3D BPF_PROG_LOAD_STRATEGY_M=
ANUAL) {
> > +                       pr_warn("prog '%s': gen_loader does not support=
 manually-loaded programs\n",
> > +                               prog->name);
> > +                       return libbpf_err(-EOPNOTSUPP);
> > +               }
> > +       }
> > +
>
> and there is no need to check this on setting gen_loader, during
> bpf_object_prepare all this stuff (gen_loader, MANUAL settings) should
> be finalized and never changed again. that's when we check all these
> conditions

Will relocate to bpf_object_prepare and also,  I think I can drop the
hunk bellow in bpf_program__set_load_strategy returning EOPNOTSUPP on
gen_loader. It's not needed since we cannot set load strategy after
prepare step and setting it before will encounter the check we will
move to bpf_object_prepare.

>
>
> >         gen =3D calloc(1, sizeof(*gen));
> >         if (!gen)
> >                 return libbpf_err(-ENOMEM);
> > @@ -15470,16 +15490,10 @@ int bpf_program__set_load_strategy(struct bpf=
_program *prog, enum bpf_prog_load_
> >                 break;
> >         case BPF_PROG_LOAD_STRATEGY_MANUAL:
> >                 /*
> > -                * Manually-loaded programs are not supported for gen_l=
oader.
> > -                * This is because bpf_object_load_prog is not called f=
or
> > -                * manually-loaded programs, so such programs are not v=
isible
> > -                * to gen_loader. For this reason, prevent calling
> > -                * bpf_program__set_load_strategy(MANUAL) when gen_load=
er was
> > -                * used to generate a BPF object loader.
> > -                * A gen_loader implementation is being called for auto=
loaded
> > -                * programs and defines its own model for loading BPF p=
rograms.
> > -                * To pass a BPF program to gen_loader, set the program=
's load strategy
> > -                * to BPF_PROG_LOAD_STRATEGY_AUTO.
> > +                * Manually-loaded programs are not visible to gen_load=
er,
> > +                * since bpf_object__load_progs() skips them during the=
 bulk
> > +                * load pass; see bpf_object__gen_loader()'s own guard =
for
> > +                * the full explanation.
> >                  */
>
> yeah, wow, nice way to score human reviewer's points, more sloppy slop pl=
ease

I want to apologize here in one place for all the instances of AI
sloppiness you justifiably flagged in this section across patches 2, 3
and 4. I take this seriously and this will not happen again.

Andrey

>
>
> >                 if (obj->gen_loader)
> >                         return libbpf_err(-EOPNOTSUPP);
> > --
> > 2.34.1
> >
