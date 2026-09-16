Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50FC4570C7
	for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 07:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789544518; cv=none; b=nrPjB0z9f+jm5RITTw1jC1sQMzy/ZHTn4tUZNaCkjGHHwK8I/IhRNqyB3hQ9n/Kmk6H4I07HoHyThUtYuSe0q+94YqUodQbu4CVLDUCpRaqwGzVgvN9dFw8YQ5DQuxj8Mrnl+eRc6ng6QI3MNebDo7IEuD/go1OGULzdlqfEr1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789544518; c=relaxed/simple;
	bh=clcccecubWNbkRJGOlvtGI0HxACaCQWOksgi+gUV1v4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cbUpRC0R5HfgyHd+wjqQfKC7egJLaeLJoespPPyIBnNfIgmlu3Eqw8z86iQQcWhdJ2L58u6a1eon5lClOwdSH5X8GsUWdZENbz+ESrxmRK32tqrZDzz4q4YiW2n7eh/IxrN3oBMPXRvaI9zFDNMFCzXhkXxi8AY1az/Nw/QCYtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=S2onp5Cf; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="S2onp5Cf"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68FLWUgP2102287;
	Wed, 16 Sep 2026 07:41:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=V6F66y5A4f5ipu5fYrGmClBoWJ/in
	l3FN+DuyakIlgc=; b=S2onp5CfwFMUNoevAKqNbDvrzMAmV+zQOA2UTC1VJLebA
	uKeu2p6JR6ay3Jt6jpsXfkXgjqcE142rJsbmgr4U2WO5BxNiaeNzzPWvUuyB+Csj
	+jdt55a7DfBtmUfm3Dcga2O5iU9nZHurjDW2sIhy9qYnt6vyMG7xTsrIwfFY7u/8
	JgQmjYoeX3KxhiLPIDIAQ5yOyLWjzNhiZXmAlk4GaiDC+nU8ZKEKh91cJduIlDJp
	aAwQL7c40FtJSnfyJQuNQgxESsdRIQKgmQjiZJzHUeb18OOrZASZzje36dtPjYRq
	zeiSodYqU/VCH2bD9gmH9QJx9Itiq4g2ecfjfA2Iw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gmxsbn5yt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Sep 2026 07:41:24 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 68G7e3O6014853;
	Wed, 16 Sep 2026 07:41:23 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4gmw6au4va-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Sep 2026 07:41:23 +0000 (GMT)
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 68G7exPf020284;
	Wed, 16 Sep 2026 07:41:23 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-86-81.vpn.oracle.com [10.154.86.81])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4gmw6au4u1-1;
	Wed, 16 Sep 2026 07:41:22 +0000 (GMT)
From: Alan Maguire <alan.maguire@oracle.com>
To: ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com, jolsa@kernel.org
Cc: daniel@iogearbox.net, ihor.solodrai@linux.dev, yonghong.song@linux.dev,
        song@kernel.org, qmo@kernel.org, martin.lau@linux.dev,
        memxor@gmail.com, emil@etsalapatis.com, bpf@vger.kernel.org,
        nsc@kernel.org, puranjay@kernel.org, yatsenko@meta.com,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v3 bpf-next 00/11] Support inline functions in BTF
Date: Wed, 16 Sep 2026 08:41:07 +0100
Message-ID: <20260916074118.1007116-1-alan.maguire@oracle.com>
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
 definitions=2026-09-15_05,2026-09-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 mlxlogscore=999 adultscore=0 phishscore=0 malwarescore=0
 mlxscore=0 spamscore=0 suspectscore=0 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2609040000 definitions=main-2609160099
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDA5OCBTYWx0ZWRfX2HLusediQPLF
 iwgcShInEzbMfu1oF74h+F2GKBVTmcGdmK1lac7pwdVRqX/m3lrAz1lrbzoJTBGrkAtyXltQYYu
 42894f6VFtl1CEwLz/YbX63vliWCRUa1T/ymntFKOsjnnlv1UCF4bbUfI19OpC6n45knaU/9riq
 A8rOxbQmt2Y2KaghPZIE2ugVKr0E4TURZMwXlV554hzz5atuKUmhXPcTTBMK4EmaS9j0PxU4WCe
 LO4YCEWXra+W4+mMOAlJ3WCDBRM5qeMOfW7v8LQH1O+UGU6lX/KILGC3VIvbmkR0FAguyT0iwaY
 UVG3WwB33nBbKzEaDlA2W3594wUtJRPHbiR4a0jH0LOeX4Ap+lXa08WlemMBbQ7+t9L+NGzd3MA
 U+hKWfwCaZ3uzp49j3Pk2VkvV5PB+selBHE73Rxpr2ayuL9Z0RHGIjBLhkR9+ddGkqSgEyWQNI+
 /aorf4R9xiIM4+6e0wA==
X-Proofpoint-GUID: xJePP1qWeZnCUdVHP2tOkrruudgum7F5
X-Authority-Analysis: v=2.4 cv=dY0VTnXe c=1 sm=1 tr=0 ts=6aaa4824 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=BqU2WV_vvsyTyxaotp0D:22 a=07d9gI8wAAAA:8 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=ooNycMfnROh-Wkvz3G0A:9 a=WmVTiCyuxqgg3mnwYu6p:22 a=e2CUPOnPG4QKp8I52DXD:22
X-Proofpoint-ORIG-GUID: xJePP1qWeZnCUdVHP2tOkrruudgum7F5
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDA5OCBTYWx0ZWRfX7r2OtkmBsPe/
 qmEpSZTV4gKYkxrtldM8XQNO+mJtbQHWrK9vRoy+G7BvNWzHgETWPPWGLfYXTY64jWlRvySaQZP
 8zDj7EOSlpiWvbrTN5m1yWw+aNNucCUxrLawmpuC7LAN3jY3NOJ0

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

Changes since v2 [3]:

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

Changes since RFC [4]:

- Support for distilled base BTF
- Support for BTF_INLINE=m on-demand loading
- Reworked inline support to handle new resolve_btfids model
- .BTF.inline sections host FUNCs/FUNC_PROTOs/strings that are
  needed for inline info only, avoiding polluting standard
  vmlinux/module BTFs

[1] https://lwn.net/Articles/1083985/
[2] https://lore.kernel.org/dwarves/20260902113829.1285407-1-alan.maguire@oracle.com/
[3] https://lore.kernel.org/bpf/20260901165757.801449-1-alan.maguire@oracle.com/
[4] https://lore.kernel.org/bpf/20251008173512.731801-1-alan.maguire@oracle.com/


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

 Documentation/bpf/btf.rst                     |  80 +++-
 include/linux/btf.h                           |  22 +-
 include/uapi/linux/btf.h                      |  65 ++-
 kernel/bpf/btf.c                              | 304 +++++++++++++-
 .../bpf/bpftool/Documentation/bpftool-btf.rst |   7 +-
 tools/bpf/bpftool/btf.c                       | 171 +++++++-
 tools/bpf/bpftool/main.c                      |  22 +-
 tools/include/uapi/linux/btf.h                |  65 ++-
 tools/lib/bpf/btf.c                           | 373 +++++++++++++++++-
 tools/lib/bpf/btf.h                           |  50 +++
 tools/lib/bpf/btf_dump.c                      |   9 +
 tools/lib/bpf/btf_iter.c                      |  18 +
 tools/lib/bpf/libbpf.map                      |   6 +
 tools/lib/bpf/libbpf_internal.h               |   2 +-
 tools/testing/selftests/bpf/btf_helpers.c     |  36 +-
 .../bpf/prog_tests/bpftool_btf_dump.c         |  84 ++++
 .../bpf/prog_tests/btf_dedup_split.c          | 116 ++++++
 .../selftests/bpf/prog_tests/btf_distill.c    | 101 +++++
 .../selftests/bpf/prog_tests/btf_field_iter.c |  31 +-
 tools/testing/selftests/bpf/test_btf.h        |  16 +
 20 files changed, 1555 insertions(+), 23 deletions(-)

-- 
2.43.5

