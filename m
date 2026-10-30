Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=74.125.82.176
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793341915;
	b=zVElINKDfr/Ltcrkq2StakVoPV+EfTED4xE/IEzOKt4fVfyXVKo1yq1rZIw0pcbbWaTu
	 CbdsTvxAxxsBcKBF5sY2/oTw3jZEhFJiHUr+UiaWFOVtqRr/BJOGBLM2SouB/dZYXoCZt
	 tccu7/UCd3wbZg/sImlAatRHkGZcVkryIUZRpg86MOBo5RCSwjLc+xlkLg4wuBI0RXr7d
	 Fe4Pge0jrPySKSexi32HPYCSZvNx7LNOJUAg5nH7zKjQ8r4TD3sFIabjbBIXAl7eeXrcW
	 Tr+5e5ElxllEDOB87H70xPKWclH3e9EcSHtSSD676eI0ifJ93togThaZAXBAHRutLgA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793341915;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=po4/7/QhF/scBRTBfQcn8+7a7UueR9Kf354VoVoto3E=;
	b=rzhcbu+D83Bf159Bz2hU4gV3Y93tXZD+zj54oFa/zsNu2Xl/vdMrXNWEonj0iqL0ZVhB
	 cpUXq/6JeGJX6oYnxOSgT/QZ5zlYXqmlDF5qOZGMQtF8Id5dDVFpsMoHgaKvlDhfAvJIP
	 Fixv2vznqUh1RWSCoBWG5ht/srV6ofK4f5StZFVWHaZqt94E45PM+uzsSneeY+nisTqj4
	 BoyzpIaDK8+3/GDWhq6lkbJxpGIj1aJ2gtS9V31GgRMXRcc6fYVMQSEVo1ODetJjWGMmd
	 xAM5I/YQaIOVdteWWRLK/NxCFm5BRwDuYWiH9tAO5deJMLmY93sg8qSYquC+EWzhPmQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cHhGZfld;
	arc=fail smtp.remote-ip=74.125.82.176
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FEEC606A31C
	for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 06:31:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6FEEC606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cHhGZfld
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-35b2c599f43so920965eec.0
        for <bpf@vger.kernel.org>; Thu, 29 Oct 2026 23:31:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793341915; cv=none;
        d=google.com; s=arc-20260327;
        b=FCAs3mTvZ8TVdhcpRkZDCh/TBZeQ51SL+ymPr4FpvTN31o/PO6mpCwIEYNMxs/NJAw
         xjQQXanvKrV/Sur7yWDeaAfVY4fIFGKWGu+5eAxvCHbPf5MVP4Y5vvag+4hXRjBojMpU
         U2A0PqHZLpEyDcILRUfVnONdtLtlXkssMibxaVsb59MwV0J1BWFVrryysYVcB0FHmI6E
         dddYWOnQCCFsXjkhwzoIHtcd59/y2AfDk/McIn26+ycpQw6hbJ256RQmtsKmmqmV7Vug
         fGY8lekPbgC/s5aPlynjFmkvnPVHU73wu+mJu1OzjWnbVhrDzDiDszSIXVz1lRZWyNrt
         Hqtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=po4/7/QhF/scBRTBfQcn8+7a7UueR9Kf354VoVoto3E=;
        fh=UVcVs4+xB9QZTql5d93TJfKUlBDUvHnK0BN/ZQo+wSk=;
        b=oE8Y2fDqsD5JZZcwziIGDh1yyY/9LkNj2Wjj26lPfQXNmMY1RSn1Lh8fgJeH/n4b6c
         lAGT5/zppQYlOcHQG6rhjqvbxLiDt8WpFhMmCv+mrPZxSOgE0t7fSzKNCyWbQD7YLEOz
         lSIYAcVt9GH9SczMSX0GZztoCOIs0nG0bUsMQnUvcx7psrZSM3EsRO+4EiLXUBz/sX10
         qtR17++ipXNM6GnqztqtfT9YvWOLnRm7nGi/JaiLdK1HTgtmVCGJZukrbPTE3FfFKz+Q
         8hpJLsRief7QgqswWsKvKsmUqsIy6eJR4S3z3tYj8XrjWJIjFQiFK1yWPred+yjd7xKm
         v4+A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793341915; x=1793946715; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=po4/7/QhF/scBRTBfQcn8+7a7UueR9Kf354VoVoto3E=;
        b=cHhGZfldf7rwLhH5KKbJjNDRKRapNAbZx8eScm4G6BCmNEX/trTh3APCkLfh7RB+2A
         cOLu7dpCFuIi/m+jx/yTUFUZMcJ/kJsLk0BeCCxGTjWwhL7Fcn2U+1mjgVSS+5x+MocD
         3qorXUcfIr3oq9+t+uVpP9+qFn8OYOWEu8f4WNt8FwjsiisYzVDtYEsHOQZK7cmuVU8s
         3WGPwDeL6kTP/eAYTW0bJDdrufMyckcJZzLXjlZWf5QW4juLEPZ3WWHwuz41GyBX9HjW
         PKxwgfe8XIQzCbxMVJIXkqmN2gVFfKVlfxMITH16qONvocH7wAlowIOwo20nkYQaUR7p
         pDAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793341915; x=1793946715;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=po4/7/QhF/scBRTBfQcn8+7a7UueR9Kf354VoVoto3E=;
        b=CZhm5+WQ189AKiHFSSKRTUjoI/ujK0tudFEcKaUyQQegrPbb9te8RAmKNWp3uJ4+vT
         tl6R6mw8YEjuU+cvBkSFCGt1kaLT+9R6dDkbalnqICvHFzqm5c4L2RtXWti2uZCiVSTC
         sXJDbYkSw5yplAOSQzgne3u4pKROxtf7xG35ZGMbvKzalPR+kSyYrevwObCjVQAXJBFc
         AYm8gLKPUu23iv1v+2x1z0NtUR60zvhNdgvwjeMpRUx4Cl3w5UfKog6b0mhED4BuND8q
         3o0FF5f62kDB9LimL4hdhe1ADu37GhgIpOzSGXe0YeJ4yi6vEcmIs7GfNiDqQhHIxzkb
         ZZ4A==
X-Forwarded-Encrypted: i=1; AKwUvBwIK8lDRWOktxC2/Pt+DfR1LnNGoOzIgJ6XyhHUeVvwW2iyP2gTUYpxkzusy5EOWl8QRGw=@vger.kernel.org
X-Gm-Message-State: AFq9FYJc4+MTSGGpRDbaJ/aG4dQXp8VPw+dUufUU/awHUg5e5oBLIhU/
	FpEv4WxxmBBzYvJaEIezel/7mCgxcPuB8+apPLf8xz8liiYgeQZkfM1zOUb4wvlcTtjICxNfueT
	iMt9qUlTdoK3XHZgWt4q2xi3Si/ATAJoQdg==
X-Gm-Gg: AYBFou3vOTp/20VZ4P/OWUxAndMk0p+AdNqBmu94Q5I7v4jj33MkR9j5/P5Bi4VQsLr
	tjezaZ1mWk4I7gjGg6Zdhr169mG0mK2gsYXSDTvnPKA4BJgtu3oth7eUX+gzxU4KtLS5x4q/F0L
	PCnsyS+INYmhZHWX8ZSTyRJdTdqAidECSlsz4iBWou71lMbm0Ze5a7S6leBtb2LBokWRDOS83K5
	+QbGgLJ17oz+ORBbZw+KvxpWhRdMS4qRBFwRXcS283DFBZ0lcprFT7vAliF9ZucfYFeajLVYhxC
	o8IZtjDUIYRvC+OQzhXnAhH0p8fNzEw74Xx9KquUU0pQ4eU521Oftds5O+oVjJ2DX4JA1tS97uN
	eKoaCViuc70GK9xKcfBwOvXdLTM7sURZDkW2+jNOsOWtujY45in/2ksV+RD//wtTQOfd2w/dg9L
	M4ViYBSunFp6EFOKdd9fRo2LZjFjtpr47YBIq55Rdj3MXJVyj3qdo=
X-Received: by 2002:a05:7301:618f:20b0:369:fa8b:d725 with SMTP id
 5a478bee46e88-36a42440a69mr2479370eec.35.1793341914428; Thu, 29 Oct 2026
 23:31:54 -0700 (PDT)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261030023248.78802-1-testwrzwrz@gmail.com> <20261030023248.78802-2-testwrzwrz@gmail.com>
In-Reply-To: <20261030023248.78802-2-testwrzwrz@gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 30 Oct 2026 14:31:14 +0800
X-Gm-Features: AclHuK-3MmLI6pDH5EvsdDyQjqZxLAj0eXtw9LqREvrfIl7g5xpi_yP0zHn6NUo
Message-ID: <CAL+tcoDUGqk-KfMBqdG4RBURHQc=9J+Ce7B7CZZWRN5yN7pRrw@mail.gmail.com>
Subject: Re: [PATCH net v4 1/2] xsk: defer software checksum until the skb is complete
To: Rongzheng Wang <testwrzwrz@gmail.com>
Cc: netdev@vger.kernel.org, Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
	Magnus Karlsson <magnus.karlsson@intel.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, stable@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 30, 2026 at 10:33=E2=80=AFAM Rongzheng Wang <testwrzwrz@gmail.c=
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
> +               } else {

Why are you still using this 'else' as you already posted a new one?
Please take a look at my previous feedback.

And please carry the reviewed-by tags through the version next time.

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
