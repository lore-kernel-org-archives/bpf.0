Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9DE332D7C7
	for <bpf@vger.kernel.org>; Fri, 20 Feb 2026 06:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771569600; cv=none; b=X6dJQLyNV95ewlgCvcTFINEik68JV4FL1gQuBZ4/8I1u54SfZ0i88tlfjtgMRbMxTLSoRillnMpj7GCbDl9XG2OMwuLh1PE1YBFVBj9RqR6y9bsA347h0omT1DkSwJmZCWFJB6Cv/HMr6PXBVzYwzQROoO9h3EeNyS7Snld6V5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771569600; c=relaxed/simple;
	bh=Jl+QGow/XMrj1ijyI95JRnnSTTC1QfaS/zgX0q9tBbo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RsjXMf6c7aPXbXThMAXfiZDCF7jUJNt/2dPmE/hPl3fifPgDHoKBUFmjpzjXVgOBT+KW2Odgvimy/x+ap/3t6iFwfcitFSK3ijw7ub1Vi7rGCvJODfYv7UP/NpgRkk3lPrQq6TGRzC1RVNIFBvMzOMpMymSjQwd6dMHxVdJgf28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rOJ476mx; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rOJ476mx"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61JL3N4S1368445;
	Fri, 20 Feb 2026 06:39:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=29qfjcnNBM005rcFcRM9Mlnqau4pUDoC+BuBV+nTM
	Uc=; b=rOJ476mx8ZF7GGfKluUbSOzcCoiNxXf0H1dWinmIL6HROCmUoIj/24sFH
	ZHTyD2hmAGGeJVycdmjmCBbDaZU9z0Xp2tbL3I+xH3/8N36QdxdYjrCWjK7gVTYS
	mR8mYqF0rgz/bd9FOIyCEEDkvKODNFYYvXS/7hgutN9mu+g5yG2d7aWZnNZk/jf1
	lH2lHlIzQzo2F7h3BP8IwbINHCqbdnwkeznjgavFnwqQScFkyGi0LM5MqdAZWg+b
	RyU73uTBo5IyvqDfhHR/AeEhA0vqWhxlf0WuXzvrJNcwbH7a+9YDAJU+wiNthPAw
	kLPwhyyG3hko2W5rbjDniX1GWUYCA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cajcjrcfk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Feb 2026 06:39:41 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61K48c2T030217;
	Fri, 20 Feb 2026 06:39:40 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ccb45fc3j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Feb 2026 06:39:40 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61K6dbEi58720516
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Feb 2026 06:39:37 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 102F320040;
	Fri, 20 Feb 2026 06:39:37 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DF80F20043;
	Fri, 20 Feb 2026 06:39:34 +0000 (GMT)
Received: from li-bd3f974c-2712-11b2-a85c-df1cec4d728e.ibm.com.com (unknown [9.43.64.63])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 20 Feb 2026 06:39:34 +0000 (GMT)
From: Hari Bathini <hbathini@linux.ibm.com>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Cc: bpf@vger.kernel.org, Madhavan Srinivasan <maddy@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Saket Kumar Bhaskar <skb99@linux.ibm.com>,
        Abhishek Dubey <adubey@linux.ibm.com>,
        Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Subject: [PATCH v2 0/5] powerpc64/bpf: various fixes
Date: Fri, 20 Feb 2026 12:09:28 +0530
Message-ID: <20260220063933.196141-1-hbathini@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: YpvBFMoqO0EH8mHwcZsgfW9HCDNU-Jnr
X-Authority-Analysis: v=2.4 cv=Md9hep/f c=1 sm=1 tr=0 ts=699801ad cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8 a=6UyuRm9t2VcF-Ioa368A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIwMDA1MiBTYWx0ZWRfX/XfwhNLPk7Sm
 oPTOmVEFARAT/3eLG8INHRxw7cdMG6nGDnW8pg/3nWERWrLPtXRJI5InW1ymk3wiczo3gNer/V4
 skwUXf4+XgHODElCg5m8x0/5uvGBRA2ZVz+1lYOqiW1DO15FR9Mft1dTGPG2qDMNjuoU1vDevY/
 AbyYwu7jcXAsm26rFljZk1zxNFAuFnKEI2K40/NmB0VI8PVJ/g27urdRnVIM1fYN4rQ+SxSULud
 cjTDAGNKspChkiRXaxOGRbhsFZFbyoaAmAdyNe68bqOFSZ47+8D9ciGjhn8aHU+co8jgdLC07q8
 KCz2LwGaGwFHaodfMfAWZrEchLhIOnG5GccyV0IzqAVLsO16Aab6bgeKQtTjmITVWhFD7w8lvhf
 VZvAEgnGbfv0noA9AHENTNRjSk1xNauACJfiR0ag65eEIUCEnDHCR7wnzDjFUKPKHPLrhbYSXro
 furllbhDZb50wgb3CqA==
X-Proofpoint-GUID: YpvBFMoqO0EH8mHwcZsgfW9HCDNU-Jnr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-19_06,2026-02-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 spamscore=0 adultscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602200052

List of fixes for powerpc64 BPF JIT:
- Patches 1 & 2 fix issues with existing powerpc64 JIT and are tagged
  for -stable.
- Patches 3 & 4 resolve issues with bpf2bpf tailcall support added
  recently.
- Patch 5 resolves an issue reported by bot+bpf-ci@kernel.org while
  adding exceptions support on powerpc64 BPF JIT.

Changes since v1:
- Addressed couple of review comments from bot+bpf-ci@kernel.org
  in patch 3 & 5.


Hari Bathini (5):
  powerpc64/bpf: do not increment tailcall count when prog is NULL
  powerpc64/bpf: fix the address returned by bpf_get_func_ip
  powerpc64/bpf: use consistent tailcall offset in trampoline
  powerpc64/bpf: remove BPF redzone protection in trampoline stack
  powerpc64/bpf: fix handling of BPF stack in exception callback

 arch/powerpc/net/bpf_jit.h        |   5 --
 arch/powerpc/net/bpf_jit_comp.c   | 118 +++++++++++++-----------------
 arch/powerpc/net/bpf_jit_comp64.c |  74 ++++++++++++-------
 3 files changed, 96 insertions(+), 101 deletions(-)

-- 
2.53.0

