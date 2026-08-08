Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3CC326938
	for <bpf@vger.kernel.org>; Sat,  8 Aug 2026 15:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786203130; cv=none; b=MkEXQQXCvmobwc67GX9RpJ6m9c0EU9jOHzPCfasLFZYn9mpnFH3Cdm71839Oq0Bu2TXCrLrtEJCMRrio2+DBJmtBXZa7WduysB6NRy9fb3TeT4Pp7o5TsPsdYtRTsVjYrq5saZyyZiCz92Afqe9GPxZ7AGs37J29jnCx8ENko/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786203130; c=relaxed/simple;
	bh=avg/jQxBOIQlx57U/8c51C+uOom6aQtP9E7HIUCJewM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=HlevO4L2NpSToCIT9MMWp3WZq9D9ybq6RVFdyXdlVrRptkW0gd6bTbyM3YdpnJV8k1mJk1jm6lS66U1SSpHiUSIBwkfImnUGr9dLusZUsqpQqWs3wW3QAarLn34LpCHz5pQ7h8nl/eeFvfA+y6USwnrKTv/7mh/VttFgVQTqhpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ON+Hyay1; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ON+Hyay1"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-6689402c7bfso555560d50.1
        for <bpf@vger.kernel.org>; Sat, 08 Aug 2026 08:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786203127; x=1786807927; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=v+UUcaMhlc8IxxN5aJcZYdqNcrd7TqnKbW0pUSKDh7E=;
        b=ON+Hyay1LSWS59W3l+mnz5HGcULEhNAehZMtVyWc/VKWPtHvIOE25pPZrHlFFiYYdZ
         xCFxsth68pQ8hdvO0ALrs8Tz9AdkFm4gm2tGCjMBh0sMXjHVhpvCOQ3OZo7bMWHP4Yd7
         O2Gw6hLQpYKePWbpZMMFALE751Bo5oJ7pew2u2OLaJrRXCszMDsU1TOnch3wK5iiVRLF
         Rw9Q80E+qR0F0m3LYDfAt6ROghL9YlhiHLKYb42gL6zdZIZKCzr1pyKBd1VLzy4kgDGt
         ofYVDpufdui7HBtlSY0lRAgkuiY0OuvMT+/17lAB9u46GeszmmI7waFy+3ER27LRgU0h
         7QTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786203127; x=1786807927;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v+UUcaMhlc8IxxN5aJcZYdqNcrd7TqnKbW0pUSKDh7E=;
        b=Rxkko9g8EeYcPGoTPt2kc7ft+8xPUoK8jCD9RkKracf2X4C/Wu3LNmQlCj/e6hPQq2
         PbPWcgbGVt0iZpz509ygVMkafxxjURkPMGQbUloCln0QlcwzVFvRFKtz2vsnuKdAplJ5
         UwUEMbysrv5ZgWHKUNw+gDuWFzSSJ4gPjsWi2UJDy3HPdpCHOCUPeJMPaEj+TKJ4smvs
         ngDwya2kG4YtDLIF9aJEts1iD9bSUf33K7p6xF4bBfH+tlr5b5bprrbPPC9ZRvmHQpWc
         QWuTFwF0nD6wX+UoH88wx1GMAgDBWPNVscBtk+9llhhuLFdkKLGMtCO/kqD2QesQQgVS
         XZKA==
X-Forwarded-Encrypted: i=1; AHgh+Rr/iLbDTWza25oBYg9ZIgvTHKJr2aLtjLdPPiW/P2bkcYPc7xNV/tbF9YMeQubS5sKebmE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcGGksBthzneuLlMY59z9MFwOw/vvpHo/OgyXebqS69tDNKGf/
	mfC9YwkEX5i/UEAXQe6uXz6dUiz1cTaAenvrVNqqiUlJr4YXFhV6x7is
X-Gm-Gg: AR+sD11rJz7GOrTSyXzNg8WYlBxhKEP2c7kK2ml3jBriXwEQNkeigMSTMQ7C1iVnhGf
	+jJ3zX3VVhr0a/MCQ9zpWhUtd2kOcWkeQWaWvhshqZFyAh70BnL2H43U1iBY0fywbldIQ/zegsm
	ZcREWP3gjR8ksf4+5HuwcG/rENKUrblMZkP7r/apcZjnvDRCwcK6Mr/azRfcqaFni7ZowcFddw1
	CL2gmUKGjWp8mZvDPWDO1jVW/VZBPjJ/uLXUf/wy0+EmCP8lH6kvETBsXybL46hYXYbR30JKqDi
	2+x47ZxpW8yrDuYj0DZwbVV6xxIf7oEqLbg7Zex2VwlmA3Icr0WPTVdzwmzvX/Mz2x8hTAZykMO
	Vl6qdqaH1LdLqmghhhM7+SV5JT72ksb6Q1kIbnOeoRIjiiB1l5mnC0apFwyBpcixAVUlQAAg/J1
	v6izg4L3JSbmKeBIYW2BhKrQogwSZFbm4ZGxwRyJSIaYoM3SoGhD2H4vWG1oK3w6V0j3/cLOTB2
	N882TaW7J4SfotoM55MaMfPQ5mdQ1C9dk73gb24Jmiw84k=
X-Received: by 2002:a05:690e:1504:b0:667:c3f6:3810 with SMTP id 956f58d0204a3-66ad73a7c6amr4278650d50.49.1786203126984;
        Sat, 08 Aug 2026 08:32:06 -0700 (PDT)
Received: from gmail.com (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66acad51b8csm3171220d50.8.2026.08.08.08.32.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2026 08:32:05 -0700 (PDT)
Date: Sat, 08 Aug 2026 11:32:05 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: wei.fang@oss.nxp.com, 
 willemdebruijn.kernel@gmail.com, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 liuhangbin@gmail.com, 
 mst@redhat.com, 
 jasowangio@gmail.com, 
 andrew+netdev@lunn.ch, 
 ast@kernel.org, 
 daniel@iogearbox.net, 
 hawk@kernel.org, 
 john.fastabend@gmail.com, 
 sdf@fomichev.me, 
 liuhangbin@gmail.com
Cc: wei.fang@nxp.com, 
 imx@lists.linux.dev, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org
Message-ID: <willemdebruijn.kernel.7f71161e0a6b@gmail.com>
In-Reply-To: <20260807063405.688780-2-wei.fang@oss.nxp.com>
References: <20260807063405.688780-1-wei.fang@oss.nxp.com>
 <20260807063405.688780-2-wei.fang@oss.nxp.com>
Subject: Re: [PATCH v2 net 1/2] net: packet: fix wrong transport_header when
 sending VLAN-tagged frame
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

wei.fang@ wrote:
> From: Wei Fang <wei.fang@nxp.com>
> 
> In packet_parse_headers(), when processing a VLAN-tagged frame,
> skb_set_network_header() is called to advance network_header past the
> VLAN tag to the inner protocol header. skb_probe_transport_header() is
> then called with skb->protocol still set to the outer VLAN EtherType
> (e.g. ETH_P_8021Q), while nhoff (derived from skb_network_offset())
> already points past the VLAN tag to the inner protocol header.
> 
> In __skb_flow_dissect(), proto is initialized to ETH_P_8021Q and nhoff
> points past the VLAN tag. When the dissector hits case ETH_P_8021Q, it
> reads a struct vlan_hdr at nhoff via __skb_header_pointer(), but that
> offset contains the inner protocol header (e.g. an IP header). The bytes
> are misinterpreted as a VLAN header, yielding a garbage encapsulated
> EtherType that matches no known protocol. The dissector returns false,
> so skb_probe_transport_header() never calls skb_set_transport_header(),
> leaving transport_header at its uninitialized sentinel value (~0U).

Not for this patch, but: having a mismatched skb->protocol and
network header offset is asking for trouble anyway.

The blamed commit states that this block is here for GSO packets, and
the mismatch will by fixed up when skb->protocol is updated in
virtio_net_hdr_set_proto. But that only updates GSO packets, while
this block affects all VLAN tagged packets. Both GSO and non-GSO
should be treated similarly throughout the stack. One approach is
setting skb->protocol here. But that does mess with anything matching
VLAN packets. There does not seem to be a perfect solution..

> Move skb_probe_transport_header() to before skb_set_network_header(). At
> the time skb_probe_transport_header() is called, network_header still
> points to the VLAN header, so nhoff correctly points to the VLAN header.
> The flow dissector can then parse the VLAN header, extract the inner
> EtherType, and advance nhoff to the inner protocol header, allowing
> transport_header to be set correctly.
> 
> Fixes: dfed913e8b55 ("net/af_packet: add VLAN support for AF_PACKET SOCK_RAW GSO")
> Assisted-by: WChat:claude-opus-4-8
> Signed-off-by: Wei Fang <wei.fang@nxp.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>
