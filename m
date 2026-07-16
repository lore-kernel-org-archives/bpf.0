Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62EC242467B
	for <bpf@vger.kernel.org>; Thu, 16 Jul 2026 15:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784214443; cv=pass; b=euYw/NoNmTmZaBGJXKwyrOpdNGcCR4wobSrVt8oVvE6Alx5p5ZpxoVZ4E4yR5Fh64pW8GVK///4ch1ijOWiCG4qWihLML3rd7MsBoMmfuqT65FPQGCnr+lp3CDYSBt1hJQKqhzIrUGgSBf04Ue4uQ9eCRRMo3VR1d7ae+bPuGMo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784214443; c=relaxed/simple;
	bh=LUfaQzJn2bnCsR/uWb1AJU4vhXIfysy8sSohRbkEbgo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DWMmvRzbbRzlDZ1OmuGjJNFnA1U6Oq5bkaujnvoN1FofeyuhXKIIeH1o2Z79wdgybeXdnXj/e8x6PpvOWud284LPmW1KHI5Pjo0mKRNNyfSpR56w7Qv13gvftr43Erw/2svBH0FdX2uBP3qNd/BOpJoyGYSFbHegJKM+e59JE0Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f2CE4j8Z; arc=pass smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f2CE4j8Z"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-39dbe684115so3266341fa.1
        for <bpf@vger.kernel.org>; Thu, 16 Jul 2026 08:07:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784214439; cv=none;
        d=google.com; s=arc-20260327;
        b=UimlNI5sjcVK7E726fv8/YaQUg77l+/VPMSfPOz5ZiBgOXjP0ADRWGBWArjw1xeFJN
         6zbJPyp1QMVlvDg6xaQkm9p1pm9Sav/5CKbswHAMRceYcf93DeaZuw/7LPYeTMhYKlrp
         0n83dzFex8o9b20S4a+H650HqlFAruHl78BelDOhQCmETDfel9zbBLtnG3ZYeIHIgsx4
         MAe59f09cfONQdQGWqS/FFarvYJHqrVjgBidNpKRuYDPmmPHJWinNagCn+U7ycdLtp4b
         bTa0twYwbEitTcnJZaNxKJKRmOobBMjNkGIoF4AOfoZiqNIgzyYQArXVVeJdM9q6t7F9
         YxEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=k7M2ApiM/8dxQZGiLlnNgbMz+W9cwib1Oj2a063GQa0=;
        fh=uOgCRLveVdL8+dE0k0CmK2xgtE5GBGHi7tYDXbTX70M=;
        b=nts4bPpcqphuhB1wuLVzdLvCUICsP/ge9HMRrJs1bU9txYBCvropPYuaCJLqRCACq8
         KOzly+BtKWNHKbkpHljCeD1KyWUcWEZoVNFixMmuGWqkC7asVGXirKBjYQaQfotL31Oe
         qGGDAhTqsVAv0jPidQe/hFvy4IqCBQOiMeK6/RUPkNbZhjnCyH32UFW65QwxtDUAO3w5
         KDGTyK1IfW5vQEt0XhzdOCff+sHmIqicA64e7dbuDQX/nnUxu2pSHUco7ycJWwIM8gne
         uXbQRmjpAuh3E8ffEaWoZebtWi31XBYk0FGc5KNk0vUMbeHVoS9kerTBkVKhGsRAIfcc
         uqbw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784214439; x=1784819239; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=k7M2ApiM/8dxQZGiLlnNgbMz+W9cwib1Oj2a063GQa0=;
        b=f2CE4j8Z2HAWNVepdjltH97LkNovDc6TTN1/BbQu18b1HFKPA7B1VAGdE2BIhfYqYo
         woKSEhTynCx0bF9vrARKHs6U8QD1BfWDpireD9BgRLDbcXNt1RhUVtgC1ZbFE4Xdu78Q
         RgD6J50vdQAz7ot6jIxlQH3GXVIXCJ4l8dG75xYH34KTObjVhrqhna0NXt9JXVmNNaNR
         ZXL/9pX3E0Kwko1pSlmIEkM5kPXVsPPF9rRaI9GW57iTN4Iz7vVR5gimpyPQ+WlH9NH0
         KBw0tNK72fabCqv44CND4SD9GbqPY9tj6ckm1RG/F2z89gC1W6jn4qzJJ80Lw/zSRj34
         vkYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784214439; x=1784819239;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=k7M2ApiM/8dxQZGiLlnNgbMz+W9cwib1Oj2a063GQa0=;
        b=VAm0eNTR7yG4L3S1KeOM/O9j86adIvsnzmqqicxx67MkloTorVELXkQHZTzsNkhAE0
         piqGTNW3ShiAmxofb/0C5qbXy5lIfdrIyXTj86f4n9T1lLAwvZwDDu4tJScVk1jHFixG
         Vzqt8lBWFzr1rPgIbh5Nc1KYZu+29TDLM9JJNeGRYnCcijJxXAhtRCy324ZMrCjmPqbv
         IxH4/Q3FpGYaziEpVJLKWlheec2e1zbcLyBuvFmskUEeO6c30QRnpziq1QOuzXp9HyeB
         ARi10fMaQ2foU4qykT40ycMY14a561WjgceaQ6iuGutJ0wpsjVwkdFt5vJ59lQCgOSPi
         MsaQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp7YgsHR2SlWCDBH3D6QQZtpQw20lCyN7u7iqUzIbYrx+BLYK3fbwofrcDbIM1rYKlQUJs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpaoqisE2tPf6HldPEyvv6O8ljFv/0F2lDqPALsBJ7XJsCKPYD
	M4n5etKV3qkMUBMWTxsCWx2ggSYvIJYjZ2Lq3vGoROgAtLASupw2awzn6fuaoabHqxPqon1o68I
	bgrF0OwjJv9BJfe3t4TNUdpS+B8behQo=
X-Gm-Gg: AfdE7cmv2c4ibdajlTh1c6LLtAsSNmz58i95Vuv4Ei+FC5gx9n63pFGBtsbpvD2TIiN
	oPdkU8MsAR0PmxxKMPRlkyLWkRCgXgTgjuOuxQFuj+rwRydXAOetcHlBjcDNA5zw0et3ZaFSxej
	WPzyGvXESS4dE8IZ29yEfG2TXPY19UhgdeZjqzTen/kO9OIIChjxVTIu+aCmgBYwznqTX/GrNax
	fvBVCDBE6dTjyiLu8wzLKvcWPpnUS4XDG3Jf+yh2cIkF6SpixcCwOSldthD6bgzipxUQYvCOz+T
	u0LmfNbMFrBTfzD4u7LSMdbfJjWnH+f6Sgitvjsnawg45MIGDICUzlqb/zxSxvZ2wUXc8JiwXkt
	ezQ==
X-Received: by 2002:a05:6512:1192:b0:5ae:b5d7:4b99 with SMTP id
 2adb3069b0e04-5b28a0f58camr826062e87.0.1784214439114; Thu, 16 Jul 2026
 08:07:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260714-bpf-meta-inside-skb-ext-v1-0-5871c07a8dd6@cloudflare.com>
 <20260714-bpf-meta-inside-skb-ext-v1-3-5871c07a8dd6@cloudflare.com>
 <aljKKt6nCB3fjFVA@devvm7509.cco0.facebook.com> <87a4rrjdj4.fsf@cloudflare.com>
In-Reply-To: <87a4rrjdj4.fsf@cloudflare.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 16 Jul 2026 17:06:41 +0200
X-Gm-Features: AUfX_mzujQhauOkZ5JSUcux-n5CL7A4vg5pNAEiHfjZwtqvCZWJ7lHML3E_SwaU
Message-ID: <CAL+tcoB4fwO5WxAcnW3QRErSQCnMBVMh6mfhFfG_dZhL+=MA6Q@mail.gmail.com>
Subject: Re: [PATCH RFC net-next 3/6] bpf: Allow skb extensions to survive
 packet scrubbing
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: Stanislav Fomichev <sdf.kernel@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	kernel-team@cloudflare.com, Jakub Kicinski <kuba@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 16, 2026 at 3:00=E2=80=AFPM Jakub Sitnicki <jakub@cloudflare.co=
m> wrote:
>
> On Thu, Jul 16, 2026 at 05:11 AM -07, Stanislav Fomichev wrote:
> > On 07/14, Jakub Sitnicki wrote:
> >> skb_scrub_packet() drops all skb extensions unconditionally via
> >> skb_ext_reset(). It runs on tunnel encap/decap (ip_tunnel_rcv,
> >> vxlan_rcv, etc.) and cross-netns forwarding (dev_forward_skb).
> >>
> >> This makes it impossible for a BPF program to pass metadata via
> >> bpf_skb_ext through a tunnel or across a netns boundary. The extension
> >> is always lost at the scrub point.
> >>
> >> Introduce skb_ext_scrub() which consults each active extension before
> >> discarding it. Extensions that request preservation are kept while the
> >> rest are torn down. When the extension slab is shared with clones, COW
> >> ensures isolation. Replace the skb_ext_reset() call in
> >> skb_scrub_packet() with skb_ext_scrub().
> >>
> >> Expose the opt-in mechanism to BPF via the BPF_SKB_EXT_F_NO_SCRUB flag
> >> for bpf_dynptr_from_skb_ext(). A program that sets this flag when
> >> creating the extension signals that its metadata should survive
> >> scrubbing.
> >>
> >> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
> >> ---
> >>  include/linux/bpf.h      |  1 +
> >>  include/linux/skbuff.h   |  2 ++
> >>  include/uapi/linux/bpf.h |  3 +-
> >>  net/core/filter.c        | 11 +++++--
> >>  net/core/skbuff.c        | 82 +++++++++++++++++++++++++++++++++++++++=
+++------
> >>  net/ipv4/udp.c           |  2 +-
> >>  6 files changed, 86 insertions(+), 15 deletions(-)
> >>
> >> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> >> index 6b918a5b61bf..a46ca53c5b27 100644
> >> --- a/include/linux/bpf.h
> >> +++ b/include/linux/bpf.h
> >> @@ -4214,6 +4214,7 @@ static inline int bpf_map_check_op_flags(struct =
bpf_map *map, u64 flags, u64 all
> >>  #ifdef CONFIG_BPF_SKB_EXT
> >>
> >>  struct bpf_skb_ext {
> >> +    u64 flags;
> >>      u8 buf[CONFIG_BPF_SKB_EXT_SIZE] __aligned(8);
> >>  };
> >>
> >> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> >> index 584d8440d352..66afa5489007 100644
> >> --- a/include/linux/skbuff.h
> >> +++ b/include/linux/skbuff.h
> >> @@ -5063,6 +5063,7 @@ void *__skb_ext_set(struct sk_buff *skb, enum sk=
b_ext_id id,
> >>  void *skb_ext_add(struct sk_buff *skb, enum skb_ext_id id);
> >>  void __skb_ext_del(struct sk_buff *skb, enum skb_ext_id id);
> >>  void __skb_ext_put(struct skb_ext *ext);
> >> +void skb_ext_scrub(struct sk_buff *skb);
> >>
> >>  static inline void skb_ext_put(struct sk_buff *skb)
> >>  {
> >> @@ -5132,6 +5133,7 @@ static inline bool skb_has_extensions(struct sk_=
buff *skb)
> >>  static inline void __skb_ext_put(struct skb_ext *ext) {}
> >>  static inline void skb_ext_put(struct sk_buff *skb) {}
> >>  static inline void skb_ext_reset(struct sk_buff *skb) {}
> >> +static inline void skb_ext_scrub(struct sk_buff *skb) {}
> >>  static inline void skb_ext_del(struct sk_buff *skb, int unused) {}
> >>  static inline void __skb_ext_copy(struct sk_buff *d, const struct sk_=
buff *s) {}
> >>  static inline void skb_ext_copy(struct sk_buff *dst, const struct sk_=
buff *s) {}
> >> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> >> index 3eee4467422d..02da170205de 100644
> >> --- a/include/uapi/linux/bpf.h
> >> +++ b/include/uapi/linux/bpf.h
> >> @@ -7734,7 +7734,8 @@ struct bpf_insn_array_value {
> >>
> >>  /* Flags to control bpf_dynptr_from_skb_ext() behavior. */
> >>  enum {
> >> -    BPF_SKB_EXT_F_CREATE =3D (1ULL << 0),
> >> +    BPF_SKB_EXT_F_CREATE    =3D (1ULL << 0),
> >> +    BPF_SKB_EXT_F_NO_SCRUB  =3D (1ULL << 1),
> >
> > Do I understand correctly that you do prefer the NO_SCRUB mode? Any rea=
son
> > we need to have scrub mode? If it's all produced/consumed by bpf, maybe
> > we can just carry this data unconditionally instead of having a SCRUB/N=
O_SCRUB
> > option?
>
> Yes, that's correct. We definitely need NO_SCRUB but I don't have a use
> case that relies on metadata scrubbing. I believe Kuniyuki also would
> like the no-scrub to be the only/default behavior for Google's egress
> use case.
>
> I've made it an opt-out mostly because that the existing metadata
> (skb->mark, skb->data_meta) gets scrubbed. Although as Jakub K has
> pointed out to me - you can circumvent it by using bpf_redirect into the
> target netns. So I guess we have a precendent?
>
> I could use input from folks operating in K8S-like environments, if

Sorry, I don't quite follow it here. Why don't we need the NO_SCRUB
here? The crucial point here is to allow skb traverse across different
containers, which is also what I expect. We do need to support this
case to make this feature standalone, which means it is independent
and not affected by other components.

And one part of what I'm doing for BPF timestamping v2 is to address
the issue in the container scenario as well, FYI.

Thanks,
Jason

> no-scrub-only mode would be acceptable there? Daniel, John, any opinion?
>
>
