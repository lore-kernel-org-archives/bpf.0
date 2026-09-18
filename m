Received: from mx0b-00206402.pphosted.com (mx0b-00206402.pphosted.com [148.163.152.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C643951EDE9
	for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 18:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=148.163.152.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789756203; cv=pass; b=i42XEpIaVxGvcKyy/RoIzs6gpb5eWbvFVNmZKJyApyZu3ewSmG/3YRpvpX8mvzR5mtb1s97CzOiPQSoetALWutWBM/C9ycGPzATDLev+RJegQCozpr+55Rq6A7wjwSed73sFIboFx65RHmHnD/gPys9HnMhf3xI7QxqGtizwhv4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789756203; c=relaxed/simple;
	bh=J7W15XqZ6ORC6qnahFGeKRPVxedy9/rMMuWN4qni3zo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oZy+/zpUAQV6/klx+8B5wEFKtffXoICdx3+N1eVIV+Or9X+l5CQfkCGX/xoGJjw4zycDp/UNGlakN0gobRkMp+9DyKFje0CVA7DyFu0ynRXj0o+HoOpjqzetQ6GuSsY2FxJEt9gvZvQS7zVC4svzqJkHEqmGAfKxRjkB1w/jcng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=Y2pPmB6C; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=QzLlNzOY; arc=pass smtp.client-ip=148.163.152.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="Y2pPmB6C";
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="QzLlNzOY"
Received: from pps.filterd (m0354655.ppops.net [127.0.0.1])
	by mx0b-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68IECscq2605194
	for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 18:29:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=70/Npkkhe33l7la9+iCrfYQoK1XRC0Wq25ySvCwwjyw=; b=Y2pP
	mB6Ci40QhcBZ66oz89Ps1uLZK0OUnjKqq+n9TI0qHaPvGNg1U1/8g+wr/hWxgR7d
	RITY6z2hrfrWFGhyehTcIM69NxngsmPS03sMcBrNuU6DemkHgCr37c8KBxSOy4t5
	9q9fhJpfVYuUKTmrQIBvavD46fIZ64iyjB61lsMuyZAr5BCshJo+0gksrQOr1uPz
	dH3eUrHm47ze2NuBiV1CIvq/2bVoZcQQ79UXMsF2qq6CJS9QmocVPEHpzw357es0
	41WUE6gB9s+3JlXxiQxb7CNOp3BlpQbN0q/HDECP62I/8ql5/wy9qwo4mwCpAp6y
	2H48yWJkGhSZBlVC9Q==
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com [209.85.128.198])
	by mx0b-00206402.pphosted.com (PPS) with ESMTPS id 4gru0w30pf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 18:29:55 +0000 (GMT)
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-892af0d1bcbso13507727b3.3
        for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 11:29:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789756195; cv=none;
        d=google.com; s=arc-20260327;
        b=AJBSZ5gYFV4aMhGrk+TwmI5tl+3A4VZkfwe1d5QKmzpfaqQUuewYY2ZbNO45eEfJ8E
         iZ3nQ7Z5yySgq6Rt9P6uqH6cS2ncd2clCNaeok/Wn6MgAIFGVKVwrs+ubr65a0Af4p1N
         iSqwiO3/2eYjPxmE6A38WNK5yRQ6lA+IVbVzlU/uNWlgoSpM25LOSBo3pVfd3JdZohF+
         de7HQI2K+mTzT5vZ7Ye1e2MFQ0LJH4SEi4PVl0J+FbCCCscEKZ0dsOi1xN9IcokEJRyi
         pfyJgcjE5EYSBNH6wCXVMzUwjPzIk2Dyv952wYrU61ZXLcnv+LFUiml0z39HPI8/gTro
         O1FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=70/Npkkhe33l7la9+iCrfYQoK1XRC0Wq25ySvCwwjyw=;
        fh=qt29tRmMv9RTRwthwC9TubzTxuwxPM3tixKceu/18cU=;
        b=hJpk5CkynKrvDQKTEbOKl1FvSU/RlQqARrF8YyRfhLMSCM/2xrdifBrj7yb+ja1/5E
         v5Adnvd9ysdSY0NAZ7aVYeQvTF9QLYdGFKGYfnQZ87FGHm3eUCLKzMFIoXFJk2QNMWY8
         deevIVlbaGrnEYQiXIPMasSEcDW/I9XUl0KucaEIxOpCu5rnhLRXyDMJ+pS1L9zcsOgX
         Gxof3aOcY3WVF5lbobAYG6t2YGb3Tp1fcfJ/4AO7WRNaI2ydSpOiHi70XLzluOECOx4v
         bCdOBfO4LMT067+h0+hbtwIS6dUv3R91KBEp4A4dYZt5Nx+IY1kPA7x6rHROPocUw/tY
         zAMg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crowdstrike.com; s=google; t=1789756195; x=1790360995; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=70/Npkkhe33l7la9+iCrfYQoK1XRC0Wq25ySvCwwjyw=;
        b=QzLlNzOY9uh3cDNhPDCYCNhQiGLJ9pXiesTDCDtRVxXmjDMotS0XBUu+DjJdogd4rD
         uk9wq70vY93c0dgM0nqYUro7RdrY1yWA6Cx8BObe6tzcRkuij4cJmgIKU1suErv6Llq0
         aXujgpyuw603V5+RtNwyGb+o9xaVu/vtMZ9GPN5C4Vc6l8ihCMc22ccDAzDdE62sIViC
         2c95JQwv3R32YjesmpifqJ5p6fpmdQ23qFajiGV2hpzIfndGLAwrAKaE5aBhio8v2dfL
         jKVn+/74WMs3f92jJUQFJw4u9ToiDtD6eTnAqvk6OBQhDbZUkecS0JHqpeRtHKSRIPsn
         5/dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789756195; x=1790360995;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=70/Npkkhe33l7la9+iCrfYQoK1XRC0Wq25ySvCwwjyw=;
        b=cibm2rUodruZKw28qfgf7QUchi4x8rIF3IHpw8Mkn0RGiR60DcrFTuxE5OxTGOD2Ks
         KKiWbefH2zgFB/fRwutbk/g1Qcp9zIyfV0ZtwRE+NHzH9mKcGz7fNeCI9OXwElySW7ha
         010wA/gx/C0Cc3Un02j4S5NIPQ3SzP1l4Iy2GA7h3C01XWZ0BYkuDl3kTWsSJoNjWPPY
         FDMRr18PiaSNpBudbDINwADsmjSfjtskn6NoDSSFYrKicauTUPqEODF81qB8kKFBl7yg
         G8UtE/PM4wQ+VNi2SXuREULx2EEz6vg8iBzIoCgVLpm1jL28sc3m9nNQ7fRYA1wJfPuX
         /3YQ==
X-Gm-Message-State: AFuF++k0pwqJYN4dJnZ0v3JUAMog5fVpeN8PfoHZlMR9KbjN5CJ4AE7J
	iKBD8L8Edo/LEyIrPcK+S7q5OMYY3FHeTuy3ucjAWoGNKqJ1m/71ti79zckXroPBP7sACKChA1A
	4Q+JEf8fnQd2vJ6vhtBmJQ4r36D+5MKdVd20Xubg4a7yZUSIOieNqIWDl1c0D0lfOqHRhDkTlei
	eJmJl4biTq51fa2Y74ZXaE6+GJIXEg
X-Gm-Gg: AYBFou26Sw3j16abfwFLdRq/ccwGcoQGM5hkSG1BG1LnVMmgIQrYbADrBqmhlOC2Uye
	qPOzy3FZwKcsFyy/lm6bWuUT7HNp5KTkjYtrxeH6bEd4ZCvtplgAIJ73G6R/1EJScwmC4FuNr5i
	cgFvq5ZGaM0Qb6V762z/x1GXv67MU072F6cOPgjMbqXWIh1IgrRDBRGc7dlg==
X-Received: by 2002:a05:690c:4ac7:b0:87f:e953:f6fe with SMTP id 00721157ae682-89733c1f4damr9492817b3.27.1789756195152;
        Fri, 18 Sep 2026 11:29:55 -0700 (PDT)
X-Received: by 2002:a05:690c:4ac7:b0:87f:e953:f6fe with SMTP id
 00721157ae682-89733c1f4damr9492717b3.27.1789756194425; Fri, 18 Sep 2026
 11:29:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260826181825.1826541-1-andrey.grodzovsky@crowdstrike.com>
 <20260826181825.1826541-3-andrey.grodzovsky@crowdstrike.com>
 <CAEf4BzY8LLT6_=sOyof7mE+GenAwtVNhzEP_Emy_U07WFjU+Eg@mail.gmail.com>
 <CAOu3gNgoopD0=8_0_OmVrt1bWdffRy3GmbBBC2Qe_9MaYjvEdg@mail.gmail.com> <CAEf4Bza-2N4JnnhCyFgCEHJqhFgiAsBECXpF0mrzfWZHwPysNw@mail.gmail.com>
In-Reply-To: <CAEf4Bza-2N4JnnhCyFgCEHJqhFgiAsBECXpF0mrzfWZHwPysNw@mail.gmail.com>
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Date: Fri, 18 Sep 2026 14:29:43 -0400
X-Gm-Features: AcwNN1X-UjexpL4SD8Ez7xsxPF9nqTiOzAer3F-zDA9CBBQDn1B2HLkbucQyrAA
Message-ID: <CAOu3gNgmp8+D4n=oTnZsuNG5DUqc-6dzs974m6w8D0G3NvGWyw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/5] libbpf: BPF programs dynamic loading and attaching
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, martin.kelly@crowdstrike.com,
        slava.imameev@crowdstrike.com, linux-open-source@crowdstrike.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=NIZAaE6g c=1 sm=1 tr=0 ts=6aad8323 cx=c_pps
 a=g1v0Z557R90hA0UpD/5Yag==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=KZhmPCYDdY0A:10 a=VkNPw1HP01LnGYTKEx00:22 a=T2KQ53IYiC3MXPrxx8bB:22
 a=vDKVRhTs-M86Ea50iKLw:22 a=pGLkceISAAAA:8 a=pl6vuDidAAAA:8
 a=E-nmC9J94Jvr7a075H8A:9 a=QEXdDO2ut3YA:10 a=MFSWADHSvvjO3QEy5MdX:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDI2NiBTYWx0ZWRfXw0wnORtFDzYR
 bfmhNXKY/Io72cO1u1MT9hmf1cTWh6rndOsu5zKcI2x3NQzwAWgqjYaZutYqgwaHOhC3AtBjxwa
 G63d8Z7rZcLWV3NuDFlS11HujXdEGnqfIn7u+0kSwzYQGy0EvDFi4jAGJGl+7tI48DQXswDrk9S
 nHXWTkjnUftEOn33Fq5Y/kPI45JvFIseNnuezNssafuOD9qFb46gicuRcd72wdrimufQsiZMcip
 6XuyhIDQnn5C9UFuP0/k2FOCaeRGUAmXncNipfrv+fNcZ0utVlNEiQMqe5B+/JFIqF6V+gWsmXm
 LTc9M2i9Mnz2jPZym2VuKFPrd3QIuoXjEtGyH4k12Iit1MRKFiRiiNHgdaBw9c/E9TADxbreolO
 IYf65qu0ArC3w0mFUqBA1GYLj+1riycA+sU0vbTE1yfDuexGHw3b9ahu3553SE5152EsTwaMffa
 q/OhHEQfX9TzSN9buKA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDI2NiBTYWx0ZWRfXxFT7oNdgjMnS
 1F7pz4zT9Ucza/r80tvmePJzTtAzEir+e8VkQsbl5agDhd30CU0PtUGWM85LwTMVfNP3UeVPVfH
 QNztP/EfORHsiZOuuZh2r4TiXC3klmCINPdpB0Et+NEY6VP2ZtTd
X-Proofpoint-ORIG-GUID: s4KRFyYrq-_mcmrH6uolI2MbEsrtR3Xy
X-Proofpoint-GUID: s4KRFyYrq-_mcmrH6uolI2MbEsrtR3Xy
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11909
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0 adultscore=0
 impostorscore=0 suspectscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609180266

On Thu, Sep 17, 2026 at 5:52=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Sep 16, 2026 at 5:39=E2=80=AFPM Andrey Grodzovsky
> <andrey.grodzovsky@crowdstrike.com> wrote:
> >
> > On Fri, Sep 11, 2026 at 7:44=E2=80=AFPM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Wed, Aug 26, 2026 at 11:18=E2=80=AFAM Andrey Grodzovsky
> > > <andrey.grodzovsky@crowdstrike.com> wrote:
> > > >
> > > > From: Slava Imameev <slava.imameev@crowdstrike.com>
> > > >
> > > > BPF programs designated as dynamically loaded can be loaded and
> > > > attached independently after the initial bpf_object loading and
> > > > attaching.
> > > >
> > > > These programs can also be reloaded and reattached multiple times,
> > > > enabling more flexible management of a resident BPF program set.
> > > >
> > > > A key motivation for this feature is to reduce load times for
> > > > utilities that include hundreds of BPF programs. When the selection
> > > > of a resident BPF program set cannot be determined at the time of
> > > > bpf_object loading and attaching, all BPF programs would otherwise
> > > > need to be marked as autoload, leading to unnecessary overhead.
> > > > This patch addresses that inefficiency.
> > > >
> > > > Signed-off-by: Slava Imameev <slava.imameev@crowdstrike.com>
> > > > Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com=
>
> > > > ---
> > > >  tools/lib/bpf/libbpf.c   | 144 +++++++++++++++++++++++++++++++++++=
+---
> > > >  tools/lib/bpf/libbpf.h   |   4 ++
> > > >  tools/lib/bpf/libbpf.map |   2 +
> > > >  3 files changed, 141 insertions(+), 9 deletions(-)
> > > >
>
> [...]
>
> > > >  static void bpf_object_post_load_cleanup(struct bpf_object *obj)
> > > >  {
> > > > -       /* clean up fd_array */
> > > > -       zfree(&obj->fd_array);
> > > > +       /* The fd array is needed for dynamically loaded programs,
> > > > +        * so defer freeing it in that case to the end of the objec=
t lifetime.
> > > > +        */
> > > > +       if (!obj->has_dynload_progs || !obj->fd_array_cnt)
> > >
> > > why the added fd_array_cnt condition?
> > >
> >
> > To avoid keeping the array  in case no program ever referenced module k=
funcs
> >
>
> my confusion stems from the fact that we unconditionally zfree'd it
> before. sure, you now added has_dynload_progs to postpone this, but
> fd_array_cnt is new and seemingly unrelated, so I'm still a bit
> confused...

Yea, I checked again, it's moot, the array is not allocated anyway if
fd_array_cnt =3D=3D 0 so this check is unnecessery.

>
> > > > +               zfree(&obj->fd_array);
> > > >
> > > >         /* clean up BTF */
> > > >         bpf_object_cleanup_btf(obj);
>
> [...]
>
> > > > + * Dynamically-loaded program data is initialized on object load.
> > > > + * Post-load initialization is not supported.
> > > > + */
> > > > +int
> > > > +bpf_program__load_dynamically(struct bpf_program *prog, int extra_=
log_level)
> > >
> > > just call it bpf_program__load()
> >
> > Problem with this is we already the legacy bpf_program__unload (full
> > unload, irrevarsable) and we have our lightweighet
> > bpf_program__unload_manually which just closes the prog FD but retains
> > the data so it's reversible. So this renaming creates the wrong
> > conceptual pairing. I am open to other ideas on how to proceed.
>
> just make bpf_program__unload() not free anything for programs that
> opted into MANUAL mode? I don't think anyone really is using
> bpf_program__unload(), I actually don't know why we left this API in
> libbpf v1.0+ at all, tbh...

bpf_program__exit and bpf_object_unload use them so just adding the
check to opt out from full release for MANUAL mode will cause mem
leaks for MANUAL progs in those cases. But I can convert
bpf_program__unload into internal helper and then just also call it
from the 'new' bpf_program__unload skipping it for MANUAL mode.

Andrey

>
> >
> > >
> > > > +{
> > > > +       int err;
> > > > +       struct bpf_object *obj;
> > > > +
> > > > +       obj =3D prog->obj;
> > > > +       if (!obj || obj->state < OBJ_LOADED)
> > >
>
> [...]
