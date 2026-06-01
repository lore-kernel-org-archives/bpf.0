Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482E1393DFB
	for <bpf@vger.kernel.org>; Mon,  1 Jun 2026 10:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780308205; cv=none; b=jzk9ycSiPnea9IplWNoARWRGN1t7YsbgS6zEpNfV9NPUnbmJTFfhNCrTGh64HNfvHb5kDN9R7npc5Eg11nE23Rp8o4Wk3TzEWRQgXAZoZVU13iZP2424H/45oowtDBnflf0NK9gyFj5fpIMg9kN/eZ2/onHqpn5uhPntG0kPlxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780308205; c=relaxed/simple;
	bh=c0X9a2ucRvumTsUXJAsp10sAePwhlpsKOMZNA7Au/KY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YyRdml3/nTKh83HvPdNLpSIHLq1iPN3Y2NoB8kufVCjGC2EXxbLdDcpGtuamm1NVUba3sttSvQ7XrzERBqiLlyCxPdBS6wc176bUHUKHBHn561fXtQ18R92GIdkKp02r8x+SiuHtPqdYf7si9UfsTUQ6GVjDMky4tqrZ7I1YPFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=LXWjqeMe; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="LXWjqeMe"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=utDibeioTa4wn3FMXQK35uRrzLZM+BH9fyi1Y5woS80=; b=LXWjqeMezcNilZ+DkuFuf4wSLu
	Re3VoDLj3H5Mx9Fdavx/n4n6bbStEon6dWPyyynKIhKZyCcfJc1z8nB5LKVlyx3/kRvf2LjBLJTHi
	0clLPgN+MGRpYI80w/IK1MbVRIOwXP0tfsDSCRGNrwQAH6/aSj2oHaKVd0TqsuYaFb+upHdyAfmQZ
	8p/6Xvh+nJo3qYhLz7C0hktLgbt3/oBW93kLDtzVBVITw6RlbBZWhiCmBswwHI4oYI3eZ7LTd1Az/
	cvhP1Mkkd7pbPOLc71HlpIweO3HYEWFbSGTqlNVmuOc+V5jp5CJ6OBZyVoXYdrXmwRBcx91ts0Urv
	fbuaNVZw==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wTzUB-0003yP-2C;
	Mon, 01 Jun 2026 12:03:07 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: alexei.starovoitov@gmail.com
Cc: bpf@vger.kernel.org,
	kpsingh@kernel.org
Subject: [PATCH bpf-next 1/3] libbpf: Reject non-exclusive metadata maps in the signed loader
Date: Mon,  1 Jun 2026 12:03:04 +0200
Message-ID: <20260601100307.386243-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28018/Mon Jun  1 08:31:13 2026)

From: KP Singh <kpsingh@kernel.org>

The loader verifies map->sha against the metadata hash in its
instructions. map->sha is calculated when BPF_OBJ_GET_INFO_BY_FD is
called on the frozen map.

While the map is frozen, the /signed loader/ must also ensure the map
is exclusive, as, without exclusivity (which a hostile host could just
omit when loading the loader), another BPF program with map access can
mutate the contents afterwards, so the check passes on stale data.

With the extra check as part of the signed loader, it now refuses to
move on with map->sha validation if the host set it up wrongly.

Fixes: fb2b0e290147 ("libbpf: Update light skeleton for signing")
Signed-off-by: KP Singh <kpsingh@kernel.org>
Co-developed-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 include/linux/bpf.h        |  1 +
 kernel/bpf/syscall.c       |  7 +++++++
 tools/lib/bpf/gen_loader.c | 17 +++++++++++++++++
 3 files changed, 25 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 1c6863ce89e0..6191c0c51fea 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -296,6 +296,7 @@ struct bpf_map_owner {
 
 struct bpf_map {
 	u8 sha[SHA256_DIGEST_SIZE];
+	u32 excl;
 	const struct bpf_map_ops *ops;
 	struct bpf_map *inner_map_meta;
 #ifdef CONFIG_SECURITY
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 2aafd2131983..0f53ec4bacc6 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1588,6 +1588,13 @@ static int map_create_alloc(union bpf_attr *attr, bpfptr_t uattr, struct bpf_ver
 			err = -EFAULT;
 			goto free_map;
 		}
+
+		/* See libbpf: emit_signature_match() */
+		BUILD_BUG_ON(offsetof(struct bpf_map, excl) != SHA256_DIGEST_SIZE);
+		BUILD_BUG_ON(!__same_type(map->excl, u32));
+		BUILD_BUG_ON(offsetof(struct bpf_map, sha)  != 0);
+		BUILD_BUG_ON(!__same_type(map->sha, u8[SHA256_DIGEST_SIZE]));
+		map->excl = 1;
 	} else if (attr->excl_prog_hash_size) {
 		bpf_log(log, "Invalid excl_prog_hash_size.\n");
 		err = -EINVAL;
diff --git a/tools/lib/bpf/gen_loader.c b/tools/lib/bpf/gen_loader.c
index 3702c5944bc0..66a02039da8c 100644
--- a/tools/lib/bpf/gen_loader.c
+++ b/tools/lib/bpf/gen_loader.c
@@ -586,6 +586,23 @@ static void emit_signature_match(struct bpf_gen *gen)
 	__s64 off;
 	int i;
 
+	/*
+	 * Reject if the metadata map is not exclusive. Without exclusivity
+	 * the cached map->sha[] verified above can be stale: another BPF
+	 * program with map access could have mutated the contents between
+	 * BPF_OBJ_GET_INFO_BY_FD and loader execution.
+	 */
+	emit2(gen, BPF_LD_IMM64_RAW_FULL(BPF_REG_1, BPF_PSEUDO_MAP_IDX,
+					 0, 0, 0, 0));
+	emit(gen, BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1, SHA256_DIGEST_LENGTH));
+	off = -(gen->insn_cur - gen->insn_start - gen->cleanup_label) / 8 - 2;
+	if (is_simm16(off)) {
+		emit(gen, BPF_MOV64_IMM(BPF_REG_7, -EINVAL));
+		emit(gen, BPF_JMP_IMM(BPF_JNE, BPF_REG_2, 1, off));
+	} else {
+		gen->error = -ERANGE;
+	}
+
 	for (i = 0; i < SHA256_DWORD_SIZE; i++) {
 		emit2(gen, BPF_LD_IMM64_RAW_FULL(BPF_REG_1, BPF_PSEUDO_MAP_IDX,
 						 0, 0, 0, 0));
-- 
2.43.0

