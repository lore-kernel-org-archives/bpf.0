Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B35A49252E
	for <bpf@vger.kernel.org>; Tue,  5 May 2026 16:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777999365; cv=none; b=uDbk6TkVvuY1qfpqD6VVoFZFd4T0AF5SdXtusmz4+7asOVelIYkx2wHFZjt23qU9AnwiRIA3NwGj3IvbiUw0jOhloh+C5oDeUoVbneVjtpIPFmBYGnnAQMOSO8wB0xd62AW6q0vpZWGhnBXiMBW39lFkx1bZD7zcCMTmqkWLKUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777999365; c=relaxed/simple;
	bh=XWisdthpXEsZ1h/uQy51Wp0h5gBanWMeshjhe0Ik7mM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NYPaxLDEqsfVx6wEYOiyi9dkC2HT6/+4m9pzHqlfem5L2EnEVRYblhagdnPI/P3IR8+HUvmnSmciFPP3vL71uRzYs4OMCdYZEJ7XBWadKkdlDvgR0kHyfUCZX2G6Cdz/vC+DWd9NIZHEZBIe7a1fE3IDR3dtFduXRkk3yjo658M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OjftXHJV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=R5W2uVyS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OjftXHJV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="R5W2uVyS"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 645D620w3187614
	for <bpf@vger.kernel.org>; Tue, 5 May 2026 16:42:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=iAYFcoBuVm/XcG40EG9yN1cf
	01dwHoZZydGSBQe+fRk=; b=OjftXHJV19fGxCUgY3Jz9FOUwuFlMyIvE2v9eq/r
	Csyto4GYkW31L5U9eST4MIKUcvENbIA8pp6Ma1FUOidL0K7MOjMfgjXVL/i0FnDA
	XphMZ8h4+N/0ZYpTL2BPZSQhxPzFo/K2KcmPT6DYB+4UKJ+dwRrvZoCKCj49KgJH
	7c718rJcgmjNAENjF1HDZTYX7JCdBHeSLp6Nn7tv8gPxJp0fMji/WDDx6CJCZaYB
	pu4dUwRprcupX2wyhzbWr/F8IvsWvCJJjOU9ScFdQkHTZVUoPg4jrN1N4dWw7f1W
	YfBe34FRZkVd/mj00lulLO0reQND555HWK3GlKXbsaM5bQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dybkkab6m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Tue, 05 May 2026 16:42:43 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2b4530a90fdso93930495ad.1
        for <bpf@vger.kernel.org>; Tue, 05 May 2026 09:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777999362; x=1778604162; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iAYFcoBuVm/XcG40EG9yN1cf01dwHoZZydGSBQe+fRk=;
        b=R5W2uVySS0pmd5cxcj13xoQMlKnhDyhJ3FyNH1guubs+B8FKBYog6KjcGw8GLymdfb
         q+idn8NadUnJen/L41Um04wHtGUv2qwV+gSH0fQM6xFaiWPdSg/dOIRMp3sTQ7P6PkpG
         Z4WZoTpMTdnjhnoLeiBFGG0/YOsq57ydnFt5Ilsf1ar+IUM6zoF+O2bWQr7O5/Noum/R
         uZcxOiIrlvfm95YyjBHOElvpD9ij0tS8siU4l1GEKhND5rCVMQdRd8zxzcfdincFsna4
         VRt14laUko8d+1WHvHwWTmOsbIL9Ui3LLiaLy5FrCSMZJ5uQb7aDh5BoKya64zoo6J9O
         5aAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777999362; x=1778604162;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iAYFcoBuVm/XcG40EG9yN1cf01dwHoZZydGSBQe+fRk=;
        b=GDbbY4WyDaSD0GQyCQvkKgIgXrx6KVt5zd3VLcxl02Ai/zKIKljWkmmA4iMifYlEUb
         Ovqn5L+rcN3l3XC3Fu1Bd0ec0JCb6n0sAcOTAXu/uJJIInsCadZIz+bmoO5Z98ZLKmPl
         t+InVDYzwS/CUpsfnMEqKsiq5Xc4s72ywxBBcHqukFo9+dy9Op+y4R2fTGIlHs30dicR
         J6hH593oKRnynXq4aE7+cl6aDiZ3m7t5udcgyZ4tQ0MVvU+zS3v0BejlVZI8NqR4s/kY
         EgYjVxnBLgYpBZzlA4TtLGRNq6n1obWMRb8IHs/eQwFEOAm9ei5GOFDEyj2C+cm2FXCI
         b7hw==
X-Forwarded-Encrypted: i=1; AFNElJ9Yfk7RslZQR2h9yv3gfu0YoobHbVZOyIdyTLFzJ6NFxtBWuUQ0bwnlrohtaZuZ30lHfDk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr9hcQczoQPHAnXEjItgs9+gllc/LLKEkYsUhvZK6hK5tVPfmC
	YhDxnCi7ot70Ac9vMDVqcAWlEsERrkWregpl7BrM/7gb2bmV98NWbhvxIWSHbzG+hNfIyqrT6AH
	pO2QNdIsd80aVQbnwPaZ9IRFpNsTsXwKJj4ihGKijtW5j6Z1xG8ZyR6U=
X-Gm-Gg: AeBDieuJ+0dLioIgZlTm6IWFUSiont61z408vU+cKwPcXKq0r9AtYzxf+WHk5tR8RWM
	qVoxpNLr+c+p/d2R5viyKBe1J1uFgBppNGT00T+VhkTapCMDCWaO4sYQpgIH+o69zu2Fs0+gQSq
	2C2IxsVh8qOoFKyzC+RQcwDQH/cTnzM07wDNRK75+yLUAPDx+NOZBaJgI8u1G+bnQATEpWKqBmC
	ECBGAZhVwSsHwsxVjORKPvG4sqsSEcRbu7AUl8KU4TTaVO3GxkBGrMlSSvLHPfa4xgHaRo0O1pa
	q1oiF9e51PZj2BiM6f81C6MDOjNAmkJ8gHlzFvvOZU6ltDw78lqHcbE9ibQvbO612jBGdpt64Zv
	1g5wDsFLTDOsU6iMac0aW7fmDA4ugEaceYgEIg6ij5a7RHw==
X-Received: by 2002:a17:903:2ecc:b0:2ba:15ff:345d with SMTP id d9443c01a7336-2ba15ff376cmr108941515ad.35.1777999362299;
        Tue, 05 May 2026 09:42:42 -0700 (PDT)
X-Received: by 2002:a17:903:2ecc:b0:2ba:15ff:345d with SMTP id d9443c01a7336-2ba15ff376cmr108940885ad.35.1777999361838;
        Tue, 05 May 2026 09:42:41 -0700 (PDT)
Received: from oss.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9cae0f6d8sm144847685ad.39.2026.05.05.09.42.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 09:42:41 -0700 (PDT)
Date: Tue, 5 May 2026 22:12:26 +0530
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
Subject: Re: [PATCH net-next 12/12] arm64: dts: qcom: qcs6490-rb3gen2: enable
 TC9564 with a single QCS8081 phy
Message-ID: <afod8ot7xb+g0wzN@oss.qualcomm.com>
References: <20260501155421.3329862-1-elder@riscstar.com>
 <20260501155421.3329862-13-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260501155421.3329862-13-elder@riscstar.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDE2MCBTYWx0ZWRfX6vYrfOtfejZt
 Io58S5nDxV3MHs1Od0FEifB4+w27sfJeTXhTYjgThMPwXM4QXbUcOfYgsCMAb2JuBSyPB/URGVL
 ig/NZx86fRbIqKByTfuunGqn0Aix+KYYbyPkEOtK0Heox+nmdfrGfjWSPqjR3xMTIADQ+Z6QDxM
 ECXwZqtSnsWnYCHkhfbMve/lJWbnlcvcz2p9aCn2FwL46moynwHv+j+ElZAN6lFKILfkSmyuIOt
 oVVvnh8awXnIaBhFxqU5w9vs3BTTroCV4PVQ3/m6ot8EuvXHjRI7QwMC2V4dJJZM6hF64zlxJl1
 lFcIgP1PrTsZPIydJr686b3GrUuZeqoiQbdQIZOjHZKp+E6muS0pGg5ckt1lBfrOacfSDwC6sC7
 4EC6jbtYJog5yfzObem+2UzGrNkt1b2bQmv48J81/9NrJD5rypNd5WcJxVm5qn5PYCyCmcC0G3A
 k/7Zo4x3r3kZrStgbfg==
X-Authority-Analysis: v=2.4 cv=SPBykuvH c=1 sm=1 tr=0 ts=69fa1e03 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=ee_2aqc6AAAA:8 a=lW0hg0oAPnnF6MRRTAsA:9 a=CjuIK1q_8ugA:10
 a=324X-CrmTo6CU4MGRt3R:22 a=VOpmJXOdbJOWo2YY3GeN:22
X-Proofpoint-GUID: ibz5adtaZ11ssjmBk-PGsuWSprk_Fpsi
X-Proofpoint-ORIG-GUID: ibz5adtaZ11ssjmBk-PGsuWSprk_Fpsi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 clxscore=1011 priorityscore=1501 malwarescore=0
 bulkscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605050160

Hi Alex,
On Fri, May 01, 2026 at 10:54:20AM -0500, Alex Elder wrote:
> From: Daniel Thompson <daniel@riscstar.com>
> 
> The QCS6490 RB3Gen2 includes a Toshiba TC9564 (a.k.a. Qualcomm QPS615).
> TC9564 is an twin Ethernet-AVB/TSN bridge with an integrated PCIe switch.
> 
> There are multiple builds of RB3Gen2 with components included/excluded.
> That means whether or not there is a phy attached to eMAC0 depends on
> the exact board. However all versions include a TC9564 combined with a
> single QCS8081 attached to eMAC1.
> 
> Add properties to the existing PCI nodes to describe how the TC9564 and
> QCS8081 are connected to each other (and to the host SoC).
> 
> (Note: "pci1179,0220" is documented in the "net/toshiba,tc956x-dwmac.yaml"
> binding, but checkpatch.pl doesn't recognize that.)
> 
> Co-developed-by: Alex Elder <elder@riscstar.com>
> Signed-off-by: Alex Elder <elder@riscstar.com>
> Signed-off-by: Daniel Thompson <daniel@riscstar.com>

There's a minor typo in the PHY name - QCS8081 instead of QCA8081.

	Ayaan
