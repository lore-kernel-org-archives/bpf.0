Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6463B1AC
	for <bpf@vger.kernel.org>; Fri, 29 Mar 2024 18:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711738072; cv=none; b=mIoReL4graQmkluAN2u1vXbJOrLmSMdiUz84QosO6RcYO5j+9e72+LlkiRBEAtLMa+6By+1et0ZN8abWV3Pk687UiETf7wJJNVV5TVY8uQfKdYrYkeSaC9NbyVHZTZfaMbtDDk5/peYKvCTq3G/SLD0eHOtqIlSRIIzDH607jOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711738072; c=relaxed/simple;
	bh=/WLgrEbfVw01tVbYMD6LgpIF8WYcDH3vzzknKD8nRWk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lv5UzmZj7YmvklNi0tTsr32dyCrw7Eo7Po42nN/6UBcabLTJCB3y/VaG0GFbyLa2xGC/D2Un9HTQcOqdakdUJkxOPaIW8fewOMmLS8rY44x7Kr93GIKNtjuNMEkFBHrEjQ7luo014JnoNQcibJJYET0suNYX0nCIu3vRVlmop3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q2bG/juA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q2bG/juA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38641C433C7;
	Fri, 29 Mar 2024 18:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711738072;
	bh=/WLgrEbfVw01tVbYMD6LgpIF8WYcDH3vzzknKD8nRWk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q2bG/juAB5EAY69bTukQ233H6Q/YDAap3RFfKvSajyg3A0/nd2Pd93m3sHQQWNbzq
	 kk2Yww5ZlM4tE+CYRQocSwLMQrGVeeXkdUh5k3pjFJ4KkxZhuP0pR7MDSuw62fWrvT
	 qcWOq0uhIK8SnJj418r0/lz2Hmc7z7k8UEqKnwthmvW1KMF1D4Tm4/BsqJVYUSPjkl
	 F6SnWGE3haByZclEmLiq3j2ZenNklv/USN4A+wRFwgqHzvNhDaL/PkAiIrB8QK9DMt
	 VyBX/7/lhpFk7eyta7IJ3Lycs+nBAE3Z7XCkB4B1X9dkNjybqPoTfEhc++vhJfHHfk
	 raQiCwxaGi36Q==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf-next 3/4] bpf: inline bpf_map_lookup_elem() for PERCPU_ARRAY maps
Date: Fri, 29 Mar 2024 11:47:39 -0700
Message-ID: <20240329184740.4084786-4-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329184740.4084786-1-andrii@kernel.org>
References: <20240329184740.4084786-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Using new per-CPU BPF instructions implement inlining for per-CPU ARRAY
map lookup helper, if BPF JIT support is present.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/arraymap.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index 13358675ff2e..557661b96cf2 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -246,6 +246,38 @@ static void *percpu_array_map_lookup_elem(struct bpf_map *map, void *key)
 	return this_cpu_ptr(array->pptrs[index & array->index_mask]);
 }
 
+/* emit BPF instructions equivalent to C code of percpu_array_map_lookup_elem() */
+static int percpu_array_map_gen_lookup(struct bpf_map *map, struct bpf_insn *insn_buf)
+{
+	struct bpf_array *array = container_of(map, struct bpf_array, map);
+	struct bpf_insn *insn = insn_buf;
+
+	if (!bpf_jit_supports_percpu_insns())
+		return -EOPNOTSUPP;
+
+	if (map->map_flags & BPF_F_INNER_MAP)
+		return -EOPNOTSUPP;
+
+	BUILD_BUG_ON(offsetof(struct bpf_array, map) != 0);
+	*insn++ = BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, offsetof(struct bpf_array, pptrs));
+
+	*insn++ = BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_2, 0);
+	if (!map->bypass_spec_v1) {
+		*insn++ = BPF_JMP_IMM(BPF_JGE, BPF_REG_0, map->max_entries, 6);
+		*insn++ = BPF_ALU32_IMM(BPF_AND, BPF_REG_0, array->index_mask);
+	} else {
+		*insn++ = BPF_JMP_IMM(BPF_JGE, BPF_REG_0, map->max_entries, 5);
+	}
+
+	*insn++ = BPF_ALU64_IMM(BPF_LSH, BPF_REG_0, 3);
+	*insn++ = BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_1);
+	*insn++ = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_0, 0);
+	*insn++ = BPF_LDX_ADDR_PERCPU(BPF_REG_0, BPF_REG_0, 0);
+	*insn++ = BPF_JMP_IMM(BPF_JA, 0, 0, 1);
+	*insn++ = BPF_MOV64_IMM(BPF_REG_0, 0);
+	return insn - insn_buf;
+}
+
 static void *percpu_array_map_lookup_percpu_elem(struct bpf_map *map, void *key, u32 cpu)
 {
 	struct bpf_array *array = container_of(map, struct bpf_array, map);
@@ -776,6 +808,7 @@ const struct bpf_map_ops percpu_array_map_ops = {
 	.map_free = array_map_free,
 	.map_get_next_key = array_map_get_next_key,
 	.map_lookup_elem = percpu_array_map_lookup_elem,
+	.map_gen_lookup = percpu_array_map_gen_lookup,
 	.map_update_elem = array_map_update_elem,
 	.map_delete_elem = array_map_delete_elem,
 	.map_lookup_percpu_elem = percpu_array_map_lookup_percpu_elem,
-- 
2.43.0

