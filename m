Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.170
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794830617;
	b=rWfRW/H2cZ+gFL+wuZpcjDhf2oCwv9MyIo57CHGdb3LIciAh7ig9BbN0JhXod2QS6SWJ
	 1yB0CKZO7+xfEkD0NQGDRttVZqP4w2PqzhiohPMN1vJtR1pJSX4ADFIHg2R7KrIOnhcxE
	 5CQOWysKdtPniOtT/lKqB5xCa0tNXf0ICBzgy/IckGlXRF9mOJdF3PxxqmMKeDg9DQlmn
	 lVvU26Ti7kjJxifCVVTDCqaFAAVSSdWo8FR4UJTSj7W0Uv4UI5/O81PpyHS7bS3F8a6LO
	 xwrN6xFN6SN3ENdQfdpqLnh06X7Pxi0NQu3CneI1vKGbtjXXcY1vAGzvcKUs4i9v6MQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794830617;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=WiA9mgxsVKJJE+AKOVKJEbQPnJuFJZeJObt4tmh0PaQ=;
	b=XmyP+12SYSijgwyJydy13XsHOnCETtpjHbSfmeTHi5ISFUpatqi7FwHTsa6yio6d5kBe
	 iA3aS6scv/k4Gknnr92kLVQBkPrPSbzydvGTIPlevivUbEZTX0lrDnXDcQ6CngEDP0jV3
	 bXWWyC7xKdLeniJvNuvgID014/vGET1FY56anVvgbEazxiux53aZ2YFsyPrkllHlQxR5m
	 M+g6jOET8T4lAh/zdH/nHt+ImS077lxH44DowWeuP3k1RkAUgQFjuFUt1JWfGgfRj/yhm
	 viBv0YI5+Ecv/fEB5a4RfGezjCj24TZbZB2E/0ivMpFLo0hMEsAplxDsIAtAvpIebjA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=xEDmxJz1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.170
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ECC4606A32A
	for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 12:03:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9ECC4606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=xEDmxJz1
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8b3577deeb0so1578749b3a.3
        for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 04:03:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794830616; cv=none;
        d=google.com; s=arc-20260327;
        b=paJ3i4Y39zD8SxEp0LB/1wn/DhFC1l4ftNAAvaiZPC2I7R4sAtQYJFOCUjRM4VfClE
         Hdk9EyMp0rOnSxkZw7Ntj4O9KugXOkNHY6rPXdGBj31wSyOz5k8/+SQbe4I4aNtvP/K+
         hNPGmkUiofaewjALHPQiBdR96Ba2bkNpd6BGElfUj06WvAxrhQqqt1ktEevdkKbbGuY/
         48u3rY+cDkdiG0qBKWJhJ/R6zBuZNUQMcG3j1onqkIDHKo3dJuVH1UJo/MGWA2gsvlbb
         a96fXGMJCRkIB/PQVLu4JDPcRTfUiLgfKPKxJwwkRMo15y+/UNP2JdmCrPC+IoaxDv/U
         znQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WiA9mgxsVKJJE+AKOVKJEbQPnJuFJZeJObt4tmh0PaQ=;
        fh=uA360uvxR9S0K/Y4Lovo7aIaGlBwzVBnnb2BKWupr/4=;
        b=PLVATf6OARWjGqbvKlo/ioWmP4S4uFWLJdMxTEp7yDJKT8iPS3598uuo5fwMOTQDa5
         hC+gioDPbApYp7hI/BgmqnRpZw+ltTULKkse49esbXOkk2nUosz1Jnx19Q0p0D+4FkiX
         ASabyizUuJiOZg3/CWStX+mdPI7AfHXzDGu63ty4mgURphh5HUMVStO+uwONlTW88aVa
         8ke3L73cikP4mYV9lZijyycZCiWwdrjlJ8QHCS3BLiPwNtId0AVKsGn7qlEcb3X4rCjo
         LnrBAwpLEJQG/x+3+hzMv1tEQqfK851x0/cfp/LZzUDJ5XzxnW73+akY0VsfCObKvyYJ
         LFXg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1794830616; x=1795435416; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WiA9mgxsVKJJE+AKOVKJEbQPnJuFJZeJObt4tmh0PaQ=;
        b=xEDmxJz1WptnYklacxdsDVGU+nJrM45hmKZFE3bjHLAT5ooTisElmkiiUmAAL5audR
         Vec0SHsEo3Sd7vMNX/APp5RNj0qos31OuZQhp6Rrs+Vp0DhUKJw0PFJvx2sjWjhk+H+5
         NxZR8skDkVEk9m8DIHeYmZxX/9pPNRoz5IahA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794830616; x=1795435416;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WiA9mgxsVKJJE+AKOVKJEbQPnJuFJZeJObt4tmh0PaQ=;
        b=f0OwLu5uWjNs8HrEKCKgc7fKXGGmbtABj+GgiYP+fQX+E8EFbQkYbvBdPMKzqShrhW
         pMW/vvKy+37wflhE/pCYBpLFRGeEpErbwtwIdL2JOzOhDvhaicy2dU8ILBYM5MNJwn4X
         8lUfXOue5s+uLy7hUZwzPV3lEkaF/2bHwe+0u/q9zTK9NiDgfvqF1xsxApKJK8wjnumn
         5SqGR4bjkKvudJ076yRep9sehE5dP/Sk1QNDlxhy8nezDHRwE0jWA16H144krMqVSe+t
         nFYn7QDIgLdLDl/Rx2uD7FhFdLJ5egl6GXDUxlgYVcN3tNss1EIlqfhp0e5VlTJuT73m
         J4yA==
X-Gm-Message-State: APuU4Z/959ahdeLJ7yFtLlJFDF4qXAcfMgJeAmg8u4DpZuKjZxzrBAKH
	leCgQP3vTL6d3lJHEfrOXnfIrNiPutzf0fXJGwHRfYgW+sCQ2dUQSRHT371bWgCnuxj3ghNzEn2
	jzsJhRF8rr1LuWtxa9cB84x+VbPt6mPGKW8v+n1PD+RwOVOUiYrk=
X-Gm-Gg: AYBFou3nfG/VEo5nNF13XxrtEQf4SixS0gDtPMULkIZuD3hYpfJHIGs7iqi54TiBjUo
	BwL4gOu+GQrVewLbw7W4TAVA2n4bzCmno9apxiQIq54FpytWRR//hRrzx93vtG8OJGiOVS/c9US
	Zjxqd8CUeYDhbQ84Cp/QR2YgCeDRcjt28u8JxTxfinf6Xu5t8fyoc4KGP49DwkdL6y1lkIL8gGn
	0koYrPZ8fo+QgytXGSc3Mg1rdZkx+NhbsYh/OywuQfx1075KZmoJy8fZIPF16FfeUALeMJ8jQeY
	0Wm7wjjdV174iPjjIXZ66gkzwdtOBUS2xtJ9EuMatBjJvnUWQugGVV/o8oRYeNYGAx0EvecSE78
	0+M3dX+I7REJHaH5EghEwk4e088M4GolBJ+LhQ7UdtHFJujIrmc5G/t3ZhBIxPu0b/ZfCS8ebZA
	xiHvdfyCJqyeehkWE=
X-Received: by 2002:a05:6a00:995:b0:89a:5:92c1 with SMTP id
 d2e1a72fcca58-8beb772bd38mr9332011b3a.56.1794830615662; Mon, 16 Nov 2026
 04:03:35 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CORE-9NOG.v3.r0.20261115050625@mojatatu.com> <CORE-9NOG.v3.r0.20261115050625-1@mojatatu.com>
 <sashiko-outbox-216710@kernel.org>
In-Reply-To: <sashiko-outbox-216710@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 16 Nov 2026 07:03:23 -0500
X-Gm-Features: AclHuK-I44M3b7jIQkev6qAYIWNeFTMf2zzj3IKpSjGp9BFft7gh55IgmHG7xkk
Message-ID: <CAM0EoMn0Hq9xZS=zOm5-Bj-y6jkLbtLKsxxOAKnFhAWK8SJLfQ@mail.gmail.com>
Subject: Re: [PATCH net-next v3 1/4] net: xfrm: interface: restore dst_orig on
 every xfrm interface
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 16, 2026 at 5:19=E2=80=AFAM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Low] xfrm: interface: missing Fixes trailer in bug-fix commit message


Remember this for the future: net-next patches do not carry Fixes trailers.
This is a net next patch. Just because i use the terms "bug" and "The
Fix" doesnt qualify i put a fixes patch.

cheers,
jamal

> --
>
> commit fc50a8a0e09367a243cf350a9e4dc409fd76b617
> Author: Jamal Hadi Salim <jhs@mojatatu.com>
>
> > net: xfrm: interface: restore dst_orig on every xfrm interface
> >
> > Found while testing the dst release for the two producers that steer a
> > packet to another device, fixed later in this series. One of the consum=
ers
> > of the metadata such a release installs is an xfrm interface, which
> > restores the original route before the xfrm lookup; the swap warned on =
the
> > metadata dst still installed in the skb, and only the collect_md arm
> > restored the route at all.
> >
> > The issue:
> > An xfrm interface takes the if_id and the underlying device either from=
 its
> > configuration or, in collect_md mode, from the xfrm metadata on the skb=
.
> > When that metadata also carries the route the packet arrived through,
> > xfrmi_xmit2() puts the route back on the skb, because the xfrm lookup t=
akes
> > the address family from it. skb_dst_set() expects the dst slot to be em=
pty
> > for a reference counted dst and warns when it is not, so the route land=
ed
> > over a metadata dst that was still there; a kernel built with
> > CONFIG_DEBUG_NET=3Dy panics on the first packet that takes this path wh=
en
> > panic_on_warn is set.
> >
> > Two more defects sit in the same place. An interface with a configured
> > if_id never restores the route: it takes the metadata dst as it is, who=
se
> > address family is AF_UNSPEC, so the lookup finds no policy and the pack=
et
> > is dropped as a link failure instead of being transformed. And the rest=
ore
> > moved the route out of the metadata dst, which a clone of the skb share=
s,
> > so the clone that reached the interface first left the original packet =
with
> > nothing to restore.
> >
> > The same slot overwrite is in the unstable helper a tc-bpf program uses=
 to
> > attach that metadata: bpf_skb_set_xfrm_info() records the route as dst_=
orig
> > and installs a per-cpu metadata dst over it. The per-cpu dst is shared =
by
> > every invocation of the program, so the restore cannot keep anything in=
 it.
> >
> > The Fix:
> > Restore dst_orig in both arms of xfrmi_xmit2(), taking a reference with
> > dst_clone() so the metadata dst keeps its own, and empty the counted sl=
ot
> > with skb_dst_drop() before the route is installed. The helper allocates=
 a
> > metadata dst per skb instead of a per-cpu one, so the route it records
> > belongs to that skb and is released with it; the per-cpu allocation is =
no
> > longer used and goes away.
> >
> > Conditions to recreate the bug:
> > A tc-bpf program that records the route as dst_orig with
> > bpf_skb_set_xfrm_info() and redirects the packet to an xfrm interface i=
s
> > the shortest way to hit the overwrite. A netdev egress fwd rule that st=
eers
> > a packet routed with an xfrm encapsulation into an interface reaches th=
e
> > same place once the dst release earlier in this series keeps the route:
> >
> >     ip link add xf0 type xfrm if_id 42
> >     ip link set xf0 up
> >     ip neigh replace 10.20.0.1 lladdr 02:aa:00:00:00:ab \
> >             dev va nud permanent
> >     ip route add 10.20.0.1/32 dev va encap xfrm if_id 42
> >     nft add rule netdev t c fwd ip to 10.1.0.2 device xf0
> >
> > Send one packet to 10.20.0.1. With CONFIG_DEBUG_NET=3Dy and panic_on_wa=
rn=3D1
> > the kernel panics in xfrmi_xmit() with the metadata dst still installed
> > while the route is put back. The interface with the configured if_id dr=
ops
> > the packet as a link failure without consulting the outbound policy, an=
d a
> > clone made after the metadata was attached consumes the route before th=
e
> > original packet arrives.
> >
> > Reviewed-by: Victor Nogueira <victor@mojatatu.com>
> > Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
>
> [Severity: Low]
> This fixes runtime defects in bpf_skb_set_xfrm_info() and xfrmi_xmit2().
> Should the commit message include a Fixes tag:
>
>   Fixes: 94151f5aa966 ("xfrm: interface: Add unstable helpers for setting=
/getting XFRM metadata from TC-BPF")
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/CORE-9NOG.v3.r0.2=
0261115050625@mojatatu.com?part=3D1
