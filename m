Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3823DDA8
	for <bpf@vger.kernel.org>; Tue,  2 Apr 2024 02:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712023999; cv=none; b=NnHtNeAGuMiZMxYR6CYyW22u6qinbZlV0GiteibG3AociZvOjnnVB5GQ5j7+dQKLjdIjPGW5LRDSIq7NWG24zvNSx88yAIfcZdxWT81O2uddfmUnLWUdYneLTWC3yE8Yd9aRVme+psNGh3QDEKl5oe8paHsd/vG7pOxcLlQdlCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712023999; c=relaxed/simple;
	bh=4QCi5sD59f75jtHwogkGPhzKbNX9B4AwBxOvz69pWsg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V8Hv0dfN/H4mJ+Eu8P0QHhBzdmnGeQMZQPT3Uynkzh8swonDxH5WWOvRpEzYMYOhq78YcigNoRtQ2Ob51rsUe/9JyN41grcFDc/OZsKJT6L8t0xDIKyUnLqODhgW9e1LNa+6AxPDorQhpzL2fmQShT62sfeGfEMIwWNkhhaYm8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=la7MBuZo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="la7MBuZo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CEF5C433F1;
	Tue,  2 Apr 2024 02:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712023998;
	bh=4QCi5sD59f75jtHwogkGPhzKbNX9B4AwBxOvz69pWsg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=la7MBuZoI/lIqclgQHEpWwYacKkZ48cvhexSn+vW/+oq/TAloE4VPf4lQJ1AL6lMC
	 V2YG9gx74Ehcm+pEaAEu9labUKRHIRVyqjlz4XkEAI7ZFYJ50XHCq2D8w4U9rn6eyx
	 b1rdJOtXrYJBQ+HJYz6mUwiVyl8Lxt96xbXem3s+y/6opW/ixVm9RlWWebZ29TbyP2
	 CAeGCWU82lKfOLRAWfW+w+Z55UMnEDNVQQ+8v1bW72/s3vKYwT8PPZusumeULgxqrz
	 v/kEsZu6GAV37CMAHppdQDQl83ZNzMGbnzZ4vdyzfcBRoYGxdTUmBF8SlX+AVaewo6
	 AX7NRreJtmH/A==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com
Subject: [PATCH v2 bpf-next 3/4] bpf: inline bpf_map_lookup_elem() for PERCPU_ARRAY maps
Date: Mon,  1 Apr 2024 19:13:04 -0700
Message-ID: <20240402021307.1012571-4-andrii@kernel.org>
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

Using new per-CPU BPF instruction implement inlining for per-CPU ARRAY
map lookup helper, if BPF JIT support is present.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/arraymap.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index 13358675ff2e..8c1e6d7654bb 100644
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
+	if (!bpf_jit_supports_percpu_insn())
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
+	*insn++ = BPF_MOV64_PERCPU_REG(BPF_REG_0, BPF_REG_0);
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

