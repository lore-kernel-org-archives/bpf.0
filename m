Received: from mx0b-00206402.pphosted.com (mx0b-00206402.pphosted.com [148.163.152.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F6C477E49;
	Fri, 27 Feb 2026 20:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.152.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772224886; cv=none; b=RbkJ2Wcce3+2DGi4xQ7GvvbeNQmY6d0BgKtG9VffDIrCq1Kt7UUABwf3Fce3NPR5ejh2zFvD0612sEBhGSxA1rf2pOSc9AaiaotG/8M1vc4uP8ar3P+1e27hH0dAWipvo9THeo+Dqv3lfE3gfU3Ukh879VZ5vjseWgyEpZFhZNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772224886; c=relaxed/simple;
	bh=iUBlxO6FQYjtJqY68dZx2jwE4WWZBOgnwJbeaQANO7g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SSfDrINKYCzgh4rQjn4nnIh13Qe48eRBnHhi4j+6/cexx6u2SlVZ5P/7ejIpChGdH1VSsKHIQuesraGIXm6WwhuivOuAPkUG1KG5h2HuB7MdHIjveDYZnYVOeksuAAOEQ6RjP176masgY7ZNbz6oEAgEJSxGl2HqBYjgQgJvdXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=oSG43vsn; arc=none smtp.client-ip=148.163.152.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="oSG43vsn"
Received: from pps.filterd (m0354653.ppops.net [127.0.0.1])
	by mx0b-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61RJloPY1207999;
	Fri, 27 Feb 2026 20:40:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=yNP0JYO3kGFLjytBqvI9CjTHwqRLZB8K9g2YWcUwfys=; b=oSG4
	3vsnl6hr4jX1TdMkJa0Jzgn7DD1zjiRNbVe52ZWlmLhmaO686gdy3KLztZs7Twv/
	KnT7p3hSAX4FeGcZjVEXJMT4CcK5Cczqj1omcg+eQbufTZZyqcEQxazt9QcgCz6U
	mG77phqUYLspfMZv5tC2mJHZ8SqL4gfVxYEr2iG80G+2NCEZkUTxyEBfQngvNYbe
	E57woT9PsgQREKgA9Z7oosECy5KWiWshfs9ci1RvTbvab6kl3TAkWQ4IXt0UbZqb
	mu1R/7YS/LQCux4QiAnvuB1V495iii91tJ+CuRbFTYpIIKVm22AeWfSBJ9tSr7M4
	hTNW6mM7+9H/z6vKfQ==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0b-00206402.pphosted.com (PPS) with ESMTPS id 4ck3s6k348-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Feb 2026 20:40:57 +0000 (GMT)
Received: from LL-DJCZ134.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 27 Feb 2026 20:40:55 +0000
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
To: <bpf@vger.kernel.org>, <linux-open-source@crowdstrike.com>
CC: <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <jolsa@kernel.org>, <rostedt@goodmis.org>,
        <linux-trace-kernel@vger.kernel.org>
Subject: [RFC PATCH bpf-next v3 2/3] ftrace: Use kallsyms binary search for single-symbol lookup
Date: Fri, 27 Feb 2026 15:40:51 -0500
Message-ID: <20260227204052.725813-3-andrey.grodzovsky@crowdstrike.com>
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
X-Proofpoint-GUID: Yz4im3YnbOSOXS3icGhHyzc9i_qdJef0
X-Proofpoint-ORIG-GUID: Yz4im3YnbOSOXS3icGhHyzc9i_qdJef0
X-Authority-Analysis: v=2.4 cv=Dboaa/tW c=1 sm=1 tr=0 ts=69a20159 cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=T2KQ53IYiC3MXPrxx8bB:22 a=GCXdLZfFv8EKBZhKOxZ5:22 a=pl6vuDidAAAA:8
 a=UND7n31CiPwrdizkzM0A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDE4MiBTYWx0ZWRfX8ya1Q51QNxR+
 K/PhwJeyl6hR6HMdkqx2uWs+TZO0ioh12hUBWEcq2Ds9/zbSXgOEkBnFbNj/4HAI3FemXdbLNPN
 9TueS3XyWtfzcKMMGtkMVoDARDQqrCI0rCZI06Aq70BQwKQ4E3C2JD4imSv0ZWqMtNCCrdV2AeY
 uj3e8tmPIM6mf93IrocJPyS4QnePXYw/lfw8Tb6y8gczNJ59UPHMx0B6HUNuWHeG6fIHpTPNgMB
 Cbw9ytpr2vxZi6gJYjgyyFrJc7a0eyFnYWssAlkNHLVVXbhkrEcCeYp7kA3/7yoUtiYzSfSrUS1
 4o+1dnCayU5i+eLOVKgjAkosN4SgowG0RYuhO3805PEQmeXHTONKJwsphZ0VhgvZnIoCFJw07l2
 /1jRoz9iA+KW/LL/MuGWivRNbKZv9KtIqQA004saw0Xuhj4lfVlCIqz6ZlQU5v/128N+sewXDEe
 I7AgnjLIHrKlSL4PaQA==
X-Proofpoint-Virus-Version: vendor=nai engine=6800 definitions=11714
 signatures=596818
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 impostorscore=0 clxscore=1015 malwarescore=0
 phishscore=0 suspectscore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602270182

When ftrace_lookup_symbols() is called with a single symbol (cnt == 1),
use kallsyms_lookup_name() for O(log N) binary search instead of the
full linear scan via kallsyms_on_each_symbol().

ftrace_lookup_symbols() was designed for batch resolution of many
symbols in a single pass.  For large cnt this is efficient: a single
O(N) walk over all symbols with O(log cnt) binary search into the
sorted input array.  But for cnt == 1 it still decompresses all ~200K
kernel symbols only to match one.

kallsyms_lookup_name() uses the sorted kallsyms index and needs only
~17 decompressions for a single lookup.

This is the common path for kprobe.session with exact function names,
where libbpf sends one symbol per BPF_LINK_CREATE syscall.

If binary lookup fails (duplicate symbol names where the first match
is not ftrace-instrumented), the function falls through to the existing
linear scan path.

Before (cnt=1, 50 kprobe.session programs):
  Attach: 858 ms  (kallsyms_expand_symbol 25% of CPU)

After:
  Attach:  52 ms  (16x faster)

Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
---
 kernel/trace/ftrace.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 827fb9a0bf0d..13906af8098a 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -9263,6 +9263,15 @@ static int kallsyms_callback(void *data, const char *name, unsigned long addr)
  * @addrs array, which needs to be big enough to store at least @cnt
  * addresses.
  *
+ * For a single symbol (cnt == 1), uses kallsyms_lookup_name() which
+ * performs an O(log N) binary search via the sorted kallsyms index.
+ * This avoids the full O(N) linear scan over all kernel symbols that
+ * the multi-symbol path requires.
+ *
+ * For multiple symbols, uses a single-pass linear scan via
+ * kallsyms_on_each_symbol() with binary search into the sorted input
+ * array.
+ *
  * Returns: 0 if all provided symbols are found, -ESRCH otherwise.
  */
 int ftrace_lookup_symbols(const char **sorted_syms, size_t cnt, unsigned long *addrs)
@@ -9270,6 +9279,19 @@ int ftrace_lookup_symbols(const char **sorted_syms, size_t cnt, unsigned long *a
 	struct kallsyms_data args;
 	int found_all;
 
+	/* Fast path: single symbol uses O(log N) binary search */
+	if (cnt == 1) {
+		addrs[0] = kallsyms_lookup_name(sorted_syms[0]);
+		if (addrs[0] && ftrace_location(addrs[0]))
+			return 0;
+		/*
+		 * Binary lookup can fail for duplicate symbol names
+		 * where the first match is not ftrace-instrumented.
+		 * Retry with linear scan.
+		 */
+	}
+
+	/* Batch path: single-pass O(N) linear scan */
 	memset(addrs, 0, sizeof(*addrs) * cnt);
 	args.addrs = addrs;
 	args.syms = sorted_syms;
-- 
2.34.1

