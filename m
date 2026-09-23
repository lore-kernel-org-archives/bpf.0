Received: from mx0b-00206402.pphosted.com (mx0b-00206402.pphosted.com [148.163.152.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B504334D0
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 23:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.152.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790206203; cv=none; b=pGt3+Ibiy8P8NC/BPvwlLe9sxabqaVzcwX+uY5YCMFwme/zffUsWCaE4Cx4jnuE46an1/LvhB2yANfpCFuJWTAvCt+02k+vCPqcUYiryWIsHo6l33Toz5xzzO3FreRLQxeC7HkL6ug7tNRZ9NbQHwRgHopuMRceLsQ2Zja8eQqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790206203; c=relaxed/simple;
	bh=QdOyVPS+y90p8hXTga2/Tc97G19ti6XAZfpSdNvHiuk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ikuz9hkfvMA1m+YaWpL6YHuQPADqGqsoyFDqfkWRQ0eBcByLZEr8OM4HsulhLLTsrCtkfhn5ZMWnT+YsosNuQ46eJ8EiDaOWZgREFKaUq8qUDVTSxMDBRTUk2PY9mUvuJz4/0mYogB0HGGxxPVZ/o5EKtDtLb4UNDjrqfbN1I80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=h23JVT22; arc=none smtp.client-ip=148.163.152.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="h23JVT22"
Received: from pps.filterd (m0354653.ppops.net [127.0.0.1])
	by mx0b-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68NKgAIL429241;
	Wed, 23 Sep 2026 23:29:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=aN75bz/Vpifo47+HrMwY/8DEORxeI0mp+MikFt1utEY=; b=h23J
	VT22E2VdW6GEhmWwKX+zdu5u/9bREFxHXMdlsLMVEQS2uajuxAGUhtmn01WjUnJk
	mO9J+j7vkzBz7bD2r8GyGvj6XB2fRGXjw3gloHEL8wYmXrM38inROMEkTAp6pMN6
	SrBgPdi/zIIvOF+zPcxqi61LQkxkIYysnvzgGDp/doorXiNPjG4w3iSkBoxHLISe
	x7p0DW+whAKaq/DU2mVm9o22GxFuHiSp5+SidI2ICRECHdrssWo4CJw5kltNiajH
	dTxPAYnXTKWbwT12ZAFJqCEkDAC9GxdJlLoBXqGtAZ7dcKGSPzO+2eVVQONcpSW3
	FUVPpe4UhdW/Om9N5Q==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0b-00206402.pphosted.com (PPS) with ESMTPS id 4gvp1r0dn5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Sep 2026 23:29:46 +0000 (GMT)
Received: from LL-DJCZ134.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 23 Sep 2026 23:29:44 +0000
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
To: <bpf@vger.kernel.org>, <andrii@kernel.org>, <ast@kernel.org>
CC: <martin.kelly@crowdstrike.com>, <slava.imameev@crowdstrike.com>,
        <linux-open-source@crowdstrike.com>
Subject: [PATCH bpf-next v5 5/8] libbpf: Version bpf_program__set_autoattach() ABI change
Date: Wed, 23 Sep 2026 19:29:36 -0400
Message-ID: <20260923232939.1886328-6-andrey.grodzovsky@crowdstrike.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260923232939.1886328-1-andrey.grodzovsky@crowdstrike.com>
References: <20260923232939.1886328-1-andrey.grodzovsky@crowdstrike.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: 04WPEXCH012.crowdstrike.sys (10.100.11.82) To
 04WPEXCH006.crowdstrike.sys (10.100.11.70)
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA5NSBTYWx0ZWRfX8xUO68Vtlze1
 JOB2r2Pc4E7BhzcyYJta9ba8Rr8+gcNwn1+gLzg9HBHUTRfpZmf6WTGx11lOuRkmJ1cH7H632UW
 rmf+q5aA8uzJACyl9gDaQpW3BnWNbYmWVn1KzR2oYuwoMHk32zqm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA5NSBTYWx0ZWRfX8gCM7g4xjUsz
 +ceMEOnULwQTS8hZYYHtaOMByrDAJIs5eDOv6hmNxPKOZSBuLWn1Y5ocFHRFOQIqJ6uoUAmeixd
 YEWxmH3p532PvMfIJ1b76nFROlg0U1/c0XxVIc/pdeVbTkr8uokB/SIahijixjUXYt+e9W3HdVZ
 4oajFkjs4T0lqrTXKz54DTDfqdgWFMPJ4Qfh1mKDvXMIwUcjD1qVfYjDGY7uEcB8tRlEG+STfEV
 X9DqL1FT4Rtyj0sNyzkA/vDIm5iCTlovqb8fom1KhlhGMUDOkCOB0AxtmDTP0By1Rj5wkQFcgpt
 JpksTwCX9NULlJcKiqH9J6ibeTlcSGdk9+DlgDOCqXGZUNRR2S6d8TQ8j8XkukfS/+kuAo5QmPf
 KnxlnJXSsZGpDkI5b5NWa0/fiy/+5my55jRBQwgATmSmSrEzYSsojQD/l7oNuEVWFsyuxMxsaEV
 kkqF+uSn+nxGWh/zlVg==
X-Authority-Analysis: v=2.4 cv=YOcKWhGx c=1 sm=1 tr=0 ts=6ab460ea cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=T2KQ53IYiC3MXPrxx8bB:22 a=GCXdLZfFv8EKBZhKOxZ5:22 a=pl6vuDidAAAA:8
 a=_7pdZih7oDRld-5tXWwA:9
X-Proofpoint-ORIG-GUID: hRA9h9KYt817bhwMW0TjOr7nR6QVBeo4
X-Proofpoint-GUID: hRA9h9KYt817bhwMW0TjOr7nR6QVBeo4
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11914
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 clxscore=1015 adultscore=0 phishscore=0 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609230095

bpf_program__set_autoattach()'s return type changed from void to int to
let callers observe the new -EINVAL rejection for MANUAL-strategy
programs, but the symbol stayed under its original LIBBPF_1.0.0 node in
libbpf.map. Binaries already linked against the old void-returning ABI
recorded a request for exactly that symbol@version pair at link time;
without a version bump they would silently start hitting the new
rejection behavior underneath them after a libbpf upgrade.

Split the symbol via ELF symbol versioning:

  - bpf_program__set_autoattach_deprecated() keeps the original
    unconditional behavior, bound via COMPAT_VERSION() to the existing
    LIBBPF_1.0.0 node.
  - bpf_program__set_autoattach_v1_8_0() carries the new MANUAL-rejecting
    behavior, bound via DEFAULT_VERSION() to the new LIBBPF_1.8.0 node.

Old binaries keep resolving bpf_program__set_autoattach() to the old
behavior at runtime; anything linked against the current headers/map
gets the new int-returning, MANUAL-rejecting behavior. Also adds the
missing __LIBBPF_MARK_DEPRECATED_1_8 gate to libbpf_common.h (only the
1.0 gate existed) so LIBBPF_DEPRECATED_SINCE(1, 8, ...) can mark the
deprecated variant.

Assisted-by: Claude:claude-sonnet-5
Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
---
 tools/lib/bpf/libbpf.c        | 9 ++++++++-
 tools/lib/bpf/libbpf.h        | 6 ++++++
 tools/lib/bpf/libbpf.map      | 2 ++
 tools/lib/bpf/libbpf_common.h | 6 ++++++
 4 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 85e1d9c775ab..224fb0247a39 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -9974,7 +9974,14 @@ bool bpf_program__autoattach(const struct bpf_program *prog)
 	return prog->autoattach;
 }
 
-int bpf_program__set_autoattach(struct bpf_program *prog, bool autoattach)
+COMPAT_VERSION(bpf_program__set_autoattach_deprecated, bpf_program__set_autoattach, LIBBPF_1.0.0)
+void bpf_program__set_autoattach_deprecated(struct bpf_program *prog, bool autoattach)
+{
+	prog->autoattach = autoattach;
+}
+
+DEFAULT_VERSION(bpf_program__set_autoattach_v1_8_0, bpf_program__set_autoattach, LIBBPF_1.8.0)
+int bpf_program__set_autoattach_v1_8_0(struct bpf_program *prog, bool autoattach)
 {
 	if (prog->load_strategy == BPF_PROG_LOAD_STRATEGY_MANUAL)
 		return libbpf_err(-EINVAL);
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index faea42f75847..d172c137cc37 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -393,6 +393,12 @@ LIBBPF_API bool bpf_program__autoload(const struct bpf_program *prog);
 LIBBPF_API int bpf_program__set_autoload(struct bpf_program *prog, bool autoload);
 LIBBPF_API bool bpf_program__autoattach(const struct bpf_program *prog);
 LIBBPF_API int bpf_program__set_autoattach(struct bpf_program *prog, bool autoattach);
+/* this "specialization" should go away once the deprecation window for
+ * bpf_program__set_autoattach_deprecated() closes
+ */
+LIBBPF_API int bpf_program__set_autoattach_v1_8_0(struct bpf_program *prog, bool autoattach);
+LIBBPF_DEPRECATED_SINCE(1, 8, "use int-returning bpf_program__set_autoattach() instead")
+LIBBPF_API void bpf_program__set_autoattach_deprecated(struct bpf_program *prog, bool autoattach);
 
 struct bpf_insn;
 
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 8def5474885a..999e791d9887 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -465,6 +465,8 @@ LIBBPF_1.8.0 {
 		bpf_program__clone;
 		bpf_program__load;
 		bpf_program__load_strategy;
+		bpf_program__set_autoattach;
+		bpf_program__set_autoattach_deprecated;
 		bpf_program__set_load_strategy;
 		btf__find_by_name_kind_own;
 		btf__new_empty_opts;
diff --git a/tools/lib/bpf/libbpf_common.h b/tools/lib/bpf/libbpf_common.h
index 8fe248e14eb6..12ad4f5f558f 100644
--- a/tools/lib/bpf/libbpf_common.h
+++ b/tools/lib/bpf/libbpf_common.h
@@ -36,6 +36,12 @@
 #define __LIBBPF_MARK_DEPRECATED_1_0(X)
 #endif
 
+#if __LIBBPF_CURRENT_VERSION_GEQ(1, 8)
+#define __LIBBPF_MARK_DEPRECATED_1_8(X) X
+#else
+#define __LIBBPF_MARK_DEPRECATED_1_8(X)
+#endif
+
 /* This set of internal macros allows to do "function overloading" based on
  * number of arguments provided by used in backwards-compatible way during the
  * transition to libbpf 1.0
-- 
2.34.1

