Received: from mx0b-00206402.pphosted.com (mx0b-00206402.pphosted.com [148.163.152.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3C13290D0;
	Thu, 26 Feb 2026 17:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.152.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772127249; cv=none; b=VEaj5xB/Cafxb2Pp8iSEMa0Rs/1CxpbukIQvfkpFSO9jjU6IdVEkBFJA/PqQnFOSxcAbCzqb3xzhwlDFVv78rg2Cc+nAsikcjpVCYk7QmIPbj2I5nYEHIHTnyYRgG8tFLM76ItLXOnEgiM2MGmik7ImDLI31REyoE6jqs9Fygg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772127249; c=relaxed/simple;
	bh=w6rfr62I76P8GyP+eM/54SEaBwKCyQxQYfI0r39jlCE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H1Bj1ZO07R2366BpccawEwpmQ76PVfX9M7roPCFTMvWKhoA//shUJ64k4sghspgb3jyriB/4WPFpsE8aR8GB64i9aVBkkjnu5+9jjPX8XXqv9+wVnS7J+322gd41kNB9VqRPZcDUoXnno3PgOa5ZWH/XUTtZWA1YGEzIxCXEK2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=d9ojlokp; arc=none smtp.client-ip=148.163.152.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="d9ojlokp"
Received: from pps.filterd (m0354655.ppops.net [127.0.0.1])
	by mx0b-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61QH1UXA2678715;
	Thu, 26 Feb 2026 17:33:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=lKfUcRLZBYeHAqGGFb2DLXJbbTfTyn7FteL9r80qGNE=; b=d9oj
	lokpisg1yHzOYMduYi/BxOV3Ym40PL+9SWt6hcfBQ+tzekQygDz8B9RBoAcutMJx
	O+NGSywZEnI5E0zuYdkm+gZnUx2iL0Kvq050i4Q4mc2kk9sV7WRgYAQwu3H6LZjT
	KmWg8iMXng4igsMdXGui8iJ1MklCKm4LyZanfjXbhEL4F98EHh+9W7/VQOKSnk98
	WtrtD7Yu0RuJiFwOr4I51NZaer0pqzDJ+ZYQ1VwwZo8B2BF5sWxb+Zl0oZVsjbgF
	gEM/OCGL+lnz9izJdLccMvji7zJhib2GSyrEpdIbRi9aOOPCc3erOB8IOs8GkOoZ
	E0FJ4GNQwSG9uZeIHg==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0b-00206402.pphosted.com (PPS) with ESMTPS id 4chu8u6xw7-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Feb 2026 17:33:46 +0000 (GMT)
Received: from LL-DJCZ134.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 26 Feb 2026 17:33:45 +0000
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
To: <bpf@vger.kernel.org>, <linux-open-source@crowdstrike.com>
CC: <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <jolsa@kernel.org>, <rostedt@goodmis.org>,
        <linux-trace-kernel@vger.kernel.org>
Subject: [RFC PATCH bpf-next v2 2/3] ftrace: Use kallsyms binary search for single-symbol lookup
Date: Thu, 26 Feb 2026 12:33:41 -0500
Message-ID: <20260226173342.3565919-3-andrey.grodzovsky@crowdstrike.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260226173342.3565919-1-andrey.grodzovsky@crowdstrike.com>
References: <20260226173342.3565919-1-andrey.grodzovsky@crowdstrike.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: 04WPEXCH008.crowdstrike.sys (10.100.11.75) To
 04WPEXCH006.crowdstrike.sys (10.100.11.70)
X-Disclaimer: USA
X-Proofpoint-ORIG-GUID: K2zhyJLl5QxQm8JuVUjvhn6_Fc7LmR0Q
X-Proofpoint-GUID: K2zhyJLl5QxQm8JuVUjvhn6_Fc7LmR0Q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI2MDE1OCBTYWx0ZWRfX9w5e2q/M6jjz
 v+GFVMnIzRcFgOmksIMjQG0oQDAwThdkTInrcliWDDcZyIPFwjafql0KRPL+jgOshP7gQhKo3Ek
 DrJoA9Owv350TSqgR3vWa9VPaqKk9LE6kkDbBNKw1YRbGOqNJ3Z1D8oXR2V5GTSsDC+DMEGS39L
 wsmnIJ7mqVe6XFnB//7UAFvMnEarIrUiQVTUGax5rUI/QiPTXKrTt1QtBvuyIaPnoJaXTVmWsUV
 OM2sSU0k46Q4h8T6OVOD2aP9fE/B+fpSgeGtWxvN6Up/VPcn8Ify8fL0h5OEzUntt2ZD0TcKo+m
 AEe0SaewNeaPOq6eRBJuCyuyOb9j5u9WvpS/X90Bp9kKl8L1Gb27ZqJlyefHjVeUAWT99vfv4gx
 dHuKmGdM7wpboI5kagIH/yTsyP5poQNVwIzhaFQMyUr3y8zo2hD60y2DgglX1sp2qosfElIIG0m
 IPbfMqgjo8r/bDwZd6Q==
X-Authority-Analysis: v=2.4 cv=P7o3RyAu c=1 sm=1 tr=0 ts=69a083fb cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=T2KQ53IYiC3MXPrxx8bB:22 a=vDKVRhTs-M86Ea50iKLw:22 a=pl6vuDidAAAA:8
 a=UND7n31CiPwrdizkzM0A:9
X-Proofpoint-Virus-Version: vendor=nai engine=6800 definitions=11713
 signatures=596818
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 phishscore=0 suspectscore=0 clxscore=1015 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602260158

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
 kernel/trace/ftrace.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 827fb9a0bf0d..cfa0c7ad7cbf 100644
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

