Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=67.231.148.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793538581;
	b=gN6gNyAGjmwcuS601bwKAOUJs+35q9jh5AYaM4s21wtWgMYLgJS5eYcrCxq7zyBc7K18
	 VEjlGWAKJSndcs+gfYUTwGmILcD1GsUCVTLSPiBAgqdClFvJgNwkgt+6uVmgiyAg0BSdl
	 T6+lqFMWrYhhsIsVhDaKWLou2McTAjsrkFrnDaV9MzXl232ZHY+nwU7S5wJbFMFFV9qVY
	 nzQPxge6Bh6RfL2HLavak3A3QBYgRV/gBnE4rUi/MCZZYE7zzBrBLurBA5PO5T80/O2QC
	 syG7Z41Y/M6YpEX22O8rhMmRhZIkCZJi+TUT0WTN+7V7TT4fXInWu0fAtykAYuoR5NA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793538581;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version;
	bh=POsgNR6eNljnTfEYpS6eyYrflzHZ116+kioTHKvudNs=;
	b=E15rr28S/svwtqxdjT4nHKKn/eNLP9iyDZpJdA+3cgEBbiUwGhhbCZiktcCgI4wJzGA4
	 XnoGS6TerxjGi6pbT8evoygG5YFkVdpELueigj0Wl5LYnorLy9uqGNfwTJ7Xq4mDLpm6B
	 GKEXu54p4ag1sZM39Rp4dIJneSFefTHZ0Nlx7DY/9MLiqeUi3s+j9okS/RLcj9Rh4o0IL
	 mSy0FTQD5Qe5Yx5x6hbMyem+wK7fgShxqHG4FMvJ5yQt3bnhAvq8VvLxwn6hcr2Rj7yMJ
	 5lTjudYeJPrS19ElPAlOuboR8T1Ukwc6YekIgB96giNEiWJ66T6xZ6oVCTqFeYq2+hg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=marvell.com;
	spf=pass smtp.mailfrom=marvell.com;
	dkim=pass header.d=marvell.com header.i=@marvell.com header.a=rsa-sha256 header.s=pfpt0220 header.b=jGZbdmzX;
	arc=none smtp.remote-ip=67.231.148.174
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61371606A324;
	Sun,  1 Nov 2026 13:09:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 61371606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=marvell.com header.i=@marvell.com header.a=rsa-sha256 header.s=pfpt0220 header.b=jGZbdmzX
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A1CTBgR2419686;
	Sun, 1 Nov 2026 05:08:57 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=POsgNR6eNljnTfEYpS6eyYrfl
	zHZ116+kioTHKvudNs=; b=jGZbdmzX08kECHd275c1FrgBm/rHizlZK6z3DGlMs
	prXixOYl4te5j+sDBjwiJzvo9SjwKoCFOOkwY9sfCyjHdYcwwwLeDcTjwkZhd4jM
	++R+ChYvplnIu8JQxRkObni82oH4uBT4IIYWV8Y0rywEyDE8hoiI79Na7kA2cN6G
	zJq4Asqw3VN1WwyGG0dZwohqBNNKrFdtVnOLSSmpYmLWjyjTppnbZ0bU4k+XUrKK
	pztCsAZbWkvYKhcGnwx1H+F4sCGncVzW2Z692akCCtTFtbyus6PrRwMTmb0Bh7gI
	d3AqrjOE3DixEpWfFsyHFvv50G/sHr80Gb2166ArjWR/w==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4hp5fd020x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 01 Nov 2026 05:08:57 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 1 Nov 2026 05:08:56 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sun, 1 Nov 2026 05:08:55 -0800
Received: from nitinsj-apex-workbox (unknown [10.28.40.177])
	by maili.marvell.com (Postfix) with SMTP id 4C4C93F7075;
	Sun,  1 Nov 2026 05:08:48 -0800 (PST)
Date: Sun, 1 Nov 2026 18:38:53 +0530
From: Nitin Shetty J <nshettyj@marvell.com>
To: Marcin Knap <marcin.knap@vecima.com>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>,
        Przemek Kitszel
	<przemyslaw.kitszel@intel.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David
 S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>,
        "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Magnus Karlsson
	<magnus.karlsson@intel.com>,
        Maciej Fijalkowski
	<maciej.fijalkowski@intel.com>,
        Stanislav Fomichev <sdf@fomichev.me>,
        "Simon
 Horman" <horms@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        "Daniel
 Borkmann" <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>, <jtollet@cisco.com>,
        <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
        Joshua Washington
	<joshwash@google.com>,
        Harshitha Ramamurthy <hramamurthy@google.com>,
        "Sunil
 Goutham" <sgoutham@marvell.com>,
        Geetha sowjanya <gakula@marvell.com>,
        Ratheesh Kannoth <rkannoth@marvell.com>,
        Subbaraya Sundeep
	<sbhatta@marvell.com>,
        Bharat Bhushan <bbhushan2@marvell.com>
Subject: Re: [PATCH bpf v2] xsk: Do not free ZC Rx buffer when the Rx ring is
 full
Message-ID: <auc55SPJVtJNhpNn@nitinsj-apex-workbox>
References: <20261030-xsk-zc-rx-double-free-v2-1-cf01d4a9f3f7@vecima.com>
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
In-Reply-To: <20261030-xsk-zc-rx-double-free-v2-1-cf01d4a9f3f7@vecima.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAxMDA1MiBTYWx0ZWRfXzkctue3SCKIW
 7Cn0Jhc1bFPBR88rY6odabuL0zLvhgmEYMrgFITbXg+WGkw3beESsB7hrOxqC9rw1Bq49Ilb+0X
 sZGKlD8WNnSS6cbySPpl0mern8MBVxjs+CHFP0FDop7KTMdd0IYPsv9eBxZxIyecXKQr9X3VWSv
 JJ5/xthcQHwMytKoNdu1Sm4LGjU9GEJsjPN7Ltpzk+3epb3sRBsFKhZKLq/KKYQqXck6P80xTpP
 Bv+DvoT7CJxfVltpKHE9coVZMc4hKXtxBucRGiDr6oQzplrZeBZD0zIkLBSJRlzqpYM/8JccN1c
 2YMKNJ/JCwYlYLvashe0KHt+9LP7BmLVDCMgoXGFMuxG0PSXjEupLA5tEwyxI+M4VimO1dK772x
 32Zdx/vZ77OsW2aPaFL+gB7FsCVd0cGBltPsEkwRLb52CSTgI7EcaykyklzviPRGgi6IZAdAaTt
 zJG2bvJvbM3B485IlHg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAxMDA1MiBTYWx0ZWRfX8RCS6d08dSYW
 //vMIMPZS+4FF8csNIIXxJCQdYCUVYaI1fKKWXFhO3FLcwnvKCYbHWsr+dDME5UM8r4ya1VVlM5
 UIFJIc9C6idBG3y7w/se0FmWoFoa1e8=
X-Proofpoint-GUID: uFRGXjxDV5PgyjAoYMCm7Ia5Fkyxo_3i
X-Authority-Analysis: v=2.4 cv=bszZl0ai c=1 sm=1 tr=0 ts=6ae739e9 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=eRKzQBkOje3ih_7c:21 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22 a=TtqV-g6YmW1Jfm2GSLaY:22
 a=VbtP2V50AAAA:8 a=M5GUcnROAAAA:8 a=HB_4VZhdTIFFo8uudmsA:9 a=CjuIK1q_8ugA:10
 a=khSs6UnhJ5OSbz3Ji1I1:22 a=OBjm3rFKGHvpk9ecZwUJ:22 a=Qh0BGDiy-lhdOgvBjkqA:22
X-Proofpoint-ORIG-GUID: uFRGXjxDV5PgyjAoYMCm7Ia5Fkyxo_3i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-01_04,2026-10-21_02,2025-10-01_01

On 2026-10-30 at 13:44:17, Marcin Knap (marcin.knap@vecima.com) wrote:
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
> index 90af9b9044aa..6d10c132f61c 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
> @@ -1555,7 +1555,8 @@ static bool otx2_xdp_rcv_pkt_handler(struct otx2_nic *pfvf,
>  				*need_xdp_flush = true;
>  				return true;
>  			}
> -			return false;
> +			xsk_buff_free(xsk_buff);
> +			return true;
>  		}
>  
>  		err = xdp_do_redirect(pfvf->netdev, &xdp, prog);

the Octeontx2 changes look good.Thanks.

Reviewed-by: Nitin Shetty J <nshettyj@marvell.com>
