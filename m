Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5617E391E7C
	for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 17:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790445105; cv=none; b=nPRzv+9Fu7oLtme+/QTDfOIgBBwl66ZjFtLyTDGBUhGe+Sbn9MFGB71dEv3nREVz89rFI480jIWUcZCKDk5N+hqNl6LldMOFg9gvd0ae0wunjL+CQvfgu82Pu52k/k5s6xNpoo1w/StVBvLawjtmrH7cHl0YqIDF/UQCNoAnoS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790445105; c=relaxed/simple;
	bh=5Yq4bJdShF1+1yLoYG8oIeKXCXyv55NsosGOwjW2DxY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=geSIYP3qorIZeI5SRHzlmiof7lqiC/qStL0qwC2YrR2nlrXz0IAJ5PQdYZcWbcbweOOi+iuqGyDVjxddpW+dsPEUJopNaj5gn/l1A7zN2X71RqyZEqHh81ZbaICV8Qk+lL5wJ0Nj9h4tzB/00732oKZncCulZobGFKlo1fjTmX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mAnEpPpE; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mAnEpPpE"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68QHaWI73169344;
	Sat, 26 Sep 2026 17:51:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=DytjtnpYWJr7+G9V7bcxY7BoWWpOh
	K5fUmT0mNRgTp0=; b=mAnEpPpEzXSPEEEkNgGjdYf2TGkgIblJUQLKmzCgKlGPH
	lf1ogDpJ/FSjEZ9PfGgXLiHGPZLeIpo1cHOncdEplkgTwuBcxcS2tNAB1bv0/+C5
	XoKjbssUWQEJoPGQ6e5J/+SQTM4GA6qAT8GY/cOqfGkI/J1Mgf83hkdOb8Ys9kxl
	R/SdJUe2A3lcojg0Efz5tO3Bj6Sc7hWWIL6+ly/35pov9hJA//4fkdcBYOLXbTAo
	EW+oJtQyCKMU8sEqV93mZLmYW7efaGfrbhiGOHnriD97yHmNoPBUhJBTrmD5GMyK
	17gtCtJZUcyp3ufvwVn0Jvvh0M78aGsiNGGWcWzLQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gx63bran4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 26 Sep 2026 17:51:19 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 68QHo2Aw017856;
	Sat, 26 Sep 2026 17:51:18 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4gx4g8nbcm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 26 Sep 2026 17:51:18 +0000 (GMT)
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 68QHpHsV020485;
	Sat, 26 Sep 2026 17:51:17 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-81-123.vpn.oracle.com [10.154.81.123])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4gx4g8nbb1-1;
	Sat, 26 Sep 2026 17:51:17 +0000 (GMT)
From: Alan Maguire <alan.maguire@oracle.com>
To: ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com, qmo@kernel.org
Cc: jolsa@kernel.org, daniel@iogearbox.net, ihor.solodrai@linux.dev,
        yonghong.song@linux.dev, song@kernel.org, martin.lau@linux.dev,
        memxor@gmail.com, emil@etsalapatis.com, bpf@vger.kernel.org,
        nsc@kernel.org, puranjay@kernel.org, yatsenko@meta.com,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v3 bpf-next 0/3] BTF inline functionality followups
Date: Sat, 26 Sep 2026 18:51:10 +0100
Message-ID: <20260926175113.2368566-1-alan.maguire@oracle.com>
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
 definitions=2026-09-26_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxlogscore=999 lowpriorityscore=0 malwarescore=0 phishscore=0 suspectscore=0
 mlxscore=0 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2609040000 definitions=main-2609260071
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI2MDA3MSBTYWx0ZWRfX0nb71kxaMQv0
 osXO56omArMe3GY25T7GXARel5F1Zc1Ws0dh/bbY3Erm2T0al7UMCWgx65oMAKxWMBFrn2EB/kN
 08lB3He4AUEDaehvUJLfs3hlF20ZycQWU8DLG5U6Pw7W7y0FUPio
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI2MDA3MSBTYWx0ZWRfX7pK6f+HpGNHe
 UpiPagWvnhpNWVNLB2OZIiCQtnIdMtpfJv3sIXE79ZJqaPIJ18VTLfynmOh9TJ/LK/3d3adRrRc
 wsd/b7aQLb17SKLteO8b2/3o91FMy+F+I8V5fmk8FNJso24AHY9Pgl3HjaoVn9OTxV0FiXsP3sz
 Nh7TJgzuZ4jSOoucP74fog/Rapi1o8yZpT0fP/0bchS7xTRP2V/IEaReQed9b5vWHF43XT3Pjdr
 2GF/n9hpjrBJmRNUvDa0TdeFdkbVJHbg1PD0UlfFdm5iMqSAwER4yn76s+yFE9ObylFl8kvsQ6t
 JDiGXVMkNEf9FDqyK8gvgTT/DnoVGzM5iu4zepUh2doWkWG/zw7Zu3QwYjJRg30fAcDuwa7cnxw
 bxBmOeAiNvp2Rs2IvN2jVuttF+pTeUq+eAPdoSXl39stkzlFNGSwZUtXtTCHmKtfKD9fIaJaNbn
 +R6COKNJE/u6uTcreEQ==
X-Proofpoint-ORIG-GUID: Jt6A0ErpkvKPbLUaAHpc4eZoG3TCRahX
X-Proofpoint-GUID: Jt6A0ErpkvKPbLUaAHpc4eZoG3TCRahX
X-Authority-Analysis: v=2.4 cv=PPGaavqC c=1 sm=1 tr=0 ts=6ab80617 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=BqU2WV_vvsyTyxaotp0D:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=e-s1Mb4KYa-ADvBhKC0A:9 a=WmVTiCyuxqgg3mnwYu6p:22

Include additional vlen/flags verification for BTF_KIND_LOC_PARAM
(patch 1), and add function signatures to LOCSEC entries (patch 2),
adjusting test to cover these (patch 3).

Changes since v2 [1]

- Improved flag/vlen verification to check combinations (Alexei,
  patch 1)
- Simplified overrun ellipsis printing (Quentin, patch 2)

Changes since v1 [2]

- Fixed sign to appear after const (bots, patch 2)
- Simplified loc printing to remove vsnprintf() logic, updated
  to retain name in json (Quentin, patch 2)
- For oversized signature strings, append "..." (Quentin, patch 2)

[1] https://lore.kernel.org/bpf/20260925170854.1240637-1-alan.maguire@oracle.com/
[2] https://lore.kernel.org/bpf/20260925095231.879708-1-alan.maguire@oracle.com/

Alan Maguire (3):
  bpf: Verify BTF_KIND_LOC_PARAM vlen, flags
  bpftool: Update func representation to include function signature
  selftests/bpf: Fix up bpftool btf dump test for signatures

 kernel/bpf/btf.c                              |  43 ++++++
 tools/bpf/bpftool/btf.c                       | 123 ++++++++++++++++--
 .../bpf/prog_tests/bpftool_btf_dump.c         |  14 +-
 3 files changed, 165 insertions(+), 15 deletions(-)

-- 
2.43.5

