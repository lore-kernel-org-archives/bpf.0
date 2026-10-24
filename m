Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.152.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792806334;
	b=K5N50+xu38qeoIBuau+5sxbyMA48Zs+Cltr9akXRFfRoskiOiFlzKhEk6ydRCZPm6fSI
	 QPau8dh02qP0IQ+jGrvrkfJGpkxbpb4cXYcNmHUSBbgUk60tHT0nKrbBMI5uiVxW0kHnL
	 pg4ch+IFzbve+GozURCkLBrWi1dn7GectTZQWBd+J6x+TOXnonK0dbhSv7d87bbN4fCSQ
	 kxuNzVHyHedGFAFDaQOrFLpdjcuUHCMW42HdZqaWjC2VFdMC8mRzWCVkTWRV6BmKNg3Ci
	 JYRUbfofcdTXO3aJppDLDhofxmOzg2PLxZI572h+dP64bE+weDPRN+0rz94hs3Iuizw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792806334;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=CHTmwySQAmgxXVIG/0uppB3aZnM78Qj4KhliL2HM/Oo=;
	b=5XUGbmNrobGoqqGXb+UfuTe2AMeIw0tSLp8GpEmhhpRgp7PuWku0BbuUy/3bSadzj2sA
	 dancP5zWyDmoXtyu4UGOre2ZY9badFFqn/cOaTWZeTB0TI3Ql0ajRF7Q+0Xt1qFIfzdOU
	 As9tZiHvyAegS35JoITUbjm0dGF16JxoGUDaudh9Req4y4DuMIKTZYPHy6k55BZWcJJOS
	 OL0hGQjmSDHR92Vkx6W9Gq9FOIhsCQBI3cz5OlNrqZGz+UH1486j4CRPknNEagy5oxp6o
	 ZmX+5RKTg00xf3UOD/Emnv78cGhdXPCnxBL32Z/JcurAtqfcOqLkqDUvlQMOp66Xqlg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=crowdstrike.com;
	spf=pass smtp.mailfrom=crowdstrike.com;
	dkim=pass header.d=crowdstrike.com header.i=@crowdstrike.com header.a=rsa-sha256 header.s=default header.b=iqnbxmRr;
	arc=none smtp.remote-ip=148.163.152.16
Received: from mx0b-00206402.pphosted.com (mx0b-00206402.pphosted.com [148.163.152.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D2D606A31D
	for <bpf@vger.kernel.org>; Sat, 24 Oct 2026 01:45:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 08D2D606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=crowdstrike.com header.i=@crowdstrike.com header.a=rsa-sha256 header.s=default header.b=iqnbxmRr
Received: from pps.filterd (m0354654.ppops.net [127.0.0.1])
	by mx0b-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69O1j5Bt3294896;
	Sat, 24 Oct 2026 01:45:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=default; bh=CHTmwySQAmgxX
	VIG/0uppB3aZnM78Qj4KhliL2HM/Oo=; b=iqnbxmRr5P+FxgOXI6wTBiL/oAVdj
	5hlkP/ObR5YpZ5R55EH/PeIxCH1fxmANs8HbIwv1O9ZEfcPhmJjkf5r+AoHHEYjW
	whGqOZeTM0KWZ8KEP3HPrkBskq8K698/T5fC5YR03uBhOCr8nxEXqQ/JLSAqy2R+
	uXfRfUfa9TCS6BDFU7JOXurgAMvZ/jQr3G8e+D5uI/k8/HDbRxtZSMbRlMlUGwzT
	tDogM2GtB/bPB19qeiCWplqmKcVDk/qDtFWHWJrEycuSDkcuJVDSTKRSjsnC50KD
	1DMd4brG940dLiqbl4PSkJQl1tNjBxWexEjBxppt2ua+euZIU+VLQLkOA==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0b-00206402.pphosted.com (PPS) with ESMTPS id 4hfw62v85d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 24 Oct 2026 01:45:18 +0000 (GMT)
Received: from LL-DJCZ134.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.53; Sat, 24 Oct 2026 01:45:16 +0000
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
To: <bpf@vger.kernel.org>, <andrii@kernel.org>
CC: <ast@kernel.org>, <martin.kelly@crowdstrike.com>,
        <slava.imameev@crowdstrike.com>
Subject: [PATCH bpf-next v8 0/7] libbpf: BPF program manual loading
Date: Fri, 23 Oct 2026 21:45:07 -0400
Message-ID: <20261024014514.2959514-1-andrey.grodzovsky@crowdstrike.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: 04WPEXCH007.crowdstrike.sys (10.100.11.74) To
 04WPEXCH006.crowdstrike.sys (10.100.11.70)
X-Authority-Analysis: v=2.4 cv=I7fw19gg c=1 sm=1 tr=0 ts=6adc0dae cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=T2KQ53IYiC3MXPrxx8bB:22 a=R_n4Uisa8axJ7jemP0ek:22 a=VwQbUJbxAAAA:8
 a=pl6vuDidAAAA:8 a=T2pYpgpeBa3Ts2VgtgwA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI0MDAwNiBTYWx0ZWRfX79PCaJAydxOo
 x+C3xvnk6/Zn0ion6Chqueo0GLdTHRFW0OQZZgQao0NK9OHAMGlFyy5foy/AkTsD1zRA7FH80Pq
 FTbozPBnZRoJxNZDpuJqAR6v8K4cq5paNRQn6u5JOAbLp6AT7u9WYLTHpcpPiMDC5VoU7fMnqqD
 5oUX0CgBGudouc5WkfJ2/FCY8N9sjvEbULE9lE1AVJnSLh6XLtgOfTTDC3hgzU0c6bvXh6wbvmp
 mfN8C4hstTMLmcbhaPZM5X7gyvBE8SxAjEOMWh1z17wJTlQUGfjRRkGfN9YxGD60j3+Mvbk2bwm
 SNEzBztLqs5Kl1d8oik7eeKOjJcETMbxNHK5R0dLR6kvCNgU4ft5oBXx5nNCBgov0dXzlzpWhCF
 r3nApMTbP+eW20mCF9fOEwIFUEKbUO3lwGztQeVZ5LpOegBBIZc0gmcL9HsiLK7HBRmss+sbMGV
 QYVKd8oqbVOODO8NheA==
X-Proofpoint-ORIG-GUID: 4026-I2Ga73zn_SrjnPVugdXF5f22jUg
X-Proofpoint-GUID: 4026-I2Ga73zn_SrjnPVugdXF5f22jUg
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI0MDAwNiBTYWx0ZWRfX7p/7hQxc7UaZ
 qOBA2ME45DEpNiMSOIBpgZ9KO6wevC0r4pxF4gjHvx4fzKqkaU/T/yo97Vo5YnLJKZa7ni145NG
 AHocon9ScXO0x++WnY/k3PoTnnOE9WvlFEpsGtZl5GWImHGXpp9J
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11944
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 priorityscore=1501 suspectscore=0 spamscore=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610240006

This series was originally posted in January 2025 [1] as a two-patch RFC
introducing a per-program tri-state load strategy (disabled/auto/manual)
to let large BPF applications load a subset of their programs lazily,
independent of the initial bpf_object load. 

This v8 fixes a patch that was accidentally corrupted during previous send. No
other changes

Motivation:

Security tools built on top of libbpf commonly ship as a single large
BPF object containing many programs, only a subset of which are needed
on any given system -- the rest are gated on optional features or on
kernel/runtime capabilities that vary across deployments. For this class
of application, per-program manual loading helps in two ways:

  - it shortens the initial load, since only the programs actually
    needed for the running configuration are loaded and attached up
    front instead of the whole object; and
  - it lets a single failing program be unloaded and possibly reloaded
    (or a feature toggled at runtime) without tearing down and reloading
    the entire bpf_object.

Both reduce the time window during which the tool is partially loaded or
inactive -- for a security tool specifically, that is also the time
window during which the system it protects is left vulnerable.

We have been running this with our internal fork of libbpf in production
for about a year. Depending on kernel and configuration support, around
250 of our programs are potentially loadable on any given system; with
manual loading, only around 90 of those are actually loaded by default,
growing to the full 250 only when every optional feature is enabled.
Cutting the default set of loaded programs from 250 down to 90 measurably
reduces load time (we observed ~60% reduction in our own measurements),
and since unload time scales with the number of loaded programs, it
correspondingly shortens unload time as well -- which matters, since
slow unload can delay system shutdown.

We believe this functionality would benefit other libbpf consumers with
similarly large, modular BPF applications.

Patch overview:

 1/7: reject bpf_object__gen_loader() once the object is PREPARED, since
      the generated loader records its steps during prepare

 2/7: replace bpf_program's boolean autoload field with an enum
      (bpf_prog_load_strategy: DISABLED/AUTO), so a third state can be
      added - preparatory commit with no functional changes

 3/7: add BPF_PROG_LOAD_STRATEGY_MANUAL and bpf_program__load()/
      bpf_program__unload(), letting a program be loaded and attached
      independently of the bulk bpf_object load/attach pass, and
      reloaded/reattached multiple times. This also covers the
      interactions with gen_loader, prog array slots, struct_ops and the
      per-program log setters

 4/7: let a program mark itself MANUAL from its own section name via a
      SEC("!...") prefix, mirroring the existing SEC("?...") convention

 5/7: selftest covering every load-strategy transition
      (DISABLED/AUTO/MANUAL) and bpf_program__set_autoload()'s bool
      compatibility

 6/7: selftest covering the manual load/attach/detach/reload cycle, the
      declarative SEC("!...") marker, prepare()-only load sufficiency,
      a module BTF deferred load, a module kfunc deferred load, and
      gen_loader rejection

 7/7: convert veristat to use manual programs instead of cloning

Changes since v7 [2]:
  - Fix 3/7: its libbpf.h hunk was accidentally corrupted when v7 was
    sent, so the series did not apply cleanly and failed CI

[1] https://lore.kernel.org/bpf/20250122215206.59859-1-slava.imameev@crowdstrike.com/
[2] https://lore.kernel.org/bpf/20261022223212.1217849-1-andrey.grodzovsky@crowdstrike.com/

Andrey Grodzovsky (4):
  libbpf: Reject gen_loader set after PREPARE step.
  libbpf: Support declarative manual load via SEC("!...") prefix
  selftests/bpf: Cover BPF program manual loading
  selftests/bpf: Convert veristat to BPF_PROG_LOAD_STRATEGY_MANUAL

Slava Imameev (3):
  libbpf: BPF program load strategy enum
  libbpf: BPF programs manual loading and attaching
  selftests/bpf: Cover BPF program load strategy transitions

 tools/lib/bpf/libbpf.c                        | 265 ++++++++++--
 tools/lib/bpf/libbpf.h                        |  89 ++++
 tools/lib/bpf/libbpf.map                      |   4 +
 .../selftests/bpf/prog_tests/load_type.c      | 154 +++++++
 .../selftests/bpf/prog_tests/manual_load.c    | 393 ++++++++++++++++++
 .../selftests/bpf/prog_tests/signed_loader.c  |  32 ++
 .../bpf/prog_tests/test_struct_ops_arena.c    |  48 ++-
 .../selftests/bpf/progs/test_load_type.c      |  31 ++
 .../selftests/bpf/progs/test_manual_load.c    |  70 ++++
 tools/testing/selftests/bpf/veristat.c        |  20 +-
 10 files changed, 1051 insertions(+), 55 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/load_type.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/manual_load.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_load_type.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_manual_load.c

base-commit: 4169c9c90532df9585c0a2ae513337a58f5e59ab
-- 
2.34.1

