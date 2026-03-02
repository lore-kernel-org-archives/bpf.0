Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0A94315A;
	Mon,  2 Mar 2026 20:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.148.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772482146; cv=none; b=ud6kUyv62h5zRsbjZJqYBsFOFd7Fd3tMLzjCUwLobbMfTLiWZnagAdZ0quOJ2b9RSpi3xTMuTPi3sStZ/6S8A8WXfO3uBmmEOi99WnlukbDtmxfhgVrGrvZMoLRuvf1jETzE/ZqHeDyHk8vDhxmifs803g/WSKPKSG1KteEwC54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772482146; c=relaxed/simple;
	bh=iUBlxO6FQYjtJqY68dZx2jwE4WWZBOgnwJbeaQANO7g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DcPXGIfVKMVvzaqJEMxsU0bGDLjm0VZFcrtvRKqs3YD+4NKB6eUzG1NJUpicPeEfyQO+fqMulLJPfpeHj/x2Xq0WFBgA6YPdxLgYIi8Ns8S0V7gLDMHBvuOI9uSB9CvH2wXw3OY0L0uO5JBu2qmvF2A19Ynj1QBsOBbzxt/YbYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=NGQg7+5a; arc=none smtp.client-ip=148.163.148.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="NGQg7+5a"
Received: from pps.filterd (m0354650.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 622JgOZN3867169;
	Mon, 2 Mar 2026 20:08:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=yNP0JYO3kGFLjytBqvI9CjTHwqRLZB8K9g2YWcUwfys=; b=NGQg
	7+5aJ2p+wbTPO6V+PzcGgyveh9ZIXhaTh3JkmHoFInF2W7z7xDZTh9rIhzFZmMkG
	/rEIAsGqlsYenF3VvFqH5ZgccmQl5RWy7/+qt12GE8VFWAMK4TFTzxKEfSe4vZit
	4Rc6F++Lh5pahBGXOVmhE3G2C2EBCHFhsfJVMtbwxCqR2HieZSirfzUgx9tlpA9f
	nfLz7LGyKTb4jH00ZYuHC2ICLxAohVNikxg+CD9IDYvWVvM7UjlON6JpFoq8w0Ms
	x1nTm3/AC+ZCXD9f1LGm+O0LoV68ow+gjSOjjgbAJNtLUeAa2VgkWafGZ0za59hb
	KQRrOkCru3LXD6lZIg==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 4cmcu95xr9-7
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Mar 2026 20:08:42 +0000 (GMT)
Received: from LL-DJCZ134.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 2 Mar 2026 20:08:40 +0000
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
To: <bpf@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>
CC: <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <jolsa@kernel.org>, <rostedt@goodmis.org>,
        <linux-open-source@crowdstrike.com>
Subject: [PATCH bpf-next v4 2/3] ftrace: Use kallsyms binary search for single-symbol lookup
Date: Mon, 2 Mar 2026 15:08:36 -0500
Message-ID: <20260302200837.317907-3-andrey.grodzovsky@crowdstrike.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260302200837.317907-1-andrey.grodzovsky@crowdstrike.com>
References: <20260302200837.317907-1-andrey.grodzovsky@crowdstrike.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDE1NSBTYWx0ZWRfX7PKcI8psDmFU
 xc1tP/M5LZ6wq8IILu8e17Tdf+ZvwRg/eLVJZKZXbah3oSgwGkgqziHKhaUJyYDVOYOekqtpWgx
 ERs/CfrAWkg0xvw4ijgMjqZqRSH8ihRNTiMvcbTSmQSCbuLza2vrXheYL6U0Ba1bFesyZ5TD9Yg
 5VcIYp1V5rQokryxs0KAX6Df6XmTvu+4wl7dwh6IlFl2LdklOOpdIJyFH1F70wLVDNHy+0G811b
 NLDn5N6OYbnYC9U1RIkf91dsgNK8MrYH6oXA68wV7BK+hq2+LkVG6SDBWBQObUUObL3rfgohpb7
 i7nwSXUvUyc0fhFnCqg7+Vufpr4Y1t51l0pn2Eq73eGqM56gwsounbZ4NDyDs5BYv6RxCbjqXv0
 cXuVBUzRnHJYg8H1S+plkodvI6wE/RsMPVOujHIscoxeZbwkdL1DvDdWZ/STKcfV+iRhg9bLSGR
 6vHcftY1ef2nUIkqkdA==
X-Proofpoint-GUID: U67SU8Y5LPZFbRlnEDF5MIbNOP059cTF
X-Proofpoint-ORIG-GUID: U67SU8Y5LPZFbRlnEDF5MIbNOP059cTF
X-Authority-Analysis: v=2.4 cv=Nr/cssdJ c=1 sm=1 tr=0 ts=69a5ee4a cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=T2KQ53IYiC3MXPrxx8bB:22 a=t04HzT_fAfAF5W-3wVZy:22 a=pl6vuDidAAAA:8
 a=UND7n31CiPwrdizkzM0A:9
X-Proofpoint-Virus-Version: vendor=nai engine=6800 definitions=11717
 signatures=596818
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 priorityscore=1501 spamscore=0
 impostorscore=0 suspectscore=0 clxscore=1015 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603020155

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

