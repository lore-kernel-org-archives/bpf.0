Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.167.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792896713;
	b=yqTBNMN3A2QmeNLw4p/MftQ3UXz9Dgf+zVa3zYquDbCPquXUYUZ3GSF78YSrPEWjvWbj
	 fgwLYfRagcJ/NlE53uC5eUMjw69vkEwNuGz/+QiAYXV4Xz9MJ456PQ3U53nB4A9deTCAM
	 3X3WUdxbsdduI8pL0LaYgSPy7xJ4gEiWzqY5cyLkmKfJFqR7mmCltV7glsm9fvh/elvIA
	 lmrYfhI8PskgzqF1GLFQS1KyT1GKrZdcF5ZMFd+LHT9osp4c+io5QMJxjnKnopCd8tAcE
	 O4dv4woVUGiz1Qk1CJKr8SvbI1AwGDIFG3naAS5JVZ8OV0Qg0bC6RxaH6/Rg8qFJy1w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792896713;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=FU5RTsamiHXtFoFdGVctPWi31ZfViWT4/lAqub7SSi4=;
	b=fx/OCA1w7cXO9fK/WWDkCqQQ/3jCk16eQWKzgaU2BJIBTAA+QqFmsQmMdQvyA8ZFgd3Y
	 Htvpcztbus2eUXRF140lzbxkO6cTt0ZojeP+sRtsONZdrSoQeN/62Xxjdwhn7q+E9lUoP
	 4uHdkRTFf2C7FOOBsXOZJd4secGRuTsdGKZFvVoS7RSPfiRqJIc0Un4SDSXqvFy7uC4ka
	 mz2NqOJ4En2ynZPNunVcdUdMEpDa3DqIPbvWErkYkAbN4pFLthMk0cwN4d0Bs4qRXqbTD
	 yRqb6QwQBhyurbV4OiiMlhtJlbzd8eHGG2kYPiPTd5CVcCxH6ZokuYvrBTahWcXo+YQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=aTtfRWF7;
	arc=fail smtp.remote-ip=209.85.167.49
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32DC6606A31B
	for <bpf@vger.kernel.org>; Sun, 25 Oct 2026 02:51:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 32DC6606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=aTtfRWF7
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5ba36cc21cdso2202698e87.1
        for <bpf@vger.kernel.org>; Sat, 24 Oct 2026 19:51:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792896711; cv=none;
        d=google.com; s=arc-20260327;
        b=Zqm5yWAER7lF/28fq7J6pX9zY109IQQyaN9YIjRsQC80Rp9vDYUUKca4zWh2ZB9Onw
         TCYFq0hPiiNnb86ABo2SH3jwFulXULiRoQKCw7Z+qHxnpsfbpmqf4Z87qVOW3cW90usW
         Ux6hGzzUApMTZ2aPwS+f/03VLDm7c4tT1kn4PCb+H5esOnTJ9jmWaAU1yqvNTiqjwKFJ
         EP9Dn7YUMExmrmvZK/O/NWwNxIVj8m5tQadZzbuU++R1Bi2kfPCWmeu786o1Nn68qLNs
         mDKfMwKXTje+FJr905W+yBkLS8ImTjNWb13GlBPQm8OBOubEVDikUffqHycjzEqVqYTb
         ZXXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FU5RTsamiHXtFoFdGVctPWi31ZfViWT4/lAqub7SSi4=;
        fh=MdzPQyYISh4aUVbCxpyvaXgbp2LXHhyqXvuad2Uq+D8=;
        b=SDLQQ0q7oejaFSku3MfumVxsJsaaOOlFPVfRW4XMIWN6VP+LpNuE5x32NHO+/9pMHY
         1gQw/0JPZ6J34n9FZJ+c14qEwZYYGDaWNJAvsP/4AeLV9zW6fZkT0fxg3q7Ycty4qd1M
         ply6up8MoOAgn9iFJD8Ya8q8XddpXmXSDS0ddaFX4JVYIQ9Bp+WKj9HWdv0POVsLFcz/
         FXsptk7p3pP077cRKsqbR3P/+LMxwlhGwqeRyGUGeU1Q/AVxp2DLmMEdnuh3n0G2ocql
         HCTyO8wRpkr3O1Gxr9/ARFMIjGiInA+Rc30JJX1Lr+mOQW+Uvm22KuZuFeKgWw2WQ+Ki
         tM9Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792896711; x=1793501511; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FU5RTsamiHXtFoFdGVctPWi31ZfViWT4/lAqub7SSi4=;
        b=aTtfRWF7LQ4aK7mY7nYUpzL3kyQ6x7PsBZmvPrbianfoppIvuf0nfUQKIpNnpVKJ1s
         MpAAKClCDQ0ycO8erRcVLScqW7Xnx9gmwbimL69V5ZlKrdetpWfYxJ0tHpHAlB8i4gSO
         8ulg2HkHqkZRnHit0VKY1gmWFyplDc6TZHpAgP5btHf2fYtDBQjsO8ajz00B9Yh8hBT+
         er/+xI/iSMvlfdZrhUF2NLOz3Jno6+jX7o9ZZKLskp/x5q4pUyNJ9eWFwmohXeWDxdzQ
         xWT3yv7UFlCgIazWEP23ahkjiPvGh0HVvXZuLLpookcU4mz6FkGhJlZ4v0U4h+sKgo5+
         P1xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792896711; x=1793501511;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FU5RTsamiHXtFoFdGVctPWi31ZfViWT4/lAqub7SSi4=;
        b=uCqL01qqRM3C2kVrx6g6CMNWRtdrHwsyMah+jnS2YWm1tF2XQqqLNPASmpnWbvVC/h
         D/eJfvg2mtQaaCrPCvkUEZcbNP7oQ8d7jKF8JpMcg7tKElQhA8ABkKZrk8RDuAdijGEY
         AWZ0J1RwsylFduKsiQ7bW9QemVpea/wVQHA0ptCCF1/J1R00jm5r3iPgNHRkCL/V1Koq
         WhQ+AAXUyycbwPyz1p27cb90hBuTXtORH+903yni+7XYDwFMuFLlGUZuzb4zzcGwabGU
         l64Qu4aW0in7ABtTOxk3zwIaMHPOoLpKupzUoCfB5jv9tvDZ/pwySP+Dz6lV3yzMEWk9
         spdw==
X-Forwarded-Encrypted: i=1; AKwUvBzy3toJsbx/ksjFkTFK/XovH/liwsFFe+PeVQ+1w4K1Dac/oAAJs5hG1O8pfdZo5Pw+jI8=@vger.kernel.org
X-Gm-Message-State: AFq9FYLwDZvLDX6RlKvF+/BwFUjyNHB+9oVO4rY8aE+rFmt+fjvuuHdC
	X4UzI9rY3gAdnfWDq8/0J9Yqc/xLMeGYrvHk9DsBAKRB/obCnWTtqLvRQ4e2+exvrb+S2RYOdMl
	TByfr03CWnqBWySQi40pKSUJCRTvMAbE=
X-Gm-Gg: AYBFou3AELO/inBvA/x9iSgkVFW+NdaLTgd3ii9y8fExCwlDngi44zvXU2YcqohPr+G
	/hJhABJq2yobBln4Ah+t1Y3KPLpUzb5YO67v/3Mr7OJsLlCNlrJ/RthgmgTZmjHSxvw4wLdhDCF
	P6iEQKlAcrLYZSiO+iqgHvzlDF1b9soNDPh8tzMiao3ZYgPOVqatAvmzd/CKMM8sTwWJlYpiExn
	ThMdMTSymcgm0uMN+BYvl+lTPuWzbRu0DiYhMABVs0eCvoerFUSlq7RVWJudYMLgbR15Kcgbrl+
	QJNZtQbVCsZgYAx9CWTrs2IuqfGdtqjwQFS8lJFgnD6IihHuUNIe2VJ8n/VudReja5Tu7Jo4S8e
	dvBTgoJBuTK8tqQ4NXaqoUwEiNdkVqhBsZETM0Nryf0pTKfGRc7pHu/4GmLpn1iQBXX+pdZcL0c
	LCHurv+MV+h5e1fFtVUWEXR6TByu05nWTSsLjtPHfUOL+UAZ4Dz1oD
X-Received: by 2002:a05:6512:2345:b0:5be:4386:8072 with SMTP id
 2adb3069b0e04-5bfb71efc33mr1010116e87.56.1792896711058; Sat, 24 Oct 2026
 19:51:51 -0700 (PDT)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261024091256.17918-1-testwrzwrz@gmail.com> <20261024141157.59301-1-testwrzwrz@gmail.com>
 <20261024141157.59301-2-testwrzwrz@gmail.com>
In-Reply-To: <20261024141157.59301-2-testwrzwrz@gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sun, 25 Oct 2026 10:51:12 +0800
X-Gm-Features: AclHuK8kPBK2Oi4nOLhCm4MhUs2zF2fhZ4bu5005K1BW9G6XUx9rptsm45CJV3A
Message-ID: <CAL+tcoBQHudeQC+B0J0mwqbh1CH82XQWfQrtyXqVMF3ybopr3w@mail.gmail.com>
Subject: Re: [PATCH net v2 1/2] xsk: defer software checksum until the skb is complete
To: Rongzheng Wang <testwrzwrz@gmail.com>
Cc: Magnus Karlsson <magnus.karlsson@intel.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, stable@vger.kernel.org, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 24, 2026 at 10:12=E2=80=AFPM Rongzheng Wang <testwrzwrz@gmail.c=
om> wrote:
>
> When XDP_UMEM_TX_SW_CSUM is used with multi-buffer TX, xsk_skb_metadata()
> calls skb_checksum_help() while only the first descriptor has been added =
to
> the skb. The checksum therefore covers just the first fragment, and
> skb_checksum_help() sets ip_summed to CHECKSUM_NONE, so the remaining
> fragments are never included in the checksum.
>
> Move the software checksum calculation to the point where the last
> descriptor has been added to the skb.
>
> On a checksum failure the packet is now dropped instead of being returned
> to the application for a retry. This path is not reachable with the
> existing metadata validation, but the behavior change is intentional.
>
> Fixes: 11614723af26 ("xsk: Add option to calculate TX checksum in SW")
> Cc: stable@vger.kernel.org
> Signed-off-by: Rongzheng Wang <testwrzwrz@gmail.com>

Please do not post patches within 24 hours; we need more time for
other maintainers to give feedback, especially for weekend.

Do not reply to the old version patch if you're trying to submit a new one.

You didn't respond to my questions. At least, discussions there are
obviously welcome and needed.

Thanks,
Jason

> ---
>  net/xdp/xsk.c | 22 ++++++++++++++--------
>  1 file changed, 14 insertions(+), 8 deletions(-)
>
> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index 33475b180ea6..65be2a368325 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -1011,14 +1011,6 @@ static int xsk_skb_metadata(struct sk_buff *skb, v=
oid *buffer,
>                 skb->csum_start =3D hr + csum_start;
>                 skb->csum_offset =3D csum_offset;
>                 skb->ip_summed =3D CHECKSUM_PARTIAL;
> -
> -               if (unlikely(pool->tx_sw_csum)) {
> -                       int err;
> -
> -                       err =3D skb_checksum_help(skb);
> -                       if (err)
> -                               return err;
> -               }
>         }
>
>         if (flags & XDP_TXMD_FLAGS_LAUNCH_TIME)
> @@ -1030,6 +1022,14 @@ static int xsk_skb_metadata(struct sk_buff *skb, v=
oid *buffer,
>         return 0;
>  }
>
> +static int xsk_skb_sw_csum(struct sk_buff *skb, struct xsk_buff_pool *po=
ol)
> +{
> +       if (!pool->tx_sw_csum || skb->ip_summed !=3D CHECKSUM_PARTIAL)
> +               return 0;
> +
> +       return skb_checksum_help(skb);
> +}
> +
>  static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
>                                               struct xdp_desc *desc)
>  {
> @@ -1275,6 +1275,12 @@ static int __xsk_generic_xmit(struct sock *sk)
>                 if (xp_mb_desc(&desc)) {
>                         xs->skb =3D skb;
>                         continue;
> +               } else {
> +                       err =3D xsk_skb_sw_csum(skb, xs->pool);
> +                       if (unlikely(err)) {
> +                               xsk_drop_skb(skb);
> +                               goto out;
> +                       }
>                 }
>
>                 err =3D __dev_direct_xmit(skb, xs->queue_id);
> --
> 2.39.5 (Apple Git-154)
>
