Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F8C3290D0;
	Thu, 26 Feb 2026 17:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.148.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772127241; cv=none; b=EueA3ISYOTYD0xKR8ePZMs+njav+8gUkEbrfRKeT6wmFFB27wvqiuck66RlHpPp1nfYjVP4LimvdtmtPQAHf19l0k3COEKrb/jWJgaQ6+P6xDXFHL6kbr0Wb1lCbtu8FUJANyzEAACOlYsCbEebiRVeeO/RLVkFysI6KaO0gYi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772127241; c=relaxed/simple;
	bh=dwcYsrKjVJKGML369lTV9uXUPzQOzZKh6nUitGboBwE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qB80QGp62KTV/35tcOnj0AAHaIcoL3ayZkVMia4zyy/Z1ORWll9RlMzhPCa2TpU9v3uZi/mMa5ZraaegZikT98VyDCLGXjldU3+8LfndJLe2yvYlftAJDtsoZD6N2I9kZLRMlN6k7J8wVRbNd1uGa46giN6xwjH0uaFQ0FlbMtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=Ptp4Bguu; arc=none smtp.client-ip=148.163.148.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="Ptp4Bguu"
Received: from pps.filterd (m0354650.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61QH1Xwx1526879;
	Thu, 26 Feb 2026 17:33:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=default; bh=By05z4h3FP3sv
	fuG9M8zZDefK2hesnEvkbkIgm0slCc=; b=Ptp4BguuLlAGm40Msn5WZ6sBpM1Xm
	Gt91YA4DEkj/ciAwsAd017P1hJsQZC11so7cu4e5T0xZ01oP6paJJnuWajxEFntJ
	lTY2CIR5H1G6wvOa+Q8KGAIqHrOS44/ecw5aX4PC3A27C3hvzt0S5u3Zi2y5mzY2
	alUQqDq0BVTBqzlzG3o3TkAsq84U7XiRBjApp7Bh5vKFcGRZoCW4P+lXbdgT86hV
	I6O59oZw1zDv7SnKEAggo/MZ8IYb6y5Lb/FWQ6MqJUbdQYtEpAjafT8Mfa61b0WQ
	06Y21c5vdAf1Px49A/AVCEAWbxP3j52I5HrfafTzRH1qq5XEKqqyE+QJw==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 4chjkkh1q9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Feb 2026 17:33:44 +0000 (GMT)
Received: from LL-DJCZ134.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 26 Feb 2026 17:33:43 +0000
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
To: <bpf@vger.kernel.org>, <linux-open-source@crowdstrike.com>
CC: <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <jolsa@kernel.org>, <rostedt@goodmis.org>,
        <linux-trace-kernel@vger.kernel.org>
Subject: [RFC PATCH bpf-next v2 0/3] Optimize kprobe.session attachment for exact function names
Date: Thu, 26 Feb 2026 12:33:39 -0500
Message-ID: <20260226173342.3565919-1-andrey.grodzovsky@crowdstrike.com>
X-Mailer: git-send-email 2.34.1
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
X-Authority-Analysis: v=2.4 cv=dYaNHHXe c=1 sm=1 tr=0 ts=69a083f8 cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=T2KQ53IYiC3MXPrxx8bB:22 a=t04HzT_fAfAF5W-3wVZy:22 a=VwQbUJbxAAAA:8
 a=pl6vuDidAAAA:8 a=I6yEX1Q7nsou2vuoaIAA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI2MDE1OCBTYWx0ZWRfX2gBy+XgnhGDy
 Ya1WdNyRVhfaOeF7AP1C8balxdC9Ubxl4S9IcFsh0vk4mbzONKzh6+6Gi3FqQFInmht7DoymWVT
 rzuuL01lTRGsL3H9CFTf7N+vy8KnYmO8w6LTeJTKE0xaKNVTlAAe58OXalpvnQx9DbCddRM1aj7
 UOIghkxKTwmDdxify/y0madUUi6idG0hZR/qxFebLT8fJtRIeFv+Eug8a0jExyTNNL13sbhr8p8
 O5UNDrR+bN+vJkVusNy3ex0+Jx1w1ASFBj9oUEajLPF3frry7EUlAMZ2TWGqd2EGMf3y8fMOo9H
 WuTHj6aR0nU4k4SzCExTjCyVm0fdWbcxybNNwRAIjrL0iybCcDQMdf7siTkWYA+CAtX/D3AwkuJ
 Q68kDf1li3GOS/aPys9LUQrVabDWoVjSN1ACfLLWTX3+t4XL/0sfjsq9mMkvjQ/HMhMJ4I1Sou3
 kh1P7IqLAGlb91LipRg==
X-Proofpoint-ORIG-GUID: KrkEvbAkJ27daFhPKMu-ZI8S1u7vKxki
X-Proofpoint-GUID: KrkEvbAkJ27daFhPKMu-ZI8S1u7vKxki
X-Proofpoint-Virus-Version: vendor=nai engine=6800 definitions=11713
 signatures=596818
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602260158

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
duplicate symbols or module symbols. Included here for context; this
patch is destined for the tracing tree via linux-trace-kernel (Steven
Rostedt).

- Patch 3: Selftests validating exact-name attachment via
kprobe_multi_session.c and error consistency between wildcard and exact
paths in test_attach_api_fails.

Changes since v1:
https://lore.kernel.org/bpf/20260223215113.924599-1-andrey.grodzovsky@crowdstrike.com/

- Moved exact-name detection from attach_kprobe_session() into
bpf_program__attach_kprobe_multi_opts() so all callers benefit,
not just session (Jiri Olsa)
- Changed ftrace_location() to boolean check only, keeping original
kallsyms address in addrs[] consistent with kallsyms_callback
behavior (Jiri Olsa)
- Removed verbose performance rationale from ftrace code comment,
kept in changelog (Steven Rostedt)
- Consolidated session syms test into kprobe_multi_session.c using
session_check(), validating via kprobe_session_result[0] == 4 (Jiri Olsa)
- Folded error tests into existing test_attach_api_fails() instead of
separate subtest (Jiri Olsa)
- Deleted standalone kprobe_multi_session_syms.c and
kprobe_multi_session_errors.c

Andrey Grodzovsky (3):
  libbpf: Optimize kprobe.session attachment for exact function names
  ftrace: Use kallsyms binary search for single-symbol lookup
  selftests/bpf: add tests for kprobe.session optimization

 kernel/trace/ftrace.c                         | 22 ++++++++++++
 tools/lib/bpf/libbpf.c                        | 34 +++++++++++++++----
 .../bpf/prog_tests/kprobe_multi_test.c        | 33 ++++++++++++++++--
 .../bpf/progs/kprobe_multi_session.c          | 10 ++++++
 4 files changed, 91 insertions(+), 8 deletions(-)

-- 
2.34.1

