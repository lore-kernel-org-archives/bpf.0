Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7EF3DDAF4;
	Fri, 21 Aug 2026 10:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787309676; cv=none; b=ifoxya64QUHzfjZX4PPqs+f1OGucciAOTFv9nuRGrlfAPxGtBaZ8kIENnplAkYjiUIqaJTavOxg+IHNB2t/TlYMk1RRKMpAxq2F1HEaFs4BB/4frAxQpNAIrqQEYyg6RDFzk0Ekmr5FbtF4DcO6Aifi9JDwDOEQjZV8XBvmj0rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787309676; c=relaxed/simple;
	bh=xk9UX3jvbTOlr/WZ0ZRUrNdC5t6L0WkRrjlgktWsEV0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hfk1zDTZgnHQGYN/jcy7qJeZVRpuvb1thw39KDq5gVcifZgYqHB+nWUme/J5qOfsA5H379qB8CG/jVYbYeBK/kF/ztTFD/2GMSMdqVChlVocwe2EGqKhGh2O0k690iDouaaL8yLRBa3t+kvZaF3tWMYymBtYhNGeOZUDhveHx4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=PcbeGOwx; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="PcbeGOwx"
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67L9Paxb4183272;
	Fri, 21 Aug 2026 03:54:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=xk9UX3jvbTOlr/WZ0ZRUrNdC5
	t6L0WkRrjlgktWsEV0=; b=PcbeGOwxACVB0m5+lPqeYXlGxU6mP5pQMPrBG6Yc0
	Peydwds/f/B0hYss7lnaekoVgLdtX1gGB64FMepLlslIfWRntJPzf4wVMy/DQJFH
	MGz9UqxYiwHQsNYLaOe/PGUFfMqwkdAuS9s2QZ/vFo5U4ioWka/M29CswS58KObz
	BD6hxrvC/SfKEcMM+qMBaRNDbjuHvOMashrogeXMaZDCNKUvnOTOIAVvlKR6/RWJ
	cFYYeHHZzHjgahBddRPsr/6DKxhZVX7XYcoGRQFv50BqfclXuw7fAUa2H/wvOOgi
	md9NcLWnDtYe/JQarI4KWxftFro+/mVXGyuqyy7UTlojA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4g6m1k054t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 03:54:10 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 21 Aug 2026 03:54:09 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Fri, 21 Aug 2026 03:54:09 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 62EC33F7091;
	Fri, 21 Aug 2026 03:54:05 -0700 (PDT)
Date: Fri, 21 Aug 2026 16:24:04 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <pabeni@redhat.com>, <sumang@marvell.com>
CC: <andrew+netdev@lunn.ch>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <davem@davemloft.net>, <edumazet@google.com>, <hawk@kernel.org>,
        <john.fastabend@gmail.com>, <kuba@kernel.org>, <sdf@fomichev.me>,
        <sgoutham@marvell.com>, Geetha sowjanya <gakula@marvell.com>
Subject: Re: [PATCH net] octeontx2-pf: fix NULL deref of af_xdp_zc_qidx on
 rep setup
Message-ID: <aoguTKQIJa6IZ5r4@rkannoth-OptiPlex-7090>
References: <20260820090533.2681578-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260820090533.2681578-1-rkannoth@marvell.com>
X-Authority-Analysis: v=2.4 cv=UbVhjqSN c=1 sm=1 tr=0 ts=6a882e52 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8
 a=mZbQywTzfupek0yPt5kA:9 a=CjuIK1q_8ugA:10 a=ZXulRonScM0A:10
 a=OBjm3rFKGHvpk9ecZwUJ:22 a=Oh551-UHZqmTy8JkqTUo:22
X-Proofpoint-GUID: a-v89ckQhUU12DwPlBNPqYOLChLzFIEy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDA4MSBTYWx0ZWRfXyHAXS5idqWyA
 yj7D7kxkDs6YDpNASi6fGpgNVt2z/p8lO2jhprbHmZZCy7DecXJ3tqJk92rxNh0zk4OajKhvoTo
 5XF0ois7PEfKOhWT7Ujzz60x5rJgxiB0eXXwycpIPAj59vsvIhzK64y/KKTvrOVDIxNoebLCOr1
 kBMbca9PUVPXmJSPWsp3ZJ7Py/5AowZ/C4XCH3MCjlYxbI/170pf+QLvjxDPIXeCoEClkldXHWU
 HAPVze7sXrztewe98UdB7CSYwFgYWdayL+SB0Lk5s+Mg0uMOfeI91CApm3xzc5MOoQj40v9imSr
 KrMTZnRvfPv+yakbuGyDOgTYA4np9QHfyBUP/2GATachpANKcCNNJIaWRWdHyI51VMMU+dJQe6I
 epU4HLK3ogLgkHTZhPlu22v4E5ERmDPU9wMTjMdUuQWlcFhl70qQ2zHCdHOk+XIRgyoGg2k0Cgi
 wLG3bb2ygW8J2ve00Rg==
X-Proofpoint-ORIG-GUID: a-v89ckQhUU12DwPlBNPqYOLChLzFIEy
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDA4MSBTYWx0ZWRfX/LKMFe7XZlly
 dQkVqyf03HFZahlRzRr7P/zJyfrz0wyJevq4/xu9IEfWNdXcPCkKi8SkTeEvkrKYhqv41NBip7e
 1WbRXevXbMv+v2cpxH5KGfBHRRC7r54=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_03,2026-08-21_01,2025-10-01_01

On 2026-08-20 at 14:35:33, Ratheesh Kannoth (rkannoth@marvell.com) wrote:
> From: Suman Ghosh <sumang@marvell.com>
>
> af_xdp_zc_qidx tracks receive queues using AF_XDP zero-copy and is
> allocated during PF/VF probe. Representors and other non-AF_XDP paths
> leave the pointer NULL, but several call sites used test_bit() on it
> unconditionally.
>
> Switching to devlink eswitch mode creates representors and runs
> otx2_init_hw_resources(), which reaches otx2_pool_aq_init() and oopses
> when dereferencing the NULL bitmap. Add NULL checks before every
> af_xdp_zc_qidx test_bit() use in the RSS, ethtool, XSK, and pool init
> paths.
>
> Fixes: efabce290151 ("octeontx2-pf: AF_XDP zero copy receive support")
> Signed-off-by: Suman Ghosh <sumang@marvell.com>
> Signed-off-by: Geetha sowjanya <gakula@marvell.com>
> Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>

Will address sashiko comments in v2

pw-bot: changes-requested
