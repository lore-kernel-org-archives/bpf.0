Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D1B386C06
	for <bpf@vger.kernel.org>; Mon,  2 Mar 2026 21:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.148.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772485552; cv=none; b=LhdxPoWIkMKWNmgjUaEEN7hxxn+qO3hGWBD1EwgoVZgHQVXCIGC7NJvzDP4AJkY2tTQhyDcU+YVVrWIiNsU49LE4l4rduGyHe1YkbJkqiiIqT1YnY4zy0dqVOWjSHERkQP0EPXr1Gc8lejBR8xXumUJuZAJECs0ZzdkQflN7XRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772485552; c=relaxed/simple;
	bh=QvKeHaxCSdO31dU2MiIi1m/uVZl8DnImkwB0Lm5N8VA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qFYHFJRI38P9HSj9nahnz08QQggdkCoUN2j0MuwFjTw5nhk3P7PklSIqwVIpRSlyhy5KGhIZbcEl5Hl4YK9b+bABSGab+HRWstJIfx6oc2S7i/cbklF+HfFxU3RymBZw0ifM1GnrHBQOJJEcBnAps4ZYwVeir2cK7Qlo6swbF6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=V0+jArNh; arc=none smtp.client-ip=148.163.148.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="V0+jArNh"
Received: from pps.filterd (m0354651.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 622Jevsw3806860;
	Mon, 2 Mar 2026 21:05:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=default; bh=b7ydCLUi6xR8o
	ua6+FjA8ogczNTBDe9PeuXOicaqSzQ=; b=V0+jArNhKq1lQie5bgX03SXlmj4qs
	mNhBV3jHb/wMaG8ODpOODh+Uf8bsJBvS3arzXSRxNC1u31kK1EO4kk+rNDEJ0MRn
	iHUsGlSnWnEydQo91ONSGADUR0x25fCihPJXzLAsqoILnIbKj472Wk03ign1kKW4
	7V2jsnPjFOpEl8TFHBN1F6UCU6xX+0EjpcJ/FexQ0MBMfgvuTylEapeTVlNiJtWl
	aRuH59k6I3TgaE3NC/Pq+bcO+6Jdrhaq05/v/EBbn07XSMqIZDUrP09l7hHcRU0v
	FiLReCi9iyIXllFFVkjEnOacf93K/s6VKlJVLrfKRCt3YO1NHAHM5WPxg==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 4cmbkwe9q0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Mar 2026 21:05:34 +0000 (GMT)
Received: from LL-DJCZ134.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 2 Mar 2026 21:05:32 +0000
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
To: <bpf@vger.kernel.org>
CC: <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <jolsa@kernel.org>, <emil@etsalapatis.com>,
        <linux-open-source@crowdstrike.com>
Subject: [PATCH bpf-next v4 0/2] Handle duplicate kprobe symbols
Date: Mon, 2 Mar 2026 16:05:30 -0500
Message-ID: <20260302210532.381083-1-andrey.grodzovsky@crowdstrike.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDE2MCBTYWx0ZWRfXwYV2Q0Bdwgge
 TdsuAZ7RFaGq0RnPB8d91aRwzTTVoNhaOISnFpFvsqUwjgCtmLlbbffB+pQSl4Y0btfRR94Qdhi
 7gqxAYlai/S3FE3FlHuoQ4beB0s2b2dzOzIshgLxldNlPZP/RyJe9Xd6YuUydo6VnJXnPYSjEp0
 B00GaaAA71S11PTpWyLS+CGomxLJ7fXL/EjFoElVHwCwIPF1K845s57LvWpm+PISRNbyx8ee5Yc
 6JO1LKTXLlmIWwP3rd4iHGjjHoNYdLeKb/NvsJAkCEVEnfIPZk3gTNpgjPXG6ILKUk7mvaK2OG9
 Pi1jrRJYZwTc5AgmXh6hOI8IVevgwOwGA8kJE6RqDEoEZfpavDKLpp+xsofqQoUv5cIxWs8cwkq
 biQ8dhymyvqzB0Zs2SEa01LblZz+LZTdqBQuwwHOiIrEpzbdhUm1QYwLyZ1h3Wdpx4ZRSX2WEme
 Ge/i0JCQgluzDrNG6vg==
X-Authority-Analysis: v=2.4 cv=M4RA6iws c=1 sm=1 tr=0 ts=69a5fb9e cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=T2KQ53IYiC3MXPrxx8bB:22 a=b3B37AjAgz0HnGB3MuNd:22 a=VwQbUJbxAAAA:8
 a=pl6vuDidAAAA:8 a=pNwn3ynNfXSQ7a8Z-kcA:9
X-Proofpoint-GUID: rWrPGsJ6knf6iFqYn2OUCYpQ1quggCpJ
X-Proofpoint-ORIG-GUID: rWrPGsJ6knf6iFqYn2OUCYpQ1quggCpJ
X-Proofpoint-Virus-Version: vendor=nai engine=6800 definitions=11717
 signatures=596818
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 spamscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603020160

When a kernel module exports a symbol with the same name as an existing
vmlinux symbol, kprobe attachment via bpf_program__attach_kprobe_opts()
fails with EADDRNOTAVAIL (perf_event_open path) or EINVAL (legacy
tracefs path).
                                                                                                                                                                                                               
This series implements a fallback mechanism that, on such failures,
resolves the vmlinux address through /proc/kallsyms - filtering out
module symbols - and retries probe attachment using the absolute address,
bypassing kernel symbol name validation.

Patch 1: Core libbpf changes - kallsyms parser restructuring, duplicate
       symbol detection, and address-based retry logic.
Patch 2: Selftests with bpf_testmod_dup_sym.ko test module validating
       kprobe attachment across all four attach modes.

Changes since v3 [1]:
- Set err = -ENOENT when kallsyms parse succeeds but the symbol is
  not found in vmlinux, preventing err == 0 from propagating to the
  caller via err_out (CI bot review)

[1] https://lore.kernel.org/bpf/20260302164846.36713-1-andrey.grodzovsky@crowdstrike.com

Andrey Grodzovsky (2):
  libbpf: Handle duplicate kprobe symbols in attach_kprobe_opts
  selftests/bpf: Add tests for duplicate kprobe symbol handling

 tools/lib/bpf/libbpf.c                        | 155 ++++++++++++++++--
 tools/testing/selftests/bpf/Makefile          |   2 +-
 .../selftests/bpf/prog_tests/attach_probe.c   |  63 +++++++
 .../testing/selftests/bpf/test_kmods/Makefile |   2 +-
 .../bpf/test_kmods/bpf_testmod_dup_sym.c      |  48 ++++++
 5 files changed, 250 insertions(+), 20 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/test_kmods/bpf_testmod_dup_sym.c

-- 
2.34.1

