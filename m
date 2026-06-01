Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6144E3D75CF
	for <bpf@vger.kernel.org>; Mon,  1 Jun 2026 15:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780326174; cv=none; b=mlqk7DWwLG3EYQ3lf2ztg14kF+SCyqqJJpCTaS4kYZpgszcehhpBOLCypvrTQEpWnXV+rbocd/UJN+1PiPUqCJ9hSY90sDHr/8F2Ts2caJ+83Sd7RzCo394T4bbmWzIX7czhqDxYNKuV9VaZeSkTbT83ZQJi9DFtgC4wek7ZF68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780326174; c=relaxed/simple;
	bh=1ei57i8vfArgH8xX5VpQkCqfERv+OU7o14ealS5GoQM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=feOUmY+WEYYiv0wyHHVOGsFk/OdrJcM8Zr/f5+5uOo2AW7d0LmbE+BPddYPFRow4+3UWY6nek5NvWlwPOJ7ck1CsBZWZl3+zCq7wwJHMDPlhGD+7gBI9iNRvk+nF5pB36ja3niZ/7llDf1CN3F+TQCnMMSzmsT7Ac4f6mbQgmd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=dPlszLwp; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="dPlszLwp"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=Uj1JB3vh+vpsOYTyHkpZ1dqay1CegIZ5z0aQjGUuVtM=; b=dPlszLwp2gOZ8zbrE9EsTE+QAa
	uhZPB3qHl9HJm1CHW5ubS4WQGevhnzMSKkqWNZoryrYFkBNwaXgZ+OdqS8jHYvCFarKZsZY2kTJQg
	gssBY1Nvqp9sHUMl0AYb+kmjH+Y5bxnV6z1VkYhpbdqwxKMWdWxFKXbX+ZaZ+SqSMwxUnV6Tt6LmJ
	NJj/A3UDpDJ3CjmFdWfAJg9KDpDsd70flvBiUvS7N8j0K2F2O9/df5y57T8IG8N1/5wqx25zc56w6
	r3Sni3OR6Sln7vCodcTVZrbLY2Pu8Q3e5nF/tzoCOZS+n1/Tx2qLA9RC2Ik+bPIGpL6CCsLOPYF/E
	gUl8yEHQ==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wU4AF-000GWc-2e;
	Mon, 01 Jun 2026 17:02:51 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: alexei.starovoitov@gmail.com
Cc: bpf@vger.kernel.org,
	kpsingh@kernel.org
Subject: [PATCH bpf-next v2 4/7] libbpf: Skip initial_value override on signed loaders
Date: Mon,  1 Jun 2026 17:02:45 +0200
Message-ID: <20260601150248.394863-5-daniel@iogearbox.net>
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

bpf_gen__map_update_elem() emits code that, when the host-supplied
loader ctx provides a non-NULL map_desc[idx].initial_value, overwrites
the blob value with bytes read from the host (bpf_copy_from_user /
bpf_probe_read_kernel) before the BPF_MAP_UPDATE_ELEM that populates
the program's .data/.rodata/.bss maps.

This override runs after emit_signature_match() has validated map->sha[],
and initial_value is part of neither the signed loader instructions nor
the hashed data blob. For a signed loader this lets an untrusted host
substitute global-variable contents into a program whose code carries
a valid signature, thus weakening what the signature attests to.

The blob already contains the signer-provided value (added via add_data()
and covered by the embedded, signed hash), so simply skip emitting the
override for signed loaders (gen_hash). Runtime initialization stays
available for the unsigned light-skeleton path as before. The jump
offsets within the override block are internal to it, so guarding the
whole block leaves them unchanged.

Fixes: ea923080c145 ("libbpf: Embed and verify the metadata hash in the loader")
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 tools/lib/bpf/gen_loader.c | 39 +++++++++++++++++++++++---------------
 1 file changed, 24 insertions(+), 15 deletions(-)

diff --git a/tools/lib/bpf/gen_loader.c b/tools/lib/bpf/gen_loader.c
index 66a02039da8c..a5d9c7a5261b 100644
--- a/tools/lib/bpf/gen_loader.c
+++ b/tools/lib/bpf/gen_loader.c
@@ -1187,27 +1187,36 @@ void bpf_gen__map_update_elem(struct bpf_gen *gen, int map_idx, void *pvalue,
 	value = add_data(gen, pvalue, value_size);
 	key = add_data(gen, &zero, sizeof(zero));
 
-	/* if (map_desc[map_idx].initial_value) {
+	/*
+	 * if (map_desc[map_idx].initial_value) {
 	 *    if (ctx->flags & BPF_SKEL_KERNEL)
 	 *        bpf_probe_read_kernel(value, value_size, initial_value);
 	 *    else
 	 *        bpf_copy_from_user(value, value_size, initial_value);
 	 * }
+	 *
+	 * The runtime initial_value comes from the host-supplied loader
+	 * ctx and would overwrite the blob value after emit_signature_match()
+	 * has already validated map->sha[]. For a signed loader (gen_hash)
+	 * the attested blob value must be authoritative, so skip the override
+	 * and leave the hashed value in place.
 	 */
-	emit(gen, BPF_LDX_MEM(BPF_DW, BPF_REG_3, BPF_REG_6,
-			      sizeof(struct bpf_loader_ctx) +
-			      sizeof(struct bpf_map_desc) * map_idx +
-			      offsetof(struct bpf_map_desc, initial_value)));
-	emit(gen, BPF_JMP_IMM(BPF_JEQ, BPF_REG_3, 0, 8));
-	emit2(gen, BPF_LD_IMM64_RAW_FULL(BPF_REG_1, BPF_PSEUDO_MAP_IDX_VALUE,
-					 0, 0, 0, value));
-	emit(gen, BPF_MOV64_IMM(BPF_REG_2, value_size));
-	emit(gen, BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_6,
-			      offsetof(struct bpf_loader_ctx, flags)));
-	emit(gen, BPF_JMP_IMM(BPF_JSET, BPF_REG_0, BPF_SKEL_KERNEL, 2));
-	emit(gen, BPF_EMIT_CALL(BPF_FUNC_copy_from_user));
-	emit(gen, BPF_JMP_IMM(BPF_JA, 0, 0, 1));
-	emit(gen, BPF_EMIT_CALL(BPF_FUNC_probe_read_kernel));
+	if (!OPTS_GET(gen->opts, gen_hash, false)) {
+		emit(gen, BPF_LDX_MEM(BPF_DW, BPF_REG_3, BPF_REG_6,
+				      sizeof(struct bpf_loader_ctx) +
+				      sizeof(struct bpf_map_desc) * map_idx +
+				      offsetof(struct bpf_map_desc, initial_value)));
+		emit(gen, BPF_JMP_IMM(BPF_JEQ, BPF_REG_3, 0, 8));
+		emit2(gen, BPF_LD_IMM64_RAW_FULL(BPF_REG_1, BPF_PSEUDO_MAP_IDX_VALUE,
+						 0, 0, 0, value));
+		emit(gen, BPF_MOV64_IMM(BPF_REG_2, value_size));
+		emit(gen, BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_6,
+				      offsetof(struct bpf_loader_ctx, flags)));
+		emit(gen, BPF_JMP_IMM(BPF_JSET, BPF_REG_0, BPF_SKEL_KERNEL, 2));
+		emit(gen, BPF_EMIT_CALL(BPF_FUNC_copy_from_user));
+		emit(gen, BPF_JMP_IMM(BPF_JA, 0, 0, 1));
+		emit(gen, BPF_EMIT_CALL(BPF_FUNC_probe_read_kernel));
+	}
 
 	map_update_attr = add_data(gen, &attr, attr_size);
 	pr_debug("gen: map_update_elem: idx %d, value: off %d size %d, attr: off %d size %d\n",
-- 
2.43.0

