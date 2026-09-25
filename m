Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B994A28B7C8
	for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 09:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790329983; cv=none; b=sQRWWmYMc9Tthi7Gk3cMFuwFjGMi29zSt4iRrfUfIKiEebdO67oIkqYS5GL26GGXaSec2Uaq+Nk94vafT3pgZYj7wxCO/bDpgOl2OwGgss9cAQAljy8F3tNbBVuwBTw4bJAQfDVGS25dZtX56IFw4+5j7dQelo/66wkJZU+gjcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790329983; c=relaxed/simple;
	bh=nEi54ovbG5zT1LV/RRX4NGj5xtscOVctaQEOpVtccvg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e9XQIX87r+wMjQPwsUiZNJy7c1JLwSuc1B1PCYlg9/lnNiYbPnJ9tbWfdWY1huamowthAU7GV5qppsgmVmreaCT+mAOvUhzYq/sgggUnv0Z705NzwGoVyEDW/AqZHH8pF+mgcbsOKImY/BdC2FuG2Bli37KIs4Hym/G6XxuFkn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gWsB0R6F; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gWsB0R6F"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68P0YH641575774;
	Fri, 25 Sep 2026 09:52:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=rg76dLEavZe7Fd9llbKzdbAKxz59M
	Dmle3mJvGNgq90=; b=gWsB0R6FfP7lJ+DU7kx4d2YFjXyPP1da1hzXvlu6dy9/X
	bWrdTt8LeVGr+awobbV5vfrlzSidClclYfzzb2N11sV49f3Mx/BH7+eHm33+/+ud
	8q5jZA53ZNbd8ncx0+tRBxhgo/Ng9gD72sPd77ahnp8x5Nk0J7uklAd8NVA1SnHE
	orfcycKSKhmcPEZOjtfRLoGXIg3HalhzobLzR2LcggYtvWI6mfUmSH54XmwBkQt+
	tB0k7Oo9Wy3joHDUGuRg/jgHM9CJu0UcGLPOe34jMEBqpliX8GYjXPdtBZbIo+4g
	wL66iUhxEoI5KH30GnM3B2Z3P9tXeQ45jY2nWRInA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gsk2193nn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Sep 2026 09:52:36 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 68P9oPsh004291;
	Fri, 25 Sep 2026 09:52:35 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4gtept1dm7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Sep 2026 09:52:35 +0000 (GMT)
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 68P9mZYd001344;
	Fri, 25 Sep 2026 09:52:34 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-81-122.vpn.oracle.com [10.154.81.122])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4gtept1djn-1;
	Fri, 25 Sep 2026 09:52:34 +0000 (GMT)
From: Alan Maguire <alan.maguire@oracle.com>
To: ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com, qmo@kernel.org
Cc: jolsa@kernel.org, daniel@iogearbox.net, ihor.solodrai@linux.dev,
        yonghong.song@linux.dev, song@kernel.org, martin.lau@linux.dev,
        memxor@gmail.com, emil@etsalapatis.com, bpf@vger.kernel.org,
        nsc@kernel.org, puranjay@kernel.org, yatsenko@meta.com,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH bpf-next 0/3] BTF inline functionality followups
Date: Fri, 25 Sep 2026 10:52:28 +0100
Message-ID: <20260925095231.879708-1-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0 mlxlogscore=988
 lowpriorityscore=0 spamscore=0 phishscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2609040000 definitions=main-2609250039
X-Authority-Analysis: v=2.4 cv=APP6TA4N c=1 sm=1 tr=0 ts=6ab64464 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=7Gl3-_t3PgB9XO-mQDs3:22 a=c0TuLuNV2kca2eWsw1EA:9 a=zZCYzV9kfG8A:10
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:13532
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDAzOSBTYWx0ZWRfXzClYYe9vwAj+
 WsKy+fSAlxRWV+7ERh4ZRxmLVifsHvAFc8i193UKEN10yMphLBJ90axe7UoKfsfA5VbEQL9j3wK
 ZP/7+r+I60Q3q8kyJGjnXAC7suoM/D/xjmeUtV3HhdD6LCdM7pUB
X-Proofpoint-ORIG-GUID: NJ5F0CGWwQ_K9rDJGOSwGsV67EfxLTE6
X-Proofpoint-GUID: NJ5F0CGWwQ_K9rDJGOSwGsV67EfxLTE6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDAzOSBTYWx0ZWRfXwJ/aiNY+QlXo
 ekIKysqTCYMHWtgDSEf2E8qctvLTZVoGsE2ldoxGHrIfIjwTSo4DBktJNTIGPupF25T9yAbC1+d
 aGzcwsEYvRC+aQO/Ihurq3b/6QdOLaShsvrphInSzT0ZWCjW/WcxAjgPRkJosRucpgAcL3lYy0j
 piBV/vGYWrk48jttBSAuqrc7AEa6w5NT2pKkLPZBktqQnVnXBHIYWTntbolULqAujnFe5GIFcnC
 EJWNAfPefBOCBXDFMXyOY5ecQR8U6JE5XM1Kpma3TQ5FUqQEfZwuqlxA0iDiu16mkDbicF49X1d
 4vHE7R/8irNJvPqddjS2LNJ2NIDYjh7bOQ4IZrUIgkaiUFB2QbD9ntna5Bev/Mk86wkFLGYjtGG
 JcyUf1GCbwOtXaerWO+XqjibjzSl6Uy7oDvsTJwpYMEeXSFjByOCpKdLKQGySJoOUS9T6XSlBXn
 CUDRcf2XEq00WIQITgMKAEh//BCK0/5o39uCq+fM=

Include additional vlen/flags verification for BTF_KIND_LOC_PARAM
(patch 1), and add function signatures to LOCSEC entries (patch 2),
adjusting test to cover these (patch 3).

Alan Maguire (3):
  bpf: Verify BTF_KIND_LOC_PARAM vlen, flags
  bpftool: Update func representation to include function signature
  selftests/bpf: Fix up bpftool btf dump test for signatures

 kernel/bpf/btf.c                              |  12 +++
 tools/bpf/bpftool/btf.c                       | 100 ++++++++++++++++--
 .../bpf/prog_tests/bpftool_btf_dump.c         |  14 +--
 3 files changed, 111 insertions(+), 15 deletions(-)

-- 
2.43.5

