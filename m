Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5AC42253EC
	for <bpf@vger.kernel.org>; Thu, 23 Apr 2026 23:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776985353; cv=pass; b=PwVAQcYfB3uYghT1DKWMYW3BtOmpKkxm0CBf1pPx19B8JOTIhKrTmZLexT/DnSHZBD3jZfum9l2dLPpeiL7UUtL7M/XKPf8vyp9M/NMY/ejgjUJJgPLPQyhCVXas2HVglqQrGbdqPNkkSHMx0EZ3Ez6LMX+SvIAqzv7ocNA2WZw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776985353; c=relaxed/simple;
	bh=3IC7YlTPgihA4fb1jIjGvKMddYC2T1s/uKUswaPXhYM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c6ifAF2R4QkAQaGLfn3RHA0lcKK6JaLzEFhrN3dpfXNDDZ9t6ogZtmqHT1+a1/PrB4SlVVqr8qe7qZAvAmH52YhdV1JoYFjxDryCB9NKUASO3NRYvC9ltnSmWXLos+zuDyywE7hzFtJaiHU6fdAs+BYe9iWsWt+i4SucNsoKge8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bMd7tTWQ; arc=pass smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bMd7tTWQ"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-12c7212836bso1786976c88.0
        for <bpf@vger.kernel.org>; Thu, 23 Apr 2026 16:02:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776985351; cv=none;
        d=google.com; s=arc-20240605;
        b=F+00GVfv2rCas6C+SxWT7Z0v3ekwF9MbTWx47mcqR4Rt/sFLfS2WUqvbHFMYDv5sSe
         Cn8FhU8lun94cMSzVbvtie5Por9ySHQuR1oinZGOTa+nHv0eukm5biJZnab00y+QqiUd
         ZU4TatWmTsQfg5ay/k4jfK0PkWzuc1XWQ/Vn6fyW5XzurtYnl3wu2WbK2tUdzFwp2f+R
         TITArZK9pY0kwHJg90qODZ+CFH4wpDylpoozhl16p4JtKY7uQIX8jm1mKCfCYRIxhIYJ
         p1K68FhMSpmAUIwDhyKAMYUVWjxTOAWJOzkyqleFqPcgM+voDc3bCurCO4BiaEIOnrky
         0khQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AMUiINtUz1MSaudwAI+i9FTqVo/QzcejA5YVuhJ0+IM=;
        fh=hJRtvJ7+7CX7jNXfy/08mSRARVIDbsPXLj5Dp59aZ1E=;
        b=Z/aku/iuRoXXgw25yP5NIT8RyGUv2zmY489zkg+8aOFm56QA/uvAqF3y9+dav62s0N
         BeCB+Q4YsjUryvk9vr/hMWPbZtkLQfQVhqd98Zmo9cfG5dhSig5sKp9KYTWs7vpdGfjY
         4be2xe3KwTXWhku+EwsV0ZnHUlpia7pPP/5J7KUvOEgdnpAS7S/accQcwlnf8Xoq2mql
         HPJ2bBCHnNzzoZ1mvWx+5863NdDKUCGsIBi/g1QUFq/6u4w/P1iW9KJrVcliJqcL0wDk
         g27ShweY5uOHlCO8pwdJ1ylJELrAFY5stWdVjpqm1KEUvOa0y63TpOMG5aTGKColU1ko
         eouA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776985351; x=1777590151; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AMUiINtUz1MSaudwAI+i9FTqVo/QzcejA5YVuhJ0+IM=;
        b=bMd7tTWQ0fwJ5uWCgc2zEK4Vqnnk90vf/p6+LjGkwIkersD3BW8UoyAM/qO1JYH7iy
         AAqpvxi7mRBHiu0lJLBmvaQCBnl6FSHxGBJqARC3gczesDH6gQ5+t7W/bsMg7UsCVcKq
         r2lVIr7/wBPkU1LaYo2KYeAOnQo4XXJiLrWyI/Aydn9xWkuLAOv7uZkYMwKPWx6e651G
         z+5z2jpQCb08E0OgelQ5wSTPeAduBkDvumcWBoKX9+1b8LsCQhjFP6GOww/QgTJOFKKA
         6wXIyD85N1j1WdPhFEq1UzeAkC+nhUXo0YuQKC1zZonvWnnhs8jFGeUFJBLfrS9qZAnI
         fjIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776985351; x=1777590151;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AMUiINtUz1MSaudwAI+i9FTqVo/QzcejA5YVuhJ0+IM=;
        b=jcGWgJ+rIlIvXG2rE2RlsL3o0ybNRAUeRIK8p2FlD9c6B1PsesXl1hRNtD0qAktLlX
         nVKioNtl+8uCON1qtw6BHF4j/68WWtf3W6g2dlydlusXPc/tkcBZU/yMzvVWH08DYdmS
         ej7tGiRjbbrnusgfZM4GyCy/p9cfJSADS2WnuuSpT5Uar2XbjrgA2BPeEkm6tcYbnAJY
         lAbXv0qtLFHz0Y9DtSBGpU7Rjg28Aaax2K1mnRFNUTf7M9rQzHO7qBRm59fqPVsLj67H
         3yrTzhWY/Jq9IAWBQoXeZ3St9YPm1g2+PKFAtEgqM2erZe90fG2xVHvcgGdszUqicp+7
         5PIw==
X-Forwarded-Encrypted: i=1; AFNElJ8AqkbcC8MMmdbmmrEJp5JCRv4a2MBwpyMAYBhqQWnj0evSHEAvBc3XgSARaYIRTjCvsrU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmIhb2drMTK/tK5IhdZxee5l0Sr3+/DxB3FCmKpkr+AOYy4gg7
	E0VMUDZZGyABHwERvifu138+rDhCSOR2qeYT0BVjImKeHXd2u310eyC8x8l0YwnLq+zuVCwwE5C
	m5acw1uVSIPxLUrevRpUkVa51Nkt3D0Q3nTDTa2vd7zL4ELGc/Ur61LhR
X-Gm-Gg: AeBDies0c1VW16a/xQE15qlCkGXvCJvwb4vueV4Sf/Z5+gG7Ve/3V6xNGfiIO+a4cTG
	l4lfuyMFvt47GyttZflyqmiwTngklexnd+DZ15Bl9j5Z+NL49bET4bN6meDG7jcCrhZ2h1hLt/p
	tbykikyx3Cx2rUrqi98d1qr4NYuPLqHDokWZonhD2gk5akky8r9qjvMlm3OhGzPVtC6XIx2sPJs
	7GDSRkdek2AsZuuQRDngYEXnpzuz10PVhauzgFxL2z52oH9LOAOQhprP7pT8+SnOCth7ZpTYMDf
	NAVGe0VANf7+QtEsOLRAHlCc4OkQf8cnvEznRkT1tGn6ndvehLDovP0hdB82WJYKR1ARhQbmxI6
	tONphctXVJCNvpIwZuiUHTYEL81s2E3+2PH4Gpww5DPqRBtQrwE8LuWlcPjY/1gPr781sxcjLdg
	==
X-Received: by 2002:a05:7022:4199:b0:128:ccaf:85d5 with SMTP id
 a92af1059eb24-12c73f83044mr16947354c88.15.1776985350169; Thu, 23 Apr 2026
 16:02:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260420194846.1089595-1-kuniyu@google.com> <20260421011357.70974C19425@smtp.kernel.org>
 <062b1b3b-dedd-422b-83a6-1ca78d7270f7@163.com> <202642321855.Yu6v.martin.lau@linux.dev>
In-Reply-To: <202642321855.Yu6v.martin.lau@linux.dev>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 23 Apr 2026 16:02:18 -0700
X-Gm-Features: AQROBzDRM0jnKEO5OrUZkvspB4odNlLou39YUScW3ykzYD7HnPP568sq7o74n94
Message-ID: <CAAVpQUDLbi9OTXak-rFvsHy51t0yNfA0q57LGivdoEwNiSAZgw@mail.gmail.com>
Subject: Re: [PATCH v2 bpf] sockmap: Fix sk_psock_drop() race vs sock_map_{unhash,close,destroy}().
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Jiayuan Chen <mrpre@163.com>, sashiko@lists.linux.dev, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 23, 2026 at 2:17=E2=80=AFPM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On Tue, Apr 21, 2026 at 11:21:27AM +0800, Jiayuan Chen wrote:
> > > > @@ -1652,20 +1657,25 @@ void sock_map_destroy(struct sock *sk)
> > > >           void (*saved_destroy)(struct sock *sk);
> > > >           struct sk_psock *psock;
> > > > +retry:
> > > >           rcu_read_lock();
> > > >           psock =3D sk_psock_get(sk);
> > > >           if (unlikely(!psock)) {
> > > >                   rcu_read_unlock();
> > > >                   saved_destroy =3D READ_ONCE(sk->sk_prot)->destroy=
;
> > > > +         if (unlikely(saved_destroy =3D=3D sock_map_destroy))
> > > > +                 goto retry;
> > > Can this unbounded retry loop cause a hard lockup due to softirq pree=
mption
> > > or priority inversion?
> > >
> > > If sk_psock_put() is called from process context with bottom-halves e=
nabled
> > > (such as from sock_map_close() after release_sock()), an interrupt co=
uld
> > > preempt the thread immediately after refcount_dec_and_test(&psock->re=
fcnt)
> > > drops to 0 but before sk_psock_drop() disables BH.
> > >
> > > If a network interrupt fires on the same CPU, NET_RX_SOFTIRQ may proc=
ess a
> > > packet (such as an RST) that triggers socket destruction via:
> > > tcp_done() -> inet_csk_destroy_sock() -> sk->sk_prot->destroy()
> > >
> > > Since sk_psock_drop() has not yet restored the protocol, sk->sk_prot-=
>destroy
> > > is still sock_map_destroy().
> > >
> > > When sock_map_destroy() calls sk_psock_get(), it returns NULL because=
 the
> > > refcount is exactly 0. The code then falls into the !psock branch, se=
es that
> > > sk->sk_prot->destroy is still sock_map_destroy(), and jumps to retry.
> > >
> > > Because the softirq spins infinitely in this tight loop and never yie=
lds the
> > > CPU, the preempted process context can never execute sk_psock_drop(),
> > > resulting in a permanent hard lockup.
> >
> >
> > sock_map_close(sk)
> > |___ sk_psock_put(sk, psock)   <- refcnt-hits-0 window lives here
> > |___ saved_close =3D=3D tcp_close
> >       |__tcp_close
> >             |____ sock_orphan   <- SOCK_DEAD set here
> >             |____(later) inet_csk_destroy_sock
> >
> > At the exact instant the refcnt can be observed at 0 with
> > sk_prot not yet restored, SOCK_DEAD is guaranteed not to be set.
>
>
> > > A similar priority inversion deadlock could also occur on PREEMPT_RT =
if the
> > > thread calling sk_psock_drop() is preempted by a higher-priority task=
.
>
> The same SOCK_DEAD reasoning applies to PREEMPT_RT?
>
> It is useful to have some explanation in the commit message for this case=
.
>
> Kuniyuki, does the above make sense? I can fold it in before landing.

Yes, that applies to PREEMPT_RT too and the AI's scenario
does not occur.

Thanks !
