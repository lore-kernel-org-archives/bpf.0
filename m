Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704DF64A8D
	for <bpf@vger.kernel.org>; Sat, 23 May 2026 04:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779508970; cv=pass; b=aKV27f/BkQIeHI6/W0LiROUx3pUO6viJkphdZlmMHBAf9jRscDt5jgC5O5t6/S2QLWLcrQF/Sp4pR6n72wgh8lfPzgYtfetrfLYsTt31G6UryZ3kvdW1X6GpJcy4H6mXLW/k07KPMBaPzoTNaIUO2y3n8uknGlzqybs2np5hE9E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779508970; c=relaxed/simple;
	bh=GH6jsum6yrwocICvHo0YbtF4U4fWpG/NcOYCkZzRxYI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Uh+K30py6XCCUA4iLt/e8n5IvmkdwC2cwn7pBYj4c0es3SJzNSb9HlnBJvaKRUd3BGarFA5Icj2Y8/hrcQstqYSai+G1Sl5E8MObW+e3PYBqARbDVZc5K59iK6kN9I6BnlvrVOArZt6cl+j+WkhLqyhAcCuC6o+jY82/uvaZPo0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GgFqMgCf; arc=pass smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GgFqMgCf"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2f0ad52830cso10333498eec.1
        for <bpf@vger.kernel.org>; Fri, 22 May 2026 21:02:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779508968; cv=none;
        d=google.com; s=arc-20240605;
        b=gvMnQ7BYNvyAfpZOmvklyi9klY+RUoObgnNqBUVgu7yHq3jlNdRy5Bga2IMH1c9yfv
         WWh/2z7bkOd32QFUdXRJeiAI13qORbjnX54FkytGFrGXCLf/G5xfabV8t+3piWEI8nNL
         ZUCH9lPrDk5BRs9piLfFhVRnCbJHfeAmMuOE6AUpWs0bElLJRLnwJHR2GEf9AlCR/udY
         zMzxu/Doo+plkJVsAj4IPTxkoqq9a//RKNIDWjXtTdN3w1YUFZIDC+/N0PBtD2DTyrP8
         3uxwTKN366neaCAf1Qdcmey8vFiGY+NiwUSJ1U9TRel6HZe34ud0KPSj1VloqYQ8pDc9
         iiRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3xcYPdDxJYzV/CmKiBG3CG1YIl4gZbm9+IKFFewBuVc=;
        fh=yJDGtm5YnBGXAHYN3ozhUYdTgwSw5I2vZMfyspVBB54=;
        b=B2qXc2VdUwpM/jg+JOChbAXMJQ4eOxD5K9v/fzM9KY50pOGrzINgdVK/1m4noL3AZ3
         47qYWVProHQmcRF2sbEtxO6PFX7zOKZ+g9b6X4Q0cDUrjOO4h2KraF3SrIoF6HRuJjlQ
         dpLkVQVC950hNbpEYaT5Eq2rhOBnNsl1lwbJ/ed5QRlG0WwWPSbjG75LCNOqApEpMicl
         k9RK7//ITyj44iIP/Xxvo8nxkH1aZON+IbU+Er34dKVitiL4izAOONZXuQs4Wea8smWF
         Ff3pnQooDC0AeUIHxNsyhVw69I0jad9yhH1AeZ40Tf/8Vc55ZI5o0dgUXVXtOy9tF5ef
         JdOA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779508968; x=1780113768; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3xcYPdDxJYzV/CmKiBG3CG1YIl4gZbm9+IKFFewBuVc=;
        b=GgFqMgCfAnQC+6+1zN43wZmpXGW+rgJy2VGjp8zPqETqoIYG76FOjtvgLW6q6Hmh8C
         g7Yr712aGBKnG3MN24mjqfpj9eAb+2XPkOzhYqWCFox+koghYdDH9kV0nDTZkDRezbin
         y5Qb2Yu/r5c+9FHuIbtvxCAkkLRuJdlrkHNDodnO+vOGDUZebJQNr2PXDuOess06snaH
         y7J42zjuJziX+mcbVkbSYMKraSl0b4NtUccZMzAvtJOxnELGlY9N+CTjUBD9+B7RyCHI
         IY951yGHAyPq34BqXRCGEXxknUSkvo/uWqZ6iwiIaG2u9A/U25P4iK3lalyFQcyt6fXY
         jfRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779508968; x=1780113768;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3xcYPdDxJYzV/CmKiBG3CG1YIl4gZbm9+IKFFewBuVc=;
        b=KXDfM1AGhThMzA64sMJAZX6ovpckODBEO4+k8f/oRa5lI9z+zGGkSxR5FhPzLvl0Ev
         KgkYF6xt6STqk0YAMEdhO9//oOs5zNahibdZrNC2Pp4+T7lq5Dyp6A7nsfUI4OXwnNaH
         K0eTjSqOrk2CiVBavYYaXRLhUJQPj6XDm6bOXfFGX/9VwEJeu8AL0EXZOaMcEmwKmgqc
         ioqQuu7fWivO7EjHmxx9CfIOsc041opNN/zm18D6EbS2X+9ZMt2Nnhq+qIdilTAqxExK
         L3NOWBZ8J9yn+h71zKpKJhe+F8mF83xnhmtm/ncZANKR5xTOJGn/zS6EOakbiJEWxoqW
         tSmA==
X-Forwarded-Encrypted: i=1; AFNElJ9pLb+OTDen1CgtTEYD3PoNe7g41cajlPM1o0aMAhgRg9NjMPETCHHofQDv6AmOxvIO6To=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNzQYiA+lOS8hhAVmEUzgMArx9LY5o8umRsjjXKhWXnVhBFdHW
	pxFwUTK26v0Je0lSvMOW/DNG4HlROPZNfG7TiSfE+XtxNNQZITgeC7YUjy8MEMisW/gQBNPQJx6
	U1hUS3u9J5PFUQoK/SJxv0tX5NHwJW01v9yg+Plcj
X-Gm-Gg: Acq92OHZKIqfqYH14PieIbF8HLRVChAvCYwGtts5RRIr+cESrUQxbt2v6XZzpJKCp8+
	aOHdePBrJEIGsvcMyi/DH2A2/WsbbwoCQjW5I5wtvByXt+IBWGzGvolA5rLodyeJt+nt2g7emxd
	CTgn9irr9f4pQoq4jWx989EhkMhWfS/VgDTb7SI2WEmbVy7frwvRG6u6KmzJ9aCZiPBywRpRL26
	GqSsJQpFCw+cc9StkMyRKA9ILZDuNhDxJJ50m9sF/+pg43eAk0PB16U6v1EXWVrFmWRloiJR7RW
	EDNlSAZMxSdzpirhLFkF3TN3KvbyzxhEicUAOc43n2TLZ37hhQIPPxX2KG8MJkccqv8GCNZtIN/
	3b55Of7D7zYhxqjRnV6BHPHVOpbVfCXECv+Mcfr6MlGGK4DRv+lK+vNpYlMY16/4=
X-Received: by 2002:a05:7022:1281:b0:135:3ed5:5e38 with SMTP id
 a92af1059eb24-1365fa38eebmr2273034c88.27.1779508967667; Fri, 22 May 2026
 21:02:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260521135244.40869-1-kerneljasonxing@gmail.com> <20260521135244.40869-4-kerneljasonxing@gmail.com>
In-Reply-To: <20260521135244.40869-4-kerneljasonxing@gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 22 May 2026 21:02:35 -0700
X-Gm-Features: AVHnY4I9iRGRBjCTDHtVv6_EN8MVPCUPZvh5e1-44mgNxX4WFKLucU4AFq1u9tQ
Message-ID: <CAAVpQUDQWZSZWamOj4MBVakq52KnLaDAHg7zAV+B1d9kkz9hkw@mail.gmail.com>
Subject: Re: [PATCH net-next v2 3/6] bpf: support bpf_setsockopt for bpf
 timestamping rx feature
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, willemb@google.com, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, memxor@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	jolsa@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me, 
	netdev@vger.kernel.org, bpf@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 21, 2026 at 6:53=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> From: Jason Xing <kernelxing@tencent.com>
>
> Add SK_BPF_CB_RX_TIMESTAMPING callback flag to enable RX timestamping
> via bpf_setsockopt(SK_BPF_CB_FLAGS).
>
> Add SOCK_BPF_TIMESTAMPING_RX into enum sock_flags that is used as
> centralized management of net_enable/disable_timestamp. Note that only
> one of them (timestamp, so_timestamping and bpf timestamping rx) can
> enable and disable the global time record of skbs.
>
> In addition, include SOCK_BPF_TIMESTAMPING_RX in SK_FLAGS_TIMESTAMP so
> that __sk_destruct() calling sock_disable_timestamp() to thoroughly turn
> off the global time record.
>
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
>  include/net/sock.h       | 5 ++++-
>  include/uapi/linux/bpf.h | 5 +++--
>  net/core/filter.c        | 8 ++++++++
>  3 files changed, 15 insertions(+), 3 deletions(-)
>
> diff --git a/include/net/sock.h b/include/net/sock.h
> index a579d5b09207..cf0e82e46482 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -1022,9 +1022,12 @@ enum sock_flags {
>         SOCK_RCVMARK, /* Receive SO_MARK  ancillary data with packet */
>         SOCK_RCVPRIORITY, /* Receive SO_PRIORITY ancillary data with pack=
et */
>         SOCK_TIMESTAMPING_ANY, /* Copy of sk_tsflags & TSFLAGS_ANY */
> +       SOCK_BPF_TIMESTAMPING_RX, /* BPF RX timestamping enabled */

Just a note, this will be the last bit on 32bit kernel.


>  };
>
> -#define SK_FLAGS_TIMESTAMP ((1UL << SOCK_TIMESTAMP) | (1UL << SOCK_TIMES=
TAMPING_RX_SOFTWARE))
> +#define SK_FLAGS_TIMESTAMP ((1UL << SOCK_TIMESTAMP) | \
> +                           (1UL << SOCK_TIMESTAMPING_RX_SOFTWARE) | \
> +                           (1UL << SOCK_BPF_TIMESTAMPING_RX))
>  /*
>   * The highest bit of sk_tsflags is reserved for kernel-internal
>   * SOCKCM_FLAG_TS_OPT_ID. There is a check in core/sock.c to control tha=
t
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 552bc5d9afbd..1e09b5cd7a39 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -7029,8 +7029,9 @@ enum {
>
>  enum {
>         SK_BPF_CB_TX_TIMESTAMPING       =3D 1<<0,
> -       SK_BPF_CB_MASK                  =3D (SK_BPF_CB_TX_TIMESTAMPING - =
1) |
> -                                          SK_BPF_CB_TX_TIMESTAMPING
> +       SK_BPF_CB_RX_TIMESTAMPING       =3D 1<<1,
> +       SK_BPF_CB_MASK                  =3D (SK_BPF_CB_RX_TIMESTAMPING - =
1) |
> +                                          SK_BPF_CB_RX_TIMESTAMPING
>  };
>
>  /* List of known BPF sock_ops operators.
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 9590877b0714..08ad102f204e 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -5304,6 +5304,14 @@ static int sk_bpf_set_get_cb_flags(struct sock *sk=
, char *optval, bool getopt)
>         if (sk_bpf_cb_flags & ~SK_BPF_CB_MASK)
>                 return -EINVAL;
>
> +       if ((sk_bpf_cb_flags ^ sk->sk_bpf_cb_flags) & SK_BPF_CB_RX_TIMEST=
AMPING) {
> +               if (sk_bpf_cb_flags & SK_BPF_CB_RX_TIMESTAMPING)
> +                       sock_enable_timestamp(sk, SOCK_BPF_TIMESTAMPING_R=
X);
> +               else
> +                       sock_disable_timestamp(sk,
> +                                              (1UL << SOCK_BPF_TIMESTAMP=
ING_RX));
> +       }
> +
>         sk->sk_bpf_cb_flags =3D sk_bpf_cb_flags;
>
>         return 0;
> --
> 2.43.7
>
