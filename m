Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E3C383B4
	for <bpf@vger.kernel.org>; Fri, 22 Mar 2024 10:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711103170; cv=none; b=bXc6X+Dlq+q7Ket7mC7vBMXGNSJrzQiqbIrPFxnhygUAK9QUPoUPHj77kgJ+KFX403cYZzjAHUkucAnuqLCEhdbZozuYbyUsMKA6WTjXy7hCjxMROV37FrLL2zYOFPR2sfhkHtfqwJbF9lyUtuFF2TTXgiGM4uHckmOKWRb+L6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711103170; c=relaxed/simple;
	bh=IGSTlWhz8SlzaGd0ZG98dkKuaOg7LmqVixXqU0Cc2Ys=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q0UeMeyooLS39b3E00uS+MW5eT+cjtdlrs0vEJWt+eWdNBSckmpZl9ff+s+L6IafOUwUbxnrFeq7oBo9Zn8BE4W8nMerJ2hawwD6p6TzPl6lw0AQC0GMUkuR3jLjRG+oFI37XJNDHldHolMz6VHpPF96u4rBcvJvEZ1OAy7FFAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fyjxXhsp; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fyjxXhsp"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42M7YePq000929;
	Fri, 22 Mar 2024 10:25:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=9C8mcHm0cpmhQM2LeopwjuvF+kDNpASADnKCfHi+27w=;
 b=fyjxXhsp6vYbZZV9BW/G6MRsWLIIa/4QPNNPEOxqpaB4RvTjJTUSwS3Q4+s1P9QmCR8W
 aPpViOefIKRswLbB6IxkgbGoz4beXGcMGQ33P53x52CmZ9YZn27/6LCJN2LE2WTBmhZe
 4ZsD3u37ZI3ponTB0fiRGtI1WSKypVPfDb8IagjIOfz2x8gYeDrpBxhBd4qGl5OUNru4
 DIkACqzNOOqcA4gmR3y9E44uWDQKaXbUltmqiVfJ0hVeyKNzS3BkASgT/mBNGjT2AHzP
 7jo1c0rCGTu2tuuJYSFf2ZCIUsbkWtluk3QtUfpDaLNlbFamVR0Hmb/dxM0eVOWHx+QK Bw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x0wvpgs7h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Mar 2024 10:25:48 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42M9APlW014978;
	Fri, 22 Mar 2024 10:25:46 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3x0wvk2j25-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Mar 2024 10:25:46 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42MAK0kf030399;
	Fri, 22 Mar 2024 10:25:46 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-192-105.vpn.oracle.com [10.175.192.105])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3x0wvk2h75-10;
	Fri, 22 Mar 2024 10:25:45 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, jolsa@kernel.org, acme@redhat.com,
        quentin@isovalent.com
Cc: eddyz87@gmail.com, mykolal@fb.com, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, houtao1@huawei.com, bpf@vger.kernel.org,
        masahiroy@kernel.org, mcgrof@kernel.org, nathan@kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [RFC bpf-next 08/13] kbuild, bpf: add module-specific pahole/resolve_btfids flags for base reference BTF
Date: Fri, 22 Mar 2024 10:24:50 +0000
Message-Id: <20240322102455.98558-10-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240322102455.98558-1-alan.maguire@oracle.com>
References: <20240322102455.98558-1-alan.maguire@oracle.com>
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
X-Proofpoint-GUID: AA4vfHdYsM1ORtIE77mTNonAFL42RI-1
X-Proofpoint-ORIG-GUID: AA4vfHdYsM1ORtIE77mTNonAFL42RI-1

Support creation of module BTF along with base reference BTF;
the latter is stored in a .BTF.base_ref ELF section and supplements
split BTF references to base BTF with information about base types,
allowing for later reconciliation of split BTF with a (possibly
changed) base.  resolve_btfids uses the "-r" option to specify
that the BTF.ids section should be populated with split BTF
relative to the added .BTF.base_ref section rather than relative
to the vmlinux base.

Modules using base reference BTF can be built via

BTF_BASE_REF=1 make -C. -M=path2/module

The default is still to use split BTF relative to vmlinux.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 scripts/Makefile.btf      | 7 +++++++
 scripts/Makefile.modfinal | 4 ++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/scripts/Makefile.btf b/scripts/Makefile.btf
index 9694ca3c5252..c8212b2ab7ca 100644
--- a/scripts/Makefile.btf
+++ b/scripts/Makefile.btf
@@ -19,4 +19,11 @@ pahole-flags-$(call test-ge, $(pahole-ver), 126)	= -j --btf_features=encode_forc
 
 pahole-flags-$(CONFIG_PAHOLE_HAS_LANG_EXCLUDE)		+= --lang_exclude=rust
 
+ifeq ($(BTF_BASE_REF),1)
+module-pahole-flags-$(call test-ge, $(pahole-ver), 126)	+= --btf_features=base_ref
+module-resolve-btfids-flags-$(call test-ge, $(pahole-ver), 126) = -r
+endif
+
 export PAHOLE_FLAGS := $(pahole-flags-y)
+export MODULE_PAHOLE_FLAGS := $(module-pahole-flags-y)
+export MODULE_RESOLVE_BTFIDS_FLAGS := $(module-resolve-btfids-flags-y)
diff --git a/scripts/Makefile.modfinal b/scripts/Makefile.modfinal
index 8568d256d6fb..22f5bb0a60a6 100644
--- a/scripts/Makefile.modfinal
+++ b/scripts/Makefile.modfinal
@@ -39,8 +39,8 @@ quiet_cmd_btf_ko = BTF [M] $@
 	if [ ! -f vmlinux ]; then					\
 		printf "Skipping BTF generation for %s due to unavailability of vmlinux\n" $@ 1>&2; \
 	else								\
-		LLVM_OBJCOPY="$(OBJCOPY)" $(PAHOLE) -J $(PAHOLE_FLAGS) --btf_base vmlinux $@; \
-		$(RESOLVE_BTFIDS) -b vmlinux $@; 			\
+		LLVM_OBJCOPY="$(OBJCOPY)" $(PAHOLE) -J $(PAHOLE_FLAGS) $(MODULE_PAHOLE_FLAGS) --btf_base vmlinux $@; \
+		$(RESOLVE_BTFIDS) $(MODULE_RESOLVE_BTFIDS_FLAGS) -b vmlinux $@; 			\
 	fi;
 
 # Same as newer-prereqs, but allows to exclude specified extra dependencies
-- 
2.39.3

