Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39CC26AF4
	for <bpf@vger.kernel.org>; Thu, 16 Jul 2026 12:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784206789; cv=none; b=FXGoHz1P7kmNliUyPXIZQ6Nxo4l32D4ON9nYO63ysuze+EQHK607bOtcBHDT19s3v5yhPI0/XIxkzML2DBYVZGWgZr7LlP0fpwS6cescdZO/HEBpiqnrfY63OtG8WOOLnMZ6z5Mvj/cFevNSSDWLWUYpYW2Ih7eKUt99WfIAfmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784206789; c=relaxed/simple;
	bh=rpmjjD9ixMN3vKIYQ51So5awvszP0cmojx8AZD/MAyc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mgYGML6l2/53g/LS2r5di+caJKDbpd30I7z9ubD9DJi93i5qSbc4eO8tfumaVw6jArQ3o6sEHoyWU5OG+81+ljlAmXsIQqpSwvUEERtCQK5L5B2UOZHhb1gTkYZx4BLA96Qwe+5eqs2VmrEyKmLoeBxY90tx9RCmLKVORT+zbpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=LuH0ZQwB; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="LuH0ZQwB"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-493e497643fso16174085e9.0
        for <bpf@vger.kernel.org>; Thu, 16 Jul 2026 05:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1784206786; x=1784811586; darn=vger.kernel.org;
        h=content-type:mime-version:message-id:date:user-agent:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=xZvfawR8I4GAicdLgeKPOlr1vtxHRZ9vVAdVAAu3ReU=;
        b=LuH0ZQwBkpheF40QdkRq7vYP/3gL7NFHsEpA3E3qO0fuettH+bMv56pTR8JMMZMpmY
         E4Ebw5Keh0YmAz/BjP2AQRVCaiyZJe22mX+QldkraT/Hv0yOlAYsUQ6IpgLtq3PzfGDK
         c0fJH9ZOOvZoEBhZAM3F7BGIbTJHUin8pcEajwpdpjBPOaIFpEEjfCkJ1IBMEsUA3iv1
         SJG6xxa/7ykBT4jBNObwAPg3yC+FuiNcpyMf2FpdtQZid4bjfaP15ClMFzLnq7cJD68p
         SkvRqtMkh1L3YxZfn8NC6OdO4bgF+o7Aq6hUX4Oor7cn0xNtxwC5BGM95/UPiyN0MTBS
         8m8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784206786; x=1784811586;
        h=content-type:mime-version:message-id:date:user-agent:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=xZvfawR8I4GAicdLgeKPOlr1vtxHRZ9vVAdVAAu3ReU=;
        b=sBZOMr4JII0cISELkjmaU+vTGU4vBTONZBqfpjW0clINMnCBvqUdXAuHCo3oPFk3MC
         vaiDH2J632R4fweP4hTXI8//pe0W5CZEqr/eRJ4X/qSR0LaJX6qh30Rq/pJPMCtgsK7C
         PHX8f5GztmyuTDEwyG1AOOLLvFNq0k8ha1j3XdP1n+kyMFY3IVJ67mH987WY63R3crkx
         ZtF0h0bEolNIW5rlzxCnnOBlE1k0fnAGsfBXUb0vNknUAxaUQT60jUaEGVKe9G/vcv17
         IfhzOiOLPrsiQ+R6lUdtx0xfpd3ISmsMVsiCbKawmq7otlD814E7uYzmamSHRDbxuREZ
         bAjg==
X-Forwarded-Encrypted: i=1; AHgh+Rrl/NM0ccoFo7HJESjDB6qvh4xq3Egb7khs1YfRHUbRrznNs9G+9QGNSV6LLCtfIDMrt+g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqhQFobgE4sj24mt4Kf2w+Aft01y7vDWRcKdqz9b2Do0FoUbaz
	fYrSB3AFYH/nT0+ZToKnSfbekHAszAALFb7CLz7o9jBroG/Qs7imFL5yS00gExeo1WM=
X-Gm-Gg: AfdE7cksWqw8p3NgFA0sSovrSZQGPmQKONTXD4YqVI1JdT32HuFS4VTaAKDYye8QNwK
	tEP6h+U/E+8ScrAdn1evJfHlLFhh4o9wk7oMzVehVEB+Cm70xL4n/NWVrlzo+WSG/2Dgxltatce
	FJgdJMIjeoBDTLoD2gb9sgcjt8Aznra/zuxa1Xss3SZQ/ndB+2ksUaA0+8BxLLxVXj01aokDRU+
	i3tFaI1DTeBfbgHzny8r/nACZSBK1QJDd1xgGDexv+vjp5P1VzqokLCnCC1vlvgGqE729jpDVzx
	metLpXxq1kf6taj1VUp/r38fPoDES0siOx0q0sGWRBmp2BmOGtIFDxXbgQxZfrtpPLXLUHfpn4q
	K9AFCIx0uoC/8zRz45kz3zWzpd5jiMzHGEsiSjiA1XJkHZbHbEeAaEN9dTqzIVv1ihVzh0O7xwB
	GlNVisrw==
X-Received: by 2002:a05:600c:4ed2:b0:495:3c8c:c16a with SMTP id 5b1f17b1804b1-49541248d08mr36567905e9.0.1784206785670;
        Thu, 16 Jul 2026 05:59:45 -0700 (PDT)
Received: from cloudflare.com ([104.28.189.108])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49541eb0343sm57827975e9.10.2026.07.16.05.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 05:59:45 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Stanislav Fomichev <sdf.kernel@gmail.com>, Daniel Borkmann
 <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>
Cc: netdev@vger.kernel.org,  bpf@vger.kernel.org,
  kernel-team@cloudflare.com, Jakub Kicinski <kuba@kernel.org>, Kuniyuki
 Iwashima <kuniyu@google.com>
Subject: Re: [PATCH RFC net-next 3/6] bpf: Allow skb extensions to survive
 packet scrubbing
In-Reply-To: <aljKKt6nCB3fjFVA@devvm7509.cco0.facebook.com> (Stanislav
	Fomichev's message of "Thu, 16 Jul 2026 05:11:30 -0700")
References: <20260714-bpf-meta-inside-skb-ext-v1-0-5871c07a8dd6@cloudflare.com>
	<20260714-bpf-meta-inside-skb-ext-v1-3-5871c07a8dd6@cloudflare.com>
	<aljKKt6nCB3fjFVA@devvm7509.cco0.facebook.com>
User-Agent: mu4e 1.14.1; emacs 30.2
Date: Thu, 16 Jul 2026 14:59:43 +0200
Message-ID: <87a4rrjdj4.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Jul 16, 2026 at 05:11 AM -07, Stanislav Fomichev wrote:
> On 07/14, Jakub Sitnicki wrote:
>> skb_scrub_packet() drops all skb extensions unconditionally via
>> skb_ext_reset(). It runs on tunnel encap/decap (ip_tunnel_rcv,
>> vxlan_rcv, etc.) and cross-netns forwarding (dev_forward_skb).
>> 
>> This makes it impossible for a BPF program to pass metadata via
>> bpf_skb_ext through a tunnel or across a netns boundary. The extension
>> is always lost at the scrub point.
>> 
>> Introduce skb_ext_scrub() which consults each active extension before
>> discarding it. Extensions that request preservation are kept while the
>> rest are torn down. When the extension slab is shared with clones, COW
>> ensures isolation. Replace the skb_ext_reset() call in
>> skb_scrub_packet() with skb_ext_scrub().
>> 
>> Expose the opt-in mechanism to BPF via the BPF_SKB_EXT_F_NO_SCRUB flag
>> for bpf_dynptr_from_skb_ext(). A program that sets this flag when
>> creating the extension signals that its metadata should survive
>> scrubbing.
>> 
>> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
>> ---
>>  include/linux/bpf.h      |  1 +
>>  include/linux/skbuff.h   |  2 ++
>>  include/uapi/linux/bpf.h |  3 +-
>>  net/core/filter.c        | 11 +++++--
>>  net/core/skbuff.c        | 82 ++++++++++++++++++++++++++++++++++++++++++------
>>  net/ipv4/udp.c           |  2 +-
>>  6 files changed, 86 insertions(+), 15 deletions(-)
>> 
>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>> index 6b918a5b61bf..a46ca53c5b27 100644
>> --- a/include/linux/bpf.h
>> +++ b/include/linux/bpf.h
>> @@ -4214,6 +4214,7 @@ static inline int bpf_map_check_op_flags(struct bpf_map *map, u64 flags, u64 all
>>  #ifdef CONFIG_BPF_SKB_EXT
>>  
>>  struct bpf_skb_ext {
>> +	u64 flags;
>>  	u8 buf[CONFIG_BPF_SKB_EXT_SIZE] __aligned(8);
>>  };
>>  
>> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
>> index 584d8440d352..66afa5489007 100644
>> --- a/include/linux/skbuff.h
>> +++ b/include/linux/skbuff.h
>> @@ -5063,6 +5063,7 @@ void *__skb_ext_set(struct sk_buff *skb, enum skb_ext_id id,
>>  void *skb_ext_add(struct sk_buff *skb, enum skb_ext_id id);
>>  void __skb_ext_del(struct sk_buff *skb, enum skb_ext_id id);
>>  void __skb_ext_put(struct skb_ext *ext);
>> +void skb_ext_scrub(struct sk_buff *skb);
>>  
>>  static inline void skb_ext_put(struct sk_buff *skb)
>>  {
>> @@ -5132,6 +5133,7 @@ static inline bool skb_has_extensions(struct sk_buff *skb)
>>  static inline void __skb_ext_put(struct skb_ext *ext) {}
>>  static inline void skb_ext_put(struct sk_buff *skb) {}
>>  static inline void skb_ext_reset(struct sk_buff *skb) {}
>> +static inline void skb_ext_scrub(struct sk_buff *skb) {}
>>  static inline void skb_ext_del(struct sk_buff *skb, int unused) {}
>>  static inline void __skb_ext_copy(struct sk_buff *d, const struct sk_buff *s) {}
>>  static inline void skb_ext_copy(struct sk_buff *dst, const struct sk_buff *s) {}
>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
>> index 3eee4467422d..02da170205de 100644
>> --- a/include/uapi/linux/bpf.h
>> +++ b/include/uapi/linux/bpf.h
>> @@ -7734,7 +7734,8 @@ struct bpf_insn_array_value {
>>  
>>  /* Flags to control bpf_dynptr_from_skb_ext() behavior. */
>>  enum {
>> -	BPF_SKB_EXT_F_CREATE = (1ULL << 0),
>> +	BPF_SKB_EXT_F_CREATE	= (1ULL << 0),
>> +	BPF_SKB_EXT_F_NO_SCRUB	= (1ULL << 1),
>
> Do I understand correctly that you do prefer the NO_SCRUB mode? Any reason
> we need to have scrub mode? If it's all produced/consumed by bpf, maybe
> we can just carry this data unconditionally instead of having a SCRUB/NO_SCRUB
> option?

Yes, that's correct. We definitely need NO_SCRUB but I don't have a use
case that relies on metadata scrubbing. I believe Kuniyuki also would
like the no-scrub to be the only/default behavior for Google's egress
use case.

I've made it an opt-out mostly because that the existing metadata
(skb->mark, skb->data_meta) gets scrubbed. Although as Jakub K has
pointed out to me - you can circumvent it by using bpf_redirect into the
target netns. So I guess we have a precendent?

I could use input from folks operating in K8S-like environments, if
no-scrub-only mode would be acceptable there? Daniel, John, any opinion?

