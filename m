Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.176
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793327441;
	b=sksolE3mwj9TCOrc+Q/BfKJ9yygJvVnj+kGQzORQDAjWOnfR7DT1IhdLB8aaGOB3yj4h
	 Hz8mxYVEyyNverR8nMe/Wb18u9DW9Uq68jlxHmH0ECX2i75HyLZiGe2UTo0bJbJ4f2ZjC
	 N8IsjRlDyHPb330AfXGb8sjEetqwbB4LGEZj1bvPdFQ0I6+e3V/qI2hGaNyQE1jQ8eQEv
	 1Qm+2yhf61lo6C0h7fyRDnzT95A2lGAsa6a2kPxbfGyTH6vJIrPnYR4SIBpkejI7rwyyU
	 AesnMCSL1PDSUOZfF5IMB77RJWCva+R/PdugSP6Y1W2I/zV+AMGENy2ZyvO7S9k/XpA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793327441;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=v5VYmc2HDzcSq4knARbKbUwFAzTpnHrwQ7qzGl0SDd8=;
	b=gFNljummD/NYS+ScvUB0SysJ4DGt+SBVk3iwVSNLjgxqvYhhTMv+Ra2vEN+JDiVdCt6C
	 jHyYAd5EZ824/pK1KavEtqQ5IUgMJBOBs8fRdyqiap1X9vRwqqy/R05yKzDyGaO+NuuKU
	 RtApdjfKaBDg+bKB1N2N4RgwmTu65q01yN1KH6ZWQnfW+B83KapmgM2BAGLuN3Rpsd2RN
	 /7GqMxmiggkoP31shzJf6cYuXTj8VecQVDaKe8hdspfjjt7uSV1aunsyI6DL29SgiJCht
	 Qy+8ETOILtZ421ezA492ORr8RUROOawF6IWJPs2vbJL9xd3QbOqWJwr8OEKdRXxoWzw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=e8gfzGoR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.176
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5E1606A323
	for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 02:30:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF5E1606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=e8gfzGoR
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-3ab46699a09so2054361fa.0
        for <bpf@vger.kernel.org>; Thu, 29 Oct 2026 19:30:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793327439; cv=none;
        d=google.com; s=arc-20260327;
        b=U6t9zy4dNW3r6Nx7jetpu9qTGAawIoR0Ipcq4N+dTw7G/q9QQyAuDBHFMK2Qw5KnSY
         uvbBNXVUMDigX47sVY/8eNIqllgKfivthAok+FvPeMNzy9eMoPO6Fm45cLXI6D+o5wqh
         fi9vaVoIy9a47Gtqs2Yakyd3a8cXqADO5uJuZKcwJ4cr/m5rrpDc2n1HpsRPb6xtAua4
         2qPfe8jSfgn/vpWRvJPdUWutJHpp4hjymokcLaDzbCljCOUbQhgR+vdYhvEJNk9TtGHN
         kIG9UYnJTx45WY5yT5g+OXD1TdIfdTZ1evWfHERg05kQ1yeD/XUIVKpm53r66Utem0ju
         ZlhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=v5VYmc2HDzcSq4knARbKbUwFAzTpnHrwQ7qzGl0SDd8=;
        fh=3kDDruLelXz89DXnY1qANDzbmxOp7/v4pquEXkKn9tg=;
        b=gVpEUmAN6MECSmfwzx80WKK+OOq6aZjyYmlMDEbs30ixzTK/fAJMqNRufe2LmpMVjj
         wQYBJuqccAZzvHetJ0wHQkxCWRv/My3wdO3RRaYcnX8esNLGN2UQg9Xi2SKfZvO/iPxX
         oEhpaa264dD8oeGYfQnwXl40BhxLD7WRZUgb/gWuSCe2LnNw6ilGMc+yh3vhae6yIJwY
         Rqkvv7JjF3xWNwQAKNr1HLbU0HUgtML6R3OzBriAEbXxJEU8XpC2QOINd5DXMQ9vUUHS
         MqEeIc+I1qdOlxTUeElfIDwXfsi3dA2lSi4HI+VdTQQWhwkRCYqug6nQEABgwvfV/peL
         rP6Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793327439; x=1793932239; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=v5VYmc2HDzcSq4knARbKbUwFAzTpnHrwQ7qzGl0SDd8=;
        b=e8gfzGoRM385FEsKyD02HVJxEcPcs7T3QOF/fJWMMm30PlbFERmKncV3Hstqsx2052
         lf0xfBvCVoO5IbSgaLtFUi3IOlIFZz1uzqLANxW84fUcWsKuv/UhGHOgEFLFNpxKSITg
         iZr0fs5CcKrN13lt42exXW7GYdCcJsaFZq1uGXQ+jrn6ASA4gprfcgsdP4KKcpG1aYfU
         C+NMi78+7JV7NTPtMAWIFI7q/n2x8uJES+rD5YbbVVnNBM1jrYwFbIqfjStrL9BYr9jO
         zsfza/TSP1s8HBRuKorim1idzGf7awlWuP58iN3WCOzZWQE5eRHJv9Wta5sLZjEEvL0F
         LSEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793327439; x=1793932239;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v5VYmc2HDzcSq4knARbKbUwFAzTpnHrwQ7qzGl0SDd8=;
        b=b6bIx+GkSYyvCeSqWgkrEQn5OXzCRq8XV3og+CZLBu3m2RdMjOChh6f1w3a2bu94lK
         TMMWpuOBcPaxrVr8U/Sq1sQXPaD7dMu2dk7Xb7vnTo2Ke2lOPnk+Rn4EvTzLfqj9AFJR
         9l0uEhrUNuKpHnw18W23v1spCJGWrQ0BO/EpzRGqblRmvoNaNvSaqXxSsX0QJ7tXXmxH
         84OKqN9CjjG5r3WlIpeuDboB9OsMefxVhFBL0ttq7vndofrTxxH+P7fRZZyEFogzm+PX
         v16oNb0qGm6CpYoAPjOVHQRRW8ZH25pIcSkgXq/+wTSeI0i0mK9bSPh8hlcrZ50E1tRC
         SFtw==
X-Forwarded-Encrypted: i=1; AKwUvBz9PnuvhBLK+2sjIWRV9Gw/cvgxAjZumFI5fOh/eSid6buB44BxWseOYqvjZv0BCROlbFA=@vger.kernel.org
X-Gm-Message-State: AFq9FYJHZF3DXTcKNqAtYE/k8gredy1XOVrCkN0JPNVzJp1Buysj5LIi
	v1h42E0qKJIizsMHdH5eR8JznJc9G+3KTrMlzk4T0p3aJ6IEwBJ11SP5vr7XlILeoxK5EWGeRQd
	4AIq98TzI/WADQUSYEGFIJr38g9jftxU=
X-Gm-Gg: AYBFou2b2NtsPHqonZ16eX40dvTdg6gp0qojfysB02BdmCCDgScxoj6gWhsI3JjVzZ/
	5gxCEGlfcUeDE3S92dj4FGe2t6TREB3ClFiuYzlL7S6abCxA7zT71l8wv5nmzFGmPFHugwmyfKd
	inWCI71IR5mzNmYpMSxyip/rr4lRCuOoBYmcwZvBnk+zMj7zuBZbphNuGgOTlzPknI/tEvHrNME
	gh7ta9uPaOoq05ZCqyCp8jsUQbGWekv3dQQkEYT4Njs1l7zT8kbKrP0jA5WpcQ0+J1pe4TULwDY
	qCyO1Qnbboihpn//6H/cilWk1Bh39ccKaYIBwZ5rXTsm6K8mNrQFW4vMl5j3gSNmu2aWLGgcyL4
	35eNDm3P8sPoku89RhgeRwrUVRM+RBq03e6E1iSIevOEAuFiEDzuAUpMRJYdrZOuaFNcfL+kFRf
	edmR5naldi3yImUSKcpQ2RJMhSyFl8Qzbufg9hp0jMjMpqFkM5bdlVcK+9zykRixFXjsrr5cUTC
	R3ejAO/mM1Q
X-Received: by 2002:a05:6512:2251:b0:5bf:cfc3:5954 with SMTP id
 2adb3069b0e04-5bfd954b9f2mr211780e87.1.1793327438692; Thu, 29 Oct 2026
 19:30:38 -0700 (PDT)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261028025026.11401-1-testwrzwrz@gmail.com> <20261028025026.11401-2-testwrzwrz@gmail.com>
In-Reply-To: <20261028025026.11401-2-testwrzwrz@gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 30 Oct 2026 10:30:00 +0800
X-Gm-Features: AclHuK9V4fvZWJ4AFY9w_N67m8fmBuNScc36Y8vzCOEgxwll8I8B9GuAiObXkno
Message-ID: <CAL+tcoA0jyxR875KocG6fwNSOPjfC-pdhJt0xCbsDQMtiNx8qQ@mail.gmail.com>
Subject: Re: [PATCH net v3 1/2] xsk: defer software checksum until the skb is complete
To: Rongzheng Wang <testwrzwrz@gmail.com>
Cc: netdev@vger.kernel.org, Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
	Magnus Karlsson <magnus.karlsson@intel.com>, Stanislav Fomichev <sdf@google.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, stable@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 28, 2026 at 10:50=E2=80=AFAM Rongzheng Wang <testwrzwrz@gmail.c=
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

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

> ---
>  net/xdp/xsk.c | 23 +++++++++++++++--------
>  1 file changed, 15 insertions(+), 8 deletions(-)
>
> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index 33475b180ea6..aa6b010192ad 100644
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
> @@ -1030,6 +1022,15 @@ static int xsk_skb_metadata(struct sk_buff *skb, v=
oid *buffer,
>         return 0;
>  }
>
> +static int xsk_skb_sw_csum(struct sk_buff *skb, struct xsk_buff_pool *po=
ol)
> +{
> +       if (unlikely(pool->tx_sw_csum &&
> +                    skb->ip_summed =3D=3D CHECKSUM_PARTIAL))
> +               return skb_checksum_help(skb);
> +
> +       return 0;
> +}
> +
>  static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
>                                               struct xdp_desc *desc)
>  {
> @@ -1275,6 +1276,12 @@ static int __xsk_generic_xmit(struct sock *sk)
>                 if (xp_mb_desc(&desc)) {
>                         xs->skb =3D skb;
>                         continue;

nit: since we have 'continue' here.

> +               } else {

How about removing the 'else' branch to avoid unnecessary indentation?

Thanks,
Jason

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
