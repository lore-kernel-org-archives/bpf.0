Received: from mx0b-00206402.pphosted.com (mx0b-00206402.pphosted.com [148.163.152.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D43E332632;
	Thu, 26 Feb 2026 17:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.152.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772127249; cv=none; b=aJFtYt1qTOpedohmbVOEMv0HAN949JIFipoU85rj/UVSOjtLBiWVRVl4zrGtJS0bFMv9QeKOjdGAC8bGLcHyWQeMM8G0gmAjJ3VSUAHCSmzRI4Y2zyMOFvcIRG1JhZHa4D1cNHYG2wq4gJ3IRwyP+1Hdk/a+m3znieJLyaRkM8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772127249; c=relaxed/simple;
	bh=FG9811vMIlsh9Y4ItbPIFUG2ufBEHdXAWCduyJ/2gws=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L3e36CFz8fIFA7+Neel423m6/k1o5HA2MwT/OBmpNkKIBCRPTOUus39OIR8fjZ3PnsnC4azlzvjxFs8OGIyR2spnGli/tsZQ9rYzA23NqiXvdtvzlbFsqYWpNDLCEz1G02KCDR6tcueQNGZptAEUYxydjGtGioDulZb/xyXU574=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=PXWDYAYQ; arc=none smtp.client-ip=148.163.152.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="PXWDYAYQ"
Received: from pps.filterd (m0354655.ppops.net [127.0.0.1])
	by mx0b-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61QH1UX92678715;
	Thu, 26 Feb 2026 17:33:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=yux3r5kI9H7tIDlQeeUMX6sdHDf7yCoCClAr7dybe18=; b=PXWD
	YAYQIncV66aSi5gazq9Km0fQ2prM+C5FSmjzITcz5pjYdCjloZdE4S2iTEDAp/UL
	OMMV+12Pji3UyjXLinCfYVcUd6mf2PVey09ZifPys3SarVfc1iDT9E0TiqIA1aCN
	jEA3eb3pfqQHbkTI/W8F6nOSPt7LzBe0fdSaQvI3mZZ1FDCug+Pamr1++5JRQjhP
	kNTwK3ay6zXNvaLIdmkgtf6+jjP0bcxHgXtdSzPyiGeoBPzdwihYkpQLUCgZ3jkh
	yaofNTlkcGqorDgVOAN1SWlCejyer/xojUktLio57MS7Qo8A7/PLLYMbCokihuFI
	00lb2sfUzZFpwtBBhQ==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0b-00206402.pphosted.com (PPS) with ESMTPS id 4chu8u6xw7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Feb 2026 17:33:46 +0000 (GMT)
Received: from LL-DJCZ134.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 26 Feb 2026 17:33:44 +0000
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
To: <bpf@vger.kernel.org>, <linux-open-source@crowdstrike.com>
CC: <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <jolsa@kernel.org>, <rostedt@goodmis.org>,
        <linux-trace-kernel@vger.kernel.org>
Subject: [RFC PATCH bpf-next v2 1/3] libbpf: Optimize kprobe.session attachment for exact function names
Date: Thu, 26 Feb 2026 12:33:40 -0500
Message-ID: <20260226173342.3565919-2-andrey.grodzovsky@crowdstrike.com>
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
X-Proofpoint-ORIG-GUID: vu5eOlBOGEqHSWRa_HrWHnqMXmY_2ri4
X-Proofpoint-GUID: vu5eOlBOGEqHSWRa_HrWHnqMXmY_2ri4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI2MDE1OCBTYWx0ZWRfX4oBu98eLMo5R
 9I9+qP5xa9N/uEx6TwbYrv2qsXauE6jyKTWqek7oZ277PEVAHnJiQfGoQvt7kMD7ZHpxv3B8yBb
 7kWhNO6nZHJp6ZaLg8ZmcggiJT0teLQDyIiHbc2d8dQdRpnHaaUB/1N8FFvysjAkq9s4VeQmCnG
 G0q+dcrCNI9eh8JqWfxqhLAtaYR3hCfNS7Hj3nERyhLBJvGiufsFz+nLZA/UAueUKo8I7WLJVXS
 m4/fYtDBN5Iye+2+B/FlrGD/01yrsO5Fs0RR8dKB1P6ng/CNP/vYCpPc3/YP8ZcaqTfqytombNU
 m50vh77us3+KJhiOmkCisy/FVoPioh5q9WIpN3l0nZKGscfanKnMxRywARSjHZjFaiYFk/zXCoS
 BU8DuyrOvu04dQQDibroORzRid9AMosYN6N2CtGDMT8sJHIGJMbntk221yufwEutcqhMSDtYIir
 aqA8hisGgHCeGpeR1jw==
X-Authority-Analysis: v=2.4 cv=P7o3RyAu c=1 sm=1 tr=0 ts=69a083fa cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=T2KQ53IYiC3MXPrxx8bB:22 a=vDKVRhTs-M86Ea50iKLw:22 a=pl6vuDidAAAA:8
 a=fCeuS-gix1Ntd_zMSvEA:9
X-Proofpoint-Virus-Version: vendor=nai engine=6800 definitions=11713
 signatures=596818
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 phishscore=0 suspectscore=0 clxscore=1015 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602260158

Implement dual-path optimization in attach_kprobe_session():
- Fast path: Use syms[] array for exact function names
  (no kallsyms parsing)
- Slow path: Use pattern matching with kallsyms only for
  wildcards

This avoids expensive kallsyms file parsing (~150ms) when function names
are specified exactly, improving attachment time 50x (~3-5ms).

Error code normalization: The fast path returns ESRCH from kernel's
ftrace_lookup_symbols(), while slow path returns ENOENT from userspace
kallsyms parsing. Convert ESRCH to ENOENT in fast path to maintain API
consistency - both paths now return identical error codes for "symbol
not found".

Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
---
 tools/lib/bpf/libbpf.c | 34 ++++++++++++++++++++++++++++------
 1 file changed, 28 insertions(+), 6 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 0be7017800fe..0ba8aa2c5fd2 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -12042,6 +12042,20 @@ bpf_program__attach_kprobe_multi_opts(const struct bpf_program *prog,
 		return libbpf_err_ptr(-EINVAL);
 
 	if (pattern) {
+		/*
+		 * Exact function name (no wildcards): bypass kallsyms parsing
+		 * and pass the symbol directly to the kernel via syms[] array.
+		 * The kernel's ftrace_lookup_symbols() resolves it efficiently.
+		 */
+		if (!strpbrk(pattern, "*?")) {
+			const char *sym = pattern;
+
+			syms = &sym;
+			cnt = 1;
+			pattern = NULL;
+			goto attach;
+		}
+
 		if (has_available_filter_functions_addrs())
 			err = libbpf_available_kprobes_parse(&res);
 		else
@@ -12060,6 +12074,7 @@ bpf_program__attach_kprobe_multi_opts(const struct bpf_program *prog,
 		cnt = res.cnt;
 	}
 
+attach:
 	retprobe = OPTS_GET(opts, retprobe, false);
 	session  = OPTS_GET(opts, session, false);
 
@@ -12067,7 +12082,6 @@ bpf_program__attach_kprobe_multi_opts(const struct bpf_program *prog,
 		return libbpf_err_ptr(-EINVAL);
 
 	attach_type = session ? BPF_TRACE_KPROBE_SESSION : BPF_TRACE_KPROBE_MULTI;
-
 	lopts.kprobe_multi.syms = syms;
 	lopts.kprobe_multi.addrs = addrs;
 	lopts.kprobe_multi.cookies = cookies;
@@ -12084,6 +12098,14 @@ bpf_program__attach_kprobe_multi_opts(const struct bpf_program *prog,
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
@@ -12192,7 +12214,7 @@ static int attach_kprobe_session(const struct bpf_program *prog, long cookie,
 {
 	LIBBPF_OPTS(bpf_kprobe_multi_opts, opts, .session = true);
 	const char *spec;
-	char *pattern;
+	char *func_name;
 	int n;
 
 	*link = NULL;
@@ -12202,14 +12224,14 @@ static int attach_kprobe_session(const struct bpf_program *prog, long cookie,
 		return 0;
 
 	spec = prog->sec_name + sizeof("kprobe.session/") - 1;
-	n = sscanf(spec, "%m[a-zA-Z0-9_.*?]", &pattern);
+	n = sscanf(spec, "%m[a-zA-Z0-9_.*?]", &func_name);
 	if (n < 1) {
-		pr_warn("kprobe session pattern is invalid: %s\n", spec);
+		pr_warn("kprobe session function name is invalid: %s\n", spec);
 		return -EINVAL;
 	}
 
-	*link = bpf_program__attach_kprobe_multi_opts(prog, pattern, &opts);
-	free(pattern);
+	*link = bpf_program__attach_kprobe_multi_opts(prog, func_name, &opts);
+	free(func_name);
 	return *link ? 0 : -errno;
 }
 
-- 
2.34.1

