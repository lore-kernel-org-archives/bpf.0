Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CEF3D7A07
	for <bpf@vger.kernel.org>; Mon,  1 Jun 2026 15:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780326174; cv=none; b=JVfNNC5YdqJPDnKHrUE/t5f+UeZkxS6odKPYI5/dxNgaKos9btVH+XjqniSyhXQv1+kCNoL/5D7M9KlDwHSCEWiYwx/64Hov/ISE99ghctQ26asqq5WPrQ1Y0OMUPsp/qan4tBlInL/gdNvXCRQcXVXlS3OctCuaSycFjZ4HG/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780326174; c=relaxed/simple;
	bh=5VHEEODrO/8nP2k4XuusQrglSLeWtqfa9L/J9B/ngk8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sDF1TPcGyok7EQIZum/AHWqo7kDECBbQwliizOxVO3xqLBR1ZIeEBZNee1SI4GcOp0kug98QKY7xSbXmYSddyVPEtaHX6M0oH/AeCecpCbu37JkYuMG7UsteZ7B4r+arTx9ouaAuSR6GrJKeT+WJdnbV4TVlVv4T+zfNp8g7+qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=rH8Wa4BG; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="rH8Wa4BG"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=03XMtBXPEhp9mny68PzjnjmoPVWrYgEjaxdaNF5aH/U=; b=rH8Wa4BGxqE0kko5W15aM23ozn
	kKtbOJEvfpGPjYQwCJKJt0NnxO9MUm9vTclaunNCDsSMr4vU8fOR0HBd142fkQ5Ui4K3vbybaV5ET
	c6MZwZUBoBgLvqA39DherzeOhp6CNd4Pu36jRg8+60xrvRmlXHz0+IHQzEyy++2h/zjDmAxDbMfjk
	bCAf6U8gIRK7YZb4ku6sQS1II0p00Xu4/TonnQ08QRwdvDdrGn7FI4VsWYP+mpaFNASpeECeW/El1
	2GWqGftpU/ySR4rvnJQ8X9NhF8NAWCjZ0bZPoXIpO53rA5tVRljYgroi/M8BAV1t0wpnNhNBREyMX
	YvLJVVXg==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wU4AD-000GWB-2Z;
	Mon, 01 Jun 2026 17:02:49 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: alexei.starovoitov@gmail.com
Cc: bpf@vger.kernel.org,
	kpsingh@kernel.org,
	sashiko <sashiko@sashiko.dev>
Subject: [PATCH bpf-next v2 1/7] bpf: Reject exclusive maps as inner maps in map-in-map
Date: Mon,  1 Jun 2026 17:02:42 +0200
Message-ID: <20260601150248.394863-2-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260601150248.394863-1-daniel@iogearbox.net>
References: <20260601150248.394863-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28018/Mon Jun  1 08:31:13 2026)

An exclusive map (created with excl_prog_hash) is bound to a single
program by hash: check_map_prog_compatibility() refuses to load any
program whose digest does not match map->excl_prog_sha. That check
only runs for maps a program references directly, i.e. its used_maps.
A map reached at runtime through a map-of-maps is never in used_maps,
and bpf_map_meta_equal() does not consider excl_prog_sha, so an
exclusive map can be inserted into a non-exclusive outer map and
then looked up and mutated by an unrelated program, bypassing the
exclusivity guarantee.

For the signed loader this defeats the metadata map exclusivity check
added in the signed loader: the cached map->sha[] is validated against
the signed hash while another program on a hostile host rewrites the
frozen map's contents through the outer map.

Fixes: baefdbdf6812 ("bpf: Implement exclusive map creation")
Reported-by: sashiko <sashiko@sashiko.dev>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 kernel/bpf/map_in_map.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/map_in_map.c b/kernel/bpf/map_in_map.c
index 645bd30bc9a9..d2cbab4bdf64 100644
--- a/kernel/bpf/map_in_map.c
+++ b/kernel/bpf/map_in_map.c
@@ -20,7 +20,8 @@ struct bpf_map *bpf_map_meta_alloc(int inner_map_ufd)
 	/* Does not support >1 level map-in-map */
 	if (inner_map->inner_map_meta)
 		return ERR_PTR(-EINVAL);
-
+	if (inner_map->excl_prog_sha)
+		return ERR_PTR(-ENOTSUPP);
 	if (!inner_map->ops->map_meta_equal)
 		return ERR_PTR(-ENOTSUPP);
 
@@ -101,6 +102,8 @@ void *bpf_map_fd_get_ptr(struct bpf_map *map,
 	inner_map = __bpf_map_get(f);
 	if (IS_ERR(inner_map))
 		return inner_map;
+	if (inner_map->excl_prog_sha)
+		return ERR_PTR(-ENOTSUPP);
 
 	inner_map_meta = map->inner_map_meta;
 	if (inner_map_meta->ops->map_meta_equal(inner_map_meta, inner_map))
-- 
2.43.0

