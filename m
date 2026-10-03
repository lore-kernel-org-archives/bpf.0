Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531A838887E;
	Sat,  3 Oct 2026 19:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791056651; cv=none; b=mBY7POZDxK2PIYkGceIXl1IRqg2y5Lb2BmtlmtaXpwqWhIMVcybXbls6qEj/x6Ba4GrnObEOuoE933l8dQQkjzM6LQ45PSn8o5CT4nb1QkmO+fkPtJxWLO8+fQ9XcLgnGYEiVjAYRQhsKkTN0V6OJZkGP0Ljzb/p304wWfYoIwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791056651; c=relaxed/simple;
	bh=6ZovYYbWjGYCuBkrTgOY81j47MJnMQ/dNXtVS9hic2M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lraKOJetaYnhrzjGg3K4S9r23V/B6lWGRVNG29WCq59eA84z40YKpdBaKlNgvjfDKc1vqJUQGKzg5avnNnPK9BZ9lPrx+E/Bpx8tQVMHbcPfyceYN8n4A2GZBL4LlUaddbLP0P2VIYQIWI6BdT0PqA4FJ4iGtCYXFhffULJwHw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=iTWYR3ui; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iTWYR3ui"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 693JUZvL1921496;
	Sat, 3 Oct 2026 19:43:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=tCotY605grdeoGs77ZnMVNVDAaeX+
	o7WQynztT00BEk=; b=iTWYR3uiOw7zN+kO/lBqT15ou0AUjfL/mWWseM10X3M8h
	AWTb9j5G9io67F05ohPgNfrJ5t44HZ4Lm+6fxrB/fCsJfdzGzHll9sOCvRs0qlzV
	qxOrNjdIGN3Qn997aoFbpnyjjpZe2JKTHQcTVSNriYbirzKcZs+5lr5L2OySKSI6
	qHNLjP/39IBBi8gDQLZ8nlTUuW4Dxop+1fc1HG79cuP0RopQaPlCaFEYZU1a9Pxp
	Tob59nCujv8XuAydMo+VXrurLlbiudUmxoLoRvYIwchGrGYT8tX2FGnyJ7FkuLKw
	IcAf8qNqGyirPXPx+JMrhVXwIBf5NnNSqwXAQ0Bfw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4h2sas0dg3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 03 Oct 2026 19:43:31 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 693JZ19L005025;
	Sat, 3 Oct 2026 19:43:30 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4h2r58yypg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 03 Oct 2026 19:43:30 +0000 (GMT)
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 693JdEMr012617;
	Sat, 3 Oct 2026 19:43:29 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-83-182.vpn.oracle.com [10.154.83.182])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4h2r58yynt-1;
	Sat, 03 Oct 2026 19:43:29 +0000 (GMT)
From: Alan Maguire <alan.maguire@oracle.com>
To: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com
Cc: jolsa@kernel.org, ihor.solodrai@linux.dev, yonghong.song@linux.dev,
        song@kernel.org, qmo@kernel.org, martin.lau@linux.dev,
        memxor@gmail.com, emil@etsalapatis.com, mcgrof@kernel.org,
        petr.pavlu@suse.com, tj@kernel.org, kees@kernel.org, nathan@kernel.org,
        arnd@arndb.de, puranjay@kernel.org, yatsenko@meta.com,
        atenart@kernel.org, ojeda@kernel.org, linux-modules@vger.kernel.org,
        arnaldo.melo@gmail.com, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v3 bpf-next 0/7] kbuild, bpf: Support inline info in BTF
Date: Sat,  3 Oct 2026 20:43:16 +0100
Message-ID: <20261003194323.817885-1-alan.maguire@oracle.com>
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
 definitions=2026-10-03_03,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 spamscore=0 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0 bulkscore=0
 adultscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2609040000 definitions=main-2610030078
X-Proofpoint-ORIG-GUID: DEjU-F8qwfKmpUJN4_tWmFHKBeLxasNV
X-Authority-Analysis: v=2.4 cv=RIMmjIi+ c=1 sm=1 tr=0 ts=6ac15ae3 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=3I1J8UUJPc9JN9BFgKH3:22 a=VwQbUJbxAAAA:8 a=vggBfdFIAAAA:8 a=yPCof4ZbAAAA:8
 a=IWlrVMBtG63jYLy6OlsA:9
X-Proofpoint-GUID: DEjU-F8qwfKmpUJN4_tWmFHKBeLxasNV
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAzMDA3OCBTYWx0ZWRfX6E7Jmk9cnjRs
 f2AsxO8Mpjkn3fIviigvrwpaqYQTj+QA28EhYF8xVe1Yqy3XCB0AERYoLxLZkBqG8Oiir9SuDd8
 5W7DGBsWzmYFc+r5Mvm4dmIvGSXnq8T9kfrnzw76UgUNmw4rPe62
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAzMDA3OCBTYWx0ZWRfXzb66xaK/WAc7
 ZK7kS/lTlLyErw7beshI+lBLcm5BSrkUt7XKEJAgSxD9UkT/FV/pUhzeIN8mQv0x19eLdRBkmyI
 A4ktT0VRiroRrnlhasR9+EKPODmC35td9zknfwhLIVZ12u1UfzFBSdST8Lk3g/XCzc29ZuFx/yL
 KeEJclD1mbmMmvW4Bhn/axNzamZq/7F9MpTuEXqSafKiUoNz0HRHDgOH+UEV9L70enaYLFWkT3J
 a8k3asksOSs2HmBY7wDyHJnrIlspPURLHhDFlWGA67uYsFBi1bP3vuU2jDh3ATVYGjJrGgu/GKa
 dxzswhFU5exxAe9XuvULi7OJOQFDFU7QqCV+1L2xd3H9Sp4Ve+B6qNtQq3jxAH183tNq0wG0/A7
 bbswuq/quTtwzPCa/KDMRGH7dhlNRFSewNrdc7oN8Ofvc2EAKxC+/KLhjYQr1Vqgx3jUsiQJTjm
 CoLyVeAKYWkvxlTddqA==

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
4Mb.

Changes since v2 [3]

 - Delivered the libbpf, bpftool parts are prerequisites
 - Switched to using Eduard's neater BTF partitioning approach which
   is fully in resolve_btfids instead of libbpf (Eduard, patch 1)
 - Supports mmap()ed vmlinux.inline (Alexei, patch 3, test patch 7)
 - Moved to using .BTF.inline.link to store inline BTF size
   which avoids need to switch to using kernfs; also allows us
   to SHA-verify BTF inline info

[1] https://lore.kernel.org/bpf/20260925224229.1850-1-wanjay@amazon.com/
[2] https://git.kernel.org/pub/scm/devel/pahole/pahole.git/
[3] https://lore.kernel.org/bpf/20260901165757.801449-1-alan.maguire@oracle.com/

Alan Maguire (6):
  resolve_btfids: Populate BTF link section
  kbuild, btf: Expose vmlinux inline BTF through sysfs
  btf: Preserve string relocation maps for split BTF
  btf: Relocate and expose module inline BTF
  selftests/bpf: Test BTF sysfs inline representations
  selftests/bpf: Add a test verifying inline information

Eduard Zingerman (1):
  resolve_btfids: Build separate main and inline BTF objects

 Makefile                                      |   1 +
 include/asm-generic/vmlinux.lds.h             |  27 ++
 include/linux/btf.h                           |  42 +-
 include/linux/module.h                        |   4 +
 kernel/bpf/Makefile                           |   1 +
 kernel/bpf/btf.c                              | 386 ++++++++++++++----
 kernel/bpf/btf_vmlinux_inline.c               |  29 ++
 kernel/bpf/sysfs_btf.c                        | 145 ++++++-
 kernel/module/main.c                          |   7 +
 lib/Kconfig.debug                             |  19 +
 scripts/Makefile.btf                          |   7 +
 scripts/gen-btf.sh                            |  31 +-
 scripts/link-vmlinux.sh                       |   8 +-
 scripts/package/kernel.spec                   |  10 +-
 tools/bpf/resolve_btfids/Build                |   1 +
 tools/bpf/resolve_btfids/btf_colors.c         | 145 +++++++
 tools/bpf/resolve_btfids/btf_colors.h         |  24 ++
 tools/bpf/resolve_btfids/main.c               | 352 +++++++++++++++-
 tools/lib/bpf/btf.c                           |   2 +-
 tools/lib/bpf/btf_relocate.c                  |   7 +-
 tools/lib/bpf/libbpf_internal.h               |   3 +-
 tools/testing/selftests/bpf/Makefile          |   4 +-
 .../selftests/bpf/prog_tests/btf_inline.c     | 110 +++++
 .../selftests/bpf/prog_tests/btf_sysfs.c      |  76 ++++
 .../selftests/bpf/test_kmods/bpf_testmod.c    |   2 +-
 tools/testing/selftests/bpf/trace_helpers.c   |  20 +
 tools/testing/selftests/bpf/trace_helpers.h   |   1 +
 tools/testing/selftests/hid/Makefile          |   2 +
 28 files changed, 1362 insertions(+), 104 deletions(-)
 create mode 100644 kernel/bpf/btf_vmlinux_inline.c
 create mode 100644 tools/bpf/resolve_btfids/btf_colors.c
 create mode 100644 tools/bpf/resolve_btfids/btf_colors.h
 create mode 100644 tools/testing/selftests/bpf/prog_tests/btf_inline.c

-- 
2.43.5

