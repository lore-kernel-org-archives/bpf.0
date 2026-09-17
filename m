Received: from mx0b-00206402.pphosted.com (mx0b-00206402.pphosted.com [148.163.152.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EAE84DEC39
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 20:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.152.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789677048; cv=none; b=RIZ3GyCHN7awxqrKivRFUuvKm+u7JI8sWWXDrt48ix4BayGm0gRWv/tKno6kVxj8HeUTG0uti/rfoRTAT60THoUkg9IHbGsShLYvTMEXTFfciWtPjowDNPKDbyAUXMMoT/3lqPeF4s9ta8IP5SpVm6ASii/8pjnRumu5Sucias4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789677048; c=relaxed/simple;
	bh=8JTJbDWgIqkGKk5L15iDVEjAhHFI+IZey9bnAK4dLnY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uBxuU9Kdd4U6SCUAjUcottsTsuALenNmUUbzzxlbe6GtMfrBKBOznVfSUKys4AYYcSL18GGsUzAvPOi842wS+Pe1cgeTQAB/XnLSla+/kpmHdyjZARF8l5TdD9Mwg11JVJXjLpae5PYYccVsoRbPtlDvHXFqPhHJ2ArefIW9gNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=ihUUtzQ5; arc=none smtp.client-ip=148.163.152.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="ihUUtzQ5"
Received: from pps.filterd (m0354653.ppops.net [127.0.0.1])
	by mx0b-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68HII6wE3369870;
	Thu, 17 Sep 2026 20:30:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=default; bh=iC27dVEm6KkF0
	5KNSd0cKzaqnk4GsFOes0V9gi++bEU=; b=ihUUtzQ51q1bdhvLpFfUtpt274Hu9
	1YrquI3ouSoIzjxAN+kH8zjM8v3lH+g2r5/2QL1v0SxwqCHIN0+sR455u52JSfRn
	YVLuUklENLIhOB1FDGBBYx+6ASPjOBs43gSGzzGp7voTVOTG97ogJuy5d38IF2Sj
	d0rGknGqHMdDlB/vmo4aA0ZcKqrDHevQsJ0Tt4GZseLjhxfeFLHOfdAcZn4Rc1+g
	nEFp1zpqWy8oE8i9J2dAVS0euSxb6vWHmL+RosMSXAU4styWXGMpDzs/ZPyVOWFv
	wweDTftBMHHJEEt1OIgFhijbQOm21v/3ySFksrGmkuSrLKtVH01f5Inag==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0b-00206402.pphosted.com (PPS) with ESMTPS id 4gr3dpmbuy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Sep 2026 20:30:43 +0000 (GMT)
Received: from LL-DJCZ134.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 17 Sep 2026 20:30:41 +0000
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
To: <bpf@vger.kernel.org>, <andrii@kernel.org>
CC: <ast@kernel.org>, <martin.kelly@crowdstrike.com>,
        <slava.imameev@crowdstrike.com>, <linux-open-source@crowdstrike.com>
Subject: [PATCH bpf-next v3 0/6] libbpf: BPF program manual loading
Date: Thu, 17 Sep 2026 16:30:34 -0400
Message-ID: <20260917203040.3150212-1-andrey.grodzovsky@crowdstrike.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: 04WPEXCH006.crowdstrike.sys (10.100.11.70) To
 04WPEXCH006.crowdstrike.sys (10.100.11.70)
X-Proofpoint-ORIG-GUID: Ucb0qt-Dk6voBKGP8LtlXasi2lq2J6k6
X-Proofpoint-GUID: Ucb0qt-Dk6voBKGP8LtlXasi2lq2J6k6
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDI5NCBTYWx0ZWRfX4v5CWNnJyIOR
 QKvAD9uJpXLvDejk6TEH8UKLXygMqhN8V6f9OITF78aAwzZJs4kFv2wolDcV7lMtAAhnqSEzN+W
 jCaM352UYkp9fV4qfRkOmlV3NcAXxsQu3hP7+Cc/HBaVjd4h6lv4
X-Authority-Analysis: v=2.4 cv=UerE26SN c=1 sm=1 tr=0 ts=6aac4df3 cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=T2KQ53IYiC3MXPrxx8bB:22 a=GCXdLZfFv8EKBZhKOxZ5:22 a=VwQbUJbxAAAA:8
 a=pl6vuDidAAAA:8 a=2N8umP1GK9bXaOz3IUkA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDI5NCBTYWx0ZWRfXyNpQqC6z4k+N
 Zuf6bjNuAkTlnKpxJPJCHTkSkg1q7V+Fmx5V8/mUllETgoHa2NeKBsjrkq61MdCbErn4Nrl2n2u
 N/JCC/24W9GFFzNq4XkcLARmZr2yCrEegy6EBsigRl9eLTz9MX+olLs5ea64GffeEA+n7OGvDq4
 MKvrow1VS7MXSF7jjROwl3UbdmxxysYNnZSozJQR0gu9yijQACf/uLOQHA+5ViA+7A3brvnn+Xr
 Te+fM9s0GjF1ddmXqn2pC/BInA+xlw75ZjAGlXJ3gEPUfgjEjiOARTDKC4D854b9uPW73EfJ6UV
 +WAjvBONzL38Tioju12U09kzvgIq3sbcQKl04wErezZzYM8icDgJ5JN/zNy9sde/v9VASZ5WanJ
 fxuaBop00/fMwgXmP90K4gzSv97CAzYYnU+LDzUglmhXSeEIA+OHk2J/JwaQqZDCICkJ7SVf+yY
 979lGSWs1WHYeBli6bA==
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11908
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 phishscore=0 spamscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609170294

This series was originally posted in January 2025 [1] as a two-patch RFC
introducing a per-program tri-state load strategy (disabled/auto/dynamic)
to let large BPF applications load a subset of their programs lazily,
after the initial bpf_object load. v2 [2] kept the same per-program enum
and added a bool-compatible bpf_program__set_autoload() shim plus a
declarative BTF decl_tag marker. This v3 renames DYNAMIC to MANUAL,
replaces the decl_tag marker with a SEC("!...") prefix, relaxes the
load gate to right after bpf_object__prepare(), adds support for
kernel module attach targets, and fixes bugs and addresses comments
identified in v2's review (see the changelog below).


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

 1/6: replace bpf_program's boolean autoload field with an enum
      (bpf_prog_load_strategy: DISABLED/AUTO), so a third state can be
      added later without an ABI break

 2/6: add BPF_PROG_LOAD_STRATEGY_MANUAL and
      bpf_program__load_manually()/unload_manually(), letting a program
      be loaded and attached independently of the bulk bpf_object
      load/attach pass, and reloaded/reattached multiple times

 3/6: let a program mark itself MANUAL from its own section name via a
      SEC("!...") prefix, instead of requiring an imperative
      bpf_program__set_load_strategy() call, mirroring the existing
      SEC("?...") convention

 4/6: reject bpf_object__gen_loader() for an object with a MANUAL
      program, which would otherwise silently corrupt every later
      program's generated prog_fd slot

 5/6: selftest covering every load-strategy transition
      (DISABLED/AUTO/MANUAL), bpf_program__set_autoload()'s bool
      compatibility, and autoattach restoration

 6/6: selftest covering the manual load/attach/detach/reload cycle, the
      declarative SEC("!...") marker, prepare()-only load sufficiency,
      a module BTF deferred load, and gen_loader rejection

Changes since v2 [2]:
  - Rename load_type -> load_strategy, DYNAMIC -> MANUAL throughout the
    API surface (Andrii)
  - Move the declarative marker from a BTF decl_tag to a SEC("!...")
    prefix (Andrii)
  - Relax bpf_program__load_manually()'s gate from OBJ_LOADED to
    OBJ_PREPARED (Andrii)
  - Compute has_manual_progs upfront in bpf_object_prepare_progs()
    instead of tracking it incrementally (Andrii)
  - Drop the bool->enum conversion of bpf_program__set_autoload()
    entirely; it stays bool-signature and becomes a thin, unconditional
    forwarder to set_load_strategy() (Andrii: "let's just leave it be")
  - Fix set_load_strategy()'s DYNAMIC->AUTO/DISABLED transition never
    restoring prog->autoattach (bot+bpf-ci)
  - Drop the premature SEC_ATTACH_BTF early-reject in
    set_load_strategy(MANUAL) (bot+bpf-ci and Andrii independently)
  - Reject gen_loader for objects with an already-MANUAL program: a
    MANUAL program is invisible to gen_loader's program count, silently
    shifting every later program's generated prog_fd slot (bot+bpf-ci)
  - Reject load_manually() with -EBUSY when prog->fd is already open,
    instead of silently overwriting it and leaking the previous fd
    on repeat load without an intervening unload (sashiko-bot)
  - Reject bpf_program__set_autoattach() for a MANUAL-strategy program
    (its signature changes from void to int accordingly), since setting
    autoattach directly would corrupt the value saved_autoattach
    restores on the next transition back to AUTO/DISABLED
  - Wrap load_manually()'s raw error via libbpf_err() and fix a NULL-
    check ordering bug (sashiko-bot); drop a redundant !obj check --
    prog->obj is an invariant elsewhere in libbpf.c (Andrii)
  - Drop the extra_log_level parameter from load_manually(); callers
    already have bpf_program__set_log_level() (Andrii)
  - Expand selftest coverage: a prepare()-only load-sufficiency test
    with attach + execution verification (closes the gap behind
    Andrii's OBJ_PREPARED question above), a module BTF deferred-load
    regression test, and a gen_loader-rejection test

[1] https://lore.kernel.org/bpf/20250122215206.59859-1-slava.imameev@crowdstrike.com/
[2] https://lore.kernel.org/bpf/20260826181825.1826541-1-andrey.grodzovsky@crowdstrike.com/

Andrey Grodzovsky (3):
  libbpf: Support declarative manual load via SEC("!...") prefix
  libbpf: Reject gen_loader for objects with already-manual programs
  selftests/bpf: Cover BPF program manual loading

Slava Imameev (3):
  libbpf: BPF program load strategy enum
  libbpf: BPF programs manual loading and attaching
  selftests/bpf: Cover BPF program load strategy transitions

 tools/lib/bpf/libbpf.c                        | 234 +++++++++---
 tools/lib/bpf/libbpf.h                        |  40 +-
 tools/lib/bpf/libbpf.map                      |   4 +
 .../selftests/bpf/prog_tests/dynamicload.c    | 350 ++++++++++++++++++
 .../selftests/bpf/prog_tests/load_type.c      | 157 ++++++++
 .../selftests/bpf/prog_tests/signed_loader.c  |  28 ++
 .../selftests/bpf/progs/test_dynamicload.c    |  54 +++
 .../selftests/bpf/progs/test_load_type.c      |  31 ++
 8 files changed, 854 insertions(+), 44 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/dynamicload.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/load_type.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_dynamicload.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_load_type.c

-- 
2.34.1

