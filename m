Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066F83DDDB3
	for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 16:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773247113; cv=pass; b=Mg0wrXs0R9WnmyXvAYZBm2Z2NRG1i1geePlf5tOXSlTGa0X/RoY4MRs0QJcpUJm9M827ZzAFvi1MhsGunr3tmOyPiPdo4Os0ORiCDzrWOx7IR5E2awZINx7LwfPIgh6lu8/7d5dNaJCgC+kUoWyeBtf5HofMfCCyZzlyqU1l4q8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773247113; c=relaxed/simple;
	bh=AMMI15d+s7pTmfoE1fiMuQZTwNVK4nGX6l+tsFLNgrg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RcKV1mFZDYSblziIUn6bkZeHMV0wqmulOyjEgOR6NSCafV6oc09Jn6AhnQdPsj+eTnFqRuafcb9iiPJNdRx5scYfKrK51kNY+yU8QtMQ1IFIGpTYcB/Ge90IG/X3mgJZwTWnwK/wpxmRHHPssjFfeeHCvHfLOChcVgNk5bT2Gpc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JDA6e0Km; arc=pass smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JDA6e0Km"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-64ae222d978so101652d50.1
        for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 09:38:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773247111; cv=none;
        d=google.com; s=arc-20240605;
        b=E5He+4lrw1bLAlyoH1hwDAwsaQyPqimeBX9iwmao3KzMw4aNtQamCch23ejmabdK1u
         aljGnZNSnZmWGcKzQGdouMeVD+arYTyYNoldFOKqU12E9g5SXGtXyetBEgu2p5XeTa8a
         +fnGwgeS6dmNaYbmp7YRiwLqd1eudTvYkB9XIRMVGAJUd/kq9qOna3HwuRtssuN5X4R1
         4aX4G22eD1E5C/cZWpneg/vnoxOhmljjSIHGVpaMd9oNUZTkV/rj1plAyI6J1J7b+4/a
         82R5/P+DMgr7NYmD1GqO60XUTM6FojjATykoqRWQ/CvRn8QFioBLtB/xCprGIWNO6m6q
         IBzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6fElsDI5EEh6ALprW2iuuzCdvhv2CT1kMYpnMsm1Ty4=;
        fh=reLytoccIbymnfxd0qOWViuC44C/L+sUMs8tM0wQ/L0=;
        b=hn9MsQxqIn/SUExXrrDvT47yeMBGxOHgxHpIO0vWXBDfKVuOgEZwdPj1LwbgnTxvJL
         sWBzRNsA8tI5Y2d9JgdDoNhBJjs39CNnyj3nb+EylviOgK78t/dJ++o5wa5bUbe1iL7e
         auI2O/caKWBaf6yb0I0C/6yP/ke4NL+p5ip93ANCGbv7WxNdfJCjsBNM+JiRRRQDf8US
         04PM36SnSvLbX7UwdStA8D+5fPCBqxCIzVu2swT/RnWCNDPTk0XpmXoDxV6vM0l0jwPr
         3hk7eQ28p+b+4QqeB455L3UhHKli8RpJ3/WDoJEHt1kOoU60fdvN/u8lpgw/lPwMEozX
         WqRg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773247111; x=1773851911; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6fElsDI5EEh6ALprW2iuuzCdvhv2CT1kMYpnMsm1Ty4=;
        b=JDA6e0KmSuuoNsJ0kUKVDpQWfcwCtSCHyB2bz9sxFUDvAIgzOlVLFT75sC2k/L9nje
         IZkQYuVWnVT/5g83VtO/lJWwTuQhDTnQFWDmixPzfeG6TZpWOyvzhKsM/TtarWd9YiZU
         s6ooRczlO6qLovgbo9JJKADByu4PvbcJYF9rDPjemsfD6BVNqLmk1g2pxs/JTx9RUwEP
         DZNcvQbY6lgnYkbeLELsG5MDRaDhOaStFK9814uzIRrvxCvKlVKGMtEe544XXCcQvrcW
         fpoX1cDmLsl7efz833uAI+EWWiIOoj1dSh/WX0J+h9M+Lvm5JCfXMQS6V5LqV9qOKt68
         Ko2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773247111; x=1773851911;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6fElsDI5EEh6ALprW2iuuzCdvhv2CT1kMYpnMsm1Ty4=;
        b=RPrVy+StsQ2lORtRQpQk8mrVNDtO2eqVy/U2pcvXL1eeP5ieZ+d5/EzMr5N5h2F49b
         cnniXh7nfKy6Kt9xSUB3vpnXLSOYWmWLZmKHxTAuvcF9eW8MlA+/VbTuj37zE43vtOUe
         hC69sQqPeAOxmohrSeC+Q+/fJI8Z95grwHFVyfWWugww9WroDHTwVbBCXrcNkM1xg28v
         au9W8tJAg4h/oMxo/qJldTO9zeCjXZ1eP9uWa7eyzpMGg2Bfk2XEFE7EtxtFOIaPJbK8
         N2anXLNNUG+iETVqhXupxBemCAX6P4PELVliKHIfBRQ07LxgkV88DwbPNbsWNjycoQK6
         o/+Q==
X-Gm-Message-State: AOJu0Yx1Q+a+OTV/HY6qolBGU2JeAXEbjZMgh8YP4VzifAUHuxIJDqzb
	zGATclyHTcRnJUXVijUC9BD1b7fy4Hhn9JBdlRcgC4A/GRbXWQozqyZngmN+CTGfY/KmUtcd1Sj
	cohDoNOhd1ArBaTM4iRMBYH5RzeG1aDg=
X-Gm-Gg: ATEYQzz4pK1Xbg17X0Su9rTUirgr7SlpahCv5Ht82OydAg3OdI67gLbHX6lW3D+OOom
	OBYSC78o7YBgE2yLBN5gxoXdrMrHXIhIYkCRFVNAtmNMlfj5z0ISTWbkMXZZ1EBP8PT7ST5GJS3
	bBV6RhHqcWVl4fjqbSuSvP4FZZOIboE95qlH8ylkxFyYXXrM6exK08Agyc4HCzwKR76i5d1MFuc
	Dke3tdG5A3SsTYbzJJ1NZBxkK9Udm88g0YMvL+9WUh4Io9LumARQypMet4Zy5CIxYFGz/4dk1lQ
	rFsIwJs=
X-Received: by 2002:a05:690c:6e83:b0:798:2cd4:5567 with SMTP id
 00721157ae682-79917fce634mr31914247b3.56.1773247110914; Wed, 11 Mar 2026
 09:38:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260307064439.3247440-1-ameryhung@gmail.com> <20260307064439.3247440-3-ameryhung@gmail.com>
 <87ldfytmja.fsf@gmail.com>
In-Reply-To: <87ldfytmja.fsf@gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Wed, 11 Mar 2026 09:38:19 -0700
X-Gm-Features: AaiRm51dqOIMR6ioMceqANJxWV3HRlorIvLhVhQ8U3y78KKMZL76mjWV4QQeICA
Message-ID: <CAMB2axNWHa9aTigQ4G1zxuYtzC7QNj1KVQZNoFiY9fNMhUBsCg@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v2 02/11] selftests/bpf: Test passing
 CONST_PTR_TO_DYNPTR to kfunc that may mutate dynptr
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, memxor@gmail.com, 
	martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 11, 2026 at 8:26=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> Amery Hung <ameryhung@gmail.com> writes:
>
> > Make sure for kfunc that takes mutable dynptr argument, verifier reject=
s
> > passing CONST_PTR_TO_DYNPTR to it.
> >
> > Rename struct sample to test_sample to avoid a conflict with the
> > definition in vmlinux.h
> >
> > In test_kfunc_dynptr_param.c, initialize dynptr to 0 to avoid
> > -Wuninitialized-const-pointer warning.
> >
> > Signed-off-by: Amery Hung <ameryhung@gmail.com>
> > ---
> >  .../testing/selftests/bpf/progs/dynptr_fail.c | 37 +++++++++++++++----
> >  .../bpf/progs/test_kfunc_dynptr_param.c       |  2 +-
> >  2 files changed, 30 insertions(+), 9 deletions(-)
> >
> > diff --git a/tools/testing/selftests/bpf/progs/dynptr_fail.c b/tools/te=
sting/selftests/bpf/progs/dynptr_fail.c
> > index 8f2ae9640886..5e1b1cf4ea8e 100644
> > --- a/tools/testing/selftests/bpf/progs/dynptr_fail.c
> > +++ b/tools/testing/selftests/bpf/progs/dynptr_fail.c
> > @@ -1,15 +1,14 @@
> >  // SPDX-License-Identifier: GPL-2.0
> >  /* Copyright (c) 2022 Facebook */
> >
> > +#include <vmlinux.h>
> >  #include <errno.h>
> >  #include <string.h>
> > -#include <stdbool.h>
> > -#include <linux/bpf.h>
> >  #include <bpf/bpf_helpers.h>
> >  #include <bpf/bpf_tracing.h>
> > -#include <linux/if_ether.h>
> >  #include "bpf_misc.h"
> >  #include "bpf_kfuncs.h"
> > +#include "../test_kmods/bpf_testmod_kfunc.h"
> >
> >  char _license[] SEC("license") =3D "GPL";
> >
> > @@ -46,7 +45,7 @@ struct {
> >       __type(value, __u64);
> >  } array_map4 SEC(".maps");
> >
> > -struct sample {
> > +struct test_sample {
> >       int pid;
> >       long value;
> >       char comm[16];
> > @@ -95,7 +94,7 @@ __failure __msg("Unreleased reference id=3D4")
> >  int ringbuf_missing_release2(void *ctx)
> >  {
> >       struct bpf_dynptr ptr1, ptr2;
> > -     struct sample *sample;
> > +     struct test_sample *sample;
> >
> >       bpf_ringbuf_reserve_dynptr(&ringbuf, sizeof(*sample), 0, &ptr1);
> >       bpf_ringbuf_reserve_dynptr(&ringbuf, sizeof(*sample), 0, &ptr2);
> > @@ -173,7 +172,7 @@ __failure __msg("type=3Dmem expected=3Dringbuf_mem"=
)
> >  int ringbuf_invalid_api(void *ctx)
> >  {
> >       struct bpf_dynptr ptr;
> > -     struct sample *sample;
> > +     struct test_sample *sample;
> >
> >       bpf_ringbuf_reserve_dynptr(&ringbuf, sizeof(*sample), 0, &ptr);
> >       sample =3D bpf_dynptr_data(&ptr, 0, sizeof(*sample));
> > @@ -315,7 +314,7 @@ __failure __msg("invalid mem access 'scalar'")
> >  int data_slice_use_after_release1(void *ctx)
> >  {
> >       struct bpf_dynptr ptr;
> > -     struct sample *sample;
> > +     struct test_sample *sample;
> >
> >       bpf_ringbuf_reserve_dynptr(&ringbuf, sizeof(*sample), 0, &ptr);
> >       sample =3D bpf_dynptr_data(&ptr, 0, sizeof(*sample));
> > @@ -347,7 +346,7 @@ __failure __msg("invalid mem access 'scalar'")
> >  int data_slice_use_after_release2(void *ctx)
> >  {
> >       struct bpf_dynptr ptr1, ptr2;
> > -     struct sample *sample;
> > +     struct test_sample *sample;
> >
> >       bpf_ringbuf_reserve_dynptr(&ringbuf, 64, 0, &ptr1);
> >       bpf_ringbuf_reserve_dynptr(&ringbuf, sizeof(*sample), 0, &ptr2);
> > @@ -1993,3 +1992,25 @@ int test_dynptr_reg_type(void *ctx)
> >       global_call_bpf_dynptr((const struct bpf_dynptr *)current);
> >       return 0;
> >  }
> > +
> > +/* Cannot pass CONST_PTR_TO_DYNPTR to bpf_kfunc_dynptr_test() that may=
 mutate the dynptr */
> > +__noinline int global_subprog_dynptr_mutable(const struct bpf_dynptr *=
dynptr)
> > +{
> > +     long ret =3D 0;
> Why do we need this long ret? Do we even need this function at all, why
> not calling bpf_kfunc_dynptr_test() directly from the
> kfunc_dynptr_const_to_mutable()?
> > +
> > +     /* this should fail */
> > +     bpf_kfunc_dynptr_test((struct bpf_dynptr *)dynptr, NULL);
> > +     __sink(ret);
> > +     return ret;
> > +}
> > +
> > +SEC("tc")
> nit: it looks like most of the programs in this file are optional:
> SEC("?tc").

I will make it SEC("?tc").

> > +__failure __msg("cannot pass pointer to const bpf_dynptr, the helper m=
utates it")
> > +int kfunc_dynptr_const_to_mutable(struct __sk_buff *skb)
> > +{
> > +     struct bpf_dynptr data;
> > +
> > +     bpf_dynptr_from_skb(skb, 0, &data);
> > +     global_subprog_dynptr_mutable(&data);
> > +     return 0;
> > +}
> > diff --git a/tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.=
c b/tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.c
> > index c3631fd41977..1c6cfd0888ba 100644
> > --- a/tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.c
> > +++ b/tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.c
> > @@ -33,7 +33,7 @@ SEC("?lsm.s/bpf")
> >  __failure __msg("cannot pass in dynptr at an offset=3D-8")
> >  int BPF_PROG(not_valid_dynptr, int cmd, union bpf_attr *attr, unsigned=
 int size, bool kernel)
> >  {
> > -     unsigned long val;
> > +     unsigned long val =3D 0;
> >
> >       return bpf_verify_pkcs7_signature((struct bpf_dynptr *)&val,
> >                                         (struct bpf_dynptr *)&val, NULL=
);
> > --
> > 2.47.3
