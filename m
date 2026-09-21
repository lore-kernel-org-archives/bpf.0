Received: from mx0b-00206402.pphosted.com (mx0b-00206402.pphosted.com [148.163.152.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACABC519922
	for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 22:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.152.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790030399; cv=none; b=aLiyZNrjG87/T/2QcbFc4pHcuXuLV0aamZOQag/EA9muNj4nvJ96YTeZXSlhCuTTrlpVQUM1OdIFB802bfQOF842tiueE58Vb8odQHNpMTB2uTOZ2rW6sLVB4jyOMySHupam+05ePtKscFXIqMdV1UyEf9OFi+fjtFZ3pf/5zwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790030399; c=relaxed/simple;
	bh=NEV9tFJl0NY7l1qIWSQXyfhkq5I6qUz1pMy+U90/o2w=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Q8pQrQVFK84wWLwkluvQnCDXrgZMan0friUhWHVt6iAo/jHbsdBTjbIUUDf32TXbqrdaiz2D1J09fFQBm57S/jUoNKjqbY9URXgxgI9SlFz8HB1DkwqvGuZyD0X6ToyZCr7vhmBeeLjWvbV7jRX+kNI99/343E3lGwoFZ/CmFmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=aIvZnyDX; arc=none smtp.client-ip=148.163.152.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="aIvZnyDX"
Received: from pps.filterd (m0354654.ppops.net [127.0.0.1])
	by mx0b-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68LIoo4B3069599;
	Mon, 21 Sep 2026 22:39:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=default; bh=n5girL2mctrvj
	1Y+9UQEzByvPI3faLsxskZGa15QCn0=; b=aIvZnyDXyGwt1Fkqivv3+Mt9kJIr4
	fDzvT106NtIq3eDNZMxMiiDGcqkX1g7vhFe+bXTPIiZQ5i6UgIiA/KXVmaNuJr6Q
	UIyfzPE4dKzVtvdX1i1G5rr6mn/qmP86ps6eoUSlYlxCbY84hB/7euxhY09A2sFO
	sy47SBak6AiPk7WJlalAMhPuoFm8sNhGK4uGdIElt5Xsv7LTnLmww9wPkK+Jahgk
	x5nMDpEXCmwxSwtPwrbPL0iIFCG/LfQhlI3lRLXr7QHuqZHaW/qXD/x/FNLFI5Vb
	arSMMahi/xTrMBt4+mv0fLpy7MTW/oJVVhIq1Ki9g6DDJQDXPd8RbLskw==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0b-00206402.pphosted.com (PPS) with ESMTPS id 4gua798q06-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Sep 2026 22:39:40 +0000 (GMT)
Received: from LL-DJCZ134.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 21 Sep 2026 22:39:38 +0000
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
To: <bpf@vger.kernel.org>, <andrii@kernel.org>
CC: <ast@kernel.org>, <martin.kelly@crowdstrike.com>,
        <slava.imameev@crowdstrike.com>, <linux-open-source@crowdstrike.com>
Subject: [PATCH bpf-next v4 0/7] libbpf: BPF program manual loading
Date: Mon, 21 Sep 2026 18:39:30 -0400
Message-ID: <20260921223937.3203093-1-andrey.grodzovsky@crowdstrike.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDMzMSBTYWx0ZWRfX4RWLzH4354nN
 TOZTfbZfqYaXOKq6P3o35E4XhXnI2rFB0cqFsk9bnz4Tj6ve7gg73N+wMRB1VP4hAu1hLeWbBXr
 yMjM3Ji2e7/cwyRs4FMbq8KKPiu2X2gKoAQ/9KsIn8fq1hfiZJWq
X-Proofpoint-ORIG-GUID: pgB2vGArkGM2Pe-n_LAimRXGNPzTOlNd
X-Authority-Analysis: v=2.4 cv=QMP91QLL c=1 sm=1 tr=0 ts=6ab1b22c cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=T2KQ53IYiC3MXPrxx8bB:22 a=R_n4Uisa8axJ7jemP0ek:22 a=VwQbUJbxAAAA:8
 a=pl6vuDidAAAA:8 a=IgsrHIQV9rkwUFSq4k0A:9
X-Proofpoint-GUID: pgB2vGArkGM2Pe-n_LAimRXGNPzTOlNd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDMzMSBTYWx0ZWRfX1txIzCBb4B12
 SB5s1kLUYdU1c/nmFkPTFy9p7X+dgPSff6y6+KPr2reR1U99AOaZcIy3ehs7xgqmRiL7OLasm1v
 PrKmu7FJtfgr71J60dMenoOmBGVcreRILw/wOZFSyXvMBVi2+ohf3Uxbbh+5MTKPkNtKhx0nZS9
 Y9cp+D9jZUoAcydw67oVs5Vcnl3w8fVhBfXN7XFSaxCnC3W0KOXoAC2LOPEmOzhAO49hZXKGuLi
 TaYME2V+Weqg9nDvhDF7FpLfvAtoweXdyg1TMRCCqVXUdHDZvamJtoHHxyPPsUx9wPiS/6uCwwk
 u/u+BBtuciW7tJIMo7JnL5PJIaMwts1C125T0fNgBRzhk3egKPxN5WiWiZ9UP7RAER9rrcHI7uK
 jlt4whtkih8Oh3e4JwbTFzNi57FKyD8pVU2lx4tyeu/FbwtitVXcPYpp4/up0JlmVaTxR1HOuw4
 JNq+Iio4Y+GtEA1XvOQ==
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11912
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 clxscore=1015 spamscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 adultscore=0 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609210331

This series was originally posted in January 2025 [1] as a two-patch RFC
introducing a per-program tri-state load strategy (disabled/auto/dynamic)
to let large BPF applications load a subset of their programs lazily,
after the initial bpf_object load. This v4 addresses all outstanding review
feedback from v3's two CI bots, folds bpf_program__load_manually()/
unload_manually() into a single load()/unload() naming pair, and adds
a new patch that properly versions bpf_program__set_autoattach()'s
ABI change instead of leaving it as a silent break for out-of-tree
consumers (see changelog below).


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

 1/7: replace bpf_program's boolean autoload field with an enum
      (bpf_prog_load_strategy: DISABLED/AUTO), so a third state can be
      added later without an ABI break

 2/7: add BPF_PROG_LOAD_STRATEGY_MANUAL and bpf_program__load()/
      bpf_program__unload(), letting a program be loaded and attached
      independently of the bulk bpf_object load/attach pass, and
      reloaded/reattached multiple times; unload() is now a single,
      MANUAL-aware verb instead of a separate load()/load_manually()
      and unload()/unload_manually() pair (see changelog)

 3/7: let a program mark itself MANUAL from its own section name via a
      SEC("!...") prefix, instead of requiring an imperative
      bpf_program__set_load_strategy() call, mirroring the existing
      SEC("?...") convention

 4/7: reject bpf_object__gen_loader() for an object with a MANUAL
      program, which would otherwise silently corrupt every later
      program's generated prog_fd slot

 5/7: version bpf_program__set_autoattach()'s void->int return-type and
      behavior change via ELF symbol versioning (COMPAT_VERSION()/
      DEFAULT_VERSION()), modeled on the xsk_umem__create and
      bpf_prog_load precedents, so binaries already linked against the
      old void-returning ABI keep that behavior instead of silently
      hitting the new MANUAL-rejection logic underneath them

 6/7: selftest covering every load-strategy transition
      (DISABLED/AUTO/MANUAL), bpf_program__set_autoload()'s bool
      compatibility, and autoattach restoration -- now including a case
      that discriminates the restore logic from a hard-coded `true`

 7/7: selftest covering the manual load/attach/detach/reload cycle, the
      declarative SEC("!...") marker, prepare()-only load sufficiency,
      a module BTF deferred load, and gen_loader rejection -- updated
      for the merged load()/unload() API and with all four scenarios
      now individually subtested

Changes since v3 [2]:
  - Log the raw error via errstr(err) instead of a bare %d in
    bpf_program__load()'s failure message (sashiko-bot)
  - Let MANUAL programs use the caller-supplied kernel log buffer
    instead of always falling back to libbpf's own realloc'd buffer
    (bot+bpf-ci)
  - Reject BPF_PROG_LOAD_STRATEGY_MANUAL for struct_ops programs:
    bpf_map_prepare_vdata() bakes every member's fd into kern_vdata
    during bpf_object__load(), before a MANUAL member could ever be
    loaded, and nothing re-bakes it afterwards (bot+bpf-ci)
  - Fix bpf_link leaks on every assertion-failure path in load_type.c
    and dynamicload.c (sashiko-bot, bot+bpf-ci)
  - Wrap all 4 dynamicload.c scenarios in test__start_subtest(), so
    bpf_testmod's absence only skips the one scenario that needs it
    instead of masking the other three as SKIP (bot+bpf-ci)
  - Drop the dead !obj->fd_array_cnt disjunct in
    bpf_object_post_load_cleanup()'s fd_array free guard (Andrii)
  - Rename bpf_program__load_manually() to bpf_program__load(), and
    fold bpf_program__unload_manually() into bpf_program__unload():
    split the existing full-free body into an internal
    bpf_program_unload_full() helper used unconditionally by
    object-teardown paths and make the public unload() skip the helper for
    manual programs (Andrii)
  - New: version bpf_program__set_autoattach()'s void->int ABI change
    via COMPAT_VERSION()/DEFAULT_VERSION() instead of leaving the
    symbol under its original LIBBPF_1.0.0 node -- an already-linked
    binary now keeps the old unconditional-set behavior at runtime
    instead of silently gaining the new MANUAL-rejection behavior
    underneath it after a libbpf upgrade (bot+bpf-ci)
  - Misc. cosmetic fixes pointed out by the bots (Sashiko + bpf-ci)

[1] https://lore.kernel.org/bpf/20250122215206.59859-1-slava.imameev@crowdstrike.com/
[2] https://lore.kernel.org/bpf/20260917203040.3150212-1-andrey.grodzovsky@crowdstrike.com/

Andrey Grodzovsky (4):
  libbpf: Support declarative manual load via SEC("!...") prefix
  libbpf: Reject gen_loader for objects with already-manual programs
  libbpf: Version bpf_program__set_autoattach() ABI change
  selftests/bpf: Cover BPF program manual loading

Slava Imameev (3):
  libbpf: BPF program load strategy enum
  libbpf: BPF programs manual loading and attaching
  selftests/bpf: Cover BPF program load strategy transitions

 tools/lib/bpf/libbpf.c                        | 278 ++++++++++---
 tools/lib/bpf/libbpf.h                        |  69 +++-
 tools/lib/bpf/libbpf.map                      |   5 +
 tools/lib/bpf/libbpf_common.h                 |   6 +
 .../selftests/bpf/prog_tests/dynamicload.c    | 365 ++++++++++++++++++
 .../selftests/bpf/prog_tests/load_type.c      | 186 +++++++++
 .../selftests/bpf/prog_tests/signed_loader.c  |  28 ++
 .../selftests/bpf/progs/test_dynamicload.c    |  54 +++
 .../selftests/bpf/progs/test_load_type.c      |  31 ++
 9 files changed, 976 insertions(+), 46 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/dynamicload.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/load_type.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_dynamicload.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_load_type.c

-- 
2.34.1

