Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=67.231.156.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793593726;
	b=ZdM+w1SgWTd+MzFa1v87ex9kq+XYrQ3ijR2ob1n1dqqkPxcnE7VvJE3uOatRezd0ST0m
	 4ezSOLK2xOhU1C4uF1HYti2JaDc3+yArOr63O5J/skzUee8EjY2M94d4awUubFDCri5sO
	 r34cAJIYf9AUnNGfFXYK4aBJXLCEtFUAiGeStCD+xK0XjfGlbgqx0098rQ+ZjFp0nU6zl
	 g5bFxKDlMyy9ZPAknKmiKJ4soV38J1TLXkFjA2fe+C0MsZbqV2Hp8hAynt1dTei3YhwA4
	 Ac6BazfuvXTQVgw7oTHhlNLJVo5tJczUH2WhZEdu8sJ40qxk02DnyExouiR2gA/MMDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793593726;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version;
	bh=rNOdFqSB48qoUD7rjsdQwyUlggKxho9NtULeg1Q9/7k=;
	b=0IniHeAXiJBQIGT/Uvc/Gx5BONr3+MdJxAyt0gqHb6/Fk2yY2v8A5lZR5X9LD+++kPmv
	 2xzHVUH7zNuFkviVmUG1xds3ce9Mm+wwZungTRu0JD3UltXzY8G/Lzw77zKYtEdDRJk3V
	 nSDIEishZEoIzNdRMAzQjCz1P9BpkA+QsgYV1PPsh1nJsai0xJbQ1/BnLFEdcpG87fhdb
	 QRJd5cptgG1hOKjWJh4U74DVG/NJEWgxHJgPsSk12i+oHAKpb9A5UZj+HgcYRb7VyxJcy
	 BW4mMsLV5g+xl9U7BZsGhKyVwujDXA4yU5MFEkoCzIp8p0CTeydgdQR7YlXWgd7+pYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=marvell.com;
	spf=pass smtp.mailfrom=marvell.com;
	dkim=pass header.d=marvell.com header.i=@marvell.com header.a=rsa-sha256 header.s=pfpt0220 header.b=ebzzGDHE;
	arc=none smtp.remote-ip=67.231.156.173
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714BE606A324;
	Mon,  2 Nov 2026 04:28:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 714BE606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=marvell.com header.i=@marvell.com header.a=rsa-sha256 header.s=pfpt0220 header.b=ebzzGDHE
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A2434Sc874854;
	Sun, 1 Nov 2026 20:28:05 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=rNOdFqSB48qoUD7rjsdQwyUlg
	gKxho9NtULeg1Q9/7k=; b=ebzzGDHE8XLU25ycXxqo4DQo+M8meWV2/Ab/Htuy3
	ouWHsB7T2qGON5mHnidLC/jKsU02CyXoU+0PxCQ5C8lgEoY9Yuszv5Lpv3SfvTOs
	VVlY9PG1DrY4nkU7IQItQZsEmMFesikaeHkYN+0nk+WaEwm3tmpTgZyAQ60RQ5zB
	OXArQIwuZ9eItsnYwGHkToST1VkKE7pVZVnUktQmOtDiV7lNQQ/TJw6spzv8yGAt
	rICotwuBB5B8vgtkmnCfrsasOJo/7XQXfUaVQr1Y13dK+dUM2LavuoufNlG9Lbh5
	KyJJGFljpFrIMK3C4tGA1DXCl+ph4nagnoiRiJVO8uZ2w==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4hnfuh3y2j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 01 Nov 2026 20:28:05 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 1 Nov 2026 20:28:04 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sun, 1 Nov 2026 20:28:04 -0800
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id D2BC03F7071;
	Sun,  1 Nov 2026 20:27:58 -0800 (PST)
Date: Mon, 2 Nov 2026 09:57:57 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: Nicolai Buchwitz <nb@tipi-net.de>
CC: Sunil Goutham <sgoutham@marvell.com>,
        Geetha sowjanya
	<gakula@marvell.com>,
        Subbaraya Sundeep <sbhatta@marvell.com>,
        Bharat Bhushan
	<bbhushan2@marvell.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S.
 Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>,
        "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        "Alexei
 Starovoitov" <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "Jesper Dangaard Brouer" <hawk@kernel.org>,
        John Fastabend
	<john.fastabend@gmail.com>,
        Stanislav Fomichev <sdf@fomichev.me>,
        Suman Ghosh
	<sumang@marvell.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>
Subject: Re: [PATCH net] octeontx2-pf: fix XDP frames freed as skbs on
 interface down
Message-ID: <augRTfa06G9arCkf@rkannoth-OptiPlex-7090>
References: <20261030-nb-otx2-xdp-cqe-cleanup-net-v1-1-710635c0f504@tipi-net.de>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261030-nb-otx2-xdp-cqe-cleanup-net-v1-1-710635c0f504@tipi-net.de>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDAxNyBTYWx0ZWRfX7syc/7COMkEv
 +iNec+2Eva4Z825Q9RoRtzIp1kH7rRbWL8Y4hD1K8uN0NazVXY8O0OgDOqV/9GJIptl8LbR+XLd
 cAicIKLwNQBueG0il5S34sQi7U0phgeRvYXP3F97FtuFctevYbWY2POetp6BcoqPWQfviAkBJN0
 gZQMPCxmTMXCDeMeU2Jk8DgfQuJTpIfdq1PIpUH/045oWCnMJbAB//n0P/SI3cgQxlCLBmzo4OA
 36jchcPN9quGKfRAgZW9KHJ838BTlR41l7tF63KNHGRDf04VAwtIuzdtTPiczfULgB6E4ZJogx9
 Y1EI42Q4xeoJ6ojXQ9yQUvKZtbmU1Yo281ohJzaEN4smg8JIwLcsSWT+fBbrwvoP9VaTDmHqGaN
 mibyf1Ipm2AWut11UewRqVhM96JXYeWmZlsrPHIzH3q9O+6rrzSryL/QyLpwzJJvS+iO6IVDeXq
 ZPfYuG9WCZn3y57Aqbw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDAxNyBTYWx0ZWRfX95y/vm6cov8k
 W1Ptup4kZMORp4W1VTSnO0QlL46ncc4DUjSQD0o0DbO3/U4Z5CJokAF2JpI9LYkpwSsnj0Et6o1
 uLocp03BcI+IZG9NDKCogMdSRBm+EM8=
X-Authority-Analysis: v=2.4 cv=cLZ1IVeN c=1 sm=1 tr=0 ts=6ae81155 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8
 a=B5IAThqA1797Ryvvc_AA:9 a=CjuIK1q_8ugA:10 a=OBjm3rFKGHvpk9ecZwUJ:22
 a=u34awES8lKBFzNfVaQUm:22
X-Proofpoint-GUID: 6ZmvWFl-OUIH5Mi044cphIUM-uD5WBX2
X-Proofpoint-ORIG-GUID: 6ZmvWFl-OUIH5Mi044cphIUM-uD5WBX2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_02,2026-10-21_02,2025-10-01_01

On 2026-10-31 at 01:42:03, Nicolai Buchwitz (nb@tipi-net.de) wrote:
> On interface down, the TX completion cleanup also runs on the XDP
> queues, but treats the pending xdp_frames as skbs. Freeing them with
> dev_kfree_skb_any() corrupts page pool memory.
>
> This happens when XDP_TX or redirected packets are still in flight on
> ifdown, or when the XDP program is replaced.
>
> Fixes: 94c80f748873 ("octeontx2-pf: use xdp_return_frame() to free xdp buffers")
> Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
> ---
> Pre-existing bug, flagged by the clashiko review of my ipsec transmit
> fixes for this driver [1], which seems reasonable (and fixable) to me.
>
> The other pre-existing findings there (e.g. the SA lifetime in
> cn10k_ipsec_del_state()) may be worth fixing too, but I'll leave those
> to the maintainers.
>
Thank you.

Reviewed-by: Ratheesh Kannoth <rkannoth@marvell.com>
