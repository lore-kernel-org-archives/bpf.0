Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91DAF378D8D
	for <bpf@vger.kernel.org>; Tue,  5 May 2026 16:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777999153; cv=none; b=PUSyQEWgqy2kQxyX+IcJOxbwf4mLcUlva2ylKqDAVpUl0GhLo5RELv9U/SK/bxYMbBvbEuddSqWjylSZd2EZ7dVVhTjz8uy/8lurpGLoJfVMsR6SNosFnpVGBa2tTtlKvE7wtBuXnI0kRZK6SzxlbzAaNI3LedrTaCiXrpFkWcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777999153; c=relaxed/simple;
	bh=xyEx4G2wKir++EItxT2osj5+hfVEdh42Mr6R7Zl3tOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jLx2ukil7lvUHp0hnfu5/4XEfBtPCR2MESRrbmmQLi0kZ05d3Fs4kUqA0ccB9WlQf1+iNXB/Bssb+zZCdXOdazB+4zl1ehyZInyksbw8sL4yJxMKIksEW5va8RrCG/CK/Yi3KVdX1O30bFHuRMRwM7uaoL1FkzVPYVTkjU4Eli0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=M+F8y2Fs; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VuMFEPFL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="M+F8y2Fs";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VuMFEPFL"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 645FtwDG2445826
	for <bpf@vger.kernel.org>; Tue, 5 May 2026 16:39:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=kcvBYxHAlvNI6sLP0AoxikyR
	e9LehpKzs6txgD8Qv9A=; b=M+F8y2Fs4/hg36XqYjUZ2aG/CZNEeOdd7UKhLo9j
	8Y0UqL088LknMkhUQRRyzARuoO+oNdGh9YxrOOAxY/U7s1HsLB3jq8q8b572Tqb5
	2J2XraWuZBz9LdfA9uEUNIDzVwbtTmdX/TNaSRaMM6PHAW6gsR0T2etdCqgyjR9W
	OtKYqNDll3aDE4gWGrusBKXkSTVYtXtVbLt7Z4gD7cN8n6QH/CpYQCimZn7DQWrF
	m3GQg+lAgKMKOaKN63Lthabq8F8NRozdfQsqR4fdsT1/DalMjesfDByXRSWYZ8Ws
	d0ZxdzHiQipQdq+w9AFeL3epabsWRpQeHSAmWpEXG/tBww==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dykmhr6qe-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Tue, 05 May 2026 16:39:09 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2aad5fec175so73832985ad.2
        for <bpf@vger.kernel.org>; Tue, 05 May 2026 09:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777999148; x=1778603948; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kcvBYxHAlvNI6sLP0AoxikyRe9LehpKzs6txgD8Qv9A=;
        b=VuMFEPFLEnWQfKlZNxTOy21MJ4cTuCEYI+jFFeGNEuyLcV61JFa2+/bg5tns4qzngr
         +V438+52M4/+U12YdSyhzaytn22IZ3Ca5TNE089SIsSAMs4YicVY1RGxrW5ki5xmbdMZ
         P5BHwB+e3rXSdElDvbIYTJtmC5ixF6zRKor+UYDFWgBRY951cUmuDXnSEAGHZbdNVOSk
         y0fOQY39aHi3gpRKiC0JWq271Ps1eER2XrDly2dZ60B79naNbPkMJ0QdOndwIY4I8CjS
         EDA2SliByOW6fQpnoY6tBsUSjmS1kSa+xcu9JPyrpzsG0QCWT/modDBSGCppXq2yKveV
         S1Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777999148; x=1778603948;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kcvBYxHAlvNI6sLP0AoxikyRe9LehpKzs6txgD8Qv9A=;
        b=cMFK3j8z1LZUqwUeTQwlLWqOUAtOkPpSH0yV7Tzr3BxIwgeOSEvPcV2EdRbk9f7/Zv
         1BLR0qyLGBUDYw3SphbPVOuuIVN5E8/raAMmMeivGTJ4nBRxdqNoZGQBrAdE0KepyUa7
         WhbtdkSMIMk5pOgnX+2HmI6KgbaTPcIsGHwbdYg8snl42REecTPTl+ts+h9FuuUXnWEL
         x5TYEc2GjZQC8THplgvgpUfsYIf4bKGj5rQFHIQZ4XbIZTlwznNKLWmQzttm0Ovoq8gJ
         dd5L+HrfE5VLjQqW1hgilDaxxlZLj3ulHkX6nfECmZrnMcUmkhZSEnJcqisHtaZ4VEgQ
         0W5w==
X-Forwarded-Encrypted: i=1; AFNElJ/mzYa/dtgvGh8d/zBPPO0YpWMUW8Wxjk6aHz/pGfkhlfy3iEgPnL34Ne0BGQyEMi9ow/g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7Xc4GJWB/yXvXKuJDNV/toPlK2wZg1cVL6ToTmPKydU3TjXKR
	8Um43cq4N8ar4d7MePP1DrRRmmcuay6+tOTleCr9jc1/yX31wUFeS1SSTds0fpBtuSaPWxXOB4w
	HLPiqFuELjn7hKzOfCWb5rsnpOHZatVnRLbWhsQ3K5tvRBvmNbo6LmoM=
X-Gm-Gg: AeBDies0/rUgY8zqyLgZnXzEU3GU+PkFweVL3jog3EZt0QmyYdYKaf4UpXnrME+FtkQ
	AshxHfmHJUKYbHfOHirsiHQZPYo3Faii2/ZiwAF3m/f+WbALhNfX4lUf5Igj/CSfoSWjy8n98Cs
	IJ0fuQ/fswE3StGYWLqxGvwEo1IhwoWgGBItagfsZSFoGvZWtimd4vL1KT2GA/4o2OIH932+S6f
	Rr3xAxrUBzxw6UmUPSPNdzFBGjiz0WajxkZTJuPLTl1um6rjnlGx6gZ9fmxKSzTpwGfPFSodSNv
	5MG2ZmJ0/AOQ1vLnRVDilshwKU0QR7KNZn0rGbZoVTlgT/HKQnKQj4+kgWk8g2MKLcg9TbZL+aC
	LEyXc/aikc5BpTLiTqwO+zcIebYFZN8F247ocHy+ChaTMQg==
X-Received: by 2002:a17:902:ebd1:b0:2b9:eb6a:68b5 with SMTP id d9443c01a7336-2b9f28348efmr149463495ad.38.1777999147952;
        Tue, 05 May 2026 09:39:07 -0700 (PDT)
X-Received: by 2002:a17:902:ebd1:b0:2b9:eb6a:68b5 with SMTP id d9443c01a7336-2b9f28348efmr149462845ad.38.1777999147261;
        Tue, 05 May 2026 09:39:07 -0700 (PDT)
Received: from oss.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9cae15fb6sm148392135ad.43.2026.05.05.09.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 09:39:06 -0700 (PDT)
Date: Tue, 5 May 2026 22:08:51 +0530
From: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
To: Alex Elder <elder@riscstar.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, maxime.chevallier@bootlin.com,
        rmk+kernel@armlinux.org.uk, andersson@kernel.org,
        konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, linusw@kernel.org, brgl@kernel.org, arnd@arndb.de,
        gregkh@linuxfoundation.org, Daniel Thompson <daniel@riscstar.com>,
        a0987203069@gmail.com, alexandre.torgue@foss.st.com, ast@kernel.org,
        boon.khai.ng@altera.com, chenchuangyu@xiaomi.com,
        chenhuacai@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
        hkallweit1@gmail.com, inochiama@gmail.com, john.fastabend@gmail.com,
        julianbraha@gmail.com, livelycarpet87@gmail.com,
        matthew.gerlach@altera.com, mcoquelin.stm32@gmail.com, me@ziyao.cc,
        prabhakar.mahadev-lad.rj@bp.renesas.com, richardcochran@gmail.com,
        rohan.g.thomas@altera.com, sdf@fomichev.me,
        siyanteng@cqsoftware.com.cn, weishangjuan@eswincomputing.com,
        wens@kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 10/12] net: stmmac: tc956x: add TC956x/QPS615
 support
Message-ID: <afodG9uuopgfvSmu@oss.qualcomm.com>
References: <20260501155421.3329862-1-elder@riscstar.com>
 <20260501155421.3329862-11-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260501155421.3329862-11-elder@riscstar.com>
X-Authority-Analysis: v=2.4 cv=X6Zi7mTe c=1 sm=1 tr=0 ts=69fa1d2d cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=YOnX06L-6IeA1UCcW-kA:9 a=CjuIK1q_8ugA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: -5vqkz3kQK1BcrKYiYUQpgaXmYl9QW3l
X-Proofpoint-GUID: -5vqkz3kQK1BcrKYiYUQpgaXmYl9QW3l
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDE2MCBTYWx0ZWRfX+jyzuelROTwa
 F0I5Jl74y1KsJKzHPDQk+oXt0vxtztZiv/+1y19WT/xuyWC9Zl8FMzNlFLuZ/Rt4Z43QfNLVt8U
 OThdrg0C8r73ZT2JK13WWsBocWX1SEb23PmvcB7NKXj+PN9Ic3P9illx4nD8cm92OCKvs7hHhtX
 /yG2nXuiG1SUxZ4kvLQH9FNOzP2hZ6ZeAcTOKh1udHhmJ8zKSpr/ksPNbwZwuiBFwHpItgR+HLr
 Yu5NEreuiF/cpfhAsSJk21g1jhCvuQZDbeocISzHDzG8yomybtsf5DMX6OsWxdzy6EjK0eXJKty
 7yw3bKS8RHnXpGG+YN+m3kFxCyN4g64fK7h5gGLBLNrcAyBr18wa0Y9qr5gUqAsw1wbBXJbhxHu
 x9zX8MFETFwbfd9omoI/VBF/yGtL3aztvaOkv59TsvLGm/vtZSjXSBZVPyqLmzWtfkh3PoPfgqj
 94m5oaELxZO6kpoSyvQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 malwarescore=0 clxscore=1011
 priorityscore=1501 suspectscore=0 adultscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605050160

Hi Alex,
On Fri, May 01, 2026 at 10:54:18AM -0500, Alex Elder wrote:

> +	/*
> +	 * TX956x has 8 TX queues but only #0 to #3 work for general IP traffic.

Minor typo in the comment: I think you meant TC956X instead of TX956X?

> +
> +	for (i = 0; i < td->plat->rx_queues_to_use; i++) {
> +		res->rx_irq[i] = irq_create_mapping(irq_domain, HWIRQ_RX0 + i);
> +		if (!res->tx_irq[i])

Typo: res->rx_irq instead of res->tx_irq.

PS: I was able to successfully test this series out on a Rb3Gen2 board.

	Ayaan
