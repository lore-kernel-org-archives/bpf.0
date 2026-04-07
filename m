Received: from mx0b-00206402.pphosted.com (mx0b-00206402.pphosted.com [148.163.152.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73D8379EE8;
	Tue,  7 Apr 2026 20:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.152.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775594394; cv=none; b=OP5dKOyteXVgDxTzDrk1SWs/iSQ0gLZyI3NDXS7ewDGJTLTilLUuU3eDelMVhp7WAUrEdF4rCLyvKkMnxFgmzrVyAoN5u/+vlxK5u5NPM3Ed9LO6ajeC38znFm/CwVYrcLOBGZ9PtlRl55Obf6LZwoEontdusT2DmDyhv4++518=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775594394; c=relaxed/simple;
	bh=VwRZo7soDKnnUdqQXIGSmhrXyo+mypI8e5+I8Dsd2dg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r78viP5Xke29hmrMsoQKSbpqQqlnq69mw+HhGKk/yhOmRQX87RYNF4Vrgup38uRR6VPEHUvMI6Mlk2P0Giq7a7dxOL+wpH51dfKFVd6viH7mldKpaR4WPFVna0gFpd61tbwFbBjkCfV84b9MeonwRhLb0vxrN2sgzv/0IGUeAsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=O7EI4FrH; arc=none smtp.client-ip=148.163.152.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="O7EI4FrH"
Received: from pps.filterd (m0354653.ppops.net [127.0.0.1])
	by mx0b-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 637IwG141878196;
	Tue, 7 Apr 2026 20:39:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=Jsh5cosuruH1i1k5149HIs4QttK0fbTk7QyRBkF84CU=; b=O7EI
	4FrHQhv/Fp03Y3rj9QYvEdnApaljzOq0ss2tQznKfh1/sX53tj9uH9gRmIiPwaBY
	WURPAFj6PJSjSv1z6mNqsalNxsO6boo5ZKJS8Ao7PDBBMB+mbVQ5ctNyECaZhTco
	p37KIyaWmc1id5utYpXqBXHG/CGskaNXkxgjKVz8KrT6i1JUeNMuErCht/7AF0zH
	3/2AjJ2C97kTrVfg5qOwDsO5v68rOyGZi7E3HUSQ6FeDf8KX2/wsSPIlEQAgf49Q
	rWxer6SAffFnAzzDzAQrKc5AX37QUa3LzICOE4g95LGvmx7te0hKeAfbI08tM1Bo
	wJBpqXlHVOLuA7LrNA==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0b-00206402.pphosted.com (PPS) with ESMTPS id 4dcmqjd941-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Apr 2026 20:39:16 +0000 (GMT)
Received: from LL-DJCZ134.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 7 Apr 2026 20:39:14 +0000
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
To: <bpf@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>
CC: <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <jolsa@kernel.org>, <rostedt@goodmis.org>, <mhiramat@kernel.org>,
        <ihor.solodrai@linux.dev>, <emil@etsalapatis.com>,
        <linux-open-source@crowdstrike.com>
Subject: [PATCH bpf-next v7 1/2] tracing: Prefer vmlinux symbols over module symbols for unqualified kprobes
Date: Tue, 7 Apr 2026 16:39:11 -0400
Message-ID: <20260407203912.1787502-2-andrey.grodzovsky@crowdstrike.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260407203912.1787502-1-andrey.grodzovsky@crowdstrike.com>
References: <20260407203912.1787502-1-andrey.grodzovsky@crowdstrike.com>
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
X-Proofpoint-ORIG-GUID: GjYfEwXcPEwfK0SRBp1UUyXN5j5M9KWq
X-Proofpoint-GUID: GjYfEwXcPEwfK0SRBp1UUyXN5j5M9KWq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDE4OCBTYWx0ZWRfX8fE6QFuw1Hnm
 /OzSP4XPLq/+WibDKwlVYiwCEdBxeE/4981QGfZpPlW/NVmzItoLXnlsPq6yWEso4LJpU3B7lws
 7+OCUOFWI1Hr1xhu9Yr+nw7qkfbqWfPQ5do1BSqCRBo0Dnf3MNIECIsaJKtEsvS0Ck1UI4TAoh/
 jn6WQW8iqtv3mgORBLYDqa/Tq4JLe5EcsxPFi4RajnBVJ2xHdR9GnSfxqtrS8lA1X/OTdy5zkRk
 JI94DAFeNE/fjKNk8yrn1TbHXfyQRyJ3Euqg45rAXFk/3rUG/kwBjOGtUrQJiUd6nwLj8DQYxW0
 CQ1tQ+xOjOkPBVYkXvCrzn+wiTEXYWNsKR91eZzW+GbEPwOTleOLVTac+WIe9YoAlpAnYfYf8T6
 E72AFzcE3gjMOWFux2a07dFVZZPLBq258ooieQERfxYaobINXpK6BgtiSgqldW6tSagx9Q1m6EJ
 /5FqAzT2ZE/tj6hBtNw==
X-Authority-Analysis: v=2.4 cv=bJsm5v+Z c=1 sm=1 tr=0 ts=69d56b74 cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=T2KQ53IYiC3MXPrxx8bB:22 a=GCXdLZfFv8EKBZhKOxZ5:22 a=VwQbUJbxAAAA:8
 a=pl6vuDidAAAA:8 a=jCOrflvdyq85uYTjvtcA:9
X-Proofpoint-Virus-Version: vendor=nai engine=6800 definitions=11752
 signatures=596818
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 suspectscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070188

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
Acked-by: Ihor Solodrai <ihor.solodrai@linux.dev>
Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
---
 kernel/trace/trace_kprobe.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index a5dbb72528e0..058724c41c46 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -765,6 +765,14 @@ static unsigned int number_of_same_symbols(const char *mod, const char *func_nam
 	if (!mod)
 		kallsyms_on_each_match_symbol(count_symbols, func_name, &ctx.count);
 
+	/*
+	 * If the symbol is found in vmlinux, use vmlinux resolution only.
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

