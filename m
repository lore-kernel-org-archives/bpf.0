Received: from mx0b-00206402.pphosted.com (mx0b-00206402.pphosted.com [148.163.152.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE09C335BBB
	for <bpf@vger.kernel.org>; Wed, 18 Feb 2026 22:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.152.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771455413; cv=none; b=Oi5BNOQnq6Bv3sdQJBEwB8r5jB8S3B+Vu52nyAPuf5cmywogSknDGQVw8K5uJJJhULgPkZjyhvgvjnc307NWxchPKFvbcYiil7Q4VSXMAhnQrayK9cviW+50RE+5HtcSTYpgBeXC2TRCOfsHeSTt9eJWr81PsQh5FIrl+Q4ObQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771455413; c=relaxed/simple;
	bh=aKWXOFKVVWtKfHMcxacivSeMw6Kr3x/Xi4qsxOiMEFM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=q+1M/QHJ+xxQ/fNXmK48dbvWp8KRV9NwJ55rKfwu5JPDMu+87r0BmYc4Vki8ZVn/uETnsYYsnTl9VpKXtJv4Au3JR/KZMY4wZdlmftEUwyaPHiF1KcR32ZvK0C8qk350qqcOFn4Bbj0Cd0uiTefSpgvvFhrtbMKZrcDXm4WUoy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=oz1acFOB; arc=none smtp.client-ip=148.163.152.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="oz1acFOB"
Received: from pps.filterd (m0354653.ppops.net [127.0.0.1])
	by mx0b-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61IKbMru2984675;
	Wed, 18 Feb 2026 22:56:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=default; bh=Zn+lcNe1hjTgT
	pR/vvq6UH7e/hVR9ob1Lowg0NohQuQ=; b=oz1acFOBnQF58C/xbM4wbPvzaC9zM
	JU/SYW3h1FFruSDpTi7Ix8/yLoEKL84t0gngbrreRnXIAI09FLwVsbCsPCXb1hc7
	t6X6elmPIxfsu/zC+YW/Y/jwEokweCgqXu0hI3b6rWG6yNOUiZREiy9PzxS9Ee50
	67dLK1SEqg79O78lu4v4NEHJnwdZW1TGWvQJSrVSzjJ+VK4UDslncyRZihre8SDP
	hcc7r0te6suMqYJdp2X7BVrqH0YDnqvlJfFtEhLekJnEf/AOT9HPuStO6+ijU5Y9
	FpAuW4I1J3Ol+7KXMsxeSrHOnP6vErH2DpHhhiivOdPGutC8SxI5+J5eA==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0b-00206402.pphosted.com (PPS) with ESMTPS id 4cd06cd183-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Feb 2026 22:56:19 +0000 (GMT)
Received: from LL-DJCZ134.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 18 Feb 2026 22:56:18 +0000
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
To: <bpf@vger.kernel.org>
CC: <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <jolsa@kernel.org>, <linux-open-source@crowdstrike.com>
Subject: [RFC PATCH bpf-next 0/2] libbpf: Handle duplicate kprobe symbols
Date: Wed, 18 Feb 2026 17:56:15 -0500
Message-ID: <20260218225617.354858-1-andrey.grodzovsky@crowdstrike.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: 04WPEXCH006.crowdstrike.sys (10.100.11.70) To
 04WPEXCH006.crowdstrike.sys (10.100.11.70)
X-Disclaimer: USA
X-Authority-Analysis: v=2.4 cv=UfxciaSN c=1 sm=1 tr=0 ts=69964393 cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=jaJHa1lccSu8UMVvMLsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE4MDE5OCBTYWx0ZWRfX8Yyl1K7GcXAX
 7l5aEfRBk9YlHv7Kv812ahm7b5lwFb6Tm+JCqseuldNzV1rdGkvX3UP28yo1Ak4pn9xCNjjv3Rn
 nMEXPlOXtFYhsNZk18Te2tyrjahQfWVyyOBbDuKyxyEK06ttbgiyZZTGlzofcwebUnUXVuheTS0
 JIEah1U6FtrBx+FuJFCumdTysR4SsqAR8XO4GuChYU+22GthgD87+PpZNVS+PnLypyMsmcpWJED
 jct5QQs7Ru4v76YGR8ITtvWHeXxZAOzD3Ttb/YEg6HXWm5C5p52NV0/GQjBDc93azCl0aDyEKEy
 NXsiqJdsNWD68//ZNcoG58IMrEkMXvDU6uTdcagnXMeY9u5SdBnGj75XvQMueuEgMRpZxHSLrvB
 dZJjJJ1IlaQnSW5z+Waxn6Ch0DsS6Yod/U4nQ02h9169GdUpkU3gr1QgcOoiOqC/KACCAez5OV5
 UiVvlkLlJgpl2NbGdjQ==
X-Proofpoint-GUID: gFWTG8WAwmKkyd0H_z8oN2KelF--M5_l
X-Proofpoint-ORIG-GUID: gFWTG8WAwmKkyd0H_z8oN2KelF--M5_l
X-Proofpoint-Virus-Version: vendor=nai engine=6800 definitions=11705
 signatures=596818
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 clxscore=1011 suspectscore=0 impostorscore=0
 phishscore=0 bulkscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602180198

When a kernel module exports a symbol with the same name as an existing
vmlinux symbol, kprobe attachment via bpf_program__attach_kprobe_opts()
fails with EADDRNOTAVAIL (perf_event_open path) or EINVAL (legacy tracefs
path). The kernel rejects the ambiguous symbol name because it cannot
determine which address to probe.

This is a practical problem: out-of-tree modules may inadvertently
duplicate vmlinux symbol names, and the current libbpf behavior provides
no recovery path — the attachment simply fails.

This series adds a fallback mechanism in libbpf that retries attachment
using the absolute kernel address instead of the symbol name when the
initial attempt fails due to duplicate symbols.

The approach:
  1. Enhance libbpf_kallsyms_parse() to extract module names from
     /proc/kallsyms entries (format: "addr type name [module]"),
     passing them to callbacks via a new module_name parameter.
  2. On EADDRNOTAVAIL/EINVAL failure, look up the function address
     in /proc/kallsyms, filtering to vmlinux-only text symbols.
     If the vmlinux symbol itself is ambiguous (same name, different
     addresses), reject with an error.
  3. Retry the probe attachment with func_name=NULL and the resolved
     address as the offset, bypassing the kernel's symbol lookup
     entirely.

This works because perf_event_open with config1=0 (no symbol name)
and config2=address performs a direct address-based probe without
any kallsyms validation. The legacy tracefs path uses the "0xADDR"
format which similarly avoids symbol resolution.

Patch 1 implements the core libbpf changes.
Patch 2 adds selftests with a test module (bpf_testmod_dup_sym.ko)
that creates a duplicate syscall wrapper symbol, validating all four
kprobe attachment modes (default, legacy, perf_event_open, link).

Andrey Grodzovsky (2):
  libbpf: Handle duplicate kprobe symbols in attach_kprobe_opts
  selftests/bpf: Add tests for duplicate kprobe symbol handling

 tools/lib/bpf/libbpf.c                        | 150 ++++++++++++++++--
 tools/testing/selftests/bpf/Makefile          |   2 +-
 .../selftests/bpf/prog_tests/attach_probe.c   |  63 ++++++++
 .../testing/selftests/bpf/test_kmods/Makefile |   2 +-
 .../bpf/test_kmods/bpf_testmod_dup_sym.c      |  45 ++++++
 5 files changed, 243 insertions(+), 19 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/test_kmods/bpf_testmod_dup_sym.c

-- 
2.34.1

