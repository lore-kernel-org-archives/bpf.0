Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C17B47143B
	for <bpf@vger.kernel.org>; Mon, 12 Oct 2026 14:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791814047; cv=none; b=NJwBPQN9tfz2z1sCVLzvW2TZWFBi1V56OzO4ZfiYU/KAyw+MHc1f/Yyyne4cARc8zzZzWPSCT7cEn4iXFiM28g0iks6lTW8f1tKxCp+ETwXdKb/bJhkfkyXlP00k0hlCegzO2ME2yHCX4HZYBTRqaqO21W6QkPoNzosVdatSxtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791814047; c=relaxed/simple;
	bh=epEswhaavBiogyp71YncXZUR6xbiLnDNvR/IGD0gnUs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PwLOLf7pER45KUGiLnwOb+nyXoCUgrQmQKlXb5TYL84b5uowZYu5g3sRQscWKvBvUE67bQysdauuKVQZqsBzQPy8N95w9IzkO52dj9UfyWKn7kEmSNwW+FCMC6RJPTEqTirAQKe3NigIkqjOANyaaDeSpHKkZWhjlM5DN6+zQpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CGy1x7XM; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CGy1x7XM"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69CCikpj1748785;
	Mon, 12 Oct 2026 14:07:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=SoQwV
	+nGppBDF2v+pHhbm2PjaAntUq1vh7FA1XzqfXo=; b=CGy1x7XMJq9fFS1i4uku7
	5GvkM4CkOrWCUqH6bkDuTfWAAGgxNERXEhHJFtg6p/uauT1iwhBfirpd6SSLz5ly
	ASAwZMSVa1HLlc7AY7V7s6RIr4dmbj1slIg8S03Ioa10piZtMai9tBiQYp7bTpC0
	u0ImVcuf34sAug2HoMAsneECzSxgV8tM6b8TnLVjY6iL5HyQ+jNcm6K9S9QKPGMv
	T4D13iX/feyGe39cWnYEEe+AEp8XGNLiq9al3Xv6GsDREBxmCGf1jSyyRm5R6IhF
	yrNMECfP+67WMR1RwDqRP67wN5Wny5noQuYzw9yON8kAccyzc8SworIt0DBc6SrC
	w==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4h7ddgjd1v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Oct 2026 14:07:06 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 69CE6iP1035126;
	Mon, 12 Oct 2026 14:07:05 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4h7btn9qjd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Oct 2026 14:07:05 +0000 (GMT)
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 69CE6vgk036955;
	Mon, 12 Oct 2026 14:07:05 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-85-240.vpn.oracle.com [10.154.85.240])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4h7btn9q4d-4;
	Mon, 12 Oct 2026 14:07:04 +0000 (GMT)
From: Alan Maguire <alan.maguire@oracle.com>
To: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com,
        jolsa@kernel.org
Cc: ihor.solodrai@linux.dev, yonghong.song@linux.dev, song@kernel.org,
        martin.lau@linux.dev, memxor@gmail.com, emil@etsalapatis.com,
        puranjay@kernel.org, yatsenko@meta.com, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH bpf-next 3/3] selftests/bpf: Enable CONFIG_DEBUG_INFO_BTF_INLINE for CI
Date: Mon, 12 Oct 2026 15:06:40 +0100
Message-ID: <20261012140640.2932195-4-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20261012140640.2932195-1-alan.maguire@oracle.com>
References: <20261012140640.2932195-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_04,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 spamscore=0 adultscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=999 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2610020000 definitions=main-2610120056
X-Authority-Analysis: v=2.4 cv=EeZd0/mC c=1 sm=1 tr=0 ts=6acce98a b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x4eqshVgHu-cdnggieHk:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=WlKgVlOj7D6ExR36I_YA:9 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22
 cc=ntf awl=host:12107
X-Proofpoint-ORIG-GUID: i0_ymOb48Bun6d5HzcOmr3mi1X9vWi3j
X-Proofpoint-GUID: i0_ymOb48Bun6d5HzcOmr3mi1X9vWi3j
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA1NSBTYWx0ZWRfX6C/JjEZ0uOiU
 DFXJ+t8+9g8T1AcnRmdzZMDG5VPCRwHoyWgbJ5yN/oQHdAz8ktjuBwdGICULW3GP72RXu11Yul0
 25NszJ5nmQH6lK4q0QaAnZa9XBwpkCNjJHlKh7SHNCx445d+NgJp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA1NSBTYWx0ZWRfX03RjW1v4YFaM
 /cwEV9nqmSbTVKKeaFPowLx+kwdT9kNeV9jefXqnWGKJKYu9gCXzrNcmnU/Fd8ByshNBuik9WH8
 /lMViexBHFMtPsPyzDLoXW9T7Dd8DYxAfPt2b49zVuAwhrJ8WHl4UQn0/mlR+kpq5/jCVQDKSL6
 b5ddq6eMEgMtxPAnzJ+XpCrQEVYA0J7FOf/7/dCeFcqCm+eCcjiJBT7cjQbTJyWkzbewVzGfh0I
 9S1j+xEkIn2zFpnRgvC9+4YBs44eGzwAIomYcPxzCjg4Rd1lAToc5XdL4FLIUrE1Eiw14fzQOKj
 VnSqLGpMG0OlqmK4Be5P+3qLTL9ffGf3ZElC1ssFtiu4sGy5kuXdkpg9p8YjWLIYrrdwe/xy8RA
 dc8l5GOgqhOZwyLwN5OtWwo/91nkGGwKUIatgOB5Rwa7CHYXKr6+hFldJSgyZu7phdIe54RUVc9
 1fYDJa9Y9qKaeDjAv0xWaoQmIAQcB2bQO+1h+jcs=

Ensure we add inline info to BTF for testing.

Suggested-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tools/testing/selftests/bpf/config | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
index 2b883b388f90..d1a19fb125dd 100644
--- a/tools/testing/selftests/bpf/config
+++ b/tools/testing/selftests/bpf/config
@@ -23,6 +23,7 @@ CONFIG_CRYPTO_ECB=y
 CONFIG_CRYPTO_AES=y
 CONFIG_DEBUG_INFO=y
 CONFIG_DEBUG_INFO_BTF=y
+CONFIG_DEBUG_INFO_BTF_INLINE=y
 CONFIG_DEBUG_INFO_DWARF4=y
 CONFIG_DMABUF_HEAPS=y
 CONFIG_DMABUF_HEAPS_SYSTEM=y
-- 
2.43.5

