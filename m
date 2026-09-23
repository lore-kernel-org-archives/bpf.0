Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AAB93CF67F
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 23:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.148.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790206192; cv=none; b=H678nNaPteYBIcNODlB2DFpAxRrajnBC0Uh8btb8DQ0wCcQ6cZlkNV8tNylQA0DHsheCteCA1XKHuGExhrlNkrOG0Y5TlkvGqNSrBapSMMDnm5TQ2WZOFnyZYG3JuxtCQJwMqa/5N7ztTZ5p4w4iR9d/T6N6CN1sUiXSz9b4GEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790206192; c=relaxed/simple;
	bh=SRXiV4O4D0kcRjL6j+3P4+2rrBPK5PET3DMy7dS/51g=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qlM/R9v1ZBSupoP5tC+HJjveABt+nje4QE+JAKb4ZLvaf0ww/iAfJzC9YZweH/bJRSW3KjcPfDdj6GKST/z6erK9tizElAjMl6P6DVyFCThoLIz5uHZ/OaET1fv6LtXJdbcas58fUCzZY1hMIFN5OyS3tnf5TKWyRNcr2/iIM78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=d+rWR6jE; arc=none smtp.client-ip=148.163.148.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="d+rWR6jE"
Received: from pps.filterd (m0354650.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68NKKqQv1558467;
	Wed, 23 Sep 2026 23:29:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=default; bh=iv1YQrFU6xKUL
	dYMOZZL6Qp4GSG8hnFHAkJcHmJMggo=; b=d+rWR6jEfAQ+yrIo0MRC4wrtXrIkS
	2p1Nfst98DtT3RIWK5PZKoaxn8eMOzefkJy2wv3naiCrk1UUPLUgqwDHyiel9kJi
	YN9/tE6Ooqsz1EYQnzRZ2ho+ssGhWd5fSGlhAC55vzUby88ARe7VH9QQv6bmNH/T
	/6HE3rwf/2fROpFwVpULidiEqVFuF2rIx9uUK8CXANremMMltHnYCQEx4zPzHD/5
	8XjzkRJrLu8Obf2BYzUrN/bYyG3JVeMchMbxGYgS77zEMKqXChwg6Nv091z1j1N9
	0m6Mo7iZ9f2gIMEeM4GRo80y6A//4cu1Xuub4/j27RQBWxDrQ/Pw7jAyQ==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 4gvnqq0h2w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Sep 2026 23:29:41 +0000 (GMT)
Received: from LL-DJCZ134.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 23 Sep 2026 23:29:39 +0000
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
To: <bpf@vger.kernel.org>, <andrii@kernel.org>, <ast@kernel.org>
CC: <martin.kelly@crowdstrike.com>, <slava.imameev@crowdstrike.com>,
        <linux-open-source@crowdstrike.com>
Subject: [PATCH bpf-next v5 0/8] libbpf: BPF program manual loading
Date: Wed, 23 Sep 2026 19:29:31 -0400
Message-ID: <20260923232939.1886328-1-andrey.grodzovsky@crowdstrike.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA5NSBTYWx0ZWRfX3Sz12WEnsyUJ
 04Y7ZepHpz8z/HrEmoWsf1UNaawu5dHNpgypJ0a+9SNiFDm84ehFtOMKVrESIAAQeE00Cum10kA
 8aZc1f/ro9CZTcCrms+zeqb0tf6dEeqsFAJN6oyRWJa0hwWmzKHtvfst1zqNdEynYP/4Nta3sOa
 UzlTPVN5yMxCRjMp2BIlGynyTwPPAePFgThXq7JyiXifxoUPtUyUYtznzCNtLyIbZJ1bakEXd/y
 24RvPwpu6jrVbdvoRSxw+ee6SSH74qLZnogdnBVNDPgi5OeN9sgpF2JsqgOu8qcHCKzyXQD3cHM
 BIkj8k6UmVzcPUBECLO5VpTWXUJ0s5ig3b3srtaUH8fGiK8ebZNt4OX/i6JeQt9+P/U6+fuZEag
 0dEbJ4OAwt5Ru/0OvHGD9GrzOxQTeKHnsvISZ0yZUjP1db2n1xuADFmTirrhAT/gJ1VbvGAEUhF
 Ff9NyLnvSWQqHAK1m9Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA5NSBTYWx0ZWRfX7R51McQEBRTf
 PM5N7m/33qxXHQnfFnMjemkr0GSjlJSFv0vj/XnwsTx0gLToQ7FoQI8mPIqZTPYvyJzEcQ52mVm
 3t6IrMznWldwSWpAhOlHcYKtg38f5fTOIQ6UQGAiLj3fQ8Q0NKtI
X-Authority-Analysis: v=2.4 cv=Is2L47/g c=1 sm=1 tr=0 ts=6ab460e5 cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=T2KQ53IYiC3MXPrxx8bB:22 a=t04HzT_fAfAF5W-3wVZy:22 a=VwQbUJbxAAAA:8
 a=pl6vuDidAAAA:8 a=JIiqLPRgoz_q3ykvEXwA:9
X-Proofpoint-GUID: WKQJZm9kBnWuk_3Ml-nm4SA5VqYi3GKA
X-Proofpoint-ORIG-GUID: WKQJZm9kBnWuk_3Ml-nm4SA5VqYi3GKA
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11914
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 adultscore=0 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 phishscore=0 suspectscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230095

This series was originally posted in January 2025 [1] as a two-patch RFC
introducing a per-program tri-state load strategy (disabled/auto/dynamic)
to let large BPF applications load a subset of their programs lazily,
after the initial bpf_object load. This v5 addresses v4's review
feedback and converts veristat's per-program verification from
bpf_program__clone() to this series' own manual-load API, closing the
loop on the open item from v2/v4 (see changelog below).


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
window during which the system it protects is unprotected.

We have been running this with our internal fork of libbpf in production
for about a year. Depending on kernel and configuration support, around
250 of our programs are potentially loadable on any given system; with
manual loading, only around 90 of those are actually loaded by default,
growing to the full 250 only when every optional feature is enabled.
Cutting the default set of loaded programs from 250 down to 90 measurably
reduces load time (we observed ~60% reduction in our own measurements),
and since unload time scales with the number of loaded programs, it
correspondingly shortens unload time as well -- which matters, since
slow unload can delay system shutdown. We believe this functionality
would benefit other libbpf consumers with similarly large, modular BPF
applications.

Patch overview:

 1/8: replace bpf_program's boolean autoload field with an enum
      (bpf_prog_load_strategy: DISABLED/AUTO), so a third state can be
      added later without an ABI break

 2/8: add BPF_PROG_LOAD_STRATEGY_MANUAL and bpf_program__load()/
      bpf_program__unload(), letting a program be loaded and attached
      independently of the bulk bpf_object load/attach pass, and
      reloaded/reattached multiple times

 3/8: let a program mark itself MANUAL from its own section name via a
      SEC("!...") prefix, instead of requiring an imperative
      bpf_program__set_load_strategy() call, mirroring the existing
      SEC("?...") convention

 4/8: reject bpf_object__gen_loader() for an object with a MANUAL
      program, which would otherwise silently corrupt every later
      program's generated prog_fd slot

 5/8: version bpf_program__set_autoattach()'s void->int return-type and
      behavior change via ELF symbol versioning (COMPAT_VERSION()/
      DEFAULT_VERSION()), modeled on the xsk_umem__create and
      bpf_prog_load precedents, so binaries already linked against the
      old void-returning ABI keep that behavior instead of silently
      hitting the new MANUAL-rejection logic underneath them

 6/8: selftest covering every load-strategy transition
      (DISABLED/AUTO/MANUAL), bpf_program__set_autoload()'s bool
      compatibility, and autoattach restoration

 7/8: selftest covering the manual load/attach/detach/reload cycle, the
      declarative SEC("!...") marker, prepare()-only load sufficiency,
      a module BTF deferred load, and gen_loader rejection

 8/8: convert veristat's process_prog() from bpf_program__clone() to
      BPF_PROG_LOAD_STRATEGY_MANUAL + bpf_program__load()/
      bpf_program__unload(), the open item from the v2 and v4 threads

Changes since v4 [2]:
  - Fix a stray comment in bpf_object__init_prog() (bot+bpf-ci, sashiko-bot)
  - Check the previously-ignored return value of
    bpf_program__set_load_strategy() for prog1/prog2 in load_type.c,
    consistent with every other call to the same setter later in the
    same file (sashiko-bot)
  - New: convert veristat's process_prog() to use
    BPF_PROG_LOAD_STRATEGY_MANUAL/bpf_program__load()/
    bpf_program__unload() instead of bpf_program__clone(), RODATA maps get 
    bound on each per-program load the way clone() deliberately avoids, but 
    since each program is unloaded again immediately after verification, the
    binding is dropped along with it (Andrii, Alexei)


[1] https://lore.kernel.org/bpf/20250122215206.59859-1-slava.imameev@crowdstrike.com/
[2] https://lore.kernel.org/bpf/20260921223937.3203093-1-andrey.grodzovsky@crowdstrike.com/

Andrey Grodzovsky (5):
  libbpf: Support declarative manual load via SEC("!...") prefix
  libbpf: Reject gen_loader for objects with already-manual programs
  libbpf: Version bpf_program__set_autoattach() ABI change
  selftests/bpf: Cover BPF program manual loading
  selftests/bpf: Convert veristat to BPF_PROG_LOAD_STRATEGY_MANUAL

Slava Imameev (3):
  libbpf: BPF program load strategy enum
  libbpf: BPF programs manual loading and attaching
  selftests/bpf: Cover BPF program load strategy transitions

 tools/lib/bpf/libbpf.c                        | 281 +++++++++++---
 tools/lib/bpf/libbpf.h                        |  69 +++-
 tools/lib/bpf/libbpf.map                      |   5 +
 tools/lib/bpf/libbpf_common.h                 |   6 +
 .../selftests/bpf/prog_tests/dynamicload.c    | 365 ++++++++++++++++++
 .../selftests/bpf/prog_tests/load_type.c      | 190 +++++++++
 .../selftests/bpf/prog_tests/signed_loader.c  |  28 ++
 .../selftests/bpf/progs/test_dynamicload.c    |  54 +++
 .../selftests/bpf/progs/test_load_type.c      |  31 ++
 tools/testing/selftests/bpf/veristat.c        |  20 +-
 10 files changed, 990 insertions(+), 59 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/dynamicload.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/load_type.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_dynamicload.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_load_type.c

-- 
2.34.1

