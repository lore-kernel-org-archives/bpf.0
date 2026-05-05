Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3B81C8604
	for <bpf@vger.kernel.org>; Tue,  5 May 2026 05:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777959803; cv=pass; b=Z7Jh2AH/lonTdGhtuMuWr7ZkPP9PYfkma6iax1qExl6OGNnynC6Gv6VoLTzMt1ZmEBz8GKTuaAvGUJ2XudPGSGDjDsP4juUam/30Icm1F7LYCRs6NLrtn9mZtIBvOihMhdhCfHMJSFhlwHTUgbL+EZZYWkat/FvmmUi0zWqyIuA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777959803; c=relaxed/simple;
	bh=PBDvQznMxWjpcwNYDmYcjrNP7ss5epTT/kwErEyvUEY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rQNzz8J0Go68iCl/PnTd0BpHD626u+Umn17TuIOC+3kiweCg1kzuGOKOzl9sswBuBzIFda7S+1LljDso6PCdvWSf0ccUBkdNGCRQ9hceBo+jYCvRDpH7yRz3fk9w9XwLvfd1P4JNZzQCFR7NEU7yiGgyybJ3Ym/4x4wIoqc6his=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IYOz3x5N; arc=pass smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IYOz3x5N"
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-1309f4ee973so1179838c88.1
        for <bpf@vger.kernel.org>; Mon, 04 May 2026 22:43:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777959801; cv=none;
        d=google.com; s=arc-20240605;
        b=aPi6Ynk65akppqK/jw6dJm3Nxv/qkT9hMishJfqwTWcFPM1QmOyoJ45pdxh2n6GLXT
         X9OCgfhyAbJWwYWNp++WhtVqhae/Gf1RyVR7yaF7CjOIaa3cgc9NHDJi5XGq95GTNkfv
         63p9+8pEowH1kgYBw2HEOiCujG+JoHyiGBjInbPQSOJc/cvZRUGnqq5OHJXb+XFOHxHV
         syMqzbVMiZJ0MZQ2uEvOmByKe7hupDFhxPSCsn/EHymaoJl2/v2xedLsUGF+VQTYauwe
         0edX8/Ol3gAVsRkL+KC6GIFU5xI+S7uGEAvMTp6kBVFT2rzfVuTPRwGFyrS4ik6vp3/I
         Unxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ID9/lDtQnEfLjPMFXed1O963xIM5qgALbX2MVBfWr7U=;
        fh=BPNtcH7ntRniEjYIhZkfaTTujl+FWspWzDXVu7iCfaY=;
        b=Sq/hmIVezHRqfBjM++JuBHw0T0dZShz0jA1bj2Nt2yiAMc45pJxKx4lJVGOUiIshJN
         MzfY/NA9oFJpZ7sv+pimRn6YS+BW+Qh/EacSyhq27pLC2ySGs8w92XGEIBsBKzwBwIOs
         IRPaY8YJgr1ywWpwvwkyTBLxsbMBBIRZDRD42/5DqYsKqRZrplVYoKa3tCeIBXuTeIu/
         b4KwarllfIyYX1fAkmuTYEmo5e2eRhwgBQVAerCieFrkFPz2TVr2UWFO07DWaPx6TQjI
         MADatdrTTLqJrpyTZBmmXHzS3sC/f/s0o95nKOFCi+oCLst3jwoz1cLTllFq4HPUefAY
         MzGQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777959801; x=1778564601; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ID9/lDtQnEfLjPMFXed1O963xIM5qgALbX2MVBfWr7U=;
        b=IYOz3x5N0R87o/Sy4/9v1LAHuuK5Tw9rXIPTCfpYeGpvHiR82v3NP9VtFdMncp65IQ
         FgH+CZ18xFUg2ufdaI56Cf6Gko47OrmxiRWSXT8Qd98xFRH7KwcJ4o9PsaohGrMSvglL
         C6/RBU3jNBeUstokcbLcbTe6jhzZDdyFp+1Vj83BPIuqw3hSYUDmFGAMji6pt4CotU7E
         D9h+KiSIbEUT+22RX0ztOGLnMYc19obQ3CVz8HR/eJv5LeAa0s134+K7Ri0ye4tYb7Ov
         /ROSv0QNjZXy3Xl7ruShw4nFjFk8kBxbn7wUoOVZgI7CteD6WkoKZ+dfi77Tx8aoMVEO
         PJUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777959801; x=1778564601;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ID9/lDtQnEfLjPMFXed1O963xIM5qgALbX2MVBfWr7U=;
        b=pCz/SGDzjF7RpXA2GXFrkfbofVAqp585jS1tOCT386XY0jDqdAwiQt1e1DVSZI8AJA
         4LVfkukoqnC3m7ar0X4qVVVrSNn2UQ6X7UkIxi4dVoE9T+i/YC9Lut0FU+2FD8p4d05B
         t/PmSrQv1DhgoJB4n0iS2YSf1tIQxdUo6Kg1xGIMRiDf/nO/OB7jGhlpLjU1r9Ktwmyv
         gAlM40seeABinKmgre0XInwXgz1szG+3qhBgrhB/h4Dq2hgaw7OOQXQdTI0a422IFzbF
         nlv1QfFbAiGT7kz0mPBav5LZtnj0fscLqrPoqrsfgtibo52ae5I5oQOCCAxQ7gLQntok
         vTQg==
X-Gm-Message-State: AOJu0Yx+1YFFCAGq5oz9PSIfnjDjtrayGiebxuRlsS8N+Squ8cieeadP
	0ZOxy0J2ybazORNQ/pUeQ+bMS2xOBGGYwulyhxgSnvmS0z93fsw8rWdPJGVA5c1QE4nwtyUpf05
	1cdBsHCn2olBAHheqsR41D6+k0FnEtKGCj4QPblrvUC76wBTL/zHTh3SAEd0=
X-Gm-Gg: AeBDiet63Pb2qnOaLlDaS54mkriJ7wB5LAudCkf+4mlUi87LUkwtg6MXtn3ni7wdwk5
	BOh+f7TWVD1uZuRfzWHDX0KYnJOECW643zP3ALgUfXO7tcx3xpwUl/Nez3hZaTiCYz5RGSfANBR
	YOG/Y2wHxyn5qUCc18kIKkRwnzkweKBzvVgCdF5BmYOPmamfG0VkIs2oIxk5RDyjAxSqz7FhGmy
	6Xj7wq2qy+MsxxwppIPI5G2rZQNVbJ+is7jPrUvQAEEyfQ8BJSH9aVp7WY6s5QBJrjDC7C7lvsq
	aTj4NHgWTUCdrAfYummdHBzjscvtuKTTgwdkQQ+jZ23/R0WwOkYd4hv1Rq7lh5Wk07mG7JhgxKk
	B+jPHEztr0Rxfe2vUOrsC2lB9HmuEs6vHpo8zN7XYaAYzVPFiKqJyUUmrCOXLkaozd+DnITbISy
	MJrvWX74DP
X-Received: by 2002:a05:7022:4381:b0:130:9bce:ba26 with SMTP id
 a92af1059eb24-1309bcebb05mr1826901c88.35.1777959800854; Mon, 04 May 2026
 22:43:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260504210610.180150-4-kuniyu@google.com> <20260505041435.187D0C2BCB4@smtp.kernel.org>
In-Reply-To: <20260505041435.187D0C2BCB4@smtp.kernel.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 4 May 2026 22:43:09 -0700
X-Gm-Features: AVHnY4JOCOb71wu5mt1KFGtOvg7crQc-IG8Nxqs_vTCH-gFp-2Dt9Bt1UXsuzwI
Message-ID: <CAAVpQUB-K4YBE5Em4xg5wWsjtK=7xZwwXFynX2vUN4DQDx2tRw@mail.gmail.com>
Subject: Re: [PATCH v2 bpf 3/6] mptcp: bpf: fix type confusion in bpf_mptcp_sock_from_subflow()
To: sashiko@lists.linux.dev, Matthieu Baerts <matttbe@kernel.org>
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Matt,

Could you follow up on the comments by Sashiko ?

On Mon, May 4, 2026 at 9:14=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
> - [High] NULL pointer dereferences in bpf_mptcp_sock_from_subflow due to =
lockless concurrent accesses
> - [High] Use-After-Free in BPF programs returning freed mptcp socket duri=
ng teardown
> --
>
> commit 52dbcdaad7d49ff5db2faacf11c47b1c581024a8
> Author: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> mptcp: bpf: fix type confusion in bpf_mptcp_sock_from_subflow()
>
> This commit fixes a type confusion issue in bpf_mptcp_sock_from_subflow()=
 by
> checking if the socket is actually a TCP socket before calling sk_is_mptc=
p().
> Previously, raw sockets could bypass the IPPROTO_TCP check and cause inco=
rrect
> assumptions about the socket type.
>
> > diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
> > index 8a16672b94e2..4cc16cbeb328 100644
> > --- a/net/mptcp/bpf.c
> > +++ b/net/mptcp/bpf.c
> > @@ -14,7 +14,7 @@
> >
> >  struct mptcp_sock *bpf_mptcp_sock_from_subflow(struct sock *sk)
> >  {
> > -     if (sk && sk_fullsock(sk) && sk->sk_protocol =3D=3D IPPROTO_TCP &=
& sk_is_mptcp(sk))
> > +     if (sk && sk_fullsock(sk) && sk_is_tcp(sk) && sk_is_mptcp(sk))
> >               return mptcp_sk(mptcp_subflow_ctx(sk)->conn);
>
> Could this cause a regression by dereferencing a NULL pointer when access=
ed
> concurrently?
>
> In subflow_ulp_fallback(), icsk->icsk_ulp_data is set to NULL prior to
> clearing tcp_sk(sk)->is_mptcp. If a BPF program triggers in this window,
> sk_is_mptcp() would return true but mptcp_subflow_ctx(sk) would return NU=
LL,
> leading to a NULL pointer dereference.
>
> Additionally, could ctx->conn be NULL when read here?
>
> During subflow_ulp_init(), the context is allocated and is_mptcp is set t=
o 1,
> but ctx->conn is initially NULL. Passing NULL to mptcp_sk(ctx->conn) trig=
gers
> a kernel panic on CONFIG_DEBUG_NET builds. On non-debug builds, it return=
s a
> non-NULL offset pointer, which bypasses BPF verifier NULL checks and caus=
es
> invalid memory accesses.
>
> Could this introduce a regression with a use-after-free of the mptcp_sock
> during teardown?
>
> During subflow_ulp_release(), sock_put(ctx->conn) drops the reference to =
the
> parent mptcp_sock and may free it. However, ctx->conn is not cleared, and=
 the
> subflow context remains valid until the RCU grace period ends.
>
> If a BPF tracing program triggers after sock_put(), could this retrieve
> and return the dangling ctx->conn pointer, enabling the BPF program to re=
ad
> from freed kernel slab memory?
>
> >
> >       return NULL;
> >  }
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260504210610.18=
0150-1-kuniyu@google.com?part=3D3
