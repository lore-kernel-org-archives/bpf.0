Received: from mx0b-00206402.pphosted.com (mx0b-00206402.pphosted.com [148.163.152.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7032222D0
	for <bpf@vger.kernel.org>; Sat, 10 Oct 2026 14:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.152.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791643549; cv=none; b=toL5JyzqQRymSrww1qbDyfextlEKVjqknu6AqiC5xjMdtyc5kKJCVc0g4usr6ai3/5Z1CLOuz3+eruFrizeVJSnUZi6Vn+3q1r3ZYP+NA3Q5L3SseeHfdhqvXxS/OQrjUYAbDslbz56QcS9b9MStmIWwprLo32ijR0rBQE0pFpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791643549; c=relaxed/simple;
	bh=jSt2lHoyx7bvYEgBfZyGk46bMUELZ0WaXrZtOHHPxrY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TUW74tvX6T57HI1EAlV/9n3epQqsJKLYqZbUhLZJV+6Rt41HhI98Xp87L+JoEv4hVJQvwNBKhInKf6PL3g6/FYxgzOVZqxUTA/seP3XjW5mP9hFr1BWErV3Mmx8Zc5QTDT6r1s6MwvH2CZ1nLNMaRBTM9CxZuOuV8nzqYt9P7do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=qkCsOuA5; arc=none smtp.client-ip=148.163.152.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="qkCsOuA5"
Received: from pps.filterd (m0354655.ppops.net [127.0.0.1])
	by mx0b-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69ADL4KC2352066;
	Sat, 10 Oct 2026 14:31:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=default; bh=g/B4YY7qIFqHO
	X6sQZSAnKRTk9wsRMqBhIeQY3GaRg0=; b=qkCsOuA5c3DBLPBCPLkjcJzD5vCtp
	laafKU7ysVeRVGbdIFcnIMSWctRroV1SqxYdeMzsaf09UtA845HwfSXN8vPLo2H1
	no8970Nfv32F/mz9EOSW9c2NXBcTs49DuL4DAt8Z4lrGXpdZxaG+PBZOaDcke6h1
	i09G8R5qtmzBEWGI2phr/YRlEzfDQA/PTgtnxfhwWkam46eY2VaqK2O09AMq3j1F
	S3skmTKr4ErK3h73xMIOGYTyiZGfIVChmZocGY58Vey60AEo5XB7+093D6lcJXAp
	T6EkVhuGLnzxoICDkv/pChhtDnFU6/XlkMj51chUC872Kq5a3u3kHQm1w==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0b-00206402.pphosted.com (PPS) with ESMTPS id 4h74ukam91-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 10 Oct 2026 14:31:59 +0000 (GMT)
Received: from LL-DJCZ134.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Sat, 10 Oct 2026 14:31:57 +0000
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
To: <bpf@vger.kernel.org>, <andrii@kernel.org>, <ast@kernel.org>
CC: <martin.kelly@crowdstrike.com>, <slava.imameev@crowdstrike.com>
Subject: [PATCH bpf-next v6 0/7] libbpf: BPF program manual loading
Date: Sat, 10 Oct 2026 10:31:49 -0400
Message-ID: <20261010143156.379864-1-andrey.grodzovsky@crowdstrike.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEwMDA1NyBTYWx0ZWRfX5NrWJBNtpV/r
 PMvVzuYuKVlomXQ7qOQZHLyBn6HGkvtINdITgRsnAh1s/wokHlLmGmYdIM/vpYAP6CxQ/Q51+me
 sScKNoblbrxKSofpPKS6ftx2Lojp+Nj/mpaUbHN1uBQXLQu4gNm5UkdIGW9BteNzVbMTgCrzzzz
 WTjuc12VXx83HNMeNkGA6zTNdUk0Od46BJTf3gMiqOcO7Q1zLv1sB2DG3bs0LMaWIkgPuXLObNE
 zLeELQgopsQhx1MhETLtBLfA0OtO76Ba09MKfcOWOVxV+Bd+6tWzt1xl7z5Md88PmEmNg+YZiaz
 YV8aJJYuI95z+PNN21tI1/wNEA60kVCBlRNAaAlrwm9bL/OVAwlSkcy39cfTm43FH5cYLu/DtuO
 /+RqZwZ5wnJ/ximBwFDDywybP82UsM22STCinWApLfCvsWB1Dy05UCZa2JHcZeDaU1M6ceDU7VE
 3Gpe8WnD9QK4OPfQdJg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEwMDA1NyBTYWx0ZWRfX+87K60/rTw/x
 lqIa/qGBcTuWW+cgWU8PtVQH58dozSpStng3Jun7CCzZnuu9A+nzTI+jHw/+IKK2cr6zoiawcnl
 SGcTXy4Gq+iUG3UINWzGnZ5CsJK2X3pkJmxXqflaNWUCIb402B5q
X-Authority-Analysis: v=2.4 cv=Ts5zFzXh c=1 sm=1 tr=0 ts=6aca4c5f cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=T2KQ53IYiC3MXPrxx8bB:22 a=vDKVRhTs-M86Ea50iKLw:22 a=VwQbUJbxAAAA:8
 a=pl6vuDidAAAA:8 a=T2pYpgpeBa3Ts2VgtgwA:9
X-Proofpoint-GUID: S2cwPZuuGOikoAPw79IXHgC_Bo-Nd8BI
X-Proofpoint-ORIG-GUID: S2cwPZuuGOikoAPw79IXHgC_Bo-Nd8BI
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11931
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015
 adultscore=0 spamscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610100057

This series was originally posted in January 2025 [1] as a two-patch RFC
introducing a per-program tri-state load strategy (disabled/auto/manual)
to let large BPF applications load a subset of their programs lazily,
independent of the initial bpf_object load. This v6 addresses v5's review
feedback.

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
      a module BTF deferred load, and gen_loader rejection

 7/7: convert veristat to use manual programs instead of cloning

Changes since v5 [2]:
  - Drop the bpf_program__set_autoattach() ABI versioning (Andrii)
  - Restore autoattach orthogonality to the load strategy: it is no longer
    saved and restored on strategy set (Andrii)
  - Reject setting gen_loader once the object is PREPARED, and detect
    the MANUAL program vs gen_loader conflict once in bpf_object_prepare()
    instead of in the setters (Andrii)
  - Simplify bpf_object_cleanup_btf() to a single early return (Andrii)
  - Reject a MANUAL program that is a prog array slot target but has not
    been loaded yet (sashiko-bot)
  - Relax the per-program log level and log buffer setters for MANUAL
    programs to work post OBJ_LOADED state so veristat does not lose the
    verifier log when bpf_object__prepare() fails (bot+bpf-ci)
  - Allow MANUAL mode on struct_ops programs through the imperative API so
    veristat can keep verifying them one by one while still rejecting the
    declarative SEC("!...") form (bot+bpf-ci)
  - Various cosmetic cleanups - comment clean-up and rewording, file
    renames to more correctly reflect their content

[1] https://lore.kernel.org/bpf/20250122215206.59859-1-slava.imameev@crowdstrike.com/
[2] https://lore.kernel.org/bpf/20260923232939.1886328-1-andrey.grodzovsky@crowdstrike.com/

Andrey Grodzovsky (4):
  libbpf: Reject gen_loader set after PREPARE step.
  libbpf: Support declarative manual load via SEC("!...") prefix
  selftests/bpf: Cover BPF program manual loading
  selftests/bpf: Convert veristat to BPF_PROG_LOAD_STRATEGY_MANUAL

Slava Imameev (3):
  libbpf: BPF program load strategy enum
  libbpf: BPF programs manual loading and attaching
  selftests/bpf: Cover BPF program load strategy transitions

 tools/lib/bpf/libbpf.c                        | 278 +++++++++++++--
 tools/lib/bpf/libbpf.h                        |  67 +++-
 tools/lib/bpf/libbpf.map                      |   3 +
 .../selftests/bpf/prog_tests/load_type.c      | 154 ++++++++
 .../selftests/bpf/prog_tests/manual_load.c    | 336 ++++++++++++++++++
 .../selftests/bpf/prog_tests/signed_loader.c  |  32 ++
 .../selftests/bpf/progs/test_load_type.c      |  31 ++
 .../selftests/bpf/progs/test_manual_load.c    |  54 +++
 tools/testing/selftests/bpf/veristat.c        |  20 +-
 9 files changed, 923 insertions(+), 52 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/load_type.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/manual_load.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_load_type.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_manual_load.c

base-commit: 15b578b1715d9a318c804350d98af87c203672bc
-- 
2.34.1

