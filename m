Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA28A344031
	for <bpf@vger.kernel.org>; Thu, 25 Jun 2026 14:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782397017; cv=pass; b=SsVlFMWbaMEdoXl08seIt6ZZ1hkDjHF3363flUEuariKG5u0XbvV1YAloBfsxZtpTdrDByjrUrzO1JQ7eAz3KthbTYD1GXcjoxtai9aKnZqtztpbYFNM9PraHTYInOk3y7YmoPlYetE/SjYc2bpdi35jUjJtdh4wd1ZQQmy5GYk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782397017; c=relaxed/simple;
	bh=W0vyq7YcmuC8WwkEvuR1qfqmZYoRCHyHLzHmSmSPVfI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KG6GHckLAidd5dB6kB7Iwjg/R2indFoxhE9jdXxUcbWy2UlyqmLWEanA5DKi90rMQd333RCIv42KzBpvJzOpPWkVZjG9FZYwdRmGeeS1P3w8qSa3rtuWcoCSZrU2RuwAKb3AdAvsbqWXqNO27NPxLZo5rpMnjpUENZkN047iv7g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cdKspgzo; arc=pass smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cdKspgzo"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5aa68cd8dd3so2705412e87.0
        for <bpf@vger.kernel.org>; Thu, 25 Jun 2026 07:16:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782397014; cv=none;
        d=google.com; s=arc-20260327;
        b=Hz2Upr+k/1dsJqMeOx/hOZjGtWcAr2B2nmYonq8TO+/2oGB1VFNct1cgNzy1DwtQ1m
         Oq6qdYqyM4cePk00hP+Fido/mIR0CPfAcwhqxIUdZTJY4iCtVZFBDURotx3COUIlFCsl
         hHYgDXxxANfJn/Ll4/qE6WzDC/SDC5NG7BqvMXQWc9YXf4AvsZzoT4g1VNUizsBoA4CI
         UhGS/LPYZcObofa+ETnWRyofK+tIhV97p1AetqpQH1uCAOaSuk+VM8Llqiskqp84Y20q
         NSmaOIXP39K2HeGhGBIXftaeObipy81Ueo8bFZteDTjHVn/OKq3o1zy6KNy2lD+OI5qD
         4Lcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NUdiuz8qbKtiMLpjLc1BMMRAUrUbvhCkX1W9M3zTK+I=;
        fh=6Z3qwMyBIBU3fDQYnCDplAiVKss6B8qKyiXr1bPKICI=;
        b=jcGYLA0BMDfqG0hbYmOze7VTKYXs5ZgcPk2WIFEYP3gWcabZ4D973nW6QMfMIKzGlH
         3nNNwZuha9CfHP8MKopxSkRvbz4iFjzAY77bNG8JJmgjhpJRqS0PFKa0HzabOreuC3Su
         /rhBq3sX4s8w9J2kuCSf+dhFB+7FIjpRPL80haWQNo+M9uPWmVG0pVy3EY8QgTVKC8zw
         XlDVsYiwzO1ZSSeRaYGW1TK2QOHuDUY1e6wOqm0ooG5vA8xgy6h0tOrNEOuMKN4nlFgQ
         /0xjDPXowMN+AxYwiwTa/fb/9snFygirX0QXjapgHfqNIGMmsWjAGd9HSgORgUxwB5fG
         pZ9w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782397014; x=1783001814; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NUdiuz8qbKtiMLpjLc1BMMRAUrUbvhCkX1W9M3zTK+I=;
        b=cdKspgzo0+lxk5lvyCmvDveIeIjbHy69toCrTbln4p4VIRTFPSVn+/yWGjkIk1JjCf
         HthWRH0Yzu9+mkO84Rrcc4R/B51nozmhsvqJ0NexuZR7uhfphCnUDGqxWxY4pbgYXVRd
         oO9IvkzhMs03ZaixYZV8iThA4gcI61LZVh7GIYOUwNlPgKA15MwjWtsKAPFIjIM04jpj
         2YW+kkN5qCmNulKd92DnjmxJeowjLAV+0Gv+AF9ZqNixWkfOv50V3SeMAd4x2307aC2j
         JNdS8tGvIPtoOpaIUoal1exSi9uiyr5/GDTh8Vw0IAfwmWK2NY5oWBockujGPoJB6vZb
         uVUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782397014; x=1783001814;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NUdiuz8qbKtiMLpjLc1BMMRAUrUbvhCkX1W9M3zTK+I=;
        b=TBCFJgDhRV/q/H+3toN4Lw7QfEyrkOptzmLtr9iPQEU9yJvxztg/07Ih+xKWXS34v7
         Y1zj5Y/PhKDWfXMO9p6yTM0XO5dfSSRxYU3dhGGWn/KoxaEk6BxfPY1KD5gf06vUEZ/m
         1Aenl1O3qXbXiOOjC8/aEdW6/YL4rSRWH9fuzDpbaBPeWD7gUKNYT44fEYE6HhmYnmdy
         UcYYUC6beyJbgF2T7+Yfzm897UAJtFz9F1Rk0avccuHGhE+md9LvzcWWT0gTOpwWN/uA
         9Vy9TLc4Q6EovqP9myZHZnHuT9ZdnqMckgVYWVsa6Ci3VlPlc6h316uDRDAgFj257EQA
         t5Pg==
X-Forwarded-Encrypted: i=1; AHgh+Rpy4RsEI5vwgMi/U/ZuBYWsn+c5TCq3hgmxKKcFYsojsgweWRM5jhvDddYR8emfFBDojt8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ9EUbYcW3pO3f+k6q1bFLiQIRWJ0+Hu/+XvDE40H+HluY9CQ+
	i0oSmQWHgF4yj6P8pyc7183xMvKz3eHqA9QT+bccVbLKskIUqO61byD/H6J5rKfA1BJE1J2HzAW
	D/Gl6TccZQB+kYaRVm5yn+b0qCDzoDphgE4Pn
X-Gm-Gg: AfdE7cllezj9RR8/6TfdnVBnuckH7JPVZ3IDb+B2y80wUqWearCcjsqhEG/8R6npTc0
	/Wk5b4HmlJpgtiVZRHuPK9YGzAsgO89BSi685r9TRKniedXauhpd7L7CWgrdbOey4WfCtQeP8QE
	DJKS0oc1sHUatJ3lOJH58OuxbaNqOf+FqhNoeHWXHKUPoabD3EZZmpWg26kdPwn/56ZHytDMWNT
	3PBwlsH2hPcEtYCkxN28hf/W2s8IPLBslwkAt/VD6nIVp3XOzn61c32LG9nTCBp+d5x7IKmCnjO
	Q2fiK0NQel7dwW47dAG7gyE14bDyhZlgidjfwyFjmdUmScJyDmEOJp1HLhhSbtNEcLGa+EpfErZ
	uMWYYRHKcfOqklrA9wWnF
X-Received: by 2002:a05:6512:839b:b0:5ae:9c19:165c with SMTP id
 2adb3069b0e04-5aea1f28dbdmr659555e87.7.1782397013921; Thu, 25 Jun 2026
 07:16:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260623133240.1048434-1-maciej.fijalkowski@intel.com> <20260623133240.1048434-5-maciej.fijalkowski@intel.com>
In-Reply-To: <20260623133240.1048434-5-maciej.fijalkowski@intel.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 25 Jun 2026 22:16:16 +0800
X-Gm-Features: AVVi8Cd_eNsml4y9VUFBX08VAzVlAbKnlPEBr2spRpxaaelvJdAWps3GMzCudr4
Message-ID: <CAL+tcoBapOxuWXyCJMNJ5ECeJ7XHFZ4K_Y1nvQ6LRZCEJUL7yw@mail.gmail.com>
Subject: Re: [PATCH net 4/7] xsk: reclaim offending invalid desc in generic
 multi-buffer Tx
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, magnus.karlsson@intel.com, 
	stfomichev@gmail.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	bjorn@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 23, 2026 at 9:33=E2=80=AFPM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> After an invalid descriptor is found in __xsk_generic_xmit(),
> xskq_cons_peek_desc() returns false and the loop body is not entered.
> Jason's drain fixes reclaim descriptors already attached to xs->skb and
> later continuation descriptors handled through drain_cont, but the
> offending descriptor that made peek fail is only released from the Tx
> ring.
>
> This loses one completion for each invalid multi-buffer packet in the
> generic path. Userspace then waits forever for a descriptor that has
> already been consumed by the kernel.
>
> If the failed descriptor belongs to an already-started or already-drainin=
g
> multi-buffer packet, publish its address to the completion ring before
> releasing it. Standalone invalid descriptors keep the existing behavior.
>
> Fixes: cf24f5a5feea ("xsk: add support for AF_XDP multi-buffer on Tx path=
")
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> ---
>  net/xdp/xsk.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index c489fadc3608..43791647cf18 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -1125,8 +1125,22 @@ static int __xsk_generic_xmit(struct sock *sk)
>         }
>
>         if (xskq_has_descs(xs->tx)) {
> +               bool reclaim_desc =3D xs->skb || xs->drain_cont;
> +
> +               if (reclaim_desc) {
> +                       err =3D xsk_cq_reserve_locked(xs->pool);
> +                       if (err) {
> +                               err =3D -EAGAIN;

xs->tx->invalid_descs--;

If the same descriptor is peeked N times due to repeated CQ reserve
failures, invalid_descs will be over-counted by N-1.

Thanks,
Jason

> +                               goto out;
> +                       }
> +               }
> +
>                 if (xs->skb)
>                         xsk_drop_skb(xs->skb);
> +
> +               if (reclaim_desc)
> +                       xsk_cq_submit_addr_single_locked(xs->pool, &desc)=
;
> +
>                 xskq_cons_release(xs->tx);
>                 xs->drain_cont =3D xp_mb_desc(&desc);
>         }
> --
> 2.43.0
>
