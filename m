Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795021165;
	b=47D4GdNrCEE5pSMLic0NfbejR0YGkAymRqpbx2nm8w2DUqeb/xUWs2ospXZ8EMUe6fnz
	 VFJjyfRLQA80vvK+cVxCg1rr+Cjxibr/njDOQaqdOoiGjE8kTFoBnKbHLm9QesPW63396
	 NsX7Hhn4nDi5oh8IGrbw/cQFeLCg7Ai8CKQMpeZ0GwuboKr1i/IS5IXG52S23GNOXDRya
	 yh25Dp30y9zUakhJ6bu0xdCJDntB4OHinPFyNM29Tr0029s7+vQAZ9D+vR761hFtvA5gb
	 zwVdHBCPnzpR9khjTHzI7ibh2We48j+Qpx1UxTrSmyo4quD2ECOQPhmH7xqYZ+Mse8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795021165;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=7T9ENv9fYoNqueNN1cl4L0LtuGcP2bPFYDoRLfK8lQQ=;
	b=wp7oVly4krEiYjMtfHFqkfPZIBHi2iCpwe2+RxO5SMWZczknnq1mqopPHNYGzB6aZ4nW
	 KgpdyetVBTWKESHJICbR1zF/nnlPxGCvbkIG4s37Vp4QcQjSWiOY0vCB++oPDyDY3VXuj
	 T2pIDhFZIwoprmqB4GAPYzy7yBDiJxfMnd3QbPDtWPrl6XBOxzvW/xShA7bMq2YdcmGeJ
	 GvAwp4Y1VEl4TRT4NMbrRCQDKNU2w90YmhRDhECCW3cHE+wAxt7nOADw2hf/z7zZ65HS1
	 BVc9Zx9N7tCJLtppdLGvwJSluVeb6m0Fc3rgc2/7MMYqp7bth6ioyT63p3RxuneM6og==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="U7ge/EMe";
	arc=none smtp.remote-ip=192.198.163.16
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9C9606A31C;
	Wed, 18 Nov 2026 16:59:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E9C9606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=U7ge/EMe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795021164; x=1826557164;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=cghH6f8GIelkFBs05EiJ1FaW5yY1//I8u9iMgXAXf0Q=;
  b=U7ge/EMehyqXYTSb0rvV9kk7d/LjKLfrN+Rq5i9N2uJHgNVRpWZGWCPY
   kIaRFfah1631lKdGY7osUfUc1JfMq3jTnK7ShzkXODEr+j8Z4E3d51NHw
   6CwD1OmmqI17Llf4AA8unDDCUds0qhBuSlNIVJWb3T0lkqtMAsJFQjJm2
   DmlrCRQReusldDhIujdwc8T+KM5na7PlgQukR55/hebvxs6UB8mSDWpmH
   j46rDnzwxm+Nb1JDxPvr9LqqinCYOi2U6C547CVmXx3gDY6CWuf6xCgbW
   qdxRnU6wghG/O+bdtbTr8d2wyTWo6mJvYxHl4GAY5rWHrhllFU0H4Afbj
   w==;
X-CSE-ConnectionGUID: Pok4RVhtShalVFmAO6YJyQ==
X-CSE-MsgGUID: WDdoaoJCS2GvArkKmFgaUQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11970"; a="3868101"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3868101"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 08:54:00 -0800
X-CSE-ConnectionGUID: uWueeSFkRAGx+hPQf4nS/g==
X-CSE-MsgGUID: 6s/qUNgtQQq1UMg+UdEedg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="10197369"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orviesa006.jf.intel.com with ESMTP; 18 Nov 2026 08:53:56 -0800
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: kuba@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	pabeni@redhat.com,
	edumazet@kernel.org,
	horms@kernel.org,
	davem@davemloft.net,
	shuah@kernel.org,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	willemb@google.com,
	petrm@nvidia.com,
	bjorn@kernel.org,
	magnus.karlsson@intel.com,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next] selftests: net: don't warn when bpftool is missing
Date: Wed, 18 Nov 2026 17:53:38 +0100
Message-Id: <20261118165338.1064930-1-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

xskxceiver and xdp_hw_metadata need bpftool to generate their BPF
skeletons, so they are skipped when it is missing or does not work.
The kernel test robot builds selftests without bpftool and reports the
warnings about it as new build regressions in both net-next and
bpf-next. Skipping the two tools is expected there, so drop the
warnings.

Fixes: e8f9d8237988 ("selftests: xsk: move the AF_XDP test suite to selftests/net")
Fixes: d01fb5c81130 ("selftests: net: move xdp_hw_metadata from selftests/bpf")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/r/202611140904.io658Rze-lkp@intel.com/
Closes: https://lore.kernel.org/r/202611141124.V0t6dlFo-lkp@intel.com/
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
Based on the bpf-net-xsk-move tag so it can go to net-next and bpf-next
through another shared branch, as Alexei asked:
https://lore.kernel.org/netdev/CAADnVQK=Y1CY=m0gGegLB-jm9S1cUcEcKUuNx33PT2W-tdMCuw@mail.gmail.com/

 tools/testing/selftests/net/Makefile     | 2 --
 tools/testing/selftests/net/lib/Makefile | 2 --
 2 files changed, 4 deletions(-)

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index 83882735229d..a7f8b2c0b763 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -231,8 +231,6 @@ BPFTOOL ?= bpftool
 HAS_BPFTOOL := $(shell $(BPFTOOL) version >/dev/null 2>&1 && echo y)
 ifeq ($(HAS_BPFTOOL),y)
 COND_GEN_FILES += xdp_hw_metadata
-else
-$(warning excluding xdp_hw_metadata, bpftool not installed or not working)
 endif
 
 TEST_GEN_FILES += $(COND_GEN_FILES)
diff --git a/tools/testing/selftests/net/lib/Makefile b/tools/testing/selftests/net/lib/Makefile
index 0a6cd733883d..5765625ae7f7 100644
--- a/tools/testing/selftests/net/lib/Makefile
+++ b/tools/testing/selftests/net/lib/Makefile
@@ -10,8 +10,6 @@ BPFTOOL ?= bpftool
 HAS_BPFTOOL := $(shell $(BPFTOOL) version >/dev/null 2>&1 && echo y)
 ifeq ($(HAS_BPFTOOL),y)
 COND_GEN_FILES += xskxceiver
-else
-$(warning excluding xskxceiver, bpftool not installed or not working)
 endif
 
 TEST_FILES := \

base-commit: d01fb5c8113055e3d1b7f573261ae6a30abf4e53
-- 
2.43.0

