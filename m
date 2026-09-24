Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A65436361
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 11:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790248505; cv=none; b=sHgY4Bh90qKA9N8MPLjb1G8JEGXtYEbLkyuwhE6uVqlsfdoQ/vvnn2facbaitFxBj+axHra24T+ZcdTRyB5rE3ImS96Q+UvihUp7xEkUMObqu/WdgEOWNmZDV5AZn/Sq1Ito51JhayZP3Tumq3WuAV73Efq3z0RJkXLZgUMqVl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790248505; c=relaxed/simple;
	bh=5TLxw0zYQxed+OKBgAWfje/ZV40WG8sbwnrJHSBVxRs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MNtFR0XFyKT/BFEJ48FImHCaigDECC1C8od1QQwu/Yfkr/vci+1JX7GG3DeQxWUGEuFMvmy4metnSGus0eYsHR6+A0M/g5vFmTcyPI++TWbTeklti44+/sNFmjx9MW4FTOtVbnt2MU72fuexHZ28P7ebZ/LltPHjHmXCvRmVP4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PL9VIuBX; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PL9VIuBX"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68O6CLV23933046;
	Thu, 24 Sep 2026 11:14:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=vOVIz0qTOMfrI+ftqULJEDUdYB/CC
	EFeWcWxka9JPe0=; b=PL9VIuBXfVpuT0v9w6igznjJ3/wvZqohvx4jT7J0NuxDk
	K0HmMAGene84uRWJ0WQ8GxLsykTgYT9//swdAcEejQMvhK/zffz+/OKp5fQZOGKz
	xFxznHeswLG0/FiyZ4wPwVfn8E8Gi4IPyctoYS+Sg+VxsnoBCetqAWk1VLVQJzKL
	CkKHY/tkK+yYIw30JbK1usPIk/VkeRPV+ACzs0W+EiEiaYS9P2EsqvAnol0uZe6k
	oOxpE2ip2hnhq7u9V1NGsuo5BawDhMofVvSADNGyXxl32aagLo3h3/7d01qULsww
	IWNngU99cEGJsUgsQ7aUFNjZcqQ5aRSxceKu7CC2A==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gsk1gfbbt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Sep 2026 11:14:33 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 68OB5Yab013079;
	Thu, 24 Sep 2026 11:14:32 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4guf119kqy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Sep 2026 11:14:32 +0000 (GMT)
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 68OBEVu5002821;
	Thu, 24 Sep 2026 11:14:31 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-80-22.vpn.oracle.com [10.154.80.22])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4guf119knh-1;
	Thu, 24 Sep 2026 11:14:31 +0000 (GMT)
From: Alan Maguire <alan.maguire@oracle.com>
To: ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com, qmo@kernel.org
Cc: jolsa@kernel.org, daniel@iogearbox.net, ihor.solodrai@linux.dev,
        yonghong.song@linux.dev, song@kernel.org, martin.lau@linux.dev,
        memxor@gmail.com, emil@etsalapatis.com, bpf@vger.kernel.org,
        nsc@kernel.org, puranjay@kernel.org, yatsenko@meta.com,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v4 bpf-next 00/11] Support inline functions in BTF
Date: Thu, 24 Sep 2026 12:14:17 +0100
Message-ID: <20260924111428.75957-1-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 spamscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0
 mlxscore=0 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2609040000 definitions=main-2609240046
X-Proofpoint-GUID: 98x_Bu1e9nBXYrcbrAS33FOAnNWAwSjt
X-Authority-Analysis: v=2.4 cv=T6sZ3PKQ c=1 sm=1 tr=0 ts=6ab50619 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x4eqshVgHu-cdnggieHk:22 a=07d9gI8wAAAA:8 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8
 a=yPCof4ZbAAAA:8 a=DoNuM6158zL3cDiGstsA:9 a=e2CUPOnPG4QKp8I52DXD:22
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12106
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA0NiBTYWx0ZWRfX+lA69P9vZn0T
 jQNLi4ZERj9SwvOQhV2SmWsDq8cjMk0ussBd7co5V22sqfzyBJnxB5eDGUcRIsoDd2noCGINnl8
 vyrE2Hq2czmq5VNolHB4bsuXSoFbvucAi90bAUQDugams230mD/H
X-Proofpoint-ORIG-GUID: 98x_Bu1e9nBXYrcbrAS33FOAnNWAwSjt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA0NiBTYWx0ZWRfXwhogzmMIyaJb
 5HNrso31AIHTeZGVPJJusH2Dkod7MAeg1fuw/xZIopGU3IVUbj8ToNFGFqkIYqxXO+feXhOMDCC
 866SZXTimj8jNLIzLsICiTDY0Nm3IeW6XPU2Q9TmVk/MM3hyvJNhfXM5YotwLLBInv3dyB9Zr6Y
 iE3PSDXtmjCI3Amq9Xuba46Yb7x2Bf1WovcpRtITLuvr3RIYp13Sz3+ZdCAVoIGvar65iZiyMe5
 dNdqo2EHkFQYWS1dfbus0pZyUEOryE5qPToy0H9Yo5UQ30xXOEZTmGyAvvRyYKBemL6azNJOh2o
 l22Uk/CwLjPddRDVSc3v9mQeSS1/9cJwqTvTgqNjz/LDJGbzS/nOS8jgniTdhIy5ZjAJURJxvYz
 4SeDKYo3+Kmjo8gq1CEjuC1j1QYRyRpy0maAPxbsjyfUCsdIJeTv0GYlqYTmdaueWsRr6uoFrTd
 sW/rpAKZ1JAwxuC2Rhdg0EwuaHKzrZsL0OBb1En0=

This series adds support to facilitate tracing of inline function
sites using BPF Type Format (BTF) information. An excellent overview
of the problem and proposed solution presented at LSF/MM/BPF is
available at [1].

The aim is to produce a compact representation providing sufficient
information to a tracer wishing to instrument an inline site via a
kprobe.  The challenge to solve is compact representation - my
local bpf-next builds show nearly 600,000 inline sites for approximately
100,000 functions.  Any BTF representation should utilize deduplication
where possible to minimize overheads.

The approach used here is to encode a series of inline sites in
a BTF DATASEC-like LOCSEC named for the associated section (like
"inline.text", where each entry consists of a

<function type id, location prototype id, offset from base address>

triple. The function type id is the BTF_KIND_FUNC that was inlined,
the location prototype is a BTF_KIND_LOC_PROTO which tells us
for each function parameter how it is represented at the site.
It is a collection of either type id 0 (parameter not available)
or BTF_KIND_LOC_PARAM ids, the latter encoding a register number,
a dereference, a constant etc.  Finally the offset is relative to
the base address, so in the case of the kernel this allows for
kASLR, and modules addresses are relative to module base address.

Full location parameter information is available for ~78% of
inlined functions; in other words all function parameters are
expressed via BTF_KIND_LOC_PARAM and can be retrieved.  Those
remaining have more complex multi-expression encoding or are
not available at all.

This series focuses on the underlying libbpf/kernel/bpftool support
for handling location data; with it in place pahole can utilize
the provided interfaces to generate inline data in combination with
general BTF data; it will then be separated out via resolve_btfids
into non-inline and inline information.

Support in pahole for generation of inline info using the libbpf
interfaces in this series is available in [2].

Patch 1 consists of the UAPI changes and associated basic support
for KIND_LOC[SEC|PARAM|PROTO].

Patch 2 adds associated libbpf support, covering dedup, field
iteration and distillation.

Patches 3-6 test various aspects of these features.

Patches 7-9 update bpftool to handle multi-split BTF (where
we potentially have module inline info sitting atop module
BTF info which in turn has vmlinux BTF as its base), and add
support for displaying location info in raw BTF dump.
Patch 10 tests bpftool raw dump of locations.

Finally patch 11 documents the location kinds.

Changes since v3 [3]:

- Fix up UAPI descriptions for btf_type (bots, patch 1)
- Add LOC_PROTO/LOCSEC to btf_type_is_resolve_source_only()
  (bots, patch 2)
- Fix LOCSEC validation to reject empty name (bots, patch 2)
- Make use of values[] array in helper (Eduard, patch 3)
- Improved testing of distill by adding unrelated types
  to make relocate harder (Eduard, patch 6)
- Use BTF_LOC_PARAM_FBREG instead of 33 as register number
  for fbreg; placing it out of range of DWARF register numbers
  is safer since DW_OP_regx allows numbers > 31.
- Improve set of tested LOC_PARAM/PROTO in bpftool test

Changes since v2 [4]:

- Split out location representation/handling (this series) from
  additions to kbuild machinery to add inline info.  This series
  provides the needed libbpf interfaces to pahole for inline location
  generation. A follow-up series will add libbpf permute support
  for splitting inline from non-inline info such that resolve_btfids
  can consume it, kbuild support for pahole inline flags and sysfs
  exposure of inline BTF.
- Updated location parameter API name, function to use flex array
  for parameter values (Eduard, patches 1, 2)
- Fixed dedup issues (Eduard, patch 2)
- Improved dedup/distill tests to cover more complex cases
  (patches 5, 6)
- Updated bpftool dump output to be more expressive for location
  parameters, prototypes and location sections (Alexei, patch 9).

Changes since RFC [5]:

- Support for distilled base BTF
- Support for BTF_INLINE=m on-demand loading
- Reworked inline support to handle new resolve_btfids model
- .BTF.inline sections host FUNCs/FUNC_PROTOs/strings that are
  needed for inline info only, avoiding polluting standard
  vmlinux/module BTFs

[1] https://lwn.net/Articles/1083985/
[2] https://github.com/alan-maguire/dwarves/tree/btf-inline-v4
[3] https://lore.kernel.org/bpf/20260916074118.1007116-1-alan.maguire@oracle.com/
[4] https://lore.kernel.org/bpf/20260901165757.801449-1-alan.maguire@oracle.com/
[5] https://lore.kernel.org/bpf/20251008173512.731801-1-alan.maguire@oracle.com/

Alan Maguire (11):
  btf: Extend UAPI to support BTF location (inline site) info
  libbpf: Add support for BTF kinds LOC[_PARAM|_PROTO|SEC]
  selftests/bpf: Test helper support for BTF_KIND_LOC[_PARAM|_PROTO|SEC]
  selftests/bpf: Add LOC_PARAM, LOC_PROTO, LOCSEC to field iter tests
  selftests/bpf: Add LOC_PARAM, LOC_PROTO, LOCSEC to dedup split tests
  selftests/bpf: BTF distill tests to ensure LOC[_PARAM|_PROTO] add to
    split BTF
  bpftool: Handle multi-split BTF by supporting multiple base BTFs
  bpftool: Document support for multi-split BTF
  bpftool: Add ability to dump LOC_PARAM, LOC_PROTO and LOCSEC
  selftests/bpf: Test bpftool dump of BTF location info
  Documentation/bpf: Describe new location-related BTF kinds

 Documentation/bpf/btf.rst                     |  83 +++-
 include/linux/btf.h                           |  22 +-
 include/uapi/linux/btf.h                      |  83 +++-
 kernel/bpf/btf.c                              | 322 +++++++++++++-
 .../bpf/bpftool/Documentation/bpftool-btf.rst |   7 +-
 tools/bpf/bpftool/btf.c                       | 226 +++++++++-
 tools/bpf/bpftool/main.c                      |  24 +-
 tools/include/uapi/linux/btf.h                |  83 +++-
 tools/lib/bpf/btf.c                           | 408 +++++++++++++++++-
 tools/lib/bpf/btf.h                           |  50 +++
 tools/lib/bpf/btf_dump.c                      |   9 +
 tools/lib/bpf/btf_iter.c                      |  18 +
 tools/lib/bpf/libbpf.c                        |   3 +
 tools/lib/bpf/libbpf.map                      |   6 +
 tools/lib/bpf/libbpf_internal.h               |   2 +-
 tools/testing/selftests/bpf/btf_helpers.c     |  35 +-
 .../bpf/prog_tests/bpftool_btf_dump.c         | 121 +++++-
 .../bpf/prog_tests/btf_dedup_split.c          | 116 +++++
 .../selftests/bpf/prog_tests/btf_distill.c    | 106 +++++
 .../selftests/bpf/prog_tests/btf_field_iter.c |  31 +-
 20 files changed, 1726 insertions(+), 29 deletions(-)

-- 
2.43.5

