Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4196B33B95C;
	Tue,  7 Apr 2026 16:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.148.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775580735; cv=none; b=rfjZ6ctOV9d/wN7LBWBvFevK4kZOyAdRNWLAa/IpFOHUs42kTcYkIltbki8oFp6//4WJCEdrzSwD2kRpQJzq/rR2FVWCzAhxzTdmf2jfg8ECoILC/gAD5RAJKTxHs1ox8gJ5W+3/BAiEP73qjlsUCnsePNMCpdsR1S25ON/BPKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775580735; c=relaxed/simple;
	bh=ewEMLWa9/pYMUHhlZvWwGuj234TtA6J38QDrsijAGfM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=I3Zv6wVkgV579M16nKzkwn82jYEXf/nDGHeWBdVE66C/eL+uQ2Q2M09tQ/nHXHbUGp9slYLm29PMLiHcJol5G5f8IUAtACPIe5UHNkrw6kXlURQHoNsEEFNpbAQBTVdSBvlIbpfTvR5CZuDiAyEw8aezOC0BgxmZEwNUo2JCp7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=D8YUDrDW; arc=none smtp.client-ip=148.163.148.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="D8YUDrDW"
Received: from pps.filterd (m0354650.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 637ENIXX3915549;
	Tue, 7 Apr 2026 16:51:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=default; bh=6ZjDgkLrREPs5
	NfyQmCJ/83u4wfXe7cKiwAN1UouNc0=; b=D8YUDrDWCE9E3S9MnUJYoaBXSzeGu
	UGN/tC5Qi0ErUU4tr8DnTPDPTksr7icZrPvGIwOjY/Gpfue/ZV3uwwSnCnLFuPjB
	nhEm7OySxTOhHixLx55XdvR84U6sZe6vWOVHJTZlpXXEph+PqZn0NYlgirOC5ntT
	DX/akCrsPDQ0cRNguF8pcJt186k+3ZHkdNyZAlpGPR5qhN8ohNbtao60SV7MRWTf
	z9Goi3Rudsox0xeL52CyWJ7Wf9b0xRMdqN4y+5nG3Y9q9ishZGdkiI7R8PdLCmdp
	5sSmBWIDtqAUwhIJBVpF+hgqkAm/m9Qk2335mdXFFjBk5BnIi5LP5afpA==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 4dcmqh4eah-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Apr 2026 16:51:48 +0000 (GMT)
Received: from LL-DJCZ134.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 7 Apr 2026 16:51:46 +0000
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
To: <bpf@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
        <jolsa@kernel.org>, <ihor.solodrai@linux.dev>
CC: <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <rostedt@goodmis.org>, <mhiramat@kernel.org>, <emil@etsalapatis.com>,
        <linux-open-source@crowdstrike.com>
Subject: [PATCH bpf-next v6 0/2] tracing: Fix kprobe attachment when module shadows vmlinux symbol
Date: Tue, 7 Apr 2026 12:51:43 -0400
Message-ID: <20260407165145.1651061-1-andrey.grodzovsky@crowdstrike.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDE1MCBTYWx0ZWRfX6sT4zZURBUPR
 u+1z0dBzTlLOiImDeLc/w7eFImlhILjm5Ajp7N9Oc3HVujTQqi9gqQc/z/eAvItGD+QFHNnVBHT
 +3iYOSLD2Lsy1n7YXg4batk5spGwKAEc4hfqaRFJlW1PUzkc8QYhPiu8/jIeeekfeLCCoqQp8ic
 JKNZWMyP6QC63N1oEv2AcAeFvHOc24FaOIbn/PkoowrAw9RKnjpSxHZYgM9yGByOug0yeXc6hv/
 0v0tDBFWM5P7N9wMecsQz3ooLOqWBS3NKlja6CJgRca9yeaDPonaXt27spG5jLAj3jjZ+bZEZsX
 VWKT539KRcvYyfjuu/ZGV9AYKSa5ppUAB1LK/hp48PlC0cpVM3CVGMJ3EFzEqlF3ptyAz6uFWAk
 9vy2hh/L7aGAoUm2E1yKOjupsY1/dogF71BDTzOmzPnwQRijHI+UMsVdaIGq7/g/SdX6fGuSXR3
 77bR5iiTZ13lj/G9Gqg==
X-Authority-Analysis: v=2.4 cv=Z9Lc2nRA c=1 sm=1 tr=0 ts=69d53624 cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=T2KQ53IYiC3MXPrxx8bB:22 a=t04HzT_fAfAF5W-3wVZy:22 a=VwQbUJbxAAAA:8
 a=pl6vuDidAAAA:8 a=YE35s84LRL086BocN2oA:9
X-Proofpoint-ORIG-GUID: BHTxMsgm5tjm_ty8s4MeMlyi8knI7XXX
X-Proofpoint-GUID: BHTxMsgm5tjm_ty8s4MeMlyi8knI7XXX
X-Proofpoint-Virus-Version: vendor=nai engine=6800 definitions=11752
 signatures=596818
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0 adultscore=0
 malwarescore=0 phishscore=0 impostorscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070150

When a kernel module exports a symbol with the same name as an existing
vmlinux symbol, kprobe attachment fails with -EADDRNOTAVAIL because
number_of_same_symbols() counts matches across both vmlinux and all
loaded modules, returning a count greater than 1.

This series takes a different approach from v1-v5, which implemented a
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
Patch 2: Selftests using bpf_fentry_shadow_test which exists in both
         vmlinux and bpf_testmod - tests unqualified (vmlinux) and
         MOD:SYM (module) attachment across all four attach modes, plus
         kprobe_multi with the duplicate symbol.

Changes since v5 [1]:
  - Selftest: use existing bpf_fentry_shadow_test (vmlinux + bpf_testmod)
    instead of a new bpf_testmod_dup_sym.ko test module (Jiri Olsa).
  - Selftest: add MOD:SYM qualification test for module shadow attachment
    (Jiri Olsa).
  - Selftest: add kprobe_multi dup_sym test in kprobe_multi_test.c
    (Jiri Olsa).

[1] https://lore.kernel.org/bpf/20260406193158.754498-1-andrey.grodzovsky@crowdstrike.com/

Andrey Grodzovsky (2):
  tracing: Prefer vmlinux symbols over module symbols for unqualified
    kprobes
  selftests/bpf: Add tests for kprobe attachment with duplicate symbols

 kernel/trace/trace_kprobe.c                   |  7 ++
 .../selftests/bpf/prog_tests/attach_probe.c   | 68 +++++++++++++++++++
 .../bpf/prog_tests/kprobe_multi_test.c        | 39 +++++++++++
 3 files changed, 114 insertions(+)

-- 
2.34.1

