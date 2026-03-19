Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4FF3D34B7
	for <bpf@vger.kernel.org>; Thu, 19 Mar 2026 13:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773926682; cv=none; b=QlQykycJNxnMDoiKgYnncoh/EnE50a6fvWhTVaxLEAmhUjkjiseDxC0aAIYWwmykaWiUCDGrQ94vEqAsPRvsP8yDDTWPzwMSXWqI6OvK7R0tVE92zQLB9/5VK0J+8cFOdW/KFOhGk5PhLTwMtYxIkcv+y7TyHBHGbwem0CRy6zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773926682; c=relaxed/simple;
	bh=SkpLpeOLfCj2GU76XmFx4ghYmRIZ+1PVqfByjE+H/pU=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=ipVYNjp1tB+qt6DHBlUCpGWPuENoRFhyXRBA5ed+259s0l7gb3PPSEEI/WmPIHhp4vGmd3SnJRrtFN0abdMFT/rtywNy5KY9mZ4/wIv1hx91/6iVMVnELZQBaGCa956dqQnKjGYoBTEnyAPTJcmsD+XtifhM4lxY8EtTxz1wRto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gEeQUDwl; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gEeQUDwl"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-79860421382so5416237b3.0
        for <bpf@vger.kernel.org>; Thu, 19 Mar 2026 06:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773926680; x=1774531480; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H9RQ6JRYqSbn2WRhZy8MD11g0JCaQRZZDGdfPYjhOb8=;
        b=gEeQUDwleBLzngzsiQuqZFuVmGf1MLghWw7ruAE9MqnuU2rnDLZ8doLjWYGamvLQuV
         QGwptRjAN7J+6ILObk2Vg6GOVRcz12rLbbQWorjxV8NbHYN/PIX1jhj8J6t/RhOErR/9
         AR/QIHapdRS16PtdQ1gcmRvrHZu78sYgFk4G+lwfA2l3iK8c/mWhohzlaJCbisa3oa25
         vPinHDo/bxAS6Id+bGBdZIfIMPpqX7zfX+idDrg0rftKyNP4joGN+35WbbfWy8fsPnCD
         hjWQbpCnpDDNh/PysgzYfBr84zVmK4F3AtM4PcW8dxnm0HtNsW94tpckLQjB+UtaAdD8
         TfeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773926680; x=1774531480;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H9RQ6JRYqSbn2WRhZy8MD11g0JCaQRZZDGdfPYjhOb8=;
        b=PRwWZWc7BoKTfbSU10PqVNP8q8OUWGyp/LCe8QkSe5Lk+zV1erd7ZcSg2aGsflFBzV
         tFyEc2ZVzaqWiY1KsBSYRTnAMctg1iEAGFdiHZArCmTDWhg1ddxPugTXuxLPJ+reF71N
         wWKUSW8oiZE4LhHA+nyxn+FmyrnqjJ0zyYj0d/WH2/V94ndG04NAozq+ofreBM041UAG
         WqsDPpVptUG9lWFLhH71c84ZYnR6ud9LPzoIca82CLHIK3R6EcvVTAif8QFFB2Of9nBd
         H70Rmu5anc+Kb0XGjjkxujrZAFfDuQkwxzcHRpU7peKbvQAeEIy3TpP7eKiK8fDJygPX
         dP0A==
X-Gm-Message-State: AOJu0Yy/RxW5dsSxukGdt3rqC41o9QUFHchM9eUejIkR7FhmB+0knRZj
	Snl4s0Wpa74ZT3o8XPtcDiL6HKF25tk/zg7v0hYk/E1OtXpzPIdbSW1n
X-Gm-Gg: ATEYQzxfEtyNc1X/xWdKinovMenedryxeOQ3qjWYrQxCWO612aHMsQJPKlCFuGX0iwE
	gd6sfyGZcylUNKA6LscSE0h1GiqasCD31N7bgp8PrAYN7EGeXa7tgOYnx/CmKBmRwzgOakMOC/8
	rs5KWW0Ee2TOiHdsH12jIWjQ79D793Py4kEi+SRVhMkL9wu+UXQA06PfDi6E4BUwlqtJNrgPPmf
	R9FFN61uuPuB/viJbsOjbik3zA3o36q8DCgW/JKdvFNHKOvEftwGO15daNh+rKDb8gpQdFgKLtC
	kajc06UBhOZqBEgVXcGOm9iCHszBXY7X7/cSPFy7GNqhi2ZwS7ydS2mO8tr23OBZB+u9VN55W7M
	n15LzaW4raXnL4bHPRCcJ/B+3BoZpdSGDIfcotPx050vOPxi+4sLEsygB72cqJ/f7CoTl0xlt8S
	UDOy8WSsP2zQ3MBJsCjOYUmA+buW/jz7JppbNZ6zy9XhqrWAMfGfe2YZ0whyLJFxRxT8YkQ4KiY
	wbWoV6dKEJcsZs=
X-Received: by 2002:a05:690c:358a:b0:798:7907:5cf with SMTP id 00721157ae682-79a71ed56b6mr75059467b3.54.1773926680000;
        Thu, 19 Mar 2026 06:24:40 -0700 (PDT)
Received: from gmail.com (180.134.85.34.bc.googleusercontent.com. [34.85.134.180])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-79a715d6acfsm37639657b3.40.2026.03.19.06.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 06:24:39 -0700 (PDT)
Date: Thu, 19 Mar 2026 09:24:39 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: "Hudson, Nick" <nhudson@akamai.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: "bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
 "Tottenham, Max" <mtottenh@akamai.com>, 
 "Glasgall, Anna" <aglasgal@akamai.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Alexei Starovoitov <ast@kernel.org>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-ID: <willemdebruijn.kernel.18a884569c72@gmail.com>
In-Reply-To: <03A3369E-0F7B-4708-92B9-B335A6F86976@akamai.com>
References: <20260318134242.2725749-1-nhudson@akamai.com>
 <20260318134242.2725749-5-nhudson@akamai.com>
 <willemdebruijn.kernel.26b750d5f8926@gmail.com>
 <03A3369E-0F7B-4708-92B9-B335A6F86976@akamai.com>
Subject: Re: [PATCH v2 4/5] bpf: allow new DECAP flags and add guard rails
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Hudson, Nick wrote:
> 
> 
> > On 18 Mar 2026, at 20:02, Willem de Bruijn <willemdebruijn.kernel@gmail.com> wrote:
> > 
> > !-------------------------------------------------------------------|
> >  This Message Is From an External Sender
> >  This message came from outside your organization.
> > |-------------------------------------------------------------------!
> > 
> > Nick Hudson wrote:
> >> Add checks to require shrink-only decap, reject conflicting decap flag
> >> combinations, and verify removed length is sufficient for claimed header
> >> decapsulation.
> >> 
> >> Co-developed-by: Max Tottenham <mtottenh@akamai.com>
> >> Signed-off-by: Max Tottenham <mtottenh@akamai.com>
> >> Co-developed-by: Anna Glasgall <aglasgal@akamai.com>
> >> Signed-off-by: Anna Glasgall <aglasgal@akamai.com>
> >> Signed-off-by: Nick Hudson <nhudson@akamai.com>
> >> ---
> >> net/core/filter.c | 47 +++++++++++++++++++++++++++++++++++++----------
> >> 1 file changed, 37 insertions(+), 10 deletions(-)
> >> 
> >> diff --git a/net/core/filter.c b/net/core/filter.c
> >> index 7c2871b40fe4..47aec44a9cd3 100644
> >> --- a/net/core/filter.c
> >> +++ b/net/core/filter.c
> >> @@ -56,6 +56,7 @@
> >> #include <net/sock_reuseport.h>
> >> #include <net/busy_poll.h>
> >> #include <net/tcp.h>
> >> +#include <net/gre.h>
> >> #include <net/xfrm.h>
> >> #include <net/udp.h>
> >> #include <linux/bpf_trace.h>
> >> @@ -3496,7 +3497,9 @@ static u32 bpf_skb_net_base_len(const struct sk_buff *skb)
> >> BPF_F_ADJ_ROOM_ENCAP_L2( \
> >>  BPF_ADJ_ROOM_ENCAP_L2_MASK))
> >> 
> >> -#define BPF_F_ADJ_ROOM_DECAP_MASK (BPF_F_ADJ_ROOM_DECAP_L3_MASK)
> >> +#define BPF_F_ADJ_ROOM_DECAP_MASK (BPF_F_ADJ_ROOM_DECAP_L3_MASK | \
> >> + BPF_F_ADJ_ROOM_DECAP_L4_MASK | \
> >> + BPF_F_ADJ_ROOM_DECAP_IPXIP_MASK)
> >> 
> >> #define BPF_F_ADJ_ROOM_MASK (BPF_F_ADJ_ROOM_FIXED_GSO | \
> >> BPF_F_ADJ_ROOM_ENCAP_MASK | \
> >> @@ -3743,20 +3746,44 @@ BPF_CALL_4(bpf_skb_adjust_room, struct sk_buff *, skb, s32, len_diff,
> >> return -ENOTSUPP;
> >> }
> >> 
> >> - if (flags & BPF_F_ADJ_ROOM_DECAP_L3_MASK) {
> >> + if (flags & BPF_F_ADJ_ROOM_DECAP_MASK) {
> >> + u32 len_decap_min = 0;
> >> +
> >> if (!shrink)
> >> return -EINVAL;
> >> 
> >> - switch (flags & BPF_F_ADJ_ROOM_DECAP_L3_MASK) {
> >> - case BPF_F_ADJ_ROOM_DECAP_L3_IPV4:
> >> + /* Reject mutually exclusive decap flag pairs. */
> >> + if ((flags & BPF_F_ADJ_ROOM_DECAP_L3_MASK) ==
> >> +    BPF_F_ADJ_ROOM_DECAP_L3_MASK)
> >> + return -EINVAL;
> >> +
> >> + if ((flags & BPF_F_ADJ_ROOM_DECAP_L4_MASK) ==
> >> +    BPF_F_ADJ_ROOM_DECAP_L4_MASK)
> >> + return -EINVAL;
> >> +
> >> + if ((flags & BPF_F_ADJ_ROOM_DECAP_IPXIP_MASK) ==
> >> +    BPF_F_ADJ_ROOM_DECAP_IPXIP_MASK)
> >> + return -EINVAL;
> >> +
> >> + /* Reject mutually exclusive decap tunnel type flags. */
> >> + if ((flags & BPF_F_ADJ_ROOM_DECAP_L4_MASK) &&
> >> +    (flags & BPF_F_ADJ_ROOM_DECAP_IPXIP_MASK))
> >> + return -EINVAL;
> >> +
> >> + if (flags & BPF_F_ADJ_ROOM_DECAP_L4_UDP)
> >> + len_decap_min += sizeof(struct udphdr);
> >> +
> >> + if (flags & BPF_F_ADJ_ROOM_DECAP_L4_GRE)
> >> + len_decap_min += sizeof(struct gre_base_hdr);
> >> +
> >> + if (len_diff_abs < len_decap_min)
> >> + return -EINVAL;
> > 
> > Should this test come after the below IP flags?
> 
> Should it?
> 
> Seems to me it can bail early without having to check the IP flags. len_decap_min vs len_min.
> 
> What am I missing?

I would think it common that UDP decap also includes an L3 decap, in
which case the len_decap_min should include both header lengths.
