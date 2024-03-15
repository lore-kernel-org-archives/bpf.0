Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BAFCD2FA
	for <bpf@vger.kernel.org>; Fri, 15 Mar 2024 04:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710478071; cv=none; b=ReQ9D5itZ3gmke/ZY+Mhq8LCz8XB/eOpVkKyLZTjfR/IZo6kFojLbVUxy6hfE0Jm61shywg9FOMJff2maxqiE1H7eAf7pQ1DfamxSOTQne0CDLcT3KJoAUskw7TTdbIVeeC/gWSAJkpe+crX3Krb18Lhz5fDxfwUxJqBevqo2eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710478071; c=relaxed/simple;
	bh=b6wU4RrvfqK8UCe1cRHFmg1WnI1R+g6RCtD7QE3x78Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pzyPYWWacxcFSo65p1nTnbZV1bIqVviN9ZC3GnPQLYHfUJWImXQXXPtEZlC1fLQpiDnoGV40h95qhfbGccBeHXrlvFjYGEZbmzUNj53JUqEx4l2c25SogUgYFMMkAtIsnEeC8ijnoLSmj9uG01eEJGm6cXwhkQ5wI+rY5oeZrJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RzoDsTwa; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RzoDsTwa"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-33d90dfe73cso1025491f8f.0
        for <bpf@vger.kernel.org>; Thu, 14 Mar 2024 21:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710478068; x=1711082868; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=drAWQCIEo7HnhwH/20r3m7PK4SqH9lkXzwna5fph/xE=;
        b=RzoDsTwaaariagpBUNlKKcrN9AgFPUNmFdBAoAjtN2Lkl4wvvt6nZ4+HnjnP2t8mmp
         ESvsLip0lKw8cx6SCDtN87BlRmYOzriOrd3q+KSeOzc/kv6w18Z6ZWdj55Y/qXw1wIn0
         MRwEVxw/ZGwQIt+O8yLqAasd8jOr2wMBPn26+2Xm6rD9H2dfIvPf8MX5v3eNkgegOpQz
         tC8ZHw4EM7kNIpLKktJEvmTECWbrFNUHnuWBJo7EY7Ahoztn2EVIakFy1oLH3t/eE6b5
         5hea6VmTlNsntsBFjO5oybRuY7zIrOCOcS0/MFE2pRxnbSbLsAhBNWT/cV9mjp0oDzPu
         AVnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710478068; x=1711082868;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=drAWQCIEo7HnhwH/20r3m7PK4SqH9lkXzwna5fph/xE=;
        b=JlGpSSBJR19OBRLATocIDKY66F+OtXJ0PQ9aXdlqIt725TdUq3FOptL5xc6ZowGfdb
         rEoPO1D7YEu/EtVEeC8o1uwp5N7n05BC8m3+tLcup8JlPbVy+GnKwWH68GYE9jdq9iJx
         m2V6iu/jQ2VbzryAWBcmdp4fURCXJnAgq3wZzuZ3z3svtqQWq9CNt+0bHTprtId3HRzW
         0D077Qz8Ee+ik5zwfsR+Ke4UIDCj7PPCWWiVLFGUCG25UaXto8YyXjrnOu9MPqE5zIDp
         dzP40bS/ivpyC36YZijZnW1xs4p/IcGxRHPxJsgVv9+tE8lMuNPLUWAxphGE6nAj5qhY
         snnQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRBXm/OMkRMVxxIK7NiVVyp38ongCxvf5YlzZydmenldHgpvboPRytpv0yC1ryO0CHWO2/QyjGM5COxkH8sOIrXmxj
X-Gm-Message-State: AOJu0Yy2gIB2h3Vf1YxjSc8kIfuLpH00/i0/LAf6VO73SYpXcEqROTtE
	mUGoymL+e/QrqgIFbcupHlMNKBtsoDkIUvdnxfno13+pOft1MvU5GuAeP8/eU2awPDUreEpIptn
	21gw9D2IOyXPOhe6pDzxXCaoy93E=
X-Google-Smtp-Source: AGHT+IHBympoQ2Mbogu/i4u7YvSlzy2eLaRYg0+1fpI2KngLwdRvxBy7a1jwK1b1F+qHFIXeP3Y4VsJ207uHjyp1xj4=
X-Received: by 2002:a5d:5051:0:b0:33e:c69f:6769 with SMTP id
 h17-20020a5d5051000000b0033ec69f6769mr4171182wrt.26.1710478067679; Thu, 14
 Mar 2024 21:47:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240312222303.2305873-1-andrii@kernel.org> <CAADnVQLBciwQ22GE1z6Sf-r+V8JRDfMjMVQWburR_pPgLj9XZA@mail.gmail.com>
 <CAEf4BzYwpFh9LTHW2s9G=mgyKcPZO9Knu_EYrgwPb1h=SByuXg@mail.gmail.com>
In-Reply-To: <CAEf4BzYwpFh9LTHW2s9G=mgyKcPZO9Knu_EYrgwPb1h=SByuXg@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 14 Mar 2024 21:47:36 -0700
Message-ID: <CAADnVQLaAP-aw9KAe1cvsYOTxf7=_SB0qNdbZv-cGb83pxUyuQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: scale benchmark counting by using
 per-CPU counters
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 14, 2024 at 8:56=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Mar 14, 2024 at 7:33=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Tue, Mar 12, 2024 at 3:23=E2=80=AFPM Andrii Nakryiko <andrii@kernel.=
org> wrote:
> > >
> > >
> > >  static void trigger_base_measure(struct bench_res *res)
> > >  {
> > > -       res->hits =3D atomic_swap(&base_hits.value, 0);
> > > +       res->hits =3D sum_counters(base_hits);
> > >  }
> > >
> > >  static void *trigger_producer(void *input)
> > > @@ -42,7 +72,7 @@ static void *trigger_producer(void *input)
> > >
> > >  static void trigger_measure(struct bench_res *res)
> > >  {
> > > -       res->hits =3D atomic_swap(&ctx.skel->bss->hits, 0);
> > > +       res->hits =3D sum_counters(ctx.skel->bss->hits);
> > >  }
> >
> > It was zeroing counters before.
> > Do you need to zero them now?
> >
>
> sum_counters() does zero them out, it does the same atomic_swap(0).

I simply missed the swap in there.
Could you rename it to sum_and_zero_counters() or
something, so it's obvious?
A helper that says 'sum_counters' isn't expected to have such side effects.
