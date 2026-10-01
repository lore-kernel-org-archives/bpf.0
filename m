Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62DB49A3CC;
	Thu,  1 Oct 2026 20:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790886170; cv=none; b=drYH1dvFZdaS3kJ2742bNTasRxj9HqW/Xuvap/ufZLeCREiY2eVcSxjJrfWavo9x1jWv6SGlXsxhrYBx0BvF5qFQ2UGOSE+1A1z3ard+sqEtBl71uzYmcZ7r12wd1OVSyKxWjXLpX0gdCjsodJglOz0Cza8Gg+s12oISL8eb42k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790886170; c=relaxed/simple;
	bh=lk3ufMV6NL11OzRitMIeLHJ8nUdVJ9+Xl8ehcwdKl1c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dgD9y7PLibiuXPuwj44HbqhncQXUQuqQuw5RVpfeEUaWlYodnTc9OuZr0gzk4LN4V5DXVb/9gMRmCBIaGZWM6cUgXo9uIeDmsMW5uk57qq7fZhLPiXhBrxr7MmuZgHmW8X+nZc+2Zi9bULZV6tOW69lLDPCjEZFcbhBj6lEzV40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NP/9qyUf; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NP/9qyUf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790886160; x=1822422160;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lk3ufMV6NL11OzRitMIeLHJ8nUdVJ9+Xl8ehcwdKl1c=;
  b=NP/9qyUfbWLpWP2gOAkXbE/ms3aT4yi0UJQWPrjskN78p0LixOm1OYQz
   wobnu10cw92zZLe/VtLSu0katmzWsRDhlKq+s1tEEmGwZnWx8QuPy3DJJ
   VIOPPNF6ApRjwGae0jVUPe/8xH70gPZgJ/tKPesWmMHaSlA4qj4vMRnhZ
   fXle+qn2vwqcO51Y8le0v82nW4f2xc9liGFhrUtaI2miMNTTf5ybdel3v
   Pab9QKvhZMMhxGiZBKWMqkp549CkoN4jHoo/vBargXDpJcOqcqjoxXq+q
   Q8y4bF1iPg+52WNAQePsNZDwl6C39ctvw6UB1nwRXBF9QvYNiZnBDFNnb
   g==;
X-CSE-ConnectionGUID: PDsuJ9JZQa2ekWVjKpwR4g==
X-CSE-MsgGUID: vrnvFDnRRUiWKwXmY48DaQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="95466808"
X-IronPort-AV: E=Sophos;i="6.27,135,1787036400"; 
   d="scan'208";a="95466808"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2026 13:22:32 -0700
X-CSE-ConnectionGUID: Fr9ZENxLS5G/n/IVUZ3wSw==
X-CSE-MsgGUID: w+dbwm7yS1uxGaQt07Tn/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,135,1787036400"; 
   d="scan'208";a="275636702"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orviesa007.jf.intel.com with ESMTP; 01 Oct 2026 13:22:31 -0700
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
Subject: [PATCH net-next 04/13] selftests: net: add a generic rule for BPF skeletons
Date: Thu,  1 Oct 2026 22:21:15 +0200
Message-Id: <20261001202124.692591-5-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20261001202124.692591-1-maciej.fijalkowski@intel.com>
References: <20261001202124.692591-1-maciej.fijalkowski@intel.com>
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
bpftool binary and defaults to the one in PATH.

xskxceiver, which moves to net/lib in the next patch, is the first user.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 tools/testing/selftests/net/bpf.mk | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/net/bpf.mk b/tools/testing/selftests/net/bpf.mk
index a4f6755dd894..6a2f078fed9d 100644
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
@@ -42,6 +43,10 @@ $(BPF_PROG_OBJS): $(OUTPUT)/%.o : %.c $(BPFOBJ) | $(MAKE_DIRS)
 	$(Q)$(CLANG) -O2 -g --target=bpf $(CCINCLUDE) $(CLANG_SYS_INCLUDES) \
 	-c $< -o $@
 
+$(OUTPUT)/%.skel.h: $(OUTPUT)/%.bpf.o
+	$(call msg,GEN-SKEL,,$@)
+	$(Q)$(BPFTOOL) gen skeleton $< name $(notdir $*) > $@
+
 $(BPFOBJ): $(wildcard $(BPFDIR)/*.[ch] $(BPFDIR)/Makefile)		       \
 	   $(APIDIR)/linux/bpf.h					       \
 	   | $(BUILD_DIR)/libbpf
-- 
2.43.0

