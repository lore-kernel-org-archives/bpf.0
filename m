Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5333D7D7A
	for <bpf@vger.kernel.org>; Mon,  1 Jun 2026 15:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780326174; cv=none; b=gTD6QvWIA0YLJlB05ySmVAa9sITZk7yf9ZVUVd4xKhW1ezyGZtYfO9VoF2qvSF/mJ95U/AESwcuT1Gs6+k71eFEeaB6EYm0HkaBqYBfAHI+eVWD0lEOcLy21Eh4NQnPHSy+wjEm4uzIexP28LdQDLfz20sUHr/A0NEqaFTse1nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780326174; c=relaxed/simple;
	bh=3Fv0VTOTx4H+Wf1awyZUJBW0Q/9ONK7003OxLbsnEMA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cmV/vSamZf50RabHDoLIzVmhwGKVEc9geU+FZU9j1ltJGybzNFtFh8Ef0OP4WFyt4VzMoUswPirNAkBfuYppdNPg8/TTALxwXqiZJbPwkkcbktjMdYZzB9ZYeZAD20TUAqtnmo8AGKdWvA0YnmuHorDu84BNglL7KNAKTTf5oZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=FAVN6Bp0; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="FAVN6Bp0"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=ORU4vw592fNUB0LVoKEq7zROJd9iXdtkectXsVv88V0=; b=FAVN6Bp0P1rE2gqtb3Yp6V4nLx
	EmisNbnmlu9Jm5nzUPG9fEiDZ7fn3P2UQeFAXw0wlE6Il8M1mK0NevTchgLSfpTNn1dOVWq5ux+Qc
	PcUFyunZcJELam9UeY37QTQUR2LlJPXkSVyOVRbPpd7Es2nY/aWnAN+PoE/4H0ZdjvbWUA/Gndzxw
	3MoC8Jk11cpZijwh+gQ2KV5CSths5YbzOekRT9qd+E3bGdCIpcRSkY8/Yc3aFtmb/0iMi8w9BRag6
	Uzy3ka9b7AOnAKlEkHFKkwRxLsN2+p+GJY1sH0foHZIfQCkT6GDiqsKup+8aI8cejmzwLmVxYGwC/
	+RF026MQ==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wU4AF-000GWK-1E;
	Mon, 01 Jun 2026 17:02:51 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: alexei.starovoitov@gmail.com
Cc: bpf@vger.kernel.org,
	kpsingh@kernel.org
Subject: [PATCH bpf-next v2 3/7] libbpf: Reject non-exclusive metadata maps in the signed loader
Date: Mon,  1 Jun 2026 17:02:44 +0200
Message-ID: <20260601150248.394863-4-daniel@iogearbox.net>
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
index d69cba55f30f..1b81bc9e8191 100644
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
index a27fa2b9b405..625a4366fe6d 100644
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

