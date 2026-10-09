Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B924A0915;
	Fri,  9 Oct 2026 11:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791545053; cv=none; b=LvrBUauO1FGam92YsPZQxFiXLz0lnnXBvcnc4P9rfVuudg7odLXfQITnDDsh/nD3XNgfMS/fYmxyPKexYe7fedbOBPKeewZ93qpkNPM6cCeBTsazS16UX4zLzBsJQCDT0W9fEz/IIjF5Zqxl6IiMV1NFX9+uMcWLOV4QsEAZ1b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791545053; c=relaxed/simple;
	bh=4EB7+Y2P/Rge0pOkdl2WMdJ4ytRVrmfAZdFVqf2re+8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HSsun5852WG5kuNnMZaWuUGWd+PJgrjQsZyAQMFFqwaXslAKfdsNYXKslYqsP3Agx83mAvroNJpq29h2+WY1KOa7rl5scbrQzWDcwpq7BNe9USM4LKKBg2QggifTpFViDmnOhHbv1JFkS9NqsSeM/0xkM73CSvnJRgpq1BFZF/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cpFoGSia; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cpFoGSia"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6990MDfv127174;
	Fri, 9 Oct 2026 11:23:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=E5Fogz2Q13rwnuGDSAqfFXkgLDey0
	ra9y5/SZ2d3frg=; b=cpFoGSiajsPSEQ/g42jC5FM7HUmKfNc6vqYsFkufh9YhA
	kxq9wl+IEwgWiLi1rw/mkyaKU9RKT8LLDe2olT7MNZWJ9sCRyckUxWC4KSyrxiJW
	IUhfSKKDKPuWFADzmK5eo9LKLyGEhtrvd6YYJaGjSSFXL0AtdwdpMaMLodo/IO4Z
	C+xFRZA+0IVbCrIR8oe/LM2Azcv0OM19f/aayYBvAbQ0knjhtAeEyJON7ChwdkS8
	4UisBkI3jihQWe63MOfO9mMXk0E2qwVPtKwEEdDlFKVBFrJGFPqrBxbksE0upA2A
	55u3hTTKjb11lgX/rgRhFq3RVBu/6y7OMta6+A5Pw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4h5xegjxtv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 09 Oct 2026 11:23:29 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 699BLjeG039817;
	Fri, 9 Oct 2026 11:23:28 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4h5xfcsn9x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 09 Oct 2026 11:23:28 +0000 (GMT)
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 699BNRkQ006543;
	Fri, 9 Oct 2026 11:23:27 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-85-231.vpn.oracle.com [10.154.85.231])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4h5xfcsn8m-1;
	Fri, 09 Oct 2026 11:23:27 +0000 (GMT)
From: Alan Maguire <alan.maguire@oracle.com>
To: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com,
        jolsa@kernel.org
Cc: ihor.solodrai@linux.dev, yonghong.song@linux.dev, song@kernel.org,
        qmo@kernel.org, martin.lau@linux.dev, memxor@gmail.com,
        emil@etsalapatis.com, mcgrof@kernel.org, petr.pavlu@suse.com,
        tj@kernel.org, kees@kernel.org, nathan@kernel.org, arnd@arndb.de,
        puranjay@kernel.org, yatsenko@meta.com, atenart@kernel.org,
        ojeda@kernel.org, linux-modules@vger.kernel.org,
        arnaldo.melo@gmail.com, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v4 bpf-next 0/7] kbuild, bpf: Support inline info in BTF
Date: Fri,  9 Oct 2026 12:23:17 +0100
Message-ID: <20261009112324.1442319-1-alan.maguire@oracle.com>
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
 definitions=2026-10-09_03,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 suspectscore=0 spamscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2610020000 definitions=main-2610090045
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA0NSBTYWx0ZWRfX1kEFRBZm/irr
 35G2G1q7mDt21UcQAOHsw9gdeaRRnIEdv4TQJugO6Lh4XMIZRndQRZinS6IJCmjYhIIjAQRw07h
 Sn0FnCeQjnxMgkue7Ws322kGsCLQBcyBdX9dKCC1s7f9KAVkCcI0
X-Authority-Analysis: v=2.4 cv=Zp54uN7G c=1 sm=1 tr=0 ts=6ac8ceb2 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=RD47p0oAkeU5bO7t-o6f:22 a=VwQbUJbxAAAA:8 a=vggBfdFIAAAA:8 a=yPCof4ZbAAAA:8
 a=JB-sWbzYIoqP5mPnr2YA:9 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22
 cc=ntf awl=host:12108
X-Proofpoint-GUID: Iws-ruFTj7PYEcYfC-sU80i3lvn1Fwqw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA0NSBTYWx0ZWRfX9dCXOZJkkLU2
 h/z7zLf/WfpIwIJIPtq5hnGMJAUQ+4CfBrVq9nLeOKYU00AME4O4RLVwEwlDwCnP5txZLYDxgRp
 5dNQBAbQyT/nWDXjFNXhsW+clSWiEX1afV2bzckmvTsY0PTo0nJbc3YmtbNmFMXBp0wclE6JHIv
 6mcZ3fKiD+c5xEDVT3Bn/twQD7zGYjOeWkRPzN67KodGz0905cucvCIfo+t+DdjUlowVPkIDXnZ
 M/9KYn1ooSFGdOwzKlKsLDEl5lU9wS1t+la//s3pI9lX+3SrPjtGLLeaMJK0z2LfmgWLQ5JqCcK
 5ol+Zl0CzxlOrvClXMTPThPLxogka9wZhCNmE9I66swiEioZ8DreW/cnC0CG9MxYhjJ64JkDdp4
 2spfuKRHBtd7NnSObCwjGR1L1mhI5j2RNOHyEIGTZdlLN/4BgzzJSBNLKb8X641bXVxJ17s254E
 jl/Ej5UyjVz4oaQDZrSfmYVEfxkH9V3bzrYRU7gM=
X-Proofpoint-ORIG-GUID: Iws-ruFTj7PYEcYfC-sU80i3lvn1Fwqw

If CONFIG_DEBUG_INFO_BTF_INLINE=y|m, add the "inline" BTF feature
and encode inline site info in BTF alongside standard BTF data.
resolve_btfids will then partition into non- and inline-related
info and split BTF will be used to store inline info in a
.BTF.inline section in vmlinux and modules.  For
CONFIG_DEBUG_INFO_BTF=m, vmlinux inline info will be stored
in btf_vmlinux_inline.ko and will be loaded on-demand if used
via /sys/kernel/btf/vmlinux.inline.  A .BTF.inline.link section
in vmlinux stores the module name, the SHA of the BTF and the
size so that even without loading the kernel can size the
sysfs representation correctly.  This approach is based on [1]
and the .BTF.inline.link section is modeled on .GNU_debuglink.

Because a module can be built with .BTF.base to allow for
BTF relocation, its inline info needs to be relocated also
so a bit more work needs to be done to handle this.

Patches 1, 2 add resolve_btfids support to partition BTF
into .BTF and .BTF.inline and to support populating
a BTF link section for BTF_INLINE=m.  Patch 3 handles
vmlinux.inline exposure in sysfs.  Patch 4 does prep
work for relocation needed in patch 5 prior to exposing
relocated BTF in sysfs, and patches 6 and 7 test BTF
sysfs representations and inline validity using
bpf_testmod respectively.

To generate inline info the latest pahole is needed [2].

Inline info for vmlinux can be quite large ~10Mb for
over 600,000 inline sites in the kernel, so

CONFIG_DEBUG_INFO_BTF_INLINE=m

is recommended; this brings the on-disk size down below
4Mb for a gzip-compressed btf_vmlinux_inline.ko.

Changes since v3 [3]:

- Retain original BTF in resolve_btfids and be careful about
  free order (bots, patch 1)
- Add more failure diagnostics to patching of BTF links
  (bots, patch 2)
- Guard vmallocs for zero-sized inline data (bots, patch 3)
- Fix potential NULL pointer BTF deref (bots, patch 5)
- Fix up leaks in sysfs test (bots, patch 6)
- Fix up tests to use kallsyms lookup directly, and improve
  validation of location info (bots, patch 7)

Changes since v2 [4]

 - Delivered the libbpf, bpftool parts are prerequisites
 - Switched to using Eduard's neater BTF partitioning approach which
   is fully in resolve_btfids instead of libbpf (Eduard, patch 1)
 - Supports mmap()ed vmlinux.inline (Alexei, patch 3, test patch 7)
 - Moved to using .BTF.inline.link to store inline BTF size
   which avoids need to switch to using kernfs; also allows us
   to SHA-verify BTF inline info

[1] https://lore.kernel.org/bpf/20260925224229.1850-1-wanjay@amazon.com/
[2] https://git.kernel.org/pub/scm/devel/pahole/pahole.git/
[3] https://lore.kernel.org/bpf/20261003194323.817885-1-alan.maguire@oracle.com/
[4] https://lore.kernel.org/bpf/20260901165757.801449-1-alan.maguire@oracle.com/

Alan Maguire (6):
  resolve_btfids: Populate BTF link section
  kbuild, btf: Expose vmlinux inline BTF through sysfs
  btf: Preserve string relocation maps for split BTF
  btf: Relocate and expose module inline BTF
  selftests/bpf: Test BTF sysfs inline representations
  selftests/bpf: Add a test verifying inline information

Eduard Zingerman (1):
  resolve_btfids: Build separate main and inline BTF objects

 .gitignore                                    |   1 +
 Makefile                                      |   1 +
 include/asm-generic/vmlinux.lds.h             |  31 ++
 include/linux/btf.h                           |  42 +-
 include/linux/module.h                        |   4 +
 kernel/bpf/Makefile                           |   1 +
 kernel/bpf/btf.c                              | 397 +++++++++++++---
 kernel/bpf/btf_vmlinux_inline.c               |  29 ++
 kernel/bpf/sysfs_btf.c                        | 149 +++++-
 kernel/module/main.c                          |   7 +
 lib/Kconfig.debug                             |  18 +
 scripts/Makefile.btf                          |   7 +
 scripts/gen-btf.sh                            |  31 +-
 scripts/link-vmlinux.sh                       |   8 +-
 scripts/package/kernel.spec                   |  10 +-
 tools/bpf/resolve_btfids/Build                |   1 +
 tools/bpf/resolve_btfids/btf_colors.c         | 145 ++++++
 tools/bpf/resolve_btfids/btf_colors.h         |  24 +
 tools/bpf/resolve_btfids/main.c               | 427 +++++++++++++++++-
 tools/lib/bpf/btf.c                           |   2 +-
 tools/lib/bpf/btf_relocate.c                  |   7 +-
 tools/lib/bpf/libbpf_internal.h               |   3 +-
 tools/testing/selftests/bpf/Makefile          |   4 +-
 .../selftests/bpf/prog_tests/btf_inline.c     | 113 +++++
 .../selftests/bpf/prog_tests/btf_sysfs.c      |  87 +++-
 .../selftests/bpf/test_kmods/bpf_testmod.c    |  11 +-
 tools/testing/selftests/bpf/trace_helpers.c   |  20 +
 tools/testing/selftests/bpf/trace_helpers.h   |   1 +
 tools/testing/selftests/hid/Makefile          |   2 +
 29 files changed, 1455 insertions(+), 128 deletions(-)
 create mode 100644 kernel/bpf/btf_vmlinux_inline.c
 create mode 100644 tools/bpf/resolve_btfids/btf_colors.c
 create mode 100644 tools/bpf/resolve_btfids/btf_colors.h
 create mode 100644 tools/testing/selftests/bpf/prog_tests/btf_inline.c

-- 
2.43.5

