Received: from mx0b-00206402.pphosted.com (mx0b-00206402.pphosted.com [148.163.152.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713F03793C3;
	Mon, 23 Feb 2026 21:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.152.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771883495; cv=none; b=FFPotqKYE33+R27oIMx6GuENlWyPGz311hikrRLHIZrWnvzhUZSKAu8YJ2hCMXYiXWFMiPFAdOMj9lVNxL2FocZyv9dU5c0dJwzPfsBv0xfcD/Hk86IAzyzSDd5eryCI6tasG82crc02rHJQPn9aX41l2oxNQQDuYNkgZ2J5SJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771883495; c=relaxed/simple;
	bh=LvAdBpDs6vSAN4K4YvZ3iYdFC3e/+5gaMzB3XS9ogbM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PogjeBeh+kApDlB69DfwyhOHVuEzDJvE9MGF4Mzmb8XAAuSwCqs6h5FGFHtxsdK7Addh+9STWQdFjHsK0EPUCg5OxhBps6vkNWztwUrtsp1gpkJq3LRuw21xof1mP7V2XDverL+yVa2B5r4rX8CFO/QJev93W0t8kDf8YGT3aNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=latA5aUs; arc=none smtp.client-ip=148.163.152.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="latA5aUs"
Received: from pps.filterd (m0354653.ppops.net [127.0.0.1])
	by mx0b-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61NJFoot2269294;
	Mon, 23 Feb 2026 21:51:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=G1n7wtz08npFDwHXdRj3gkHg2quclTG+HOfjYrGS+i0=; b=latA
	5aUszgMCs9KyG17SqTZtT34T02K2bDp0FP7oTZ/9ABzSqesBzVEnNOcg7dFqf/LF
	zaMJUYnllStIAFuuXV5RDIQSi4QfeANEQahBnuoLjqZGaMwWvva1fVKN22OT9N2w
	sq+ftMJUIJWNiKFAPh2lfEkWTHhoSsK9lnOzKJ9lnN7SVf+FFioWGGQKhJbh9ZAQ
	A/8y4/ejR+xLm6qzGhcjEeIhNcqhmA+48dCxZRJ2jPcW9mIkdBLiIO5KHYWyt1jg
	jTXRxWYwISWkorAbNS/HRl2/eoKcXRPzJI4QtYKub91dLLWgJqkm7tnFHe5LY77S
	Ncr9kYvoP01MEZQBIA==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0b-00206402.pphosted.com (PPS) with ESMTPS id 4cfqnjf34y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Feb 2026 21:51:18 +0000 (GMT)
Received: from LL-DJCZ134.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 23 Feb 2026 21:51:16 +0000
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
To: <bpf@vger.kernel.org>
CC: <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <jolsa@kernel.org>, <rostedt@goodmis.org>,
        <linux-trace-kernel@vger.kernel.org>,
        <linux-open-source@crowdstrike.com>
Subject: [RFC PATCH bpf-next 2/3] ftrace: Use kallsyms binary search for single-symbol lookup
Date: Mon, 23 Feb 2026 16:51:12 -0500
Message-ID: <20260223215113.924599-3-andrey.grodzovsky@crowdstrike.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260223215113.924599-1-andrey.grodzovsky@crowdstrike.com>
References: <20260223215113.924599-1-andrey.grodzovsky@crowdstrike.com>
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
X-Disclaimer: USA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDE5MCBTYWx0ZWRfX/gsPjydiW6XQ
 ZbIcXUywPMauxActOkqPDT8LbuggTqdhk4vHQCNlsPGqZ3fp2TbPIaiFsTqI9eJEX7HlytRl9/f
 lQsv8dtS2KOxz/G+B1nLQubgzbke+TJL98c03rbUeeQws+WL2qFC49ckHlOWvZLPJv0eeL88FhF
 1IjSvqSaPH5t7/rfcAjU1xN2paBHRklooKJBf6XmmdrbcgIsZkXnzPy/b5Gyuwebes6jZLPAKtC
 RM0ltP8xjypoZU/s0iaf4qRbC1Z23eV1wdA0LfB3ZHU4ufVB/fn22t+fgNzhH3eTBiAetAqfPb9
 7xYUQO+uEuKiMlNrK/KERJ5ZIs+zu7ZyUMmmooBqiQewM/GpprpES8JY8DI/8RTd5hDqvhgdv+B
 FTZJ0cpJCK2wMGU300uEOpGmy9wRX0ZZxAwSwpOrP4NNSBY24PENBt2wWOxuo3/O46Amzi1rbQb
 dkXFrM85I8OM7TK9fuw==
X-Proofpoint-ORIG-GUID: 4sJjqqNsDmmqzcXXPstpmJhXErwvL7iN
X-Authority-Analysis: v=2.4 cv=UoJu9uwB c=1 sm=1 tr=0 ts=699ccbd6 cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=T2KQ53IYiC3MXPrxx8bB:22 a=GCXdLZfFv8EKBZhKOxZ5:22 a=pl6vuDidAAAA:8
 a=QmtXynS4W5m_fGnND4MA:9
X-Proofpoint-GUID: 4sJjqqNsDmmqzcXXPstpmJhXErwvL7iN
X-Proofpoint-Virus-Version: vendor=nai engine=6800 definitions=11710
 signatures=596818
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 adultscore=0 lowpriorityscore=0 impostorscore=0 priorityscore=1501
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2602230190

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
is not ftrace-instrumented, or module symbols), the function falls
through to the existing linear scan path.

Before (cnt=1, 50 kprobe.session programs):
  Attach: 858 ms  (kallsyms_expand_symbol 25% of CPU)

After:
  Attach:  52 ms  (16x faster)

Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
---
 kernel/trace/ftrace.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 827fb9a0bf0d..bfd7670669c2 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -9263,6 +9263,19 @@ static int kallsyms_callback(void *data, const char *name, unsigned long addr)
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
+ * array.  While individual lookups are O(log N), doing K lookups
+ * totals O(K * log N) which loses to a single sequential O(N) pass
+ * at scale due to cache-friendly memory access patterns of the linear
+ * walk.  Empirical testing shows the linear scan is faster for batch
+ * lookups even well below 10K symbols.
+ *
  * Returns: 0 if all provided symbols are found, -ESRCH otherwise.
  */
 int ftrace_lookup_symbols(const char **sorted_syms, size_t cnt, unsigned long *addrs)
@@ -9270,6 +9283,21 @@ int ftrace_lookup_symbols(const char **sorted_syms, size_t cnt, unsigned long *a
 	struct kallsyms_data args;
 	int found_all;
 
+	/* Fast path: single symbol uses O(log N) binary search */
+	if (cnt == 1) {
+		addrs[0] = kallsyms_lookup_name(sorted_syms[0]);
+		if (addrs[0])
+			addrs[0] = ftrace_location(addrs[0]);
+		if (addrs[0])
+			return 0;
+		/*
+		 * Binary lookup can fail for duplicate symbol names
+		 * where the first match is not ftrace-instrumented,
+		 * or for module symbols.  Retry with linear scan.
+		 */
+	}
+
+	/* Batch path: single-pass O(N) linear scan */
 	memset(addrs, 0, sizeof(*addrs) * cnt);
 	args.addrs = addrs;
 	args.syms = sorted_syms;
-- 
2.34.1

