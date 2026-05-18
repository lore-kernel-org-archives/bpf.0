Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951873E4C6D
	for <bpf@vger.kernel.org>; Mon, 18 May 2026 09:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779095434; cv=pass; b=LfpK8GKUAPj5v1Sy5uO3sj0mEfLvVIul6TKGvZHLq8nhJcEqRO+MZlSv8o4plpkPak0UY8wpngtS209qligdAbCZ5rCqToHOSR+XRwykezEGsnYIY4I9eCJGew2n9Fcc1Wm/ztDKHKvy2F05IHMfnyh/aVr0b7RvMF8md215Kw0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779095434; c=relaxed/simple;
	bh=uHTN8NfGJnT96dgsJXFP3/yIeb0sw4lgywvjuy6wQtM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EWXbk7TTiFNrlObpqBbcCR2lu91f2Ex7VtlynN5R5MWsmzKqMpHHZIwvv5SKd66weY69EEvGOW2As4qlmrHJYUHqZ8NlF/fMTMr+Tq36aeGLth5BZ/o8LZTwUZ9UJONL0PJjpUwzRFK/GDxF6CCTmyLFWKmdh3QqDLjBMdblu5w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MpEJaywv; arc=pass smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MpEJaywv"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5a8ee4b703fso1867290e87.0
        for <bpf@vger.kernel.org>; Mon, 18 May 2026 02:10:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779095431; cv=none;
        d=google.com; s=arc-20240605;
        b=CnSBnQcn0ZeWvin2jThaggfZlNfddceLLCdS49qpaJfzpuHGitxxkRFZoNER8S+HxW
         cLn+NYc3OItqrwMqnDANaTZr5VCxh3xEtEnPfSIV2dxcKNB3TM5zqrok5m+colMvzWwY
         1vOUsN2Mil/Ot1ttgQtnBbLK22YvOrtD0ts6ZqICPOUOw/xECKdGiOQcc/wkPohj8uPG
         vVClkzmvy4zPuEEodN+EN0wxreMz92K8wQsbA5OdsIw98Jae1ClDx7BNTJvC4OJHDHey
         9YyiO5PqUjhHvcpEGScudcVQ7SMzjE5jk4QUYSl1tvk3J6fTPt9L12/OPrwYck19Ht8a
         P0Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/r1K8bP8+PsseAKaC+qZbXn1qbLOc7jjZj2aJft2jRY=;
        fh=uA360uvxR9S0K/Y4Lovo7aIaGlBwzVBnnb2BKWupr/4=;
        b=EcnDwoe9m2IQ5PsPvOWXXY9f7ESnzwZwAfFNLZGDQj9lQgczRyB4FqyhsAFtiZeo/v
         oPkONqiTKkX6GynaUAEx8+zBB4Nl+WVAjYcb6yplkA8nmWxFi8MmB/3Qa0n78H/Hiu1K
         UGH7XlgYlV0cgEwGkCX7enUBFLTCEUc79VXyp6n+bo+bku5V9wjJSjJq75KOykCBMte/
         Ti7Nr/6P/OKYNU/z4ynAjw/DI8aSrCn5Dmc1tv5OS1FHFaEhbzm0ZLDWqFm3CbgWR2nb
         yj64YjOiDkiU6OpCnd/8u30GfqHUBKjSLXRw2c3sZu7l6frtJ6RMAhL4jHF23kQCIXBe
         trRg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779095431; x=1779700231; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/r1K8bP8+PsseAKaC+qZbXn1qbLOc7jjZj2aJft2jRY=;
        b=MpEJaywvOl5lmd4RSbYAV3sY6a5VfW2pX+7gkhM4QQZmmnB188rmhFCiQTX4RT4oAy
         +JBslludEy7XjRjxL/GVLxNtd37ndYjruYrDeZTEefaBCU6nIXm09tbumAUSNN2eX5sG
         w0TmMu2XsdytQdhtQ86cPe8vYW5wSPMe/dGYLjgeuZhdKzoAolBu+XL2QEldMGhiXYHb
         dqikQk4MsGaoDU6Ps0lvUxyk7yEqCm4mDHejCtXUzSWGMVEQftkwQ+iQ3FaBv+d0fu+H
         v0THmJSdbkCrOd7iOVttRVng/pJDZJ445b6a7mtv+SHXdSfGPVc5lG57jENJqKnaFR9j
         ccfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779095431; x=1779700231;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/r1K8bP8+PsseAKaC+qZbXn1qbLOc7jjZj2aJft2jRY=;
        b=agpDwGVOzKW0MUwxURKqUlMFAKKFR2uvpn0424+uZdmQy3ZVNYEt/VOC59y7iYNj6Q
         SuBuUX9DJpy2Td8y/1+IYlId3gjTxVFiCiSJaU+unMcLXJ6jmDSJYjz8bG4oRm4mf50h
         phua8cl5sbUQgLuOZWMbikrg6WyDQx4xJCt7rr6py0oc687FYoipriCm0zqPXvrAcuWn
         8iGHHnspFtxhY13Lsu1EP8Ma8Sy4g0x5uoYqzmyRAUKdN/Z+w23FYIE8SeAJhY3LCN0T
         kJ9W3voBG1r4BxjruzzvBzETPIa3rZBAKyHcujVhUvGlEeRxt2pelXbwf2BQ0uqNOw/2
         kQqQ==
X-Gm-Message-State: AOJu0YybrpfZd1qUJfXpg6Ltx7Pxw0f2xF+ot4h4h2uNZVbesNBX68ei
	LhWwHRp4nLbAdicRcwe2Of0SrFj4c75ZyLkQdtFnu/nGisNZXlqvx5UzN0nFnE3Bv/WcBAIhCXg
	ASDiQ5xdWVumfe8rJvfk1SKtW1wRcpV0=
X-Gm-Gg: Acq92OHWMJ6QN94Vg+i32xCJp6mvJ1P5T4t156n9I+La9XS89/cTh/PQG+674N/yhUi
	ahYk9cfiAVxJaEDBN6f6Rd8wNoemTMAjXpDkb3PFS67RCkv44ZkzKorViiL0WnTSBiO8Mhic71e
	ZwMORgTIkh1K7E5eHmmQSTm0gm+wExA5cKNFVqB65A2toVyLqXJWDY0fWPccmjLmUUuac03DeGH
	CbmT3eaaJAdtSPKgKbnWb2taCX94o40Hgut9cLr2XH2Eo2iWgg6o43OWvqRrybc77PgjlkZdX9m
	A/1JiYo29SOBtnlQbFFnzP1sL0O2g4TNRvTXjRXA
X-Received: by 2002:a05:6512:2384:b0:5a2:c4f1:2635 with SMTP id
 2adb3069b0e04-5aa0e74e119mr3652064e87.41.1779095430563; Mon, 18 May 2026
 02:10:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260517063311.28921-4-kerneljasonxing@gmail.com> <20260518063408.5F995C2BCC6@smtp.kernel.org>
In-Reply-To: <20260518063408.5F995C2BCC6@smtp.kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 18 May 2026 17:09:52 +0800
X-Gm-Features: AVHnY4J_yeFtAi1KRLa-mCcAxqRBNxA_wAMywBg2D4_zBLETSSfz2IEZgdQ_oGU
Message-ID: <CAL+tcoBK5DD8Hn9_6XGwm+9U2_zPxVUAtnoHr+wk-gKjcJ_etw@mail.gmail.com>
Subject: Re: [PATCH net v3 3/5] xsk: drain continuation descs after overflow
 in xsk_build_skb()
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 18, 2026 at 2:34=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] The commit message claims the function returns `-EOVERFLOW` af=
ter draining is complete, but the code merely uses `continue;`.
> --
>
> commit 5c0ce4e27ce234e8586a243e61aed44e90c34548
> Author: Jason Xing <kerneljasonxing@gmail.com>
>
> xsk: drain continuation descs after overflow in xsk_build_skb()
>
> This patch adds a drain_cont flag to xdp_sock to properly drain leftover
> continuation descriptors when a multi-buffer packet exceeds MAX_SKB_FRAGS=
.
> The main TX loop handles these leftover descriptors individually by retur=
ning
> them to the completion queue with standard backpressure mechanisms.
>
> Closes: https://lore.kernel.org/all/20260425041726.85FB3C2BCB2@smtp.kerne=
l.org/
>
> > When the last fragment
> > (without XDP_PKT_CONTD) is processed, the flag is cleared and the
> > function returns -EOVERFLOW so the next call starts with a fresh
> > budget for normal packets.
>
> Is this description accurate?
>
> > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > index 0a6203c425766..298194b7335e1 100644
> > --- a/net/xdp/xsk.c
> > +++ b/net/xdp/xsk.c
>
> [ ... ]
>
> > @@ -1062,6 +1064,23 @@ static int __xsk_generic_xmit(struct sock *sk)
> >                       goto out;
> >               }
> >
> > +             if (unlikely(xs->drain_cont)) {
> > +                     unsigned long flags;
> > +                     u32 idx;
> > +
> > +                     spin_lock_irqsave(&xs->pool->cq_prod_lock, flags)=
;
> > +                     idx =3D xskq_get_prod(xs->pool->cq);
> > +                     xskq_prod_write_addr(xs->pool->cq, idx, desc.addr=
);
> > +                     xskq_prod_submit_n(xs->pool->cq, 1);
> > +                     spin_unlock_irqrestore(&xs->pool->cq_prod_lock, f=
lags);
> > +
> > +                     xs->tx->invalid_descs++;
> > +                     xskq_cons_release(xs->tx);
> > +                     if (!xp_mb_desc(&desc))
> > +                             xs->drain_cont =3D false;
> > +                     continue;
>
> Looking at the implementation here, the code clears the flag and executes
> a continue statement, which proceeds to the next descriptor using the
> remaining budget instead of returning -EOVERFLOW.
>
> Could the code and the commit message be out of sync?

Right, will reword the commit log:
"When the last fragment (without XDP_PKT_CONTD) is processed, the flag
is cleared and the loop continues to process subsequent descriptors
with the remaining budget."

Thanks,
Jason

>
> > +             }
> > +
> >               skb =3D xsk_build_skb(xs, &desc);
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260517063311.28=
921-1-kerneljasonxing@gmail.com?part=3D3
