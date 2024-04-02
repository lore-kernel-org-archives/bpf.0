Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21605D51D
	for <bpf@vger.kernel.org>; Tue,  2 Apr 2024 02:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712024002; cv=none; b=LGOhxJO5WOiBz2hh06IWtoZ4gSC6BZ4VfZJADSHac1AWOMwiutFI8Mnc2hxtTd9gtvBUJmbcaPAqmpk/kvsPdkfHDNT8aoT53u8uog5TGpKNAdQFxNSB9wytoE6Y66JPwMJxL/tNFsWDqBEmEqcT1Cxm3Ta7rYdWmHKUhP621BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712024002; c=relaxed/simple;
	bh=nO9DRFLGxpqgrzKfRddi8VmSDVT6Z36NbE6U021+FOs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oNraqVkoyCiVDBG0aHm0KzrpENTXS5ZCf7avOCjtdWRQhRni0Z904qv0iKZDextwZn4DnaHaWhTuaEmnT4980MPUONQCYsO+5RNE/Qzm3fhFKzS9VCl3BwtfiIuCRdAf7R7B7hu1PoQTLY/QWF4p/2Y11uH3BH1v8vEMet/SUyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W9jfGYUX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W9jfGYUX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87671C433C7;
	Tue,  2 Apr 2024 02:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712024001;
	bh=nO9DRFLGxpqgrzKfRddi8VmSDVT6Z36NbE6U021+FOs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W9jfGYUXUA1OZCTkNsXM2LyXXXJMExSvsNg6XjehkpVE0RsfVfva98lfO/mFvK4TE
	 BuIkldgdFvu0DVPnAebRG/yc8P0NQSiddXEsiphohL46THz8uobLykyMqr5hQK6nBj
	 92Llcq/TTrKXfUbqLQB1jjaoJfRdG3ZCqNFLorc9RjMqk3mxGQfJFylxGgB2Mbxsgb
	 arwCeSgAc4jeoSAAK0aBoD/LwyoS+LVRZ5Ho+FeDRSTprg3PBE2GmqegbRN45sV0vm
	 nzKrsdB3uzu20fwd0qLI8KDEm1zuV1HSDcggnGSWYPVOFbXJKT1c3BAquMsWIYzmK8
	 9sK4aM0EeCD3g==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com
Subject: [PATCH v2 bpf-next 4/4] bpf: inline bpf_map_lookup_elem() helper for PERCPU_HASH map
Date: Mon,  1 Apr 2024 19:13:05 -0700
Message-ID: <20240402021307.1012571-5-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240402021307.1012571-1-andrii@kernel.org>
References: <20240402021307.1012571-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Using new per-CPU BPF instruction, partially inline
bpf_map_lookup_elem() helper for per-CPU hashmap BPF map. Just like for
normal HASH map, we still generate a call into __htab_map_lookup_elem(),
but after that we resolve per-CPU element address using a new
instruction, saving on extra functions calls.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/hashtab.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index e81059faae63..83a9a74260e9 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -2308,6 +2308,26 @@ static void *htab_percpu_map_lookup_elem(struct bpf_map *map, void *key)
 		return NULL;
 }
 
+/* inline bpf_map_lookup_elem() call for per-CPU hashmap */
+static int htab_percpu_map_gen_lookup(struct bpf_map *map, struct bpf_insn *insn_buf)
+{
+	struct bpf_insn *insn = insn_buf;
+
+	if (!bpf_jit_supports_percpu_insn())
+		return -EOPNOTSUPP;
+
+	BUILD_BUG_ON(!__same_type(&__htab_map_lookup_elem,
+		     (void *(*)(struct bpf_map *map, void *key))NULL));
+	*insn++ = BPF_EMIT_CALL(__htab_map_lookup_elem);
+	*insn++ = BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 3);
+	*insn++ = BPF_ALU64_IMM(BPF_ADD, BPF_REG_0,
+				offsetof(struct htab_elem, key) + map->key_size);
+	*insn++ = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_0, 0);
+	*insn++ = BPF_MOV64_PERCPU_REG(BPF_REG_0, BPF_REG_0);
+
+	return insn - insn_buf;
+}
+
 static void *htab_percpu_map_lookup_percpu_elem(struct bpf_map *map, void *key, u32 cpu)
 {
 	struct htab_elem *l;
@@ -2436,6 +2456,7 @@ const struct bpf_map_ops htab_percpu_map_ops = {
 	.map_free = htab_map_free,
 	.map_get_next_key = htab_map_get_next_key,
 	.map_lookup_elem = htab_percpu_map_lookup_elem,
+	.map_gen_lookup = htab_percpu_map_gen_lookup,
 	.map_lookup_and_delete_elem = htab_percpu_map_lookup_and_delete_elem,
 	.map_update_elem = htab_percpu_map_update_elem,
 	.map_delete_elem = htab_map_delete_elem,
-- 
2.43.0

