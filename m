Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F5F26A08A
	for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 16:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773248233; cv=pass; b=AqWzJ/eotSdED9rdwVGmDVj+rXa547Hk8ioypo6Navgw5MQt+gcBYPZEiV6PGMoyCxxyxz3FJ7DK1Bxb5rlGtP0yC5+soBWd+aRzhpPr/2FxeWXsre24rXiJAMw2lt2JZucPZD1JKd5zQ5X4VwZ4GXJLOl2cEYd+/WH0xGVOHhQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773248233; c=relaxed/simple;
	bh=BRB3wDLz/jn2nOvVLIccx2wENPSwD58xFUwhfC4aI9M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gbeugWkZaKAWFyha/ub90NUW/9Ch5LhYTfUm61ITTAdfEU6RXEBcbWI+eWJLTT+7Bcn9n4wpwjLbS6IQOhPDIG8CIud98kjof0IhRPwILyQPa7CRvQIg9thjkUIdepadwf2p44tm0EHIF6B/m2lHRnMRRj4e6/Bt3kVb0GDO334=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jzROdWa8; arc=pass smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jzROdWa8"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-7991d890ebbso435147b3.2
        for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 09:57:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773248231; cv=none;
        d=google.com; s=arc-20240605;
        b=XQBOTSvV+1iVCoSO8wfKUEoTimuZNMXQwCJzAY/gnZnRexcL44B84H5xXjMuBZkPeV
         2ZBNH06XDLrNvW+g7tmXiIpPlXxThYcb3BrBRsNINjYBEyuTZqampngn8vVj/qf69dNm
         kyWjiZSTYBN1vE8cWy2E2lBBUuK5ZJd/e4uqXXShbgydgv5XnQC12U9g9Hhmwtl2Q7t6
         1to/MDU8Sby5BB1CleovT1zCkACNMOphFCogEV6wngq0MomdIpEkvWhUdQHVwsDL5FT/
         Ku3IeIq/t43nopyOZTkW+CDDJXEZXMEWyS4ZzxM+Mdo+/3/tZMgLw+qck+PofwQzix+3
         9JkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MRLF7utSMB+F1MK0j+aEXx5BvijhWq8cP3RtjVJVGqE=;
        fh=reLytoccIbymnfxd0qOWViuC44C/L+sUMs8tM0wQ/L0=;
        b=M12wdIuFXpFpCYs8ThaOs4OaKQhoG0c/SG/squQx4JET4sgTZmFBhZnA7jWyiG4sXj
         4GtfwmUj7csBGY+UV6RbT+D21XiDSRj51oilRGVE+2OfKmOJnAFU7N4xcsSjx2xL7iuO
         iy4NfZA7Pxr6I3ophNe+i2qkUQO3p73PAhg3pzeqeFlUomulv+dPbmoPMheZCsogMTRI
         2317gC1MBk42p9/GG3JQfhqPNz6PfVY0LidjDCheymxewdSlJjnzmCDtNo1UpvqdAclz
         sQ1nLSTswpVW/QyPecj3meW0gS4xd1NK95q8uBrcOnY62b2opZLH+erKc1GSylXv3SgG
         AVKQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773248231; x=1773853031; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MRLF7utSMB+F1MK0j+aEXx5BvijhWq8cP3RtjVJVGqE=;
        b=jzROdWa8+OThkXfxjY7iBbfEA5r41YOAumqUS/+CP/6mBPFm9n4LBgyhhhRAXqh75V
         emGEP9n7Pc9eDeiN84N2QXVq2taAsPQS2Nr+BwruIDoeZKn9yPRygRdB5xV3fVcAault
         7zlqWIfgpKi3Ef2wIrQ6lHBmPg/YlA5wGfmovEB8VibbIYoHXbtZXHUWOfmlu2YLf4H9
         oERNu0urlrBrCL6wM3V8eqFVopzIMmbS0PaI7e6glbFS5HJOHJ8SfadimyhuZBcBHsMB
         SZ6604rHu8kSWlrNm2fVxAbTu+pjM0emU0aoRMfX8ZqscV7RsT58SQG+tFEjrNMwP739
         4m3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773248231; x=1773853031;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MRLF7utSMB+F1MK0j+aEXx5BvijhWq8cP3RtjVJVGqE=;
        b=a2X2lfPkgPLi5lPI24vY9xVBxaAKIrWiMRGJQ9BB39l992s8y79bBbqHk9LqM6xXb4
         6EBRlbJtJ2fZvqt/i7LJ/UrFHe9+Ale0PWQZWPoQ9b/sYKe6SvmdBcXyMTW6hrGOHUCv
         gwVxcntJ08c3kggaqomuQpG8hPI4GCTdkIlhSR7AdZ4PatJiU+AWQMERrFnXlIGIvqcb
         13n0+bnputxTeYDapnMhLH1ujOYcbZDoxHX1cfIos7IEXaOqmbn+ZYXikG87qhhOyua1
         /DCm9RtXhFuaVJgbaHy6DULQqbp23379h8R4CFhMMwZma/KH3nULCFqyzTDbWrKxvwzv
         IDYg==
X-Gm-Message-State: AOJu0YwgndcEGUUEfiWgEQ3E7X7L8Gw0/66rM2zPsGczpTk4EkK0jjrx
	mhpyfV9+CIeJhQTRRoi4C1JBmnw3iAoGXnaCW0krkErRy77K4I0L6RXld6g1grmOt4XtVKBMTx4
	sBSsCsD2tP3Jfg0oker8PlQ/Ov6y2fH+8eSWORZc=
X-Gm-Gg: ATEYQzwbpd76g1utrtBvB9PGNf9jgTCFcgFlgu9tBOaWi1ekTgogjrLd9ac6YBRoKXY
	slHxOCXiK9sOB8NoCpuPpTlVbupVlADafMsWM7tvSRg2QzURP48uu7QitbGMZ9dOyIJt/epNcfB
	xGsSSvq53QSz52mBOUHtcrEZ5tGwkk2KEcOdlBWSunUEHaEXRRE5ZqRdWk8ZRp+mTsRZLhEZElB
	kK8K3r1DiXNjVrrgPyx7drOyxwB6TcBzRDzN1EwfQRlmFDzeydkGyiJXmE/FyxaoSnk+4TyCCQF
	GzVMOaM=
X-Received: by 2002:a05:690c:22c6:b0:798:36:e110 with SMTP id
 00721157ae682-7991801ac2cmr30369447b3.62.1773248230893; Wed, 11 Mar 2026
 09:57:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260307064439.3247440-1-ameryhung@gmail.com> <20260307064439.3247440-3-ameryhung@gmail.com>
 <87ldfytmja.fsf@gmail.com> <CAMB2axNWHa9aTigQ4G1zxuYtzC7QNj1KVQZNoFiY9fNMhUBsCg@mail.gmail.com>
In-Reply-To: <CAMB2axNWHa9aTigQ4G1zxuYtzC7QNj1KVQZNoFiY9fNMhUBsCg@mail.gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Wed, 11 Mar 2026 09:56:59 -0700
X-Gm-Features: AaiRm51CQMvijRuppXo8FNftbSnpPNiYu2yHtuE3TPP_jR4RQ3GRPGA6-QxhbCA
Message-ID: <CAMB2axM2y2zZxCf5e4rmgK5yB4t14Oqn2-3_+xVHbVmWmOXycw@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v2 02/11] selftests/bpf: Test passing
 CONST_PTR_TO_DYNPTR to kfunc that may mutate dynptr
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, memxor@gmail.com, 
	martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 11, 2026 at 9:38=E2=80=AFAM Amery Hung <ameryhung@gmail.com> wr=
ote:
>
> On Wed, Mar 11, 2026 at 8:26=E2=80=AFAM Mykyta Yatsenko
> <mykyta.yatsenko5@gmail.com> wrote:
> >
> > Amery Hung <ameryhung@gmail.com> writes:
> >
> > > Make sure for kfunc that takes mutable dynptr argument, verifier reje=
cts
> > > passing CONST_PTR_TO_DYNPTR to it.
> > >
> > > Rename struct sample to test_sample to avoid a conflict with the
> > > definition in vmlinux.h
> > >
> > > In test_kfunc_dynptr_param.c, initialize dynptr to 0 to avoid
> > > -Wuninitialized-const-pointer warning.
> > >
> > > Signed-off-by: Amery Hung <ameryhung@gmail.com>
> > > ---
> > >  .../testing/selftests/bpf/progs/dynptr_fail.c | 37 +++++++++++++++--=
--
> > >  .../bpf/progs/test_kfunc_dynptr_param.c       |  2 +-
> > >  2 files changed, 30 insertions(+), 9 deletions(-)
> > >
> > > diff --git a/tools/testing/selftests/bpf/progs/dynptr_fail.c b/tools/=
testing/selftests/bpf/progs/dynptr_fail.c
> > > index 8f2ae9640886..5e1b1cf4ea8e 100644
> > > --- a/tools/testing/selftests/bpf/progs/dynptr_fail.c
> > > +++ b/tools/testing/selftests/bpf/progs/dynptr_fail.c
> > > @@ -1,15 +1,14 @@
> > >  // SPDX-License-Identifier: GPL-2.0
> > >  /* Copyright (c) 2022 Facebook */
> > >
> > > +#include <vmlinux.h>
> > >  #include <errno.h>
> > >  #include <string.h>
> > > -#include <stdbool.h>
> > > -#include <linux/bpf.h>
> > >  #include <bpf/bpf_helpers.h>
> > >  #include <bpf/bpf_tracing.h>
> > > -#include <linux/if_ether.h>
> > >  #include "bpf_misc.h"
> > >  #include "bpf_kfuncs.h"
> > > +#include "../test_kmods/bpf_testmod_kfunc.h"
> > >
> > >  char _license[] SEC("license") =3D "GPL";
> > >
> > > @@ -46,7 +45,7 @@ struct {
> > >       __type(value, __u64);
> > >  } array_map4 SEC(".maps");
> > >
> > > -struct sample {
> > > +struct test_sample {
> > >       int pid;
> > >       long value;
> > >       char comm[16];
> > > @@ -95,7 +94,7 @@ __failure __msg("Unreleased reference id=3D4")
> > >  int ringbuf_missing_release2(void *ctx)
> > >  {
> > >       struct bpf_dynptr ptr1, ptr2;
> > > -     struct sample *sample;
> > > +     struct test_sample *sample;
> > >
> > >       bpf_ringbuf_reserve_dynptr(&ringbuf, sizeof(*sample), 0, &ptr1)=
;
> > >       bpf_ringbuf_reserve_dynptr(&ringbuf, sizeof(*sample), 0, &ptr2)=
;
> > > @@ -173,7 +172,7 @@ __failure __msg("type=3Dmem expected=3Dringbuf_me=
m")
> > >  int ringbuf_invalid_api(void *ctx)
> > >  {
> > >       struct bpf_dynptr ptr;
> > > -     struct sample *sample;
> > > +     struct test_sample *sample;
> > >
> > >       bpf_ringbuf_reserve_dynptr(&ringbuf, sizeof(*sample), 0, &ptr);
> > >       sample =3D bpf_dynptr_data(&ptr, 0, sizeof(*sample));
> > > @@ -315,7 +314,7 @@ __failure __msg("invalid mem access 'scalar'")
> > >  int data_slice_use_after_release1(void *ctx)
> > >  {
> > >       struct bpf_dynptr ptr;
> > > -     struct sample *sample;
> > > +     struct test_sample *sample;
> > >
> > >       bpf_ringbuf_reserve_dynptr(&ringbuf, sizeof(*sample), 0, &ptr);
> > >       sample =3D bpf_dynptr_data(&ptr, 0, sizeof(*sample));
> > > @@ -347,7 +346,7 @@ __failure __msg("invalid mem access 'scalar'")
> > >  int data_slice_use_after_release2(void *ctx)
> > >  {
> > >       struct bpf_dynptr ptr1, ptr2;
> > > -     struct sample *sample;
> > > +     struct test_sample *sample;
> > >
> > >       bpf_ringbuf_reserve_dynptr(&ringbuf, 64, 0, &ptr1);
> > >       bpf_ringbuf_reserve_dynptr(&ringbuf, sizeof(*sample), 0, &ptr2)=
;
> > > @@ -1993,3 +1992,25 @@ int test_dynptr_reg_type(void *ctx)
> > >       global_call_bpf_dynptr((const struct bpf_dynptr *)current);
> > >       return 0;
> > >  }
> > > +
> > > +/* Cannot pass CONST_PTR_TO_DYNPTR to bpf_kfunc_dynptr_test() that m=
ay mutate the dynptr */
> > > +__noinline int global_subprog_dynptr_mutable(const struct bpf_dynptr=
 *dynptr)
> > > +{
> > > +     long ret =3D 0;
> > Why do we need this long ret? Do we even need this function at all, why
> > not calling bpf_kfunc_dynptr_test() directly from the
> > kfunc_dynptr_const_to_mutable()?

oops. Will remove ret.

IIUC, this global subprog is needed so that the arg will be
CONST_PTR_TO_DYNPTR. Verifier will see PTR_TO_STACK if passing &data
directly to bpf_kfunc_dynptr_test().

> > > +
> > > +     /* this should fail */
> > > +     bpf_kfunc_dynptr_test((struct bpf_dynptr *)dynptr, NULL);
> > > +     __sink(ret);
> > > +     return ret;
> > > +}
> > > +
> > > +SEC("tc")
> > nit: it looks like most of the programs in this file are optional:
> > SEC("?tc").
>
> I will make it SEC("?tc").
>
> > > +__failure __msg("cannot pass pointer to const bpf_dynptr, the helper=
 mutates it")
> > > +int kfunc_dynptr_const_to_mutable(struct __sk_buff *skb)
> > > +{
> > > +     struct bpf_dynptr data;
> > > +
> > > +     bpf_dynptr_from_skb(skb, 0, &data);
> > > +     global_subprog_dynptr_mutable(&data);
> > > +     return 0;
> > > +}
> > > diff --git a/tools/testing/selftests/bpf/progs/test_kfunc_dynptr_para=
m.c b/tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.c
> > > index c3631fd41977..1c6cfd0888ba 100644
> > > --- a/tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.c
> > > +++ b/tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.c
> > > @@ -33,7 +33,7 @@ SEC("?lsm.s/bpf")
> > >  __failure __msg("cannot pass in dynptr at an offset=3D-8")
> > >  int BPF_PROG(not_valid_dynptr, int cmd, union bpf_attr *attr, unsign=
ed int size, bool kernel)
> > >  {
> > > -     unsigned long val;
> > > +     unsigned long val =3D 0;
> > >
> > >       return bpf_verify_pkcs7_signature((struct bpf_dynptr *)&val,
> > >                                         (struct bpf_dynptr *)&val, NU=
LL);
> > > --
> > > 2.47.3
