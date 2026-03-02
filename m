Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6B030DD1B;
	Mon,  2 Mar 2026 20:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.148.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772482163; cv=none; b=UK14Y2QSZpCHyjOO2yRZNEhW/Y9WgqB3i7Y/Uebnhfz8ft+BlrNxmw+D/rdIbx3THpaJO4lugbFoNvVEh/lUUkDxpOwoUiYYH8U8bQXJ+PtcnAxsR5Sn4y3Fl/mjWDHB3RKwbN+4x8A+1KwQVuf9JjmnEW/9X3LOCffcrny0tW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772482163; c=relaxed/simple;
	bh=mnOmN3ksr0eINg6+BkRedgoTyM0+rJpFzyqPlSJLSPc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s9fA/1Nql3pyiK7ZW/zm1ISAlUAWgw3NEP9Bd/E7EvqDkWDF1w2qKkpW1a1ENYQg+rXZHRszcVE1JC91tY/znCBX/WL/zMO36caPg2ywEZMwCZRT77uPmEpqKkRqxo5pLRNBtSzZCI2totidII+fpc39iQodGMli2CjboL1yshc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=aCC5no0n; arc=none smtp.client-ip=148.163.148.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="aCC5no0n"
Received: from pps.filterd (m0354650.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 622JgOZL3867169;
	Mon, 2 Mar 2026 20:08:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=mAzjvIUM87VnhoblX9RBNH0pu68ZDgIXq+PJP44Vz3A=; b=aCC5
	no0n2E6sjv9PYXQjSFPcchDFLrb4gpF9LRsTwsld02OwvS2U6csG0XgrLICF/1Nh
	nQiyIX/scFYtra50LeDuuAn2NlVprsQu3rNoyb7nEXvli33Dj+fiRlIMR7FNxyz9
	fTXESs94eDFHWz5N+DJoKLep7MVtRYkH304AIoOjsbKU0+ck08TedWtgAmT7awOG
	HnOS1tbUShphAKn7N9mXO36RB6Ye5g2EVFXSXMPGNLgTLypeehbl5gDK59QJe8LM
	CbWW3nlACiizIbZechODKdzGqrnVPzmRLFk8R7xALmL/bjkjjet6JVJ60kQ9nP4f
	VPiLxmfnc2ObBs89jQ==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 4cmcu95xr9-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Mar 2026 20:08:41 +0000 (GMT)
Received: from LL-DJCZ134.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 2 Mar 2026 20:08:39 +0000
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
To: <bpf@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>
CC: <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <jolsa@kernel.org>, <rostedt@goodmis.org>,
        <linux-open-source@crowdstrike.com>
Subject: [PATCH bpf-next v4 1/3] libbpf: Optimize kprobe.session attachment for exact function names
Date: Mon, 2 Mar 2026 15:08:35 -0500
Message-ID: <20260302200837.317907-2-andrey.grodzovsky@crowdstrike.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDE1NSBTYWx0ZWRfX/+gKHEqtrDyq
 NsaRWNvSOyikqhKcQvMnnm4lgT/enC1nd53RgZu6yOLTZ/7pRUKntxLlHOY/hI/8XOB3SOKMN1I
 Ueg8VFDKdY1aXQTfO5wXBtw0JuqiUOWz9FdUvQg2OYXmEKMO4tbsd70cW/a+inaEgrYxRcKOfwT
 T9L0V1xDdAX8gbTSIHqWpyGzxSgl590SAvCTp/QWibuqR0zkOhpvzST2EC2C48SJhNHF1Xb2sec
 yvVKyVCyPLLBsFMnHl/nBbaCE3QpWZeAhq7tMTbSBk8+rqREQC0bDBMg+75E0YUl4ZllNSI6YTA
 tbWG/nB8T7zT2eHXq+uO2qyb2tQ8ThWuSo3Wdm3UAea82KAD6pfQkJwvCUuQTuSaMHtubNe7l42
 Ay9yvkAB3GSdFTBx39nX0wNc0Q3YXpWJbMufXbmb36L/BxfomkjVlS0nC2Yoxey1hYb7ePNB1xf
 iyEHus246YErGud6tBQ==
X-Proofpoint-GUID: eqzJmpVke77K3PmsGmoHPU1uy7mmn6sT
X-Proofpoint-ORIG-GUID: eqzJmpVke77K3PmsGmoHPU1uy7mmn6sT
X-Authority-Analysis: v=2.4 cv=Nr/cssdJ c=1 sm=1 tr=0 ts=69a5ee49 cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=T2KQ53IYiC3MXPrxx8bB:22 a=t04HzT_fAfAF5W-3wVZy:22 a=pl6vuDidAAAA:8
 a=VpqhlCfQX1L-8fIZS4AA:9
X-Proofpoint-Virus-Version: vendor=nai engine=6800 definitions=11717
 signatures=596818
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 priorityscore=1501 spamscore=0
 impostorscore=0 suspectscore=0 clxscore=1015 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603020155

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
 tools/lib/bpf/libbpf.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 0be7017800fe..0662d72bad20 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -12041,7 +12041,16 @@ bpf_program__attach_kprobe_multi_opts(const struct bpf_program *prog,
 	if (addrs && syms)
 		return libbpf_err_ptr(-EINVAL);
 
-	if (pattern) {
+	/*
+	 * Exact function name (no wildcards) without unique_match:
+	 * bypass kallsyms parsing and pass the symbol directly to the
+	 * kernel via syms[] array.  When unique_match is set, fall
+	 * through to the slow path which detects duplicate symbols.
+	 */
+	if (pattern && !strpbrk(pattern, "*?") && !unique_match) {
+		syms = &pattern;
+		cnt = 1;
+	} else if (pattern) {
 		if (has_available_filter_functions_addrs())
 			err = libbpf_available_kprobes_parse(&res);
 		else
@@ -12084,6 +12093,14 @@ bpf_program__attach_kprobe_multi_opts(const struct bpf_program *prog,
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

