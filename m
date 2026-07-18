Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63482846F;
	Sat, 18 Jul 2026 13:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784382378; cv=none; b=LPAiUqzxNlBPhEgLE4VmqUzJwsrOkKNKpCchTuT7TaA2+p+Z0e/zJlIS8pz9kuIEHj0wFGaRQ1Pq7tJ8NdPmRGq6ZI0i1n3yb29m4TmoUH/6cs415irBGH94nylLKe/MWaEIBcdz7ykc4h8JcEbNHvoLiIXsPgz+wTbWtqNDZps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784382378; c=relaxed/simple;
	bh=ti3SJliEhTQwXIyW7601QIBqonk8uDfvV/xE/Ni5730=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mNq3DpgDL6K5nRNq+kM1hFJ/AnVPCcFhsIOvY+sf2fHHARm7R/uff4wAIMv3LKJnu4zn8i75jh2fQSlwCInVWybSlHl2YYi4XzFQ+04sw7sxKNdE8eHbp9gNfKVKiXQd8W8bTSo1Dpn0pBRlKbZEl4iEchjaAR2eNXfVpiw3jDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PdrKD4LX; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PdrKD4LX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784382378; x=1815918378;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ti3SJliEhTQwXIyW7601QIBqonk8uDfvV/xE/Ni5730=;
  b=PdrKD4LXRNXgWTG0lbMn3LNSSGFRe69y2ACb0cK44WcqHaUsa2uKamq+
   oG6YK/Gh2Op5g/QtPmmeQgFChFuQiCCzcBow5JLOHABJHv0X7GS9mc0kB
   djo7LmUGt9xiAXNn3Rt/3ZniHYPfo+TsvN4f7k3WY8YyBD2F00EmBkS7W
   5+izEA3O4I5/yyWW/dCbEifd+mlHcQmn1puy+GMr3GiZSr1Sq9uFsftbX
   Hdnb2WTeoEPhMqR1gRHTYWnWbO8bAiyWvhc8Vt3fB7A2Sxck8HGzhbxhd
   jy3FVJToadB9StPHzafzyxUanm+j9eoFHz6z/W/OGKo4dUdRymzj8t4Gu
   g==;
X-CSE-ConnectionGUID: dRVlKGtcTfKuWUKH9XWYjg==
X-CSE-MsgGUID: A/Gosla0ThOCb7Qb6IPozg==
X-IronPort-AV: E=McAfee;i="6800,10657,11849"; a="84980697"
X-IronPort-AV: E=Sophos;i="6.25,171,1779174000"; 
   d="scan'208";a="84980697"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2026 06:46:17 -0700
X-CSE-ConnectionGUID: LSYizkAISyKhCaJKRvUrww==
X-CSE-MsgGUID: QPR/FEB9SuOlrm547vUKVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,171,1779174000"; 
   d="scan'208";a="261995639"
Received: from unknown (HELO brc05..) ([10.190.162.60])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2026 06:46:14 -0700
From: Tushar Vyavahare <tushar.vyavahare@intel.com>
To: netdev@vger.kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	stfomichev@gmail.com,
	kernelxing@tencent.com,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	tirthendu.sarkar@intel.com,
	tushar.vyavahare@intel.com
Cc: bpf@vger.kernel.org
Subject: [PATCH net-next] selftests/xsk: decouple xskxceiver and xdp apps from test_progs objects
Date: Sat, 18 Jul 2026 13:44:50 +0000
Message-ID: <20260718134450.575758-1-tushar.vyavahare@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Build xskxceiver, xdp_hw_metadata, and xdp_features from explicit source
lists instead of reusing helper objects produced by test_progs rules.

Reusing shared objects such as network_helpers.o and xsk.o can pull in
test_progs-only dependency chains and trigger unrelated libarena builds
when invoking a single target.

Keep these standalone binaries self-contained so each target builds only
its own required sources and BPF skeleton dependencies.

Signed-off-by: Tushar Vyavahare <tushar.vyavahare@intel.com>
---
 tools/testing/selftests/bpf/Makefile | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index b642ee489ea6..a6f0ed10ccb4 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -934,17 +934,27 @@ $(OUTPUT)/test_verifier: test_verifier.c verifier/tests.h $(BPFOBJ) | $(OUTPUT)
 	$(call msg,BINARY,,$@)
 	$(Q)$(CC) $(CFLAGS) $(filter %.a %.o %.c,$^) $(LDLIBS) -o $@
 
-# Include find_bit.c to compile xskxceiver.
-EXTRA_SRC := $(TOOLSDIR)/lib/find_bit.c prog_tests/test_xsk.c prog_tests/test_xsk.h
-$(OUTPUT)/xskxceiver: $(EXTRA_SRC) xskxceiver.c xskxceiver.h $(OUTPUT)/network_helpers.o $(OUTPUT)/xsk.o $(OUTPUT)/xsk_xdp_progs.skel.h $(BPFOBJ) | $(OUTPUT)
+# Keep xskxceiver independent from test_progs object dependencies.
+XSKXCEIVER_SRC := xskxceiver.c xsk.c network_helpers.c \
+		  $(TOOLSDIR)/lib/find_bit.c prog_tests/test_xsk.c
+$(OUTPUT)/xskxceiver: $(XSKXCEIVER_SRC) xskxceiver.h xsk.h network_helpers.h \
+			   prog_tests/test_xsk.h test_progs.h bpf_util.h \
+			   $(OUTPUT)/xsk_xdp_progs.skel.h $(BPFOBJ) | $(OUTPUT)
 	$(call msg,BINARY,,$@)
 	$(Q)$(CC) $(CFLAGS) $(filter %.a %.o %.c,$^) $(LDLIBS) -o $@
 
-$(OUTPUT)/xdp_hw_metadata: xdp_hw_metadata.c $(OUTPUT)/network_helpers.o $(OUTPUT)/xsk.o $(OUTPUT)/xdp_hw_metadata.skel.h | $(OUTPUT)
+XDP_HW_METADATA_SRC := xdp_hw_metadata.c xsk.c network_helpers.c \
+			       $(TOOLSDIR)/lib/find_bit.c
+$(OUTPUT)/xdp_hw_metadata: $(XDP_HW_METADATA_SRC) xdp_metadata.h \
+			   xsk.h network_helpers.h test_progs.h bpf_util.h \
+			   $(OUTPUT)/xdp_hw_metadata.skel.h $(BPFOBJ) | $(OUTPUT)
 	$(call msg,BINARY,,$@)
 	$(Q)$(CC) $(CFLAGS) $(filter %.a %.o %.c,$^) $(LDLIBS) -o $@
 
-$(OUTPUT)/xdp_features: xdp_features.c $(OUTPUT)/network_helpers.o $(OUTPUT)/xdp_features.skel.h | $(OUTPUT)
+XDP_FEATURES_SRC := xdp_features.c network_helpers.c
+$(OUTPUT)/xdp_features: $(XDP_FEATURES_SRC) xdp_features.h network_helpers.h \
+			   test_progs.h bpf_util.h $(OUTPUT)/xdp_features.skel.h \
+			   $(BPFOBJ) | $(OUTPUT)
 	$(call msg,BINARY,,$@)
 	$(Q)$(CC) $(CFLAGS) $(filter %.a %.o %.c,$^) $(LDLIBS) -o $@
 
-- 
2.43.0

