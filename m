Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905D83F23C1;
	Thu, 19 Mar 2026 17:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773942962; cv=none; b=pWnAL5FM4YQKzh9Ls2fBk0h9CeRLmGymvdAyruE6ytJaYQfpycvYzZuGNbLBCYqbB3PASYl8tlWv4bSiRHlFfWFeUfq0L7C5eEHlBRi2DYf5A94haUlX+GqdYOnKFSM9+ie/1Lji3j5Gb+QmF1wmwwk6Hc42miuoVh79caDlVx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773942962; c=relaxed/simple;
	bh=oUdqkprAKNLqdy+Z9DsSiRaGN2K4IDbzQNUWqrM2lm4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=E8FVzxRd72l4LS6fmcjc8qYTghT3w6eZrL1bcO/cguSJnEWOZBr/++lfzHP3ogC3abciQgZR+MIcftK1ahT3YVxzJi7nafWm4d28RwyqTsVjzBSqRwc5rEmFTJU4BExU6pjooVBHuJ38DjV2C9wBMVNBGFQ8VZM3bQW3MOVw+iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KKyn2fGB; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KKyn2fGB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773942962; x=1805478962;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oUdqkprAKNLqdy+Z9DsSiRaGN2K4IDbzQNUWqrM2lm4=;
  b=KKyn2fGB0QewVOLVyrXn1WPmgG4ZU7j24X9078NaW+Xg1ZswJJln6dUB
   mw/e0cEI23lUUu0AeKp7X3h8lSrlAejLgxgG0nQXNLPypYnKPro/HdUq4
   zPi/qAkm1XAHF0aQFtcBg2NyNwYRKLrcWiM5Vqfh2r/F9+dSFTC4DqcUN
   fI6JB/RdzDNbanZB822U2hEXHLh4T2hx59Aay1+MTfr73g3SOnbM+phRR
   ZB8Tnf+4wep5JqsKTcff6+0VnzvJh5kFiviTu6/gAxqK5OmLH/ChXPe80
   jXjATbzSkd4aOKKOEtGC2U6iL77zsHCSkgAuACskqtjlK/GPimwkfxlOp
   g==;
X-CSE-ConnectionGUID: /pMLbmIaRdufJGvhRraveA==
X-CSE-MsgGUID: tR52t4FLSWy117pXEWGhfg==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="74038629"
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; 
   d="scan'208";a="74038629"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 10:56:01 -0700
X-CSE-ConnectionGUID: UHFhjABISGSRMeJex1tacg==
X-CSE-MsgGUID: b8ogzmxGQB2xkQzmDarlHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; 
   d="scan'208";a="246058682"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by fmviesa002.fm.intel.com with ESMTP; 19 Mar 2026 10:55:59 -0700
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	magnus.karlsson@intel.com,
	stfomichev@gmail.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	larysa.zaremba@intel.com,
	aleksander.lobakin@intel.com,
	bjorn@kernel.org,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH v2 net 7/8] selftests: bpf: have a separate variable for drop test
Date: Thu, 19 Mar 2026 18:55:37 +0100
Message-Id: <20260319175538.479139-8-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20260319175538.479139-1-maciej.fijalkowski@intel.com>
References: <20260319175538.479139-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently two different XDP programs share a static variable for
different purposes (picking where to redirect on shared umem test &
whether to drop a packet). This can be a problem when running full test
suite - idx can be written by shared umem test and this value can cause
a false behavior within XDP drop half test.

Introduce a dedicated variable for drop half test so that these two
don't step on each other toes.

Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 tools/testing/selftests/bpf/progs/xsk_xdp_progs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/xsk_xdp_progs.c b/tools/testing/selftests/bpf/progs/xsk_xdp_progs.c
index 683306db8594..40609d8c2471 100644
--- a/tools/testing/selftests/bpf/progs/xsk_xdp_progs.c
+++ b/tools/testing/selftests/bpf/progs/xsk_xdp_progs.c
@@ -15,6 +15,7 @@ struct {
 	__uint(value_size, sizeof(int));
 } xsk SEC(".maps");
 
+static unsigned int drop_idx;
 static unsigned int idx;
 int adjust_value = 0;
 int count = 0;
@@ -27,7 +28,7 @@ SEC("xdp.frags") int xsk_def_prog(struct xdp_md *xdp)
 SEC("xdp.frags") int xsk_xdp_drop(struct xdp_md *xdp)
 {
 	/* Drop every other packet */
-	if (idx++ % 2)
+	if (drop_idx++ % 2)
 		return XDP_DROP;
 
 	return bpf_redirect_map(&xsk, 0, XDP_DROP);
-- 
2.43.0

