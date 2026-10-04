Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD5239F16B
	for <bpf@vger.kernel.org>; Sun,  4 Oct 2026 20:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791146574; cv=none; b=nX93OLa19CJjkPJYZ+2c9pHiugCQ9SsJKdgoVyeiwrrCSjXTN+k9FE7gng6fh3scqR6urrickPZORNf8m7dFU3jzdFTA39Yu792lV6YI/aO+F25MGIdUFWiqDlkH9KrxLMrqBcovwuYxLsncB04TL9w0ST7h+pL2pJxF4VTAD+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791146574; c=relaxed/simple;
	bh=NvHV/NjvO6PM0NIjL2C2g9bSW9F0c2QVWVCSzgpiYjQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=DRCiD6gHaN09RLjBYPGETAXfF1i54cg30vytacw548jf0Y7ilx9zf/kaR/4lGadW4JkIx0mtPEPmKZ5r9DVXv3J9JdSTe1tN3dTEweUjopzCER2YlqaPmODDKeH3PayOSTIo2Oyt+oWG/VXZGYLYgH0j/i/hN8yrDrfVcQOm82Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Szrox9BH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=e4maxghG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Szrox9BH";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="e4maxghG"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 694IIn473477992
	for <bpf@vger.kernel.org>; Sun, 4 Oct 2026 20:42:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=r+9536ubjZAnFwIuv7vJah
	3WtJ0YDIcg7Gc+K2rs9aQ=; b=Szrox9BHjCbSDvM7cy1pAWuE2n9H5Hn2+2P/aA
	GnLoLOCdBTy23YTCuTqtmmRE6cFnD+XpmfzSYtbarhzObcDd8HIXTttpFk7uwny2
	D5n5+0pYrhbbEYq8Yjj9XeM1m3eV5qtTujZ+Y6+DLVxfijrhiAZWzX9Hikp0b+it
	D3SBuz6izbxWihXL4sFG5vvCk2YSB6b+ISCeYLM3BeN/Es7a3ZXEVkU5yb3m33gv
	IiRlMcdPNaXvgUgr9W8QhUne5m56jQPAFPcO2KbwSWGiWp0+6KqODXHZvcZuBc7n
	43a49lB5cOOADWbEmQYrI8JBCgTzwfxuN9Thta6s61d8eLng==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h2ssu3qup-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Sun, 04 Oct 2026 20:42:51 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93bfb2da664so235659985a.1
        for <bpf@vger.kernel.org>; Sun, 04 Oct 2026 13:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791146571; x=1791751371; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=r+9536ubjZAnFwIuv7vJah3WtJ0YDIcg7Gc+K2rs9aQ=;
        b=e4maxghGXT6RHi//a2TLeY/Rr+mGKRyvFOoqWdiJ/0SInNohg4t07ZNDE7YwJtTmYa
         YjpEvnqqfM8pHXQJRPHi6TKBlT5T9CBHDMvK3GzD1FaZFasVgwLMbsVd66llVvCn0oc5
         HEMdBOCBNbocUaWQ9mN4aBRKYWtD2l0BkMThAXEyqmln9pgIdPxN4qOsc6aIlQkxiQat
         PXGJ3SpLl3mNvN/uU2FZ9BxRLXSRH5otYCGEb+vKhKheITJ3ywzg8GQ8IYd+K/dbEE5r
         Uqo4Xp8huAwwuN5ZjcthUPVBIadp5+r+Cq8fRcT1xUDwXhwFfriHXRFRSU+XzZzZW0Ns
         HwTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791146571; x=1791751371;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=r+9536ubjZAnFwIuv7vJah3WtJ0YDIcg7Gc+K2rs9aQ=;
        b=ZYmF3zhZNN0xhqiEQzl3TbyFxdjehsZzS+AypN4VgD+e9UBYHkHPqUCK2PaQi+19Qq
         E3+59X0ALGYnlcFHNzJWcMDoqjF57pz5HOPLP4xs8Xr2r4ciM00NLjQ1M5wuFnvZvySU
         rf6u9AHKc1czktX0FG06i3pXx4lBGzG4fnTceFpPDM3LY7hoexz5zo2qX0MjKnct9dY2
         QCPMA65k3BQ4zGX43MtMMt9hKN6e506qIKJ4hcsH2FjmbbA/000W3kHA1ERSCAM0aHnu
         eQ4hSmkqC/uuLQVrwjH8fAgvfkb8tWJf/aq+G4onPCWign46Evc3yQI36RwyKqvbgCEc
         yyag==
X-Forwarded-Encrypted: i=1; AKwUvBy1i6KE/btCnVTH++pD2WNfuu2PtoM/SNZee2+Ko9ATrZJElINkFSA+VLS+4sdBrR0HKv0=@vger.kernel.org
X-Gm-Message-State: AFuF++nljZ5AixdokZZ8L+emlLn3vAEWUyhrzS0Qm1QTw9OfbkkeQlJ7
	rq0Xxp4Wg3C5eSa/Ua/r5P7YfJwUbiopwbfBkUKh1QFI1iYN2DVT/MFmzRLO1muF304utmd27WK
	b3d34dmAzQfEEpiIDsoIxEqKxOZ0db+RIq501G2YO24Wdg5v+irrZINGu8lOPfkA=
X-Gm-Gg: AYBFou04R/GpnNiTIq1PaOl1EDoDLVjXTBlQu4kMeGL7LGpnMjl7PbVlxTgnq6Oaj63
	onuKTrBMlPsgmir864tTWwdMa9IFYjqYwLcrtkfxnC6wkMUvKApSFOlaqDcduyBpu5PIcIeHUmj
	ECI2LKiv2AGafeRqX4YmkSauKj7GBc8BkSTN9PNozK7QgbxZTm5yH3I/d4O4kCQfW1NJ6pUSy3P
	x6UtY08sRslzQpg3EM2dBcXyXwJcvWWScJ05l6tM4tssdETwnmB4wOWtG4ubaWHgIsNwJOfaxXD
	IEL2WBut3XTXEtd4fXmbSx7bE9uCz+Yv+BCFidbJBKqpfyGfQesObXYDq+hq9gL/F7KVkzFOQhw
	ol2QjzVDJN5RaZA==
X-Received: by 2002:a05:620a:4397:b0:93e:516e:a8d2 with SMTP id af79cd13be357-93e516ec2f0mr1017727185a.4.1791146570664;
        Sun, 04 Oct 2026 13:42:50 -0700 (PDT)
X-Received: by 2002:a05:620a:4397:b0:93e:516e:a8d2 with SMTP id af79cd13be357-93e516ec2f0mr1017725085a.4.1791146570116;
        Sun, 04 Oct 2026 13:42:50 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48b38307190sm19496719f8f.45.2026.10.04.13.42.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 13:42:49 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Subject: [PATCH net-next v3 0/2] net: stmmac: introduce XDP rx multi-buff
 support
Date: Sun, 04 Oct 2026 22:42:00 +0200
Message-Id: <20261004-stmmac-rx-mb-v3-0-50fa171af9ec@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/23NQQ7CIBAF0KsY1tIwFGnrynsYF7QdLIkUBSQ1T
 e8uYWVMN5P8/Pw3KwnoDQZyPqzEYzLBuDmH+nggw6TmO1Iz5kw445J10NIQrVUD9Qu1PQUpZKd
 4AwIVyZOnR22Wwl3JjJHOuERyy81kQnT+U/4kKP0+mYACZb04QTMKJpS+uBCq11s9BmdtlU/xE
 v8xOPwZPBsSWy4RtK6Z3DG2bfsCgQxBnf0AAAA=
X-Change-ID: 20260918-stmmac-rx-mb-16469a2714ea
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
        Ong Boon Leong <boon.leong.ong@intel.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org,
        James Hilliard <james.hilliard1@gmail.com>,
        Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA0MDA4MiBTYWx0ZWRfX9fKXq4Ks/HMU
 rYHiv2HV1aeFiZFZhoianUn/+CdYx6gClUUhu4TxyiioZSH9iUjOKdIHIa2uKYiCrk+gAE0cLov
 Z3UHeD8XKbcR08c33G3hOHlsHBLN3F1SnldURVR5Z0tiEdkYReqpG44Eio2frvkFPjFSkO2LEwA
 OBMLlErf5dFzhmoSSCw7gRshaL8o70NMvuFgx/2Q6N09Ez3tk6kQ3y0XY39FvbjC4+cV5e+OVFq
 Dl5Nw5FnLRdBFVvX4ajNl3DXKJbui+gny2dttY0bHOYVVgjQXcmmRCwSDhFV2vxiop9+7zzbYsX
 jDMErl8ndvgc+RJvZAHls7aPio8kPejtfnYwSUGLznR8Tsh/ggFV49isj2ishMZP1iWZ+vo6tx8
 3bBkLxg9T6epQseNCNJAvlOGlFTCayxa535NRkW/bwJvHpdks6GJ+F2plQ2I2Tvkn0THW6geWdI
 PBbzmXpPsvHZtSh3B6g==
X-Proofpoint-ORIG-GUID: xD8vHYVGs_zB5C6sfr5TD1zPRj9-bcXB
X-Proofpoint-GUID: xD8vHYVGs_zB5C6sfr5TD1zPRj9-bcXB
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA0MDA4MiBTYWx0ZWRfX8oYk+ILi95Sb
 T3GeBSq5qWizAAQgyfBCW3X7c5JUEySomL6WU9nG2A9dOstjjYiW3l1Hc7bNTYVljVBo+ku9Qi4
 1R7iGhjDDzLwRuW11jOuqn5BoW8dJUg=
X-Authority-Analysis: v=2.4 cv=XPSl2ghE c=1 sm=1 tr=0 ts=6ac2ba4b cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=SNmR0GAD1IuDnH7kD-MA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-04_05,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 adultscore=0 malwarescore=0 spamscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610040082

Rework stmmac_rx routine to properly support XDP rx multi-buff.
Fix possible rx_q state leaks closing/opening the interface.

---
Changes in v3:
- Return secondary page in case of error.
- Introduce stmmac_xdp_shrink_tail() to remove the ethernet FCS.
- Add patch 'net: stmmac: take ownership of saved RX state at poll
  entry' from James.
- Link to v2: https://lore.kernel.org/r/20260921-stmmac-rx-mb-v2-1-6e826e1ff306@oss.qualcomm.com

Changes in v2:
- Rely on xdp_buff_add_frag() to create xdp fragments
- Fix bugs in rx_q state recording
- Fix the corner case where we receive more than MAX_SKB_FRAGS fragments
- Cosmetics
- Link to v1: https://lore.kernel.org/r/20260918-stmmac-rx-mb-v1-1-0b4517d404af@oss.qualcomm.com

---
James Hilliard (1):
      net: stmmac: take ownership of saved RX state at poll entry

Lorenzo Bianconi (1):
      net: stmmac: rework stmmac_rx to support XDP rx multi-buff

 drivers/net/ethernet/stmicro/stmmac/stmmac.h      |   3 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 388 ++++++++++++++--------
 2 files changed, 249 insertions(+), 142 deletions(-)
---
base-commit: 14b9ac2f189db8809a3c9f750d7700cfc9d21f77
change-id: 20260918-stmmac-rx-mb-16469a2714ea

Best regards,
-- 
Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

