Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835813126A9;
	Mon,  6 Apr 2026 20:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.148.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775505929; cv=none; b=e3kojmUSS7iLuR4P21NmmDMkH5KPHnAI7nuq/jdpPP0LsmENcwI4OVTuVMAehDuPQ6JtaQawGVplJbu9QV+qpt66FjHF/OJz+wp1GL6NaaLDB9kiwnlbdJPInFFck9aHeTR5vTMU+AG6ywLiBHNOG/jV5j/8kIMDnImnvJ8chnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775505929; c=relaxed/simple;
	bh=AC+Rwir7wQ8TqEdwv3VYw3uhn6Y5OpJ0ix6JbQrM5g8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=X7Aha8dpaHa6kGGVCLLAx0f/B1DzcWPeQUk03Vv15ekuXcrSgJsg6EO3qsgdjKD11WhQPClxMHNJtoUcmtar7FBV6BIwOO3cV+L7hIuSs8BVyb85MPPGAwXjwMLroE8iPPYLzsDlcMU/UsJdPOJ0t9euTX0oLqPPD78wjOzEq0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=yP8TgcE1; arc=none smtp.client-ip=148.163.148.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="yP8TgcE1"
Received: from pps.filterd (m0354651.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 636J6fnA2547818;
	Mon, 6 Apr 2026 19:32:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=default; bh=ThjhPdJQwTuOp
	MPIna20fC3u2KE50uJcGQ+pki/m8to=; b=yP8TgcE1g55aFi+IYzG2yrZmCrWQc
	4PoFiocwZOfK6Z0ttgoZXGnMgf6GgdKbXNyJTTV1V+BjjrIpnHYillRJPWPSzOjh
	zEioIJNHjXc8C2WNEqJCOTNLJ1rz4s8GWcCekHhQdMFkP9P75StCg91g5j30fwLp
	TMnqn5G4ZqmFR+ql269/8eClQ99QVa+be9W69/H2fAOKWHOpyAU32LwYGQniDZL1
	qnPXvRmRqWOQClICVizyQ3TWjGstCPMGAvfdAP5sec/F6kC8X7Fx6pr4F+dHRh2K
	n0420/EzYkaBQ63453qGaLpMvWMJn/UTnH7W5wqEIrTnwdCGjydM5pyxw==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 4dbdvxqy86-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Apr 2026 19:32:00 +0000 (GMT)
Received: from LL-DJCZ134.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 6 Apr 2026 19:31:58 +0000
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
To: <bpf@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>
CC: <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <jolsa@kernel.org>, <rostedt@goodmis.org>, <mhiramat@kernel.org>,
        <ihor.solodrai@linux.dev>, <emil@etsalapatis.com>,
        <linux-open-source@crowdstrike.com>
Subject: [RFC PATCH bpf-next v5 0/2] tracing: Fix kprobe attachment when module shadows vmlinux symbol
Date: Mon, 6 Apr 2026 15:31:56 -0400
Message-ID: <20260406193158.754498-1-andrey.grodzovsky@crowdstrike.com>
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
X-Authority-Analysis: v=2.4 cv=fNQ0HJae c=1 sm=1 tr=0 ts=69d40a30 cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=T2KQ53IYiC3MXPrxx8bB:22 a=b3B37AjAgz0HnGB3MuNd:22
 a=VwQbUJbxAAAA:8 a=pl6vuDidAAAA:8 a=YE35s84LRL086BocN2oA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: fFOe9Ow93tyj1hWyny2gud8MrTmhVtr4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA2MDE5MSBTYWx0ZWRfX/tjKJcEqsRR2
 bv2zXVz62Sw+CdWzEYNVHkyM4iB/jPx4RAIlZ7AKuQGZ9XAtyKsbElHUf1qN9Nc5LGCcgw8AtyA
 Q+Gln5dRJqeKfEsWdM7eRWBndw5e8ADMsicoQLXRcA4mBe1Wi/ZQYR5QZibmjXjp3Ph3QwDMGvJ
 pVmcXJ/2fk2ItsCcKaUEzkgqvOydRBgNo++oRJoh/il9tlvxc38xVp1Fv0gXMT0mdJi6DWk1LHj
 0stnIfOGQBDPLwWM5lzVuW1yzlwcpZSDudkZBn4JB+LQruF557EknfsrsVcWRJtgysNAkNWmLjz
 hl9tSFS8UiZ1ombqKou/6ZfNZyBITAffIMUb1ozKGgdD3ENgPeUjGgNwu/Ni3uTFhjbsEna4TTM
 RHz+9yxMUWoOsTwv4Jp2/kI/EcDc1slTu86wEuvizgF4BaIUHa6ueJOQKIZ780MAIMjfbEyRRcr
 rspP6PwaFVdDZefZ6Kg==
X-Proofpoint-ORIG-GUID: fFOe9Ow93tyj1hWyny2gud8MrTmhVtr4
X-Proofpoint-Virus-Version: vendor=nai engine=6800 definitions=11751
 signatures=596818
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 bulkscore=0
 malwarescore=0 phishscore=0 priorityscore=1501 clxscore=1011 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604060191

When a kernel module exports a symbol with the same name as an existing
vmlinux symbol, kprobe attachment fails with -EADDRNOTAVAIL because
number_of_same_symbols() counts matches across both vmlinux and all
loaded modules, returning a count greater than 1.

This series takes a different approach from v1-v4, which implemented a
libbpf-side fallback parsing /proc/kallsyms and retrying with the
absolute address. That approach was rejected (Andrii Nakryiko, Ihor
Solodrai) because ambiguous symbol resolution does not belong in libbpf,
and because it did not cover the kprobe_multi path.

Following Ihor's suggestion, this series fixes the root cause in the
kernel: when an unqualified symbol name is given and the symbol is found
in vmlinux, prefer the vmlinux symbol and do not scan loaded modules.
This makes the skeleton auto-attach path work transparently with no
libbpf changes needed.

Patch 1: Kernel fix - return vmlinux-only count from
         number_of_same_symbols() when the symbol is found in vmlinux,
         preventing module shadows from causing -EADDRNOTAVAIL.
Patch 2: Selftests with bpf_testmod_dup_sym.ko test module validating
         kprobe attachment across all four attach modes with a duplicate
         symbol present. Unchaged from V4.

Changes since v4 [1]:
  - Completely rework the approach: move fix from libbpf to the kernel
    (number_of_same_symbols() in trace_kprobe.c) as suggested by Ihor
    Solodrai. No libbpf changes needed.
  - When mod==NULL and vmlinux contains the symbol (count > 0), return
    the vmlinux-only count immediately, skipping module scan entirely.
  - Preserves all existing semantics: MOD:SYM qualification unchanged,
    module-only symbols unchanged, vmlinux-ambiguous symbols unchanged.

[1] https://lore.kernel.org/bpf/20260302210532.381083-1-andrey.grodzovsky@crowdstrike.com/

Andrey Grodzovsky (2):
  tracing: Prefer vmlinux symbols over module symbols for unqualified
    kprobes
  selftests/bpf: Add tests for duplicate kprobe symbol handling

 kernel/trace/trace_kprobe.c                   |  7 +++
 tools/testing/selftests/bpf/Makefile          |  2 +-
 .../selftests/bpf/prog_tests/attach_probe.c   | 63 +++++++++++++++++++
 .../testing/selftests/bpf/test_kmods/Makefile |  2 +-
 .../bpf/test_kmods/bpf_testmod_dup_sym.c      | 48 ++++++++++++++
 5 files changed, 120 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/test_kmods/bpf_testmod_dup_sym.c

-- 
2.34.1

