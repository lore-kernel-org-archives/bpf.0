Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1F5286D60
	for <bpf@vger.kernel.org>; Sat,  8 Aug 2026 15:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786203203; cv=none; b=uGnlxTdI9250HrxY9xbjgaESHlBH692TQJfQaeDhWSkhD03hhF7ols7t3xBJsMK6Nx9kcY3Pupla5cFEJfRhNS4omMUADsvJqCM3Es16H+XGBvqvQCOu5Qw+oK7LC6+7/PVL7dcmU8GoXJT2IGn4IO7kn/3m5ZRGDDr37wDdjWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786203203; c=relaxed/simple;
	bh=n1KfjKfpUR15iqcsyI8AewdHHKTKixOybQJ7vGLbE4c=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=UjFCbFWWrwbcBjW1dPnbVrzFk7roF/O1sX/vZrNG80Q+MaKZ7oZ3qJn8Nhzj/ip+lEfADCfXfYSAxzTFzUt+PAT5LHp1O2ryCCfVdHpPqTPKre5nHlUTYPXu2KKir+4fQEdc2+lNZCGjPIZ40x/Cnlm96noJYuzlIpbtmbh9z0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aPYGoDiO; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aPYGoDiO"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-80cebd41372so6934897b3.3
        for <bpf@vger.kernel.org>; Sat, 08 Aug 2026 08:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786203201; x=1786808001; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=L+wa+H68v40Oc6TuXXsleyL0sXcMHjYANUloxiBM5MA=;
        b=aPYGoDiOQNxIuSK2A0gVq73JIK5A0PBdGekxVu1YuRZOglN2TVcnVOKiamFMOUVq75
         NdWE/FDzH6lHPk/Xjnz5OCiBFrtJ/Ga17Jf/F3ibyqfI5gfK+zucKHuvAMFiP4TkjoeA
         b7W+EQ8U6wqU8XcgnGNd5mGzOjkd125AdP/L+7s4jJwcfwCX5Sk5HS9f3KhCppB/eoeo
         UAiRlXDJUiJ+8FBpy85TdDif81rkEwc4dnZgsaGTvo8ouw/nEy80SJG52zBcmTjoyxGf
         IUI5ILyemorRq24CYBn5shDW3EnLsjR43c1Dn28ZxPVMWPnVHaNwFeM9Mfor/qm5VqIw
         mAug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786203201; x=1786808001;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L+wa+H68v40Oc6TuXXsleyL0sXcMHjYANUloxiBM5MA=;
        b=AsZ9guhOokBEeVsDnxrhQEDkVWhj3aufmc1Pr49jm4dsM5vTDGpqJtk2bZ5LqWSuB0
         DJ4sYZFqImrYH3HVLRtVyJXH1S9G3hjPrGKmZXV+RMBAQOVEevwS+8VAh20gv4VMOWTK
         2VFH11NglL3IXgX0Yi2fJG0obtmAWQczKi9EvJKzU+OGWDQuHfULjKk94fQdIzVDzJCf
         4Auedd7b7qTcwb5l3J8FaUShW7ezJB9L32XfAOQDv3MFaVexe1iHrKFN1p5toz7wgReH
         TzaOvb97al4q+IcCXt33XbBrD7RYA/OolmWta5jwYVzPfd7sThAWyvg3K55vZv1wtdCj
         mfsQ==
X-Forwarded-Encrypted: i=1; AHgh+Rrq9WawRfCCoGyC3Ocxiy+5FaSXPiRHaPLA6WFprJkzFH32JZQENWgPAFevqc4/yXuUNq4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPAwv0fDcgPYpsmf6pym/0CaI6OCrA65J5pW9rLQiObbAYvtyM
	B9SyWGtrC/hwl6C/CpfekffO/lFsWc4COv4VngJ84vq5FwL7/uwaRtAA
X-Gm-Gg: AR+sD139XaKdnLBKDvktaAn1BCm9WCC+3uqSvgItDAppI1D/s2MoF02EGCQQ309U0Zh
	84GWoyJUdNW796ifh102EdSL2MZK07YE85dbLkx4Ia4cead+PNGGfaz6e7byuSR+wkp+uTG6glM
	Q5JMoOEC8VnZ5zAZH+3QTQlaENX5vyzrZXze6yLOXeWk/AzMP7F6JqU2g16ljcSKzXWEbWJIjyJ
	nuC5RMVG/8vMzebRsMk5GMOI4Lsjnr1BnsrhHW1pRpqqtHzaQnMLw0XA1K9ru+3Ij5Llq3J+pXS
	StVTR6KUbXSuwFToKErYakoV2mEMe6ziLXNPhrHh2I6DmNGFwonBR+9xIAIlUwrrpzi6KIu6m1m
	1YlSG332ACGaAQFi/98Dpar2A7nYJfqS+dLC4SgbtzsePzRAALyw4JH38rLr4lHGrQ0VVsQs2JE
	X10njqfW7/A2AhQqgh8JtD5BJ4HUOPwwagmfrvxfy9V/AGOj39G5YSB1Dk1jUsmu67agQxaHe+5
	2qPbEFAQ6iMf4El21Uic9TSI/KR/k0pXFB1jfHe7lZ/UGU=
X-Received: by 2002:a05:690c:b12:b0:81e:c998:9c9a with SMTP id 00721157ae682-820224daff1mr185323067b3.17.1786203200789;
        Sat, 08 Aug 2026 08:33:20 -0700 (PDT)
Received: from gmail.com (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-823f079edb3sm27530177b3.14.2026.08.08.08.33.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2026 08:33:19 -0700 (PDT)
Date: Sat, 08 Aug 2026 11:33:19 -0400
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
 sdf@fomichev.me
Cc: wei.fang@nxp.com, 
 imx@lists.linux.dev, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org
Message-ID: <willemdebruijn.kernel.13efaee8c6042@gmail.com>
In-Reply-To: <20260807063405.688780-3-wei.fang@oss.nxp.com>
References: <20260807063405.688780-1-wei.fang@oss.nxp.com>
 <20260807063405.688780-3-wei.fang@oss.nxp.com>
Subject: Re: [PATCH v2 net 2/2] net: tap: fix wrong transport_header when
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
> In tap_get_user_xdp(), when processing a VLAN-tagged frame (e.g.
> ETH_P_8021Q), skb_set_network_header() is called first to advance
> network_header past the VLAN tag to the inner protocol header.
> skb_probe_transport_header() is then called with skb->protocol still
> set to ETH_P_8021Q, while nhoff (derived from skb_network_offset())
> already points past the VLAN tag to the inner protocol header.
> 
> In __skb_flow_dissect(), proto is initialized to ETH_P_8021Q and nhoff
> points past the VLAN tag. When the dissector hits case ETH_P_8021Q, it
> reads a struct vlan_hdr at the current nhoff via __skb_header_pointer(),
> but that offset contains the inner protocol header (e.g. an IP header).
> The bytes are misinterpreted as a VLAN header, yielding a garbage
> encapsulated EtherType that matches no known protocol. The dissector
> returns false, so skb_probe_transport_header() never calls
> skb_set_transport_header(), leaving transport_header at its uninitialized
> sentinel value (~0U).
> 
> Move skb_set_network_header() to after skb_probe_transport_header(). At
> the time skb_probe_transport_header() is called, network_header still
> points to the VLAN header (offset ETH_HLEN), so nhoff is correct and the
> flow dissector can parse the VLAN header, extract the inner EtherType,
> and advance nhoff to the inner protocol header, allowing transport_header
> to be set correctly.
> 
> Fixes: 8c76e77f9069 ("tap: call skb_probe_transport_header after setting skb->dev")
> Assisted-by: WChat:claude-opus-4-8
> Signed-off-by: Wei Fang <wei.fang@nxp.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

Only if respinning: include the explanation why tap_get_user does not
need this, only tap_get_user_xdp.
