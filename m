Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794370971;
	b=f/G0u3rSpRM9yMU3owSGHWkqRVT/UZUQ0QzeA46vcVIPkmxDwYZUKiuMijxEWuAPEeSo
	 l5QqEW22D4IiivwzUxt8NBjreF0WHcqzbfYmS3LsWIriy9u9IUIk0PpGW5Uqg4Fmp3lsw
	 KlNezrwd4vHpBH6OE04A4cAbpfTdoejZaYT+ctXaUyS4avhMkaCUZ5VJElen2TdJdqYTf
	 WPxyjl5USX3Gmk/nziy/jtsTTxrX6gjehgwbw5YWyJ5bCeS+LsdSPV/jgV+Rd8QAZmp62
	 l+PJG6CwH5L193PhPOi/mYP4aHuHD9pxPf+wEar9lxC4ulWPSOnJv5c4/10+TvEM3Ig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794370971;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=/5Bxw6ytYLgq+ERu7e6JcggrYWvMSRCcRXq4N71vRMI=;
	b=TxPq/YqyuSufpm+7mVBuyBcL6UoOq7T3u0UtZKNDroZpXvNilb0qP/k5QvHZI2SFcxb4
	 yvaJnqaWpUL31stT2TcG5HqVfez0XOc1rkC22Q2uFHKX5rUD4gFPjO5/NyWYmgOnE3wAQ
	 GQWxttTvFolRJZ8RIz4OWMFSyqLCzbVvGDNvrp6N0C/n62mE7IwMfXvvrGXNf3/VZOZum
	 iJDT3SzP/4Ml3DaiHLllfLaSKWwa2YXl3Ogkfonus9nlPn+dPjKdJVc+WBUJpmWh68kKa
	 DXNbE4N+w4fkt+ec3dszd7gYo/+SKujotpkn24004LYIV0UmfHRV2Ru2F/qrCKdMUMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="f6/CvfmN";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0E4606A31C
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 04:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f6/CvfmN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4A431F0089F;
	Wed, 11 Nov 2026 04:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794370971;
	bh=/5Bxw6ytYLgq+ERu7e6JcggrYWvMSRCcRXq4N71vRMI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=f6/CvfmNfsdIq5vVhi3o7Y9G83SE8jEJnYsFXKSGLhF32eFeO1HvroW5/XkLsmT1+
	 pHiB4Nt3wz60JXuZD7H5J9bDfVoWWgPBs/XRz8d80xHJIb4Yl4f9mqkspFvNp1fwAJ
	 37rIhnSCOjPqpgY6T7ww0ap1nIaSjncPG0QmdNToHLirrSReT5ytuK9JKnMSBF+WR+
	 t2nZbu4sTuSI6fi55LEe41cPG0FaRkxFiosADJfU14NlL+/NpQQkQwSlajivd0ENzZ
	 VrEe9CftkVJ9iZcRjuemCzhWrubvwNU+2ArjyN2sVei1KPCUrjmAtwBJ7WnN5VpCBJ
	 tM8FR0ntat3GA==
Message-ID: <sashiko-outbox-208275@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 4/6] bpf: Invalidate async callbacks before
 detaching them
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yun Lu" <luyun_611@163.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261111024333.228633-5-luyun_611@163.com>
References: <20261111024333.228633-1-luyun_611@163.com>
 <20261111024333.228633-5-luyun_611@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 04:22:50 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] bpf: stale async->cb pointer when losing xchg() race in
  bpf_async_cancel_and_free()
--

commit 686504449c958e635d8414edba153676c8d63adc
Author: Yun Lu <luyun@kylinos.cn>

bpf: Invalidate async callbacks before detaching them

This commit changes bpf_async_cancel_and_free() to clear cb->map with xchg()
under RCU before clearing async->cb, so that a callback object is invalidat=
ed
before it is detached from the map value slot.

> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index a08b2af56ee64..716be7a852b58 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -1747,15 +1747,18 @@ static void bpf_async_cancel_and_free(struct bpf_=
async_kern *async)
>  {
>  	struct bpf_async_cb *cb;
> =20
> -	if (!READ_ONCE(async->cb))
> +	/* Another canceller can release the map-owned cb reference. */
> +	guard(rcu)();
> +	/* Order unlink before reading async->cb, including an empty slot. */
> +	smp_mb();
> +	/* Acquire any invalidation published before the slot was cleared. */
> +	cb =3D smp_load_acquire(&async->cb);
> +	/* Only the first invalidator detaches cb and drops the map's reference=
. */
> +	if (!cb || !xchg(&cb->map, NULL))
>  		return;
> =20
> -	cb =3D xchg(&async->cb, NULL);
> -	if (!cb)
> -		return;
> +	WRITE_ONCE(async->cb, NULL);

[Severity: Medium]
Can a losing canceller return from bpf_async_cancel_and_free() while
async->cb is still non-NULL?

Before this patch, xchg(&async->cb, NULL) guaranteed that async->cb was
NULL whenever bpf_async_cancel_and_free() returned.  With the split between
xchg(&cb->map, NULL) and WRITE_ONCE(async->cb, NULL), a second canceller
can observe the invalidated cb and return early before the slot is cleared:

CPU0                              CPU1
array_map_update_elem()           array_map_update_elem()
  bpf_obj_cancel_fields()           copy_map_value()
    bpf_async_cancel_and_free()     bpf_obj_cancel_fields()
      cb =3D smp_load_acquire(...)      bpf_async_cancel_and_free()
      xchg(&cb->map, NULL)              cb =3D smp_load_acquire(...)
                                        !xchg(&cb->map, NULL)
                                        return;
                                  bpf_timer_init()
                                    __bpf_async_init()
                                      READ_ONCE(async->cb) !=3D NULL
                                      return -EBUSY;  <-- spurious failure
      WRITE_ONCE(async->cb, NULL)

The same race occurs on a single CPU if an interrupt or NMI BPF program
updates the element and calls bpf_timer_init() or bpf_wq_init() while the
interrupted task is between xchg(&cb->map, NULL) and
WRITE_ONCE(async->cb, NULL), or when check_and_cancel_fields() races with
map_release_uref() before recycling a hash map element.

Having the losing canceller also clear the slot (for example via
cmpxchg(&async->cb, cb, NULL)) before returning would preserve the
guarantee that async->cb is NULL on return without overwriting a newly
published callback.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111024333.2286=
33-1-luyun_611@163.com?part=3D4
