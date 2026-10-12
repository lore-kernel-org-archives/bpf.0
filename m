Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB713CF1E7
	for <bpf@vger.kernel.org>; Mon, 12 Oct 2026 14:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791814042; cv=none; b=U6I4uYFAlYI8DU+mwkgB8y1mnW5FO/Qbnpeq5CiSyGrlCZzs3v96p+VuPgOuAujFSKogUVePm3IG9ydHwmwnMM/QPeprcnb6fl8EF44JGKtKjakr8rda79+cFbRVR8hAGk5UN8Bt7hNFQg5/Z8U0J4M7sqlvUe6znOymJN5a1Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791814042; c=relaxed/simple;
	bh=7bi+vspsAG1hhcfsYqKLA7DD9NGzOgn375aai+bmtYc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NG2HMC3bjFuBEdD1ET0O+Zf9S0OssSasV3UvR0dvyK605gp1zm80q8i4FV+Dd6cZqwA7Upz1ttuBHLwrYDglSmOOHzss8X5X7EIbQgBPzYze0vZviBIaLlrFz+bd60FMMi89Aq1aAcAmkslhfasCaeV+2kXfujD/iCkdYy1DXyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KdUBu9uI; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KdUBu9uI"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69CCiftH1836407;
	Mon, 12 Oct 2026 14:06:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=gPG5fpScR0nwew0G/YMMnUohifN+g
	yVlLqYu30vbgAE=; b=KdUBu9uIPGx+j1Tp8jUoaCy1hnJRoDW4mXv6cs+5EGmWo
	JBkt7CUnrqc3Xlv7eAzd859gY7FJmV7VrDPS1mLfLYnuMIL/zAhEdpiPyVaGx16N
	ijdUfHr5cbXr3fXhcIe76NlT5EtITx8KDOTVr2pgttvYWBZvOTcwc29oKbQ/HOxt
	6c/ecioj4a37eLI/ZTrRMxohoTm5wm2C1eCw+3LcW196pEG3qWQWRuwKgTJag16F
	nQpqXxPQEjGto0xMFPfvVgTwkXhse/tU8VVokxqIYojI8RmCikbN02TJ+CbAKkld
	1sa8VE0jTWe1Ye2sohhFVM45eKn0bs+a8wveou6xw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4h7demjbtj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Oct 2026 14:06:58 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 69CE6idE035086;
	Mon, 12 Oct 2026 14:06:58 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4h7btn9qch-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Oct 2026 14:06:58 +0000 (GMT)
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 69CE6vge036955;
	Mon, 12 Oct 2026 14:06:57 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-85-240.vpn.oracle.com [10.154.85.240])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4h7btn9q4d-1;
	Mon, 12 Oct 2026 14:06:57 +0000 (GMT)
From: Alan Maguire <alan.maguire@oracle.com>
To: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com,
        jolsa@kernel.org
Cc: ihor.solodrai@linux.dev, yonghong.song@linux.dev, song@kernel.org,
        martin.lau@linux.dev, memxor@gmail.com, emil@etsalapatis.com,
        puranjay@kernel.org, yatsenko@meta.com, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH bpf-next 0/3] Inline BTF followups
Date: Mon, 12 Oct 2026 15:06:37 +0100
Message-ID: <20261012140640.2932195-1-alan.maguire@oracle.com>
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
 definitions=2026-10-12_04,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 spamscore=0 adultscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=999 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2610020000 definitions=main-2610120056
X-Authority-Analysis: v=2.4 cv=CoEq4X4D c=1 sm=1 tr=0 ts=6acce983 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=3I1J8UUJPc9JN9BFgKH3:22 a=TN3fGzQdy2qI55i9mlgA:9 a=5yU3S35YU4bGjq-dph-N:22
 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12107
X-Proofpoint-GUID: kU9uCT4Y9CZahtpI7AWVlKVLF9BamZIN
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA1NSBTYWx0ZWRfX326XyOMCEGZj
 MYsG8xlzaV6bqjs46LD5f6bKWMw40bo+tXm5Bdiway6gEnu0w/hEG39sdLo+mWKG7gi2/NX3fz2
 4sT0GCAvhxgMPOFbz4m7gv9M3/dTc9Tt1DaHodhEe3fx4mORZIgp
X-Proofpoint-ORIG-GUID: kU9uCT4Y9CZahtpI7AWVlKVLF9BamZIN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA1NSBTYWx0ZWRfX6Sgh0ZRhv84V
 FitDpFjqzqeWi0CTBKmRiia5qiP8PfnQJSI9Gj7fc+vCdtlFMNazKuguOXjQUbWjr815hkYM/3h
 Q7nn8rWcBihRBrykxAZS6ylNNQOpHOdzhlRpf1t4v137zcMBQnNv28bw6dG3Cz6TRxuUnCENw1w
 z+PpHfgBmnYk8i+xpls5Ew4mo9csJoaCSrS9SN08rqz4zNtLSjkg3jXyp8Bcn+QVn/BAztduM4K
 pZdrKk6cJJZeREsgxQ6AhU9GxYk0KaxVfm12g8dCDFpBjFq+7FG2odTBjY2m5XdMPtMFut5w/Qy
 PH6KlE/JxKCxW/1vBlufw7us4/zdyTOj0qFek06WE+opUTU+5wIt8SM++CN6kZri/6KHrf/4vc8
 Jbp/Wme7PCCBpHiql5n2KStELjYXfBlwhIsWQQA7UlUMRWSGi7i/7xOrbA2/e4LGbfpUbeB0ff7
 HYFkR8c3ifEhinR+serR/dtbEhKTO0+1sO9X3IKM=

This series addresses lingering issues after BTF inline
series landed.

Patch 1 fixes validation issue on loading BTF inline info.

Patch 2 corrects the base address calculation for BTF inline
data in LOCSEC to use the ELF section base rather than module
base.

Patch 3 enables BTF inline info for CI config.

Alan Maguire (3):
  btf: Fix size/vlen validation for BTF_KIND_LOC_PARAM
  selftests/bpf: Fix btf_inline to use .text section as base
  selftests/bpf: Enable CONFIG_DEBUG_INFO_BTF_INLINE for CI

 kernel/bpf/btf.c                              |  8 ++++----
 tools/testing/selftests/bpf/config            |  1 +
 .../selftests/bpf/prog_tests/btf_inline.c     |  5 +++--
 tools/testing/selftests/bpf/trace_helpers.c   | 19 +++++++++++++++++++
 tools/testing/selftests/bpf/trace_helpers.h   |  1 +
 5 files changed, 28 insertions(+), 6 deletions(-)

-- 
2.43.5

