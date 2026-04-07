Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5F25733E;
	Tue,  7 Apr 2026 20:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.148.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775594429; cv=none; b=HXgOwghwwSNrK0VhqQo3HGGuSVu/vUVgrvZ/z281FUa2otw/MYXOZxxaQukzedjJrU1WkE+h5h1iTehWlg978oyKPJbYWCUUwDJXleIM+jLE5o2DSBUAUZ3dIKWr+LD/LwetuK3M+Ibvo6Hh7H2P/Nm9sBhdXzh7b4i7lk6vsbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775594429; c=relaxed/simple;
	bh=RSJdaqZ/U+aHK5Czz+9HVpDfqODw9NB2as7SJqZBqQA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NKWlUx6sz9NhXOEnjc35G3lbmgV4kgovnXjxiGtb5na2da0LQJbNNkVfaHF820jfQTHVOWMHF+IHag+U5rcbyD23Zs9ncTazgPmoGVHrMr7xxvJioHTSUnDvnjaZYYuYePPSU0DO7j7u/lUjp9q1oCYb9fAx2cdgBwixFS5BAhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=g/bw6c8K; arc=none smtp.client-ip=148.163.148.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="g/bw6c8K"
Received: from pps.filterd (m0354651.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 637JTJ353555305;
	Tue, 7 Apr 2026 20:39:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=default; bh=rmhpzrSBY3yN/
	aGLMO/4qXoVUKfm6pfffpWhIKFLbKg=; b=g/bw6c8KSJKYs8FP3YD4VFvk5E7du
	zYu/fk7TPOhYevftiiW2zUVxrwa+hW7OFrYrUMxmnOE5hBLpWBkiA85RUjIh/6AW
	7GpNTyCb9Aii/NuA1zcWW7otjsU742/UjHLwkG1wzsK/5FmF3PmKHXvIcFpI8IVI
	3aiQBI8dGF6dJP+ZVIIKuo6Lv/HdZxmJ3CR8CmXHfh+7SfmdblLjqjhVIZkcdssc
	xCbK64l6HdHpIJIv85jvfIR9JYjhiZrCdtZP9owcThKv9YGBWxoO8EhusXu/kbRo
	ozLDF0H4SQEg3YdwE3Et1dl+PPN6Pz1IRimaLdBPkTYR0OXdxlBtzeT5g==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 4dcmqgwhut-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Apr 2026 20:39:14 +0000 (GMT)
Received: from LL-DJCZ134.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 7 Apr 2026 20:39:13 +0000
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
To: <bpf@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>
CC: <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <jolsa@kernel.org>, <rostedt@goodmis.org>, <mhiramat@kernel.org>,
        <ihor.solodrai@linux.dev>, <emil@etsalapatis.com>,
        <linux-open-source@crowdstrike.com>
Subject: [PATCH bpf-next v7 0/2] tracing: Fix kprobe attachment when module shadows vmlinux symbol
Date: Tue, 7 Apr 2026 16:39:10 -0400
Message-ID: <20260407203912.1787502-1-andrey.grodzovsky@crowdstrike.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDE4OCBTYWx0ZWRfXxj7i3iunOtK0
 qp2HuLzS7gi1QZIPaesU3FW3AKMEH6vWfjScUSJbZh115MaGLOnoyFvOZzUygvPkx1mxSIrdEYc
 ipsBkGS1MI2+a7ou5LSxrVgO5ddGr6txbStq1A3/osprFliFXBVEBmxfv7V3VBZIExGz5aOl2kr
 1ByYNSEZsJ6wn/JWqRVV+50P69sciDc6ojJ2CY2mTZ3vwwut8yHWjAgyDD0SUaSs0lsq7i0kTll
 +gQD2a9Jjp4w2Ru/HJ57o3zatBD71xpKz50tQq0AWlheQW2zKOHf23zv5vpyl1NTz4aqDF6jKX9
 4C3b3CQ+iePlHGOuIRoNJjaq53x04ipwCH0cAoPn+ObxHMNg9JAFPp3vVXxLPSuBzB3wKb2Rd8R
 VLNTbtgJZ5/K71XgVjhZeldw2oZChXQle/6d/GtIMJH7TAIltzMS2mzGUDjBFt8B1PpFqXjw9S/
 Otq/XLEWCnv128FMglw==
X-Proofpoint-ORIG-GUID: lyNpPnL3K2ad112GtWsSj2_VlHfWsTfl
X-Proofpoint-GUID: lyNpPnL3K2ad112GtWsSj2_VlHfWsTfl
X-Authority-Analysis: v=2.4 cv=C87ZDwP+ c=1 sm=1 tr=0 ts=69d56b73 cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=T2KQ53IYiC3MXPrxx8bB:22 a=b3B37AjAgz0HnGB3MuNd:22 a=VwQbUJbxAAAA:8
 a=pl6vuDidAAAA:8 a=LAl3fjZN0rgIiSzbgngA:9
X-Proofpoint-Virus-Version: vendor=nai engine=6800 definitions=11752
 signatures=596818
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 malwarescore=0 spamscore=0 impostorscore=0
 suspectscore=0 bulkscore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070188

When a kernel module exports a symbol with the same name as an existing
vmlinux symbol, kprobe attachment fails with -EADDRNOTAVAIL because
number_of_same_symbols() counts matches across both vmlinux and all
loaded modules, returning a count greater than 1.

This series takes a different approach from v1-v4, which implemented a
libbpf-side fallback parsing /proc/kallsyms and retrying with the
absolute address. That approach was rejected (Andrii Nakryiko, Ihor
Solodrai) because ambiguous symbol resolution does not belong in libbpf.

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

Changes since v6 [1]:
  - Fix comment style: use /* on its own line instead of networking-style
    /* text on opener line (Alexei Starovoitov).

[1] https://lore.kernel.org/bpf/20260407165145.1651061-1-andrey.grodzovsky@crowdstrike.com/

Andrey Grodzovsky (2):
  tracing: Prefer vmlinux symbols over module symbols for unqualified
    kprobes
  selftests/bpf: Add tests for kprobe attachment with duplicate symbols

 kernel/trace/trace_kprobe.c                   |  8 +++
 .../selftests/bpf/prog_tests/attach_probe.c   | 69 +++++++++++++++++++
 .../bpf/prog_tests/kprobe_multi_test.c        | 40 +++++++++++
 3 files changed, 117 insertions(+)

-- 
2.34.1

