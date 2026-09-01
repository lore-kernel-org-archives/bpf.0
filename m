Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3CF848383E;
	Tue,  1 Sep 2026 16:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788281913; cv=none; b=VDr8au8tzWnVchXu0dqSxeb7522QkXTx1l/CDipVDhvNgwVefZyE5bisrajCvY5Bd/qtgcV2gk7ZkOVr9CiEpJtzR1a3yuHQYv9W/EBwj2YmfH9J4BPOQQiycpVIHkeusJJpefNmwAw4DPGpa3c34oXmxAOqij6IPzUvCdBpYhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788281913; c=relaxed/simple;
	bh=dUvvnKblGXcu4zabABfH+AUKezeg+WAag4l9+8AASTo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NlKAhCGAFr151YGlHPiQbCmpaC9QxFzFwwdwqjW/1cNac6yL3kr/MJ9twgpPgs74v4RBnPCcEGHgk3dEppvu4vhAjLs+JFYJaOzDkhs5nloS4WwC3V0s9ClXqZ/2YEoIjqH5ljoYLZgTU3RM9zr0cxKmLN539BqFlZ9UW7GDHao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jgteeqn7; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jgteeqn7"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 681EQBjN231357;
	Tue, 1 Sep 2026 16:58:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=Fa+mDCnAg8L+K3s8
	8eIiUveGn+rg4KrlWBXzi0f63gI=; b=jgteeqn7XgOVP/Gtnl+9Xw70gU2iv0ea
	irAr6T0vMlhf+4psNJ8OEsr+zP3XZvcsIItGqlWt4aH0Uygeehls/2Ti7RSK9b+H
	r0dKTXZfVB/FFjCjqaV1QVwdzSqkSd6H+AW9dyalzuUh1MIHkf2qX8peWrm7Rwa+
	r6YCtJk4b1V2WiNT5SxdKkqudwNwMs2WDJJZ1IDmfuUJK3DA41LvpoB4fcI2Oumj
	wqZ/MONjqd9v/4sHD+sB/MlphFpZn7xd+QlT6JzllqDTpn0nioUZmJ+RzU7vjiQZ
	/WhJa0GOU6VoIPmu4EGAtbPoP5zqGjZPsuGS2CJZRk4Oh76x++TyEQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gbqa7n3sh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Sep 2026 16:58:03 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 681GjSMu001822;
	Tue, 1 Sep 2026 16:58:02 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4gdymtg8gp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Sep 2026 16:58:01 +0000 (GMT)
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 681Gw1Vp011129;
	Tue, 1 Sep 2026 16:58:01 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-52-250.vpn.oracle.com [10.154.52.250])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4gdymtg8f6-1;
	Tue, 01 Sep 2026 16:58:00 +0000 (GMT)
From: Alan Maguire <alan.maguire@oracle.com>
To: ast@kernel.org, andrii@kernel.org
Cc: daniel@iogearbox.net, eddyz87@gmail.com, jolsa@kernel.org,
        ihor.solodrai@linux.dev, yonghong.song@linux.dev, song@kernel.org,
        qmo@kernel.org, martin.lau@linux.dev, memxor@gmail.com,
        emil@etsalapatis.com, mcgrof@kernel.org, petr.pavlu@suse.com,
        tj@kernel.org, kees@kernel.org, bpf@vger.kernel.org, nathan@kernel.org,
        nsc@kernel.org, arnd@arndb.de, puranjay@kernel.org, yatsenko@meta.com,
        atenart@kernel.org, ojeda@kernel.org, linux-modules@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v2 bpf-next 00/18] Support inline functions in BTF
Date: Tue,  1 Sep 2026 17:57:39 +0100
Message-ID: <20260901165757.801449-1-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_04,2026-09-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 adultscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 mlxlogscore=999 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2609010148
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDE1MCBTYWx0ZWRfX2YgDjWSJ1VU+
 F8c9mIJQ5Kffi24UV+gBt4TpUkQBkcuSvLGG1NTQz+r8k239xGg/z53xNkniND+0U5vqy7ZmuCN
 ssODt1cb5+qajl3RWXOy8LPW9YlpTzV5ZWUrDHbOp5yBJMdmi2Rc
X-Proofpoint-GUID: 378WsFYuB7aQkSfYUKEIiM_QA8mL-WnB
X-Authority-Analysis: v=2.4 cv=DPu/JSNb c=1 sm=1 tr=0 ts=6a97041b b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=EIcjfB9IiI4px24ztqRk:22 a=07d9gI8wAAAA:8
 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=QPHJuCtNaKxP3Rz0Ko8A:9
 a=QEXdDO2ut3YA:10 a=e2CUPOnPG4QKp8I52DXD:22 a=5yU3S35YU4bGjq-dph-N:22
 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:13521
X-Proofpoint-ORIG-GUID: 378WsFYuB7aQkSfYUKEIiM_QA8mL-WnB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDE1MCBTYWx0ZWRfXw5nFDC6DvFCu
 w6SWU8TDMbugOF6uiz9UZ8By0yAcBf5Yoqz+isVTxnkFWh0qmmMEK0WngouJFtTIxb1KncICE3q
 Gfu/6LlLaCMgovkV9l+iP0mRiOizaf3GFMH6HAmEY894+v1ATbJ5ny365WfwO42z6L1cF37sMKO
 NJwJKhfOL/2HUTh14SbvBQb2BTZrQwZkMfkenxLBwqa3d08yO3AOUUq0vxIfw9hBsAyM57bFE6K
 w8t5xafOhIms5G6rtzgkRaLvLw5nLMsyIHMh/AlqWyxu09S8u5p6M89HppmDQQ+5tF2gzWSaCVZ
 F5sI71MmtCdN77+WHVd+F1lZ5xuIw7AcTRgL/pboPh52btXtANIvD+90kalsVjMIZt2gTFoswRN
 ickkR1sV8q2k7BQDVduT6kPI/4IHgGpykqVx0X8MIOiJaXMnGfxN2ktd6bOKTJZZcEkJn4HU7p/
 M3zGx2sDc05EYTCPsdE//mpGCUEE+BNchL5QcKf0=

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
".text", where each entry consists of a

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

For a vmlinux with 6Mb of BTF in /sys/kernel/btf/vmlinux, I
see 10.8Mb of inline information.  When delivered as a compressed
module, the module size is 3.5Mb (via CONFIG_DEBUG_INFO_BTF_INLINE=m).
In this module-delivered mode, /sys/kernel/btf/vmlinux.inline will
be zero-sized until it is opened, at which point the module is
requested so the user experience is identical to when inline info
is derived from vmlinux itself, but we save the allocation associated
with live inline representation.

This series is rather large, and ideally we would split it into
basic inline support in kernel/libbpf/bpftool and associated tests
(patches 1-11) and delivery of inline info (patches 12-18).

This would allow us to land the pahole support once the libbpf
interfaces become available, though it will work in its absence.
The pahole code is still being tested but is available at [2].

Patch 1 consists of the UAPI changes and associated basic support
for KIND_LOC[SEC|PARAM|PROTO].

Patch 2 wires in libbpf support to handle these, including in dedup,
field iteration and so on.  LOCSEC does not dedup since each entry
has a unique offset, but LOC_PARAM and LOC_PROTO do.

Patch 3 widens BTF permutation to support a transfer mode which
allows us to move a subset of types to a newly-created split BTF.
This will allow resolve_btfids to take a pahole-generated BTF
object (consisting of usual BTF plus inline info) and separate
out the inline-relevant components into a new .BTF.inline section.
This is an approach in line with other resolve_btfids changes which
prepare more generic BTF for the needs of the kernel.

Patches 4-8 provide tests for all of this.

Patches 9-11 add bpftool support to handle multi-split BTF for
inline info and to display location info.

Patch 12 adds resolve_btfids support to split out inline info
with the aim that any functions that are exclusively needed for
inline sites wind up in the inline BTF; this is a good test to
see if a function is likely fully inlined.  Similarly any LOCSEC
references < start BTF id of the inline BTF suggest partially
inlined functions.  See the patch for the nuances.  resolve_btfids
takes as input BTF consisting of the usual vmlinux BTF objects
and inline-related ones; its role is to create a split BTF
where we move the inline-related pieces out so that
/sys/kernel/btf/vmlinux (or module equivalent) is the same
as before and does not pay the cost of inline representations.
This approach is different to how it was done in the RFC because
the model of applying kernel customizations in resolve_btfids
did not exist to the same degree then.  In the RFC approach,
pahole delivered already-split BTF and we relocated it, but
since the base BTF it is built on now is transformed significantly
(added/changed types, sorting, dedup) it is not feasible to
track id changes across all of these operations.  As such
we view splitting the inline info out as another kernel-specific
customization.

Patches 13-16 add support to the kbuild infrastructure and
/sys/kernel/btf representations for inline data.  We can choose
to deliver vmlinux inline info via a module (since it is ~10Mb
that makes sense) but there are some issues in getting that
module to load when /sys/kernel/btf/vmlinux.inline is accessed
that are described in patch 15).  Patch 16 handles relocation
of distilled base BTF for out-of-tree modules, ensuring that
relocation works across module and module inline info.  The
painful part here is that we need to relocate ids in the
inline info, which requires multi-split BTF support.  Happily
that is not a big change.

Finally tests in patches 17, 18 cover sysfs representation
and we introduce an inline site to bpf_testmod and ensure
its representation makes sense.

Changes since RFC [3]:

- Support for distilled base BTF
- Support for BTF_INLINE=m on-demand loading
- Reworked inline support to handle new resolve_btfids model
- .BTF.inline sections host FUNCs/FUNC_PROTOs/strings that are
  needed for inline info only, avoiding polluting standard
  vmlinux/module BTFs

[1] https://lwn.net/Articles/1083985/
[2] https://github.com/alan-maguire/dwarves/tree/pahole-next-btf-inline-v2-testing
[3] https://lore.kernel.org/bpf/20251008173512.731801-1-alan.maguire@oracle.com/

Alan Maguire (18):
  btf: Extend UAPI to support BTF location (inline site) info
  libbpf: Add support for BTF kinds LOC[_PARAM|_PROTO|SEC]
  libbpf: Support moving permuted BTF types into split BTF
  selftests/bpf: Test helper support for BTF_KIND_LOC[_PARAM|_PROTO|SEC]
  selftests/bpf: Add LOC_PARAM, LOC_PROTO, LOCSEC to field iter tests
  selftests/bpf: Add LOC_PARAM, LOC_PROTO, LOCSEC to dedup split tests
  selftests/bpf: BTF distill tests to ensure LOC[_PARAM|_PROTO] add to
    split BTF
  selftests/bpf: Validate that btf__permute transfer works
  bpftool: Handle multi-split BTF by supporting multiple base BTFs
  bpftool: Document support for multi-split BTF
  bpftool: Add ability to dump LOC_PARAM, LOC_PROTO and LOCSEC
  resolve_btfids: Extract inline BTF
  kbuild: Add support for BTF inline information
  btf: Make vmlinux, module inline info available in /sys/kernel/btf
  btf: Support CONFIG_DEBUG_INFO_BTF_INLINE=m
  btf: Relocate inline BTF for modules with distilled base BTF
  selftests/bpf: Test BTF sysfs inline representations
  selftests/bpf: Add a test verifying inline information

 Makefile                                      |   1 +
 include/asm-generic/vmlinux.lds.h             |  11 +
 include/linux/btf.h                           |  23 +-
 include/linux/module.h                        |   4 +
 include/uapi/linux/btf.h                      |  65 +-
 kernel/bpf/Makefile                           |   1 +
 kernel/bpf/btf.c                              | 686 ++++++++++++++++--
 kernel/bpf/btf_vmlinux_inline.c               |  37 +
 kernel/module/main.c                          |   4 +
 lib/Kconfig.debug                             |  18 +
 scripts/Makefile.btf                          |   7 +
 scripts/gen-btf.sh                            |  33 +-
 .../bpf/bpftool/Documentation/bpftool-btf.rst |   7 +-
 tools/bpf/bpftool/btf.c                       |  85 +++
 tools/bpf/bpftool/main.c                      |   3 +-
 tools/bpf/resolve_btfids/main.c               | 336 ++++++++-
 tools/include/uapi/linux/btf.h                |  65 +-
 tools/lib/bpf/btf.c                           | 659 ++++++++++++++++-
 tools/lib/bpf/btf.h                           |  66 +-
 tools/lib/bpf/btf_dump.c                      |   9 +
 tools/lib/bpf/btf_iter.c                      |  22 +
 tools/lib/bpf/btf_relocate.c                  |   7 +-
 tools/lib/bpf/libbpf.map                      |   6 +
 tools/lib/bpf/libbpf_internal.h               |   5 +-
 tools/testing/selftests/bpf/btf_helpers.c     |  36 +-
 .../bpf/prog_tests/btf_dedup_split.c          | 109 +++
 .../selftests/bpf/prog_tests/btf_distill.c    |  76 ++
 .../selftests/bpf/prog_tests/btf_field_iter.c |  31 +-
 .../selftests/bpf/prog_tests/btf_inline.c     | 110 +++
 .../selftests/bpf/prog_tests/btf_permute.c    | 128 ++++
 .../selftests/bpf/prog_tests/btf_sysfs.c      |  74 ++
 tools/testing/selftests/bpf/test_btf.h        |  16 +
 .../selftests/bpf/test_kmods/bpf_testmod.c    |   2 +-
 tools/testing/selftests/bpf/trace_helpers.c   |  20 +
 tools/testing/selftests/bpf/trace_helpers.h   |   1 +
 35 files changed, 2636 insertions(+), 127 deletions(-)
 create mode 100644 kernel/bpf/btf_vmlinux_inline.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/btf_inline.c

-- 
2.43.5

