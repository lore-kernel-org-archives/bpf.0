Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BAA73B9608
	for <bpf@vger.kernel.org>; Sat, 11 Apr 2026 17:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775927512; cv=pass; b=IIT9IFTBZ1auQ2NnI+hK5gCgLfvo/IfyWj0xVZPvpNiAE6W4qSK3+PXlsRvUI2FqZZ8Jo2DQpHfxrJPbVh9qDIVIln9ToeGTPR9fdx5PlznyrF40HZVzCAhr7/bUjDGAooff5o751MC0CGYCKcX56VZ4Yi5F+tXk7Dggm9V+POg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775927512; c=relaxed/simple;
	bh=eWVvSlGwW8qlVNML2KwLwIr/MLYKSiPh1Y19hzJS2eY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LNvuJraHpOngYnD/+CWJzpOGQVdAihLrLRELLxihX4h6LIPdbHABDTa1JgwR1ngjG/HlDLDHAefkfI//JsnnqEymcaaU56HwzNeZb3bN/HhWM/mAkQT505n18zOjInJrm+PhUrBJzUItI4dufHZIBC/WbxkErW7P8tSP9fspEIA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o07Sq6e9; arc=pass smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o07Sq6e9"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-43d17bb1c1dso2444199f8f.2
        for <bpf@vger.kernel.org>; Sat, 11 Apr 2026 10:11:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775927509; cv=none;
        d=google.com; s=arc-20240605;
        b=VirSP379bjvgocyRTKurhWCnnIY40HCNaTHHO/JiNhwMnbWPZgtJ4acg4NkUL3YIBu
         ck09h5V42DmG82WrVFhwdC/Yv42ZPhCH+2wPxQfxtOgT0zEZT3l86Ffwep5dm/7eR+6+
         ANsRW4JVswODof7rgFtutDlj9fU5bg8GhPqEcCkzMdD+rg2kQ8NWWOI11JuzkNNfy1l7
         KN9NqFTECzMeh2LxRo+9QfIDG3FIAkVCcKJB8cLdu8xbb2sou09Bk7DNGtd3kbKU/oHn
         7VrOUMsc3osnOcpub5i1Cm+ymSer2F1qfr8HdWN2UkUop7nKnlegDz3fmw7qX5SnoXAt
         Zv+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=E8BI6rhlMtlSuplpTUVFQcStsgNDWUSIkfvD3X7GsUM=;
        fh=uY2FGmYdBe2KIhqBO1v4njEpuWy819UyY6mKhq1sFhM=;
        b=LCJO+/FFWr27yDc3dgv3UTXtNo2mktYtNK4G18cJVg88VHO2IMKXnTJ92HKwx38dM1
         7eeXxzCVacRW1LIksqGhIjsHp70U9J1js/3iSFN9/OnguN8Oy2esB95z8IJ1xIRd2XHm
         09UvyWqyK7TP2AIiZerAHyndDPIJNjmsl9lLCHBXqp+xUJn9E1an8FrXVbTstYlwbnt8
         VM1f9tf00jo/WnYHbLO5FhMC6fXiNFQKyoHwG04pbGWbU7LuMWnvGCtKxNSw6w3bGfIY
         zziKfcSyHJa/yef2LaZSH0eUfecCOvJhW8FOZBC8cF6Bbo9MjuZWvSTEAzTCXx0DV3S8
         EF0A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775927509; x=1776532309; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E8BI6rhlMtlSuplpTUVFQcStsgNDWUSIkfvD3X7GsUM=;
        b=o07Sq6e990oJURVuWGTTMY6vwRGMXR1DcWmyYlAEAiEzCnb4dLmlV0KO/YpwtVSwvx
         9RDvUA9byopXhde4MjDvlLsFJ3142JX9G3eJfs3HU2dv358NEKgmFviMbPjXtNfga5YT
         eCgUyEwnFFB6cF1p0L9w7flfsxtx3rPeWPvOeu44ZcoyB5sg3ZfTy9Odw9AJV+2vOgRj
         LahYPLvXZVfiRYOk0wFg2XxAlMPjEC0fkjXZZOK9kFpGy0VatZC1z7FlN3LD97+PuqnB
         0Qb4fQfUVUtzzh9dbi+iSZ+CE0qxtLj5WfHxJnfPibXfL/+4Gxty1B6LpX3G/1H7aH1K
         ghuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775927509; x=1776532309;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=E8BI6rhlMtlSuplpTUVFQcStsgNDWUSIkfvD3X7GsUM=;
        b=Ch7Gz8jVvj7Sh+gHtw64rLEe15vCXPWImD4JcXwVO1r3f3pHexGStPdpVXORr0Kwwo
         mt2GZKysucl2Q3Vl2lRmDrIOXQQxqv019/idzslzmntTbWxUJVBowLajdJ8fJvGtUD+o
         mgW1TxMFLpw3SVLv7ehzjFyxXknYkxUkRgWjN4m6JZ2F5lJ5KVMaVOr2KM8YEWLY6B1P
         8/1p8BDpsDUHq6PHM1ZUoLYQxqU8ZTOdFUATyzxNpSL5gsoeHoPPVAxmqZU4Zbm+zXAm
         dzZ9eNhT525PcyQ7nz1FrzKgJwL1WESuHnEzbxweNw49RgGZweCUyoVHLnjDCrxSHJJ3
         bGcA==
X-Forwarded-Encrypted: i=1; AJvYcCVeeVc8pS3rZpqvDLpQJgRYobQVIsqJwS1JH/VABhoZPwEYJN+c6Jg+rY3lU+7ZrW5/vqs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzf2OssqudPsxpyv6QyzqtPBqS92jyZmH6QCvrSYDAV8vOMgJOf
	obFleMxcnv4jAVl00c2z1js/5AvYnx2cJKNlA8kmUAUQ92ZWDwsk0xcwunV5yhscw04Z06Y0u6f
	CL8OpNfm+V+Lmv2LbsCeIBVaWzwLvyOM=
X-Gm-Gg: AeBDieuU4ucASZo2AWS5RcIbdwEfWZGyf4lEsaL4Y9thoLGvlqoePvrt87xP/+VB2D2
	rsZWniVN4O/gE0btAAi0urWQpTlsR3VQHKDQ8S6zzJsiFVkbBwrAinIqswRlgpZUd7RTM24fQC1
	z8uFZiDV/zgwb3oGio+l5BERgkgOL/DXUZgy/45UOR3P3CILFHmCGNNRfEZj1YEYJU9nKSQnTb8
	PUzcZ4DSPS1O/Xm8GheiGtk8Tao8afgYCTjDkzykPir+sRuisl7AUKo/1cyVDlzBRfWkVrTiS+B
	jp8msWlqr32NLqP5tojX97m/BAW11pYm0jC92KmAKu5RvdSE2fmyEyKCts3GUjO9HZ61BzR3MSp
	8sB1ilH06Qp93rodGei423OpYJMHPDiwVpIx3
X-Received: by 2002:a05:6000:184f:b0:43d:61:652a with SMTP id
 ffacd0b85a97d-43d642cd3f8mr10908143f8f.40.1775927508541; Sat, 11 Apr 2026
 10:11:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260411133847.1042658-3-xukuohai@huaweicloud.com> <e7535d00be73466e4a09621be0cc898e0ab76422427a17996e4d34712d16fbe3@mail.kernel.org>
In-Reply-To: <e7535d00be73466e4a09621be0cc898e0ab76422427a17996e4d34712d16fbe3@mail.kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 11 Apr 2026 10:11:37 -0700
X-Gm-Features: AQROBzD1PETSYrQ_4Ut3JAZoHyozvOBttmiXhABIYq9ciFQj2SBH_0deqnr1OqY
Message-ID: <CAADnVQ+482iOBCPieOVGd5yBdkBeSjVj75xehNAjeJJaT9rKqg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v13 2/5] bpf: Pass bpf_verifier_env to JIT
To: bot+bpf-ci@kernel.org
Cc: Xu Kuohai <xukuohai@huaweicloud.com>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	Puranjay Mohan <puranjay@kernel.org>, Anton Protopopov <a.s.protopopov@gmail.com>, 
	=?UTF-8?Q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>, 
	Shahab Vahedi <list+bpf@vahedi.org>, Russell King <linux@armlinux.org.uk>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>, Hengqi Chen <hengqi.chen@gmail.com>, 
	Johan Almbladh <johan.almbladh@anyfinetworks.com>, Paul Burton <paulburton@kernel.org>, 
	Hari Bathini <hbathini@linux.ibm.com>, Christophe Leroy <chleroy@kernel.org>, 
	"Naveen N. Rao" <naveen@kernel.org>, Luke Nelson <luke.r.nels@gmail.com>, Xi Wang <xi.wang@gmail.com>, 
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Pu Lehui <pulehui@huawei.com>, Ilya Leoshkevich <iii@linux.ibm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	"David S. Miller" <davem@davemloft.net>, Wang YanQing <udknight@gmail.com>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Chris Mason <clm@meta.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 11, 2026 at 7:43=E2=80=AFAM <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> > index 3fa3c74869d0..bd96b3a01b99 100644
> > --- a/kernel/bpf/core.c
> > +++ b/kernel/bpf/core.c
>
> [ ... ]
>
> > @@ -2553,46 +2530,53 @@ static bool bpf_prog_select_interpreter(struct =
bpf_prog *fp)
> >       return select_interpreter;
> >  }
> >
> > -static struct bpf_prog *bpf_prog_jit_compile(struct bpf_prog *prog)
> > +static struct bpf_prog *bpf_prog_jit_compile(struct bpf_verifier_env *=
env, struct bpf_prog *prog)
> >  {
> >  #ifdef CONFIG_BPF_JIT
> >       struct bpf_prog *orig_prog;
> > +     struct bpf_insn_aux_data *orig_insn_aux;
> >
> >       if (!bpf_prog_need_blind(prog))
> > -             return bpf_int_jit_compile(prog);
> > +             return bpf_int_jit_compile(env, prog);
> > +
> > +     if (env) {
> > +             /* If env is not NULL, we are called from the end of bpf_=
check(), at this
> > +              * point, only insn_aux_data is used after failure, so it=
 should be restored
> > +              * on failure.
> > +              */
>
> This isn't a bug, but this multi-line comment has text on the
> opening /* line. The BPF subsystem preferred style places /* on
> its own line:
>
>         /*
>          * If env is not NULL, we are called from ...
>          */

AI is correct.

pw-bot: cr
