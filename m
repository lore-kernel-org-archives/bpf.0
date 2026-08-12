Received: from mx0a-00190b01.pphosted.com (mx0a-00190b01.pphosted.com [67.231.149.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EBF53ECBE3;
	Wed, 12 Aug 2026 09:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786526161; cv=none; b=L4LnLuJfuKPS0JLMvqEG9mP2EJ8P9LmYW1lBB7hLIOa/5USphKlibQx1bV49KjnycGx3ut54LOFymiNJZl3DKSIiLPg+QUV8S7KUsRbwQERhaHFREBFi9rjJWjWFpO5cFwhD2lEzBKgbNSmm08VJNbtgRa0Hm8tT/kgWzm1y1XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786526161; c=relaxed/simple;
	bh=j/Gf7eG2L4EQepA6SKCL4ijYtNRQpB5EftU7kryKkC0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tea/0JR5nsD0XgnTc9uCeJrQGNuVERHWH+ivjLfax1ougHUyrU55hgLH9eMaDy1z53pwfqCaPh/bAbeneNquMyw2N0MUrmTOORh0hQsokLw/ynMcNKjMQjF0PDdr/zPtYq/8GVAHEQDL0J6KNS3to3HpxY1Upl1d5le8FX7vMZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=akamai.com; spf=pass smtp.mailfrom=akamai.com; dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b=L/EFvqst; arc=none smtp.client-ip=67.231.149.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=akamai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=akamai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="L/EFvqst"
Received: from pps.filterd (m0409409.ppops.net [127.0.0.1])
	by m0409409.ppops.net-00190b01. (8.18.1.11/8.18.1.11) with ESMTP id 67C63ohU1886961;
	Wed, 12 Aug 2026 09:31:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=apr2026.eng; bh=cbQQ4iEE+b4gAkybCIk+iiJ6KTlvNOVX7
	RGoObD0EVE=; b=L/EFvqsts8cDhRNl8Hbi5XCZGKgXtNyKORNELr0A7HNSBQIU/
	ACvV6Wz9g8jxeZ/BX/H9bWbImNmdJw+LipQcYGYDb755xJqKJP1G6ILyAMoMxQ5w
	BpU/oCFkS744ghCvb+cGemQ4sEGdyJJOcC2th7uCTZfV09dQEqGbfqup+KZ+/nsm
	OoibWCjjB1Lw4ri0NxrUPYPKiQmNQATpmN17hxFJ/P6bF1dRaj3eTkM04ARx+vC9
	IlHUXvG6bNtbERX64ZJmZTE2S/CTh8gPzk4ihj9Aj/GrILhNljFlTRlBdXnsHosT
	T4Vh1OqDwaJF2Lmfe1X/w42uxYPmuTVcPShww==
Received: from prod-mail-ppoint2 (prod-mail-ppoint2.akamai.com [184.51.33.19])
	by m0409409.ppops.net-00190b01. (PPS) with ESMTPS id 4g067ps048-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 09:31:24 +0100 (BST)
Received: from pps.filterd (prod-mail-ppoint2.akamai.com [127.0.0.1])
	by prod-mail-ppoint2.akamai.com (8.18.1.7/8.18.1.7) with ESMTP id 67C8JfXH028034;
	Wed, 12 Aug 2026 04:31:22 -0400
Received: from prod-mail-relay01.akamai.com ([172.27.118.31])
	by prod-mail-ppoint2.akamai.com (PPS) with ESMTP id 4fwyswxv82-1;
	Wed, 12 Aug 2026 04:31:22 -0400 (EDT)
Received: from muc-lhvdhd.munich.corp.akamai.com (muc-lhvdhd.munich.corp.akamai.com [172.29.0.147])
	by prod-mail-relay01.akamai.com (Postfix) with ESMTP id C6BC680;
	Wed, 12 Aug 2026 08:31:21 +0000 (UTC)
From: Nick Hudson <nhudson@akamai.com>
To: bpf@vger.kernel.org, netdev@vger.kernel.org,
        Willem de Bruijn <willemb@google.com>,
        Martin KaFai Lau <martin.lau@linux.dev>
Cc: Nick Hudson <nhudson@akamai.com>, Max Tottenham <mtottenh@akamai.com>,
        Anna Glasgall <aglasgal@akamai.com>
Subject: [PATCH bpf-next v7 0/6] bpf: decap flags and GSO state updates
Date: Wed, 12 Aug 2026 09:31:09 +0100
Message-Id: <20260812083115.73100-1-nhudson@akamai.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_02,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 adultscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2606160000
 definitions=main-2608120066
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA2NyBTYWx0ZWRfX5xeDKDvRlmSZ
 wGhON4KswJZf9iZKmA1Ru/ktmy/3Tv4XgU3CRL0Y7mY3msw7UiWGBtVYvBywlspvZyam15zc8oz
 3wy+0+kkXXRUHwap7vSXJxl66Ned3diWabV0gopXJeJww/7RXjDRlqxnM2mnwcWx2addymHfsWj
 Fsm3Qu8e0qdKi+vbuHsODvziwiUwE0w7u1XhTtf3TbIhQM8GGb8ZXFUyzjYJteFgzqLULyku0Hr
 v3VYOAoavwt9Hxo85Mg8Ar1l2GB+zsolFec3S0FXKS7ulKNvNaqVDRfsJl54+yc24mKICr5sVOH
 FJVJdA9Dz7CKYQU4BrMmDSrcB7+I2DiuwoGk8ogpGX2l7xXO0vJrDnqNGlyCpmEYJgcm5Mrrv2L
 wmQn/fIEmf9yfUFDjhl0gq6Q1kj9/Ka4IkmBcBii+g6+74bFA8reG7aFRGSIPWulvcONZnMO/m+
 De3H5g1Q0tpPVEYwRzg==
X-Authority-Analysis: v=2.4 cv=eYYNubEH c=1 sm=1 tr=0 ts=6a7c2f5c cx=c_pps
 a=BpD+HMUBsFIkYY1OQe22Yw==:117 a=BpD+HMUBsFIkYY1OQe22Yw==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Ifg-1AOnLHOf1gn6spyb:22
 a=TTBIr9FR-UdC54aaq7Eb:22 a=X7Ea-ya5AAAA:8 a=g1FTZKP8ERfPk9Mz4Y4A:9
X-Proofpoint-GUID: fyKw3vLDRcQ20Rr-VCLvZ_QdygPNn7vN
X-Proofpoint-ORIG-GUID: fyKw3vLDRcQ20Rr-VCLvZ_QdygPNn7vN
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA2NyBTYWx0ZWRfX9Qp8Wghq+eMk
 NsxAB9+dcSOv3S7BMka+SOrSF75bfph5yr5RdudpXuolOVZOzZ69ngIDPPl5yT4C+OjqfF0XlMs
 88v/uVQhi1FET+T1NvRCfetPIi523zw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_02,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 suspectscore=0 spamscore=0 priorityscore=1501
 clxscore=1011 malwarescore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606160001 definitions=main-2608120067

This series extends bpf_skb_adjust_room() with decapsulation-specific
flags and tunnel GSO state updates for decap use cases.

Motivation
----------

When BPF decapsulates tunneled packets, skb GSO state needs to be
updated to match the removed tunnel layer. This includes clearing the
corresponding tunnel GSO type bits and resetting encapsulation state
once no tunnel GSO flags remain.

Series Overview
---------------

- Name the adjust_room flag enum for CO-RE lookups.
- Refactor adjust_room helper masks for maintainable validation logic.
- Add new DECAP flags to UAPI.
- Add guard rails for incompatible/invalid decap flag combinations.
- Implement decap GSO state clearing on shrink.
- Add selftests to validate decap GSO and encapsulation state.

Changes v6 -> v7:
- Resend only for formatting/threading fixes (no functional changes).
- Rebase onto current bpf-next/master (d114bb989367).

Changes v5 -> v6:
- Patch 5: extend decap-state handling for the new L4/IPXIP decap
  flags to non-GSO packets as well: when decapsulation is requested
  on a non-GSO skb, clear skb->encapsulation directly so behavior is
  consistent with the GSO path.
- Patch 6: broaden tc_tunnel coverage to exercise and validate both
  GSO and non-GSO decapsulation paths. This includes selecting
  IPXIP decap flags from the outer tunnel header family, adding
  explicit post-decap encapsulation checks for non-GSO packets,
  and removing forced TSO disable so GSO cases are exercised in
  the test harness.

Changes v4 -> v5:
- Patch 5: Remove explicit clearing of encap_hdr_csum and
  remcsum_offload on UDP decap, per review feedback.
- Patch 6: Remove SKB_GSO_TUNNEL_REMCSUM from SKB_GSO_UDP_TUNNEL_MASK
  in selftests, and minor test improvements.

Changes v3 -> v4:
- Patch 5: drop SKB_GSO_TUNNEL_REMCSUM handling from this series.
- Patch 5: clear encap_hdr_csum and remcsum_offload directly on UDP
  decap.

Changes v2 -> v3:
- Add a new selftests patch to validate decap GSO state behavior.
- Reorder the series so helper-mask refactoring precedes UAPI DECAP
  flag additions.
- Refresh patch 2 and patch 3 split to keep refactoring
  behavior-neutral.
- Patch 5: add decap tunnel GSO-state checks in "bpf: clear decap
  tunnel GSO state in skb_adjust_room" (per Gemini/sashiko).

Changes v1 -> v2:
- Patch 3: decap flag acceptance intentionally remains L3-only while
  adding helper masks.
- Patch 4: decap with L4/IPXIP support enabled with guard rails.

Co-developed-by: Max Tottenham <mtottenh@akamai.com>
Signed-off-by: Max Tottenham <mtottenh@akamai.com>
Co-developed-by: Anna Glasgall <aglasgal@akamai.com>
Signed-off-by: Anna Glasgall <aglasgal@akamai.com>
Signed-off-by: Nick Hudson <nhudson@akamai.com>

Nick Hudson (6):
  bpf: name the enum for BPF_FUNC_skb_adjust_room flags
  bpf: refactor masks for ADJ_ROOM flags and encap validation
  bpf: add BPF_F_ADJ_ROOM_DECAP_* flags for tunnel decapsulation
  bpf: allow new DECAP flags and add guard rails
  bpf: clear decap state on skb_adjust_room shrink path
  selftests/bpf: tc_tunnel - validate decap GSO and encapsulation state

 include/uapi/linux/bpf.h                      |  36 +++++-
 net/core/filter.c                             | 119 +++++++++++++++---
 tools/include/uapi/linux/bpf.h                |  36 +++++-
 .../selftests/bpf/prog_tests/test_tc_tunnel.c |   1 -
 .../selftests/bpf/progs/test_tc_tunnel.c      |  91 ++++++++++++--
 5 files changed, 252 insertions(+), 31 deletions(-)

-- 
2.34.1

