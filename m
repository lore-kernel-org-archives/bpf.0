Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B673321A2
	for <bpf@vger.kernel.org>; Tue,  3 Mar 2026 13:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772542957; cv=none; b=dz20UAX65Hs4LLe5BT2F749IkWZMmppQhUoYM5Mt1Mh0Q+SFsAjTaGZFrJdMr43sj5l3L5zO+xH/NGDLcL0KIQvwQrXhKeSGmwbquLQcBdEqbf78TdDm3HkE4dujxGNOVeDLtzDnNaca325cx8Qx0Vjs53C01xDOdYdXwcLlpBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772542957; c=relaxed/simple;
	bh=3k3fxPqQMECQwW5NstwyumDJ4v2GBerVig0Ivli3ark=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nKuRJlJbrN/u8a7oj0lJVJFFGPE77R74f6ePrpUafQoHXppSRK11PN6VA3+rnpUpMJQaaiYsPBwCYvDP5KmjEaZnTMV+3ta/qWhxZaDKZH7qR2Lv523DBxUsc1LPfeW68eu5IeMbLwJ2aE2a0po0+jTfBdE/9vD+AtVtCz500cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LrFj4GvF; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LrFj4GvF"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6236MnZB1805485;
	Tue, 3 Mar 2026 13:02:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=+fv2d9YzwyaoOUzkFlb0vld37qH2Ki7NAgNl2ZyRH
	LM=; b=LrFj4GvFLPM59zf6MMUPn3QQj6vtMjBUxu3ew+7mKHncJ8PrRHdHQAuUW
	Dlok4uwRHEptb7jkdbR4Z9/TdTKqJ9at+wv0G0H35LpozqyA0bK+X60ZgATz1B9T
	HnuAYT1ZAthzq2p4afQOgYuPhAPhm4yzVXpR14mEEsvjr67Q7ESSxsJMCx3p65Yi
	DB9Vr1z0aEOFe/tq0RjqG4uTa3HuvtQL8ZC2fOWWT0XmFEL7PCnimJS1G9Kfq2Sj
	Fl7qXI76TNDZYdKZPlG5NLk6fgriUK8e53xLDQWYg+sYN2elDzAW+NpUTpHJnIj/
	VnMRCggzVQ+eruu9kMBlsMqeiHKRQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ckskbtp40-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Mar 2026 13:02:16 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6239XXEI003243;
	Tue, 3 Mar 2026 13:02:15 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cmb2y2cj1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Mar 2026 13:02:15 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 623D2Bpv51577314
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 3 Mar 2026 13:02:11 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3A6CE20043;
	Tue,  3 Mar 2026 13:02:11 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5F64D2004B;
	Tue,  3 Mar 2026 13:02:09 +0000 (GMT)
Received: from li-bd3f974c-2712-11b2-a85c-df1cec4d728e.in.ibm.com (unknown [9.78.106.17])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  3 Mar 2026 13:02:09 +0000 (GMT)
From: Hari Bathini <hbathini@linux.ibm.com>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Cc: bpf@vger.kernel.org, Madhavan Srinivasan <maddy@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Saket Kumar Bhaskar <skb99@linux.ibm.com>,
        Abhishek Dubey <adubey@linux.ibm.com>,
        Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Subject: [PATCH v3 0/6] powerpc64/bpf: various fixes
Date: Tue,  3 Mar 2026 18:32:02 +0530
Message-ID: <20260303130208.325249-1-hbathini@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: z_0NSw_3dTrF0f6JReJl-xxYUZEbIn7-
X-Authority-Analysis: v=2.4 cv=b66/I9Gx c=1 sm=1 tr=0 ts=69a6dbd8 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8 a=6UyuRm9t2VcF-Ioa368A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAzMDA5OSBTYWx0ZWRfX3uDFtlcNQcJP
 4q4ODmWotvN+zEa5wP60KBYNCUAvlxhqQbaqObN3kST6qdSCBMDjmrrRr2p3oSswgSe22Sfbu73
 WveaFShKunsSbCVbw7Bsp2jPDqjr2vCVhmgonqswh4qHYKpy9FBl2/3u0QCV9zYc9aUAq4YPAgA
 K8N9KYhfmK99WBZuS4tOV1KMCXW8QOsZXq0ilFj26zTGNxeVuqrJgwJlxErrBTlFwVet7rTuU3z
 vjA+xhBwpXtRXK8Ve5L37icuJnKN++qkt//uujWBiG7sgtTPOra6FiMG4WrteCGHnxgE8MhtoP5
 VIO377iFoV+Lx5P4ZpdiUlZCtFbswrdX1r12L3aA4o5HrOZ+UcGocA8YfMG4iYs12DcR++AhTWa
 uiaub8rhAKQ031JhPD5niSqBUg1AgX4yHmwDbi4/I+CEvSBXl9LjcLLrLLqGlMto9pktb0twQFn
 8DtnaGRMNbV99RgpGfw==
X-Proofpoint-GUID: z_0NSw_3dTrF0f6JReJl-xxYUZEbIn7-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_05,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 adultscore=0
 bulkscore=0 impostorscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603030099

List of fixes for powerpc64 BPF JIT:
- Patches 1, 2 & 6 fix issues with existing powerpc64 JIT and are
  tagged for -stable.
- Patches 3 & 4 resolve issues with bpf2bpf tailcall support added
  recently.
- Patch 5 resolves an issue reported by bot+bpf-ci@kernel.org while
  adding exceptions support on powerpc64 BPF JIT.

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

