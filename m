Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FFB61B87C9
	for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 17:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.148.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771953855; cv=none; b=oLN18bsVblv5caddVA4L5D2xr0PvzzMy474sFV67zQCyMbvGeXnK3NiHznjqAbxk039DGHhlp9lRmUUyrLTGdZ7D+muW1/NIXjhOy/7ZW+9WUHhf/odneLP0WOQ7HbkESu19S0Jm5dlrjbBYH0o3/j5oAnt0gvgwQQAv5KzD4sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771953855; c=relaxed/simple;
	bh=PpJN55ECc4zdXZG5p41jHUR716pQYq7nP2KqFo1W4wA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hYTdp1SsW7VQL/Vl/S/907ewUClVe85nxDhhsZ+EN+OyqGIr3bo8vcyeFKGOVk1bPi7iEZBNzfIBs2NKWDdzMwNwjjRPEGFwenMFEjydUBRtBo+bqj1NbqQrU6+SMEZ0A2Q3cCnyveEJ5qBrQ+Js1xzQEXRffm95HeORgwudE0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=GaldLv56; arc=none smtp.client-ip=148.163.148.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="GaldLv56"
Received: from pps.filterd (m0354652.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61OFqX2N912091;
	Tue, 24 Feb 2026 17:23:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=default; bh=HSaNGBWAimSp8
	6CtoOMNF5Nz9YC5gbbpGsUCNUWxGfs=; b=GaldLv56ayRVBQZEJ6G6+c4w2uHOA
	ac4f36DH9f0HODVcbnaLTkgMtXMNrFda6wHgJl9tuCt6VDTGjowmbIw+ILznnNaR
	GOTaiopLhfQ7/tkvm4g8Hs9ZB/ndrTau6sGV02NvIzAocBQIVJMdNbj4n0WlP5dj
	PJgfQauCcHUXXe2uAvr3oyHgkq2MxK26rtC5iPCv1mXSPEqv9Xz7tiwhM4gKP7Qq
	qF71Rlnyg6wP+ZU6psus+sDoUaz53l8NgAJkeXz6h639mKUE1Z32Qqrn311G2Opm
	/oDL/k351cjTlEHxtS0L51zs8Vc1eSlwkV9NvDXHTFduMBIbi42Kg4sUg==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 4cftgxjva4-9
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Feb 2026 17:23:48 +0000 (GMT)
Received: from LL-DJCZ134.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 24 Feb 2026 17:23:41 +0000
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
To: <bpf@vger.kernel.org>
CC: <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <jolsa@kernel.org>, <emil@etsalapatis.com>,
        <linux-open-source@crowdstrike.com>
Subject: [RFC PATCH bpf-next v2 0/2] libbpf: Handle duplicate kprobe symbols
Date: Tue, 24 Feb 2026 12:23:38 -0500
Message-ID: <20260224172340.1704618-1-andrey.grodzovsky@crowdstrike.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: 04WPEXCH005.crowdstrike.sys (10.100.11.69) To
 04WPEXCH006.crowdstrike.sys (10.100.11.70)
X-Disclaimer: USA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI0MDE0NSBTYWx0ZWRfXxt4FSKDV5q3d
 4sWQYOvmQMti1x6ktw5sATM7RqhhhNH+RilAVRAeXZgrJYf9rn4SozHg5MxWKPGfZShqKNDlDyW
 DZlv9zr1VXln/aqEh8KijriXJbUT7jFNRtXEm6Na8Oh8E2VxWK3iWifbow8+xi/NaLXfLO0TCvq
 oWAG4ZMVN1ZtysDcjyllhCKC87TJDI/jEtBLErXHARptCbRKOECQLdEQOvzauPFW+s6pyLn+dXr
 9LKsMmhZaynPreSI9F46TY9iReLU1Ud21wowRp0J9oDijWw/ICmrPG8FIWPdpQP/V48Ml4yK9zY
 KuqyPP6AWOheYtw4EhtQVk6RHtiVCCTF8EgPJlKK2Ifry9F+GK60Lcuzs1nrdkKBPdA1saPfWnF
 yJa6UEbbRXWFwY7o0ToJny78csUFvRQg9mL6jbnXnogLS2p94sRMSzs+mkenAQRNkXw6eTIc7te
 pUbVwGBRV+zfgPbUkHg==
X-Proofpoint-ORIG-GUID: B6tgVm7Xzl03f9c4IOJrlP371I4el7xa
X-Authority-Analysis: v=2.4 cv=S+XUAYsP c=1 sm=1 tr=0 ts=699ddea4 cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=T2KQ53IYiC3MXPrxx8bB:22 a=2KvRFfd_T_-xjmS8C1aD:22 a=VwQbUJbxAAAA:8
 a=pl6vuDidAAAA:8 a=jaJHa1lccSu8UMVvMLsA:9
X-Proofpoint-GUID: B6tgVm7Xzl03f9c4IOJrlP371I4el7xa
X-Proofpoint-Virus-Version: vendor=nai engine=6800 definitions=11711
 signatures=596818
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 bulkscore=0 suspectscore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2602240145

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

Changes since v1 [1]:
  - Restructure libbpf_kallsyms_parse() loop to use while(true) with
    post-loop feof() error check (Emil Tsalapatis)
  - Remove module_name parameter from kallsyms_cb_t callback signature;
    add bool skip_if_module parameter to libbpf_kallsyms_parse()
    instead (Emil Tsalapatis)
  - Use toupper(sym_type) != 'T' in find_kaddr_cb (Emil Tsalapatis)
  - Add kaddr validation after kallsyms parse -  (CI bot review)
  - Fix NULL pointer passed to %s in gen_probe_legacy_event_name()
    when using absolute address (CI bot review)
  - Fix NULL pointer passed to %s in pr_warn() calls within
    perf_event_kprobe_open_legacy() (CI bot review)
  - Fix memory leak of legacy_probe  (CI bot review)
  - Add forward declarations for arch-specific duplicate symbol
    functions in bpf_testmod_dup_sym.c to fix -Wmissing-prototypes
    warning (Jiri Olsa)

[1] https://lore.kernel.org/bpf/20260218225617.354858-1-andrey.grodzovsky@crowdstrike.com/

Andrey Grodzovsky (2):
  libbpf: Handle duplicate kprobe symbols in attach_kprobe_opts
  selftests/bpf: Add tests for duplicate kprobe symbol handling

 tools/lib/bpf/libbpf.c                        | 153 +++++++++++++++---
 tools/testing/selftests/bpf/Makefile          |   2 +-
 .../selftests/bpf/prog_tests/attach_probe.c   |  63 ++++++++
 .../testing/selftests/bpf/test_kmods/Makefile |   2 +-
 .../bpf/test_kmods/bpf_testmod_dup_sym.c      |  50 ++++++
 5 files changed, 250 insertions(+), 20 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/test_kmods/bpf_testmod_dup_sym.c

-- 
2.34.1

