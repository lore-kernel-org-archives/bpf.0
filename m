Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C173793C5;
	Mon, 23 Feb 2026 21:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.148.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771883494; cv=none; b=GPtIc1VsvysABqQt21yzIsQV8UsEwKidjEE0hTnGBxMQY4R04lOGgoTuI35iCsh8DB91heoUXyQAlHi1ZzlS8SosKuzMqkw82pU4z8jV0qL6Gi4AWKwXAtm4Jpaw65V7hGd035gHQ99Q51R3fZhRmD9QDFIzo9kbtzYYmd3vNtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771883494; c=relaxed/simple;
	bh=UYcCfuYZ9F5An6+l4ig5wzMjaGB40+cmzdAGOB24PUg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YApPPrerrx2FZAa8kE1khXmohV9sFVein8u+Bd9HMQZc4aMlrFOUjGApkA1IJdFTV8ge5sTsdHYN912EyIrBSRugi4L324XEX1nblvve0NHdBzhPpT1oEs4U1rqwBMjaRTgOr1wcKrdHp3lcKkcC2ugX++SmBAyNyPX78VQtPHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=hop4D8fM; arc=none smtp.client-ip=148.163.148.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="hop4D8fM"
Received: from pps.filterd (m0354652.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61NJPeNh912064;
	Mon, 23 Feb 2026 21:51:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=3p/VG0N1wMUI72pZfR8CakSWGL7YQpI0gmXIpCx81co=; b=hop4
	D8fMffDQ+EDiMVdlkfeaOPkL3Diik7L0KnGcLhZgoXz90bDq8hOFpKK8j+KHgn+U
	dAtgzojgcdCFU0wN8wdbuusOqybcOwiFNsP7gKCtnvadbulVJQFhHuDOWaG8PVcT
	Au7hl6RiWFfVcRJmQoPzSeFbaID0Fs0sei2GjUnQUJKn8cXZi5+/p3PRyh2H7p0w
	UYO1TXsxQQnZuDpEbEFj4PABEB/KOOWwPUwCKFKc25+msPn0IG8x+tuH0oVRXGjB
	inTziiToFXKdQvCF+ApUNAqib3c4yNXIquDUqDYsXGmN4uxDznJVItUJ6qY/3eu8
	Z2PFfK0GWzsToiwbGg==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 4cftgxes3a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Feb 2026 21:51:17 +0000 (GMT)
Received: from LL-DJCZ134.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 23 Feb 2026 21:51:15 +0000
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
To: <bpf@vger.kernel.org>
CC: <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <jolsa@kernel.org>, <rostedt@goodmis.org>,
        <linux-trace-kernel@vger.kernel.org>,
        <linux-open-source@crowdstrike.com>
Subject: [RFC PATCH bpf-next 1/3] libbpf: Optimize kprobe.session attachment for exact function names
Date: Mon, 23 Feb 2026 16:51:11 -0500
Message-ID: <20260223215113.924599-2-andrey.grodzovsky@crowdstrike.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDE5MCBTYWx0ZWRfX0AMUoKArV67E
 X0gkD1McIEwa8pQvgjqxudNZDgwzi6oGL+8YmPWKneTmp3S8CLRXvHE/dlkQlVaS0PkaE5Tp7Td
 2b0LaGSa0/b0xLzESUN3fojc1d2gu99vlmMKwXZiNJIuEXLA42cgKmUP3k6Q4VJEoIPVemHArJd
 VXmPzlELMfCOHIPHaLTFg9f7L3H4VLm+rd0C4AqqVT6fibiAqwO5U0B9PNNcmIO8M7jaYkUHWCn
 HhK9W5wURDuvKYxn+pgWLo69jRf8jhlXlEdGFhEDgA8CObaPYVyfkBoI4rEx2wFjykPYN2dCzpk
 NMpFKPJVqanknxhsJDwNsFFvnbWokBQ03krcELE5i6DiR28VZ8kI2FYi0Cs42ugbcSSEZXFFeNN
 PEtpj6AxYkOBZkdzPNp6q+aoSCmoVkxGQtg3phYB+vO1tTX0ug7OVh33GiB3SVGXlT/NztVMT9s
 pJOsFdaSN/WxQ3zzi7Q==
X-Proofpoint-ORIG-GUID: c3rAOwesil5GBMXHVgEEHuj5d5C2FU5H
X-Authority-Analysis: v=2.4 cv=S+XUAYsP c=1 sm=1 tr=0 ts=699ccbd5 cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=T2KQ53IYiC3MXPrxx8bB:22 a=2KvRFfd_T_-xjmS8C1aD:22 a=pl6vuDidAAAA:8
 a=QKgh8SY86NO7HFkBrzMA:9
X-Proofpoint-GUID: c3rAOwesil5GBMXHVgEEHuj5d5C2FU5H
X-Proofpoint-Virus-Version: vendor=nai engine=6800 definitions=11710
 signatures=596818
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 bulkscore=0 suspectscore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2602230190

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
 tools/lib/bpf/libbpf.c | 32 +++++++++++++++++++++++++++-----
 1 file changed, 27 insertions(+), 5 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 0be7017800fe..87a71eab4308 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -12192,7 +12192,7 @@ static int attach_kprobe_session(const struct bpf_program *prog, long cookie,
 {
 	LIBBPF_OPTS(bpf_kprobe_multi_opts, opts, .session = true);
 	const char *spec;
-	char *pattern;
+	char *func_name;
 	int n;
 
 	*link = NULL;
@@ -12202,14 +12202,36 @@ static int attach_kprobe_session(const struct bpf_program *prog, long cookie,
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
+	/* Check if pattern contains wildcards */
+	if (strpbrk(func_name, "*?")) {
+		/* Wildcard pattern - use pattern matching path with kallsyms parsing */
+		*link = bpf_program__attach_kprobe_multi_opts(prog, func_name, &opts);
+	} else {
+		/* Exact function name - use syms array path (fast, no kallsyms parsing) */
+		const char *syms[1];
+
+		syms[0] = func_name;
+		opts.syms = syms;
+		opts.cnt = 1;
+		*link = bpf_program__attach_kprobe_multi_opts(prog, NULL, &opts);
+		if (!*link && errno == ESRCH) {
+			/*
+			 * Normalize error code for API consistency: fast path returns ESRCH
+			 * from kernel's ftrace_lookup_symbols(), while slow path returns ENOENT
+			 * from userspace kallsyms parsing. Convert ESRCH to ENOENT so both paths
+			 * return the same error for "symbol not found".
+			 */
+			errno = ENOENT;
+		}
+	}
+
+	free(func_name);
 	return *link ? 0 : -errno;
 }
 
-- 
2.34.1

