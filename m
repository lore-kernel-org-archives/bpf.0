Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.173
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793924823;
	b=MVWdBRYYpIlHZGeFzMyN5N4zpTTIw46aWXrKV0vR5ZAu5jcMa8PBCYJd6Kt9/JKM/O0T
	 Ao8Q6h52aVGiP5QTvxr6bIsGD7cm634hkqhZ+K4R+oNqAwTvhMacOEjNqHH5VULQpjxYV
	 MmmULX6vPHs8Tn8lcARw+uc+VnUKV1uyttv8TuZ38onDAarBTeji35nxw2UAw6IXA58SU
	 4MxiK8O1Y6qcma9OJfH+yU8aEvMztg/ZXFPKa6b5CTXR1xy9Yk39vkjs2TUEx84kuS+Uo
	 OvkQEkew6u+YghDP0217WlinE4/XmD76Mqfjt60L6C3gkpI7Ohrj5v7L6zSvsz9Wasw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793924823;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=q0hyvU+ucajnUy7w/QIwVHHHP6trSeKQe02htFHCQbE=;
	b=UV6akhdR2Dq0r3HtZASnk4eFeSbBPaxljqyb0Nt13FSbktQ4YDv9+nefSsropLu8Zcg1
	 Iw+UtHnEUzWfgXa6mTs67Z44nkWaICC6XQxcTJGnKBR2lSHkNr522iNz4asukT7p3Pabb
	 FeAuJTiknv2+vyStMYf/NDZ0jcDUrs0CBb3EAQtWmWswm2xlP2yZ2jHKXPRfWoXBTqc6G
	 g0/BOzBYTyDUX+I/jEga25h2egdGf260w5Wxr0VWmuxaX1RcY5XE+g96QG1U9eX32tVgp
	 iTsrvALDCm3/G5eHxTmn3K5jk75y9bwlXkZmuGdyn1LoDzL45prkrBcEDKFQ7dyhdHA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=OR3sP8id;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.173
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E27606A329
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 00:27:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 57E27606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=OR3sP8id
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-54492d8a988so5731cf.0
        for <bpf@vger.kernel.org>; Thu, 05 Nov 2026 16:27:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793924822; cv=none;
        d=google.com; s=arc-20260327;
        b=e/C/Xdf+/BCN2ld3a6o+Rzzmx1verSu8QzYWZjZvEHEj5eDJEyLp0UjSQxcUEqvMpj
         faIHheypBTimIvp6E9skFaOvrDc68i/AIvk2Ul0osBhe6NR9Z+XZJ/jjWogxLjEYAXtu
         WTqd9Sl995rj59PjqVLVAZEEAJ7nJLns/S22vSqPIlpbzoNQhh44qdFLDw/9OKVShBzS
         4YyjZyoxnJiZaQZI0Cbl0VN6RqIRfrbdX99cppP1L+Ws8NdIT/0DFkTU3rs4Yxr6MEYY
         xlgTEg2gFnoHjQ4inyzKLNFItZzUeu8fXLeAjxv7qfTEGoKy/KKzIEMkTd61xEp1TpY8
         /Lvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=q0hyvU+ucajnUy7w/QIwVHHHP6trSeKQe02htFHCQbE=;
        fh=Ik2zo3hyGIzKH7EQWEvgFEALFaG7RviRg/Hs5vihNr8=;
        b=Qa8IQNABmF3bFAObyf3mrxhHNUcqmoKF+6DdW9Jtd14MvyKdNRays9HkmCkgfywDU0
         oNhwGjg35yFfZDWfu6A2iCgD2qX6UaNA4orI+KW/X+lFyu4RrG5xtrFrJVxKsAd61Rqi
         nK9ftZmZ6hMOtB4PGUdL4qOXWu3Kh9AnEw0AtXVVVFWQ2q39fFvo8wCjD+X4CnnKD5PE
         ff0Suf4JweeTLx2FOFKUxBMknkc2QqMU3GVq8aP+eJhrPdmHPanIUicjapEHHJGFg+PH
         UF2F986nKeu61yqLl00tSKLGYSVjaG7DpIAC/c3o0+yXRK0SE0nhS8VudgC9otzZGi1U
         Gwlg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793924822; x=1794529622; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=q0hyvU+ucajnUy7w/QIwVHHHP6trSeKQe02htFHCQbE=;
        b=OR3sP8idCd8lFUwObgHP+VoQLI2+GkZfdoC5R3Lts44EKxKYVtT0Cr+35JH1bp3CwN
         BtFmUm7qNizvngsg1eH2rzSzvjrVqUfH0amDOFKV8cL39dERSLelT5MNEYA21oCikqgH
         gVDndYYv51i0S33sBB89IZM76e5UdJvtwjA+uuVqrzO8rmC2b8LLnVTSPuCrRWnBmLde
         /Xw9xlvEw5VcCzVgQxS+4FnO2RVKk7lZKjkBexwXNYP9971NFZOcjmAIoFJyEBR8C3vO
         dTPVSxa9F9c15TSmKpv1SPbBG7MUbtQ3Y+ZH/0cfOHE8Ad3xbLAOkwa5VBehntKIhw0E
         xXjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793924822; x=1794529622;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=q0hyvU+ucajnUy7w/QIwVHHHP6trSeKQe02htFHCQbE=;
        b=URMlmsilVQYrobLj83ZpJeH08zQufm0v9cOgAGRWIg+PasgQdxicnR5t6wi6uVsU5s
         ug/7Vkj/oM8ClQeBgCxMQ2gSUL0mHCnHzKKy0me+BzdN5l9YYcf4Ul6LQGarMmiwU9X5
         4sFHINx9cvojKbJkgu+bohe2YVczd90KgCG/wgE6rQsroPowF78ZNvJxZQuFTIPs1vT+
         3Jp5mytv3rwOk58XI1zZQjSM3So3KMjZ53FmBOYSrwOd/prpsIRFXuCVe9wpvUgbo4TK
         sXNuA4GefTn6Alr2Y/O0EhXsAUpY4TsKH0VNFSVsCVuKmV0XY9wPP0dbFV+L/480Jex/
         eMmQ==
X-Forwarded-Encrypted: i=1; AKwUvBw89kD80o5ybICau/AWrYvu90UZc+CGqSmYpHkyZhbkAFS4LYV3XtKr/ZdHYcr0ytQ0Zg8=@vger.kernel.org
X-Gm-Message-State: APuU4Z+oOnVLawdsqwX+x3K33mniX445rMLt3thTlJ0t8LY61jH1Eupp
	SOjoeXh7CnenCZ69E7fmVKQcXL/liRmUGbstcO8mHGephR1QN9LqDSJkyLijSsY+TfueifVgr/c
	yBA9UmOFfZrxiFtuNDd29AJGGPYO3zxNxJam+nWJZ
X-Gm-Gg: AYBFou3Gogt4U9i2in90GoR1ItFDQVGEcnYGRbK+PvQzUJ09/54knzgaumuiplOD1b/
	1xn9mDlfLie2WHZgl10JHCKFMG/SNidvaxNdeU0Jg/bDjpZ5N3nMH5opV31Ds20XDGVBSjGf/BH
	3ABCJ6jI+GNUxNM7X34ayXEWztq5tYWu5/K1zIRyYhWWqF41rg7pEJZITOWuHVxDGTPo7dcrhzj
	6LZh1w3o650e8GBwF/amLEZRBZ2ORWs8cCahOpWPlRQt7NJr9Z+oABPsWYy1jBTv9TwUhXCO5xN
	Z1AUqXSDjV905ZDdKwTJenn2DaRqqvLFkyTrLmjlNGMu0/+JD0JBZ/qSeOyErReBY/HAtjOUQrD
	dNO8zJq763clFMCRXSrFaVkQrkwn6dVWE51ur
X-Received: by 2002:a05:622a:1246:b0:536:353e:8d2a with SMTP id
 d75a77b69052e-54e18330dcdmr8567761cf.1.1793924821140; Thu, 05 Nov 2026
 16:27:01 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261030043145.2185700-1-weiwan@google.com> <20261030043145.2185700-2-weiwan@google.com>
 <DMNC538FF7AS.2JZQJXNEZG6P6@gmail.com>
In-Reply-To: <DMNC538FF7AS.2JZQJXNEZG6P6@gmail.com>
From: Wei Wang <weiwan@google.com>
Date: Thu, 5 Nov 2026 16:26:50 -0800
X-Gm-Features: AclHuK-ILsDSgY5YgNMpnZ8hmoNqhj7qLVOd_4uN32yLwqUvq0acaga0lCDJnaI
Message-ID: <CAEA6p_CuU1o25nXzd71C7chjj5xRS=qtNhP-ypwzV9H90MSy=Q@mail.gmail.com>
Subject: Re: [PATCH net v2 1/2] net: Make PSP skb extension survive packet scrubbing
To: Daniel Zahka <daniel.zahka@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>, 
	Simon Horman <horms@kernel.org>, Jakub Sitnicki <jakub@cloudflare.com>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 5, 2026 at 6:09=E2=80=AFAM Daniel Zahka <daniel.zahka@gmail.com=
> wrote:
>
> On Fri Oct 30, 2026 at 12:31 AM EDT, Wei Wang wrote:
> > skb_scrub_packet() drops all skb extensions unconditionally via
> > skb_ext_reset(). It runs on tunnel encap/decap (ip_tunnel_rcv, vxlan_rc=
v,
> > etc.) and virtual device forwarding/redirection (dev_forward_skb,
> > netkit_xmit, skb_do_redirect).
> >
> > When a virtual device such as netkit is associated with a PSP device in
> > another network namespace via PSP_CMD_DEV_ASSOC, incoming PSP packets
> > decapsulated by psp_dev_rcv() lose their SKB_EXT_PSP extension when
> > scrubbed during redirection into the peer netns. Without SKB_EXT_PSP,
> > __psp_sk_rx_policy_check() rejects incoming TCP data segments at the
> > socket layer with SKB_DROP_REASON_PSP_INPUT.
> >
> > Introduce a static skb_ext_scrub() helper in net/core/skbuff.c to
> > preserve SKB_EXT_PSP across skb_scrub_packet() while dropping all other
> > extensions. If SKB_EXT_PSP is not active, skb_ext_scrub() simply calls
> > skb_ext_reset(). If SKB_EXT_PSP is the only extension in the skb_ext
> > buffer, nothing needs to be scrubbed. Otherwise, save the PSP metadata,
> > reset the extension block, and re-add a fresh SKB_EXT_PSP extension (or
> > clear skb->decrypted if the allocation fails).
> >
> > Fixes: 06c2dce2d0f6 ("psp: add new netlink cmd for dev-assoc and dev-di=
sassoc")
> > Link: https://lore.kernel.org/r/20260910-bpf-meta-inside-skb-ext-v2-3-0=
b21e42180b0@cloudflare.com
> > Reported-by: Daniel Zahka <daniel.zahka@gmail.com>
> > Closes: https://lore.kernel.org/netdev/DLODSKPY6ON6.1G6SP3CFFLCPJ@gmail=
.com/
> > Co-developed-by: Jakub Sitnicki <jakub@cloudflare.com>
> > Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
> > Signed-off-by: Wei Wang <weiwan@google.com>
> > ---
> >  net/core/skbuff.c | 31 +++++++++++++++++++++++++++++--
> >  1 file changed, 29 insertions(+), 2 deletions(-)
> >
> > diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> > index 93c2f440b9ec..5c4a2e982ebc 100644
> > --- a/net/core/skbuff.c
> > +++ b/net/core/skbuff.c
> > @@ -6369,6 +6369,32 @@ bool skb_try_coalesce(struct sk_buff *to, struct=
 sk_buff *from,
> >  }
> >  EXPORT_SYMBOL(skb_try_coalesce);
> >
> > +static void skb_ext_scrub(struct sk_buff *skb)
> > +{
> > +#if IS_ENABLED(CONFIG_INET_PSP)
> > +     struct psp_skb_ext *pse =3D skb_ext_find(skb, SKB_EXT_PSP);
> > +
> > +     if (pse) {
> > +             struct skb_ext *ext =3D skb->extensions;
> > +             struct psp_skb_ext tmp =3D *pse;
>
> I would move the copy just before skb_ext_reset(skb), but it probably
> won't make a difference in the generated code.
>
> > +
> > +             /* Nothing else to scrub if PSP is the only extension in =
ext. */
> > +             if (ext->chunks =3D=3D SKB_EXT_CHUNKSIZEOF(*ext) +
> > +                                skb_ext_type_len[SKB_EXT_PSP])
> > +                     return;
> > +
> > +             skb_ext_reset(skb);
> > +             pse =3D skb_ext_add(skb, SKB_EXT_PSP);
> > +             if (pse)
> > +                     memcpy(pse, &tmp, sizeof(*pse));
> > +             else
> > +                     skb->decrypted =3D 0;
>
> Agree with sashiko not to clear decrypted. It would at least prevent the
> skb from being forwarded cleartext back onto the network.
>

Yea, makes sense. Removing this in the next version.

> > +             return;
> > +     }
> > +#endif
> > +     skb_ext_reset(skb);
> > +}
> > +
> >  /**
> >   * skb_scrub_packet - scrub an skb
> >   *
> > @@ -6380,7 +6406,8 @@ EXPORT_SYMBOL(skb_try_coalesce);
> >   * operations.
> >   * skb_scrub_packet can also be used to clean a skb before injecting i=
t in
> >   * another namespace (@xnet =3D=3D true). We have to clear all informa=
tion in the
> > - * skb that could impact namespace isolation.
> > + * skb that could impact namespace isolation. Note that PSP skb extens=
ion is
> > + * preserved across packet scrubbing by design.
> >   */
> >  void skb_scrub_packet(struct sk_buff *skb, bool xnet)
> >  {
> > @@ -6388,7 +6415,7 @@ void skb_scrub_packet(struct sk_buff *skb, bool x=
net)
> >       skb->skb_iif =3D 0;
> >       skb->ignore_df =3D 0;
> >       skb_dst_drop(skb);
> > -     skb_ext_reset(skb);
> > +     skb_ext_scrub(skb);
> >       nf_reset_ct(skb);
> >       nf_reset_trace(skb);
> >
>
> The only thing I would say is that skb_ext_scrub() won't scale if a
> second extension comes along and wants the same treatment as PSP. In
> that case, either we could make a bitmap of "no scrub" extensions and
> then use the same approach of allocating a new ext block and copying
> them over, or the original approach of skb_ext_del() could be used after
> changing the reference counting scheme for the special extensions in the
> release path of __skb_ext_put(), but that is a more intrusive change.
>
> I'm ok with the approach from a PSP perspective:

ACK.


>
> Reviewed-by: Daniel Zahka <daniel.zahka@gmail.com>
