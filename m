Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04254175A9D
	for <bpf@vger.kernel.org>; Sat, 25 Apr 2026 00:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777077056; cv=pass; b=qEL27+OgeyXnJhtaW4toQAGZj/fWgW1YcBrGvO7KYx0Vxan/brsN4WfBeCoD+yDLpIAoZt7u5YjQkkJoE9HyxAqK/ZM+ajb5xz1kMdYGcKwn3QSGbILM/RUEjD4MC9SgXqjWqhoVkI3WhOpAFHAqkK8IQwDN4hjjFF93X1fbARg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777077056; c=relaxed/simple;
	bh=Pe0pQ/xYfUpOrylttDTvtib6XmVWAY+7XhmnK47zGPo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G8ri4GjyIs53u7GPcX+jAZLF4zRLlPo0ml9ukWfSupnUk2x1riyru58uc3Ohs8TPUUy77Qr3sgXzl7lNOnWY70Ihf7B9qm0Vv6aQjycME30Ecz5XU/cCBtGQSjuHdmB5Anrp+lCK0xAgmMy0sHZhJTCl52p+wFwy8YwhhMz9ik0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uStJdsnl; arc=pass smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uStJdsnl"
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-12c1a170a50so10801976c88.0
        for <bpf@vger.kernel.org>; Fri, 24 Apr 2026 17:30:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777077054; cv=none;
        d=google.com; s=arc-20240605;
        b=JU3hxA8dvPBjzdBAPGOVdnvsTRT8MXnq5AKc1oLLUe4xsj31p3wTxyj3P8Hn7BLP6/
         NjbEjZSob0TKpnl3hr6tDwUnk2UN0iAyGFf0ruVTNePY8AYr7Jzna674Rpmjg6PC/Fhs
         H+/7ygNG4o8wzkwxE45LPrIjDT0wanaXaOrsBX5XcRryuzR0M9pq5Z+FeYifCAJEiRb+
         9FbPWy65V6MKgDvDVhV6ChpvOWehZkZDPTi2pZxEkQbN4hRWbSYcZngo3HJEVF5rgBTd
         mXsVCkPTAlqW2C2NHiFHUpjsJlAfQ3dzqQsoVCARqZ7NgDILarUHV7KSKCKeL0Uyb8yN
         pqdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=scAIt6H3Lr9726e8Rx2uESa4VModnRMiTXIlRkglNao=;
        fh=HK02R6nQHB41eX2cD+fBYNsuhzD4k1MUHuoz5Xi3QZ0=;
        b=YxgE8bqfQ9z7vf5uLmF0e7zQ/q+ByzRyRTHVHVV2L+SXMAELQ+MHA0qhYRv5y4dIsY
         9EiR/LisEYQPiCjB02w6s+aqxfMDbJAwAAvqqOKqYqXHjhYhSMtPtfIXNj9XIU22WY6h
         umLGHdNXjhNocONCo2il6kWzGkrdmU6COL1OGUL1MfnD7dCSftKmuammI2LQuffEvFqL
         p4LX5+wgH2J181VQz9DSsnMQ6mdBU0aAHeQftyB7HXOnp2M3YtcnEGejt+CCKgwr8nUZ
         VPZ7cY7wYkUoaSznA1TY0ohxv/xC44Gk/LX9g0n1fdEE5+t2AhxPxkOsfYEj6SGaGXdS
         nVew==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777077054; x=1777681854; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=scAIt6H3Lr9726e8Rx2uESa4VModnRMiTXIlRkglNao=;
        b=uStJdsnlKwoQP6HBSUvsa6RHbnTaAuFc28D0lec7G9QUv19Si2RXBuabruYeTUx2zJ
         rvYuElo2ZUH6Fk2CBUGUki1s9tNbrHC/2JaDC84TI/2mQMZYdlwoDJaX/ChDtmAQTYHQ
         NXmgOm9a0zX3+YkeqZaSx9L8bzExo/McUPAlS90TxiswIE+YPhuzXfvQwnyzr4J2EPYM
         2PthUQ674rt9b2ex8Sae9O0SOHa+/nEj1TsFAHfyVhxf4ffIxPFAn9yJzo7wHAKeqt9k
         LGSOHoziURaecjmYOO4k7c380t0Bw1JGkg2yZdvJpI2WELpzFZxphsXKKITZ55FhDvjQ
         0EMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777077054; x=1777681854;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=scAIt6H3Lr9726e8Rx2uESa4VModnRMiTXIlRkglNao=;
        b=kHH6zW6qnlHWBK3iT65W3lUrarixRAHLLQ296xNU82U7WzFPi3sLgNku6mE2UnuAAN
         DJ78jBrOW4TlC4PyZ+2EVOaDl/HtjuXpS8Vbsmw6acXhxWad1jwp/xxbvY9WfQvy9TXF
         lxnQgRjFDeMtHQT6k08Uw0M/MFeCasINEmL9wJ96cFN7QwPAVuR4Yfr0OZpgZxPyVVsg
         +iBhXA36mHs4O44uYjdOiVUENu77NQSOSTL2g12w/WOM6kSVd8jEjzmh+kxkyiOgl2LQ
         nmFo/htgVV5cg4zNs/0BrYOQT8XQCRmLshgEddwaq/p3Ibzqyp2u+StG0NR2UvBv+TWA
         b6Xg==
X-Forwarded-Encrypted: i=1; AFNElJ+pUs0HJOATymuJfjqxGARR+NeiOlwl0LYnEUr3dkVRihbtF/fDYFC+ieKu54lL1w3doxY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo0omAMbVZasrxuGNrG9TtQ1fizA7A2HoL95oIY5OOHwQOEFkp
	r9sDEnGm15i4WyUcuGIA4089hp9NdUzH/dUPHjPahsM2u6RdNzps4vmw7lcff3zshvOkeTkjXO3
	wgQBLwfqwkZG1daKfiIgguNyIE2HpAeIhveunnGVA
X-Gm-Gg: AeBDievYzeMzg+Rqw2eCU7tHQwDe+YsELaZT5tJH4vy6l+Xfq1LZ3TMrdt1zQabU6oZ
	RWkrHzK/262EUqYXQ/bHGw+hP34gQbTNptVd7/GG+GtQDlbPr8xWgEagsWL+5kxr83MKCDuiozx
	vPypLb4hTpV2bz/e/Zluicsf/aS8eVQgRTRJ3RNEfmq9Uo/6iZm9S6P7FoIMrZxMbrSA/r/hEyJ
	nhkPuVQ7aUhnKJAjd79mQyIjuB1D4Op20ZZGrQoqgormlBkUsE5XLv4BLupFVzcwqxNGmidkD3Y
	0iNCx+PXVpXZV+dhZcn/WpWuHFmEN4g6FWOql3n6TY4x/f4xOdmXyXEc1aKi+OMsZWW8QKU4EfX
	Bl244Uq3M46FdbDFAnHIpcyKkF2GdHBkWrrvuRbsOBSC2w+lsCxAFbSFJh16l5bhEf3kZikKtqQ
	==
X-Received: by 2002:a05:7022:3d87:b0:12a:85ef:1e50 with SMTP id
 a92af1059eb24-12c73f6c614mr19080813c88.12.1777077053440; Fri, 24 Apr 2026
 17:30:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260424235247.1990272-1-kuniyu@google.com> <407178e7c68a87a2a660badc2e4e8e8feae7b1767998649cb278ce4bde14371d@mail.kernel.org>
In-Reply-To: <407178e7c68a87a2a660badc2e4e8e8feae7b1767998649cb278ce4bde14371d@mail.kernel.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 24 Apr 2026 17:30:42 -0700
X-Gm-Features: AQROBzAqrIhJ7JX_MyPdPgfTGaxFKP0KnybLYb1g2b0avxkPVh-L-EmOG11z32E
Message-ID: <CAAVpQUB47UfzsKJUr9M-K_KU0Sz2r4XZv0Y1-SAt8dW--y3=tg@mail.gmail.com>
Subject: Re: [PATCH v1 bpf] bpf: Free reuseport cBPF prog after RCU grace period.
To: bot+bpf-ci@kernel.org
Cc: martin.lau@linux.dev, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, kuni1840@gmail.com, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, eulgyukim@snu.ac.kr, 
	martin.lau@kernel.org, yonghong.song@linux.dev, clm@meta.com, 
	ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 24, 2026 at 5:26=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/net/core/filter.c b/net/core/filter.c
> > index bc96c18df4e0..dba4c9340bb7 100644
> > --- a/net/core/filter.c
> > +++ b/net/core/filter.c
> > @@ -1654,15 +1654,24 @@ int sk_reuseport_attach_bpf(u32 ufd, struct soc=
k *sk)
> >       return err;
> >  }
> >
> > -void sk_reuseport_prog_free(struct bpf_prog *prog)
> > +static void sk_reuseport_prog_free_rcu(struct rcu_head *rcu)
> > +{
> > +     struct bpf_prog_aux *aux =3D container_of(rcu, struct bpf_prog_au=
x, rcu);
> > +     struct bpf_prog *prog =3D aux->prog;
> > +
> > +     bpf_release_orig_filter(prog);
> > +     bpf_prog_free(prog);
> > +}
> > +
> > +void sk_reuseport_prog_free(struct bpf_prog *prog, bool wait_rcu)
> >  {
>
> The function signature was changed to add a 'bool wait_rcu' parameter, bu=
t

Oops, sorry I forgot to commit the staged change..

pw-bot: cr
