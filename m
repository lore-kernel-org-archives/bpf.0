Received: from mx0b-00206402.pphosted.com (mx0b-00206402.pphosted.com [148.163.152.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A495425CC4
	for <bpf@vger.kernel.org>; Mon,  2 Mar 2026 16:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.152.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772470161; cv=none; b=tIjocY+zElyY6/HzBNwvwNr84qp48y+GszoiD99W6R2ZjP8qvFZnl+Hx0atd8CgmeR7zoC4q4cA3VzAzLgbcAv1fBUm/cnaD5aKWfAA1RUx8iQ8lFSCh3JMeX5G8zAM4HTP38QML/YgcRTk4rmllmlXcjEZuYeKx6nh1/kexJxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772470161; c=relaxed/simple;
	bh=LGTQnDbabIqc3H2LiuJHgvBCA/VBjYj/Rg7a6Vl7y7k=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DEq57iAMibHLZbo8OpIz5DNE14FDYlCtTjOwsRzCLH8tYnsj+QTPJxOFHRrFIynsAHsZGzCwHJPzU0VqTKuazD7ubKJ4P64lzzklwOeLJNQMTMZK6eGnKb4fJ/TYa+dNao0KokFnDrECX5D/s/xGMIpod3SDCwB9LrRlJSOZcss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=F1bhYniW; arc=none smtp.client-ip=148.163.152.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="F1bhYniW"
Received: from pps.filterd (m0354654.ppops.net [127.0.0.1])
	by mx0b-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 622E7mIu1677322;
	Mon, 2 Mar 2026 16:48:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=default; bh=70Kqg2XKlVHBx
	hVdBS6W8Bb2cBAWzbnOwc+Gru4sm9Q=; b=F1bhYniWKfKm1Og+GWGKFdZo58Vmf
	Mn4HHAwrhPINGFLwcF5MYSj9KCbVBfdOcyNt2dcKeQWI1gQF8+Odu16alQnptG+u
	uE35c+fQ/sTl6e6g57kUTnH1tMFkp2R5eZ7PHohhTAGCTvgrRIogVtussCCOpZKG
	mXptsmzoVtiK+p0oGDq0RLzXt5nMsCWblz4QsBoeCF1jez5gIhglFvRUHIxvrt8d
	9dau0K1eZ2tKrQCFpVPCUxlMg3NtdGWE7718hJHNJireSIgvde0UMMqwgS1e9xwc
	ahpYIsu2zA0J4AUzcEvZucj5Z3vIw8+CxP782b2MwP1ckaor75MRV3EUQ==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0b-00206402.pphosted.com (PPS) with ESMTPS id 4cmb5uw755-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Mar 2026 16:48:49 +0000 (GMT)
Received: from LL-DJCZ134.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 2 Mar 2026 16:48:47 +0000
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
To: <bpf@vger.kernel.org>
CC: <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <jolsa@kernel.org>, <emil@etsalapatis.com>,
        <linux-open-source@crowdstrike.com>
Subject: [PATCH bpf-next v3 0/2] libbpf: Handle duplicate kprobe symbols
Date: Mon, 2 Mar 2026 11:48:44 -0500
Message-ID: <20260302164846.36713-1-andrey.grodzovsky@crowdstrike.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: 04WPEXCH012.crowdstrike.sys (10.100.11.82) To
 04WPEXCH006.crowdstrike.sys (10.100.11.70)
X-Disclaimer: USA
X-Proofpoint-GUID: 9nh-m4xC-GssTDbx6BgMM4_yZtgtFmEh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDEzOCBTYWx0ZWRfXzd9pZWLdS2JO
 uo9FMw5iTN9NkBYdLBT4G2L5ARGgNxGDE9hybnrvinaQCb6M2yZ6dbGydyOuVldTlVmKF0+12Ov
 Elv0LfRLkqnuuwIDgkUDIVL+3t6jFv+517Wcwvsc+y6porb6/WMzLG+TbxBG6IzyPUOxhBW+Lx1
 BlOiieQTkjYVrvQZotn6E7WH4fAE0keKGNggNdv7GgAz2mXUkC4Myh6U2/9YDpBO5bCNs7Kcoah
 NIQXC0Xd6OoiwoRZJ3c5kyTFH79xWY92cPH25RnjsvljtMvcHcPmfwC8XMuACGM74kQ3RtdeHcU
 XHOww0/1gfdzVUlOXqwq5uhx1HKbM/d7PD6sBzS15Lh0ngKywsWTbnOZsV+50l+/CkT1F1msneg
 O75HcHflipD8n2KltHtRyHSSv0kS0Nioo0V3FPEJvQNeWKyugB4TrAeUiRorcRgGgOf2phXfF+E
 1p00gRT3JHCSdqySNcg==
X-Authority-Analysis: v=2.4 cv=WN1yn3sR c=1 sm=1 tr=0 ts=69a5bf71 cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=T2KQ53IYiC3MXPrxx8bB:22 a=R_n4Uisa8axJ7jemP0ek:22 a=VwQbUJbxAAAA:8
 a=pl6vuDidAAAA:8 a=pNwn3ynNfXSQ7a8Z-kcA:9
X-Proofpoint-ORIG-GUID: 9nh-m4xC-GssTDbx6BgMM4_yZtgtFmEh
X-Proofpoint-Virus-Version: vendor=nai engine=6800 definitions=11717
 signatures=596818
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 phishscore=0 suspectscore=0 bulkscore=0
 adultscore=0 malwarescore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603020138

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

Changes since v2 [1]:
- Fix multi-line comment style in find_kaddr_cb (Emil Tsalapatis)
- Fix misleading "override the offset" comment to match offset +=
  semantics (CI bot review)
- Remove pr_info calls from bpf_testmod_dup_sym init/exit (Emil
  Tsalapatis)

[1] https://lore.kernel.org/bpf/20260224172340.1704618-1-andrey.grodzovsky@crowdstrike.com/

Andrey Grodzovsky (2):
  libbpf: Handle duplicate kprobe symbols in attach_kprobe_opts
  selftests/bpf: Add tests for duplicate kprobe symbol handling

 tools/lib/bpf/libbpf.c                        | 154 ++++++++++++++++--
 tools/testing/selftests/bpf/Makefile          |   2 +-
 .../selftests/bpf/prog_tests/attach_probe.c   |  63 +++++++
 .../testing/selftests/bpf/test_kmods/Makefile |   2 +-
 .../bpf/test_kmods/bpf_testmod_dup_sym.c      |  48 ++++++
 5 files changed, 249 insertions(+), 20 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/test_kmods/bpf_testmod_dup_sym.c

-- 
2.34.1

