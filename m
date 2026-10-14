Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636182D47FF
	for <bpf@vger.kernel.org>; Wed, 14 Oct 2026 13:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791983397; cv=none; b=aA0UyL27AZiVI0SCXydcarGeWTcClu7+8ITv646zoq3Gt2vUBAFzTDY4zJLvnwyTVtccwK9qPlxhzKaQg6sr1wQirFOJPr8wZSJz18lpPXwr13oTtBWmxx18SdFwKbvxrLGk86DDMFyyNmHh5+rOfFPH8xuGNHzN3KF6g9MzB0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791983397; c=relaxed/simple;
	bh=oe0higQISNHB33yUruYCuFebMzPfyj0nuhkmsdVIpqk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Y0Ij+5va9ZboJDlOIW1eHQlmml2w45HVFlzyIsMgL5xexrIhU9BmCxl9yPwhY1eUXoHkJU6VnrE6G9PAjbgQTcPyY0DKdCE5/4XItTmqRoSWqoutox5OKLuCM+gnmCUrdjQNcllUGCpp5XlTLcY4fZ9mRWMbk2R58+9dnfit4zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZfNPI99D; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TlEnewcg; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZfNPI99D";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TlEnewcg"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69EBJxDK3365360
	for <bpf@vger.kernel.org>; Wed, 14 Oct 2026 13:09:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=fxVyJQjkYpcPZ3DCNVSAAY
	sZSsu0sxPUoy58SbGtpRg=; b=ZfNPI99DaVzQX3sTpcqZYOPv/jC4NxkL4HBaXI
	4mBUJeYCXB7XRio2Ac6VNBoz2xHjBCmem5DM1tPz4DPL1Ypc/U77HMa/Fn4iUfJP
	/zsKhQHEnm1dabsLEbAubtUZqlY/syypHAj93izv62iB7BAHxwiatWUsR3dI3myL
	nSgIlB/nhwvrprCkS0nSGQQZB8YO3Xn+330EL0mhgK1PskrGEpHRuSPDGAW++D3s
	vJ5tz6VXAXFOnI/8dv2JBRfZOTzMOxu0hFJoc6eDrHWrKA9l6WpMHutsh4u8CY20
	kY3vdUUDUjop60ZfKp/N9ARjWMl6Qwcam9KJnlPSGX6BtQeQ==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com [209.85.217.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ha4621q9s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 14 Oct 2026 13:09:55 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-7c07f9547d9so604909137.3
        for <bpf@vger.kernel.org>; Wed, 14 Oct 2026 06:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791983394; x=1792588194; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=fxVyJQjkYpcPZ3DCNVSAAYsZSsu0sxPUoy58SbGtpRg=;
        b=TlEnewcgdHqvvz2Nug+Qi3KcHcG/dFml4ZYM6UpI5wr8w6pLTAeQJwDU6hGIAprs/6
         anf+ZzTlS4dbqrSO+9qTk81d8VitN//PQ8UXb+aHK262vU6E6xKdv1vmRd2G+x638GpA
         F3MNk3mldychTtMtt0eXJcEF9R9bk04ayagq5g7Wpd+iYhovsR1dsO0tpxKLPhqgO7ZR
         kUl7Qn0PrZoPJrAXaZNXCzydUq7EjQ2fxa/M5ex5M6L6beNMTRE2Uh/MusyByGHCYsVS
         fgIfwU9a6k8WNloBmoLL52HyXogRvheFfIjrmNYsjD6Coswe11EDKLjhIZOMY2u3vpId
         4yOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791983394; x=1792588194;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=fxVyJQjkYpcPZ3DCNVSAAYsZSsu0sxPUoy58SbGtpRg=;
        b=wmqC1FC+gXccLYHR6KUwjnxR9ebng05EgRizFfQahlkaIxtVT0Nds/FBI/l7rUyVK4
         KhGmYOpn8Fg5Qun0qUnXI2TZv60mcSzrib3s6zrjThZMzOKVboMCsORw09aKp1ARR9d/
         BqUrU9VZI0FLkKJKwhIcJFsUCoCFI2lz9f80I9mXVNQsX2GNPXLfxkXz1ZH0iZuRRxR3
         goQDj6BCZqYuRsK4JM3bm5zV6tdKM7MFkCI+1kns2rKfTwCeO/rRmFFJ7KSyVXWeUip1
         Iytmfa8z/d+0IBtjBV2Vs9ogYak7ouT9vjzxYrD6igoTxF5x3h6oFb9tS9XlIMmHsmMc
         95ZA==
X-Forwarded-Encrypted: i=1; AKwUvBwAF1QQBAUk1l9xvYyqWciKI5SwAx80+WnZIdNVZcAK17rSG6dKkN+ZUoVx09GuYBbSjYg=@vger.kernel.org
X-Gm-Message-State: AFq9FYJC1UrihRvKSI1bGQLudWM8hROD/EP1601pjKxIKNMOBT979Kvo
	Usv4BjeB0iAq5Dby3ajwfZVhfNoih370jd5I/07b3VNmPt8nIZZz37WCziw8UTJJLG709rXxooI
	0vWNBFvH2vGG2hx/Oe481Kb6FOwLEE7Zi0iOucHP+ZiDLiGzGiwom0uw=
X-Gm-Gg: AYBFou2jwZbQPRyViv5z/3zeu2DKpDq+ze0EU+10wMeHtF8+o/it3pqeaAq5DPw8WjB
	wgYmrSLTrr3SByzo0pe8kjhoHr6KqbCtK/6JoKkCuBI+mTJwXZFv6ZW3dW7runA3BLHLZjIQB1Y
	l7qaSuLmRxBTEYTESONQ1cFvbHrUh4hn1xpJZb5Gt8mrGsutQknMmEPGZmiyKpYyrRzUnw6Le5n
	ijZ7dGLO7N7wM0/uaFDB7Bj/gw+1xCzI2Asn4z7k5Xwq/HQtgZPKbk2YLwFgb/L9oPBEtrrccUd
	DhQLX9z0dmWX1SxRxxD67qIcfl9OoVhnRrz2pJotWaBwA82HVJrWB/4BkOJXMRfloRFf/xtuw1Q
	VyWeBbEVLAOwj0A==
X-Received: by 2002:a05:6102:869a:20b0:7cb:bc5e:7dad with SMTP id ada2fe7eead31-7cbbc5e9b16mr1454820137.10.1791983394283;
        Wed, 14 Oct 2026 06:09:54 -0700 (PDT)
X-Received: by 2002:a05:6102:869a:20b0:7cb:bc5e:7dad with SMTP id ada2fe7eead31-7cbbc5e9b16mr1454810137.10.1791983393670;
        Wed, 14 Oct 2026 06:09:53 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0ac5265sm12641340f8f.41.2026.10.14.06.09.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 06:09:52 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Subject: [PATCH net-next v7 0/4] net: stmmac: introduce XDP rx multi-buff
 support
Date: Wed, 14 Oct 2026 15:09:34 +0200
Message-Id: <20261014-stmmac-rx-mb-v7-0-5d2d70f052cd@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XQz2rDMAwG8FcpPs/Fkv8k2WnvMXZQXXk1LEkXZ
 yGj5N0nchghNBfBx4d+Aj1U4SFzUa+nhxp4yiX3nYTq5aTijbpP1vkqWaHBYBqodRnblqIeZt1
 eNAQXGsIKHJOSlfvAKc8r9646HnXH86g+pLnlMvbD73pngrV/Tk6gQZuL81BdnXGU3vpSzt8/9
 BX7tj3LWL0JNwbCzkAxAtcYGFKyJhwY9t8AY9zOsNpobxJBBZQajgeG2xphZzgxOJGL1FSO7fX
 A8Fuj2RlejGhrUZgIbH1ghI0BuDOCGIjojZeH+whPjGVZ/gAGKGRBDQIAAA==
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
Cc: netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        bpf@vger.kernel.org, James Hilliard <james.hilliard1@gmail.com>,
        Nicolai Buchwitz <nb@tipi-net.de>,
        Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-ORIG-GUID: FfUYxVtxeZRfgDtbOwD5GvJSHKeecwp0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA1MiBTYWx0ZWRfX8xZZIrYv/Ham
 CiV5RcBtYevNf6+6HU7s5a9wscDICjW2bIPjRNETpXP9Lg+rrUaJhGK2F3tuM150A/RCaPTGx8B
 kVbPgkqPJOKgASwfEKyssDPjwK4u8NHe0rpWiTCXNAVd5HL+QWgKcfkKBmOzVchOIfPfNWW/m60
 41cAE0jen86Z/YYpu0GETKlbbS03e0dTnNMR6jJDGsbk42I7rx2+FQA1sroM31OV8N5RLwZvuIV
 l/+rhO5sY+CAZ31laHH/ROagPEQNve5gs2ewqHOlwwBzwR+eGuSmDMeaZxORvKvlKqZiEtwTJwl
 3rGbz3SepTh6CT1JM8YRQef7btJSsBVzb0TTuzdIkbSzMrcWQINK84/YHUjfeUsT2wfnwADg8+8
 DfGGbPfcxSRg5vkOtKeWEsCGPKsx94HLF00O19rS0rG79WXqLOAv1IbLJQot8ydibP56yY2TaFv
 YJtSStfPwdIsK6LTqYw==
X-Authority-Analysis: v=2.4 cv=ErZHPicA c=1 sm=1 tr=0 ts=6acf7f23 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=u4BqklbH0r9NqUsF4ZAA:9 a=QEXdDO2ut3YA:10
 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA1MiBTYWx0ZWRfX3Fq/3MqTXHmS
 F7hqGL+WDQ10iwzvRdk9YYpxkI1Qa7OgPfzL/6G5vCeYNP2dfSiI5DDWg4Ja0VALwxxflATsWBo
 k8wO2/RygyFCAe0mWdwox1S2dz6mPSU=
X-Proofpoint-GUID: FfUYxVtxeZRfgDtbOwD5GvJSHKeecwp0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 bulkscore=0 impostorscore=0 adultscore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140052

Rework stmmac_rx() to build the xdp_buff from all the descriptors that make
up a frame, so the XDP program runs on the whole (possibly fragmented)
packet instead of the first buffer only. Fix possible rx_q state leaks
when closing/opening the interface.

---
Changes in v7:
- Take into account the case where buf2_len is not 0 for the single
  descriptor case if the interface is running in xdp mode.
- Report rx_not_ls bit if the packet is splitted over multiple
  descriptors for dwmac100 and dwmac1000 cores.
- Link to v6: https://lore.kernel.org/r/20261012-stmmac-rx-mb-v6-0-2225050915c1@oss.qualcomm.com

Changes in v6:
- Drop patch 'net: stmmac: allow non-linear xdp_buff in XDP mode' since
  it requires some XDP fixes.
- Introduce patch 'net: stmmac: drop split frames on AF_XDP zero-copy
  RX' to always drop XDP multi-buff frames for AF_XDP mode since it not
  yet supported there.
- Introduce patch 'net: stmmac: drop multi-buffer frames in XDP mode' to
  fix pending bugs due to missing XDP multi-buffer support before patch
  'net: stmmac: rework stmmac_rx to support XDP rx multi-buff'
- Link to v5: https://lore.kernel.org/r/20261009-stmmac-rx-mb-v5-0-c38fa4eaa138@oss.qualcomm.com

Changes in v5:
- Fix possible read after bound issue in patch 1/3.
- Do not allow parsing non-linear XDP buffers if the program loaded does
  not support frags.
- Add patch 3/3 to remove MTU constraint for XDP prog.
- Link to v4: https://lore.kernel.org/r/20261006-stmmac-rx-mb-v4-0-efa4ca974e3d@oss.qualcomm.com

Changes in v4:
- Reset in_progress flag when the packet is fully consumed.
- Advetise NETDEV_XDP_ACT_RX_SG capability.
- Link to v3: https://lore.kernel.org/r/20261004-stmmac-rx-mb-v3-0-50fa171af9ec@oss.qualcomm.com

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
Lorenzo Bianconi (4):
      net: stmmac: take ownership of saved RX state at poll entry
      net: stmmac: drop split frames on AF_XDP zero-copy RX
      net: stmmac: drop multi-buffer frames in XDP mode
      net: stmmac: rework stmmac_rx to support XDP rx multi-buff

 drivers/net/ethernet/stmicro/stmmac/enh_desc.c    |   2 +-
 drivers/net/ethernet/stmicro/stmmac/norm_desc.c   |   2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac.h      |   3 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 407 ++++++++++++++--------
 4 files changed, 259 insertions(+), 155 deletions(-)
---
base-commit: 05b5019b01fb9443b09ae4ed34af1135a80a84c8
change-id: 20260918-stmmac-rx-mb-16469a2714ea

Best regards,
-- 
Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

