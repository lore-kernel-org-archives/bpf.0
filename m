Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F8F42D74E;
	Tue, 28 Jul 2026 11:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785239542; cv=none; b=LT/NvEYFzBdESP31v++pk7YAO1tVwQVfEVvCxvh1govVeXiA1Rey956RFVyQ+S87Vj5/1wFycqTpCz6fNw3BV9J1rRjvSwSfd2ahG+EYQKKjZ+ZiVVPcST/pmFpQ8Xa9xZWBDH/wl8573PXEZY2IjHGhSX1FgvbRRhsqdiY6RrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785239542; c=relaxed/simple;
	bh=FnZZxgfwWPXT4LRpIEflOOdV/AhleSjd6WDy4TDk2xM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fhNI3B2IVYKZzaanLitG5BG5mJbmHfkgnQ62hevnDc70R/6BlSCqniwqomkyklMG5rfvh5vIkWKeF2YHEvGF/DhBDbjy5NIFp7CLfKpy2aF/IUhgFX8caxzO2QwAhaoE3BxKDnNUcLA9sMzfOcLdBtSrUDQpbwLKh3IuYvaKko0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fb2d64e1; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fb2d64e1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785239540; x=1816775540;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FnZZxgfwWPXT4LRpIEflOOdV/AhleSjd6WDy4TDk2xM=;
  b=fb2d64e1zdsOwDzAAyuj2vw3WhcqXQCRsvfGd95WShPqDAnsmpY0k4iI
   hnbXprDJbWJdm8jCIdvohWo9QP5b0CayC252ZsUeS2WI4qQDoROWx8yn9
   WdpOsUqiSDpXf+Hcgzdej0qTSCcDYy11yVKlLrxx+cGFWWiKUNDWnS3al
   YYs+6RFe8BROoA7ircLFjgVloNhnsEVquTaOacmkWxkeGA2GqPaAIqwCR
   iOl8f2cLfkjHA6j6+lm3mzcDu85L+OsXWjNR0hshJCNT3dh03GByf7aRp
   7iW2s/pkmZMrRoGxZWfzd1XU+VpVmq1AUb3hIKEV35tNJsIsjbfQ/1uzM
   g==;
X-CSE-ConnectionGUID: GkJeu4y0TPKE5x4LO0XlqA==
X-CSE-MsgGUID: Rt1N81xXRte5wEJndBtp8w==
X-IronPort-AV: E=McAfee;i="6800,10657,11858"; a="108619216"
X-IronPort-AV: E=Sophos;i="6.25,190,1779174000"; 
   d="scan'208";a="108619216"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2026 04:52:18 -0700
X-CSE-ConnectionGUID: EJ3Yf+pDTseruPKpbG6Txw==
X-CSE-MsgGUID: NsQsz2X8T1io3XbhNsWz2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,190,1779174000"; 
   d="scan'208";a="284224186"
Received: from unknown (HELO brc05..) ([10.190.162.60])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2026 04:52:15 -0700
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
Subject: [PATCH net-next v3] selftests/xsk: decouple xskxceiver and xdp apps from test_progs objects
Date: Tue, 28 Jul 2026 11:50:36 +0000
Message-ID: <20260728115036.2049536-1-tushar.vyavahare@intel.com>
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

Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Tested-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Signed-off-by: Tushar Vyavahare <tushar.vyavahare@intel.com>
---
v3:
- Fix SoB line
- Add tags from Maciej

v2:
- Inline dependency lists in tools/testing/selftests/bpf/Makefile.
- Drop *_SRC helper variables per review feedback.
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

