Received: from mx0b-00206402.pphosted.com (mx0b-00206402.pphosted.com [148.163.152.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224683126AD;
	Tue,  7 Apr 2026 16:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.152.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775580734; cv=none; b=HExPNqsXPwZE5AsjBfMOKjBMX9JtlMbSAEaIvUeL8CBD1AyjC1YGa/l3I64ddgTi39CVcfDtld33ngUcrlMZvAyu1cUPB1K1VgOF1ssi9FcFnGQNJd96EqdDKCG3Oh4mbc5+60AIlp2MDst9OWMYtexKnwcFQ6j4+rbN2Pu+zqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775580734; c=relaxed/simple;
	bh=IhomNVymAjLzk9OUOAXORucV8MsYd4uXVlPdSvBiseM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iqkpfCbiVKxNQ4TFm6+mHmwSHCSCky/BwxmXywhU/VonUV6bMUl0xedCQn1Fxfd7V37LU64fLsG6LE3L06aBfoTcYG0Rtp1Iokc7lqqhXNCF37UM+nTRhUVzsywjQKqqpFTYwDzntx8rzhOwtdokxH+CWBnmXFhWGGU+PdLSTUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=fhWiYaEC; arc=none smtp.client-ip=148.163.152.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="fhWiYaEC"
Received: from pps.filterd (m0354655.ppops.net [127.0.0.1])
	by mx0b-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 637FdiK71670846;
	Tue, 7 Apr 2026 16:51:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=CVfnpeWzQMMv3tHyOjqh65HDhTB9Lc6baJyBmK9G+0g=; b=fhWi
	YaEC7KTMO/Eih+PyGSfXyVaAYuJ0BhKq4L12EXqc34G38SqY+6oUBINc5dcecDSD
	QXhEcLwEFFAn5hbXsazcDs2QBlrdpK+9HYHQ5vf6MP/Zxw8nnUJvsWZfNTtFGdNI
	FXgdMbZDVrcBQjX4fG98lQIWveF6DWpEzfHQYj1iVflDCa25kQ/e9b25lk+SSqqV
	KIK5cp1ze6vAWoFfp3xArC1gumfvaR6Zz5niNLXHkVG+66nTU9Pe3R7baAbWOMWp
	JcjnHQpb6ijwAGouq5DUzuj8Gu7yaxl4ui/KENNliY+jMnIdimBl0Nut7TAMvsTn
	uJLMppaLMdZN61xVBQ==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0b-00206402.pphosted.com (PPS) with ESMTPS id 4dcmqjm7td-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Apr 2026 16:51:49 +0000 (GMT)
Received: from LL-DJCZ134.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 7 Apr 2026 16:51:47 +0000
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
To: <bpf@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
        <jolsa@kernel.org>, <ihor.solodrai@linux.dev>
CC: <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <rostedt@goodmis.org>, <mhiramat@kernel.org>, <emil@etsalapatis.com>,
        <linux-open-source@crowdstrike.com>
Subject: [PATCH bpf-next v6 1/2] tracing: Prefer vmlinux symbols over module symbols for unqualified kprobes
Date: Tue, 7 Apr 2026 12:51:44 -0400
Message-ID: <20260407165145.1651061-2-andrey.grodzovsky@crowdstrike.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260407165145.1651061-1-andrey.grodzovsky@crowdstrike.com>
References: <20260407165145.1651061-1-andrey.grodzovsky@crowdstrike.com>
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
X-Proofpoint-GUID: QSMZdWgtmRg--iUbcUbwLlOb5NP20cks
X-Proofpoint-ORIG-GUID: QSMZdWgtmRg--iUbcUbwLlOb5NP20cks
X-Authority-Analysis: v=2.4 cv=HJfz0Itv c=1 sm=1 tr=0 ts=69d53625 cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=T2KQ53IYiC3MXPrxx8bB:22 a=vDKVRhTs-M86Ea50iKLw:22 a=VwQbUJbxAAAA:8
 a=pl6vuDidAAAA:8 a=jCOrflvdyq85uYTjvtcA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDE1MCBTYWx0ZWRfX5GdnrcRMicTd
 sqiW40kr1WHuR2fytgUmpYJBio+BQ6eNJo7futeuqF+b762sreVDtocZ9L5ffqGGefzXJa+KFfb
 BT7ooUw4tvPgFWDb9kMc/p3ZfjBoVBMufSPuTKbKmde8ZwC1Ppciw53xTVEtsfSqO7bkym5m0ur
 TV0b5eeMLX72Zs2r3oTD1Vha2WHyiLVrTGnv9c7HHqXCmsmzYly39qrPURDzhFHlTxQrwwFS7uf
 +Xc140BgpMBY6vABHU5qPvf1CucaaqOhN48ddYGGHu8REREINsTHEHWc3634GhGKnJ6VEnn1IwP
 qyi88FWr+UwChgVNPKL/HJeCbNkUUMCoWH4sbaeRro2AmW5IJaBdM9eO/b3L4v/0jtRPmtlf2za
 xQg289nr9PicsIZXleIaBJtf2gUuTrXqrlbTUAl2A9st+lrkg5E/En+bwd1rh0CGRPjcXi7bTGF
 oUfL/iemrEvUFtBJgLg==
X-Proofpoint-Virus-Version: vendor=nai engine=6800 definitions=11752
 signatures=596818
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070150

When an unqualified kprobe target exists in both vmlinux and a loaded
module, number_of_same_symbols() returns a count greater than 1,
causing kprobe attachment to fail with -EADDRNOTAVAIL even though the
vmlinux symbol is unambiguous.

When no module qualifier is given and the symbol is found in vmlinux,
return the vmlinux-only count without scanning loaded modules. This
preserves the existing behavior for all other cases:
- Symbol only in a module: vmlinux count is 0, falls through to module
  scan as before.
- Symbol qualified with MOD:SYM: mod != NULL, unchanged path.
- Symbol ambiguous within vmlinux itself: count > 1 is returned as-is.

Fixes: 926fe783c8a6 ("tracing/kprobes: Fix symbol counting logic by looking at modules as well")
Fixes: 9d8616034f16 ("tracing/kprobes: Add symbol counting check when module loads")
Suggested-by: Ihor Solodrai <ihor.solodrai@linux.dev>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
---
 kernel/trace/trace_kprobe.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index a5dbb72528e0..99c41ea8b6d7 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -765,6 +765,13 @@ static unsigned int number_of_same_symbols(const char *mod, const char *func_nam
 	if (!mod)
 		kallsyms_on_each_match_symbol(count_symbols, func_name, &ctx.count);
 
+	/* If the symbol is found in vmlinux, use vmlinux resolution only.
+	 * This prevents module symbols from shadowing vmlinux symbols
+	 * and causing -EADDRNOTAVAIL for unqualified kprobe targets.
+	 */
+	if (!mod && ctx.count > 0)
+		return ctx.count;
+
 	module_kallsyms_on_each_symbol(mod, count_mod_symbols, &ctx);
 
 	return ctx.count;
-- 
2.34.1

