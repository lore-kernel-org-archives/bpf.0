Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661D548489D
	for <bpf@vger.kernel.org>; Tue, 13 Oct 2026 16:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791909011; cv=pass; b=a0tkMeTmNjZLelZNN9amv/kH98elmIGMvP1y4TE0feyU3z3rBatbqCckQod0xt8O4YdQjoGS1vQgJ/9GlV8zbX5rtnXpqHUnqyJuKDqnx1rPiqbYIWRL1Eowy9GuB9+e24O0vPzNPSfhyoSfIqorSdWAM4CbEDkk+QU4dKulbSU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791909011; c=relaxed/simple;
	bh=rr+spJ7n0JW+ovZs/CR2CxF9rmEX93rSF/dATklRBz0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Em3iGQU7T4cYWZtOSdG92qDvSGM+i0Ejoh+8R7QQNZkuCXOLXUkSzN/NwCctELeOCQslLq4f+6JN+09YEabyIK6RPTWcTdmtGHd8m2FDpUE4gtNlkFLU8fNQspqyjss7weIvAdARNXRAE4Cb3KM9/3WYC+Kdmym0pUWvSj46je8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FyYzOoKo; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FyYzOoKo"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6ae14cdc63aso27198a12.1
        for <bpf@vger.kernel.org>; Tue, 13 Oct 2026 09:30:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791909007; cv=none;
        d=google.com; s=arc-20260327;
        b=jTTG59DmlUBsxCMSVymTZ9VB2zA1cCFDkJMa3473lHAfsMgN5z6fWelgiLMigP67K7
         QaKlq8odNkFgn+j3rTsb30D+iZWNM6SjkqpIO2tRmfudsXMwlgYmUaXLFFtF+e4Rro0E
         8FigWOzuN6kjRCyywVQyJklOAP9hjdb8Pudu703kFbmkUWW7n9CE1NyuYQy2tIRKVtH/
         KpVJQEiz6AIN0XRodxubYefL3U4QQklVizZ71FHbRrchpmvBavX+zFIyUsoyFtknR8f/
         eSffKY5bu1g7c22QTnxtOFsO34z5xIHf3JVi6HhLVS7pJ8vLaaRfcQVNB4hGiSil+5Mj
         PEgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=USnWgApP+/1SoteVw2gO1Ar5rEYFG+9nVhj1Ww1rLx0=;
        fh=VOCgbp5j/oL2LiftGvQfwhIVyFk3Aw91/SEVktnXn1g=;
        b=i6xwnz4GMMSWD3j8y3y3wIJnsNdIgCq+sOMmagRwutsxE8xPW5B4Gg7XqIiymU32+B
         OaDqGFlAYOXqotvFNcPMdUkcWiX6s+F68pNaYnLlWxMtVFmBIH2xA56XA6fNk8IvSJ3V
         cm8J3WiHDmo9xfpWzId5QepqsMLz/Z6iQxPFY2PoVook7lJhQnLGMLrsP38mYZ7uGdGv
         VykPnyOt9XZ6jD8SBPu9hdw4wglPCN+yG5ngybe/dwGrjlY+EtmcI/XhrgJoYUDleVUh
         pu/RVeuF/Fq8TFqIpE4+KJnbnpn4Jd5k8mlObPVmaQr2S3z78/j93dkNliRdwnPbLVvA
         HXVw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791909007; x=1792513807; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=USnWgApP+/1SoteVw2gO1Ar5rEYFG+9nVhj1Ww1rLx0=;
        b=FyYzOoKoP+kSYyrfqeJux3/PlQAJikAsqyNzCaYIJF25L5o6DwSIHZnLvdVmvY5qj+
         bCWqP2kv9rlJRMbhMPPY4BCG44rtCH+9TB6SjfM/Y3sm0cXsFIxlnubTqnz7F1tkvdaU
         7xf018W3STozTSJkdhyoq1+TVeidmTRRekSLZoFE7ci68bXgfUhNA8SOaN++mIKZxUYS
         QFKHKWMkadeJbUccTRK9bB0oo5prWdGCg2xznaRmvy2OTIYXVkzlKrO1qkg0Z/y5blGi
         cyHDN5p39gaaZHRvts3rnWGekIBMVjx+6G8tDTy4KgnovdRdtk8+LezMYfqlaWmi1Xjo
         CyNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791909007; x=1792513807;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=USnWgApP+/1SoteVw2gO1Ar5rEYFG+9nVhj1Ww1rLx0=;
        b=izXkuLbNhMbaNq8fiT/GPQ8sSY6NINsOjv/oAjeR8JQUMLIP2IfOewfZ9pgIaYO29X
         kdlMH16ufgp+mSAUPG+iSYVCytgJ4ulAhBrv7n+fQ/u1yJIAZSoHkyFQLAuZLickaqk7
         /qXJO3jC+V8wz0R49vQYeu8PEvXr8SYCEoHOhVewxU6xVJp93lpi/iA7GaniexmPNVGL
         P5dJ1D7sdMnVPHqmlZdukFUd3Sd8ahk626h9rE2wAqw8mHBzjNwy6X347/gCoAlR0zYQ
         Tw7/++AdX9grHr2KkkFZY2ZGTV3kdw9mdwGRPEt4SYIgkr/2OZKf+hQkJp/ZxmV1HRbi
         xhUQ==
X-Forwarded-Encrypted: i=1; AKwUvBwwWz5o2CQb400bjONn21WAukn12i9nwmis1fIihqmzRMIdtV9tAWa4IYX5Q6nSQIhHm9I=@vger.kernel.org
X-Gm-Message-State: AFq9FYLhOzQolRp2NotyhxfxwNxmUbrdsUQPvLnL7wBHcyzQeSnQfvFx
	OKGfjA8pPUCWsADfH+uqS493JSuYXVNuPPc/iNaYVyQPY4OU0Cb8AS0+1AF1HUCgwIYM6u4EWDF
	a3VyHNpY3PHXNccVD7RF1SmRSewhsWudR8bcA9xez
X-Gm-Gg: AYBFou12npH86dzuYmj9E6I9RIba4WxyKnsMexyoCaw7rvlNKL5GG3EIVUKDYvDYwl5
	DWl60wJHKx3K6vQZniwtFOFOdrjn1vMNDWTyWzUKjtRowFzz9DoYkLP6RdU3BM7JkEyQRI8pCuz
	DEdIA9Cq+SB/1vSmdWBKf6T9cE+P6jnRfZhytgiuRngLTkHvloPswLIOgOdTX95ibU/Sb5gRgcx
	3YoO+NMUCtZ81H+P+KXbgRCt2ali3lrhZTjvrbTS4dlL1DkOsSX+TQnZtVoakdZyaSqbSQkH0ZK
	144pUI1MZGv65RKvGTq/g+ih8EnHcrCE6drlXvCuKWDxN9b5TxiVKX1zeV30ljYNseQfk/p/c4O
	jBuDZ3Hkadw==
X-Received: by 2002:a05:6402:a593:10b0:6b1:d313:16f8 with SMTP id
 4fb4d7f45d1cf-6b1d3131c5emr113934a12.0.1791909007037; Tue, 13 Oct 2026
 09:30:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261012082148.1698596-4-almasrymina@google.com> <179188049412.434549.8105329401807782174@kernel.org>
In-Reply-To: <179188049412.434549.8105329401807782174@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 13 Oct 2026 09:29:55 -0700
X-Gm-Features: AclHuK8kCFpm3iyYaxSIjhAo3U-PNi7X2jSQzQnctTkUNfPkNJqv2oqIvvlgRMo
Message-ID: <CAHS8izOKULOVuav4R-2rcw=38G2oifcSj2EnbVoyEPcW=kLD4A@mail.gmail.com>
Subject: Re: [PATCH net-next v2 3/6] net: skbuff: replace skb_page_unref() and
 __skb_frag_unref() with skb_netmem_unref()
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org, ayush.sawal@chelsio.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org, 
	kuba@kernel.org, pabeni@redhat.com, tariqt@nvidia.com, horms@kernel.org, 
	steffen.klassert@secunet.com, herbert@gondor.apana.org.au, 
	ncardwell@google.com, kuniyu@google.com, john.fastabend@gmail.com, 
	sd@queasysnail.net, ebiggers@kernel.org, kees@kernel.org, 
	aleksandr.loktionov@intel.com, u.kleine-koenig@baylibre.com, 
	shaojijie@huawei.com, mgr@kernel.org, j.raczynski@samsung.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 13, 2026 at 1:34=E2=80=AFAM <netdev-bot+sashiko@kernel.org> wro=
te:
>
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 1 =C2=B7 Low: 1
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [Medium] The patch fixes a real page refcount bug on mlx4's RX error
>   path but has no Fixes: tag, and the fix is folded into a tree-wide API=
=E2=80=A6
> - [Low] At this commit, the new kernel-doc for skb_netmem_unref() in
>   include/linux/skbuff_ref.h says it is the "Counterpart to=E2=80=A6
>
> --
>
> net: skbuff: replace skb_page_unref() and __skb_frag_unref() with skb_net=
mem_unref()
>
> This patch replaces skb_page_unref() and __skb_frag_unref() with a single
> helper, skb_netmem_unref(netmem, recycle). The SKB-owned fragment unrefs
> in mlx4, sky2, tls_strp and skb_shift() now use skb_frag_unref(), so they
> follow skb->pp_recycle. tls_device's destroy_record() now calls
> put_netmem() directly.
>
> > diff --git a/drivers/net/ethernet/mellanox/mlx4/en_rx.c b/drivers/net/e=
thernet/mellanox/mlx4/en_rx.c
> > index 96f97fa0f5489..fe18606c2ab55 100644
> > --- a/drivers/net/ethernet/mellanox/mlx4/en_rx.c
> > +++ b/drivers/net/ethernet/mellanox/mlx4/en_rx.c
> > @@ -497,7 +497,7 @@ static int mlx4_en_complete_rx_desc(struct mlx4_en_=
priv *priv,
> >  fail:
> >       while (nr > 0) {
> >               nr--;
> > -             __skb_frag_unref(skb_shinfo(skb)->frags + nr, false);
> > +             skb_frag_unref(skb, nr);
> >       }
> >       return 0;
> >  }
>
> [Severity: Medium]
> This looks like a real fix for mlx4. Should it have a Fixes: tag and go
> in separately from the API rework?
>

I think there were a lot of latent bugs in the refcounting, and if
possible I'd like to fix them and make the refcounting more consistent
rather than split them up. A lot of the fixes depend on reworked or
introduced new consistent and symetric helpers.

>
> [Severity: Low]
> This isn't a bug, but are these kernel-doc references accurate at this
> point in the series?
>

Very low prio nit. The comment becomes consistent later.


--=20
Thanks,
Mina
