Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354AF56C64F;
	Wed, 14 Oct 2026 18:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792003568; cv=none; b=hpRQCUj6lvlN1c+o3w8sj4oLuMIdVYqVgKvjH2IfD75IuTRaP+/bo01iSzCNzpM0BzYIJhuuarDhjrfy/GQgS+2sOTXmEcjdtWY20YQ5BrlFwB/yCOjq9Du2MS6xQjKg7N59ibZB7CUYzJomsclRTWHnMeN2UwixB40BXRf7KSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792003568; c=relaxed/simple;
	bh=m7SLaQhzFifjvUFLCkYcogdkANxF8vk00vyfFTxfe9s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Eh4jltMRu2F9HkWAL4D0eoe7SNoxQFMukErSOmDU31PxChzpOS9A6AxBvB1ArJ/bobfyLnwhh2hs60IggfXEBYCrZ28xq7iNG5DWZscQ9R1usxPclfeBcnNmMfRyTfdkeQDzp0QCSUp4BVwlCTpgyzxBhs6LlL+qlpDEWvW7QkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OR2mlGeJ; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OR2mlGeJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792003566; x=1823539566;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=m7SLaQhzFifjvUFLCkYcogdkANxF8vk00vyfFTxfe9s=;
  b=OR2mlGeJGWWJUH3nrZaZvHf6ryUMCHyMtdKscoT1Kwz5hiRRUiEzfL1R
   Gk0vtuyr5WlCcwjCqK72xfvBNMbgS3mE0Kxt7fsDDXXoI30OyqV6vjniu
   W1K4THVcaxK0XlmkHkghlQ3pk3+kfdEuO7ikE0yS2OzAlt8QGSnfwB213
   QklHRy2RKQAY55Hk8G6xYtCtaDhrNnSTqeTE5t+823farZP2XH417zY/2
   i2Tqi61HiT0k6U7+dVsZ5fdXA/jMGUH2DKJHmwr1JSLXXx79PH44l2YK3
   pZ9Vz7ZA9SC3kEf2XV/VexXGpGzffCrEnwrir5jCai5hCsSAsbSNQI2mU
   A==;
X-CSE-ConnectionGUID: sUXQ2eDcQbChgxbeWtPSwg==
X-CSE-MsgGUID: T+tJF+GsTfOo69BBmEjCBg==
X-IronPort-AV: E=McAfee;i="6800,10657,11935"; a="767284"
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="767284"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2026 11:46:06 -0700
X-CSE-ConnectionGUID: 63vtodrURoaTICxvjXyKAQ==
X-CSE-MsgGUID: YlgyiSgXRdqHaFCaFLh1GQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="1420707"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orviesa009.jf.intel.com with ESMTP; 14 Oct 2026 11:46:04 -0700
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
Subject: [PATCH v3 net-next 05/15] selftests: net: add a generic rule for BPF skeletons
Date: Wed, 14 Oct 2026 20:45:29 +0200
Message-Id: <20261014184539.774708-6-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20261014184539.774708-1-maciej.fijalkowski@intel.com>
References: <20261014184539.774708-1-maciej.fijalkowski@intel.com>
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
$(OUTPUT)/<name>.skel.h from $(OUTPUT)/<name>.bpf.o with $(BPFTOOL),
which defaults to the bpftool in PATH. A failing bpftool leaves no
partial header behind for a later build to take as up to date.

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

