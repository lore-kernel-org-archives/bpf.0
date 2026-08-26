Received: from mx0b-00206402.pphosted.com (mx0b-00206402.pphosted.com [148.163.152.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695C036DA15
	for <bpf@vger.kernel.org>; Wed, 26 Aug 2026 18:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.152.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787768337; cv=none; b=rK+Za6iAia2BL5Zz1rxhxUBsBrOqPAlk8wAg3eAeTBLw/UCDRLkORhBk1bNdyaFBELjKRLR88WpjGTyD2hldwHFU5oV2d1eXWcjJ7TbEU7aLK3TEDo/hl5PJL70MozKRbY31EfAiEoPoj7eicp0kfRxEWZbfU8e9LZQ7XeXnkeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787768337; c=relaxed/simple;
	bh=mNi/porhF2jOitDuvfoC35lGPyuWdRA7n/lSZlGRLZE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BQVHUnr1IBQStjGXj/IPxqIWgf7qbGAz9n7zoZV+UvAqPNE20QcqQgg7SZAZEN0ADQjGLv4KSNLnMjJqREvLLG3KMT9EUG1fh7SzDsLfTMSxMhzwrr84jmBDJf5SnIT7Khm8ad1w7dj18JlHgDMMNKPCErCcdPyBU6yqki20m8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=NjHe8qTa; arc=none smtp.client-ip=148.163.152.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="NjHe8qTa"
Received: from pps.filterd (m0354654.ppops.net [127.0.0.1])
	by mx0b-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67QHorEM014210;
	Wed, 26 Aug 2026 18:18:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=default; bh=Ea1qNcdD9EBr6
	IUt99GvLLALPPKzlQqCckwV9jKLo5E=; b=NjHe8qTaxQ/V/lunZ4U48sHVlddRw
	vbfZgnOHyJe8n4mw7lJbWuLpU8n9+/xM8kVzMRmOIfoCyH4FtRt/oHHhCrcMLJHX
	fw2ms0gamoIcFiEy8Spez+8f+ReBHkFSOoGPOlt5LldqyteD+rF0LomniEdAXomL
	MvRPAfhqQ+JmQh/Dsa1e3N3cPj7eyHoAHZ0ZWa5EODf/lugEMWEU/eMtHgw0a8c6
	1bdskZglOogN1bE/LUM+uFIr8iVPO4vPh63i3jHbDH+PDH9UEYEgBLfrWGnebs4s
	67ly7DuVjPAOtiwScf+f475iulqhiqteojXBrNqMx6/5211Uql8I1yA8g==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0b-00206402.pphosted.com (PPS) with ESMTPS id 4ga4wcr6dw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Aug 2026 18:18:28 +0000 (GMT)
Received: from LL-DJCZ134.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 26 Aug 2026 18:18:26 +0000
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
To: <bpf@vger.kernel.org>, <andrii@kernel.org>
CC: <martin.kelly@crowdstrike.com>, <slava.imameev@crowdstrike.com>,
        <linux-open-source@crowdstrike.com>
Subject: [PATCH bpf-next v2 0/5] libbpf: BPF program dynamic loading
Date: Wed, 26 Aug 2026 14:18:20 -0400
Message-ID: <20260826181825.1826541-1-andrey.grodzovsky@crowdstrike.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: 04WPEXCH016.crowdstrike.sys (10.100.11.68) To
 04WPEXCH006.crowdstrike.sys (10.100.11.70)
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDE1MyBTYWx0ZWRfX6Rl7vQ8gpvm4
 pCNM2Vv9hDSWuFp7bIbkVbCigAA7GVD9pODnCPt0dj4KQ5U/w8ZphoRVy6JtBqPX3e66pzf3oOf
 Py0uoqnyWWCf5sP0uqlCcLmliZgUjtuJh3XBvJOZST0CSd9fwCP+aSty+YvoE2PYBozQgq13/Rz
 SYDAvmIiNrH+FZOtmopHksylNxAxZMHB4S87ckFas2JPwBGxQp/qZRYuuhsCdcME/hQlc1E6MlX
 1P6rU7U0fyBoNuJxLt7cxCJ6EGhlSZxCswjzeSQW//Rbj+O2q1cmnApqTHSFYWVsjP9ppAd8x2z
 dglu50ZVFLUhShzQWizrhZZQGg+hzvaCDly/QGbODar5ofLTdzddvvrFihuN1sIUjEbrlmXS4Gz
 sIzAGPs0TL3d3eL7AbE0hnjWC4jKD6cTnHj28Cg6+6SnAVs+yUgK8MVz5iXcmBCRnblaeUjTyus
 VtOFn7wyoFegswRj+2g==
X-Authority-Analysis: v=2.4 cv=SbfHsPRu c=1 sm=1 tr=0 ts=6a8f2df4 cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=T2KQ53IYiC3MXPrxx8bB:22 a=R_n4Uisa8axJ7jemP0ek:22 a=VwQbUJbxAAAA:8
 a=pl6vuDidAAAA:8 a=pGLkceISAAAA:8 a=Kb_ievDTB7_4XtEly2oA:9
X-Proofpoint-ORIG-GUID: OxK5_CVUdp2MXSYmp4KOqYFRRv6zUpN8
X-Proofpoint-GUID: OxK5_CVUdp2MXSYmp4KOqYFRRv6zUpN8
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDE1MyBTYWx0ZWRfX6t5eF4qasPlw
 zcsXP5I22kgvs9I3bqUqhWG5s8v4fEhzHoI2PhFz83q/F1Vm4OpPwRd4WPcNEXFB/iSo8Cq3D2z
 VG8B4rJ9xEE5bdOctn+w5cr4oYWg3iEjlqU4TgSbsjTI0mnPKkxT
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11887
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0 clxscore=1015
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608260153

This series was originally posted in January 2025 [1] as
a two-patch RFC introducing a per-program tri-state load type
(disabled/auto/dynamic) to let large BPF applications load a subset of
their programs lazily, after the initial bpf_object load.

We looked at the object-wide opt-in flag Andrii suggested as a
lighter-weight alternative to a per-program enum ("all programs may load
later, opt in via bpf_object_open_opts"). Problem was that it collapses two
states that need to stay distinguishable at the level of a single program:[2]

  - a program that is not currently loaded but is *expected* to load
    later, gated on runtime configuration; and
  - a program that is *permanently* not going to load on this kernel
    (e.g. it targets a symbol or struct field that doesn't exist on the
    running kernel, or it lost out to an alternative implementation and
    will never be used on this object instance).

A per-program enum keeps that distinction where it belongs: disabled
stays fully excluded from relocation/map-creation with isolated failure
handling, auto is unchanged, and the new dynamic state is the only one
that opts a given program into later loading -- without implicitly
promoting every other disabled program in the object along with it.

This v2 keeps the same programs and tests we originally proposed, and
addresses two additional requests from Andrii [3]:

1. bpf_program__set_autoload() is converted from bool to the new
   enum bpf_prog_load_type, so it remains source- and ABI-compatible
   with the ~200 existing bool callers (false->0, true->1 already match
   the enum's DISABLED/AUTO numbering), while becoming a thin forwarder
   to bpf_program__set_load_type(). It intentionally continues to reject
   BPF_PROG_LOAD_TYPE_DYNAMIC, to preserve its original on/off meaning --
   dynamic load is only reachable through set_load_type().

2. A declarative way to mark a program dynamic-load-eligible from its
   source, as an alternative to an imperative set_load_type() call, using
   a new BTF decl_tag.

Motivation:

Security tools built on top of libbpf commonly ship as a single large
BPF object containing many programs, only a subset of which are needed
on any given system -- the rest are gated on optional features or on
kernel/runtime capabilities that vary across deployments. For this class
of application, per-program dynamic loading helps in two ways:

  - it shortens the initial load, since only the programs actually
    needed for the running configuration are loaded and attached up
    front instead of the whole object; and
  - it lets a single failing program be unloaded and possibly
    reloaded (or a feature toggled at runtime) without tearing down
    and reloading the entire bpf_object.

Both reduce the time window during which the tool is partially loaded or
inactive -- for a security tool specifically, that is also the time
window during which the system it protects is unprotected.

We have been running this with our internal fork of libbpf in production
for about a year. Depending on kernel and configuration support, around
250 of our programs are potentially loadable on any given system; with
dynamic loading, only around 90 of those are actually loaded by default,
growing to the full 250 only when every optional feature is enabled.
Cutting the default set of loaded programs from 250 down to 90 measurably
reduces load time (we observed ~60% reduction in our own measurements),
and since unload time scales with the number of loaded programs, it
correspondingly shortens unload time as well -- which matters, since
slow unload can delay system shutdown. We believe this functionality
would benefit other libbpf consumers with similarly large, modular BPF
applications.


[1] https://lore.kernel.org/bpf/20250122215206.59859-1-slava.imameev@crowdstrike.com/
[2] https://lore.kernel.org/bpf/CAOu3gNjg5vQ=t0C5UmStNpK8zutFC7kcYTrKt9aiR8Gia+rdNw@mail.gmail.com/
[3] https://lore.kernel.org/bpf/CAEf4BzZKy5Wv_TxtEqsbzW+v-tO28kgY=9RhXrnbPhOZcVbOSA@mail.gmail.com/

Andrey Grodzovsky (2):
  libbpf: Convert bpf_program__set_autoload() to load-type enum
  libbpf: Support declarative dynamic load via BTF decl_tag

Slava Imameev (3):
  libbpf: BPF program load type enum
  libbpf: BPF programs dynamic loading and attaching
  selftests/bpf: Cover BPF program dynamic loading

 tools/lib/bpf/bpf_helpers.h                   |   5 +
 tools/lib/bpf/libbpf.c                        | 273 ++++++++++++++++--
 tools/lib/bpf/libbpf.h                        |  32 +-
 tools/lib/bpf/libbpf.map                      |   4 +
 .../selftests/bpf/prog_tests/dynamicload.c    | 222 ++++++++++++++
 .../selftests/bpf/prog_tests/load_type.c      | 167 +++++++++++
 .../selftests/bpf/progs/test_dynamicload.c    |  40 +++
 .../selftests/bpf/progs/test_load_type.c      |  31 ++
 8 files changed, 741 insertions(+), 33 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/dynamicload.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/load_type.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_dynamicload.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_load_type.c

-- 
2.34.1

