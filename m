Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0A13939B6
	for <bpf@vger.kernel.org>; Wed, 26 Aug 2026 18:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.148.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787768341; cv=none; b=D5cZyHJiIGVHBZWC/MJt5mu6apsRIdvP56EQqXzwD7oAeqyJKGbH+7XqKIzdYe+JO4Xyc35JdOnFEweCNuhbcgnFP7OR9dJGES1+uhghrqeHhyLCEYhSMwq4sbUtjUhgeZcKv17wHPeSfw7lNY1bTj5YaUgztSjfNNR5CR3IgzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787768341; c=relaxed/simple;
	bh=VvWVRkQhNSTUmRVcn/BRcSVRzP9tCFR7L71Pydy6LwY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UxvVRMUnb/tXz8ftE2ieDd4/LfX2MLhA3tb6asEedtBnj452uKAO/BQEYWi5jcR2jqBzZ/GVK1YTulS891CDY+est/JRq3wrx3HqkaDq6Qm447xrwBkaDI/7l+Jo3k+anUJmXNfKJyE77M8rH5bTn8WBt6y0FXj4UJo7tas+L+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=DKSwrA6f; arc=none smtp.client-ip=148.163.148.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="DKSwrA6f"
Received: from pps.filterd (m0354652.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67QI2rNc011882;
	Wed, 26 Aug 2026 18:18:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=LyHW2qu1Y8vdjOS8pRRPSmV8B2EIdpIfwiukQUWIom4=; b=DKSw
	rA6fNkm8kYjcXsV3SXgVIWogmmmo9g8yBQZ41JKHsFms1IGhX7QE4l19d4ENcPNR
	O2jM/EsU5X25vLrL3x03dA46b3lz6Y4gbOBYQin726RUEz71SR9QASV8fKj33E04
	T4c0UkcvxJdlYloFzPY30TgkHQjLwjAWrB0eJb63j4ky4i3aHQ4qmfJlLrZy6Fea
	NCrYtgLSYAV+Tr3HPhffSFhWz1kiqkM6fJFMtj7ykIrhyd6WVjEiZj1fqBGHYHPJ
	Q0ZYgUeM46fp5HcJ2gpB9canqxkcY8jHao1ik+JgTWbRpW0UfzS9cU8SJWCHfSKM
	OKnQEJ82iSonP2VG3A==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 4ga53283g1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Aug 2026 18:18:31 +0000 (GMT)
Received: from LL-DJCZ134.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 26 Aug 2026 18:18:29 +0000
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
To: <bpf@vger.kernel.org>, <andrii@kernel.org>
CC: <martin.kelly@crowdstrike.com>, <slava.imameev@crowdstrike.com>,
        <linux-open-source@crowdstrike.com>
Subject: [PATCH bpf-next v2 3/5] libbpf: Convert bpf_program__set_autoload() to load-type enum
Date: Wed, 26 Aug 2026 14:18:23 -0400
Message-ID: <20260826181825.1826541-4-andrey.grodzovsky@crowdstrike.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260826181825.1826541-1-andrey.grodzovsky@crowdstrike.com>
References: <20260826181825.1826541-1-andrey.grodzovsky@crowdstrike.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: 04WPEXCH016.crowdstrike.sys (10.100.11.68) To
 04WPEXCH006.crowdstrike.sys (10.100.11.70)
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDE1MyBTYWx0ZWRfX87YmtrWZhRvS
 3ODV1MzcYUjj2ObxSFS5d5nUoLeIZ9vrcfl2EqCpX5qfbcy7QlX7C5STq3YoNQS2zoIC5Gfcw4M
 U7oBV+YpWUOTa3PIYG0r4vb3Bu74f0E8V64M2K9W4+xo8Ui5TW/QB/ZeQzMBxd5XsoLtYCuMxbL
 9LF6urOB84AdnHG9UwrKU6xIzxxVnzbw+Ox/J/mc1UkMbniQsuAOJVb637FW/4AHhkpPh6tTQbg
 VYRhaRJU2YWMLcUCmHXH138gUlZHQCslVVrt/0r3tc8hTui6Y/FxWoVBOislaX42LkHVjkbvhPm
 Dhnq8LXfLlDA74sC+3rcg3rc0os3PU8U6QzouYexXb6WF4MJbLCPK8Xt1U9vqYROCX+LlG0IL+W
 9NQbnLebYFpfeIysg7yi352z5jyT3H6zWQhOgwrBrWp4+YUVYNi1QmZN2gjuUDCETgAm4XsxsSC
 cpvgr/gAMAnVekOP8JA==
X-Proofpoint-GUID: nnlyVDQmb0wM56tNuPPOp2aJ3fUXosLx
X-Proofpoint-ORIG-GUID: nnlyVDQmb0wM56tNuPPOp2aJ3fUXosLx
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDE1MyBTYWx0ZWRfX1fCGcdepEbO8
 l9MdIYYaIDwxOGjAuazGOVip4WS4dnVlX0x5cqgs8JfnXeqSG/AOn0ZyRxjXSZf0fpKSz8eWBzc
 x0a9F0AVDn/0VuRjwmGyya83Kt2E4mZc0OeGuZNtB/jBU7v5CEKx
X-Authority-Analysis: v=2.4 cv=QclWeMbv c=1 sm=1 tr=0 ts=6a8f2df7 cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=T2KQ53IYiC3MXPrxx8bB:22 a=2KvRFfd_T_-xjmS8C1aD:22 a=VwQbUJbxAAAA:8
 a=pl6vuDidAAAA:8 a=QFY7RvWF8OokBNrb0VEA:9
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11887
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0
 phishscore=0 impostorscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260153

Convert bpf_program__set_autoload() from bool to enum bpf_prog_load_type,
to unify the API with the new tri-state load type. Reject
BPF_PROG_LOAD_TYPE_DYNAMIC to preserve the original autoload on/off
meaning; only BPF_PROG_LOAD_TYPE_DYNAMIC is dynamic-load-only. Also
restore autoattach when leaving BPF_PROG_LOAD_TYPE_DYNAMIC via
set_load_type(), fixing a bug where a program left dynamic load and
became autoload-eligible but never re-attached.

Assisted-by: Claude:claude-sonnet-5
Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
---
 tools/lib/bpf/libbpf.c   | 29 ++++++++++++++++++-----------
 tools/lib/bpf/libbpf.h   | 39 +++++++++++++++++++++++++--------------
 tools/lib/bpf/libbpf.map |  6 +++---
 3 files changed, 46 insertions(+), 28 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index c3fe1de43210..cd1d00c47841 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -9814,18 +9814,12 @@ bool bpf_program__autoload(const struct bpf_program *prog)
 	return prog->load_type == BPF_PROG_LOAD_TYPE_AUTO;
 }
 
-int bpf_program__set_autoload(struct bpf_program *prog, bool autoload)
+int bpf_program__set_autoload(struct bpf_program *prog, enum bpf_prog_load_type autoload)
 {
-	enum bpf_prog_load_type type = prog->load_type;
-
-	if (autoload)
-		type = BPF_PROG_LOAD_TYPE_AUTO;
-	else if (prog->load_type == BPF_PROG_LOAD_TYPE_AUTO)
-		type = BPF_PROG_LOAD_TYPE_DISABLED;
-	else
-		return 0; /* Otherwise, keep the current load type. */
+	if (autoload != BPF_PROG_LOAD_TYPE_AUTO && autoload != BPF_PROG_LOAD_TYPE_DISABLED)
+		return libbpf_err(-EINVAL);
 
-	return bpf_program__set_load_type(prog, type);
+	return bpf_program__set_load_type(prog, autoload);
 }
 
 bool bpf_program__autoattach(const struct bpf_program *prog)
@@ -15295,15 +15289,28 @@ static int bpf_program__set_dynamicload(struct bpf_program *prog)
 
 int bpf_program__set_load_type(struct bpf_program *prog, enum bpf_prog_load_type type)
 {
+	if (!prog)
+		return libbpf_err(-EINVAL);
+
 	if (prog->obj->state >= OBJ_LOADED)
 		return libbpf_err(-EINVAL);
 
 	switch (type) {
 	case BPF_PROG_LOAD_TYPE_DYNAMIC:
 		return bpf_program__set_dynamicload(prog);
-	default:
+	case BPF_PROG_LOAD_TYPE_AUTO:
+	case BPF_PROG_LOAD_TYPE_DISABLED:
+		/*
+		 * Leaving the dynamic state: set_dynamicload() cleared
+		 * autoattach because dynamically loaded programs are attached
+		 * explicitly. Restore the default for the target load type.
+		 */
+		if (prog->load_type == BPF_PROG_LOAD_TYPE_DYNAMIC)
+			prog->autoattach = true;
 		prog->load_type = type;
 		break;
+	default:
+		return libbpf_err(-EINVAL);
 	}
 
 	return 0;
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 54d755861289..a56068f0f112 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -356,6 +356,19 @@ LIBBPF_API int libbpf_attach_type_by_name(const char *name,
 LIBBPF_API int libbpf_find_vmlinux_btf_id(const char *name,
 					  enum bpf_attach_type attach_type);
 
+/*
+ * The program load type:
+ *
+ * - BPF_PROG_LOAD_TYPE_DISABLED: the program is not loaded.
+ * - BPF_PROG_LOAD_TYPE_AUTO: the program is autoloaded when the bpf_object is loaded.
+ * - BPF_PROG_LOAD_TYPE_DYNAMIC: the program is loaded and attached dynamically.
+ */
+enum bpf_prog_load_type {
+	BPF_PROG_LOAD_TYPE_DISABLED = 0,
+	BPF_PROG_LOAD_TYPE_AUTO,
+	BPF_PROG_LOAD_TYPE_DYNAMIC,
+};
+
 /* Accessors of bpf_program */
 struct bpf_program;
 
@@ -376,7 +389,18 @@ LIBBPF_API void bpf_program__set_ifindex(struct bpf_program *prog,
 LIBBPF_API const char *bpf_program__name(const struct bpf_program *prog);
 LIBBPF_API const char *bpf_program__section_name(const struct bpf_program *prog);
 LIBBPF_API bool bpf_program__autoload(const struct bpf_program *prog);
-LIBBPF_API int bpf_program__set_autoload(struct bpf_program *prog, bool autoload);
+/**
+ * @brief **bpf_program__set_autoload()** is retained for backwards
+ * compatibility; **bpf_program__set_load_type()** is the preferred API.
+ * The enum's numbering (DISABLED=0, AUTO=1, DYNAMIC=2) matches the previous
+ * bool semantics (false=0, true=1), so existing bool callers keep compiling
+ * and behaving unchanged. Only BPF_PROG_LOAD_TYPE_AUTO and
+ * BPF_PROG_LOAD_TYPE_DISABLED are accepted, preserving the original
+ * autoload on/off meaning; use bpf_program__set_load_type() to set
+ * BPF_PROG_LOAD_TYPE_DYNAMIC.
+ */
+LIBBPF_API int bpf_program__set_autoload(struct bpf_program *prog,
+					 enum bpf_prog_load_type autoload);
 LIBBPF_API bool bpf_program__autoattach(const struct bpf_program *prog);
 LIBBPF_API void bpf_program__set_autoattach(struct bpf_program *prog, bool autoattach);
 
@@ -2078,19 +2102,6 @@ LIBBPF_API int libbpf_unregister_prog_handler(int handler_id);
  */
 LIBBPF_API int bpf_program__clone(struct bpf_program *prog, const struct bpf_prog_load_opts *opts);
 
-/**
- * The program load type:
- *
- * - BPF_PROG_LOAD_TYPE_DISABLED: the program is not loaded.
- * - BPF_PROG_LOAD_TYPE_AUTO: the program is autoloaded when the bpf_object is loaded.
- * - BPF_PROG_LOAD_TYPE_DYNAMIC: the program is loaded and attached dynamically.
- */
-enum bpf_prog_load_type {
-	BPF_PROG_LOAD_TYPE_DISABLED = 0,
-	BPF_PROG_LOAD_TYPE_AUTO,
-	BPF_PROG_LOAD_TYPE_DYNAMIC,
-};
-
 LIBBPF_API int bpf_program__set_load_type(struct bpf_program *prog,
 					  enum bpf_prog_load_type loadtype);
 LIBBPF_API enum bpf_prog_load_type bpf_program__load_type(const struct bpf_program *prog);
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index a0389c58efe9..74312c95d328 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -460,10 +460,10 @@ LIBBPF_1.8.0 {
 	global:
 		bpf_program__attach_tracing_multi;
 		bpf_program__clone;
-		btf__find_by_name_kind_own;
-		btf__new_empty_opts;
+		bpf_program__load_dynamically;
 		bpf_program__load_type;
 		bpf_program__set_load_type;
-		bpf_program__load_dynamically;
 		bpf_program__unload_dynamically;
+		btf__find_by_name_kind_own;
+		btf__new_empty_opts;
 } LIBBPF_1.7.0;
-- 
2.34.1

