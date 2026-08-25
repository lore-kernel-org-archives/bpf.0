Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365CA33E36A
	for <bpf@vger.kernel.org>; Tue, 25 Aug 2026 16:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787674348; cv=none; b=K4YajtEDH5D5D2gV1u7kcAhHXfVPLOV3BM1XfyXO2npvZHG+V46P2btYDSLSMZ3fr3zFggEjwm6pUcXNiX9S/y0wd4qlEIi6/j+oadG7pdClsw3rBJILzI350RHduXJc7F2v6E/tNAAuFqT4UsFYkQceFjM1KqQzFo6MFH6jcLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787674348; c=relaxed/simple;
	bh=wXrgHy62T0tNDn8P/4NZ8q+YEMGB8yHeI1pf6IWRHTM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=dFbl891y+bJGydfCfN2P6s+rm8PjvUcgOtDBfz8ATT5/cRxCA5Vgx3wjaK0Bk62k4wpOJkjW0DE0z48i0MnIbzIscVsWRjyhQ78L1dRlvPKfrqpxYvzW3WMYxCdazFHZ30Utxb1p5erD4HUY59dlhl0mKcq3UQsG0TOxvhg97eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jgBoyzun; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jgBoyzun"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-81dfdbd86d1so63725167b3.1
        for <bpf@vger.kernel.org>; Tue, 25 Aug 2026 09:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787674346; x=1788279146; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=01+frOfya8cSKRerweuTqMaNxLlq2qDmJSW1y4jWqwo=;
        b=jgBoyzun7CojyfCESxsmmfgmuzwEnU+tjz4NyZnY7GinVGXAoUF2uhZ72sP3oWsWki
         Sjcmmm0RL7ITTZs/EnwNw+8cp/AtNenU3vDc3D6mTNfOutYLFz8Pe1HKtO54EzTrMkwv
         zM3MLWCeoJ7TvoqG43U9aSG2Kh6LjuolvPUsMdcVUuYo+1JFx25VrRHNQI1rOUYIUSre
         e8pkOk91xVuL5mBbgxKn/T7Du1QsBG2mFvG73XFcwSjZV5RUMR52GCKDGOktZYGad5+e
         NZPmIrHc3ggtLSmpWx10VKsos2RoIsy6saPk/yninUkosU2T9tVvi+AB28EXy2tyRNkX
         4nxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787674346; x=1788279146;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=01+frOfya8cSKRerweuTqMaNxLlq2qDmJSW1y4jWqwo=;
        b=l4hhWt21SEz4m6GvcHchF3wZD2ixRKqtyFRNQikb5mhDYdMFtZDfiNueCuVwmUL/oQ
         6DJyuQDM8o9VkFLXulvEZ384pbZ4PGCyYGAlMLP1p+b3dhE5rJKgX428a251lalceeZp
         FXtT4SquM2VnRN4pqNAp/absjbnsTnQQStTKsQyd1ux9A4M5CvY+nrUZHtFxi6vgIklg
         03JOpSPSmcOSzT44QIuMZPBKjvtJVS2XnqQncM2vFifdIPMZ9KlnZn0J08CR26xb0euh
         wvq/iKNQOLynGSbZO5+Cl3HXUteMM9NcDdil35t01rAKHBbVF3klaAkt8vpfqr7YxUL1
         AHoQ==
X-Forwarded-Encrypted: i=1; AHgh+RpGkDRSGzh0gTN76+LIX9es3OHI0chgSIqsuocvk4sHteg7VbSKF4vZE6TJHga37QCFKlg=@vger.kernel.org
X-Gm-Message-State: AFuF++kvy+Mji7yB7H7QyJUGdR3GdYsA+Z7nYGMD4J/uPE3ngliqhD5p
	BGQDwOurJYA9AXZQ5on0wbXVys02WwV6QmT4bZlthmQGpsWf6P1/BFFZ
X-Gm-Gg: AR+sD11c66EWhEjV3sBgH2VFUkTYPHK6G1n8hX/g48fuKDx2k5aw5/9S+QgierMORT/
	jeS6f99Ivgc5paRrLaVOSoSwA0t2rs1tvxqTm9DqTE6ZzBIGFCPGgELw2+GCSTYJ4ia+m7dBl5H
	b04vruYsPb/hRekqL0zYOsmgVOkvEaGblk7+kJvL+EdHMTSa7Szan2P4dEXp9qNadfl6ySxHZ1Z
	YNmxAfcsmQRR16szdmyvaKQNU2neh1vqYw0Sa7gNKRzdAiqk7dzPa4u+9/SAhi6kNyQXzDiOSmH
	3tBhqc2zCsGUYstBsispyPNugDzDtuyLEU0x/pvxMAO2ErKrYCwoeFFHgpD7Qk2CC7YNhfCli2C
	Gbcreo8f4HzlpFez5Q8KPa0mpSiEjyMSa7AHHWxz4u+mqApHwH4yQ9QkAFeyxFiUHhVs2s1FloS
	e8KgITnFuhkJbXjD1ns6flpwj3t5tBLr0dFPrxb54zrioz8ZcQpmLStZ2Ptl+KKobrvnmGMH35K
	++xXnEYQEWe1V9CyiQan14k/+i5dUNcwue1fLsCuP9MYH2+VTHT
X-Received: by 2002:a05:690c:e1d7:20b0:80e:5236:b944 with SMTP id 00721157ae682-85473d9e59amr26963037b3.10.1787674345937;
        Tue, 25 Aug 2026 09:12:25 -0700 (PDT)
Received: from gmail.com (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-85705387614sm2221077b3.2.2026.08.25.09.12.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 09:12:25 -0700 (PDT)
Date: Tue, 25 Aug 2026 12:12:24 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>
Cc: Mirja Kuehlewind <mirja.kuehlewind@ericsson.com>, 
 "shaojijie@huawei.com" <shaojijie@huawei.com>, 
 "shenjian15@huawei.com" <shenjian15@huawei.com>, 
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, 
 "eperezma@redhat.com" <eperezma@redhat.com>, 
 "jasowang@redhat.com" <jasowang@redhat.com>, 
 "virtualization@lists.linux.dev" <virtualization@lists.linux.dev>, 
 "mst@redhat.com" <mst@redhat.com>, 
 "xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>, 
 "pabeni@redhat.com" <pabeni@redhat.com>, 
 "edumazet@google.com" <edumazet@google.com>, 
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, 
 "corbet@lwn.net" <corbet@lwn.net>, 
 "horms@kernel.org" <horms@kernel.org>, 
 "dsahern@kernel.org" <dsahern@kernel.org>, 
 "kuniyu@google.com" <kuniyu@google.com>, 
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
 "dave.taht@gmail.com" <dave.taht@gmail.com>, 
 "jhs@mojatatu.com" <jhs@mojatatu.com>, 
 "stephen@networkplumber.org" <stephen@networkplumber.org>, 
 "xiyou.wangcong@gmail.com" <xiyou.wangcong@gmail.com>, 
 "jiri@resnulli.us" <jiri@resnulli.us>, 
 "davem@davemloft.net" <davem@davemloft.net>, 
 "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, 
 "donald.hunter@gmail.com" <donald.hunter@gmail.com>, 
 "ast@fiberby.net" <ast@fiberby.net>, 
 "liuhangbin@gmail.com" <liuhangbin@gmail.com>, 
 "shuah@kernel.org" <shuah@kernel.org>, 
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, 
 "ij@kernel.org" <ij@kernel.org>, 
 "ncardwell@google.com" <ncardwell@google.com>, 
 "Koen De Schepper (Nokia)" <koen.de_schepper@nokia-bell-labs.com>, 
 "g.white@cablelabs.com" <g.white@cablelabs.com>, 
 Ingemar Johansson S <ingemar.s.johansson@ericsson.com>, 
 "cheshire@apple.com" <cheshire@apple.com>, 
 "rs.ietf@gmx.at" <rs.ietf@gmx.at>, 
 "Jason_Livingood@comcast.com" <Jason_Livingood@comcast.com>, 
 "vidhi_goel@apple.com" <vidhi_goel@apple.com>, 
 Parav Pandit <parav@nvidia.com>, 
 Willem de Bruijn <willemb@google.com>, 
 ij@kernel.org
Message-ID: <willemdebruijn.kernel.28ce4bc2544df@gmail.com>
In-Reply-To: <PAXPR07MB7984F0C072220066856DD8ACA3AF2@PAXPR07MB7984.eurprd07.prod.outlook.com>
References: <20260804213510.673084-1-chia-yu.chang@nokia-bell-labs.com>
 <20260804213510.673084-2-chia-yu.chang@nokia-bell-labs.com>
 <20260811173017.3d18dfdc@kernel.org>
 <PAXPR07MB79849A3F1724DBB2DA8EA20AA3DC2@PAXPR07MB7984.eurprd07.prod.outlook.com>
 <20260812155430.6ec81eec@kernel.org>
 <PAXPR07MB7984E3E73868BF8966821C27A3DB2@PAXPR07MB7984.eurprd07.prod.outlook.com>
 <CAF=yD-LQbndjPZiXcfA6fMp6msza_+YdzqqwyeUDVTdOCOHhDw@mail.gmail.com>
 <47BE8A8A-F80C-4C30-BC95-C85FEBFFB606@ericsson.com>
 <PAXPR07MB7984ED42ED0849D3A9AB8C19A3DA2@PAXPR07MB7984.eurprd07.prod.outlook.com>
 <willemdebruijn.kernel.c248a28f9c86@gmail.com>
 <20260814120121.50e61d01@kernel.org>
 <CAF=yD-L1-Sxz9uyP_4WqtNRJHnwTVMhQba_KF-=Eiy=d9Jf-qA@mail.gmail.com>
 <PAXPR07MB7984F0C072220066856DD8ACA3AF2@PAXPR07MB7984.eurprd07.prod.outlook.com>
Subject: RE: [PATCH v5 net-next 1/2] net: update comments for SKB_GSO_TCP_ECN
 and SKB_GSO_TCP_ACCECN
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

> > > On Fri, 14 Aug 2026 09:34:01 -0400 Willem de Bruijn wrote:
> > > > > Current SW GRO sets SKB_GSO_TCP_ACCECN when the flushed skb carries CWR in tcp_gro_complete():
> > > > > if (th->cwr)
> > > > >     shinfo->gso_type |= SKB_GSO_TCP_ACCECN;
> > > >
> > > > And I suppose it follows correct AccECN rules for coalescing.
> > > >
> > > > That is a performance regression from RFC 3168 ECN, as it allows for 
> > > > less effective coalescing. I have no intuition how much it will 
> > > > differ in practice.
> > > >
> > > > > For HW GRO of a legacy device that implementing RFC3168 semantics, setting SKB_GSO_TCP_ECN seems reasonable.
> > > > > However, such a device would not be able to preserve ACCECN signaling across the GRO/GSO.
> > > > > In that case, if preserving AccECN signaling is required, disabling HW GRO may indeed be necessary.
> > > >
> > > > Right.
> > >
> > > I'm still not following.. Maybe Willem can ELI5 what the problem is.
> > >
> > > _SW_ GRO follows only the AccECN rules.
> > > But if HW GRO follows RFC 3168 and we mark the aggregate as 
> > > SKB_GSO_TCP_ECN - TSO will also abide, and segmented output will be 
> > > identical to pre-GRO input.
> > 
> > +1
> > 
> > > Are we trying to ban RFC 3168 behavior in HW purely to match SW?
> > 
> > I think that's the intent here?
> Hi Willem,
> 
> I think we can still change SKB_GSO_TCP_ECN into SKB_GSO_TCP_ACCECN on the RX path, even if HW GRO and SW GRO use different aggregation rules.
> Currently, SW GRO flushes when the CWR state changes and sets SKB_GSO_TCP_ACCECN when the resulting skb carries CWR=1.
>
> 
> For HW GRO, if the device flushes immediately when a CWR=1 packet arrives, there is no need to set either SKB_GSO_TCP_ECN or SKB_GSO_TCP_ACCECN.
> In that case, each CWR=1 packet is emitted separately, and there is no need to preserve multiple CWR indications through GSO.
> So, if the HW can be confirmed to always flush CWR-marked packets without coalescing them, preserving multiple CWR indications through GSO is not required.
> In that case, using SKB_GSO_TCP_ACCECN would not provide any additional benefit.

I agree.

The difference on transmit is that SKB_GSO_TCP_ACCECN will copy the
ECN bits to every segment, whereas SKB_GSO_TCP_ECN will only set the
bits on the first segment.

From commit 023af5a72ab1 ("gso: AccECN support") that introduced
SKB_GSO_TCP_ACCECN:

    With RFC 3168 ECN aware TSO (NETIF_F_TSO_ECN) CWR flag is cleared
    starting from 2nd segment which is incompatible how AccECN handles
    the CWR flag. Such super-segments are indicated by SKB_GSO_TCP_ECN.
    With AccECN, CWR flag (or more accurately, the ACE field that also
    includes ECE & AE flags) changes only when new packet(s) with CE
    mark arrives so the flag should not be changed within a super-skb.

Makes me wonder what SKB_GS_TCP_ACCECN adds. Copying bits
from the GSO skb to all segments is the default. SKB_GSO_TCP_ECN is
an indication that the NIC knows how to diverge from this default for
these specific bits.

That commit confirms this:

    If NIC is completely unaware of RFC3168 ECN (doesn't support
    NETIF_F_TSO_ECN) or its TSO engine can be set to not touch CWR flag
    despite supporting also NETIF_F_TSO_ECN, TSO could be safely used
    with AccECN on such NIC. This should be evaluated per NIC basis
    (not done in this patch series for any NICs).`

> 
> The problematic case is when a HW GRO aggregates multiple packets carrying CWR=1 and only sets SKB_GSO_TCP_ECN.

The driver of such a device could be updated to set SKB_GSO_TCP_ACCECN
or not set any such ECN GSO flag.

The driver of other devices that do follow RFC 3168 semantics will
continue to have to set SKB_GSO_TCP_ECN on the GSO skb. It is quite
plausible that few or no devices currently support ECN in their HW-GRO
coalescing.

> During GSO, only the first output segment would carry CWR=1, which loses the remaining CWR signaling information required by AccECN.
> In that case, changing from SKB_GSO_TCP_ECN to SKB_GSO_TCP_ACCECN would preserve the original signaling by ensuring that the segmented packets carry the correct CWR information.
> As I understand RFC3168, receiving additional CWR-marked packets is harmless, because once a valid CWR has been received, the receiver already stops echoing ECE.

Agreed.

> Additional CWR indications do not change the receiver state.
> This would have a performance impact since it disables HW TSO for the skb and falls back to software segmentation.

You mean if the device advertises NETIF_F_TSO_ECN, and GSO skbs may
contain AccECN signals, the host must downgrade from TSO to GSO to
avoid corrupting the signal?

The cost of that would be significant. Not something to do for
established environments. But technically seemingly correct, at least
for packets with non-zero ECN bits.

> But IMO it preserves correctness for both RFC3168 ECN and AccECN.

Side-note: this thread probably has way too many Cc: for this narrow topic.
