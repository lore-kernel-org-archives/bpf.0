Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B603B4E8B
	for <bpf@vger.kernel.org>; Wed,  8 Apr 2026 16:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775667506; cv=none; b=MsHWl/yJvv90abDx56G56Q3nJQ9kILorOPpqR3HSKOQdJZ2TGCW3239wavti14uD7mrMedXOkA5fP0qoQU+VTVzggsFzeQ/b8ETCSeevRxWEksT22QDeRQZwGrFwXDJGOFM7xtspP4O5wfB5T3800rqMgmsxBGl2u5YHbOKM7UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775667506; c=relaxed/simple;
	bh=XZnXXr/KQ74auQjUFM4P+iKiCo96BltrKCEZGNEXOEo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VcQbhSe+w9g8P59nBD+BDUtb7dR/hUMyG1+edc3CiBEFT3hFhR6l/8/3cSRhN6t8skxEwbquABGFxbTPrfAl2L6w6CR9Leffwxc1ClNMm/ubj6FOc7smBnZLs44Z4bv86DQySvZuju4McEGXC13HKZiaJAzneUcidFjbumnOo54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BgfIRwmF; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BgfIRwmF"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 638FOBIX3978978;
	Wed, 8 Apr 2026 16:57:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=NNvF1Nhtzcl4+1V7cGapFPDnUh6ar
	LLHHmpdOJzjfDs=; b=BgfIRwmFpFn9VENli8iAiU62IBQulV7UhMFyalWDGtZSD
	UlVJDblcYF66lUkaSNdU/Yew5ikaRKu9NcRJC8Op8PR3syz15Tp710myxKQTjV8/
	nh5SV1QEVWekP3/LsfxraXGJi2Vt0lfKJF57RNui0gydaV5TRDWt8g7KPHMP8fjq
	+n8mFJnHbJXXlHDWBI64SiH7+6N5avgfSb7W8dTOnNRRvjv0pVyNP7JWVWbjnzjo
	rj3eDUP10x7Z2ex7kt1EEJSR/OzGEzIF53ZQK/jpuLTvO5i9rdC00LLXSjKoGYwY
	iLpgrZ2MZKmruPVfsqKa1S2AYBGSqUbAwS+gf/dBw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4dcmq9ux0e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Apr 2026 16:57:39 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 638GuXeu026500;
	Wed, 8 Apr 2026 16:57:38 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4dcmebhqpg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Apr 2026 16:57:38 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 638Gvbo8025438;
	Wed, 8 Apr 2026 16:57:37 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-48-176.vpn.oracle.com [10.154.48.176])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4dcmebhqmb-1;
	Wed, 08 Apr 2026 16:57:37 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        eddyz87@gmail.com, memxor@gmail.com, song@kernel.org,
        yonghong.song@linux.dev, jolsa@kernel.org, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v3 bpf-next 0/2] selftests/bpf: Test BTF sanitization
Date: Wed,  8 Apr 2026 17:57:33 +0100
Message-ID: <20260408165735.843763-1-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_05,2026-04-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 adultscore=0
 phishscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2604010000
 definitions=main-2604080157
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDE1NyBTYWx0ZWRfX26bXVS3suJAJ
 t6JzMaF26ZcGjeqfwPshe8ZNVBYmg6m/IQ9eIBGG39hW94UpS3OvZjm02FxGmkzsCmmNR1Fescd
 /0fOJiuSI1/1xEmlwK4shNf9NrPNP1qhSAB6xb60NGHdMmnye5ok/2Cu6Ni2VTmNqbe6/0uAg6H
 DfydsljAsjnq00KaR/baJq295QYI6HBeTP6YBjqp7mCAQX77UahEALULBz2FV+XkdPK7sa8WlEy
 Ne3CtRGuuGuvargJV2nd59DI7MdPUMPH4dIF5kSvx+w5tRs5cSTy1mursDTSGzAtQW+Y5FgJBtz
 AQXn17L1iOSRUEo3p/uBY0Jx9XQc6GvckKw/xst8opeT/OU6xYtROll1+RK8TnBOHJu6m+Qfz1j
 PwflqObFR/b65K9FaZVLYjcrPhj8v3s38g8QzDzJYjRr1AfDLEfm6mnfhLzILDi1rRxUtSVji7B
 uON1ERXEcRMZObSErqFXLq1HKjtNXnjL0tWk8ark=
X-Proofpoint-ORIG-GUID: nUw_ZN3szbtB9W2gtJ7CN6zjAjYBqo6C
X-Authority-Analysis: v=2.4 cv=MaJcfZ/f c=1 sm=1 tr=0 ts=69d68903 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=o5oIOnhZENCTenyL_yNV:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=4ZnBetGeu5BCO9975JEA:9 cc=ntf awl=host:12292
X-Proofpoint-GUID: nUw_ZN3szbtB9W2gtJ7CN6zjAjYBqo6C

Allow simulation of missing BPF features through provision of
a synthetic feature cache set, and use this to simulate case
where FEAT_BTF_LAYOUT is missing.  Ensure sanitization leaves us
with expected BTF (layout info removed, layout header fields
zeroed, strings data adjusted).

Specifying a feature cache with selected missing features will
allow testing of other missing feature codepaths, but for now
add BTF layout sanitization test only.

Changes since v2 [1]:

- change zfree() to free() since we immediately assign the
  feat_cache (Jiri, patch 1)
- "goto out" to avoid skeleton leak (Chengkaitao, patch 2)
- just use kfree_skb__open() since we do not need to load
  skeleton

Changes since v1 [2]:

- renamed to bpf_object_set_feat_cache() (Andrii, patch 1)
- remove __packed, relocate skeleton open/load, fix formatting
  issues (Andrii, patch 2)

[1] https://lore.kernel.org/bpf/20260408105324.663280-1-alan.maguire@oracle.com/
[2] https://lore.kernel.org/bpf/20260401164302.3844142-1-alan.maguire@oracle.com/

Alan Maguire (2):
  libbpf: Allow use of feature cache for non-token cases
  selftests/bpf: Add BTF sanitize test covering BTF layout

 tools/lib/bpf/libbpf.c                        | 12 ++-
 tools/lib/bpf/libbpf_internal.h               |  3 +-
 .../selftests/bpf/prog_tests/btf_sanitize.c   | 97 +++++++++++++++++++
 3 files changed, 109 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/btf_sanitize.c

-- 
2.39.3

