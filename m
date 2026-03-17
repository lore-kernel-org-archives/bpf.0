Received: from mx0b-00190b01.pphosted.com (mx0b-00190b01.pphosted.com [67.231.157.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D043BD25C
	for <bpf@vger.kernel.org>; Tue, 17 Mar 2026 12:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.157.127
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773749698; cv=none; b=kl09Uqr+a8Hz0JAF88988yxTZOjiePd8zd0EYSy5ecJPybSIbseh8mVm9EOTGiTDBs/pXNZCueqTFN4suvpyGwyK1HIuwt+nOLZU8ihfB4mDbcKQfiG+EzjCNyNV+mAtgY2gcZtEP4s/md0epG843g5mIHEevTGRX9GPmSytoko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773749698; c=relaxed/simple;
	bh=iUIA9SMVoQBBMlDhoBceuGZ6QblLltcVewq2ws5Q9mY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dE/jBzMnX7ko7owZlKnoBeDdpfXWgWA3JYatJc2Uf0y6YTmKrl3pxsO1mfnN2ySBkzII6JLBzHisr9kGz0zFW/rhf5NBqphDdcRrqRqROhkLij5MpQ/5BV80BASV3MqBZw9JwdhHjgFiwZr9/v7wID49mRMF8DbQlAH6Q25vplY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com; spf=pass smtp.mailfrom=akamai.com; dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b=UBe8an0f; arc=none smtp.client-ip=67.231.157.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=akamai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="UBe8an0f"
Received: from pps.filterd (m0409410.ppops.net [127.0.0.1])
	by m0409410.ppops.net-00190b01. (8.18.1.11/8.18.1.11) with ESMTP id 62H7rvbX147991;
	Tue, 17 Mar 2026 12:14:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=jan2016.eng; bh=+PBBQs5irNdBsRJS6mnfXoAKbjVM4dtQs
	WxirXgSZDA=; b=UBe8an0fKwPvkSlut2PPj1dTQqhgDpxt/mlMJdQRmIsuRlxLH
	1CiXGWXBiXB7WIo+xBAXCwaH7Z2DgBE8E+YnERA4e5qTkR0hd2yJ4ZtfbDaKXdG3
	fxztdYlImKiF2v9dyoecHSXlv5XtiND80rPAb9ncau5AyBeXZskN25UubIoco8fj
	DThGxF7eMzXoSCjeQt+r+fWjIfzaX81NLKRCKCljcCxJuvyOPFmEgFrbQxWo++CE
	SygQQ4Wc+okggSOmBmS41rwahZW5ytmlXriC1nUBpPgCGMzvklDD0tSW9eXVtbDa
	LEEmC8f4f70exIbuOYjYlCyl6PUdvLP8m/Kfw==
Received: from prod-mail-ppoint1 (prod-mail-ppoint1.akamai.com [184.51.33.18])
	by m0409410.ppops.net-00190b01. (PPS) with ESMTPS id 4cwkf8r9t1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Mar 2026 12:14:49 +0000 (GMT)
Received: from pps.filterd (prod-mail-ppoint1.akamai.com [127.0.0.1])
	by prod-mail-ppoint1.akamai.com (8.18.1.7/8.18.1.7) with ESMTP id 62HC43Iu027969;
	Tue, 17 Mar 2026 08:14:49 -0400
Received: from prod-mail-relay02.akamai.com ([172.27.118.35])
	by prod-mail-ppoint1.akamai.com (PPS) with ESMTP id 4cw30xjvku-1;
	Tue, 17 Mar 2026 08:14:49 -0400 (EDT)
Received: from muc-lhvdhd.munich.corp.akamai.com (muc-lhvdhd.munich.corp.akamai.com [172.29.0.147])
	by prod-mail-relay02.akamai.com (Postfix) with ESMTP id 62B5783;
	Tue, 17 Mar 2026 12:14:48 +0000 (UTC)
From: Nick Hudson <nhudson@akamai.com>
To: bpf@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Nick Hudson <nhudson@akamai.com>
Subject: [PATCH v1 0/5] bpf: Add tunnel decapsulation and GSO state updates per new flags
Date: Tue, 17 Mar 2026 12:14:24 +0000
Message-Id: <20260317121429.2399539-1-nhudson@akamai.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_01,2026-03-16_06,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0 bulkscore=0 mlxlogscore=788 lowpriorityscore=0 malwarescore=0
 spamscore=0 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2603050001 definitions=main-2603170107
X-Authority-Analysis: v=2.4 cv=SoSgLvO0 c=1 sm=1 tr=0 ts=69b945b9 cx=c_pps
 a=StLZT/nZ0R8Xs+spdojYmg==:117 a=StLZT/nZ0R8Xs+spdojYmg==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Ifg-1AOnLHOf1gn6spyb:22
 a=KDzEjHMMTas96-nIEKpj:22 a=uXt6CUtHl8vvQ0Uq5DwA:9
X-Proofpoint-GUID: avT0EsWoPLhqEWJWk4QcT12Q9qcsfwLy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE3MDEwNyBTYWx0ZWRfX1Vg4tnQ0L0nY
 B/rIk2nKvxXa8uChD36J2ahHHSCYk7oJhDRWMEeT8MHx3nrI4ieIiR7exC9M4Ys2s7tFGyDm8bC
 kSqs/Hmd+0dvT5fyenufMaeWRLCGV0Hlg/hwGLDUfD18hoYwz+abKTPbW3AgyZTGX36OW0EkcIL
 /5c9Hq1zD9VXKOmYfUbYz2gPEqGPeer/7dhtnk3DL4mQ+DxIHUypc+g/S2pCrk/biMANwO9zfy9
 5lNWEXlxMGLOPysTW7rkBe4DT3Qwydcy+cXNAPU4wvN2trE1oJ0fH8CgJ0IyspOQotwyB85irMF
 H+4EypbGZrLhLSgWpOO2XVs1X8VkOnpBg4EPra8OdZUYdNsBzpIVTDa6zda7X1zsRenLP7pPi2/
 WTCh4F35lG08bwiSqIhN+L5BwXMl1PrNEeIWLmY/SKGqlJFjaDHPsYcn1978fOrJsngyvojy15q
 Cw/hJ/JgGQUGKUDhY7A==
X-Proofpoint-ORIG-GUID: avT0EsWoPLhqEWJWk4QcT12Q9qcsfwLy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_01,2026-03-16_06,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015
 priorityscore=1501 spamscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 adultscore=0 phishscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603130000 definitions=main-2603170107

This patch series enables BPF programs to properly handle GSO state when
decapsulating tunneled packets by adding selective GSO flag clearing.

New decapsulation flags:

- BPF_F_ADJ_ROOM_DECAP_L4_UDP: Clear UDP tunnel GSO flags
 (SKB_GSO_UDP_TUNNEL, SKB_GSO_UDP_TUNNEL_CSUM)
- BPF_F_ADJ_ROOM_DECAP_L4_GRE: Clear GRE tunnel GSO flags
 (SKB_GSO_GRE, SKB_GSO_GRE_CSUM)
- BPF_F_ADJ_ROOM_DECAP_IPXIP4: Clear SKB_GSO_IPXIP4 flag for
 IPv4-in-IPv4 (IPIP) and IPv6-in-IPv4 (SIT) tunnels
- BPF_F_ADJ_ROOM_DECAP_IPXIP6: Clear SKB_GSO_IPXIP6 flag for
 IPv6-in-IPv6 and IPv4-in-IPv6 tunnels

The existing anonymous enum for BPF_FUNC_skb_adjust_room flags is
renamed to enum bpf_adj_room_flags to enable CO-RE (Compile Once -
Run Everywhere) lookups in BPF programs.

Usage example (decapsulating UDP tunnel with IPv4 inner packet):

 bpf_skb_adjust_room(skb, -hdr_len, BPF_ADJ_ROOM_NET,
                     BPF_F_ADJ_ROOM_DECAP_L3_IPV4 |
                     BPF_F_ADJ_ROOM_DECAP_L4_UDP);

Nick Hudson (5):
  bpf: name the enum for BPF_FUNC_skb_adjust_room flags
  bpf: add BPF_F_ADJ_ROOM_DECAP_* flags for tunnel decapsulation
  bpf: add helper masks for ADJ_ROOM decap flags
  bpf: add guard rails for new DECAP flags
  bpf: clear decap tunnel GSO state in skb_adjust_room

 include/uapi/linux/bpf.h       |  36 ++++++++++-
 net/core/filter.c              | 109 ++++++++++++++++++++++++++++-----
 tools/include/uapi/linux/bpf.h |  36 ++++++++++-
 3 files changed, 158 insertions(+), 23 deletions(-)

-- 
2.34.1

