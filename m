Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C25751A757
	for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 22:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.148.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790030401; cv=none; b=GZYCb0bY7WiJDvuR4I/OH5YfEbej0NrJBI+fGrOHq1xybbVw0exsWvQmlzlqr97BeqMGuFaZ9zvdJqObff/aNXcUpFLJXP31gHb3QNaIm5dCkZCQbkTLU/UM4R8ETFd3QMzqlsH+OGB7l/kJL37QibVq+LyRTc1vLg420dfwNzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790030401; c=relaxed/simple;
	bh=KNWZW8eB3j6zpN8SQ7wsHAX/5xI1S4m0dH5DqE/VqnA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XLiA/3b2s4QmG2ajfKoVOBTGibpIFsMvIzfbNTn1SxkQaHLPMG6axfJrOoKCGVrUe34HDd9gWxA6zCtPkVIrog4B0fk2g9Peqc4sIqvwsOZ1pA/W2M8qRdlHll79eJvq6077LIb54ojSJEeZdVWwdazaHo97GulU/hPsliuMZPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=b1LhMPpV; arc=none smtp.client-ip=148.163.148.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="b1LhMPpV"
Received: from pps.filterd (m0354650.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68LHuiLN3819043;
	Mon, 21 Sep 2026 22:39:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=dwhZNmFy1JAR3RaFK/ylbRSoOcsz9cY7G4SsWQfUjBI=; b=b1Lh
	MPpVrdVE07CvPCfw8I5hmZrXnIY+VPXYJf2N3Ph2r4VxhG4OP1hoYD+6wqseT6rI
	3rUoasTSLuzDu54uW7RRhv8MBNmM4OnFV5i3It4JZ9tChuU574qvW4eF4tcOdtxU
	/VFIvMHdzYWTpl16ByKdHchaoSrP7l0nzuLMplK9SHIHy5cua2qdsrQprN5laU9g
	/HDAaXd4LItCkwI6GW00sEOB64wiHEZ3K9bs/Vg1OJ5/Uu+WmRttG5lkwAeg5Hwu
	6on8Mbcnh5UU+NBAV0fIDKbcZ8MlygPlaU6cji8QwhbFXIoCZwKQpZvKZzTcLEdm
	PG6HWFUaRTuwbF9W1A==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 4gu9e5rxes-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Sep 2026 22:39:46 +0000 (GMT)
Received: from LL-DJCZ134.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 21 Sep 2026 22:39:44 +0000
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
To: <bpf@vger.kernel.org>, <andrii@kernel.org>
CC: <ast@kernel.org>, <martin.kelly@crowdstrike.com>,
        <slava.imameev@crowdstrike.com>, <linux-open-source@crowdstrike.com>
Subject: [PATCH bpf-next v4 5/7] libbpf: Version bpf_program__set_autoattach() ABI change
Date: Mon, 21 Sep 2026 18:39:35 -0400
Message-ID: <20260921223937.3203093-6-andrey.grodzovsky@crowdstrike.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260921223937.3203093-1-andrey.grodzovsky@crowdstrike.com>
References: <20260921223937.3203093-1-andrey.grodzovsky@crowdstrike.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: 04WPEXCH014.crowdstrike.sys (10.100.11.87) To
 04WPEXCH006.crowdstrike.sys (10.100.11.70)
X-Proofpoint-ORIG-GUID: 2gDPLWrOZsFH2ZbqgwswM2r3R1gxUczW
X-Authority-Analysis: v=2.4 cv=L/iI0OT8 c=1 sm=1 tr=0 ts=6ab1b232 cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=T2KQ53IYiC3MXPrxx8bB:22 a=t04HzT_fAfAF5W-3wVZy:22 a=pl6vuDidAAAA:8
 a=_7pdZih7oDRld-5tXWwA:9
X-Proofpoint-GUID: 2gDPLWrOZsFH2ZbqgwswM2r3R1gxUczW
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDMzMSBTYWx0ZWRfX2Hpyxo3vMujY
 gxxFOu/a/kNnykkuYmZh3rPBzwAML460QRrzwPS1gMaqAp4xmeJj+PlCWWVOCPDMsD3eDLkD/Or
 zrtcO7PaS3OSsmN9F6SB53kKbBsbSizQoffvOcTeDFPvrphdueKr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDMzMSBTYWx0ZWRfX0OeqPRr3+SGw
 2RmEK+V35hpJvZ/cjc0+Fh/1D1ZoAVqohU7NKrDVdUKHD8aAUmc81wnRdUpQVHP2fHZMyRshvsw
 mE7T5XVL8qpweDVK67hKs2CEwGr2F6CZMZyrA0pL1/F+lI7JAuo3DEyO5UHg08dwg480ekDENmo
 l+hpp3rszki3IPy4BGcMgUAYLKOcU7OxGCwzj46t7oe5sk5bhADwVUpC/4xZUNKBw/hAc2ivfjq
 cn/TVw5miHKCW5gBO3gRvsEWaS+YWzNXD005lmrE3p5FI57+Q1+WT6EgGH5xqG/Jvp6xi8vR75s
 +xJQv1cetmURlPt4zWHZ/KUFC53fMf/VFRVcQdR3+kRne28dGFtZ06YMEZO8F81WY1g3o846CV7
 12UgTS/GLUI1TV51O7lJaKwXHjP8XZVxFvaE1z9AMvjOYeX8p4Ry7jyVkyMkggMzVXGjLhW1WBl
 NhqiiE0z429k7wudBJQ==
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11912
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 impostorscore=0 phishscore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609210331

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
index 6e7ec026d944..3e4eaeafea0e 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -9903,7 +9903,14 @@ bool bpf_program__autoattach(const struct bpf_program *prog)
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
index 5e44bcfa2ca1..8a04d81ccaeb 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -379,6 +379,12 @@ LIBBPF_API bool bpf_program__autoload(const struct bpf_program *prog);
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

