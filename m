Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B35373BEC
	for <bpf@vger.kernel.org>; Tue, 16 Jun 2026 01:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781574251; cv=pass; b=s600zo31uRl5HXoz25q+iivgYHlgLlTQ+0aScOcwRgsz0x+zgr4KFCxb7PW2ZMrXw/pv+Mt20+mCcIull+GITwGaGj77ABZ9w8kgNZmI4w+Z09u/B7bEVVtmYYlfXuyQcjF61vKPdvyTZO3xmtJtdfg74WILQ3sX2YYS+71rv28=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781574251; c=relaxed/simple;
	bh=236fBEIJz/KEeeV7woGGo3ZYcOTNrCWyCpSWEhiGQK4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rMh8e9IrCSieOX9kHGs73Fm5n0ShKohw6MsY5gH7CYf7PXYdobjFWhpEXmPHRffwBO5n+Ga1W+A21vdZq7cGqw5YoplQpaCEhBCuSMk4lQr6UNTsI/OA0a7r5CDAItDJ6o11gpCWvmAq3cvflvadlB8NWnCJquKh93q1YMjOGwU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E2o0frn2; arc=pass smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E2o0frn2"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-7e3b2a435ecso43611597b3.1
        for <bpf@vger.kernel.org>; Mon, 15 Jun 2026 18:44:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781574247; cv=none;
        d=google.com; s=arc-20240605;
        b=PEMWm4ixp/EdqH1/RDpmj3zYsJRWQ8ux4mGwf/jfzXj9PONECtgH1e3r5muZ8VUoFZ
         T41jM3BrIDn0rzqEBDUhv4/0PJmNpEKkgRAjZhqXCMmnFwJ+kj98U/Yq0TQFiajO4Cyf
         xwZs3gWOA7mdywK54OuvTpJfb+XrsHPLEf/ryssU10uSshZx4gCAgwxO8CVBNF0JnbJk
         me84MTdkx+lseLmaRn5JRKAkYD1WHE53l66tWs4NDJiSNbGi7eKIacK0jU26rN1E6jU5
         Vj5dq5v5eGUKmJ3+RMa9d9wzNgEbVZiDWCbRCaWEJNYnRlW7wdDZrhQQnQwFCwgkKoTp
         dABA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+oKKpyH4QTZmF9PWO5iAvNe25h+SsPEG6KTMiiFXfCc=;
        fh=xBeIBgkDbd0exZ3T/3galYLqEpVRufMAoTdOHDqhD9E=;
        b=IeJVj6Xg3gTtTifw1+Y86XNpgzTZms7AO6B5x2g/7rebZjRNKgvJzXSuDJSxtxAE/8
         H7wTbcHBuPDgIxXqqeNCpk9t/zfEoOu1rA4EowuWd3Oh9W4rxYXyGn+RGT6eHQEa0mUy
         eVOGN99kcKkvBnHP/eyH6BMvUxdHRWAMQAy9WWKj9Ih0PFaP4Q7YNYOFCXgiJRtnH08s
         88u87/PLBtD3QaeapyAA0SjQ4BHHEOgnjGgsw0gv2d1J4zHDGaPuYl80T7ofuJDyRzWn
         bkn5p5U7yCgDiYP6PBpx1JNo5yHouKunu6sRf1oEC0hYmm3swlRoz4Trn2MkyCDpYF5B
         xdhw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781574247; x=1782179047; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+oKKpyH4QTZmF9PWO5iAvNe25h+SsPEG6KTMiiFXfCc=;
        b=E2o0frn2KSkwnFR4DV7A6TqMGa/Oei7dB2VJLSbtZxgmj/8asuPSLDfPSjAg7Tgo9s
         ZaL9wyUtGjGBjjNQo7B+ywKOAzZ2qYwDsYuTP4yHYGHB/+FJfE15KvbQb+pkhulZ8lSM
         jcXzc+7loptnXJaYbCw2OIGI4KLG/S+6fswjUIq+0+zXdIP0TUCVAFxP7ioa2w+F5FfR
         26cVzvsrGnC0mbgCQm6ED96BK3uOUoPQ7T26lFDZFmBj1hib2zi3TOoGd+dkIZBV5jqd
         8hgBt7a4jMW53dT4SiudefPd6660+zv4qhyu2aLAWNr2+3kT3nkkUxmhjgdrK72MGyqB
         pKkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781574247; x=1782179047;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+oKKpyH4QTZmF9PWO5iAvNe25h+SsPEG6KTMiiFXfCc=;
        b=i7D6alRLeJdq43BAWJEv3FZTlAOcEo5eKiqyPrZgVvRKtCMXfDr9wI8Fre8qXPvvz0
         gpzA0+3ylfxaEKPVdEqfoVUvXjM/8JIvEQJ3zea4VU6FC09N0/NmRfibxFpl9MMhlb+p
         rY0PJbJsA3g/4H65RoznDxVISZwp8AehiGz+nNslbgC+APqPDLg8V6UJwNX1NqOz7+/U
         TQbr1dwXtKeVVZhX3ylxwdo7eerryVE4J6sGDHBISN19xnsG5qt01KMzW9gFFGuHM9KO
         Ma3+HBtLUglyIhNeEloo6SOsE7IL3ZHFvDTCiXqWpSay1x+DBgEE+ictNX2r48TRMJBv
         BM4Q==
X-Gm-Message-State: AOJu0YyHCqm+9KuUoDtEO/MamhW0k2kRXP1gYinRuSZ0Noky3xgnwGcy
	B+sDNHbX12R1ZksvHBZZBog51Na9hxc6KkD5PuxvAn5kHBUsM3cx1WpnfPE6mphfP6H/2fU3Dif
	tP6ZmxukDTx939JTqLAd+1gCzilszCW8=
X-Gm-Gg: Acq92OFU8rksbD41IBLJWPnKqoncmE8NTSCNYFUkBsl7HJMm4lxSTvU2RyGLNjyUOyr
	3UNuYXI5Etu8NAJegf2agzf08AhqUFX3U2E5sAUqv5M+YEqfHssayP/OYum+8Fset13zdbjObSs
	CwgEVDBLfXWDJWkf/rnnO5Q0Eu3h8auTIE4eNWgJ0K5M1a1fPpOxOVcmgcBWq6zsxB5HYApLK6X
	AuYbIdYYV3MAub0xJKdUuov2OTg9IqTkUu15NcpUcQAuB95uWuE14de2EtiFbSIVrmnj6gZVXd4
	gIMtL3AcuL+dXkAE+3OcPH5cFZ0FNCl5Mnkbh+fm4127GG7mTlJrp4/z8uI5PA==
X-Received: by 2002:a05:690c:4902:b0:7a3:7ad3:3e9e with SMTP id
 00721157ae682-7f8c37d34b1mr121804007b3.32.1781574247418; Mon, 15 Jun 2026
 18:44:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260615073856.152479-1-sun.jian.kdev@gmail.com>
 <20260615073856.152479-2-sun.jian.kdev@gmail.com> <ajAAkIv0R3ztfc5g@mail.gmail.com>
In-Reply-To: <ajAAkIv0R3ztfc5g@mail.gmail.com>
From: sun jian <sun.jian.kdev@gmail.com>
Date: Tue, 16 Jun 2026 09:43:57 +0800
X-Gm-Features: AVVi8Cf7im9Wiat3H2R_vuZVWzFKDi57wMkvXVzURWHo32EAr5QTdOPWPc2BPvI
Message-ID: <CABFUUZFKTsaHLSzoMDogSnnzUCikZcb6TzxQ4G640oO4OxmAjA@mail.gmail.com>
Subject: Re: [PATCH bpf 1/2] bpf: Fix partial copy of non-linear skb test_run output
To: Paul Chaignon <paul.chaignon@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, memxor@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	jolsa@kernel.org, shuah@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 15, 2026 at 9:39=E2=80=AFPM Paul Chaignon <paul.chaignon@gmail.=
com> wrote:
>
> On Mon, Jun 15, 2026 at 03:38:55PM +0800, Sun Jian wrote:
> > For non-linear skbs, bpf_test_finish() derives the linear head copy
> > length from copy_size - frag_size. This only matches the skb head lengt=
h
> > when copy_size is the full packet size.
> >
> > When userspace provides a short data_out buffer, copy_size is clamped t=
o
> > that buffer size. If copy_size is smaller than frag_size, the computed
> > length becomes negative and bpf_test_finish() returns -ENOSPC before
> > copying the packet prefix or updating data_size_out.
>
> Thanks for fixing this!
>
> >
> > Compute the linear head length from the skb layout instead, and clamp t=
he
> > head copy length to copy_size. This preserves the expected partial-copy
> > semantics: return -ENOSPC, copy the packet prefix that fits in data_out=
,
> > and report the full packet length through data_size_out.
> >
> > Fixes: 838baa351cee ("bpf: Craft non-linear skbs in BPF_PROG_TEST_RUN")
>
> Wouldn't this bug actually go back to 7855e0db150ad ("bpf: test_run:
> add xdp_shared_info pointer in bpf_test_finish signature") and also
> affect the XDP bpf_prog_test_run_xdp()? If so, could you also add a
> selftest that covers it for XDP?
>
> > Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
> > ---
> >  net/bpf/test_run.c | 11 ++++-------
> >  1 file changed, 4 insertions(+), 7 deletions(-)
> >
> > diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
> > index 2bc04feadfab..976e8fa31bc9 100644
> > --- a/net/bpf/test_run.c
> > +++ b/net/bpf/test_run.c
> > @@ -453,19 +453,16 @@ static int bpf_test_finish(const union bpf_attr *=
kattr,
> >       }
> >
> >       if (data_out) {
> > -             int len =3D sinfo ? copy_size - frag_size : copy_size;
> > -
> > -             if (len < 0) {
> > -                     err =3D -ENOSPC;
> > -                     goto out;
> > -             }
> > +             u32 head_len =3D size - frag_size;
> > +             u32 len =3D min(copy_size, head_len);
> >
> >               if (copy_to_user(data_out, data, len))
> >                       goto out;
> >
> >               if (sinfo) {
> > -                     int i, offset =3D len;
> > +                     u32 offset =3D len;
> >                       u32 data_len;
> > +                     int i;
> >
> >                       for (i =3D 0; i < sinfo->nr_frags; i++) {
> >                               skb_frag_t *frag =3D &sinfo->frags[i];
> > --
> > 2.43.0
> >

Hi Paul,

Thanks for taking a look.

Yes, that makes sense. I'll re-check the Fixes tag against
7855e0db150ad and add XDP coverage in v2, since the issue is in the
shared bpf_test_finish() path.

Thanks,
Sun Jian
