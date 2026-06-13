Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D561230DED5
	for <bpf@vger.kernel.org>; Sat, 13 Jun 2026 22:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781388546; cv=pass; b=Oyoy4DLNce59oc7DA63WlfPwhxBYzd1XKnTWMHqEwO7ImEbYPvYO1p81oi96GuyAfqztMlv9rdMHxbi94uofuY0OdqS3mfQGQNK+0EvZCK63e9rcRnX6hKv23rujnnN0dkLGxixMqqY8K3mfnmus76JyVSXe4AA6y3baRNgASjE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781388546; c=relaxed/simple;
	bh=u1HnSCHVThXuBtisnQ9xUVpTnFom1owuSIlE6XNhBOE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hTsurXmLgSN6szOcdnMRhMFf9zo8EiUpaYGtVflT3HH4gtx5JOFXv14BuAQ3G2AU3VwaHL61R2Xt0n9w4z0rTxvXA9MNivHalc884J2EB0BiFFzG4ab5mTCqCe81B0YunDqIxvFAnalEpMgIvRE8C/PBWt+VGo65d23XfD1bW+k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wgE7Q1Vc; arc=pass smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wgE7Q1Vc"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-68d234218bcso3687426a12.2
        for <bpf@vger.kernel.org>; Sat, 13 Jun 2026 15:09:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781388543; cv=none;
        d=google.com; s=arc-20240605;
        b=hBOKdRyEOrSRJDXaLYFJE39Jf5PZZGweQGmGhRX7hkZ2AsMjN5KaCoxQmMJya6hsWK
         gZQpUIdl2RxeYiAkFV28kMpN7F1R3oea6EsIK3aIv01+x2IaejFkicTvW04ggyY5g6Kp
         h09b/RD8NuGSL+cg7Spvd2SpEg8FqlOv4GcGQGhaYZXDKRmjH3IxaOrvlKhD11MPS49H
         4SdqazAhZosw26b9fTD/6uY6TEjFeA9sxIqWmQnxkkwLeKyY8/bbpIK/YFWbRjL2prBn
         FKQ8sW81gRdXEk1TJmCWO65amxnhSfVw6zujhLTon95ZjFyXfqj9d1WxwZ/zYeEludmK
         hy2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=k6+Vrq96PhkNTNuOuWwoEyF7xtWRs4MqDJ7y2u6EUlw=;
        fh=9Vkrs/YOQgKYa1Ktcchy+brRCyIeCKVYMX8oo/RATV8=;
        b=CjdQ8hLw8vK+ZSJbwCuNr7RRgCpsqx4xl/MqLzBNqbbCKJjNKJJENDs371lJPyNIj7
         ry+wFY2sefcYlsr2hynlYxjASEeAk/PCEVSxb38SjLqAtUR0uGe/wZMAa3Q5+0I7oHud
         nlMOAh8ucs/IeBdxMNo6+bwVHcI3udFRDQQhxqRHjcqjZ5RmwdktVjPYmJsv3LoNHp2U
         TEQ9WZSFNvz8Xjp1IbUDk2GEH5e8Dd5s6GCPV1yEG/JcuH0eWWoOzJngd0VZmj/O5+Fw
         YQMLvSNLo9qVSTxW+0T2tQNOw6HD0QpyrradQeZa726ESgsTPQu1sclzvyLO5j7h/Lcv
         rd/A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781388543; x=1781993343; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k6+Vrq96PhkNTNuOuWwoEyF7xtWRs4MqDJ7y2u6EUlw=;
        b=wgE7Q1VcM19IKuVqMwyqyW1PpcC4m4BCCOfM3r37uuknQIst1SH6YErRsk5UTK9gsV
         LKoVvh+nenWgCwr75oeSaOnPP3cERwb0jCgOZV6TA0zOdZpgf+h0wzd0Bayami2ufZ03
         GYQdPMxBWfbJUYDvBWfdQ/9Gv3gmI1CSsyigCo5LBd/SHdssZgDO7EeCRdwryVtagqIg
         VgcWLH/oV1Hc1dYk4kXXWiJ9VOp/gSIm0yh8gT3XxdOGKab6Cz0mTJIe2yeD38rZh/g8
         blfhaEqeiwS36U3A0bpWYWADlmQDrbVa3ldLgfoxXvlE8ECF+uzZ6gdGmMwPxfSYYlYY
         +WSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781388543; x=1781993343;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=k6+Vrq96PhkNTNuOuWwoEyF7xtWRs4MqDJ7y2u6EUlw=;
        b=Makbt4eDoy2uUQ1hxhx+GffFeaqTNij2kzGPSMeVvdvuBx1Ql4GVtip7aeVlGPnID1
         1zWOq7vkp5DAs4nKQkcNWA/t9pfF8Iglhn+gG0wtGGnSzbgEz4DF8MC5tSUQ742CNZfP
         SmbiQ96RSEq7Y8P7MyKt0diwuKi0GYd49/jZrgSgb/UoaKS1wNSvExsD3yFpMbZHSQRd
         cn50OiCZ5AIqcyowpGBpziYk/hOqBCN8icD/Ao03wUEXUapw+AR7fzbaExV4BBFQ6VyF
         CqdrsODs/0xAJKwC/r+/8RL65ju2NJ3uMvXRm3H1qNm8D7SxtWU7jq9BGI4xoYrzIeFh
         s3Ug==
X-Forwarded-Encrypted: i=1; AFNElJ/mTo1TQ3bF38CYdc0M3rcgDMGDawcFIIJoimnI4Pg+vuDsmBB1B+mYInlvxSoyHN+NkWw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmukiEEz4VeQ5NTJiA6QRq+GTXun/X+BuOXceYZ0ZX0Qe6JQn6
	IEO2vKxo9C2ZmppWvcrlWOxxUEIrX5wWSxblU+DPb4NvXiDV+WVz3M4t5myT2z9dr1znmoSbx5Y
	JUopshjHfO3+dDB7Q7AgSSWgkQ96eO+vcsMNFDPhT
X-Gm-Gg: Acq92OGYsbAfzs9ItubFohdd3fKeUVkIX3VqoZVUjnTJN4fwNFhPK+PP0UfUonE92tK
	W3YQvurklK4IRap8Np0Nz5p6EH61AlrYuOYmecPNFT+9hBg2CxPH5rsc07By8pIiE95lMqAKT9s
	I+OfC1ggQJgepDbYtvnovQr6ktJKARNePuUlQ5reuQSaG4Ol8iUXMwTfoToZabHZ8h5bEEx3qHZ
	DuuX2hd1yTCVunbezK90EDcVB+f6bCKW7pNZSfN1lZC60c4zyNZ1XESIqhUMk8gX51uKv12gpTN
	I1oqDRMTJxfvdqjUsQdPYE7SIaVxosT6vQPkXmbOkewOhrfAlOymF29qvY/HVMhjc7Oys9ZYi+q
	kWppXiEHCp8Hi8osXZ5hQJSf/Ex+fvzz95nS4l6FTb6CkN5Af6Vx2
X-Received: by 2002:a05:6402:5d6:b0:687:261a:3391 with SMTP id
 4fb4d7f45d1cf-693c6a0fc25mr1832702a12.6.1781388542833; Sat, 13 Jun 2026
 15:09:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260613010039.1362312-1-kuniyu@google.com> <20260613010039.1362312-6-kuniyu@google.com>
 <DJ7J7GXSJCRS.2FA4LT0RF9GZ5@gmail.com>
In-Reply-To: <DJ7J7GXSJCRS.2FA4LT0RF9GZ5@gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Sat, 13 Jun 2026 15:08:49 -0700
X-Gm-Features: AVVi8CdakJMzctkrvjodmRckFwRELd3t3VXEyGMSLlrDt2719g-DiXG6dDDAc4E
Message-ID: <CAAVpQUAs+7fGK7GBuFSCfNunL8joGmCDt6aw+HOfsouKKxZBKA@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next/net 5/5] selftest: bpf: Add test for hwtstamp proxy.
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Stanislav Fomichev <sdf@fomichev.me>, 
	Andrii Nakryiko <andrii@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 12, 2026 at 6:31=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri Jun 12, 2026 at 6:00 PM PDT, Kuniyuki Iwashima wrote:
> > diff --git a/tools/testing/selftests/bpf/bpf_kfuncs.h b/tools/testing/s=
elftests/bpf/bpf_kfuncs.h
> > index 7dad01439391..8d119b10ed0d 100644
> > --- a/tools/testing/selftests/bpf/bpf_kfuncs.h
> > +++ b/tools/testing/selftests/bpf/bpf_kfuncs.h
> > @@ -92,4 +92,14 @@ extern int bpf_set_dentry_xattr(struct dentry *dentr=
y, const char *name__str,
> >                               const struct bpf_dynptr *value_p, int fla=
gs) __ksym __weak;
> >  extern int bpf_remove_dentry_xattr(struct dentry *dentry, const char *=
name__str) __ksym __weak;
> >
> > +extern int bpf_skb_scrub_tx_tstamp(struct __sk_buff *s) __ksym __weak;
> > +
> > +struct bpf_hwtstamp;
> > +extern int bpf_skb_set_hwtstamp(struct __sk_buff *s,
> > +                             struct bpf_hwtstamp *attrs, int attrs__sz=
) __ksym __weak;
> > +
> > +struct bpf_tx_tstamp_cmpl;
> > +extern int bpf_skb_complete_tx_tstamp(struct __sk_buff *s,
> > +                                   struct bpf_tx_tstamp_cmpl *attrs,
> > +                                   int attrs__sz) __ksym __weak;
>
> ...
>
> > diff --git a/tools/testing/selftests/bpf/progs/proxy_hwtstamp.c b/tools=
/testing/selftests/bpf/progs/proxy_hwtstamp.c
> > new file mode 100644
> > index 000000000000..e13963f2393e
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/progs/proxy_hwtstamp.c
> > @@ -0,0 +1,236 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/* Copyright 2026 Google LLC */
> > +
> > +#include "vmlinux.h"
>
> Please update your pahole. It must be old, since you had
> the need to add kfuncs defs into bpf_kfuncs.h.
> pahole was improved couple years ago and all kfuncs now
> in vmlinux.h automatically.

Good to know this.  I was able to build selftest without
bpf_kfunc.h change with the latest pahole.

>
> Overall, the set looks good to me, but I would like
> to see an ack for networking bits from somebody.
>
> bpf-next/net was the right subj to use, but this is very late
> into release cycle, so I prefer to land it to bpf-next/master
> and send together with main bpf-next PR.

I'll repost to bpf-next without patch 1.

It's okay to drop patch 1 for now (since SO_TIMESTAMPING
is not tied to device capability, and while it's not ideal, we can
change the application for a while), and I can explore possible
options in the next cycle in net-next.
