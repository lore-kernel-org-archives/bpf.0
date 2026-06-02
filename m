Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366A23E5A25
	for <bpf@vger.kernel.org>; Tue,  2 Jun 2026 13:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780407063; cv=none; b=XAt2ff4bv1XsfJTk62hmm8OkwJgZHHWnJWSiNlXutYJQ5H0w1rlOxdkU/CWwooVPUaJhxyL7E5tRlBMB1BIFkw3a7zlUpyiS8jaESrSsiXSw2BGbVCgSPHuBeNT45g+eCNLOJz0qi5k0y9JYHxp2h2DdaJCPwM00GfDbZnrLymk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780407063; c=relaxed/simple;
	bh=ZNE4fTYpYAs5ZlyTn6NxF6fNZweXSs18X7AezAD+Zqk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lBUmP+UfzXAk+iJr5gxHKYBILHI4wLss5OAlXer4F2WCZsYs28NF6L1LOcyb+GL18l2yvQ2Lsd21TbV5J/seYe4BX2OhCCuhO2XFMXdiHXfAIc7BaTe92vPHC6k0DcHf0YKHXkxDHU+qcJ8KCysH9jQ/hthFU8q/ZX7O/bNY9Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=WA9OtVTJ; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="WA9OtVTJ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=dUfaUWB8g1dwf7VOZH7JErNK4Bkcx+CQ/BmIXbTyGW8=; b=WA9OtVTJVw+Oi1Fjn0r8C/UYUa
	K9TV8zZL6ON3huLF56ftdkqu933iYM7576S5EZsFlK/Y3xrgrnX2EEEacM+7/2BrQz2Yg9DRh9vNC
	a2fVwf/SXIWnpjOPZx+CJOvFAvp7CG3hzTbTnanAWUo66/tBmG5tNUXwf4lknOE1MufLmV8+i7G9/
	lw3g8uI5hLldAWACtQqAqgZgBLzzTu9TYbPSsMjO9CN9ybEZrzJo5gZvvQ3i8EI0+ZAqnsbe6bLCb
	l6UmNdjJ1T7D5d/MRNvNCbhgdHwxWZvceLp7PpC5EojW8OPSmw4fa0y7mKiCzDWxxOGnzBVY+txqQ
	HsdymnRA==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wUPCn-0007Ic-24;
	Tue, 02 Jun 2026 15:30:53 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: alexei.starovoitov@gmail.com
Cc: bpf@vger.kernel.org,
	kpsingh@kernel.org
Subject: [PATCH bpf-next 1/4] bpf: Reject exclusive maps for bpf_map_elem iterators
Date: Tue,  2 Jun 2026 15:30:49 +0200
Message-ID: <20260602133052.423725-2-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260602133052.423725-1-daniel@iogearbox.net>
References: <20260602133052.423725-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28019/Tue Jun  2 08:33:27 2026)

Exclusive maps (aka excl_prog_hash) are meant to be reachable only
from the single program whose hash matches. This is enforced by
check_map_prog_compatibility() when the map is referenced from a
program such as signed BPF loaders.

A bpf_map_elem iterator, however, binds its target map at attach
time in bpf_iter_attach_map() instead of referencing it from the
program, so the exclusivity check is never reached. On top of that,
the iterator exposes the map value as a writable buffer.

Fixes: baefdbdf6812 ("bpf: Implement exclusive map creation")
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 kernel/bpf/map_iter.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/bpf/map_iter.c b/kernel/bpf/map_iter.c
index 261a03ea73d3..ae0741a09c6d 100644
--- a/kernel/bpf/map_iter.c
+++ b/kernel/bpf/map_iter.c
@@ -112,6 +112,10 @@ static int bpf_iter_attach_map(struct bpf_prog *prog,
 	map = bpf_map_get_with_uref(linfo->map.map_fd);
 	if (IS_ERR(map))
 		return PTR_ERR(map);
+	if (map->excl_prog_sha) {
+		err = -EPERM;
+		goto put_map;
+	}
 
 	if (map->map_type == BPF_MAP_TYPE_PERCPU_HASH ||
 	    map->map_type == BPF_MAP_TYPE_LRU_PERCPU_HASH ||
-- 
2.43.0

