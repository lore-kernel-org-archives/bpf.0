Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAFA73D79E3
	for <bpf@vger.kernel.org>; Mon,  1 Jun 2026 15:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780326174; cv=none; b=IPkkk+2dyE4OEe+RDB09lc/hytZzLsiRvJ/4PEw6MHlJNL0eQO90XMJenY0YDfBg5uas76WDQcSgumOAk/ciuqRtrH7lY64MUy8ajdl5r0BIXoYDAPrgAoIqhnFgkBVuHIQ6s4HWXbKDDD0eFugcgYi50/Vf3ZZqSe+BqPD+TRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780326174; c=relaxed/simple;
	bh=0v2tdRKRgLo653EY+RkkzjtBUYnXDkVtFMzRRHTPI/g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GniS7Jh9pPMSMMcgsSIu8zwom9UN9ftDAcGxuKjIjdUTrWv96Yuv3j3j7blj5113JjrERUJDyImoSEsugTun7M4WVg9o8C4UULjko01Uwb4WIM6neyTuHl3Sf9MfkENLREauQ3wCfTg5MJcUF1HpnJiFnJYR3/nrGS53HsfkSVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=FKtP/vbv; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="FKtP/vbv"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=d3QrtolEc1CGzVvjDkKLj/tuWTGk3XI8fea+Nba/CmY=; b=FKtP/vbvCx7f+3T3A+LK8FeQZ2
	SQHIee4hC9J/8zxARjkXJC6l301zoEkzAvH1JBzv5s8A6Qx39zrSFuhb5N8aW42box0oGHeynTFMh
	ithg5LysHcv0+ZkTM5k4uRdSCrJeiuCP3tD/0ThWnSGHyKU7Ar3/VG5fZgnDBBf5zySd5B+sPW4Dc
	ybtXeBWDpj3PWxx2FH+BYO+ISkCeZ/QigMI1vXQWCC7uyS3BR3Gx8H0sOdPRadctTkbPIx9qanSy6
	KMQiUTqFFFa7tg/AnIl0Kbpm4ld73jACK1AsKIeN/f0aoaUKJEgZc34aG/pcx4VtvjFxuelyXV0ys
	z92v2spQ==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wU4AG-000GWl-0q;
	Mon, 01 Jun 2026 17:02:52 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: alexei.starovoitov@gmail.com
Cc: bpf@vger.kernel.org,
	kpsingh@kernel.org
Subject: [PATCH bpf-next v2 5/7] libbpf: Skip max_entries override on signed loaders
Date: Mon,  1 Jun 2026 17:02:46 +0200
Message-ID: <20260601150248.394863-6-daniel@iogearbox.net>
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

bpf_gen__map_create() lets the host-supplied loader ctx override a
map's max_entries at runtime (map_desc[idx].max_entries, when non-zero).
This is how the light skeleton sizes maps to the target machine, but
it happens after emit_signature_match() and is covered by neither the
signed loader instructions nor the hashed blob.

For a signed loader this means an untrusted host can re-dimension the
program's maps, outside what the signature attests to. Gate the override
on gen_hash so signed loaders use the signer-provided max_entries baked
into the blob.

Fixes: ea923080c145 ("libbpf: Embed and verify the metadata hash in the loader")
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 tools/lib/bpf/gen_loader.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/gen_loader.c b/tools/lib/bpf/gen_loader.c
index a5d9c7a5261b..66e13566bc31 100644
--- a/tools/lib/bpf/gen_loader.c
+++ b/tools/lib/bpf/gen_loader.c
@@ -546,13 +546,22 @@ void bpf_gen__map_create(struct bpf_gen *gen,
 	default:
 		break;
 	}
-	/* conditionally update max_entries */
-	if (map_idx >= 0)
+
+	/*
+	 * Conditionally update max_entries from the host-supplied loader
+	 * ctx. This sizes the map at runtime, but for a signed loader
+	 * (gen_hash) it would let an untrusted host re-dimension the
+	 * program's maps after emit_signature_match(), outside what the
+	 * signature attests to. Keep the signer-provided max_entries
+	 * baked into the blob in that case.
+	 */
+	if (map_idx >= 0 && !OPTS_GET(gen->opts, gen_hash, false))
 		move_ctx2blob(gen, attr_field(map_create_attr, max_entries), 4,
 			      sizeof(struct bpf_loader_ctx) +
 			      sizeof(struct bpf_map_desc) * map_idx +
 			      offsetof(struct bpf_map_desc, max_entries),
 			      true /* check that max_entries != 0 */);
+
 	/* emit MAP_CREATE command */
 	emit_sys_bpf(gen, BPF_MAP_CREATE, map_create_attr, attr_size);
 	debug_ret(gen, "map_create %s idx %d type %d value_size %d value_btf_id %d",
-- 
2.43.0

