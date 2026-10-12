Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5324949D5BD
	for <bpf@vger.kernel.org>; Mon, 12 Oct 2026 15:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791818721; cv=none; b=vGlPCNwBWzRC2Chm2kYbs2WRLJj0NAfOanckyY/zsCjXTw7HnF4SK+2LiuQ8hxgChgwX6rGRYgDF0MEu/TD3iF9I4baFAE9YqQ388wk/008+x3wpG9x3fpW2wWrP43+MTvgnr9tVQe3FFx+3+BP2mmb/wQN0nwNjhUstZuQr5Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791818721; c=relaxed/simple;
	bh=uLgwTTxiZpNInq7W7aL0wWG2WDX0Ic08HNd764X4JW8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=dh5R1hugUTpgP9sdPWn5I0fflfkiHB+xtEINdBKxo+Kv/5HP1SRv329IV4gx2ktegK/Rsx1rMhB1i73rcOlA79HqIpM9vH4Fb/l7u9ofXO9vvqyDJwqG5yMUfB6duZmujNogDKaSBiGS4XtsnhSfwTigbRnZQBsYFK3bX7KxbBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=I1bG2YNx; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Dzxtc+b1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="I1bG2YNx";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Dzxtc+b1"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69CC0Kwn3292500
	for <bpf@vger.kernel.org>; Mon, 12 Oct 2026 15:25:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=g3lVCKwz3m+1Qgdbpu0enx
	VKwE6OpVLIOQB3rCyKQnc=; b=I1bG2YNx5jnaa1O7dGKuJIoyEDR3xy4PkZQFyK
	KwRDYeS7uxzflVZpXFChySjV6bHq/+W3tarnYnresBAvSEqlu97WjnSq9LUCoF6V
	sINHBWy36I8l2GU014nOZPluVKuCi3SYzxBbo0Sn7FHwdtvM21Enp3xsrNC2Vbyy
	ulJbQESBxrqkeIvXPQ43vuON5l658vhuXk8T5ZEzf4pPJT5PaALW7SRf+Hdlt5Ko
	XR3BrYEtvSBYfpRsKi1BrRonCmECYEQ6dMcY7vy2OS4LSf3aEdDwgEJ4izVm4YOM
	9lS37cXrpDck6JHZMMXkzBnuEHCBZzh3sNstK4gTbKKiAWpw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h8uh3j1qq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Mon, 12 Oct 2026 15:25:19 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93ce7a85f04so474484685a.0
        for <bpf@vger.kernel.org>; Mon, 12 Oct 2026 08:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791818719; x=1792423519; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=g3lVCKwz3m+1Qgdbpu0enxVKwE6OpVLIOQB3rCyKQnc=;
        b=Dzxtc+b1XGXmSEGSKtU65gNfLYkzB2iqGpRCqfbcQq0FCC40DHMiH4Vxmz/ftLrfDJ
         CDGaqOuKRazQdqaFTP+PHMaRaYZf/1pWavaCOLePANWxO2dqcJ7akNPbhrUP6DyXjVEo
         IEiURKzOcM3gMU0N5VcHaijqSTD1fzc7qO5/tn/4+Na2FCjACQ58Y6UfEQvFyGjv1HyT
         CJwIyQhWx4HoQhpyS/di+2i831TtUt5i8Mg/m9UL/Wyr77uT9suiwDu+l2BxjPJoU8Iy
         m8FXoqSAb8ksgTQrzAKa+jKunqKGkXPB21FRDSZNkV5h4n9CsdPGRxQVN+av7YRlw3J5
         +joQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791818719; x=1792423519;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=g3lVCKwz3m+1Qgdbpu0enxVKwE6OpVLIOQB3rCyKQnc=;
        b=za+Hijjh12zJbSmpH5st5vSx1aN7PFLfCE1hVscoq+acOJVM7WQaKik75T4cdpu4FY
         rQlnau48XRcoRP4WGlWVR8pPlPETUbQcXFR+a0/GW/sGg/EIFe0EJ5vS+aqplQK/wttY
         LQHQzyD9px+4GxFK+kfL2dnKUMYILHKKFs4EVMaTtL/Isz+5RB1uPYlW74gOBvMG6+Uw
         cRuS0cq/QlHS1F5ZDJ+c05XKQeTrHEoq2/HwLQaC+N3zCbVKpujh54E5uQQDx7xLrkJ1
         pMah5X+WEN4Vmev0sdEyIlE++vkCndBG3XyeboS3cgNNh5B3uTldDOzsdVbIqDRveYfz
         MfCA==
X-Forwarded-Encrypted: i=1; AKwUvByMXAjjQ6bsX+MFJRJNVTOdNcvSxyYw7OgD+HG/t3kOwS3xWZGYb1fmoWQY3knXBkS/uoY=@vger.kernel.org
X-Gm-Message-State: AFq9FYIkfc+kjWOvV9GIkCjhw2ak3TgKBzwPTu/m/8Pfr0Mvosae0B0Y
	x7qguGvQtu1IbcKOydUbM5uosgbLdFWs6lJRuQEc/+qgAeHjkr1MrgJKfo+CPHGGqaLA2VDUOFS
	kPvSiMchWWy7kle2tp0GBCNy3e4ZTM0vRRurc62ky6SnYiLLHXmAxA/c=
X-Gm-Gg: AYBFou0vA2KsRsiTaf44KIPcu0M1FeUnY8NITiiKPY5tjjIAeitXavrb4Lipj9zdqCS
	iIug1AAzWZ9YKxAmMINpfIXCuaJkxfIcMLuiiMfzPS3/eCGyl/GMa9aSczWa7whUNYvxriTU5Ou
	BrAzPeoldAN3Pa9DlLzaRUckmCJcRMICxD2K0PpDczIkms/YbXmaCFZ7mW0zp98hNaVfCaWMXB5
	gS6WEuwt/JTAVHeJ9ibtKb92lMpkK2lPkgFxd6vNzcqoeInJAX+HX2RaGSpctfZN7zBOvt98Elt
	5d5bqtDhkiBdQees5ZvoXlOfO40oaU15zG/t3G0Y7hRh7zvuMyX+w1lwqhKYZErwXq1pOX3hGpa
	ED9lbA3+Mwx5Quw==
X-Received: by 2002:a05:620a:4552:b0:93c:6abf:c8ae with SMTP id af79cd13be357-93ebd231201mr1728165385a.50.1791818718433;
        Mon, 12 Oct 2026 08:25:18 -0700 (PDT)
X-Received: by 2002:a05:620a:4552:b0:93c:6abf:c8ae with SMTP id af79cd13be357-93ebd231201mr1728157785a.50.1791818717740;
        Mon, 12 Oct 2026 08:25:17 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18e49792bsm475483735e9.4.2026.10.12.08.25.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 08:25:17 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Subject: [PATCH net-next 0/2] stmmac: some XDP fixes in XDP_TX path
Date: Mon, 12 Oct 2026 17:24:38 +0200
Message-Id: <20261012-stmmac-xdp-tx-pre-fixes-v1-0-05fd0c90f7e1@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3LQQqEMAxA0atI1gbajqh4FXFR2ziThVWaIgXx7
 hNcfh7/BqHMJDA1N2S6WPhIGrZtIPx8+hJy1AZnXG+NdShl333AGk8sFc9MuHElwc+wxW40Zh2
 6AHqrvKDzDIkKJqoFluf5A04NlRdzAAAA
X-Change-ID: 20261012-stmmac-xdp-tx-pre-fixes-37fd4800b74c
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
        Ong Boon Leong <boon.leong.ong@intel.com>
Cc: netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        bpf@vger.kernel.org,
        Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA2MSBTYWx0ZWRfX53W91SzClux9
 /0Do+FR4wN8gyNfP66Zphpr7E6od+QO4y8bFqGCmWagyrvwffxP+VmF+szB1J+YRFbTWrT6jlmk
 MUQ3hMGx7rJI8YIJD6LDBysJ/w0w/8/KPlBRo4OjDIjeBDocGLM9DwIBf/f7z6Sbk0QhW0jkcb+
 q8oVUSpH9UKcU2F96sESZVipPqtN7Fh1myFRAZr9JUKlmESbJUyFxFgCXJKfskMPNNk8BtZXrzi
 P96H7efGRCftBT6l+8kleV+NF6RxIxCQWGudaEW4t7FemalVFC0xW05GBZKclG3vZMTpu25G3Kr
 RfLfQnl33oVq9CIOtyMQFp6yX0m6JaXCl4eanbUBhBkDBGpoVLSA9YolGQEpaNDr2ycLbzjG/sW
 WmHlQ6vsKAg4tIVtdXqD0TEUgVBzlXWzgbElo3r53SdxFBoo5/yGZaRZUiKpbQljW/lzIbNIAba
 eUjX+p6nssmpEtyQe6Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA2MSBTYWx0ZWRfX2P8zRKoNtqon
 2H/2xusRxpX0QwiEe5Mm6YLNW789x9d3vmz3aovwFe9lNYmvLN2bjlLaLW6+p1UyzRvUztDsEZh
 59ksBrKBEcgoc9BHj2w7q2b302mRZTw=
X-Authority-Analysis: v=2.4 cv=QO391QLL c=1 sm=1 tr=0 ts=6accfbdf cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=e8Hy17V4MP4qKruQfKwA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: OH5ksyrOECoPdS8u8r-ltqFBn0mTV0Hg
X-Proofpoint-GUID: OH5ksyrOECoPdS8u8r-ltqFBn0mTV0Hg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_04,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120061

- Fix page address lookup for compound pages in XDP_TX path.
- Disable TX checksum offload for jumbo frames in XDP_TX path.

---
Lorenzo Bianconi (2):
      net: stmmac: fix XDP TX DMA address for compound RX pages
      net: stmmac: disable TX checksum offload for jumbo frames on bugged cores

 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)
---
base-commit: 29f144016f03608abfddcd6ebaeabafd7aeaadd2
change-id: 20261012-stmmac-xdp-tx-pre-fixes-37fd4800b74c

Best regards,
-- 
Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

