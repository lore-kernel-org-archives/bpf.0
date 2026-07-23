Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E19471CF9
	for <bpf@vger.kernel.org>; Thu, 23 Jul 2026 14:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784815641; cv=none; b=GY88tZWD8OoOoT+ogvBzl8A+Mg5NQsUZyUQE9daSRV7JEezU9IJkNXsgZ+Q92bsemPtRqskBRfBrnb7u1+/dZlaVD7jXSW3jF9yHTVbbM9IcE1N0TULUBIKTyoOtGt0D7qVhOcCQdPm37QPDvNlZLXHgpS/6TNSOnmiNbS/jHcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784815641; c=relaxed/simple;
	bh=R4H9Cu1uzuSEiDGG64i/DK2gCARH5OPSVPtbMLywKMs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M697NVq27NUcAVHFVB2NpMJclDDproS/TCzYPi7HxgpL364Y/Rsa8E+kBgciDhFlqddhmaeBS2/iuqtQza5iCAXCVf2pXBipF/VY6w4Ejf62FdjFDPAvcCWVYS1kJdNhJIMPLTlObajuj2aI6v7BfrjfmwOjukkd/B0pGomWWmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ek1iYXFu; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ek1iYXFu"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66NDBtgX3095035;
	Thu, 23 Jul 2026 14:07:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=zy0zcxjZFCN/knOdROBAniAMW22q9R75WDk4pJgrW
	7c=; b=ek1iYXFuv0qD72SeHWVCsf2EDkeEjLZ3a9BtT1mi+p7oJ793g5tpPeyea
	J/KGd3Gf+pT5pkgs2Ku63kuRpYWZHUbL90wehxHhLssksCh6qYzdFNkq4Mnjy/25
	/H8ac4bghYnkrlZpcFBQs+2vd8asV8k9Kb6c9DA94PYulefPTVQapg852/EkmudU
	6RUTTbI3mDGwNVlL3GlcWKNc1gMf1YTZH8/lGBBcsc/tcGG6tgBjxdp+EFg/HqpY
	pF8zdamQ3mPFPc46frZMdiNzWlj5lBPokIotNuruOQ0oXljFYFQ+yIbMg1kpJAqn
	bPoiCA3HGiRjcUffTQut/EsjtTASw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg7ahfab5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 14:07:02 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66NE4atJ025098;
	Thu, 23 Jul 2026 14:07:02 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgnahcep7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 14:07:02 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66NE70fC23659102
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jul 2026 14:07:01 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8D18B58064;
	Thu, 23 Jul 2026 14:07:00 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8F72E5804E;
	Thu, 23 Jul 2026 14:06:58 +0000 (GMT)
Received: from thinkpad-p1.ehn-de.ibm.com (unknown [9.224.75.254])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 23 Jul 2026 14:06:58 +0000 (GMT)
From: Maxim Khmelevskii <max@linux.ibm.com>
To: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org, Ilya Leoshkevich <iii@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [PATCH bpf-next 0/3] s390/bpf: Support load-acquire and store-release instructions
Date: Thu, 23 Jul 2026 16:03:48 +0200
Message-ID: <20260723140648.583055-5-max@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Ku-O69yqY8VmW-FIh7ELS4_Dm_Tz3AYg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDEzNSBTYWx0ZWRfX4SQ/8ucu0Swf
 0YZorOXH/zgR62BsEG6sVXzFBTW00Bg8twGO8TSZ1oPPOOvb/LJCVDjK18lfy3ZeVOo83P2etOJ
 w00PaVenPEKlPWtZaFQkUdQ3DaCEPehEOclM7i0MtN6mc7RwcZuA/8P2Hpv6+Phxjuy9KAKdbtX
 7LpaEwA2l0F8fDLS/oEFnRTkGQJkQ5w1wDG9Mz9/BX0Nn1spYHpq3OTJ4JMlPEKeMJoJf1tRNYX
 sDLs/10V864c6Zbns+s/A2R3NOcXdZPQjFfdjZpxskNrb1dHGsdiUGVZCIsPmX1iIX9ATtJ1bam
 CoPV51fnP4p26qtI2nRB8wVa53V0Y80AMRSAYspLrPGKEnPRF7syTr4tsUmQwleMy61hVyph84P
 yEY8WQfSiVb4HnGRzrYvXLQaGrmbRdpPbooZz1UByKHUmA50ieDOnxiU1pUZE46mJmUg3T+eoXK
 VIkArVcUcmGScVyLhjw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDEzNSBTYWx0ZWRfXwuJbwQw7Htuc
 Kvka+t1T7SWUVxhVusgg1Q6qhLPVI80OFt6/uY1idWDKbqGdQE2F73wplf9/UQlzJDGVu7AwoC1
 iI9/klZD8ZFkRD5VHB/+pVcPRc2Kpcw=
X-Proofpoint-GUID: Ku-O69yqY8VmW-FIh7ELS4_Dm_Tz3AYg
X-Authority-Analysis: v=2.4 cv=SM5ykuvH c=1 sm=1 tr=0 ts=6a622006 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=7XoH4dCvY4e9pCTkT3EA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_04,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607230135

Support load-acquire (BPF_LOAD_ACQ) and store-release (BPF_STORE_REL)
instructions. Since s390 has strong memory model, implement
them as regular BPF_LDX/BPF_STX instructions.

Maxim Khmelevskii (3):
  s390/bpf: Add emit_ldx and emit_stx functions
  s390/bpf: Support load-acquire and store-release instructions
  s390/bpf: Enable atomics tests for s390

 arch/s390/net/bpf_jit_comp.c                  | 198 ++++++++++--------
 .../selftests/bpf/progs/arena_atomics.c       |  18 +-
 tools/testing/selftests/bpf/progs/bpf_misc.h  |   9 +-
 3 files changed, 123 insertions(+), 102 deletions(-)

-- 
2.55.0

