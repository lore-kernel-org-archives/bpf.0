Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E453537E4;
	Thu,  2 Apr 2026 15:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775145049; cv=none; b=Zwomc+SzMJOVveEKkoKyKd6ZMNR7OzK8YqUGa55/KjyZ0k78ObEaIcv9h/+nlo3CRtBD/7Of84FTdS+AKT9Wb0OZ+jhaesFoiOzHevmHmI1X4oXK3npLGjXxPEStkVIyN4q+7W4q05xevLn5Uio4HTFiH5rR+OkKHNm8CVn1SuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775145049; c=relaxed/simple;
	bh=FaWQTqp6l2AkN18SDD7RryzwFhKgM6MciHDFXpG1hd8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VWVKRI0RBqA/lfHqCUsyHrtc/n4X5tn2A+vZ0rVE0rrrXOx1QOnzlaYLWvxCPtAp0cP9d1LPloshNJmjzm1RoYq6omEupjZDeiXMkYWDSmBFLwr1VVrkOMscRyfC8jM5usTkqNGWuouO6qyo8TkpDckSIqcBNeGp+Q33lZ21cTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h43TaKXQ; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h43TaKXQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775145049; x=1806681049;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FaWQTqp6l2AkN18SDD7RryzwFhKgM6MciHDFXpG1hd8=;
  b=h43TaKXQAedeOCMuOVIK9tWOQ8CEddM+Soc2j008whlsPMAB9DvZAR+W
   2NcNV1ObDcS96Pik+kbhzo1QJfGvXOXpExX0giOn96mNhuLNFFw7cDtT3
   5N8giDi07UVtdCGWupqV0gnPU04d3Dr7yM8gBgryoWpNmailn9OPBnz2y
   MATDs+F7DqbCYU22oRU1t8duQQcgeNDrwyDjcloWSNqjjFkRzoIhU5Gi5
   0AVltGle3KQYznIsP0XzXVSJ0MLX/hj8JqSGR7xWoSWFFMq8Y14ErG/tc
   rSndYquiEjhiqgKGbsMiVhqnYeYABGHrkZCnSLhHgXSg7G+qJWsF3kQav
   w==;
X-CSE-ConnectionGUID: irCtI054RXWQ98AMvDACOA==
X-CSE-MsgGUID: J197k3rMSL+gJLQgGnt9OQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11747"; a="75927999"
X-IronPort-AV: E=Sophos;i="6.23,156,1770624000"; 
   d="scan'208";a="75927999"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2026 08:50:49 -0700
X-CSE-ConnectionGUID: EeLdGdKqRMSGHYfxzxcTJA==
X-CSE-MsgGUID: 18ArL703SgKCXhcasNU1NA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,156,1770624000"; 
   d="scan'208";a="224157715"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by fmviesa008.fm.intel.com with ESMTP; 02 Apr 2026 08:50:46 -0700
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
Subject: [PATCH v6 net 7/8] selftests: bpf: have a separate variable for drop test
Date: Thu,  2 Apr 2026 17:49:57 +0200
Message-Id: <20260402154958.562179-8-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20260402154958.562179-1-maciej.fijalkowski@intel.com>
References: <20260402154958.562179-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Currently two different XDP programs share a static variable for
different purposes (picking where to redirect on shared umem test &
whether to drop a packet). This can be a problem when running full test
suite - idx can be written by shared umem test and this value can cause
a false behavior within XDP drop half test.

Introduce a dedicated variable for drop half test so that these two
don't step on each other toes. There is no real need for using
__sync_fetch_and_add here as XSK tests are executed on single CPU.

Reviewed-by: Björn Töpel <bjorn@kernel.org>
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 tools/testing/selftests/bpf/progs/xsk_xdp_progs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/xsk_xdp_progs.c b/tools/testing/selftests/bpf/progs/xsk_xdp_progs.c
index 683306db8594..023d8befd4ca 100644
--- a/tools/testing/selftests/bpf/progs/xsk_xdp_progs.c
+++ b/tools/testing/selftests/bpf/progs/xsk_xdp_progs.c
@@ -26,8 +26,10 @@ SEC("xdp.frags") int xsk_def_prog(struct xdp_md *xdp)
 
 SEC("xdp.frags") int xsk_xdp_drop(struct xdp_md *xdp)
 {
+	static unsigned int drop_idx;
+
 	/* Drop every other packet */
-	if (idx++ % 2)
+	if (drop_idx++ % 2)
 		return XDP_DROP;
 
 	return bpf_redirect_map(&xsk, 0, XDP_DROP);
-- 
2.43.0

