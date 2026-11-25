Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795618157;
	b=wLMq1OoX7z7PrOdIHGNAG+gqE5WOi2EhPhjUedVS+KxoyFqzwTYvloNiHc5x0QsmNCF0
	 sM/bIKAmnfirf+04WALvUDX5eKZYg1dcdF2fi7rCrAYcZ+JAABUwq6yUAF9SoAmgpaAYs
	 6H1LdYekDyfT0BPWXn/XZ0iUla4v77M8BI/o844QEKNutUM2L1UY6YMN8KGSAlOC8QD0e
	 J+LkWbhyD73/P3vj46bYozCQfEh4goWCePDYoZCPpXwhwBfsiquasDJ1IYFGVyomqJb2y
	 liHr+rjUHNRdvMZQopykeO0CAYbEo5Ma4OQAssKLKlU5L1VfRMJdQsn8D8FFK9kzD8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795618157;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=lhO3ie7MyS5IbnfBQG50mZt1o4BzJsfDN7FBCdEFYtk=;
	b=c2uNh7znjGgKeEDWtBh9cpwV+Ro4sYtJ2c+YsVlS06bVjOFHM7D/uRxemWrtrOn4PlPh
	 D7fzb5tFXEbfqt1AhhRxslbbIKCbpCib8Rdeuqqad9d8mWRZZIBR2SiulKdgmCT/tWWHM
	 5WvxI9T4+fPmgojndfOvfC++2akZi92Yrb4c18Q8JntliTaxWpPfvD1ZoxeQVMm33ktvw
	 /nmI7C6T8QjGZUgQU7tWoTQpII2SD4MVDRT/FamaWUQla+JLTdz2V3MpMeSwUCohZxcMq
	 98rCxFBxrOo0AIULufmdSLP087fCvusyiVtP7qq8sE2HNFE2LM6PFTOlU0+mixCa8SA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=nT9gDU7v;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=iYzEgT2d;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E66D606A332
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 14:49:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1E66D606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=nT9gDU7v;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=iYzEgT2d
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6APEM6762729762
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 14:49:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lhO3ie7MyS5IbnfBQG50mZt1o4BzJsfDN7FBCdEFYtk=; b=nT9gDU7v3b4nEnwQ
	60VdfNWNP0dwEZAqTDdRsJWxlvNWTzWUmQIo3l5bOP0Mw2jAUKareZHJQTYiX1CU
	GMuhqKiDVf3+11InQvAHWmaTRTHoNnrTlCvJ6Bec+beMuH/r7wqmpN2fxjLHjQjw
	lVd28uqhFVcDoKoBQl2X5sgzwRqWhryMjDpj8uMq4nTckT7k8CjtCi3Onkj2AjZZ
	hS2OhgK1qVJtRLuvXiEMT+3Jh/lUjJvhB/uWvpdnyOOylrtbLcFyIxfWYHfQ1LrZ
	ymmQVhmVZ9Cg2lk2gU76rehehgi+BrjX5OwxYN8nbCNXQsDXWVGtv/3f505DVWFt
	NAi/bQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5vuksbsn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 14:49:15 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93f2373e9b4so662325385a.1
        for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 06:49:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795618155; x=1796222955; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lhO3ie7MyS5IbnfBQG50mZt1o4BzJsfDN7FBCdEFYtk=;
        b=iYzEgT2dQNieC/UwLpiBgZEZqZiDjcaxv+qmQ46qtSlP+U8KpSLrd+FsTPoioPJXfi
         RiPV57FRZANlMo/MUSn+VUuiJLdiqYbC3/Rc3/wCYU+H+qSNvz8Q1+COk4qNowdGiUBL
         ab1EjCloDWgRax1xOfRC7DoZZNVhP3jVyd2FvjYnPJTrPOqolam7psV4pJYKimUiin2Q
         WS1v2udszTaQ/BzN69AZO/mZR9/So1LBmAji8Zb+ZLrQzjKzaHSPEpi/K73EN4lspyBm
         IwromQU9PP47ASknQR8Xcyfatr7IOKzHzV+a0rbyvIsZQ++e7uzq2T/bXDNCid+Blf/b
         isPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795618155; x=1796222955;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lhO3ie7MyS5IbnfBQG50mZt1o4BzJsfDN7FBCdEFYtk=;
        b=EMVUaJz3DJYikdn3ltTgAn1tDzoW50wGIy6KzqDX+a7wQA2AS5lJJaDfPp2viu4zZD
         qmuHVgadFztL/amNdVntZyhm6I6BVdHlPWqy/ZNSL+p+pD/b2jrceufswck+t9mpcasB
         9hE34iJVANQh0okw9TNagJxJWTIKg6mDG7xpCXmyPOvM+8O5cvM2khSMstYN3ecnqZhp
         rY+BR2FFKPq8snJw1ry5A3uWXE9v9qF/thEIPuuTcZiWfYNuu8IaUQ7azb1l9tadGv+h
         rL7wt5WC/1aic1xYfyrx2jA5W46GkjfRDj80rz6cAddAnvJSgwC4RzCyhJRLdYBtxewW
         4PUQ==
X-Forwarded-Encrypted: i=1; AL+hErFQ7G9yqaZx/KZtlDjyzBK/QW0llXlDIEenkJ3D3q813mMUJJh8Q+STZLRapJRmAF1OVkc=@vger.kernel.org
X-Gm-Message-State: APuU4Z+X3fPaa6iw79hIl/DFWlkU/1q06EwDdCB/bZA4H9XtA4MtRW/l
	ObU3rRf9DjLxMLeSUeHL1Bgfcw55vp9PAMnHQrbxM0HJnu3+15uEqTfLpQSUdPepTUTooS3Pwjs
	bzCbuATiFcTj0m3ZoP73dyg01d6nnE+mFujF35YFaKOyDEn3+alIJwMs=
X-Gm-Gg: AZFdTZcYOKVxSJyocQ4W6yZBzI1VmwRHMpdFScPAOc7lQnkkYFNBvub0o4Jwwawce4m
	vJxqWs88zjxFiFyRiWLXZBQQX5MHRw9QQkxOLTZ7cVMNfQaObP7o1i1M4ZjwB6jUGSIs5k+oKrW
	H9vgOhVTz+fwoEQ88mm50hEmkfMLk0EAb237bgIAlhhd9eDbceXk3ynhsBrgklRVByRaZuYpCFs
	+RjH9UYGjk7b65vX1yNtDUYmNQQkZ+BghpawBESnk2yy1DfKFn0vyz2tcWPnjRuvV7iN0wI4Pa5
	7x9lsFMRNHH0wMaRZZLTztdWWz9ra3au9+cIsGyn/Mxjq2C3vEcZwMksmTKNOW/ovOK/B3fKZeB
	xwi0t8+c1z2fCSCAZBEry0kohxX1L4YAlgJdlMm5XHxC7Zuhdy6MvgDKKsO7seUI+wgkIRz4H0f
	SxYTulc6znUuJqz6BOgo7kc8NK4VY=
X-Received: by 2002:a05:620a:31aa:b0:949:3066:5551 with SMTP id af79cd13be357-949bac80948mr3198570285a.79.1795618155144;
        Wed, 25 Nov 2026 06:49:15 -0800 (PST)
X-Received: by 2002:a05:620a:31aa:b0:949:3066:5551 with SMTP id af79cd13be357-949bac80948mr3198561785a.79.1795618154494;
        Wed, 25 Nov 2026 06:49:14 -0800 (PST)
Received: from localhost (net-188-152-73-83.cust.dsl.teletu.it. [188.152.73.83])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884c3063sm523493195e9.15.2026.11.25.06.49.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 06:49:13 -0800 (PST)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Wed, 25 Nov 2026 15:48:46 +0100
Subject: [PATCH net-next v13 1/5] net: stmmac: selftests: Prevent RXC from
 being disabled in LPI
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261125-stmmac-rx-mb-v13-1-0f6bac53e8d5@oss.qualcomm.com>
References: <20261125-stmmac-rx-mb-v13-0-0f6bac53e8d5@oss.qualcomm.com>
In-Reply-To: <20261125-stmmac-rx-mb-v13-0-0f6bac53e8d5@oss.qualcomm.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Stanislav Fomichev <sdf@fomichev.me>,
        Jose Abreu <Jose.Abreu@synopsys.com>,
        Ong Boon Leong <boon.leong.ong@intel.com>,
        Simon Horman <horms@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
        Emil Tsalapatis <emil@etsalapatis.com>,
        Ihor Solodrai <ihor.solodrai@linux.dev>,
        Matthew Gerlach <matthew.gerlach@altera.com>,
        Boon Khai Ng <boon.khai.ng@altera.com>
Cc: netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        bpf@vger.kernel.org, Peilin He <he.peilin@zte.com.cn>
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=KfVHIgYD c=1 sm=1 tr=0 ts=6b06f56b cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=mlS0om9xteqVCAF/aDpb2g==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=P-IC7800AAAA:8 a=1RTuLK3dAAAA:8 a=6E56evKkPzl37l_feFUA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=d3PnA9EDa4IxuAV0gXij:22 a=kRpfLKi8w9umh8uBmg1i:22
X-Proofpoint-ORIG-GUID: QUhx4qBWVuM8jZ_KbYgOmWAeALL02UYn
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDA1OCBTYWx0ZWRfXzAzAHn5cUyip
 TnStacopl8ZOQkDK2lUnImRvi4QPjL74wp+SaLDY3USlSKgq9Y9O5e2nw8ghXnn8vR2iPnIdcym
 9d7xeQFqxgJTHHUrm7k7Ks7z0hqXg4c=
X-Proofpoint-GUID: QUhx4qBWVuM8jZ_KbYgOmWAeALL02UYn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDA1OCBTYWx0ZWRfX173d/js9GyEp
 yCigMEzZObPCTrOYoS6KQ+ztxcMVdIcSpEis5S5TlGeTI7fDiIi4ZMd0EgwaKWTt3eJ+n0eInnb
 vzV6UXl6wiDZ9olv7NIwKSnUyVU5R1V1b3VK75KkYV1/BYYW0vjt27N2Cokv6u2pvbl/dv/CkPX
 kpe6LXTikPz9t6kzoHVQxCsQzIiczLgJih32ilZ5+MkUIWTv119qP2erQ/ZiUBtW4qEM1bKz/Wk
 AGYrX934gWYyfJQZX+cCPBWl9Dx0864tdbgI2rW21s6wuwOa985v2IdfSC4z8yDbkpikeMcrGgy
 mSyFaDALy3yCqXEicWoSOCPcdUFaTr6x5i0V4fLOxb4z6kPFQcE5QARFOYwtNS494BNXOtpIFF9
 EzVfDcHZ8RPweE/6tmVDSlTpCt3paj9FVrFJtlEZ9+iRjkLA+pfhi02rVrmqBuAAQQu5fBn792P
 6NnFxLSHBGVqr21P42Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_04,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 priorityscore=1501 clxscore=1015 bulkscore=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611250058

From: Maxime Chevallier <maxime.chevallier@bootlin.com>

RXC is critical to the RX path and some register banks in stmmac, so
it is blocked from being disabled in LPI when we know we're going
to need that clock.

During selftests, we're in MAC loopback so the PHY may enter LPI and
stop its RXC. This will prevent the RX path from properly receiving
the looped-back packets, hence failing the selftests.

As NETIF_F_VLAN_FEATURES may be empty on some platforms once the
software VLAN stripping is removed, the phylink config attribute
'eee_rx_clk_stop_enable' may no longer be unconditionally set to
false, hence allowing RXC to be disabled during LPI on platforms
that don't have any VLAN features. This is already the case for
CONFIG_VLAN_8021Q=n builds.

Fixes: 091810dbded9 ("net: stmmac: Introduce selftests support")
Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Signed-off-by: Peilin He <he.peilin@zte.com.cn>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
index df696e2c1528..41a8493cf9dd 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
@@ -1940,12 +1940,14 @@ void stmmac_selftest_run(struct net_device *dev,
 		return;
 	}
 
+	phylink_rx_clk_stop_block(priv->phylink);
 	for (i = 0; i < count; i++) {
 		ret = stmmac_selftests[i].fn(priv);
 		if (ret && (ret != -EOPNOTSUPP))
 			etest->flags |= ETH_TEST_FL_FAILED;
 		buf[i] = ret;
 	}
+	phylink_rx_clk_stop_unblock(priv->phylink);
 
 	stmmac_set_mac_loopback(priv, priv->ioaddr, false);
 }

-- 
2.56.1

