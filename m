Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792957939;
	b=uf3NEUt1tbRO0ypMTkhowWzUvKLr5XJXYC3aX6oMocxl3VBUA6LMFk7ySx/YUK7fSDjW
	 4VUfAI8DTSw6sUPVzVLPgTQ2kfOcKVnT8K/G9TpOiCxSQeM0TIA7aekeN69xEN5pmxW/3
	 Rg1xUC/jF4dmrnXVK+linUkN9dE13PhVUQEppJmyCueryd2qHflzeLeiSn8Tw6wnFFpPG
	 8iWsPVD8RxPxApWRZt2EoVJZ/0UTpK+Q77y4R8+abGllxS5aT/uS0rHwda+RT+WGzhZ9L
	 25dCQfyUpNpDSDbXbwYmpS7EAsI6m/Wku7nXqV2UnMVR2ctEmo0gxquSThN147pc8Yg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792957939;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=ksE8b4/KBgZc3kfivoq0ARabS58Vtl9JkGQ6CWDimYs=;
	b=ijeJWojRog0qKJduP5vk1bu1XDWQ6rAUIa1aLOtwOnEqOmnhD5Dm2DIMkvs5Klk+YHt0
	 GgOaKKUs+IAFVgE2XfFEGEjCIoMbI4tAiiJ2FbxyAw71khv36+ejx9LP59SMabTAaI+mW
	 TIK0M6t54gPBqHSu+BhR4ehuIPF8olxvVI7H59lrDU7pNNWub8FOy/a5kRGOQ8hpOo6VW
	 c/pnJDe7NYb9NWg2sMe82aVBw+KZre6q+LIo8Ykh8OC8YPGAjt3E8iZi6FAE0UMURCePw
	 dsupwc8kjFPKUwWQt9s5jLhuU+7YJtyXoSBx3rM293BDZ5oUgUxBAhA1LQw/fH1ZCWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="DK/KMOGV";
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=a9CZxXn+;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78CCD60A2603
	for <bpf@vger.kernel.org>; Sun, 25 Oct 2026 19:52:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 78CCD60A2603
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DK/KMOGV;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=a9CZxXn+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792957932;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ksE8b4/KBgZc3kfivoq0ARabS58Vtl9JkGQ6CWDimYs=;
	b=DK/KMOGVOz5vNXi5OtllOO8HODvKfU6g3HzYNW6B7Q7SJcNufDqUQM84+cIfrKExmiYLcl
	UJe3YFzxtLKMjfyxLZi+kqqoen1rXJrsrbC8xNWliU+mFy7z4YxCgabzqGvIePr1uBDjGs
	QeooxQVBqNWOB9hw7xva0ADlppMlmVc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-557-e3N5mc05Pa-dUVY_IEGvsQ-1; Sun, 25 Oct 2026 15:52:05 -0400
X-MC-Unique: e3N5mc05Pa-dUVY_IEGvsQ-1
X-Mimecast-MFC-AGG-ID: e3N5mc05Pa-dUVY_IEGvsQ_1792957924
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4a359b714f8so13653055e9.2
        for <bpf@vger.kernel.org>; Sun, 25 Oct 2026 12:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792957924; x=1793562724; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ksE8b4/KBgZc3kfivoq0ARabS58Vtl9JkGQ6CWDimYs=;
        b=a9CZxXn+xvFCqQjeC31EB24PJsQwq/uZvki2sewHIkpr6Fub3QP0SBNQuJCBZH++dJ
         SHTc25fgviRkl/UJ1DzNvW9KIuP9MoSOw72vWVzqTaeubN//Acq8cwGt5ndXmdyPNoYo
         nduUKaOInkltA0ms1wA9w5awVLQgvKznsBW/IFc3Ny5J7Zs7j7qBJ/F1ZpcMj5nvHiSB
         b5HxWRC3w8tlG36PuN0C6jBCn8ywhw1L2xzTNgVkIduWwGE6qlfkrn8kR9a23uPeN60p
         q3k/+rrKE0d4O/RJinV7APGfDoLUMn2TN7+jP4ydPiLo90PLQfWcNQW7UIKxFZf1qoDM
         +1sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792957924; x=1793562724;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ksE8b4/KBgZc3kfivoq0ARabS58Vtl9JkGQ6CWDimYs=;
        b=jlZ+7RfZlTWinrczsRf8TmyZ9o4gF6KycZOmf2vIZB/MiF63AHem10BWCTC+g2ESc/
         g7tYPnLz5vxWf56BZTToZ6+r0beu7EwBMnbMJVgEOs6L9VSibiNVuEtSlhsb7VO4UwZe
         rMgaGgVUNf8v29gJ3eAnXFWNI7mSKV9LpFaYU5gCIK1e9cA4a5W2UBPD2WqcYXU3zQuA
         6Ta4gluJZxRgycVZHgZVEtNEXf2K9/IclSlRp4oRXqplQQ3+mkZnzGW2tU8IG8ByRsQV
         JpsLQY8ChQX31WM/e83GILQFAgtjGMIZFtETPVK8kTNDBXldANHyR77pgGW/hL9Re0jX
         6U6g==
X-Forwarded-Encrypted: i=1; AKwUvBxjNZX1FWJAY5LBMk63RHhNXcLiokkwS5GBtsOgJ4U+wqq6WJ5EIUnd8TGTyhW+DPS0hyw=@vger.kernel.org
X-Gm-Message-State: AFq9FYLd86nX6LN+xsIcOs4k37jndX30sMUho8ReAmb6rRZLpCXjbQKB
	Ah07w8gSNAqQZM2yYbFP/su3C1tglp+dU0zfDeWjLl/DyV4rsIeAXgOIDw5Xep8LfIHcVDW17wF
	SS0dRVb5CDWYBrvvF+PvzfnGSu4Cjxb5jAMLg2CQcWW2Smbg1Xlw5lw==
X-Gm-Gg: AYBFou2+mTnMpqoRF3BLB3E3PkQgU6+saP73gsseyD71mw779dymkGDCsyEV44TEHwE
	qlyTCNd9CfGNHpJRUtHC6YTaEt17KHw7TSOwt8QsI0SqbBJAj9GKT3/qdnLdMwgGWOwHeqF6ind
	0G4IalUui+11afyZIVf/6dz6HGJXLqaM6sgzxi/4hDPQjf6gkg8ifC839UpPCHp7ICEOi7GuYxc
	+fOv7atqna61Kj8l8opzIw8CWlPqCCBYwUaPjK91Uh8Y1lWcqYN4rfn3HCnuPML+tx7dPkRl4Or
	hmB2RZlpy5rkwGxvSrBmDjOt6hvKs4fxiflNkYpQ8aRCV2RIY8uWZHIalZ4cSTq3CXU=
X-Received: by 2002:a05:6000:188b:b0:488:8bc1:a2eb with SMTP id ffacd0b85a97d-48e3eb98ee3mr9182564f8f.39.1792957923702;
        Sun, 25 Oct 2026 12:52:03 -0700 (PDT)
X-Received: by 2002:a05:6000:188b:b0:488:8bc1:a2eb with SMTP id ffacd0b85a97d-48e3eb98ee3mr9182531f8f.39.1792957923128;
        Sun, 25 Oct 2026 12:52:03 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1536:fc00:b838:383:1c7:6e81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebc3cfasm11844481f8f.17.2026.10.25.12.52.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 12:52:02 -0700 (PDT)
Date: Sun, 25 Oct 2026 15:51:59 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eric Dumazet <edumazet@kernel.org>
Cc: netdev-bot+sashiko@kernel.org, linux-kernel@vger.kernel.org,
	willemb@google.com, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, maxk@qualcomm.com,
	rusty@rustcorp.com.au, netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH net v3] net: gso: validate transport header before
 computing segment length
Message-ID: <20261025154757-mutt-send-email-mst@kernel.org>
References: <52b8bfe4ee848aff8ace47752352de486171d45f.1792595507.git.mst@redhat.com>
 <179290180493.3134.5235549211177646736@kernel.org>
 <20261025124546-mutt-send-email-mst@kernel.org>
 <CAL4Wiiqk9Gq5=JKk7j=uK9oNbCd7GCcHUm8BmgZ4hGCqjjo45g@mail.gmail.com>
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
In-Reply-To: <CAL4Wiiqk9Gq5=JKk7j=uK9oNbCd7GCcHUm8BmgZ4hGCqjjo45g@mail.gmail.com>

On Sun, Oct 25, 2026 at 08:40:57PM +0100, Eric Dumazet wrote:
> Le dim. 25 oct. 2026 à 17:51, Michael S. Tsirkin <mst@redhat.com> a écrit :
> >
> > On Sun, Oct 25, 2026 at 04:16:44AM +0000, netdev-bot+sashiko@kernel.org wrote:
> > > Thank you for your contribution! Sashiko AI review found 1 potential
> > > issue(s) to consider.
> > >
> > > Critical: 0 · High: 1 · Medium: 0 · Low: 0
> > >
> > > If you believe none of the issues are legitimate, please reply to each
> > > issue of Medium severity or higher and explain why the AI is wrong.
> > > If any of them are legitimate and you plan to respin, please let patchwork
> > > know by including "pw-bot: cr" as a separate line at the end of your reply
> > > (one such reply per series is enough).
> > >
> > > - [High] The patch is incomplete for the producer its own commit message
> > >   names.
> > >
> > > --
> > >
> > > net: gso: validate transport header before computing segment length
> > >
> > > This patch makes the GSO segment length helpers in net/core/gso.c check
> > > the TCP header before they read it. If the transport header is unset, or
> > > the TCP header is not in the linear data, skb_gso_validate_network_len()
> > > and skb_gso_validate_mac_len() now report that the skb does not fit. It
> > > also adds two helpers, skb_inner_transport_header_was_set() and
> > > skb_transport_header_linear(), to include/linux/skbuff.h.
> > >
> > > > diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> > > > index d6894f463bf43..11c8b295bd260 100644
> > > > --- a/include/linux/skbuff.h
> > > > +++ b/include/linux/skbuff.h
> > >
> > > [ ... ]
> > >
> > > > @@ -3250,6 +3257,29 @@ static inline int skb_transport_offset(const struct sk_buff *skb)
> > > >     return skb_transport_header(skb) - skb->data;
> > > >  }
> > > >
> > > > +/* Is the (inner) transport header, as specified by
> > > > + * skb->transport_header/inner_transport_header, in the linear data?
> > > > + */
> > > > +static inline bool skb_transport_header_linear(const struct sk_buff *skb,
> > > > +                                          unsigned int hlen)
> > > > +{
> > > > +   int thoff;
> > > > +
> > > > +   if (!skb_transport_header_was_set(skb))
> > > > +           return false;
> > > > +
> > > > +   if (skb->encapsulation) {
> > > > +           if (!skb_inner_transport_header_was_set(skb))
> > > > +                   return false;
> > > > +
> > > > +           thoff = skb_inner_transport_offset(skb);
> > > > +   } else {
> > > > +           thoff = skb_transport_offset(skb);
> > > > +   }
> > > > +
> > > > +   return thoff >= 0 && thoff + hlen <= skb_headlen(skb);
> > >
> > > [Severity: High]
> > >
> > > The commit message names bpf_skb_adjust_room() as a way to leave a bad
> > > transport header behind. It also says:
> > >
> > >     Qdisc length estimation has carried a guard against exactly this since
> > >
> > > Is that guard enough for the bpf_skb_adjust_room() case? In
> > > qdisc_pkt_len_segs_init(), the only check is for an unset transport
> > > header. Nothing there matches the thoff >= 0 check added here:
> > >
> > > net/core/dev.c:qdisc_pkt_len_segs_init() {
> > >     ...
> > >       if (!skb->encapsulation) {
> > >               if (unlikely(!skb_transport_header_was_set(skb)))
> > >                       return SKB_NOT_DROPPED_YET;
> > >               hdr_len = skb_transport_offset(skb);
> > >       } else {
> > >               hdr_len = skb_inner_transport_offset(skb);
> > >       }
> > >       /* + transport layer */
> > >       if (likely(shinfo->gso_type & (SKB_GSO_TCPV4 | SKB_GSO_TCPV6))) {
> > >               const struct tcphdr *th;
> > >
> > >               if (!pskb_may_pull(skb, hdr_len + sizeof(struct tcphdr)))
> > >                       return SKB_DROP_REASON_SKB_BAD_GSO;
> > >
> > >               th = (const struct tcphdr *)(skb->data + hdr_len);
> > >               tlen = __tcp_hdrlen(th);
> > >     ...
> > > }
> > >
> > > bpf_skb_net_hdr_pop() moves mac_header and network_header forward. It
> > > leaves transport_header where it was, unless it was equal to
> > > network_header:
> > >
> > > net/core/filter.c:bpf_skb_net_hdr_pop() {
> > >     ...
> > >               skb->mac_header += len;
> > >               skb->network_header += len;
> > >               if (trans_same)
> > >                       skb->transport_header = skb->network_header;
> > >     ...
> > > }
> > >
> > > When the DECAP_L4 or DECAP_IPXIP flags remove the last tunnel GSO bit,
> > > bpf_skb_net_shrink() also clears skb->encapsulation.
> > >
> > > Take a locally VXLAN-encapsulated TCP TSO skb whose transport_header
> > > points at the outer UDP header. If a tc program calls
> > > bpf_skb_adjust_room(skb, -50, BPF_ADJ_ROOM_MAC,
> > > BPF_F_ADJ_ROOM_DECAP_L4_UDP | ...), the transport offset ends up at -16
> > > and encapsulation is 0.
> > >
> > > A simpler BPF_ADJ_ROOM_NET shrink of 40 bytes on a plain Ethernet/IPv4
> > > TSO skb gives an offset of -6.
> > >
> > > If the program then redirects to egress with bpf_redirect(), this path
> > > runs before any of the validators hardened in this patch:
> > >
> > > __bpf_tx_skb()
> > >   dev_queue_xmit()
> > >     __dev_queue_xmit()
> > >       qdisc_pkt_len_segs_init()
> > >
> > > In that function hdr_len is an unsigned int, so -16 becomes 0xfffffff0.
> > > hdr_len + sizeof(struct tcphdr) is then truncated to 4 when passed as the
> > > unsigned int len argument of pskb_may_pull(), so the pull succeeds.
> > >
> > > Wouldn't __tcp_hdrlen(th) then read about 4GB past skb->data on 64-bit?
> > >
> > > Should qdisc_pkt_len_segs_init() get the same check, for example by
> > > using skb_transport_header_linear()? If not, could the commit message
> > > be changed so it does not say the qdisc path already guards against
> > > this?
> > >
> > > > +}
> > > > +
> > > >  static inline u32 skb_network_header_len(const struct sk_buff *skb)
> > > >  {
> > > >     DEBUG_NET_WARN_ON_ONCE(!skb_transport_header_was_set(skb));
> > >
> > > [ ... ]
> > >
> >
> >
> > Indeed. Not nice.
> >
> > Eric, you seem to have strong opinions about how to fix these
> > bugs, so, before I spend time testing: a fix like the below, acceptable?
> 
> The report looks valid, but this patches _one_ consumer of a broken
> transport_header, not its _producer_.
> 
> bpf_skb_net_hdr_pop() adjusts mac_header and network_header, but leaves
> transport_header alone unless it was equal to network_header. If the
> popped region covers the transport header (BPF_ADJ_ROOM_NET shrink,
> or a DECAP_* shrink in BPF_ADJ_ROOM_MAC mode), we keep a stale offset.
> It can be negative, or positive and pointing to the wrong bytes.
> 
> qdisc_pkt_len_segs_init() is only one reader. TSO drivers
> (skb_tcp_all_headers(), tcp_hdr() in ndo_features_check()/ndo_start_xmit())
> and the GSO validators would read the same stale offset.
> A 'hdr_len < 0' test does not catch the positive case either.
> 
> bpf_skb_net_grow() already sets the transport header properly,
> the shrink side should do the same. Something like (untested):
> 
> diff --git a/net/core/filter.c b/net/core/filter.c
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ static int bpf_skb_net_hdr_pop(struct sk_buff *skb, u32 off, u32 len)
>  {
>         bool trans_same = skb->transport_header == skb->network_header;
> +       bool trans_popped = false;
>         int ret;
> 
> +       if (!trans_same && skb_transport_header_was_set(skb)) {
> +               int thoff = skb_transport_offset(skb);
> +
> +               trans_popped = thoff >= (int)off && thoff < (int)(off + len);
> +       }
> +
>         /* Same here, __skb_push()/__skb_pull() pair not needed. */
>         ret = bpf_skb_generic_pop(skb, off, len);
>         if (likely(!ret)) {
>                 skb->mac_header += len;
>                 skb->network_header += len;
>                 if (trans_same)
>                         skb->transport_header = skb->network_header;
> +               else if (trans_popped)
> +                       skb_set_transport_header(skb, off);
>         }
> 
>         return ret;
>  }
> 
> For the decap case, BPF folks might prefer to restore the transport header
> from skb->inner_transport_header when skb->encapsulation is cleared.


OK, do you want to propose a patch, or need me to look into it?
And are you open to patching also all known consumers,
in case we miss a producer, or only the producers?

-- 
MST

