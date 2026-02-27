Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC39477E40;
	Fri, 27 Feb 2026 20:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.148.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772224884; cv=none; b=ndv3RdhtWYK2FBq/zHjrxNctpnNHy5zmY2tsrsV/x8mr0JDfRILElUK1fcSuFxUCtPWb42wyDNBf3+4o+r0pjbUsipTHYgTl8ds1uOVnkXS0fS6hGoM93QdwifBMdepR59thDYX9EoYJNH7nQYMySRUyk7MHwFL5LneemHDhefI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772224884; c=relaxed/simple;
	bh=QUOHjeaBF+9DKMoVmMSWJAFZTI91K34vGS+quMzHDlI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uOG3VKMAw2c8dcqgHWsmed5Y1keMbvxm0A5B1wJTnv3yJQr+kfozD7Wb6KgLMjW5cyzdhwjM+Cr1E9qM3bA24/SC2StNf06YYG1YOX4Txgb+EWwYjAjpvq912qore6KSdTpJlZeeQozXEInMZcec4s+Hk21C6gV9Uv4SYWPQ9Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=I+zngrU3; arc=none smtp.client-ip=148.163.148.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="I+zngrU3"
Received: from pps.filterd (m0354651.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61RK1L0N4076662;
	Fri, 27 Feb 2026 20:40:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=b1emR5Wx6Wa3oDqUD3m9qnHb5Z2/4vrjzqsvntE4AH0=; b=I+zn
	grU3x6QzVuuobvjkbPOecY398sbcFwi8ALoFFaOPLAvBaMjOVgXkOREA1v7CrjaR
	n3et2fT9fekluQyRIu4pDjcI0dbKm12hF0z0kYs9sP+XD3vKt5Fz1VZnFo2BOFNb
	ptWovOuyTVix4TvT/u8bB7bvgAOHnX+eD0Cpw0aKaX8cfWypjVZQS4pRnehBKqDT
	MqqlBUMKInd+oFK5tYAhUzlZBgdLVZY5+pK1eoj0TXrHvvcCNOpoiWdTC2DP7Fka
	z/eGLFQ1pgO7bENLt4cY54rQh6kQcyxu5op0k7yt5qwBkQtIH3fqB0HObo9ZGT+Z
	61oFlN1yAQDl0DqdHA==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 4ck5gvaudq-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Feb 2026 20:40:55 +0000 (GMT)
Received: from LL-DJCZ134.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 27 Feb 2026 20:40:54 +0000
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
To: <bpf@vger.kernel.org>, <linux-open-source@crowdstrike.com>
CC: <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <jolsa@kernel.org>, <rostedt@goodmis.org>,
        <linux-trace-kernel@vger.kernel.org>
Subject: [RFC PATCH bpf-next v3 1/3] libbpf: Optimize kprobe.session attachment for exact function names
Date: Fri, 27 Feb 2026 15:40:50 -0500
Message-ID: <20260227204052.725813-2-andrey.grodzovsky@crowdstrike.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260227204052.725813-1-andrey.grodzovsky@crowdstrike.com>
References: <20260227204052.725813-1-andrey.grodzovsky@crowdstrike.com>
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
X-Disclaimer: USA
X-Authority-Analysis: v=2.4 cv=Scz6t/Ru c=1 sm=1 tr=0 ts=69a20157 cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=T2KQ53IYiC3MXPrxx8bB:22 a=b3B37AjAgz0HnGB3MuNd:22 a=pl6vuDidAAAA:8
 a=VpqhlCfQX1L-8fIZS4AA:9
X-Proofpoint-GUID: D6ZdXn2cSfbsn8QtM0ZZ0jEzSxfyrkBx
X-Proofpoint-ORIG-GUID: D6ZdXn2cSfbsn8QtM0ZZ0jEzSxfyrkBx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDE4MiBTYWx0ZWRfX+2/QelK77HSJ
 1cvNzcdYbVSHKqTtq7pQGhLH6Oq1XeZts+JJCAIRLXb+uN5WG1XK9WMRVJcO6U//iIhLusyRD/D
 9lBbHmPx6U6pJ93TOkdMvuVcQOcZhUPzF46pwv247LRmelcHM5fUElT+h8hnzgzSroaiIFwrSd1
 ZiD3NNSb4jjA329TVgeK2Jv6jvnfcHxO3TOOm+iokgF/73Le84KcSISh+JfXdARz5YzMFfn+s+6
 Yld8gR3V+WWrOV9ePO8NtWcuuHNxfdRIo9XGWVkVETwpYuBRBdiNXU1cO56KnxHZS8zVbnjguS4
 GXMya17bUljFj/safbVtWfhOenfDTwAJnvnaGG1k3blSQbDK1erejiNS6e/mlJRn/IEfBVp+054
 lrLxD8YeXAkDaeTpjx9yDKWGHkdGZMkRSDnbKXsnzDQCIWXEY4HWKcf908AJmrQ3uTLfZXbIk2U
 uSXoN6YB2fnzZSEM7EQ==
X-Proofpoint-Virus-Version: vendor=nai engine=6800 definitions=11714
 signatures=596818
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 spamscore=0 phishscore=0 lowpriorityscore=0
 bulkscore=0 adultscore=0 impostorscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602270182

Detect exact function names (no wildcards) in
bpf_program__attach_kprobe_multi_opts() and bypass kallsyms parsing,
passing the symbol directly to the kernel via syms[] array.  This
benefits all callers, not just kprobe.session.

When the pattern contains no '*' or '?' characters, set syms to point
directly at the pattern string and cnt to 1, skipping the expensive
/proc/kallsyms or available_filter_functions parsing (~150ms per
function).

Error code normalization: the fast path returns ESRCH from kernel's
ftrace_lookup_symbols(), while the slow path returns ENOENT from
userspace kallsyms parsing.  Convert ESRCH to ENOENT in the
bpf_link_create error path to maintain API consistency - both paths
now return identical error codes for "symbol not found".

Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
---
 tools/lib/bpf/libbpf.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 0be7017800fe..80278385bc9c 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -12041,7 +12041,15 @@ bpf_program__attach_kprobe_multi_opts(const struct bpf_program *prog,
 	if (addrs && syms)
 		return libbpf_err_ptr(-EINVAL);
 
-	if (pattern) {
+	/*
+	 * Exact function name (no wildcards): bypass kallsyms parsing
+	 * and pass the symbol directly to the kernel via syms[] array.
+	 * The kernel's ftrace_lookup_symbols() resolves it efficiently.
+	 */
+	if (pattern && !strpbrk(pattern, "*?")) {
+		syms = &pattern;
+		cnt = 1;
+	} else if (pattern) {
 		if (has_available_filter_functions_addrs())
 			err = libbpf_available_kprobes_parse(&res);
 		else
@@ -12084,6 +12092,14 @@ bpf_program__attach_kprobe_multi_opts(const struct bpf_program *prog,
 	link_fd = bpf_link_create(prog_fd, 0, attach_type, &lopts);
 	if (link_fd < 0) {
 		err = -errno;
+		/*
+		 * Normalize error code: when exact name bypasses kallsyms
+		 * parsing, kernel returns ESRCH from ftrace_lookup_symbols().
+		 * Convert to ENOENT for API consistency with the pattern
+		 * matching path which returns ENOENT from userspace.
+		 */
+		if (err == -ESRCH)
+			err = -ENOENT;
 		pr_warn("prog '%s': failed to attach: %s\n",
 			prog->name, errstr(err));
 		goto error;
-- 
2.34.1

