Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8243B3F927E
	for <bpf@vger.kernel.org>; Mon, 20 Jul 2026 11:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784547551; cv=none; b=AhdtwehOWgXXPkwNsQAL394Xx6y9nLc+nlVV7xSO5t+yfhJEqQPzp3bSPU0OKngYy5GmOpN4CfF0XqiQR7LddPf69ttS3k+Rgd7SN2W2mSY9zh791mTLAD3c1qKfWwjsL07o9dH++JaenRhIGTQq3C+pvpymLlnve3l1tfXqItE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784547551; c=relaxed/simple;
	bh=lB8aqiCUuMZ/aZviJun/n1wU9gwWQms7traoLJUJDGQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Nze3Q+8D5DIE8L0+Q/lBiVgtDKPHcqCVTZyGTniMjAxbZrvgM2qF6vKctMCPXMPf4u2GFIepN4bUTSANQfOo+venLaabHS9gy1OLnE1QKZgoFEwdF84flQrUiGBjQV2hi5sqvkx72ug+cr4wxLjl89xmBfbxIoDcHkIQRBtjL6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=JVfOSpCq; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="JVfOSpCq"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-69e7a5b61e4so3187910a12.2
        for <bpf@vger.kernel.org>; Mon, 20 Jul 2026 04:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1784547542; x=1785152342; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=jwoMg55HiPYSUanAs9mZ1+FQz/PVpJKPAn4gUaHhyV4=;
        b=JVfOSpCqND+edOnGQHWf92ZIVKMJelZLDNmLUcdfczbeaS1/AwvbPhdYt3qQGqK9e1
         g12m1fOo4wz9E5C99flJez8EMRevHyF5BHtJK+Z7CpjFQTHw/kTbjZFyQ6TjNm5dhvB/
         WbRaV4GS376CM/D6RCdK6lNZls0CD9G8+YZjh+i2S0CAKEtYhsneLxi2YJBy2N2aTgp2
         OPBYrCvslAVmdrofBGVEal0eaARNDowKbtFdP/I0BGeiy7oPyTQaexN9x1BbmJjPcRT3
         cT/4AfW4expd2y4MXkG/GzQdaWDDfLO5jk9lvM2p2pG2QaXqsVuzcEES4Ke2QHJaHWDJ
         il+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784547542; x=1785152342;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jwoMg55HiPYSUanAs9mZ1+FQz/PVpJKPAn4gUaHhyV4=;
        b=UqvqYX1+3h5K0nSfBzdBaxCqzGjHvnCJ8UMxPmbiqFvoDBOWIyugvi46YzUcUA9eqV
         AC4zjrE4rAJb0+IXQx2x6wsZ6OERXiZepZMW8GAEhUKNNN2cUBmyDEIs7dgrfvh7GHd0
         CtnKQnSRSaoO0YsmOzDDTgz8tQ4sQsD7djzuwzesZVah8xbV4tvGbHA+7+wA2WyK+i4K
         hf9+WeRgziDBmVGlfSkzhJ63k0B7LLJrC8RhKZA6z/SC7TiJAj4A1f04Xpnvkr+pqnho
         kvrdp9cvE3xHMqcVgrA3oBd4r3haR3SeplT/ZcGKp8IMpuhCAUjrJHDx0Zqww5wxeDSp
         7hkg==
X-Forwarded-Encrypted: i=1; AHgh+Rpo5UHEB5zQb6Yk/ZSM//TKm0dCTwE3ySZap6IGF7XHUlkJJ1XaEtbeaQiaT2lnAoM/yqs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjsitRJ+5dDRLey1B0ZdYbHExcEUBoTYJkSGF2a4zO6cbyQAJA
	iXFxur2mi+V5G4uqqUrqJCSnUUdX+QgQzLHJ1zwE5XgtI9ud7pef6XFIUKMBS694Glw=
X-Gm-Gg: AfdE7clOk+vK0KbjHsUWMxNjq/vjokc7ynA8zVPpfV+rxzMApbUPhGfOjERzIO/OwZ0
	cP8pGnJS2I5rQW8/cb+f1L11HAICsOGO/8pUL1Oqwbuag0h9EEltpasbbT+rCn8mje0mJfE2npT
	Dk8kAB4JoZ1z2MYDF31zo1i5x8UoJXFW9mR9yWrO2HDOi21PGxuVOEKlk6UOvQ4Hui8pRNPvMCg
	45Q5FU0vCVw9oB5K7GFQs31sIDWeUSm7CfHQzZ9nh+SZOtDIpqxrhiLg2tT086CjxiBPx+mYewz
	paS6H+Z2OGIEOhVUT3ocqoaLEwFftrLhGfl97+NjalEPWz2Tgy5TnS19qO4kj3d/0ut2Q9EWvvi
	REb2pDLuDGsMtnx0meYHADZOWGv94iySwlufxUDzMJd922CzSaV0exfxWuhoa9DCbDdmzMstfwo
	wG
X-Received: by 2002:a05:6402:234f:b0:698:3c4c:5fc6 with SMTP id 4fb4d7f45d1cf-69e652dd8camr4581601a12.22.1784547542375;
        Mon, 20 Jul 2026 04:39:02 -0700 (PDT)
Received: from cloudflare.com ([104.28.21.182])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69e6fef2477sm4711567a12.7.2026.07.20.04.39.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 04:39:01 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: Stanislav Fomichev <sdf.kernel@gmail.com>,  Daniel Borkmann
 <daniel@iogearbox.net>,  John Fastabend <john.fastabend@gmail.com>,
  netdev@vger.kernel.org,  bpf@vger.kernel.org,
  kernel-team@cloudflare.com,  Jakub Kicinski <kuba@kernel.org>,  Kuniyuki
 Iwashima <kuniyu@google.com>
Subject: Re: [PATCH RFC net-next 3/6] bpf: Allow skb extensions to survive
 packet scrubbing
In-Reply-To: <CAL+tcoBPv2_yMZrrvgNT7kkL9tCmAfUZmsr7+0qYukRmYJb6gQ@mail.gmail.com>
	(Jason Xing's message of "Fri, 17 Jul 2026 19:30:12 +0200")
References: <20260714-bpf-meta-inside-skb-ext-v1-0-5871c07a8dd6@cloudflare.com>
	<20260714-bpf-meta-inside-skb-ext-v1-3-5871c07a8dd6@cloudflare.com>
	<aljKKt6nCB3fjFVA@devvm7509.cco0.facebook.com>
	<87a4rrjdj4.fsf@cloudflare.com>
	<CAL+tcoB4fwO5WxAcnW3QRErSQCnMBVMh6mfhFfG_dZhL+=MA6Q@mail.gmail.com>
	<CAL+tcoBPv2_yMZrrvgNT7kkL9tCmAfUZmsr7+0qYukRmYJb6gQ@mail.gmail.com>
User-Agent: mu4e 1.14.1; emacs 30.2
Date: Mon, 20 Jul 2026 13:39:01 +0200
Message-ID: <875x2951re.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 17, 2026 at 07:30 PM +02, Jason Xing wrote:
> On Thu, Jul 16, 2026 at 5:06=E2=80=AFPM Jason Xing <kerneljasonxing@gmail=
.com> wrote:
>>
>> On Thu, Jul 16, 2026 at 3:00=E2=80=AFPM Jakub Sitnicki <jakub@cloudflare=
.com> wrote:
>> >
>> > On Thu, Jul 16, 2026 at 05:11 AM -07, Stanislav Fomichev wrote:
>> > > On 07/14, Jakub Sitnicki wrote:
>> > >> skb_scrub_packet() drops all skb extensions unconditionally via
>> > >> skb_ext_reset(). It runs on tunnel encap/decap (ip_tunnel_rcv,
>> > >> vxlan_rcv, etc.) and cross-netns forwarding (dev_forward_skb).
>> > >>
>> > >> This makes it impossible for a BPF program to pass metadata via
>> > >> bpf_skb_ext through a tunnel or across a netns boundary. The extens=
ion
>> > >> is always lost at the scrub point.
>> > >>
>> > >> Introduce skb_ext_scrub() which consults each active extension befo=
re
>> > >> discarding it. Extensions that request preservation are kept while =
the
>> > >> rest are torn down. When the extension slab is shared with clones, =
COW
>> > >> ensures isolation. Replace the skb_ext_reset() call in
>> > >> skb_scrub_packet() with skb_ext_scrub().
>> > >>
>> > >> Expose the opt-in mechanism to BPF via the BPF_SKB_EXT_F_NO_SCRUB f=
lag
>> > >> for bpf_dynptr_from_skb_ext(). A program that sets this flag when
>> > >> creating the extension signals that its metadata should survive
>> > >> scrubbing.
>> > >>
>> > >> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
>> > >> ---
>> > >>  include/linux/bpf.h      |  1 +
>> > >>  include/linux/skbuff.h   |  2 ++
>> > >>  include/uapi/linux/bpf.h |  3 +-
>> > >>  net/core/filter.c        | 11 +++++--
>> > >>  net/core/skbuff.c        | 82 ++++++++++++++++++++++++++++++++++++=
++++++------
>> > >>  net/ipv4/udp.c           |  2 +-
>> > >>  6 files changed, 86 insertions(+), 15 deletions(-)
>> > >>
>> > >> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>> > >> index 6b918a5b61bf..a46ca53c5b27 100644
>> > >> --- a/include/linux/bpf.h
>> > >> +++ b/include/linux/bpf.h
>> > >> @@ -4214,6 +4214,7 @@ static inline int bpf_map_check_op_flags(stru=
ct bpf_map *map, u64 flags, u64 all
>> > >>  #ifdef CONFIG_BPF_SKB_EXT
>> > >>
>> > >>  struct bpf_skb_ext {
>> > >> +    u64 flags;
>> > >>      u8 buf[CONFIG_BPF_SKB_EXT_SIZE] __aligned(8);
>> > >>  };
>> > >>
>> > >> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
>> > >> index 584d8440d352..66afa5489007 100644
>> > >> --- a/include/linux/skbuff.h
>> > >> +++ b/include/linux/skbuff.h
>> > >> @@ -5063,6 +5063,7 @@ void *__skb_ext_set(struct sk_buff *skb, enum=
 skb_ext_id id,
>> > >>  void *skb_ext_add(struct sk_buff *skb, enum skb_ext_id id);
>> > >>  void __skb_ext_del(struct sk_buff *skb, enum skb_ext_id id);
>> > >>  void __skb_ext_put(struct skb_ext *ext);
>> > >> +void skb_ext_scrub(struct sk_buff *skb);
>> > >>
>> > >>  static inline void skb_ext_put(struct sk_buff *skb)
>> > >>  {
>> > >> @@ -5132,6 +5133,7 @@ static inline bool skb_has_extensions(struct =
sk_buff *skb)
>> > >>  static inline void __skb_ext_put(struct skb_ext *ext) {}
>> > >>  static inline void skb_ext_put(struct sk_buff *skb) {}
>> > >>  static inline void skb_ext_reset(struct sk_buff *skb) {}
>> > >> +static inline void skb_ext_scrub(struct sk_buff *skb) {}
>> > >>  static inline void skb_ext_del(struct sk_buff *skb, int unused) {}
>> > >>  static inline void __skb_ext_copy(struct sk_buff *d, const struct =
sk_buff *s) {}
>> > >>  static inline void skb_ext_copy(struct sk_buff *dst, const struct =
sk_buff *s) {}
>> > >> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
>> > >> index 3eee4467422d..02da170205de 100644
>> > >> --- a/include/uapi/linux/bpf.h
>> > >> +++ b/include/uapi/linux/bpf.h
>> > >> @@ -7734,7 +7734,8 @@ struct bpf_insn_array_value {
>> > >>
>> > >>  /* Flags to control bpf_dynptr_from_skb_ext() behavior. */
>> > >>  enum {
>> > >> -    BPF_SKB_EXT_F_CREATE =3D (1ULL << 0),
>> > >> +    BPF_SKB_EXT_F_CREATE    =3D (1ULL << 0),
>> > >> +    BPF_SKB_EXT_F_NO_SCRUB  =3D (1ULL << 1),
>> > >
>> > > Do I understand correctly that you do prefer the NO_SCRUB mode? Any =
reason
>> > > we need to have scrub mode? If it's all produced/consumed by bpf, ma=
ybe
>> > > we can just carry this data unconditionally instead of having a SCRU=
B/NO_SCRUB
>> > > option?
>
> After giving it more thought, I vote for only no_scrub mode because I
> don't see any reason why we still use scrub mode. But it's just my
> opinion.
>
> My question is if we in the future really need the scrub mode, it's
> still possible to add this option, right?

Sorry for the delayed response. Took some time off after the conference.

I will make the bpf skb ext contents survive skb scrubbing in v1.

It seems to suit everyone we've heard from and it is consistent with the
existing bpf_redirect_peer behavior wrt xdp/skb metadata.
