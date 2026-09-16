Received: from mail-oi2-f12.google.com (mail-oi2-f12.google.com [74.125.231.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F2E43E068
	for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 19:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789588110; cv=pass; b=C3/HLaKCtj+Cujv7Ltt4UoidAb1rBLoixgrlaHU5xqcvvJahbjBjJKKW+tQdAOj5L++4bKTEToxoUETefT6e8PnC9n6vByHxe5FwHmj1u6Jedg/Dh7daIUo3+xiVR7K6XwHIWpBWNOpsiSp4szWk1ItDfixRizzBMhOAtVqIU3k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789588110; c=relaxed/simple;
	bh=7jrRIBYIeo9ZWvJBvUPUjmtGD45XWSUIw9N8VD7dBfA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mq9Tl7txYPHDwQsBW4w6rcO0w8vfqTvVBhzoJfum7LYPiYhUxszxZN4TD8rA86MwfOcRJ1zFP3e0GJ3YhXdNdXD9e4VLM/UiIlIictZDGhrRXNu8n6pi5T9JvmSfJRqoOljaUpO1sHMHXNoA8m+Af9YIgvkT7IqHwo4Rie1CA/E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PPJ+Dnyr; arc=pass smtp.client-ip=74.125.231.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PPJ+Dnyr"
Received: by mail-oi2-f12.google.com with SMTP id 5614622812f47-4b37a3688a2so100553b6e.0
        for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 12:48:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789588092; cv=none;
        d=google.com; s=arc-20260327;
        b=ae+dCuWdRFTyuSV0rF2blVb9D7FbEhN3i2W/MwnmAxnIxL8gbd1g5ACIs641pOvGvj
         rfxi/CvUNb+QkvwhU/FuZGjSzaGoLCmxDHTCE6X9Q73DB7pEn/q2Q+1P1Ldg6G62UaFU
         Y2WXCwNWnsQZ/ky+UjIgrEyakwMsEX4DlKVyhMC+UhIbTM+zU/R9GhpAkvlsQiEzzh6i
         4sFluXeAcWS5ns56024I/09qKgIDM7Z8Jo2DpPPz+uzXUnrSOZlOjluQUO9y8MzY7wUI
         r8Xewh+h6pzPt1Bvpm78QH9z0FVSkA1F5KtKUrjNPYY97WyZTrQGb5T9eLkUqezTxNtV
         2T9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PEwtLGtWjJW9VQKWAOKEgcq9DgQP3mGFczkkaHSyhA0=;
        fh=PVF5hOV3lFVkYzH+em3TPzA8DUX1nPTQFNVMrTIZklE=;
        b=X/4SsmLeGdAN2vD6/Zr9eXUO4AVOpNk2uG7Qa1FSChNndEXIaHxf5eNl0JVLeNK1E6
         QTtbia2hSfSksPmeC1O1i5EbLFQ4VCeg2vt1hnGO/CfRUP1yjuI3EJB9YYFF1099EWAn
         QEwwkYJEYPROn3Q4nb1yrWhYGVH5KTHgpm2AgRGI2iFCZ/CnAc9Ljh+N3YCO5BUHSVmm
         DRXTnBY/nx9adTVUenv7gtvomWMAajUcxF2m2lgiEqQZcyklABViDNraH2ezr8vgg4uU
         NeOpS4SMdIXft3OEsWdUBcK1VbIATB1bYe5rtocBEBYHqas0HIN50IlBuqbRH9VW1mYM
         26pg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789588092; x=1790192892; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PEwtLGtWjJW9VQKWAOKEgcq9DgQP3mGFczkkaHSyhA0=;
        b=PPJ+Dnyr5xnETA1VHNDNEyQo0tLeZw6jt9SlptBy6hzjNt+Y3qK2tSDsBJ0Pw1xLIE
         JS/L2By/vsDTiiVrAMnrmthGxWUEcTBKNhbeUUr31Tj4c70vBcSXAqfiYpCs8DdM9KfZ
         70IUVBzDdsjrYVaOTP5v7/tgK4/NyMR493uf1xy3P8G6lOE+5DFRF21QHTG6cXKTwlFi
         AJfSi8Pe4vX+9Gn1cn4mg/NlLhGUdZ7JXRu4kwwxob0W9Jo6i0cwochs0tjR5jG0CWVU
         L+zPJxqQ8BdzzxKU9aK0QAgPW01flftpwFYfjJXXUZVaWtaz/FSIwBvFX8siRaTuJWi0
         7KqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789588092; x=1790192892;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PEwtLGtWjJW9VQKWAOKEgcq9DgQP3mGFczkkaHSyhA0=;
        b=tkEFSETxm6ad0Vej6O2gupLchVFvjNJIPqIKQEfQi9d9e306gSMvAOv3utUHDSJNJr
         sj8IOWb4oLe/pqh/54Ra2lXmCnXDW/gVszy5aHoP9FNyWSuOhllldaBoXF/FpXNDdZsr
         xH21c8fYFbeitHc9ogjP5whaKDw/W1jNk2oWpWuXH/pjIVyzqQw5Hk8FzoxCDcn+roVn
         NBULdWkbf/aaNe00T2igJB0prjSj2a778UqKUVEeYSY1wGuL5j93xqcwninK/wJaVdRY
         Ju+YUB2QBu6R88d2gWmiM+1emmaPniSI48d8BAvW/qcVECBgFFieLIJommLHHc8XLbjX
         716w==
X-Gm-Message-State: AFuF++l3RJB0sNA/ZR3aybEhN9uIgq8nmxxucnlFsJBzMrzJAuSRqJw2
	ub/UGYSybaGbIJGYpk6vJanTziLMmyCwv4qCBgA0Gfv8CA2z4B8RBrg9uC/sFR/kGgkzsyQortl
	2Z4qovIwwYW80asMxZNlUxJUNgj6yG0A=
X-Gm-Gg: AYBFou0D7rMKndB40DG1AjLcQS2B3w2ip7F8T9FkM3bc4C+iV8nONRCEKg3EyZEGwct
	YApKzM9YOkQwLIJuLG38g8S6IDdAb1YUtRvAQ/0OTzs57Crvmt//aP3jNxPTfEvkLKD3sX2Mg1A
	I7SjFsVjx49jPC5lAvFZFC2j7aMZNWfgr4SFffNIh5ltO6FK8owMOv9TCa+q0TEEXNwwfAjDaXT
	cLeZLvhpUiO3cVtCLWv8zTWIPScfsJsYR5mTi1gKKcvZJ1ElXCTmRh7cn6OK0qtKNvDZDf4TMJJ
	PbeSKYlFJeUIwPMEBSaAgORzE6u16DTCTupHwet9N9nVoaaFtyBIg04=
X-Received: by 2002:a05:6808:87d1:b0:4b9:a8ac:47f with SMTP id
 5614622812f47-4ca4c6b9aa3mr5551498b6e.29.1789588092261; Wed, 16 Sep 2026
 12:48:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260911220415.1396439-1-ameryhung@gmail.com> <20260911220415.1396439-20-ameryhung@gmail.com>
 <aqkhifLvyAhw66jg@gmail.com> <CAMB2axNCx-+HJVuOmS9hXAidXc0yQgv_+zAfzSkNdDXOZtFP5Q@mail.gmail.com>
In-Reply-To: <CAMB2axNCx-+HJVuOmS9hXAidXc0yQgv_+zAfzSkNdDXOZtFP5Q@mail.gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Wed, 16 Sep 2026 12:48:01 -0700
X-Gm-Features: AcwNN1WpBgL-9SPHf5pu7SHselWT6W66evW2Ha3ZB4mijaTgLyVAO-DWmovvkvE
Message-ID: <CAMB2axPL9c+XAVP0M5ED5UNgt9CDyi2POXkUPHvikt7fPWmovA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 19/23] bpf: Consolidate function call
 pkt_access validation
To: Mahe Tardy <mahe.tardy@gmail.com>
Cc: bpf@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, memxor@gmail.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, one question I have: Even before my patch, the verifier only
allowed one byte of access based on arg btf (char *data_start here).
What do you do with that single byte of packet data?

        __attribute__((noinline)) int
        parse_something(struct __sk_buff *skb, __u16 off, char *data_start,=
 ...)

On Tue, Sep 15, 2026 at 3:32=E2=80=AFPM Amery Hung <ameryhung@gmail.com> wr=
ote:
>
> On Tue, Sep 15, 2026 at 3:44=E2=80=AFAM Mahe Tardy <mahe.tardy@gmail.com>=
 wrote:
> >
> > On Fri, Sep 11, 2026 at 03:04:11PM -0700, Amery Hung wrote:
> > > check_func_arg() checks whether a helper permits packet pointers befo=
re
> > > dispatching argument-specific memory validation. check_kfunc_args() h=
as
> > > no equivalent check, even though kfunc memory arguments may be backed=
 by
> > > packet data.
> > >
> > > Move packet-access validation to check_helper_mem_access(), where the
> > > access direction is known and helper, kfunc, and global-subprogram me=
mory
> > > arguments converge. Pass call metadata there so helpers continue to
> > > require bpf_func_proto::pkt_access, while writes through kfunc and gl=
obal
> > > subprogram arguments use the program-type policy and set
> > > env->seen_direct_write.
> > >
> > > Keep call metadata when variable-size memory disables raw mode by
> > > clearing arg_raw_mem.regno instead, and pass it through the map-key p=
ath
> > > as well.
> > >
> > > This also makes kfunc and global-subprogram packet writes request the
> > > required writable-packet prologue and rejects them for program types
> > > that only support direct packet reads.
> >
> > Hello, sorry I don't have the full context on this patch series but it
> > looks like this commit broke one of our programs on bpf-next, we have a
> > global function with the following signature in a cgroup_skb program:
>
> Sorry for the surprise. Although this was not the patch=E2=80=99s origina=
l
> intent, it closes a verifier bug. The verifier does not currently
> track whether a global subprogram=E2=80=99s ARG_PTR_TO_MEM argument is
> read-only, so the callee is verified with a mutable PTR_TO_MEM. The
> call site must therefore require both read and write access. Since
> cgroup_skb packet data is read-only, rejecting this call is correct.
>
> Supporting this use case safely will require an explicit read-only
> argument contract.
>
> >
> >         __attribute__((noinline)) int
> >         parse_something(struct __sk_buff *skb, __u16 off, char *data_st=
art, ...)
> >
> > that we call with data_start being skb->data + some_offset and now it
> > fails passing the verifier with:
> >
> >         ; ret =3D parse_something(skb, offset_start, data, ...); @ pars=
er.h:131
> >         199: (bf) r2 =3D r8                     ; R2=3Dscalar(id=3D5) R=
8=3Dscalar(id=3D5)
> >         200: (57) r2 &=3D 65535                 ; R2=3Dscalar(smin=3Dsm=
in32=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D0xffff,var_off=3D(0x0; 0xffff))
> >         201: (79) r1 =3D *(u64 *)(r10 -40)      ; R1=3Dctx() R10=3Dfp0 =
fp-40=3Dctx()
> >         202: (bf) r3 =3D r7                     ; R3=3Dpkt(r=3D1247,imm=
=3D1244) R7=3Dpkt(r=3D1247,imm=3D1244)
> >         203: (b7) r4 =3D 0                      ; R4=3D0
> >         204: (85) call pc+776
> >         function access to the packet is not allowed
> >         Caller passes invalid args into func#3 ('parse_something')
> >
> > And this is read-only access given it's cgroup_skb prog.
> >
> > We can work around this by just passing the integer offset and re-doing
> > the whole skb->data + offset dance in the global function (we've been
> > already doing it in some other spots for function by function
> > verification) but I was wondering if this actually a regression or
> > expected, thanks.
> >
> > >
> > > Signed-off-by: Amery Hung <ameryhung@gmail.com>
> > > ---
> > >  kernel/bpf/verifier.c                         | 24 +++++++++--------=
--
> > >  .../bpf/progs/verifier_helper_packet_access.c |  4 ++--
> > >  2 files changed, 13 insertions(+), 15 deletions(-)
> >
> > [...]
> >
