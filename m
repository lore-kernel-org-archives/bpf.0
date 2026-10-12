Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF78B3F1068
	for <bpf@vger.kernel.org>; Mon, 12 Oct 2026 14:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791814045; cv=none; b=tBLrCuSg/uanH3gry156HofTgb/Am5u5ai7W05c/s+McIbXXulqJf3OrJW7heYdLbGJ9z77eAe0xgX7AVDCXSsfTNPdn8aHBYQDsUHXkKBa0FXc6BP8qy1Lf/dJCsTTZwF8HxqagoxnkI0azVOapZ/mt/woZBvuOSJ8E7+A0x9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791814045; c=relaxed/simple;
	bh=xPaDiQg2Yp9dHNSuVK+AUsZ/3nGnmaMwlQb/fQaX++4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WmOhW1PgZZRISEBU1ooUoZ8bkNusa5g9zZEaB492H9bxxaapI9x/j80q/82/TFYYPL4B7WHMw+tSd4kWLYNN+yR9QXTr+XKKPy8X17gWFkvo0b2ynycacdeYxN8Jee6DB0OPz5Qbu2FpqFJHZzpYGOgjmCgQr2qddpMFVq3Kx8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ebrsGNKl; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ebrsGNKl"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69CCkdYM1751272;
	Mon, 12 Oct 2026 14:07:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=6YMSr
	6+Xp62dNVmzs2shbCGoF4fm3swN/W5ZkXAnhlw=; b=ebrsGNKlA4q7PzoFxEQWv
	qdWRODIP6u53YAlFxFFANxY3nRFwZK1AQRoVqCymvRsH1goMn0i/M5bfHb0X0eOa
	1DDMvbfXShdORkO6S2tTnHPPBHmLDqdhMGMt0Q+99Vf2dtvPrHGxFdjUY1v3kAZX
	YYvABodPmB61UMmePCUOUBibY2z3nvMH+6i1cAbvvhanLJeGN0B+DsyUe/shgKSM
	eQpOJaEY1HcD3mYZtwJlJ9D0kUM64cpZX3l//Y0OePJpkUCPsDz5qwDpjLsbuk03
	OaHAvpBKLoTDzNVS3sudwnqNOVQzIObOjXJvwgJpLPzjU1dc660pveqQV2X6w83M
	Q==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4h7ddgjd1n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Oct 2026 14:07:03 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 69CE6kVl035235;
	Mon, 12 Oct 2026 14:07:03 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4h7btn9qg9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Oct 2026 14:07:03 +0000 (GMT)
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 69CE6vgi036955;
	Mon, 12 Oct 2026 14:07:02 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-85-240.vpn.oracle.com [10.154.85.240])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4h7btn9q4d-3;
	Mon, 12 Oct 2026 14:07:02 +0000 (GMT)
From: Alan Maguire <alan.maguire@oracle.com>
To: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com,
        jolsa@kernel.org
Cc: ihor.solodrai@linux.dev, yonghong.song@linux.dev, song@kernel.org,
        martin.lau@linux.dev, memxor@gmail.com, emil@etsalapatis.com,
        puranjay@kernel.org, yatsenko@meta.com, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH bpf-next 2/3] selftests/bpf: Fix btf_inline to use .text section as base
Date: Mon, 12 Oct 2026 15:06:39 +0100
Message-ID: <20261012140640.2932195-3-alan.maguire@oracle.com>
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
X-Authority-Analysis: v=2.4 cv=EeZd0/mC c=1 sm=1 tr=0 ts=6acce987 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x4eqshVgHu-cdnggieHk:22 a=yPCof4ZbAAAA:8 a=VJIvrCeVIK4rQzBT4gwA:9
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12107
X-Proofpoint-ORIG-GUID: p2tTejtkZka0AXCoickcIijshlYMtwz8
X-Proofpoint-GUID: p2tTejtkZka0AXCoickcIijshlYMtwz8
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA1NSBTYWx0ZWRfX6voijcqIVuwy
 2ZxNeX93udVIkA1SsfofunCbfYIp9T8K6KUOKPhVQJOfWxtsCSSurC0r+hIGyEfwXicDygWiNUu
 GKfC7vuW8+dzbIkm5fCvafVYZV+xPSRK8YhLlkvYPTJFCFv+J+EW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA1NSBTYWx0ZWRfX2I0fbA1c8bFw
 /33SaUIOpEeeeHYqduQCp+Iz1K/IgqoSjTWbbsCnVbay6UHfhfAgUpKWjstvwl8qM1fsDY/URyK
 QvoNAEnJ+BGe39lQUPR6/aw9ojSfgHsJ6FiTaBhBRghgLoJDNyCAj9KjsV9WlgwQ3SBnm8XvVVO
 XqlfO3EV+AFwYuc+v8FcB6aR6+zPq3p4VWrGtXre5mG6MH3ppQAOqd493eRIPfKKs/BnWPBIIsp
 hQc71PHHh1PPNEwtv+wBkvygvDM/RFGMF7XuiKnap0VgY6kT7ietAJtXbkOIT+uPtg7q6lAcHgm
 gytX0NuQTz79LnBjwXf6V18kAKlRG1+5o6h12BUayEvy7QUC+DXE1fZgYoGbtyxwcfyq0wjXWZK
 d+b4cZgLsjdoqqLJg9wgihM3F1G6vP22k4mR0CWhKYm7H0V/S0JsI83bkz/R4RH0ID+IZiTzsbE
 XxLfUuZ5IGeODJTrbhQKXoc9DHhKQtr98b3TVOoM=

Relative addresses in LOCSEC are relative to the associated
ELF section for the LOCSEC "inline<section>"; in the case of
this test, it is ".text".  Fix the test to compute the address
via the section base rather than the overall module base address.

Since addresses in BTF inline LOC_PARAMs can be module base-relative,
do not remove the module base calcuation function.

Fixes: 400f0881c912 ("selftests/bpf: Add a test verifying inline information")
Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 .../selftests/bpf/prog_tests/btf_inline.c     |  5 +++--
 tools/testing/selftests/bpf/trace_helpers.c   | 19 +++++++++++++++++++
 tools/testing/selftests/bpf/trace_helpers.h   |  1 +
 3 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf_inline.c b/tools/testing/selftests/bpf/prog_tests/btf_inline.c
index d88fab6429b1..e630e5f0f5fa 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf_inline.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf_inline.c
@@ -32,7 +32,8 @@ void test_btf_inline(void)
 		return;
 	}
 
-	base_addr = module_get_base_addr("bpf_testmod");
+	/* LOCSEC offsets are relative to the ELF section base. */
+	base_addr = module_get_base_addr_sec("bpf_testmod", ".text");
 	if (!ASSERT_NEQ(base_addr, 0, "base_addr_nonzero"))
 		return;
 
@@ -41,7 +42,7 @@ void test_btf_inline(void)
 		return;
 	if (!ASSERT_NEQ(caller_addr, 0, "caller_addr_nonzero"))
 		return;
-	if (!ASSERT_GT(caller_addr, base_addr, "caller_addr_gt_base_addr"))
+	if (!ASSERT_GE(caller_addr, base_addr, "caller_addr_ge_base_addr"))
 		return;
 	caller_addr -= base_addr;
 
diff --git a/tools/testing/selftests/bpf/trace_helpers.c b/tools/testing/selftests/bpf/trace_helpers.c
index f3a1d627699d..6d7a4b8c4ab8 100644
--- a/tools/testing/selftests/bpf/trace_helpers.c
+++ b/tools/testing/selftests/bpf/trace_helpers.c
@@ -264,6 +264,25 @@ unsigned long long module_get_base_addr(const char *module)
 	return base_addr;
 }
 
+unsigned long long module_get_base_addr_sec(const char *module, const char *sec)
+{
+	unsigned long long addr = 0;
+	char *path;
+	FILE *f;
+
+	if (asprintf(&path, "/sys/module/%s/sections/%s", module, sec) < 0)
+		return 0;
+	f = fopen(path, "r");
+	free(path);
+	if (!f)
+		return 0;
+
+	if (fscanf(f, "%llx", &addr) != 1)
+		addr = 0;
+	fclose(f);
+	return addr;
+}
+
 #ifdef PROCMAP_QUERY
 int env_verbosity __weak = 0;
 
diff --git a/tools/testing/selftests/bpf/trace_helpers.h b/tools/testing/selftests/bpf/trace_helpers.h
index eb0d0d9804d6..0f8d99746084 100644
--- a/tools/testing/selftests/bpf/trace_helpers.h
+++ b/tools/testing/selftests/bpf/trace_helpers.h
@@ -39,6 +39,7 @@ int load_kallsyms(void);
 struct ksym *ksym_search(long key);
 long ksym_get_addr(const char *name);
 unsigned long long module_get_base_addr(const char *module);
+unsigned long long module_get_base_addr_sec(const char *module, const char *sec);
 
 struct ksyms *load_kallsyms_local(void);
 struct ksym *ksym_search_local(struct ksyms *ksyms, long key);
-- 
2.43.5

