Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68EC598BEF;
	Fri, 16 Oct 2026 17:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792172642; cv=none; b=Y+AqzcU2cgy5vty6lLQVfp661heHwVvDc1heTdt672MVWW81PTpO5yG78Wp+MWZ6rR9EMe5RivRa3WQ5IS4XgzyuOvANsKpYouhyHRA17lGIWUdDHsr0nrg8tO3q+Xv5QQkPkZIUFVjuqiJoek/Ba5n63OcZeqpzuqVsdVwBFqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792172642; c=relaxed/simple;
	bh=ET93SLZI1pICuf19eo4HcWM5OwJk0++f1Zm11+bMMU0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o0kwM4npvAI9Vjgd1G4OuTOaYk9o30H+iP9iTde86jC1a1T93MCt1TjuhaNybc2/Ts7yU7kmFpKDRiqjk1J17cDHJsJohsMKLXkzyEA0FF6wEsSg5197+iePir65Lum/azQBb727eTufJCwO3rcQhjkisBMqDpeK9QF33c8wk/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AgatvIeo; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AgatvIeo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792172641; x=1823708641;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ET93SLZI1pICuf19eo4HcWM5OwJk0++f1Zm11+bMMU0=;
  b=AgatvIeo88BvRIVxgNeSkxEVPPvp55LiySCq/7G1DdiHGMx37sqkj4Ti
   vGblDwl7rphRXfnJLH/OCZXm8wUK/p71cv82niJMknmqqcrKHCcMHjOBl
   9wUdvO7cEdbzJhbyEDDnOGfmwTcx2pbEXiSkmy+2GoY6g2aQXirKvv0Nq
   WR1IyIZNw0JBatbnwYO4gcms3GrJM2aHtBogajrp4BNafvK8M+jP8Rli7
   pPLY69WwpLnFgJUzUwPxhgtKKbIB3rIYb7IUrKT7mRD3/0gWpcZ1v5iUh
   L/kYiLUnyx0YLBoCz3TjHMwbVIND3Ns9pFBtBGjjLALKQ4DpzZrf4oiv/
   Q==;
X-CSE-ConnectionGUID: drrvDhXpTlqtv29t/08lag==
X-CSE-MsgGUID: Tifb8u48T7qeRI4/yjiyhQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11937"; a="972355"
X-IronPort-AV: E=Sophos;i="6.27,162,1787036400"; 
   d="scan'208";a="972355"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2026 10:44:00 -0700
X-CSE-ConnectionGUID: aeHxGyvcSLilkrIv9fFUKQ==
X-CSE-MsgGUID: +TWc1DxDQaWP8SXVLih3BA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,162,1787036400"; 
   d="scan'208";a="2425194"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orviesa010.jf.intel.com with ESMTP; 16 Oct 2026 10:43:58 -0700
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
Subject: [PATCH v4 net-next 05/15] selftests: net: add a generic rule for BPF skeletons
Date: Fri, 16 Oct 2026 19:43:28 +0200
Message-Id: <20261016174338.787135-6-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20261016174338.787135-1-maciej.fijalkowski@intel.com>
References: <20261016174338.787135-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

net/bpf.mk builds the BPF programs of the networking selftests, but a
test that loads its program through a bpftool-generated skeleton has to
bring its own rule for the header. Add a pattern rule that generates
$(OUTPUT)/<name>.skel.h from $(OUTPUT)/<name>.bpf.o with $(BPFTOOL),
which defaults to the bpftool in PATH. A failing bpftool leaves no
partial header behind for a later build to take as up to date.

xskxceiver, which moves to net/lib in the next patch, is the first user.

Reviewed-by: Björn Töpel <bjorn@kernel.org>
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

