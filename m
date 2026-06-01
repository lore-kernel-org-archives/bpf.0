Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4536E3D967A
	for <bpf@vger.kernel.org>; Mon,  1 Jun 2026 15:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780327761; cv=pass; b=DH9i3Hk3i6k+XkJhi5jt9NOeS+3NSwyqBTzfAJNhSf7kmpqGGdAZzySPrYVlG1yoU6JPLhKF00NQ6GdkaeyD2HbILe4qZxEUgCxHPHyJeAEdqmNGRqgsPvGHMZI69kzNUlNPRjN6QiGyvWXFRS9vetNtkWXYMv5/jOox+FmOGUo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780327761; c=relaxed/simple;
	bh=Wj2HjaCmvrNykd7/b89FdO2/xBGB5dAuIyTwzhwlNos=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c0TRunw1iED86ajR12PLV1TQlUdR+wrdsaHT7+sfu9zBvxARB+8aZJAPl6t8+LNISWkre9sxJfTIoYgGmqs6mbE1zx6Zv+GHXUjmeEImQd4FQaU3A8ardlndrwtm4C+onICR76OCc6Wged8FvLqp2ZbyoxaDQ3Mk2b+ibvEiNxo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZAAJYdYZ; arc=pass smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZAAJYdYZ"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-8ce9d444173so16969326d6.2
        for <bpf@vger.kernel.org>; Mon, 01 Jun 2026 08:29:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780327750; cv=none;
        d=google.com; s=arc-20240605;
        b=TehqLzN5qdXwamHzlPz6Uq3XF8DB+b3dqswQdN8qdiFMCy2aRggbkCXqd8deoww+51
         YsG4uZPRR1hmkH26A/pAD6C/iTAFW9GqPGHwQhuCgTIRyBdnlVHAbmtR4Nm7mPdaUWi9
         CfK8hyyUAhKoN5WXkGgSGOrjwpsTN+0W09hKhR6SNYladcFrvJVhuH4Ko2BP6qCXeHtl
         t61BSnS2xK4nFM/Xk5dDjhpCsDmg9dBN0kerLZsWpn+tRStDY39n6/eI6bkIE8cDBCzg
         v8qScvf1YK1cvtgw3/48TipAw4HLPyY14M82ib9QYr4mBRk+YkiUTs8ieGrTzOOW3a3x
         4fSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7EP5yWJP/oLaBrC33EafyKNZLj+nlCv8r++/P2IFxvE=;
        fh=Ppwz4RUpJPJA6Jd2kTXI/EHd0RuQbqr7BnbEdTA1Qgw=;
        b=cQWsJsXERkcyUSJ8n4J9q5nW9TwzcTgSyOhD0fZ9oeCZtkqXBZszk6xc1QbGEJTJ1i
         vSZ7dR/QNk+U98PDrLK/S9n1qh4ryYR5jPQkrxBKUzwQYEdTIBFd5Ntip7iIt2z0/f9u
         2lTxz4+1JXSeO1uShfPMXObLuiAXcAjaYjpWKNuLrM35xPyfSaw0GyaRzrBcIn21KuXp
         Pjn7LwmWDOEUMSYAKtngQopYZVP1zgUhBLAcpODI2yOd376cpc3lodusoeJ4evAZvqZE
         dk7YsvMBwz0ABk7YiEdF4yPtVQykRbPct+PzQ4oWy7ygBzwqPR+SrZKVvJzll9LPkIOd
         wYDw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780327750; x=1780932550; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7EP5yWJP/oLaBrC33EafyKNZLj+nlCv8r++/P2IFxvE=;
        b=ZAAJYdYZV/KGWuFFI74dgcE5AjOOyyiRXII2VV93UrZNpHjLmPIDR3f//rcPmuDdAm
         bZYMZK84P2WA51F/FCWoVDSe80hxKU+FT2kAsJvFTNE1IT3ljY0jkQ5U0vnb3hE249xl
         oxnXysfShracuKeYpx/z49Xqw55KaDOQnm15831kQ33BbUmEYn+QhuIl95pQ06AaHBUc
         PVPvmZcXv8T5//LvHnIXUHvVsBDCutUVpeYRhPY3vDaTIaFKZmTuKy9YZfVIeXWAGxYf
         Ul2B2e9KhGG0XHp5MFmcDz0gPcTr5Oc9CSQObBvmofdPrkKPeCB0A9pw/Cbd08kI/mso
         MJOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780327750; x=1780932550;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7EP5yWJP/oLaBrC33EafyKNZLj+nlCv8r++/P2IFxvE=;
        b=GutVD0Ag/Cb1R8BIklIoyctIzazhtfRr9KNKmvfMgKkKcUTINrLdKpOFTCaAX7g6H+
         Dd8jWg4hj9qfes2krqlwOpkaLsv6C3BIfcDe4NmJdSKlhVrMWPxPa+eaEw8iNVknyOaB
         FPp8yhqY1ApoTXtvHS6L4lit5hLvAn1dxiqmhMsP8oXpNJrpvtpyCAWltzkP7jQxjEPl
         p/A/ZN16OCcfARp5FZEi+reuhq3nVFX3Mh5zUTa4txf3acmaw0AmQiASuQkxAetUjPyS
         OcgyT/9CpoMjkSOHZFE6YrrjWo7oMYADA6AgpiXolCdGpydDoG2ZbC5h0NwHM4+c/Qz/
         B3uA==
X-Gm-Message-State: AOJu0YwK71hJQ0dtrkMEftq1wMesEiZwRkUH87kYoeX+McTinkhe6WLu
	FOFkaH+WduUTveeVnX1wpGAv6RlmzQyu24KCU1rX4HDSWCMm4aaQmx58WjhLXNQorpyGsv0VzvO
	EiA7w7JvX5459riKTAoR9wys6xzwogztD4NODUnXS
X-Gm-Gg: Acq92OF6bgtNlb0pH4WIZf/LfbrfZZRKnpE9sgBHyIHkXRgjCKjZXY5Rt+CZJU26Zvu
	I9mELYKZL/ip2Rq9zu+U14SpKApbhHQ95QHBA04GxS8PAH19dGOPFGt3aPXBHWfoP91NVSMx2Ns
	YBNafjc1GkBvIYpoduT+7Pr6jEKmnB538oT2UuZErdossUSqHGBOsn0DLXmSQHxNls9FZPP5l6t
	0wBGKBPU/yAnXfEDxif9RXWLsKIk+FqRrZRsK3CjzmLqKzzLs4knL9I1/Zs82pJQc3DaXJzWQ7f
	w7FppBXHbcfGh9cy3bhvcQROLXnFSXeoGt1G6Y/DHDCwzbBNWMbweYqPluFo3of4ehLZ8qnUmeF
	9v56mX+jrz/CRMw0ATTj7sT1Pt+qc
X-Received: by 2002:ac8:5fd4:0:b0:516:daff:7f7e with SMTP id
 d75a77b69052e-5173a80ffb6mr163432151cf.48.1780327749316; Mon, 01 Jun 2026
 08:29:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260601150203.20352-1-leon.hwang@linux.dev> <20260601150203.20352-2-leon.hwang@linux.dev>
In-Reply-To: <20260601150203.20352-2-leon.hwang@linux.dev>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 1 Jun 2026 08:28:58 -0700
X-Gm-Features: AVHnY4KtmX48lQbX-Wzhm_U2p70Q1h5Y6tSbTyXB_2Lu_Z88IMHeMo5GbIX4esw
Message-ID: <CANn89iLJgBxx=NaZDHy4s1_U9LKp9dqUDd1v9LR3CQPNo7DxEQ@mail.gmail.com>
Subject: Re: [PATCH bpf v3 1/2] bpf: Update transport_header when
 encapsulating UDP tunnel in lwt
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Guillaume Nault <gnault@redhat.com>, Ido Schimmel <idosch@nvidia.com>, 
	Fernando Fernandez Mancera <fmancera@suse.de>, Peter Oskolkov <posk@google.com>, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-patches-bot@fb.com, Leon Hwang <leon.huangfu@shopee.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 1, 2026 at 8:03=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> wr=
ote:
>
> Currently, bpf_lwt_push_ip_encap() does not update skb->transport_header.
> When a driver, e.g. ice, reuses the stale skb->transport_header to
> offload checksum computation to NIC hardware, VxLAN packets encapsulated
> by bpf_lwt_push_encap() helper may be dropped due to incorrect checksum.
>
> Update skb->transport_header in bpf_lwt_push_ip_encap() whenever the
> encapsulated packet uses UDP, so checksum offload works correctly.
>
> Fixes: 52f278774e79 ("bpf: implement BPF_LWT_ENCAP_IP mode in bpf_lwt_pus=
h_encap")
> Cc: Leon Hwang <leon.huangfu@shopee.com>
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
>  net/core/lwt_bpf.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/net/core/lwt_bpf.c b/net/core/lwt_bpf.c
> index f71ef82a5f3d..65d1dfbf3312 100644
> --- a/net/core/lwt_bpf.c
> +++ b/net/core/lwt_bpf.c
> @@ -599,6 +599,7 @@ static int handle_gso_encap(struct sk_buff *skb, bool=
 ipv4, int encap_len)
>
>  int bpf_lwt_push_ip_encap(struct sk_buff *skb, void *hdr, u32 len, bool =
ingress)
>  {
> +       bool is_udp_tunnel;
>         struct iphdr *iph;
>         bool ipv4;
>         int err;
> @@ -612,10 +613,16 @@ int bpf_lwt_push_ip_encap(struct sk_buff *skb, void=
 *hdr, u32 len, bool ingress)
>                 ipv4 =3D true;
>                 if (unlikely(len < iph->ihl * 4))
>                         return -EINVAL;
> +               is_udp_tunnel =3D iph->protocol =3D=3D IPPROTO_UDP;
> +               if (unlikely(is_udp_tunnel && len < iph->ihl * 4 + sizeof=
(struct udphdr)))
> +                       return -EINVAL;
>         } else if (iph->version =3D=3D 6) {
>                 ipv4 =3D false;
>                 if (unlikely(len < sizeof(struct ipv6hdr)))
>                         return -EINVAL;
> +               is_udp_tunnel =3D ((struct ipv6hdr *)iph)->nexthdr =3D=3D=
 NEXTHDR_UDP;
> +               if (unlikely(is_udp_tunnel && len < sizeof(struct ipv6hdr=
) + sizeof(struct udphdr)))
> +                       return -EINVAL;
>         } else {
>                 return -EINVAL;
>         }
> @@ -637,6 +644,10 @@ int bpf_lwt_push_ip_encap(struct sk_buff *skb, void =
*hdr, u32 len, bool ingress)
>         if (ingress)
>                 skb_postpush_rcsum(skb, iph, len);
>         skb_reset_network_header(skb);

iph might point to freed memory after skb_cow_head(), leading to UAF in iph=
->ihl

This issue is already there in the skb_postpush_rcsum(skb, iph, len) call a=
bove.

> +       if (ipv4 && is_udp_tunnel)
> +               skb_set_transport_header(skb, skb_network_offset(skb) + i=
ph->ihl * 4);
> +       else if (!ipv4 && is_udp_tunnel)
> +               skb_set_transport_header(skb, skb_network_offset(skb) + s=
izeof(struct ipv6hdr));
>         memcpy(skb_network_header(skb), hdr, len);
>         bpf_compute_data_pointers(skb);
>         skb_clear_hash(skb);
> --
> 2.54.0
>
