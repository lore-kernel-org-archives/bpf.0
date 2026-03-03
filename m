Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B040B381AFE
	for <bpf@vger.kernel.org>; Tue,  3 Mar 2026 18:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772561458; cv=none; b=iefm4AA4yRkpZQsr9S5hynGUgzDrO/BqM/LS2T0SA+XbodiYoR7pAIHupMVyiiKiXF2uaFeVuVOiXaYJmYwGvughgcDVGqyzWEhBWlefNczVZgX7bseFkTCvzpHSjcmqz3OGKLTpWQEgvxdAaR/y0EA2kpYFT22INM3n7+PA+Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772561458; c=relaxed/simple;
	bh=bVkOecfZXlQczZYtq+j97rDIHA6Vhh21m9ssb5VNlYw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Mmz0JgB+3TvF5Vwykt6AVi9nFAzgfze2+9pS9SjT7mWRNKVLmWZwfkh3dqYzmTWOw9sp2ngzXHIeU5QXV1YPUjYvoVOB7X4HiGmOMvFdwHkIPwPk6o/WfTCHQIvg9AeIIt+ZFePyDU6yiHzzFQWw53i/XqlQp5aEFJW11ZHrWrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LXOKWIG7; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LXOKWIG7"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6236V7L11994861;
	Tue, 3 Mar 2026 18:10:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=g1/bDvKR9DZrP1UcznGemOE2aCvY6OgeiTEY5wODs
	to=; b=LXOKWIG7ROCI9F7U9L9DyiGnu0Qc9MFMMU1APoA9GqQci+s8DzSeJZ3lw
	KRDnmP8u2ILueUGeHML76COZXS2vHuzIeOcixzYX88n6OY49PUaQTxIFFl8A5R/F
	42OQffKuhDtEjBxCt4fDmnRmdLT9mGH+Kz5z25hzyFfkK8oHt8kBSCU0XocgCA8r
	nOHwc+0WmjWduNGbednJoMwUsZ09OS1bzy3XiJNH3VOuYhurATT8S42NdXGKfIp8
	mvDm0ds8TI26Y8FOqtC7a+80nVc7a77cQpJMS0XnJzhOiTc+p90SV20hjZmLRUIT
	y9Ey9jt7InghzofjbhFfrvcQqzaWQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ckskcv932-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Mar 2026 18:10:39 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 623E5RFC016756;
	Tue, 3 Mar 2026 18:10:38 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cmbpn3fqj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Mar 2026 18:10:38 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 623IAYDx57344496
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 3 Mar 2026 18:10:34 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2511D20043;
	Tue,  3 Mar 2026 18:10:34 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 039A020040;
	Tue,  3 Mar 2026 18:10:32 +0000 (GMT)
Received: from li-bd3f974c-2712-11b2-a85c-df1cec4d728e.ibm.com.com (unknown [9.43.53.81])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  3 Mar 2026 18:10:31 +0000 (GMT)
From: Hari Bathini <hbathini@linux.ibm.com>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Cc: bpf@vger.kernel.org, Madhavan Srinivasan <maddy@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Saket Kumar Bhaskar <skb99@linux.ibm.com>,
        Abhishek Dubey <adubey@linux.ibm.com>,
        Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Subject: [PATCH v4 0/6] powerpc64/bpf: various fixes
Date: Tue,  3 Mar 2026 23:40:24 +0530
Message-ID: <20260303181031.390073-1-hbathini@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 6jWWUrk0cPAS5nO2pOv7vhVN-sPBK1X0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAzMDE0NiBTYWx0ZWRfXxEQxzo2RqPZ3
 V83d2QveBmHuPJPoCUxBUPbKODkYVABaq42Rk1TuVPFrpRsFU2hKhNyC0uvCH+A5WtDbCvMhIRS
 UA5NybgUVHvDRs/4c4WDwYdN67nXi1uVNdENWcX/j1IQ347KqcKpis9Th57yvNVNyDKpFNrmwNL
 41tCg7uXKg89vkwIdZRmOmr/vulv60aK26j/gpl+jmZa7hp888EAjXL/7GnpZd1lmqxlwtQA8we
 0jfa21aIbyfgjSXTZVk7o8GHKrh3n0lkFvfPciEoeLqHUA8Tju7WJRU93bNWmXBDsnKrhen0O1Q
 NR6xq3XVYrYgv1t50gtsv5WvrMwqzwRS9xqvGzhtPeumZVAugY1qXuhtN5ekI2vMaxfZyGMdpLv
 9gy4J2h8h/Y3HKUwUO96Uo8QUzuA/JziKXTn7+SPZpv+VDdGo3QxZNsE2xnyV7/ekUMjUaE9fRH
 chULjg8miDUN8lKqNJw==
X-Authority-Analysis: v=2.4 cv=H7DWAuYi c=1 sm=1 tr=0 ts=69a7241f cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=F-3jXUw4vF4i_SR45usA:9
X-Proofpoint-ORIG-GUID: 6jWWUrk0cPAS5nO2pOv7vhVN-sPBK1X0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-03_02,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603030146

List of fixes for powerpc64 BPF JIT:
- Patches 1, 2 & 6 fix issues with existing powerpc64 JIT and are
  tagged for -stable.
- Patches 3 & 4 resolve issues with bpf2bpf tailcall support added
  recently.
- Patch 5 resolves an issue reported by bot+bpf-ci@kernel.org while
  adding exceptions support on powerpc64 BPF JIT.

Changes since v3:
- Fixed a minor issue in zero_extend() helper in patch 6 as pointed
  out by bot+bpf-ci@kernel.org.

Changes since v2:
- Added Tested-by tag from Venkat on patches 1, 2  & 4.
- Patches 6 added to fix kfunc call ABI issue on powerpc.
- Fixed a few comments on Abhishek's suggestion.

Changes since v1:
- Addressed couple of review comments from bot+bpf-ci@kernel.org
  in patch 3 & 5.


Hari Bathini (6):
  powerpc64/bpf: do not increment tailcall count when prog is NULL
  powerpc64/bpf: fix the address returned by bpf_get_func_ip
  powerpc64/bpf: use consistent tailcall offset in trampoline
  powerpc64/bpf: remove BPF redzone protection in trampoline stack
  powerpc64/bpf: fix handling of BPF stack in exception callback
  powerpc64/bpf: fix kfunc call support

 arch/powerpc/net/bpf_jit.h        |   5 -
 arch/powerpc/net/bpf_jit_comp.c   | 127 +++++++++------------
 arch/powerpc/net/bpf_jit_comp64.c | 181 +++++++++++++++++++++++-------
 3 files changed, 199 insertions(+), 114 deletions(-)

-- 
2.53.0

