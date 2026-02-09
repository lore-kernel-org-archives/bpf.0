Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE463326940
	for <bpf@vger.kernel.org>; Mon,  9 Feb 2026 08:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770627378; cv=none; b=r2m2YwLg4OE3GrBfM0aAdy7DkOJj0RNJeumnWLIwwR/u0P0UtoRoLGlm7aSHEXR0sL2lq8u7FA1SrqU4GGyagWFJ8vpskQ8dxGJxkwxzO9n0DwSdkuExt/NAFK1wl7yGnEmMpt5KT1+Wp/+dMCcuC4uGoDUUv7dCq+jZCtpiC+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770627378; c=relaxed/simple;
	bh=1LuO5Knnshh13dhq3TT+NZXbpE0lGhq8TgeEl2cU6KQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VR7PqLr5bERKv2yqpJ6NcC0vNkaYOnJouDJMKus2BcgsQ2NZftZxKzOQ16CNWJGj+60IoWE7AifC3KKJuN/QiWfEhRBiHSVI6x/A5ALmjmv55uqumI4jFbije/Kj81252xaJuRw3MIYy4hoSRjp3ZhJfi3iS0ptcvrxFUAxnJaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; dkim=pass (2048-bit key) header.d=unisoc.com header.i=@unisoc.com header.b=NkWSBAf5; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=unisoc.com header.i=@unisoc.com header.b="NkWSBAf5"
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 6198thRs056902;
	Mon, 9 Feb 2026 16:55:43 +0800 (+08)
	(envelope-from Xuewen.Yan@unisoc.com)
Received: from SHDLP.spreadtrum.com (BJMBX01.spreadtrum.com [10.0.64.7])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4f8dnX0zVkz2Q1PRN;
	Mon,  9 Feb 2026 16:55:28 +0800 (CST)
Received: from BJ10918NBW01.spreadtrum.com (10.0.73.73) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.48; Mon, 9 Feb 2026 16:55:40 +0800
From: Xuewen Yan <xuewen.yan@unisoc.com>
To: <tj@kernel.org>, <void@manifault.com>, <arighi@nvidia.com>,
        <changwoo@igalia.com>, <guohua.yan@unisoc.com>
CC: <ke.wang@unisoc.com>, <di.shen@unisoc.com>, <sched-ext@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
        <xuewen.yan94@gmail.com>
Subject: [RFC PATCH] tools/sched_ext: Use u64 for kind field to fix ARM64 atomic ops
Date: Mon, 9 Feb 2026 16:55:36 +0800
Message-ID: <20260209085536.16723-1-xuewen.yan@unisoc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHCAS01.spreadtrum.com (10.0.1.201) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL:SHSQR01.spreadtrum.com 6198thRs056902
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unisoc.com;
	s=default; t=1770627362;
	bh=BoE2POw/coWzPtTia/y8gs/W+p7UZmXEbNp7M1wnSmU=;
	h=From:To:CC:Subject:Date;
	b=NkWSBAf5uZkyMT1SuN73xia5sgxMjN5l5ITaCA5zY2CUK2Bncu0qf5tKWMSEXBaxJ
	 8aZ02lrGgxjOUZAWSMEKWuOC5RWPQ5pBUrsq4XnPizGss5Z/xQ/vtNA4He5e9+nSvX
	 19VaD1/iyNwOzcV2f78ECEHqgJZ6WC8RWUckHB/DcgjCm33J0rPcq24atLLGw+1Sf7
	 ud5/hODCXtFP1U/NhUvbPD/umBT+doxDgGv/kzLVLsh6UyTZJ5m9oKz+JZLZBbvGxu
	 V+NIHOU03olCBhna+XY3PWdDLbgQnIgDPXNJ+U7jyJmBeORTksFSQ8kM8DZ8J8/Cgw
	 G/D4P7jrrl/AA==

From: Guohua Yan <guohua.yan@unisoc.com>

There are following compile errors in arm64:

bpftools/CORE/scx_simple.bpf.c:144:2: error: unsupported atomic operation, please use 64 bit version
  144 |         UEI_RECORD(uei, ei);
      |         ^

Convert kind from int to u64 to resolve ARM64 atomic operation
limitations. ARM64 primarily supports 64-bit atomic operations.

Signed-off-by: Guohua Yan <guohua.yan@unisoc.com>
Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
---
 tools/sched_ext/include/scx/user_exit_info_common.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/sched_ext/include/scx/user_exit_info_common.h b/tools/sched_ext/include/scx/user_exit_info_common.h
index 2d0981aedd89..5bad20faade1 100644
--- a/tools/sched_ext/include/scx/user_exit_info_common.h
+++ b/tools/sched_ext/include/scx/user_exit_info_common.h
@@ -21,7 +21,7 @@ enum uei_sizes {
 };
 
 struct user_exit_info {
-	int		kind;
+	u64		kind;
 	s64		exit_code;
 	char		reason[UEI_REASON_LEN];
 	char		msg[UEI_MSG_LEN];
-- 
2.25.1

