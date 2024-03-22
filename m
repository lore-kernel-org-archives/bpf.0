Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C6D383AF
	for <bpf@vger.kernel.org>; Fri, 22 Mar 2024 10:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711103144; cv=none; b=kdYYn+m73PiJl9qamfKROzHAWREPN0PCcIxZWJYIQQiCFQwmOqKb7Q/V4KEqKXJb7YGIVZEaGIXckhayP6iViaUjz0LIt634DXg3r/FkqmTpLpJ4yNg+fe6cUQMP0gMjVz2zLlZ+tco/jv2QcY/mQkYQwHB83gGW8qY/9pMHkuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711103144; c=relaxed/simple;
	bh=GDAHKBH2DnBUD3iBCCF8d2b3dlH3ZfIlmFCol77bA8s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sPuuukum87b+vJVj4WxvevEi/zfBcSl7LLR4eNWH1Yc+26Jqv85a8MqzUr/qCBWLTVAKEfqzVrsWYH1ckW2Q//ygkbWiLF9SnKVlZOr1FHwm3t8GagGqBYEkdl6MbCzCyA/T5kbSyEMvEQ13hv1QQ6xmoCxk1y/G8p7TbMskz+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=E/f7xRNo; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="E/f7xRNo"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42M7Y1h5019499;
	Fri, 22 Mar 2024 10:25:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-11-20; bh=pDl+B5T2OxkNgYwhplvBlsIKPN6cDZnwqlGVsd9Nfk4=;
 b=E/f7xRNoUnB3pJ9x9BfIIfsnzhyOb06xVgRm7v2RmFP1vEvHEifREQKkEgxBNc//lHWM
 Qc8OsDSD3TOpalaRfDlx3zFmZ6tOAm39rIc1yNEEApch5qaQzJykaRHoPyRpZ5aWzHio
 3w/WMHSqX9HLKW2JwtlBTey5r14GMbs+Erv/4TaFmKe32FOeomyrNIcDwLYG8ezE7A86
 fop3pscclHIEfDVoEvccKQ9SJpQJ7zHwlBIjHLJvSGb+/Lws8z3G94juB+XoNEtrvX4Q
 ttkOdC5RxEpeqznloiHcgSrzqF8KkrDhRWpVd/D11tZChUpTcq/vLmpiBuiVFHSaB/Gv nA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x0wvmgt66-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Mar 2024 10:25:02 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42M8xXAf014414;
	Fri, 22 Mar 2024 10:25:02 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3x0wvk2h9c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Mar 2024 10:25:02 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42MAK0kN030399;
	Fri, 22 Mar 2024 10:25:01 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-192-105.vpn.oracle.com [10.175.192.105])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3x0wvk2h75-1;
	Fri, 22 Mar 2024 10:25:01 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, jolsa@kernel.org, acme@redhat.com,
        quentin@isovalent.com
Cc: eddyz87@gmail.com, mykolal@fb.com, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, houtao1@huawei.com, bpf@vger.kernel.org,
        masahiroy@kernel.org, mcgrof@kernel.org, nathan@kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [RFC bpf-next 00/13] bpf: support resilient split BTF
Date: Fri, 22 Mar 2024 10:24:41 +0000
Message-Id: <20240322102455.98558-1-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-22_06,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 spamscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2403210000
 definitions=main-2403220074
X-Proofpoint-GUID: Ya70IcE-ZYTVMYXMZayor_6mYektGnmx
X-Proofpoint-ORIG-GUID: Ya70IcE-ZYTVMYXMZayor_6mYektGnmx

Split BPF Type Format (BTF) provides huge advantages in that kernel
modules only have to provide type information for types that they do not
share with the core kernel; for core kernel types, split BTF refers to
core kernel BTF type ids.  So for a STRUCT sk_buff, a module that
uses that structure (or a pointer to it) simply needs to refer to the
core kernel type id, saving the need to define the structure and its many
dependents.  This cuts down on duplication and makes BTF as compact
as possible.

However, there is a downside.  This scheme requires the references from
split BTF to base BTF to be valid not just at encoding time, but at use
time (when the module is loaded).  Even a small change in kernel types
can perturb the type ids in core kernel BTF, and due to pahole's
parallel processing of compilation units, even an unchanged kernel can
have different type ids if BTF is re-generated.  So we have a robustness
problem for split BTF for cases where a module is not always compiled at
the same time as the kernel.  This problem is particularly acute for
distros which generally want module builders to be able to compile a
module for the lifetime of a Linux stable-based release, and have it
continue to be valid over the lifetime of that release, even as changes
in data structures (and hence BTF types) accrue.  Today it's not
possible to generate BTF for modules that works beyond the initial
kernel it is compiled against - kernel bugfixes etc invalidate the split
BTF references to vmlinux BTF, and BTF is no longer usable for the
module.

The goal of this series is to provide options to provide additional
context for cases like this.  That context comes in the form of "base
reference" BTF; it stands in for the base BTF, and contains
information about the types referenced from split BTF, but not their
full descriptions.  The modified split BTF will refer to type ids in
this .BTF.base_ref section, and when the kernel loads such modules it
will use the base reference BTF to map references from split BTF to the
current vmlinux BTF - a process of reconciling split BTF with the
currently-running kernel's vmlinux base BTF.

A module builder - using this series along with the pahole changes -
can then build a module with base reference BTF via

BTF_BASE_REF=1 make -C . M=path/2/module

For this to work, pahole will have to be built with libbpf based on
this series and with the patch titled

[RFC dwarves] btf_encoder: add base_ref BTF feature to generate split
BTF with base refs

The module will have a .BTF section (the split BTF) and a
.BTF.base_ref section.  The latter is small in size - base reference
BTF does not need full struct/union/enum information for named
types for example.  For 2667 modules built with base reference BTF,
the average size observed was 1556 bytes (stddev 1563).

Note that for the in-tree modules, this approach is not needed as
split and base BTF in the case of in-tree modules are always built
and re-built together.

The series first focuses on generating split BTF with base reference
BTF, and provides btf__parse_opts() which allows specification
of the section name from which to read BTF data, since we now have
both .BTF and .BTF.base_ref sections that can contain such data.

Then we add support to resolve_btfids for generating the .BTF.ids
section with reference to the .BTF.base_ref section - this ensures the
.BTF.ids match those used in the split/base reference BTF.

Finally the series provides the mechanism for reconciling split BTF with
a new base; the base reference BTF is used to map the references to base
BTF in the split BTF to the new base.  For the kernel, this
reconciliation process happens at module load time, and we reconcile
split BTF references to base BTF with the current vmlinux BTF.  .BTF.ids
need to be reconciled also.

So concretely, what happens is

- we generate split BTF in the .BTF section of a module that refers to
  types in the .BTF.base_ref section as base types; these are not full
  type descriptions but provide information about the base type.  So
  a STRUCT sk_buff would be represented as a FWD struct sk_buff in
  base reference BTF for example.
- when the module is loaded, the split BTF is reconciled with vmlinux
  BTF; in the case of the FWD struct sk_buff, we find the STRUCT sk_buff
  in vmlinux BTF and map all split BTF references to the base reference
  FWD sk_buff to the vmlinux BTF STRUCT sk_buff.

Support is also added to bpftool to be able to display split BTF
relative to its .BTF.base_ref section and display the reconciled form.

A previous approach to this problem [1] utilized standalone BTF for such
cases - where the BTF is not defined relative to base BTF so there is no
reconciliation required.  The problem with that approach is that from
the verifier perspective, some types are special, and having a custom
representation of a core kernel type that did not necessarily match the
current representation is not tenable.  So the approach taken here was
to preserve the split BTF model while minimizing the representation of
the context needed to reconcile split and current vmlinux BTF.

[1] https://lore.kernel.org/bpf/20231112124834.388735-14-alan.maguire@oracle.com/

Alan Maguire (13):
  libbpf: add support to btf__add_fwd() for ENUM64
  libbpf: add btf__new_split_base_ref() creating split BTF with
    reference base BTF
  selftests/bpf: test split base reference BTF generation
  libbpf: add btf__parse_opts() API for flexible BTF parsing
  bpftool: support displaying raw split BTF using base reference BTF as
    base
  kbuild,bpf: switch to using --btf_features for pahole v1.26 and later
  resolve_btfids: use .BTF.base_ref BTF as base BTF if -r option is used
  kbuild, bpf: add module-specific pahole/resolve_btfids flags for base
    reference BTF
  libbpf: split BTF reconciliation
  module, bpf: store BTF base reference pointer in struct module
  libbpf,bpf: share BTF reconcile-related code with kernel
  selftests/bpf: extend base reference tests cover BTF reconciliation
  bpftool: support displaying reconciled-with-base split BTF

 include/linux/btf.h                           |  29 +
 include/linux/module.h                        |   2 +
 kernel/bpf/Makefile                           |   8 +
 kernel/bpf/btf.c                              | 197 +++++-
 kernel/module/main.c                          |   2 +
 scripts/Makefile.btf                          |  12 +-
 scripts/Makefile.modfinal                     |   4 +-
 .../bpf/bpftool/Documentation/bpftool-btf.rst |  17 +
 tools/bpf/bpftool/btf.c                       |  33 +-
 tools/bpf/bpftool/main.c                      |  14 +-
 tools/bpf/bpftool/main.h                      |   2 +
 tools/bpf/resolve_btfids/main.c               |  17 +-
 tools/lib/bpf/Build                           |   2 +-
 tools/lib/bpf/btf.c                           | 434 +++++++++----
 tools/lib/bpf/btf.h                           |  56 ++
 tools/lib/bpf/btf_common.c                    | 146 +++++
 tools/lib/bpf/btf_reconcile.c                 | 614 ++++++++++++++++++
 tools/lib/bpf/libbpf.map                      |   3 +
 tools/lib/bpf/libbpf_internal.h               |   2 +
 .../bpf/prog_tests/btf_split_base_ref.c       | 254 ++++++++
 20 files changed, 1668 insertions(+), 180 deletions(-)
 create mode 100644 tools/lib/bpf/btf_common.c
 create mode 100644 tools/lib/bpf/btf_reconcile.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/btf_split_base_ref.c

-- 
2.39.3

