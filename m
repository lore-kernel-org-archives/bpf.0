Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD1148FF76;
	Thu,  8 Oct 2026 11:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791460172; cv=none; b=SH2cOC2oo7eXU2CkSd4f+EKXD2sYp5yyoH+JMH0P1E1nObHMUdnXuuRXscPIqb3CzdBeT442XLTWKtvaHIsWl7RSxS3vbjUh1xJfSF/LuAsiUF9LkCQoL9HzoBjBjXZBvBGATDBg8qQZzVqaJpKrfJzNP8NpmUHPt8NIhVFY0mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791460172; c=relaxed/simple;
	bh=vKUdxEgYBjKV4suFtuZ6q3fC9/5tnK8FfFQYUSI5T7k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MjO4mYGFvBCn7zJ3Xktr+3PFttj2dZi9xw1RPo8HH1J3mLaCjNc7XwpHrf5NFg38E3wLVrXAVYZI3bVNIqFO2Q6V9aPwaawg7cdeLJTh37TxOCw1bFWVJ68t00WSwi0ArmVhTPCPuypd0xMYWoGS3drTieu5d03gRosqnlOQ+Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ChuldMsr; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ChuldMsr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791460171; x=1822996171;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vKUdxEgYBjKV4suFtuZ6q3fC9/5tnK8FfFQYUSI5T7k=;
  b=ChuldMsruBXowAJWnYSbDCSFOaMvOTa8xf6YJtbYD64/dhrS1dhuffmr
   cbcWUm8KpAr9orDLwmDlz4wD4+iFUsGEj+yaskGEyWRPVY7ekhjq/JLY9
   mgg7C4r/DZmr6vxy8pS/DxRosFSVx/mSFkNjpNPTgC/uQHHTDfrAeRvzD
   6mULPNyHLiBtp7mOOSCLbCFIZpCIVKHDn6ONoatTkKm25eKALlaI3kao/
   emclUE70Rn3xSII/gmdVKrekltOWtgAcQH1KkBfELCB0yQqE4blcKVkD3
   9qcQlFxS/2nlkpEMuPRgJXeIxU8oUwqMMyMNYhCM5jXw62oCPEGGVKiGc
   w==;
X-CSE-ConnectionGUID: mncjnWqtTMGOLV1ZScIxlA==
X-CSE-MsgGUID: hVBwT4r2Ry67adeFw1qOgg==
X-IronPort-AV: E=McAfee;i="6800,10657,11928"; a="124936"
X-IronPort-AV: E=Sophos;i="6.27,146,1787036400"; 
   d="scan'208";a="124936"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2026 04:49:31 -0700
X-CSE-ConnectionGUID: NQbx+CruT5WLihvEccHceA==
X-CSE-MsgGUID: 4ancZZDYQ6So+IHzXRWbnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,146,1787036400"; 
   d="scan'208";a="467116"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orviesa010.jf.intel.com with ESMTP; 08 Oct 2026 04:49:29 -0700
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	magnus.karlsson@intel.com,
	stfomichev@gmail.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	tushar.vyavahare@intel.com,
	kerneljasonxing@gmail.com,
	bjorn@kernel.org,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH v2 net-next 04/14] selftests: net: add a generic rule for BPF skeletons
Date: Thu,  8 Oct 2026 13:48:59 +0200
Message-Id: <20261008114909.734364-5-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20261008114909.734364-1-maciej.fijalkowski@intel.com>
References: <20261008114909.734364-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

net/bpf.mk builds the BPF programs of the networking selftests, but a
test that loads its program through a bpftool-generated skeleton has to
bring its own rule for the header. Add a pattern rule that generates
$(OUTPUT)/<name>.skel.h from $(OUTPUT)/<name>.bpf.o. BPFTOOL selects the
bpftool binary and defaults to the one in PATH. When bpftool fails, the
rule removes the partial header, so a later build does not take it as
up to date.

xskxceiver, which moves to net/lib in the next patch, is the first user.

Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 tools/testing/selftests/net/bpf.mk | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/net/bpf.mk b/tools/testing/selftests/net/bpf.mk
index a4f6755dd894..0eca0c5de5b5 100644
--- a/tools/testing/selftests/net/bpf.mk
+++ b/tools/testing/selftests/net/bpf.mk
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 # Rules to generate bpf objs
 CLANG ?= clang
+BPFTOOL ?= bpftool
 SCRATCH_DIR := $(OUTPUT)/tools
 BUILD_DIR := $(SCRATCH_DIR)/build
 BPFDIR := $(top_srcdir)/tools/lib/bpf
@@ -42,6 +43,11 @@ $(BPF_PROG_OBJS): $(OUTPUT)/%.o : %.c $(BPFOBJ) | $(MAKE_DIRS)
 	$(Q)$(CLANG) -O2 -g --target=bpf $(CCINCLUDE) $(CLANG_SYS_INCLUDES) \
 	-c $< -o $@
 
+$(OUTPUT)/%.skel.h: $(OUTPUT)/%.bpf.o
+	$(call msg,GEN-SKEL,,$@)
+	$(Q)$(BPFTOOL) gen skeleton $< name $(notdir $*) > $@ || \
+		{ rm -f $@; exit 1; }
+
 $(BPFOBJ): $(wildcard $(BPFDIR)/*.[ch] $(BPFDIR)/Makefile)		       \
 	   $(APIDIR)/linux/bpf.h					       \
 	   | $(BUILD_DIR)/libbpf
-- 
2.43.0

