Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0D6248F64;
	Fri,  4 Sep 2026 03:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788491582; cv=none; b=bWK2WAw7vbMmx6NmnRd/I0tnxYIeDKWWJ/ArSbtHkC849nTrAPfQDQui0YF257NYV7M2jEKeEoOaeLx0TgBWUKvQOlFKtvDoEO9QIOqWnBH6tNZvjXpXSlSS2emevT0hItJDgx/yqGdipqcrdrqIia/z6h7DJOlMapL0f0GCfFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788491582; c=relaxed/simple;
	bh=dVCosq1tcEgjE/dFQV0G11RaG8J/41FPXOJOzWXwlg0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S9VYEjkRF8KUAWREUFF5Kbnn2kc8YpYN/QKBqWFQf7WkJ+SHfiUBYsTInufHMcMEYR0GPbngrkgr9ZSXuiQW4DoiUaCWltuNbUriQoNxa83+P7IRj/eSplAYMG8Gpoed1681pMSYHbz3owWyxFuekH84ITkjlpcDQ2B2zc7BIDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=VAoxUHOJ; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="VAoxUHOJ"
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6842poZ62476467;
	Thu, 3 Sep 2026 20:12:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=dVCosq1tcEgjE/dFQV0G11RaG
	8J/41FPXOJOzWXwlg0=; b=VAoxUHOJ8MQl5/Rp5OD1tAW26KcBXFYp8QJKuJ9WW
	vlbG3zL8cPQ1cAm67FuHux59QlFNPR55c53Gk5ydAFrJox6Uqv36CFOPGqcJbQ1x
	jIZnj7HVGz7Cz1+DFs2e69c2mvXE1Xst1P7hJgd4gUgw/5b5ZMLiFxIcDAkYqUiI
	ckt0x460oX038AnbiKZTqjvZuj/D9dphXZJ17H3pMEi42/XJb/juz3UxiOEP/xvg
	hGnKepMX1eOIBQT7+6aXC2wd0Is4AbuJjZZUS+KrD4HsaKkh1744R/qNLZsNxMxB
	L6EfotVmn8fTDmub8jJSFqYJgWhVA15gTZq7S7/WCZ1eQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4gfdwn1gsx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Sep 2026 20:12:20 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 3 Sep 2026 20:12:20 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 3 Sep 2026 20:12:20 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id DC00E3F70AA;
	Thu,  3 Sep 2026 20:12:15 -0700 (PDT)
Date: Fri, 4 Sep 2026 08:42:09 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <davem@davemloft.net>, <edumazet@google.com>, <hawk@kernel.org>,
        <john.fastabend@gmail.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <sdf@fomichev.me>, <sgoutham@marvell.com>
Subject: Re: [PATCH v12 net-next] octeontx2-pf: add mqprio bandwidth offload
 for NIX TX schedulers
Message-ID: <apo3CVfUw2-aXF8F@rkannoth-OptiPlex-7090>
References: <20260903023324.3078284-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260903023324.3078284-1-rkannoth@marvell.com>
X-Proofpoint-ORIG-GUID: Qf-bO91l1soTFeIK7IMrwtXUEMoDajc-
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDAyNyBTYWx0ZWRfXy1MfE+QOZijj
 0hEqzoiStWwKg6uOJBM/U0+0ZDghOuzd38oaAu8PUMOljI2CN4a2kaWUfQHM2MWvYbtxerjoj3L
 FJc6zc3cvBXxCyun4u1vfPMB83WlNgE=
X-Proofpoint-GUID: Qf-bO91l1soTFeIK7IMrwtXUEMoDajc-
X-Authority-Analysis: v=2.4 cv=ZIrnX37b c=1 sm=1 tr=0 ts=6a9a3714 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8
 a=LVN581Q_2Dy9vVtsR9IA:9 a=CjuIK1q_8ugA:10 a=ZXulRonScM0A:10
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDAyNyBTYWx0ZWRfX2slmeiWm/gzs
 9H8VxRLOkEoV8pNVIhyO7hvwCwm6YM1m6H4FV559u4K7D0DK4blM7iRRjNVFNYVIxhbyjzDWOYV
 LjSKn9Mf/8ikIguBxqwUwbp+mtXxpwws1MQqkuac4IQeTmtPazoFdIitxz0H5d+kHVW2qAfwc4f
 lmjAbvgb4PMaL3FncsRCqIzR0JoIEWuOtMEt8ODHznLNF7wFwrrqGpIV4h0CG9UFfBtapXoahnK
 DU8MM9jCkXaP0Z1N88Yvj2v6DViComr4sTYdLOgoV51KSJmU4NfaFrSbr+8pcfJM0DJCg3h3O0y
 JRVZOafuhvSu7RDWKdb/ztr9QPTk1PTDOfiygyE1geO3GjSJJEBOW1U9hYM6rplQYKlgNMr2LjC
 75bv6Ow3KlCPaR98MERFzYRHUHa8bwOLzjpM0WeAZBEar371DZ3frVifExhmYJoKcIpd+B2MW41
 UIZyEbnkzrTsZ6WU4Zw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_01,2026-09-03_01,2025-10-01_01

On 2026-09-03 at 08:03:24, Ratheesh Kannoth (rkannoth@marvell.com) wrote:
> Add TC_SETUP_QDISC_MQPRIO offload for channel-mode mqprio with
> TC_MQPRIO_SHAPER_BW_RATE. Program per-queue MDQ CIR/PIR through the
> NIX TX scheduler mailbox for each non-QoS transmit queue. When offload
> is active, allocate one SMQ per such queue, parent every MDQ under
> TL4[0], and map each traffic class min/max rate to the queue(s) in that
> class.

will address sashiko comments in v13

pw-bot: changes-requested

>
