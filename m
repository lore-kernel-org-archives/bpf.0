Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534882E266C
	for <bpf@vger.kernel.org>; Thu,  2 Apr 2026 02:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775098493; cv=pass; b=VlmiXzhebpNwg0StjLzTMMaFX7PyxzdXfi6El96XcNbuNC6ZjxseEIfsLKx+QxVxwAD7ampZYLKMRLbkYHQQXwuQsmLvLxDbsKZWPhWSM+v/fxwtRDuIsC7lYcek54LMYtIpveNDH9xgvw216TW9zsBTmoCe0ZUupcdhvTLmOkw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775098493; c=relaxed/simple;
	bh=N2jjn2t64EAUCLmA/1DSxhfdfO4oB3BlnGRBEtIBjzk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SO211DkNUjPTu7dHwyLu1zabW0gXjd/a2OAoOTQ7twErIbCgb2ORsS1O94YEuQz8ILjtKv4z2Rcve8OegJxN26hh2WSC9Mc1REpCzRuzhnjvuoeLgYS33DupHi4Ch5Ct4INGgZ5uSMHVQD/3MvWitYf/3WY6PXt1OhE3p7Wk8iE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rgcHKj3X; arc=pass smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rgcHKj3X"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-79853c0f5b9so6196297b3.0
        for <bpf@vger.kernel.org>; Wed, 01 Apr 2026 19:54:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775098491; cv=none;
        d=google.com; s=arc-20240605;
        b=K7wSQSJumic1vb9q/O6l5do8QaHjXzIp5Xe2NM2bkkDA3q5Wm3q5SElgDZBZdli3zM
         aaCOZ78xSiJmZ36LwEpKKVkAb++VaGU0A2kjhV2O2/M1L9nfqjDVZVJegzuik9eZVsNN
         liG/Hk8/pyJjpuLPch8+zcru1yKXJH2+JRt70AsK33pycBA2UtRdqQLB+kSKF9m5A7YN
         sKQGnjPuEaHCSjhxKp1OCLoPs3ynaH109uDTKX6WkGVug0qh+YK1TJmL+QyTpgaalOqP
         RCwwG9J+V1Ock/tJtpcFYGU0wRt9sgdheGVQqIgJjTrFlcHOEkKnx5fHSRA8h9fYBkKh
         eR1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RBLKEoxArr3r3hHSZ/mzm798kMhORMb914/bPyz8K5Q=;
        fh=yIYSx+oPVdCK70IbxL2Gs6GH6GAuCu0qDcfegS7khRQ=;
        b=WOGVR6XBMl+1JYrHMxrqIkL+sBbqU6lsfVLt6ViERJI6Eyk5DIXx9c2N2akoWaLp8b
         aAMPPXTXmhzbMuxrGh5mEN3NSpwEDaPd0yYORsrVZwzTkAzQ8ZPlHI2QpjlJnmKRT7lb
         OsqpRRgkO9teHavh2tRm0H69qfbiv2MDjjzLLo5qSb2R3ZDFCxRD4WsW+7MTg5vT8SB1
         nVjcblBERyhXdCbyMkPDie3yVkFGsKZ5WIpWmmEe+jqZAlJoqVGK+QiLSDVa9pvdGmhT
         A4zA706RrciRjceSk3nnKpSIGaEfCLOXIe/KkLvafk44eiGD6mj77Ut9MBQgP6OT9Lv0
         e/cQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775098491; x=1775703291; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RBLKEoxArr3r3hHSZ/mzm798kMhORMb914/bPyz8K5Q=;
        b=rgcHKj3XOQoxUz2sxtla6VQgbusrN5eILsiFS+xzbdPmVMiPlX72t69xueucKOw9b1
         vvE3s6CrMsxmoUiintFqi69XbxJf7IIJ2u1rsDvrbfivwBMc3o0N2OsoAkoVxsZlpoTl
         0nR5uklGtldjyZdmkv3C0gEgmoeeKbvVfMs0tlO8jWLrCa4jt4THtu9/454F2kOJReGe
         jgkSdtEMWJ5uoYstfKGpXeQ3sxQVjTcA8uTilQTz7RExj5T1IqrTg1tRppFgF7Kr0CXf
         RtYUCEqdo4FFtaJJi76L6TRfCE+MgxY0F6AdmLimeK3xFPvCPiDa+6IyzLF86LMR/3/I
         IFfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775098491; x=1775703291;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RBLKEoxArr3r3hHSZ/mzm798kMhORMb914/bPyz8K5Q=;
        b=O94EaxGXsnELB2dprsdtsyIM2X4Jfw+Rd6S3nGfiyNQ0G91+LIHqSbxHSAgEoOUUd+
         d4jOTnIMiwDw6dcnwZP1cCYcceRuaTL+uspXQwjIfpgOf0lJx+2CvPZn1AVRTJU21qyA
         mbmhT94k2lvSvrABFPrW6K9S+y+LifEohJuCkpatZVmQpJk9H9U6tcywpcAovj5JA7zz
         XXnzNHfwdY3qSVS8CILBmSHXWKA8eH6uD4/K2jlyv2y0C8dfOO50p307NILyAVNZOe6l
         xd6mtV/txHo0uwbc5dYU1dxvETCOEs4riZ/ePN0glR0TT8kp+0NW1sFlXcpVHJBY55DF
         SoEg==
X-Forwarded-Encrypted: i=1; AJvYcCXtMNmIb/B1Pdf1RP07W5S7wDnp3Ykacm4dWUihLJSvNXGqa3pXB0yp5Iyn3xksZl8PYHQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8jrlARWwer9CncK6bwUgqe9MJYctslBB9HtmaTw4XLMCRITyJ
	zn8M0xmHxchEtjTk9eU/cFd2PSsYh552SA6qy+zJj8El8MuwDOVwXty+cYGGsBKIzEVZmPSuD0Q
	mNZIiQqnDYPJaXXb1RtlP65kNvE0gUmw=
X-Gm-Gg: AeBDietFOZ6vek9RpPaab34IdybLFZqANHpTUrC5b+2QF2c60X/HIpWgg1GQQBF6j81
	xw2MtZddVdkVPOqeJ32ZAWjc+4Z8chqL8t4hbQOU5OYVyJU0i+BM48stjO9nAh5Ejicda0n73Gx
	slW8/3NvcUPzYhJ+9pWn3W3a0eXyrGCwqOLwphBkZ5gneQVgzUeNXe/dZ0qJ8c77XTuD9y+5GzI
	HHO4LgCa6XL4p8RwYs9PCU/fsvP9HZIilnm7c/heWaE9NKATK1+7k/SaWGWkKPdEgqL6CYBNGPZ
	Mc2MzPsze9F6peOr9OSYceqPV2townegsvYswvb2PYygxHAxdnoIfaWfgMw=
X-Received: by 2002:a05:690c:ec5:b0:79b:ccb6:a845 with SMTP id
 00721157ae682-7a212241ce6mr65808557b3.49.1775098491382; Wed, 01 Apr 2026
 19:54:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260329161751.1914272-1-sun.jian.kdev@gmail.com> <ac2ccb5NBAB3Zq1D@devbig1721.ftw5.facebook.com>
In-Reply-To: <ac2ccb5NBAB3Zq1D@devbig1721.ftw5.facebook.com>
From: sun jian <sun.jian.kdev@gmail.com>
Date: Thu, 2 Apr 2026 10:54:41 +0800
X-Gm-Features: AQROBzD2dbb8_qvFgH9tNuLfsL9X5Kv1gH8lsxfzbJgix1U0X99QhIEV3SVVCzo
Message-ID: <CABFUUZEdh2-bpYG+inQeUwxs9UC7D-xm5tR4RtAsPHrG58WBSg@mail.gmail.com>
Subject: Re: [PATCH v2] selftests/bpf: Reject malformed IPv4/IPv6 skb test input
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, 
	song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	syzbot+619b9ef527f510a57cfc@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 2, 2026 at 10:17=E2=80=AFAM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On Mon, Mar 30, 2026 at 12:17:51AM +0800, Sun Jian wrote:
> > bpf_prog_test_run_skb() derives skb->protocol from the Ethernet header
> > through eth_type_trans(), but it does not verify that the provided
> > linear input is long enough to contain the corresponding L3 base header=
.
> >
> > This can result in an inconsistent skb being passed to test_run helpers
> > such as bpf_skb_adjust_room(), where inferred protocol offsets can lead
> > to operating on uninitialized memory, triggering KMSAN errors.
> >
> > To reject such malformed test input, we check that the linear head is
> > sufficiently large to contain the corresponding L3 base header (IPv4
> > or IPv6) before running the program.
> >
> > Reported-by: syzbot+619b9ef527f510a57cfc@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=3D619b9ef527f510a57cfc
> > Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
> > ---
> > v2:
> >  - Ensured that the linear head is large enough to accommodate the corr=
esponding L3 base header (IPv4 or IPv6), before running the program.
> >
> > Link: <https://lore.kernel.org/bpf/129d235b04aca276c0a57c7c3646ce486444=
58cdc85d9b92b25f405e2d58a9ae@mail.kernel.org/>
> >
> >  net/bpf/test_run.c | 19 +++++++++++++++++++
> >  1 file changed, 19 insertions(+)
> >
> > diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
> > index 178c4738e63b..4790bee535b9 100644
> > --- a/net/bpf/test_run.c
> > +++ b/net/bpf/test_run.c
> > @@ -1118,6 +1118,25 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog,=
 const union bpf_attr *kattr,
> >       skb->protocol =3D eth_type_trans(skb, dev);
> >       skb_reset_network_header(skb);
> >
> > +     switch (skb->protocol) {
>
> The implementation is poor.
>
> > +     case htons(ETH_P_IP):
> > +             if (skb_headlen(skb) < sizeof(struct iphdr)) {
> > +                     ret =3D -EINVAL;
> > +                     goto out;
> > +             }
> > +             break;
> > +#if IS_ENABLED(CONFIG_IPV6)
> > +     case htons(ETH_P_IPV6):
> > +             if (skb_headlen(skb) < sizeof(struct ipv6hdr)) {
> > +                     ret =3D -EINVAL;
> > +                     goto out;
> > +             }
> > +             break;
> > +#endif
> > +     default:
> > +             break;
> > +     }
> > +
> >       switch (skb->protocol) {
>
> There is an exact same switch and it has the same check
> on skb_headlen(skb).
>
> A selftest is needed. Check if the tests in empty_skb.c need to be
> changed also. imo, This can be bpf-next.
>
> pw-bot: cr
>
> >       case htons(ETH_P_IP):
> >               sk->sk_family =3D AF_INET;
> >
> > base-commit: cbfffcca2bf0622b601b7eaf477aa29035169184
> > --
> > 2.43.0
> >

Ack, I'll respin a v2.

BTW, v1 was mainly meant as a minimal proof of the fix, so I
kept the existing structure intact.

Sun Jian
