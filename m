Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B5B21D3CC;
	Mon,  2 Mar 2026 20:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.148.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772482146; cv=none; b=PyD1NwJRy1QT31SlESRVIpEPxVrpTyH/+dmxeNqOXtUgE4BLL1UaG/5HT4Aelulxq2pS5Kr3ISUqMvh8Hw2CAgEE2DMDjfu9quaLjKsmhjvQWAXFod6+GKvTA0XFscLK0IRXYN5jN5dTH/z+NuSmGt3BoH0l7a1N/2e1HMG7bRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772482146; c=relaxed/simple;
	bh=Phn87xCZRACGNGKI4jdIe6JcPdwO+z+vimi+Ub7XvOA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tknUobOA6UP2xnMQSrVq7NRJaMtYYj4Bl3u2+vlfGYHFbJWwon2+RPaktP45TUt4hgszSQ0GoJBx1DJnjFSUXA3VzG8VEjKKEbQ78r5etNTpDyJgs97PD+9a7x1xCf9jjWQT0gpnyQvE289d+KKBGe/qV9rQlIbUT/UzgoRYdWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=l1449bDe; arc=none smtp.client-ip=148.163.148.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="l1449bDe"
Received: from pps.filterd (m0354650.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 622JgOZJ3867169;
	Mon, 2 Mar 2026 20:08:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=default; bh=f06D1yITg5sVx
	RgtImdcR1EO816D7px6HH8T09ioEbE=; b=l1449bDer4vCEr8S5LRRySXP7Epw/
	AMZm7Qwy+VVKt1nNU5lmpeta7QEBVMuueoRMaW272BK/m6eA8h6DM4P7+w3P8F2w
	4Fy/bV8Scrq8WL8HK444vrVu7JZsUh1RJwsjOLtSPB93r8i6DZq9RCGJ2EgVfKIw
	HifYSYxJXIDoqGoNmVSMV3xA3LOAomNcZcMmrgN1DLMU0WNRJv91hPvjJsLLYIBO
	4F1LO3t7LbbT+RmidEfPbbHJdCi/wLh3i88ALxC+zg7DGxT3pHWfXM+JSvVJAp00
	GlljrvQ+E3pId3p3krqKDuw3CDi0lQrSp0njOKIuY+oS5zR6YZzyaxbIA==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 4cmcu95xr9-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Mar 2026 20:08:39 +0000 (GMT)
Received: from LL-DJCZ134.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 2 Mar 2026 20:08:38 +0000
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
To: <bpf@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>
CC: <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <jolsa@kernel.org>, <rostedt@goodmis.org>,
        <linux-open-source@crowdstrike.com>
Subject: [PATCH bpf-next v4 0/3] Optimize kprobe.session attachment for exact function names
Date: Mon, 2 Mar 2026 15:08:34 -0500
Message-ID: <20260302200837.317907-1-andrey.grodzovsky@crowdstrike.com>
X-Mailer: git-send-email 2.34.1
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDE1NSBTYWx0ZWRfX8J+gWuL0t3N/
 LCI+dIcWpsqad3QVBgN/Lu1kw+xqrzoa90YglHGTZAehLNJxqdn2eYNlTTUHCE2VFT5fCb6yIw8
 DIQOTrh3hKpwtdB2EQJyKGrGtX36kLGhfEN++843dxP8woGJWcepbR5WcNosYzjpfKtA8eAIkIp
 TuDn6iuNfR7lbkkaehkJax86/kNPxkwwTkz4sXAUqa2xYyl8KZbvZy8yRYqr93TLRarBocYPdnn
 Aprcor14+T20XeAqGsLb41O1IthI7V1/luMRvtUzFSUigE6Tnh1PswMnwhKs5O+2Tq8V/ja2Grl
 dFSdnXFr/e9e/3IN9HTY7coK4vjuv7iaq3qWcaqZDi2gBhUG4pIm8ARWXf2xSDScM+nbC9N/Qof
 nstNIqMO8gwkRKKQIcGJ//prgaaxJaMMI6GRq2LkvaozeKwSXNEWNi9AIdboWmh8sFGLwvWfx5g
 asAphllbTzqgvW3E6NQ==
X-Proofpoint-GUID: gBq9rd9lIaKUY565rOSvMrA8H0_n2Iqh
X-Proofpoint-ORIG-GUID: gBq9rd9lIaKUY565rOSvMrA8H0_n2Iqh
X-Authority-Analysis: v=2.4 cv=Nr/cssdJ c=1 sm=1 tr=0 ts=69a5ee48 cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=T2KQ53IYiC3MXPrxx8bB:22 a=t04HzT_fAfAF5W-3wVZy:22 a=VwQbUJbxAAAA:8
 a=pl6vuDidAAAA:8 a=y9PgSqjz0oz1NqTizCwA:9
X-Proofpoint-Virus-Version: vendor=nai engine=6800 definitions=11717
 signatures=596818
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 priorityscore=1501 spamscore=0
 impostorscore=0 suspectscore=0 clxscore=1015 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603020155

When libbpf attaches kprobe.session programs with exact function names
(the common case: SEC("kprobe.session/vfs_read")), the current code path
has two independent performance bottlenecks:

1. Userspace (libbpf): attach_kprobe_session() always parses
/proc/kallsyms to resolve function names, even when the name is exact
(no wildcards).  This takes ~150ms per function.

2. Kernel (ftrace): ftrace_lookup_symbols() does a full O(N) linear scan
over ~200K kernel symbols via kallsyms_on_each_symbol(), decompressing
every symbol name, even when resolving a single symbol (cnt == 1).

This series optimizes both layers:

- Patch 1: libbpf detects exact function names (no wildcards) in
bpf_program__attach_kprobe_multi_opts() and bypasses kallsyms parsing,
passing the symbol directly to the kernel via syms[] array.
ESRCH is normalized to ENOENT for API consistency.

- Patch 2: ftrace_lookup_symbols() uses kallsyms_lookup_name() for
O(log N) binary search when cnt == 1, with fallback to linear scan for
duplicate symbols. Included here for context; this patch is destined
for the tracing tree via linux-trace-kernel (Steven Rostedt).

- Patch 3: Selftests validating exact-name attachment via
kprobe_multi_session.c and error consistency between wildcard and exact
paths in test_attach_api_fails.

Changes since v3 [3]:
- Skip fast path when unique_match is set (Jiri Olsa, CI bot)

Changes since v2 [2]:
- Use if/else-if instead of goto (Jiri Olsa)
- Use syms = &pattern directly (Jiri Olsa)
- Drop unneeded pattern = NULL (Jiri Olsa)
- Revert cosmetic rename in attach_kprobe_session (Jiri Olsa)
- Remove "module symbols" from ftrace comment (CI bot)

Changes since v1 [1]:
- Move optimization into attach_kprobe_multi_opts (Jiri Olsa)
- Use ftrace_location as boolean check only (Jiri Olsa)
- Remove verbose perf rationale from comment (Steven Rostedt)
- Consolidate tests into existing subtests (Jiri Olsa)
- Delete standalone _syms.c and _errors.c files

[1] https://lore.kernel.org/bpf/20260223215113.924599-1-andrey.grodzovsky@crowdstrike.com/
[2] https://lore.kernel.org/bpf/20260226173342.3565919-1-andrey.grodzovsky@crowdstrike.com/
[3] https://lore.kernel.org/bpf/20260227204052.725813-1-andrey.grodzovsky@crowdstrike.com/


Andrey Grodzovsky (3):
  libbpf: Optimize kprobe.session attachment for exact function names
  ftrace: Use kallsyms binary search for single-symbol lookup
  selftests/bpf: add tests for kprobe.session optimization

 kernel/trace/ftrace.c                         | 22 +++++++++++++
 tools/lib/bpf/libbpf.c                        | 19 ++++++++++-
 .../bpf/prog_tests/kprobe_multi_test.c        | 33 +++++++++++++++++--
 .../bpf/progs/kprobe_multi_session.c          | 10 ++++++
 4 files changed, 81 insertions(+), 3 deletions(-)

-- 
2.34.1

