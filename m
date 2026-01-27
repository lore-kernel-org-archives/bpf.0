Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A5970814
	for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 02:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769481974; cv=none; b=LuK3G0x5K3ocrDDfSDXNnXIb45fq0eqim9sZ0DRcJTmyCbT1WETTkafqZJtnoiByUdg7BqFBtQe+N+g64BdpDtltGy7UQIKYj2eZHkVNL9S4iUJRjrE0J4sMqf+Wnohx2hyeFO2OB6KAuRjK//IgpmZTrf6mj4+d361Z5LVIhOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769481974; c=relaxed/simple;
	bh=dRAVhasx5bHqnuDTTUGwAcs5w2XiY9nfxldpWXTghTM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t6pBaw0F0Sqkuv2YNPAsNyWMn85FRj5hqAU5KezX0wtHXNjEsRBT7EuNEQ2zh+gQmefMxreCzz3XoD/1visWhP7z9R3NEe4OWV9Ot2pBgsRrf/+8Ih2k+DFmJqXybDCZ4uPw7w/0tH4rxjQPoBxBIRcZZJ4ajydv9BCRhX/vz/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hR971E1r; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hR971E1r"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769481971;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LzjEJY6qcpwuajGjEtJvsvxgNViqBcYPvAfyJeQzmvs=;
	b=hR971E1rulwlHhX2kklqL5Fikprd3Duwb+F6s9Kj8XQ6Yj2Jaw4eHH4LTtQIHK2dLCXquH
	6F89dMkq479LNitHcu6b+3uJoxU4OmJTxEvUTw0XkKf/f6BSxmN4KOeTWWXOECIEZi/p1W
	zMXiuCpKolrY2OtAdFJaFQRE9yMbS7c=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: bpf@vger.kernel.org
Cc: Michal Hocko <mhocko@suse.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	JP Kobryn <inwardvessel@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Suren Baghdasaryan <surenb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Song Liu <song@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>
Subject: [PATCH bpf-next v3 16/17] bpf: selftests: add config for psi
Date: Mon, 26 Jan 2026 18:46:03 -0800
Message-ID: <20260127024604.495018-1-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: JP Kobryn <inwardvessel@gmail.com>

Include CONFIG_PSI to allow dependent tests to build.

Suggested-by: Song Liu <song@kernel.org>
Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
---
 tools/testing/selftests/bpf/config | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
index 558839e3c185..e7dcb1aed4df 100644
--- a/tools/testing/selftests/bpf/config
+++ b/tools/testing/selftests/bpf/config
@@ -111,6 +111,7 @@ CONFIG_IP6_NF_IPTABLES=y
 CONFIG_IP6_NF_FILTER=y
 CONFIG_NF_NAT=y
 CONFIG_PACKET=y
+CONFIG_PSI=y
 CONFIG_RC_CORE=y
 CONFIG_SAMPLES=y
 CONFIG_SAMPLE_LIVEPATCH=m
-- 
2.52.0

