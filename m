Received: from outbound.qs.icloud.com (qs-2003h-snip4-2.eps.apple.com [57.103.86.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD8D34388C
	for <bpf@vger.kernel.org>; Sat, 20 Jun 2026 12:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.86.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781957651; cv=none; b=uzH/UloauktDPsxMNvZZELIpPxuYdGOuYptqcFHkDZDdw5JtQv8X9sA3ga6VWdlna+ly3lw+OhLlSGhbG17TpE0yudG2dahc5hg/qcSVn/sbhHK32H7EKlh3G4Mr4nC1icS7WwdLV+bGduEayYSmwrQjJJwfZ8WtJAy4U36ZdJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781957651; c=relaxed/simple;
	bh=F4nQG/vAy1yKxXgYOlZoathCWfcC0tiqHT340k4o7F0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kgHdKbEj6xxyjbij3Al2WcTy0pK2xWAaqONo09YThQImhQgCoYlQ920tMud9/Tj1dEbJ2dj7sOwoZoE6r0pKLyhMJFLlglT4uNqQGM/wp2hyEnqzzUapDEpxc/ZO2k9z4g//YDRFjoB4MxLqxUuZ03zJ71fSuoNGdGR36hIbvoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=fQxxM3fR; arc=none smtp.client-ip=57.103.86.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="fQxxM3fR"
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-east-2d-10-percent-2 (Postfix) with ESMTPS id 6BA2E3000191;
	Sat, 20 Jun 2026 12:14:05 +0000 (UTC)
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQpOHV8CXhxBAFYLWxcOVk1KEVcJXwpABFEbWg9eK1sTVRdGCRkIXR0ZHldQXgheH0wcHQ5YBhICWkUKTV8OXh8EF0YZVQRHHl1WQh4ZAlEcVg1XQ1QEX1BJDEFQbFoARxdIHV0ZWW9QXRwOBFQHXQVdVlACWktfGV1FD18HWQRAD0oDXAVaAUIIVgdYBVkFXQpVQARTD1oRSwxbDl4JWzBQG18CQg8cE1YVDU1DEkIVBBFQAVgeVg==
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1781957648; x=1784549648; bh=B2Pp0WGbRgzLs4Smn37csLZQa4PVookrDR16OraLNYs=; h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme; b=fQxxM3fRRpdpKDkg9fQNT9MDJfVBRU2DBrRMA+lCbcumsv074awNbA3ORf1CwGDKUIHeIhUf6dkPt/WfPFVZ4fyhzbcQjcsljeic3Kf7VpnmYnx+k4DABggEjq128P0Qp5bguGsDNeXiaAIpLyaDMxPfS8R/oca4lEzMfSEg6FX4dLVQ08H7yEYFmAq6NA7kPuMyIcFAb4HHNUIqjJSGigQU4z9Rvpk4J1K7ALJ3m64x7rbxAvb4+qaO3uAr0Zp548d0kvvx4V5HEtPRn24saFm+8DZXDi9tMPEiwU1kgqrX66ounnexyazhmkLA5sOyT3uthVk1U22Y8w2onv1osw==
Received: from cibi (unknown [17.57.155.37])
	by p00-icloudmta-asmtp-us-east-2d-10-percent-2 (Postfix) with ESMTPSA id 11B5B3000184;
	Sat, 20 Jun 2026 12:14:00 +0000 (UTC)
From: Siddharth C <siddharthcibi@icloud.com>
To: ast@kernel.org,
	kuba@kernel.org,
	hawk@kernel.org,
	andrii@kernel.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: Siddharth_Cibi <siddharthcibi@icloud.com>
Subject: [PATCH 2/2] selftests/bpf: validate rx_queue_index in xdp_metadata
Date: Sat, 20 Jun 2026 12:13:14 +0000
Message-ID: <20260620121321.45227-3-siddharthcibi@icloud.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260620121321.45227-1-siddharthcibi@icloud.com>
References: <20260620121321.45227-1-siddharthcibi@icloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: tFHWwJf4YN-D4whddqvv-hexfB_5gAlG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIwMDEyMSBTYWx0ZWRfX7plsFHKGUv1A
 WP5I9tWiRubvLDY0kEmOz1rGIrP9ys+APeD2YtGhXUH2+Y3lb69pEQNhftKS5YrTvVCh6Ymnddi
 n36ecaavCKERwR7qzxGfPs9cTmN0W9FmAFlrOMiHUPe1QBXWNBxuBnSywGTpzIK15VJiybYllzA
 LJL85veIVY677MBj3lHXFMuqUwU55lqVaxZmt8kbfWS6UYMwa2G0NCW9dzxZm8/+iADIyZtkPv6
 dxkje0LOiqBGtq3MLQBel6Nrmk7ElEgX/RCIQwMLP1Ww1/Inus8Tt/fdwG7Y7E6upWWQQ7hYLcu
 8G1lfI0OiB2yY2ikGQS
X-Proofpoint-GUID: tFHWwJf4YN-D4whddqvv-hexfB_5gAlG
X-Apple-Category-Label: MjA0NzgyOTUxNDY6JGNhdGVnb3J5JF9QZXJzb25hbCw=

From: Siddharth_Cibi <siddharthcibi@icloud.com>

Extend xdp_metadata selftest coverage to validate that
ctx->rx_queue_index is preserved and observable after XDP redirect
execution.

Capture rx_queue_index in metadata and assert that it matches the
expected queue during packet verification.

Signed-off-by: Siddharth_Cibi <siddharthcibi@icloud.com>
---
 tools/testing/selftests/bpf/prog_tests/xdp_metadata.c | 3 ++-
 tools/testing/selftests/bpf/progs/xdp_metadata.c      | 2 +-
 tools/testing/selftests/bpf/xdp_metadata.h            | 1 +
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c b/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
index 5c31054ad4a4..f8cabbbe7bb7 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
@@ -309,7 +309,8 @@ static int verify_xsk_metadata(struct xsk *xsk, bool sent_from_af_xdp)
 
 	if (!ASSERT_NEQ(meta->rx_hash, 0, "rx_hash"))
 		return -1;
-
+	if (!ASSERT_EQ(meta->rx_queue_index, QUEUE_ID, "rx_queue_index"))
+        	return -1;
 	if (!sent_from_af_xdp) {
 		if (!ASSERT_NEQ(meta->rx_hash_type & XDP_RSS_TYPE_L4, 0, "rx_hash_type"))
 			return -1;
diff --git a/tools/testing/selftests/bpf/progs/xdp_metadata.c b/tools/testing/selftests/bpf/progs/xdp_metadata.c
index 09bb8a038d52..62ae83860d7f 100644
--- a/tools/testing/selftests/bpf/progs/xdp_metadata.c
+++ b/tools/testing/selftests/bpf/progs/xdp_metadata.c
@@ -98,7 +98,7 @@ int rx(struct xdp_md *ctx)
 	bpf_xdp_metadata_rx_hash(ctx, &meta->rx_hash, &meta->rx_hash_type);
 	bpf_xdp_metadata_rx_vlan_tag(ctx, &meta->rx_vlan_proto,
 				     &meta->rx_vlan_tci);
-
+	meta->rx_queue_index = ctx->rx_queue_index;
 	return bpf_redirect_map(&xsk, ctx->rx_queue_index, XDP_PASS);
 }
 
diff --git a/tools/testing/selftests/bpf/xdp_metadata.h b/tools/testing/selftests/bpf/xdp_metadata.h
index 87318ad1117a..1f0ae4c00091 100644
--- a/tools/testing/selftests/bpf/xdp_metadata.h
+++ b/tools/testing/selftests/bpf/xdp_metadata.h
@@ -49,4 +49,5 @@ struct xdp_meta {
 		__s32 rx_vlan_tag_err;
 	};
 	enum xdp_meta_field hint_valid;
+	__u32 rx_queue_index;
 };
-- 
2.53.0

