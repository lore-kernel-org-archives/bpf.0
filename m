Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9DD386435;
	Mon,  6 Apr 2026 19:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.148.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775503970; cv=none; b=pkpQ46Srajo3TntWdjLdcrW5y0ZZi++2tsdF9uKRnaxt+ZBx4Z8h9t/UYpxGYUXq5QEPdu3YisQ+sB/z1QdPfjDbNpXcK9+1hvtF5eUnliOVrVjtPZOGpSx3CLXOXMCaBqjdOfOtef6UXQ4WnSwSzcBwy01Q3oMcfXwlu+u2NnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775503970; c=relaxed/simple;
	bh=Q0iOn83kb6WuyFAKgiG8q8u/oQDJ8OLbWJCbX2fBcQE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LiTqkq0ib9469lsLXczYeGmCh5SdyI0mPTzRi1qeO5KkZM897pjeD6gE5rDBOpK6k13j01VD3NRNemQ18BfU1IuqZ24NEfFQw3NyOvIuV9Jukw+ClpYy3cRUKWfcG7PypBxt36Zq+T+2/Vd+yr3Uiw8KTBevPhmtdlvmYxlNs4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=oqpLgvkf; arc=none smtp.client-ip=148.163.148.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="oqpLgvkf"
Received: from pps.filterd (m0354651.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 636J6fnB2547818;
	Mon, 6 Apr 2026 19:32:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=wsKRLkEznnB/w2MoZrarUdUTZMeWmP4JjJlK9bG1EjA=; b=oqpL
	gvkfOfoF6Wc2b4O8PZBK3G1gpLqvKmq6xvbk0WEOxOS3JoV5bjwSUZaVRX+4ILeH
	2LA388B1mc+hkyEMqayB6WAQePQT60PxWURtSO8Z//eZhFp/mOk04RXlhsmA2Y2N
	vTi6Qa0icQtVZlo2QaTUu5CHNGXBl+vbrNrnZ78v2nW3SjyN3DfQu6sF1Uzx+u0n
	wiDusyNDucCW3OJz/4cHAUY7ZeiR8DRhF7u4CLS95TvudgMVrVSMVYA4q7F6obch
	/9SlUfUX14AlbXXhzjUgt26K70TfDJRM+nH0FXEsQ7eU5QP44mbFHmF5rsvPihBw
	TF6+FJyOl0FsjJzSeA==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 4dbdvxqy86-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Apr 2026 19:32:01 +0000 (GMT)
Received: from LL-DJCZ134.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 6 Apr 2026 19:32:00 +0000
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
To: <bpf@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>
CC: <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <jolsa@kernel.org>, <rostedt@goodmis.org>, <mhiramat@kernel.org>,
        <ihor.solodrai@linux.dev>, <emil@etsalapatis.com>,
        <linux-open-source@crowdstrike.com>
Subject: [RFC PATCH bpf-next v5 1/2] tracing: Prefer vmlinux symbols over module symbols for unqualified kprobes
Date: Mon, 6 Apr 2026 15:31:57 -0400
Message-ID: <20260406193158.754498-2-andrey.grodzovsky@crowdstrike.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260406193158.754498-1-andrey.grodzovsky@crowdstrike.com>
References: <20260406193158.754498-1-andrey.grodzovsky@crowdstrike.com>
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
X-Authority-Analysis: v=2.4 cv=fNQ0HJae c=1 sm=1 tr=0 ts=69d40a31 cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=T2KQ53IYiC3MXPrxx8bB:22 a=b3B37AjAgz0HnGB3MuNd:22 a=pl6vuDidAAAA:8
 a=jCOrflvdyq85uYTjvtcA:9
X-Proofpoint-GUID: f7_it3mHg12X3oxBNPceiN8l2N6U67SS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA2MDE5MSBTYWx0ZWRfXy4gWTlyziNIy
 W3UZ1NYccHKbiTuUYYWETa+r6uFRzRj195bUJ5rbXZLzAfXze/9++DxSjRgPQNt7uYeV0uIh10s
 4jJuZbs6HFxZQEkUTSo0Q9jBjAEjifuJfBuMoOcdCkd7t4boY3Qf/hoWVhhzfXWQYyX3W6i2fHh
 0D+6/N53Yx9i4AleC7JO+sRCbPCjbkILAMUC3qcNsxWNUJNzkEXwmt1QorIPzYUV2CMBJSs6Vnm
 jc6tHblufA+EBj3QwWe4Q3zIBokiGJu3W3ggD+ofFMPYYH3khVcULo1pFIYUfyb2wMCWcjt3ZMe
 MCh59zJPs6CtMebKrViOgG1v2kqBKZGWHevWwuY315lbJVSYIMPcs0HZnUMLg36+Q7GGlVd+ugA
 /OdWdJjUTBPIstuMPI2acYEU7mDkhr+ygLlY864+pAitTq4c0n0ysmY+ataldtqEyARTIegrmvB
 pPIXH3PH6UXnbBP7LUQ==
X-Proofpoint-ORIG-GUID: f7_it3mHg12X3oxBNPceiN8l2N6U67SS
X-Proofpoint-Virus-Version: vendor=nai engine=6800 definitions=11751
 signatures=596818
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 bulkscore=0
 malwarescore=0 phishscore=0 priorityscore=1501 clxscore=1011 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604060191

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

Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Suggested-by: Ihor Solodrai <ihor.solodrai@linux.dev>
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

