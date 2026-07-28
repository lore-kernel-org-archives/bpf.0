Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D353A2551;
	Tue, 28 Jul 2026 06:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785218982; cv=none; b=FqP0oe7K4zf1qEdbjKoaoFHeg8GlWDMCoO3MHgj/yEKxRuC457Fw+8yzqM1EsxTWaPAjf8CoTMjYy4uDx0To0h6W3AM6hrSjHpNKsoMP7Y5287WzvNERibGb/rLjFWTim1nEDLQ1BkeuQ/QN5WMWi50bR7HuanjTMYsV+RKTPFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785218982; c=relaxed/simple;
	bh=ue0Ss3++MOkygxbDEiaNhKUsfPTMdDfTvduvWjVo6TU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QdNOhfqT58Sl0cRwUH7qINvMgJKouUr0WN11nQU8JfUwrek1AUDRcIyW1cXFG0NwlPaPeULWk8UJl7AGfzWqVaC4PxHmNA7ADT0V/fh72/n1Kwmy+OFmHjrHBAxo2am78J5c9eKGI7ZvF9R/XJyF3vmLaVd8tkVNB8I1iv3xzkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eswpGkBG; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eswpGkBG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785218980; x=1816754980;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ue0Ss3++MOkygxbDEiaNhKUsfPTMdDfTvduvWjVo6TU=;
  b=eswpGkBGfT8EWBS/SSznK45QcltXF0fcxrKIbmIwN4RoASC2ra7W2Y0g
   4M/26kfDgWhxbklpQufYe2NUEkNrLL3FVS7rxsUH6oESyhunbVu4BU/dE
   dfn9v8kjHiTno0dZlJVx27031oM09+Lk4KzOBCv281cI1ASqwsxQv2VHE
   cefLVpq28ZzjmcqytdPMecLzKPT6eg7UTPJqcb/t8Z+uCBxmaKkLV6wmx
   1+zJLD/cTT3yaKsFLvdgJhfMQ+GtPuxQr0tc4k9D05suNzVJ9KhVW7895
   0h2t8GLmoh5YVaSiZpB7ocb41gSh7kOLJJtcRvznu9edW/6m3tqYs2wCo
   A==;
X-CSE-ConnectionGUID: SGUAn9kATlu31S9iuvlGVA==
X-CSE-MsgGUID: 6BcEXaj5QfCfH07SoVAa8Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11858"; a="97171050"
X-IronPort-AV: E=Sophos;i="6.25,189,1779174000"; 
   d="scan'208";a="97171050"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 23:09:39 -0700
X-CSE-ConnectionGUID: LuYNrYPETQqI7vP027Uzmg==
X-CSE-MsgGUID: PMt7PumiTjCc3pcubCpFxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,189,1779174000"; 
   d="scan'208";a="258343502"
Received: from unknown (HELO brc05..) ([10.190.162.60])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 23:09:35 -0700
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
	tushar.vyavahare@intel.com,
	andrii.nakryiko@gmail.com
Cc: bpf@vger.kernel.org
Subject: [PATCH net-next v2] selftests/xsk: decouple xskxceiver and xdp apps from test_progs objects
Date: Tue, 28 Jul 2026 06:07:58 +0000
Message-ID: <20260728060758.1970618-1-tushar.vyavahare@intel.com>
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

---
v2:
- Inline dependency lists in tools/testing/selftests/bpf/Makefile.
- Drop *_SRC helper variables per review feedback.

Signed-off-by: Tushar Vyavahare <tushar.vyavahare@intel.com>
---
 tools/testing/selftests/bpf/Makefile | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index b642ee489ea6..f4e78bf8ec80 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -934,17 +934,26 @@ $(OUTPUT)/test_verifier: test_verifier.c verifier/tests.h $(BPFOBJ) | $(OUTPUT)
 	$(call msg,BINARY,,$@)
 	$(Q)$(CC) $(CFLAGS) $(filter %.a %.o %.c,$^) $(LDLIBS) -o $@
 
-# Include find_bit.c to compile xskxceiver.
-EXTRA_SRC := $(TOOLSDIR)/lib/find_bit.c prog_tests/test_xsk.c prog_tests/test_xsk.h
-$(OUTPUT)/xskxceiver: $(EXTRA_SRC) xskxceiver.c xskxceiver.h $(OUTPUT)/network_helpers.o $(OUTPUT)/xsk.o $(OUTPUT)/xsk_xdp_progs.skel.h $(BPFOBJ) | $(OUTPUT)
+# Keep xskxceiver independent from test_progs object dependencies.
+$(OUTPUT)/xskxceiver: xskxceiver.c xsk.c network_helpers.c \
+			   $(TOOLSDIR)/lib/find_bit.c prog_tests/test_xsk.c \
+			   xskxceiver.h xsk.h network_helpers.h \
+			   prog_tests/test_xsk.h test_progs.h bpf_util.h \
+			   $(OUTPUT)/xsk_xdp_progs.skel.h $(BPFOBJ) | $(OUTPUT)
 	$(call msg,BINARY,,$@)
 	$(Q)$(CC) $(CFLAGS) $(filter %.a %.o %.c,$^) $(LDLIBS) -o $@
 
-$(OUTPUT)/xdp_hw_metadata: xdp_hw_metadata.c $(OUTPUT)/network_helpers.o $(OUTPUT)/xsk.o $(OUTPUT)/xdp_hw_metadata.skel.h | $(OUTPUT)
+$(OUTPUT)/xdp_hw_metadata: xdp_hw_metadata.c xsk.c network_helpers.c \
+			   $(TOOLSDIR)/lib/find_bit.c xdp_metadata.h \
+			   xsk.h network_helpers.h test_progs.h bpf_util.h \
+			   $(OUTPUT)/xdp_hw_metadata.skel.h $(BPFOBJ) | $(OUTPUT)
 	$(call msg,BINARY,,$@)
 	$(Q)$(CC) $(CFLAGS) $(filter %.a %.o %.c,$^) $(LDLIBS) -o $@
 
-$(OUTPUT)/xdp_features: xdp_features.c $(OUTPUT)/network_helpers.o $(OUTPUT)/xdp_features.skel.h | $(OUTPUT)
+$(OUTPUT)/xdp_features: xdp_features.c network_helpers.c xdp_features.h \
+			   network_helpers.h \
+			   test_progs.h bpf_util.h $(OUTPUT)/xdp_features.skel.h \
+			   $(BPFOBJ) | $(OUTPUT)
 	$(call msg,BINARY,,$@)
 	$(Q)$(CC) $(CFLAGS) $(filter %.a %.o %.c,$^) $(LDLIBS) -o $@
 
-- 
2.43.0

