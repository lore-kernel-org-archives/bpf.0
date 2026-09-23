Received: from mail-dl2-f12.google.com (mail-dl2-f12.google.com [74.125.229.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C776324716
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 22:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790202111; cv=pass; b=LscCUr2fVGSDoPjPZ5sv2azGr/5mTNyzQZRlzvTQxY7ZjoGJukClleLqYxnOLXbxDPswIvFSBcTJRSOK5AXtFpkKBZwfmptwslcrd6AfMDMckCTiI2HDLhQfjdWhbnRkN/6YQhuFP5/1fF3DT5lLz8MyPYY/bQwE6QoofBhVZL8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790202111; c=relaxed/simple;
	bh=tliYGNFTpwD+P7c3MiJ22dL/iRQQdvYPsDg/ctQP6Y8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OQb3bbaZcOtXnwhdzobFzqbdDmh0SXgVZJLVey+MllUlc+spnVCZvMg7q5evfmc3oInFDuocgSCuIArtlLaGXWXPJlfHmmKYNaPJ8G5+cHNx0I82nTMVpPBJCrixTXEruEMz+kxXl+Q28w0ATkR3/we4KMQGCOWhNXeRTKJSvAc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=voq3sB+u; arc=pass smtp.client-ip=74.125.229.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="voq3sB+u"
Received: by mail-dl2-f12.google.com with SMTP id a92af1059eb24-142dd046b87so1129216c88.2
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 15:21:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790202109; cv=none;
        d=google.com; s=arc-20260327;
        b=ZK3XNdcLogJlBiUwErtNn4egJImTxeuyYK77o+ImcTcdV8T0sFPLowUAfeJi/rFB+9
         2CSJAEtMKaXTmANrFNMNxv4hvb5ojQ7Vid9+8A8javywdsOvpoDHvlzqFwJKgMa8J7G5
         4VJpH86LUemkuWSpaAahFm1eiKQiTCCIyH70B98kqMusSfH1qF19sS5sTZsMuOg1FYmb
         1zhzTw2Igqh8MRcderQIhCBhNecwlx9FZzmTBqTkzCQeAOvs0pP9/CMGR2+hef6bYxqM
         ksAX5nHgDTGqhr1+7wdm3brbq+TVo7pVaFOZ0hapZG/XAqvJQItHyR1QAYTmGyqchN22
         8tcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=esE/zmEZJv3Gumf+k+6MWUx8NLOwAoSQg46jivr0oLA=;
        fh=uA360uvxR9S0K/Y4Lovo7aIaGlBwzVBnnb2BKWupr/4=;
        b=Mc9zbRG4FUEy6Fp3Yv1NNfXJfuEg6l1vzfOEhf5YbswlkhZ7sPNOoVLgOJ8PSMYi5X
         NLy7bJtOzCfsRaciJDgidCcCIYl1gEMnpDMW1eoZCOQc72eTIhKOtSTxpKVenieqY89u
         KO9pNYMzYTkbiKC0QhuqooVY9eUUhjES3P6683av8QyxPqQsVYnlYj7w1I6cy+mNf9BD
         CTauamsegy+zH4PPn4/eEk/flpstn+UYl6nf/xIpeDXaCvrzUjSEcYkX+qb9y4yD0paN
         0jzCQsgywFw+zurWmXe8+0aYW/dIcnUegRUoUCaEKKGSwoc+0xorQ3t6B7oJ95x74gSZ
         pCHw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790202109; x=1790806909; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=esE/zmEZJv3Gumf+k+6MWUx8NLOwAoSQg46jivr0oLA=;
        b=voq3sB+u3zeiInoj047gGPCaK2pMJOIHjxftO4AZZP5qzD04knoQC7O8/UE5+1Z/JX
         eZ9Lo915zXWkPcZKckHj23ZJDawyz0V2y8iS+PB9pPCGoM6INkVXPOYorg1OGUwqxVWn
         qsXekT5fqmvh8gacNMzCiIfAUjznnCSBqHkhvX9Vddm5sgr3/Z3v/br1h++JUZenCpwo
         TapH3CO8qUpDjD4xuks4JVaDj5xJzoVs7AIcNkXAgKqnPAmW1ME73JszDOLZ3xj+cqfA
         B0pBKqObq8+pf7ptxYIWgWg0g6vatK7AskwP+W50Bc0ZTGBC+vJ7BzCVjmvMnblwV2G5
         7lrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790202109; x=1790806909;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=esE/zmEZJv3Gumf+k+6MWUx8NLOwAoSQg46jivr0oLA=;
        b=nX0K9LtebLy6r+q07DcvY+GsyTcPzQ2/EyiKibmniXQHnlQUXCWzVcw7OV9YtBa5kf
         Xa3sjZZaW4CTQEiOYLRvLPpZG8ytxJ2dwh9Tm8fgB0hmvZ5jR6O9Jt2aWgWDLo2evMCn
         +XdeymyVrYrXVs1M7q6NxTGhjEJD5dfuMsWQQyGrbEHBJKXQfLyqYsil4OQwv2bZu+sH
         2z/zhJIWvEWJUPKSKfXJmB2xyVumO/v/ue9C8OOMaWWYylA0w2jY1Lscbn32nhZBqDdK
         QK20S53FpHp5b3ihXGzuR7/xVHcFaglTTtUTZLd4AT48cQ9XONV4zMX5hXxofqYSoEyZ
         IRnQ==
X-Gm-Message-State: AFuF++lmKzoO1cuszYnaFAnjQfUhjWYosMUhysrX1uWa5+PPhmIH2LmL
	MuVdtMfrO/i2G7PhrItvSBkGtknm8rK1Ct/CU8PpxCm90L6B28CSUrID9F4GAJQ/h4RWA2zsWHH
	+AZHkY2i+k4RxOjz0qEJzVABOq+bUBSgBHdvYv1oHqRwreSl3EtRWfaV7UMLcjQ==
X-Gm-Gg: AYBFou1GXcY1Le38n+OHHcEjRniyUQVQJQqbAA2bxZYWgFpM1A5D2uW/B+h1sNd1kPk
	75hyaQWV8qOEjkIIwBCQjWo3VLreVXX+uQmKRdga4WRIZnm4/mr1Vyl05wKDO3EjmtswwyyPiVz
	FZiXVpv8rzIGEf0G79cFcGVTQw5fnv6ucdwjwmygOGouIJKwGaSO/tAR5t5lrXYz2N3T0zOr1zI
	aDK/jOfGEpMlBJ/IPDIh6TmtcJ1RxH7IoNp6LHDBuKBcJByM/lP4OS3a4X2oqp5+HvMJWTzoP6Z
	T4qNSkmKQ5G6VYth3E3UbrlqhMTeVj+hZlgbYiRHVL5n+843GEYgnJnLWh9ShB0TQRWBBM0EfH9
	7o3UsLmQ04StmPq7/5LS/Q8WLTy76T1z/5hmng9aMi78Sj2BJ5ijUB3XV3TYpt52vWfmEc3vskY
	Hi+e2FhkjkUB9cmTXsVjOuyWU=
X-Received: by 2002:a05:701b:21c8:b0:143:5c2a:e488 with SMTP id
 a92af1059eb24-14503f6e17amr337810c88.0.1790202108054; Wed, 23 Sep 2026
 15:21:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260923213719.224838-1-kuniyu@google.com> <20260923213719.224838-8-kuniyu@google.com>
 <20260923220251.9490C1F000FF@smtp.kernel.org>
In-Reply-To: <20260923220251.9490C1F000FF@smtp.kernel.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 23 Sep 2026 15:21:36 -0700
X-Gm-Features: AclHuK_h4qXFBEFH72kLwaln6D1VfTAMFoRWKPVnz_qUcyz8UJSJ4LddlxF2mHc
Message-ID: <CAAVpQUCTjVNRnaLSA=V56fCwG8tt5_AsGVcUbB4N5kh55vhGEQ@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 7/8] bpf: tcp: Add kfunc to adjust sk->sk_rcvlowat.
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2026 at 3:02=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [High] bpf: tcp: OOB write in __tcp_set_rcvlowat via unrelated socket
> --
>
> commit 68bce63bbe5802a4eee99c7c0f138096d7c16481
> Author: Kuniyuki Iwashima <kuniyu@google.com>
>
> bpf: tcp: Add kfunc to adjust sk->sk_rcvlowat.
>
> This commit adds a new BPF kfunc bpf_tcp_ops_set_rcvlowat to allow
> struct_ops programs to dynamically adjust sk->sk_rcvlowat. It clamps
> negative values to INT_MAX and delegates the update to __tcp_set_rcvlowat=
().
>
> > diff --git a/net/ipv4/bpf_tcp_ops.c b/net/ipv4/bpf_tcp_ops.c
> > index b0cade34cce65..e93c8d13684ef 100644
> > --- a/net/ipv4/bpf_tcp_ops.c
> > +++ b/net/ipv4/bpf_tcp_ops.c
> [ ... ]
> > @@ -368,8 +368,62 @@ static struct bpf_struct_ops bpf_tcp_ops =3D {
> >       .owner =3D THIS_MODULE,
> >  };
> >
> > +__bpf_kfunc_start_defs();
> > +
> > +__bpf_kfunc int bpf_tcp_ops_set_rcvlowat(struct sock *sk, int rcvlowat=
,
> > +                                      const struct bpf_prog_aux *aux)
> > +{
> > +     u32 moff =3D aux->attach_st_ops_member_off;
> > +     bool wakeup =3D false;
> > +
> > +     if (moff =3D=3D offsetof(struct bpf_tcp_ops, dequeue_rcvq))
> > +             wakeup =3D true;
> > +
> > +     if (rcvlowat < 0)
> > +             rcvlowat =3D INT_MAX;
> > +
> > +     return __tcp_set_rcvlowat(sk, rcvlowat, wakeup);
>
> [Severity: High]
> Does this code allow an out-of-bounds write via an unrelated socket type?

No, from v1:
https://lore.kernel.org/bpf/CAAVpQUAJJ2RmL_dTH=3DM2s2Tj9mypL2YtYK7t6tCSaEj4=
bYY9Uw@mail.gmail.com/

---8<---
No, false-positive.

This kfunc is supported in encode_rcvq() and decode_rcvq()
only, and we don't support lookup helpers there.
---8<---
