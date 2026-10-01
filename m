Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B14F4CDDEC
	for <bpf@vger.kernel.org>; Thu,  1 Oct 2026 09:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790846800; cv=none; b=ZDv2Ll3pjZQPISyXpf/6Ih9oiMrYFQNbRqK9Gu82lKHzxoW220oAhQ3bvTvlBsce5+ixRtuh6dLs8vHB48fOCdnfmAFiiVMrGHJhmC6Xq8nFGzRCvM9cU7KkZpHjtjK62T6KoO/zRWjUVYCvgp4IIQTi8HxOiD8XSUe2hHC8r1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790846800; c=relaxed/simple;
	bh=NkYY+1DeiRh9z+KuLD2c3bCcQ3Wpe85neE0KaprW3qo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=FN+1xxLQVVV/W0UsHrbzGc6tP87AbCzLFHtAxTyyl36L/fRoFOO6/yld6R+FeFfG/6hxXb408X/LxfIwdqiC8JkUqGgXi0l2xBuJSlCcOlFJrHEpipBrVhSgIDRihnvWRvmYPZIgY6wm9qf01lADsNxsYgyft3lgkluq1egRGeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=e9a/9ElT; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ez1OgUjw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="e9a/9ElT";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ez1OgUjw"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6916xmk21661065
	for <bpf@vger.kernel.org>; Thu, 1 Oct 2026 09:26:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=vL+NGGHGnOqAqDpLAA9zVX
	rhPezAzpq3G+BHPNIYUq8=; b=e9a/9ElTdJXAvPYX0PFefR/z5Lmp4i7RozxKNY
	GXfzWLUPTVDTXh5wEPdyuYJTfb0mFDb6nkAjtnkKo155rPEWADOCTBiGx8+p90EQ
	vqPzx9O1a0JFzSh3h8VeDazroXPj0b6lMfzTOZ30sYV2Mxu9BLXE7HmpoT6mNPc8
	g+4G/NGQkSw0dbgZbHq6mHaj8MqzDeLRiZJHCpI493dq86ZDVy0L1fPKVt+cbeUo
	Al6ARetcA2L41uqH4r9kpNFrp8aJ2rzIJmKh7jVmZ/ttRtuz3y63Z6Td9fNx9Tam
	0/4SHcCGWhKGUyfqEahYCIcT0mW49tTj7ly1DMjQyed6feZw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h167pkjwu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Thu, 01 Oct 2026 09:26:31 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93a3f673221so1702917685a.0
        for <bpf@vger.kernel.org>; Thu, 01 Oct 2026 02:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790846791; x=1791451591; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=vL+NGGHGnOqAqDpLAA9zVXrhPezAzpq3G+BHPNIYUq8=;
        b=Ez1OgUjwsKgH05dlbcdAyuNtnlKq8Tbts582ML4WaJ5wNoXWmNQSuSGjBwZfkU1b0B
         rYSGs4bNWF8uv8eebFzptivMbe3FCrCQAcs9j4WuxO/XrGBQa5Fv8mmle78jAhBvnsQX
         V4GuODHTNUgYdIn85MopFuVxstOLWZq8YAJOJTxj3ag+5F8On49GTU6gTLeygVocnAhA
         OwrY8djvaB9qYT0u4G7OHU+4QCCEmEjcQEk61uKGPK3dxkL8aammiBHasxLtErj3iJG0
         ANerY76gSJ0YTlYF7vtpIlVysUUdrss8GThYNurwcsZ5Tr7h1Mbk3t1dqd5Ehc18A1er
         s+Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790846791; x=1791451591;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=vL+NGGHGnOqAqDpLAA9zVXrhPezAzpq3G+BHPNIYUq8=;
        b=k+BsmQqBpmHFAuz+TDo7Wpz8jo7MZwYX3ebwt6rtYI8PILFueDyB8PFw0N2/mGl4LN
         LYb0MoalkNCVfKcm4S38Ufyzbf9j6ENqwCPVx8bh6sJxygulMw6XDAsQ9vdIRO2FiBAj
         pcPv2TwNuyJ82D4xlkLRlNjI7C8nB4tJbrCVPkQCqXVo9YL4qRA7GJbTAS+zsWfE4AG1
         kca03DpQWCoCP9C/wZ02rpxViaTz2tlXiorxrlkOvhkL371Xn43QGvFls0s5+WFRcp+H
         gHnpwycBYNKVtf/OdsDuI0lxjEHK04OW/wymodZVHjnngC2bmdNWKLK6UGqK994EO4Zb
         9w6g==
X-Forwarded-Encrypted: i=1; AKwUvBwSCuZZMK/AQxaSmN5z+wbxDZyrNfrV7LBYpDveWzL0E8kRS2gaaA0fLZMhjW3lQB8i/uI=@vger.kernel.org
X-Gm-Message-State: AFuF++n4hubU++BqOt7yTcomhObjjrPuQckqSpGq7CSp+zmBMNyvwqTZ
	p5gbru8tpCClbOX/wcfUZFD3EDypj3OsYDnp1dzSY7mG5KkwfsHb4ZTlDwVnGhp+kkfgIoWCSmM
	cyFYkI6uAn2pR/BWSbec24F5HS2EBwNQP0pWOGcIyCNzwjiQtcT8kYos=
X-Gm-Gg: AYBFou3KPySeJTZjsitosdms9NShpQC2IjxFkcG0Tx7xKt18pLij5bfdakobGqHFBIS
	t+qDNrGUNBhy4lMbRVH+ZXLX6FlZwKa4X1MrataSADL/EuQZlLE6FzoE+nFnsJEKBBRorhy0+gQ
	6ApZKVyYdlIkDiW3qS+lDnnyuZ5bpKlWZoHM7K5EJ/B8QDGjIWp1UdJ2kUi1o3w7+EZFQam5StA
	if4juih6T0NdQp+sFYb6OGv5MYMEmGPN4MZOUj3Akl3zSRl+dou9e0xMBx4gzZWkC1mv8naDBHi
	76OdEl4IxkOe10SpG38MSLTXkVR7Ol2BgOQY7rYXvbeDgeLl5BY3MpQmwG/YVmuGTb5kIETEgFk
	asfFxWL99wu9gDg==
X-Received: by 2002:a05:620a:4504:b0:93c:6b90:1d18 with SMTP id af79cd13be357-93ca97b9304mr702908585a.62.1790846791113;
        Thu, 01 Oct 2026 02:26:31 -0700 (PDT)
X-Received: by 2002:a05:620a:4504:b0:93c:6b90:1d18 with SMTP id af79cd13be357-93ca97b9304mr702904385a.62.1790846790543;
        Thu, 01 Oct 2026 02:26:30 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2e31dc751dsm119255166b.67.2026.10.01.02.26.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 02:26:28 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Subject: [PATCH net-next v4 0/2] net: stmmac: introduce XDP multi-buff
 support for TX path
Date: Thu, 01 Oct 2026 11:26:11 +0200
Message-Id: <20261001-b4-stmmac-xmit-mb-v4-0-664e0c3eb289@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XNTQrCMBAF4KtI1k5JJumfK+8hLpI4tQHTahNLp
 fTuhuKii7oZeDzeNzMLNDgK7HSY2UCjC67vUlDHA7Ot7u4E7pYyQ44FrxHBKAjRe21h8i6CN2B
 MWREvKmUbxdLuOVDjptW8sI4idDRFdk1N60Lsh8/6bBRr/3PljjsKEKBLoYXNEYXCcx9C9nrrh
 +29z9JZ0RG3kNqDMEGcS6lKUxqL+R9IbqF8D5IJsppXDceaKmF3oGVZvh6ow6ZVAQAA
X-Change-ID: 20260922-b4-stmmac-xmit-mb-bb78e0684cf4
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
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org,
        Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-ORIG-GUID: Ry1dalVpaaPXO7BbIrLO6BTzmK13M00k
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDAzNyBTYWx0ZWRfXxzbLORyZPeTo
 MInfR9wTX7I0qCOEUAeE7bdMQcHjeeyJCHtv4HkAfSgqrIUR0qVE3q1py8PiWtWRid6sW46Pk0O
 9QZXt1Ku+/XtVfXJ0vhQa4MfP5Ro5d4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDAzNyBTYWx0ZWRfX7ntWOmM3b6Kg
 NMO5Yudcn4sTPH+d2nTrlQy8KzgYHn29b+ov4EeCk36/NUoAeXw3exCQ5lbDrJydwzvl4AMhTh0
 HZHVEd9D9c0MIbEFFmc4/BEX0IgwmFBHnhjaIZQvScTWir29C6ViSs6AtT3xfkFN3gavktI3GD8
 8kfG8SHEa/mAeNJLPJ6PPd+VMocQZKUZtKhr7++JJBtc6sGyEelmR92fFy3mtJsRn0R0Qrw0CnM
 gb8dGtPrGSTWQtWQ224PNNZbjXFkp+hcZAB4hFYTKY+uIR3PCHreKBmyHOi4D0xuR0RT4BZ15Cy
 2fuCSNqYyyYlP495b4i5JiT9JsqjVih+IlySAKo5qKshUDMNSjpNO3wCJNCenMgpFEoPBGb9Vnp
 NXo4GJsJh5vSKJgnDqcvAn6VoWosfqfQTEqTKIRig4LqcxykuUNkeW17ouyZypsE0HgGi7a6YqR
 MMNrwgc+48nky6N951Q==
X-Proofpoint-GUID: Ry1dalVpaaPXO7BbIrLO6BTzmK13M00k
X-Authority-Analysis: v=2.4 cv=WpC+otfv c=1 sm=1 tr=0 ts=6abe2747 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=VKprxIfjjedsZqdkuwoA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 impostorscore=0 adultscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610010037

Extend stmmac_xdp_xmit_xdpf() to transmit XDP frames with fragments.
Fix TX coalesce race and div-by-zero in XDP/legacy path

---
Changes in v4:
- Add patch 1/2 to fix theoretical division by zero issue in xdp/legacy
  tx path.
- Link to v3: https://lore.kernel.org/r/20260925-b4-stmmac-xmit-mb-v3-1-ca08f029e81c@oss.qualcomm.com

Changes in v3:
- Advertise NETDEV_XDP_ACT_NDO_XMIT_SG capability.
- Add missing dma_wmb() before setting OWN bit of the first descriptor.
- Link to v2: https://lore.kernel.org/r/20260924-b4-stmmac-xmit-mb-v2-1-003347b7bc25@oss.qualcomm.com

Changes in v2:
- Fix Tx coalescing logic in stmmac_xdp_xmit_xdpf()
- Consider the max between STMMAC_TX_THRESH() and num_frames as
  threshold in stmmac_xdp_xmit_xdpf().
- Link to v1: https://lore.kernel.org/r/20260923-b4-stmmac-xmit-mb-v1-1-a71a1c522142@oss.qualcomm.com

---
Lorenzo Bianconi (2):
      net: stmmac: fix TX coalesce race and div-by-zero in XDP/legacy path
      net: stmmac: add XDP multi-buff support for TX side

 .../net/ethernet/stmicro/stmmac/stmmac_ethtool.c   |  11 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  | 160 +++++++++++++--------
 drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c   |   2 +-
 3 files changed, 107 insertions(+), 66 deletions(-)
---
base-commit: ea3b2f0356c2f33022c10dc7ad3fd02bf4aa517c
change-id: 20260922-b4-stmmac-xmit-mb-bb78e0684cf4

Best regards,
-- 
Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

