Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7E93E8C60;
	Fri, 27 Feb 2026 20:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.148.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772224882; cv=none; b=Kp/2u9A6nKYSuJA3HFDk9mJQsia46YZ+pZr3P3RXPv/5zm2bLglYjOPoD3t7U1rCTiR85sxsc/u82l0PzUZqMv0NR2LrFB1R6bIyrixTkFu+h4HBwulaqB/d5OiizKWLqNK0aYt6Jh4Fzxb1zlvbG/vdvWB3PzI0U/N2fpg/NMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772224882; c=relaxed/simple;
	bh=je1e1JHekRftvINgGxkcVSHNbzrt6xqb41qoxei03MI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RFpeH7JqrC6AEI5Mm5KTixhlqphuBDeCdCN4UoXGeLAyxX9TO4jopTCZ3SWEYw0ohJZ6K/SvDCSFX9OsRmJ0VKTjIpQUTofd/u9Bv8vdiiMOhpChYGSG3iZodDNNQl9uMjTMM0shkyeHgiQwj0v0fWWlr9Y8S9kdjLt4MzPJM8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=IAWa4twi; arc=none smtp.client-ip=148.163.148.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="IAWa4twi"
Received: from pps.filterd (m0354651.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61RK1L0M4076662;
	Fri, 27 Feb 2026 20:40:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=default; bh=2lRsnku0c6d7q
	pA4mCEd2/yhfFEd6M2jupSXrJGBGmw=; b=IAWa4twihGXfRA0mndkGA4Es3zTik
	153NjNhkD151+ZBTkufSDgJMYwZIDZpTidJPxqaLAPffOyRwYW7VzcCRDsD5TKMO
	SbuHk5K2yMK5PkTt2Lnl3JG/kem9c8DYMPFEgZKVn7YxygPDSOuDipQEXzVTR2aw
	BNUZZkDGU44w6fOwXkqx4VVJHqnwfLpWzucS5Puu9QhL4jY2PHyrVDcjPpYRTR8X
	Fl+hdX+KusF245hSqW/VZsnDBE8KaZkjKObz5NhTxZuG+KIx3NRXkutoMTX2SFv2
	lazckZ74Bw/AEAPratJ97XA5HZYX7WRqXB+L5gJHZHn3kS+4N4+HfFC3Q==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 4ck5gvaudq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Feb 2026 20:40:54 +0000 (GMT)
Received: from LL-DJCZ134.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 27 Feb 2026 20:40:53 +0000
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
To: <bpf@vger.kernel.org>, <linux-open-source@crowdstrike.com>
CC: <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <jolsa@kernel.org>, <rostedt@goodmis.org>,
        <linux-trace-kernel@vger.kernel.org>
Subject: [RFC PATCH bpf-next v3 0/3] Optimize kprobe.session attachment for exact function names
Date: Fri, 27 Feb 2026 15:40:49 -0500
Message-ID: <20260227204052.725813-1-andrey.grodzovsky@crowdstrike.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: 04WPEXCH016.crowdstrike.sys (10.100.11.68) To
 04WPEXCH006.crowdstrike.sys (10.100.11.70)
X-Disclaimer: USA
X-Authority-Analysis: v=2.4 cv=Scz6t/Ru c=1 sm=1 tr=0 ts=69a20157 cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=T2KQ53IYiC3MXPrxx8bB:22 a=b3B37AjAgz0HnGB3MuNd:22 a=VwQbUJbxAAAA:8
 a=pl6vuDidAAAA:8 a=y9PgSqjz0oz1NqTizCwA:9
X-Proofpoint-GUID: Ea6PSEzaGLBERccVYBV4tzHmrrIZ22q4
X-Proofpoint-ORIG-GUID: Ea6PSEzaGLBERccVYBV4tzHmrrIZ22q4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDE4MiBTYWx0ZWRfX6wxBSh8EuO46
 ssW7Uf6icr7QycC1wAOT63DMoJvMT8JnO9OMg9mfm1dm1MTEplEyH+0aVbEcCdO+zND36rmPvYE
 fw6WrV7nZpp2ThkMZqZSH2yVp8+F7yCJGZuCHSGM5sdEl4vSVyegjksY1K9HchGPIPSH0Ca5NqG
 9yUlQOzcfjwxYixlrJR7VXO+KWI2I1XPAPKvp7wtbiWkiKW12UzmYgfEh+n92RjkzBVMU8K2J/U
 UfHHdpHQvrRcah0Wz2i81CkJQuug2MQ1wDjUeCRBwo2p8MCTl3yF4/7/IOE2gAH5qEUUruIlbTz
 MaKuRv+BwMC9OTWwYWbbUmTeUNETthvhBG7Agq2zHyW4wbHoV4bY37d1iVD4OsuO/vlDcf/IKdo
 BWJUtep/HwnOdzTkMIm1TsCPdR8MNfxWic4T8z3hie5kUNcuprESI3oWrPgDlrDvWAIjXfBtJ9e
 PXL1hSxNCEQaqbyWvGw==
X-Proofpoint-Virus-Version: vendor=nai engine=6800 definitions=11714
 signatures=596818
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 spamscore=0 phishscore=0 lowpriorityscore=0
 bulkscore=0 adultscore=0 impostorscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602270182

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

Andrey Grodzovsky (3):
  libbpf: Optimize kprobe.session attachment for exact function names
  ftrace: Use kallsyms binary search for single-symbol lookup
  selftests/bpf: add tests for kprobe.session optimization

 kernel/trace/ftrace.c                         | 22 +++++++++++++
 tools/lib/bpf/libbpf.c                        | 18 +++++++++-
 .../bpf/prog_tests/kprobe_multi_test.c        | 33 +++++++++++++++++--
 .../bpf/progs/kprobe_multi_session.c          | 10 ++++++
 4 files changed, 80 insertions(+), 3 deletions(-)

-- 
2.34.1

