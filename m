Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.176
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794866778;
	b=L2bZO9fUSgqfRI0TGYlhntNuIz9YrPJaFBfhEGxgOq3Y63Oo95rOAhMtkX5INEgAesIu
	 mh/Onrp8fGAOsfNUQwYCX1q9Mpguh8cmbKyMU+f3Zh10Oe6cVtz3s0w7HX/Mrvn0iaULt
	 0Hqc/72qp6BJQJmG1zbxuZ/hHPjVwKb3a2G44+VPKyN5FvJpLxn792KYlQ6Dpnsn/vO0F
	 DqxE9e2AwaTdv0y2+tswve1zGiCvyqMsmQX6qCErV76M2egiY5OP/AhonSd+lpfIerHyu
	 8I5LK2KZuZhmOPMU1kw8Yw38F4cQowoUKl6P1uEALtHvCKInmEoljQBH9c2vOCNoQGQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794866778;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=vMqdrlWyOAmekXsQEG1itPY1dEWj1QOm8mYmjBsq/aM=;
	b=RoDtcz4KF4HEjiKaLm9HFWNc2SEnz7G5f3OF7h+2IeFSFpCHfVQF8bs7CBTtlv19sgP+
	 UoASwUBq3vhmwoNhnxQf7rV8hdipgASCJJToQFPFjEyEgxBjngYDuOb9TPg1Vm/cSwIk5
	 fTR3aovjVv2eH3PLIq8KiuAswq8+zibxA7APqXuX3Ui3GRPlZTD6GRzie8Qio238QKNYv
	 VGclYvw2Mw0eBIHuVh21taEqAvP9lUyP9LH4Y9faxfzbpxjZ3FN1j+IYLMZL8v4Y2Tfh/
	 fMJxCxdG/xB/lQSeGJnnF6TkUxHUdWIte1OP54cxDfm53E0+GKTFMsQpJhwk0ggAJ9A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=AbgF2ZqY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.176
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29318606A323
	for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 22:06:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 29318606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=AbgF2ZqY
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-8a070781f63so1465670b3a.1
        for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 14:06:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794866777; cv=none;
        d=google.com; s=arc-20260327;
        b=Lxd55gGhkHxC42LktIDNGnqNeg/rXgQLXgXucuQPUJMqUtSV5m3a+/eS+J0xS1gRy2
         V5YsqW9/MVIao8Q/pW0nH1Pz5SagqxX9XbJ2CNFs6TbgElCv/SY7jsisa29X0XweOEB+
         hybQH+b+xKPIRwVRL5PM/ezNrKwgQof0mLFtW7BRYDatuAplSoQpUdkXKPkQOQtxjB5A
         Sw1/gaeZGMs1fS/lwnCtP1AElsMJzreOiWpHzT8q1kQXxvAM2FEl9LQ0DTWv2thn9zvQ
         N1dRKkvK7Uzm5XzrV8I4fbJrsQgMS7R4wSjFGF/s6LeJZuT+8hOFFyIAeq8xkF8ZhaWR
         pZLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vMqdrlWyOAmekXsQEG1itPY1dEWj1QOm8mYmjBsq/aM=;
        fh=hjQN2zKZlUzDfDiL2Z820VUNm8IjtAsHKdNWv41pRQA=;
        b=plf7BXDBxEVG493bpxuWDfS+3uTTHt0DsGfFcDjpbPrDdL116jdUSDw8UyfbWstyPR
         +3hOsVXxn1Z1XvuIPxISeMa4ddLb5KwGmm/jKZPZUI0JI27BXp0fnUzeJq2FGmN4V+wC
         cXR6afFP7MGU6XogNgO3mjYH/v/uZwd5wf2Gg4XveuJTnxjfm5HEpj066278rLx/G0VQ
         swIytQI5gHbe1/QkG/Gv+rg1x5PjHclB0NiA61lDuhwcrTNAAVzcSwHzI10QBYHzzWHV
         leJZpoVMbuGRhxHKGMNddFHc50ouTRGzT2ui+frB496Ku/f2dpjXWX20V8ToVysUu7da
         udig==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1794866777; x=1795471577; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vMqdrlWyOAmekXsQEG1itPY1dEWj1QOm8mYmjBsq/aM=;
        b=AbgF2ZqY1HyslMGUCiQ6uP1x99OLZqVAaM1OrrEO4CH7mo1PNmgSxN1NhAOMMml7hr
         Kr8qpUxep5DYauQZpKDrctjJMaD0lup8nL+WN5Te0X1Xue+6X0iQFWdV1SB7ugAHYnu2
         4VERBbMxZnEKly8N6oAZzau77kTBfePEM5NYE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794866777; x=1795471577;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vMqdrlWyOAmekXsQEG1itPY1dEWj1QOm8mYmjBsq/aM=;
        b=PqQ1W+kgfwFAGck/ijrkZ/c2TauXvNz40jks9mvRWEGqyN8KuporH+OURFD7wBCY+8
         MWCRS8+EBnGvKQH9luCgXXFN4qIhRCyZVT+/c/JBGoAIosqZVBTVECqSa3lOLdqC0qsf
         IK/kqK75UvK748Prs2jjM6DTu+rux2lxM9hhlvxNmdJt7QE3T5djz+DVFywZN4+iopiz
         0S2JmIYrwXEf7S+DBx68hM8tBh+MHs9KKb25KWr2k8wwmS8LyjQvMRbpZ2NxQ2RH3ImS
         3eVCAsVUV+SfrL5/Yhp7fTo/RH99U1Y0KAtIWFFQ63NEi/0EdwFpeCtR4pJ8vA1ztKRk
         sGJQ==
X-Forwarded-Encrypted: i=1; AL+hErFeyvTo16SGqiKvN4RsCriwCxuUq6fcbZK9fT+cA0XqbkZRbEQYSgZ63Hkq1h6gVbHDwMU=@vger.kernel.org
X-Gm-Message-State: APuU4Z+gZ5p9xf8ZR8RfxiYS8KbYEAso03USsEm/wAYcvMsXRpO8lHOY
	R9ae4u1XcLd1ce58bZQqow2HBCHEOUznJYdvyLHHQd/5E4RcNauZ83DIFZcJb5+AxJHYpLsVUnS
	E8VRpdAi8SMCmObDNYhtjDTAmXpM18I69Rx/oVNDN
X-Gm-Gg: AYBFou2Sl+eZilkJ1tHsIh7I2SnG+l2qhRIr0H8Z2mSKbkARQfh9axU6OSFoxzznvha
	SM+MkZXt4jp7rkw+4fvIE3LwzBZRXMWVpQj4LYXOWN/AM+eeNKqgkL7gkwJHVR34hC9ztVh3Gn9
	j5y5x6rR+TgurHEdiXwV79jsYXdAw9mhlZs7iWdL2whiSB4Sb+v75eRv8ZivEqqhpEsGJavdPks
	gTTpLvENufZjRbLkJyKhRZNTIsavFHQW9xM44WFMCe9NBJ32VQpInXMbrG52M7s2mbBo8zFqfJM
	KlW67EzBeuoXOrm6vExe0/m8u0wF8Ag53aYTamgGdY5+DYaAJe+ZxT7cxHyXMGZtgWUIL8fvEHM
	wdVZiSSGMvLAgCnUEGpak3ztgAsih8epZcYdmUm9OBMuXbU0dnwHB+/DxpjDdQ4VD6j7YZfPumu
	uYinLIDR+LdKpYvvg=
X-Received: by 2002:a05:6a00:4ac7:b0:885:e2eb:23b6 with SMTP id
 d2e1a72fcca58-8beb53d9d07mr10583427b3a.11.1794866777097; Mon, 16 Nov 2026
 14:06:17 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CORE-9NOG.v4.r0.20261116135311@mojatatu.com> <CORE-9NOG.v4.r0.20261116135311-4@mojatatu.com>
 <DMWXH28YQDYH.1SI4Y5WQ7EPSR@gmail.com>
In-Reply-To: <DMWXH28YQDYH.1SI4Y5WQ7EPSR@gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 16 Nov 2026 17:06:05 -0500
X-Gm-Features: AclHuK9n7C752nA4wdQHdLQTklh2YsDwp5Gv59-pY4fMu60xseoLBKlaRL5BDRk
Message-ID: <CAM0EoMk10vCoAKZq0P=8A_jed=Z3SudLEUV8uvXO5F=ewNjnGQ@mail.gmail.com>
Subject: Re: [PATCH net-next v4 4/4] bpf: drop the stale dst when redirecting
 to an explicit nexthop
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: netdev@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	bpf@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, 
	Victor Nogueira <victor@mojatatu.com>, Sashiko <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 16, 2026 at 3:46=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Nov 16, 2026 at 11:01 AM Jamal Hadi Salim <jhs@mojatatu.com> wrot=
e:
> > The release goes through skb_dst_drop_keep_metadata(), so encapsulation
> > parameters a route carries are handed over to a metadata dst instead of
> > being lost, and a metadata dst already on the packet is left in place. =
Both
> > wrappers take their existing drop path when that copy cannot be allocat=
ed,
> > so a packet is never sent with the stale route.
>
> Just briefly looked at it. skb_dst_drop_keep_metadata() with kmalloc()
> in the fast path is really no go.
>
> Why not do something like this instead of patches 2, 3 and 4 ?
>
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 946b07a..13f2d57 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -2470,6 +2470,10 @@ static int __bpf_redirect_neigh(struct sk_buff *sk=
b, struct net_device *dev,
>         skb_unset_mac_header(skb);
>         skb_reset_network_header(skb);
>
> +       /* The route is for the old skb->dev. Keep the tunnel key. */
> +       if (skb_valid_dst(skb))
> +               skb_dst_drop(skb);
> +
>         if (skb->protocol =3D=3D htons(ETH_P_IP))
>                 return __bpf_redirect_neigh_v4(skb, dev, nh);
>         else if (skb->protocol =3D=3D htons(ETH_P_IPV6))
> diff --git a/net/netfilter/nft_fwd_netdev.c b/net/netfilter/nft_fwd_netde=
v.c
> index 7447da9..d1ac4eb 100644
> --- a/net/netfilter/nft_fwd_netdev.c
> +++ b/net/netfilter/nft_fwd_netdev.c
> @@ -15,6 +15,7 @@
>  #include <net/netfilter/nf_tables_offload.h>
>  #include <net/netfilter/nf_dup_netdev.h>
>  #include <net/netfilter/nf_recursion.h>
> +#include <net/dst_metadata.h>
>  #include <net/neighbour.h>
>  #include <net/ip.h>
>
> @@ -176,6 +177,9 @@ static void nft_fwd_neigh_eval(const struct nft_expr =
*expr,
>                 }
>         }
>
> +       /* The route is for the old skb->dev. Keep the tunnel template. *=
/
> +       if (skb_valid_dst(skb))
> +               skb_dst_drop(skb);
>         skb->dev =3D dev;
>         skb_clear_tstamp(skb);
>

Agreed on the alloc cost (and i will send v5 to resolve that). Having said =
that:
skb_valid_dst() is  essentially  "a dst is present and it is not
DST_METADATA", so it is true for a route (skb_dst_drop() then releases
that route) and true for keys built with bpf_skb_set_tunnel_key(); for
encap ip/ip6 or encap xfrm template the tunnel template lives in
dst->lwtstate  that wont work (packet reaches the tunnel or xfrm
device with no encapsulation).
For that reason we cant drop 3 and 4. I see the change in 2/4 (I see
1/4 not changing either) .  The change is not that small because it
will have to touch multiple core files (although just small mechanical
surgeries). Summary it will still be 4 patches..

cheers,
jamal

> pw-bot: cr
