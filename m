Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792947098;
	b=g1SwBIOgvF4uAHHP6mzuIO8VKmz7jyj/U7/ngmgRaDj7EhKWaWLhd1Ur+KX72fmpisBK
	 iiWOrxikJEgFmaOzwz+0q5gNFq1V1dsb2rDI7Yfm6Qv6ht3j8mRVW32aCdwnYqHM+bQtD
	 d4Yaws8RGq+vGuGiBgVBgrO0bAr289W4krcar/AcoPYkaw/g9HIcWdrCbTDuF0q1PG2Wh
	 9WCjrpx0878tDKcpt3FzQF1b82U+2Wlb9B9dyt67h4xpn3rYWClf/B70abMICDqPF9Ypp
	 nBmewaWRWkR3F2orclJq9/rbHEByoipqWtdEi6E4a6LoCqtNPqv5R7kPNA0XaMD/MWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792947098;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=xzHKgSVVoFQfSfmD7ehsFWGCtvBBsi/8d+yY9tqmJak=;
	b=VthlTI92z/LE1Bg0cCbpEVz1fZqZYcrsVrYY1QVe8airgfwppt5vhwYudIyMfD56l7C/
	 eQwih0/sz9rxD8nexa+CPuVzaPlPg1ncndYDkgF1f/7H529lmOiUMAJAnDK/8JO3Pf5WN
	 PK3ix5/Mdx7RI4Ly2ZzIHvcNAdPmdVyaXA2DPnjMlh7oG/Lh2HMYdGzEFY4FeSUzLvAJm
	 fB39CYp54jPg6buQ7tWQTFDDBwFv3SlKEnf13dxlettyEJe6V5sp7TDY8crAKy5d44Gpk
	 P/HEdrM1+jOPc8/a34cZ8RrwD1eskX5WN7vVH+WReQ9xCBCWZehFzg6tcDb68jAGbRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AXSMHcmt;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=gHK+tJLQ;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27BE606A31A
	for <bpf@vger.kernel.org>; Sun, 25 Oct 2026 16:51:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C27BE606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AXSMHcmt;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=gHK+tJLQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792947096;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xzHKgSVVoFQfSfmD7ehsFWGCtvBBsi/8d+yY9tqmJak=;
	b=AXSMHcmtnswIVtza7//H6rjMutf3+x+gD0Ad01CQsFQk6ibPAKnfzJV7nsrN6u/1MLGuLp
	cZ5wRtUiE3VV3oa7jygUaTc+Z+/rSKFQTWK7vdymCHLtkOogiG6EXd2wh1rGj9b++/F5fx
	63jTODNhVzmE1AcVFwZ6apRpXS8BWGw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-373-kwvujUUGMjaPk7l2Wi4TkQ-1; Sun, 25 Oct 2026 12:51:35 -0400
X-MC-Unique: kwvujUUGMjaPk7l2Wi4TkQ-1
X-Mimecast-MFC-AGG-ID: kwvujUUGMjaPk7l2Wi4TkQ_1792947094
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-4870142f030so1378883f8f.2
        for <bpf@vger.kernel.org>; Sun, 25 Oct 2026 09:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792947094; x=1793551894; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xzHKgSVVoFQfSfmD7ehsFWGCtvBBsi/8d+yY9tqmJak=;
        b=gHK+tJLQASjCX6mh6NkeGsl0txW4VqTM8bH49P6YkapJfaxn5Rs/+xawYoWWzt9dNk
         P1H/VXyiAag0xR3rw2nGeF06tlMYXMuxWKoB6Rrh4lThnopHUVTDXIyFpipegA/E+YDC
         UYh7IJPtZoaZE1IOzgI4jyFVVD5W0KuZt6j8GIKP+AhlCVq1BXaDvS28G25Bt/3jOp6O
         o94CbejzTxxCj2vyKJspYQxNBuZIR7+soZz3mevbys3GgwcExKbeYd4wVYdaywx7VE7z
         PtFGF6Dr9fjajJQEzbu5Pe9skXldQMc0XBaSnAdoIryov98Owe2LsC7/1mSl89B6pynG
         OnuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792947094; x=1793551894;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=xzHKgSVVoFQfSfmD7ehsFWGCtvBBsi/8d+yY9tqmJak=;
        b=I2joSVMWSyPoe4bBVvlxBoIG/mgY2SVwoRm4e3dp9Y3wPRwhlvc7erTTcT4hsKIh26
         9aXc5eFmDAEdNMvgaELkMiS5AtI/KYwovXq5ZGdqBXjcWRvuQUoQPYeYQoyo/Na9p8BK
         R1oOKn9Tmq6oPunwFJM64qgqGhH7waGkKE4gBrpT8JuGQhMCprnAHKuk5FJ84+0iKddG
         jsDeNJKsibhW3uv8iAltkCPXyzLgcpMm+SdfY7SbZEGA9WJegvvQFlT+f0N6Js6Tg2Co
         AB9XKo5Z6rc2UOEU5Boispkg/Mggf0f3ynNAZry5ulrWt6t9axGQJ9DiJiJqNKg9MN0P
         vMlw==
X-Forwarded-Encrypted: i=1; AKwUvBxHRMy1gX00HjZFu028J6fZeSKQaAPt8zRCr5m6hKJTQx+ZY5Skm1a70bCmOq7ZlHTfnIw=@vger.kernel.org
X-Gm-Message-State: AFq9FYJFCx098+gsydaVgxayIfw9TjtGhv5KIH5ln/ZCELvPb5zSm0NQ
	HP68F1ayIBK8BYLKt0/nNNz/hoVReN639YE83E9Dt8RX5Q8ghIB77CecyWc4s3c01BknFy50qXA
	hFpffOqFxEEFnxLoVpV8HRCAW4BNbq0jYynEbRuys+Qv390wZg87EQw==
X-Gm-Gg: AYBFou038X0iqWjnl8rXfZoljBoRzFslT5TRWBLmg5VnAqAOfxcUuAy8oGWu0Wzticp
	1ap0w5rAAwIGNBaOQttqchjF3Kv39U5Z3XJ26ZViSrM/F/E6yjUQrqMlyT3RmFUoOSX8wAgmh5Q
	kK6RQw144Qg9/CrHwbZnrUFcfjzcniSnkIU6f8OVyf54iWJAArPOp3hxWiZh/tl5EN8yrIgJcoi
	CyY92j4QPPPnTU9gEwkB6NYtas2ts4OdZJVvDFcRygAygirXMXCt/e4m6eCQ8iTpcIWUmcoS8ag
	hYQ717CmexopMfAjR8IJmZ6XxyytkZkQiJYy0FIYqgVtSGmDEj8yKyZ3KHih/zqbuGY=
X-Received: by 2002:a05:6000:481b:b0:48e:82f:48fc with SMTP id ffacd0b85a97d-48e3eb971ccmr8796923f8f.31.1792947093881;
        Sun, 25 Oct 2026 09:51:33 -0700 (PDT)
X-Received: by 2002:a05:6000:481b:b0:48e:82f:48fc with SMTP id ffacd0b85a97d-48e3eb971ccmr8796894f8f.31.1792947093370;
        Sun, 25 Oct 2026 09:51:33 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1536:fc00:b838:383:1c7:6e81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ecd8c05sm14148518f8f.49.2026.10.25.09.51.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 09:51:31 -0700 (PDT)
Date: Sun, 25 Oct 2026 12:51:28 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: netdev-bot+sashiko@kernel.org
Cc: linux-kernel@vger.kernel.org, willemb@google.com, davem@davemloft.net,
	edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, maxk@qualcomm.com, rusty@rustcorp.com.au,
	netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH net v3] net: gso: validate transport header before
 computing segment length
Message-ID: <20261025124546-mutt-send-email-mst@kernel.org>
References: <52b8bfe4ee848aff8ace47752352de486171d45f.1792595507.git.mst@redhat.com>
 <179290180493.3134.5235549211177646736@kernel.org>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <179290180493.3134.5235549211177646736@kernel.org>

On Sun, Oct 25, 2026 at 04:16:44AM +0000, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 1 · Medium: 0 · Low: 0
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [High] The patch is incomplete for the producer its own commit message
>   names.
> 
> --
> 
> net: gso: validate transport header before computing segment length
> 
> This patch makes the GSO segment length helpers in net/core/gso.c check
> the TCP header before they read it. If the transport header is unset, or
> the TCP header is not in the linear data, skb_gso_validate_network_len()
> and skb_gso_validate_mac_len() now report that the skb does not fit. It
> also adds two helpers, skb_inner_transport_header_was_set() and
> skb_transport_header_linear(), to include/linux/skbuff.h.
> 
> > diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> > index d6894f463bf43..11c8b295bd260 100644
> > --- a/include/linux/skbuff.h
> > +++ b/include/linux/skbuff.h
> 
> [ ... ]
> 
> > @@ -3250,6 +3257,29 @@ static inline int skb_transport_offset(const struct sk_buff *skb)
> >  	return skb_transport_header(skb) - skb->data;
> >  }
> >  
> > +/* Is the (inner) transport header, as specified by
> > + * skb->transport_header/inner_transport_header, in the linear data?
> > + */
> > +static inline bool skb_transport_header_linear(const struct sk_buff *skb,
> > +					       unsigned int hlen)
> > +{
> > +	int thoff;
> > +
> > +	if (!skb_transport_header_was_set(skb))
> > +		return false;
> > +
> > +	if (skb->encapsulation) {
> > +		if (!skb_inner_transport_header_was_set(skb))
> > +			return false;
> > +
> > +		thoff = skb_inner_transport_offset(skb);
> > +	} else {
> > +		thoff = skb_transport_offset(skb);
> > +	}
> > +
> > +	return thoff >= 0 && thoff + hlen <= skb_headlen(skb);
> 
> [Severity: High]
> 
> The commit message names bpf_skb_adjust_room() as a way to leave a bad
> transport header behind. It also says:
> 
>     Qdisc length estimation has carried a guard against exactly this since
> 
> Is that guard enough for the bpf_skb_adjust_room() case? In
> qdisc_pkt_len_segs_init(), the only check is for an unset transport
> header. Nothing there matches the thoff >= 0 check added here:
> 
> net/core/dev.c:qdisc_pkt_len_segs_init() {
>     ...
> 	if (!skb->encapsulation) {
> 		if (unlikely(!skb_transport_header_was_set(skb)))
> 			return SKB_NOT_DROPPED_YET;
> 		hdr_len = skb_transport_offset(skb);
> 	} else {
> 		hdr_len = skb_inner_transport_offset(skb);
> 	}
> 	/* + transport layer */
> 	if (likely(shinfo->gso_type & (SKB_GSO_TCPV4 | SKB_GSO_TCPV6))) {
> 		const struct tcphdr *th;
> 
> 		if (!pskb_may_pull(skb, hdr_len + sizeof(struct tcphdr)))
> 			return SKB_DROP_REASON_SKB_BAD_GSO;
> 
> 		th = (const struct tcphdr *)(skb->data + hdr_len);
> 		tlen = __tcp_hdrlen(th);
>     ...
> }
> 
> bpf_skb_net_hdr_pop() moves mac_header and network_header forward. It
> leaves transport_header where it was, unless it was equal to
> network_header:
> 
> net/core/filter.c:bpf_skb_net_hdr_pop() {
>     ...
> 		skb->mac_header += len;
> 		skb->network_header += len;
> 		if (trans_same)
> 			skb->transport_header = skb->network_header;
>     ...
> }
> 
> When the DECAP_L4 or DECAP_IPXIP flags remove the last tunnel GSO bit,
> bpf_skb_net_shrink() also clears skb->encapsulation.
> 
> Take a locally VXLAN-encapsulated TCP TSO skb whose transport_header
> points at the outer UDP header. If a tc program calls
> bpf_skb_adjust_room(skb, -50, BPF_ADJ_ROOM_MAC,
> BPF_F_ADJ_ROOM_DECAP_L4_UDP | ...), the transport offset ends up at -16
> and encapsulation is 0.
> 
> A simpler BPF_ADJ_ROOM_NET shrink of 40 bytes on a plain Ethernet/IPv4
> TSO skb gives an offset of -6.
> 
> If the program then redirects to egress with bpf_redirect(), this path
> runs before any of the validators hardened in this patch:
> 
> __bpf_tx_skb()
>   dev_queue_xmit()
>     __dev_queue_xmit()
>       qdisc_pkt_len_segs_init()
> 
> In that function hdr_len is an unsigned int, so -16 becomes 0xfffffff0.
> hdr_len + sizeof(struct tcphdr) is then truncated to 4 when passed as the
> unsigned int len argument of pskb_may_pull(), so the pull succeeds.
> 
> Wouldn't __tcp_hdrlen(th) then read about 4GB past skb->data on 64-bit?
> 
> Should qdisc_pkt_len_segs_init() get the same check, for example by
> using skb_transport_header_linear()? If not, could the commit message
> be changed so it does not say the qdisc path already guards against
> this?
> 
> > +}
> > +
> >  static inline u32 skb_network_header_len(const struct sk_buff *skb)
> >  {
> >  	DEBUG_NET_WARN_ON_ONCE(!skb_transport_header_was_set(skb));
> 
> [ ... ]
> 


Indeed. Not nice.

Eric, you seem to have strong opinions about how to fix these
bugs, so, before I spend time testing: a fix like the below, acceptable?

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

---

diff --git a/net/core/dev.c b/net/core/dev.c
index e76762e29360..bef7f0a00140 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4174,7 +4174,8 @@ EXPORT_SYMBOL_GPL(validate_xmit_skb_list);
 static enum skb_drop_reason qdisc_pkt_len_segs_init(struct sk_buff *skb)
 {
 	struct skb_shared_info *shinfo = skb_shinfo(skb);
-	unsigned int hdr_len, tlen;
+	unsigned int tlen;
+	int hdr_len;
 	u16 gso_segs;
 
 	qdisc_skb_cb(skb)->pkt_len = skb->len;
@@ -4197,6 +4198,8 @@ static enum skb_drop_reason qdisc_pkt_len_segs_init(struct sk_buff *skb)
 	} else {
 		hdr_len = skb_inner_transport_offset(skb);
 	}
+	if (unlikely(hdr_len < 0))
+		return SKB_NOT_DROPPED_YET;
 	/* + transport layer */
 	if (likely(shinfo->gso_type & (SKB_GSO_TCPV4 | SKB_GSO_TCPV6))) {
 		const struct tcphdr *th;




-- 
MST

