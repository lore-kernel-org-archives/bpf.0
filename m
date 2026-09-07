Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8F1494823;
	Mon,  7 Sep 2026 12:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788783037; cv=none; b=WnmdneLfwaVyFZ7oQUIAl6QgVija8akFNANCn5EoAHRLe9iQvxR8egyCNUztcDoTsp8f0OUtfeXj5+zQ5QC+NHOJB2owlR+Q9JfUcI78Q4g2OC017Yr8eB6/T2MLnUgpa1xDfcapTREfePwRTWMBVT0BUH/fpESGgx1g4S8eUPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788783037; c=relaxed/simple;
	bh=pBFTDUlgVQK476EvcxWLk9HFtl+TxdrOxm61fklUco4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R94ZoZT0jurJ1Ke70bKyO/PPqE5exrteTPjQ2MHAcA+0PbT7KtXC6i56kNE4EGmaZ6xo1IVQCDvgi7z0lSKk9ewvzhIYnruydstS1/Rur5imc+Ytp+gEMT9p0iuUVpRGQzTJVhoBwZ9LRDpNWWVjB/3zLwsxscUnhjA8zj9h2AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=IYqdOMsA; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="IYqdOMsA"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=I6g5bmQMO0nIQS4wp5i9NSNRztEbYChHlJxfnE70RS4=; b=IYqdOMsAh742rulpCbHcdD3Hc5
	rjAYFtMlCPBZlA5Y972J6B9dcEpxT8bDpwzDAcz4OqT9Hy9ByQbu4LOlcEVi0eGWvPV6q0BytQhb+
	qdS4yLWiogi0zVWnIoiov/+ivgZXPeND7FDJC179YsZiMfAmHrkLr7G5yv4zAfg9zZqrxPsNkM9Xh
	ccbT4/eIprnn6lje9ichIMDT/MvRyN88OmKiVKJnvvBMzyzEnjiLIc6Syb47V3FlEBgL5hl0vIrQH
	zmGGSbxCUDDVAxdosJuFFM/yUKwKQnLkydJqlh2YVkrHuEJ+vraVmZAg2pZojc2WjWz8qtAVq4SGj
	FRjMwC3A==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1x3YB7-000Moq-2m;
	Mon, 07 Sep 2026 14:10:26 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: ast@kernel.org
Cc: memxor@gmail.com,
	yusuke.suzuki@isovalent.com,
	tom.hadlaw@isovalent.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH bpf 1/2] bpf: Fix bpf_skb_change_tail wrt csum partial skbs
Date: Mon,  7 Sep 2026 14:10:24 +0200
Message-ID: <20260907121025.1923656-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28116/Mon Sep  7 08:24:32 2026)

Cilium generates ICMP "frag needed" replies from BPF when a LB DSR
packet exceeds the egress MTU. The reply is built by first trimming the
packet down to target size via bpf_skb_change_tail(), and then pushing
the ICMP error headers in front of it.

The trim is rejected for skbs which carry a checksum offload, e.g. TCP
packets aggregated by GRO on ingress where tcp_gro_complete() leaves
the skb as CHECKSUM_PARTIAL. __bpf_skb_min_len() raises the minimum
length to the end of the L4 checksum field, so a trim to 42 bytes bails
out with -EINVAL given a min_len of 52 in this case, and due to that
the ICMP generator fails. This is not the case if GRO is turned off.

Fix this bpf_skb_change_tail() restriction and drop the checksum offload
when the new length no longer covers the checksum field. The BPF program
rewrites the skb into an ICMP error and computes the checksum itself
anyway.

Fixes: 5293efe62df8 ("bpf: add bpf_skb_change_tail helper")
Reported-by: Tom Hadlaw <tom.hadlaw@isovalent.com>
Reported-by: Yusuke Suzuki <yusuke.suzuki@isovalent.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 net/core/filter.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 61940e753552..8513167a858a 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -3961,12 +3961,6 @@ static u32 __bpf_skb_min_len(const struct sk_buff *skb)
 		if (offset > 0)
 			min_len = offset;
 	}
-	if (skb->ip_summed == CHECKSUM_PARTIAL) {
-		offset = skb_checksum_start_offset(skb) +
-			 skb->csum_offset + sizeof(__sum16);
-		if (offset > 0)
-			min_len = offset;
-	}
 	return min_len;
 }
 
@@ -3983,6 +3977,11 @@ static int bpf_skb_grow_rcsum(struct sk_buff *skb, unsigned int new_len)
 
 static int bpf_skb_trim_rcsum(struct sk_buff *skb, unsigned int new_len)
 {
+	if (skb->ip_summed == CHECKSUM_PARTIAL &&
+	    new_len < skb_checksum_start_offset(skb) + skb->csum_offset +
+		      sizeof(__sum16))
+		skb->ip_summed = CHECKSUM_NONE;
+
 	return __skb_trim_rcsum(skb, new_len);
 }
 
-- 
2.43.0

