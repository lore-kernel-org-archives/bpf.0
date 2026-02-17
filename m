Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C61326950
	for <bpf@vger.kernel.org>; Tue, 17 Feb 2026 16:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771344518; cv=none; b=mfvfc6pk4G3BCTG7xdVe1HDEY2cSGT/w8E5kZVqAtBLt6Ql0Wd7RKmDKgz6hmamiWCOuedgPm7igyKJPjuj7V1awdMKKkBocdF9v9i9QsFyqX0N4lgsHHNeWysJ6PZamjACr3ZmNFuH8kyoEzDDdwIpd0ducyP6pOsKe1PJlLAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771344518; c=relaxed/simple;
	bh=EcrID4rsNoidCKs/5dqWwAQeXKUjasOf4S1h+DfW9ho=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jhNQRqJSQyLfqi3w8AKVcXDkYJBxyMpbfDH1Rfda1pvw0A523JxKwvGdVSra9G6n9feOb1zfJxx3hgzQ6Hz/X+tbDEbR/HCIuS9Z0h7gTf2AeXv0nROvMtdzPrm3DZf8CT6OuGvX9wkofUTvxds6Lv3t68bRBltkbjdEvO48vU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SXMDYAMA; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SXMDYAMA"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61H9unOr3607463;
	Tue, 17 Feb 2026 16:08:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=tmU691IP+FRfn4/ZfacbdImyS5g1VGeSEDiY3zReD
	ck=; b=SXMDYAMAkwnQO452m1rFD3ObODQohIFtBwFO6vszL5olPyEMmUyeVn7np
	/YWJymQzPGUZJay6OWTT+LVY8fqhfCH88TaUYUplWhMxE826BQkPlFYpsOxDBWBJ
	edAN+WL6fcfezerSPlMKj3NulOIGnQzV/0DVQiW6J6Ixp5ajHlG1lGki/nu1S9gB
	jmh3csW4oVtCQyip7rCaHDxLtHFtjanog3qiwVTkV1m4sdS/o1fEoe/ti86XauML
	r04qvQn4Acor7YsjyhSIZiThIznRQpSfoMDz6py06848bejwocUm152YuDNjSntJ
	DZrpBzAAn5YTEwjA+tFOPwq2ItXeQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4caj4kc5yr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Feb 2026 16:08:24 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61HG0Qfj030213;
	Tue, 17 Feb 2026 16:08:23 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ccb453jvq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Feb 2026 16:08:23 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61HG8JSu46727644
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Feb 2026 16:08:19 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7AF9520040;
	Tue, 17 Feb 2026 16:08:19 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 33C1B2004B;
	Tue, 17 Feb 2026 16:08:19 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.87.136.123])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 17 Feb 2026 16:08:19 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 0/2] bpf/s390: Implement get_preempt_count()
Date: Tue, 17 Feb 2026 17:05:07 +0100
Message-ID: <20260217160813.100855-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE3MDEyNyBTYWx0ZWRfXwSPeMVOtVxk7
 6SI+9qlkp4c5hapbAn201TilOtZ+9KqhEL1fG88/tLXuXQbKrs4ks3ilZ0OG0+0Evc2/pW1Erh+
 srtxTpCOBaQ8a/4baUq7j1hpDsRJh3lDUGk+NhaDi8oAmWGLzzCeN4kgNcNyH3tXuhO3ZjPJerq
 G0q8LFcZlYqJ7al3Ezq9KRQ+IHMLj5FyHPaMQJivoDXdkKsDpRcdwP1u7iafYU6byIsRdxMVQo+
 67PoIlzvR3l5BbVc+N+8ceConQVi4dAPyJlAOxpJkVJRN1/apcstHn+/2MpM+rJwaY65BcUkTb4
 RBLapYg/ToMbBuV+K6VbRZL8ZBN37FtM0YEyqeWXaImsRgWvdzhDjczB29inwpkdDApLUFWKeFB
 FvsEwMClMJ1YDtPS+tfSG33ODOI3HntNRanDKNxS+hZNrrPSmLQCe4p08ALmVGnCBXxIrYCNjJ2
 ZXQttZJt63bd/0tGhDg==
X-Proofpoint-ORIG-GUID: UxbZ7AsOJGT_5bsPImWz0iI3gJjj6RXU
X-Proofpoint-GUID: UxbZ7AsOJGT_5bsPImWz0iI3gJjj6RXU
X-Authority-Analysis: v=2.4 cv=M7hA6iws c=1 sm=1 tr=0 ts=69949278 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=wChL_YDYxV0wqAx4buUA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-17_02,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015 phishscore=0
 impostorscore=0 suspectscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602170127

Hi,

This series adds get_preempt_count() BPF implementation for s390.
On s390 preempt_count lives in lowcore: a per-cpu data structure
mapped at virtual address 0 or 0x70000 depending on the kernel
command line.

Patch 1 adds a kfunc to obtain lowcore address.
Patch 2 is the implementation that delegates to it.

Best regards,
Ilya

Ilya Leoshkevich (2):
  s390: Introduce bpf_get_lowcore() kfunc
  bpf/s390: Implement get_preempt_count()

 arch/s390/kernel/Makefile                      |  2 ++
 arch/s390/kernel/bpf.c                         | 12 ++++++++++++
 kernel/bpf/helpers.c                           |  3 +++
 tools/testing/selftests/bpf/bpf_experimental.h | 11 +++++++++++
 4 files changed, 28 insertions(+)
 create mode 100644 arch/s390/kernel/bpf.c

-- 
2.53.0

