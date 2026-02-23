Received: from mx0b-00206402.pphosted.com (mx0b-00206402.pphosted.com [148.163.152.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5562222A9;
	Mon, 23 Feb 2026 21:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.152.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771883493; cv=none; b=E8zAh63kOLmBRuzHQqEzqrnNRFAjl7xejei3QuWFdc1sme3UaibIWsuZEFFTx5DLQ+GreaQLHJMBWDJ95P+2Q6F+016Qo75soHUOHMnQHybH1dpuF7yD6spvF6AkTos6cDgNb/Ljw+21M3r14LSyg/42I2oUGHA8YUcQIpwSgd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771883493; c=relaxed/simple;
	bh=VI949fYOcRg/bbrtExVL+jb2/QWY8SNp4IQ3Ze68RHQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fU25B1FLou/jw6pkY2KLKTJ+57rRioHGRx1opHKRZDSM5HFUvTgFVYAT7AymXP4YbbhZNT8L74InE8xRWQWgMqZxKQ8hikgvFKIgsCk8HMvWDWIHYinf/dvRPmAf1Lh9Y53RblZCn2tcwINec2aFHSGwY1NvulkPJDrki34shUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=OUYGhsHG; arc=none smtp.client-ip=148.163.152.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="OUYGhsHG"
Received: from pps.filterd (m0354655.ppops.net [127.0.0.1])
	by mx0b-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61NJYaFd2436900;
	Mon, 23 Feb 2026 21:51:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=default; bh=M5NL5JyBuEtsa
	7mNIWvXUQi3Fj6ZbxHOypeqrDfDeSk=; b=OUYGhsHGiHw7nNelrbNxMOVyfG1ns
	8QsTHJwPurvYIZnDRE52jwkX6T7L55MhY2x4RyYnvbaqZaHNNRfQdWjkfW8TTAqW
	oP6DydJWJkExuR2TbOKpltKd4QHhcDzt+5i6ErkpZnDRENdUVoox53/R6Pt+ulsw
	UE6q2vrn55is9gwS0BJ6KoLZFZ88bpwoeNCdAH4FiLi2mpB/xQwbWLgJn4YZEk80
	Q05+GJCMwd9Vgief+PJ4fWPM1vGnVid8DD1XL2pNuclpbghF9BupDMLojDVP9Ce4
	417LgyhRmeMHoWIS2kAvbUzvyOZkFdk+95snBiStybxmlX/82GRfxyVng==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0b-00206402.pphosted.com (PPS) with ESMTPS id 4cfry9pvtk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Feb 2026 21:51:16 +0000 (GMT)
Received: from LL-DJCZ134.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 23 Feb 2026 21:51:14 +0000
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
To: <bpf@vger.kernel.org>
CC: <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <jolsa@kernel.org>, <rostedt@goodmis.org>,
        <linux-trace-kernel@vger.kernel.org>,
        <linux-open-source@crowdstrike.com>
Subject: [RFC PATCH bpf-next 0/3] Optimize kprobe.session attachment for exact match
Date: Mon, 23 Feb 2026 16:51:10 -0500
Message-ID: <20260223215113.924599-1-andrey.grodzovsky@crowdstrike.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: 04WPEXCH014.crowdstrike.sys (10.100.11.87) To
 04WPEXCH006.crowdstrike.sys (10.100.11.70)
X-Disclaimer: USA
X-Proofpoint-GUID: 9Hac2BBa1fG87XCZFqdGZpXJnefRGVxx
X-Proofpoint-ORIG-GUID: 9Hac2BBa1fG87XCZFqdGZpXJnefRGVxx
X-Authority-Analysis: v=2.4 cv=b7u/I9Gx c=1 sm=1 tr=0 ts=699ccbd4 cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=T2KQ53IYiC3MXPrxx8bB:22 a=vDKVRhTs-M86Ea50iKLw:22
 a=IKi72SNgi2vtnQK4u7UA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDE5MCBTYWx0ZWRfX5oFTXZMPv59F
 wlMyGuukSyV14FIyvYIGZeI0FqyRuYWI+GgIIQro3Zhmm00mByXhvpW3EjXGZ4dNi9uyOBuUhEa
 1bYj3+EUVuWMXq3dp2x/Oq3V0Dga9G8boyrJrMDBYZ3bkdKWd7GRISXyuMNmpwqJ6GltlUCPIZX
 4L33W52CHAwj0b1lXYWnUl9KmIJNEtBaiOk4XBwXrmDReWLKbMf/KiF94s0ENIXucuoXbDDeOnG
 1Af5sq2jwvcOkcEB7KqNIfvBoT14ykzitca2VowYRodbYhxcHzazu+X7F71j4WO37hNF9uDABDA
 /IKDFz4dk+Jfe6SGSb3+Dx7OkTrvBZ2A+8iL58ECjgM4O7d69MzXIeZc1vKtEYyWppvvfYVm13T
 deU1U5KI+uY2WSvH8GVGtfL7qYNhPtbQ2DIq7KOaBjQYZgxQ8IyDWUOrdSgg8Lc3MQSK8C+0L6R
 /lKkV0IRnDQ9IC8x8fw==
X-Proofpoint-Virus-Version: vendor=nai engine=6800 definitions=11710
 signatures=596818
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1011 malwarescore=0
 impostorscore=0 spamscore=0 adultscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602230190

When libbpf attaches kprobe.session programs with exact function names
(the common case: SEC("kprobe.session/vfs_read")), the current code path
has two independent performance bottlenecks:

1. Userspace (libbpf): attach_kprobe_session() always parses
   /proc/kallsyms to resolve function names, even when the name is exact
   (no wildcards).

2. Kernel (ftrace): ftrace_lookup_symbols() does a full O(N) linear scan
   Worse case ~200K kernel symbols via kallsyms_on_each_symbol(), decompressing
   every symbol name, even when resolving a single symbol (cnt == 1).

This series optimizes both layers:

Patch 1 adds a dual-path optimization to libbpf's attach_kprobe_session().
When the section name contains no wildcards (* or ?), it passes the
function name via opts.syms[] directly to the kernel, completely skipping
the /proc/kallsyms parse.  When wildcards are present, it falls back to
the existing pattern matching path.  Error codes are normalized (ESRCH →
ENOENT) so both paths present identical errors for "symbol not found".

Patch 2 adds a cnt == 1 fast path inside ftrace_lookup_symbols().  For a
single symbol, it uses kallsyms_lookup_name() which performs an O(log N)
binary search via the sorted kallsyms index, needing only ~17 symbol
decompressions instead of ~200K.  If the binary lookup fails (duplicate
symbol names where the first match is not ftrace-instrumented, or module
symbols), it falls through to the existing linear scan.

The optimization is placed inside ftrace_lookup_symbols() rather than in
its callers because:
  - It benefits all callers (bpf_kprobe_multi_link_attach,
    register_fprobe_syms) without duplicating logic.
  - The cnt == 1 binary search with fallback is purely an internal
    optimization detail of ftrace_lookup_symbols()'s contract.

For batch lookups (cnt > 1), the existing single-pass O(N) linear scan
is retained.  Empirical profiling with perf and bpftrace on both QEMU
and real hardware showed that the linear scan beats per-symbol
binary search for batch resolution at every measured scale (500, 10K,
41K symbols).

Patch 3 adds selftests covering the optimization: test_session_syms
validates that exact function name attachment works correctly through
the fast path, and test_session_errors verifies that both the wildcard
(slow) and exact (fast) paths return identical -ENOENT errors for
non-existent functions.

Example -  (50 kprobe.session programs, each attaching to one exact
function name via separate BPF_LINK_CREATE syscall, 50 distinct
functions):

  Configuration                                  Attach Time
  -----------------------------------------------+-----------
  Before (unpatched libbpf + kernel)              7,488 ms
  Patched libbpf only                               858 ms
  Both patches (libbpf + ftrace)                      52 ms
  Traditional kprobe pairs (100 progs, reference)    132 ms

Combined improvement: 144x faster.  kprobe.session is now 2.5x faster
than the equivalent traditional kprobe entry+return pair.

Background: ftrace_lookup_symbols() was added by "ftrace: Add
ftrace_lookup_symbols function" to batch-resolve thousands of
wildcard-matched symbols in a single linear pass.  At the time,
kallsyms_lookup_name() was also a linear scan, so the batch approach
was strictly better.  "kallsyms: Improve the performance of
kallsyms_lookup_name()" later added a sorted index making
kallsyms_lookup_name() O(log N), but ftrace_lookup_symbols() was
never updated to take advantage of this for the single-symbol case.

Andrey Grodzovsky (3):
  libbpf: Optimize kprobe.session attachment for exact function names
  ftrace: Use kallsyms binary search for single-symbol lookup
  selftests/bpf: add tests for kprobe.session optimization

 kernel/trace/ftrace.c                         | 28 +++++++
 tools/lib/bpf/libbpf.c                        | 32 ++++++--
 .../bpf/prog_tests/kprobe_multi_test.c        | 76 +++++++++++++++++++
 .../bpf/progs/kprobe_multi_session_errors.c   | 27 +++++++
 .../bpf/progs/kprobe_multi_session_syms.c     | 45 +++++++++++
 5 files changed, 203 insertions(+), 5 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/kprobe_multi_session_errors.c
 create mode 100644 tools/testing/selftests/bpf/progs/kprobe_multi_session_syms.c

-- 
2.34.1

