Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.152.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792708353;
	b=kmgJQHVrd4a6mG9l2YSKH+G/6iC/hMA5wrruXgQOpCPFEgfpwzS7ax9iNsf6/VrEXNJE
	 By1TQFYDNT+ptUUeCv+3OMTluaWXdGDpgmwdgPRv/AGMMpMTlR4h2rPGJjxIjtlAXwpWJ
	 m9UV82UG0ij/6Z4C0Lk+nbkCXr8RFsagUypbg9nvew6Y0UP5EbDOCCxYEXT36mhwPh3D2
	 joa9g3m1Vn3LTxhL6SLF8iZ1g7K5/U+bYvAfZI0GZR2Q6u1XuATGploDN7A/zt5D9dZnI
	 lTO7bYtVvVbGP2BJWImq9fcPXZSlvKYrB6A7AHDZmSyGd0DEJXH132giRP+0YKglB3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792708353;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=WcDMypCx7ub4pOJRADZu6AvyXKMQ9vzlcUYIxkAep9E=;
	b=kq2ia7XmD95DSC4yTeSAuAigYbtb7BSmWcQxoJREHiLOIOvGPjMjtF9YEvwN80fUfDj9
	 RdXrTD7doCbvS+CdO7txgZJNi6VU/ysfm3RguFGoO23mvJufPFuKg3Muf9UIAghItHCXZ
	 ceTXQBRLV9NufiB3SeaIUoiGEH/BeRF8J/9tUFlVaAk7O1vrvgNLNsK68YK3CqQTAzM/6
	 dt9pCipVpPvTG4rO2rfohCMu2FS4ymn2c4BbiMSGbT0M213BXq6T7A7WjLdZEQwPemsnN
	 K8T21CkgEwsVlXrOTfY/Gt9pTcE0i/viOWCg6kR6JtQO08geIk9cmQIyXDxbKuxrvvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=crowdstrike.com;
	spf=pass smtp.mailfrom=crowdstrike.com;
	dkim=pass header.d=crowdstrike.com header.i=@crowdstrike.com header.a=rsa-sha256 header.s=default header.b="m/xHO36F";
	arc=none smtp.remote-ip=148.163.152.16
Received: from mx0b-00206402.pphosted.com (mx0b-00206402.pphosted.com [148.163.152.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC64606A31B
	for <bpf@vger.kernel.org>; Thu, 22 Oct 2026 22:32:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2FC64606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=crowdstrike.com header.i=@crowdstrike.com header.a=rsa-sha256 header.s=default header.b=m/xHO36F
Received: from pps.filterd (m0354653.ppops.net [127.0.0.1])
	by mx0b-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69MHN7Sb3008702;
	Thu, 22 Oct 2026 22:32:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=default; bh=WcDMypCx7ub4p
	OJRADZu6AvyXKMQ9vzlcUYIxkAep9E=; b=m/xHO36F2EKsJPD1yabD8mvbPPFMQ
	FikI2TKzjx4Id4FjivniRuN01JK6tNYMui8V9SpG8ylq2CnKzcLTSZcKshPp7OPJ
	2815Di3Kd6NI+/L6VZZYJgkEYEQ0eWGAy784R/48D92ofF3HSq0tRhPInRsjr+Kq
	1GWit/SNL3SRnq/3Idbp9FP6iJlfEYzc4WfzRZcHhrXkFPaQqw6F8zslVxofDuH5
	ja7eQoO2v6gQ6zmh0LtS4g0aArWXQckiN8mtqRPukInCCfMNJD7IW/d98JvEjKMr
	Tc4PnEE8W53opojXft6/e+/BaE+AlLr1QQThOho5aMl5jp4sftim6IsyA==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0b-00206402.pphosted.com (PPS) with ESMTPS id 4hf97mvktg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Oct 2026 22:32:15 +0000 (GMT)
Received: from LL-DJCZ134.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.53; Thu, 22 Oct 2026 22:32:14 +0000
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
To: <bpf@vger.kernel.org>, <andrii@kernel.org>
CC: <ast@kernel.org>, <martin.kelly@crowdstrike.com>,
        <slava.imameev@crowdstrike.com>
Subject: [PATCH bpf-next v7 0/7] libbpf: BPF program manual loading
Date: Thu, 22 Oct 2026 18:32:05 -0400
Message-ID: <20261022223212.1217849-1-andrey.grodzovsky@crowdstrike.com>
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
X-ClientProxiedBy: 04WPEXCH015.crowdstrike.sys (10.100.11.67) To
 04WPEXCH006.crowdstrike.sys (10.100.11.70)
X-Proofpoint-ORIG-GUID: 8kD18tdsUHhGyBzj8NQ5Fu2ukEi-96Za
X-Proofpoint-GUID: 8kD18tdsUHhGyBzj8NQ5Fu2ukEi-96Za
X-Authority-Analysis: v=2.4 cv=CMW/zhrD c=1 sm=1 tr=0 ts=6ada8eef cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=T2KQ53IYiC3MXPrxx8bB:22 a=GCXdLZfFv8EKBZhKOxZ5:22 a=VwQbUJbxAAAA:8
 a=pl6vuDidAAAA:8 a=T2pYpgpeBa3Ts2VgtgwA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA4OSBTYWx0ZWRfX2h4WzpQ0L/a3
 YBITcFAfWBT9nr6icqRepBpefc2dm514TFJ4CVTPLUlMqmT4cgL3I7edFFPayrOoyko8pNrpUWZ
 dshAFYtXAQrW8OlcnbS/bRZ1C0XkkVJwuFxncDEooxPRrnyvVr6tJcnwMF9LDkYr2Faq5ZsHZb7
 ZqtGpzvDnE3nBeJgvJJZvkzKk9OUbYgViIw5/+L+jL6rl0TFWItcu+Lm+6LEjv1760giOtQA2+z
 N1TIscTDuUl0Qt5TH/yicaAmGNzqmzqfnFKnxF9pdMk88HVa9/ASDN04ToxYk4Jvlbu6SbO4w+5
 jhD2lxQjUQsZh34COAjQT4/FFaGBl/9m2n3lPlSvv74FuvFgg55C8wNPfPHD2NSOYbPFRpiwLZk
 cIYSeVehtny8u6hF1cxOsoblKxcKMIiAZSUz/5jxUw25+sfwHYYTTciR7OfwbaqDAc4kEDzcQIq
 saqH2vnol1TDIMNhh3Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA4OSBTYWx0ZWRfX6umJetvE1GK5
 C5CAGPt9WFYRGNEfL6WbOkAn+CA9QZM1UgKym0dfjVrxcqajJrkRblFtEcIji+FkArLD/C+yVrY
 KN/6WLW00dh0pCnZSAJvWm2qunh0XH0zmVukHmhjzKGDXaXPrpan
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11943
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015
 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220089

This series was originally posted in January 2025 [1] as a two-patch RFC
introducing a per-program tri-state load strategy (disabled/auto/manual)
to let large BPF applications load a subset of their programs lazily,
independent of the initial bpf_object load. This v7 addresses v6's review
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
      a module BTF deferred load, a module kfunc deferred load, and
      gen_loader rejection

 7/7: convert veristat to use manual programs instead of cloning

Changes since v6 [2]:
  - Reject a load strategy change once the object is PREPARED, not
    LOADED (Andrii)
  - Drop the MANUAL-specific state check and the same-strategy early
    return from bpf_program__set_load_strategy() (Andrii)
  - Add the new APIs to the LIBBPF_1.9.0 section of libbpf.map instead
    of LIBBPF_1.8.0 (Andrii)
  - Filter the manual_load test programs by the test's PID, so a
    concurrent process cannot flip the test's flags or overwrite the recorded
    read size when run in parallel (sashiko-bot)
  - Properly Document bpf_program__set_log_level() and bpf_program__set_log_buf()
    in libbpf.h, including the MANUAL program exception
  - Add selftests covering the fd_array binding of the arena and of a
    module kfunc for MANUAL programs

[1] https://lore.kernel.org/bpf/20250122215206.59859-1-slava.imameev@crowdstrike.com/
[2] https://lore.kernel.org/bpf/20261010143156.379864-1-andrey.grodzovsky@crowdstrike.com/

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

base-commit: b116ac6087541d3d98031e786adbe9c733cd6df3
-- 
2.34.1

