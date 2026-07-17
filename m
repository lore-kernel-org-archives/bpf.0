Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED200388E7C
	for <bpf@vger.kernel.org>; Fri, 17 Jul 2026 17:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784309454; cv=pass; b=VicqJXqb+T5D/i5dpa3bujjVvamiccMxOSwPQJHAPzDLHyJpktBImXD1ZO42e0h/mQCxpDjhN8ugeSTLJOBeiC2S2mhPKQG6fUeMudTYsORVbZxZP0oy+ELmexo6tB7FFo5lUcGGzhrbCwf0H53+1V8s9+TYnM0PJ7oPl0kcVBc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784309454; c=relaxed/simple;
	bh=yiPZUFjluz3ZJnoNLM8T+8cr5Tir9k5LbHW+P69ZnLA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Np5XuQUZ7VMyzE9SxJG6R7uP88FtHay5pUeSsqWYmtZMxRz3FHNwn2Ra0E0w87KVUwG9ZCJ7vuYvrBRN88yy6aZgHB/Gn9L69bAazhvFbJWvvyHPzV/hQ2NIh0zrndYPghPwJZfK7rlxOcH+tQPS+5354ap2iw7wsyw1Vx55vWM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=My7CDu48; arc=pass smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="My7CDu48"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5b0115b9e17so4607259e87.0
        for <bpf@vger.kernel.org>; Fri, 17 Jul 2026 10:30:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784309451; cv=none;
        d=google.com; s=arc-20260327;
        b=DooqDjpe5zlBoxkM6ZQwR7gAfBAlk20am7RFT+u5eQNr5gY1sAswFl/vY4MVxNRGbb
         1VvgZHPrQkuRwrow7du/6bdBohpUP9IwVFqpqm4Pc0o0YmT+/0CE1s7+pSQhnRsO6CMR
         EDfk5VmwcpiIymdUe47d+KzyHB+W/Lm08hP8cTAEOfNG9DPKIsigatJ8obzsWCm7KZ+E
         naZU9u5GysCTdMY7oDOrWvf6jvqP0L12acvuYhm6TMw0FNZcNK0/Zsm0Wz0D9yupoQ60
         RbvffqirdRemtxhdi2FczQJm27fpbUVsBFjA/loGw8AbAS5UfAi9xVYRrsJdlk75kF6f
         xXWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=P+g0QqbxrxgqSG+NVRARqXqqiU2n/zAAHbtN/DTtmLo=;
        fh=drPNnWX4baZdfUyi5aeQnQR09pi42FZ1VdwJrK/HIVY=;
        b=okQtFPNRbNO3+MJJ3POObxj3r+13Q5ciJEpn6FUxyAwY3q8CnlcxqEiOCdDH1I8NCK
         i7V2GfMxEub/2jdiqIOdGJZFtVlif60FqDjfU+8MB+3REIuL2Vmbahj3ObqSkiAvuM8a
         6rDUgzTzeutx5gNZePhnv87pBNMLISsuchHcW3yCMN1sWx86CtN2voOre3NSjNKXuMQS
         JMMsvqu3DQrRHMUii+OAe6F9g/B7wprFKYFQDv7HOg777LTCF7P+/PBnLQZB/gDo3uGC
         Cdl6fGboT4ZzaGEPFWFw7rGNFv48aDdxy3qCjdqemUncEjdmTJdO4rZyzmstAwFS7U5u
         GCkQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784309451; x=1784914251; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=P+g0QqbxrxgqSG+NVRARqXqqiU2n/zAAHbtN/DTtmLo=;
        b=My7CDu48Q+KXWyArUEClzcVOt0hYbYXm5Gbr2ai4jiSuTiS0tjoS5GAxoVddUg7+Nj
         W06fefbLpaGglpXw23+ePU0wvuuU8Mh04cVOc12TmFcDYb0oDS2284hj5nlKr6Kx6imT
         4nVt5SxPjtvT2uVw/66XqwSXkSPltX9YGsTSqHWtfred7Pc68+nB9KQkpP02gs9WEE6W
         snHpGhHf+bn3hzp73Egtynv4ArrBqjzGGDwgnU41igqAzZc4R2t/e5kOc+7N3khqeu++
         0nfzcuf4LlwkhPq/dyMv6pg6/7KO6ASc7yxqpQq0KZrUI54dyRfPueH8d17DXUNrnQSt
         pzig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784309451; x=1784914251;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P+g0QqbxrxgqSG+NVRARqXqqiU2n/zAAHbtN/DTtmLo=;
        b=O2SvwvWNbQ4xO8jRXs/EyYBtlDu9LnxNWgKBei96bBIuRGYMhFde++qUzf1UhAG/RE
         JjLUEmw3g9ItEVXTDNEcRH4OY2S1shhPVFlDPWu4MNU1wVYWgHwakb14neRRhgnjuIBj
         WY609nsFpiCa8V4Q9cTLzTqg+tJsx6qDuv+iSD1ZeNi4EgBd/cF2AMaJUxP4a6gXLgu6
         NQMwUEtwx+RcTlvyKr34WICC1SRNAXMSEieuMh9AE00ncCOKNXvpHdoOIjkg7KGW+Jow
         IqpeZvG2NRQJSH3cqBXpiDmtM/yEEOYge4/Q/2fExnIISJKAorSXm5lpYaroJYK8tlUx
         LEig==
X-Forwarded-Encrypted: i=1; AHgh+RqqZV/6ImmzPwjzvKXfg989TdSeIELLpekDJLAB2VkLYINopjNPko6IqX83zy7w4BcHQ6g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+05IEahqUA1xHNjc30JF0IosmB2vVhm+mpBpNTrR3nMwgwD5L
	C8+k07Zh5XWMXQCAI1w9SXcfTHQSJeDKu41Xl0rXDR6clNTmJ2hv3lLTvI2DOHCJz/Geaahl2La
	Gyi0bbmK6KCiFhuc4vGEpQ4TcovBB+0M=
X-Gm-Gg: AfdE7clkB7HFbWDNT+2vqvpz17Ub/TCz/u72TCxIKuABXTQMfUYD0ZK/gfq9QwV68cM
	k5Gk05z+iDWYzxfPcX4g2p/jxO8Xu4NpK+NmWiVF0WSWd1yBYUXCUiwJpr67AiWMPPAK58QPCsX
	dlIgPOAy9kN4CPAkrNO4L8BeEwl98O2glF5P9oYSl3F0CaFtp6LZlYOidWeVYCb3oFGpo/MDtFR
	7OAMMJzj0L/2vMHQnOScKnERNQXbZAuFvnHF7fyZA8WbSfKeNGmhI1JPJmOPbu5bn9qmxiOdBSY
	SYJkVRPOQPZSEBckZI5mg19NNxDbWunVyqsrqsBxojwuJlSX7rzGnGVEstq6mgdBsrDtj23i/w=
	=
X-Received: by 2002:a05:6512:2349:b0:5b0:1852:934c with SMTP id
 2adb3069b0e04-5b28f873139mr835411e87.9.1784309450650; Fri, 17 Jul 2026
 10:30:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260714-bpf-meta-inside-skb-ext-v1-0-5871c07a8dd6@cloudflare.com>
 <20260714-bpf-meta-inside-skb-ext-v1-3-5871c07a8dd6@cloudflare.com>
 <aljKKt6nCB3fjFVA@devvm7509.cco0.facebook.com> <87a4rrjdj4.fsf@cloudflare.com>
 <CAL+tcoB4fwO5WxAcnW3QRErSQCnMBVMh6mfhFfG_dZhL+=MA6Q@mail.gmail.com>
In-Reply-To: <CAL+tcoB4fwO5WxAcnW3QRErSQCnMBVMh6mfhFfG_dZhL+=MA6Q@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 17 Jul 2026 19:30:12 +0200
X-Gm-Features: AUfX_mwmLqyTeuL8QrfW83_HRes5nTH1cciZFeLKrMlpdGOZNmHk26V5s3aD_-Y
Message-ID: <CAL+tcoBPv2_yMZrrvgNT7kkL9tCmAfUZmsr7+0qYukRmYJb6gQ@mail.gmail.com>
Subject: Re: [PATCH RFC net-next 3/6] bpf: Allow skb extensions to survive
 packet scrubbing
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: Stanislav Fomichev <sdf.kernel@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	kernel-team@cloudflare.com, Jakub Kicinski <kuba@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 16, 2026 at 5:06=E2=80=AFPM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> On Thu, Jul 16, 2026 at 3:00=E2=80=AFPM Jakub Sitnicki <jakub@cloudflare.=
com> wrote:
> >
> > On Thu, Jul 16, 2026 at 05:11 AM -07, Stanislav Fomichev wrote:
> > > On 07/14, Jakub Sitnicki wrote:
> > >> skb_scrub_packet() drops all skb extensions unconditionally via
> > >> skb_ext_reset(). It runs on tunnel encap/decap (ip_tunnel_rcv,
> > >> vxlan_rcv, etc.) and cross-netns forwarding (dev_forward_skb).
> > >>
> > >> This makes it impossible for a BPF program to pass metadata via
> > >> bpf_skb_ext through a tunnel or across a netns boundary. The extensi=
on
> > >> is always lost at the scrub point.
> > >>
> > >> Introduce skb_ext_scrub() which consults each active extension befor=
e
> > >> discarding it. Extensions that request preservation are kept while t=
he
> > >> rest are torn down. When the extension slab is shared with clones, C=
OW
> > >> ensures isolation. Replace the skb_ext_reset() call in
> > >> skb_scrub_packet() with skb_ext_scrub().
> > >>
> > >> Expose the opt-in mechanism to BPF via the BPF_SKB_EXT_F_NO_SCRUB fl=
ag
> > >> for bpf_dynptr_from_skb_ext(). A program that sets this flag when
> > >> creating the extension signals that its metadata should survive
> > >> scrubbing.
> > >>
> > >> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
> > >> ---
> > >>  include/linux/bpf.h      |  1 +
> > >>  include/linux/skbuff.h   |  2 ++
> > >>  include/uapi/linux/bpf.h |  3 +-
> > >>  net/core/filter.c        | 11 +++++--
> > >>  net/core/skbuff.c        | 82 +++++++++++++++++++++++++++++++++++++=
+++++------
> > >>  net/ipv4/udp.c           |  2 +-
> > >>  6 files changed, 86 insertions(+), 15 deletions(-)
> > >>
> > >> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > >> index 6b918a5b61bf..a46ca53c5b27 100644
> > >> --- a/include/linux/bpf.h
> > >> +++ b/include/linux/bpf.h
> > >> @@ -4214,6 +4214,7 @@ static inline int bpf_map_check_op_flags(struc=
t bpf_map *map, u64 flags, u64 all
> > >>  #ifdef CONFIG_BPF_SKB_EXT
> > >>
> > >>  struct bpf_skb_ext {
> > >> +    u64 flags;
> > >>      u8 buf[CONFIG_BPF_SKB_EXT_SIZE] __aligned(8);
> > >>  };
> > >>
> > >> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> > >> index 584d8440d352..66afa5489007 100644
> > >> --- a/include/linux/skbuff.h
> > >> +++ b/include/linux/skbuff.h
> > >> @@ -5063,6 +5063,7 @@ void *__skb_ext_set(struct sk_buff *skb, enum =
skb_ext_id id,
> > >>  void *skb_ext_add(struct sk_buff *skb, enum skb_ext_id id);
> > >>  void __skb_ext_del(struct sk_buff *skb, enum skb_ext_id id);
> > >>  void __skb_ext_put(struct skb_ext *ext);
> > >> +void skb_ext_scrub(struct sk_buff *skb);
> > >>
> > >>  static inline void skb_ext_put(struct sk_buff *skb)
> > >>  {
> > >> @@ -5132,6 +5133,7 @@ static inline bool skb_has_extensions(struct s=
k_buff *skb)
> > >>  static inline void __skb_ext_put(struct skb_ext *ext) {}
> > >>  static inline void skb_ext_put(struct sk_buff *skb) {}
> > >>  static inline void skb_ext_reset(struct sk_buff *skb) {}
> > >> +static inline void skb_ext_scrub(struct sk_buff *skb) {}
> > >>  static inline void skb_ext_del(struct sk_buff *skb, int unused) {}
> > >>  static inline void __skb_ext_copy(struct sk_buff *d, const struct s=
k_buff *s) {}
> > >>  static inline void skb_ext_copy(struct sk_buff *dst, const struct s=
k_buff *s) {}
> > >> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > >> index 3eee4467422d..02da170205de 100644
> > >> --- a/include/uapi/linux/bpf.h
> > >> +++ b/include/uapi/linux/bpf.h
> > >> @@ -7734,7 +7734,8 @@ struct bpf_insn_array_value {
> > >>
> > >>  /* Flags to control bpf_dynptr_from_skb_ext() behavior. */
> > >>  enum {
> > >> -    BPF_SKB_EXT_F_CREATE =3D (1ULL << 0),
> > >> +    BPF_SKB_EXT_F_CREATE    =3D (1ULL << 0),
> > >> +    BPF_SKB_EXT_F_NO_SCRUB  =3D (1ULL << 1),
> > >
> > > Do I understand correctly that you do prefer the NO_SCRUB mode? Any r=
eason
> > > we need to have scrub mode? If it's all produced/consumed by bpf, may=
be
> > > we can just carry this data unconditionally instead of having a SCRUB=
/NO_SCRUB
> > > option?

After giving it more thought, I vote for only no_scrub mode because I
don't see any reason why we still use scrub mode. But it's just my
opinion.

My question is if we in the future really need the scrub mode, it's
still possible to add this option, right?

Thanks,
Jason

> >
> > Yes, that's correct. We definitely need NO_SCRUB but I don't have a use
> > case that relies on metadata scrubbing. I believe Kuniyuki also would
> > like the no-scrub to be the only/default behavior for Google's egress
> > use case.
> >
> > I've made it an opt-out mostly because that the existing metadata
> > (skb->mark, skb->data_meta) gets scrubbed. Although as Jakub K has
> > pointed out to me - you can circumvent it by using bpf_redirect into th=
e
> > target netns. So I guess we have a precendent?
> >
> > I could use input from folks operating in K8S-like environments, if
>
> Sorry, I don't quite follow it here. Why don't we need the NO_SCRUB
> here? The crucial point here is to allow skb traverse across different
> containers, which is also what I expect. We do need to support this
> case to make this feature standalone, which means it is independent
> and not affected by other components.
>
> And one part of what I'm doing for BPF timestamping v2 is to address
> the issue in the container scenario as well, FYI.
>
> Thanks,
> Jason
>
> > no-scrub-only mode would be acceptable there? Daniel, John, any opinion=
?
> >
> >
